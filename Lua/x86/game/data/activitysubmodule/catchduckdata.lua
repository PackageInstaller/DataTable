local var_0_0 = singletonClass("CatchDuckData")
local var_0_1 = {}
local var_0_2 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_CHESS_BOARD_DUCK]

function var_0_0.InitData(arg_1_0, arg_1_1)
	var_0_1 = {}
	arg_1_0.isFirst_ = true
	arg_1_0.enterIndex_ = 2
	arg_1_0.activity_id = arg_1_1.activity_id

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.mission_info_list) do
		var_0_1[iter_1_1.unlock_mission] = {}
		var_0_1[iter_1_1.unlock_mission].score = iter_1_1.score
		var_0_1[iter_1_1.unlock_mission].seconds = arg_1_0:CaculateSeconds(iter_1_1.min_use_seconds, iter_1_1.unlock_mission)
	end

	arg_1_0:UpdateRedPointData()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.mission_info
	local var_2_1 = var_2_0.unlock_mission
	local var_2_2 = ActivityCatchDuckCfg.get_id_list_by_stage_id[var_2_1][1]
	local var_2_3 = ActivityCatchDuckCfg[var_2_2]

	var_2_0.min_use_seconds = arg_2_0:CaculateSeconds(var_2_0.min_use_seconds, var_2_1)
	arg_2_0.battleResult_ = {
		score = var_2_0.score,
		seconds = var_2_0.min_use_seconds
	}

	if var_2_0.score >= var_2_3.target_score then
		if var_0_1[var_2_1] then
			var_0_1[var_2_1].score = math.max(var_2_0.score, var_0_1[var_2_1].score)
			var_0_1[var_2_1].seconds = math.min(var_2_0.min_use_seconds, var_0_1[var_2_1].seconds)
		else
			var_0_1[var_2_1] = {
				score = var_2_0.score,
				seconds = var_2_0.min_use_seconds
			}
		end
	end
end

function var_0_0.CaculateSeconds(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = ActivityCatchDuckCfg.get_id_list_by_stage_id[arg_3_2][1]
	local var_3_1 = ActivityCatchDuckCfg[var_3_0]
	local var_3_2 = 0
	local var_3_3 = (arg_3_1 <= 0 or arg_3_1 - 2 <= 0) and 0 or arg_3_1 - 2

	return (math.min(var_3_3, var_3_1.limit_time))
end

function var_0_0.GetBattleResult(arg_4_0)
	local var_4_0 = arg_4_0.battleResult_

	arg_4_0.battleResult_ = nil

	return var_4_0
end

function var_0_0.GetDuckStageData(arg_5_0)
	return var_0_1
end

function var_0_0.GetDuckStageDataById(arg_6_0, arg_6_1)
	return var_0_1[arg_6_1]
end

function var_0_0.GetConditionId(arg_7_0, arg_7_1)
	return var_0_2[arg_7_1]
end

function var_0_0.IsOpenSecondHalf(arg_8_0)
	local var_8_0 = var_0_2[2]
	local var_8_1 = ActivitySummerChessConditionCfg[var_8_0].condition

	return IsConditionAchieved(var_8_1)
end

function var_0_0.IsOpenActivity(arg_9_0)
	local var_9_0 = var_0_2[1]
	local var_9_1 = ActivitySummerChessConditionCfg[var_9_0].condition

	return IsConditionAchieved(var_9_1)
end

function var_0_0.UpdateRedPointData(arg_10_0)
	local var_10_0 = ActivityCatchDuckCfg.get_id_list_by_type[2][1]
	local var_10_1 = ActivityCatchDuckCfg[var_10_0]
	local var_10_2 = var_0_1[var_10_1.stage_id] == nil and 1 or 0

	manager.redPoint:setTip(RedPointConst.ACTIVITY_3_5_CATCH_DUCK_STAGE, var_10_2)
end

function var_0_0.SetIsFirst(arg_11_0, arg_11_1)
	arg_11_0.isFirst_ = arg_11_1
end

function var_0_0.GetIsFirst(arg_12_0)
	if getData("catchDuck", "OpenSecondHalf") ~= "1" and arg_12_0:IsOpenSecondHalf() then
		saveData("catchDuck", "OpenSecondHalf", "1")

		return false
	end

	return arg_12_0.isFirst_
end

function var_0_0.SetEnterIndex(arg_13_0, arg_13_1)
	arg_13_0.enterIndex_ = arg_13_1
end

function var_0_0.GetEnterIndex(arg_14_0)
	local var_14_0 = arg_14_0.enterIndex_

	arg_14_0.enterIndex_ = 2

	return var_14_0
end

return var_0_0
