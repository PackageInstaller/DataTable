local var_0_0 = singletonClass("CowboyData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	if not var_0_1[var_2_0] then
		var_0_1[var_2_0] = {}
		var_0_1[var_2_0].activityID = arg_2_1.activity_id
		var_0_1[var_2_0].open = arg_2_1.activity_point > -10000
	end

	var_0_1[var_2_0].score = arg_2_1.activity_point or -10000
	var_0_1[var_2_0].reward = cleanProtoTable(arg_2_1.reward_info, {
		"point_id",
		"point_reward_state"
	})
end

function var_0_0.SetLastLevel(arg_3_0, arg_3_1, arg_3_2)
	var_0_2[arg_3_1] = arg_3_2
end

function var_0_0.GetLastLevel(arg_4_0, arg_4_1)
	return var_0_2[arg_4_1]
end

function var_0_0.SetOpen(arg_5_0, arg_5_1)
	if var_0_1[arg_5_1] then
		var_0_1[arg_5_1].open = true
	end
end

function var_0_0.GetOpen(arg_6_0, arg_6_1)
	if var_0_1[arg_6_1] then
		return var_0_1[arg_6_1].open
	end

	return false
end

function var_0_0.SetReward(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(var_0_1[arg_7_1].reward) do
		if iter_7_1.point_id == arg_7_2 then
			iter_7_1.point_reward_state = 2

			break
		end
	end
end

function var_0_0.SetScore(arg_8_0, arg_8_1, arg_8_2)
	var_0_1[arg_8_1].score = arg_8_2
end

function var_0_0.GetList(arg_9_0, arg_9_1)
	local var_9_0 = {}
	local var_9_1 = ActivityData:GetActivityData(arg_9_1).subActivityIdList

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		if var_0_1[iter_9_1] then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function var_0_0.GetData(arg_10_0, arg_10_1)
	return var_0_1[arg_10_1]
end

function var_0_0.GetHistoryScore(arg_11_0, arg_11_1)
	if var_0_1[arg_11_1] then
		return var_0_1[arg_11_1].score
	end

	return 0
end

function var_0_0.GetRewardCount(arg_12_0, arg_12_1)
	local var_12_0 = 0
	local var_12_1 = 0
	local var_12_2 = ActivityData:GetActivityData(arg_12_1).subActivityIdList

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		if var_0_1[iter_12_1] then
			var_12_1 = var_12_1 + 1

			for iter_12_2, iter_12_3 in ipairs(var_0_1[iter_12_1].reward) do
				if iter_12_3.point_reward_state == 2 then
					var_12_0 = var_12_0 + 1
				end
			end
		end
	end

	return var_12_0, var_12_1 * 3
end

function var_0_0.IsRewardRedPointShow(arg_13_0, arg_13_1)
	if var_0_1[arg_13_1] then
		local var_13_0 = var_0_1[arg_13_1].score

		for iter_13_0, iter_13_1 in ipairs(var_0_1[arg_13_1].reward) do
			if var_13_0 > ActivityPointRewardCfg[iter_13_1.point_id].need and iter_13_1.point_reward_state == 1 then
				return true
			end
		end
	end

	return false
end

return var_0_0
