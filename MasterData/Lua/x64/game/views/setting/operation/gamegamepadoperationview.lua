local GameGamepadOperationView = class("GameGamepadOperationView", ReduxView)
local cjson = require("cjson")
local var_0_2 = "OtherLayout"

function GameGamepadOperationView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GameGamepadOperationView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GameGamepadOperationView:InitUI()
	self:BindCfgUI()

	self.toggleController_ = ControllerUtil.GetController(self.gamepadBtn_.transform, "toggle")
end

function GameGamepadOperationView:AddUIListener()
	self:AddGamepadSettingListener()
end

function GameGamepadOperationView:AddEventListeners()
	return
end

function GameGamepadOperationView:OnEnter()
	self:AddEventListeners()

	self.changed_ = false
	self.gamepadType_ = LuaForGamepad.GetGamepadType()
	self.oldLayoutJson_ = LuaForGamepad.GetLayoutJson(var_0_2, LuaForGamepad.GetDefaultLayoutFileName(var_0_2))
end

function GameGamepadOperationView:SaveData()
	self.changed_ = false
	self.gamepadType_ = LuaForGamepad.GetGamepadType()
	self.oldLayoutJson_ = LuaForGamepad.GetLayoutJson(var_0_2, LuaForGamepad.GetDefaultLayoutFileName(var_0_2))
end

function GameGamepadOperationView:CheckDataChange()
	return self.changed_
end

function GameGamepadOperationView:RecoverTmpData()
	LuaForGamepad.SetGamePadType(self.gamepadType_)
	LuaForGamepad.SaveLayoutJson(var_0_2, self.oldLayoutJson_)
	LuaForGamepad.ReloadLayout()
	self:RefreshGamepadSetting()
end

function GameGamepadOperationView:OnExit()
	self:RemoveAllEventListener()
	self:StopGampadSetting()
end

function GameGamepadOperationView:Dispose()
	GameGamepadOperationView.super.Dispose(self)
end

function GameGamepadOperationView:UpdatePageData()
	self:RefreshGamepadSetting()
end

function GameGamepadOperationView:AddGamepadSettingListener()
	self:AddBtnListener(self.gamepadBtn_, nil, function()
		if self.toggleController_:GetSelectedState() == "off" then
			self.toggleController_:SetSelectedState("on")
			LuaForGamepad.SetGamePadType(4)
			self:RefreshGamepadSetting()

			self.changed_ = true
		else
			self.toggleController_:SetSelectedState("off")
			LuaForGamepad.SetGamePadType(0)
			self:RefreshGamepadSetting()

			self.changed_ = true
		end
	end)
	self:AddBtnListener(self.gamepadMoveUpBtn_, nil, function()
		self:InputListener(self.gamepadMoveUpTxt_, P08.Gamepad.En_ButtonType.MoveUp:ToInt())
	end)
	self:AddBtnListener(self.gamepadMoveDownBtn_, nil, function()
		self:InputListener(self.gamepadMoveDownTxt_, P08.Gamepad.En_ButtonType.MoveDown:ToInt())
	end)
	self:AddBtnListener(self.gamepadMoveLeftBtn_, nil, function()
		self:InputListener(self.gamepadMoveLeftTxt_, P08.Gamepad.En_ButtonType.MoveLeft:ToInt())
	end)
	self:AddBtnListener(self.gamepadMoveRightBtn_, nil, function()
		self:InputListener(self.gamepadMoveRightTxt_, P08.Gamepad.En_ButtonType.MoveRight:ToInt())
	end)
	self:AddBtnListener(self.gamepadCameraLeftBtn_, nil, function()
		self:InputListener(self.gamepadCameraLeftTxt_, P08.Gamepad.En_ButtonType.CameraLeft:ToInt())
	end)
	self:AddBtnListener(self.gamepadCameraRightBtn_, nil, function()
		self:InputListener(self.gamepadCameraRightTxt_, P08.Gamepad.En_ButtonType.CameraRight:ToInt())
	end)
	self:AddBtnListener(self.gamepadSubStickUpBtn_, nil, function()
		self:InputListener(self.gamepadSubStickUpTxt_, P08.Gamepad.En_ButtonType.SubJoystickUp:ToInt())
	end)
	self:AddBtnListener(self.gamepadSubStickDownBtn_, nil, function()
		self:InputListener(self.gamepadSubStickDownTxt_, P08.Gamepad.En_ButtonType.SubJoystickDown:ToInt())
	end)
	self:AddBtnListener(self.gamepadSubStickLeftBtn_, nil, function()
		self:InputListener(self.gamepadSubStickLeftTxt_, P08.Gamepad.En_ButtonType.SubJoystickLeft:ToInt())
	end)
	self:AddBtnListener(self.gamepadSubStickRightBtn_, nil, function()
		self:InputListener(self.gamepadSubStickRightTxt_, P08.Gamepad.En_ButtonType.SubJoystickRight:ToInt())
	end)
	self:AddBtnListener(self.gamepadMeleeBtn_, nil, function()
		self:InputListener(self.gamepadMeleeTxt_, P08.Gamepad.En_ButtonType.Melee:ToInt())
	end)
	self:AddBtnListener(self.gamepadSkill1Btn_, nil, function()
		self:InputListener(self.gamepadSkill1Txt_, P08.Gamepad.En_ButtonType.Skill1:ToInt())
	end)
	self:AddBtnListener(self.gamepadSkill2Btn_, nil, function()
		self:InputListener(self.gamepadSkill2Txt_, P08.Gamepad.En_ButtonType.Skill2:ToInt())
	end)
	self:AddBtnListener(self.gamepadSkill3Btn_, nil, function()
		self:InputListener(self.gamepadSkill3Txt_, P08.Gamepad.En_ButtonType.Skill3:ToInt())
	end)
	self:AddBtnListener(self.gamepadAvoidBtn_, nil, function()
		self:InputListener(self.gamepadAvoidTxt_, P08.Gamepad.En_ButtonType.Avoid:ToInt())
	end)
	self:AddBtnListener(self.gamepadUltimate1Btn_, nil, function()
		self:InputListener(self.gamepadUltimate1Txt_, P08.Gamepad.En_ButtonType.Ultimate1:ToInt())
	end)
	self:AddBtnListener(self.gamepadUltimate2Btn_, nil, function()
		self:InputListener(self.gamepadUltimate2Txt_, P08.Gamepad.En_ButtonType.Ultimate2:ToInt())
	end)
	self:AddBtnListener(self.gamepadUltimate3Btn_, nil, function()
		self:InputListener(self.gamepadUltimate3Txt_, P08.Gamepad.En_ButtonType.Ultimate3:ToInt())
	end)
	self:AddBtnListener(self.gamepadLockBtn_, nil, function()
		self:InputListener(self.gamepadLockTxt_, P08.Gamepad.En_ButtonType.Lock:ToInt())
	end)
	self:AddToggleListener(self.sensitivitySlider_, function()
		self:SetCameraSensitivity(self.sensitivitySlider_.value)
	end)
	self:AddPressingByTimeListener(self.sensitivityReduceBtn_.gameObject, 3, 0.5, 0.5, function()
		if self.sensitivitySlider_.value > 1 then
			self:SetCameraSensitivity(self.sensitivitySlider_.value - 1)

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.sensitivityAddBtn_.gameObject, 3, 0.5, 0.5, function()
		if self.sensitivitySlider_.value < 100 then
			self:SetCameraSensitivity(self.sensitivitySlider_.value + 1)

			return true
		end

		return false
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("RESET_CAMERAANDKEYBOARD"),
			OkCallback = function()
				LuaForGamepad.DeleteLayoutJson(var_0_2)
				LuaForGamepad.ReloadLayout()
				self:RefreshGamepadSetting()

				self.changed_ = true
			end
		})
	end)
end

function GameGamepadOperationView:InputListener(arg_39_1, arg_39_2)
	if self.timer_ then
		return
	end

	self.localCnt_ = 0
	self.timer_ = Timer.New(function()
		self.localCnt_ = self.localCnt_ + 1

		if self.localCnt_ < 10 then
			arg_39_1.text = GetTips("INITING")

			return
		end

		arg_39_1.text = GetTips("PLEASE_INPUT_KEY")

		local var_40_0 = LuaForGamepad.GetFirstDeltaInputValue()

		if var_40_0 == "" then
			return
		end

		if self.timer_ then
			self.timer_:Stop()

			self.timer_ = nil
		end

		local var_40_1 = cjson.decode(var_40_0)

		arg_39_1.text = var_40_1.m_axisName

		LuaForGamepad.SetLayoutItem(var_0_2, LuaForGamepad.GetDefaultLayoutFileName(var_0_2), arg_39_2, var_40_1.m_axisName)
		self:StopGampadSetting()
		self:RefreshGamepadSetting()

		self.changed_ = true
	end, 0.033, -1)

	self.timer_:Start()
end

function GameGamepadOperationView:SetCameraSensitivity(arg_41_1)
	if arg_41_1 < 1 then
		arg_41_1 = 1
	elseif arg_41_1 > 100 then
		arg_41_1 = 100
	end

	LuaForGamepad.SetCameraSensitivity(var_0_2, LuaForGamepad.GetDefaultLayoutFileName(var_0_2), arg_41_1)
	self:RefreshGamepadSetting()

	self.changed_ = true
end

function GameGamepadOperationView:StopGampadSetting()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	LuaForGamepad.ClearInputValue()
	LuaForGamepad.DisableListenerEnable()
end

function GameGamepadOperationView:RefreshGamepadSetting()
	local var_43_0 = LuaForGamepad.GetGamepadType()

	if var_43_0 == 4 then
		self.toggleController_:SetSelectedState("on")
	else
		self.toggleController_:SetSelectedState("off")
	end

	if var_43_0 ~= 4 then
		return
	end

	local var_43_1 = cjson.decode((LuaForGamepad.GetLayoutJson(var_0_2, LuaForGamepad.GetDefaultLayoutFileName(var_0_2))))

	if var_43_1 == nil or var_43_1.m_buttonMapLayouts == nil then
		return
	end

	for iter_43_0, iter_43_1 in pairs(var_43_1.m_buttonMapLayouts) do
		if iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.MoveUp:ToInt() then
			self.gamepadMoveUpTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.MoveDown:ToInt() then
			self.gamepadMoveDownTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.MoveLeft:ToInt() then
			self.gamepadMoveLeftTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.MoveRight:ToInt() then
			self.gamepadMoveRightTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.CameraLeft:ToInt() then
			self.gamepadCameraLeftTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.CameraRight:ToInt() then
			self.gamepadCameraRightTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.SubJoystickUp:ToInt() then
			self.gamepadSubStickUpTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.SubJoystickDown:ToInt() then
			self.gamepadSubStickDownTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.SubJoystickLeft:ToInt() then
			self.gamepadSubStickLeftTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.SubJoystickRight:ToInt() then
			self.gamepadSubStickRightTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Melee:ToInt() then
			self.gamepadMeleeTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Skill1:ToInt() then
			self.gamepadSkill1Txt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Skill2:ToInt() then
			self.gamepadSkill2Txt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Skill3:ToInt() then
			self.gamepadSkill3Txt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Avoid:ToInt() then
			self.gamepadAvoidTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Ultimate1:ToInt() then
			self.gamepadUltimate1Txt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Ultimate2:ToInt() then
			self.gamepadUltimate2Txt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Ultimate3:ToInt() then
			self.gamepadUltimate3Txt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		elseif iter_43_1.m_buttonType == P08.Gamepad.En_ButtonType.Lock:ToInt() then
			self.gamepadLockTxt_.text = LuaForGamepad.ConvertName(iter_43_1.m_value)
		end
	end

	local var_43_2 = LuaForGamepad.GetCameraSensitivity()

	self.sensitivitySlider_.value = var_43_2
	self.sensitivityTxt_.text = var_43_2
end

return GameGamepadOperationView
