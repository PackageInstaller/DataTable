local var_0_0 = g.core.model.User.competitionData
local CompetitionActivityMainLayer = class("CompetitionActivityMainLayer", require("app.fairyGUI.competition.UI_CompetitionActivityMainLayer"), function()
	return fgui.GComponent:create({
		resName = "CompetitionActivityMainLayer",
		pkgPath = "ui/competition/competition",
		isFullScreen = true,
		pkgName = "competition"
	}, ...)
end)

function CompetitionActivityMainLayer:ctor()
	self.m_topBarComp:setResInfoById(264)
	self:addBg("bg/competition/bg_jingsai_tujian.jpg")
	self.m_rankTab:addClickListener(handler(self, self._onClickRankTab))
	self.m_taskTab:addClickListener(handler(self, self._onClickTaskTab))
end

function CompetitionActivityMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayRefresh, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_HANDBOOK_COMPETITION_GETAWARD, self._onHandBookCompetitionGetAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_HANDBOOK_COMPETITION_SYNCTASK, self._onHandBookCompetitionSyncTask, self)
	self:_updateScoreMainView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_rankTab
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskTab
	})
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.HANDBOOK_COMPETITION)
	self.m_enterTransition:play()
end

function CompetitionActivityMainLayer:_updateScoreMainView()
	self.m_isShowRankController:setSelectedIndex(var_0_0:isShowCompetitionRank() and 1 or 0)
	self.m_scoreTaskComp:updateScoreView()
	self.m_rankComp:updateRankComp()
end

function CompetitionActivityMainLayer:_onHandBookCompetitionGetAward(arg_5_1, arg_5_2, arg_5_3)
	if arg_5_3.awards then
		g.core.module.ModuleManager:awardSummary(arg_5_3.awards)
		self:_updateScoreMainView()
	end
end

function CompetitionActivityMainLayer:_onHandBookCompetitionSyncTask()
	self:_updateScoreMainView()
end

function CompetitionActivityMainLayer:_onCrossDayRefresh()
	local var_7_0 = var_0_0:getActivityData()

	if var_7_0 and var_7_0:getActivityState() == g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.EXPIRE then
		g.core.module.ModuleManager:popModule()

		return
	end
end

function CompetitionActivityMainLayer:_onClickRankTab()
	var_0_0:setRankClicked()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_rankTab
	})
end

function CompetitionActivityMainLayer:_onClickTaskTab()
	self.m_scoreTaskComp:playSwitchTransition()
end

return CompetitionActivityMainLayer
