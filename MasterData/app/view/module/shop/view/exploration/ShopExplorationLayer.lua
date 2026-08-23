local DrawKnight = require("app.view.common.DrawKnight")
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.model.User.shopData
local var_0_3 = g.core.model.User.explorationData
local ShopExplorationLayer = class("ShopExplorationLayer", require("app.fairyGUI.shop.UI_ShopExplorationLayer"), function()
	return fgui.GComponent:create({
		resName = "ShopExplorationLayer",
		pkgPath = "ui/shop/shop",
		isFullScreen = true,
		pkgName = "shop"
	})
end)

function ShopExplorationLayer:ctor(arg_2_1)
	self._shopTabType = 9
	self._shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.EXPLORATION

	local var_2_0 = var_0_3:getBaseInfo()

	if var_2_0 then
		self._shopFirst = var_2_0.shop_first or 1
	end

	self._shopShowParam = nil

	self:initShopExploration()
end

function ShopExplorationLayer:initShopExploration()
	self:_initExplorationShopData()
	self:_initShopExplorationUI()
end

function ShopExplorationLayer:_initExplorationShopData()
	self._shopShowParam = nil

	for iter_4_0, iter_4_1 in pairs(var_0_2:getShopInfoGroup()[self._shopTabType][self._shopType]) do
		if iter_4_1.shop_first == self._shopFirst then
			self:_addToOpenShopPage(iter_4_1)
		end
	end
end

function ShopExplorationLayer:_addToOpenShopPage(arg_5_1)
	if not var_0_3:isActivityOpen() and false then
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

function ShopExplorationLayer:_initShopExplorationUI()
	self:addBg("bg/exploration/bg_slmj_shop.jpg")
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.EXPLORATION_SHOP_LAYER)
	self:_addSpine()
end

function ShopExplorationLayer:_addSpine()
	self.m_knightComp:removeChildren()

	local var_7_0 = {}

	var_7_0.isShowBg = false
	var_7_0.isAlphaNode = true

	local var_7_1 = DrawKnight.new({
		isAlphaNode = true,
		resId = 600060,
		isShowBg = false
	})

	var_7_1:setAlphaRect(var_0_1.SpineConst.MASK_TYPE.HORIZON, cc.rect(-150, -10, 390, 100), 300)
	self.m_knightComp:addChild(var_7_1)
end

function ShopExplorationLayer:_refreshShopItem()
	if self._shopShowParam == nil then
		return
	end

	self.m_childComp:updateComp(self._shopShowParam)
end

function ShopExplorationLayer:_onCrossDayUpdate()
	if not var_0_3:isActivityOpen() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end
end

function ShopExplorationLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	self:_refreshShopItem()
end

return ShopExplorationLayer
