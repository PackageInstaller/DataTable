local var_0_0 = singletonClass("NewDemonChallengeData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

function var_0_0.InitData(arg_1_0)
	var_0_1 = {}
	var_0_3 = {}
end

function var_0_0.SetSubActivityData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	var_0_1[var_2_0] = {
		activityId = var_2_0
	}

	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.info) do
		var_2_1[iter_2_1.difficulty] = {}
		var_2_1[iter_2_1.difficulty].challenge_state = iter_2_1.challenge_state
		var_2_1[iter_2_1.difficulty].hurt_state = iter_2_1.hurt_state
	end

	var_0_1[var_2_0].challengeInfo = var_2_1
end

function var_0_0.SetMainActivityData(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activity_id

	var_0_3[var_3_0] = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.complete_list) do
		var_0_3[var_3_0][iter_3_1] = ActivityConst.DEMON_CHALLENGE_REWARD_STATE.RECEIVED
	end

	local var_3_1 = NewDemonChallengeRewardCfg.get_id_list_by_activity_id[var_3_0]

	for iter_3_2, iter_3_3 in ipairs(var_3_1) do
		if var_0_3[var_3_0][iter_3_3] == nil then
			var_0_3[var_3_0][iter_3_3] = ActivityConst.DEMON_CHALLENGE_REWARD_STATE.UNRECEIVE
		end
	end
end

function var_0_0.GetRewardStateList(arg_4_0, arg_4_1)
	return var_0_3[arg_4_1]
end

function var_0_0.SetRewardState(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	var_0_3[arg_5_1][arg_5_2] = arg_5_3
end

function var_0_0.GetChallengeInfo(arg_6_0, arg_6_1)
	return var_0_1[arg_6_1]
end

function var_0_0.AddSelectedActivityId(arg_7_0, arg_7_1)
	var_0_2[arg_7_1] = true
end

function var_0_0.GetIsSelected(arg_8_0, arg_8_1)
	return var_0_2[arg_8_1]
end

function var_0_0.GetCompletedDifficultyCountList(arg_9_0, arg_9_1)
	local var_9_0 = {}
	local var_9_1 = ActivityData:GetActivityData(arg_9_1).subActivityIdList

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = var_0_1[iter_9_1]

		if var_9_2 ~= nil then
			for iter_9_2, iter_9_3 in pairs(var_9_2.challengeInfo) do
				var_9_0[iter_9_2] = var_9_0[iter_9_2] or 0

				if iter_9_3.challenge_state == ActivityConst.DEMON_CHALLENGE_STATE.FINISHED then
					var_9_0[iter_9_2] = var_9_0[iter_9_2] + 1
				end
			end
		end
	end

	return var_9_0
end

return var_0_0
