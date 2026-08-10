local var_0_0 = class("SnowballGamePausePopup", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballGamePausePopup"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(arg_3_0.okBtn_, nil, function()
		JumpTools.Back()

		if arg_3_0.OkCallback then
			arg_3_0.OkCallback()
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.cancelBtn_, nil, function()
		JumpTools.Back()

		if arg_3_0.CancelCallback then
			arg_3_0.CancelCallback()
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.OkCallback = arg_6_0.params_.OkCallback
	arg_6_0.CancelCallback = arg_6_0.params_.CancelCallback
end

return var_0_0
