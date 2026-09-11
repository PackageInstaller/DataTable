local var_0_0 = singletonClass("ActivityRhythmGameData")

function var_0_0:Init()
	self.stageDataList_ = {}
	self.unlockStageCfgList_ = {}
	self.showStageCfgList_ = {}
	self.unlockCommandList_ = {}
	self.playedStoryList_ = {}
	self.curPage_ = ActivityRhythmGameConst.Chapter_ID.ONE

	self:InitRedPoint()
end

function var_0_0:InitStageDataList(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		self.stageDataList_[iter_2_1.id] = {}
		self.stageDataList_[iter_2_1.id].star = iter_2_1.star_id_list or {}
		self.stageDataList_[iter_2_1.id].time = iter_2_1.use_seconds or {}
	end

	self:InitUnlockStageData()

	local var_2_0 = 0

	for iter_2_2, iter_2_3 in pairs(self.stageDataList_) do
		var_2_0 = var_2_0 + 1
	end

	if var_2_0 < #self.unlockStageCfgList_ then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_COMMON .. "_" .. ActivityConst.SUMMER_CHESS_BOARD_RHYTHM, 1, RedPointStyle.NORMAL)
	end
end

function var_0_0:UpdateStageDataList(arg_3_1)
	local var_3_0 = arg_3_1.rhythm_stage_info.id

	if self.stageDataList_[arg_3_1.rhythm_stage_info.id] then
		-- block empty
	else
		self.stageDataList_[var_3_0] = {}
	end

	self.stageDataList_[var_3_0].star = arg_3_1.rhythm_stage_info.star_id_list or {}
	self.stageDataList_[var_3_0].time = arg_3_1.rhythm_stage_info.use_seconds or {}
end

function var_0_0:GetStageDataList()
	return self.stageDataList_
end

function var_0_0:InitUnlockStageData()
	self.unlockStageCfgList_ = {}

	for iter_5_0, iter_5_1 in ipairs(ActivityRhythmGameCfg) do
		if not IsConditionAchieved(iter_5_1.condition_list) then
			break
		end

		if self:IsUnlockPreStage(iter_5_1.id) and not ActivityRhythmGameTools.GetSessionIsLockByID(iter_5_1.chapter_id) then
			table.insert(self.unlockStageCfgList_, iter_5_1.id)
		end
	end
end

function var_0_0:InitUnlockCommandData()
	self.unlockCommandList_ = {}

	for iter_6_0, iter_6_1 in ipairs(TalentTreeCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_CHESS_BOARD_RHYTHM]) do
		local var_6_0 = true

		for iter_6_2, iter_6_3 in ipairs(TalentTreeCfg[iter_6_1].unlock_condition) do
			if not IsConditionAchieved(iter_6_3) then
				var_6_0 = false

				break
			end
		end

		if var_6_0 then
			table.insert(self.unlockCommandList_, iter_6_1)
		end
	end
end

function var_0_0:InitStoryListData(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		table.insert(self.playedStoryList_, iter_7_1)
	end
end

function var_0_0:UpdateStoryListData(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self.playedStoryList_) do
		if iter_8_1 == arg_8_1 then
			return
		end
	end

	table.insert(self.playedStoryList_, arg_8_1)
end

function var_0_0.SetCurPage(arg_9_0, arg_9_1)
	arg_9_0.curPage_ = arg_9_1
end

function var_0_0:GetCurPage()
	return self.curPage_
end

function var_0_0.GetCanSwitchChapter(arg_11_0)
	return not ActivityRhythmGameTools.GetSessionIsLockByID(ActivityRhythmGameConst.Chapter_ID.TWO)
end

function var_0_0:IsStroyPlayed(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self.playedStoryList_) do
		if iter_12_1 == arg_12_1 then
			return true
		end
	end

	return false
end

function var_0_0:IsUnlockPreStage(arg_13_1)
	if ActivityRhythmGameCfg[arg_13_1].pre_level == 0 then
		return true
	end

	return self:IsStageClear(ActivityRhythmGameCfg[arg_13_1].pre_level)
end

function var_0_0:GetCommandListByChapterIDForUI(arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(self.unlockCommandList_) do
		if TalentTreeCfg[iter_14_1] and TalentTreeCfg[iter_14_1].stage and ActivityRhythmGameCommandCfg[TalentTreeCfg[iter_14_1].stage].chapter_id == arg_14_1 then
			table.insert(var_14_0, TalentTreeCfg[iter_14_1].stage)
		end
	end

	return var_14_0
end

function var_0_0:GetCommandList(arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(self.unlockCommandList_) do
		if TalentTreeCfg[iter_15_1] and TalentTreeCfg[iter_15_1].stage and ActivityRhythmGameCommandCfg[TalentTreeCfg[iter_15_1].stage].chapter_id == arg_15_1 then
			table.insert(var_15_0, TalentTreeCfg[iter_15_1].id)
		end
	end

	return var_15_0
end

function var_0_0:GetCommandListByStageID(arg_16_1)
	local var_16_0 = -1

	for iter_16_0, iter_16_1 in ipairs(ActivityRhythmGameCfg) do
		if iter_16_1 and iter_16_1.stage_id == arg_16_1 then
			var_16_0 = iter_16_1.chapter_id

			break
		end
	end

	if var_16_0 ~= -1 then
		return self:GetCommandList(var_16_0)
	end

	for iter_16_2, iter_16_3 in ipairs(ActivityRhythmGameCommandCfg) do
		if iter_16_3 and iter_16_3.stage_id == arg_16_1 then
			for iter_16_4, iter_16_5 in ipairs(self.unlockCommandList_) do
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

function var_0_0:IsUnlock(arg_17_1)
	for iter_17_0, iter_17_1 in pairs(self.unlockStageCfgList_) do
		if iter_17_1 == arg_17_1 then
			return true
		end
	end

	return false
end

function var_0_0:GetStarsByCfgID(arg_18_1)
	for iter_18_0, iter_18_1 in pairs(self.stageDataList_) do
		if iter_18_0 == ActivityRhythmGameCfg[arg_18_1].stage_id then
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

function var_0_0:IsStageClear(arg_20_1)
	local var_20_0 = false

	for iter_20_0, iter_20_1 in pairs(self.stageDataList_) do
		if iter_20_0 == arg_20_1 then
			var_20_0 = true

			break
		end
	end

	return var_20_0
end

function var_0_0:GetTimeByStageID(arg_21_1)
	if self.stageDataList_[arg_21_1] then
		return self.stageDataList_[arg_21_1].time or -1
	end

	return -1
end

function var_0_0:GetStarCount()
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in pairs(self.stageDataList_) do
		if iter_22_1 and iter_22_1.star then
			var_22_0 = var_22_0 + #iter_22_1.star
		end
	end

	return var_22_0
end

function var_0_0.InitRedPoint(arg_23_0)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(ActivityRhythmGameTools.GetSubActivityID(ActivityConst.SUMMER_CHESS_BOARD_RHYTHM_TASK) or {}) do
		table.insert(var_23_0, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_23_1)))
	end

	local var_23_1 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SUMMER_CHESS_BOARD_RHYTHM_TASK)

	manager.redPoint:addGroup(var_23_1, var_23_0)

	local var_23_2 = {}

	for iter_23_2, iter_23_3 in ipairs(ActivityRhythmGameTools.GetSubActivityID(ActivityConst.SUMMER_CHESS_BOARD_RHYTHM_LIMIT_TASK) or {}) do
		table.insert(var_23_2, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_23_3)))
	end

	local var_23_3 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SUMMER_CHESS_BOARD_RHYTHM_LIMIT_TASK)

	manager.redPoint:addGroup(var_23_3, var_23_2)
	manager.redPoint:addGroup(RedPointConst.ACTIVITY_RHYTHM_GIFT, {
		var_23_1,
		var_23_3
	})
end

return var_0_0
