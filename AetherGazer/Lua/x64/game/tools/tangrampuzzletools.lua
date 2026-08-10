local var_0_0 = {
	GetTaskUIName = function(arg_1_0)
		return TangramPuzzleCfg[arg_1_0].task_ui_path
	end,
	GetPlayViewUIName = function(arg_2_0)
		return TangramPuzzleCfg[arg_2_0].play_ui_path
	end,
	GetRewardViewUIName = function(arg_3_0)
		return TangramPuzzleCfg[arg_3_0].reward_ui_path
	end
}

function var_0_0.InitConfig(arg_4_0)
	local var_4_0 = TangramPuzzleCfg[arg_4_0]
	local var_4_1 = var_4_0.correct_array
	local var_4_2 = var_4_0.picture_fragment_id

	var_0_0.regionCfgDic = var_0_0.regionCfgDic or {}
	var_0_0.regionCfgDic[arg_4_0] = {}
	var_0_0.regionIndexDic = var_0_0.regionIndexDic or {}
	var_0_0.regionIndexDic[arg_4_0] = {}
	var_0_0.regionIdDicByPuzzleID = var_0_0.regionIdDicByPuzzleID or {}
	var_0_0.regionIdDicByPuzzleID[arg_4_0] = {}
	var_0_0.regionIdDicByPuzzleGlobalIndex = var_0_0.regionIdDicByPuzzleGlobalIndex or {}
	var_0_0.regionIdDicByPuzzleGlobalIndex[arg_4_0] = {}
	var_0_0.puzzleGlobalIndexDic = var_0_0.puzzleGlobalIndexDic or {}
	var_0_0.puzzleGlobalIndexDic[arg_4_0] = {}

	local var_4_3 = 1

	var_0_0.puzzleLocalIndexDicByGlobalIndex = var_0_0.puzzleLocalIndexDicByGlobalIndex or {}
	var_0_0.puzzleLocalIndexDicByGlobalIndex[arg_4_0] = {}
	var_0_0.puzzleLocalIndexDic = var_0_0.puzzleLocalIndexDic or {}
	var_0_0.puzzleLocalIndexDic[arg_4_0] = {}
	var_0_0.puzzleGlobalIndexListByRegionID = var_0_0.puzzleGlobalIndexListByRegionID or {}
	var_0_0.puzzleGlobalIndexListByRegionID[arg_4_0] = {}
	var_0_0.puzzlePictureIdDic = var_0_0.puzzlePictureIdDic or {}
	var_0_0.puzzlePictureIdDic[arg_4_0] = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_4 = iter_4_1[1]
		local var_4_5 = iter_4_1[2]
		local var_4_6 = var_4_2[iter_4_0][2]

		var_0_0.regionIndexDic[arg_4_0][var_4_4] = iter_4_0

		local var_4_7 = {}

		for iter_4_2, iter_4_3 in ipairs(var_4_5) do
			var_0_0.regionIdDicByPuzzleID[arg_4_0][iter_4_3] = var_4_4
			var_0_0.regionIdDicByPuzzleGlobalIndex[arg_4_0][var_4_3] = var_4_4
			var_0_0.puzzleLocalIndexDic[arg_4_0][iter_4_3] = iter_4_2
			var_0_0.puzzleGlobalIndexDic[arg_4_0][iter_4_3] = var_4_3
			var_0_0.puzzleLocalIndexDicByGlobalIndex[arg_4_0][var_4_3] = iter_4_2

			table.insert(var_4_7, var_4_3)

			var_0_0.puzzlePictureIdDic[arg_4_0][iter_4_3] = var_4_6[iter_4_2]
			var_4_3 = var_4_3 + 1
		end

		var_0_0.puzzleGlobalIndexListByRegionID[arg_4_0][var_4_4] = var_4_7
	end

	var_0_0.regionListByType = var_0_0.regionListByType or {}
	var_0_0.regionListByType[arg_4_0] = {}

	local var_4_8 = var_4_0.area_type_list

	for iter_4_4, iter_4_5 in ipairs(var_4_8) do
		local var_4_9 = iter_4_5[1]
		local var_4_10 = iter_4_5[2]
		local var_4_11 = iter_4_5[3]

		var_0_0.regionListByType[arg_4_0][var_4_9] = {}

		for iter_4_6, iter_4_7 in ipairs(var_4_10) do
			var_0_0.regionCfgDic[arg_4_0][iter_4_7] = var_0_0.regionCfgDic[arg_4_0][iter_4_7] or {}
			var_0_0.regionCfgDic[arg_4_0][iter_4_7].type = var_4_9
			var_0_0.regionCfgDic[arg_4_0][iter_4_7].rotateAngle = var_4_11

			table.insert(var_0_0.regionListByType[arg_4_0][var_4_9], iter_4_7)
		end
	end

	local var_4_12 = {}
	local var_4_13 = PuzzleNewClueCfg.get_id_list_by_main_activity_id[arg_4_0] or {}

	for iter_4_8, iter_4_9 in ipairs(var_4_13) do
		local var_4_14 = PuzzleNewClueCfg[iter_4_9].area_type

		var_4_12[var_4_14] = var_4_12[var_4_14] or {}

		table.insert(var_4_12[var_4_14], iter_4_9)
	end

	var_0_0.clueListByRegionType = var_0_0.clueListByRegionType or {}
	var_0_0.clueListByRegionType[arg_4_0] = var_4_12
	var_0_0.cacheAllReceivedRegion = var_0_0.cacheAllReceivedRegion or {}
	var_0_0.cacheAllReceivedRegion[arg_4_0] = {}
	var_0_0.cacheAllRightRegionType = var_0_0.cacheAllRightRegionType or {}
	var_0_0.cacheAllRightRegionType[arg_4_0] = {}
end

function var_0_0.GetRegionIdDicByPuzzleID(arg_5_0)
	local var_5_0

	if var_0_0.regionIdDicByPuzzleID and var_0_0.regionIdDicByPuzzleID[arg_5_0] then
		var_5_0 = var_0_0.regionIdDicByPuzzleID[arg_5_0]
	else
		var_5_0 = {}
	end

	return var_5_0
end

function var_0_0.GetPuzzleLocalIndexDic(arg_6_0)
	local var_6_0

	if var_0_0.puzzleLocalIndexDic and var_0_0.puzzleLocalIndexDic[arg_6_0] then
		var_6_0 = var_0_0.puzzleLocalIndexDic[arg_6_0]
	else
		var_6_0 = {}
	end

	return var_6_0
end

function var_0_0.GetPuzzleGlobalIndexDic(arg_7_0)
	local var_7_0

	if var_0_0.puzzleGlobalIndexDic and var_0_0.puzzleGlobalIndexDic[arg_7_0] then
		var_7_0 = var_0_0.puzzleGlobalIndexDic[arg_7_0]
	else
		var_7_0 = {}
	end

	return var_7_0
end

function var_0_0.GetPuzzleLocalIndexDicByGlobalIndex(arg_8_0)
	local var_8_0

	if var_0_0.puzzleLocalIndexDicByGlobalIndex and var_0_0.puzzleLocalIndexDicByGlobalIndex[arg_8_0] then
		var_8_0 = var_0_0.puzzleLocalIndexDicByGlobalIndex[arg_8_0]
	else
		var_8_0 = {}
	end

	return var_8_0
end

function var_0_0.GetPuzzleGlobalIndexListByRegionID(arg_9_0)
	local var_9_0

	if var_0_0.puzzleGlobalIndexListByRegionID and var_0_0.puzzleGlobalIndexListByRegionID[arg_9_0] then
		var_9_0 = var_0_0.puzzleGlobalIndexListByRegionID[arg_9_0]
	else
		var_9_0 = {}
	end

	return var_9_0
end

function var_0_0.GetCurServerPuzzleGlobalIndex(arg_10_0, arg_10_1)
	local var_10_0 = TangramPuzzleData:GetCurPuzzleDic(arg_10_0)

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		if arg_10_1 == iter_10_1 then
			return iter_10_0
		end
	end

	return -1
end

function var_0_0.GetPuzzlePictureDic(arg_11_0)
	local var_11_0

	if var_0_0.puzzlePictureIdDic and var_0_0.puzzlePictureIdDic[arg_11_0] then
		var_11_0 = var_0_0.puzzlePictureIdDic[arg_11_0]
	else
		var_11_0 = {}
	end

	return var_11_0
end

function var_0_0.FindClosestTarget(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.pressEventCamera
	local var_12_1 = arg_12_1.position
	local var_12_2 = Vector3.New(var_12_1.x, var_12_1.y, 0)
	local var_12_3 = var_12_0:WorldToScreenPoint(arg_12_0[1])
	local var_12_4 = 1
	local var_12_5 = (var_12_3 - var_12_2):Magnitude()

	for iter_12_0 = 2, #arg_12_0 do
		local var_12_6 = (var_12_0:WorldToScreenPoint(arg_12_0[iter_12_0]) - var_12_2):Magnitude()

		if var_12_6 < var_12_5 then
			var_12_5 = var_12_6
			var_12_4 = iter_12_0
		end
	end

	return var_12_4, var_12_5
end

function var_0_0.CheckValidDistanceForExchangePuzzle(arg_13_0, arg_13_1)
	local var_13_0 = TangramPuzzleCfg[arg_13_0].puzzle_distance
	local var_13_1 = Screen.width / 1920
	local var_13_2 = Screen.height / 1080
	local var_13_3 = 1

	if var_13_3 < var_13_1 then
		var_13_3 = var_13_1
	end

	if var_13_3 < var_13_2 then
		var_13_3 = var_13_2
	end

	return arg_13_1 <= var_13_0 * var_13_3
end

function var_0_0.CheckWrongSideByRegionID(arg_14_0, arg_14_1)
	local var_14_0 = TangramPuzzleData:GetCurPuzzleDic(arg_14_0)
	local var_14_1 = var_0_0.GetRegionCorrectPuzzleList(arg_14_0, arg_14_1)
	local var_14_2 = var_0_0.GetPuzzleGlobalIndexListByRegionID(arg_14_0)[arg_14_1]

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		if iter_14_1 ~= var_14_0[var_14_2[iter_14_0]] then
			return true
		end
	end

	return false
end

function var_0_0.CheckRegionAllRight(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(var_0_0.regionListByType[arg_15_0]) do
		if not var_0_0.CheckRegionAllRightByType(arg_15_0, iter_15_0) then
			return false
		end
	end

	return true
end

function var_0_0.CheckRegionAllRightByType(arg_16_0, arg_16_1)
	if var_0_0.cacheAllRightRegionType[arg_16_0][arg_16_1] == true then
		return true
	end

	local var_16_0 = var_0_0.regionListByType[arg_16_0][arg_16_1]

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if var_0_0.CheckWrongSideByRegionID(arg_16_0, iter_16_1) == true then
			return false
		end
	end

	var_0_0.cacheAllRightRegionType[arg_16_0][arg_16_1] = true

	return true
end

function var_0_0.GetRegionCfg(arg_17_0)
	return var_0_0.regionCfgDic[arg_17_0]
end

function var_0_0.GetRegionType(arg_18_0, arg_18_1)
	return var_0_0.regionCfgDic[arg_18_0][arg_18_1].type
end

function var_0_0.GetRegionRotateAngle(arg_19_0, arg_19_1)
	return var_0_0.regionCfgDic[arg_19_0][arg_19_1].rotateAngle
end

function var_0_0.GetRegionCorrectPuzzleList(arg_20_0, arg_20_1)
	local var_20_0 = TangramPuzzleCfg[arg_20_0]
	local var_20_1 = var_0_0.regionIndexDic[arg_20_0][arg_20_1]

	return var_20_0.correct_array[var_20_1][2]
end

function var_0_0.GetRegionRewardList(arg_21_0, arg_21_1)
	local var_21_0 = TangramPuzzleCfg[arg_21_0]
	local var_21_1 = var_0_0.regionIndexDic[arg_21_0][arg_21_1]

	return var_21_0.reward_area_list[var_21_1][2]
end

function var_0_0.GetRegionListByType(arg_22_0)
	return var_0_0.regionListByType[arg_22_0]
end

function var_0_0.GetRegionIdByPuzzleGlobalIndex(arg_23_0)
	local var_23_0

	if var_0_0.regionIdDicByPuzzleGlobalIndex and var_0_0.regionIdDicByPuzzleGlobalIndex[arg_23_0] then
		var_23_0 = var_0_0.regionIdDicByPuzzleGlobalIndex[arg_23_0]
	else
		var_23_0 = {}
	end

	return var_23_0
end

function var_0_0.CheckRegionReward(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = {}
	local var_24_2 = TangramPuzzleData:GetRegionReceivedDic(arg_24_0)

	for iter_24_0, iter_24_1 in pairs(var_0_0.regionCfgDic[arg_24_0]) do
		if not var_0_0.CheckWrongSideByRegionID(arg_24_0, iter_24_0) and not var_24_2[iter_24_0] then
			local var_24_3 = var_0_0.GetRegionRewardList(arg_24_0, iter_24_0)

			table.insertto(var_24_1, var_24_3)

			var_24_0[#var_24_0 + 1] = iter_24_0
		end
	end

	return var_24_0, var_24_1
end

function var_0_0.IsAllRegionReceived(arg_25_0, arg_25_1)
	if var_0_0.cacheAllReceivedRegion[arg_25_0][arg_25_1] then
		return true
	end

	local var_25_0 = var_0_0.regionListByType[arg_25_0][arg_25_1]
	local var_25_1 = TangramPuzzleData:GetRegionReceivedDic(arg_25_0)

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if not var_25_1[iter_25_1] then
			return false
		end
	end

	var_0_0.cacheAllReceivedRegion[arg_25_0][arg_25_1] = true

	return true
end

function var_0_0.IsAllRegionTypeReceived(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(var_0_0.regionListByType[arg_26_0]) do
		if not var_0_0.IsAllRegionReceived(arg_26_0, iter_26_0) then
			return false
		end
	end

	return true
end

function var_0_0.GetClueListByRegionType(arg_27_0)
	local var_27_0

	if var_0_0.clueListByRegionType[arg_27_0] and var_0_0.clueListByRegionType[arg_27_0] then
		var_27_0 = var_0_0.clueListByRegionType[arg_27_0]
	else
		var_27_0 = {}
	end

	return var_27_0
end

function var_0_0.IsAllClueCompleted(arg_28_0)
	local var_28_0 = TangramPuzzleData:GetCurClueDic(arg_28_0)
	local var_28_1 = PuzzleNewClueCfg.get_id_list_by_main_activity_id[arg_28_0]

	for iter_28_0, iter_28_1 in ipairs(var_28_1) do
		if not var_28_0[iter_28_1] then
			return false
		end
	end

	return true
end

return var_0_0
