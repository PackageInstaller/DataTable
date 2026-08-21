local var_0_0 = singletonClass("RaceTrialData")

function var_0_0.Init(arg_1_0)
	arg_1_0.totalScore_ = 0
	arg_1_0.battleData_ = {
		get_id_list = {}
	}
	arg_1_0.scoreRewardData_ = {}
	arg_1_0.battleState_ = {
		complete = 2,
		received = 3,
		incomplete = 1
	}
	arg_1_0.mainActivityIdDic_ = {}
end

function var_0_0.InitConst(arg_2_0, arg_2_1)
	arg_2_0.mainActivityIdDic_ = {}

	local var_2_0 = ActivityData:GetActivityData(arg_2_1).subActivityIdList

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		arg_2_0.mainActivityIdDic_[iter_2_1] = arg_2_1
	end
end

function var_0_0.GetMainActivityID(arg_3_0, arg_3_1)
	return arg_3_0.mainActivityIdDic_[arg_3_1]
end

function var_0_0.InitData(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.activity_id

	RaceTrialAction.InitRedPointKey(var_4_0)
	arg_4_0:InitConst(var_4_0)
	arg_4_0:ModifyScoreRewardData(arg_4_1.got_reward_list or {})
	arg_4_0:RefreshScoreRedPoint(var_4_0)
end

function var_0_0.InitBattleData(arg_5_0, arg_5_1)
	local var_5_0 = ActivityData:GetActivityData(arg_5_1).subActivityIdList

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		arg_5_0.battleData_[iter_5_1] = {
			point = 0,
			state = 1,
			id = iter_5_1,
			customList = {}
		}

		arg_5_0:RefreshBattleRedPoint(iter_5_1)
		arg_5_0:RefreshFirstRedPoint(iter_5_1)
	end

	arg_5_0:RefreshScoreRedPoint(arg_5_1)

	arg_5_0.battleData_.get_id_list = {}
end

function var_0_0.InitScoreRewardData(arg_6_0, arg_6_1)
	local var_6_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_6_1]

	if var_6_0 ~= nil then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			arg_6_0.scoreRewardData_[iter_6_1] = {}
			arg_6_0.scoreRewardData_[iter_6_1].id = iter_6_1
			arg_6_0.scoreRewardData_[iter_6_1].receive_flag = false
		end
	end
end

function var_0_0.ModifyScoreRewardData(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		arg_7_0.scoreRewardData_[iter_7_1].receive_flag = true
	end
end

function var_0_0.RefreshBattleData(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.challenge
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0.custom_affix_list) do
		var_8_1[iter_8_0] = iter_8_1
	end

	arg_8_0.battleData_[var_8_0.activity_id] = {
		id = var_8_0.activity_id,
		state = var_8_0.first_clear_reward_apply_state,
		customList = var_8_1,
		point = var_8_0.point
	}

	arg_8_0:RefreshRedPoint(var_8_0.activity_id, arg_8_0:GetMainActivityID(var_8_0.activity_id))
end

function var_0_0.GetTotalScore(arg_9_0, arg_9_1)
	arg_9_0.totalScore_ = 0

	local var_9_0 = ActivityData:GetActivityData(arg_9_1).subActivityIdList

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = arg_9_0.battleData_[iter_9_1]

		arg_9_0.totalScore_ = arg_9_0.totalScore_ + (var_9_1 and var_9_1.point or 0)
	end

	return arg_9_0.totalScore_
end

function var_0_0.GetCurLv(arg_10_0, arg_10_1)
	local var_10_0
	local var_10_1 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_10_1]

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_2 = arg_10_0.scoreRewardData_[iter_10_1]

		if not var_10_2.receive_flag then
			return var_10_2.id
		end
	end

	return var_10_1[#var_10_1]
end

function var_0_0.GetFirstRewardSortList(arg_11_0, arg_11_1)
	local var_11_0
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = {}
	local var_11_4 = {}
	local var_11_5 = ActivityData:GetActivityData(arg_11_1).subActivityIdList

	for iter_11_0, iter_11_1 in ipairs(var_11_5) do
		local var_11_6 = arg_11_0.battleData_[iter_11_1]

		if var_11_6.state == arg_11_0.battleState_.incomplete then
			table.insert(var_11_3, iter_11_1)
		elseif var_11_6.state == arg_11_0.battleState_.complete then
			table.insert(var_11_2, iter_11_1)
		elseif var_11_6.state == arg_11_0.battleState_.received then
			table.insert(var_11_4, iter_11_1)
		end
	end

	table.insertto(var_11_1, var_11_2)
	table.insertto(var_11_1, var_11_3)
	table.insertto(var_11_1, var_11_4)

	return var_11_1, var_11_2
end

function var_0_0.GetBattleData(arg_12_0, arg_12_1)
	return arg_12_0.battleData_[arg_12_1]
end

function var_0_0.GetScoreRewardSortList(arg_13_0, arg_13_1)
	local var_13_0
	local var_13_1
	local var_13_2 = {}
	local var_13_3 = {}
	local var_13_4 = {}
	local var_13_5 = {}
	local var_13_6 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_13_1]

	for iter_13_0, iter_13_1 in ipairs(var_13_6) do
		local var_13_7 = arg_13_0.scoreRewardData_[iter_13_1]
		local var_13_8 = ActivityPointRewardCfg[iter_13_1].need

		if var_13_7.receive_flag then
			table.insert(var_13_5, var_13_7.id)
		elseif var_13_8 <= arg_13_0.totalScore_ then
			table.insert(var_13_3, var_13_7.id)
		else
			table.insert(var_13_4, var_13_7.id)
		end
	end

	table.insertto(var_13_2, var_13_3)
	table.insertto(var_13_2, var_13_4)
	table.insertto(var_13_2, var_13_5)

	return var_13_2
end

function var_0_0.GetScoreRewardByID(arg_14_0, arg_14_1)
	return arg_14_0.scoreRewardData_[arg_14_1]
end

function var_0_0.GetRaceTrialStartTime(arg_15_0, arg_15_1)
	return ActivityData:GetActivityData(arg_15_1).startTime
end

function var_0_0.GetRaceTrialEndTime(arg_16_0, arg_16_1)
	return ActivityData:GetActivityData(arg_16_1).stopTime
end

function var_0_0.GetCustomList(arg_17_0, arg_17_1)
	return arg_17_0.battleData_[arg_17_1].customList
end

function var_0_0.GetCustomListByStageID(arg_18_0, arg_18_1)
	local var_18_0
	local var_18_1 = ActivityRaceTrialCfg.all

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		local var_18_2 = ActivityRaceTrialCfg[iter_18_1]

		if arg_18_1 == var_18_2.stage_id then
			return arg_18_0.battleData_[var_18_2.id].customList
		end
	end

	print("匹配出错")

	return {}
end

function var_0_0.ReceiveScoreReward(arg_19_0, arg_19_1)
	arg_19_0.scoreRewardData_[arg_19_1].receive_flag = true

	local var_19_0 = ActivityPointRewardCfg[arg_19_1].activity_id

	arg_19_0:RefreshScoreRedPoint(var_19_0)
end

function var_0_0.ReceiveFirstReward(arg_20_0, arg_20_1)
	arg_20_0.battleData_[arg_20_1].state = arg_20_0.battleState_.received

	arg_20_0:RefreshFirstRedPoint(arg_20_1)
end

function var_0_0.SaveCustomList(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2 = arg_21_2 or {}
	arg_21_0.battleData_[arg_21_1].customList = arg_21_2
end

function var_0_0.RefreshRedPoint(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:RefreshBattleRedPoint(arg_22_1)
	arg_22_0:RefreshScoreRedPoint(arg_22_2)
	arg_22_0:RefreshFirstRedPoint(arg_22_1)
end

function var_0_0.RefreshBattleRedPoint(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.battleData_[arg_23_1]
	local var_23_1 = arg_23_0:GetMainActivityID(arg_23_1)
	local var_23_2 = 1
	local var_23_3 = ActivityData:GetActivityIsOpen(arg_23_1) and var_23_0.point <= 0 and 1 or 0

	manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, var_23_1, arg_23_1), var_23_3)
end

function var_0_0.RefreshScoreRedPoint(arg_24_0, arg_24_1)
	local var_24_0 = false
	local var_24_1
	local var_24_2
	local var_24_3 = arg_24_0:GetTotalScore(arg_24_1)
	local var_24_4 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_24_1]

	for iter_24_0, iter_24_1 in ipairs(var_24_4 or {}) do
		local var_24_5 = ActivityPointRewardCfg[iter_24_1]
		local var_24_6 = arg_24_0.scoreRewardData_[iter_24_1]

		if var_24_3 >= var_24_5.need and var_24_6.receive_flag == false then
			var_24_0 = true

			break
		end
	end

	manager.redPoint:setTip(string.format("%s_%s_PointReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_24_1), var_24_0 and 1 or 0)
end

function var_0_0.RefreshFirstRedPoint(arg_25_0, arg_25_1)
	local var_25_0 = false
	local var_25_1 = arg_25_0:GetMainActivityID(arg_25_1)

	if arg_25_0.battleData_[arg_25_1].state == arg_25_0.battleState_.complete then
		var_25_0 = true
	end

	manager.redPoint:setTip(string.format("%s_%s_%d_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, var_25_1, arg_25_1), var_25_0 and 1 or 0)
end

function var_0_0.SetBattleRedPointOn(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:GetMainActivityID(arg_26_2)

	manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, var_26_0, arg_26_2), 0)
end

function var_0_0.GetBattleResultGoal(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.battleData_[arg_27_1].customList or {}
	local var_27_1 = ActivityRaceTrialCfg[arg_27_1].base_point
	local var_27_2

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		var_27_1 = var_27_1 + ActivityAffixPoolCfg[iter_27_1].point
	end

	return var_27_1
end

return var_0_0
