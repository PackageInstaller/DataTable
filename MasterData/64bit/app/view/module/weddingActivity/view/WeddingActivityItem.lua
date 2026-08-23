local var_0_0 = g.core.const.ConstMgr.RechargeConst
local var_0_1 = g.core.model.User
local var_0_4 = g.core.const.ConstMgr.ShopConst
local WeddingActivityItem = class("WeddingActivityItem", require("app.fairyGUI.weddingActivity.UI_WeddingActivityItem"))

function WeddingActivityItem:ctor()
	self:addClickListener(handler(self, self._onClick))
end

function WeddingActivityItem:onUnload()
	self:_stopTimer()
end

function WeddingActivityItem:updateCell(arg_3_1)
	if not arg_3_1 then
		self:setVisible(false)

		return
	end

	self:setVisible(true)

	self._info = arg_3_1
	self._curInfo = self._info.id == self._info.curGiftId and self._info or g.core.model.User.giftData:getGiftDataById(self._info.curGiftId)

	self:setIcon((g.core.common.Path:getRechargeIconById(self._curInfo.icon)))
	self.m_nameTxt:setText(self._curInfo.name)

	if self.m_showRechargeTypeController then
		self.m_showRechargeTypeController:setSelectedIndex(self._curInfo.recharge_type ~= 0 and 1 or 0)
	end

	if self._curInfo.recharge_type ~= 0 then
		if self._curInfo.recharge_money == 0 then
			self.m_isFreeController:setSelectedIndex(1)
		else
			self.m_isFreeController:setSelectedIndex(0)

			if self.m_priceCompMoney then
				self.m_priceCompMoney:setPriceByInfo((var_0_1.rechargeData:getRechargeInfoByTypeAndPrice(self._curInfo.recharge_type, self._curInfo.recharge_money, self._curInfo.special)))
			end
		end
	elseif self._curInfo.diamond_price == 0 then
		self.m_isFreeController:setSelectedIndex(1)
	else
		self.m_isFreeController:setSelectedIndex(0)
		self.m_priceComp:setGold(self._curInfo.diamond_price, self._curInfo.original_price)
	end

	if self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.NORMAL then
		self.m_isLimitBuyController:setSelectedIndex(0)

		self._canBuy = true
	else
		self.m_isLimitBuyController:setSelectedIndex(1)

		local var_3_0 = self._curInfo.times - self._curInfo.buyTimes

		self._canBuy = self._curInfo.times - self._curInfo.buyTimes > 0

		local var_3_1 = 107063

		if self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.DAILY then
			var_3_1 = 107061
		elseif self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.WEEKLY then
			var_3_1 = 107062
		elseif self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.MONTHLY then
			var_3_1 = 107064
		elseif self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.PERMANENT then
			var_3_1 = 410314
		end

		self.m_buyTitleTxt:setText((g.core.lang:get(var_3_1)))
		self.m_buyTimesTxt:setText(g.core.lang:get(430801, {
			color = (not self._canBuy or nil) and "#e52e2e",
			cur = var_3_0,
			max = self._curInfo.times
		}))
	end

	if self._curInfo.buy_level > 0 and var_0_1:getLevel() < self._curInfo.buy_level then
		-- block empty
	end

	if self._curInfo.discount ~= 100 and self._curInfo.discount ~= 0 then
		self.m_isDiscountController:setSelectedIndex(1)
		self.m_discountComp:setTitle(self._curInfo.discount .. "%")
	else
		self.m_isDiscountController:setSelectedIndex(0)
	end

	self:_stopTimer()

	local var_3_5

	if self._curInfo.time_limited ~= 0 then
		self.m_isLimitTimeController:setSelectedIndex(1)

		if g.core.common.ServerTime:getLeftSeconds(self._curInfo.endBuyTime) > 0 then
			self:_startTimer()
		end
	else
		self.m_isLimitTimeController:setSelectedIndex(0)

		var_3_5 = {}
	end

	var_3_5.id = self._curInfo.id

	if self._curInfo.shop_first == var_0_4.SHOP_GIFT_VALUE.LEVEL_GIFT then
		self.m_redPointComp:setId(339)
	elseif self._curInfo.shop_first == var_0_4.SHOP_GIFT_VALUE.NEO_GIFT then
		self.m_redPointComp:setId(1064)
	elseif self._curInfo.shop_first == var_0_4.SHOP_GIFT_VALUE.THEME_GIFT then
		self.m_redPointComp:setId(715)
	elseif self._curInfo.shop_first == var_0_4.SHOP_GIFT_VALUE.WEDDING then
		self.m_redPointComp:setId(803)
	else
		self.m_redPointComp:setId(195)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = var_3_5
	})
end

function WeddingActivityItem:_stopTimer()
	if self._timeSchedule then
		self:cancelSchedule(self._timeSchedule)
	end

	self._timeSchedule = nil
end

function WeddingActivityItem:_startTimer()
	self._timeSchedule = self._timeSchedule or self:newSchedule(handler(self, self._onTimerUpdate), 1)
end

function WeddingActivityItem:_onTimerUpdate()
	local var_6_0, var_6_1, var_6_2, var_6_3 = g.core.common.ServerTime:getLeftTimeParts(self._curInfo.endBuyTime)

	if var_6_0 > 0 then
		self.m_timeTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(109600, {
			num = var_6_0
		}))
	elseif var_6_1 > 0 then
		self.m_timeTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(109599, {
			num = var_6_1
		}))
	elseif var_6_2 > 0 then
		self.m_timeTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(109598, {
			num = var_6_2
		}))
	elseif var_6_3 > 0 then
		self.m_timeTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(109598, {
			num = 1
		}))
	elseif var_6_3 == 0 then
		self:_stopTimer()
		self:dispatchCompEvent("GiftTimeOut_CheckRefresh")
	end
end

function WeddingActivityItem:_onClick()
	if self._canBuy then
		clone(self._curInfo).chargeInfo = self._rechargeInfo

		g.core.module.ModuleManager:pushPopup(require("app.view.module.recharge.view.RechargeGiftPop").new(self._curInfo))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(107118))
	end
end

return WeddingActivityItem
