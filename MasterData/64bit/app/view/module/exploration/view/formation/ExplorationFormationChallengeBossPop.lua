local var_0_0 = g.core.const.ConstMgr.LineUpConst
local var_0_1 = g.core.config.multi_team_formation_info
local var_0_2 = g.core.model.User.explorationData
local var_0_3 = g.core.config.exploration_boss_info
local ExplorationFormationChallengeBossPop = class("ExplorationFormationChallengeBossPop", require("app.fairyGUI.exploration.UI_ExplorationFormationChallengeBossPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgName = "exploration",
		resName = "ExplorationFormationChallengeBossPop",
		pkgPath = "ui/exploration/exploration"
	}, ...)
end)

function ExplorationFormationChallengeBossPop:ctor(arg_2_1)
	self._bossId = arg_2_1.bossId
	self._battleTeam = arg_2_1.battleTeam or {}
	self._mulTeamInfo = var_0_1.get(var_0_0.MulTeamType.EXPLORATION)
	self._bossInfo = var_0_3.get(self._bossId)

	self:initView()
	self.m_enterTransition:play()
end

function ExplorationFormationChallengeBossPop:initView()
	self.m_isMulTeamController:setSelectedIndex(0)
	self.m_enterEff2:addEffectSpine({
		name = "eff_ui_explorationTeam_enter",
		isLoop = false,
		remove = true,
		anim = "play2"
	})

	local var_3_0 = self._battleTeam.units[1].id
	local var_3_1

	if self._battleTeam.units[1].id == self._battleTeam.user.base_id and self._battleTeam.user.skin and self._battleTeam.user.skin ~= 0 then
		var_3_1 = self._battleTeam.user.skin
		var_3_0 = nil
	end

	self:_updateShowKnight(var_3_0, var_3_1)
end

function ExplorationFormationChallengeBossPop:onLoad()
	self.m_challengeComp:updateChallengeComp(self._bossInfo, self._battleTeam)
end

function ExplorationFormationChallengeBossPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EXPLORATION_FORMATION_FIGHT_VALUE_CHECK, false)
end

function ExplorationFormationChallengeBossPop:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "click_battle_btn" then
		self:_onClickBattleBtn()
	elseif arg_6_1 == "click_rank_btn" then
		self:_onClickRankBtn()
	elseif arg_6_1 == "update_show_knight" then
		-- block empty
	end
end

function ExplorationFormationChallengeBossPop:_updateShowKnight(arg_7_1, arg_7_2)
	self.m_knightPicComp:updateKnight({
		baseId = arg_7_1,
		skinId = arg_7_2
	})
	self.m_knightPicComp:setAlphaLRDistance(250)
end

function ExplorationFormationChallengeBossPop:_onClickClose()
	self.m_backTransition:play(handler(self, self._backTranEnd))
end

function ExplorationFormationChallengeBossPop:_backTranEnd()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ExplorationFormationChallengeBossPop:_onClickBattleBtn()
	if var_0_2:getBossCanChallengeCount() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(109808))

		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.EXPLORATION_FORMATION, {
		isBoss = true,
		teamNums = self._mulTeamInfo.team_size
	})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ExplorationFormationChallengeBossPop:_onClickRankBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.EXPLORATION_RANK_LAYER)
end

return ExplorationFormationChallengeBossPop
