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

function var_0_0:InitData(arg_2_1)
	self.openCurVersion_ = true
	self.versionID_ = 1
	self.isCompleted_ = arg_2_1.is_completed

	if arg_2_1.newbie_recharge_reward then
		self:InitRechargeData(arg_2_1.newbie_recharge_reward)
	end

	if self.isFinishAllActivity_ then
		return
	end

	if arg_2_1.newbie_sign then
		self:InitSignData(arg_2_1.newbie_sign)
	else
		manager.redPoint:setTip(RedPointConst.NEWBIE_SIGN, 1)
	end

	if arg_2_1.newbie_level_reward then
		self:InitUpgradeData(arg_2_1.newbie_level_reward)
	end

	if arg_2_1.trigger_time then
		self.trigger_time = arg_2_1.trigger_time
	end
end

function var_0_0:GetVersionID()
	return self.versionID_
end

function var_0_0:IsOpenCurVersion()
	return self.openCurVersion_
end

function var_0_0:IsFinishAllActivity()
	return self.isCompleted_ > 1
end

function var_0_0:IsFinishClientJudge()
	if self.trigger_time then
		return self.trigger_time + manager.time:GetHourInType(GameSetting.newbie_time_limit.value[1] * 24, 2) - manager.time:GetServerTime() > 0
	end

	return false
end

function var_0_0:InitSignData(arg_7_1)
	self.signDay_ = arg_7_1.now_sign_times
	self.signTimestamp_ = arg_7_1.last_sign_timestamp

	if manager.time:GetTodayFreshTime() > self.signTimestamp_ and #NoobVersionCfg[self:GetVersionID()].noob_sign > self.signDay_ then
		manager.redPoint:setTip(RedPointConst.NEWBIE_SIGN, 1)
	else
		manager.redPoint:setTip(RedPointConst.NEWBIE_SIGN, 0)
	end
end

function var_0_0:GetSignDay()
	return self.signDay_
end

function var_0_0:GetSignTimestamp()
	return self.signTimestamp_
end

function var_0_0:SignIn()
	self.signDay_ = self.signDay_ + 1
	self.signTimestamp_ = manager.time:GetServerTime()

	manager.redPoint:setTip(RedPointConst.NEWBIE_SIGN, 0)
end

function var_0_0:InitUpgradeData(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1.received_level_list) do
		table.insert(self.upgradeFinishList_, iter_11_1)
	end
end

function var_0_0:GetUpgradeFinishList()
	return self.upgradeFinishList_
end

function var_0_0:SetUpgradeFinish(arg_13_1)
	table.insert(self.upgradeFinishList_, arg_13_1)
end

function var_0_0:InitRechargeData(arg_14_1)
	self:UpdateRecharge(arg_14_1)
end

function var_0_0.UpdateRecharge(arg_15_0, arg_15_1)
	arg_15_0.firstRechargeRewardStatus_ = {
		firstGearStatus = arg_15_1.first_recharge_reward.first_gear_recharge_reward,
		secondGearStatus = arg_15_1.first_recharge_reward.second_gear_recharge_flag,
		signTimes = arg_15_1.first_recharge_reward.now_sign_times,
		lastSignTimestamp = arg_15_1.first_recharge_reward.last_sign_timestamp,
		firstGearNewTag = arg_15_1.first_recharge_reward.is_new_recharge_6,
		secondGearNewTag = arg_15_1.first_recharge_reward.is_new_recharge_18
	}
	arg_15_0.firstMonthlyCardStatus_ = {
		isRecharged = arg_15_1.first_monthly_card_reward.flag,
		heroRewardFlag = arg_15_1.first_monthly_card_reward.role_reward_flag,
		signTimes = arg_15_1.first_monthly_card_reward.sign_times,
		signRewardFlag = arg_15_1.first_monthly_card_reward.sign_reward_flag
	}
	arg_15_0.firstBattlePassStatus_ = {
		bpRewardStatus = arg_15_1.first_battlepass_reward.first_battlepass_reward,
		battlePassNewTag = arg_15_1.first_battlepass_reward.is_new_battlepass_reward
	}
end

function var_0_0:GetFirstRechargeStatus()
	return self.firstRechargeRewardStatus_
end

function var_0_0:ReceiveFirstRecharge(arg_17_1)
	if arg_17_1 == 0 then
		self.firstRechargeRewardStatus_.firstGearStatus = 2
	else
		self.firstRechargeRewardStatus_.signTimes = self.firstRechargeRewardStatus_.signTimes + 1
		self.firstRechargeRewardStatus_.lastSignTimestamp = manager.time:GetServerTime()
	end
end

function var_0_0:GetFirstMonthlyCardStatus()
	return self.firstMonthlyCardStatus_
end

function var_0_0:ReceiveMonthlyCard(arg_19_1)
	if arg_19_1 == 0 then
		self.firstMonthlyCardStatus_.heroRewardFlag = true
	else
		self.firstMonthlyCardStatus_.signRewardFlag = true
	end
end

function var_0_0.SetMonthlyCardSign(arg_20_0)
	return
end

function var_0_0:GetBattlePassStatus()
	return self.firstBattlePassStatus_
end

function var_0_0:GetBpRewardStatus()
	return self.firstBattlePassStatus_.bpRewardStatus
end

function var_0_0:SetBpRewardStatus()
	self.firstBattlePassStatus_.bpRewardStatus = 2
end

function var_0_0:GetRechargeStatus()
	return self.rechargeStatus_
end

function var_0_0:GetNewbieOpenTime()
	return self.trigger_time
end

function var_0_0.SetNewbieOpenTime(arg_26_0, arg_26_1)
	arg_26_0.trigger_time = arg_26_1
end

return var_0_0
