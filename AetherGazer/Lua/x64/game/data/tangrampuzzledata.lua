local var_0_0 = singletonClass("TangramPuzzleData")

function var_0_0.Init(arg_1_0)
	arg_1_0.clearDic_ = {}
	arg_1_0.regionReceivedDic_ = {}
	arg_1_0.unlockRegionDic_ = {}
	arg_1_0.puzzleDic_ = {}
	arg_1_0.clueDic_ = {}
	arg_1_0.selectPlayBtn_ = {}
	arg_1_0.selectPutBtn_ = {}
	arg_1_0.inited = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	arg_2_0.inited[var_2_0] = true
	arg_2_0.regionReceivedDic_[var_2_0] = {}
	arg_2_0.unlockRegionDic_[var_2_0] = {}

	local var_2_1 = arg_2_1.area_award_id

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		arg_2_0.regionReceivedDic_[var_2_0][iter_2_1] = true
	end

	local var_2_2 = arg_2_1.puzzle

	arg_2_0.puzzleDic_[var_2_0] = arg_2_0:ParsePuzzle(var_2_2)

	local var_2_3 = 1

	for iter_2_2, iter_2_3 in ipairs(TangramPuzzleCfg[var_2_0].correct_array) do
		local var_2_4 = iter_2_3[1]
		local var_2_5 = iter_2_3[2]

		if arg_2_0.puzzleDic_[var_2_0][var_2_3] ~= nil then
			arg_2_0.unlockRegionDic_[var_2_0][var_2_4] = true
		end

		var_2_3 = var_2_3 + #var_2_5
	end

	arg_2_0.clueDic_[var_2_0] = {}

	local var_2_6 = arg_2_1.clue_list

	for iter_2_4, iter_2_5 in ipairs(var_2_6) do
		arg_2_0.clueDic_[var_2_0][iter_2_5] = true
	end
end

function var_0_0.IsInited(arg_3_0, arg_3_1)
	return arg_3_0.inited[arg_3_1] == true
end

function var_0_0.ParsePuzzle(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.vacant_position
	local var_4_1 = arg_4_1.puzzle_data
	local var_4_2 = #var_4_0 + #var_4_1
	local var_4_3 = {}
	local var_4_4 = 1
	local var_4_5 = 1

	for iter_4_0 = 1, var_4_2 do
		if var_4_0[var_4_4] == iter_4_0 then
			var_4_4 = var_4_4 + 1
		else
			var_4_3[iter_4_0] = var_4_1[var_4_5]
			var_4_5 = var_4_5 + 1
		end
	end

	return var_4_3
end

function var_0_0.SetPuzzle(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 ~= 0 then
		arg_5_0.puzzleDic_[arg_5_1][arg_5_3] = arg_5_2
	else
		arg_5_0.puzzleDic_[arg_5_1][arg_5_3] = nil
	end
end

function var_0_0.SetPuzzleDic(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.puzzleDic_[arg_6_1] = arg_6_2
end

function var_0_0.ExchangePuzzle(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0.puzzleDic_[arg_7_1][arg_7_2]
	local var_7_1 = arg_7_0.puzzleDic_[arg_7_1][arg_7_3]

	arg_7_0:SetPuzzle(arg_7_1, var_7_0, arg_7_3)
	arg_7_0:SetPuzzle(arg_7_1, var_7_1, arg_7_2)
end

function var_0_0.RetateRegion(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if rotatetimes == 0 then
		return
	end

	local var_8_0 = TangramPuzzleTools.GetPuzzleGlobalIndexListByRegionID(arg_8_1)[arg_8_2]
	local var_8_1 = #var_8_0

	if math.abs(arg_8_3) == var_8_1 then
		return
	end

	local var_8_2 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		var_8_2[iter_8_0] = arg_8_0.puzzleDic_[arg_8_1][iter_8_1]
	end

	local var_8_3 = arg_8_3 > 0
	local var_8_4
	local var_8_5
	local var_8_6
	local var_8_7
	local var_8_8

	if var_8_3 == true then
		var_8_4 = 1
		var_8_5 = var_8_1
		var_8_8 = 1
	else
		var_8_4 = var_8_1
		var_8_5 = 1
		var_8_8 = -1
	end

	local var_8_9 = var_8_4 + arg_8_3

	for iter_8_2 = var_8_4, var_8_5, var_8_8 do
		arg_8_0:SetPuzzle(arg_8_1, var_8_2[iter_8_2], var_8_0[var_8_9])

		var_8_9 = var_8_9 + var_8_8

		if var_8_9 <= 0 then
			var_8_9 = var_8_1
		elseif var_8_1 < var_8_9 then
			var_8_9 = 1
		end
	end
end

function var_0_0.GetCurPuzzleDic(arg_9_0, arg_9_1)
	return arg_9_0.puzzleDic_[arg_9_1] or {}
end

function var_0_0.GetRegionReceivedDic(arg_10_0, arg_10_1)
	return arg_10_0.regionReceivedDic_[arg_10_1] or {}
end

function var_0_0.SetRegionReceivedDic(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.regionReceivedDic_[arg_11_1] = arg_11_0.regionReceivedDic_[arg_11_1] or {}

	for iter_11_0, iter_11_1 in pairs(arg_11_2) do
		arg_11_0.regionReceivedDic_[arg_11_1][iter_11_1] = true
	end
end

function var_0_0.IsReceivedFinalReward(arg_12_0, arg_12_1)
	return arg_12_0:GetRegionReceivedDic(arg_12_1)[0] == true
end

function var_0_0.GetUnlockRegionDic(arg_13_0, arg_13_1)
	return arg_13_0.unlockRegionDic_[arg_13_1]
end

function var_0_0.GetCurClueDic(arg_14_0, arg_14_1)
	return arg_14_0.clueDic_[arg_14_1] or {}
end

function var_0_0.SetCurClueDic(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.clueDic_[arg_15_1][arg_15_2] = true
end

function var_0_0.SetSelecteClue(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	saveData("tangram_puzzle", string.format("select_clue_%d_%d", arg_16_1, arg_16_2), arg_16_3)
end

function var_0_0.GetSelecteClue(arg_17_0, arg_17_1, arg_17_2)
	return getData("tangram_puzzle", string.format("select_clue_%d_%d", arg_17_1, arg_17_2))
end

function var_0_0.SetFirstEnter(arg_18_0, arg_18_1, arg_18_2)
	saveData("tangram_puzzle", string.format("first_enter_%d", arg_18_1), arg_18_2)
end

function var_0_0.GetFirstEnter(arg_19_0, arg_19_1)
	return getData("tangram_puzzle", string.format("first_enter_%d", arg_19_1))
end

function var_0_0.SetFirstEnterRegionType(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	saveData("tangram_puzzle", string.format("first_enter_region_%d_%d", arg_20_1, arg_20_2), arg_20_3)
end

function var_0_0.GetFirstEnterRegionType(arg_21_0, arg_21_1, arg_21_2)
	return getData("tangram_puzzle", string.format("first_enter_region_%d_%d", arg_21_1, arg_21_2))
end

function var_0_0.SetFirstTips(arg_22_0, arg_22_1, arg_22_2)
	saveData("tangram_puzzle", string.format("first_tips_%d", arg_22_1), arg_22_2)
end

function var_0_0.GetFirstTips(arg_23_0, arg_23_1)
	return getData("tangram_puzzle", string.format("first_tips_%d", arg_23_1))
end

return var_0_0
