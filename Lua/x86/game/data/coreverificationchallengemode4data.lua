local var_0_0 = singletonClass("CoreVerificationChallengeMode4Data")

var_0_0.TaskState = {
	Completed = 2,
	CanGetReward = 1,
	InProgress = 0
}

function var_0_0.Init(arg_1_0)
	arg_1_0.commonStage = {}
	arg_1_0.challengeStage = {}
	arg_1_0.finishedTaskInfo = {}
	arg_1_0.firstEnterTipsHasShown = false
	arg_1_0.activityID = 0
	arg_1_0.lastBattleScore = 0
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.commonStage = {}
	arg_2_0.challengeStage = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.common_stages) do
		local var_2_0 = iter_2_1.stage_id
		local var_2_1 = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.common_locks) do
			var_2_1[iter_2_3.index] = {
				heroList = iter_2_3.hero_id_list,
				score = iter_2_3.cur_value,
				time = iter_2_3.seconds
			}
		end

		local var_2_2 = (nullable(CoreVerificationClMode4Cfg, var_2_0, "stage_type") or 1) == 1 and arg_2_0.commonStage or arg_2_0.challengeStage

		table.insert(var_2_2, {
			stageID = var_2_0,
			teams = var_2_1
		})
	end

	arg_2_0.finishedTaskInfo = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.finish_assignment_list) do
		arg_2_0.finishedTaskInfo[iter_2_5.assignment_id] = iter_2_5.state
	end

	arg_2_0.firstEnterTipsHasShown = arg_2_1.first_enter
	arg_2_0.maxPoint = arg_2_1.max_point

	CoreVerificationChallengeTools.InitCache()

	arg_2_0.activityID = CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4)

	arg_2_0:InitTaskInfo()
end

function var_0_0.UpdateLastBattleScore(arg_3_0, arg_3_1)
	arg_3_0.lastBattleScore = arg_3_1
end

function var_0_0.GetLastBattleScore(arg_4_0)
	return arg_4_0.lastBattleScore
end

function var_0_0.OnResetTeam(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:GetStageDataByStageID(arg_5_1)

	if var_5_0 and var_5_0.teams[arg_5_2] then
		local var_5_1 = var_5_0.teams[arg_5_2]

		var_5_1.heroList = {}
		var_5_1.score = 0
		var_5_1.time = nil
	end
end

function var_0_0.OnResetStage(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetStageDataByStageID(arg_6_1)

	if var_6_0 then
		for iter_6_0, iter_6_1 in pairs(var_6_0.teams) do
			iter_6_1.heroList = {}
			iter_6_1.score = 0
			iter_6_1.time = nil
		end
	end
end

function var_0_0.OnResetAll(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.commonStage) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1.teams) do
			iter_7_3.heroList = {}
			iter_7_3.score = 0
			iter_7_3.time = nil
		end
	end

	for iter_7_4, iter_7_5 in ipairs(arg_7_0.challengeStage) do
		for iter_7_6, iter_7_7 in pairs(iter_7_5.teams) do
			iter_7_7.heroList = {}
			iter_7_7.score = 0
			iter_7_7.time = nil
		end
	end
end

function var_0_0.InitTaskInfo(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = ActivityCfg[arg_8_0.activityID].sub_activity_list[2]
	local var_8_2 = CoreVerificationClRewardCfg.get_id_list_by_activity_id[var_8_1] or {}

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		local var_8_3 = {
			taskId = iter_8_1,
			reward_type = CoreVerificationClRewardCfg[iter_8_1].reward_type
		}

		table.insert(var_8_0, var_8_3)
	end

	arg_8_0.allTaskInfo = var_8_0
end

function var_0_0.GetActivityID(arg_9_0)
	return arg_9_0.activityID
end

function var_0_0.GetCommonStage(arg_10_0)
	return arg_10_0.commonStage
end

function var_0_0.GetChallengeStage(arg_11_0)
	return arg_11_0.challengeStage
end

function var_0_0.GetStageDataByStageID(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.commonStage) do
		if iter_12_1.stageID == arg_12_1 then
			return iter_12_1
		end
	end

	for iter_12_2, iter_12_3 in ipairs(arg_12_0.challengeStage) do
		if iter_12_3.stageID == arg_12_1 then
			return iter_12_3
		end
	end

	return nil
end

function var_0_0.GetSeasonIsTips(arg_13_0)
	return not arg_13_0.firstEnterTipsHasShown
end

function var_0_0.SetSeasonIsTips(arg_14_0, arg_14_1)
	arg_14_0.firstEnterTipsHasShown = not arg_14_1
end

function var_0_0.UpdateIllustrated(arg_15_0, arg_15_1)
	return
end

function var_0_0.UpdateFinishTaskData(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		arg_16_0.finishedTaskInfo[iter_16_1] = var_0_0.TaskState.Completed
	end
end

function var_0_0.GetCurPoint(arg_17_0)
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.challengeStage) do
		for iter_17_2, iter_17_3 in pairs(iter_17_1.teams) do
			var_17_0 = var_17_0 + iter_17_3.score
		end
	end

	if var_17_0 == 0 then
		return 0
	end

	local var_17_1 = var_17_0

	for iter_17_4, iter_17_5 in ipairs(arg_17_0.commonStage) do
		for iter_17_6, iter_17_7 in pairs(iter_17_5.teams) do
			var_17_1 = var_17_1 + iter_17_7.score
		end
	end

	return var_17_1
end

function var_0_0.GetMaxPoint(arg_18_0)
	return arg_18_0.maxPoint
end

function var_0_0.GetRankScore(arg_19_0)
	return arg_19_0:GetMaxPoint()
end

function var_0_0.GetAllTaskInfo(arg_20_0)
	return arg_20_0.allTaskInfo or {}
end

function var_0_0.GetTaskState(arg_21_0, arg_21_1)
	return nullable(arg_21_0.finishedTaskInfo, arg_21_1) or var_0_0.TaskState.InProgress
end

function var_0_0.GetTaskInfoById(arg_22_0, arg_22_1)
	return {
		taskId = arg_22_1,
		state = arg_22_0:GetTaskState(arg_22_1),
		reward_type = CoreVerificationClRewardCfg[arg_22_1].reward_type
	}
end

function var_0_0.IsGetAllTaskReward(arg_23_0)
	if arg_23_0.finishedTaskInfo == nil or next(arg_23_0.finishedTaskInfo) == nil then
		return false
	end

	for iter_23_0, iter_23_1 in pairs(arg_23_0.finishedTaskInfo) do
		if iter_23_1 ~= var_0_0.TaskState.Completed then
			return false
		end
	end

	return true
end

function var_0_0.IsGetTaskReward(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.finishedTaskInfo) do
		if iter_24_1 == var_0_0.TaskState.Completed then
			return true
		end
	end

	return false
end

function var_0_0.IsCanGetTaskReward(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.finishedTaskInfo) do
		if iter_25_1 == var_0_0.TaskState.CanGetReward then
			return 1
		end
	end

	return 0
end

function var_0_0.IsJumpAllStage(arg_26_0)
	return true
end

function var_0_0.GetChallengeStageCfg(arg_27_0, arg_27_1)
	arg_27_1 = arg_27_1 or CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4)

	for iter_27_0, iter_27_1 in ipairs(CoreVerificationClMode4Cfg.get_id_list_by_stage_type[2]) do
		local var_27_0 = CoreVerificationClMode4Cfg[iter_27_1]

		if var_27_0.activity_id == arg_27_1 then
			return var_27_0
		end
	end

	return nil
end

local function var_0_1(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_0 then
		return
	end

	local var_28_0 = nullable(arg_28_2, "stageID")
	local var_28_1 = nullable(arg_28_2, "teamIndex")

	for iter_28_0, iter_28_1 in ipairs(arg_28_0) do
		for iter_28_2, iter_28_3 in pairs(iter_28_1.teams) do
			if iter_28_3.heroList and (var_28_0 ~= iter_28_1.stageID or var_28_1 ~= iter_28_2) then
				for iter_28_4, iter_28_5 in ipairs(iter_28_3.heroList) do
					table.insert(arg_28_1, iter_28_5)
				end
			end
		end
	end
end

function var_0_0.PushStageLockedHero(arg_29_0, arg_29_1, arg_29_2)
	var_0_1(arg_29_0:GetChallengeStage(), arg_29_2, arg_29_1)
	var_0_1(arg_29_0:GetCommonStage(), arg_29_2, arg_29_1)
end

return var_0_0
