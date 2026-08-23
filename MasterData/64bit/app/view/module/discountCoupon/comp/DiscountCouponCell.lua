local DiscountCouponCell = class("DiscountCouponCell", require("app.fairyGUI.discountCoupon.UI_DiscountCouponCell"))
local var_0_1 = g.core.model.User.rechargeData
local var_0_3 = g.core.config.expirable_item_info
local MultilingualMgr = require("app.core.lang.MultilingualMgr")

function DiscountCouponCell:ctor(arg_1_1)
	self.m_BuyBtn:addClickListener(handler(self, self._onBuyClick))
end

function DiscountCouponCell:updateView(arg_2_1)
	self._data = arg_2_1
	self._endTime = arg_2_1.time
	self._rechargeInfo = var_0_1:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.LIMIT_TICKET, var_0_3.get(arg_2_1.value).item_value)

	self.m_moneyNum:setText(self._rechargeInfo.realMoney)
	self.m_moneyUnit:setText(self._rechargeInfo.moneyUnit)
	self.m_itemNum:setText(self._rechargeInfo.gold_recharge)
	self.m_BuyBtn:getChild("moneyText"):setText(g.core.lang:get(410200, {
		num = self._rechargeInfo.moneyUnit .. self._rechargeInfo.realMoney
	}))

	local var_2_0 = self._rechargeInfo.gold_recharge / 10

	self.m_discountNum:setText(self._rechargeInfo.money * 100 / self._rechargeInfo.gold_recharge)

	if config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
		var_2_0 = g.core.model.User.rechargeData:safeCalPriceString(self._rechargeInfo.id, self._rechargeInfo.gold_recharge / 10 / self._rechargeInfo.money, "*")

		local var_2_1 = MultilingualMgr:getUseLang()

		if var_2_1 ~= "cn" and var_2_1 ~= "tw" then
			self.m_discountNum:setText(100 - 10 * (self._rechargeInfo.money * 100 / self._rechargeInfo.gold_recharge) .. "%")
		end
	end

	self.m_BuyBtn:getChild("oldMoneyText"):setText(self._rechargeInfo.moneyUnit .. var_2_0)
	self:_onUpdateCountdown()

	if self._updateHandler then
		self:cancelSchedule(self._updateHandler)

		self._updateHandler = nil
	end

	self._updateHandler = self._updateHandler or self:newSchedule(handler(self, self._onUpdateCountdown), 1)

	local var_2_2 = MultilingualMgr:getUseLang()

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA or var_2_2 == "cn" or var_2_2 == "tw" then
		self.m_appTypeController:setSelectedIndex(0)
	else
		self.m_appTypeController:setSelectedIndex(1)
	end
end

function DiscountCouponCell:_onUpdateCountdown()
	self._leftTime = self._endTime - g.core.common.ServerTime:getTime()

	if self._leftTime >= 0 then
		self:_setTimeTxt()
	else
		if self._updateHandler then
			self:cancelSchedule(self._updateHandler)

			self._updateHandler = nil
		end

		self._leftTime = 0

		self:_skinTimeEnd()
	end
end

function DiscountCouponCell:_setTimeTxt()
	self.m_countDown:setText((g.core.common.ServerTime:getLeftDHMSFormat(self._endTime)))
end

function DiscountCouponCell:_skinTimeEnd()
	self.m_countDown:setText(g.core.lang:get(410201))
end

function DiscountCouponCell:_onBuyClick()
	if g.core.common.ServerTime:getLeftSeconds(self._endTime) > 0 then
		g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._rechargeInfo, self._data.onlyId, 0)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(410202))
	end
end

function DiscountCouponCell:playEff()
	self.m_enterTransition:play()
	self.m_enterEff:addEffectSpine({
		name = "eff_ui_discountCoupon_enter",
		isLoop = false,
		anim = "play",
		remove = true
	})
end

return DiscountCouponCell
