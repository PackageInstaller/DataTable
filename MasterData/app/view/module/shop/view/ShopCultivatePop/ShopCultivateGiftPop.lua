local var_0_0 = g.core.const.ConstMgr.ShopConst
local var_0_1 = g.core.model.User.giftData
local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_3 = g.core.common.Path
local var_0_4 = g.core.event.EventManager
local var_0_5 = g.core.model.User.cultivateDataMgr
local var_0_6 = g.core.module.ModuleManager
local ShopCultivateGiftPop = class("ShopCultivateGiftPop", require("app.fairyGUI.shop.UI_ShopCultivateGiftPop"), function()
	return fgui.GComponent:create({
		resName = "ShopCultivateGiftPop",
		pkgPath = "ui/shop/shop",
		pkgName = "shop"
	}, ...)
end)

function ShopCultivateGiftPop:ctor(arg_2_1)
	self:showAtCenter()

	self._actId = type(arg_2_1) == "table" and arg_2_1.route1 or arg_2_1

	self.m_closeBtn:setClickCallBack(nil)
	self.m_closePnl:addClickListener(handler(self, self.onClose))
	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onRenderGiftList))
end

function ShopCultivateGiftPop:_updateView()
	local var_3_0 = var_0_0.SHOP_GIFT_VALUE.CULTIVATE_GIFT

	self._actData = var_0_5:getCultivateData(self._actId)

	if self._actData:isWitchActivity() then
		var_3_0 = var_0_0.SHOP_GIFT_VALUE.WITCH_CULTIVATE_GIFT
	end

	self._giftList = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, var_3_0, handler(self, self._filterActivityGift)) or {}

	if #self._giftList == 0 then
		g.core.model.User.giftData:refreshInTime()

		self._giftList = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, var_3_0, handler(self, self._filterActivityGift)) or {}
	end

	self.m_giftList:setNumItems(#self._giftList)
	self.m_isWitchController:setSelectedIndex(self._actData:isWitchActivity() and 1 or 0)

	if self._actData:isWitchActivity() then
		self.m_titleLoader:setURL(var_0_3:getCultivateMulLangImage("txt_mnzj_shangyue", var_0_5:getResDirId(self._actData:getActivityCfg().id)))
	end
end

function ShopCultivateGiftPop:onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ShopCultivateGiftPop:_filterActivityGift(arg_5_1)
	return self._actId == arg_5_1.activity_id
end

function ShopCultivateGiftPop:_onRenderGiftList(arg_6_1, arg_6_2)
	if self._giftList and self._giftList[arg_6_1 + 1] then
		arg_6_2:updateCell(self._giftList[arg_6_1 + 1], true)
		arg_6_2:updateCellItemByAct(self._actId)
	end
end

function ShopCultivateGiftPop:onLoad()
	var_0_4:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._recvChargeInfo), self)
	var_0_4:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvGetRecharge), self)
	var_0_4:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT, self._onCrossDayUpdate, self)
	self:_updateView()
	self.m_giftList:transitionShowCells("enter_left", 0.03, 1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ShangYue_Selected)
end

function ShopCultivateGiftPop:onUnload()
	return
end

function ShopCultivateGiftPop:_recvChargeInfo(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_4.gift and arg_9_4.gift.awards then
		var_0_6:awardSummary(arg_9_4.gift.awards)
		self.m_giftList:setNumItems(#self._giftList)
	end

	if not self:_isCultivateOpen() then
		var_0_6:tip(g.core.lang:get(1005))
		var_0_6:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function ShopCultivateGiftPop:_recvGetRecharge(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if self:_isCultivateOpen() then
		self:_updateView()
	else
		var_0_6:tip(g.core.lang:get(1005))
		var_0_6:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function ShopCultivateGiftPop:_onCrossDayUpdate()
	if not self:_isCultivateOpen() then
		var_0_6:tip(g.core.lang:get(1005))
		var_0_6:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	self:_updateView()
end

function ShopCultivateGiftPop:_isCultivateOpen()
	return var_0_5:isActivityOpen(self._actId)
end

return ShopCultivateGiftPop
