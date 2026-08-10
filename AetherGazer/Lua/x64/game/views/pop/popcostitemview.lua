local var_0_0 = class("PopCostItemView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/PopupCostConfirmationUI"
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

	arg_4_0.tipsController_ = arg_4_0.controllerEx_:GetController("tips")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_cancelBtn, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_maskBtn, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_okBtn, nil, function()
		local var_8_0 = arg_5_0.params_.ToggleCallback

		arg_5_0:Back()

		if var_8_0 then
			var_8_0(arg_5_0.tipsFlag_)
		end

		if arg_5_0.params_.popCostCallBack then
			arg_5_0.params_.popCostCallBack()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_tipsBtn_, nil, function()
		arg_5_0.tipsFlag_ = not arg_5_0.tipsFlag_

		arg_5_0.tipsController_:SetSelectedState(tostring(arg_5_0.tipsFlag_))
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.m_costCountText.text = arg_10_0.params_.content

	local var_10_0 = arg_10_0.params_.ToggleCallback ~= nil

	SetActive(arg_10_0.m_tips, var_10_0)

	arg_10_0.tipsTxt_.text = arg_10_0.params_.ToggleText or GetTips("LOGIN_MUTE_TIP")
	arg_10_0.tipsFlag_ = false

	arg_10_0.tipsController_:SetSelectedState(tostring(arg_10_0.tipsFlag_))
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0.lastBarList_ = manager.windowBar:GetLastBarList() or {}
	arg_11_0.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	arg_11_0.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()

	local var_11_0 = arg_11_0.params_.costId or 0

	manager.windowBar:SwitchBar({
		var_11_0
	})
	manager.windowBar:SetBarCanAdd(var_11_0, arg_11_0:IsItemCanAdd(var_11_0))
	manager.windowBar:SetBarCanClick(var_11_0, true)
	manager.windowBar:SetAsLastSibling()
end

function var_0_0.OnExit(arg_12_0)
	if arg_12_0.lastBarList_ then
		manager.windowBar:SwitchBar(arg_12_0.lastBarList_)
	end

	if arg_12_0.lastAddBarList_ then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0.lastAddBarList_) do
			manager.windowBar:SetBarCanAdd(iter_12_1, true)
		end
	end

	if arg_12_0.lastCanClickBarList_ then
		for iter_12_2, iter_12_3 in ipairs(arg_12_0.lastCanClickBarList_) do
			manager.windowBar:SetBarCanClick(iter_12_3, true)
		end
	end
end

function var_0_0.IsItemCanAdd(arg_13_0, arg_13_1)
	if arg_13_1 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
		return true
	end

	return false
end

return var_0_0
