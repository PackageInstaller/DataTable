local var_0_0 = singletonClass("CoreVerificationChallengeData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = 0
local var_0_8 = {}
local var_0_9 = false

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
	var_0_3 = cleanProtoTable(arg_1_1.buff_list)
	var_0_4 = cleanProtoTable(arg_1_1.finish_assignment_list)
	var_0_9 = arg_1_1.first_enter

	CoreVerificationChallengeTools.InitCache()

	var_0_7 = CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1)

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
	return var_0_5 or {}
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

function var_0_0.IsGetAllTaskReward(arg_9_0)
	if #var_0_4 <= 0 then
		return false
	end

	for iter_9_0, iter_9_1 in ipairs(var_0_4) do
		if iter_9_1.state ~= 2 then
			return false
		end
	end

	return true
end

function var_0_0.IsCanGetTaskReward(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(var_0_4) do
		if iter_10_1.state == 1 then
			return 1
		end
	end

	return 0
end

function var_0_0.GetCommonStage(arg_11_0)
	return var_0_2 or {}
end

function var_0_0.GetChallengeStage(arg_12_0)
	return var_0_1 or {}
end

function var_0_0.GetBuffList(arg_13_0)
	return var_0_3 or {}
end

function var_0_0.GetFinishAssignmentList(arg_14_0)
	return var_0_4 or {}
end

function var_0_0.GetChallengeStageCfg(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(CoreVerificationClMode1Cfg.get_id_list_by_stage_type[2]) do
		local var_15_0 = CoreVerificationClMode1Cfg[iter_15_1]
		local var_15_1 = CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1)

		if var_15_0.activity_id == var_15_1 then
			return var_15_0
		end
	end

	return {}
end

function var_0_0.GetCommonStageByIndex(arg_16_0, arg_16_1)
	return var_0_2[arg_16_1]
end

function var_0_0.GetBuffLevelById(arg_17_0, arg_17_1)
	local var_17_0 = 1

	if var_0_3 then
		for iter_17_0, iter_17_1 in ipairs(var_0_3) do
			if iter_17_1.buff_id == arg_17_1 then
				var_17_0 = iter_17_1.level
			end
		end
	end

	if var_17_0 == 50 or var_17_0 == 0 then
		var_17_0 = 1
	end

	return var_17_0
end

function var_0_0.IsUnLockBuffById(arg_18_0, arg_18_1)
	local var_18_0 = false

	if var_0_3 then
		for iter_18_0, iter_18_1 in ipairs(var_0_3) do
			if iter_18_1.buff_id == arg_18_1 then
				var_18_0 = true
			end
		end
	end

	return var_18_0
end

function var_0_0.SetSelectAffixsAdd(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = var_0_0:GetBuffLevelById(arg_19_1)
	local var_19_1 = {
		buff_id = arg_19_1,
		level = var_19_0 == 50 and 1 or var_19_0,
		type = arg_19_2
	}

	table.insert(var_0_6, var_19_1)
end

function var_0_0.SetSelectAffixsRemove(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(var_0_6) do
		if iter_20_1.buff_id == arg_20_1 then
			table.remove(var_0_6, iter_20_0)

			return
		end
	end
end

function var_0_0.GetSelectAffixs(arg_21_0)
	return var_0_6
end

function var_0_0.IsSelectAffixById(arg_22_0, arg_22_1)
	local var_22_0 = false

	for iter_22_0, iter_22_1 in ipairs(var_0_6) do
		if iter_22_1.buff_id == arg_22_1 then
			var_22_0 = true
		end
	end

	return var_22_0
end

function var_0_0.GetEfficiencyNum(arg_23_0)
	local var_23_0 = 100
	local var_23_1 = var_0_0:GetChallengeStageCfg()

	for iter_23_0, iter_23_1 in ipairs(var_0_6) do
		for iter_23_2, iter_23_3 in ipairs(var_23_1.stage_debuff) do
			if iter_23_1.buff_id == iter_23_3[1] then
				var_23_0 = var_23_0 + iter_23_3[2]
			end
		end

		for iter_23_4, iter_23_5 in ipairs(var_23_1.stage_buff) do
			if iter_23_1.buff_id == iter_23_5[1] then
				var_23_0 = var_23_0 + iter_23_5[2]
			end
		end
	end

	return var_23_0 .. "%"
end

function var_0_0.GetActivityId(arg_24_0)
	return var_0_7
end

function var_0_0.UpdateIllustrated(arg_25_0, arg_25_1)
	illustrated = arg_25_1.illustrated
end

function var_0_0.GetIllustrated(arg_26_0)
	return illustrated or {}
end

function var_0_0.GetMaxIllustrated(arg_27_0)
	local var_27_0 = -1
	local var_27_1 = 0

	for iter_27_0, iter_27_1 in ipairs(arg_27_0:GetIllustrated()) do
		local var_27_2 = CoreVerificationClBadgeCfg[iter_27_1.illustrated_id]

		if var_27_2.activity_id == CoreVerificationChallengeTools.GetActivityId() then
			if var_27_2.level == 0 and var_27_0 < var_27_2.level and var_27_1 < iter_27_1.illustrated_id then
				var_27_1 = iter_27_1.illustrated_id
			end

			if var_27_2 and var_27_0 < var_27_2.level then
				var_27_0 = var_27_2.level
				var_27_1 = iter_27_1.illustrated_id
			end
		end
	end

	return var_27_1
end

function var_0_0.IsUnlockIllustratedById(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0:GetIllustrated()) do
		if arg_28_1 == iter_28_1.illustrated_id then
			return true
		end
	end

	return false
end

function var_0_0.GetIllustratedInfoByLevel(arg_29_0, arg_29_1, arg_29_2)
	for iter_29_0, iter_29_1 in ipairs(CoreVerificationClBadgeCfg.all) do
		local var_29_0 = CoreVerificationClBadgeCfg[iter_29_1]

		if arg_29_1 == var_29_0.level and var_29_0.set_id == arg_29_2 then
			return var_29_0
		end
	end

	return {}
end

function var_0_0.GetIllustratedById(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0:GetIllustrated()) do
		if arg_30_1 == iter_30_1.illustrated_id then
			return iter_30_1
		end
	end

	return {}
end

function var_0_0.IsUnLockIllustrated(arg_31_0, arg_31_1)
	local var_31_0 = false

	for iter_31_0, iter_31_1 in ipairs(arg_31_0:GetIllustrated()) do
		local var_31_1 = CoreVerificationClBadgeCfg[iter_31_1.illustrated_id]

		if arg_31_1 == iter_31_1.illustrated_id then
			var_31_0 = true
		end
	end

	return var_31_0
end

function var_0_0.GetSeasonIsTips(arg_32_0)
	return var_0_9
end

function var_0_0.SetSeasonIsTips(arg_33_0)
	var_0_9 = false
end

function var_0_0.IsJumpAllStage(arg_34_0)
	local var_34_0 = false

	if var_0_1.stage_id and var_0_1.stage_id > 0 then
		var_34_0 = true
	end

	return #var_0_2 >= 2 and var_34_0
end

function var_0_0.ResetSelectAffix(arg_35_0)
	var_0_6 = {}
end

function var_0_0.GetAffixState(arg_36_0, arg_36_1)
	local var_36_0 = var_0_0:GetChallengeStageCfg()

	for iter_36_0, iter_36_1 in ipairs(var_36_0.stage_buff) do
		if iter_36_1[1] == arg_36_1 then
			return 1
		end
	end

	for iter_36_2, iter_36_3 in ipairs(var_36_0.stage_debuff) do
		if iter_36_3[1] == arg_36_1 then
			return 2
		end
	end

	return 1
end

function var_0_0.PushStageLockedHero(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_1.stageID
	local var_37_1 = arg_37_0:GetChallengeStage()

	if var_37_0 ~= var_37_1.stage_id and var_37_1.challenge_lock then
		for iter_37_0, iter_37_1 in ipairs(var_37_1.challenge_lock) do
			table.insert(arg_37_2, iter_37_1)
		end
	end

	local var_37_2 = arg_37_0:GetCommonStage()

	if var_37_2 then
		for iter_37_2, iter_37_3 in ipairs(var_37_2) do
			if var_37_0 ~= iter_37_3.stage_id then
				for iter_37_4, iter_37_5 in ipairs(iter_37_3.common_lock_id) do
					table.insert(arg_37_2, iter_37_5)
				end
			end
		end
	end
end

function var_0_0.GetRankScore(arg_38_0)
	return arg_38_0:GetChallengeStage().max_challenge_value
end

return var_0_0
