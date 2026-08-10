local var_0_0 = singletonClass("CoreVerificationChallengeMode3Data")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = 0
local var_0_7 = {}
local var_0_8 = true
local var_0_9 = 0
local var_0_10 = 0

function var_0_0.Update(arg_1_0, arg_1_1)
	var_0_1.stage_id = arg_1_1.challenge_stage.stage_id
	var_0_1.max_challenge_value = arg_1_1.challenge_stage.max_challenge_value
	var_0_1.challenge_lock = arg_1_1.challenge_stage.challenge_lock
	var_0_1.recently_challenge_value = arg_1_1.challenge_stage.recently_challenge_value
	var_0_1.min_seconds = arg_1_1.challenge_stage.min_seconds
	var_0_2 = cleanProtoTable(arg_1_1.common_stage)
	var_0_4 = cleanProtoTable(arg_1_1.finish_assignment_list)
	var_0_8 = arg_1_1.first_enter
	var_0_9 = arg_1_1.cur_point
	var_0_10 = arg_1_1.max_point

	CoreVerificationChallengeTools.InitCache()

	var_0_6 = CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE3)

	var_0_0:InitTaskInfo()
end

function var_0_0.InitTaskInfo(arg_2_0)
	var_0_5 = {}

	local var_2_0 = ActivityCfg[var_0_6].sub_activity_list[2]
	local var_2_1 = CoreVerificationClRewardCfg.get_id_list_by_activity_id[var_2_0]

	if var_2_1 and #var_0_5 < #var_2_1 then
		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			local var_2_2 = var_0_0:GetTaskState(iter_2_1)
			local var_2_3 = {
				taskId = iter_2_1,
				state = var_2_2,
				reward_type = CoreVerificationClRewardCfg[iter_2_1].reward_type
			}

			table.insert(var_0_5, var_2_3)
		end
	end
end

function var_0_0.UpdateRewardData(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1.assignment_id) do
		for iter_3_2, iter_3_3 in ipairs(var_0_5) do
			if iter_3_1 == iter_3_3.taskId then
				iter_3_3.state = 2

				break
			end
		end
	end
end

function var_0_0.UpdateFinishTaskData(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1.assignment_id) do
		for iter_4_2, iter_4_3 in ipairs(var_0_4) do
			if iter_4_1 == iter_4_3.assignment_id then
				iter_4_3.state = 2

				break
			end
		end
	end
end

function var_0_0.GetAllTaskInfo(arg_5_0)
	return var_0_5
end

function var_0_0.GetTaskInfoById(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0:GetAllTaskInfo()) do
		if iter_6_1.taskId == arg_6_1 then
			var_6_0 = iter_6_1

			return var_6_0
		end
	end

	return var_6_0
end

function var_0_0.GetTaskState(arg_7_0, arg_7_1)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0:GetFinishAssignmentList()) do
		if arg_7_1 == iter_7_1.assignment_id then
			var_7_0 = iter_7_1.state

			return var_7_0
		end
	end

	return var_7_0
end

function var_0_0.IsGetTaskReward(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0:GetFinishAssignmentList()) do
		if iter_8_1.state == 2 then
			return true
		end
	end

	return false
end

function var_0_0.IsCanGetTaskReward(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0:GetFinishAssignmentList()) do
		if iter_9_1.state == 1 then
			return 1
		end
	end

	return 0
end

function var_0_0.IsGetAllTaskReward(arg_10_0)
	local var_10_0 = arg_10_0:GetFinishAssignmentList()

	if #var_10_0 <= 0 then
		return false
	end

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1.state ~= 2 then
			return false
		end
	end

	return true
end

function var_0_0.GetCommonStage(arg_11_0)
	return var_0_2
end

function var_0_0.GetChallengeStage(arg_12_0)
	return var_0_1
end

function var_0_0.GetFinishAssignmentList(arg_13_0)
	return var_0_4
end

function var_0_0.GetChallengeStageCfg(arg_14_0)
	local var_14_0 = CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE3)

	for iter_14_0, iter_14_1 in ipairs(CoreVerificationClMode3Cfg.get_id_list_by_stage_type[2]) do
		local var_14_1 = CoreVerificationClMode3Cfg[iter_14_1]

		if var_14_1.activity_id == var_14_0 then
			return var_14_1
		end
	end

	return nil
end

function var_0_0.GetCommonStageByIndex(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(var_0_2) do
		if iter_15_1.stage_id == arg_15_1 then
			return iter_15_1
		end
	end

	return nil
end

function var_0_0.ResetCommonStage(arg_16_0)
	var_0_2 = {}
end

function var_0_0.GetActivityId(arg_17_0)
	return var_0_6
end

function var_0_0.GetSeasonIsTips(arg_18_0)
	return var_0_8
end

function var_0_0.SetSeasonIsTips(arg_19_0)
	var_0_8 = false
end

function var_0_0.IsJumpAllStage(arg_20_0)
	local var_20_0 = false

	if var_0_1.stage_id and var_0_1.stage_id > 0 then
		var_20_0 = true
	end

	return #var_0_2 >= 3 and var_20_0
end

function var_0_0.GetAllScore(arg_21_0)
	local var_21_0 = var_0_1.recently_challenge_value
	local var_21_1 = 0

	for iter_21_0, iter_21_1 in ipairs(var_0_2) do
		var_21_1 = var_21_1 + iter_21_1.recently_normal_value
	end

	return var_21_0 + var_21_1
end

function var_0_0.GetRankScore(arg_22_0)
	return arg_22_0:GetMaxPoint()
end

function var_0_0.GetLastScore(arg_23_0)
	local var_23_0 = var_0_1.recently_challenge_value
	local var_23_1 = 0

	for iter_23_0, iter_23_1 in ipairs(var_0_2) do
		var_23_1 = var_23_1 + iter_23_1.reset_normal_value
	end

	var_23_0 = var_23_0 or 0

	return var_23_0 + var_23_1
end

function var_0_0.GetCurPoint(arg_24_0)
	return var_0_9
end

function var_0_0.GetMaxPoint(arg_25_0)
	return var_0_10
end

function var_0_0.PushStageLockedHero(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_1.stageID
	local var_26_1 = arg_26_0:GetChallengeStage()

	if var_26_0 ~= var_26_1.stage_id and var_26_1.challenge_lock then
		for iter_26_0, iter_26_1 in ipairs(var_26_1.challenge_lock) do
			table.insert(arg_26_2, iter_26_1)
		end
	end

	local var_26_2 = arg_26_0:GetCommonStage()

	if var_26_2 then
		for iter_26_2, iter_26_3 in ipairs(var_26_2) do
			if var_26_0 ~= iter_26_3.stage_id then
				for iter_26_4, iter_26_5 in ipairs(iter_26_3.common_lock_id) do
					table.insert(arg_26_2, iter_26_5)
				end
			end
		end
	end
end

return var_0_0
