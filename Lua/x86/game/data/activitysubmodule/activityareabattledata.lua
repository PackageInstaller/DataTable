local var_0_0 = singletonClass("ActivityAreaBattleData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {
	[3934205] = "Widget/Version/Alone_SeizuresUI/Alone_",
	[293425] = "Widget/Version/ShashwatUI_3_7/ShashwatUI_3_7_SeizuresUI/",
	[313425] = "Widget/Version/CORGUI_3_10/CORGUI_3_10_SeizuresUI/"
}

function var_0_0.Init(arg_1_0)
	var_0_1:Init()
end

function var_0_0.GetDataByActivityID(arg_2_0, arg_2_1)
	return var_0_1.activityList[arg_2_1]
end

function var_0_0.InitAreaBattleData(arg_3_0, arg_3_1)
	var_0_2 = {}

	var_0_1:InitAreaBattleData(arg_3_1)
end

function var_0_0.GetPrefabByActivityID(arg_4_0, arg_4_1)
	return var_0_3[arg_4_1]
end

function var_0_0.ResetBattleData(arg_5_0, arg_5_1)
	var_0_1:ResetBattleData(arg_5_1)
end

function var_0_0.UpdateAreaBattleData(arg_6_0, arg_6_1)
	var_0_1:UpdateAreaBattleData(arg_6_1)
end

function var_0_0.GetReward(arg_7_0, arg_7_1)
	var_0_1:GetReward(arg_7_1)
end

function var_0_0.GetStageIdList(arg_8_0)
	return var_0_2
end

function var_0_0.GetStageUnlock(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(ActivityAreaBattleCfg.all) do
		local var_9_1 = ActivityAreaBattleCfg[iter_9_1].stage_id[2]

		for iter_9_2, iter_9_3 in ipairs(var_9_1) do
			if iter_9_3 == arg_9_2 then
				var_9_0 = iter_9_1

				break
			end
		end
	end

	if var_0_1.activityList[arg_9_1][var_9_0].difficultList[2] == nil then
		return false
	end

	for iter_9_4, iter_9_5 in pairs(var_0_1.activityList[arg_9_1][var_9_0].difficultList[2]) do
		for iter_9_6, iter_9_7 in pairs(var_0_2) do
			if iter_9_7.stage_id == arg_9_2 then
				return true
			end
		end
	end

	return false
end

function var_0_1.GetReward(arg_10_0, arg_10_1)
	local var_10_0 = ActivityCfg.get_id_list_by_sub_activity_list[arg_10_1.activity_id][1]
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.target_score_list) do
		arg_10_0.activityList[var_10_0][arg_10_1.activity_id].gotChallengeRewardList[iter_10_1] = true
		arg_10_0.activityList[var_10_0][arg_10_1.activity_id].completeTask = arg_10_0.activityList[var_10_0][arg_10_1.activity_id].completeTask + 1

		for iter_10_2, iter_10_3 in ipairs(ActivityAreaBattleCfg[arg_10_1.activity_id].reward_list) do
			if iter_10_3[1] == iter_10_1 then
				for iter_10_4, iter_10_5 in ipairs(iter_10_3[2]) do
					table.insert(var_10_1, iter_10_5)
				end
			end
		end
	end

	local var_10_2 = formatRewardCfgList(var_10_1)
	local var_10_3 = mergeReward(var_10_2)

	getReward(var_10_3, nil, nil, nil, true)
end

function var_0_1.ResetBattleData(arg_11_0, arg_11_1)
	local var_11_0 = ActivityCfg.get_id_list_by_sub_activity_list[arg_11_1.activity_id][1]

	for iter_11_0, iter_11_1 in pairs(arg_11_0.activityList[var_11_0][arg_11_1.activity_id].difficultList) do
		for iter_11_2, iter_11_3 in pairs(arg_11_1.stage_id_list) do
			if iter_11_1[iter_11_3] then
				iter_11_1[iter_11_3].point = 0
				iter_11_1[iter_11_3].usedHeroList = {}
			else
				iter_11_1[iter_11_3] = nil
			end
		end
	end
end

function var_0_1.InitAreaBattleData(arg_12_0, arg_12_1)
	arg_12_0.activityList[arg_12_1.activity_id] = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.area_battle_data_list) do
		arg_12_0.activityList[arg_12_1.activity_id][iter_12_1.activity_id] = arg_12_0:ParseServerData(iter_12_1)
	end
end

function var_0_1.UpdateAreaBattleData(arg_13_0, arg_13_1)
	local var_13_0 = ActivityCfg.get_id_list_by_sub_activity_list[arg_13_1.area_battle_data.activity_id][1]

	arg_13_0.activityList[var_13_0][arg_13_1.area_battle_data.activity_id] = arg_13_0:ParseServerData(arg_13_1.area_battle_data)
end

function var_0_1.ParseServerData(arg_14_0, arg_14_1)
	local var_14_0 = {
		challengeValue = arg_14_1.challenge_value,
		maxChallengeValue = arg_14_1.max_challenge_value,
		allChallengeValue = arg_14_1.acc_challenge_value,
		difficultList = {}
	}

	var_14_0.completeTask = 0

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.difficult_info_list) do
		var_14_0.difficultList[iter_14_1.difficult_level] = {}

		for iter_14_2, iter_14_3 in ipairs(iter_14_1.stage_info_list) do
			var_14_0.difficultList[iter_14_1.difficult_level][iter_14_3.stage_id] = {}
			var_14_0.difficultList[iter_14_1.difficult_level][iter_14_3.stage_id].stageID = iter_14_3.stage_id
			var_14_0.difficultList[iter_14_1.difficult_level][iter_14_3.stage_id].usedHeroList = iter_14_3.used_hero_list
			var_14_0.difficultList[iter_14_1.difficult_level][iter_14_3.stage_id].point = iter_14_3.point

			if var_0_2[iter_14_3.stage_id] then
				var_0_2[iter_14_3.stage_id] = {
					isFirst = true,
					stage_id = iter_14_3.stage_id
				}
			else
				var_0_2[iter_14_3.stage_id] = {
					isFirst = false,
					stage_id = iter_14_3.stage_id
				}
			end
		end
	end

	var_14_0.gotChallengeRewardList = {}

	for iter_14_4, iter_14_5 in ipairs(arg_14_1.got_challenge_reward_list) do
		var_14_0.gotChallengeRewardList[iter_14_5] = true
		var_14_0.completeTask = var_14_0.completeTask + 1
	end

	return var_14_0
end

function var_0_1.Init(arg_15_0)
	arg_15_0.activityList = {}
end

return var_0_0
