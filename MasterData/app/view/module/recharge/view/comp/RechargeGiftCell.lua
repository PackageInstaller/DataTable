local var_0_0 = g.core.const.ConstMgr.RechargeConst
local var_0_1 = g.core.model.User
local var_0_2 = g.core.model.User.giftData
local var_0_3 = g.core.common.ServerTime
local var_0_4 = g.core.const.ConstMgr.ShopConst
local RechargeGiftCell = class("RechargeGiftCell", require("app.fairyGUI.recharge.UI_RechargeGiftCell"))

function RechargeGiftCell:ctor()
	self._info = nil
	self._curInfo = nil
	self._isEnough = true
	self._canBuy = false
	self._costType = 0
	self._costValue = 0
	self._costHasNum = 0
	self._timeSchedule = nil
	self._nextBuyTime = 0
	self._limitTimeScheduler = nil

	self:_addListeners()
	self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)
end

function RechargeGiftCell:_addListeners()
	self.m_popBtn:addClickListener(handler(self, self._onClick))
	self.m_awardBtn:addClickListener(handler(self, self._onClick))
end

function RechargeGiftCell:_onClick()
	if self._canBuy then
		clone(self._curInfo).chargeInfo = self._rechargeInfo

		g.core.module.ModuleManager:pushPopup(require("app.view.module.recharge.view.RechargeGiftPop").new(self._curInfo))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(107118))
	end
end

function RechargeGiftCell:updateCell(arg_4_1, arg_4_2)
	if not arg_4_1 then
		self:setVisible(false)

		return
	end

	self:setVisible(true)

	self._info = arg_4_1
	self._curInfo = self._info.id == self._info.curGiftId and self._info or g.core.model.User.giftData:getGiftDataById(self._info.curGiftId)

	self.m_item:setURL((g.core.common.Path:getRechargeIconById(self._curInfo.icon)))
	self.m_nameTxt:setText(self._curInfo.name)

	local var_4_0 = self._curInfo.activity_type == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.PRECIOUS_RECRUIT
	local var_4_1 = self._curInfo.activity_type == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WEEKLY_COMPETITION
	local var_4_2 = self._curInfo.activity_type == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.BOUNTY_GIFT

	if self._curInfo.activity_type == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WEEKLY_COMPETITION or var_4_2 then
		if self._curInfo.diamond_price == 0 and self._curInfo.recharge_type == 0 and self._curInfo.free_diamond == 0 then
			self.m_isFreeController:setSelectedIndex(1)
			self.m_redPointComp:setVisible(true)
		else
			self.m_redPointComp:setVisible(false)
			self.m_isFreeController:setSelectedIndex(0)

			if self._curInfo.diamond_price > 0 then
				self.m_priceComp:setGold(self._curInfo.diamond_price, self._curInfo.original_price)
			elseif self._curInfo.free_diamond > 0 then
				self.m_priceComp:setDiamond(self._curInfo.free_diamond)
			else
				self._rechargeInfo = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(self._curInfo.recharge_type, self._curInfo.recharge_money)

				self.m_priceComp:setTitle(self._rechargeInfo.moneyUnit .. self._rechargeInfo.realMoney)
				self.m_priceComp:getChild("originNum"):setText((config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA or nil) and g.core.model.User.rechargeData:safeCalPriceString(self._rechargeInfo.id, self._curInfo.discount / 100, "*"))
			end
		end
	elseif var_4_0 then
		if self._curInfo.recharge_type == 0 then
			self.m_isFreeController:setSelectedIndex(1)
			self.m_redPointComp:setVisible(true)
		else
			self.m_redPointComp:setVisible(false)
			self.m_isFreeController:setSelectedIndex(0)

			if self._curInfo.diamond_price > 0 then
				self.m_priceComp:setGold(self._curInfo.diamond_price, self._curInfo.original_price)
			elseif self._curInfo.free_diamond > 0 then
				self.m_priceComp:setDiamond(self._curInfo.free_diamond)
			else
				self._rechargeInfo = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(self._curInfo.recharge_type, self._curInfo.recharge_money)

				self.m_priceComp:setTitle(self._rechargeInfo.moneyUnit .. self._rechargeInfo.realMoney)
				self.m_priceComp:getChild("originNum"):setText((config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA or nil) and g.core.model.User.rechargeData:safeCalPriceString(self._rechargeInfo.id, self._curInfo.discount / 100, "*"))
			end
		end
	else
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
		elseif self._curInfo.diamond_price == 0 and self._curInfo.free_diamond == 0 then
			self.m_isFreeController:setSelectedIndex(1)
		else
			self.m_isFreeController:setSelectedIndex(0)

			if self._curInfo.diamond_price > 0 then
				self.m_priceComp:setGold(self._curInfo.diamond_price, self._curInfo.original_price)
			else
				self.m_priceComp:setDiamond(self._curInfo.free_diamond)
			end
		end
	end

	if self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.NORMAL then
		self.m_isLimitController:setSelectedIndex(0)

		self._canBuy = true

		if self._timeSchedule then
			self:cancelSchedule(self._timeSchedule)

			self._timeSchedule = nil
		end

		self.m_isUnBuyController:setSelectedIndex(0)
	else
		self.m_isLimitController:setSelectedIndex(1)

		local var_4_5 = self._curInfo.times - self._curInfo.buyTimes

		if self._curInfo.buyTimes > 0 then
			if self._curInfo.id ~= 54 then
				if self.m_timeTxt then
					self.m_timeTxt:setVisible(true)
				end

				self:_refreshTime()

				self._timeSchedule = self:newSchedule(handler(self, self._refreshTime), 1)
			elseif self.m_timeTxt then
				self.m_timeTxt:setVisible(false)
			end
		elseif self._timeSchedule then
			self:cancelSchedule(self._timeSchedule)

			self._timeSchedule = nil
		end

		self._canBuy = var_4_5 > 0

		local var_4_6 = 107063

		if self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.DAILY then
			var_4_6 = 107061
		elseif self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.WEEKLY then
			var_4_6 = 107062
		elseif self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.MONTHLY then
			var_4_6 = 107064
		elseif self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.PERMANENT and (var_4_1 or var_4_2) then
			var_4_6 = 410314
		end

		self.m_limitTxt:setText(g.core.lang:get(var_4_6) .. " " .. g.core.lang:get(107056, {
			num = var_4_5,
			maxNum = self._curInfo.times
		}))
		self.m_isUnBuyController:setSelectedIndex(self._canBuy and 0 or 1)
	end

	local var_4_7 = true

	if self._curInfo.buy_level > 0 then
		if var_0_1:getLevel() < self._curInfo.buy_level then
			var_4_7 = false

			self.m_isUnBuyController:setSelectedIndex(2)
			self.m_levelText:setText(g.core.lang:get(107028, {
				level = self._curInfo.buy_level
			}))
		end
	end

	if self._curInfo.discount ~= 100 and self._curInfo.discount ~= 0 then
		self.m_isDiscountController:setSelectedIndex(1)
		self.m_discountTitle:setTitle(self._curInfo.discount .. "%")
	else
		self.m_isDiscountController:setSelectedIndex(0)
	end

	if self._limitTimeScheduler then
		self:cancelSchedule(self._limitTimeScheduler)

		self._limitTimeScheduler = nil
	end

	if self._curInfo.time_limited ~= 0 then
		self.m_IsTimeLimitController:setSelectedIndex(1)

		if g.core.common.ServerTime:getLeftSeconds(self._curInfo.endBuyTime) > 0 then
			self._limitTimeScheduler = self:newSchedule(handler(self, self._onRefreshEndBuyTime), 1)
		end

		self:_onRefreshEndBuyTime()
	else
		self.m_IsTimeLimitController:setSelectedIndex(0)
	end

	local var_4_8 = {
		id = self._curInfo.id
	}

	if self._curInfo.shop_first == var_0_4.SHOP_GIFT_VALUE.LEVEL_GIFT then
		self.m_redPointComp:setId(339)

		if var_4_7 then
			var_0_2:addNewLevelGiftId(self._curInfo.id)
		end
	elseif self._curInfo.shop_first == var_0_4.SHOP_GIFT_VALUE.NEO_GIFT then
		self.m_redPointComp:setId(1064)
	elseif self._curInfo.shop_first == var_0_4.SHOP_GIFT_VALUE.THEME_GIFT then
		self.m_redPointComp:setId(715)
	elseif self._curInfo.shop_first == var_0_4.SHOP_GIFT_VALUE.WEDDING then
		self.m_redPointComp:setId(803)
	elseif self._curInfo.shop_first == var_0_4.SHOP_GIFT_VALUE.RELEASE_ACTIVITY then
		self.m_redPointComp:setId(1157)
	else
		self.m_redPointComp:setId(195)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = var_4_8
	})
end

function RechargeGiftCell:_onRefreshEndBuyTime()
	if self._curInfo.activity_type == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WEEKLY_COMPETITION and not self._curInfo.endBuyTime then
		local var_5_0, var_5_1 = g.core.model.User.weeklyCompetitionMgrData:hasWeeklyCompetitionActivityByBaseId(self._curInfo.activity_id)

		self._curInfo.endBuyTime = var_5_1
	end

	local var_5_2, var_5_3, var_5_4, var_5_5 = g.core.common.ServerTime:getLeftTimeParts(self._curInfo.endBuyTime)

	if var_5_2 > 0 then
		self.m_timeLimitTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(109600, {
			num = var_5_2
		}))
	elseif var_5_3 > 0 then
		self.m_timeLimitTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(109599, {
			num = var_5_3
		}))
	elseif var_5_4 > 0 then
		self.m_timeLimitTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(109598, {
			num = var_5_4
		}))
	elseif var_5_5 > 0 then
		self.m_timeLimitTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(109598, {
			num = 1
		}))
	elseif var_5_5 == 0 then
		if self._limitTimeScheduler then
			self:cancelSchedule(self._limitTimeScheduler)

			self._limitTimeScheduler = nil
		end

		self:dispatchCompEvent("GiftTimeOut_CheckRefresh")
	end
end

function RechargeGiftCell:_refreshTime()
	local var_6_0

	if self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.DAILY then
		var_6_0 = var_0_3:getLeftHMSFormat((var_0_3:getTimestampByHMS(24, 0, 0)))
	elseif self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.WEEKLY then
		var_6_0 = var_0_3:getCurWeekCountDown()
	end

	if self.m_timeTxt then
		if var_6_0 then
			self.m_timeTxt:setText(var_6_0)
		else
			self.m_timeTxt:setText("")
		end
	end
end

return RechargeGiftCell
