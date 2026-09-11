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
	var_0_0.puzzleLocalIndexDicByGlobalIndex = var_0_0.puzzleLocalIndexDicByGlobalIndex or {}
	var_0_0.puzzleLocalIndexDicByGlobalIndex[arg_4_0] = {}
	var_0_0.puzzleLocalIndexDic = var_0_0.puzzleLocalIndexDic or {}
	var_0_0.puzzleLocalIndexDic[arg_4_0] = {}
	var_0_0.puzzleGlobalIndexListByRegionID = var_0_0.puzzleGlobalIndexListByRegionID or {}
	var_0_0.puzzleGlobalIndexListByRegionID[arg_4_0] = {}
	var_0_0.puzzlePictureIdDic = var_0_0.puzzlePictureIdDic or {}
	var_0_0.puzzlePictureIdDic[arg_4_0] = {}

	for iter_4_0, iter_4_1 in ipairs(TangramPuzzleCfg[arg_4_0].correct_array) do
		var_0_0.regionIndexDic[arg_4_0][iter_4_1[1]] = iter_4_0

		local var_4_0 = {}

		for iter_4_2, iter_4_3 in ipairs(iter_4_1[2]) do
			var_0_0.regionIdDicByPuzzleID[arg_4_0][iter_4_3] = iter_4_1[1]
			var_0_0.regionIdDicByPuzzleGlobalIndex[arg_4_0][1] = iter_4_1[1]
			var_0_0.puzzleLocalIndexDic[arg_4_0][iter_4_3] = iter_4_2
			var_0_0.puzzleGlobalIndexDic[arg_4_0][iter_4_3] = 1
			var_0_0.puzzleLocalIndexDicByGlobalIndex[arg_4_0][1] = iter_4_2

			table.insert(var_4_0, 1)

			var_0_0.puzzlePictureIdDic[arg_4_0][iter_4_3] = TangramPuzzleCfg[arg_4_0].picture_fragment_id[iter_4_0][2][iter_4_2]
		end

		var_0_0.puzzleGlobalIndexListByRegionID[arg_4_0][iter_4_1[1]] = var_4_0
	end

	var_0_0.regionListByType = var_0_0.regionListByType or {}
	var_0_0.regionListByType[arg_4_0] = {}

	for iter_4_4, iter_4_5 in ipairs(TangramPuzzleCfg[arg_4_0].area_type_list) do
		var_0_0.regionListByType[arg_4_0][iter_4_5[1]] = {}

		for iter_4_6, iter_4_7 in ipairs(iter_4_5[2]) do
			var_0_0.regionCfgDic[arg_4_0][iter_4_7] = var_0_0.regionCfgDic[arg_4_0][iter_4_7] or {}
			var_0_0.regionCfgDic[arg_4_0][iter_4_7].type = iter_4_5[1]
			var_0_0.regionCfgDic[arg_4_0][iter_4_7].rotateAngle = iter_4_5[3]

			table.insert(var_0_0.regionListByType[arg_4_0][iter_4_5[1]], iter_4_7)
		end
	end

	local var_4_2 = {}

	for iter_4_8, iter_4_9 in ipairs(PuzzleNewClueCfg.get_id_list_by_main_activity_id[arg_4_0] or {}) do
		var_4_2[PuzzleNewClueCfg[iter_4_9].area_type] = var_4_2[PuzzleNewClueCfg[iter_4_9].area_type] or {}

		table.insert(var_4_2[PuzzleNewClueCfg[iter_4_9].area_type], iter_4_9)
	end

	var_0_0.clueListByRegionType = var_0_0.clueListByRegionType or {}
	var_0_0.clueListByRegionType[arg_4_0] = var_4_2
	var_0_0.cacheAllReceivedRegion = var_0_0.cacheAllReceivedRegion or {}
	var_0_0.cacheAllReceivedRegion[arg_4_0] = {}
	var_0_0.cacheAllRightRegionType = var_0_0.cacheAllRightRegionType or {}
	var_0_0.cacheAllRightRegionType[arg_4_0] = {}
end

function var_0_0.GetRegionIdDicByPuzzleID(arg_5_0)
	return var_0_0.regionIdDicByPuzzleID and var_0_0.regionIdDicByPuzzleID[arg_5_0] and var_0_0.regionIdDicByPuzzleID[arg_5_0] or {}
end

function var_0_0.GetPuzzleLocalIndexDic(arg_6_0)
	return var_0_0.puzzleLocalIndexDic and var_0_0.puzzleLocalIndexDic[arg_6_0] and var_0_0.puzzleLocalIndexDic[arg_6_0] or {}
end

function var_0_0.GetPuzzleGlobalIndexDic(arg_7_0)
	return var_0_0.puzzleGlobalIndexDic and var_0_0.puzzleGlobalIndexDic[arg_7_0] and var_0_0.puzzleGlobalIndexDic[arg_7_0] or {}
end

function var_0_0.GetPuzzleLocalIndexDicByGlobalIndex(arg_8_0)
	return var_0_0.puzzleLocalIndexDicByGlobalIndex and var_0_0.puzzleLocalIndexDicByGlobalIndex[arg_8_0] and var_0_0.puzzleLocalIndexDicByGlobalIndex[arg_8_0] or {}
end

function var_0_0.GetPuzzleGlobalIndexListByRegionID(arg_9_0)
	return var_0_0.puzzleGlobalIndexListByRegionID and var_0_0.puzzleGlobalIndexListByRegionID[arg_9_0] and var_0_0.puzzleGlobalIndexListByRegionID[arg_9_0] or {}
end

function var_0_0.GetCurServerPuzzleGlobalIndex(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs((TangramPuzzleData:GetCurPuzzleDic(arg_10_0))) do
		if arg_10_1 == iter_10_1 then
			return iter_10_0
		end
	end

	return -1
end

function var_0_0.GetPuzzlePictureDic(arg_11_0)
	return var_0_0.puzzlePictureIdDic and var_0_0.puzzlePictureIdDic[arg_11_0] and var_0_0.puzzlePictureIdDic[arg_11_0] or {}
end

function var_0_0:FindClosestTarget(arg_12_1)
	local var_12_0 = Vector3.New(arg_12_1.position.x, arg_12_1.position.y, 0)
	local var_12_1 = 1
	local var_12_2 = (arg_12_1.pressEventCamera:WorldToScreenPoint(self[1]) - var_12_0):Magnitude()

	for iter_12_0 = 2, #self do
		local var_12_3 = (arg_12_1.pressEventCamera:WorldToScreenPoint(self[iter_12_0]) - var_12_0):Magnitude()

		if var_12_3 < var_12_2 then
			var_12_2 = var_12_3
			var_12_1 = iter_12_0
		end
	end

	return var_12_1, var_12_2
end

function var_0_0.CheckValidDistanceForExchangePuzzle(arg_13_0, arg_13_1)
	local var_13_0 = 1

	if 1 < Screen.width / 1920 then
		var_13_0 = Screen.width / 1920
	end

	if var_13_0 < Screen.height / 1080 then
		var_13_0 = Screen.height / 1080
	end

	return arg_13_1 <= TangramPuzzleCfg[arg_13_0].puzzle_distance * var_13_0
end

function var_0_0.CheckWrongSideByRegionID(arg_14_0, arg_14_1)
	local var_14_0 = TangramPuzzleData:GetCurPuzzleDic(arg_14_0)
	local var_14_1 = var_0_0.GetPuzzleGlobalIndexListByRegionID(arg_14_0)[arg_14_1]

	for iter_14_0, iter_14_1 in ipairs((var_0_0.GetRegionCorrectPuzzleList(arg_14_0, arg_14_1))) do
		if iter_14_1 ~= var_14_0[var_14_1[iter_14_0]] then
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

	for iter_16_0, iter_16_1 in ipairs(var_0_0.regionListByType[arg_16_0][arg_16_1]) do
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
	return TangramPuzzleCfg[arg_20_0].correct_array[var_0_0.regionIndexDic[arg_20_0][arg_20_1]][2]
end

function var_0_0.GetRegionRewardList(arg_21_0, arg_21_1)
	return TangramPuzzleCfg[arg_21_0].reward_area_list[var_0_0.regionIndexDic[arg_21_0][arg_21_1]][2]
end

function var_0_0.GetRegionListByType(arg_22_0)
	return var_0_0.regionListByType[arg_22_0]
end

function var_0_0.GetRegionIdByPuzzleGlobalIndex(arg_23_0)
	return var_0_0.regionIdDicByPuzzleGlobalIndex and var_0_0.regionIdDicByPuzzleGlobalIndex[arg_23_0] and var_0_0.regionIdDicByPuzzleGlobalIndex[arg_23_0] or {}
end

function var_0_0.CheckRegionReward(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = {}
	local var_24_2 = TangramPuzzleData:GetRegionReceivedDic(arg_24_0)

	for iter_24_0, iter_24_1 in pairs(var_0_0.regionCfgDic[arg_24_0]) do
		if not var_0_0.CheckWrongSideByRegionID(arg_24_0, iter_24_0) and not var_24_2[iter_24_0] then
			table.insertto(var_24_1, (var_0_0.GetRegionRewardList(arg_24_0, iter_24_0)))

			var_24_0[#var_24_0 + 1] = iter_24_0
		end
	end

	return var_24_0, var_24_1
end

function var_0_0.IsAllRegionReceived(arg_25_0, arg_25_1)
	local var_25_0

	if var_0_0.cacheAllReceivedRegion[arg_25_0][arg_25_1] then
		do return true end

		var_25_0 = TangramPuzzleData:GetRegionReceivedDic(arg_25_0)
	end

	for iter_25_0, iter_25_1 in ipairs(var_0_0.regionListByType[arg_25_0][arg_25_1]) do
		if not var_25_0[iter_25_1] then
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
	return var_0_0.clueListByRegionType[arg_27_0] and var_0_0.clueListByRegionType[arg_27_0] and var_0_0.clueListByRegionType[arg_27_0] or {}
end

function var_0_0.IsAllClueCompleted(arg_28_0)
	local var_28_0 = TangramPuzzleData:GetCurClueDic(arg_28_0)

	for iter_28_0, iter_28_1 in ipairs(PuzzleNewClueCfg.get_id_list_by_main_activity_id[arg_28_0]) do
		if not var_28_0[iter_28_1] then
			return false
		end
	end

	return true
end

return var_0_0
