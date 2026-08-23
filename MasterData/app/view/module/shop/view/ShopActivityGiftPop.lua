local var_0_0 = g.core.const.ConstMgr.ShopConst
local var_0_1 = g.core.model.User.giftData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.module.ModuleManager
local ShopActivityGiftPop = class("ShopActivityGiftPop", require("app.fairyGUI.shop.UI_ShopActivityGiftPop"), function()
	return fgui.GComponent:create({
		resName = "ShopActivityGiftPop",
		pkgPath = "ui/shop/shop",
		pkgName = "shop"
	}, ...)
end)

function ShopActivityGiftPop:ctor(arg_2_1)
	self:showAtCenter()

	self._activityOpenCheckFunc = arg_2_1.openCheckFunc
	self._activityValue = arg_2_1.activityValue
	self._shopValue = arg_2_1.shopValue

	self.m_title:setText(arg_2_1.title)

	self._giftList = {}

	self.m_closeBtn:setClickCallBack(nil)
	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onRenderGiftList))
end

function ShopActivityGiftPop:_updateView()
	self._giftList = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, self._shopValue, handler(self, self._filterActivityGift)) or {}

	self.m_giftList:setNumItems(#self._giftList)
end

function ShopActivityGiftPop:_filterActivityGift(arg_4_1)
	return self._activityValue == arg_4_1.activity_id
end

function ShopActivityGiftPop:_onRenderGiftList(arg_5_1, arg_5_2)
	if self._giftList and self._giftList[arg_5_1 + 1] then
		arg_5_2:updateCell(self._giftList[arg_5_1 + 1], true)
	end
end

function ShopActivityGiftPop:onLoad()
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._recvChargeInfo), self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvGetRecharge), self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	self:_updateView()
	self.m_giftList:transitionShowCells("enter_left", 0.03, 1)
end

function ShopActivityGiftPop:onUnload()
	return
end

function ShopActivityGiftPop:_recvChargeInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_4.gift and arg_8_4.gift.awards then
		var_0_3:awardSummary(arg_8_4.gift.awards)
		self.m_giftList:setNumItems(#self._giftList)
	end

	if not self:_isActivityOpen() then
		var_0_3:tip(g.core.lang:get(1005))
		var_0_3:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function ShopActivityGiftPop:_recvGetRecharge(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if self:_isActivityOpen() then
		self:_updateView()
	else
		var_0_3:tip(g.core.lang:get(1005))
		var_0_3:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function ShopActivityGiftPop:_onCrossDayUpdate()
	if not self:_isActivityOpen() then
		var_0_3:tip(g.core.lang:get(1005))
		var_0_3:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	self:_updateView()
end

function ShopActivityGiftPop:_isActivityOpen()
	if self._activityOpenCheckFunc then
		return self._activityOpenCheckFunc()
	end

	return false
end

return ShopActivityGiftPop
