local var_0_0 = singletonClass("SkuldSystemData")

function var_0_0.Init(arg_1_0)
	arg_1_0.stageIDGetLevelIDList_ = {}

	for iter_1_0, iter_1_1 in pairs(SkuldStageCfg.all) do
		arg_1_0.stageIDGetLevelIDList_[SkuldStageCfg[iter_1_1].type[2]] = iter_1_1
	end

	arg_1_0.keyList_ = {}
	arg_1_0.LevelClearInfoList_ = {}
	arg_1_0.getPointRewardList_ = {}
	arg_1_0.cacheIconNum_ = 0
	arg_1_0.keyDefineList_ = {
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
	arg_1_0.cacheStageViewInfo_ = nil
	arg_1_0.cacheFinalStageViewInfo_ = nil
end

function var_0_0.InitRedPointGroup(arg_2_0)
	local var_2_0 = RedPointConst.ACTIVITY_STORY_STAGE .. ActivityConst.ACTIVITY_SKULD_MAIN
	local var_2_1 = RedPointConst.SKULD_SYSTEM_TASK_ALL .. ActivityConst.ACTIVITY_SKULD_MAIN_TASK
	local var_2_2 = ActivityCfg[ActivityConst.ACTIVITY_SKULD_MAIN_TASK]
	local var_2_3 = {}

	for iter_2_0, iter_2_1 in pairs(var_2_2.sub_activity_list) do
		local var_2_4 = RedPointConst.SKULD_SYSTEM_TASK_TAG .. iter_2_1

		table.insert(var_2_3, var_2_4)

		local var_2_5 = {}

		for iter_2_2, iter_2_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_2_1]) do
			local var_2_6 = RedPointConst.SKULD_SYSTEM_TASK_ITEM .. iter_2_3

			table.insert(var_2_5, var_2_6)
		end

		manager.redPoint:addGroup(var_2_4, var_2_5)
	end

	manager.redPoint:addGroup(var_2_1, var_2_3)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		var_0_0:UpdateSkuldTaskRedPoint()
	end)

	local var_2_7 = RedPointConst.SKULD_SYSTEM_TRUST_ALL
	local var_2_8 = {}

	for iter_2_4, iter_2_5 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_MAIN]) do
		local var_2_9 = RedPointConst.SKULD_SYSTEM_TRUST_ITEM .. iter_2_5

		table.insert(var_2_8, var_2_9)
	end

	manager.redPoint:addGroup(var_2_7, var_2_8)
	manager.notify:RegistListener(RECEIVE_POINT_REWARD, function()
		var_0_0:UpdateSkuldPointRewardRedPoint()
	end)

	local var_2_10 = RedPointConst.SKULD_SYSTEM_ARCHIVE_ALL .. "_6010128"
	local var_2_11 = {}
	local var_2_12 = StageTools.GetStageArchiveIDListByChapterID(6010128)
	local var_2_13, var_2_14 = StageTools.ReorderStageArchiveListByGroup(var_2_12)

	for iter_2_6, iter_2_7 in ipairs(var_2_13) do
		for iter_2_8, iter_2_9 in ipairs(var_2_14[iter_2_7]) do
			local var_2_15 = RedPointConst.SKULD_SYSTEM_ARCHIVE_ITEM .. iter_2_9

			table.insert(var_2_11, var_2_15)
		end
	end

	manager.redPoint:addGroup(var_2_10, var_2_11)
	manager.notify:RegistListener(STAGE_ARCHIVE_RED_UPDATE, function()
		var_0_0:UpdateSkuldStageArchiveRed()
	end)
	manager.redPoint:addGroup(var_2_0, {
		var_2_1,
		var_2_7,
		var_2_10,
		RedPointConst.SKULD_SYSTEM_FINAL_OPEN
	})

	local var_2_16 = {
		RedPointConst.SKULD_SYSTEM_PHOTO .. 1,
		RedPointConst.SKULD_SYSTEM_PHOTO .. 2,
		RedPointConst.SKULD_SYSTEM_PHOTO .. 3,
		RedPointConst.SKULD_SYSTEM_PHOTO .. 4
	}

	manager.redPoint:addGroup(RedPointConst.SKULD_SYSTEM_PHOTO, var_2_16)
end

function var_0_0.UpdateSkuldStageArchiveRed(arg_6_0)
	local var_6_0 = StageTools.GetStageArchiveIDListByChapterID(6010128)
	local var_6_1, var_6_2 = StageTools.ReorderStageArchiveListByGroup(var_6_0)

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		for iter_6_2, iter_6_3 in ipairs(var_6_2[iter_6_1]) do
			local var_6_3 = RedPointConst.SKULD_SYSTEM_ARCHIVE_ITEM .. iter_6_3
			local var_6_4 = BattleStageData:GetStageArchiveRedState(iter_6_3)

			manager.redPoint:setTip(var_6_3, var_6_4 == true and 1 or 0)
		end
	end
end

function var_0_0.UpdateSkuldPhoteRedPoint(arg_7_0)
	for iter_7_0 = 1, 4 do
		local var_7_0 = RedPointConst.SKULD_SYSTEM_PHOTO .. iter_7_0

		if arg_7_0:GetClientKey("PhotoClick" .. iter_7_0) then
			manager.redPoint:setTip(var_7_0, 0)
		else
			local var_7_1 = GameSetting["skuld_photo" .. iter_7_0].value

			if SkuldSystemData:GetLevelIDIsClear(var_7_1[5]) then
				manager.redPoint:setTip(var_7_0, 1)
			else
				manager.redPoint:setTip(var_7_0, 0)
			end
		end
	end
end

function var_0_0.UpdateSkuldTaskRedPoint(arg_8_0)
	local var_8_0 = ActivityCfg[ActivityConst.ACTIVITY_SKULD_MAIN_TASK]

	for iter_8_0, iter_8_1 in pairs(var_8_0.sub_activity_list) do
		local var_8_1 = ActivityData:GetActivityIsOpen(iter_8_1)

		for iter_8_2, iter_8_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_8_1]) do
			local var_8_2 = RedPointConst.SKULD_SYSTEM_TASK_ITEM .. iter_8_3

			if var_8_1 then
				local var_8_3 = TaskData2:GetTaskProgress(iter_8_3)
				local var_8_4 = AssignmentCfg[iter_8_3]

				if TaskData2:GetTaskComplete(iter_8_3) then
					manager.redPoint:setTip(var_8_2, 0)
				elseif var_8_3 >= var_8_4.need then
					manager.redPoint:setTip(var_8_2, 1)
				else
					manager.redPoint:setTip(var_8_2, 0)
				end
			else
				manager.redPoint:setTip(var_8_2, 0)
			end
		end
	end
end

function var_0_0.UpdateSkuldPointRewardRedPoint(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_MAIN]) do
		local var_9_0 = RedPointConst.SKULD_SYSTEM_TRUST_ITEM .. iter_9_1
		local var_9_1 = ActivityPointRewardCfg[iter_9_1]

		if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id) >= var_9_1.need then
			if arg_9_0:GetPointRewardIsGet(iter_9_1) then
				manager.redPoint:setTip(var_9_0, 0)
			else
				manager.redPoint:setTip(var_9_0, 1)
			end
		else
			manager.redPoint:setTip(var_9_0, 0)
		end
	end
end

function var_0_0.UpdateSkuldFinalOpenRedPoint(arg_10_0)
	local var_10_0 = false

	for iter_10_0, iter_10_1 in pairs(SkuldStageCfg.get_id_list_by_section[9]) do
		if arg_10_0:GetLevelIDIsOpen(iter_10_1) then
			var_10_0 = true

			break
		end
	end

	if var_10_0 then
		if arg_10_0:GetClientKey("EndClick") then
			manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_FINAL_OPEN, 0, RedPointStyle.SHOW_NEW_TAG)
		else
			manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_FINAL_OPEN, 1, RedPointStyle.SHOW_NEW_TAG)
		end
	else
		manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_FINAL_OPEN, 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

function var_0_0.SetData(arg_11_0, arg_11_1)
	arg_11_0.keyList_ = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.client_opt) do
		arg_11_0.keyList_[iter_11_1] = true
	end

	arg_11_0.LevelClearInfoList_ = {}

	for iter_11_2, iter_11_3 in ipairs(arg_11_1.mission_list) do
		arg_11_0.LevelClearInfoList_[iter_11_3.id] = iter_11_3.times
	end

	arg_11_0.getPointRewardList_ = {}

	for iter_11_4, iter_11_5 in ipairs(arg_11_1.reward_list) do
		table.insert(arg_11_0.getPointRewardList_, iter_11_5)
	end

	arg_11_0:UpdateSkuldPointRewardRedPoint()
	arg_11_0:UpdateSkuldFinalOpenRedPoint()
end

function var_0_0.GetLevelIDIsOpen(arg_12_0, arg_12_1)
	local var_12_0 = SkuldStageCfg[arg_12_1]

	for iter_12_0, iter_12_1 in pairs(var_12_0.pre_id) do
		if not arg_12_0:GetLevelIDIsClear(iter_12_1) then
			return false
		end
	end

	return true
end

function var_0_0.GetLevelIDIsClear(arg_13_0, arg_13_1)
	if arg_13_0.LevelClearInfoList_[arg_13_1] and arg_13_0.LevelClearInfoList_[arg_13_1] > 0 then
		return true
	else
		return false
	end
end

function var_0_0.GetLevelIDByStageID(arg_14_0, arg_14_1)
	if arg_14_0.stageIDGetLevelIDList_[arg_14_1] then
		return arg_14_0.stageIDGetLevelIDList_[arg_14_1]
	else
		error(arg_14_1, "没有对应的系统ID")
	end
end

function var_0_0.GetIsShowFrontPop(arg_15_0)
	return arg_15_0.isShowFrontPop_
end

function var_0_0.SetClientKey(arg_16_0, arg_16_1)
	arg_16_0.keyList_[arg_16_1] = true
end

function var_0_0.GetClinetKeyByDefine(arg_17_0, arg_17_1)
	return arg_17_0.keyDefineList_[arg_17_1]
end

function var_0_0.GetClientKey(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.keyDefineList_[arg_18_1]

	if var_18_0 == nil then
		error("SkuldSystemData KeyDefine = nil ,", arg_18_1)
	end

	if arg_18_0.keyList_[var_18_0] then
		return arg_18_0.keyList_[var_18_0]
	else
		return false
	end
end

function var_0_0.GetCurTaskScheduleInfo(arg_19_0)
	local var_19_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_SCHEDULE_TASK]
	local var_19_1 = var_19_0[#var_19_0]

	return TaskData2:GetTaskProgress(var_19_1), AssignmentCfg[var_19_1].need
end

function var_0_0.CacheSkuldIconNum(arg_20_0)
	arg_20_0.cacheIconNum_ = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id)
end

function var_0_0.GetCacheSkuldIconNum(arg_21_0)
	return arg_21_0.cacheIconNum_
end

function var_0_0.PassLevel(arg_22_0, arg_22_1)
	if arg_22_0.LevelClearInfoList_[arg_22_1] then
		arg_22_0.LevelClearInfoList_[arg_22_1] = arg_22_0.LevelClearInfoList_[arg_22_1] + 1
	else
		arg_22_0.LevelClearInfoList_[arg_22_1] = 1
	end

	arg_22_0:UpdateSkuldFinalOpenRedPoint()
end

function var_0_0.GetPointRewardIsGet(arg_23_0, arg_23_1)
	if not arg_23_0.getPointRewardList_ then
		arg_23_0.getPointRewardList_ = {}
	end

	if table.indexof(arg_23_0.getPointRewardList_, arg_23_1) then
		return true
	else
		return false
	end
end

function var_0_0.GetPointReward(arg_24_0, arg_24_1)
	if not arg_24_0.getPointRewardList_ then
		arg_24_0.getPointRewardList_ = {}
	end

	table.insert(arg_24_0.getPointRewardList_, arg_24_1)
end

function var_0_0.CacheStageViewInfo(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_2 then
		arg_25_0.cacheFinalStageViewInfo_ = arg_25_1
	else
		arg_25_0.cacheStageViewInfo_ = arg_25_1
	end
end

function var_0_0.GetCacheStageViewInfo(arg_26_0, arg_26_1)
	if arg_26_1 then
		return arg_26_0.cacheFinalStageViewInfo_
	else
		return arg_26_0.cacheStageViewInfo_
	end
end

return var_0_0
