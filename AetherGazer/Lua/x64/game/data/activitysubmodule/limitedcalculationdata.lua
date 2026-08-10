local var_0_0 = singletonClass("LimitedCalculationData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	if not var_0_1[arg_2_1.activity_id] then
		var_0_1[arg_2_1.activity_id] = {
			isNeed = true,
			score = 0,
			activityID = arg_2_1.activity_id,
			lastDifficulty = getData("LimitedCalculation", "lastDifficulty" .. arg_2_1.activity_id) or 1
		}
	end

	var_0_1[arg_2_1.activity_id].clearActivityList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.clear_list or {}) do
		table.insert(var_0_1[arg_2_1.activity_id].clearActivityList, iter_2_1)
	end

	var_0_1[arg_2_1.activity_id].score = math.max(var_0_1[arg_2_1.activity_id].score, arg_2_1.high_score)

	local var_2_0 = {}

	if ActivityPointRewardCfg.get_id_list_by_activity_id[arg_2_1.activity_id] then
		for iter_2_2, iter_2_3 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_2_1.activity_id]) do
			var_2_0[iter_2_3] = {
				complete_flag = 0,
				id = iter_2_3
			}
		end
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.got_reward_list) do
		if var_2_0[iter_2_5] then
			var_2_0[iter_2_5].complete_flag = 1
		end
	end

	var_0_1[arg_2_1.activity_id].rewards = var_2_0
	var_0_1[arg_2_1.activity_id].difficultyList = {}

	local var_2_1 = ActivityData:GetActivityData(arg_2_1.activity_id)

	if var_2_1 then
		for iter_2_6, iter_2_7 in ipairs(var_2_1.subActivityIdList or {}) do
			local var_2_2 = ActivityTools.GetActivityType(iter_2_7)

			if ActivityTemplateConst.LIMITED_DIFFICULTY == var_2_2 then
				table.insert(var_0_1[arg_2_1.activity_id].difficultyList, iter_2_7)
			end
		end
	end
end

function var_0_0.GetCurDifficulty(arg_3_0, arg_3_1)
	if var_0_1[arg_3_1] == nil then
		print("activity data is null", arg_3_1, debug.traceback())

		return 1
	end

	local var_3_0 = var_0_1[arg_3_1].lastDifficulty or {}

	if var_3_0 == 1 then
		var_0_1[arg_3_1].lastDifficulty = var_0_1[arg_3_1].difficultyList[1]

		return var_0_1[arg_3_1].difficultyList[1]
	else
		return var_3_0
	end
end

function var_0_0.SetCurDifficulty(arg_4_0, arg_4_1, arg_4_2)
	var_0_1[arg_4_1].lastDifficulty = arg_4_2

	saveData("LimitedCalculation", "lastDifficulty" .. arg_4_1, arg_4_2)
	manager.notify:CallUpdateFunc(LIMITED_DIFFICULTY_CHANGE)
end

function var_0_0.GetDifficultyList(arg_5_0, arg_5_1)
	return var_0_1[arg_5_1].difficultyList
end

function var_0_0.IsClearActivity(arg_6_0, arg_6_1, arg_6_2)
	return table.keyof(var_0_1[arg_6_1].clearActivityList, arg_6_2)
end

function var_0_0.GetScore(arg_7_0, arg_7_1)
	return var_0_1[arg_7_1] and var_0_1[arg_7_1].score
end

function var_0_0.GetRewardList(arg_8_0, arg_8_1)
	local var_8_0 = {}

	if ActivityPointRewardCfg.get_id_list_by_activity_id[arg_8_1] == nil then
		return var_8_0
	end

	for iter_8_0, iter_8_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_8_1]) do
		table.insert(var_8_0, var_0_1[arg_8_1] and var_0_1[arg_8_1].rewards[iter_8_1])
	end

	return var_8_0
end

function var_0_0.SetRewardState(arg_9_0, arg_9_1, arg_9_2)
	var_0_1[arg_9_1].rewards[arg_9_2].complete_flag = ActivityConst.LIMITED_CALCULATION_REWARD_STATE.REWARDED
end

function var_0_0.GetIsNeed(arg_10_0, arg_10_1)
	return var_0_1[arg_10_1] and var_0_1[arg_10_1].isNeed
end

function var_0_0.SetIsNeed(arg_11_0, arg_11_1, arg_11_2)
	if var_0_1[arg_11_1].isNeed and arg_11_2 == false then
		manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_OPEN .. arg_11_1, 0)
	end

	var_0_1[arg_11_1].isNeed = arg_11_2
end

return var_0_0
