local var_0_0 = singletonClass("SummerLittleGameData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
end

function var_0_0.InitLeviathanGameData(arg_2_0, arg_2_1)
	var_0_1[arg_2_1.activity_id] = arg_2_1.challenge_state
end

function var_0_0.GetLeviathanState(arg_3_0, arg_3_1)
	return var_0_1[arg_3_1]
end

function var_0_0.SetLeviathanGameReward(arg_4_0, arg_4_1, arg_4_2)
	var_0_1[arg_4_1] = arg_4_2
end

function var_0_0.InitSkadiGameData(arg_5_0, arg_5_1)
	var_0_2[arg_5_1.activity_id] = {
		star = cleanProtoTable(arg_5_1.achieve_star),
		reward = cleanProtoTable(arg_5_1.achieve_star_reward)
	}
end

function var_0_0.GetSkadiStars(arg_6_0, arg_6_1)
	if not var_0_2[arg_6_1] then
		return {}
	end

	return var_0_2[arg_6_1].star
end

function var_0_0.GetSkadiReward(arg_7_0, arg_7_1)
	if not var_0_2[arg_7_1] then
		return {}
	end

	return var_0_2[arg_7_1].reward
end

function var_0_0.SetSkadiGameReward(arg_8_0, arg_8_1, arg_8_2)
	table.insert(var_0_2[arg_8_1].reward, arg_8_2)
end

function var_0_0.GetSkadiRewardNum(arg_9_0)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in pairs(var_0_2) do
		var_9_0 = var_9_0 + #iter_9_1.reward
	end

	return var_9_0
end

function var_0_0.IsSkadiRewardPointShow(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(var_0_2) do
		if #iter_10_1.reward < #iter_10_1.star then
			return true
		end
	end

	return false
end

function var_0_0.IsSkadiLevelPointShow(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(var_0_2) do
		local var_11_0 = ActivityData:GetActivityData(iter_11_0).startTime
		local var_11_1 = ActivityData:GetActivityData(iter_11_0).stopTime
		local var_11_2 = manager.time:GetServerTime()

		if var_11_0 <= var_11_2 and var_11_2 <= var_11_1 and #iter_11_1.star < 1 then
			return true
		end
	end

	return false
end

function var_0_0.IsLeviathanRewardPointShow(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(var_0_1) do
		if iter_12_1 == 1 then
			return true
		end
	end

	return false
end

function var_0_0.IsLeviathanLevelPointShow(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(var_0_1) do
		local var_13_0 = ActivityData:GetActivityData(iter_13_0).startTime
		local var_13_1 = ActivityData:GetActivityData(iter_13_0).stopTime
		local var_13_2 = manager.time:GetServerTime()

		if var_13_0 <= var_13_2 and var_13_2 <= var_13_1 and iter_13_1 == 0 then
			return true
		end
	end

	return false
end

return var_0_0
