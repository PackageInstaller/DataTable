local var_0_0 = singletonClass("CatchDuckData")
local var_0_1 = {}
local var_0_2 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_CHESS_BOARD_DUCK]

function var_0_0:InitData(arg_1_1)
	var_0_1 = {}
	self.isFirst_ = true
	self.enterIndex_ = 2
	self.activity_id = arg_1_1.activity_id

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.mission_info_list) do
		var_0_1[iter_1_1.unlock_mission] = {}
		var_0_1[iter_1_1.unlock_mission].score = iter_1_1.score
		var_0_1[iter_1_1.unlock_mission].seconds = self:CaculateSeconds(iter_1_1.min_use_seconds, iter_1_1.unlock_mission)
	end

	self:UpdateRedPointData()
end

function var_0_0:RefreshData(arg_2_1)
	arg_2_1.mission_info.min_use_seconds = self:CaculateSeconds(arg_2_1.mission_info.min_use_seconds, arg_2_1.mission_info.unlock_mission)
	self.battleResult_ = {
		score = arg_2_1.mission_info.score,
		seconds = arg_2_1.mission_info.min_use_seconds
	}

	if arg_2_1.mission_info.score >= ActivityCatchDuckCfg[ActivityCatchDuckCfg.get_id_list_by_stage_id[arg_2_1.mission_info.unlock_mission][1]].target_score then
		if var_0_1[arg_2_1.mission_info.unlock_mission] then
			var_0_1[arg_2_1.mission_info.unlock_mission].score = math.max(arg_2_1.mission_info.score, var_0_1[arg_2_1.mission_info.unlock_mission].score)
			var_0_1[arg_2_1.mission_info.unlock_mission].seconds = math.min(arg_2_1.mission_info.min_use_seconds, var_0_1[arg_2_1.mission_info.unlock_mission].seconds)
		else
			var_0_1[arg_2_1.mission_info.unlock_mission] = {
				score = arg_2_1.mission_info.score,
				seconds = arg_2_1.mission_info.min_use_seconds
			}
		end
	end
end

function var_0_0.CaculateSeconds(arg_3_0, arg_3_1, arg_3_2)
	return (math.min((arg_3_1 <= 0 or arg_3_1 - 2 <= 0) and 0 or arg_3_1 - 2, ActivityCatchDuckCfg[ActivityCatchDuckCfg.get_id_list_by_stage_id[arg_3_2][1]].limit_time))
end

function var_0_0:GetBattleResult()
	self.battleResult_ = nil

	return self.battleResult_
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
	return IsConditionAchieved(ActivitySummerChessConditionCfg[var_0_2[2]].condition)
end

function var_0_0.IsOpenActivity(arg_9_0)
	return IsConditionAchieved(ActivitySummerChessConditionCfg[var_0_2[1]].condition)
end

function var_0_0.UpdateRedPointData(arg_10_0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_3_5_CATCH_DUCK_STAGE, var_0_1[ActivityCatchDuckCfg[ActivityCatchDuckCfg.get_id_list_by_type[2][1]].stage_id] == nil and 1 or 0)
end

function var_0_0.SetIsFirst(arg_11_0, arg_11_1)
	arg_11_0.isFirst_ = arg_11_1
end

function var_0_0:GetIsFirst()
	if getData("catchDuck", "OpenSecondHalf") ~= "1" and self:IsOpenSecondHalf() then
		saveData("catchDuck", "OpenSecondHalf", "1")

		return false
	end

	return self.isFirst_
end

function var_0_0.SetEnterIndex(arg_13_0, arg_13_1)
	arg_13_0.enterIndex_ = arg_13_1
end

function var_0_0:GetEnterIndex()
	self.enterIndex_ = 2

	return self.enterIndex_
end

return var_0_0
