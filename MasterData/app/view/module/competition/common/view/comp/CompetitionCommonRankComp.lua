local var_0_0 = g.core.model.User.commonCompetitionDataManager
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.const.ConstMgr.CompetitionConst
local CompetitionCommonRankComp = class("CompetitionCommonRankComp", require("app.fairyGUI.competition.UI_CompetitionCommonRankComp"))

function CompetitionCommonRankComp:ctor()
	self._rankList = {}
	self._specifyRanks = {}
	self._cdScheduler = nil
	self._activeSubId = 0

	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankListRenderer))
	self.m_rankAwardList:setVirtual()
	self.m_rankAwardList:setItemRenderer(handler(self, self._onRankAwardListRenderer))
end

function CompetitionCommonRankComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvGetCommonRank, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.updateRankList, self)
end

function CompetitionCommonRankComp:setActivitySubId(arg_3_1)
	self._activeSubId = arg_3_1
	self._competitionData = var_0_0:getDataById(arg_3_1)
end

function CompetitionCommonRankComp:updateRankComp()
	local var_4_0 = self._competitionData:getInfo()

	self.m_rankRewardIcon:setIcon(g.core.common.Path:getCompetitionRankIcon(self._activeSubId))
	self.m_detailBtn:initBtnInfo({
		type = var_4_0.rank_reward_type,
		value = var_4_0.rank_reward_value
	})

	self._rankAward = self._competitionData:getRankAwardList()

	self.m_rankAwardList:setNumItems(#self._rankAward)
	self.m_curScoreTxt:setText(g.core.lang:get(409752, {
		score = self._competitionData:getCurCompetitionScore()
	}))
	self:_refreshCountDown()

	self._cdScheduler = self._cdScheduler or self:newSchedule(handler(self, self._refreshCountDown), 60)

	if self._competitionData:getActivityData():getActivityState() == g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.END then
		self.m_rankStateController:setSelectedIndex(1)
	else
		self.m_rankStateController:setSelectedIndex(0)
	end
end

function CompetitionCommonRankComp:_onRcvGetCommonRank(arg_5_1, arg_5_2, arg_5_3)
	self._selfRank = arg_5_3.self_rank or 0
	self._rankList = arg_5_3.rank_units or {}

	if arg_5_3.specify_rank_units then
		for iter_5_0, iter_5_1 in ipairs(arg_5_3.specify_rank_units) do
			table.insert(self._rankList, iter_5_1)
		end
	end

	self:updateRankList()
	self.m_switchTransition:play()
end

function CompetitionCommonRankComp:updateRankList()
	self.m_rankList:setNumItems(#self._rankList)

	if self._selfRank == 0 then
		self.m_selfRankTxt:setText(g.core.lang:get(409700))
	else
		self.m_selfRankTxt:setText(g.core.lang:get(409701, {
			rank = self._selfRank
		}))

		if self._selfRank <= var_0_2.RANK_SIZE then
			self.m_rankList:scrollToView(self._selfRank - 1)
		end
	end
end

function CompetitionCommonRankComp:_refreshCountDown()
	local var_7_0 = self._competitionData:getActivityData():getFinishTime()

	if var_0_1:getTime() <= var_7_0 then
		local var_7_1, var_7_2, var_7_3, var_7_4 = var_0_1:getLeftTimeParts(var_7_0)

		if var_7_3 > 0 or var_7_4 > 0 then
			var_7_2 = var_7_2 + 1
		end

		self.m_activityTimeTxt:setText(g.core.lang:get(409702, {
			day = var_7_1,
			hour = var_7_2
		}))
	else
		self.m_activityTimeTxt:setText(g.core.lang:get(409704))
	end
end

function CompetitionCommonRankComp:_onRankListRenderer(arg_8_1, arg_8_2)
	if self._rankList[arg_8_1 + 1] then
		arg_8_2:updateCell(self._rankList[arg_8_1 + 1])
	end
end

function CompetitionCommonRankComp:_onRankAwardListRenderer(arg_9_1, arg_9_2)
	if self._rankAward[arg_9_1 + 1] then
		arg_9_2:updateCell(self._rankAward[arg_9_1 + 1])
	end
end

return CompetitionCommonRankComp
