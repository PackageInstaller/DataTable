local var_0_0 = class("MusicKeySetItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.trackIndex = arg_1_2
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.keyBtn_, nil, function()
		arg_4_0:StartListeningNewKey()
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.KeyName = arg_6_1
	arg_6_0.trackNameText_.text = string.format(GetTips("ACTIVITY_MUSIC_SETTING_TRANK"), arg_6_0.trackIndex)
	arg_6_0.keyNameText_.text = GetKeyCodeMappedName(arg_6_1)
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.SetKeyChanged(arg_9_0, arg_9_1)
	arg_9_0.onKeyChanged_ = arg_9_1
end

function var_0_0.SetKey(arg_10_0, arg_10_1)
	local var_10_0 = LuaForGamepad.ConvertName(arg_10_1)

	if arg_10_0.onKeyChanged_ then
		local var_10_1 = arg_10_0.keyName

		if KeyCode[var_10_1] then
			local var_10_2 = tostring(KeyCode[var_10_1]:ToInt())
		end

		local var_10_3 = {
			key = arg_10_1,
			keyName = var_10_0,
			oldKeyName = arg_10_0.KeyName
		}

		arg_10_0.onKeyChanged_(var_10_3)
	end
end

function var_0_0.StartListeningNewKey(arg_11_0)
	JumpTools.OpenPageByJump("gameKeyListening", {
		controlType = 0,
		gamepadType = HID_TYPES.Keyboard,
		listenCallback = function(arg_12_0)
			arg_11_0:SetKey(arg_12_0)
		end
	})
end

return var_0_0
