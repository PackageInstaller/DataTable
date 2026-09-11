local var_0_0 = singletonClass("SubDemonChallengeData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.InitData(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	var_0_1[arg_2_1.activity_id] = {
		activityId = arg_2_1.activity_id
	}

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.info) do
		var_2_0[iter_2_1.difficulty] = {}
		var_2_0[iter_2_1.difficulty].challenge_state = iter_2_1.challenge_state
		var_2_0[iter_2_1.difficulty].reward_state = iter_2_1.reward_state
		var_2_0[iter_2_1.difficulty].hurt_state = iter_2_1.hurt_state
	end

	var_0_1[arg_2_1.activity_id].challengeInfo = var_2_0
end

function var_0_0.SetRewardState(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	var_0_1[arg_3_1].challengeInfo[table.indexof(DemonChallengeCfg.get_id_list_by_activity_id[arg_3_1], arg_3_2)].reward_state = arg_3_3
end

function var_0_0.GetChallengeInfo(arg_4_0, arg_4_1)
	return var_0_1[arg_4_1]
end

function var_0_0.AddSelectedActivityId(arg_5_0, arg_5_1)
	var_0_2[arg_5_1] = true
end

function var_0_0.GetIsSelected(arg_6_0, arg_6_1)
	return var_0_2[arg_6_1]
end

return var_0_0
