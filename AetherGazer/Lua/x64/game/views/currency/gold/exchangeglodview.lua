local var_0_0 = class("ExchangeGlodView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/AddmoneypopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.isItemExchangeController_ = arg_3_0.controllerEx_:GetController("isItemExchange")
	arg_3_0.topBtnList_ = {}

	for iter_3_0 = 1, 2 do
		arg_3_0.topBtnList_[iter_3_0] = StoreBtnView.New(arg_3_0[string.format("toggleBtnGo%s_", iter_3_0)], CommonBtnTypeConst.EXCHANGE_GOLD, iter_3_0)
	end

	arg_3_0.exchangeGlodByItemView_ = ExchangeGlodByItem.New(arg_3_0.itemExchangeGo_)
	arg_3_0.exchangeGlodByCurrencyView_ = ExchangeGlodByCurrency.New(arg_3_0.currencyExchangeGo_)
	arg_3_0.OnSwitchBtnTypeHandler_ = handler(arg_3_0, arg_3_0.OnSwitchBtnType)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.exchangeGlodByItemView_:InitData()
	arg_4_0.exchangeGlodByItemView_:OnEnter()
	arg_4_0.exchangeGlodByCurrencyView_:OnEnter()

	arg_4_0.selectIndex_ = 1

	arg_4_0:RefreshTopBtn()
	arg_4_0:RefreshBottomBtn()
	manager.notify:RegistListener(COMMON_BTN_TYPE_SWITCH, arg_4_0.OnSwitchBtnTypeHandler_)
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:RestoreBar()
	manager.notify:RemoveListener(COMMON_BTN_TYPE_SWITCH, arg_5_0.OnSwitchBtnTypeHandler_)
	arg_5_0.exchangeGlodByItemView_:OnExit()
	arg_5_0.exchangeGlodByCurrencyView_:OnExit()
end

function var_0_0.OnTop(arg_6_0)
	arg_6_0:UpdateBar()
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.topBtnList_) do
		iter_7_1:Dispose()
	end

	arg_7_0.topBtnList_ = nil
	arg_7_0.OnSwitchBtnTypeHandler_ = nil

	arg_7_0.exchangeGlodByItemView_:Dispose()

	arg_7_0.exchangeGlodByItemView_ = nil

	arg_7_0.exchangeGlodByCurrencyView_:Dispose()

	arg_7_0.exchangeGlodByCurrencyView_ = nil
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.sureBtn_, nil, function()
		if arg_8_0.selectIndex_ == 1 then
			arg_8_0.exchangeGlodByItemView_:OnExchange()
		else
			arg_8_0.exchangeGlodByCurrencyView_:OnExchange()
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.cancelBtn_, nil, function()
		arg_8_0:Back()
	end)
end

function var_0_0.UpdateBar(arg_12_0)
	arg_12_0.lastBarList_ = manager.windowBar:GetLastBarList() or {}
	arg_12_0.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	arg_12_0.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()

	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})

	if whereami ~= "battle" and whereami ~= "battleResult" then
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	end

	manager.windowBar:SetAsLastSibling()
end

function var_0_0.RestoreBar(arg_13_0)
	if arg_13_0.lastBarList_ then
		manager.windowBar:SwitchBar(arg_13_0.lastBarList_)
	end

	if arg_13_0.lastAddBarList_ then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0.lastAddBarList_) do
			manager.windowBar:SetBarCanAdd(iter_13_1, true)
		end
	end

	if arg_13_0.lastCanClickBarList_ then
		for iter_13_2, iter_13_3 in ipairs(arg_13_0.lastCanClickBarList_) do
			manager.windowBar:SetBarCanClick(iter_13_3, true)
		end
	end
end

function var_0_0.OnSwitchBtnType(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= CommonBtnTypeConst.EXCHANGE_GOLD or arg_14_0.selectIndex_ == btnBtnIndex then
		return
	end

	arg_14_0.selectIndex_ = arg_14_2

	arg_14_0:RefreshTopBtn()
	arg_14_0:RefreshBottomBtn()
end

function var_0_0.RefreshTopBtn(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.topBtnList_) do
		iter_15_1:RefreshUI(arg_15_0.selectIndex_)
	end
end

function var_0_0.RefreshBottomBtn(arg_16_0)
	local var_16_0 = true

	if arg_16_0.selectIndex_ == 1 then
		arg_16_0.isItemExchangeController_:SetSelectedState("true")

		var_16_0 = arg_16_0.exchangeGlodByItemView_:HasMaterial()
	else
		arg_16_0.isItemExchangeController_:SetSelectedState("false")
	end

	arg_16_0.sureBtn_.interactable = var_16_0
end

function var_0_0.OnTryToUseItem(arg_17_0, arg_17_1, arg_17_2)
	if isSuccess(arg_17_1.result) then
		arg_17_0:Back()

		local var_17_0 = {}

		for iter_17_0, iter_17_1 in ipairs(arg_17_1.drop_list) do
			var_17_0[iter_17_1.id] = var_17_0[iter_17_1.id] and iter_17_1.num + var_17_0[iter_17_1.id] or iter_17_1.num
		end

		local var_17_1 = {}

		for iter_17_2, iter_17_3 in pairs(var_17_0) do
			table.insert(var_17_1, {
				id = iter_17_2,
				num = iter_17_3
			})
		end

		getReward(var_17_1)
	else
		ShowTips(arg_17_1.result)
	end
end

function var_0_0.OnBuyCoin(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1.result == 0 then
		ShowTips("TRANSACTION_SUCCESS")
		arg_18_0:Back()
	else
		ShowTips(arg_18_1.result)

		return
	end
end

return var_0_0
