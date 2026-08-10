local var_0_0 = class("GuideStuckPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/GuideNewUI/GuideStuckPopView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiTips.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0.okBtn_.onClick:AddListener(function()
		arg_5_0:OnClickOk()
	end)
	arg_5_0.cancelBtn_.onClick:AddListener(function()
		arg_5_0:OnClickCancel()
	end)
	arg_5_0.maskBtn_.onClick:AddListener(function()
		arg_5_0:OnClickCancel()
	end)
end

function var_0_0.OnClickOk(arg_9_0)
	if arg_9_0.info_.OkCallback then
		arg_9_0.info_.OkCallback()
	end

	arg_9_0:Back()
end

function var_0_0.OnClickCancel(arg_10_0)
	if arg_10_0.info_.CancelCallback then
		arg_10_0.info_.CancelCallback()
	end

	arg_10_0:Back()
end

function var_0_0.RemoveListeners(arg_11_0)
	arg_11_0.okBtn_.onClick:RemoveAllListeners()
	arg_11_0.cancelBtn_.onClick:RemoveAllListeners()
	arg_11_0.tipsBtn_.onClick:RemoveAllListeners()
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.info_ = arg_12_0.params_
	arg_12_0.tipContent_.text = arg_12_0.info_.content
end

function var_0_0.SetGaussionBg(arg_13_0)
	manager.ui:SetUISeparateRender(true)

	return true
end

function var_0_0.Hide(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
