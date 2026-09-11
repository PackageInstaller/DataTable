local ShopItemView = class("ShopItemView", ShopItemBase)

function ShopItemView:InitUI()
	self:BindCfgUI()

	self.limitController_ = self.controller_:GetController("lock")
	self.commonItem_ = CommonItemView.New(self.commonGo_)
	self.commonData = clone(ItemTemplateData)
end

function ShopItemView:AddUIListener()
	self:AddBtnListener(nil, nil, "OnClick")
end

function ShopItemView:UpdateTimerView()
	if self.isExchange or self.isLock then
		return
	end

	local var_3_0 = self.shopCfg.refresh_cycle

	if self.shopCfg.refresh_cycle == 1 then
		return
	end

	if not self.isExchange then
		local var_3_1

		if var_3_0 == 2 then
			var_3_1 = _G.gameTimer:GetNextMonthFreshTime()
		elseif var_3_0 == 3 then
			var_3_1 = _G.gameTimer:GetNextWeekFreshTime()
		elseif var_3_0 == 4 then
			var_3_1 = _G.gameTimer:GetNextDayFreshTime()
		elseif var_3_0 == 5 then
			var_3_1 = self.data.next_refresh_timestamp
		end

		self.countdownText_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:DescCdTime3(nil - manager.time:GetServerTime()))
	end
end

function ShopItemView:OnClick()
	if not ShopTools.CheckShopIsUnLock(self.shopID) then
		if self.shopCfg then
			ShowPopItem(POP_ITEM, {
				self.shopCfg.give_id
			})
		end

		return
	end

	self:ClickFunction()
end

function ShopItemView:UpdateView()
	self:SetCommonItem()

	self.nameText_.text = string.format("%s x%d", ItemTools.getItemName(self.itemCfg.id), self.shopCfg.give)
	self.isLock = ShopData.IsGoodUnlock(self.goodID, self.shopID) == 0

	if self.isLock then
		local var_5_0, var_5_1 = ShopData.GetLockTypeAndCondition(self.goodID, self.shopID)

		SetActive(self.null_, true)
		SetActive(self.countdownText_.gameObject, true)

		if var_5_0 == 5 then
			self.nullText_.text = GetTips("EXPLORE_SHOP_TIPS_1")
			self.countdownText_.text = string.format(GetTips("EXPLORE_SHOP_TIPS_2"), var_5_1)
		end
	elseif self.shopCfg.limit_num == -1 or self.shopCfg.limit_num == nil then
		SetActive(self.limitGo_, false)
		SetActive(self.null_, false)
	else
		local var_5_2 = self.shopCfg.limit_num - self.data.buyTime

		if self.itemCfg.type == ItemConst.ITEM_TYPE.HERO_SKIN and ShopTools.HaveSkin(self.itemCfg.id) then
			var_5_2 = 0
		end

		if var_5_2 > 0 then
			SetActive(self.limitGo_, true)
			SetActive(self.null_, false)

			self.limitNum_.text = string.format("<color=#0d89bf>%d</color>/%d", var_5_2, self.shopCfg.limit_num)
			self.limitText_.text = GetTips(ShopConst.SHOP_LIMIT_TEXT[self.shopCfg.refresh_cycle or 7])
		else
			if self.isExchange then
				self.limitController_:SetSelectedState("empty1")

				self.nullText_.text = GetTips("SOLD_OUT")
			else
				local var_5_3 = self.shopCfg.refresh_cycle

				if self.shopCfg.refresh_cycle == 1 then
					self.nullText_.text = GetTips("SOLD_OUT")
				elseif var_5_3 == 2 then
					self.nullText_.text = GetTips("MONTHLY_SOLD_OUT")
				elseif var_5_3 == 3 then
					self.nullText_.text = GetTips("WEEKLY_SOLD_OUT")
				elseif var_5_3 == 4 then
					self.nullText_.text = GetTips("DAILY_SOLD_OUT")
				elseif var_5_3 == 5 then
					self.nullText_.text = GetTips("ACTIVITY_SOLD_OUT")
				end
			end

			SetActive(self.limitGo_, false)
			SetActive(self.null_, true)
		end
	end

	if self.shopCfg.limit_num == 0 then
		SetActive(self.limitGo_, false)
	end

	self:SetCostIcon()

	if ShopTools.GetDiscount(self.goodID, self.shopID) ~= 100 then
		SetActive(self.discountGo_, true)

		self.discountText_.text = ShopTools.GetDiscountLabel(self.goodID, self.shopID)

		SetActive(self.oldPriceGo_, true)

		self.oldPriceText_.text = tostring((ShopTools.GetOriPrice(self.goodID, self.shopID)))
	else
		SetActive(self.oldPriceGo_, false)

		if self.shopCfg.tag == 2 then
			SetActive(self.discountGo_, true)

			self.discountText_.text = GetTips("NEW_ADD")
		else
			SetActive(self.discountGo_, false)
		end
	end

	self:SetPriceText()
end

function ShopItemView:Dispose()
	ShopItemView.super.Dispose(self)
end

return ShopItemView
