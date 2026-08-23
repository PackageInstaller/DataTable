local var_0_0 = g.core.const.ConstMgr.ShopConst
local var_0_1 = g.core.model.User.giftData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.model.User.themeData
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = g.core.config.activity_theme_display_info
local ShopThemeGiftPop = class("ShopThemeGiftPop", require("app.fairyGUI.shop.UI_ShopThemeGiftPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/shop/shop",
		resName = "ShopThemeGiftPop",
		pkgName = "shop"
	}, ...)
end)

function ShopThemeGiftPop:ctor(arg_2_1)
	self:showAtCenter()

	self._activityValue = arg_2_1.activityValue
	self._activityValues = arg_2_1.activityValues

	if self._activityValues then
		self._activityValueSet = {}

		for iter_2_0, iter_2_1 in ipairs(self._activityValues) do
			self._activityValueSet[iter_2_1] = true
		end
	end

	self._summerThemeData = var_0_3:getThemeData(self._activityValue)
	self._displayInfo = var_0_5.fetch(self._activityValue) or {}

	self.m_title:setText(self._displayInfo.gift_name)

	self._giftList = {}

	self.m_closeBtn:setClickCallBack(nil)
	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onRenderGiftList))
end

function ShopThemeGiftPop:_updateView()
	self._giftList = var_0_1:getGiftListByShopTypeValue(var_0_0.SHOP_TYPE.GIFT, var_0_0.SHOP_GIFT_VALUE.THEME_GIFT, handler(self, self._filterActivityGift)) or {}

	self.m_giftList:setNumItems(#self._giftList)
end

function ShopThemeGiftPop:_filterActivityGift(arg_4_1)
	if self._activityValueSet then
		return self._activityValueSet[arg_4_1.activity_id] == true
	end

	return self._activityValue == arg_4_1.activity_id
end

function ShopThemeGiftPop:_onRenderGiftList(arg_5_1, arg_5_2)
	if self._giftList and self._giftList[arg_5_1 + 1] then
		arg_5_2:updateCell(self._giftList[arg_5_1 + 1], true)
	end
end

function ShopThemeGiftPop:onLoad()
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._recvChargeInfo), self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvGetRecharge), self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	self:_updateView()
	self.m_giftList:transitionShowCells("enter_left", 0.03, 1)
end

function ShopThemeGiftPop:onUnload()
	return
end

function ShopThemeGiftPop:_recvChargeInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_4.gift and arg_8_4.gift.awards then
		var_0_4:awardSummary(arg_8_4.gift.awards)
		self.m_giftList:setNumItems(#self._giftList)
	end

	if not self:_isThemeOpen() then
		var_0_4:tip(g.core.lang:get(1005))
		var_0_4:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function ShopThemeGiftPop:_recvGetRecharge(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if self:_isThemeOpen() then
		self:_updateView()
	else
		var_0_4:tip(g.core.lang:get(1005))
		var_0_4:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function ShopThemeGiftPop:_onCrossDayUpdate()
	if not self:_isThemeOpen() then
		var_0_4:tip(g.core.lang:get(1005))
		var_0_4:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	self:_updateView()
end

function ShopThemeGiftPop:_isThemeOpen()
	if self._activityValues then
		for iter_11_0, iter_11_1 in ipairs(self._activityValues) do
			local var_11_0 = var_0_3:getThemeData(iter_11_1)

			if var_11_0 and var_11_0:isThemeActiveOpen() then
				return true
			end
		end

		return false
	end

	return self._summerThemeData:isThemeActiveOpen()
end

return ShopThemeGiftPop
