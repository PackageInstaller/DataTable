local var_0_0 = singletonClass("ActivityRhythmGameData")

function var_0_0.Init(arg_1_0)
	arg_1_0.stageDataList_ = {}
	arg_1_0.unlockStageCfgList_ = {}
	arg_1_0.showStageCfgList_ = {}
	arg_1_0.unlockCommandList_ = {}
	arg_1_0.playedStoryList_ = {}
	arg_1_0.curPage_ = ActivityRhythmGameConst.Chapter_ID.ONE

	arg_1_0:InitRedPoint()
end

function var_0_0.InitStageDataList(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = iter_2_1.id

		arg_2_0.stageDataList_[var_2_0] = {}
		arg_2_0.stageDataList_[var_2_0].star = iter_2_1.star_id_list or {}
		arg_2_0.stageDataList_[var_2_0].time = iter_2_1.use_seconds or {}
	end

	arg_2_0:InitUnlockStageData()

	local var_2_1 = #arg_2_0.unlockStageCfgList_
	local var_2_2 = 0

	for iter_2_2, iter_2_3 in pairs(arg_2_0.stageDataList_) do
		var_2_2 = var_2_2 + 1
	end

	if var_2_2 < var_2_1 then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_COMMON .. "_" .. ActivityConst.SUMMER_CHESS_BOARD_RHYTHM, 1, RedPointStyle.NORMAL)
	end
end

function var_0_0.UpdateStageDataList(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.rhythm_stage_info
	local var_3_1 = var_3_0.id

	if arg_3_0.stageDataList_[var_3_1] then
		-- block empty
	else
		arg_3_0.stageDataList_[var_3_1] = {}
	end

	arg_3_0.stageDataList_[var_3_1].star = var_3_0.star_id_list or {}
	arg_3_0.stageDataList_[var_3_1].time = var_3_0.use_seconds or {}
end

function var_0_0.GetStageDataList(arg_4_0)
	return arg_4_0.stageDataList_
end

function var_0_0.InitUnlockStageData(arg_5_0)
	arg_5_0.unlockStageCfgList_ = {}

	for iter_5_0, iter_5_1 in ipairs(ActivityRhythmGameCfg) do
		local var_5_0 = iter_5_1.condition_list

		if not IsConditionAchieved(var_5_0) then
			break
		end

		local var_5_1 = iter_5_1.id

		if arg_5_0:IsUnlockPreStage(var_5_1) and not ActivityRhythmGameTools.GetSessionIsLockByID(iter_5_1.chapter_id) then
			table.insert(arg_5_0.unlockStageCfgList_, iter_5_1.id)
		end
	end
end

function var_0_0.InitUnlockCommandData(arg_6_0)
	arg_6_0.unlockCommandList_ = {}

	for iter_6_0, iter_6_1 in ipairs(TalentTreeCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_CHESS_BOARD_RHYTHM]) do
		local var_6_0 = TalentTreeCfg[iter_6_1].unlock_condition
		local var_6_1 = true

		for iter_6_2, iter_6_3 in ipairs(var_6_0) do
			if not IsConditionAchieved(iter_6_3) then
				var_6_1 = false

				break
			end
		end

		if var_6_1 then
			table.insert(arg_6_0.unlockCommandList_, iter_6_1)
		end
	end
end

function var_0_0.InitStoryListData(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		table.insert(arg_7_0.playedStoryList_, iter_7_1)
	end
end

function var_0_0.UpdateStoryListData(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.playedStoryList_) do
		if iter_8_1 == arg_8_1 then
			return
		end
	end

	table.insert(arg_8_0.playedStoryList_, arg_8_1)
end

function var_0_0.SetCurPage(arg_9_0, arg_9_1)
	arg_9_0.curPage_ = arg_9_1
end

function var_0_0.GetCurPage(arg_10_0)
	return arg_10_0.curPage_
end

function var_0_0.GetCanSwitchChapter(arg_11_0)
	return not ActivityRhythmGameTools.GetSessionIsLockByID(ActivityRhythmGameConst.Chapter_ID.TWO)
end

function var_0_0.IsStroyPlayed(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.playedStoryList_) do
		if iter_12_1 == arg_12_1 then
			return true
		end
	end

	return false
end

function var_0_0.IsUnlockPreStage(arg_13_0, arg_13_1)
	local var_13_0 = ActivityRhythmGameCfg[arg_13_1].pre_level

	if var_13_0 == 0 then
		return true
	end

	return arg_13_0:IsStageClear(var_13_0)
end

function var_0_0.GetCommandListByChapterIDForUI(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.unlockCommandList_) do
		local var_14_1 = TalentTreeCfg[iter_14_1]

		if var_14_1 and var_14_1.stage and ActivityRhythmGameCommandCfg[var_14_1.stage].chapter_id == arg_14_1 then
			table.insert(var_14_0, var_14_1.stage)
		end
	end

	return var_14_0
end

function var_0_0.GetCommandList(arg_15_0, arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.unlockCommandList_) do
		local var_15_1 = TalentTreeCfg[iter_15_1]

		if var_15_1 and var_15_1.stage and ActivityRhythmGameCommandCfg[var_15_1.stage].chapter_id == arg_15_1 then
			table.insert(var_15_0, var_15_1.id)
		end
	end

	return var_15_0
end

function var_0_0.GetCommandListByStageID(arg_16_0, arg_16_1)
	local var_16_0 = -1

	for iter_16_0, iter_16_1 in ipairs(ActivityRhythmGameCfg) do
		if iter_16_1 and iter_16_1.stage_id == arg_16_1 then
			var_16_0 = iter_16_1.chapter_id

			break
		end
	end

	if var_16_0 ~= -1 then
		return arg_16_0:GetCommandList(var_16_0)
	end

	for iter_16_2, iter_16_3 in ipairs(ActivityRhythmGameCommandCfg) do
		if iter_16_3 and iter_16_3.stage_id == arg_16_1 then
			for iter_16_4, iter_16_5 in ipairs(arg_16_0.unlockCommandList_) do
				if TalentTreeCfg[iter_16_5] and TalentTreeCfg[iter_16_5].stage and TalentTreeCfg[iter_16_5].stage == iter_16_2 then
					return {
						iter_16_5
					}
				end
			end
		end
	end

	return {}
end

function var_0_0.IsUnlock(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.unlockStageCfgList_) do
		if iter_17_1 == arg_17_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetStarsByCfgID(arg_18_0, arg_18_1)
	local var_18_0 = ActivityRhythmGameCfg[arg_18_1].stage_id

	for iter_18_0, iter_18_1 in pairs(arg_18_0.stageDataList_) do
		if iter_18_0 == var_18_0 then
			return iter_18_1.star
		end
	end

	return {}
end

function var_0_0.GetShowCfgIDsByChapterID(arg_19_0, arg_19_1)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(ActivityRhythmGameCfg) do
		if iter_19_1 and iter_19_1.chapter_id == arg_19_1 then
			table.insert(var_19_0, iter_19_1.id)
		end
	end

	return var_19_0
end

function var_0_0.IsStageClear(arg_20_0, arg_20_1)
	local var_20_0 = false

	for iter_20_0, iter_20_1 in pairs(arg_20_0.stageDataList_) do
		if iter_20_0 == arg_20_1 then
			var_20_0 = true

			break
		end
	end

	return var_20_0
end

function var_0_0.GetTimeByStageID(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.stageDataList_[arg_21_1]

	if var_21_0 then
		return var_21_0.time or -1
	end

	return -1
end

function var_0_0.GetStarCount(arg_22_0)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in pairs(arg_22_0.stageDataList_) do
		if iter_22_1 and iter_22_1.star then
			var_22_0 = var_22_0 + #iter_22_1.star
		end
	end

	return var_22_0
end

function var_0_0.InitRedPoint(arg_23_0)
	local var_23_0 = {}
	local var_23_1 = ActivityRhythmGameTools.GetSubActivityID(ActivityConst.SUMMER_CHESS_BOARD_RHYTHM_TASK)

	for iter_23_0, iter_23_1 in ipairs(var_23_1 or {}) do
		local var_23_2 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_23_1)

		table.insert(var_23_0, var_23_2)
	end

	local var_23_3 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SUMMER_CHESS_BOARD_RHYTHM_TASK)

	manager.redPoint:addGroup(var_23_3, var_23_0)

	local var_23_4 = {}
	local var_23_5 = ActivityRhythmGameTools.GetSubActivityID(ActivityConst.SUMMER_CHESS_BOARD_RHYTHM_LIMIT_TASK)

	for iter_23_2, iter_23_3 in ipairs(var_23_5 or {}) do
		local var_23_6 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_23_3)

		table.insert(var_23_4, var_23_6)
	end

	local var_23_7 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SUMMER_CHESS_BOARD_RHYTHM_LIMIT_TASK)

	manager.redPoint:addGroup(var_23_7, var_23_4)
	manager.redPoint:addGroup(RedPointConst.ACTIVITY_RHYTHM_GIFT, {
		var_23_3,
		var_23_7
	})
end

return var_0_0
