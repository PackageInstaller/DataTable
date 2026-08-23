local var_0_0 = g.core.model.User.competitionData
local var_0_1 = g.core.const.ConstMgr.CompetitionConst
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.config.competition_info
local var_0_4 = g.core.const.ConstMgr.ActivityConst
local var_0_5 = g.core.common.ServerTime
local CompetitionScoreTaskComp = class("CompetitionScoreTaskComp", require("app.fairyGUI.competition.UI_CompetitionScoreTaskComp"))

function CompetitionScoreTaskComp:ctor()
	self._scoreInfos = {}
	self._taskTagList = {}
	self._selectTag = 1
	self._cdScheduler = nil

	self:_initRegisterUI()
end

function CompetitionScoreTaskComp:_initRegisterUI()
	self.m_tagTabList:setIniter()
	self.m_tagTabList:setItemRenderer(handler(self, self._onTaskTagListRenderer))
	self.m_tagTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickTabList))

	self._taskTagList = var_0_0:getTaskTagList()

	self.m_tagTabList:setNumItems(table.nums(self._taskTagList))
	self.m_tagTabList:setSelectedIndex(self._selectTag - 1)
	self.m_scoreAwardList:setVirtual()
	self.m_scoreAwardList:doFairyBatching(false)
	self.m_scoreAwardList:setItemRenderer(handler(self, self._onScoreAwardListRenderer))
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRenderer))
end

function CompetitionScoreTaskComp:updateScoreView()
	self._scoreInfos = var_0_0:getCompetitionScoreInfoCfg()

	self.m_scoreIconLoader:setIcon(var_0_2:convert({
		type = var_0_2.TYPE_RESOURCE,
		value = var_0_1.COMPETITION_SCORE_VALUE
	}).icon)
	self.m_curScoreTxt:setText(var_0_0:getCurCompetitionScore())

	local var_3_0 = math.max(0, #self._scoreInfos - 1)

	self.m_scoreAwardList:setNumItems(var_3_0)

	local var_3_1 = self:getCanGetScoreAwardIdx()

	if var_3_0 < var_3_1 then
		self.m_scoreAwardList:scrollToView(var_3_0 - 1)
	else
		self.m_scoreAwardList:scrollToView(var_3_1 - 1)
	end

	self.m_tagTabList:setNumItems(table.nums(self._taskTagList))
	self.m_finalAwardComp:updateAwardCell(self._scoreInfos[#self._scoreInfos], false, true)

	self._taskListData = var_0_0:getTaskListByTag(self._selectTag)

	self.m_taskList:setNumItems(table.nums(self._taskListData))

	local var_3_2 = var_0_3.get(var_0_0:getCompetitionActId())

	if var_3_2.big_reward_type == var_0_2.TYPE_SKIN then
		self.m_bigRewardIcon:setIcon((g.core.common.Path:getMiddleKnightPicById(g.core.config.knight_base_info.get(g.core.config.skin_info.get(var_3_2.big_reward_value).res).painted_id)))
		self.m_detailBtn:initBtnInfo({
			type = var_3_2.big_reward_type,
			value = var_3_2.big_reward_value
		})
	end

	self:_refreshActivityCountDown()

	self._cdScheduler = self._cdScheduler or self:newSchedule(handler(self, self._onUpdateCDTime), 60)
end

function CompetitionScoreTaskComp:_onUpdateCDTime()
	self:_refreshActivityCountDown()
end

function CompetitionScoreTaskComp:_refreshActivityCountDown()
	local var_5_0 = var_0_0:getActivityData():getActivityState()

	if var_5_0 == var_0_4.ACTIVITY_STATE.START then
		local var_5_1, var_5_2, var_5_3, var_5_4 = var_0_5:getLeftTimeParts((var_0_0:getActivityData():getFinishTime()))

		if var_5_3 > 0 or var_5_4 > 0 then
			var_5_2 = var_5_2 + 1
		end

		self.m_activityTimeTxt:setText(g.core.lang:get(409705, {
			day = var_5_1,
			hour = var_5_2
		}))
	elseif var_5_0 == var_0_4.ACTIVITY_STATE.END then
		local var_5_5, var_5_6, var_5_7, var_5_8 = var_0_5:getLeftTimeParts((var_0_0:getActivityData():getExpireTime()))

		if var_5_7 > 0 or var_5_8 > 0 then
			var_5_6 = var_5_6 + 1
		end

		self.m_activityTimeTxt:setText(g.core.lang:get(409750, {
			day = var_5_5,
			hour = var_5_6
		}))
	elseif self._cdScheduler then
		self:cancelSchedule(self._cdScheduler)
	end
end

function CompetitionScoreTaskComp:_onScoreAwardListRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateAwardCell(self._scoreInfos[arg_6_1 + 1], arg_6_1 + 1 == math.max(0, #self._scoreInfos - 1), false)
end

function CompetitionScoreTaskComp:_onTaskTagListRenderer(arg_7_1, arg_7_2)
	arg_7_2:getChild("icon1"):setURL(var_0_1.TASK_TAG_ICON[arg_7_1 + 1] .. "1")
	arg_7_2:getChild("icon2"):setURL(var_0_1.TASK_TAG_ICON[arg_7_1 + 1] .. "2")
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = arg_7_2,
		customData = {
			tag = arg_7_1 + 1
		}
	})
end

function CompetitionScoreTaskComp:_onClickTabList()
	local var_8_0 = self.m_tagTabList:getSelectedIndex() + 1

	if var_8_0 == self._selectTag then
		return
	end

	self._selectTag = var_8_0

	self:updateScoreView()
	self.m_switch2Transition:play()
end

function CompetitionScoreTaskComp:_onTaskItemRenderer(arg_9_1, arg_9_2)
	arg_9_2:updateTaskCell(self._taskListData[arg_9_1 + 1])
end

function CompetitionScoreTaskComp:playSwitchTransition()
	self.m_switchTransition:play()
end

function CompetitionScoreTaskComp:getCanGetScoreAwardIdx()
	for iter_11_0, iter_11_1 in ipairs(self._scoreInfos) do
		local var_11_0 = var_0_0:getScoreAwardState(iter_11_1.id)

		if var_11_0 == var_0_1.AWARD_STATE.CANGET then
			return iter_11_0
		elseif var_11_0 == var_0_1.AWARD_STATE.UNGET then
			return iter_11_0
		end
	end

	return 1
end

return CompetitionScoreTaskComp
