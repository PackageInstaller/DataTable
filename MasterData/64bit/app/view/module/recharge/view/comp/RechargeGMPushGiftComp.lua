local var_0_0 = g.core.model.User.hotSaleGMGiftData
local RechargeGMPushGiftComp = class("RechargeGMPushGiftComp", require("app.fairyGUI.recharge.UI_RechargeGMPushGiftComp"))

function RechargeGMPushGiftComp:ctor()
	self._gmGiftList = {}

	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onGiftsListRender))
	self:addListen(self.m_giftList)
end

function RechargeGMPushGiftComp:_onGiftsListRender(arg_2_1, arg_2_2)
	if self._gmGiftList[arg_2_1 + 1] then
		arg_2_2:updateCell(self._gmGiftList[arg_2_1 + 1])
	end
end

function RechargeGMPushGiftComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onS2CRehargeOp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvS2CGetReharge), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_BUY, handler(self, self.checkGiftOpenState), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_AWARD, handler(self, self.checkGiftOpenState), self)
end

function RechargeGMPushGiftComp:updateComp()
	self.m_nameTxt:setText(g.core.lang:get(1300))
	self:_updateGiftList()
end

function RechargeGMPushGiftComp:_updateGiftList()
	self._gmGiftList = var_0_0:getGMPushGiftArray()

	self.m_giftList:setNumItems(#self._gmGiftList)
	self.m_giftList:transitionShowCells("enter_left", 0.03, 1)
end

function RechargeGMPushGiftComp:_onS2CRehargeOp(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4.gift and arg_6_4.gift.awards and self:isVisible() then
		g.core.module.ModuleManager:awardSummary(arg_6_4.gift.awards)
		self:_updateGiftList()
	end
end

function RechargeGMPushGiftComp:_recvS2CGetReharge()
	self:checkGiftOpenState()
end

function RechargeGMPushGiftComp:checkGiftOpenState()
	if not self:isVisible() then
		return false
	end

	if not var_0_0:isShowHotSaleGMGiftTab() then
		self:dispatchCompEvent(g.core.const.ConstMgr.ShopConst.SHOP_EVENT_GO_TO, {
			tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.GIFT_TAB_TYPE,
			shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.GIFT
		})

		return true
	else
		self:_updateGiftList()

		return false
	end
end

return RechargeGMPushGiftComp
