local var_0_0 = g.core.model.User.commonCompetitionDataManager
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.const.ConstMgr.ActivityConst
local var_0_3 = g.core.common.ServerTime
local var_0_4 = g.core.const.ConstMgr.CompetitionConst
local CompetitionCommonScoreTaskComp = class("CompetitionCommonScoreTaskComp", require("app.fairyGUI.competition.UI_CompetitionCommonScoreTaskComp"))

function CompetitionCommonScoreTaskComp:ctor()
	self._scoreInfos = {}
	self._taskTagList = {}
	self._selectTag = 1
	self._cdScheduler = nil
	self._activeSubId = 0
end

function CompetitionCommonScoreTaskComp:setActivitySubId(arg_2_1)
	self._activeSubId = arg_2_1
	self._competitionData = var_0_0:getDataById(arg_2_1)

	self:_initRegisterUI()
end

function CompetitionCommonScoreTaskComp:_initRegisterUI()
	self.m_tagTabList:setIniter()
	self.m_tagTabList:setItemRenderer(handler(self, self._onTaskTagListRenderer))
	self.m_tagTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickTabList))

	self._taskTagList = self._competitionData:getTaskTagList()

	self.m_tagTabList:setNumItems(table.nums(self._taskTagList))
	self.m_tagTabList:setSelectedIndex(self._selectTag - 1)
	self.m_scoreAwardList:setVirtual()
	self.m_scoreAwardList:doFairyBatching(false)
	self.m_scoreAwardList:setItemRenderer(handler(self, self._onScoreAwardListRenderer))
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRenderer))
end

function CompetitionCommonScoreTaskComp:updateScoreView()
	self._scoreInfos = self._competitionData:getCompetitionScoreInfoCfg()

	local var_4_0 = self._competitionData:getInfo()

	self.m_titleTxt:setText(var_4_0.show_text)
	self.m_scoreIconLoader:setIcon(var_0_1:convert({
		type = var_4_0.score_type,
		value = var_4_0.score_value
	}).icon)
	self.m_curScoreTxt:setText(self._competitionData:getCurCompetitionScore())

	local var_4_1 = math.max(0, #self._scoreInfos - 1)

	self.m_scoreAwardList:setNumItems(var_4_1)

	local var_4_2 = self:getCanGetScoreAwardIdx()

	if var_4_1 < var_4_2 then
		self.m_scoreAwardList:scrollToView(var_4_1 - 1)
	else
		self.m_scoreAwardList:scrollToView(var_4_2 - 1)
	end

	self.m_tagTabList:setNumItems(table.nums(self._taskTagList))
	self.m_finalAwardComp:updateAwardCell(self._scoreInfos[#self._scoreInfos], false, true, self._activeSubId)

	self._taskListData = self._competitionData:getTaskListByTag(self._selectTag)

	self.m_taskList:setNumItems(table.nums(self._taskListData))
	self.m_bigRewardIcon:setIcon(g.core.common.Path:getCompetitionActivityIcon(self._activeSubId))
	self.m_detailBtn:initBtnInfo({
		type = var_4_0.big_reward_type,
		value = var_4_0.big_reward_value
	})
	self:_refreshActivityCountDown()

	self._cdScheduler = self._cdScheduler or self:newSchedule(handler(self, self._onUpdateCDTime), 60)
end

function CompetitionCommonScoreTaskComp:getCanGetScoreAwardIdx()
	for iter_5_0, iter_5_1 in ipairs(self._scoreInfos) do
		local var_5_0 = self._competitionData:getScoreAwardState(iter_5_1.id)

		if var_5_0 == var_0_4.AWARD_STATE.CANGET then
			return iter_5_0
		elseif var_5_0 == var_0_4.AWARD_STATE.UNGET then
			return iter_5_0
		end
	end

	return 1
end

function CompetitionCommonScoreTaskComp:_onUpdateCDTime()
	self:_refreshActivityCountDown()
end

function CompetitionCommonScoreTaskComp:_refreshActivityCountDown()
	local var_7_0 = self._competitionData:getActivityData():getActivityState()

	if var_7_0 == var_0_2.ACTIVITY_STATE.START then
		local var_7_1, var_7_2, var_7_3, var_7_4 = var_0_3:getLeftTimeParts((self._competitionData:getActivityData():getFinishTime()))

		if var_7_3 > 0 or var_7_4 > 0 then
			var_7_2 = var_7_2 + 1
		end

		self.m_activityTimeTxt:setText(g.core.lang:get(409705, {
			day = var_7_1,
			hour = var_7_2
		}))
	elseif var_7_0 == var_0_2.ACTIVITY_STATE.END then
		local var_7_5, var_7_6, var_7_7, var_7_8 = var_0_3:getLeftTimeParts((self._competitionData:getActivityData():getExpireTime()))

		if var_7_7 > 0 or var_7_8 > 0 then
			var_7_6 = var_7_6 + 1
		end

		self.m_activityTimeTxt:setText(g.core.lang:get(409750, {
			day = var_7_5,
			hour = var_7_6
		}))
	elseif self._cdScheduler then
		self:cancelSchedule(self._cdScheduler)
	end
end

function CompetitionCommonScoreTaskComp:_onScoreAwardListRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateAwardCell(self._scoreInfos[arg_8_1 + 1], arg_8_1 + 1 == math.max(0, #self._scoreInfos - 1), false, self._activeSubId, arg_8_1 + 1)
end

function CompetitionCommonScoreTaskComp:_onTaskTagListRenderer(arg_9_1, arg_9_2)
	local var_9_0 = self._competitionData:getTagIcon(arg_9_1 + 1)

	arg_9_2:getChild("icon1"):setURL(g.core.common.Path:getCompetitionTabIcon(var_9_0 .. "_1"))
	arg_9_2:getChild("icon2"):setURL(g.core.common.Path:getCompetitionTabIcon(var_9_0 .. "_2"))

	if self._competitionData:isGetInfo() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = arg_9_2,
			customData = {
				subId = self._activeSubId,
				tag = arg_9_1 + 1
			}
		})
	end
end

function CompetitionCommonScoreTaskComp:_onClickTabList()
	local var_10_0 = self.m_tagTabList:getSelectedIndex() + 1

	if var_10_0 == self._selectTag then
		return
	end

	self._selectTag = var_10_0

	self:updateScoreView()
	self.m_switch2Transition:play()
end

function CompetitionCommonScoreTaskComp:_onTaskItemRenderer(arg_11_1, arg_11_2)
	arg_11_2:updateTaskCell(self._taskListData[arg_11_1 + 1], self._activeSubId)
end

function CompetitionCommonScoreTaskComp:playSwitchTransition()
	self.m_switchTransition:play()
end

return CompetitionCommonScoreTaskComp
