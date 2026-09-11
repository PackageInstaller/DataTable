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

function var_0_0:InitData(arg_2_1)
	self.openCurVersion_ = true
	self.versionID_ = arg_2_1.version_id
	self.completedTime_ = arg_2_1.completed_time

	if arg_2_1.newbie_recharge_reward then
		self:InitRechargeData(arg_2_1.newbie_recharge_reward)
	end

	if self:IsFinishAllActivity() == true then
		return
	end

	if arg_2_1.newbie_sign then
		self:InitSignData(arg_2_1.newbie_sign)
	end

	if arg_2_1.newbie_level_reward then
		self:InitUpgradeData(arg_2_1.newbie_level_reward)
	end

	if arg_2_1.trigger_time then
		self.trigger_time = arg_2_1.trigger_time
	end

	self.unlockPhase_ = arg_2_1.max_phase
	self.noobAccumulateReceivedList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.got_pt_id_list) do
		self.noobAccumulateReceivedList_[iter_2_1] = true
	end
end

function var_0_0:IsOpenCurVersion()
	return self.openCurVersion_
end

function var_0_0:GetVersionID()
	return self.versionID_
end

function var_0_0:IsFinishAllActivity()
	if self.completedTime_ == 0 then
		return false
	else
		return self.completedTime_ <= manager.time:GetServerTime()
	end
end

function var_0_0:IsFinishClientJudge()
	if self.trigger_time then
		return self.trigger_time + manager.time:GetHourInType(GameSetting.newbie_time_limit.value[1] * 24, 2) - manager.time:GetServerTime() > 0
	end

	return false
end

function var_0_0:GetUnlockPhase()
	return self.unlockPhase_
end

function var_0_0:GetAccumulateReceivedList()
	return self.noobAccumulateReceivedList_
end

function var_0_0:SetAccumulateReceivedList(arg_9_1)
	self.noobAccumulateReceivedList_[arg_9_1] = true
end

function var_0_0.CacheSelectedPhase(arg_10_0, arg_10_1)
	arg_10_0.cachePhase_ = arg_10_1
end

function var_0_0:GetSelectedPhase()
	return self.cachePhase_
end

function var_0_0:InitSignData(arg_12_1)
	self.signDay_ = arg_12_1.now_sign_times
	self.signTimestamp_ = arg_12_1.last_sign_timestamp

	if manager.time:GetTodayFreshTime() > self.signTimestamp_ and #ActivityNewbieTools.GetSignCfg() > self.signDay_ then
		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_SIGN, (math.ceil((self.signDay_ + 1) / 7))), 1)
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

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_SIGN, (math.ceil(self.signDay_ / 7))), 0)
end

function var_0_0:InitUpgradeData(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1.received_level_list) do
		table.insert(self.upgradeFinishList_, iter_16_1)
	end
end

function var_0_0:GetUpgradeFinishList()
	return self.upgradeFinishList_
end

function var_0_0:SetUpgradeFinish(arg_18_1)
	table.insert(self.upgradeFinishList_, arg_18_1)
end

function var_0_0:InitRechargeData(arg_19_1)
	self:UpdateRecharge(arg_19_1)
end

function var_0_0.UpdateRecharge(arg_20_0, arg_20_1)
	arg_20_0.firstRechargeRewardStatus_ = {
		firstGearStatus = arg_20_1.first_recharge_reward.first_gear_recharge_reward,
		secondGearStatus = arg_20_1.first_recharge_reward.second_gear_recharge_flag,
		signTimes = arg_20_1.first_recharge_reward.now_sign_times,
		lastSignTimestamp = arg_20_1.first_recharge_reward.last_sign_timestamp,
		firstGearNewTag = arg_20_1.first_recharge_reward.is_new_recharge_6,
		secondGearNewTag = arg_20_1.first_recharge_reward.is_new_recharge_18
	}
	arg_20_0.firstMonthlyCardStatus_ = {
		isRecharged = arg_20_1.first_monthly_card_reward.flag,
		heroRewardFlag = arg_20_1.first_monthly_card_reward.role_reward_flag,
		signTimes = arg_20_1.first_monthly_card_reward.sign_times,
		signRewardFlag = arg_20_1.first_monthly_card_reward.sign_reward_flag,
		newTagRoleFlag = arg_20_1.first_monthly_card_reward.is_new_tag_role_reward,
		newTagSignFlag = arg_20_1.first_monthly_card_reward.is_new_tag_sign_reward
	}
	arg_20_0.firstBattlePassStatus_ = {
		bpRewardStatus = arg_20_1.first_battlepass_reward.first_battlepass_reward,
		battlePassNewTag = arg_20_1.first_battlepass_reward.is_new_battlepass_reward
	}
end

function var_0_0:GetFirstRechargeStatus()
	return self.firstRechargeRewardStatus_
end

function var_0_0:SetNewTagRoleFlag(arg_22_1)
	self.firstMonthlyCardStatus_.newTagRoleFlag = arg_22_1
end

function var_0_0:SetNewTagSignFlag(arg_23_1)
	self.firstMonthlyCardStatus_.newTagSignFlag = arg_23_1
end

function var_0_0:SetFirstGearNewTag(arg_24_1)
	self.firstRechargeRewardStatus_.firstGearNewTag = arg_24_1
end

function var_0_0:SetSecondGearNewTag(arg_25_1)
	self.firstRechargeRewardStatus_.secondGearNewTag = arg_25_1
end

function var_0_0:IsFirstRechargeNewTag()
	return self.firstMonthlyCardStatus_.newTagSignFlag or self.firstRechargeRewardStatus_.firstGearNewTag or self.firstRechargeRewardStatus_.secondGearNewTag or self.firstBattlePassStatus_.battlePassNewTag
end

function var_0_0:ReceiveFirstRecharge(arg_27_1)
	if arg_27_1 == 0 then
		self.firstRechargeRewardStatus_.firstGearStatus = 2
	else
		self.firstRechargeRewardStatus_.signTimes = self.firstRechargeRewardStatus_.signTimes + 1
		self.firstRechargeRewardStatus_.lastSignTimestamp = manager.time:GetServerTime()
	end
end

function var_0_0:GetFirstMonthlyCardStatus()
	return self.firstMonthlyCardStatus_
end

function var_0_0:ReceiveMonthlyCard(arg_29_1)
	if arg_29_1 == 0 then
		self.firstMonthlyCardStatus_.heroRewardFlag = true
	else
		self.firstMonthlyCardStatus_.signRewardFlag = true
	end
end

function var_0_0.SetMonthlyCardSign(arg_30_0)
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

function var_0_0:SetBattlePassNewTag(arg_34_1)
	self.firstBattlePassStatus_.battlePassNewTag = arg_34_1
end

function var_0_0:GetRechargeStatus()
	return self.rechargeStatus_
end

function var_0_0:GetNewbieOpenTime()
	return self.trigger_time
end

function var_0_0.SetNewbieOpenTime(arg_37_0, arg_37_1)
	arg_37_0.trigger_time = arg_37_1
end

return var_0_0
