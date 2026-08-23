local var_0_0 = g.core.config.exploration_monster_info
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_2 = g.core.model.User.explorationData
local ExplorationFormationChallengePop = class("ExplorationFormationChallengePop", require("app.fairyGUI.exploration.UI_ExplorationFormationChallengePop"), function()
	return fgui.GComponent:create({
		resName = "ExplorationFormationChallengePop",
		pkgPath = "ui/exploration/exploration",
		isFullScreen = true,
		pkgName = "exploration"
	}, ...)
end)

function ExplorationFormationChallengePop:ctor(arg_2_1)
	local var_2_0 = 0

	if arg_2_1.event then
		self._eventData = arg_2_1.event
		var_2_0 = self._eventData.id
	elseif arg_2_1.roomId then
		self._roomId = arg_2_1.roomId
		self._direction = arg_2_1.direction
		var_2_0 = arg_2_1.monsterId
	end

	self._deBuffInfo = arg_2_1.deBuffInfo
	self._diffTip = arg_2_1.diffTip
	self._monsterInfo = var_0_0.get(var_2_0)
	self._teamIdList = {}

	self:initView()
	self.m_enterTransition:play()
end

function ExplorationFormationChallengePop:initView()
	self._teamIdList = {}

	while var_0_0.hasKey("monster_" .. 1) do
		if self._monsterInfo["monster_" .. 1] > 0 then
			table.insert(self._teamIdList, self._monsterInfo["monster_" .. 1])
		end
	end

	if #self._teamIdList <= 1 then
		self.m_isMulTeamController:setSelectedIndex(0)
		self.m_enterEff2:addEffectSpine({
			anim = "play2",
			name = "eff_ui_explorationTeam_enter",
			remove = true,
			isLoop = false
		})
	else
		self.m_isMulTeamController:setSelectedIndex(1)
		self.m_enterEff1:addEffectSpine({
			anim = "play1",
			name = "eff_ui_explorationTeam_enter",
			remove = true,
			isLoop = false
		})
	end

	if self._deBuffInfo then
		self.m_isDebuffController:setSelectedIndex(1)
	else
		self.m_isDebuffController:setSelectedIndex(0)
	end
end

function ExplorationFormationChallengePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_CHALLENGEGUARDBEGIN, handler(self, self._onGetChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_EVENTPROCESS, handler(self, self._onGetChallengeBegin), self)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RECEIVE_ROLE)
	self.m_challengeComp:updateChallengeComp(self._monsterInfo, self._teamIdList, self._deBuffInfo, self._diffTip)
end

function ExplorationFormationChallengePop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EXPLORATION_FORMATION_FIGHT_VALUE_CHECK, false)
end

function ExplorationFormationChallengePop:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "click_battle_btn" then
		self:_onClickBattleBtn()
	elseif arg_6_1 == "click_battle_btn_and_skip" then
		local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")

		if self._eventData then
			g.core.network.GameNetProxy:send_C2S_Exploration_EventProcess({
				unique_id = self._eventData.unique_id
			})
			var_0_2:getMapData():saveBattleInfo({
				event = self._eventData
			})
		elseif self._isBoss then
			if var_0_2:checkChallengeTime(ExplorationConst.EVENT_TYPE.ULTIMATUM, 0) then
				g.core.network.GameNetProxy:send_C2S_Exploration_ChallengeBossBegin({})
			end
		elseif var_0_2:checkChallengeTime(ExplorationConst.EVENT_TYPE.GUARD, table.concat({
			self._roomId,
			self._direction
		}, "_")) then
			g.core.network.GameNetProxy:send_C2S_Exploration_ChallengeGuardBegin({
				room_id = self._roomId,
				guard = self._direction
			})
			var_0_2:getMapData():saveBattleInfo({
				room_id = self._roomId,
				direction = self._direction + 1
			})
		end
	elseif arg_6_1 == "update_show_knight" then
		self:_updateShowKnight(arg_6_2.baseId)
	end
end

function ExplorationFormationChallengePop:_onGetChallengeBegin(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4.battle_id then
		g.core.battle.BattleProxy:enterBattle({
			soundType = 5,
			canSkip = true,
			battle_id = arg_7_4.battle_id,
			type = BattleConst.TYPE_EXPLORATION,
			skip = BattleConst.SKIP_TYPE.ACTIVE,
			battleType = BattleConst.BATTLE_TYPE.PVE,
			bgId = self._isBoss and 144 or 143
		})
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BATTLE_SKIP_NOTIFY_REFRESH)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ExplorationFormationChallengePop:_updateShowKnight(arg_8_1)
	self.m_knightPicComp:updateKnight({
		baseId = arg_8_1
	})
	self.m_knightPicComp:setAlphaLRDistance(250)
end

function ExplorationFormationChallengePop:_onClickBattleBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.EXPLORATION_FORMATION, {
		teamNums = #self._teamIdList,
		teams = self._teamIdList,
		event = self._eventData,
		roomId = self._roomId,
		direction = self._direction
	})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ExplorationFormationChallengePop:_onClickClose()
	self.m_backTransition:play(handler(self, self._backTranEnd))
end

function ExplorationFormationChallengePop:_backTranEnd()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return ExplorationFormationChallengePop
