local var_0_0 = g.core.const.ConstMgr.ActivityConst
local var_0_1 = g.core.const.ConstMgr.CompetitionConst
local var_0_2 = g.core.model.User.activityDataManager
local var_0_3 = g.core.config.competition_info
local var_0_4 = g.core.config.competition_score_info
local var_0_5 = g.core.config.competition_task_info
local var_0_6 = g.core.common.Goods
local CompetitionData = class("CompetitionData")

function CompetitionData:ctor()
	self:initData()
end

function CompetitionData:initData()
	self._activiId = 1
	self._scoreInfoCfg = {}
	self._taskInfoCfg = {}
	self._rankAwardCfg = {}
	self._scoreAwards = {}
	self._taskAwards = {}
	self._competitionTasks = {}
end

function CompetitionData:getActivityData()
	return (var_0_2:getShowActivityDataByCfg(var_0_0.ACTIVITY_TYPE.HANDBOOK, self._activiId))
end

function CompetitionData:getActivityStartTime()
	local var_4_0 = self:getActivityData()

	return (var_4_0 and var_4_0:isShow() or nil) and var_4_0:getStartTime()
end

function CompetitionData:onS2CHandbookCompetitionGetInfo(arg_5_1)
	if arg_5_1.info then
		self._activiId = arg_5_1.info.act_id or 0
	end

	if self._activiId > 0 then
		if arg_5_1.info then
			self._scoreAwards = arg_5_1.info.score_awarded or {}
		end

		if arg_5_1.info then
			self._taskAwards = arg_5_1.info.task_awarded or {}
		end

		if arg_5_1.info then
			self._competitionTasks = arg_5_1.info.tasks or {}
		end

		self:_initScoreAndTaskInfoCfg()
	end
end

function CompetitionData:onS2CHandbookCompetitionGetAward(arg_6_1)
	if arg_6_1.type == var_0_1.AWARD_TYPE.SCORE then
		self._scoreAwards = arg_6_1.awarded_tasks
	elseif arg_6_1.type == var_0_1.AWARD_TYPE.COMMON then
		self._taskAwards = arg_6_1.awarded_tasks
	end
end

function CompetitionData:onS2CHandbookCompetitionSyncTask(arg_7_1)
	if arg_7_1.task then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1.task) do
			local var_7_0 = false

			for iter_7_2, iter_7_3 in ipairs(self._competitionTasks) do
				if iter_7_1.id == iter_7_3.id and iter_7_3.num ~= iter_7_1.num then
					var_7_0 = true
					iter_7_3.num = iter_7_1.num

					break
				end
			end

			if not var_7_0 then
				table.insert(self._competitionTasks, iter_7_1)
			end
		end
	end
end

function CompetitionData:onS2CFlushRedPoint(arg_8_1)
	self._activiId = arg_8_1.act_id or 0

	if self._activiId > 0 then
		self._scoreAwards = arg_8_1.score_awarded or {}
		self._taskAwards = arg_8_1.task_awarded or {}
		self._competitionTasks = arg_8_1.tasks or {}

		self:_initScoreAndTaskInfoCfg()
	end
end

function CompetitionData:_initScoreAndTaskInfoCfg()
	if next(self._scoreInfoCfg) and next(self._scoreInfoCfg) and next(self._taskInfoCfg) and next(self._taskTagStorageMap) then
		return
	end

	local var_9_0 = var_0_3.get(self._activiId)
	local var_9_1 = var_9_0.score_group

	self._scoreInfoCfg = var_0_4.match(function(arg_10_0)
		return arg_10_0.group == var_9_1
	end)

	local var_9_2 = var_9_0.task_group

	self._taskInfoCfg = var_0_5.match(function(arg_11_0)
		return arg_11_0.group == var_9_2
	end)
	self._rankAwardCfg = g.core.config.rank_award_info.match(function(arg_12_0)
		return arg_12_0.rank_type == var_9_0.rank_type and arg_12_0.activity_id == self._activiId
	end)

	self:_initTagAndStorageTaskMap()
end

function CompetitionData:_initTagAndStorageTaskMap()
	self._taskTagStorageMap = {}

	for iter_13_0, iter_13_1 in ipairs(self._taskInfoCfg) do
		self._taskTagStorageMap[iter_13_1.task_tag] = self._taskTagStorageMap[iter_13_1.task_tag] or {}
		self._taskTagStorageMap[iter_13_1.task_tag][iter_13_1.storage] = self._taskTagStorageMap[iter_13_1.task_tag][iter_13_1.storage] or {}

		table.insert(self._taskTagStorageMap[iter_13_1.task_tag][iter_13_1.storage], iter_13_1)
	end
end

function CompetitionData:getTaskListByTag(arg_14_1)
	table.sort(self._taskTagStorageMap[arg_14_1], function(arg_15_0, arg_15_1)
		local var_15_0 = self:getTaskStorageAwardIdx(arg_15_0)
		local var_15_1 = self:getTaskStorageAwardIdx(arg_15_1)
		local var_15_2 = self:getTaskStorageIdx(arg_15_0)
		local var_15_3 = self:getTaskStorageIdx(arg_15_1)

		if var_15_0 ~= var_15_1 then
			return var_15_0 < var_15_1
		elseif var_15_2 ~= var_15_3 then
			return var_15_2 < var_15_3
		end

		return false
	end)

	return self._taskTagStorageMap[arg_14_1]
end

function CompetitionData:getTaskStorageAwardIdx(arg_16_1)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		var_16_0 = iter_16_1.id

		if not self:isGetTaskAward(iter_16_1.id) then
			break
		end
	end

	return (var_16_0 > 0 and self:getTaskState(var_16_0) == var_0_1.AWARD_STATE.GETDONE or nil) and 1
end

function CompetitionData:getTaskStorageIdx(arg_17_1)
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		var_17_0 = iter_17_1.id

		if not self:isGetTaskAward(iter_17_1.id) then
			break
		end
	end

	return (var_17_0 > 0 or nil) and var_0_5.get(var_17_0).storage
end

function CompetitionData:getTaskTagList()
	return self._taskTagStorageMap
end

function CompetitionData:getCompetitionScoreInfoCfg()
	return self._scoreInfoCfg
end

function CompetitionData:getCompetitionActId()
	return self._activiId
end

function CompetitionData:getCurCompetitionScore()
	return (g.core.model.User.bagData:getOwnNum(var_0_6.TYPE_RESOURCE, var_0_1.COMPETITION_SCORE_VALUE))
end

function CompetitionData:getScoreAwardState(arg_22_1)
	if self:getCurCompetitionScore() >= var_0_4.get(arg_22_1).score then
		if self:isGetScoreAward(arg_22_1) then
			return var_0_1.AWARD_STATE.GETDONE
		else
			return var_0_1.AWARD_STATE.CANGET
		end
	else
		return var_0_1.AWARD_STATE.UNGET
	end
end

function CompetitionData:isGetScoreAward(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(self._scoreAwards) do
		if iter_23_1 == arg_23_1 then
			return true
		end
	end

	return false
end

function CompetitionData:isGetTaskAward(arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(self._taskAwards) do
		if iter_24_1 == arg_24_1 then
			return true
		end
	end

	return false
end

function CompetitionData:getCompetitionTaskData(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(self._competitionTasks) do
		if iter_25_1.id == arg_25_1 then
			return iter_25_1
		end
	end
end

function CompetitionData:getTaskState(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(self._taskInfoCfg) do
		if iter_26_1.id == arg_26_1 then
			local var_26_0 = self:getCompetitionTaskData(arg_26_1)

			if var_26_0 and var_26_0.num >= iter_26_1.value then
				if self:isGetTaskAward(arg_26_1) then
					return var_0_1.AWARD_STATE.GETDONE
				else
					return var_0_1.AWARD_STATE.CANGET
				end
			end

			local var_26_1 = self:getActivityData()

			if var_26_1 and var_26_1:getActivityState() == var_0_0.ACTIVITY_STATE.END then
				return var_0_1.AWARD_STATE.ACTEND
			else
				return var_0_1.AWARD_STATE.UNGET
			end
		end
	end
end

function CompetitionData:getRankAwardList()
	return self._rankAwardCfg
end

function CompetitionData:getSpecialRankIdx()
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(self._rankAwardCfg) do
		if iter_28_1.max_rank > var_0_1.RANK_SIZE then
			table.insert(var_28_0, iter_28_1.max_rank)
		end
	end

	return var_28_0
end

function CompetitionData:getRankShowFinishTime()
	return self:getActivityData():getStartTime() + var_0_3.get(self._activiId).rank_days * 86400
end

function CompetitionData:getRankShowExpireTime()
	return self:getRankShowFinishTime() + var_0_3.get(self._activiId).rank_show * 86400
end

function CompetitionData:isShowCompetitionRank()
	local var_31_0 = false

	if self._activiId > 0 then
		local var_31_1 = var_0_3.get(self._activiId)

		if var_31_1.if_rank ~= 0 then
			if var_31_1.rank_require == 1 then
				local var_31_2 = g.core.common.ServerTime:getTime()

				if var_31_1.require_value_3 <= g.core.model.User.bagData:getOwnNum(var_31_1.require_value_1, var_31_1.require_value_2) and self:getActivityStartTime() < var_31_2 and var_31_2 <= self:getRankShowExpireTime() then
					var_31_0 = true
				end
			end
		end
	end

	return var_31_0
end

function CompetitionData:isHaveCanGetAwardTask(arg_32_1)
	if arg_32_1 and arg_32_1.tag then
		return (self:isFrontTaskCanGetAward(arg_32_1.tag))
	else
		for iter_32_0, iter_32_1 in ipairs(self._taskInfoCfg) do
			if self:isFrontTaskCanGetAward(iter_32_1.task_tag) then
				return true
			end
		end
	end

	return false
end

function CompetitionData:isFrontTaskCanGetAward(arg_33_1)
	for iter_33_0, iter_33_1 in ipairs((self:getTaskListByTag(arg_33_1))) do
		local var_33_0 = 0

		for iter_33_2, iter_33_3 in ipairs(iter_33_1) do
			var_33_0 = iter_33_3.id

			if not self:isGetTaskAward(iter_33_3.id) then
				break
			end
		end

		if var_33_0 > 0 and self:getTaskState(var_33_0) == var_0_1.AWARD_STATE.CANGET then
			return true
		end
	end

	return false
end

function CompetitionData:isHaveCanGetAwardScore(arg_34_1)
	if arg_34_1 and arg_34_1.id then
		if self:getScoreAwardState(arg_34_1.id) == var_0_1.AWARD_STATE.CANGET then
			return true
		end
	else
		for iter_34_0, iter_34_1 in ipairs(self._scoreInfoCfg) do
			if self:getScoreAwardState(iter_34_1.id) == var_0_1.AWARD_STATE.CANGET then
				return true
			end
		end
	end

	return false
end

function CompetitionData:getCanGetAwardScoreList()
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(self._scoreInfoCfg) do
		if self:getScoreAwardState(iter_35_1.id) == var_0_1.AWARD_STATE.CANGET then
			table.insert(var_35_0, iter_35_1.id)
		end
	end

	return var_35_0
end

function CompetitionData:getCanGetAwardTaskList()
	local var_36_0 = {}

	for iter_36_0, iter_36_1 in pairs(self._taskTagStorageMap) do
		for iter_36_2, iter_36_3 in ipairs(iter_36_1) do
			for iter_36_4, iter_36_5 in ipairs(iter_36_3) do
				if self:getTaskState(iter_36_5.id) == var_0_1.AWARD_STATE.CANGET then
					table.insert(var_36_0, iter_36_5.id)
				end
			end
		end
	end

	return var_36_0
end

function CompetitionData:getTabAllCanGetAwardId(arg_37_1)
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in pairs(self._taskTagStorageMap) do
		if iter_37_0 == arg_37_1 then
			for iter_37_2, iter_37_3 in ipairs(iter_37_1) do
				for iter_37_4, iter_37_5 in ipairs(iter_37_3) do
					if self:getTaskState(iter_37_5.id) == var_0_1.AWARD_STATE.CANGET then
						table.insert(var_37_0, iter_37_5.id)
					end
				end
			end
		end
	end

	return var_37_0
end

function CompetitionData:isOpenCompetitonRank()
	local var_38_0 = false

	for iter_38_0, iter_38_1 in ipairs(g.core.common.Storage:load("click_competition_rank.json", true) or {}) do
		if iter_38_1.actId == self._activiId then
			var_38_0 = true

			break
		end
	end

	return self:isShowCompetitionRank() and not var_38_0
end

function CompetitionData:setRankClicked()
	local var_39_0 = g.core.common.Storage:load("click_competition_rank.json", true) or {}
	local var_39_1 = false

	for iter_39_0, iter_39_1 in ipairs(var_39_0) do
		if iter_39_1.actId == self._activiId then
			var_39_1 = true

			break
		end
	end

	if not var_39_1 then
		table.insert(var_39_0, {
			actId = self._activiId
		})
		g.core.common.Storage:save("click_competition_rank.json", var_39_0, true)
	end
end

return CompetitionData
