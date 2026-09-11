local RechargeDiamondExchangeView = class("RechargeDiamondExchangeView", ReduxView)

function RechargeDiamondExchangeView:UIName()
	return "Widget/Common/Pop/Addshiftedstars"
end

function RechargeDiamondExchangeView:UIParent()
	return manager.ui.uiPop.transform
end

function RechargeDiamondExchangeView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function RechargeDiamondExchangeView:OnEnter()
	self:UpdateView()
	self:UpdateBar()
	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_flower_to_diamond = "{" .. ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) .. "," .. CurrencyData:GetRechargeDiamond()
	})
	manager.windowBar:SetAsLastSibling()
end

function RechargeDiamondExchangeView:ConfirmToDo(arg_5_1)
	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_ticket_check = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)
	})

	local var_5_2 = tonumber(self.inputFieldText_.text)

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = string.format(GetTips("CONFIRM_BUY"), ItemTools.getItemName(self.params_.useId), self.params_.useBaseNum * var_5_2, ItemTools.getItemName(self.params_.getId), self.params_.getBaseNum * var_5_2),
		OkCallback = function()
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_flower_to_diamond_check = 0
			})
			arg_5_1()
		end,
		CancelCallback = function()
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_flower_to_diamond_check = 1
			})
		end
	})
end

function RechargeDiamondExchangeView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		self:CheckBuy()
	end)
	self:AddPressingByTimeListener(self.addBtn_.gameObject, 3, 0.5, 0.2, function()
		local var_12_0 = tonumber(self.inputFieldText_.text)

		if var_12_0 >= self.canUseMaxNum_ then
			return false
		end

		var_12_0 = self.pressCnt_ > 1 and (self.pressCnt_ == 2 and var_12_0 + 9 or var_12_0 + 10) or var_12_0 + 1

		if var_12_0 < self.canUseMaxNum_ then
			self:UpdateCnt(var_12_0)

			return true
		end

		self:UpdateCnt(self.canUseMaxNum_)

		return false
	end)
	self:AddPressingByTimeListener(self.delBtn_.gameObject, 3, 0.5, 0.2, function()
		local var_13_0 = tonumber(self.inputFieldText_.text)

		if var_13_0 <= 1 then
			return false
		end

		var_13_0 = self.pressCnt_ > 1 and (self.pressCnt_ == 2 and var_13_0 - 9 or var_13_0 - 10) or var_13_0 - 1

		if var_13_0 > 1 then
			self:UpdateCnt(var_13_0)

			return true
		end

		self:UpdateCnt(1)

		return false
	end)
	self:AddBtnListener(self.maxBtn_, nil, function()
		self:UpdateCnt(self.canUseMaxNum_)
	end)
	self.inputFieldText_.onValueChanged:AddListener(function()
		local var_15_0 = tonumber(self.inputFieldText_.text) or 0

		if var_15_0 < 1 then
			var_15_0 = 1
		end

		self:UpdateCnt(var_15_0)
	end)
end

function RechargeDiamondExchangeView:UpdateView()
	if self.params_.useId then
		self.icon1_.sprite = ItemTools.getItemLittleSprite(self.params_.useId)
		self.useNameText_.text = ItemTools.getItemName(self.params_.useId)
	end

	if self.params_.getId then
		local var_16_0 = ItemTools.getItemLittleSprite(self.params_.getId)

		self.icon2_.sprite = var_16_0
		self.getImage_.sprite = var_16_0
		self.getNameText_.text = ItemTools.getItemName(self.params_.getId)
		self.titleText_.text = string.format(GetTips("EXCHANGE_TIP"), ItemTools.getItemName(self.params_.getId))
	end

	self.canUseMaxNum_ = math.floor(self:GetTotal() / (self.params_.useBaseNum or 1))

	self:UpdateCnt((self.params_.defaultNum ~= 0 or nil) and (self.params_.defaultNum or 1))

	local var_16_1 = self.canUseMaxNum_ ~= 1

	if self.canUseMaxNum_ ~= 1 == false then
		self.addBtn_.interactable = var_16_1
		self.maxBtn_.interactable = var_16_1
	end
end

function RechargeDiamondExchangeView:UpdateBar()
	self.lastBarList_ = manager.windowBar:GetLastBarList() or {}
	self.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	self.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()

	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})

	if whereami ~= "battle" and whereami ~= "battleResult" then
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	end
end

function RechargeDiamondExchangeView:GetTotal()
	if self.params_.useId == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE or self.params_.useId == CurrencyConst.GetPlatformDiamondId() then
		return CurrencyData:GetRechargeDiamond()
	end

	return ItemTools.getItemNum(self.params_.useId)
end

function RechargeDiamondExchangeView:UpdateCnt(arg_19_1)
	self.useNumText_.text = NumberTools.RetractNumberForWindBar(arg_19_1 * self.params_.useBaseNum)
	self.getNumText_.text = NumberTools.RetractNumberForWindBar(arg_19_1)

	if tonumber(self.inputFieldText_.text) ~= arg_19_1 then
		self.inputFieldText_.text = arg_19_1
	end

	self.tipsNumText_.text = arg_19_1
	self.inputFieldText_.textComponent.color = arg_19_1 > self.canUseMaxNum_ and Color(1, 0, 0.043) or Color(0.302, 0.338, 0.389)
	self.delBtn_.interactable = arg_19_1 > 1
	self.addBtn_.interactable = arg_19_1 < self.canUseMaxNum_
	self.maxBtn_.interactable = arg_19_1 < self.canUseMaxNum_
end

function RechargeDiamondExchangeView:CheckBuy()
	local var_20_0 = tonumber(self.inputFieldText_.text)

	if self.params_.defaultNum ~= 0 then
		var_20_0 = var_20_0 * self.params_.useBaseNum
	end

	if self.params_.getId == CurrencyConst.CURRENCY_TYPE_DIAMOND then
		if var_20_0 <= CurrencyData:GetRechargeDiamond() then
			self:ConfirmToDo(function()
				CurrencyAction.BuyDiamond(var_20_0)
			end)
		else
			if whereami == "battle" or whereami == "battleResult" then
				ShowTips("ERROR_RECHARGE_DIAMOND_NOT_ENOUGH_NO_BUY")

				return
			end

			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
				ShopTools.DiamondEnoughMessageBox()
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_DIAMOND")
			end
		end
	elseif self.params_.exchangeId then
		local var_20_1 = getShopCfg(self.params_.exchangeId)

		if var_20_1.cost_id == CurrencyConst.CURRENCY_TYPE_DIAMOND then
			if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < var_20_1.cost * var_20_0 then
				self:Back()
				ShopTools.DefaultOpenPopUp(0)

				return
			end
		elseif var_20_1.cost_id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE and CurrencyData:GetRechargeDiamond() < var_20_1.cost * var_20_0 then
			self:Back()

			if whereami == "battle" or whereami == "battleResult" then
				ShowTips("ERROR_RECHARGE_DIAMOND_NOT_ENOUGH_NO_BUY")

				return
			end

			ShopTools.DiamondEnoughMessageBox()

			return
		end

		self:ConfirmToDo(function()
			ShopAction.BuyItem({
				{
					goodID = var_20_1.goods_id,
					buyNum = var_20_0
				}
			}, nil, (self.params_.buy_source or nil) and self.params_.buy_source)
		end)
	end
end

function RechargeDiamondExchangeView:RestoreBar()
	if self.lastBarList_ then
		manager.windowBar:SwitchBar(self.lastBarList_)
	end

	if self.lastAddBarList_ then
		for iter_23_0, iter_23_1 in ipairs(self.lastAddBarList_) do
			manager.windowBar:SetBarCanAdd(iter_23_1, true)
		end
	end

	if self.lastCanClickBarList_ then
		for iter_23_2, iter_23_3 in ipairs(self.lastCanClickBarList_) do
			manager.windowBar:SetBarCanClick(iter_23_3, true)
		end
	end
end

function RechargeDiamondExchangeView:OnBuyDiamond(arg_24_1, arg_24_2)
	if arg_24_1.result == 0 then
		self:Back()
		ShowTips("TRANSACTION_SUCCESS")
	end
end

function RechargeDiamondExchangeView:OnShopBuyResult(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	if arg_25_1 == 0 then
		self:Back()
	end
end

function RechargeDiamondExchangeView:OnExit()
	self:RestoreBar()
	manager.windowBar:SetAsFirstSibling()

	self.lastBarList_ = nil
	self.lastAddBarList_ = nil
	self.lastCanClickBarList_ = nil
end

function RechargeDiamondExchangeView:OnExitInput()
	JumpTools.Back()

	return true
end

function RechargeDiamondExchangeView:Dispose()
	RechargeDiamondExchangeView.super.Dispose(self)
end

return RechargeDiamondExchangeView
