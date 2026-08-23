local var_0_3 = g.core.model.User.anniversaryData
local AnniversaryShopLayer = class("AnniversaryShopLayer", require("app.fairyGUI.anniversary.UI_AnniversaryShopLayer"), function()
	return fgui.GComponent:create({
		resName = "AnniversaryShopLayer",
		pkgPath = "ui/anniversary/anniversary",
		isFullScreen = true,
		pkgName = "anniversary"
	}, ...)
end)

function AnniversaryShopLayer:ctor(arg_2_1)
	self._selectedGroup = 1
	self._shopTabList = {}
	self._itemList = {}

	self:_initListView()
	self:_initView()
end

function AnniversaryShopLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, self._onShop, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, self._updateView, self)
	self:_updateView(true)
	self.m_selGroupController:setSelectedIndex(0)
	self.m_enterTransition:play()
end

function AnniversaryShopLayer:_initListView()
	self.m_selGroupController:setSelectedIndex(-1)
	self.m_selGroupController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onGroupSelChanged))
	self.m_shopTabList:setVirtual()
	self.m_shopTabList:setItemRenderer(handler(self, self._onRenderShopTabList))
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onRenderItemList))
end

function AnniversaryShopLayer:_onRenderShopTabList(arg_5_1, arg_5_2)
	arg_5_2:updateTab(self._shopTabList[arg_5_1 + 1])
end

function AnniversaryShopLayer:_onRenderItemList(arg_6_1, arg_6_2)
	arg_6_2:updateShopItem(self._itemList[arg_6_1 + 1], self._shopTabList[self._selectedGroup])
end

function AnniversaryShopLayer:_initView(arg_7_1)
	self:addBg(var_0_3:getActivityResource("bg", "bg_xmhy_shop.jpg"))

	local var_7_0 = var_0_3:getAnniversaryInfo()

	self.m_topBarComp:setResInfoById(var_7_0.interface_main)
	self.m_topBarComp:setTitle(var_7_0.shop_name)
end

function AnniversaryShopLayer:_updateView(arg_8_1)
	self._shopTabList = var_0_3:getShopTabList()

	self.m_shopTabList:setNumItems(#self._shopTabList)

	self._itemList = var_0_3:getShopTabSellList(self._selectedGroup)

	self.m_itemList:setNumItems(#self._itemList)

	if arg_8_1 then
		self.m_itemList:transitionShowCells("enter_left", 0.03)
	end
end

function AnniversaryShopLayer:_onGroupSelChanged()
	local var_9_0 = self.m_selGroupController:getSelectedIndex() + 1

	self._shopTabList = var_0_3:getShopTabList()

	if var_0_3:getCurScore() < self._shopTabList[var_9_0].openScoreNum then
		g.core.module.ModuleManager:tip(g.core.lang:get(431608, {
			targetNum = self._shopTabList[var_9_0].openScoreNum
		}))
	end

	self._selectedGroup = var_9_0

	self:_updateView(true)
end

function AnniversaryShopLayer:_onShop(arg_10_1, arg_10_2, arg_10_3)
	g.core.module.ModuleManager:awardSummary(arg_10_3.awards)
	self:_updateView()
end

return AnniversaryShopLayer
