local var_0_0 = g.core.model.User
local var_0_1 = g.core.const.ConstMgr.ActivityConst
local var_0_2 = g.core.model.User.activityDailyBoxData
local ActivityDailyBoxCell = class("ActivityDailyBoxCell", require("app.fairyGUI.activity.UI_ActivityDailyBoxCell"))

function ActivityDailyBoxCell:ctor()
	self._chargeData = {}
	self._isFree = false
	self._isHasBuy = false
	self._isWeekCardValid = false

	self.m_buyTouch:addClickListener(handler(self, self._onClickBuy))
	self.m_viewTouch:addClickListener(handler(self, self._onClickViewGift))
end

function ActivityDailyBoxCell:onLoad()
	return
end

function ActivityDailyBoxCell:updateGift(arg_3_1, arg_3_2)
	self._chargeData = arg_3_1

	local var_3_0 = self._chargeData.info
	local var_3_1 = self._chargeData.chargeInfo

	self._isFree = self._chargeData.info.type == var_0_1.DAILY_BOX_GIFT_TYPE.FREE

	self.m_isFreeController:setSelectedIndex(self._isFree and 0 or 1)

	self._isHasBuy = self._chargeData.isBuy

	self.m_isBuyController:setSelectedIndex(self._isHasBuy and 1 or 0)

	self._isWeekCardValid = var_0_2:isWeekCardValid()

	self.m_hasWeekCardController:setSelectedIndex(self._isWeekCardValid and 1 or 0)
	self.m_redPointComp:setId(0)

	if self._isFree then
		self.m_redPointComp:setId(215)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})

	if not self._isFree and not self._isHasBuy then
		self.m_giftPrice:setText(var_3_1.realMoney or "")
		self.m_priceSign:setText(var_3_1.moneyUnit or "")
	end

	self.m_discountTxt:setText(var_3_0.off .. "%")
	self.m_giftName:setText(var_3_0.name)
	self.m_giftNum:setText("0" .. arg_3_2)
	self.m_giftIcon:setURL(g.core.common.Path:getActivityDailyGiftIconById(var_3_0.res))
end

function ActivityDailyBoxCell:_onClickBuy()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.CLICK_ENTER)

	if (false or nil) and true then
		g.core.network.GameNetProxy:send_C2S_Recharge_GetFreeDailySaleAward({
			id = self._chargeData.info.id
		})
	else
		local var_4_1 = var_0_0.activityDailyBoxData:convertChargeInfo(self._chargeData.info)

		var_4_1.buyTimes = 0

		if self._isHasBuy then
			var_4_1.buyTimes = 1
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.module.recharge.view.RechargeGiftPop").new(var_4_1))
	end
end

function ActivityDailyBoxCell:_onClickViewGift()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.CLICK_ENTER)

	local var_5_0 = var_0_2:convertChargeInfo(self._chargeData.info)

	if (false or nil) and true then
		if var_5_0.recharge_money > 0 then
			var_5_0.forceShowReceive = true
			var_5_0.clickCall = handler(self, function()
				g.core.network.GameNetProxy:send_C2S_Recharge_GetFreeDailySaleAward({
					id = self._chargeData.info.id
				})
			end)
		else
			var_5_0.freeCallBack = handler(self, function()
				g.core.network.GameNetProxy:send_C2S_Recharge_GetFreeDailySaleAward({
					id = self._chargeData.info.id
				})
			end)
		end
	end

	var_5_0.buyTimes = 0

	if self._isHasBuy then
		var_5_0.buyTimes = 1
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.recharge.view.RechargeGiftPop").new(var_5_0))
end

return ActivityDailyBoxCell
