local ChallengeRogueAttributeValueData = class("ChallengeRogueAttributeValueData")

function ChallengeRogueAttributeValueData:ExportMethod()
	return {
		"GetTaskActivityIDByTemple",
		"GetStageTaskIDByActivtiyIDAndStage",
		"GetTaskIDListByActivtiyIDAndStage",
		"GetUnCompletedTaskStage"
	}
end

function ChallengeRogueAttributeValueData:Init()
	return
end

function ChallengeRogueAttributeValueData:GetTaskActivityIDByTemple(arg_3_1)
	if RogueTeamCfg[arg_3_1] then
		for iter_3_0, iter_3_1 in ipairs(ActivityCfg[RogueTeamCfg[arg_3_1].activity_id] and ActivityCfg[RogueTeamCfg[arg_3_1].activity_id].sub_activity_list) do
			if ActivityCfg[iter_3_1].activity_template == ActivityTemplateConst.CHALLENGE_ROGUE_TEAM_TASK then
				return iter_3_1
			end
		end
	end

	return nil
end

function ChallengeRogueAttributeValueData:GetStageTaskIDByActivtiyIDAndStage(arg_4_1, arg_4_2)
	if AssignmentCfg.get_id_list_by_activity_id[arg_4_1] then
		for iter_4_0, iter_4_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[arg_4_1]) do
			if AssignmentCfg[iter_4_1].phase == arg_4_2 and AssignmentCfg[iter_4_1].type == TaskConst.TASK_TYPE.CHALLENGE_ROGUE_TEAM_STAGE_TASK then
				return iter_4_1
			end
		end
	end

	return nil
end

function ChallengeRogueAttributeValueData:GetTaskIDListByActivtiyIDAndStage(arg_5_1, arg_5_2)
	local var_5_0 = {}

	if AssignmentCfg.get_id_list_by_activity_id[arg_5_1] then
		for iter_5_0, iter_5_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[arg_5_1]) do
			if AssignmentCfg[iter_5_1].phase == arg_5_2 and AssignmentCfg[iter_5_1].condition ~= 300001 then
				table.insert(var_5_0, iter_5_1)
			end
		end
	end

	return var_5_0
end

function ChallengeRogueAttributeValueData:GetUnCompletedTaskStage(arg_6_1)
	local var_6_0 = 0

	if AssignmentCfg.get_id_list_by_activity_id[arg_6_1] then
		for iter_6_0, iter_6_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[arg_6_1]) do
			if AssignmentCfg[iter_6_1].type == TaskConst.TASK_TYPE.CHALLENGE_ROGUE_TEAM_STAGE_TASK and not TaskData2:GetTaskComplete(iter_6_1) then
				return AssignmentCfg[iter_6_1].phase
			end

			var_6_0 = math.max(var_6_0, AssignmentCfg[iter_6_1].phase)
		end
	end

	return var_6_0
end

return ChallengeRogueAttributeValueData
