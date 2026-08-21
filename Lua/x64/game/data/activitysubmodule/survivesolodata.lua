local var_0_0 = singletonClass("SurviveSoloData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	if not var_0_1[var_2_0] then
		var_0_1[var_2_0] = {}
		var_0_1[var_2_0].time = 0
		var_0_1[var_2_0].rewards = {}
		var_0_1[var_2_0].activityID = var_2_0
	end

	var_0_1[var_2_0].time = arg_2_1.survival_time
	var_0_1[var_2_0].rewards = arg_2_1.got_reward_list or {}
end

function var_0_0.GetData(arg_3_0, arg_3_1)
	return var_0_1[arg_3_1]
end

function var_0_0.SetReward(arg_4_0, arg_4_1, arg_4_2)
	if not table.indexof(var_0_1[arg_4_1].rewards, arg_4_2) then
		table.insert(var_0_1[arg_4_1].rewards, arg_4_2)
	end
end

function var_0_0.GetLastIndex(arg_5_0, arg_5_1)
	return var_0_2[arg_5_1]
end

function var_0_0.SetLastIndex(arg_6_0, arg_6_1, arg_6_2)
	var_0_2[arg_6_1] = arg_6_2
end

return var_0_0
