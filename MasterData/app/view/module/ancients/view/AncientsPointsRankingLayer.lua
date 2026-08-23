local AncientsPointsRankingLayer = class("AncientsPointsRankingLayer", require("app.fairyGUI.ancients.UI_AncientsPointsRankingLayer"), function()
	return fgui.GComponent:create({
		resName = "AncientsPointsRankingLayer",
		pkgPath = "ui/ancients/ancients",
		isFullScreen = true,
		pkgName = "ancients"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.AncientsConst

function AncientsPointsRankingLayer:ctor(arg_2_1)
	if arg_2_1 then
		self._autoInTeam = arg_2_1.autoInTeam or false
	end

	self:addBg("bg/ancients/bg_jxmy_jfsjs.jpg")
	self.m_Btn_check_rewards:addClickListener(handler(self, self._onClickBtnCheckRewards))
	self.m_Btn_prize:addClickListener(handler(self, self._onClickBtnPrize))
	self.m_Comp_top_bar:setResInfoById(var_0_1.TopBarId)
end

function AncientsPointsRankingLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_ENTER, handler(self, self._onRcvGetTeamPointsRanking), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_ROUNDNOTIFY, handler(self, self._onRcvRoundNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayEvent), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self._onModuleExit), self)
	g.core.network.GameNetProxy:send_C2S_Ancient_Enter({})
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_TeamPVP)
	self.m_enterTransition:play()
	self.m_Comp_points_rank:getTransition("enter"):play()
end

function AncientsPointsRankingLayer:_onRcvGetTeamPointsRanking(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
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

function AncientsPointsRankingLayer:_onRcvRoundNotify(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self._roundTeams = arg_5_4.round_teams or {}

	self:_updateView()
end

function AncientsPointsRankingLayer:_onModuleExit(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3 == g.view.entrance.ANCIENTS_GUESS_POP then
		self:_updateView()
	end
end

function AncientsPointsRankingLayer:_updateView()
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

	local var_7_0, var_7_1 = g.core.model.User.ancientsData:isInStageShowTimeAndCd()

	if var_7_0 then
		self._showTimeSchedule = self:newScheduleOnce(handler(self, self._updateView), var_7_1)
	end

	local var_7_2 = g.core.model.User.ancientsData

	self.m_Comp_points_rank:updateView(self._promoteTeams)

	if g.core.model.User.ancientsData:getTeam(var_0_1.GET_TEAM_TYPE.FINAL_TEAM) == nil then
		if g.core.model.User.ancientsData:hasFinalFightQualification() then
			if g.core.model.User.ancientsData:getAncientsState() ~= g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP then
				-- block empty
			else
				-- block empty
			end
		end

		if g.core.model.User.ancientsData:isTeamUserLeader(g.core.model.User:getId(), var_0_1.GET_TEAM_TYPE.FINAL_TEAM) then
			local var_7_5 = g.core.model.User.ancientsData:getTeam(var_0_1.GET_TEAM_TYPE.FINAL_TEAM) ~= nil and #g.core.model.User.ancientsData:getTeam(var_0_1.GET_TEAM_TYPE.FINAL_TEAM).users < 4 and g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP
		end
	end

	self.m_Txt_team_ranking:setText(self._playerRankIndex)
	self.m_Txt_points:setText(self._playerPoints)

	if var_7_2:getTeamId() == 0 then
		self.m_Txt_award:setVisible(false)
		self.m_Btn_prize:setVisible(false)

		return
	end

	local var_7_6 = var_7_2:getAwardProg(var_7_2:getAwardExp())

	if var_7_6.cfg then
		self.m_Btn_prize:setIcon(g.core.common.Path:getAncientsTeamBoxIcon(var_7_6.cfg.quality))
	end
end

function AncientsPointsRankingLayer:_onClickBtnPrize()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_TEAM_SPOILS_POP)
end

function AncientsPointsRankingLayer:_onClickBtnCheckRewards()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_TEAM_RANK_POP)
end

function AncientsPointsRankingLayer:_onCrossDayEvent()
	if g.core.utils.Tools.ancientsFunc.getNeedOpenModule() ~= g.view.entrance.ANCIENTS_AGAINST_LAYER then
		g.core.utils.Tools.ancientsFunc.openAncientsMainLayer(true)
	end
end

return AncientsPointsRankingLayer
