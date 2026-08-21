local var_0_0 = class("RecallSystemInputWordPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/RecallUI/RC1stRecallCodeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:GetOrAddComponent(arg_3_0.codeInput_.gameObject, typeof(InputFieldHelper))
	dealEnter(arg_3_0.codeInput_.gameObject)
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.sureBtn_, nil, function()
		local var_6_0 = ActivityRecallData:GetDataByPara("recalledActivityID")
		local var_6_1 = arg_4_0.codeInput_.text

		ActivityRecallAction.RequireWriteRecallCode(var_6_0, var_6_1)

		arg_4_0.codeInput_.text = ""
	end)
	arg_4_0:AddBtnListener(arg_4_0.cancelBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.OnReceivedCodeReward(arg_8_0)
	arg_8_0:Back()
end

function var_0_0.UpdateBar(arg_9_0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:UpdateView()
end

function var_0_0.UpdateView(arg_12_0)
	arg_12_0.codeInput_.text = ""
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.codeInput_.onValueChanged:RemoveAllListeners()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
