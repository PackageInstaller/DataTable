local var_0_0 = g.core.const.ConstMgr.ShopConst
local var_0_1 = g.core.model.User.giftData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.model.User.retroData
local var_0_4 = g.core.module.ModuleManager
local RechargeRetroGiftPop = class("RechargeRetroGiftPop", require("app.fairyGUI.recharge.UI_RechargeRetroGiftPop"), function()
	return fgui.GComponent:create({
		pkgName = "recharge",
		resName = "RechargeRetroGiftPop",
		pkgPath = "ui/recharge/recharge"
	}, ...)
end)

function RechargeRetroGiftPop:ctor(arg_2_1)
	self:showAtCenter()

	self._actId = type(arg_2_1) == "table" and arg_2_1.route1 or arg_2_1

	self.m_title:setText(var_0_3:getRetroDisplayInfo().gift_name)
	self.m_closeBtn:setClickCallBack(nil)
	self.m_closePnl:addClickListener(handler(self, self.onClose))
	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onRenderGiftList))
end

function RechargeRetroGiftPop:_updateView()
	self._giftList = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.RETRO_GIFT, handler(self, self._filterActivityGift)) or {}

	if #self._giftList == 0 then
		g.core.model.User.giftData:refreshInTime()

		self._giftList = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.RETRO_GIFT, handler(self, self._filterActivityGift)) or {}
	end

	self.m_giftList:setNumItems(#self._giftList)
end

function RechargeRetroGiftPop:onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function RechargeRetroGiftPop:_filterActivityGift(arg_5_1)
	return self._actId == arg_5_1.activity_id
end

function RechargeRetroGiftPop:_onRenderGiftList(arg_6_1, arg_6_2)
	if self._giftList and self._giftList[arg_6_1 + 1] then
		arg_6_2:updateCell(self._giftList[arg_6_1 + 1], true)
	end
end

function RechargeRetroGiftPop:onLoad()
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._recvChargeInfo), self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvGetRecharge), self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT, handler(self, self._onCrossDayUpdate), self)
	self:_updateView()
	self.m_giftList:transitionShowCells("enter_left", 0.03, 1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ShangYue_Selected)
end

function RechargeRetroGiftPop:_recvChargeInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_4.gift and arg_8_4.gift.awards then
		var_0_4:awardSummary(arg_8_4.gift.awards)
		self.m_giftList:setNumItems(#self._giftList)
	end

	if not self:_isActRetroOpen() then
		var_0_4:tip(g.core.lang:get(1005))
		var_0_4:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function RechargeRetroGiftPop:_recvGetRecharge(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if self:_isActRetroOpen() then
		self:_updateView()
	else
		var_0_4:tip(g.core.lang:get(1005))
		var_0_4:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function RechargeRetroGiftPop:onUnload()
	var_0_2:removeListenerWithTarget(self)
end

function RechargeRetroGiftPop:_onCrossDayUpdate()
	if not self:_isActRetroOpen() then
		var_0_4:tip(g.core.lang:get(1005))
		var_0_4:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	self:_updateView()
end

function RechargeRetroGiftPop:_isActRetroOpen()
	return var_0_3:isActOpen(self._actId)
end

return RechargeRetroGiftPop
