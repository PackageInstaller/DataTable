local ExchangeItemView = class("ExchangeItemView", ShopItemBase)

function ExchangeItemView:InitUI()
	self:BindCfgUI()

	self.commonItem_ = CommonItemView.New(self.commonGo_, true)
	self.commonData = clone(ItemTemplateData)
	self.lockController = self.controller_:GetController("lock")
end

function ExchangeItemView:AddUIListener()
	self:AddBtnListener(self.clickBtn_, nil, function()
		if self.callBack then
			self.callBack(self.data)

			return
		end

		self:OnClick()
	end)
end

function ExchangeItemView:UpdateView()
	self.commonData.id = self.itemCfg.id
	self.commonData.number = self.shopCfg.give

	self.commonItem_:SetData(self.commonData)

	local var_4_0, var_4_1, var_4_2 = ShopTools.IsOnDiscountArea(self.goodID)

	self.nameText_.text = ItemTools.getItemName(self.itemCfg.id)

	SetActive(self.limitGo_, false)
	SetActive(self.newGo_, self.shopCfg.tag == ShopConst.TAGS.NEW)

	local var_4_3 = ShopTools.GetDiscount(self.goodID)

	if var_4_0 and var_4_2 then
		SetActive(self.discountGo_, true)
		SetActive(self.oldPriceGo_, true)
	else
		SetActive(self.discountGo_, false)
		SetActive(self.oldPriceGo_, false)
	end

	self:SetCostIcon()
	self:SetPriceText()

	if var_4_3 ~= 100 then
		self.discountText_.text = ShopTools.GetDiscountLabel(self.goodID)
		self.oldPriceText_.text = tostring(ShopTools.GetOriPrice(self.goodID))
	end

	if self.restNum <= 0 then
		if self.isExchange then
			self.soldOutText_.text = GetTips("ACTIVITY_SOLD_OUT")
		else
			local var_4_4 = self.shopCfg.refresh_cycle

			if self.shopCfg.shop_refresh == 4 then
				self.soldOutText_.text = self.itemCfg.type == ItemConst.ITEM_TYPE.HERO_PIECE and GetTips("NEXT_UPDATE") or GetTips("ACTIVITY_SOLD_OUT")
			elseif var_4_4 == 1 then
				self.soldOutText_.text = GetTips("SOLD_OUT")
			elseif var_4_4 == 2 then
				self.soldOutText_.text = GetTips("MONTHLY_SOLD_OUT")
			elseif var_4_4 == 3 then
				self.soldOutText_.text = GetTips("WEEKLY_SOLD_OUT")
			elseif var_4_4 == 4 then
				self.soldOutText_.text = GetTips("DAILY_SOLD_OUT")
			elseif var_4_4 == 5 then
				self.soldOutText_.text = GetTips("ACTIVITY_SOLD_OUT")
			elseif var_4_4 == 6 then
				self.soldOutText_.text = GetTips("ACTIVITY_SOLD_OUT")
			end
		end
	end

	SetActive(self.ownGo_, ShopTools.CheckGoodsOwen(self.goodID))

	if self.shopCfg.limit_num == -1 or self.shopCfg.limit_num == nil then
		SetActive(self.limitGo_, false)
		self.lockController:SetSelectedState("null")
	else
		if self.itemCfg.type == ItemConst.ITEM_TYPE.HERO_SKIN and ShopTools.HaveSkin(self.itemCfg.id) then
			self.restNum = 0
		end

		SetActive(self.limitGo_, self.restNum > 0)

		self.limitNum_.text = string.format("%s/%d", (self.data.defaultNumColor or nil) and (self.restNum or string.format("<color=#0d89bf>%d</color>", self.restNum)), self.shopCfg.limit_num)
		self.limitText_.text = GetTips(self.restNum > 0 and "PURCHASE_LIMIT" or "SOLD_OUT")

		if self.restNum <= 0 then
			if self.shopCfg.refresh_cycle == 1 or self.isExchange then
				self.lockController:SetSelectedState("refresh1")
			else
				self.lockController:SetSelectedState("refresh2")
			end
		else
			self.lockController:SetSelectedState("null")
		end
	end

	self:UpdateLock()
end

function ExchangeItemView:UpdateLock()
	self.isGoodLock = ShopData.IsGoodUnlock(self.goodID) == 0

	if self.isGoodLock then
		local var_5_0, var_5_1 = ShopData.GetLockTypeAndCondition(self.goodID)

		self.lockController:SetSelectedState("lock")

		if var_5_0 == 5 then
			self.nullText_.text = string.format(GetTips("EXPLORE_AREA_DEBLOCKING"), var_5_1)
		end

		if var_5_0 == 7 then
			self.nullText_.text = string.format(GetTips("GOD_EATER_SHOP_LOCK_DES"), var_5_1)
		end
	end

	self.isShopLock = not ShopTools.CheckShopIsUnLock(self.shopID)

	if self.isShopLock then
		self.lockController:SetSelectedState("lock")

		self.nullText_.text = GetTips("SHOP_LOCK")
	end

	self.isShopClose = not ShopTools.IsShopOpen(self.shopID) and self.data.checkShopOpen

	if self.isShopClose then
		self.lockController:SetSelectedState("lock")

		self.nullText_.text = GetTips("SHOP_LOCK")
	end
end

function ExchangeItemView:UpdateTimerView()
	if self.restNum and self.restNum > 0 then
		return
	end

	if self.isExchange or self.isLock then
		return
	end

	if self.shopCfg.refresh_cycle and self.shopCfg.refresh_cycle == 1 then
		return
	end

	if not self.isExchange then
		self.countdownText_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStrWith2Unit(self:GetLeftTime(), true))
	end
end

function ExchangeItemView:GetLeftTime()
	local var_7_0

	if self.shopCfg.refresh_cycle == 2 then
		var_7_0 = _G.gameTimer:GetNextMonthFreshTime()
	elseif self.shopCfg.refresh_cycle == 3 then
		var_7_0 = _G.gameTimer:GetNextWeekFreshTime()
	elseif self.shopCfg.refresh_cycle == 4 then
		var_7_0 = _G.gameTimer:GetNextDayFreshTime()
	elseif self.shopCfg.refresh_cycle == 5 then
		var_7_0 = self.data.next_refresh_timestamp
	elseif self.shopCfg.refresh_cycle == 6 then
		var_7_0 = self.data.next_refresh_timestamp
	elseif self.shopCfg.shop_refresh == 4 then
		var_7_0 = self.data.next_refresh_timestamp
	end

	return var_7_0
end

function ExchangeItemView:OnExit()
	self.callBack = nil
end

function ExchangeItemView:Dispose()
	self.commonItem_:Dispose()
	ExchangeItemView.super.Dispose(self)
end

function ExchangeItemView:OnClick()
	if not ShopTools.CheckShopIsUnLock(self.shopID) then
		ShowPopItem(POP_ITEM, {
			self.shopCfg.give_id
		})

		return
	end

	self:ClickFunction()
end

return ExchangeItemView
