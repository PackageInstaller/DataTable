local ActivityPermanentRechargeGiftPop = class("ActivityPermanentRechargeGiftPop", require("app.fairyGUI.activity.UI_ActivityPermanentRechargeGiftPop"), function()
	return fgui.GComponent:create({
		resName = "ActivityPermanentRechargeGiftPop",
		pkgPath = "ui/activity/activity",
		pkgName = "activity"
	}, ...)
end)
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.lang
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.model.User.activityPermanentRechargeData

function ActivityPermanentRechargeGiftPop:ctor()
	self:showAtCenter()

	self._giftList = var_0_4:getGiftCanBuy()

	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onGiftListItemRender))
	self.m_closeBtn:addClickListener(handler(self, self._onCloseClick))
	self.m_enterTransition:play()

	self._nextStartTime = 0
	self._cdScheduler = nil

	self:_updateView()
end

function ActivityPermanentRechargeGiftPop:_onBuyDiamondGift(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_3_4.awards or {}, nil, nil, g.core.lang:get(300001))
	end

	self:_onRefreshGifts()
end

function ActivityPermanentRechargeGiftPop:_onBuyCashGift(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_4_4.awards or {}, nil, nil, g.core.lang:get(300001))
	end

	self:_onRefreshGifts()
	self:dispatchCompEvent("update_light_size")
end

function ActivityPermanentRechargeGiftPop:_updateView()
	self.m_giftList:setNumItems(#self._giftList)
	self.m_giftList:transitionShowCells("enter_left", 0.03)
	self:_refreshCountDown()
end

function ActivityPermanentRechargeGiftPop:_onRefreshGifts()
	self._giftList = var_0_4:getGiftCanBuy()

	self.m_giftList:setNumItems(#self._giftList)

	if #self._giftList == 0 then
		self:_onCloseClick()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function ActivityPermanentRechargeGiftPop:_refreshCountDown()
	local var_7_0 = var_0_4:getNextStartTime()

	if var_7_0 ~= 0 then
		self._nextStartTime = var_7_0

		if var_0_1:getLeftTimeParts(self._nextStartTime) < 7 and not self._cdScheduler then
			self._cdScheduler = g.core.common.Scheduler:newSchedule(handler(self, self._updateCD), 1)
		end
	elseif self._cdScheduler then
		g.core.common.Scheduler:cancelSchedule(self._cdScheduler)

		self._cdScheduler = nil
	end
end

function ActivityPermanentRechargeGiftPop:onLoad()
	var_0_3:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_BUYRECHARGEREBATEGIFT, handler(self, self._onBuyDiamondGift), self)
	var_0_3:addEventListener(g.core.event.enum.EVENT_PERMANENT_RECHARGE_SHOW_GIFTS, handler(self, self._onBuyCashGift), self)
	var_0_3:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_UPDATERECHARGEREBATEGMINFO, handler(self, self._updateView), self)
	var_0_3:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onRefreshGifts), self)
	var_0_3:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGEREBATEINFO, handler(self, self._onRefreshGifts), self)
	var_0_3:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_EXCHANGE, handler(self, self._updateView), self)
	self:_refreshCountDown()
end

function ActivityPermanentRechargeGiftPop:_onGiftListItemRender(arg_9_1, arg_9_2)
	arg_9_2:updateView(self._giftList[arg_9_1 + 1])
end

function ActivityPermanentRechargeGiftPop:_onCloseClick()
	var_0_4:setGiftInfo()
	self:dispatchCompEvent("refresh_giftBtn")
	self.m_backTransition:play()
end

function ActivityPermanentRechargeGiftPop:_updateCD()
	self._nextStartTime = self._nextStartTime or var_0_4:getNextStartTime()

	local var_11_0, var_11_1, var_11_2, var_11_3 = var_0_1:getLeftTimeParts(self._nextStartTime)
	local var_11_4 = var_11_0 > 1 and var_0_1:getLeftDHMFormat(self._nextStartTime) or var_0_1:getLeftHMSFormat(self._nextStartTime)

	if var_0_1:getLeftSeconds(self._nextStartTime) <= 0 or self._nextStartTime == 0 then
		if self._cdScheduler then
			g.core.common.Scheduler:cancelSchedule(self._cdScheduler)

			self._cdScheduler = nil
		end

		self.m_timeTxt:setVisible(false)
		g.core.network.GameNetProxy:send_C2S_Recharge_GetRechargeRebateInfo({})
	else
		self.m_timeTxt:setText(var_0_2:get(408303) .. var_11_4)
		self.m_timeTxt:setVisible(true)
	end
end

function ActivityPermanentRechargeGiftPop:onUnload()
	if self._cdScheduler then
		g.core.common.Scheduler:cancelSchedule(self._cdScheduler)

		self._cdScheduler = nil
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_PERMANENT_RECHARGE_REFRESH_TAB)
end

return ActivityPermanentRechargeGiftPop
