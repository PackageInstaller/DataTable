local var_0_0 = class("GameKeyboardOperationView", ReduxView)
local var_0_1 = require("cjson")
local var_0_2 = "KeyboardLayout"

function var_0_0.OnCtor(arg_1_0, arg_1_1)
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

	arg_3_0.toggleController_ = ControllerUtil.GetController(arg_3_0.keyboardBtn_.transform, "toggle")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddGamepadSettingListener()
end

function var_0_0.AddEventListeners(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:AddEventListeners()

	arg_6_0.changed_ = false
	arg_6_0.gamepadType_ = LuaForGamepad.GetGamepadType()
	arg_6_0.oldLayoutJson_ = LuaForGamepad.GetLayoutJson(var_0_2, LuaForGamepad.GetDefaultLayoutFileName(var_0_2))
end

function var_0_0.SaveData(arg_7_0)
	arg_7_0.changed_ = false
	arg_7_0.gamepadType_ = LuaForGamepad.GetGamepadType()
	arg_7_0.oldLayoutJson_ = LuaForGamepad.GetLayoutJson(var_0_2, LuaForGamepad.GetDefaultLayoutFileName(var_0_2))
end

function var_0_0.CheckDataChange(arg_8_0)
	return arg_8_0.changed_
end

function var_0_0.RecoverTmpData(arg_9_0)
	LuaForGamepad.SetGamePadType(arg_9_0.gamepadType_)
	LuaForGamepad.SaveLayoutJson(var_0_2, arg_9_0.oldLayoutJson_)
	LuaForGamepad.ReloadLayout()
	arg_9_0:RefreshGamepadSetting()
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
	arg_10_0:StopGampadSetting()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.UpdatePageData(arg_12_0)
	arg_12_0:RefreshGamepadSetting()
end

function var_0_0.AddGamepadSettingListener(arg_13_0)
	arg_13_0:AddBtnListener(arg_13_0.keyboardBtn_, nil, function()
		if arg_13_0.toggleController_:GetSelectedState() == "off" then
			arg_13_0.toggleController_:SetSelectedState("on")
			LuaForGamepad.SetGamePadType(1)
			arg_13_0:RefreshGamepadSetting()

			arg_13_0.changed_ = true
		else
			arg_13_0.toggleController_:SetSelectedState("off")
			LuaForGamepad.SetGamePadType(0)
			arg_13_0:RefreshGamepadSetting()

			arg_13_0.changed_ = true
		end
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadMoveUpBtn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadMoveUpTxt_, P08.Gamepad.En_ButtonType.MoveUp:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadMoveDownBtn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadMoveDownTxt_, P08.Gamepad.En_ButtonType.MoveDown:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadMoveLeftBtn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadMoveLeftTxt_, P08.Gamepad.En_ButtonType.MoveLeft:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadMoveRightBtn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadMoveRightTxt_, P08.Gamepad.En_ButtonType.MoveRight:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadCameraLeftBtn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadCameraLeftTxt_, P08.Gamepad.En_ButtonType.CameraLeft:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadCameraRightBtn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadCameraRightTxt_, P08.Gamepad.En_ButtonType.CameraRight:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadSubStickUpBtn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadSubStickUpTxt_, P08.Gamepad.En_ButtonType.SubJoystickUp:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadSubStickDownBtn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadSubStickDownTxt_, P08.Gamepad.En_ButtonType.SubJoystickDown:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadSubStickLeftBtn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadSubStickLeftTxt_, P08.Gamepad.En_ButtonType.SubJoystickLeft:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadSubStickRightBtn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadSubStickRightTxt_, P08.Gamepad.En_ButtonType.SubJoystickRight:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadMeleeBtn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadMeleeTxt_, P08.Gamepad.En_ButtonType.Melee:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadSkill1Btn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadSkill1Txt_, P08.Gamepad.En_ButtonType.Skill1:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadSkill2Btn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadSkill2Txt_, P08.Gamepad.En_ButtonType.Skill2:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadSkill3Btn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadSkill3Txt_, P08.Gamepad.En_ButtonType.Skill3:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadAvoidBtn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadAvoidTxt_, P08.Gamepad.En_ButtonType.Avoid:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadUltimate1Btn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadUltimate1Txt_, P08.Gamepad.En_ButtonType.Ultimate1:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadUltimate2Btn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadUltimate2Txt_, P08.Gamepad.En_ButtonType.Ultimate2:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadUltimate3Btn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadUltimate3Txt_, P08.Gamepad.En_ButtonType.Ultimate3:ToInt())
	end)
	arg_13_0:AddBtnListener(arg_13_0.gamepadLockBtn_, nil, function()
		arg_13_0:InputListener(arg_13_0.gamepadLockTxt_, P08.Gamepad.En_ButtonType.Lock:ToInt())
	end)
	arg_13_0:AddToggleListener(arg_13_0.sensitivitySlider_, function()
		arg_13_0:SetCameraSensitivity(arg_13_0.sensitivitySlider_.value)
	end)
	arg_13_0:AddPressingByTimeListener(arg_13_0.sensitivityReduceBtn_.gameObject, 3, 0.5, 0.5, function()
		if arg_13_0.sensitivitySlider_.value > 1 then
			local var_35_0 = arg_13_0.sensitivitySlider_.value - 1

			arg_13_0:SetCameraSensitivity(var_35_0)

			return true
		end

		return false
	end)
	arg_13_0:AddPressingByTimeListener(arg_13_0.sensitivityAddBtn_.gameObject, 3, 0.5, 0.5, function()
		if arg_13_0.sensitivitySlider_.value < 100 then
			local var_36_0 = arg_13_0.sensitivitySlider_.value + 1

			arg_13_0:SetCameraSensitivity(var_36_0)

			return true
		end

		return false
	end)
	arg_13_0:AddBtnListener(arg_13_0.resetBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("RESET_CAMERAANDKEYBOARD"),
			OkCallback = function()
				LuaForGamepad.DeleteLayoutJson(var_0_2)
				LuaForGamepad.ReloadLayout()
				arg_13_0:RefreshGamepadSetting()

				arg_13_0.changed_ = true
			end
		})
	end)
end

function var_0_0.InputListener(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_0.textCom_ ~= arg_39_1 then
		if arg_39_0.textCom_ then
			arg_39_0.textCom_.text = arg_39_0.textCache_
		end

		arg_39_0.textCom_ = arg_39_1

		if arg_39_0.timer_ then
			arg_39_0.timer_:Stop()

			arg_39_0.timer_ = nil
		end

		arg_39_0.textCache_ = arg_39_1.text
		arg_39_0.localCnt_ = 0
		arg_39_0.timer_ = Timer.New(function()
			arg_39_0.localCnt_ = arg_39_0.localCnt_ + 1

			if arg_39_0.localCnt_ < 10 then
				arg_39_1.text = GetTips("INITING")

				return
			end

			arg_39_1.text = GetTips("PLEASE_INPUT_KEY")

			local var_40_0 = LuaForGamepad.GetLastInputValue()

			if var_40_0 == "" then
				return
			end

			local var_40_1 = var_0_1.decode(var_40_0)

			arg_39_1.text = var_40_1.m_axisName

			LuaForGamepad.SetLayoutItem(var_0_2, LuaForGamepad.GetDefaultLayoutFileName(var_0_2), arg_39_2, var_40_1.m_axisName)
			arg_39_0:StopGampadSetting()
			arg_39_0:RefreshGamepadSetting()

			arg_39_0.textCache_ = arg_39_1.text
			arg_39_0.changed_ = true
			arg_39_0.textCom_ = nil
		end, 0.033, -1)

		arg_39_0.timer_:Start()
	end
end

function var_0_0.SetCameraSensitivity(arg_41_0, arg_41_1)
	if arg_41_1 < 1 then
		arg_41_1 = 1
	elseif arg_41_1 > 100 then
		arg_41_1 = 100
	end

	LuaForGamepad.SetCameraSensitivity(var_0_2, LuaForGamepad.GetDefaultLayoutFileName(var_0_2), arg_41_1)
	arg_41_0:RefreshGamepadSetting()

	arg_41_0.changed_ = true
end

function var_0_0.StopGampadSetting(arg_42_0)
	if arg_42_0.timer_ then
		arg_42_0.timer_:Stop()

		arg_42_0.timer_ = nil
	end

	LuaForGamepad.ClearInputValue()
	LuaForGamepad.DisableListenerEnable()
end

function var_0_0.RefreshGamepadSetting(arg_43_0)
	local var_43_0 = LuaForGamepad.GetGamepadType()

	if var_43_0 == 1 then
		arg_43_0.toggleController_:SetSelectedState("on")
	else
		arg_43_0.toggleController_:SetSelectedState("off")
	end

	if var_43_0 ~= 1 then
		return
	end

	local var_43_1 = LuaForGamepad.GetLayoutJson(var_0_2, LuaForGamepad.GetDefaultLayoutFileName(var_0_2))
	local var_43_2 = var_0_1.decode(var_43_1)

	if var_43_2 == nil or var_43_2.m_buttonMapLayouts == nil then
		return
	end

	for iter_43_0, iter_43_1 in pairs(var_43_2.m_buttonMapLayouts) do
		if iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.MoveUp:ToInt() then
			arg_43_0.gamepadMoveUpTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.MoveDown:ToInt() then
			arg_43_0.gamepadMoveDownTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.MoveLeft:ToInt() then
			arg_43_0.gamepadMoveLeftTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.MoveRight:ToInt() then
			arg_43_0.gamepadMoveRightTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.CameraLeft:ToInt() then
			arg_43_0.gamepadCameraLeftTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.CameraRight:ToInt() then
			arg_43_0.gamepadCameraRightTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.SubJoystickUp:ToInt() then
			arg_43_0.gamepadSubStickUpTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.SubJoystickDown:ToInt() then
			arg_43_0.gamepadSubStickDownTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.SubJoystickLeft:ToInt() then
			arg_43_0.gamepadSubStickLeftTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.SubJoystickRight:ToInt() then
			arg_43_0.gamepadSubStickRightTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Melee:ToInt() then
			arg_43_0.gamepadMeleeTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Skill1:ToInt() then
			arg_43_0.gamepadSkill1Txt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Skill2:ToInt() then
			arg_43_0.gamepadSkill2Txt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Skill3:ToInt() then
			arg_43_0.gamepadSkill3Txt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Avoid:ToInt() then
			arg_43_0.gamepadAvoidTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Ultimate1:ToInt() then
			arg_43_0.gamepadUltimate1Txt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Ultimate2:ToInt() then
			arg_43_0.gamepadUltimate2Txt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Ultimate3:ToInt() then
			arg_43_0.gamepadUltimate3Txt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Lock:ToInt() then
			arg_43_0.gamepadLockTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		end
	end

	local var_43_3 = LuaForGamepad.GetCameraSensitivity()

	arg_43_0.sensitivitySlider_.value = var_43_3
	arg_43_0.sensitivityTxt_.text = var_43_3
end

return var_0_0
