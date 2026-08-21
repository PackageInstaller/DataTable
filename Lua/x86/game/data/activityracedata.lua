local var_0_0 = singletonClass("ActivityRaceData")

function var_0_0.Init(arg_1_0)
	arg_1_0.affixList_ = {}
	arg_1_0.activityStateList_ = {}
	arg_1_0.receivedTaskList_ = {}
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	if arg_2_1.info ~= nil then
		local var_2_0 = arg_2_1.activity_id
		local var_2_1 = arg_2_1.info

		arg_2_0.activityStateList_[var_2_0] = {}
		arg_2_0.activityStateList_[var_2_0].unlockStageList = {}

		for iter_2_0, iter_2_1 in ipairs(var_2_1.chapter_progress) do
			arg_2_0.activityStateList_[var_2_0].unlockStageList[iter_2_1] = true
		end

		arg_2_0.activityStateList_[var_2_0].completedStageList = {}

		for iter_2_2, iter_2_3 in ipairs(var_2_1.clear_progress) do
			arg_2_0.activityStateList_[var_2_0].completedStageList[iter_2_3] = true
		end

		arg_2_0.activityStateList_[var_2_0].score = var_2_1.boss_challenge_score
		arg_2_0.activityStateList_[var_2_0].accumulativeScore = tonumber(var_2_1.total_score)
		arg_2_0.receivedTaskList_[var_2_0] = {}

		for iter_2_4, iter_2_5 in ipairs(var_2_1.admitted_award_list) do
			arg_2_0.receivedTaskList_[var_2_0][iter_2_5] = true
		end

		arg_2_0:RefreshUnReceiveCount(var_2_0)

		arg_2_0.affixList_[var_2_0] = {}

		for iter_2_6, iter_2_7 in ipairs(var_2_1.affix_list) do
			local var_2_2 = ActivityAffixPoolCfg[iter_2_7].affix[1]

			arg_2_0.affixList_[var_2_0][var_2_2] = iter_2_7
		end

		arg_2_0:RefreshCompleteRedPoint(var_2_0)
		arg_2_0:RefreshRewardRedPoint(var_2_0)
	end
end

function var_0_0.SetCompleteStage(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = ActivityRaceCfg[arg_3_1].stage_list
	local var_3_1 = table.keyof(var_3_0, arg_3_2)

	arg_3_0.activityStateList_[arg_3_1].completedStageList[arg_3_2] = true

	local var_3_2 = var_3_1 + 1

	if var_3_2 <= #var_3_0 then
		arg_3_0.activityStateList_[arg_3_1].unlockStageList[var_3_0[var_3_2]] = true
	end

	arg_3_0:RefreshUnReceiveCount(arg_3_1)
	arg_3_0:RefreshRewardRedPoint(arg_3_1)
end

function var_0_0.RefreshUnReceiveCount(arg_4_0, arg_4_1)
	local var_4_0 = ActivityRaceCfg[arg_4_1].task_list_id
	local var_4_1 = arg_4_0.activityStateList_[arg_4_1].accumulativeScore
	local var_4_2 = ActivityRaceCfg[arg_4_1].task_list
	local var_4_3 = arg_4_0.activityStateList_[arg_4_1].score
	local var_4_4 = 0

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if var_4_1 >= ActivityPointRewardCfg[iter_4_1].need and arg_4_0.receivedTaskList_[arg_4_1][iter_4_1] == nil then
			var_4_4 = var_4_4 + 1
		end
	end

	for iter_4_2, iter_4_3 in ipairs(var_4_2) do
		if var_4_3 >= ActivityPointRewardCfg[iter_4_3].need and arg_4_0.receivedTaskList_[arg_4_1][iter_4_3] == nil then
			var_4_4 = var_4_4 + 1
		end
	end

	arg_4_0.activityStateList_[arg_4_1].unreceiveCount = var_4_4
end

function var_0_0.GetSortedRewardList(arg_5_0, arg_5_1)
	local var_5_0 = ActivityRaceCfg.get_id_list_by_main_activity_id[arg_5_1]

	if var_5_0 == nil then
		var_5_0 = {
			arg_5_1
		}
	end

	local var_5_1 = {}
	local var_5_2 = {}
	local var_5_3 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_4 = arg_5_0.activityStateList_[iter_5_1]

		if var_5_4 == nil or var_5_4.unreceiveCount == 0 then
			var_5_2[#var_5_2 + 1] = iter_5_1
		else
			var_5_3[#var_5_3 + 1] = iter_5_1
		end
	end

	table.insertto(var_5_1, var_5_3)
	table.insertto(var_5_1, var_5_2)

	return var_5_1
end

function var_0_0.SetReceivedTaskList(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.receivedTaskList_[arg_6_1][arg_6_2] = true
	arg_6_0.activityStateList_[arg_6_1].unreceiveCount = arg_6_0.activityStateList_[arg_6_1].unreceiveCount - 1

	arg_6_0:RefreshRewardRedPoint(arg_6_1)
end

function var_0_0.GetReceivedTaskList(arg_7_0, arg_7_1)
	return arg_7_0.receivedTaskList_[arg_7_1] or {}
end

function var_0_0.GetTotalScore(arg_8_0, arg_8_1)
	local var_8_0 = ActivityRaceCfg.get_id_list_by_main_activity_id[arg_8_1]
	local var_8_1 = 0
	local var_8_2

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		var_8_1 = var_8_1 + (arg_8_0.activityStateList_[iter_8_1] and arg_8_0.activityStateList_[iter_8_1].score or 0)
	end

	return var_8_1
end

function var_0_0.SetScore(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 and arg_9_2 > arg_9_0.activityStateList_[arg_9_1].score then
		arg_9_0.activityStateList_[arg_9_1].score = arg_9_2

		arg_9_0:RefreshUnReceiveCount(arg_9_1)
	end

	local var_9_0 = ActivityRaceCfg[arg_9_1].task_list_id

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if ActivityPointRewardCfg[iter_9_1].need > arg_9_0.activityStateList_[arg_9_1].accumulativeScore then
			arg_9_0.activityStateList_[arg_9_1].accumulativeScore = arg_9_0.activityStateList_[arg_9_1].accumulativeScore + arg_9_2

			return
		end
	end
end

function var_0_0.GetStateList(arg_10_0)
	return arg_10_0.activityStateList_
end

function var_0_0.GetUnlockAffixList(arg_11_0, arg_11_1)
	return arg_11_0.affixList_[arg_11_1] or {}
end

function var_0_0.SetDropAffixes(arg_12_0, arg_12_1)
	arg_12_0.dropAffixList_ = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.affix_list) do
		local var_12_0 = ActivityAffixPoolCfg[iter_12_1].affix[1]

		arg_12_0.dropAffixList_[#arg_12_0.dropAffixList_ + 1] = var_12_0

		if arg_12_0.affixList_[arg_12_0.tempActivityID_][var_12_0] == nil then
			arg_12_0.affixList_[arg_12_0.tempActivityID_][var_12_0] = iter_12_1
		else
			local var_12_1 = ActivityRaceAffixLevelUpCfg[iter_12_1].affix_list
			local var_12_2 = arg_12_0.affixList_[arg_12_0.tempActivityID_][var_12_0]
			local var_12_3 = table.keyof(var_12_1, var_12_2) + 1

			if var_12_3 <= #var_12_1 then
				arg_12_0.affixList_[arg_12_0.tempActivityID_][var_12_0] = var_12_1[var_12_3]
			end
		end
	end
end

function var_0_0.SetTempActivityID(arg_13_0, arg_13_1)
	arg_13_0.tempActivityID_ = arg_13_1
end

function var_0_0.GetDropAffixes(arg_14_0)
	local var_14_0

	if arg_14_0.dropAffixList_ ~= nil then
		var_14_0 = deepClone(arg_14_0.dropAffixList_)
		arg_14_0.dropAffixList_ = nil
	end

	return var_14_0
end

function var_0_0.SetSelectActivityID(arg_15_0, arg_15_1)
	local var_15_0 = ActivityRaceCfg[arg_15_1].main_activity_id

	if arg_15_0.activityStateList_[arg_15_1].unreceiveCount <= 0 then
		manager.redPoint:setTip(string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, var_15_0, arg_15_1), 0)
	end
end

function var_0_0.RefreshCompleteRedPoint(arg_16_0, arg_16_1)
	local var_16_0 = ActivityRaceCfg[arg_16_1].main_activity_id

	if ActivityData:GetActivityIsOpen(arg_16_1) and arg_16_0.activityStateList_[arg_16_1].score <= 0 then
		manager.redPoint:setTip(string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, var_16_0, arg_16_1), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, var_16_0, arg_16_1), 0)
	end
end

function var_0_0.RefreshRewardRedPoint(arg_17_0, arg_17_1)
	local var_17_0 = ActivityRaceCfg[arg_17_1].main_activity_id

	if arg_17_0.activityStateList_[arg_17_1].unreceiveCount > 0 then
		manager.redPoint:setTip(string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, var_17_0, arg_17_1), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, var_17_0, arg_17_1), 0)
	end
end

return var_0_0
