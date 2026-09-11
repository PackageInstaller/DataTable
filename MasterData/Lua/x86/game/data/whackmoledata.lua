local var_0_0 = singletonClass("WhackMoleData")

function var_0_0.Init(arg_1_0)
	arg_1_0.stageDataList_ = {}
	arg_1_0.selectedList_ = {}
end

function var_0_0:InitData(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.stage_info_list) do
		self.stageDataList_[iter_2_1.id] = {}
		self.stageDataList_[iter_2_1.id].is_success = iter_2_1.is_success
		self.stageDataList_[iter_2_1.id].score = iter_2_1.history_max_score
	end
end

function var_0_0:UpdateStageData(arg_3_1)
	self.battleResultData_ = arg_3_1
	self.stageDataList_[arg_3_1.id] = self.stageDataList_[arg_3_1.id] or {}
	self.stageDataList_[arg_3_1.id].is_success = self.stageDataList_[arg_3_1.id].is_success or arg_3_1.is_success

	local var_3_0 = self.stageDataList_[arg_3_1.id].score or 0

	if var_3_0 < arg_3_1.settle_score then
		self.stageDataList_[arg_3_1.id].score = arg_3_1.settle_score or var_3_0
	end
end

function var_0_0:GetBattleResultData()
	return self.battleResultData_
end

function var_0_0:IsCompletedStage(arg_5_1)
	if not self.stageDataList_[arg_5_1] then
		return false
	end

	return self.stageDataList_[arg_5_1].is_success == true
end

function var_0_0:GetStageScore(arg_6_1)
	if not self.stageDataList_[arg_6_1] then
		return 0
	end

	return self.stageDataList_[arg_6_1].score
end

function var_0_0.GetHadEntered(arg_7_0, arg_7_1, arg_7_2)
	return getData(string.format("whack_mole_%d_%d", arg_7_1, arg_7_2), "hadEntered")
end

function var_0_0.SetHadEntered(arg_8_0, arg_8_1, arg_8_2)
	saveData(string.format("whack_mole_%d_%d", arg_8_1, arg_8_2), "hadEntered", true)
end

function var_0_0.GetLastContentPosX(arg_9_0, arg_9_1, arg_9_2)
	return getData(string.format("whack_mole_%d_%d", arg_9_1, arg_9_2), "contentPosX")
end

function var_0_0.SetLastContentPosX(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	saveData(string.format("whack_mole_%d_%d", arg_10_1, arg_10_2), "contentPosX", arg_10_3)
end

function var_0_0:GetSelected(arg_11_1)
	return self.selectedList_[arg_11_1]
end

function var_0_0:SetSelected(arg_12_1)
	self.selectedList_[arg_12_1] = true

	WhackMoleAction.UpdatePlayRedPoint(arg_12_1)
end

return var_0_0
