local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.model.User.explorationData
local var_0_4 = g.core.const.ConstMgr.LineUpConst
local var_0_5 = g.core.config.massive_monster_team_info
local ExplorationFormationMainLayer = class("ExplorationFormationMainLayer", require("app.fairyGUI.exploration.UI_ExplorationFormationMainLayer"), function()
	return fgui.GComponent:create({
		resName = "ExplorationFormationMainLayer",
		pkgPath = "ui/exploration/exploration",
		isFullScreen = true,
		pkgName = "exploration"
	}, ...)
end)

function ExplorationFormationMainLayer:ctor(arg_2_1)
	self._isMainEnter = arg_2_1.isMainEnter == true
	self._tabNum = arg_2_1.teamNums or 1
	self._teams = arg_2_1.teams or {}

	if arg_2_1.event then
		self._eventData = arg_2_1.event
	elseif arg_2_1.roomId then
		self._roomId = arg_2_1.roomId
		self._direction = arg_2_1.direction
	elseif arg_2_1.isBoss then
		self._isBoss = arg_2_1.isBoss
	end

	self._formationData = var_0_3:getFormationData()
	self._curTabIndex = 1
	self._enterBattle = false

	self:initView()
end

function ExplorationFormationMainLayer:initView()
	self:addBg("bg/exploration/bg_slmj_bz_di.jpg", false, nil, 1)
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.EXPLORATION_LAYER)
	self.m_tabList:setVirtual(self)
	self.m_tabList:doFairyBatching(false)
	self.m_tabList:setItemRenderer(handler(self, self._onTabItemRender))
	self.m_tabList:setNumItems(self._tabNum)
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickFormationTab))
	self.m_challengeBtn:setVisible(not self._isMainEnter)

	self._isShowSkip = not self._isMainEnter

	self.m_challengeBtn:addClickListener(handler(self, self._onClickChallengeBtn))
end

function ExplorationFormationMainLayer:_onTabItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateComp({
		idx = arg_4_1 + 1,
		process = self:_getTeamProcess(arg_4_1 + 1)
	})
end

function ExplorationFormationMainLayer:_onClickFormationTab(arg_5_1)
	local var_5_0 = arg_5_1:getDataValue()

	if var_5_0 + 1 == self._curTabIndex then
		return
	end

	self._curTabIndex = var_5_0 + 1

	self:_updateFormationView()
end

function ExplorationFormationMainLayer:_getTeamProcess(arg_6_1)
	return var_0_3:getFormationData():getFormationStruct(arg_6_1):getTeamProcess() / 1000
end

function ExplorationFormationMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, handler(self, self._onS2CFormationSave), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_ERROR_SAVE, handler(self, self._updateFormationView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_CHALLENGEGUARDBEGIN, handler(self, self._onGetChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_EVENTPROCESS, handler(self, self._onGetChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_CHALLENGEBOSSBEGIN, handler(self, self._onGetChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_FIGHTVALUE, handler(self, self.updateSkipBattleTips), self)
	self.m_tabList:setSelectedIndex(self._curTabIndex - 1)
	self:_updateFormationView()
end

function ExplorationFormationMainLayer:_updateFormationView()
	self.m_mulTeamFormationComp:updateComp(self._curTabIndex)

	if self._curTabIndex == self._tabNum then
		self.m_btnTypeController:setSelectedIndex(1)
	else
		self.m_btnTypeController:setSelectedIndex(0)
	end
end

function ExplorationFormationMainLayer:_onS2CFormationSave()
	self.m_tabList:refreshVirtualList()

	if self._enterBattle then
		self._enterBattle = false

		self:_startChallengeStage()
	end
end

function ExplorationFormationMainLayer:_onGetChallengeBegin(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_4.battle_id then
		g.core.battle.BattleProxy:enterBattle({
			soundType = 5,
			canSkip = true,
			battle_id = arg_10_4.battle_id,
			type = BattleConst.TYPE_EXPLORATION,
			skip = BattleConst.SKIP_TYPE.ACTIVE,
			battleType = BattleConst.BATTLE_TYPE.PVE,
			bgId = self._isBoss and 144 or 143
		})
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ExplorationFormationMainLayer:_onClickChallengeBtn()
	if self._curTabIndex == self._tabNum then
		local var_11_0 = 0

		for iter_11_0 = 1, self._tabNum do
			local var_11_1 = self._formationData:getFormationStruct(iter_11_0)

			if not var_11_1:hasAnyGoodsLineUp(var_0_2.TYPE_KNIGHT) then
				var_0_1:tip(g.core.lang:get(420653, {
					index = iter_11_0
				}))

				return
			elseif var_11_1:hasNotGoodsLineUp(var_0_2.TYPE_KNIGHT) then
				var_11_0 = iter_11_0
			end
		end

		if var_11_0 > 0 then
			var_0_1:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(1257),
				desc = g.core.lang:get(420654, {
					index = var_11_0
				}),
				onConfirm = handler(self, self._needEnterBattle)
			}))
		else
			self:_needEnterBattle()
		end
	else
		self._curTabIndex = self._curTabIndex + 1

		self.m_tabList:setSelectedIndex(self._curTabIndex - 1)
		self:_updateFormationView()
	end
end

function ExplorationFormationMainLayer:_needEnterBattle()
	self._enterBattle = true

	g.core.network.GameNetProxy:send_C2S_Formation_Save({
		tp = var_0_4.MulTeamType.EXPLORATION,
		formations = self._formationData:getOutBaseFormationArr()
	})
	self.m_mulTeamFormationComp:setEnterBattle(true)
end

function ExplorationFormationMainLayer:_startChallengeStage()
	if not var_0_3:isActivityOpen() then
		var_0_1:tip(g.core.lang:get(420659))

		return
	end

	local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")

	if self._eventData then
		g.core.network.GameNetProxy:send_C2S_Exploration_EventProcess({
			unique_id = self._eventData.unique_id
		})
		var_0_3:getMapData():saveBattleInfo({
			event = self._eventData
		})
	elseif self._isBoss then
		if var_0_3:checkChallengeTime(ExplorationConst.EVENT_TYPE.ULTIMATUM, 0) then
			g.core.network.GameNetProxy:send_C2S_Exploration_ChallengeBossBegin({})
		end
	elseif var_0_3:checkChallengeTime(ExplorationConst.EVENT_TYPE.GUARD, table.concat({
		self._roomId,
		self._direction
	}, "_")) then
		g.core.network.GameNetProxy:send_C2S_Exploration_ChallengeGuardBegin({
			room_id = self._roomId,
			guard = self._direction
		})
		var_0_3:getMapData():saveBattleInfo({
			room_id = self._roomId,
			direction = self._direction + 1
		})
	end
end

function ExplorationFormationMainLayer:receiveCompEvent(arg_14_1, arg_14_2)
	if arg_14_1 == "CompEventFormationChanged" then
		self.m_tabList:refreshVirtualList()
		self:updateSkipBattleTips()
	end
end

function ExplorationFormationMainLayer:updateSkipBattleTips()
	local var_15_0 = 0
	local var_15_1 = 0

	for iter_15_0, iter_15_1 in ipairs(self._teams) do
		var_15_0 = var_15_0 + var_0_5.get(iter_15_1).fight
		var_15_1 = var_15_1 + var_0_3:getFormationData():getFormationStruct(iter_15_0):getFightValue()
	end

	self.m_canSkipController:setSelectedIndex(self._isShowSkip and g.core.model.User:checkUserSkipBattle(var_15_1, var_15_0, 1) and 1 or 0)
end

return ExplorationFormationMainLayer
