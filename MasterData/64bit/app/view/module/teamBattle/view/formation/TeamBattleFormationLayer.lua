local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.model.User.teamBattleData
local var_0_4 = g.core.const.ConstMgr.LineUpConst
local TeamBattleFormationLayer = class("TeamBattleFormationLayer", require("app.fairyGUI.teamBattle.UI_TeamBattleFormationLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/teamBattle/teamBattle",
		resName = "TeamBattleFormationLayer",
		pkgName = "teamBattle",
		isFullScreen = true
	}, ...)
end)

function TeamBattleFormationLayer:ctor(arg_2_1)
	self._isMainEnter = arg_2_1.isMainEnter == true
	self._grid = arg_2_1.grid
	self._isBoss = arg_2_1.isBoss
	self._formationData = var_0_3:getFormationData()
	self._curTabIndex = 1
	self._enterBattle = false
	self._clickSaveBtn = false

	self:initView()
end

function TeamBattleFormationLayer:initView()
	self:addBg("bg/teamBattle/bg_hjtj_buzhen.jpg", false, nil, 1)
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.TEAM_BATTLE)
	self.m_challengeBtn:addClickListener(handler(self, self._onClickChallengeBtn))

	if self._isMainEnter then
		self.m_isFormationController:setSelectedIndex(1)
	else
		self.m_isFormationController:setSelectedIndex(0)
	end

	self.m_enterTransition:play()
end

function TeamBattleFormationLayer:_onTabItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateComp({
		idx = arg_4_1 + 1,
		process = self:_getTeamProcess(arg_4_1 + 1)
	})
end

function TeamBattleFormationLayer:_onClickFormationTab(arg_5_1)
	local var_5_0 = arg_5_1:getDataValue()

	if var_5_0 + 1 == self._curTabIndex then
		return
	end

	self._curTabIndex = var_5_0 + 1

	self:_updateFormationView()
end

function TeamBattleFormationLayer:_getTeamProcess(arg_6_1)
	return var_0_3:getFormationData():getFormationStruct(arg_6_1):getTeamProcess() / 1000
end

function TeamBattleFormationLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, handler(self, self._onS2CFormationSave), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_ERROR_SAVE, handler(self, self._updateFormationView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_CHALLENGEMONSTERBEGIN, handler(self, self._onGetChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_CHALLENGEBOSSBEGIN, handler(self, self._onGetChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	self:_updateFormationView()
end

function TeamBattleFormationLayer:_onCrossDayUpdate()
	local var_8_0 = g.core.model.User.teamBattleData:getCurStage()
	local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")

	if var_8_0 == TeamBattleConst.ACTIVITY_STATE.RESULT then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.TEAM_BATTLE_RESULT_LAYER)
	elseif var_8_0 == TeamBattleConst.ACTIVITY_STATE.NOT_OPEN then
		g.core.module.ModuleManager:tip(g.core.lang:get(420691))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function TeamBattleFormationLayer:_updateFormationView(arg_9_1)
	if self._formationData:checkDeadKnightAndLineUp() then
		self._enterBattle = false

		g.core.network.GameNetProxy:send_C2S_Formation_Save({
			tp = var_0_4.MulTeamType.TEAM_BATTLE,
			formations = self._formationData:getOutBaseFormationArr()
		})
	else
		self.m_mulTeamFormationComp:updateComp(self._curTabIndex)

		if arg_9_1 and self._clickSaveBtn and self._isMainEnter then
			var_0_1:tip(g.core.lang:get(427143))

			self._clickSaveBtn = false
		end
	end
end

function TeamBattleFormationLayer:_onS2CFormationSave()
	if self._enterBattle then
		self._enterBattle = false

		self:_startChallengeStage()
	else
		self:_updateFormationView(true)
	end
end

function TeamBattleFormationLayer:_onGetChallengeBegin(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	g.core.module.ModuleManager:popAllPopup()
	g.core.module.ModuleManager:popComponent({
		curModule = g.core.module.ModuleManager:getModuleByDisplayName("TeamBattleChallengePop")
	})
	g.core.battle.BattleProxy:enterBattle({
		soundType = 5,
		canSkip = true,
		battle_id = arg_11_4.battle_id,
		type = BattleConst.TYPE_TEAM_BATTLE,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVE,
		bgId = self._isBoss and 144 or 143
	})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TeamBattleFormationLayer:_onSaveFormation()
	local var_12_0 = self._formationData:getOutBaseFormationArr()
	local var_12_1 = false

	for iter_12_0, iter_12_1 in ipairs(var_12_0[1].knight_id) do
		if iter_12_1 ~= 0 then
			var_12_1 = true

			break
		end
	end

	if not var_12_1 then
		var_0_1:tip(g.core.lang:get(427139))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Formation_Save({
		tp = var_0_4.MulTeamType.TEAM_BATTLE,
		formations = var_12_0
	})
end

function TeamBattleFormationLayer:_onClickChallengeBtn()
	self._clickSaveBtn = true

	if self._isMainEnter then
		self:_onSaveFormation()

		return
	end

	local var_13_0 = 0
	local var_13_1 = self._formationData:getFormationStruct(1)
	local var_13_2 = false
	local var_13_3 = 0

	for iter_13_0, iter_13_1 in pairs((var_13_1:getKnightSidArr())) do
		if iter_13_1 > 0 then
			if self._formationData:getGuardById(iter_13_1):getHpRatio() > 1 then
				var_13_2 = true
			end

			var_13_3 = var_13_3 + 1
		end
	end

	if var_13_3 <= 0 then
		var_0_1:tip(g.core.lang:get(427139))

		return
	end

	if not var_13_2 then
		var_0_1:tip(g.core.lang:get(427124))

		return
	end

	if not var_13_1:hasAnyGoodsLineUp(var_0_2.TYPE_KNIGHT) then
		var_0_1:tip(g.core.lang:get(420653, {
			index = var_13_0
		}))

		return
	elseif var_13_1:hasNotGoodsLineUp(var_0_2.TYPE_KNIGHT) then
		var_13_0 = 1
	end

	if var_13_0 > 0 then
		var_0_1:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(420654, {
				index = var_13_0
			}),
			onConfirm = handler(self, self._needEnterBattle)
		}))
	else
		self:_needEnterBattle()
	end
end

function TeamBattleFormationLayer:_needEnterBattle()
	self._enterBattle = true

	self:_onSaveFormation()
	self.m_mulTeamFormationComp:setEnterBattle(true)
end

function TeamBattleFormationLayer:_startChallengeStage()
	if not var_0_3:isActivityOpen() then
		var_0_1:tip(g.core.lang:get(420659))

		return
	end

	if self._isBoss then
		g.core.network.GameNetProxy:send_C2S_TeamBattle_ChallengeBossBegin({
			grid_id = self._grid
		})
	else
		g.core.network.GameNetProxy:send_C2S_TeamBattle_ChallengeMonsterBegin({
			grid_id = self._grid
		})
	end
end

function TeamBattleFormationLayer:receiveCompEvent(arg_16_1, arg_16_2)
	return
end

return TeamBattleFormationLayer
