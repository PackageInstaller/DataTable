local var_0_0 = {}
local var_0_1 = {
	[ActivityConst.ACTIVITY_2_10_HERO_LETTER] = "Widget/Version/NorseUI_3_0/NorseUI_3_0_NianUI/NorseUI_3_0_NianMianUI"
}

function var_0_0.GetEnterUIName(arg_1_0)
	return var_0_1[arg_1_0]
end

local var_0_2 = {
	[ActivityConst.ACTIVITY_2_10_HERO_LETTER] = "Widget/Version/NorseUI_3_0/NorseUI_3_0_NianUI/NorseNianStageUI"
}

function var_0_0.GetMainUIName(arg_2_0)
	return var_0_2[arg_2_0]
end

local var_0_3 = {
	[ActivityConst.ACTIVITY_2_10_HERO_LETTER] = "Widget/Version/NorseUI_3_0/NorseUI_3_0_NianUI/NorseNianRecallUI"
}

function var_0_0.GetPlayBackUIName(arg_3_0)
	return var_0_3[arg_3_0]
end

local var_0_4 = {
	[ActivityConst.ACTIVITY_2_10_HERO_LETTER] = "Widget/Version/NorseUI_3_0/NorseUI_3_0_NianUI/NorseNianRoleUI"
}

function var_0_0.GetTaskUIName(arg_4_0)
	return var_0_4[arg_4_0]
end

local var_0_5 = {
	[ActivityConst.ACTIVITY_2_10_HERO_LETTER] = "ACTIVITY_HERO_TASK_DESC"
}

function var_0_0.GetHelpKey(arg_5_0)
	return var_0_5[arg_5_0] or ""
end

function var_0_0.IsReward(arg_6_0)
	local var_6_0 = ActivityHeroTaskCfg[arg_6_0].task_id
	local var_6_1 = TaskData2:GetTask(var_6_0)

	return var_6_1 and var_6_1.complete_flag == 1
end

return var_0_0
