local GamepadSelectView = class("GamepadSelectView")

function GamepadSelectView:UIName()
	return "Widget/System/Setting/GameSettinghandleUI"
end

function GamepadSelectView:UIParent()
	return manager.ui.uiStory.transform
end

function GamepadSelectView:Ctor(arg_3_1)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName()), self:UIParent())
	self.transform_ = self.gameObject_.transform
	self.gamepadType_ = arg_3_1

	self:Init()
	self:OnEnter()
end

function GamepadSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GamepadSelectView:InitUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)

	self.selectController_ = self.controllerEx_:GetController("select")
	self.toggleController_ = self.controllerEx_:GetController("keepType")
end

function GamepadSelectView:AddUIListener()
	self.confirmBtn_.onClick:AddListener(function()
		if self.keepJoystickType_ and self.keepJoystickType_ ~= LuaHidTools.IsKeepJoystickType() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("GAMEPAD_USE_HISTORY_TIP"),
				OkCallback = function()
					return
				end
			})
		end

		LuaHidTools.SetIsKeepJoystickType(self.keepJoystickType_)

		local var_7_0 = self:GetGamepadType(self.selectIdx_)

		LuaHidTools.SetPlayerSelectJoystick(var_7_0)
		self:CloseWindow()
		manager.notify:Invoke(JOYSTICK_TYPE_SELECT, var_7_0)
		SDKTools.SendMessageToSDK("keymap_setting", {
			type = var_7_0,
			other_arrayobject = {
				{
					buttonType = "unknown",
					value = "unknown"
				}
			}
		})
	end)
	self.cancelBtn_.onClick:AddListener(function()
		self:CloseWindow()
	end)

	for iter_6_0 = 1, 2 do
		if self["btn_" .. iter_6_0] then
			self["btn_" .. iter_6_0].onClick:AddListener(function()
				self:SelectGamepad(iter_6_0)
			end)
		end
	end

	self.keepTypeToggle_.onValueChanged:AddListener(function(arg_11_0)
		self.keepJoystickType_ = arg_11_0

		self.toggleController_:SetSelectedState(arg_11_0 and "true" or "false")
	end)
end

function GamepadSelectView:RemoveUIListeners()
	self.confirmBtn_.onClick:RemoveAllListeners()
	self.cancelBtn_.onClick:RemoveAllListeners()

	for iter_12_0 = 1, 2 do
		if self["btn_" .. iter_12_0] then
			self["btn_" .. iter_12_0].onClick:RemoveAllListeners()
		end
	end
end

function GamepadSelectView:OnEnter()
	self:SetGaussionBg()
	self:SelectGamepad((self:GetGamepadIndex((PlayerPrefs.HasKey("JoystickType") or nil) and LuaHidTools.GetPlayerSelectJoystick())))
	LuaForCursor.SwitchCursor(true)

	self.keepJoystickType_ = LuaHidTools.IsKeepJoystickType()
	self.keepTypeToggle_.isOn = self.keepJoystickType_
	self.keepTypeText_.text = GetTips("DEVICE_MUTE_TIP")
end

function GamepadSelectView:SelectGamepad(arg_14_1)
	self.selectController_:SetSelectedState(arg_14_1)

	self.selectIdx_ = arg_14_1
end

function GamepadSelectView:GetGamepadIndex(arg_15_1)
	if arg_15_1 == HID_TYPES.PS4 then
		return 1
	end

	return 2
end

function GamepadSelectView:GetGamepadType(arg_16_1)
	if arg_16_1 == 1 then
		return HID_TYPES.PS4
	end

	return HID_TYPES.Xbox
end

function GamepadSelectView:CloseWindow()
	self:RevertSeparate()
	self:Dispose()

	LuaHidTools.selectWin_ = nil
end

function GamepadSelectView:SetGaussionBg()
	if not manager.ui:GetUISeparateRender() then
		manager.ui:SetUISeparateRender(true)

		self.separateFlag_ = true
	end

	return true
end

function GamepadSelectView:RevertSeparate()
	if self.separateFlag_ then
		manager.ui:SetUISeparateRender(false)

		self.separateFlag_ = false
	end
end

function GamepadSelectView:Dispose()
	self:RemoveUIListeners()
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return GamepadSelectView
