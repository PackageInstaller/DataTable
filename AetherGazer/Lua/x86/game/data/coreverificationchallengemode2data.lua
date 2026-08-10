local var_0_0 = singletonClass("CoreVerificationChallengeMode2Data")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = 0
local var_0_8 = {}
local var_0_9 = true

function var_0_0.Update(arg_1_0, arg_1_1)
	var_0_1.stage_id = arg_1_1.challenge_stage.stage_id
	var_0_1.max_challenge_value = arg_1_1.challenge_stage.max_challenge_value
	var_0_1.challenge_lock = arg_1_1.challenge_stage.challenge_lock
	var_0_1.challenge_buff = arg_1_1.challenge_stage.challenge_buff

	local var_1_0 = cleanProtoTable(var_0_1.challenge_buff)

	var_0_6 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_1 = var_0_0:GetAffixState(iter_1_1)

		var_0_0:SetSelectAffixsAdd(iter_1_1, var_1_1)
	end

	var_0_1.recently_challenge_value = arg_1_1.challenge_stage.recently_challenge_value
	var_0_2 = cleanProtoTable(arg_1_1.common_stage)
	var_0_4 = cleanProtoTable(arg_1_1.finish_assignment_list)
	var_0_9 = arg_1_1.first_enter

	CoreVerificationChallengeTools.InitCache()

	var_0_7 = CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2)

	var_0_0:InitTaskInfo()
end

function var_0_0.InitTaskInfo(arg_2_0)
	var_0_5 = {}

	local var_2_0 = ActivityCfg[var_0_7].sub_activity_list[2]
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

	for iter_6_0, iter_6_1 in ipairs(var_0_5) do
		if iter_6_1.taskId == arg_6_1 then
			var_6_0 = iter_6_1

			return var_6_0
		end
	end

	return var_6_0
end

function var_0_0.GetTaskState(arg_7_0, arg_7_1)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(var_0_4) do
		if arg_7_1 == iter_7_1.assignment_id then
			var_7_0 = iter_7_1.state

			return var_7_0
		end
	end

	return var_7_0
end

function var_0_0.IsGetTaskReward(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(var_0_4) do
		if iter_8_1.state == 2 then
			return true
		end
	end

	return false
end

function var_0_0.IsCanGetTaskReward(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(var_0_4) do
		if iter_9_1.state == 1 then
			return 1
		end
	end

	return 0
end

function var_0_0.GetCommonStage(arg_10_0)
	return var_0_2
end

function var_0_0.GetChallengeStage(arg_11_0)
	return var_0_1
end

function var_0_0.GetFinishAssignmentList(arg_12_0)
	return var_0_4
end

function var_0_0.GetChallengeStageCfg(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(CoreVerificationClMode2Cfg.get_id_list_by_stage_type[2]) do
		local var_13_0 = CoreVerificationClMode2Cfg[iter_13_1]
		local var_13_1 = CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2)

		if var_13_0.activity_id == var_13_1 then
			return var_13_0
		end
	end

	return nil
end

function var_0_0.GetCommonStageByIndex(arg_14_0, arg_14_1)
	return var_0_2[arg_14_1]
end

function var_0_0.SetSelectAffixsAdd(arg_15_0, arg_15_1, arg_15_2)
	affixCfg = ActivityAffixPoolCfg[arg_15_1]

	local var_15_0 = {
		buff_id = arg_15_1,
		level = affixCfg.affix[2],
		type = arg_15_2,
		point = affixCfg.point
	}

	for iter_15_0, iter_15_1 in ipairs(var_0_6) do
		if iter_15_1.buff_id == arg_15_1 then
			return
		end
	end

	table.insert(var_0_6, var_15_0)
end

function var_0_0.SetSelectAffixsRemove(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(var_0_6) do
		if iter_16_1.buff_id == arg_16_1 then
			table.remove(var_0_6, iter_16_0)

			return
		end
	end
end

function var_0_0.GetSelectAffixs(arg_17_0)
	return var_0_6
end

function var_0_0.IsSelectAffixById(arg_18_0, arg_18_1)
	local var_18_0 = false

	for iter_18_0, iter_18_1 in ipairs(var_0_6) do
		if iter_18_1.buff_id == arg_18_1 then
			var_18_0 = true
		end
	end

	return var_18_0
end

function var_0_0.GetEfficiencyNum(arg_19_0)
	local var_19_0 = 1
	local var_19_1 = var_0_0:GetChallengeStageCfg()
	local var_19_2, var_19_3, var_19_4 = var_0_0:GetPostNum()

	return 100 * (var_19_4 * GameSetting.core_verification_cl_score_2.value[3] + var_19_0) .. "%"
end

function var_0_0.GetPostNum(arg_20_0)
	local var_20_0 = 0
	local var_20_1 = var_0_0:GetPostLimitNum()
	local var_20_2 = 0
	local var_20_3 = var_0_0:GetChallengeStageCfg()

	for iter_20_0, iter_20_1 in ipairs(var_0_6) do
		for iter_20_2, iter_20_3 in ipairs(var_20_3.stage_affix_buff) do
			if iter_20_1.buff_id == iter_20_3 then
				affixCfg = ActivityAffixPoolCfg[iter_20_3]
				var_20_0 = var_20_0 + affixCfg.point
			end
		end

		for iter_20_4, iter_20_5 in ipairs(var_20_3.stage_affix_debuff) do
			if iter_20_1.buff_id == iter_20_5 then
				affixCfg = ActivityAffixPoolCfg[iter_20_5]
				var_20_0 = var_20_0 + affixCfg.point
			end
		end

		for iter_20_6, iter_20_7 in ipairs(var_20_3.stage_affix_debuff) do
			if iter_20_1.buff_id == iter_20_7 then
				affixCfg = ActivityAffixPoolCfg[iter_20_7]
				var_20_2 = var_20_2 + affixCfg.point
			end
		end
	end

	return var_20_0, var_20_1, var_20_2
end

function var_0_0.GetPostLimitNum(arg_21_0)
	local var_21_0 = GameSetting.core_verification_cl_cost.value[1]

	for iter_21_0, iter_21_1 in ipairs(var_0_2) do
		var_21_0 = var_21_0 + CoreVerificationClMode2Cfg[iter_21_1.stage_id].cost_limit_up
	end

	return var_21_0
end

function var_0_0.ResetCommonStage(arg_22_0)
	var_0_2 = {}
end

function var_0_0.GetActivityId(arg_23_0)
	return var_0_7
end

function var_0_0.GetSeasonIsTips(arg_24_0)
	return var_0_9
end

function var_0_0.SetSeasonIsTips(arg_25_0)
	var_0_9 = false
end

function var_0_0.IsJumpAllStage(arg_26_0)
	local var_26_0 = false

	if var_0_1.stage_id and var_0_1.stage_id > 0 then
		var_26_0 = true
	end

	return #var_0_2 >= 2 and var_26_0
end

function var_0_0.ResetSelectAffix(arg_27_0)
	var_0_6 = {}
end

function var_0_0.IsGetAllTaskReward(arg_28_0)
	if #var_0_4 <= 0 then
		return false
	end

	for iter_28_0, iter_28_1 in ipairs(var_0_4) do
		if iter_28_1.state ~= 2 then
			return false
		end
	end

	return true
end

function var_0_0.GetAffixState(arg_29_0, arg_29_1)
	local var_29_0 = var_0_0:GetChallengeStageCfg()

	for iter_29_0, iter_29_1 in ipairs(var_29_0.stage_affix_buff) do
		if iter_29_1 == arg_29_1 then
			return 1
		end
	end

	for iter_29_2, iter_29_3 in ipairs(var_29_0.stage_affix_debuff) do
		if iter_29_3 == arg_29_1 then
			return 2
		end
	end

	return 1
end

function var_0_0.PushStageLockedHero(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_1.stageID
	local var_30_1 = arg_30_0:GetChallengeStage()

	if var_30_0 ~= var_30_1.stage_id and var_30_1.challenge_lock then
		for iter_30_0, iter_30_1 in ipairs(var_30_1.challenge_lock) do
			table.insert(arg_30_2, iter_30_1)
		end
	end

	local var_30_2 = arg_30_0:GetCommonStage()

	if var_30_2 then
		for iter_30_2, iter_30_3 in ipairs(var_30_2) do
			if var_30_0 ~= iter_30_3.stage_id then
				for iter_30_4, iter_30_5 in ipairs(iter_30_3.common_lock_id) do
					table.insert(arg_30_2, iter_30_5)
				end
			end
		end
	end
end

function var_0_0.GetRankScore(arg_31_0)
	return arg_31_0:GetChallengeStage().max_challenge_value
end

return var_0_0
