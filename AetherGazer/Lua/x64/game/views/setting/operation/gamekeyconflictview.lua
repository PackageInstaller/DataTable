local var_0_0 = class("GameKeyConflictView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Setting/SettingHandl02UI"
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

	arg_4_0.styleController_ = arg_4_0.keyConEx_:GetController("style")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.confirmBtn_, nil, function()
		arg_5_0:InvokeCallback(true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0:InvokeCallback(false)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.opName_ = arg_8_0.params_.opName
	arg_8_0.key_ = arg_8_0.params_.key
	arg_8_0.keyName_ = arg_8_0.params_.keyName
	arg_8_0.conflictOpName_ = arg_8_0.params_.conflictOpName
	arg_8_0.gamepadType_ = arg_8_0.params_.gamepadType

	arg_8_0:RefreshUI()
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = LuaForGamepad.GetKeyIcon(arg_10_0.keyName_, arg_10_0.gamepadType_)

	if var_10_0 then
		local var_10_1 = LuaForGamepad.IsGamepadKey(arg_10_0.key_)

		arg_10_0.styleController_:SetSelectedState(var_10_1 and "gamepad" or "keyboard")

		arg_10_0.keyImage_.sprite = var_10_0

		arg_10_0.keyImage_:SetNativeSize()
	else
		arg_10_0.styleController_:SetSelectedState("text")

		arg_10_0.keyText_.text = GetKeyCodeMappedName(arg_10_0.keyName_)
	end

	local var_10_2 = GetTips("INPUT_KEY_CONFLICT_TIPS")
	local var_10_3 = LuaHidTools.GetOpName(arg_10_0.conflictOpName_)

	arg_10_0.conflictText_.text = string.format(var_10_2, var_10_3)
end

function var_0_0.InvokeCallback(arg_11_0, arg_11_1)
	arg_11_0:Back()

	if arg_11_0.params_.listenCallback then
		arg_11_0.params_.listenCallback(arg_11_1)
	end
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
