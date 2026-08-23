local var_0_0 = g.core.model.User.hotSaleGMGiftData
local var_0_1 = g.core.const.ConstMgr.PushGiftConst
local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local RechargeGMPushGiftCell = class("RechargeGMPushGiftCell", require("app.fairyGUI.recharge.UI_RechargeGMPushGiftCell"))

function RechargeGMPushGiftCell:ctor()
	self._info = nil

	self:_initRegisterUI()
	self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)
end

function RechargeGMPushGiftCell:_initRegisterUI()
	self.m_popBtn:addClickListener(handler(self, self._onClick))
	self.m_awardBtn:addClickListener(handler(self, self._onClick))
end

function RechargeGMPushGiftCell:_onClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.recharge.view.RechargeGMGiftBuyPop").new(self._info))
end

function RechargeGMPushGiftCell:updateCell(arg_4_1)
	self._info = arg_4_1
	self._giftId = arg_4_1.id
	self._pushGiftInfo = var_0_0:getPushGiftInfo(arg_4_1.push_gift_id)
	self._contentInfo = var_0_0:getPushGiftContentInfo(arg_4_1.gift_id)

	self.m_item:setURL((g.core.common.Path:getRechargeIconById(self._pushGiftInfo.icon_id)))

	local var_4_0 = json.decode(self._contentInfo.name)

	if var_4_0 and var_4_0[MultilingualMgr:getUseLang()] then
		self.m_nameTxt:setText(var_4_0[MultilingualMgr:getUseLang()])
	else
		self.m_nameTxt:setText(g.core.lang:get(408326))
	end

	local var_4_1 = self._contentInfo.price == 0

	self.m_isFreeController:setSelectedIndex(self._contentInfo.price == 0 and 1 or 0)
	self.m_redPointComp:setId(var_4_1 and 714 or 1067)

	local var_4_2 = var_0_0:getGiftDiscountById(self._info.gift_id)

	self.m_discountTitle:setTitle(g.core.lang:get(307005, {
		num = var_4_2
	}))
	self.m_discountTitle:setVisible(var_4_2 ~= 100)

	if self._contentInfo then
		if self._contentInfo.buy_type == var_0_1.GOLD_TYPE then
			self.m_priceComp:setDiamond(self._contentInfo.price, self._contentInfo.original_price)
		elseif self._contentInfo.buy_type == var_0_1.GOLD_EXCHANGE_TYPE then
			self.m_priceComp:setGold(self._contentInfo.price, self._contentInfo.original_price)
		else
			local var_4_3 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.PUSH_GIFT, self._contentInfo.price)

			if var_4_3 then
				local var_4_4 = self._contentInfo.original_price

				if config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
					var_4_4 = g.core.model.User.rechargeData:safeCalPriceString(var_4_3.id, self._contentInfo.original_price / self._contentInfo.price, "*")
				end

				self.m_priceComp:setTitle(var_4_3.moneyUnit .. var_4_3.realMoney)
				self.m_priceComp:getChild("originNum"):setText(var_4_4)
			else
				self.m_priceComp:setVisible(false)
			end
		end
	end

	if g.core.common.ServerTime:getLeftSeconds(self._pushGiftInfo.activity_end_time) > 0 then
		if self._limitTimeScheduler then
			self:cancelSchedule(self._limitTimeScheduler)

			self._limitTimeScheduler = nil
		end

		self._limitTimeScheduler = self:newSchedule(handler(self, self._onRefreshEndBuyTime), 1)
	end

	self:_onRefreshEndBuyTime()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			id = self._giftId
		}
	})
	var_0_0:clearGMGiftNew(self._giftId)
end

function RechargeGMPushGiftCell:_onRefreshEndBuyTime()
	local var_5_0, var_5_1, var_5_2, var_5_3 = g.core.common.ServerTime:getLeftTimeParts(self._pushGiftInfo.activity_end_time)

	if var_5_0 > 0 then
		self.m_timeLimitTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(109600, {
			num = var_5_0
		}))
	elseif var_5_1 > 0 then
		self.m_timeLimitTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(109599, {
			num = var_5_1
		}))
	elseif var_5_2 > 0 then
		self.m_timeLimitTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(109598, {
			num = var_5_2
		}))
	elseif var_5_3 > 0 then
		self.m_timeLimitTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(109598, {
			num = 1
		}))
	elseif var_5_3 == 0 and self._limitTimeScheduler then
		self:cancelSchedule(self._limitTimeScheduler)

		self._limitTimeScheduler = nil
	end
end

return RechargeGMPushGiftCell
