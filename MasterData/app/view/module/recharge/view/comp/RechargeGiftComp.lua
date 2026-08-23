local var_0_0 = g.core.model.User
local var_0_1 = g.core.const.ConstMgr.ShopConst
local RechargeGiftComp = class("RechargeGiftComp", require("app.fairyGUI.recharge.UI_RechargeGiftComp"))

function RechargeGiftComp:ctor()
	self._info = nil
	self._giftList = nil
	self._lastScrollPos = 0

	self:addListen(self.m_giftList)
	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onGiftsListRender))
end

function RechargeGiftComp:_onGiftsListRender(arg_2_1, arg_2_2)
	if self._giftList and self._giftList[arg_2_1 + 1] then
		arg_2_2:updateCell(self._giftList[arg_2_1 + 1], true)
	end
end

function RechargeGiftComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._recvChargeInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvGetRecharge), self)
end

function RechargeGiftComp:updateComp(arg_4_1)
	self._info = arg_4_1.info

	self.m_nameTxt:setText(self._info.type_name)

	if self._info.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WEDDING_ACTIVITY or self._info.shop_first == g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.SUCCUBA_LAUNCH then
		g.core.model.User.functionUnlockData:saveUnlockedFunc(self._info.function_id)
	end

	self:_updateList()
end

function RechargeGiftComp:_updateList()
	self._giftList = var_0_0.giftData:getGiftListByShopTypeValue(self._info.shop_type, self._info.shop_first) or {}

	if not self._hasUpdate then
		self:newScheduleOnce(handler(self, self._updateGiftList), 0.1)

		self._hasUpdate = true
	else
		self:_updateGiftList()
	end
end

function RechargeGiftComp:_updateGiftList()
	self.m_giftList:setNumItems(0)
	self.m_giftList:setNumItems(#self._giftList)
	self.m_giftList:transitionShowCells("enter_left", 0.03, 1)

	if self._lastScrollPos > 0 then
		self.m_giftList:getScrollPane():setPosX(self._lastScrollPos)
	end

	self.m_isEmptyController:setSelectedIndex(#self._giftList == 0 and 1 or 0)
end

function RechargeGiftComp:_recvChargeInfo(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4.gift and arg_7_4.gift.awards and self:isVisible() then
		g.core.module.ModuleManager:awardSummary(arg_7_4.gift.awards)
		self.m_giftList:setNumItems(#self._giftList)
		self.m_isEmptyController:setSelectedIndex(#self._giftList == 0 and 1 or 0)
		self:checkGiftOpenState()
	end
end

function RechargeGiftComp:onUnload()
	self._lastScrollPos = self.m_giftList:getScrollPane():getPosX()
end

function RechargeGiftComp:_recvGetRecharge(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if self:isVisible() and not self:checkGiftOpenState() then
		self:_updateList()
	end
end

function RechargeGiftComp:receiveCompEvent(arg_10_1, arg_10_2)
	if arg_10_1 == "GiftTimeOut_CheckRefresh" and not self:checkGiftOpenState() then
		self._giftList = var_0_0.giftData:getGiftListByShopTypeValue(self._info.shop_type, self._info.shop_first) or {}

		self.m_giftList:setNumItems(#self._giftList)
		self.m_isEmptyController:setSelectedIndex(#self._giftList == 0 and 1 or 0)
	end
end

function RechargeGiftComp:checkGiftOpenState()
	if var_0_1.SHOP_TYPE.GIFT == self._info.shop_type and var_0_1.RECHARGE_HOT_VALUE.HOT_KNIGHT == self._info.shop_first and not var_0_0.giftData:isLimitStartGiftShow() then
		self:dispatchCompEvent(var_0_1.SHOP_EVENT_GO_TO, {
			tabType = var_0_1.SHOP_INFO_TAB_TYPE.GIFT_TAB_TYPE,
			shopType = var_0_1.SHOP_TYPE.GIFT
		})

		return true
	end

	return false
end

return RechargeGiftComp
