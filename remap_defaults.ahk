#NoEnv							; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force
#UseHook
SendMode Input		    		; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  	; Ensures a consistent starting directory.

; #Warn							; Enable warnings to assist with detecting common errors.
; #InstallKeybdHook             ; for debug

Return							; End of Initialize Section


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GLOBAL SCOPE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive

#Space::Return	        ; Disable Win+Space to change IME

; Swap Left Ctrl <-> Left Alt to simulate Mac Keyboard
*LCtrl::LAlt
*LAlt::LCtrl

; *CapsLock::RCtrl   	; NOT WORKING! Use ChangeKey => https://forest.watch.impress.co.jp/library/software/changekey/

; 無変換    => IME OFF
vk1D::
	Gosub, GetImeState
	If (isImeActive = true) {
		Send, {vkF3}
	}
	Return
; 変換      => IME ON
vk1C::
	Gosub, GetImeState
	If (isImeActive = false) {
    	Send, {vkF3}
	}
	Return
GetImeState:
	WinGet, vcurrentwindow, ID, A
	isImeActive := DllCall("user32.dll\SendMessageA", "UInt", DllCall("imm32.dll\ImmGetDefaultIMEWnd", "Uint", vcurrentwindow), "UInt", 0x0283, "Int", 0x0005, "Int", 0)
	Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ニャー次郎
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; #IfWinActive, Meowjiro

; e::f
; E::F


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Apex Legends
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; #If WinActive("ahk_exe r5apex.exe") || WinActive("ahk_exe notepad.exe")
#IfWinActive ahk_exe r5apex.exe

; ピン指し中の武器チェンジ誤爆を防止
; ~MButton & WheelDown::Return
; ~MButton & WheelUp::Return
; ~MButton & WheelLeft::Return
; ~MButton & WheelRight::Return

; リロード癖の抑制
*R::
	KeyWait, r, T0.175
	If (ErrorLevel) {
		; 長押し時の挙動
		Send, {r DownTemp}
		KeyWait, r
		Send, {r Up}
		Return
	} Else If (A_PriorHotkey = A_ThisHotkey) And (A_TimeSincePriorHotkey < 400) {
		; ダブルクリック時の挙動
		Send, {r}
		Return
	} Else {
		; シングルクリック時の挙動
		Return
	}
	Return

; 回復をダブルクリックでバッテリー回復
*F6::
	KeyWait, F6, T0.200
	If (ErrorLevel) {
		; 長押し時の挙動
		Send, {F6 DownTemp}
		KeyWait, F6
		Send, {F6 Up}
		Return
	} Else If (A_PriorHotkey = A_ThisHotkey) And (A_TimeSincePriorHotkey < 600) {
		; ダブルクリック時の挙動
		Send, {h}	; バッテリー回復キー
		Return
	} Else {
		; シングルクリック時の挙動
		Send, {F6}
		Return
	}
	Return

; 武器をしまうキーを長押しで格闘攻撃
*F9::
	KeyWait, F9, T0.200
	If (ErrorLevel) {
		; 長押し時の挙動
		Send, {F4}
		KeyWait, F9
		Send, {F9 Up}
		Return
	} Else {
		; シングルクリック時の挙動
		Send, {F9}
		Return
	}
	Return
; 武器入れ替えキーを長押しで格闘攻撃
*F10::
	KeyWait, F10, T0.200
	If (ErrorLevel) {
		; 長押し時の挙動
		Send, {F4}
		KeyWait, F10
		Send, {F10 Up}
		Return

	} Else {
		; シングルクリック時の挙動
		Send, {F10}
		Return
	}
		Return

; ; サイドボタン奥のキーを長押しでのみ発動するように抑制（グレボタン変更対策）
; *F5::
; 	KeyWait, F5, T0.400
; 	If (ErrorLevel) {
; 		; 長押し時の挙動
; 		Send, {F5 DownTemp}
; 		KeyWait, F5
; 		Send, {F5 Up}
; 		Return
; 	} Else If (A_PriorHotkey = A_ThisHotkey) And (A_TimeSincePriorHotkey < 400) {
; 		; ダブルクリック時の挙動
; 		Send, {F5}
; 		Return
; 	} Else {
; 		; シングルクリック時の挙動
; 		Return
; 	}
; 	Return
; *F1::
; 	KeyWait, F1, T0.400
; 	If (ErrorLevel) {
; 		; 長押し時の挙動
; 		Send, {F1 DownTemp}
; 		KeyWait, F1
; 		Send, {F1 Up}
; 		Return
; 	} Else If (A_PriorHotkey = A_ThisHotkey) And (A_TimeSincePriorHotkey < 400) {
; 		; ダブルクリック時の挙動
; 		Send, {F1}
; 		Return
; 	} Else {
; 		; シングルクリック時の挙動
; 		Return
; 	}
; 	Return