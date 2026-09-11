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

function var_0_0:InitConst(arg_2_1)
	self.mainActivityIdDic_ = {}

	for iter_2_0, iter_2_1 in ipairs(ActivityData:GetActivityData(arg_2_1).subActivityIdList) do
		self.mainActivityIdDic_[iter_2_1] = arg_2_1
	end
end

function var_0_0:GetMainActivityID(arg_3_1)
	return self.mainActivityIdDic_[arg_3_1]
end

function var_0_0:InitData(arg_4_1)
	RaceTrialAction.InitRedPointKey(arg_4_1.activity_id)
	self:InitConst(arg_4_1.activity_id)
	self:ModifyScoreRewardData(arg_4_1.got_reward_list or {})
	self:RefreshScoreRedPoint(arg_4_1.activity_id)
end

function var_0_0:InitBattleData(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(ActivityData:GetActivityData(arg_5_1).subActivityIdList) do
		self.battleData_[iter_5_1] = {
			point = 0,
			state = 1,
			id = iter_5_1,
			customList = {}
		}

		self:RefreshBattleRedPoint(iter_5_1)
		self:RefreshFirstRedPoint(iter_5_1)
	end

	self:RefreshScoreRedPoint(arg_5_1)

	self.battleData_.get_id_list = {}
end

function var_0_0:InitScoreRewardData(arg_6_1)
	if ActivityPointRewardCfg.get_id_list_by_activity_id[arg_6_1] ~= nil then
		for iter_6_0, iter_6_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_6_1]) do
			self.scoreRewardData_[iter_6_1] = {}
			self.scoreRewardData_[iter_6_1].id = iter_6_1
			self.scoreRewardData_[iter_6_1].receive_flag = false
		end
	end
end

function var_0_0:ModifyScoreRewardData(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		self.scoreRewardData_[iter_7_1].receive_flag = true
	end
end

function var_0_0:RefreshBattleData(arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.challenge.custom_affix_list) do
		var_8_0[iter_8_0] = iter_8_1
	end

	self.battleData_[arg_8_1.challenge.activity_id] = {
		id = arg_8_1.challenge.activity_id,
		state = arg_8_1.challenge.first_clear_reward_apply_state,
		customList = var_8_0,
		point = arg_8_1.challenge.point
	}

	self:RefreshRedPoint(arg_8_1.challenge.activity_id, self:GetMainActivityID(arg_8_1.challenge.activity_id))
end

function var_0_0:GetTotalScore(arg_9_1)
	self.totalScore_ = 0

	for iter_9_0, iter_9_1 in ipairs(ActivityData:GetActivityData(arg_9_1).subActivityIdList) do
		self.totalScore_ = self.totalScore_ + ((self.battleData_[iter_9_1] or nil) and (self.battleData_[iter_9_1].point or 0))
	end

	return self.totalScore_
end

function var_0_0:GetCurLv(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_10_1]) do
		if not self.scoreRewardData_[iter_10_1].receive_flag then
			return self.scoreRewardData_[iter_10_1].id
		end
	end

	return ActivityPointRewardCfg.get_id_list_by_activity_id[arg_10_1][#ActivityPointRewardCfg.get_id_list_by_activity_id[arg_10_1]]
end

function var_0_0:GetFirstRewardSortList(arg_11_1)
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = {}
	local var_11_4 = {}

	for iter_11_0, iter_11_1 in ipairs(ActivityData:GetActivityData(arg_11_1).subActivityIdList) do
		if self.battleData_[iter_11_1].state == self.battleState_.incomplete then
			table.insert(var_11_3, iter_11_1)
		elseif self.battleData_[iter_11_1].state == self.battleState_.complete then
			table.insert(var_11_2, iter_11_1)
		elseif self.battleData_[iter_11_1].state == self.battleState_.received then
			table.insert(var_11_4, iter_11_1)
		end
	end

	table.insertto(var_11_1, var_11_2)
	table.insertto(var_11_1, var_11_3)
	table.insertto(var_11_1, var_11_4)

	return var_11_1, var_11_2
end

function var_0_0:GetBattleData(arg_12_1)
	return self.battleData_[arg_12_1]
end

function var_0_0:GetScoreRewardSortList(arg_13_1)
	local var_13_2 = {}
	local var_13_3 = {}
	local var_13_4 = {}
	local var_13_5 = {}

	for iter_13_0, iter_13_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_13_1]) do
		if self.scoreRewardData_[iter_13_1].receive_flag then
			table.insert(var_13_5, self.scoreRewardData_[iter_13_1].id)
		elseif ActivityPointRewardCfg[iter_13_1].need <= self.totalScore_ then
			table.insert(var_13_3, self.scoreRewardData_[iter_13_1].id)
		else
			table.insert(var_13_4, self.scoreRewardData_[iter_13_1].id)
		end
	end

	table.insertto(var_13_2, var_13_3)
	table.insertto(var_13_2, var_13_4)
	table.insertto(var_13_2, var_13_5)

	return var_13_2
end

function var_0_0:GetScoreRewardByID(arg_14_1)
	return self.scoreRewardData_[arg_14_1]
end

function var_0_0.GetRaceTrialStartTime(arg_15_0, arg_15_1)
	return ActivityData:GetActivityData(arg_15_1).startTime
end

function var_0_0.GetRaceTrialEndTime(arg_16_0, arg_16_1)
	return ActivityData:GetActivityData(arg_16_1).stopTime
end

function var_0_0:GetCustomList(arg_17_1)
	return self.battleData_[arg_17_1].customList
end

function var_0_0:GetCustomListByStageID(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(ActivityRaceTrialCfg.all) do
		if arg_18_1 == ActivityRaceTrialCfg[iter_18_1].stage_id then
			return self.battleData_[ActivityRaceTrialCfg[iter_18_1].id].customList
		end
	end

	print("匹配出错")

	return {}
end

function var_0_0:ReceiveScoreReward(arg_19_1)
	self.scoreRewardData_[arg_19_1].receive_flag = true

	self:RefreshScoreRedPoint(ActivityPointRewardCfg[arg_19_1].activity_id)
end

function var_0_0:ReceiveFirstReward(arg_20_1)
	self.battleData_[arg_20_1].state = self.battleState_.received

	self:RefreshFirstRedPoint(arg_20_1)
end

function var_0_0:SaveCustomList(arg_21_1, arg_21_2)
	arg_21_2 = arg_21_2 or {}
	self.battleData_[arg_21_1].customList = arg_21_2
end

function var_0_0:RefreshRedPoint(arg_22_1, arg_22_2)
	self:RefreshBattleRedPoint(arg_22_1)
	self:RefreshScoreRedPoint(arg_22_2)
	self:RefreshFirstRedPoint(arg_22_1)
end

function var_0_0:RefreshBattleRedPoint(arg_23_1)
	manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, self:GetMainActivityID(arg_23_1), arg_23_1), ActivityData:GetActivityIsOpen(arg_23_1) and self.battleData_[arg_23_1].point <= 0 and 1 or 0)
end

function var_0_0:RefreshScoreRedPoint(arg_24_1)
	local var_24_0 = false
	local var_24_3 = self:GetTotalScore(arg_24_1)

	for iter_24_0, iter_24_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_24_1] or {}) do
		if var_24_3 >= ActivityPointRewardCfg[iter_24_1].need and self.scoreRewardData_[iter_24_1].receive_flag == false then
			var_24_0 = true

			break
		end
	end

	manager.redPoint:setTip(string.format("%s_%s_PointReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_24_1), var_24_0 and 1 or 0)
end

function var_0_0:RefreshFirstRedPoint(arg_25_1)
	manager.redPoint:setTip(string.format("%s_%s_%d_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, self:GetMainActivityID(arg_25_1), arg_25_1), (self.battleData_[arg_25_1].state == self.battleState_.complete or nil) and true and 1 or 0)
end

function var_0_0:SetBattleRedPointOn(arg_26_1, arg_26_2)
	manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, self:GetMainActivityID(arg_26_2), arg_26_2), 0)
end

function var_0_0:GetBattleResultGoal(arg_27_1)
	local var_27_1 = ActivityRaceTrialCfg[arg_27_1].base_point

	for iter_27_0, iter_27_1 in ipairs(self.battleData_[arg_27_1].customList or {}) do
		var_27_1 = var_27_1 + ActivityAffixPoolCfg[iter_27_1].point
	end

	return var_27_1
end

return var_0_0
