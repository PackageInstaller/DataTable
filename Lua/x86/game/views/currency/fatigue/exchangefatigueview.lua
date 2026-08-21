local var_0_0 = class("ExchangeFatigueView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/AddstaminapopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.isItemExchangeController_ = arg_3_0.controllerEx_:GetController("isItemExchange")
	arg_3_0.topBtnList_ = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.topBtnList_[iter_3_0] = StoreBtnView.New(arg_3_0[string.format("toggleBtnGo%s_", iter_3_0)], CommonBtnTypeConst.EXCHANGE_VITALITY, iter_3_0)
	end

	arg_3_0.exchangeFatigueByItemView_ = ExchangeFatigueByItem.New(arg_3_0.itemExchangeGo_)
	arg_3_0.exchangeFatigueByCurrencyView_ = ExchangeFatigueByCurrency.New(arg_3_0.currencyExchangeGo_)
	arg_3_0.dailyFatigueView_ = DailyFatiguePage.New(arg_3_0.dailyFatigueGo_)
	arg_3_0.OnSwitchBtnTypeHandler_ = handler(arg_3_0, arg_3_0.OnSwitchBtnType)

	arg_3_0:BindDailyFatigueRedPoint()
end

function var_0_0.BindDailyFatigueRedPoint(arg_4_0)
	manager.redPoint:bindUIandKey(arg_4_0.toggleBtnGo3_.transform, RedPointConst.DAILY_FATIGUE)
	manager.redPoint:updateKey(RedPointConst.DAILY_FATIGUE)
end

function var_0_0.UnbindDailyFatigueRedPoint(arg_5_0)
	manager.redPoint:unbindUIandKey(arg_5_0.toggleBtnGo3_.transform, RedPointConst.DAILY_FATIGUE)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.exchangeFatigueByItemView_:InitData()
	arg_6_0.exchangeFatigueByItemView_:OnEnter()
	arg_6_0.exchangeFatigueByCurrencyView_:OnEnter()
	arg_6_0.dailyFatigueView_:OnEnter()

	local var_6_0 = arg_6_0.dailyFatigueView_:CheckEnable()
	local var_6_1 = arg_6_0.params_.page

	if var_6_1 and var_6_1 ~= 0 then
		arg_6_0.selectIndex_ = var_6_1
	else
		arg_6_0.selectIndex_ = var_6_0 and 3 or 1
	end

	arg_6_0:RefreshTopBtn()
	arg_6_0:RefreshBottomBtn()
	manager.notify:RegistListener(COMMON_BTN_TYPE_SWITCH, arg_6_0.OnSwitchBtnTypeHandler_)
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:RestoreBar()
	manager.notify:RemoveListener(COMMON_BTN_TYPE_SWITCH, arg_7_0.OnSwitchBtnTypeHandler_)
	arg_7_0.exchangeFatigueByItemView_:OnExit()
	arg_7_0.exchangeFatigueByCurrencyView_:OnExit()
	arg_7_0.dailyFatigueView_:OnExit()
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0:UpdateBar()
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	arg_9_0:UnbindDailyFatigueRedPoint()

	for iter_9_0, iter_9_1 in pairs(arg_9_0.topBtnList_) do
		iter_9_1:Dispose()
	end

	arg_9_0.topBtnList_ = nil
	arg_9_0.OnSwitchBtnTypeHandler_ = nil

	arg_9_0.exchangeFatigueByItemView_:Dispose()

	arg_9_0.exchangeFatigueByItemView_ = nil

	arg_9_0.exchangeFatigueByCurrencyView_:Dispose()

	arg_9_0.exchangeFatigueByCurrencyView_ = nil

	arg_9_0.dailyFatigueView_:Dispose()

	arg_9_0.dailyFatigueView_ = nil
end

function var_0_0.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.sureBtn_, nil, function()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_dundun_diamond_check = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		})

		if arg_10_0.selectIndex_ == 1 then
			arg_10_0.exchangeFatigueByItemView_:OnExchange()
		else
			arg_10_0.exchangeFatigueByCurrencyView_:OnExchange()
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.maskBtn_, nil, function()
		arg_10_0:Back()
	end)
	arg_10_0:AddBtnListener(arg_10_0.cancelBtn_, nil, function()
		arg_10_0:Back()
	end)
end

function var_0_0.UpdateBar(arg_14_0)
	arg_14_0.lastBarList_ = manager.windowBar:GetLastBarList() or {}
	arg_14_0.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	arg_14_0.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()

	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})

	if whereami ~= "battle" and whereami ~= "battleResult" then
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	end

	manager.windowBar:SetAsLastSibling()
end

function var_0_0.RestoreBar(arg_15_0)
	manager.windowBar:HideBar()

	if arg_15_0.lastBarList_ then
		manager.windowBar:SwitchBar(arg_15_0.lastBarList_)
	end

	if arg_15_0.lastAddBarList_ then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0.lastAddBarList_) do
			manager.windowBar:SetBarCanAdd(iter_15_1, true)
		end
	end

	if arg_15_0.lastCanClickBarList_ then
		for iter_15_2, iter_15_3 in ipairs(arg_15_0.lastCanClickBarList_) do
			manager.windowBar:SetBarCanClick(iter_15_3, true)
		end
	end
end

function var_0_0.OnSwitchBtnType(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 ~= CommonBtnTypeConst.EXCHANGE_VITALITY or arg_16_0.selectIndex_ == arg_16_2 then
		return
	end

	arg_16_0.selectIndex_ = arg_16_2

	arg_16_0:RefreshTopBtn()
	arg_16_0:RefreshBottomBtn()
end

function var_0_0.RefreshTopBtn(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.topBtnList_) do
		iter_17_1:RefreshUI(arg_17_0.selectIndex_)
	end
end

function var_0_0.RefreshBottomBtn(arg_18_0)
	local var_18_0 = true

	if arg_18_0.selectIndex_ == 1 then
		arg_18_0.isItemExchangeController_:SetSelectedIndex(1)

		var_18_0 = arg_18_0.exchangeFatigueByItemView_:HasMaterial()

		arg_18_0.dailyFatigueView_:OnUnSelect()
	elseif arg_18_0.selectIndex_ == 2 then
		arg_18_0.isItemExchangeController_:SetSelectedIndex(0)
		arg_18_0.dailyFatigueView_:OnUnSelect()
	else
		arg_18_0.isItemExchangeController_:SetSelectedIndex(2)
		arg_18_0.dailyFatigueView_:OnSelect()
	end

	arg_18_0.sureBtn_.interactable = var_18_0
end

function var_0_0.OnTryToUseItem(arg_19_0, arg_19_1, arg_19_2)
	if isSuccess(arg_19_1.result) then
		local var_19_0 = PlayerData:GetPlayerInfo().userLevel

		if GameLevelSetting[var_19_0].fatigue_max <= ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) then
			CurrencyData:SetFatigueCallFlag(0)
		end

		ShowTips("EXCHANGE_SUCCESS")
		arg_19_0:Back()
	else
		ShowTips(arg_19_1.result)
	end
end

function var_0_0.OnBuyFatigue(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1.result == 0 then
		ShowTips("TRANSACTION_SUCCESS")
		arg_20_0:Back()
	else
		ShowTips(arg_20_1.result)

		return
	end
end

return var_0_0
