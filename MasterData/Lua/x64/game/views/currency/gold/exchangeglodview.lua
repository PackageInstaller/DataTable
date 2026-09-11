local ExchangeGlodView = class("ExchangeGlodView", ReduxView)

function ExchangeGlodView:UIName()
	return "Widget/Common/Pop/AddmoneypopUI"
end

function ExchangeGlodView:UIParent()
	return manager.ui.uiPop.transform
end

function ExchangeGlodView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.isItemExchangeController_ = self.controllerEx_:GetController("isItemExchange")
	self.topBtnList_ = {}

	for iter_3_0 = 1, 2 do
		self.topBtnList_[iter_3_0] = StoreBtnView.New(self[string.format("toggleBtnGo%s_", iter_3_0)], CommonBtnTypeConst.EXCHANGE_GOLD, iter_3_0)
	end

	self.exchangeGlodByItemView_ = ExchangeGlodByItem.New(self.itemExchangeGo_)
	self.exchangeGlodByCurrencyView_ = ExchangeGlodByCurrency.New(self.currencyExchangeGo_)
	self.OnSwitchBtnTypeHandler_ = handler(self, self.OnSwitchBtnType)
end

function ExchangeGlodView:OnEnter()
	self.exchangeGlodByItemView_:InitData()
	self.exchangeGlodByItemView_:OnEnter()
	self.exchangeGlodByCurrencyView_:OnEnter()

	self.selectIndex_ = 1

	self:RefreshTopBtn()
	self:RefreshBottomBtn()
	manager.notify:RegistListener(COMMON_BTN_TYPE_SWITCH, self.OnSwitchBtnTypeHandler_)
end

function ExchangeGlodView:OnExit()
	self:RestoreBar()
	manager.notify:RemoveListener(COMMON_BTN_TYPE_SWITCH, self.OnSwitchBtnTypeHandler_)
	self.exchangeGlodByItemView_:OnExit()
	self.exchangeGlodByCurrencyView_:OnExit()
end

function ExchangeGlodView:OnTop()
	self:UpdateBar()
end

function ExchangeGlodView:Dispose()
	ExchangeGlodView.super.Dispose(self)

	for iter_7_0, iter_7_1 in pairs(self.topBtnList_) do
		iter_7_1:Dispose()
	end

	self.topBtnList_ = nil
	self.OnSwitchBtnTypeHandler_ = nil

	self.exchangeGlodByItemView_:Dispose()

	self.exchangeGlodByItemView_ = nil

	self.exchangeGlodByCurrencyView_:Dispose()

	self.exchangeGlodByCurrencyView_ = nil
end

function ExchangeGlodView:AddListeners()
	self:AddBtnListener(self.sureBtn_, nil, function()
		if self.selectIndex_ == 1 then
			self.exchangeGlodByItemView_:OnExchange()
		else
			self.exchangeGlodByCurrencyView_:OnExchange()
		end
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
end

function ExchangeGlodView:UpdateBar()
	self.lastBarList_ = manager.windowBar:GetLastBarList() or {}
	self.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	self.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()

	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})

	if whereami ~= "battle" and whereami ~= "battleResult" then
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	end

	manager.windowBar:SetAsLastSibling()
end

function ExchangeGlodView:RestoreBar()
	if self.lastBarList_ then
		manager.windowBar:SwitchBar(self.lastBarList_)
	end

	if self.lastAddBarList_ then
		for iter_13_0, iter_13_1 in ipairs(self.lastAddBarList_) do
			manager.windowBar:SetBarCanAdd(iter_13_1, true)
		end
	end

	if self.lastCanClickBarList_ then
		for iter_13_2, iter_13_3 in ipairs(self.lastCanClickBarList_) do
			manager.windowBar:SetBarCanClick(iter_13_3, true)
		end
	end
end

function ExchangeGlodView:OnSwitchBtnType(arg_14_1, arg_14_2)
	if arg_14_1 ~= CommonBtnTypeConst.EXCHANGE_GOLD or self.selectIndex_ == btnBtnIndex then
		return
	end

	self.selectIndex_ = arg_14_2

	self:RefreshTopBtn()
	self:RefreshBottomBtn()
end

function ExchangeGlodView:RefreshTopBtn()
	for iter_15_0, iter_15_1 in pairs(self.topBtnList_) do
		iter_15_1:RefreshUI(self.selectIndex_)
	end
end

function ExchangeGlodView:RefreshBottomBtn()
	local var_16_0 = true

	if self.selectIndex_ == 1 then
		self.isItemExchangeController_:SetSelectedState("true")

		var_16_0 = self.exchangeGlodByItemView_:HasMaterial()
	else
		self.isItemExchangeController_:SetSelectedState("false")
	end

	self.sureBtn_.interactable = var_16_0
end

function ExchangeGlodView:OnTryToUseItem(arg_17_1, arg_17_2)
	if isSuccess(arg_17_1.result) then
		self:Back()

		local var_17_0 = {}

		for iter_17_0, iter_17_1 in ipairs(arg_17_1.drop_list) do
			if var_17_0[iter_17_1.id] then
				var_17_0[iter_17_1.id] = iter_17_1.num + var_17_0[iter_17_1.id] or iter_17_1.num
			end
		end

		local var_17_2 = {}

		for iter_17_2, iter_17_3 in pairs(var_17_0) do
			table.insert(var_17_2, {
				id = iter_17_2,
				num = iter_17_3
			})
		end

		getReward(var_17_2)
	else
		ShowTips(arg_17_1.result)
	end
end

function ExchangeGlodView:OnBuyCoin(arg_18_1, arg_18_2)
	if arg_18_1.result == 0 then
		ShowTips("TRANSACTION_SUCCESS")
		self:Back()
	else
		ShowTips(arg_18_1.result)

		return
	end
end

return ExchangeGlodView
