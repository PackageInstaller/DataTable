local var_0_0 = {}

manager.net:Bind(11023, function(arg_1_0)
	RaceTrialData:InitData(arg_1_0.race_trial)
end)
manager.net:Bind(11019, function(arg_2_0)
	RaceTrialData:RefreshBattleData(arg_2_0)
end)

function var_0_0:ReceiveAllScoreReward(arg_3_1)
	local var_3_0 = {}
	local var_3_1 = RaceTrialData:GetTotalScore(arg_3_1)

	for iter_3_0, iter_3_1 in ipairs((RaceTrialData:GetScoreRewardSortList(arg_3_1))) do
		if not RaceTrialData:GetScoreRewardByID(iter_3_1).receive_flag and ActivityPointRewardCfg[iter_3_1].need <= var_3_1 then
			table.insert(var_3_0, iter_3_1)
		end
	end

	manager.net:SendWithLoadingNew(60054, {
		point_reward_id_list = var_3_0
	}, 60055, handler(self, self.OnReceiveScoreReward))
end

function var_0_0:ReceiveMultipleScoreReward(arg_4_1)
	manager.net:SendWithLoadingNew(60054, {
		point_reward_id_list = arg_4_1
	}, 60055, handler(self, self.OnReceiveScoreReward))
end

function var_0_0:ReceiveScoreReward(arg_5_1)
	manager.net:SendWithLoadingNew(60054, {
		point_reward_id_list = {
			arg_5_1
		}
	}, 60055, handler(self, self.OnReceiveScoreReward))
end

function var_0_0.OnReceiveScoreReward(arg_6_0, arg_6_1, arg_6_2)
	if isSuccess(arg_6_1.result) then
		for iter_6_0, iter_6_1 in ipairs(arg_6_2.point_reward_id_list) do
			RaceTrialData:ReceiveScoreReward(iter_6_1)
		end

		getReward(mergeReward(arg_6_1.reward_list))
		manager.notify:CallUpdateFunc(RACE_TRIAL_POINT_RECEIVE)
		manager.notify:Invoke(RACE_TRIAL_POINT_RECEIVE)
	else
		ShowTips(arg_6_1.result)
	end
end

function var_0_0:ReceiveFirstReward(arg_7_1, arg_7_2)
	self:ReceiveMultipleFirstClearLevelReward(arg_7_1, {
		arg_7_2
	})
end

function var_0_0:ReceiveMultipleFirstClearLevelReward(arg_8_1, arg_8_2)
	manager.net:SendWithLoadingNew(11040, {
		id_list = arg_8_2,
		activity_id = arg_8_1
	}, 11041, handler(self, self.OnReceiveMultipleFirstClearLevelReward))
end

function var_0_0.OnReceiveMultipleFirstClearLevelReward(arg_9_0, arg_9_1, arg_9_2)
	if isSuccess(arg_9_1.result) then
		for iter_9_0, iter_9_1 in ipairs(arg_9_2.id_list) do
			RaceTrialData:ReceiveFirstReward(iter_9_1)
		end

		getReward(mergeReward(arg_9_1.item_list))
		manager.notify:CallUpdateFunc(RACE_TRIAL_FIRST_RECEIVE)
	else
		ShowTips(arg_9_1.result)
	end
end

function var_0_0:SaveCustomList(arg_10_1, arg_10_2)
	if not ActivityData:GetActivityIsOpen(arg_10_1) then
		return
	end

	RaceTrialData:SaveCustomList(arg_10_1, arg_10_2)
	manager.net:SendWithLoadingNew(11038, {
		id = arg_10_1,
		race_trial_affix_id_list = arg_10_2
	}, 11039, handler(self, self.OnSaveCustomList))
end

function var_0_0.OnSaveCustomList(arg_11_0, arg_11_1, arg_11_2)
	if isSuccess(arg_11_1.result) then
		-- block empty
	else
		ShowTips(arg_11_1.result)
	end
end

function var_0_0.Init(arg_12_0)
	RaceTrialData:InitConst(arg_12_0)
	RaceTrialData:InitBattleData(arg_12_0)
	RaceTrialData:InitScoreRewardData(arg_12_0)
end

function var_0_0.InitRedPointKey(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(ActivityData:GetActivityData(arg_13_0).subActivityIdList) do
		var_13_0[#var_13_0 + 1] = string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, arg_13_0, iter_13_1)
		var_13_1[#var_13_1 + 1] = string.format("%s_%s_%d_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_13_0, iter_13_1)
	end

	manager.redPoint:addGroup(string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_13_0), var_13_1, true)

	var_13_0[#var_13_0 + 1] = string.format("%s_%s_PointReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_13_0)
	var_13_0[#var_13_0 + 1] = string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_13_0)

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, arg_13_0), var_13_0, false)
end

function var_0_0.UpdateRedPoint(arg_14_0)
	if not ActivityData:GetActivityIsOpen(arg_14_0) then
		if #ActivityCfg[arg_14_0].sub_activity_list > 0 then
			for iter_14_0, iter_14_1 in ipairs(ActivityCfg[arg_14_0].sub_activity_list) do
				manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, arg_14_0, iter_14_1), 0)
				manager.redPoint:setTip(string.format("%s_%s_%d_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_14_0, iter_14_1), 0)
			end

			manager.redPoint:setTip(string.format("%s_%s_PointReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_14_0), 0)
		else
			local var_14_0 = RaceTrialData:GetMainActivityID(arg_14_0)

			manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, var_14_0, arg_14_0), 0)
			manager.redPoint:setTip(string.format("%s_%s_%d_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, var_14_0, arg_14_0), 0)
		end
	end
end

return var_0_0
