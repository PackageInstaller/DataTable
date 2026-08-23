local WeeklyCompetitionConst = require("app.view.module.weeklyCompetition.const.WeeklyCompetitionConst")
local WeeklyCompetitionData = class("WeeklyCompetitionData")

function WeeklyCompetitionData:ctor()
	self:initData()
end

function WeeklyCompetitionData:initData()
	self._baseDic = {}
	self._taskInfoDic = {}
	self._rewardInfoDic = {}
	self._curBaseId = 0
	self._rareId = 0
	self._lastCacheTime = -1
	self._lastScore = -1
	self._activeId = 0
	self._isFirstReq = true
end

function WeeklyCompetitionData:_initBaseInfo(arg_3_1)
	local var_3_0 = g.core.config.weekly_competition_info.get(arg_3_1)

	self._baseDic[arg_3_1] = {
		section = 1,
		cfg = var_3_0,
		activityInfo = {},
		rewardInfoList = self:getRewardList(var_3_0.reward_group, true),
		taskInfoList = self:getTaskInfoList(var_3_0.task_group, true)
	}
end

function WeeklyCompetitionData:_updateBaseInfoByActivityInfo(arg_4_1, arg_4_2)
	self:getBaseInfo(arg_4_1).activityInfo = arg_4_2
end

function WeeklyCompetitionData:getBaseInfo(arg_5_1, arg_5_2)
	if not arg_5_1 or arg_5_1 == 0 then
		return
	end

	arg_5_1 = tonumber(arg_5_1)

	if not self._baseDic[arg_5_1] then
		self:_initBaseInfo(arg_5_1)
	elseif arg_5_2 then
		self._baseDic[arg_5_1].section = 1

		self:_resetRewardInfoList(self._baseDic[arg_5_1].cfg.reward_group)
		self:_resetTaskInfoList(self._baseDic[arg_5_1].cfg.task_group)
	end

	return self._baseDic[arg_5_1]
end

function WeeklyCompetitionData:getCurBaseInfo()
	return self:getBaseInfo(self._curBaseId)
end

function WeeklyCompetitionData:getCurBaseId()
	return self._curBaseId
end

function WeeklyCompetitionData:getActiveId()
	return self._activeId
end

function WeeklyCompetitionData:_initTaskInfoList(arg_9_1)
	local var_9_0 = {}

	for iter_9_0 = 1, g.core.config.weekly_competition_task_info.getLength() do
		local var_9_1 = g.core.config.weekly_competition_task_info.indexOf(iter_9_0)

		if var_9_1.group == arg_9_1 then
			var_9_0[#var_9_0 + 1] = {
				receiveNum = 0,
				curValue = 0,
				cfg = var_9_1,
				receiveLimit = var_9_1.frequency,
				id = var_9_1.id,
				taskKey = var_9_1.task_type .. "_" .. var_9_1.key
			}
		end
	end

	self._taskInfoDic[arg_9_1] = var_9_0
end

function WeeklyCompetitionData:getTaskInfoList(arg_10_1, arg_10_2)
	if not self._taskInfoDic[arg_10_1] then
		self:_initTaskInfoList(arg_10_1)
	end

	if arg_10_2 then
		self:_resetTaskInfoList(arg_10_1)
	end

	return self._taskInfoDic[arg_10_1]
end

function WeeklyCompetitionData:_resetTaskInfoList(arg_11_1)
	local var_11_0 = self:getTaskInfoList(arg_11_1)

	if not var_11_0 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		iter_11_1.curValue = 0
		iter_11_1.receiveNum = 0
	end
end

function WeeklyCompetitionData:_updateTaskInfo(arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in ipairs(self:getCurBaseInfo().taskInfoList) do
		if iter_12_1.id == arg_12_1 then
			iter_12_1.curValue = arg_12_2.task_progress
			iter_12_1.receiveNum = arg_12_2.task_finish_times

			break
		end
	end
end

function WeeklyCompetitionData:_initRewardInfoList(arg_13_1)
	local var_13_0 = {}

	for iter_13_0 = 1, g.core.config.weekly_competition_reward_info.getLength() do
		local var_13_1 = g.core.config.weekly_competition_reward_info.indexOf(iter_13_0)
		local var_13_6

		if var_13_1.group == arg_13_1 then
			local var_13_2 = {}
			local var_13_3 = 0

			if nil then
				var_13_3 = (nil).score
			end

			while g.core.config.weekly_competition_reward_info.hasKey("reward_type" .. 1) do
				if var_13_1["reward_size" .. 1] > 0 then
					var_13_2[#var_13_2 + 1] = {
						type = var_13_1["reward_type" .. 1],
						value = var_13_1["reward_value" .. 1],
						size = var_13_1["reward_size" .. 1]
					}
				end
			end

			local var_13_5 = var_13_0[var_13_1.section]

			if not var_13_0[var_13_1.section] then
				var_13_5 = {}
				var_13_0[var_13_1.section] = var_13_5
			end

			var_13_5[#var_13_5 + 1] = {
				cfg = var_13_1,
				awards = var_13_2,
				state = WeeklyCompetitionConst.REWARD_STATE.NONE,
				scoreInfo = {
					score = var_13_1.score,
					startScore = var_13_3
				},
				id = var_13_1.id
			}
			var_13_6 = var_13_1
		end
	end

	for iter_13_1, iter_13_2 in ipairs(var_13_0) do
		table.sort(iter_13_2, function(arg_14_0, arg_14_1)
			return arg_14_0.cfg.score < arg_14_1.cfg.score
		end)
	end

	self._rewardInfoDic[arg_13_1] = var_13_0
end

function WeeklyCompetitionData:getRewardList(arg_15_1, arg_15_2)
	if not self._rewardInfoDic[arg_15_1] then
		self:_initRewardInfoList(arg_15_1)
	end

	if arg_15_2 then
		self:_resetRewardInfoList(arg_15_1)
	end

	return self._rewardInfoDic[arg_15_1]
end

function WeeklyCompetitionData:_resetRewardInfoList(arg_16_1)
	local var_16_0 = self:getRewardList(arg_16_1)

	if not var_16_0 then
		return
	end

	local var_16_1 = self:getResourceNum()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		for iter_16_2, iter_16_3 in ipairs(iter_16_1) do
			iter_16_3.state = var_16_1 >= iter_16_3.cfg.score and WeeklyCompetitionConst.REWARD_STATE.MATCH or WeeklyCompetitionConst.REWARD_STATE.NONE
		end
	end
end

function WeeklyCompetitionData:_updateRewardInfo(arg_17_1, arg_17_2)
	local var_17_0 = self:getCurBaseInfo()
	local var_17_1 = g.core.config.weekly_competition_reward_info.get(arg_17_1).section
	local var_17_2 = #var_17_0.rewardInfoList[var_17_1]

	for iter_17_0, iter_17_1 in ipairs(var_17_0.rewardInfoList[var_17_1]) do
		if iter_17_1.id == arg_17_1 then
			iter_17_1.state = arg_17_2
		end

		if WeeklyCompetitionConst.REWARD_STATE.REWARDED == iter_17_1.state then
			var_17_2 = var_17_2 - 1
		end
	end

	if WeeklyCompetitionConst.REWARD_STATE.REWARDED == arg_17_2 then
		var_17_0.section = var_17_2 == 0 and math.min(var_17_1 + 1, #var_17_0.rewardInfoList) or var_17_1
	end
end

function WeeklyCompetitionData:_checkRewardList()
	local var_18_0 = self:getResourceNum()
	local var_18_1 = self:getCurBaseInfo()

	if var_18_1.section then
		for iter_18_0 = var_18_1.section, #var_18_1.rewardInfoList do
			for iter_18_1, iter_18_2 in ipairs(var_18_1.rewardInfoList[iter_18_0]) do
				if iter_18_2.state == WeeklyCompetitionConst.REWARD_STATE.NONE and var_18_0 >= iter_18_2.cfg.score then
					iter_18_2.state = WeeklyCompetitionConst.REWARD_STATE.MATCH
				end
			end
		end
	end
end

function WeeklyCompetitionData:getCurSection()
	return self:getCurBaseInfo().section
end

function WeeklyCompetitionData:getLastScore()
	return self._lastScore
end

function WeeklyCompetitionData:getResourceNum()
	if self._curBaseId == 0 then
		return 0
	end

	self._iconId = self._iconId or g.core.config.weekly_competition_info.get(self._curBaseId).item_id

	return g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, self._iconId)
end

function WeeklyCompetitionData:getScoreIconUrl()
	if self._curBaseId == 0 then
		return 0
	end

	self._iconUrl = self._iconUrl or g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_ITEM, g.core.config.weekly_competition_info.get(self._curBaseId).item_id, true)

	return self._iconUrl
end

function WeeklyCompetitionData:getScoreIconName()
	if self._curBaseId == 0 then
		return 0
	end

	self._iconName = self._iconName or g.core.config.item_info.get(g.core.config.weekly_competition_info.get(self._curBaseId).item_id).name

	return self._iconName
end

function WeeklyCompetitionData:isInActivity()
	local var_24_0 = self:getCurBaseInfo()

	if not var_24_0 then
		return false
	end

	local var_24_1 = g.core.common.ServerTime:getTime()

	return var_24_1 >= var_24_0.activityInfo.local_start_time and var_24_1 < var_24_0.activityInfo.local_end_time
end

function WeeklyCompetitionData:hasWeeklyCompetitionActivity()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.WEEKLY_COMPETITION) then
		return false
	end

	local var_25_0 = self:getCurBaseInfo()

	if not var_25_0 or not var_25_0.activityInfo then
		return false
	end

	local var_25_1 = var_25_0.activityInfo
	local var_25_2 = g.core.model.User:getLevel()

	if var_25_2 < var_25_0.activityInfo.level_min or not ((var_25_0.activityInfo.level_max > 0 or nil) and var_25_2 <= var_25_1.level_max) then
		return false
	end

	return self:isInActivity()
end

function WeeklyCompetitionData:hasWeeklyCompetitionActivityByBaseId(arg_26_1)
	local var_26_0 = self:getCurBaseInfo()

	return (self:hasWeeklyCompetitionActivity() or nil) and self._curBaseId == arg_26_1, (var_26_0 or nil) and var_26_0.activityInfo.local_end_time
end

function WeeklyCompetitionData:setGiftDirty()
	self._giftDirty = true
end

function WeeklyCompetitionData:hasReqInfo()
	return not self._isFirstReq
end

function WeeklyCompetitionData:isNewActivity()
	if not self:hasWeeklyCompetitionActivity() then
		return false
	end

	if self._lastCacheTime < 0 then
		self:checkAndLoadActivityCache()
	end

	return self:getCurBaseInfo().activityInfo.local_end_time ~= self._lastCacheTime
end

function WeeklyCompetitionData:saveNewActivity()
	local var_30_0 = self:getCurBaseInfo().activityInfo

	if var_30_0.local_end_time ~= self._lastCacheTime then
		g.core.common.Storage:save("weekly_competition.json", {
			lastFinishTime = var_30_0.local_end_time
		}, true)

		self._lastCacheTime = var_30_0.local_end_time
	end
end

function WeeklyCompetitionData:checkAndLoadActivityCache()
	self._lastCacheTime = (g.core.common.Storage:load("weekly_competition.json", true) or {
		lastFinishTime = 0
	}).lastFinishTime
end

function WeeklyCompetitionData:canGetBoxReward()
	local var_32_0 = self:getCurBaseInfo()
	local var_32_1 = self:getResourceNum()
	local var_32_2 = false

	for iter_32_0, iter_32_1 in ipairs(var_32_0.rewardInfoList[var_32_0.section]) do
		if iter_32_1.state ~= WeeklyCompetitionConst.REWARD_STATE.REWARDED and var_32_1 >= iter_32_1.cfg.score then
			var_32_2 = true

			break
		end
	end

	return var_32_2
end

function WeeklyCompetitionData:onS2CWeeklyCompetitionInfo(arg_33_1)
	self._isFirstReq = false

	if arg_33_1.activity == nil then
		return
	end

	local var_33_0 = self._curBaseId

	self._curBaseId = tonumber(arg_33_1.activity.sub_id)

	self:getBaseInfo(self._curBaseId, true)
	self:_updateBaseInfoByActivityInfo(self._curBaseId, arg_33_1.activity)

	for iter_33_0, iter_33_1 in ipairs(arg_33_1.reward_ids or {}) do
		self:_updateRewardInfo(iter_33_1, WeeklyCompetitionConst.REWARD_STATE.REWARDED)
	end

	for iter_33_2, iter_33_3 in ipairs(arg_33_1.task_list or {}) do
		self:_updateTaskInfo(iter_33_3.task_id, iter_33_3)
	end

	if self._giftDirty or var_33_0 ~= self._curBaseId or self._lastScore < 0 then
		g.core.model.User.giftData:refreshInTime()

		self._giftDirty = false
	end
end

function WeeklyCompetitionData:onS2CWeeklyCompetitionEnter(arg_34_1)
	self._lastScore = arg_34_1.last_score

	self:_checkRewardList()
end

function WeeklyCompetitionData:onS2CWeeklyCompetitionScoreAward(arg_35_1)
	self:_updateRewardInfo(arg_35_1.reward_id, WeeklyCompetitionConst.REWARD_STATE.REWARDED)
end

function WeeklyCompetitionData:onS2CWeeklyCompetitionGetServerInfos(arg_36_1)
	return
end

function WeeklyCompetitionData:onWeeklyCompetitionActivity(arg_37_1)
	self._isFirstReq = false
	self._curBaseId = arg_37_1.sub_id
	self._activeId = arg_37_1.activity_id

	self:getBaseInfo(self._curBaseId, true)
	self:_updateBaseInfoByActivityInfo(self._curBaseId, arg_37_1)

	if self._giftDirty or self._curBaseId ~= self._curBaseId or self._lastScore < 0 then
		g.core.model.User.giftData:refreshInTime()

		self._giftDirty = false
	end
end

function WeeklyCompetitionData:onWeeklyCompetitionUserData(arg_38_1)
	for iter_38_0, iter_38_1 in ipairs(arg_38_1.score_reward_ids or {}) do
		self:_updateRewardInfo(iter_38_1, WeeklyCompetitionConst.REWARD_STATE.REWARDED)
	end

	local var_38_1 = {}
	local var_38_2 = {}

	for iter_38_2, iter_38_3 in ipairs(arg_38_1.tasks or {}) do
		local var_38_3 = iter_38_3.award_task_nums or {}

		for iter_38_4, iter_38_5 in ipairs(iter_38_3.actions or {}) do
			var_38_1[iter_38_5.type .. "_" .. iter_38_5.key] = iter_38_5.value
		end

		for iter_38_6, iter_38_7 in ipairs(iter_38_3.award_task_ids or {}) do
			var_38_2[iter_38_7] = var_38_3[iter_38_6] or 0
		end
	end

	for iter_38_8, iter_38_9 in ipairs(self:getCurBaseInfo().taskInfoList) do
		iter_38_9.curValue = var_38_1[iter_38_9.taskKey] or 0
		iter_38_9.receiveNum = var_38_2[iter_38_9.id] or 0
	end
end

return WeeklyCompetitionData
