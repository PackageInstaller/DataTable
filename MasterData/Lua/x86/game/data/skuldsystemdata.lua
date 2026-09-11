local var_0_0 = singletonClass("SkuldSystemData")

function var_0_0:Init()
	self.stageIDGetLevelIDList_ = {}

	for iter_1_0, iter_1_1 in pairs(SkuldStageCfg.all) do
		self.stageIDGetLevelIDList_[SkuldStageCfg[iter_1_1].type[2]] = iter_1_1
	end

	self.keyList_ = {}
	self.LevelClearInfoList_ = {}
	self.getPointRewardList_ = {}
	self.cacheIconNum_ = 0
	self.keyDefineList_ = {
		PhotoClick4 = 9,
		EndClick = 10,
		IsPlaySectionUnlock1 = 2,
		IsPlaySectionUnlock3 = 4,
		PhotoClick2 = 7,
		IsPlayEndUnlock = 5,
		IsShowEmptyDreamPop = 1,
		PhotoClick3 = 8,
		IsPlaySectionUnlock2 = 3,
		PhotoClick1 = 6
	}
	self.cacheStageViewInfo_ = nil
	self.cacheFinalStageViewInfo_ = nil
end

function var_0_0.InitRedPointGroup(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(ActivityCfg[ActivityConst.ACTIVITY_SKULD_MAIN_TASK].sub_activity_list) do
		table.insert(var_2_0, RedPointConst.SKULD_SYSTEM_TASK_TAG .. iter_2_1)

		local var_2_1 = {}

		for iter_2_2, iter_2_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_2_1]) do
			table.insert(var_2_1, RedPointConst.SKULD_SYSTEM_TASK_ITEM .. iter_2_3)
		end

		manager.redPoint:addGroup(RedPointConst.SKULD_SYSTEM_TASK_TAG .. iter_2_1, var_2_1)
	end

	manager.redPoint:addGroup(RedPointConst.SKULD_SYSTEM_TASK_ALL .. ActivityConst.ACTIVITY_SKULD_MAIN_TASK, var_2_0)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		var_0_0:UpdateSkuldTaskRedPoint()
	end)

	local var_2_2 = {}

	for iter_2_4, iter_2_5 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_MAIN]) do
		table.insert(var_2_2, RedPointConst.SKULD_SYSTEM_TRUST_ITEM .. iter_2_5)
	end

	manager.redPoint:addGroup(RedPointConst.SKULD_SYSTEM_TRUST_ALL, var_2_2)
	manager.notify:RegistListener(RECEIVE_POINT_REWARD, function()
		var_0_0:UpdateSkuldPointRewardRedPoint()
	end)

	local var_2_3 = {}
	local var_2_4, var_2_5 = StageTools.ReorderStageArchiveListByGroup((StageTools.GetStageArchiveIDListByChapterID(6010128)))

	for iter_2_6, iter_2_7 in ipairs(var_2_4) do
		for iter_2_8, iter_2_9 in ipairs(var_2_5[iter_2_7]) do
			table.insert(var_2_3, RedPointConst.SKULD_SYSTEM_ARCHIVE_ITEM .. iter_2_9)
		end
	end

	manager.redPoint:addGroup(RedPointConst.SKULD_SYSTEM_ARCHIVE_ALL .. "_6010128", var_2_3)
	manager.notify:RegistListener(STAGE_ARCHIVE_RED_UPDATE, function()
		var_0_0:UpdateSkuldStageArchiveRed()
	end)
	manager.redPoint:addGroup(RedPointConst.ACTIVITY_STORY_STAGE .. ActivityConst.ACTIVITY_SKULD_MAIN, {
		RedPointConst.SKULD_SYSTEM_TASK_ALL .. ActivityConst.ACTIVITY_SKULD_MAIN_TASK,
		RedPointConst.SKULD_SYSTEM_TRUST_ALL,
		RedPointConst.SKULD_SYSTEM_ARCHIVE_ALL .. "_6010128",
		RedPointConst.SKULD_SYSTEM_FINAL_OPEN
	})
	manager.redPoint:addGroup(RedPointConst.SKULD_SYSTEM_PHOTO, {
		RedPointConst.SKULD_SYSTEM_PHOTO .. 1,
		RedPointConst.SKULD_SYSTEM_PHOTO .. 2,
		RedPointConst.SKULD_SYSTEM_PHOTO .. 3,
		RedPointConst.SKULD_SYSTEM_PHOTO .. 4
	})
end

function var_0_0.UpdateSkuldStageArchiveRed(arg_6_0)
	local var_6_0, var_6_1 = StageTools.ReorderStageArchiveListByGroup((StageTools.GetStageArchiveIDListByChapterID(6010128)))

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		for iter_6_2, iter_6_3 in ipairs(var_6_1[iter_6_1]) do
			manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_ARCHIVE_ITEM .. iter_6_3, BattleStageData:GetStageArchiveRedState(iter_6_3) == true and 1 or 0)
		end
	end
end

function var_0_0:UpdateSkuldPhoteRedPoint()
	for iter_7_0 = 1, 4 do
		if self:GetClientKey("PhotoClick" .. iter_7_0) then
			manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_PHOTO .. iter_7_0, 0)
		elseif SkuldSystemData:GetLevelIDIsClear(GameSetting["skuld_photo" .. iter_7_0].value[5]) then
			manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_PHOTO .. iter_7_0, 1)
		else
			manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_PHOTO .. iter_7_0, 0)
		end
	end
end

function var_0_0.UpdateSkuldTaskRedPoint(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(ActivityCfg[ActivityConst.ACTIVITY_SKULD_MAIN_TASK].sub_activity_list) do
		local var_8_0 = ActivityData:GetActivityIsOpen(iter_8_1)

		for iter_8_2, iter_8_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_8_1]) do
			if var_8_0 then
				local var_8_1 = TaskData2:GetTaskProgress(iter_8_3)

				if TaskData2:GetTaskComplete(iter_8_3) then
					manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_TASK_ITEM .. iter_8_3, 0)
				elseif var_8_1 >= AssignmentCfg[iter_8_3].need then
					manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_TASK_ITEM .. iter_8_3, 1)
				else
					manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_TASK_ITEM .. iter_8_3, 0)
				end
			else
				manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_TASK_ITEM .. iter_8_3, 0)
			end
		end
	end
end

function var_0_0:UpdateSkuldPointRewardRedPoint()
	for iter_9_0, iter_9_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_MAIN]) do
		if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id) >= ActivityPointRewardCfg[iter_9_1].need then
			if self:GetPointRewardIsGet(iter_9_1) then
				manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_TRUST_ITEM .. iter_9_1, 0)
			else
				manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_TRUST_ITEM .. iter_9_1, 1)
			end
		else
			manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_TRUST_ITEM .. iter_9_1, 0)
		end
	end
end

function var_0_0:UpdateSkuldFinalOpenRedPoint()
	local var_10_0 = false

	for iter_10_0, iter_10_1 in pairs(SkuldStageCfg.get_id_list_by_section[9]) do
		if self:GetLevelIDIsOpen(iter_10_1) then
			var_10_0 = true

			break
		end
	end

	if var_10_0 then
		if self:GetClientKey("EndClick") then
			manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_FINAL_OPEN, 0, RedPointStyle.SHOW_NEW_TAG)
		else
			manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_FINAL_OPEN, 1, RedPointStyle.SHOW_NEW_TAG)
		end
	else
		manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_FINAL_OPEN, 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

function var_0_0:SetData(arg_11_1)
	self.keyList_ = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.client_opt) do
		self.keyList_[iter_11_1] = true
	end

	self.LevelClearInfoList_ = {}

	for iter_11_2, iter_11_3 in ipairs(arg_11_1.mission_list) do
		self.LevelClearInfoList_[iter_11_3.id] = iter_11_3.times
	end

	self.getPointRewardList_ = {}

	for iter_11_4, iter_11_5 in ipairs(arg_11_1.reward_list) do
		table.insert(self.getPointRewardList_, iter_11_5)
	end

	self:UpdateSkuldPointRewardRedPoint()
	self:UpdateSkuldFinalOpenRedPoint()
end

function var_0_0:GetLevelIDIsOpen(arg_12_1)
	for iter_12_0, iter_12_1 in pairs(SkuldStageCfg[arg_12_1].pre_id) do
		if not self:GetLevelIDIsClear(iter_12_1) then
			return false
		end
	end

	return true
end

function var_0_0:GetLevelIDIsClear(arg_13_1)
	if self.LevelClearInfoList_[arg_13_1] and self.LevelClearInfoList_[arg_13_1] > 0 then
		return true
	else
		return false
	end
end

function var_0_0:GetLevelIDByStageID(arg_14_1)
	if self.stageIDGetLevelIDList_[arg_14_1] then
		return self.stageIDGetLevelIDList_[arg_14_1]
	else
		error(arg_14_1, "没有对应的系统ID")
	end
end

function var_0_0:GetIsShowFrontPop()
	return self.isShowFrontPop_
end

function var_0_0:SetClientKey(arg_16_1)
	self.keyList_[arg_16_1] = true
end

function var_0_0:GetClinetKeyByDefine(arg_17_1)
	return self.keyDefineList_[arg_17_1]
end

function var_0_0:GetClientKey(arg_18_1)
	if self.keyDefineList_[arg_18_1] == nil then
		error("SkuldSystemData KeyDefine = nil ,", arg_18_1)
	end

	if self.keyList_[self.keyDefineList_[arg_18_1]] then
		return self.keyList_[self.keyDefineList_[arg_18_1]]
	else
		return false
	end
end

function var_0_0.GetCurTaskScheduleInfo(arg_19_0)
	local var_19_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_SCHEDULE_TASK][#AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_SCHEDULE_TASK]]

	return TaskData2:GetTaskProgress(var_19_0), AssignmentCfg[var_19_0].need
end

function var_0_0.CacheSkuldIconNum(arg_20_0)
	arg_20_0.cacheIconNum_ = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id)
end

function var_0_0:GetCacheSkuldIconNum()
	return self.cacheIconNum_
end

function var_0_0:PassLevel(arg_22_1)
	self.LevelClearInfoList_[arg_22_1] = self.LevelClearInfoList_[arg_22_1] and self.LevelClearInfoList_[arg_22_1] + 1 or 1

	self:UpdateSkuldFinalOpenRedPoint()
end

function var_0_0:GetPointRewardIsGet(arg_23_1)
	self.getPointRewardList_ = self.getPointRewardList_ or {}

	if table.indexof(self.getPointRewardList_, arg_23_1) then
		return true
	else
		return false
	end
end

function var_0_0:GetPointReward(arg_24_1)
	self.getPointRewardList_ = self.getPointRewardList_ or {}

	table.insert(self.getPointRewardList_, arg_24_1)
end

function var_0_0.CacheStageViewInfo(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_2 then
		arg_25_0.cacheFinalStageViewInfo_ = arg_25_1
	else
		arg_25_0.cacheStageViewInfo_ = arg_25_1
	end
end

function var_0_0:GetCacheStageViewInfo(arg_26_1)
	if arg_26_1 then
		return self.cacheFinalStageViewInfo_
	else
		return self.cacheStageViewInfo_
	end
end

return var_0_0
