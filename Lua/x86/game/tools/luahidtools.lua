local var_0_0 = {}
local var_0_1 = P08.Gamepad.HIDInputPage

function var_0_0.EnsureHasInputPage(arg_1_0)
	local var_1_0 = arg_1_0.gameObject_

	if var_1_0 == nil or var_0_1 == nil then
		return
	end

	local var_1_1 = typeof(var_0_1)

	if var_1_0:GetComponent(var_1_1) == nil then
		return var_1_0:AddComponent(var_1_1)
	end
end

local function var_0_2(arg_2_0)
	local var_2_0 = arg_2_0.gameObject_

	if var_2_0 == nil or var_0_1 == nil then
		return nil
	end

	return (var_2_0:GetComponent(typeof(var_0_1)))
end

function var_0_0.EnterInputPage(arg_3_0)
	local var_3_0 = var_0_2(arg_3_0)

	if var_3_0 then
		var_3_0:EnablePageIfNeed()
	end
end

function var_0_0.ExitInputPage(arg_4_0)
	local var_4_0 = var_0_2(arg_4_0)

	if var_4_0 then
		var_4_0:DisablePageIfNeed()
	end
end

HID_TYPES = {
	KeyMouse = 5,
	PS4 = 3,
	Keyboard = 1,
	Other = 4,
	Xbox = 2,
	None = 0
}

local var_0_3 = {
	[HID_TYPES.Xbox] = "Xbox_",
	[HID_TYPES.PS4] = "PS_"
}
local var_0_4 = {
	KeypadMultiply = "Pad*",
	KeypadPlus = "Pad+",
	KeypadMinus = "Pad-",
	Alpha1 = "1",
	Alpha2 = "2",
	Escape = "Esc",
	BackQuote = "~",
	Alpha7 = "7",
	KeypadDivide = "Pad/",
	Keypad6 = "Pad6",
	Backslash = "\\",
	Keypad3 = "Pad3",
	Slash = "/",
	Comma = ",",
	Alpha3 = "3",
	Alpha4 = "4",
	Quote = "\"",
	Alpha9 = "9",
	Return = "Enter",
	Keypad8 = "Pad8",
	Keypad5 = "Pad5",
	Alpha0 = "0",
	Alpha5 = "5",
	Alpha6 = "6",
	Keypad7 = "Pad7",
	KeypadEnter = "PadEnter",
	Keypad0 = "Pad0",
	Minus = "-",
	Alpha8 = "8",
	Equals = "+",
	KeypadPeriod = "Pad.",
	Keypad9 = "Pad9",
	Keypad2 = "Pad2",
	Period = ".",
	Keypad4 = "Pad4",
	Keypad1 = "Pad1"
}
local var_0_5 = {
	"Alpha0",
	"Alpha1",
	"Alpha2",
	"Alpha3",
	"Alpha4",
	"Alpha5",
	"Alpha6",
	"Alpha7",
	"Alpha8",
	"Alpha9",
	"Keypad0",
	"Keypad1",
	"Keypad2",
	"Keypad3",
	"Keypad4",
	"Keypad5",
	"Keypad6",
	"Keypad7",
	"Keypad8",
	"Keypad9"
}

function GetKeyCodeMappedName(arg_5_0)
	local var_5_0 = "KEYCODE_" .. string.upper(arg_5_0)
	local var_5_1 = TipsCfg.get_id_list_by_define[var_5_0]

	if var_5_1 then
		return GetTips(var_5_1)
	elseif var_0_4[arg_5_0] then
		return var_0_4[arg_5_0]
	end

	return arg_5_0
end

local var_0_6 = {}
local var_0_7

function var_0_0.StopDeviceAddTimer()
	var_0_7:Stop()

	var_0_7 = nil
end

function var_0_0.OpenGamepadSelectWin(arg_7_0)
	if var_0_0.selectWin_ then
		return
	end

	LuaExchangeHelper.PauseGame()

	var_0_0.selectWin_ = GamepadSelectView.New(arg_7_0)
end

function OnGamepadDeviceAdded(arg_8_0, arg_8_1)
	print("OnGamepadDeviceAdded: " .. arg_8_1)
	table.insert(var_0_6, {
		arg_8_1,
		arg_8_0
	})

	if var_0_7 then
		return
	end

	var_0_7 = Timer.New(function()
		if var_0_0.selectWin_ then
			if manager.guide:IsPlaying() then
				var_0_0.selectWin_:CloseWindow()
			end

			return
		end

		if #var_0_6 <= 0 then
			var_0_0.StopDeviceAddTimer()

			return
		end

		if manager.guide:IsPlaying() then
			return
		end

		local var_9_0 = var_0_6[1]

		if manager.managerInit then
			local var_9_1 = LuaForGamepad.GetGamepadType()

			if var_9_1 == HID_TYPES.Xbox or var_9_1 == HID_TYPES.PS4 then
				if not LuaHidTools.IsKeepJoystickType() then
					var_0_0.OpenGamepadSelectWin(var_9_0.gamepadType)
				end

				table.clean(var_0_6)
			end
		end
	end, 1, -1)

	var_0_7:Start()
end

function OnGamepadDeviceRemoved(arg_10_0, arg_10_1)
	print("OnGamepadDeviceRemoved: " .. arg_10_1)

	local var_10_0

	for iter_10_0, iter_10_1 in ipairs(var_0_6) do
		if iter_10_1[1] == arg_10_1 then
			var_10_0 = iter_10_1
		end
	end

	if var_10_0 then
		table.removebyvalue(var_0_6, var_10_0)
	end
end

local var_0_8

local function var_0_9()
	if var_0_8 then
		return
	end

	var_0_8 = {
		Insert = true,
		Numlock = true,
		Escape = true,
		Pause = true,
		Delete = true,
		Backspace = true,
		PageDown = true,
		LeftApple = true,
		Print = true,
		Menu = true,
		SysReq = true,
		ScrollLock = true,
		RightMeta = true,
		Mouse0 = true,
		Home = true,
		PageUp = true
	}

	local var_11_0

	if GameToSDK.IsAndroidPlatform() then
		var_11_0 = {
			PS_JoystickButton11 = true,
			Xbox_JoystickButton11 = true,
			PS_JoystickButton8 = true,
			Xbox_JoystickButton8 = true
		}
	elseif GameToSDK.IsIOSPlatform() then
		var_11_0 = {
			PS_JoystickButton17 = true,
			PS_JoystickButton0 = true,
			Xbox_JoystickButton0 = true,
			Xbox_JoystickButton17 = true
		}
	else
		var_11_0 = {
			PS_JoystickButton8 = true,
			Xbox_JoystickButton6 = true,
			PS_JoystickButton10 = true,
			Xbox_JoystickButton8 = true
		}
	end

	table.merge(var_0_8, var_11_0)
end

function var_0_0.IsKeyNotAllow(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 == CONTROL_TYPES.Operation and table.keyof(var_0_5, arg_12_1) then
		return true
	end

	var_0_9()

	if var_0_8[arg_12_1] then
		return true
	end

	local var_12_0 = var_0_3[arg_12_0]

	if var_12_0 then
		local var_12_1 = var_12_0 .. arg_12_1

		if var_0_8[var_12_1] then
			return true
		end
	end

	return false
end

local var_0_10 = {
	Sys_Confirm = true,
	Sys_Home = true,
	Sys_BattlePause = true,
	Sys_Back = true,
	Special_SwitchCursor = true,
	Special_JoystickClick = true
}

function var_0_0.IsOpNotAllow(arg_13_0, arg_13_1)
	if var_0_10[arg_13_1] then
		return true
	end

	if arg_13_0 == HID_TYPES.KeyMouse and (arg_13_1 == "Melee" or arg_13_1 == "CameraLeft" or arg_13_1 == "CameraRight" or arg_13_1 == "CameraUp" or arg_13_1 == "CameraDown") then
		return true
	end

	return false
end

function var_0_0.GetOpName(arg_14_0)
	return GetTips(string.format("INPUT_BUTTON_%s", string.upper(arg_14_0)))
end

function var_0_0.GetPlayerSelectJoystick()
	return LuaForGamepad.GetPlayerSelectJoystick()
end

function var_0_0.SetPlayerSelectJoystick(arg_16_0)
	LuaForGamepad.SetPlayerSelectJoystick(arg_16_0)
end

function var_0_0.GetPlayerSelectKeyboard()
	return LuaForGamepad.GetPlayerSelectKeyboard()
end

function var_0_0.SetPlayerSelectKeyboard(arg_18_0)
	LuaForGamepad.SetPlayerSelectKeyboard(arg_18_0)
end

function var_0_0.ForceSelectKeyboard(arg_19_0)
	LuaForGamepad.ForceSelectKeyboard(arg_19_0 or HID_TYPES.None)
end

local var_0_11 = "InputRemapNoticeEnableList"

function var_0_0.SetRemapNotice(arg_20_0, arg_20_1)
	LuaForGamepad.SetNeedRemapNotice(arg_20_0, arg_20_1)
end

function var_0_0.GetRemapNotice(arg_21_0)
	return LuaForGamepad.GetNeedRemapNotice(arg_21_0)
end

function var_0_0.ResetRemapNotice()
	PlayerPrefs.DeleteKey(var_0_11)

	local var_22_0 = var_0_0.GetRemapNotice(HID_TYPES.None)

	var_0_0.SetRemapNotice(HID_TYPES.None, var_22_0)
end

function var_0_0.HasSetRemapNotice()
	if not GameToSDK.IsEditorOrPcPlatform() then
		return true
	end

	if PlayerPrefs.HasKey(var_0_11) then
		return true
	end

	return false
end

function var_0_0.SetAllRemapNotice(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(HID_TYPES) do
		var_0_0.SetRemapNotice(iter_24_1, arg_24_0)
	end
end

function var_0_0.QueryRemapNotice()
	JumpTools.OpenPageByJump("blank")
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("INPUT_REMAP_NOTICE_QUERY"),
		OkCallback = function()
			var_0_0.SetAllRemapNotice(true)
			JumpTools.Back()
		end,
		CancelCallback = function()
			var_0_0.SetAllRemapNotice(false)
			JumpTools.Back()
		end
	})
end

function var_0_0.IsKeepJoystickType()
	return PlayerPrefs.GetInt("PCCURSOR_KEEP_JOYSTICK_TYPE", 0) ~= 0
end

function var_0_0.SetIsKeepJoystickType(arg_29_0)
	PlayerPrefs.SetInt("PCCURSOR_KEEP_JOYSTICK_TYPE", arg_29_0 and 1 or 0)
end

function IsPolyhedronGameOver()
	local var_30_0 = BattleController.GetInstance()

	if not var_30_0 then
		return false
	end

	local var_30_1 = var_30_0:GetBattleStageData()

	if not var_30_1 then
		return false
	end

	if not BattleFieldData:IsInBattle() and BattleConst.STAGE_TYPE_NEW.POLYHEDRON == var_30_1:GetType() then
		return true
	end

	return false
end

return var_0_0
