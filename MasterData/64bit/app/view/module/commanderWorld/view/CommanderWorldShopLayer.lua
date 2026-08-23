local var_0_0 = g.core.common.ActivitySort
local var_0_1 = g.core.model.User.commanderWorldData
local var_0_2 = g.core.const.ConstMgr.CommanderWorldConst
local CommanderWorldShopLayer = class("CommanderWorldShopLayer", require("app.fairyGUI.commanderWorld.UI_CommanderWorldShopLayer"), function()
	return fgui.GComponent:create({
		pkgName = "commanderWorld",
		isFullScreen = true,
		pkgPath = "ui/commanderWorld/commanderWorld",
		resName = "CommanderWorldShopLayer"
	}, ...)
end)

function CommanderWorldShopLayer:ctor()
	self:addBg("bg/shop/bg_wanfasd.jpg")

	self._tabIndex = 0
	self._tabNames = {}
	self._shopType = 1
	self._shopInfoList = {}

	self.m_topBarComp:setResInfoById(var_0_2.TOP_BAR_ID)
	self.m_tabList:setIniter()
	self.m_tabList:setItemRenderer(handler(self, self._onTabListRenderer))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabClicked))
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self.onShopGoodItemRender))
	self.m_giftBtn:addClickListener(handler(self, self._onClickGiftBtn))
	self.m_enterTransition:play()
end

function CommanderWorldShopLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_INFO, self.onRcvCommanderWorldInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_SHOPBUY, self.onRcvAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_EXCHANGE, handler(self, self._updateShopList), self)
	self:_updateShopList()
end

function CommanderWorldShopLayer:_onTabListRenderer(arg_4_1, arg_4_2)
	local var_4_0 = var_0_1:getTabNames()

	if var_4_0 and var_4_0[arg_4_1 + 1] then
		arg_4_2:setTitle(var_4_0[arg_4_1 + 1])
	end
end

function CommanderWorldShopLayer:_onTabClicked()
	local var_5_0 = self.m_tabList:getSelectedIndex()

	if self._tabIndex ~= var_5_0 then
		self._tabIndex = var_5_0
		self._shopType = self._tabIndex + 1

		self:_updateShopList()
	end
end

function CommanderWorldShopLayer:onShopGoodItemRender(arg_6_1, arg_6_2)
	arg_6_2:updateItemCell(self._shopInfoList[arg_6_1 + 1])
end

function CommanderWorldShopLayer:_updateShopList()
	self._tabNames = var_0_1:getTabNames() or {}

	self.m_tabList:setNumItems(#self._tabNames)
	self.m_tabList:setSelectedIndex(self._tabIndex)

	self._shopInfoList = table.values((var_0_1:getShopDataByType(self._shopType)))
	self._shopInfoList = var_0_0:listSort(var_0_0.SHOP_SHOW, self._shopInfoList, {
		"info",
		"goods_id"
	}, function(arg_8_0, arg_8_1)
		if arg_8_0.isSold ~= arg_8_1.isSold then
			return not arg_8_0.isSold
		end

		return arg_8_0.info.sort < arg_8_1.info.sort
	end, "CommanderWorldShopLayer")

	self.m_itemList:setNumItems(#self._shopInfoList)
	self.m_itemList:transitionShowCells("enter_left", 0.03)
	self.m_giftBtn:setVisible(var_0_1:getActivityStageAndRemainTime() ~= var_0_2.STAGE.REWARDDAY)
end

function CommanderWorldShopLayer:onRcvAward(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3.awards then
		g.core.module.ModuleManager:awardSummary(arg_9_3.awards, true)
		self:_updateShopList()
	end
end

function CommanderWorldShopLayer:onRcvCommanderWorldInfo()
	self:_updateShopList()
end

function CommanderWorldShopLayer:_onClickGiftBtn()
	if var_0_1:isProcess() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.COMMANDER_GIFT)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(410308))
	end
end

return CommanderWorldShopLayer
