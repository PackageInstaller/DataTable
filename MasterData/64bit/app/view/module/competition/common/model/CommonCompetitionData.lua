local var_0_0 = g.core.const.ConstMgr.ActivityConst
local var_0_1 = g.core.const.ConstMgr.CompetitionConst
local var_0_2 = g.core.model.User.activityDataManager
local var_0_3 = g.core.config.competition_info
local var_0_4 = g.core.config.competition_score_info
local var_0_5 = g.core.config.competition_task_info
local CommonCompetitionData = class("CommonCompetitionData")

function CommonCompetitionData:ctor(arg_1_1)
	self._actSubId = arg_1_1
	self._scoreInfoCfg = {}
	self._taskTagStorageMap = {}
	self._taskTagIconDict = {}
	self._rankAwardCfg = {}
	self._scoreGetAwardDict = {}
	self._taskGetAwardDict = {}
	self._competitionTaskDict = {}
	self._svrRedCanAward = false
	self._isGetInfo = false
end

function CommonCompetitionData:setTaskInfoList(arg_2_1)
	self._taskTagStorageMap = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1 or {}) do
		if not self._taskTagStorageMap[iter_2_1.task_tag] then
			self._taskTagStorageMap[iter_2_1.task_tag] = {}
			self._taskTagIconDict[iter_2_1.task_tag] = iter_2_1.tab
		end

		self._taskTagStorageMap[iter_2_1.task_tag][iter_2_1.storage] = self._taskTagStorageMap[iter_2_1.task_tag][iter_2_1.storage] or {}

		table.insert(self._taskTagStorageMap[iter_2_1.task_tag][iter_2_1.storage], iter_2_1)
	end

	self:_initScoreAndTaskInfoCfg()
end

function CommonCompetitionData:getActivityData()
	return var_0_2:getShowActivityDataByCfg(var_0_0.ACTIVITY_TYPE.COMMANDER_COMPETITION, self._actSubId)
end

function CommonCompetitionData:getActivityStartTime()
	local var_4_0 = self:getActivityData()

	return (var_4_0 and var_4_0:isShow() or nil) and var_4_0:getStartTime()
end

function CommonCompetitionData:updateGetInfoData(arg_5_1)
	self._svrRedCanAward = false
	self._isGetInfo = true

	self:updateScoreGetData(arg_5_1.score_awarded)
	self:updateTaskGetData(arg_5_1.task_awarded)
	self:updateTaskData(arg_5_1.tasks)
end

function CommonCompetitionData:updateScoreGetData(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1 or {}) do
		self._scoreGetAwardDict[iter_6_1] = true
	end
end

function CommonCompetitionData:updateTaskGetData(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1 or {}) do
		self._taskGetAwardDict[iter_7_1] = true
	end
end

function CommonCompetitionData:updateTaskData(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1 or {}) do
		self._competitionTaskDict[iter_8_1.id .. "_" .. iter_8_1.key] = iter_8_1.status
	end
end

function CommonCompetitionData:updateRedData(arg_9_1)
	self._svrRedCanAward = checkbool(arg_9_1.can_award)
end

function CommonCompetitionData:_initScoreAndTaskInfoCfg()
	if next(self._scoreInfoCfg) and next(self._rankAwardCfg) then
		return
	end

	local var_10_0 = self:getInfo()
	local var_10_1 = var_10_0.score_group

	self._scoreInfoCfg = var_0_4.match(function(arg_11_0)
		return arg_11_0.group == var_10_1
	end)

	table.sort(self._scoreInfoCfg, function(arg_12_0, arg_12_1)
		return arg_12_0.score < arg_12_1.score
	end)

	self._rankAwardCfg = g.core.config.rank_award_info.match(function(arg_13_0)
		return arg_13_0.rank_type == var_10_0.rank_type and arg_13_0.activity_id == self._actSubId
	end)
end

function CommonCompetitionData:getTaskListByTag(arg_14_1, arg_14_2)
	if not arg_14_2 then
		table.sort(self._taskTagStorageMap[arg_14_1], function(arg_15_0, arg_15_1)
			local var_15_0 = self:getTaskStorageAwardIdx(arg_15_0)
			local var_15_1 = self:getTaskStorageAwardIdx(arg_15_1)

			if var_15_0 ~= var_15_1 then
				return var_15_0 < var_15_1
			end

			return self:getTaskStorageIdx(arg_15_0) < self:getTaskStorageIdx(arg_15_1)
		end)
	end

	return self._taskTagStorageMap[arg_14_1]
end

function CommonCompetitionData:getTagIcon(arg_16_1)
	return self._taskTagIconDict[arg_16_1]
end

function CommonCompetitionData:getTaskStorageAwardIdx(arg_17_1)
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		var_17_0 = iter_17_1.id

		if not self:isGetTaskAward(iter_17_1.id) then
			break
		end
	end

	local var_17_1 = 3

	if var_17_0 > 0 then
		local var_17_2 = self:getTaskState(var_17_0)

		var_17_1 = var_17_2 == var_0_1.AWARD_STATE.GETDONE and 3 or var_17_2 == var_0_1.AWARD_STATE.CANGET and 1 or 2
	end

	return var_17_1
end

function CommonCompetitionData:getTaskStorageIdx(arg_18_1)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		var_18_0 = iter_18_1.id

		if not self:isGetTaskAward(iter_18_1.id) then
			break
		end
	end

	return (var_18_0 > 0 or nil) and var_0_5.get(var_18_0).storage
end

function CommonCompetitionData:getTaskTagList()
	return self._taskTagStorageMap
end

function CommonCompetitionData:getCompetitionScoreInfoCfg()
	return self._scoreInfoCfg
end

function CommonCompetitionData:getScoreInfoByLevel(arg_21_1)
	return self._scoreInfoCfg[arg_21_1]
end

function CommonCompetitionData:getActId()
	return self._actSubId
end

function CommonCompetitionData:getInfo()
	return var_0_3.get(self._actSubId)
end

function CommonCompetitionData:getCurCompetitionScore()
	return g.core.model.User.bagData:getOwnNum(self:getInfo().score_type, self:getInfo().score_value)
end

function CommonCompetitionData:getScoreAwardState(arg_25_1)
	if self:getCurCompetitionScore() >= var_0_4.get(arg_25_1).score then
		if self:isGetScoreAward(arg_25_1) then
			return var_0_1.AWARD_STATE.GETDONE
		else
			return var_0_1.AWARD_STATE.CANGET
		end
	else
		return var_0_1.AWARD_STATE.UNGET
	end
end

function CommonCompetitionData:isGetScoreAward(arg_26_1)
	return self._scoreGetAwardDict[arg_26_1]
end

function CommonCompetitionData:isGetTaskAward(arg_27_1)
	return self._taskGetAwardDict[arg_27_1]
end

function CommonCompetitionData:getTaskState(arg_28_1)
	local var_28_0 = var_0_5.get(arg_28_1)
	local var_28_1 = self._competitionTaskDict[var_28_0.task_type .. "_" .. var_28_0.key] or 0

	if self:isGetTaskAward(arg_28_1) then
		return var_0_1.AWARD_STATE.GETDONE
	elseif var_28_1 >= var_28_0.value then
		return var_0_1.AWARD_STATE.CANGET
	else
		local var_28_2 = self:getActivityData()

		if var_28_2 and var_28_2:getActivityState() == var_0_0.ACTIVITY_STATE.END then
			return var_0_1.AWARD_STATE.ACTEND
		else
			return var_0_1.AWARD_STATE.UNGET
		end
	end
end

function CommonCompetitionData:getTaskGroup()
	return self:getInfo().task_group
end

function CommonCompetitionData:getScoreGroup()
	return self:getInfo().score_group
end

function CommonCompetitionData:getRankAwardList()
	return self._rankAwardCfg
end

function CommonCompetitionData:getSpecialRankIdx()
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(self._rankAwardCfg) do
		if iter_32_1.max_rank > var_0_1.RANK_SIZE then
			table.insert(var_32_0, iter_32_1.max_rank)
		end
	end

	return var_32_0
end

function CommonCompetitionData:getRankShowFinishTime()
	return self:getActivityData():getExpireTime()
end

function CommonCompetitionData:isGetInfo()
	return self._isGetInfo
end

function CommonCompetitionData:isShowCompetitionRank()
	local var_35_0 = false

	if self._actSubId > 0 then
		local var_35_1 = self:getInfo()

		if var_35_1.if_rank ~= 0 and var_35_1.rank_require == 1 and g.core.model.User.bagData:getOwnNum(var_35_1.require_value_1, var_35_1.require_value_2) >= var_35_1.require_value_3 then
			var_35_0 = true
		end
	end

	return var_35_0
end

function CommonCompetitionData:isHaveCanGetAwardTask(arg_36_1)
	if not self._isGetInfo then
		return self._svrRedCanAward
	end

	if arg_36_1 and arg_36_1.tag then
		for iter_36_0, iter_36_1 in ipairs((self:getTaskListByTag(arg_36_1.tag))) do
			for iter_36_2, iter_36_3 in ipairs(iter_36_1) do
				if self:getTaskState(iter_36_3.id) == var_0_1.AWARD_STATE.CANGET then
					return true
				end
			end
		end
	else
		for iter_36_4, iter_36_5 in pairs(self._taskTagStorageMap) do
			for iter_36_6, iter_36_7 in ipairs(iter_36_5) do
				for iter_36_8, iter_36_9 in ipairs(iter_36_7) do
					if self:getTaskState(iter_36_9.id) == var_0_1.AWARD_STATE.CANGET then
						return true
					end
				end
			end
		end
	end

	return false
end

function CommonCompetitionData:isHaveCanGetAwardScore(arg_37_1)
	if not self._isGetInfo then
		return self._svrRedCanAward
	end

	if not self:getActivityData() then
		return false
	end

	if arg_37_1 and arg_37_1.id then
		if self:getScoreAwardState(arg_37_1.id) == var_0_1.AWARD_STATE.CANGET then
			return true
		end
	else
		for iter_37_0, iter_37_1 in ipairs(self._scoreInfoCfg) do
			if self:getScoreAwardState(iter_37_1.id) == var_0_1.AWARD_STATE.CANGET then
				return true
			end
		end
	end

	return false
end

function CommonCompetitionData:getCanGetAwardScoreList()
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in ipairs(self._scoreInfoCfg) do
		if self:getScoreAwardState(iter_38_1.id) == var_0_1.AWARD_STATE.CANGET then
			table.insert(var_38_0, iter_38_1.id)
		end
	end

	return var_38_0
end

function CommonCompetitionData:getCanGetAwardTaskList()
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(self._taskTagStorageMap) do
		for iter_39_2, iter_39_3 in ipairs(iter_39_1) do
			for iter_39_4, iter_39_5 in ipairs(iter_39_3) do
				if self:getTaskState(iter_39_5.id) == var_0_1.AWARD_STATE.CANGET then
					table.insert(var_39_0, iter_39_5.id)
				end
			end
		end
	end

	return var_39_0
end

function CommonCompetitionData:getTabAllCanGetAwardId(arg_40_1)
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in pairs(self._taskTagStorageMap) do
		if iter_40_0 == arg_40_1 then
			for iter_40_2, iter_40_3 in ipairs(iter_40_1) do
				for iter_40_4, iter_40_5 in ipairs(iter_40_3) do
					if self:getTaskState(iter_40_5.id) == var_0_1.AWARD_STATE.CANGET then
						table.insert(var_40_0, iter_40_5.id)
					end
				end
			end
		end
	end

	return var_40_0
end

function CommonCompetitionData:isOpenCompetitionRank()
	if not self:isShowCompetitionRank() then
		return false
	end

	local var_41_0 = false

	for iter_41_0, iter_41_1 in ipairs(g.core.common.Storage:load("click_competition_rank.json", true) or {}) do
		if iter_41_1.actId == self._actSubId then
			var_41_0 = true

			break
		end
	end

	return not var_41_0
end

function CommonCompetitionData:setRankClicked()
	local var_42_0 = g.core.common.Storage:load("click_competition_rank.json", true) or {}
	local var_42_1 = false

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		if iter_42_1.actId == self._actSubId then
			var_42_1 = true

			break
		end
	end

	if not var_42_1 then
		table.insert(var_42_0, {
			actId = self._actSubId
		})
		g.core.common.Storage:save("click_competition_rank.json", var_42_0, true)
	end
end

return CommonCompetitionData
