local var_0_0 = class("ChallengeRogueAttributeValueData")

function var_0_0.ExportMethod(arg_1_0)
	return {
		"GetTaskActivityIDByTemple",
		"GetStageTaskIDByActivtiyIDAndStage",
		"GetTaskIDListByActivtiyIDAndStage",
		"GetUnCompletedTaskStage"
	}
end

function var_0_0.Init(arg_2_0)
	return
end

function var_0_0.GetTaskActivityIDByTemple(arg_3_0, arg_3_1)
	local var_3_0 = RogueTeamCfg[arg_3_1]

	if var_3_0 then
		local var_3_1 = ActivityCfg[var_3_0.activity_id] and ActivityCfg[var_3_0.activity_id].sub_activity_list

		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			if ActivityCfg[iter_3_1].activity_template == ActivityTemplateConst.CHALLENGE_ROGUE_TEAM_TASK then
				return iter_3_1
			end
		end
	end

	return nil
end

function var_0_0.GetStageTaskIDByActivtiyIDAndStage(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = AssignmentCfg.get_id_list_by_activity_id[arg_4_1]

	if var_4_0 then
		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			local var_4_1 = AssignmentCfg[iter_4_1]

			if var_4_1.phase == arg_4_2 and var_4_1.type == TaskConst.TASK_TYPE.CHALLENGE_ROGUE_TEAM_STAGE_TASK then
				return iter_4_1
			end
		end
	end

	return nil
end

function var_0_0.GetTaskIDListByActivtiyIDAndStage(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = AssignmentCfg.get_id_list_by_activity_id[arg_5_1]
	local var_5_1 = {}

	if var_5_0 then
		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			local var_5_2 = AssignmentCfg[iter_5_1]

			if var_5_2.phase == arg_5_2 and var_5_2.condition ~= 300001 then
				table.insert(var_5_1, iter_5_1)
			end
		end
	end

	return var_5_1
end

function var_0_0.GetUnCompletedTaskStage(arg_6_0, arg_6_1)
	local var_6_0 = AssignmentCfg.get_id_list_by_activity_id[arg_6_1]
	local var_6_1 = 0

	if var_6_0 then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			local var_6_2 = AssignmentCfg[iter_6_1]

			if var_6_2.type == TaskConst.TASK_TYPE.CHALLENGE_ROGUE_TEAM_STAGE_TASK and not TaskData2:GetTaskComplete(iter_6_1) then
				return var_6_2.phase
			end

			var_6_1 = math.max(var_6_1, var_6_2.phase)
		end
	end

	return var_6_1
end

return var_0_0
