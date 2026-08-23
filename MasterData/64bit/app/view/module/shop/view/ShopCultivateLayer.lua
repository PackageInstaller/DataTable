local var_0_0 = g.core.const.ConstMgr.ShopConst
local var_0_1 = g.core.model.User.cultivateDataMgr
local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_3 = g.core.common.Path
local ShopCultivateLayer = class("ShopCultivateLayer", require("app.fairyGUI.shop.UI_ShopCultivateLayer"), function()
	return fgui.GComponent:create({
		pkgName = "shop",
		isFullScreen = true,
		pkgPath = "ui/shop/shop",
		resName = "ShopCultivateLayer"
	}, ...)
end)

function ShopCultivateLayer:ctor(arg_2_1)
	self._actId = type(arg_2_1) ~= "table" and arg_2_1 or arg_2_1.route1
	self._actData = var_0_1:getCultivateData(self._actId)
	self._shopShowParam = nil
	self._shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.CULTIVATE
	self._shopTabType = var_0_0.SHOP_INFO_TAB_TYPE.CULTIVATE_TYPE
	self._shopFirst = self._actId
	self._uiShopName = nil

	self:initShopTheme()
end

function ShopCultivateLayer:onLoad()
	self:_initRegisterMSG()
	self:_refreshShopItem()
	self.m_enterTransition:play()
end

function ShopCultivateLayer:onUnload()
	g.core.model.User.themeData:redDoNewShopScoreOpen(self._shopType, self._shopFirst)
end

function ShopCultivateLayer:initShopTheme()
	self:_initShopThemeData()
	self:_initShopThemeUI()
end

function ShopCultivateLayer:_initShopThemeData()
	self._shopShowParam = nil

	for iter_6_0, iter_6_1 in pairs(g.core.model.User.shopData:getShopInfoGroup()[self._shopTabType][self._shopType]) do
		if iter_6_1.shop_first == self._shopFirst then
			self._uiShopName = self._uiShopName or iter_6_1.tab_name

			self:_addToOpenShopPage(iter_6_1)
		end
	end
end

function ShopCultivateLayer:_initShopThemeUI()
	local var_7_0 = g.core.config.cultivate_activity_display_info.get(self._actId)

	self.m_topBarComp:setResInfoById(var_7_0.interface_shop)
	self.m_topBarComp:setTitle(var_7_0.module_shop)
	self:addBg("bg/cultivate/" .. self._actId .. "/bg_shop.jpg")
	self.m_titleLoader:setURL(var_0_3:getCultivateMulLangImage("txt_shop", self._actId))
	self.m_timeDiGraph:setColor(cc.c3b(CultivateConst.hexToRgb(var_7_0.color_time)))
	self:updatePassCardTime()
end

function ShopCultivateLayer:updatePassCardTime()
	local var_8_0, var_8_1, var_8_2, var_8_3 = g.core.common.ServerTime:getLeftTimeParts((self._actData:getExpireTime()))

	self.m_timeTxt:setText(g.core.lang:get(421407, {
		day = var_8_0,
		hour = var_8_1
	}))
end

function ShopCultivateLayer:_initRegisterMSG()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
end

function ShopCultivateLayer:_refreshShopItem()
	if self._shopShowParam == nil then
		return
	end

	self._shopShowParam.hideAll = true
	self._shopShowParam.bgStyle = 1

	self.m_childComp:updateComp(self._shopShowParam)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ShangYue_Selected)
end

function ShopCultivateLayer:_checkShopIsOpen(arg_11_1)
	return (arg_11_1.function_id ~= 0 or nil) and g.core.common.ModuleUnlock:isModuleUnlock(arg_11_1.function_id, nil, true) and g.core.model.User.shopData:checkShopOpen(arg_11_1.shop_type, arg_11_1.shop_first)
end

function ShopCultivateLayer:_addToOpenShopPage(arg_12_1)
	if not self:_checkShopIsOpen(arg_12_1) then
		return
	end

	if not self._shopShowParam then
		self._shopShowParam = {}
		self._shopShowParam.info = arg_12_1
	end

	if arg_12_1.shop_second > 0 then
		self._shopShowParam.subInfo = self._shopShowParam.subInfo or {}

		table.insert(self._shopShowParam.subInfo, arg_12_1)
	end
end

function ShopCultivateLayer:_onCrossDayUpdate()
	self:_refreshShopItem()

	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	if self._actId then
		g.core.network.GameNetProxy:send_C2S_CultivateActivity_GetInfo({
			activity_id = self._actId
		})
	end
end

return ShopCultivateLayer
