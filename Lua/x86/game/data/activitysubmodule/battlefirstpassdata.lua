local var_0_0 = singletonClass("BattleFirstPassData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	if not var_0_1[arg_2_1.activity_id] then
		var_0_1[arg_2_1.activity_id] = {
			isNeedRedPoint = true,
			activityID = arg_2_1.activity_id
		}
	end

	local var_2_0 = {}

	var_0_1[arg_2_1.activity_id].battleList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.sub_shot_list) do
		var_2_0[iter_2_1.activity_id] = {
			battleID = iter_2_1.activity_id,
			battleState = iter_2_1.first_clear_reward_apply_state
		}

		table.insert(var_0_1[arg_2_1.activity_id].battleList, iter_2_1.activity_id)
	end

	var_0_1[arg_2_1.activity_id].battleInfo = var_2_0
end

function var_0_0.SetBattleState(arg_3_0, arg_3_1, arg_3_2)
	var_0_1[arg_3_1].battleInfo[arg_3_2].battleState = ActivityConst.BATTLE_FIRST_PASS_STATE.REWARDED
end

function var_0_0.SetIsNeedRedPoint(arg_4_0, arg_4_1, arg_4_2)
	var_0_1[arg_4_1].isNeedRedPoint = arg_4_2
end

function var_0_0.SetLastBattleID(arg_5_0, arg_5_1, arg_5_2)
	var_0_2[arg_5_1] = arg_5_2
end

function var_0_0.GetBattleFirstPassActivityData(arg_6_0, arg_6_1)
	return var_0_1[arg_6_1]
end

function var_0_0.GetBattleList(arg_7_0, arg_7_1)
	return var_0_1[arg_7_1].battleList
end

function var_0_0.GetBattleData(arg_8_0, arg_8_1, arg_8_2)
	return var_0_1[arg_8_1].battleInfo[arg_8_2]
end

function var_0_0.GetLastBattleID(arg_9_0, arg_9_1)
	return var_0_2[arg_9_1]
end

return var_0_0
