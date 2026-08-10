local var_0_0 = singletonClass("ActivityNewbieData")

function var_0_0.Init(arg_1_0)
	arg_1_0.openCurVersion_ = false
	arg_1_0.isCompleted_ = 1
	arg_1_0.signDay_ = 0
	arg_1_0.signTimestamp_ = 0
	arg_1_0.upgradeFinishList_ = {}
	arg_1_0.rechargeStatus_ = {}
	arg_1_0.firstRechargeRewardStatus_ = {}
	arg_1_0.firstMonthlyCardStatus_ = {}
	arg_1_0.firstBattlePassStatus_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.openCurVersion_ = true
	arg_2_0.versionID_ = 1
	arg_2_0.isCompleted_ = arg_2_1.is_completed

	if arg_2_1.newbie_recharge_reward then
		arg_2_0:InitRechargeData(arg_2_1.newbie_recharge_reward)
	end

	if arg_2_0.isFinishAllActivity_ then
		return
	end

	if arg_2_1.newbie_sign then
		arg_2_0:InitSignData(arg_2_1.newbie_sign)
	else
		manager.redPoint:setTip(RedPointConst.NEWBIE_SIGN, 1)
	end

	if arg_2_1.newbie_level_reward then
		arg_2_0:InitUpgradeData(arg_2_1.newbie_level_reward)
	end

	if arg_2_1.trigger_time then
		arg_2_0.trigger_time = arg_2_1.trigger_time
	end
end

function var_0_0.GetVersionID(arg_3_0)
	return arg_3_0.versionID_
end

function var_0_0.IsOpenCurVersion(arg_4_0)
	return arg_4_0.openCurVersion_
end

function var_0_0.IsFinishAllActivity(arg_5_0)
	return arg_5_0.isCompleted_ > 1
end

function var_0_0.IsFinishClientJudge(arg_6_0)
	if arg_6_0.trigger_time then
		local var_6_0 = GameSetting.newbie_time_limit.value[1] * 24

		return arg_6_0.trigger_time + manager.time:GetHourInType(var_6_0, 2) - manager.time:GetServerTime() > 0
	end

	return false
end

function var_0_0.InitSignData(arg_7_0, arg_7_1)
	arg_7_0.signDay_ = arg_7_1.now_sign_times
	arg_7_0.signTimestamp_ = arg_7_1.last_sign_timestamp

	local var_7_0 = #NoobVersionCfg[arg_7_0:GetVersionID()].noob_sign

	if manager.time:GetTodayFreshTime() > arg_7_0.signTimestamp_ and var_7_0 > arg_7_0.signDay_ then
		manager.redPoint:setTip(RedPointConst.NEWBIE_SIGN, 1)
	else
		manager.redPoint:setTip(RedPointConst.NEWBIE_SIGN, 0)
	end
end

function var_0_0.GetSignDay(arg_8_0)
	return arg_8_0.signDay_
end

function var_0_0.GetSignTimestamp(arg_9_0)
	return arg_9_0.signTimestamp_
end

function var_0_0.SignIn(arg_10_0)
	arg_10_0.signDay_ = arg_10_0.signDay_ + 1
	arg_10_0.signTimestamp_ = manager.time:GetServerTime()

	manager.redPoint:setTip(RedPointConst.NEWBIE_SIGN, 0)
end

function var_0_0.InitUpgradeData(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1.received_level_list) do
		table.insert(arg_11_0.upgradeFinishList_, iter_11_1)
	end
end

function var_0_0.GetUpgradeFinishList(arg_12_0)
	return arg_12_0.upgradeFinishList_
end

function var_0_0.SetUpgradeFinish(arg_13_0, arg_13_1)
	table.insert(arg_13_0.upgradeFinishList_, arg_13_1)
end

function var_0_0.InitRechargeData(arg_14_0, arg_14_1)
	arg_14_0:UpdateRecharge(arg_14_1)
end

function var_0_0.UpdateRecharge(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.first_recharge_reward

	arg_15_0.firstRechargeRewardStatus_ = {
		firstGearStatus = var_15_0.first_gear_recharge_reward,
		secondGearStatus = var_15_0.second_gear_recharge_flag,
		signTimes = var_15_0.now_sign_times,
		lastSignTimestamp = var_15_0.last_sign_timestamp,
		firstGearNewTag = var_15_0.is_new_recharge_6,
		secondGearNewTag = var_15_0.is_new_recharge_18
	}

	local var_15_1 = arg_15_1.first_monthly_card_reward

	arg_15_0.firstMonthlyCardStatus_ = {
		isRecharged = var_15_1.flag,
		heroRewardFlag = var_15_1.role_reward_flag,
		signTimes = var_15_1.sign_times,
		signRewardFlag = var_15_1.sign_reward_flag
	}

	local var_15_2 = arg_15_1.first_battlepass_reward

	arg_15_0.firstBattlePassStatus_ = {
		bpRewardStatus = var_15_2.first_battlepass_reward,
		battlePassNewTag = var_15_2.is_new_battlepass_reward
	}
end

function var_0_0.GetFirstRechargeStatus(arg_16_0)
	return arg_16_0.firstRechargeRewardStatus_
end

function var_0_0.ReceiveFirstRecharge(arg_17_0, arg_17_1)
	if arg_17_1 == 0 then
		arg_17_0.firstRechargeRewardStatus_.firstGearStatus = 2
	else
		arg_17_0.firstRechargeRewardStatus_.signTimes = arg_17_0.firstRechargeRewardStatus_.signTimes + 1
		arg_17_0.firstRechargeRewardStatus_.lastSignTimestamp = manager.time:GetServerTime()
	end
end

function var_0_0.GetFirstMonthlyCardStatus(arg_18_0)
	return arg_18_0.firstMonthlyCardStatus_
end

function var_0_0.ReceiveMonthlyCard(arg_19_0, arg_19_1)
	if arg_19_1 == 0 then
		arg_19_0.firstMonthlyCardStatus_.heroRewardFlag = true
	else
		arg_19_0.firstMonthlyCardStatus_.signRewardFlag = true
	end
end

function var_0_0.SetMonthlyCardSign(arg_20_0)
	return
end

function var_0_0.GetBattlePassStatus(arg_21_0)
	return arg_21_0.firstBattlePassStatus_
end

function var_0_0.GetBpRewardStatus(arg_22_0)
	return arg_22_0.firstBattlePassStatus_.bpRewardStatus
end

function var_0_0.SetBpRewardStatus(arg_23_0)
	arg_23_0.firstBattlePassStatus_.bpRewardStatus = 2
end

function var_0_0.GetRechargeStatus(arg_24_0)
	return arg_24_0.rechargeStatus_
end

function var_0_0.GetNewbieOpenTime(arg_25_0)
	return arg_25_0.trigger_time
end

function var_0_0.SetNewbieOpenTime(arg_26_0, arg_26_1)
	arg_26_0.trigger_time = arg_26_1
end

return var_0_0
