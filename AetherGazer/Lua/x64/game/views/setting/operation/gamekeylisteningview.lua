local var_0_0 = class("GameKeyListeningView", ReduxView)
local var_0_1 = require("cjson")

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Setting/SettingHandlUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.gamepadType_ = arg_7_0.params_.gamepadType

	SetActive(arg_7_0.confirmBtn_.gameObject, false)
	arg_7_0:StartKeyListening()
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:StopKeyListening()

	arg_8_0.params_.listenCallback = nil
end

function var_0_0.SendKeyResult(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.params_.listenCallback
	local var_9_1 = arg_9_0:MapKey(arg_9_1)

	if var_9_0 then
		var_9_0(var_9_1)
	end
end

function var_0_0.StartKeyListening(arg_10_0)
	arg_10_0:StopKeyListening()

	arg_10_0.contentText_.text = GetTips("PLEASE_INPUT_KEY")

	LuaForCursor.SetCanMove(false)
	LuaForGamepad.ClearInputValue()

	arg_10_0.lastKey_ = nil
	arg_10_0.candidateKey_ = nil
	arg_10_0.candidateCount_ = 0
	arg_10_0.timer_ = FrameTimer.New(function()
		local var_11_0 = arg_10_0:GetInputKey()

		if not arg_10_0:IsKeyLegal(var_11_0) then
			return
		end

		LuaForGamepad.ClearInputValue()
		arg_10_0:SendKeyResult(var_11_0)
	end, 1, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.StopKeyListening(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end

	LuaForCursor.SetCanMove(true)
end

function var_0_0.IsKeyLegal(arg_13_0, arg_13_1)
	if arg_13_1 == "" then
		return false
	end

	local var_13_0 = LuaForGamepad.ConvertName(arg_13_1)

	print(string.format("输入名称: %s", var_13_0))

	local var_13_1 = arg_13_0.gamepadType_

	if LuaHidTools.IsKeyNotAllow(var_13_1, var_13_0, arg_13_0.params_.controlType) then
		local var_13_2 = GetTipsF("INPUT_KEY_NOT_ALLOW", GetKeyCodeMappedName(var_13_0))

		ShowTips(var_13_2)

		return false
	end

	return (var_13_1 == 2 or var_13_1 == 3) == LuaForGamepad.IsGamepadKey(arg_13_1)
end

function var_0_0.GetInputData(arg_14_0)
	local var_14_0 = LuaForGamepad.GetInputListString()

	if var_14_0 and var_14_0 ~= "" then
		print(string.format("InputingList: %s", var_14_0))
	end

	local var_14_1 = arg_14_0.gamepadType_
	local var_14_2 = var_14_1 == 2 or var_14_1 == 3
	local var_14_3 = ""
	local var_14_4 = LuaForGamepad.GetAllInputResultJson()

	if var_14_4 and var_14_4 ~= "" then
		local var_14_5 = var_0_1.decode(var_14_4).m_inputValueList

		for iter_14_0, iter_14_1 in ipairs(var_14_5) do
			local var_14_6 = iter_14_1.m_axisName

			if var_14_2 == LuaForGamepad.IsGamepadKey(var_14_6) and not string.find(var_14_6, "Mouse_") then
				var_14_3 = iter_14_1

				break
			end
		end
	end

	return var_14_3
end

function var_0_0.GetInputKey(arg_15_0)
	local var_15_0 = arg_15_0:GetInputData()
	local var_15_1 = arg_15_0.lastKey_

	if var_15_0 == "" then
		if var_15_1 then
			arg_15_0.lastKey_ = nil

			return var_15_1
		end

		return ""
	end

	local var_15_2 = var_15_0.m_axisName

	if var_15_2 ~= var_15_1 then
		if var_15_2 == arg_15_0.candidateKey_ then
			arg_15_0.candidateCount_ = arg_15_0.candidateCount_ + 1
		else
			arg_15_0.candidateKey_ = var_15_2
			arg_15_0.candidateCount_ = 1
		end

		if arg_15_0.candidateCount_ >= 3 then
			arg_15_0.lastKey_ = var_15_2
		end
	end

	return ""
end

function var_0_0.MapKey(arg_16_0, arg_16_1)
	local var_16_0 = tonumber(arg_16_1)

	if var_16_0 then
		print("converting keypad input to alpha")

		if var_16_0 == 271 then
			return "13"
		end

		if var_16_0 >= 256 and var_16_0 <= 265 then
			return tostring(48 + var_16_0 - 256)
		end
	end

	return arg_16_1
end

function var_0_0.Dispose(arg_17_0)
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
