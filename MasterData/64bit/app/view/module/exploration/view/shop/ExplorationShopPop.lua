local var_0_0 = g.core.const.ConstMgr.ExplorationConst
local ExplorationShopPop = class("ExplorationShopPop", require("app.fairyGUI.exploration.UI_ExplorationShopPop"), function()
	return fgui.GComponent:create({
		resName = "ExplorationShopPop",
		pkgName = "exploration"
	})
end)

function ExplorationShopPop:ctor(arg_2_1)
	self:showAtCenter()
	self:getView():setWidth(display.width)

	self._tiledStruct = arg_2_1
	self._uniqueId = arg_2_1:getEventUniqueID()
	self._shopType = arg_2_1:getEventType()
	self._shopList = {}
	self._freshCostTVS = {
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_EXPLORATION_COMMON_RESOURCE,
		size = g.core.config.exploration_parameter_info.get(var_0_0.CHALLENGE_COST.FRESH).parameter
	}

	self:_initBtn()
	self:_initListView()
end

function ExplorationShopPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_EVENTPROCESS, self._onRecvBuyShopItem, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_SHOPREFRESH, self._onRecvFreshShopItem, self)
	self:updateView()
	self.m_enterTransition:play()
	self:getChild("n4"):setPosition(0, 61)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RESONATOR_SHOP)
end

function ExplorationShopPop:onUnload()
	self.m_backTransition:play()
end

function ExplorationShopPop:_initBtn()
	self.m_costComp:updateHaveNumTextColor()
	self.m_costComp:setTitleNormalColor(2)
	self.m_freshBtn:addClickListener(handler(self, self._onFreshClick))
end

function ExplorationShopPop:_initListView()
	self.m_shopList:setWidth(1255 + display.width - CC_DESIGN_RESOLUTION.width - 2 * cc.Director:getInstance():getSafeAreaRect().x)
	self.m_shopList:setVirtual()
	self.m_shopList:doFairyBatching(false)
	self.m_shopList:setItemRenderer(handler(self, self._onRenderShopList))
	self:addListen(self.m_shopList)
end

function ExplorationShopPop:_onRenderShopList(arg_7_1, arg_7_2)
	if self._isFresh then
		arg_7_2:playFreshEffect()
	end

	arg_7_2:updateShopItem(self._shopList[arg_7_1 + 1], self._shopType)
end

function ExplorationShopPop:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "Exploration_buy_shop_item" then
		g.core.network.GameNetProxy:send_C2S_Exploration_EventProcess({
			unique_id = self._uniqueId,
			params = {
				arg_8_2.itemId
			}
		})
	end
end

function ExplorationShopPop:updateView()
	self._shopList = self._tiledStruct:getShopProductList()

	self.m_shopList:setNumItems(#self._shopList)
	self.m_resComp:updateResBtn({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_EXPLORATION_COMMON_RESOURCE
	})
	self.m_costComp:updateByTVS(self._freshCostTVS)
end

function ExplorationShopPop:_onRecvBuyShopItem(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3 and arg_10_3.event and arg_10_3.event.tp and ({
		[var_0_0.EVENT_TYPE.KNIGHT_SHOP] = 1,
		[var_0_0.EVENT_TYPE.UNITE_SHOP] = 1,
		[var_0_0.EVENT_TYPE.PET_SHOP] = 1,
		[var_0_0.EVENT_TYPE.ARTIFACT_SHOP] = 1
	})[arg_10_3.event.tp] then
		g.core.module.ModuleManager:tip(g.core.lang:get(420668))
		self:updateView()
	end
end

function ExplorationShopPop:_onRecvFreshShopItem(arg_11_1, arg_11_2, arg_11_3)
	self._isFresh = true

	self:updateView()

	self._isFresh = false
end

function ExplorationShopPop:_onFreshClick()
	if g.core.utils.Tools.isCountEnoughByTVS(self._freshCostTVS, true) then
		g.core.network.GameNetProxy:send_C2S_Exploration_ShopRefresh({
			shop_id = self._uniqueId
		})
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RESONATOR_SHOP_FRESH)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(420673))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RESONATOR_SHOP_MONEY_DEFICIT)
	end
end

return ExplorationShopPop
