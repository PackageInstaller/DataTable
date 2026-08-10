local var_0_0 = singletonClass("StoryStageActivityData")

function var_0_0.Init(arg_1_0)
	arg_1_0.stageList_ = {}
	arg_1_0.historyActivityList_ = {}
	arg_1_0.historyChapterList_ = {}
	arg_1_0.defaultActivityID_ = {}
	arg_1_0.redPointList_ = {}
	arg_1_0.unlockState_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.info) do
		local var_2_0 = iter_2_1.chapter_id

		arg_2_0.stageList_[var_2_0] = arg_2_0.stageList_[var_2_0] or {}
		arg_2_0.stageList_[var_2_0][iter_2_1.stage_id] = {
			id = iter_2_1.stage_id,
			clear_times = iter_2_1.clear_time
		}
	end
end

function var_0_0.GetStageData(arg_3_0, arg_3_1)
	return arg_3_0.stageList_[arg_3_1] or {}
end

function var_0_0.GetHistoryStage(arg_4_0, arg_4_1)
	arg_4_0.historyChapterList_[arg_4_1] = arg_4_0.historyChapterList_[arg_4_1] or getData("StoryStageData", "chapterID" .. arg_4_1) or 1

	return arg_4_0.historyChapterList_[arg_4_1]
end

function var_0_0.SaveHistoryStage(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.historyChapterList_[arg_5_1] = arg_5_2

	saveData("StoryStageData", "chapterID" .. arg_5_1, arg_5_2)
end

function var_0_0.GetHistoryChapter(arg_6_0, arg_6_1)
	arg_6_0.historyActivityList_[arg_6_1] = arg_6_0.historyActivityList_[arg_6_1] or getData("StoryStageData", "activityID" .. arg_6_1) or ActivityStoryChapterCfg.get_id_list_by_activity_id[arg_6_1][1]

	return arg_6_0.historyActivityList_[arg_6_1]
end

function var_0_0.SaveHistoryChapter(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.historyActivityList_[arg_7_1] = arg_7_2

	saveData("StoryStageData", "activityID" .. arg_7_1, arg_7_2)
end

function var_0_0.SaveDefaultActivityID(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = ActivityCfg[arg_8_2].activity_theme

	arg_8_0.defaultActivityID_[var_8_0] = arg_8_2

	saveData("StoryStageData", "activityID" .. var_8_0, arg_8_2)
end

function var_0_0.GetDefaultActivityID(arg_9_0, arg_9_1)
	return arg_9_0.defaultActivityID_[arg_9_1] or getData("StoryStageData", "activityID" .. arg_9_1)
end

function var_0_0.SetRedPoint(arg_10_0, arg_10_1)
	saveData("StoryStageData", "RedPoint" .. arg_10_1, 0)
end

function var_0_0.GetRedPoint(arg_11_0, arg_11_1)
	arg_11_0.redPointList_[arg_11_1] = arg_11_0.redPointList_[arg_11_1] or getData("StoryStageData", "RedPoint" .. arg_11_1)

	return arg_11_0.redPointList_[arg_11_1]
end

function var_0_0.SetUnlockState(arg_12_0, arg_12_1)
	arg_12_0.unlockState_[arg_12_1] = true

	saveData("StoryStageData", "unlock" .. arg_12_1, true)
end

function var_0_0.GetUnlockState(arg_13_0, arg_13_1)
	return arg_13_0.unlockState_[arg_13_1] or getData("StoryStageData", "unlock" .. arg_13_1)
end

return var_0_0
