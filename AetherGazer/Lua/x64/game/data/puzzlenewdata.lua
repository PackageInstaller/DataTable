local var_0_0 = singletonClass("PuzzleNewData")

function var_0_0.Init(arg_1_0)
	arg_1_0.clearDic_ = {}
	arg_1_0.regionReceivedList_ = {}
	arg_1_0.puzzleDic_ = {}
	arg_1_0.checkList_ = {}
	arg_1_0.checkTipsList_ = {}
	arg_1_0.selectPlayBtn_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	arg_2_0.regionReceivedList_[var_2_0] = {}

	local var_2_1 = arg_2_1.area_award_id

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		arg_2_0.regionReceivedList_[var_2_0][iter_2_1] = true
	end

	local var_2_2 = arg_2_1.puzzle

	arg_2_0.puzzleDic_[var_2_0] = arg_2_0:ParsePuzzle(var_2_2)
	arg_2_0.checkList_[var_2_0] = {}

	local var_2_3 = arg_2_1.clue_list

	for iter_2_2, iter_2_3 in ipairs(var_2_3) do
		arg_2_0.checkList_[var_2_0][iter_2_3] = true
	end

	arg_2_0.checkTipsList_[var_2_0] = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.clue_tip_list) do
		arg_2_0.checkTipsList_[var_2_0][iter_2_5] = true
	end
end

function var_0_0.ParsePuzzle(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.vacant_position
	local var_3_1 = arg_3_1.puzzle_data
	local var_3_2 = #var_3_0 + #var_3_1
	local var_3_3 = {}
	local var_3_4 = 1
	local var_3_5 = 1

	for iter_3_0 = 1, var_3_2 do
		if var_3_0[var_3_4] == iter_3_0 then
			var_3_4 = var_3_4 + 1
		else
			var_3_3[iter_3_0] = var_3_1[var_3_5]
			var_3_5 = var_3_5 + 1
		end
	end

	return var_3_3
end

function var_0_0.SetPuzzle(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_2 ~= 0 then
		arg_4_0.puzzleDic_[arg_4_1][arg_4_3] = arg_4_2
	else
		arg_4_0.puzzleDic_[arg_4_1][arg_4_3] = nil
	end
end

function var_0_0.GetRegionReceivedList(arg_5_0, arg_5_1)
	return arg_5_0.regionReceivedList_[arg_5_1] or {}
end

function var_0_0.SetRegionReceivedList(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.regionReceivedList_[arg_6_1] = arg_6_0.regionReceivedList_[arg_6_1] or {}

	for iter_6_0, iter_6_1 in pairs(arg_6_2) do
		arg_6_0.regionReceivedList_[arg_6_1][iter_6_1] = true
	end
end

function var_0_0.GetCurPuzzleList(arg_7_0, arg_7_1)
	return arg_7_0.puzzleDic_[arg_7_1] or {}
end

function var_0_0.GetCurCheckList(arg_8_0, arg_8_1)
	return arg_8_0.checkList_[arg_8_1] or {}
end

function var_0_0.SetCurCheckList(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.checkList_[arg_9_1][arg_9_2] = true
end

function var_0_0.GetCheckTipsList(arg_10_0, arg_10_1)
	return arg_10_0.checkTipsList_[arg_10_1] or {}
end

function var_0_0.SetCheckTipsList(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.checkTipsList_[arg_11_1][arg_11_2] = true
end

function var_0_0.IsCompleted(arg_12_0, arg_12_1)
	if not arg_12_0.clearDic_[arg_12_1] then
		local var_12_0 = PuzzleNewCfg[arg_12_1].area_fragment_list

		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			local var_12_1 = iter_12_1[1]
			local var_12_2 = arg_12_0:GetRegionReceivedList(arg_12_1)

			if not var_12_2 or not var_12_2[var_12_1] then
				return false
			end
		end

		arg_12_0.clearDic_[arg_12_1] = true
	end

	return arg_12_0.clearDic_[arg_12_1]
end

function var_0_0.RefreshPlayRedPoint(arg_13_0, arg_13_1)
	local var_13_0 = 0

	if not (arg_13_0.selectPlayBtn_[arg_13_1] == true) then
		local var_13_1 = PuzzleNewCfg[arg_13_1].area_fragment_list
		local var_13_2 = arg_13_0:GetRegionReceivedList(arg_13_1)
		local var_13_3 = PuzzleNewTools.GetPuzzlePosDic(arg_13_1)
		local var_13_4 = arg_13_0:GetCurPuzzleList(arg_13_1)
		local var_13_5 = {}

		for iter_13_0, iter_13_1 in pairs(var_13_4) do
			var_13_5[iter_13_1] = true
		end

		for iter_13_2, iter_13_3 in ipairs(var_13_1) do
			local var_13_6 = iter_13_3[1]

			if not var_13_2 or not var_13_2[var_13_6] then
				local var_13_7 = false

				for iter_13_4, iter_13_5 in ipairs(iter_13_3[2]) do
					if not var_13_5[iter_13_5] then
						var_13_7 = false

						break
					end

					local var_13_8 = var_13_3[iter_13_5]

					if var_13_4[var_13_8] and var_13_4[var_13_8] ~= iter_13_5 then
						var_13_7 = true

						break
					end
				end

				if var_13_7 == true then
					var_13_0 = 1

					break
				end
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.PUZZLE_NEW_PLAY, arg_13_1), var_13_0)
end

function var_0_0.SetPlayBtnSelected(arg_14_0, arg_14_1)
	local var_14_0 = string.format("%s_%d", RedPointConst.PUZZLE_NEW_PLAY, arg_14_1)

	if manager.redPoint:getTipBoolean(var_14_0) and not arg_14_0.selectPlayBtn_[arg_14_1] then
		arg_14_0.selectPlayBtn_[arg_14_1] = true

		arg_14_0:RefreshPlayRedPoint(arg_14_1)
	end
end

function var_0_0.RefreshPieceRedPoint(arg_15_0, arg_15_1)
	local var_15_0 = PuzzleNewCfg[arg_15_1].fragment_id[1]
	local var_15_1 = var_15_0[1]
	local var_15_2 = ItemTools.getItemNum(var_15_1)
	local var_15_3 = 0

	if var_15_2 >= var_15_0[2] and PuzzleNewTools.CheckWrongSide(true, arg_15_1) then
		var_15_3 = 1
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.PUZZLE_NEW_PIECE, arg_15_1), var_15_3)
end

function var_0_0.SetPutBtnSelected(arg_16_0, arg_16_1)
	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.PUZZLE_NEW_PIECE, arg_16_1), 0)
end

function var_0_0.SetSelecteCheckPoint(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	saveData("puzzle_new", string.format("select_check_point_%d_%d", arg_17_1, arg_17_2), arg_17_3)
end

function var_0_0.GetSelecteCheckPoint(arg_18_0, arg_18_1, arg_18_2)
	return getData("puzzle_new", string.format("select_check_point_%d_%d", arg_18_1, arg_18_2))
end

return var_0_0
