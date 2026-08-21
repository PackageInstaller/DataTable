local var_0_0 = singletonClass("PaChinKoData")

function var_0_0.Init(arg_1_0)
	arg_1_0.rewardList_ = {}
	arg_1_0.rewardData_ = {}
end

function var_0_0.InitPaChinKoData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	arg_2_0.rewardList_[var_2_0] = {}
	arg_2_0.rewardData_[var_2_0] = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.reward_list) do
		arg_2_0:AddPachinKoReward(var_2_0, iter_2_1)
	end

	PaChinKoAction.UpdateRedPoint(var_2_0)
end

function var_0_0.AddPachinKoReward(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.rewardData_[arg_3_1] = arg_3_0.rewardData_[arg_3_1] or {}
	arg_3_0.rewardList_[arg_3_1] = arg_3_0.rewardList_[arg_3_1] or {}
	arg_3_0.rewardData_[arg_3_1][arg_3_2] = (arg_3_0.rewardData_[arg_3_1][arg_3_2] or 0) + 1

	table.insert(arg_3_0.rewardList_[arg_3_1], arg_3_2)
end

function var_0_0.GetRewardData(arg_4_0, arg_4_1)
	return arg_4_0.rewardData_[arg_4_1] or {}
end

function var_0_0.GetRewardList(arg_5_0, arg_5_1)
	return arg_5_0.rewardList_[arg_5_1] or {}
end

return var_0_0
