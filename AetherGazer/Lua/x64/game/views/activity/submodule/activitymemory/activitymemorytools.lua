local var_0_0 = {}
local var_0_1 = {
	[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY] = "SPRING_FESTIVAL_MEMORY_DES"
}

function var_0_0.GetHelpKey(arg_1_0)
	return var_0_1[arg_1_0] or ""
end

local var_0_2 = {
	[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY] = "UI/VersionUI/IndiaUI_2_8/IndiaRecall/IndiaRecallMainUI"
}

function var_0_0.GetEnterUIName(arg_2_0)
	return var_0_2[arg_2_0]
end

local var_0_3 = {
	[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY] = "UI/VersionUI/IndiaUI_2_8/IndiaRecall/IndiaRecallPopUI"
}

function var_0_0.GetInfoUIName(arg_3_0)
	return var_0_3[arg_3_0]
end

local var_0_4 = {
	[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY] = ActivityConst.ACTIVITY_2_8_SPRING_MEMORY_TASK
}

function var_0_0.GetTaskActivityID(arg_4_0)
	return var_0_4[arg_4_0]
end

local var_0_5 = {
	[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY] = GameSetting.spring_festival_memory_story_start.value
}

function var_0_0.GetEnterCondition(arg_5_0)
	return var_0_5[arg_5_0]
end

local var_0_6 = {
	[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY] = GameSetting.spring_festival_memory_story_process.value
}

function var_0_0.GetActivityCondition(arg_6_0)
	return var_0_6[arg_6_0]
end

local var_0_7 = {
	[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY] = GameSetting.spring_festival_memory_story_end.value
}

function var_0_0.GetCollectCondition(arg_7_0)
	return var_0_7[arg_7_0]
end

return var_0_0
