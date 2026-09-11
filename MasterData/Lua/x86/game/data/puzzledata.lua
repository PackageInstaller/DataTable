local var_0_0 = singletonClass("PuzzleData")
local var_0_1 = {
	UNCOMPLETE = 1,
	UNRECEIVE = 2,
	RECEIVED = 3
}

function var_0_0.Init(arg_1_0)
	arg_1_0.stepCountList_ = {}
	arg_1_0.puzzleStateList_ = {}
	arg_1_0.minStepCountList_ = {}
	arg_1_0.selectedList_ = {}
	arg_1_0.watchedPlotList_ = {}
	arg_1_0.activityStateList_ = {}
end

function var_0_0:InitData(arg_2_1)
	self.activityStateList_[arg_2_1.activity_id] = arg_2_1.is_clear == 2 and (arg_2_1.is_reward_admitted == 2 and var_0_1.RECEIVED or var_0_1.UNRECEIVE) or var_0_1.UNCOMPLETE
	self.stepCountList_[arg_2_1.activity_id] = arg_2_1.change_times or 0
	self.minStepCountList_[arg_2_1.activity_id] = arg_2_1.least_change_times or 0
	self.puzzleStateList_[arg_2_1.activity_id] = arg_2_1.puzzle.puzzle_data
	self.puzzleStateList_[arg_2_1.activity_id][arg_2_1.puzzle.vacant_position] = ActivityPuzzleCfg[arg_2_1.activity_id].block

	self:RefreshRedPoint(arg_2_1.activity_id)
end

function var_0_0:GetStateList(arg_3_1)
	return self.puzzleStateList_[arg_3_1]
end

function var_0_0:IsCompleted(arg_4_1)
	if self.activityStateList_[arg_4_1] ~= nil then
		return self.activityStateList_[arg_4_1] >= var_0_1.UNRECEIVE
	end

	return false
end

function var_0_0:IsReceived(arg_5_1)
	if self.activityStateList_[arg_5_1] then
		return self.activityStateList_[arg_5_1] == var_0_1.RECEIVED
	end

	return false
end

function var_0_0:GetStepCount(arg_6_1)
	return self.stepCountList_[arg_6_1] or 0
end

function var_0_0:GetMinStepCount(arg_7_1)
	return self.minStepCountList_[arg_7_1]
end

function var_0_0:SetMinStepCount(arg_8_1)
	local var_8_0 = false

	if self.minStepCountList_[arg_8_1] == 0 or self.stepCountList_[arg_8_1] < self.minStepCountList_[arg_8_1] then
		var_8_0 = true
		self.minStepCountList_[arg_8_1] = self.stepCountList_[arg_8_1]
	end

	return var_8_0, self.minStepCountList_[arg_8_1]
end

function var_0_0:SetCompletedActivityList(arg_9_1)
	if self.activityStateList_[arg_9_1] ~= var_0_1.RECEIVED then
		self.activityStateList_[arg_9_1] = var_0_1.UNRECEIVE
	end

	self:RefreshRedPoint(arg_9_1)
end

function var_0_0:SetReceivedActivityList(arg_10_1)
	self.activityStateList_[arg_10_1] = var_0_1.RECEIVED

	self:RefreshRedPoint(arg_10_1)
end

function var_0_0:SetPuzzleState(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	self.puzzleStateList_[arg_11_1] = self.puzzleStateList_[arg_11_1] or {}
	self.puzzleStateList_[arg_11_1][arg_11_2] = arg_11_3
	self.puzzleStateList_[arg_11_1][arg_11_4] = arg_11_5
	self.stepCountList_[arg_11_1] = self.stepCountList_[arg_11_1] + 1
end

function var_0_0:ResetData(arg_12_1)
	self.puzzleStateList_[arg_12_1] = clone(ActivityPuzzleCfg[arg_12_1].default_array)
	self.stepCountList_[arg_12_1] = 0
end

function var_0_0:SetSelectActivity(arg_13_1)
	if self.activityStateList_[arg_13_1] ~= var_0_1.UNRECEIVE then
		manager.redPoint:setTip(string.format("%s_%s_%s_normal", RedPointConst.ACTIVITY_PUZZLE, ActivityPuzzleCfg[arg_13_1].main_activity_id, arg_13_1), 0)
	end
end

function var_0_0:SetWatchedVideo(arg_14_1)
	saveData(string.format("Puzzle_%d", arg_14_1), "watchVideo", true)
	self:RefreshVideoRedPoint(arg_14_1, ActivityPuzzleCfg[arg_14_1].main_activity_id)
end

function var_0_0:RefreshRedPoint(arg_15_1)
	local var_15_0 = ActivityPuzzleCfg[arg_15_1].main_activity_id

	if ActivityData:GetActivityIsOpen(arg_15_1) and self.activityStateList_[arg_15_1] <= var_0_1.UNRECEIVE then
		manager.redPoint:setTip(string.format("%s_%s_%s_normal", RedPointConst.ACTIVITY_PUZZLE, var_15_0, arg_15_1), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s_%s_normal", RedPointConst.ACTIVITY_PUZZLE, var_15_0, arg_15_1), 0)
	end

	self:RefreshVideoRedPoint(arg_15_1, var_15_0)
end

function var_0_0:RefreshVideoRedPoint(arg_16_1, arg_16_2)
	if self.activityStateList_[arg_16_1] >= var_0_1.UNRECEIVE and not (ActivityPuzzleCfg[arg_16_1].story_id == 0 or getData(string.format("Puzzle_%d", arg_16_1), "watchVideo") == true) then
		manager.redPoint:setTip(string.format("%s_%s_%s_video", RedPointConst.ACTIVITY_PUZZLE, arg_16_2, arg_16_1), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s_%s_video", RedPointConst.ACTIVITY_PUZZLE, arg_16_2, arg_16_1), 0)
	end
end

function var_0_0.GetLastContentPosX(arg_17_0, arg_17_1)
	return getData(string.format("Puzzle_%d", arg_17_1), "contentPosX")
end

function var_0_0.SetLastContentPosX(arg_18_0, arg_18_1, arg_18_2)
	saveData(string.format("Puzzle_%d", arg_18_1), "contentPosX", arg_18_2)
end

return var_0_0
