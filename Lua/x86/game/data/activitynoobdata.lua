local var_0_0 = singletonClass("ActivityNoobData")

function var_0_0.Init(arg_1_0)
	arg_1_0.openCurVersion_ = false
	arg_1_0.completedTime_ = 0
	arg_1_0.signDay_ = 0
	arg_1_0.signTimestamp_ = 0
	arg_1_0.upgradeFinishList_ = {}
	arg_1_0.rechargeStatus_ = {}
	arg_1_0.firstRechargeRewardStatus_ = {}
	arg_1_0.firstMonthlyCardStatus_ = {}
	arg_1_0.firstBattlePassStatus_ = {}
	arg_1_0.unlockPhase_ = 0
	arg_1_0.noobAccumulateReceivedList_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.openCurVersion_ = true
	arg_2_0.versionID_ = arg_2_1.version_id
	arg_2_0.completedTime_ = arg_2_1.completed_time

	if arg_2_1.newbie_recharge_reward then
		arg_2_0:InitRechargeData(arg_2_1.newbie_recharge_reward)
	end

	if arg_2_0:IsFinishAllActivity() == true then
		return
	end

	if arg_2_1.newbie_sign then
		arg_2_0:InitSignData(arg_2_1.newbie_sign)
	end

	if arg_2_1.newbie_level_reward then
		arg_2_0:InitUpgradeData(arg_2_1.newbie_level_reward)
	end

	if arg_2_1.trigger_time then
		arg_2_0.trigger_time = arg_2_1.trigger_time
	end

	arg_2_0.unlockPhase_ = arg_2_1.max_phase
	arg_2_0.noobAccumulateReceivedList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.got_pt_id_list) do
		arg_2_0.noobAccumulateReceivedList_[iter_2_1] = true
	end
end

function var_0_0.IsOpenCurVersion(arg_3_0)
	return arg_3_0.openCurVersion_
end

function var_0_0.GetVersionID(arg_4_0)
	return arg_4_0.versionID_
end

function var_0_0.IsFinishAllActivity(arg_5_0)
	if arg_5_0.completedTime_ == 0 then
		return false
	else
		return arg_5_0.completedTime_ <= manager.time:GetServerTime()
	end
end

function var_0_0.IsFinishClientJudge(arg_6_0)
	if arg_6_0.trigger_time then
		local var_6_0 = GameSetting.newbie_time_limit.value[1] * 24

		return arg_6_0.trigger_time + manager.time:GetHourInType(var_6_0, 2) - manager.time:GetServerTime() > 0
	end

	return false
end

function var_0_0.GetUnlockPhase(arg_7_0)
	return arg_7_0.unlockPhase_
end

function var_0_0.GetAccumulateReceivedList(arg_8_0)
	return arg_8_0.noobAccumulateReceivedList_
end

function var_0_0.SetAccumulateReceivedList(arg_9_0, arg_9_1)
	arg_9_0.noobAccumulateReceivedList_[arg_9_1] = true
end

function var_0_0.CacheSelectedPhase(arg_10_0, arg_10_1)
	arg_10_0.cachePhase_ = arg_10_1
end

function var_0_0.GetSelectedPhase(arg_11_0)
	return arg_11_0.cachePhase_
end

function var_0_0.InitSignData(arg_12_0, arg_12_1)
	arg_12_0.signDay_ = arg_12_1.now_sign_times
	arg_12_0.signTimestamp_ = arg_12_1.last_sign_timestamp

	local var_12_0 = #ActivityNewbieTools.GetSignCfg()

	if manager.time:GetTodayFreshTime() > arg_12_0.signTimestamp_ and var_12_0 > arg_12_0.signDay_ then
		local var_12_1 = math.ceil((arg_12_0.signDay_ + 1) / 7)

		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_SIGN, var_12_1), 1)
	end
end

function var_0_0.GetSignDay(arg_13_0)
	return arg_13_0.signDay_
end

function var_0_0.GetSignTimestamp(arg_14_0)
	return arg_14_0.signTimestamp_
end

function var_0_0.SignIn(arg_15_0)
	arg_15_0.signDay_ = arg_15_0.signDay_ + 1
	arg_15_0.signTimestamp_ = manager.time:GetServerTime()

	local var_15_0 = math.ceil(arg_15_0.signDay_ / 7)

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_SIGN, var_15_0), 0)
end

function var_0_0.InitUpgradeData(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1.received_level_list) do
		table.insert(arg_16_0.upgradeFinishList_, iter_16_1)
	end
end

function var_0_0.GetUpgradeFinishList(arg_17_0)
	return arg_17_0.upgradeFinishList_
end

function var_0_0.SetUpgradeFinish(arg_18_0, arg_18_1)
	table.insert(arg_18_0.upgradeFinishList_, arg_18_1)
end

function var_0_0.InitRechargeData(arg_19_0, arg_19_1)
	arg_19_0:UpdateRecharge(arg_19_1)
end

function var_0_0.UpdateRecharge(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.first_recharge_reward

	arg_20_0.firstRechargeRewardStatus_ = {
		firstGearStatus = var_20_0.first_gear_recharge_reward,
		secondGearStatus = var_20_0.second_gear_recharge_flag,
		signTimes = var_20_0.now_sign_times,
		lastSignTimestamp = var_20_0.last_sign_timestamp,
		firstGearNewTag = var_20_0.is_new_recharge_6,
		secondGearNewTag = var_20_0.is_new_recharge_18
	}

	local var_20_1 = arg_20_1.first_monthly_card_reward

	arg_20_0.firstMonthlyCardStatus_ = {
		isRecharged = var_20_1.flag,
		heroRewardFlag = var_20_1.role_reward_flag,
		signTimes = var_20_1.sign_times,
		signRewardFlag = var_20_1.sign_reward_flag,
		newTagRoleFlag = var_20_1.is_new_tag_role_reward,
		newTagSignFlag = var_20_1.is_new_tag_sign_reward
	}

	local var_20_2 = arg_20_1.first_battlepass_reward

	arg_20_0.firstBattlePassStatus_ = {
		bpRewardStatus = var_20_2.first_battlepass_reward,
		battlePassNewTag = var_20_2.is_new_battlepass_reward
	}
end

function var_0_0.GetFirstRechargeStatus(arg_21_0)
	return arg_21_0.firstRechargeRewardStatus_
end

function var_0_0.SetNewTagRoleFlag(arg_22_0, arg_22_1)
	arg_22_0.firstMonthlyCardStatus_.newTagRoleFlag = arg_22_1
end

function var_0_0.SetNewTagSignFlag(arg_23_0, arg_23_1)
	arg_23_0.firstMonthlyCardStatus_.newTagSignFlag = arg_23_1
end

function var_0_0.SetFirstGearNewTag(arg_24_0, arg_24_1)
	arg_24_0.firstRechargeRewardStatus_.firstGearNewTag = arg_24_1
end

function var_0_0.SetSecondGearNewTag(arg_25_0, arg_25_1)
	arg_25_0.firstRechargeRewardStatus_.secondGearNewTag = arg_25_1
end

function var_0_0.IsFirstRechargeNewTag(arg_26_0)
	return arg_26_0.firstMonthlyCardStatus_.newTagSignFlag or arg_26_0.firstRechargeRewardStatus_.firstGearNewTag or arg_26_0.firstRechargeRewardStatus_.secondGearNewTag or arg_26_0.firstBattlePassStatus_.battlePassNewTag
end

function var_0_0.ReceiveFirstRecharge(arg_27_0, arg_27_1)
	if arg_27_1 == 0 then
		arg_27_0.firstRechargeRewardStatus_.firstGearStatus = 2
	else
		arg_27_0.firstRechargeRewardStatus_.signTimes = arg_27_0.firstRechargeRewardStatus_.signTimes + 1
		arg_27_0.firstRechargeRewardStatus_.lastSignTimestamp = manager.time:GetServerTime()
	end
end

function var_0_0.GetFirstMonthlyCardStatus(arg_28_0)
	return arg_28_0.firstMonthlyCardStatus_
end

function var_0_0.ReceiveMonthlyCard(arg_29_0, arg_29_1)
	if arg_29_1 == 0 then
		arg_29_0.firstMonthlyCardStatus_.heroRewardFlag = true
	else
		arg_29_0.firstMonthlyCardStatus_.signRewardFlag = true
	end
end

function var_0_0.SetMonthlyCardSign(arg_30_0)
	return
end

function var_0_0.GetBattlePassStatus(arg_31_0)
	return arg_31_0.firstBattlePassStatus_
end

function var_0_0.GetBpRewardStatus(arg_32_0)
	return arg_32_0.firstBattlePassStatus_.bpRewardStatus
end

function var_0_0.SetBpRewardStatus(arg_33_0)
	arg_33_0.firstBattlePassStatus_.bpRewardStatus = 2
end

function var_0_0.SetBattlePassNewTag(arg_34_0, arg_34_1)
	arg_34_0.firstBattlePassStatus_.battlePassNewTag = arg_34_1
end

function var_0_0.GetRechargeStatus(arg_35_0)
	return arg_35_0.rechargeStatus_
end

function var_0_0.GetNewbieOpenTime(arg_36_0)
	return arg_36_0.trigger_time
end

function var_0_0.SetNewbieOpenTime(arg_37_0, arg_37_1)
	arg_37_0.trigger_time = arg_37_1
end

return var_0_0
