local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.commonCompetitionDataManager
local var_0_3 = g.core.const.ConstMgr.CompetitionConst
local CompetitionCommonActivityMainLayer = class("CompetitionCommonActivityMainLayer", require("app.fairyGUI.competition.UI_CompetitionCommonActivityMainLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/competition/competition",
		isFullScreen = true,
		pkgName = "competition",
		resName = "CompetitionCommonActivityMainLayer"
	}, ...)
end)

function CompetitionCommonActivityMainLayer:ctor(arg_2_1)
	self._activeSubId = arg_2_1
	self._competitionData = var_0_2:getDataById(arg_2_1)
	self._isGetInfo = self._competitionData:isGetInfo()
	self._isEnterEnd = false

	self:initView()
	self.m_enterTransition:play(handler(self, self._onEnterEnd))
end

function CompetitionCommonActivityMainLayer:_onEnterEnd()
	self._isEnterEnd = true

	if self._isGetInfo then
		self:_updateScoreMainView()
		var_0_0:dispatchEvent(var_0_1.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_rankTab,
			customData = {
				subId = self._activeSubId
			}
		})
		var_0_0:dispatchEvent(var_0_1.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_taskTab,
			customData = {
				subId = self._activeSubId
			}
		})
	end
end

function CompetitionCommonActivityMainLayer:initView()
	self.m_topBarComp:setResInfoById(264)
	self:addBg("bg/competition/bg_jingsai_tujian.jpg")
	self.m_scoreTaskComp:setActivitySubId(self._activeSubId)
	self.m_rankComp:setActivitySubId(self._activeSubId)
	self.m_rankTab:addClickListener(handler(self, self._onClickRankTab))

	local var_4_0 = self._competitionData:getActivityData():getActivityName()

	self.m_taskTab:setTitle(var_4_0)
	self.m_topBarComp:setTitle(var_4_0)
end

function CompetitionCommonActivityMainLayer:onLoad()
	var_0_0:addEventListener(var_0_1.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayRefresh), self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_COMPETITION_GETINFO, handler(self, self._onGetInfo), self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_COMPETITION_TASKAWARD, handler(self, self._onCompetitionGetAward), self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_COMPETITION_SCOREAWARD, handler(self, self._onCompetitionGetAward), self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_ACTION_STATUS_FLUSH, handler(self, self._onCommonCompetitionSyncTask), self)
	g.core.model.User.commonCompetitionDataManager:saveEnterActivityLayer(self._activeSubId)

	if not self._competitionData:isGetInfo() then
		g.core.network.GameNetProxy:send_C2S_Competition_GetInfo({
			activity_sub_id = self._activeSubId
		})
	end

	self:_updateScoreMainView()
end

function CompetitionCommonActivityMainLayer:_onGetInfo()
	self._isGetInfo = true

	if self._isEnterEnd then
		self:_updateScoreMainView()
		var_0_0:dispatchEvent(var_0_1.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_rankTab,
			customData = {
				subId = self._activeSubId
			}
		})
		var_0_0:dispatchEvent(var_0_1.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_taskTab,
			customData = {
				subId = self._activeSubId
			}
		})
	end
end

function CompetitionCommonActivityMainLayer:_updateScoreMainView()
	self.m_isShowRankController:setSelectedIndex(self._competitionData:isShowCompetitionRank() and 1 or 0)
	self.m_scoreTaskComp:updateScoreView()
	self.m_rankComp:updateRankComp()
end

function CompetitionCommonActivityMainLayer:_onCompetitionGetAward(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_8_4.awards)
		self:_updateScoreMainView()
	end

	if self._competitionData:isShowCompetitionRank() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_rankTab
		})
	end
end

function CompetitionCommonActivityMainLayer:_onCommonCompetitionSyncTask()
	self:_updateScoreMainView()
end

function CompetitionCommonActivityMainLayer:_onCrossDayRefresh()
	local var_10_0 = self._competitionData:getActivityData()

	if var_10_0 and var_10_0:getActivityState() == g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.EXPIRE then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function CompetitionCommonActivityMainLayer:_onClickRankTab()
	self._competitionData:setRankClicked()

	if var_0_3.RANK_ID[self._competitionData:getInfo().type] then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			id = var_0_3.RANK_ID[self._competitionData:getInfo().type],
			size = var_0_3.RANK_SIZE,
			specify_ranks = self._competitionData:getSpecialRankIdx()
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_rankTab
		})
	end
end

function CompetitionCommonActivityMainLayer:_onClickTaskTab()
	self.m_scoreTaskComp:playSwitchTransition()
end

return CompetitionCommonActivityMainLayer
