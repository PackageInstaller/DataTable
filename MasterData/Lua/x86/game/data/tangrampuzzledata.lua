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

function var_0_0:InitData(arg_2_1)
	self.inited[arg_2_1.activity_id] = true
	self.regionReceivedDic_[arg_2_1.activity_id] = {}
	self.unlockRegionDic_[arg_2_1.activity_id] = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.area_award_id) do
		self.regionReceivedDic_[arg_2_1.activity_id][iter_2_1] = true
	end

	self.puzzleDic_[arg_2_1.activity_id] = self:ParsePuzzle(arg_2_1.puzzle)

	for iter_2_2, iter_2_3 in ipairs(TangramPuzzleCfg[arg_2_1.activity_id].correct_array) do
		if self.puzzleDic_[arg_2_1.activity_id][1] ~= nil then
			self.unlockRegionDic_[arg_2_1.activity_id][iter_2_3[1]] = true
		end
	end

	self.clueDic_[arg_2_1.activity_id] = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.clue_list) do
		self.clueDic_[arg_2_1.activity_id][iter_2_5] = true
	end
end

function var_0_0:IsInited(arg_3_1)
	return self.inited[arg_3_1] == true
end

function var_0_0.ParsePuzzle(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0 = 1, #arg_4_1.vacant_position + #arg_4_1.puzzle_data do
		local var_4_1

		if arg_4_1.vacant_position[1] == iter_4_0 then
			var_4_1 = 1 + 1
		else
			var_4_0[iter_4_0] = arg_4_1.puzzle_data[1]
		end
	end

	return var_4_0
end

function var_0_0:SetPuzzle(arg_5_1, arg_5_2, arg_5_3)
	self.puzzleDic_[arg_5_1][arg_5_3] = arg_5_2 ~= 0 and arg_5_2 or nil
end

function var_0_0:SetPuzzleDic(arg_6_1, arg_6_2)
	self.puzzleDic_[arg_6_1] = arg_6_2
end

function var_0_0:ExchangePuzzle(arg_7_1, arg_7_2, arg_7_3)
	self:SetPuzzle(arg_7_1, self.puzzleDic_[arg_7_1][arg_7_2], arg_7_3)
	self:SetPuzzle(arg_7_1, self.puzzleDic_[arg_7_1][arg_7_3], arg_7_2)
end

function var_0_0:RetateRegion(arg_8_1, arg_8_2, arg_8_3)
	if rotatetimes == 0 then
		return
	end

	local var_8_0 = TangramPuzzleTools.GetPuzzleGlobalIndexListByRegionID(arg_8_1)[arg_8_2]
	local var_8_1 = #var_8_0

	if math.abs(arg_8_3) == #var_8_0 then
		return
	end

	local var_8_2 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		var_8_2[iter_8_0] = self.puzzleDic_[arg_8_1][iter_8_1]
	end

	local var_8_3
	local var_8_4
	local var_8_7

	if arg_8_3 > 0 == true then
		var_8_3 = 1
		var_8_4 = var_8_1
		var_8_7 = 1
	else
		var_8_3 = var_8_1
		var_8_4 = 1
		var_8_7 = -1
	end

	local var_8_8 = var_8_3 + arg_8_3

	for iter_8_2 = var_8_3, var_8_4, var_8_7 do
		self:SetPuzzle(arg_8_1, var_8_2[iter_8_2], var_8_0[var_8_8])

		var_8_8 = var_8_8 + var_8_7

		if var_8_8 <= 0 then
			var_8_8 = var_8_1
		elseif var_8_1 < var_8_8 then
			var_8_8 = 1
		end
	end
end

function var_0_0:GetCurPuzzleDic(arg_9_1)
	return self.puzzleDic_[arg_9_1] or {}
end

function var_0_0:GetRegionReceivedDic(arg_10_1)
	return self.regionReceivedDic_[arg_10_1] or {}
end

function var_0_0:SetRegionReceivedDic(arg_11_1, arg_11_2)
	self.regionReceivedDic_[arg_11_1] = self.regionReceivedDic_[arg_11_1] or {}

	for iter_11_0, iter_11_1 in pairs(arg_11_2) do
		self.regionReceivedDic_[arg_11_1][iter_11_1] = true
	end
end

function var_0_0:IsReceivedFinalReward(arg_12_1)
	return self:GetRegionReceivedDic(arg_12_1)[0] == true
end

function var_0_0:GetUnlockRegionDic(arg_13_1)
	return self.unlockRegionDic_[arg_13_1]
end

function var_0_0:GetCurClueDic(arg_14_1)
	return self.clueDic_[arg_14_1] or {}
end

function var_0_0:SetCurClueDic(arg_15_1, arg_15_2)
	self.clueDic_[arg_15_1][arg_15_2] = true
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
