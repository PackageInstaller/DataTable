local var_0_0 = {
	StageIsCleared = function(arg_1_0)
		local var_1_0 = BattleStageData:GetStageData()

		return var_1_0[arg_1_0] and var_1_0[arg_1_0].clear_times > 0
	end,
	GetBossChallengeNextIndex = function(arg_2_0)
		local var_2_0 = BattleBossChallengeNormalData:GetFinishIndex(arg_2_0)
		local var_2_1 = BattleBossChallengeNormalData:GetBossChallengeCfg()

		if var_2_0 > var_2_1.level_amount then
			return var_2_1.level_amount
		end

		return var_2_0
	end
}

function var_0_0.GetAutoChapter(arg_3_0, arg_3_1)
	if BattleStageData:GetStageData()[arg_3_1].clear_times == 1 then
		return var_0_0.GetNextChapter(arg_3_0, arg_3_1)
	end

	return arg_3_0
end

function var_0_0.GetNextChapter(arg_4_0, arg_4_1)
	local var_4_0 = ChapterCfg[arg_4_0]
	local var_4_1 = var_4_0.section_id_list

	if var_4_1[#var_4_1] == arg_4_1 then
		local var_4_2 = getChapterListByDifficulty(var_4_0.type, var_4_0.difficulty)
		local var_4_3 = table.keyof(var_4_2, arg_4_0)

		if var_4_3 < #var_4_2 then
			local var_4_4 = var_4_2[var_4_3 + 1]

			if ChapterTools.IsFinishPreChapter(var_4_4) and ChapterTools.IsUnlockChapter(var_4_4) then
				return var_4_4
			end
		end
	end

	return arg_4_0
end

function var_0_0.GetChapterNextStageID(arg_5_0, arg_5_1)
	local var_5_0 = BattleChapterStageCfg[arg_5_1]

	if var_5_0 then
		local var_5_1 = var_5_0.next_stage_id

		if var_5_1 then
			if var_5_1 <= -1 then
				return
			end

			if var_5_1 ~= 0 then
				return var_5_1
			end
		end

		local var_5_2 = var_5_0.next_unlock_id_list

		if var_5_2 and type(var_5_2) == "table" and #var_5_2 > 0 then
			local var_5_3 = var_5_2[1]

			if var_5_3 ~= 0 then
				return var_5_3
			end
		end
	end

	local var_5_4 = ChapterCfg[arg_5_0].section_id_list
	local var_5_5 = table.keyof(var_5_4, arg_5_1)

	if var_5_5 < #var_5_4 then
		local var_5_6 = var_5_4[var_5_5 + 1]

		if var_5_6 == GameSetting.travel_skuld_new_ending_stage_id.value[1] and BattleStageData:GetStageData()[var_5_6].clear_times < 1 then
			return
		end

		return var_5_6
	end
end

function var_0_0.GetActivityStoryNextStageID(arg_6_0, arg_6_1)
	local var_6_0 = ActivityStoryChapterCfg[arg_6_0].activity_id
	local var_6_1 = ActivityData:GetActivityData(var_6_0)
	local var_6_2 = manager.time:GetServerTime()

	if var_6_2 < var_6_1.startTime or var_6_2 > var_6_1.stopTime then
		return
	end

	if var_6_0 == ActivityConst.OSIRIS_STROY then
		return var_0_0.GetOsirisNextStage(arg_6_0, arg_6_1)
	end
end

function var_0_0.GetOsirisNextStage(arg_7_0, arg_7_1, arg_7_2)
	if StoryStageActivityData:GetStageData(arg_7_1)[arg_7_2] then
		local var_7_0

		for iter_7_0, iter_7_1 in pairs(GameSetting.activity_plot_unlock.value) do
			if iter_7_1[1][1] == arg_7_1 and iter_7_1[1][2] == arg_7_2 then
				var_7_0 = iter_7_1[2][1]
			end
		end

		local var_7_1 = 100

		if var_7_0 then
			var_7_1 = ChessTools.GetChapterProgress(var_7_0)
		end

		if var_7_1 < 100 then
			return
		end

		local var_7_2 = ActivityStoryChapterCfg[arg_7_1].stage_list
		local var_7_3 = table.keyof(var_7_2, arg_7_2)

		if var_7_3 < #var_7_2 then
			return var_7_2[var_7_3 + 1]
		end
	end
end

function var_0_0.CalcBossChallengeStar()
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(BattleBossChallengeNormalData:GetThreeStarList()) do
		for iter_8_2, iter_8_3 in ipairs(iter_8_1) do
			if iter_8_3 == 1 then
				var_8_0 = var_8_0 + 1
			end
		end
	end

	return var_8_0
end

function var_0_0.NeedShowContinueBattleWindow(arg_9_0, arg_9_1)
	local var_9_0 = BattleStageTools.GetStageCfg(arg_9_0, arg_9_1)

	if var_9_0.auto_next_stage_group == 0 then
		return false
	end

	local var_9_1, var_9_2 = var_0_0.GetContinueBattleCost(arg_9_0, arg_9_1)

	if var_9_2 <= 1 then
		return false
	end

	if var_9_0.auto_next_stage_group <= 10 then
		return true
	else
		local var_9_3 = var_9_1[1].id

		if ItemTools.getItemNum(var_9_3) < var_9_1[1].num then
			return true
		end
	end

	return false
end

function var_0_0.GetContinueBattleCost(arg_10_0, arg_10_1)
	local var_10_0 = var_0_0.GetContinueBattleStageList(arg_10_0, arg_10_1)
	local var_10_1 = {}
	local var_10_2 = BattleStageTools.GetStageCfg(arg_10_0, arg_10_1)

	if type(var_10_2.extra_cost) == "table" and var_10_2.extra_cost[1] then
		table.insert(var_10_1, {
			var_10_2.extra_cost[1],
			0
		})
	else
		table.insert(var_10_1, {
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			0
		})
	end

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_3 = BattleStageData:GetStageData()[iter_10_1]
		local var_10_4 = BattleStageTools.GetStageCfg(arg_10_0, iter_10_1)

		if not var_10_3 or not (var_10_3.clear_times > 0) then
			if type(var_10_4.extra_cost) == "table" and var_10_4.extra_cost[1] then
				table.insert(var_10_1, clone(var_10_4.extra_cost))
			else
				table.insert(var_10_1, {
					CurrencyConst.CURRENCY_TYPE_VITALITY,
					var_10_4.cost
				})
			end
		end
	end

	local var_10_5 = formatRewardCfgList(var_10_1)

	return mergeReward(var_10_5), #var_10_0
end

function var_0_0.GetContinueBattleStageList(arg_11_0, arg_11_1)
	local var_11_0 = BattleStageTools.GetStageCfg(arg_11_0, arg_11_1)
	local var_11_1 = arg_11_1
	local var_11_2 = {}
	local var_11_3 = var_11_0.auto_next_stage_group

	while var_11_3 ~= 0 and var_11_0.auto_next_stage_group == var_11_3 do
		table.insert(var_11_2, var_11_1)

		local var_11_4 = getChapterIDByStageID(var_11_1)

		var_11_1 = var_0_0.GetChapterNextStageID(var_11_4, var_11_1)

		if var_11_1 then
			var_11_0 = BattleStageTools.GetStageCfg(arg_11_0, var_11_1)
		else
			break
		end
	end

	return var_11_2
end

function var_0_0.HasStageCost(arg_12_0, arg_12_1)
	local var_12_0 = BattleStageTools.GetStageCfg(arg_12_0, arg_12_1)
	local var_12_1 = BattleStageData:GetStageData()[arg_12_1]
	local var_12_2 = 0
	local var_12_3 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)

	if not var_12_1 or not (var_12_1.clear_times > 0) then
		if type(var_12_0.extra_cost) == "table" and var_12_0.extra_cost[1] then
			return ItemTools.getItemNum(var_12_0.extra_cost[1]) >= var_12_0.extra_cost[2]
		else
			return var_12_3 >= var_12_0.cost
		end
	end

	return true
end

function var_0_0.IsLockStage(arg_13_0, arg_13_1)
	if not ChapterTools.IsFinishPreChapter(arg_13_0) then
		return true
	end

	if arg_13_1 then
		local var_13_0 = BattleStageTools.GetStageCfg(ChapterCfg[arg_13_0].type, arg_13_1)

		if not ActivityData:GetActivityIsOpen(ChapterCfg[arg_13_0].activity_id) then
			return PlayerData:GetPlayerInfo().userLevel < var_13_0.level
		end
	end

	return false
end

function var_0_0.IsLockSubChapterStage(arg_14_0, arg_14_1)
	local var_14_0 = false

	for iter_14_0, iter_14_1 in pairs(GameSetting.sub_plot_unlock.value) do
		if iter_14_1[1][1] == arg_14_0 and iter_14_1[1][2] == arg_14_1 then
			for iter_14_2, iter_14_3 in ipairs(iter_14_1[2]) do
				if ChessTools.GetChapterProgress(iter_14_3) < 100 then
					return true
				end
			end

			return false
		end
	end

	return false
end

function var_0_0.IsStageFirstClear(arg_15_0)
	local var_15_0 = BattleStageData:GetStageData()[arg_15_0]

	return var_15_0 and var_15_0.clear_times == 1
end

function var_0_0.GetStageArchiveID(arg_16_0)
	local var_16_0 = StageArchiveCfg.get_id_list_by_unlock_by_stage_id[arg_16_0]

	if var_16_0 then
		return var_16_0[1]
	else
		return 0
	end
end

var_0_0.stageArchiveChapterDic = {}

function var_0_0.InitStageArchiveCfg()
	for iter_17_0, iter_17_1 in ipairs(StageArchivesCollectCfg.all) do
		local var_17_0 = StageArchivesCollectCfg[iter_17_1].chapter_id

		for iter_17_2, iter_17_3 in ipairs(var_17_0) do
			var_0_0.stageArchiveChapterDic[iter_17_3] = var_0_0.stageArchiveChapterDic[iter_17_3] or {}

			table.insert(var_0_0.stageArchiveChapterDic[iter_17_3], iter_17_1)
		end
	end
end

function var_0_0.GetStageArchiveIDListByChapterID(arg_18_0)
	return var_0_0.stageArchiveChapterDic[arg_18_0] or {}
end

function var_0_0.IsNeedStageArchiveEntrace(arg_19_0)
	return #var_0_0.GetStageArchiveIDListByChapterID(arg_19_0) > 0
end

function var_0_0.GetUnlockStageArchiveList(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = var_0_0.GetStageArchiveIDListByChapterID(arg_20_0)

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		if var_0_0.IsStageArchiveUnLock(iter_20_1) then
			var_20_0[#var_20_0 + 1] = iter_20_1
		end
	end

	return var_20_0
end

function var_0_0.IsStageArchiveUnLock(arg_21_0)
	return BattleStageData:IsStageArchiveUnlock(arg_21_0)
end

function var_0_0.ReorderStageArchiveListByGroup(arg_22_0)
	local var_22_0 = {}
	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_0) do
		local var_22_2 = StageArchivesCollectCfg[iter_22_1].tag_id

		var_22_0[var_22_2] = var_22_0[var_22_2] or {}

		table.insert(var_22_0[var_22_2], iter_22_1)
	end

	for iter_22_2, iter_22_3 in pairs(var_22_0) do
		var_22_1[#var_22_1 + 1] = iter_22_2
	end

	table.sort(var_22_1, function(arg_23_0, arg_23_1)
		return arg_23_0 < arg_23_1
	end)

	local var_22_3 = {}

	for iter_22_4, iter_22_5 in ipairs(var_22_1) do
		table.sort(var_22_0[iter_22_5], function(arg_24_0, arg_24_1)
			return arg_24_0 < arg_24_1
		end)

		var_22_3[iter_22_5] = var_22_0[iter_22_5]
	end

	return var_22_1, var_22_3
end

function var_0_0.OpenStageArchiveInfo(arg_25_0)
	local var_25_0 = StageArchivesCollectCfg[arg_25_0]

	if var_25_0.archive_type == StageConst.STAGE_ARCHIVE_TAG_TYPE.PICTURE_TEXT then
		JumpTools.OpenPageByJump("stageArchivePictureInfo", {
			archiveID = arg_25_0
		})
	elseif var_25_0.archive_type == StageConst.STAGE_ARCHIVE_TAG_TYPE.TEXT then
		JumpTools.OpenPageByJump("gameHelpLong", {
			title = var_25_0.name,
			content = formatText(var_25_0.desc)
		})
	elseif var_25_0.archive_type == StageConst.STAGE_ARCHIVE_TAG_TYPE.STORY then
		local var_25_1 = var_25_0.archive_parameter

		manager.story:StartStory(var_25_1)
	elseif var_25_0.archive_type == StageConst.STAGE_ARCHIVE_TAG_TYPE.MOMO_TALK then
		JumpTools.OpenPageByJump("stageArchiveMomoTalk", {
			archiveID = arg_25_0
		})
	else
		Debug.LogError("undefine stage archive: " .. arg_25_0)
	end
end

function var_0_0.IsArchiveMomotalkPlayed(arg_26_0)
	if not arg_26_0 then
		return false
	end

	return getData(string.format("stage_archive_momotalk_%d", arg_26_0), "played") == true
end

function var_0_0.SetArchiveMomotalkPlayed(arg_27_0)
	if not arg_27_0 then
		return false
	end

	saveData(string.format("stage_archive_momotalk_%d", arg_27_0), "played", true)
end

function var_0_0.IsHavedStageArchiveRedInChapter(arg_28_0)
	local var_28_0 = var_0_0.GetStageArchiveIDListByChapterID(arg_28_0)
	local var_28_1 = false

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		if var_0_0.IsStageArchiveUnLock(iter_28_1) then
			var_28_1 = var_0_0.IsHaveRedStageArchive(iter_28_1)

			if var_28_1 then
				break
			end
		end
	end

	return var_28_1
end

function var_0_0.IsHaveRedStageArchive(arg_29_0)
	return BattleStageData:GetStageArchiveRedState(arg_29_0)
end

return var_0_0
