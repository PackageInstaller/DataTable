local var_0_0 = singletonClass("PuzzleNewData")

function var_0_0.Init(arg_1_0)
	arg_1_0.clearDic_ = {}
	arg_1_0.regionReceivedList_ = {}
	arg_1_0.puzzleDic_ = {}
	arg_1_0.checkList_ = {}
	arg_1_0.checkTipsList_ = {}
	arg_1_0.selectPlayBtn_ = {}
end

function var_0_0:InitData(arg_2_1)
	self.regionReceivedList_[arg_2_1.activity_id] = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.area_award_id) do
		self.regionReceivedList_[arg_2_1.activity_id][iter_2_1] = true
	end

	self.puzzleDic_[arg_2_1.activity_id] = self:ParsePuzzle(arg_2_1.puzzle)
	self.checkList_[arg_2_1.activity_id] = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.clue_list) do
		self.checkList_[arg_2_1.activity_id][iter_2_3] = true
	end

	self.checkTipsList_[arg_2_1.activity_id] = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.clue_tip_list) do
		self.checkTipsList_[arg_2_1.activity_id][iter_2_5] = true
	end
end

function var_0_0.ParsePuzzle(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0 = 1, #arg_3_1.vacant_position + #arg_3_1.puzzle_data do
		local var_3_1

		if arg_3_1.vacant_position[1] == iter_3_0 then
			var_3_1 = 1 + 1
		else
			var_3_0[iter_3_0] = arg_3_1.puzzle_data[1]
		end
	end

	return var_3_0
end

function var_0_0:SetPuzzle(arg_4_1, arg_4_2, arg_4_3)
	self.puzzleDic_[arg_4_1][arg_4_3] = arg_4_2 ~= 0 and arg_4_2 or nil
end

function var_0_0:GetRegionReceivedList(arg_5_1)
	return self.regionReceivedList_[arg_5_1] or {}
end

function var_0_0:SetRegionReceivedList(arg_6_1, arg_6_2)
	self.regionReceivedList_[arg_6_1] = self.regionReceivedList_[arg_6_1] or {}

	for iter_6_0, iter_6_1 in pairs(arg_6_2) do
		self.regionReceivedList_[arg_6_1][iter_6_1] = true
	end
end

function var_0_0:GetCurPuzzleList(arg_7_1)
	return self.puzzleDic_[arg_7_1] or {}
end

function var_0_0:GetCurCheckList(arg_8_1)
	return self.checkList_[arg_8_1] or {}
end

function var_0_0:SetCurCheckList(arg_9_1, arg_9_2)
	self.checkList_[arg_9_1][arg_9_2] = true
end

function var_0_0:GetCheckTipsList(arg_10_1)
	return self.checkTipsList_[arg_10_1] or {}
end

function var_0_0:SetCheckTipsList(arg_11_1, arg_11_2)
	self.checkTipsList_[arg_11_1][arg_11_2] = true
end

function var_0_0:IsCompleted(arg_12_1)
	if not self.clearDic_[arg_12_1] then
		for iter_12_0, iter_12_1 in ipairs(PuzzleNewCfg[arg_12_1].area_fragment_list) do
			local var_12_0 = self:GetRegionReceivedList(arg_12_1)

			if not var_12_0 or not var_12_0[iter_12_1[1]] then
				return false
			end
		end

		self.clearDic_[arg_12_1] = true
	end

	return self.clearDic_[arg_12_1]
end

function var_0_0:RefreshPlayRedPoint(arg_13_1)
	local var_13_0 = 0

	if self.selectPlayBtn_[arg_13_1] ~= true then
		local var_13_1 = self:GetRegionReceivedList(arg_13_1)
		local var_13_2 = PuzzleNewTools.GetPuzzlePosDic(arg_13_1)
		local var_13_3 = self:GetCurPuzzleList(arg_13_1)
		local var_13_4 = {}

		for iter_13_0, iter_13_1 in pairs(var_13_3) do
			var_13_4[iter_13_1] = true
		end

		for iter_13_2, iter_13_3 in ipairs(PuzzleNewCfg[arg_13_1].area_fragment_list) do
			if not var_13_1 or not var_13_1[iter_13_3[1]] then
				local var_13_5 = false

				for iter_13_4, iter_13_5 in ipairs(iter_13_3[2]) do
					if not var_13_4[iter_13_5] then
						var_13_5 = false

						break
					end

					if var_13_3[var_13_2[iter_13_5]] and var_13_3[var_13_2[iter_13_5]] ~= iter_13_5 then
						var_13_5 = true

						break
					end
				end

				if var_13_5 == true then
					var_13_0 = 1

					break
				end
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.PUZZLE_NEW_PLAY, arg_13_1), var_13_0)
end

function var_0_0:SetPlayBtnSelected(arg_14_1)
	if manager.redPoint:getTipBoolean((string.format("%s_%d", RedPointConst.PUZZLE_NEW_PLAY, arg_14_1))) and not self.selectPlayBtn_[arg_14_1] then
		self.selectPlayBtn_[arg_14_1] = true

		self:RefreshPlayRedPoint(arg_14_1)
	end
end

function var_0_0.RefreshPieceRedPoint(arg_15_0, arg_15_1)
	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.PUZZLE_NEW_PIECE, arg_15_1), (ItemTools.getItemNum(PuzzleNewCfg[arg_15_1].fragment_id[1][1]) >= PuzzleNewCfg[arg_15_1].fragment_id[1][2] and PuzzleNewTools.CheckWrongSide(true, arg_15_1) or nil) and 1)
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
