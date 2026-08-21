local var_0_0 = class("FishStaminaRecoverOverflowNotify", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(arg_3_0.okBtn_, nil, handler(arg_3_0, arg_3_0.OnOk))
	arg_3_0:AddBtnListener(arg_3_0.cancelBtn_, nil, handler(arg_3_0, arg_3_0.OnCancel))
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.okCallback = arg_4_0.params_.OkCallback
	arg_4_0.cancelCallback = arg_4_0.params_.CancelCallback
end

function var_0_0.OnOk(arg_5_0)
	OperationRecorder.RecordButtonTouch("activity_kagutsuchi_energyspilling_ture")
	JumpTools.Back()

	if arg_5_0.okCallback then
		arg_5_0.okCallback()
	end
end

function var_0_0.OnCancel(arg_6_0)
	OperationRecorder.RecordButtonTouch("activity_kagutsuchi_energyspilling_false")
	JumpTools.Back()

	if arg_6_0.cancelCallback then
		arg_6_0.cancelCallback()
	end
end

return var_0_0
