local var_0_0 = g.core.const.ConstMgr.ShopConst
local var_0_1 = g.core.model.User.giftData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.model.User.activityReturnData
local ShopReleaseGiftPop = class("ShopReleaseGiftPop", require("app.fairyGUI.shop.UI_ShopReleaseGiftPop"), function()
	return fgui.GComponent:create({
		resName = "ShopReleaseGiftPop",
		pkgPath = "ui/shop/shop",
		pkgName = "shop"
	}, ...)
end)

function ShopReleaseGiftPop:ctor(arg_2_1)
	self:showAtCenter()

	if arg_2_1 and arg_2_1.activityInfo then
		self._actId = arg_2_1.activityInfo.sub_id or 0
	end

	self.m_closeBtn:setClickCallBack(nil)
	self.m_closePnl:addClickListener(handler(self, self.onClose))
	self.m_title:setText(g.core.model.User.releaseActivityData:getActivityReleaseDisplayCfg().gift_name)
	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onRenderGiftList))
end

function ShopReleaseGiftPop:_updateView()
	self._giftList = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.RELEASE_ACTIVITY, handler(self, self._filterActivityGift)) or {}

	if #self._giftList == 0 then
		g.core.model.User.giftData:refreshInTime()

		self._giftList = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.RELEASE_ACTIVITY, handler(self, self._filterActivityGift)) or {}
	end

	self.m_giftList:setNumItems(#self._giftList)
end

function ShopReleaseGiftPop:onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ShopReleaseGiftPop:_filterActivityGift(arg_5_1)
	return self._actId == arg_5_1.activity_id
end

function ShopReleaseGiftPop:_onRenderGiftList(arg_6_1, arg_6_2)
	if self._giftList and self._giftList[arg_6_1 + 1] then
		arg_6_2:updateCell(self._giftList[arg_6_1 + 1], true)
	end
end

function ShopReleaseGiftPop:onLoad()
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._recvChargeInfo), self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvGetRecharge), self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT, self._onCrossDayUpdate, self)
	self:_updateView()
	self.m_giftList:transitionShowCells("enter_left", 0.03, 1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ShangYue_Selected)
end

function ShopReleaseGiftPop:_recvChargeInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_4.gift and arg_8_4.gift.awards then
		var_0_3:awardSummary(arg_8_4.gift.awards)
		self.m_giftList:setNumItems(#self._giftList)
	end
end

function ShopReleaseGiftPop:_recvGetRecharge(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	var_0_3:tip(g.core.lang:get(1005))
	var_0_3:switchModuleIntelligent(g.view.entrance.HOME)
end

function ShopReleaseGiftPop:_onCrossDayUpdate()
	if not self:_isActivityReturnOpen() then
		var_0_3:tip(g.core.lang:get(1005))
		var_0_3:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	self:_updateView()
end

function ShopReleaseGiftPop:_isActivityReturnOpen()
	return var_0_4:isActivityOpen(self._actId)
end

return ShopReleaseGiftPop
