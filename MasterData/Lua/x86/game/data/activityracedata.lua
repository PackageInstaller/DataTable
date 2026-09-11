local var_0_0 = singletonClass("ActivityRaceData")

function var_0_0.Init(arg_1_0)
	arg_1_0.affixList_ = {}
	arg_1_0.activityStateList_ = {}
	arg_1_0.receivedTaskList_ = {}
end

function var_0_0:SetData(arg_2_1)
	if arg_2_1.info ~= nil then
		self.activityStateList_[arg_2_1.activity_id] = {}
		self.activityStateList_[arg_2_1.activity_id].unlockStageList = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.info.chapter_progress) do
			self.activityStateList_[arg_2_1.activity_id].unlockStageList[iter_2_1] = true
		end

		self.activityStateList_[arg_2_1.activity_id].completedStageList = {}

		for iter_2_2, iter_2_3 in ipairs(arg_2_1.info.clear_progress) do
			self.activityStateList_[arg_2_1.activity_id].completedStageList[iter_2_3] = true
		end

		self.activityStateList_[arg_2_1.activity_id].score = arg_2_1.info.boss_challenge_score
		self.activityStateList_[arg_2_1.activity_id].accumulativeScore = tonumber(arg_2_1.info.total_score)
		self.receivedTaskList_[arg_2_1.activity_id] = {}

		for iter_2_4, iter_2_5 in ipairs(arg_2_1.info.admitted_award_list) do
			self.receivedTaskList_[arg_2_1.activity_id][iter_2_5] = true
		end

		self:RefreshUnReceiveCount(arg_2_1.activity_id)

		self.affixList_[arg_2_1.activity_id] = {}

		for iter_2_6, iter_2_7 in ipairs(arg_2_1.info.affix_list) do
			self.affixList_[arg_2_1.activity_id][ActivityAffixPoolCfg[iter_2_7].affix[1]] = iter_2_7
		end

		self:RefreshCompleteRedPoint(arg_2_1.activity_id)
		self:RefreshRewardRedPoint(arg_2_1.activity_id)
	end
end

function var_0_0:SetCompleteStage(arg_3_1, arg_3_2)
	self.activityStateList_[arg_3_1].completedStageList[arg_3_2] = true

	if table.keyof(ActivityRaceCfg[arg_3_1].stage_list, arg_3_2) + 1 <= #ActivityRaceCfg[arg_3_1].stage_list then
		self.activityStateList_[arg_3_1].unlockStageList[ActivityRaceCfg[arg_3_1].stage_list[table.keyof(ActivityRaceCfg[arg_3_1].stage_list, arg_3_2) + 1]] = true
	end

	self:RefreshUnReceiveCount(arg_3_1)
	self:RefreshRewardRedPoint(arg_3_1)
end

function var_0_0:RefreshUnReceiveCount(arg_4_1)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(ActivityRaceCfg[arg_4_1].task_list_id) do
		if self.activityStateList_[arg_4_1].accumulativeScore >= ActivityPointRewardCfg[iter_4_1].need and self.receivedTaskList_[arg_4_1][iter_4_1] == nil then
			var_4_0 = var_4_0 + 1
		end
	end

	for iter_4_2, iter_4_3 in ipairs(ActivityRaceCfg[arg_4_1].task_list) do
		if self.activityStateList_[arg_4_1].score >= ActivityPointRewardCfg[iter_4_3].need and self.receivedTaskList_[arg_4_1][iter_4_3] == nil then
			var_4_0 = var_4_0 + 1
		end
	end

	self.activityStateList_[arg_4_1].unreceiveCount = var_4_0
end

function var_0_0:GetSortedRewardList(arg_5_1)
	local var_5_0 = ActivityRaceCfg.get_id_list_by_main_activity_id[arg_5_1]

	if ActivityRaceCfg.get_id_list_by_main_activity_id[arg_5_1] == nil then
		var_5_0 = {
			arg_5_1
		}
	end

	local var_5_1 = {}
	local var_5_2 = {}
	local var_5_3 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if self.activityStateList_[iter_5_1] == nil or self.activityStateList_[iter_5_1].unreceiveCount == 0 then
			var_5_2[#var_5_2 + 1] = iter_5_1
		else
			var_5_3[#var_5_3 + 1] = iter_5_1
		end
	end

	table.insertto(var_5_1, var_5_3)
	table.insertto(var_5_1, var_5_2)

	return var_5_1
end

function var_0_0:SetReceivedTaskList(arg_6_1, arg_6_2)
	self.receivedTaskList_[arg_6_1][arg_6_2] = true
	self.activityStateList_[arg_6_1].unreceiveCount = self.activityStateList_[arg_6_1].unreceiveCount - 1

	self:RefreshRewardRedPoint(arg_6_1)
end

function var_0_0:GetReceivedTaskList(arg_7_1)
	return self.receivedTaskList_[arg_7_1] or {}
end

function var_0_0:GetTotalScore(arg_8_1)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(ActivityRaceCfg.get_id_list_by_main_activity_id[arg_8_1]) do
		var_8_0 = var_8_0 + (self.activityStateList_[iter_8_1] and self.activityStateList_[iter_8_1].score or 0)
	end

	return var_8_0
end

function var_0_0:SetScore(arg_9_1, arg_9_2)
	if arg_9_2 and arg_9_2 > self.activityStateList_[arg_9_1].score then
		self.activityStateList_[arg_9_1].score = arg_9_2

		self:RefreshUnReceiveCount(arg_9_1)
	end

	for iter_9_0, iter_9_1 in ipairs(ActivityRaceCfg[arg_9_1].task_list_id) do
		if ActivityPointRewardCfg[iter_9_1].need > self.activityStateList_[arg_9_1].accumulativeScore then
			self.activityStateList_[arg_9_1].accumulativeScore = self.activityStateList_[arg_9_1].accumulativeScore + arg_9_2

			return
		end
	end
end

function var_0_0:GetStateList()
	return self.activityStateList_
end

function var_0_0:GetUnlockAffixList(arg_11_1)
	return self.affixList_[arg_11_1] or {}
end

function var_0_0:SetDropAffixes(arg_12_1)
	self.dropAffixList_ = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.affix_list) do
		self.dropAffixList_[#self.dropAffixList_ + 1] = ActivityAffixPoolCfg[iter_12_1].affix[1]

		if self.affixList_[self.tempActivityID_][ActivityAffixPoolCfg[iter_12_1].affix[1]] == nil then
			self.affixList_[self.tempActivityID_][ActivityAffixPoolCfg[iter_12_1].affix[1]] = iter_12_1
		else
			local var_12_0 = ActivityRaceAffixLevelUpCfg[iter_12_1].affix_list
			local var_12_1 = table.keyof(ActivityRaceAffixLevelUpCfg[iter_12_1].affix_list, self.affixList_[self.tempActivityID_][ActivityAffixPoolCfg[iter_12_1].affix[1]]) + 1

			if var_12_1 <= #ActivityRaceAffixLevelUpCfg[iter_12_1].affix_list then
				self.affixList_[self.tempActivityID_][ActivityAffixPoolCfg[iter_12_1].affix[1]] = var_12_0[var_12_1]
			end
		end
	end
end

function var_0_0.SetTempActivityID(arg_13_0, arg_13_1)
	arg_13_0.tempActivityID_ = arg_13_1
end

function var_0_0:GetDropAffixes()
	local var_14_0

	if self.dropAffixList_ ~= nil then
		var_14_0 = deepClone(self.dropAffixList_)
		self.dropAffixList_ = nil
	end

	return var_14_0
end

function var_0_0:SetSelectActivityID(arg_15_1)
	if self.activityStateList_[arg_15_1].unreceiveCount <= 0 then
		manager.redPoint:setTip(string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, ActivityRaceCfg[arg_15_1].main_activity_id, arg_15_1), 0)
	end
end

function var_0_0:RefreshCompleteRedPoint(arg_16_1)
	if ActivityData:GetActivityIsOpen(arg_16_1) and self.activityStateList_[arg_16_1].score <= 0 then
		manager.redPoint:setTip(string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, ActivityRaceCfg[arg_16_1].main_activity_id, arg_16_1), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, ActivityRaceCfg[arg_16_1].main_activity_id, arg_16_1), 0)
	end
end

function var_0_0:RefreshRewardRedPoint(arg_17_1)
	if self.activityStateList_[arg_17_1].unreceiveCount > 0 then
		manager.redPoint:setTip(string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, ActivityRaceCfg[arg_17_1].main_activity_id, arg_17_1), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, ActivityRaceCfg[arg_17_1].main_activity_id, arg_17_1), 0)
	end
end

return var_0_0
