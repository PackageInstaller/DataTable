local var_0_0 = {
	GetTaskUIName = function(arg_1_0)
		local var_1_0 = ActivityTools.GetActivityTheme(arg_1_0)

		if var_1_0 >= ActivityConst.THEME.ACTIVITY_5_0 then
			return "Widget/Version/Alone_SpecialJigsawUI/ActivitySpecialJigsawTaskUI"
		elseif var_1_0 >= ActivityConst.THEME.ACTIVITY_3_8 then
			return "Widget/System/Activity_Resident/Activity_SpecialJigsawUI/ActivitySpecialJigsawTaskUI"
		elseif var_1_0 == ActivityConst.THEME.ACTIVITY_2_1 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawUI"
		elseif var_1_0 == ActivityConst.THEME.ACTIVITY_2_8 then
			return "UI/VersionUI/IndiaUI_2_8/IndiaJigsawUI/IndiaJigsawUI"
		else
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawUI"
		end
	end,
	GetPlayViewUIName = function(arg_2_0)
		local var_2_0 = ActivityTools.GetActivityTheme(arg_2_0)

		if var_2_0 >= ActivityConst.THEME.ACTIVITY_5_0 then
			return "Widget/Version/Alone_SpecialJigsawUI/ActivitySpecialJigsawPuzzleUI"
		elseif var_2_0 >= ActivityConst.THEME.ACTIVITY_3_8 then
			return "Widget/System/Activity_Resident/Activity_SpecialJigsawUI/ActivitySpecialJigsawPuzzleUI"
		elseif var_2_0 == ActivityConst.THEME.ACTIVITY_2_1 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzleUI"
		elseif var_2_0 == ActivityConst.THEME.ACTIVITY_2_8 then
			return "UI/VersionUI/IndiaUI_2_8/IndiaJigsawUI/IndiaJigsawPuzzleUI"
		else
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzleUI"
		end
	end,
	GetRewardViewUIName = function(arg_3_0)
		local var_3_0 = ActivityTools.GetActivityTheme(arg_3_0)

		if var_3_0 >= ActivityConst.THEME.ACTIVITY_5_0 then
			return "Widget/Version/Alone_SpecialJigsawUI/ActivitySpecialJigsawPuzzlePop2UI"
		elseif var_3_0 >= ActivityConst.THEME.ACTIVITY_3_8 then
			return "Widget/System/Activity_Resident/Activity_SpecialJigsawUI/ActivitySpecialJigsawPuzzlePop2UI"
		elseif var_3_0 == ActivityConst.THEME.ACTIVITY_2_1 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzlePop2UI"
		elseif var_3_0 == ActivityConst.THEME.ACTIVITY_2_8 then
			return "UI/VersionUI/IndiaUI_2_8/IndiaJigsawUI/IndiaJigsawPuzzlePop2UI"
		else
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzlePop2UI"
		end
	end,
	GetPreviewUIName = function(arg_4_0)
		local var_4_0 = ActivityTools.GetActivityTheme(arg_4_0)

		if var_4_0 >= ActivityConst.THEME.ACTIVITY_5_0 then
			return "Widget/Version/Alone_SpecialJigsawUI/ActivitySpecialJigsawPuzzlePop1UI"
		elseif var_4_0 >= ActivityConst.THEME.ACTIVITY_3_8 then
			return "Widget/System/Activity_Resident/Activity_SpecialJigsawUI/ActivitySpecialJigsawPuzzlePop1UI"
		elseif var_4_0 == ActivityConst.THEME.ACTIVITY_2_1 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzlePop1UI"
		elseif var_4_0 == ActivityConst.THEME.ACTIVITY_2_8 then
			return "UI/VersionUI/IndiaUI_2_8/IndiaJigsawUI/IndiaJigsawPuzzlePop1UI"
		else
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzlePop1UI"
		end
	end,
	GetCheckPreviewUIName = function(arg_5_0)
		local var_5_0 = ActivityTools.GetActivityTheme(arg_5_0)

		if var_5_0 >= ActivityConst.THEME.ACTIVITY_5_0 then
			return "Widget/Version/Alone_SpecialJigsawUI/ActivitySpecialJigsawPuzzlePop3UI"
		elseif var_5_0 >= ActivityConst.THEME.ACTIVITY_3_8 then
			return "Widget/System/Activity_Resident/Activity_SpecialJigsawUI/ActivitySpecialJigsawPuzzlePop3UI"
		elseif var_5_0 == ActivityConst.THEME.ACTIVITY_2_1 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzlePop3UI"
		elseif var_5_0 == ActivityConst.THEME.ACTIVITY_2_8 then
			return "UI/VersionUI/IndiaUI_2_8/IndiaJigsawUI/IndiaJigsawPuzzlePop3UI"
		else
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzlePop3UI"
		end
	end,
	GetTaskItemClass = function(arg_6_0)
		local var_6_0 = ActivityTools.GetActivityTheme(arg_6_0)

		if var_6_0 >= ActivityConst.THEME.ACTIVITY_3_8 then
			return PuzzleNewTaskItem_Resident
		elseif var_6_0 == ActivityConst.THEME.ACTIVITY_2_1 then
			return PuzzleNewTaskItem
		elseif var_6_0 == ActivityConst.THEME.ACTIVITY_2_8 then
			return IndiaPuzzleNewTaskItem
		else
			return PuzzleNewTaskItem
		end
	end
}

function var_0_0.InitConfig(arg_7_0)
	local var_7_0 = PuzzleNewCfg[arg_7_0]

	var_0_0.puzzlePosDic = var_0_0.puzzlePosDic or {}
	var_0_0.puzzlePosDic[arg_7_0] = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0.correct_array) do
		var_0_0.puzzlePosDic[arg_7_0][iter_7_1] = iter_7_0
	end

	local var_7_1 = var_7_0.reward_area_list

	var_0_0.regionPosDic = var_0_0.regionPosDic or {}
	var_0_0.regionPosDic[arg_7_0] = {}
	var_0_0.regionCfgList = var_0_0.regionCfgList or {}
	var_0_0.regionCfgList[arg_7_0] = {}

	for iter_7_2, iter_7_3 in ipairs(var_7_0.area_fragment_list) do
		local var_7_2 = iter_7_3[1]
		local var_7_3 = iter_7_3[2]
		local var_7_4 = var_7_1[iter_7_2][2]

		var_0_0.regionPosDic[arg_7_0][var_7_2] = iter_7_2
		var_0_0.regionCfgList[arg_7_0][var_7_2] = {}
		var_0_0.regionCfgList[arg_7_0][var_7_2].reward = var_7_4
		var_0_0.regionCfgList[arg_7_0][var_7_2].puzzle = var_7_3
	end
end

function var_0_0.GetPuzzlePosDic(arg_8_0)
	local var_8_0

	if var_0_0.puzzlePosDic and var_0_0.puzzlePosDic[arg_8_0] then
		var_8_0 = var_0_0.puzzlePosDic[arg_8_0]
	else
		var_8_0 = {}
	end

	return var_8_0
end

function var_0_0.GetRegionPosDic(arg_9_0)
	local var_9_0

	if var_0_0.regionPosDic and var_0_0.regionPosDic[arg_9_0] then
		var_9_0 = var_0_0.regionPosDic[arg_9_0]
	else
		var_9_0 = {}
	end

	return var_9_0
end

function var_0_0.GetRegionCfgList(arg_10_0)
	local var_10_0

	if var_0_0.regionCfgList and var_0_0.regionCfgList[arg_10_0] then
		var_10_0 = var_0_0.regionCfgList[arg_10_0]
	else
		var_10_0 = {}
	end

	return var_10_0
end

function var_0_0.FindPuzzleByScreenPos(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0, var_11_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_11_0, arg_11_3.position, arg_11_3.pressEventCamera, nil)
	local var_11_2 = arg_11_0.sizeDelta
	local var_11_3 = var_11_2.x
	local var_11_4 = var_11_2.y
	local var_11_5 = var_11_1.x
	local var_11_6 = var_11_4 - var_11_1.y
	local var_11_7 = math.ceil(var_11_6 / var_11_4 * arg_11_2)
	local var_11_8 = math.ceil(var_11_5 / var_11_3 * arg_11_1)

	if var_11_8 < 1 or var_11_7 < 1 or arg_11_1 < var_11_8 or arg_11_2 < var_11_7 then
		return false, -1
	else
		local var_11_9 = (var_11_7 - 1) * arg_11_1 + var_11_8

		return true, var_11_9
	end
end

function var_0_0.CheckWrongSide(arg_12_0, arg_12_1)
	local var_12_0 = PuzzleNewCfg[arg_12_1].correct_array
	local var_12_1 = PuzzleNewData:GetCurPuzzleList(arg_12_1)

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		if arg_12_0 then
			if var_12_1[iter_12_0] == nil then
				return true
			end
		elseif var_12_1[iter_12_0] ~= nil and var_12_1[iter_12_0] ~= iter_12_1 then
			return true
		end
	end

	return false
end

function var_0_0.CheckRegionResult(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(var_0_0.regionCfgList[arg_13_0]) do
		if var_0_0.CheckRegionResultByRegionID(iter_13_0, arg_13_0) then
			table.insertto(var_13_1, iter_13_1.reward)

			var_13_0[#var_13_0 + 1] = iter_13_0
		end
	end

	return var_13_0, var_13_1
end

function var_0_0.CheckRegionResultByRegionID(arg_14_0, arg_14_1)
	if PuzzleNewData:GetRegionReceivedList(arg_14_1)[arg_14_0] then
		return false
	else
		local var_14_0 = PuzzleNewData:GetCurPuzzleList(arg_14_1)
		local var_14_1 = var_0_0.regionCfgList[arg_14_1][arg_14_0].puzzle

		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			local var_14_2 = var_0_0.puzzlePosDic[arg_14_1][iter_14_1]

			if not var_14_0[var_14_2] or var_14_0[var_14_2] ~= iter_14_1 then
				return false
			end
		end
	end

	return true
end

return var_0_0
