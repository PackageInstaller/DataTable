local var_0_0 = g.core.const.ConstMgr.ShopConst
local var_0_1 = g.core.model.User.giftData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.const.ConstMgr.AnniversaryConst
local var_0_5 = g.core.model.User.anniversaryData
local AnniversaryGiftPop = class("AnniversaryGiftPop", require("app.fairyGUI.anniversary.UI_AnniversaryGiftPop"), function()
	return fgui.GComponent:create({
		resName = "AnniversaryGiftPop",
		pkgPath = "ui/anniversary/anniversary",
		pkgName = "anniversary"
	}, ...)
end)

function AnniversaryGiftPop:ctor(arg_2_1)
	self:showAtCenter()

	self._activityOpenCheckFunc = arg_2_1.openCheckFunc
	self._activityValue = arg_2_1.activityValue
	self._shopValue = arg_2_1.shopValue
	self._giftList = {}

	dump(self._activityValue, "self._activityValue")
	self.m_closeBtn:setClickCallBack(nil)
	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onRenderGiftList))
	self.m_bg:setURL(var_0_5:getActivityResource("ui_cocos", "bg_xmhy_libaodikuang.png"))
	self.m_title:setURL(var_0_5:getActivityResource("pic", "txt_xmhy_shangyue.png"))
end

function AnniversaryGiftPop:_updateView(arg_3_1)
	self._giftList = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, self._shopValue, handler(self, self._filterActivityGift)) or {}

	if self._giftList == nil or #self._giftList < 1 then
		self._giftList = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, self._shopValue, handler(self, self._filterActivityGift))
	end

	self.m_giftList:setNumItems(#self._giftList)

	if arg_3_1 then
		self.m_giftList:transitionShowCells("enter_left", 0.03)
	end
end

function AnniversaryGiftPop:_filterActivityGift(arg_4_1)
	return self._activityValue == arg_4_1.activity_id
end

function AnniversaryGiftPop:_onRenderGiftList(arg_5_1, arg_5_2)
	if self._giftList and self._giftList[arg_5_1 + 1] then
		arg_5_2:updateCell(self._giftList[arg_5_1 + 1], true)
		arg_5_2:getChild("bg"):setURL(var_0_5:getActivityResource("ui_cocos", "bg_xmhy_libao_di.png"))
		arg_5_2:getChild("zhezhao"):setURL(var_0_5:getActivityResource("ui_cocos", "bg_xmhy_libao_di_zhezhao.png"))
		arg_5_2:getChild("nameTxt"):setColor(var_0_4.hexToRgb(var_0_5:getAnniversaryInfo().biz_color))
	end
end

function AnniversaryGiftPop:onLoad()
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._recvChargeInfo), self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvGetRecharge), self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	self:_updateView(true)
	self.m_enterTransition:play()
end

function AnniversaryGiftPop:onUnload()
	return
end

function AnniversaryGiftPop:_recvChargeInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_4.gift and arg_8_4.gift.awards then
		var_0_3:awardSummary(arg_8_4.gift.awards)
		self.m_giftList:setNumItems(#self._giftList)
	end

	if not self:_isActivityOpen() then
		var_0_3:tip(g.core.lang:get(1005))
		var_0_3:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function AnniversaryGiftPop:_recvGetRecharge(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if self:_isActivityOpen() then
		g.core.model.User.giftData:refreshInTime()
		self:_updateView()
	else
		var_0_3:tip(g.core.lang:get(1005))
		var_0_3:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function AnniversaryGiftPop:_onCrossDayUpdate()
	if not self:_isActivityOpen() then
		var_0_3:tip(g.core.lang:get(1005))
		var_0_3:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	if not var_0_5:isInActivityGameTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	g.core.model.User.giftData:refreshInTime()
	self:_updateView()
end

function AnniversaryGiftPop:_isActivityOpen()
	if self._activityOpenCheckFunc then
		return self._activityOpenCheckFunc()
	end

	return false
end

return AnniversaryGiftPop
