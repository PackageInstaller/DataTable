local var_0_0 = class("GamepadSelectView")

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Setting/GameSettinghandleUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiStory.transform
end

function var_0_0.Ctor(arg_3_0, arg_3_1)
	arg_3_0.gameObject_ = Object.Instantiate(Asset.Load(arg_3_0:UIName()), arg_3_0:UIParent())
	arg_3_0.transform_ = arg_3_0.gameObject_.transform
	arg_3_0.gamepadType_ = arg_3_1

	arg_3_0:Init()
	arg_3_0:OnEnter()
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_5_0, arg_5_0.gameObject_)

	arg_5_0.selectController_ = arg_5_0.controllerEx_:GetController("select")
	arg_5_0.toggleController_ = arg_5_0.controllerEx_:GetController("keepType")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0.confirmBtn_.onClick:AddListener(function()
		if arg_6_0.keepJoystickType_ and arg_6_0.keepJoystickType_ ~= LuaHidTools.IsKeepJoystickType() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("GAMEPAD_USE_HISTORY_TIP"),
				OkCallback = function()
					return
				end
			})
		end

		LuaHidTools.SetIsKeepJoystickType(arg_6_0.keepJoystickType_)

		local var_7_0 = arg_6_0:GetGamepadType(arg_6_0.selectIdx_)

		LuaHidTools.SetPlayerSelectJoystick(var_7_0)
		arg_6_0:CloseWindow()
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
	arg_6_0.cancelBtn_.onClick:AddListener(function()
		arg_6_0:CloseWindow()
	end)

	for iter_6_0 = 1, 2 do
		local var_6_0 = arg_6_0["btn_" .. iter_6_0]

		if var_6_0 then
			var_6_0.onClick:AddListener(function()
				arg_6_0:SelectGamepad(iter_6_0)
			end)
		end
	end

	arg_6_0.keepTypeToggle_.onValueChanged:AddListener(function(arg_11_0)
		arg_6_0.keepJoystickType_ = arg_11_0

		arg_6_0.toggleController_:SetSelectedState(arg_11_0 and "true" or "false")
	end)
end

function var_0_0.RemoveUIListeners(arg_12_0)
	arg_12_0.confirmBtn_.onClick:RemoveAllListeners()
	arg_12_0.cancelBtn_.onClick:RemoveAllListeners()

	for iter_12_0 = 1, 2 do
		local var_12_0 = arg_12_0["btn_" .. iter_12_0]

		if var_12_0 then
			var_12_0.onClick:RemoveAllListeners()
		end
	end
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:SetGaussionBg()

	local var_13_0 = arg_13_0.gamepadType_

	if PlayerPrefs.HasKey("JoystickType") then
		var_13_0 = LuaHidTools.GetPlayerSelectJoystick()
	end

	local var_13_1 = arg_13_0:GetGamepadIndex(var_13_0)

	arg_13_0:SelectGamepad(var_13_1)
	LuaForCursor.SwitchCursor(true)

	arg_13_0.keepJoystickType_ = LuaHidTools.IsKeepJoystickType()
	arg_13_0.keepTypeToggle_.isOn = arg_13_0.keepJoystickType_
	arg_13_0.keepTypeText_.text = GetTips("DEVICE_MUTE_TIP")
end

function var_0_0.SelectGamepad(arg_14_0, arg_14_1)
	arg_14_0.selectController_:SetSelectedState(arg_14_1)

	arg_14_0.selectIdx_ = arg_14_1
end

function var_0_0.GetGamepadIndex(arg_15_0, arg_15_1)
	if arg_15_1 == HID_TYPES.PS4 then
		return 1
	end

	return 2
end

function var_0_0.GetGamepadType(arg_16_0, arg_16_1)
	if arg_16_1 == 1 then
		return HID_TYPES.PS4
	end

	return HID_TYPES.Xbox
end

function var_0_0.CloseWindow(arg_17_0)
	arg_17_0:RevertSeparate()
	arg_17_0:Dispose()

	LuaHidTools.selectWin_ = nil
end

function var_0_0.SetGaussionBg(arg_18_0)
	if not manager.ui:GetUISeparateRender() then
		manager.ui:SetUISeparateRender(true)

		arg_18_0.separateFlag_ = true
	end

	return true
end

function var_0_0.RevertSeparate(arg_19_0)
	if arg_19_0.separateFlag_ then
		manager.ui:SetUISeparateRender(false)

		arg_19_0.separateFlag_ = false
	end
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0:RemoveUIListeners()
	Object.Destroy(arg_20_0.gameObject_)

	arg_20_0.transform_ = nil
	arg_20_0.gameObject_ = nil
end

return var_0_0
