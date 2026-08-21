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

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	if arg_2_1.is_clear == 2 then
		if arg_2_1.is_reward_admitted == 2 then
			arg_2_0.activityStateList_[var_2_0] = var_0_1.RECEIVED
		else
			arg_2_0.activityStateList_[var_2_0] = var_0_1.UNRECEIVE
		end
	else
		arg_2_0.activityStateList_[var_2_0] = var_0_1.UNCOMPLETE
	end

	arg_2_0.stepCountList_[var_2_0] = arg_2_1.change_times or 0
	arg_2_0.minStepCountList_[var_2_0] = arg_2_1.least_change_times or 0
	arg_2_0.puzzleStateList_[var_2_0] = arg_2_1.puzzle.puzzle_data
	arg_2_0.puzzleStateList_[var_2_0][arg_2_1.puzzle.vacant_position] = ActivityPuzzleCfg[var_2_0].block

	arg_2_0:RefreshRedPoint(var_2_0)
end

function var_0_0.GetStateList(arg_3_0, arg_3_1)
	return arg_3_0.puzzleStateList_[arg_3_1]
end

function var_0_0.IsCompleted(arg_4_0, arg_4_1)
	if arg_4_0.activityStateList_[arg_4_1] ~= nil then
		return arg_4_0.activityStateList_[arg_4_1] >= var_0_1.UNRECEIVE
	end

	return false
end

function var_0_0.IsReceived(arg_5_0, arg_5_1)
	if arg_5_0.activityStateList_[arg_5_1] then
		return arg_5_0.activityStateList_[arg_5_1] == var_0_1.RECEIVED
	end

	return false
end

function var_0_0.GetStepCount(arg_6_0, arg_6_1)
	return arg_6_0.stepCountList_[arg_6_1] or 0
end

function var_0_0.GetMinStepCount(arg_7_0, arg_7_1)
	return arg_7_0.minStepCountList_[arg_7_1]
end

function var_0_0.SetMinStepCount(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.minStepCountList_[arg_8_1]
	local var_8_1 = false

	if arg_8_0.minStepCountList_[arg_8_1] == 0 or arg_8_0.stepCountList_[arg_8_1] < arg_8_0.minStepCountList_[arg_8_1] then
		var_8_1 = true
		arg_8_0.minStepCountList_[arg_8_1] = arg_8_0.stepCountList_[arg_8_1]
	end

	return var_8_1, var_8_0
end

function var_0_0.SetCompletedActivityList(arg_9_0, arg_9_1)
	if arg_9_0.activityStateList_[arg_9_1] ~= var_0_1.RECEIVED then
		arg_9_0.activityStateList_[arg_9_1] = var_0_1.UNRECEIVE
	end

	arg_9_0:RefreshRedPoint(arg_9_1)
end

function var_0_0.SetReceivedActivityList(arg_10_0, arg_10_1)
	arg_10_0.activityStateList_[arg_10_1] = var_0_1.RECEIVED

	arg_10_0:RefreshRedPoint(arg_10_1)
end

function var_0_0.SetPuzzleState(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	arg_11_0.puzzleStateList_[arg_11_1] = arg_11_0.puzzleStateList_[arg_11_1] or {}
	arg_11_0.puzzleStateList_[arg_11_1][arg_11_2] = arg_11_3
	arg_11_0.puzzleStateList_[arg_11_1][arg_11_4] = arg_11_5
	arg_11_0.stepCountList_[arg_11_1] = arg_11_0.stepCountList_[arg_11_1] + 1
end

function var_0_0.ResetData(arg_12_0, arg_12_1)
	arg_12_0.puzzleStateList_[arg_12_1] = clone(ActivityPuzzleCfg[arg_12_1].default_array)
	arg_12_0.stepCountList_[arg_12_1] = 0
end

function var_0_0.SetSelectActivity(arg_13_0, arg_13_1)
	local var_13_0 = ActivityPuzzleCfg[arg_13_1].main_activity_id

	if arg_13_0.activityStateList_[arg_13_1] ~= var_0_1.UNRECEIVE then
		manager.redPoint:setTip(string.format("%s_%s_%s_normal", RedPointConst.ACTIVITY_PUZZLE, var_13_0, arg_13_1), 0)
	end
end

function var_0_0.SetWatchedVideo(arg_14_0, arg_14_1)
	saveData(string.format("Puzzle_%d", arg_14_1), "watchVideo", true)

	local var_14_0 = ActivityPuzzleCfg[arg_14_1].main_activity_id

	arg_14_0:RefreshVideoRedPoint(arg_14_1, var_14_0)
end

function var_0_0.RefreshRedPoint(arg_15_0, arg_15_1)
	local var_15_0 = ActivityPuzzleCfg[arg_15_1].main_activity_id

	if ActivityData:GetActivityIsOpen(arg_15_1) and arg_15_0.activityStateList_[arg_15_1] <= var_0_1.UNRECEIVE then
		manager.redPoint:setTip(string.format("%s_%s_%s_normal", RedPointConst.ACTIVITY_PUZZLE, var_15_0, arg_15_1), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s_%s_normal", RedPointConst.ACTIVITY_PUZZLE, var_15_0, arg_15_1), 0)
	end

	arg_15_0:RefreshVideoRedPoint(arg_15_1, var_15_0)
end

function var_0_0.RefreshVideoRedPoint(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = ActivityPuzzleCfg[arg_16_1].story_id == 0 or getData(string.format("Puzzle_%d", arg_16_1), "watchVideo") == true

	if arg_16_0.activityStateList_[arg_16_1] >= var_0_1.UNRECEIVE and not var_16_0 then
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
