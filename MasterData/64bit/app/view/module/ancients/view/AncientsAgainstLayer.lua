local AncientsAgainstLayer = class("AncientsAgainstLayer", require("app.fairyGUI.ancients.UI_AncientsAgainstLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/ancients/ancients",
		resName = "AncientsAgainstLayer",
		pkgName = "ancients",
		isFullScreen = true
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.AncientsConst

function AncientsAgainstLayer:ctor(arg_2_1)
	if arg_2_1 then
		self._autoInTeam = arg_2_1.autoInTeam or false
	end

	self:addBg("bg/ancients/bg_jxmy_dfs.jpg")
	self.m_effDi:addEffectSpine({
		anim = "play",
		remove = false,
		isLoop = true,
		name = "eff_ui_ancients_schedulebglight"
	})
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_TeamPVP)
	self.m_Comp_top_bar:setResInfoById(var_0_1.TopBarId)
	self.m_enterTransition:play()
end

function AncientsAgainstLayer:onLoad()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ANCIENTS)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_ENTER, handler(self, self._onRcvGetTeamPointsRanking), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_FINALBATTLEREPORT, handler(self, self._onRcvFinalBattleReport), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_ROUNDNOTIFY, handler(self, self._onRcvRoundNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayEvent), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self._onModuleExit), self)
	g.core.network.GameNetProxy:send_C2S_Ancient_Enter({})

	if g.core.model.User.ancientsData:getAncientsState() <= g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP and g.core.model.User.ancientsData:hasFinalFightQualification() and g.core.model.User.ancientsData:getTeam(var_0_1.GET_TEAM_TYPE.CURRENT_TEAM) == nil then
		g.core.network.GameNetProxy:send_C2S_Ancient_GetInvitationList({})
	end

	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_TeamPVP)
end

function AncientsAgainstLayer:_onRcvGetTeamPointsRanking(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self._promoteTeams = arg_4_4.promote_teams or {}
	self._playerPoints = arg_4_4.score_stage_score or 0
	self._playerRankIndex = arg_4_4.score_stage_rank or 0
	self._finalTeams = arg_4_4.final_teams or {}
	self._roundTeams = arg_4_4.round_teams or {}

	if self._playerRankIndex == 0 then
		self._playerRankIndex = g.core.lang:get(202065)
	end

	self:_updateView()
end

function AncientsAgainstLayer:_onRcvRoundNotify(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self._roundTeams = arg_5_4.round_teams or {}

	self:_updateView()
end

function AncientsAgainstLayer:_onRcvFinalBattleReport(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_FINAL_BATTLE_REPORT_POP, {
		report = arg_6_4.report
	})
end

function AncientsAgainstLayer:_onModuleExit(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3 == g.view.entrance.ANCIENTS_GUESS_POP then
		self:_updateView()
	end
end

function AncientsAgainstLayer:_updateView()
	if self._autoInTeam then
		self._autoInTeam = false

		if g.core.model.User.ancientsData:hasFinalFightQualification() then
			if g.core.model.User.ancientsData:getTeam(var_0_1.GET_TEAM_TYPE.FINAL_TEAM) == nil then
				g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_MAIN_LAYER)
			else
				g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_MAIN_LAYER)
			end
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(433378))
		end
	end

	local var_8_0, var_8_1 = g.core.model.User.ancientsData:isInStageShowTimeAndCd()

	if var_8_0 then
		self._showTimeSchedule = self:newScheduleOnce(handler(self, self._updateView), var_8_1)
	end

	self.m_Comp_against:updateView({
		teams = self._finalTeams,
		roundData = self._roundTeams
	})
end

function AncientsAgainstLayer:_onCrossDayEvent()
	if g.core.utils.Tools.ancientsFunc.getNeedOpenModule() ~= g.view.entrance.ANCIENTS_AGAINST_LAYER then
		g.core.utils.Tools.ancientsFunc.openAncientsMainLayer(true)
	end
end

return AncientsAgainstLayer
