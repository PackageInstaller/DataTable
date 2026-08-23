local var_0_0 = g.core.config.massive_monster_team_info
local var_0_1 = g.core.config.team_battle_monster_info
local TeamBattleChallengePop = class("TeamBattleChallengePop", require("app.fairyGUI.teamBattle.UI_TeamBattleChallengePop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/teamBattle/teamBattle",
		resName = "TeamBattleChallengePop",
		pkgName = "teamBattle"
	})
end)

function TeamBattleChallengePop:ctor(arg_2_1)
	self:showAtCenter()

	self._event = arg_2_1

	local var_2_0 = arg_2_1:getEventInfo()

	self._eventInfo = var_2_0
	self._monsterId = var_2_0.monsterInfo.monsterId
	self._grid = var_2_0.grid

	self:_updateMainView()
end

function TeamBattleChallengePop:_updateMainView()
	local var_3_0 = var_0_1.get(self._monsterId)

	self._enemyList = self._eventInfo.monsterInfo.knightList

	self.m_knightPicComp:updateKnight({
		baseId = self._enemyList[1]
	})
	self.m_knightPicComp:setAlphaLRDistance(250)
	self.m_challengeComp:updateChallengeComp({
		battleMonsterInfo = var_3_0,
		teamInfo = var_0_0.get(var_3_0.monster_1),
		enemyIdList = self._enemyList,
		hpList = self._eventInfo.monsterInfo.hpRatioList
	})
	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		anim = "play_xiangqing",
		name = "eff_ui_teamBattle_popBg",
		remove = true,
		isLoop = false
	})
end

function TeamBattleChallengePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_CHALLENGEMONSTERBEGIN, handler(self, self._onS2CTeamBattleChallengeMonsterBegin), self)
end

function TeamBattleChallengePop:_onS2CTeamBattleChallengeMonsterBegin(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		soundType = 4,
		canSkip = true,
		battle_id = arg_5_4.battle_id,
		type = BattleConst.TYPE_TEAM_BATTLE,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVE
	})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TeamBattleChallengePop:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "TEAM_BATTLE_CHALLENGE" then
		g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_BATTLE_FORMATION_LAYER, {
			grid = self._grid
		})
	end
end

function TeamBattleChallengePop:onUnload()
	self.m_backTransition:play(handler(self, self.onReset))
end

function TeamBattleChallengePop:onReset()
	self.m_resetTransition:play()
end

function TeamBattleChallengePop:onRemoved()
	return
end

return TeamBattleChallengePop
