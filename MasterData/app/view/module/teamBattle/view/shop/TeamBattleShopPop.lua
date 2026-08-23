local TeamBattleShopPop = class("TeamBattleShopPop", require("app.fairyGUI.teamBattle.UI_TeamBattleShopPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleShopPop",
		pkgName = "teamBattle"
	})
end)

function TeamBattleShopPop:ctor(arg_2_1)
	self:showAtCenter()
	self:getView():setWidth(display.width)

	self._event = arg_2_1

	local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
	local var_2_1 = g.core.config.team_battle_parameter_info.get(TeamBattleConst.PARAMETER_ID.KNIGHT_SHOP_COST_ID).parameter

	if self._event:getEventType() == TeamBattleConst.EVENT_TYPE.BUFF_SHOP then
		self.m_isBuffShopController:setSelectedIndex(1)

		var_2_1 = g.core.config.team_battle_parameter_info.get(TeamBattleConst.PARAMETER_ID.BUFF_SHOP_COST_ID).parameter
	end

	local var_2_2 = self._event:getEventInfo()

	self._uniqueId = 0
	self._shopType = arg_2_1:getCfg().id
	self._gridId = var_2_2.grid
	self._shopList = {}
	self._freshCostTVS = {
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_TEAM_BATTLE,
		size = var_2_1
	}

	self.m_title:setText(self._event:getCfg().event_name)
	self:_initBtn()
	self:_initListView()
end

function TeamBattleShopPop:_initBtn()
	self.m_freshBtn:addClickListener(handler(self, self._onClickFreshBtn))
	self.m_closePnl:addClickListener(handler(self, self._onCloseClick))
end

function TeamBattleShopPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_KNIGHTSHOPREFRESH, handler(self, self._onShopRefreshSuc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYKNIGHTSHOPREFRESH, handler(self, self._onShopRefreshSuc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_BUFFSHOPREFRESH, handler(self, self._onShopRefreshSuc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYBUFFSHOPREFRESH, handler(self, self._onShopRefreshSuc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_KNIGHTSHOPBUY, handler(self, self._onS2CTeamBattleKnightShopBuy), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYKNIGHTSHOPBUY, handler(self, self._onS2CTeamBattleNotifyKnightShopBuy), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_BUFFSHOPBUY, handler(self, self._onS2CTeamBattleBuffShopBuy), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYBUFFSHOPBUY, handler(self, self._onS2CTeamBattleNotifyBuffShopBuy), self)
	self:_updateMainView()
	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		remove = true,
		name = "eff_ui_teamBattle_popBg",
		anim = "play_shop",
		isLoop = false
	})
end

function TeamBattleShopPop:onUnload()
	self.m_backTransition:play()
end

function TeamBattleShopPop:_initListView()
	self.m_shopList:setVirtual()
	self.m_shopList:doFairyBatching(false)
	self.m_shopList:setItemRenderer(handler(self, self._onRenderShopList))
	self:addListen(self.m_shopList)
	self.m_buffList:setVirtual()
	self.m_buffList:doFairyBatching(false)
	self.m_buffList:setItemRenderer(handler(self, self._onRenderShopList))
	self:addListen(self.m_buffList)
end

function TeamBattleShopPop:_onRenderShopList(arg_7_1, arg_7_2)
	if self._isFresh then
		arg_7_2:playFreshEffect()
	end

	arg_7_2:updateShopItem(self._shopList[arg_7_1 + 1], self._shopType, arg_7_1)
end

function TeamBattleShopPop:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "TEAMBATTLE_SHOP_BUY_ITEM" then
		if self.m_isBuffShopController:getSelectedIndex() == 1 then
			g.core.network.GameNetProxy:send_C2S_TeamBattle_BuffShopBuy({
				grid_id = self._gridId,
				pos = arg_8_2.pos
			})
		else
			g.core.network.GameNetProxy:send_C2S_TeamBattle_KnightShopBuy({
				grid_id = self._gridId,
				pos = arg_8_2.pos
			})
		end
	end
end

function TeamBattleShopPop:_updateMainView()
	self._shopList = self._event:getEventInfo().productList or {}

	if self.m_isBuffShopController:getSelectedIndex() == 1 then
		self.m_buffList:setNumItems(#self._shopList)
		self.m_buffList:transitionShowCells("enter_scaleIn", 0.03)
	else
		self.m_shopList:setNumItems(#self._shopList)
		self.m_shopList:transitionShowCells("enter_scaleIn", 0.03)
	end

	self.m_resComp:updateResBtn({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_TEAM_BATTLE
	})
	self.m_costComp:updateByTVS(self._freshCostTVS)
end

function TeamBattleShopPop:_onRecvFreshShopItem(arg_10_1, arg_10_2, arg_10_3)
	self._isFresh = true

	self:_updateMainView()

	self._isFresh = false
end

function TeamBattleShopPop:_onClickFreshBtn()
	if g.core.utils.Tools.isCountEnoughByTVS(self._freshCostTVS, true) then
		if self.m_isBuffShopController:getSelectedIndex() == 1 then
			g.core.network.GameNetProxy:send_C2S_TeamBattle_BuffShopRefresh({
				grid_id = self._gridId
			})
		else
			g.core.network.GameNetProxy:send_C2S_TeamBattle_KnightShopRefresh({
				grid_id = self._gridId
			})
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RESONATOR_SHOP_FRESH)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(420673))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RESONATOR_SHOP_MONEY_DEFICIT)
	end
end

function TeamBattleShopPop:_onCloseClick()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TeamBattleShopPop:_onShopRefreshSuc(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_4.grid_id == self._gridId then
		g.core.module.ModuleManager:tip(g.core.lang:get(427113))
		self:_updateMainView()
	end
end

function TeamBattleShopPop:_onS2CTeamBattleKnightShopBuy(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if arg_14_4.grid_id == self._gridId then
		g.core.module.ModuleManager:tip(g.core.lang:get(427111))
		self:_updateMainView()
	end
end

function TeamBattleShopPop:_onS2CTeamBattleNotifyKnightShopBuy(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if arg_15_4.grid_id == self._gridId then
		self:_updateMainView()
	end
end

function TeamBattleShopPop:_onS2CTeamBattleBuffShopBuy(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if arg_16_4.grid_id == self._gridId then
		g.core.module.ModuleManager:tip(g.core.lang:get(427112))
		self:_updateMainView()
		g.core.network.GameNetProxy:send_C2S_Formation_Get({
			tp = g.core.const.ConstMgr.LineUpConst.MulTeamType.TEAM_BATTLE
		})
	end
end

function TeamBattleShopPop:_onS2CTeamBattleNotifyBuffShopBuy(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if arg_17_4.grid_id == self._gridId then
		self:_updateMainView()
		g.core.network.GameNetProxy:send_C2S_Formation_Get({
			tp = g.core.const.ConstMgr.LineUpConst.MulTeamType.TEAM_BATTLE
		})
	end
end

function TeamBattleShopPop:onUnload()
	self.m_backTransition:play()
	g.core.model.User.teamBattleData:getFormationData():onCheckFightValue()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EXPLORATION_FORMATION_FIGHT_VALUE_CHECK, false)
end

return TeamBattleShopPop
