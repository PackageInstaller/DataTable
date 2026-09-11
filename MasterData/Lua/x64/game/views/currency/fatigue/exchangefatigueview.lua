local ExchangeFatigueView = class("ExchangeFatigueView", ReduxView)

function ExchangeFatigueView:UIName()
	return "Widget/Common/Pop/AddstaminapopUI"
end

function ExchangeFatigueView:UIParent()
	return manager.ui.uiPop.transform
end

function ExchangeFatigueView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.isItemExchangeController_ = self.controllerEx_:GetController("isItemExchange")
	self.topBtnList_ = {}

	for iter_3_0 = 1, 3 do
		self.topBtnList_[iter_3_0] = StoreBtnView.New(self[string.format("toggleBtnGo%s_", iter_3_0)], CommonBtnTypeConst.EXCHANGE_VITALITY, iter_3_0)
	end

	self.exchangeFatigueByItemView_ = ExchangeFatigueByItem.New(self.itemExchangeGo_)
	self.exchangeFatigueByCurrencyView_ = ExchangeFatigueByCurrency.New(self.currencyExchangeGo_)
	self.dailyFatigueView_ = DailyFatiguePage.New(self.dailyFatigueGo_)
	self.OnSwitchBtnTypeHandler_ = handler(self, self.OnSwitchBtnType)

	self:BindDailyFatigueRedPoint()
end

function ExchangeFatigueView:BindDailyFatigueRedPoint()
	manager.redPoint:bindUIandKey(self.toggleBtnGo3_.transform, RedPointConst.DAILY_FATIGUE)
	manager.redPoint:updateKey(RedPointConst.DAILY_FATIGUE)
end

function ExchangeFatigueView:UnbindDailyFatigueRedPoint()
	manager.redPoint:unbindUIandKey(self.toggleBtnGo3_.transform, RedPointConst.DAILY_FATIGUE)
end

function ExchangeFatigueView:OnEnter()
	self.exchangeFatigueByItemView_:InitData()
	self.exchangeFatigueByItemView_:OnEnter()
	self.exchangeFatigueByCurrencyView_:OnEnter()
	self.dailyFatigueView_:OnEnter()

	self.selectIndex_ = self.params_.page and self.params_.page ~= 0 and self.params_.page or self.dailyFatigueView_:CheckEnable() and 3 or 1

	self:RefreshTopBtn()
	self:RefreshBottomBtn()
	manager.notify:RegistListener(COMMON_BTN_TYPE_SWITCH, self.OnSwitchBtnTypeHandler_)
end

function ExchangeFatigueView:OnExit()
	self:RestoreBar()
	manager.notify:RemoveListener(COMMON_BTN_TYPE_SWITCH, self.OnSwitchBtnTypeHandler_)
	self.exchangeFatigueByItemView_:OnExit()
	self.exchangeFatigueByCurrencyView_:OnExit()
	self.dailyFatigueView_:OnExit()
end

function ExchangeFatigueView:OnTop()
	self:UpdateBar()
end

function ExchangeFatigueView:Dispose()
	ExchangeFatigueView.super.Dispose(self)
	self:UnbindDailyFatigueRedPoint()

	for iter_9_0, iter_9_1 in pairs(self.topBtnList_) do
		iter_9_1:Dispose()
	end

	self.topBtnList_ = nil
	self.OnSwitchBtnTypeHandler_ = nil

	self.exchangeFatigueByItemView_:Dispose()

	self.exchangeFatigueByItemView_ = nil

	self.exchangeFatigueByCurrencyView_:Dispose()

	self.exchangeFatigueByCurrencyView_ = nil

	self.dailyFatigueView_:Dispose()

	self.dailyFatigueView_ = nil
end

function ExchangeFatigueView:AddListeners()
	self:AddBtnListener(self.sureBtn_, nil, function()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_dundun_diamond_check = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		})

		if self.selectIndex_ == 1 then
			self.exchangeFatigueByItemView_:OnExchange()
		else
			self.exchangeFatigueByCurrencyView_:OnExchange()
		end
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
end

function ExchangeFatigueView:UpdateBar()
	self.lastBarList_ = manager.windowBar:GetLastBarList() or {}
	self.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	self.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()

	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})

	if whereami ~= "battle" and whereami ~= "battleResult" then
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	end

	manager.windowBar:SetAsLastSibling()
end

function ExchangeFatigueView:RestoreBar()
	manager.windowBar:HideBar()

	if self.lastBarList_ then
		manager.windowBar:SwitchBar(self.lastBarList_)
	end

	if self.lastAddBarList_ then
		for iter_15_0, iter_15_1 in ipairs(self.lastAddBarList_) do
			manager.windowBar:SetBarCanAdd(iter_15_1, true)
		end
	end

	if self.lastCanClickBarList_ then
		for iter_15_2, iter_15_3 in ipairs(self.lastCanClickBarList_) do
			manager.windowBar:SetBarCanClick(iter_15_3, true)
		end
	end
end

function ExchangeFatigueView:OnSwitchBtnType(arg_16_1, arg_16_2)
	if arg_16_1 ~= CommonBtnTypeConst.EXCHANGE_VITALITY or self.selectIndex_ == arg_16_2 then
		return
	end

	self.selectIndex_ = arg_16_2

	self:RefreshTopBtn()
	self:RefreshBottomBtn()
end

function ExchangeFatigueView:RefreshTopBtn()
	for iter_17_0, iter_17_1 in pairs(self.topBtnList_) do
		iter_17_1:RefreshUI(self.selectIndex_)
	end
end

function ExchangeFatigueView:RefreshBottomBtn()
	local var_18_0 = true

	if self.selectIndex_ == 1 then
		self.isItemExchangeController_:SetSelectedIndex(1)

		var_18_0 = self.exchangeFatigueByItemView_:HasMaterial()

		self.dailyFatigueView_:OnUnSelect()
	elseif self.selectIndex_ == 2 then
		self.isItemExchangeController_:SetSelectedIndex(0)
		self.dailyFatigueView_:OnUnSelect()
	else
		self.isItemExchangeController_:SetSelectedIndex(2)
		self.dailyFatigueView_:OnSelect()
	end

	self.sureBtn_.interactable = var_18_0
end

function ExchangeFatigueView:OnTryToUseItem(arg_19_1, arg_19_2)
	if isSuccess(arg_19_1.result) then
		if GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max <= ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) then
			CurrencyData:SetFatigueCallFlag(0)
		end

		ShowTips("EXCHANGE_SUCCESS")
		self:Back()
	else
		ShowTips(arg_19_1.result)
	end
end

function ExchangeFatigueView:OnBuyFatigue(arg_20_1, arg_20_2)
	if arg_20_1.result == 0 then
		ShowTips("TRANSACTION_SUCCESS")
		self:Back()
	else
		ShowTips(arg_20_1.result)

		return
	end
end

return ExchangeFatigueView
