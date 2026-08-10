local var_0_0 = {}
local var_0_1
local var_0_2

local function var_0_3(arg_1_0, arg_1_1)
	return nullable(arg_1_0, arg_1_1) or arg_1_0.default
end

local var_0_4 = {
	default = "UI/VersionUI/IndiaUI_2_8/IndiaAnswerUI/IndiaPreheatMainUI",
	[ActivityConst.THEME.ACTIVITY_3_10] = "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_AnswerUI/SandPlay_Com_AnswerEnterUI"
}

function var_0_0.GetEnterUIName(arg_2_0)
	local var_2_0 = ActivityTools.GetActivityTheme(arg_2_0)

	return var_0_3(var_0_4, var_2_0)
end

local var_0_5 = {
	default = "UI/VersionUI/IndiaUI_2_8/IndiaAnswerUI/IndiaPopUI",
	[ActivityConst.THEME.ACTIVITY_3_10] = "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_AnswerUI/SandPlay_Com_AnswerPopUI"
}

function var_0_0.GetMatchPopUIName(arg_3_0)
	local var_3_0 = ActivityTools.GetActivityTheme(arg_3_0)

	return var_0_3(var_0_5, var_3_0)
end

local var_0_6 = {
	default = "UI/VersionUI/IndiaUI_2_8/IndiaAnswerUI/IndiaShowUI",
	[ActivityConst.THEME.ACTIVITY_3_10] = "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_AnswerUI/SandPlay_Com_AnswerShowUI"
}

function var_0_0.GetResultUIName(arg_4_0)
	local var_4_0 = ActivityTools.GetActivityTheme(arg_4_0)

	return var_0_3(var_0_6, var_4_0)
end

function var_0_0.GetTaskActivityID(arg_5_0)
	return ActivityTools.GetAllTaskSubActivityID(arg_5_0)[1]
end

local var_0_7 = {
	default = "ACTIVITY_QUIZ_DESCRIBE"
}

function var_0_0.GetHelpKey(arg_6_0)
	local var_6_0 = ActivityTools.GetActivityTheme(arg_6_0)

	return var_0_3(var_0_7, var_6_0)
end

local var_0_8 = {
	default = "UI/VersionUI/IndiaUI_2_8/IndiaAnswerUI/IndiaHallUI",
	[ActivityConst.THEME.ACTIVITY_3_10] = "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_AnswerUI/SandPlay_Com_AnswerHallUI"
}

function var_0_0.GetActivitySceneUIName(arg_7_0)
	local var_7_0 = ActivityTools.GetActivityTheme(arg_7_0)

	return var_0_3(var_0_8, var_7_0)
end

local var_0_9 = {
	default = "UI/VersionUI/IndiaUI_2_8/IndiaAnswerUI/AnswerRoleNameUI",
	[ActivityConst.THEME.ACTIVITY_3_10] = "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_AnswerUI/SandPlay_Com_AnswerRoleNameUI"
}

function var_0_0.GetActivityRoleNamePrefab(arg_8_0)
	local var_8_0 = ActivityTools.GetActivityTheme(arg_8_0)

	return var_0_3(var_0_9, var_8_0)
end

local var_0_10 = {
	default = "UI/VersionUI/IndiaUI_2_8/IndiaAnswerUI/AnswerResultRoleRankUI",
	[ActivityConst.THEME.ACTIVITY_3_10] = "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_AnswerUI/SandPlay_Com_AnswerResultRoleRankUI"
}

function var_0_0.GetActivityRoleRankedNamePrefab(arg_9_0)
	local var_9_0 = ActivityTools.GetActivityTheme(arg_9_0)

	return var_0_3(var_0_10, var_9_0)
end

function var_0_0.SetCurActivityID(arg_10_0, arg_10_1)
	var_0_1 = arg_10_0
	var_0_2 = arg_10_1
end

function var_0_0.GetCurActivityID()
	if var_0_1 then
		return var_0_1
	else
		error("未设置活动id")
	end
end

function var_0_0.GetCurActivityBackTo()
	return var_0_2
end

function var_0_0.ClearCurActivityID()
	var_0_1 = nil
	var_0_2 = nil
end

function var_0_0.GetActivitySceneName(arg_14_0)
	return ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[arg_14_0][1]].scene
end

function var_0_0.GetLastSelectedPlayer(arg_15_0)
	local var_15_0 = ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[arg_15_0][1]]

	return getData("activityQuiz", "lastSelectedPlayer_" .. arg_15_0) or var_15_0.character_list[1]
end

function var_0_0.IsInOpenTimeSpan(arg_16_0)
	local var_16_0 = GameSetting.activity_quiz_open_time.value
	local var_16_1 = var_16_0[1]
	local var_16_2 = var_16_0[2]
	local var_16_3 = manager.time:GetServerTime()
	local var_16_4 = tonumber(manager.time:STimeDescS(var_16_3, "!%Y"))
	local var_16_5 = tonumber(manager.time:STimeDescS(var_16_3, "!%m"))
	local var_16_6 = tonumber(manager.time:STimeDescS(var_16_3, "!%d"))
	local var_16_7 = {
		year = var_16_4,
		month = var_16_5,
		day = var_16_6,
		hour = var_16_1[1],
		min = var_16_1[2],
		sec = var_16_1[3]
	}
	local var_16_8 = {
		year = var_16_4,
		month = var_16_5,
		day = var_16_6,
		hour = var_16_2[1],
		min = var_16_2[2],
		sec = var_16_2[3]
	}
	local var_16_9 = manager.time:Table2ServerTime(var_16_7)
	local var_16_10 = manager.time:Table2ServerTime(var_16_8)

	if var_16_9 <= var_16_3 and var_16_3 < var_16_10 then
		return true
	end

	return false
end

function var_0_0.AlreadyEnterHintToday(arg_17_0)
	local var_17_0 = ActivityTools.GetActivityLocalData(arg_17_0, "lastEnter")

	if var_17_0 then
		return manager.time:IsToday(var_17_0)
	end

	return false
end

function var_0_0.AlreadyEnterThisLogin(arg_18_0)
	return var_0_0.alreadyEnterQuizActivityThisLogin
end

function var_0_0.RecordAlreadyEnterThisLogin(arg_19_0)
	var_0_0.alreadyEnterQuizActivityThisLogin = true
end

function var_0_0.AlreadyEnterTodayLocal(arg_20_0)
	local var_20_0 = getData("activity_quiz_enter", tostring(arg_20_0)) or 0

	return manager.time:IsToday(var_20_0)
end

function var_0_0.RecordAlreadyEnterTodayLocal(arg_21_0)
	saveData("activity_quiz_enter", tostring(arg_21_0), manager.time:GetServerTime())
end

function var_0_0.RecordAlreadyHint(arg_22_0)
	ActivityTools.SetActivityLocalData(arg_22_0, "lastEnter", manager.time:GetServerTime())
end

function var_0_0.HintActivityOpen(arg_23_0)
	if not var_0_0.AlreadyEnterHintToday(arg_23_0) then
		QWorldData:AddHint(312571001)
		var_0_0.RecordAlreadyHint(arg_23_0)
	end
end

function var_0_0.CheckQuizActivityHint()
	local var_24_0 = ActivityConst.ACTIVITY_SPRING_QUIZ

	if ActivityTools.GetActivityIsOpenWithTip(var_24_0, false) and var_0_0.IsInOpenTimeSpan(var_24_0) then
		var_0_0.HintActivityOpen(var_24_0)
	end
end

return var_0_0
