local DrawKnight = require("app.view.common.DrawKnight")
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.model.User.shopData
local var_0_3 = g.core.model.User.gveDataMgr
local ShopGveLayer = class("ShopGveLayer", require("app.fairyGUI.shop.UI_ShopGveLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/shop/shop",
		resName = "ShopGveLayer",
		pkgName = "shop",
		isFullScreen = true
	})
end)

function ShopGveLayer:ctor(arg_2_1)
	self._shopTabType = 8
	self._shopType = 34
	self._shopFirst = var_0_3:getGveBaseCfg().shop_group
	self._shopShowParam = nil
	self._uiShopName = nil

	self:initShopGve()
end

function ShopGveLayer:initShopGve()
	self:_initGveShopData()
	self:_initShopGveUI()
	self.m_enterTransition:play()
end

function ShopGveLayer:_initGveShopData()
	self._shopShowParam = nil

	for iter_4_0, iter_4_1 in pairs(var_0_2:getShopInfoGroup()[self._shopTabType][self._shopType]) do
		if iter_4_1.shop_first == self._shopFirst then
			self._uiShopName = self._uiShopName or iter_4_1.tab_name

			self:_addToOpenShopPage(iter_4_1)
		end
	end
end

function ShopGveLayer:_addToOpenShopPage(arg_5_1)
	if not self:_checkShopIsOpen(arg_5_1) then
		return
	end

	if not self._shopShowParam then
		self._shopShowParam = {}
		self._shopShowParam.info = arg_5_1
	end

	if arg_5_1.shop_second > 0 then
		self._shopShowParam.subInfo = self._shopShowParam.subInfo or {}

		table.insert(self._shopShowParam.subInfo, arg_5_1)
	end
end

function ShopGveLayer:_checkShopIsOpen(arg_6_1)
	return (arg_6_1.function_id ~= 0 or nil) and g.core.common.ModuleUnlock:isModuleUnlock(arg_6_1.function_id, nil, true) and g.core.model.User.shopData:checkShopOpen(arg_6_1.shop_type, arg_6_1.shop_first)
end

function ShopGveLayer:_initShopGveUI()
	self:addBg("bg/gve/bg_rw_jiemianxinxi.jpg")
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.GVE_SHOP_LAYER)
	self:_addAssistant((self._shopShowParam or nil) and self._shopShowParam.info.spine)
end

function ShopGveLayer:_addAssistant(arg_8_1)
	self.m_knightComp:removeChildren()

	local var_8_0 = {
		resId = arg_8_1 > 0 and arg_8_1 or 700060
	}

	var_8_0.isShowBg = false
	var_8_0.isAlphaNode = true

	local var_8_1 = DrawKnight.new(var_8_0)

	var_8_1:setAlphaRect(var_0_1.SpineConst.MASK_TYPE.HORIZON, cc.rect(-150, -10, 390, 100), 300)
	self.m_knightComp:addChild(var_8_1)
end

function ShopGveLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE, handler(self, self._onS2CNoticeAllianceState), self)
	self:_refreshShopItem()
	self:_onS2CNoticeAllianceState()
end

function ShopGveLayer:_refreshShopItem()
	if self._shopShowParam == nil then
		return
	end

	self.m_childComp:updateComp(self._shopShowParam)
end

function ShopGveLayer:_onCrossDayUpdate()
	if not var_0_3:isOpen() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end
end

function ShopGveLayer:_onS2CNoticeAllianceState()
	if not g.core.model.User.allianceData:isInAlliance() then
		g.core.module.ModuleManager:tip(g.core.lang:get(309198))
		self:newScheduleOnce(function()
			g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
		end, 0)
	end
end

return ShopGveLayer
