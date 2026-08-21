local var_0_0 = {}

manager.net:Bind(24043, function(arg_1_0)
	BattleStageData:InitStageArchiveData(arg_1_0.plot_list)
end)
manager.net:Bind(24045, function(arg_2_0)
	BattleStageData:UpdateStageArchiveRedPoint(arg_2_0.plot_list)
end)

function var_0_0.SetStageArchiveRead(arg_3_0)
	manager.net:SendWithLoadingNew(24040, {
		archive_id = arg_3_0
	}, 24041)
end

manager.net:Bind(24009, function(arg_4_0)
	BattleStageData:InitPlotData(arg_4_0.user_chapter_list)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.user_chapter_list) do
		local var_4_0 = iter_4_1.id
		local var_4_1 = getChapterIDByStageID(var_4_0)
		local var_4_2 = ChapterCfg[var_4_1]
		local var_4_3 = BattleStageTools.GetStageCfg(ChapterCfg[var_4_1].type, var_4_0)

		if iter_4_1.clear_times > 0 then
			local var_4_4 = StageTools.GetStageArchiveID(var_4_0)

			if var_4_4 and var_4_4 ~= 0 and not RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_STAGE_ARCHIVE_RANGE + var_4_4) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_CHAPTER_ARCHIVE, var_4_4), 1)
			end
		end

		var_0_0.CheckStageRedPoint(var_4_0)
	end

	TaskRedPoint:UpdateDailyTaskRedTip()
	var_0_0.UpdateRedPoint()
	var_0_0.UpdateSubPlotRedPoint()
end)
manager.net:Bind(24017, function(arg_5_0)
	BattleStageData:InitChapterStarReward(arg_5_0.gain_list)
	var_0_0.UpdateRedPoint()
end)

function var_0_0.GetChapterStarReward(arg_6_0, arg_6_1, arg_6_2)
	manager.net:SendWithLoadingNew(24014, {
		id = arg_6_0,
		treasure_id = arg_6_1
	}, 24015, function(arg_7_0)
		arg_6_2(arg_7_0)
		var_0_0.UpdateChapterRedPoint(arg_6_0)
	end)
end

function var_0_0.ClientModifyThreeStar(arg_8_0, arg_8_1)
	if GameSetting.newbie_unlock_level_id.value[1] == arg_8_0 and BattleStageData:GetStageData()[arg_8_0].clear_times <= 1 then
		ActivityNewbieData:SetNewbieOpenTime(manager.time:GetServerTime())
	end

	BattleStageData:ClientModifyThreeStar(arg_8_0, arg_8_1)

	local var_8_0 = getChapterAndSectionID(arg_8_0)

	var_0_0.UpdateChapterRedPoint(var_8_0)
end

function var_0_0.ClickChapterArchive(arg_9_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_CHAPTER_ARCHIVE, arg_9_0), 0)

	if not RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_STAGE_ARCHIVE_RANGE + arg_9_0) then
		RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_STAGE_ARCHIVE_RANGE + arg_9_0)
	end
end

function var_0_0.UpdateRedPoint()
	for iter_10_0, iter_10_1 in pairs(BattleStageData:GetChapterStarList()) do
		var_0_0.UpdateChapterRedPoint(iter_10_0)
	end

	TaskRedPoint:UpdateChapterPlot19RedTip()
end

function var_0_0.UpdateActivityRedPoint()
	for iter_11_0, iter_11_1 in pairs(BattleStageData:GetStageData()) do
		var_0_0.CheckStageRedPoint(iter_11_0)
	end
end

function var_0_0.CheckStageRedPoint(arg_12_0)
	if BattleStageData:GetStageData()[arg_12_0].clear_times <= 0 then
		local var_12_0 = getChapterIDByStageID(arg_12_0)
		local var_12_1 = ChapterCfg[var_12_0]
		local var_12_2

		if var_12_1.unlock_activity_id ~= 0 then
			var_12_2 = var_12_1.unlock_activity_id
		else
			var_12_2 = var_12_1.activity_id
		end

		local var_12_3 = true

		if var_12_2 == 0 or ActivityTools.GetActivityStatus(var_12_2) ~= 1 then
			var_12_3 = false
		end

		if table.keyof(var_12_1.section_id_list, arg_12_0) == 1 and var_12_3 and var_12_2 and not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_RANGE + var_12_2) and ChapterTools.IsFinishPreChapter(var_12_0) then
			manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(var_12_1.activity_id), var_12_2), 1)
		else
			manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(var_12_1.activity_id), var_12_2), 0)
		end
	end
end

function var_0_0.UpdateSubPlotRedPoint()
	if PlayerData:GetPlayerInfo().userLevel < GameSetting.sub_plot_unlock_level.value[1] then
		return
	end

	for iter_13_0, iter_13_1 in pairs(ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT] or {}) do
		local var_13_0 = ChapterClientCfg[iter_13_1]
		local var_13_1 = var_13_0.show_tag_type == ChapterConst.SHOW_TYPE.LIMIT_TIME
		local var_13_2 = var_13_0.chapter_list

		for iter_13_2, iter_13_3 in pairs(var_13_2) do
			if not ChapterTools.IsClearChapter(iter_13_3) then
				local var_13_3 = ChapterCfg[iter_13_3].section_id_list[1]

				if not ChapterTools.IsClearFirstStage(iter_13_3) and BattleStageData:GetSubPlotRedPointFlag(iter_13_3) ~= 1 and BattleStageData:GetStageData()[var_13_3] then
					local var_13_4 = ChapterCfg[iter_13_3].activity_id
					local var_13_5 = var_13_1 and not ActivityData:GetActivityIsOpen(var_13_4) and 0 or 1

					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, iter_13_3), var_13_5)

					local var_13_6 = ActivityData:GetActivityRefreshTime(var_13_4)

					if var_13_4 ~= 0 and ActivityTools.GetActivityStatus(var_13_4) == 1 and (var_13_6 == 0 or var_13_6 >= manager.time:GetServerTime()) and not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_RANGE + var_13_4) then
						manager.redPoint:setTip(ActivityTools.GetRedPointKey(var_13_4) .. var_13_4, 1)

						break
					end

					if var_13_4 ~= 0 then
						manager.redPoint:setTip(ActivityTools.GetRedPointKey(var_13_4) .. var_13_4, 0)
					end
				end

				break
			end
		end

		var_0_0.UpdateExtraStoryRedPoint(iter_13_1)

		if ChapterConst.NEW_TAG_CLIENT[iter_13_1] and not getData("SUB_PLOT_CHAPTER", "NEW_TAG_" .. iter_13_1) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_POLT_NEW_TAG, iter_13_1), 1, RedPointStyle.SHOW_NEW_TAG)
		end
	end
end

function var_0_0.UpdateExtraStoryRedPoint(arg_14_0)
	local var_14_0 = ChapterClientCfg[arg_14_0]

	if var_14_0.extra_story_unlock_condition ~= "" and isMeetAllCondition(var_14_0.extra_story_unlock_condition) and not RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_EXTRA_STORY_RANGE + arg_14_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, arg_14_0), 1)
	end
end

function var_0_0.ClickSubPlot(arg_15_0)
	local var_15_0 = string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_15_0)

	manager.redPoint:setTip(var_15_0, 0)

	local var_15_1 = ChapterCfg[arg_15_0].activity_id

	if var_15_1 ~= 0 then
		RedPointAction.HandleRedPoint(RedPointConst.ACTIVITY_RANGE + var_15_1)
		manager.redPoint:setTip(ActivityTools.GetRedPointKey(var_15_1) .. var_15_1, 0)
	end

	BattleStageData:SetSubPlotRedPointFlag(arg_15_0)
end

function var_0_0.ClickSubPlotExtraStory(arg_16_0)
	local var_16_0 = string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, arg_16_0)

	manager.redPoint:setTip(var_16_0, 0)

	local var_16_1 = ChapterClientCfg[arg_16_0]

	if var_16_1.extra_story_unlock_condition ~= "" and isMeetAllCondition(var_16_1.extra_story_unlock_condition) and not RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_EXTRA_STORY_RANGE + arg_16_0) then
		RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_EXTRA_STORY_RANGE + arg_16_0)
	end
end

function var_0_0.UpdateChapterRedPoint(arg_17_0)
	if not ChapterTools.IsFinishPreChapter(arg_17_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, arg_17_0), 0)

		return
	end

	local var_17_0 = getChapterClientCfgByChapterID(arg_17_0)

	if var_17_0 == nil then
		return
	end

	local var_17_1 = var_17_0.id

	if getChapterToggle(var_17_1) == BattleConst.TOGGLE.PLOT then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, arg_17_0), BattleStageData:GetChapterRedPointNotice(arg_17_0) and 1 or 0)
	end
end

local var_0_1

function var_0_0.AddActivityTimer()
	var_0_0.UpdateRedPoint()

	local var_18_0 = ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT]
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_2 = ChapterCfg[iter_18_1].activity_id

		if var_18_2 ~= 0 then
			var_18_1[var_18_2] = ActivityData:GetActivityData(var_18_2):IsActivitying()
		end
	end

	var_0_1 = Timer.New(function()
		local var_19_0 = false

		for iter_19_0, iter_19_1 in pairs(var_18_1) do
			local var_19_1 = ActivityData:GetActivityData(iter_19_0):IsActivitying()

			if iter_19_1 ~= var_19_1 then
				var_18_1[iter_19_0] = var_19_1
				var_19_0 = true
			end
		end

		if var_19_0 then
			var_0_0.UpdateRedPoint()
		end
	end, 1, -1)

	var_0_1:Start()
end

function var_0_0.RemoveActivityTimer()
	if var_0_1 then
		var_0_1:Stop()

		var_0_1 = nil
	end
end

manager.net:Bind(24029, function(arg_21_0)
	BattleStageData:InitMapLocation(arg_21_0)
end)

function var_0_0.ScanClueLocation(arg_22_0, arg_22_1)
	manager.net:SendWithLoadingNew(24030, {
		map_id = arg_22_0
	}, 24031, function(arg_23_0)
		if isSuccess(arg_23_0.result) then
			for iter_23_0, iter_23_1 in ipairs(arg_23_0.location_id_list) do
				BattleStageData:ScanClueLocationData(arg_22_0, iter_23_1)
			end

			arg_22_1(arg_23_0)
		else
			ShowTips(arg_23_0.result)
		end
	end)
end

function var_0_0.GetClueLocation(arg_24_0)
	manager.net:Push(24032, {
		location_id = arg_24_0
	})
end

manager.net:Bind(24033, function(arg_25_0)
	if isSuccess(arg_25_0.result) then
		local var_25_0 = arg_25_0.clue_location.location_id
		local var_25_1 = arg_25_0.clue_location.clue_id
		local var_25_2 = arg_25_0.map_id

		BattleStageData:UpdateClueLocationData(var_25_2, var_25_0, var_25_1)
		manager.notify:Invoke(CHAPTER_GET_CLUE, var_25_0)
	else
		ShowTips(arg_25_0.result)
	end
end)

function var_0_0.UpdateLocationEvent(arg_26_0)
	if BattleStageData:HasReadLocationEvent(arg_26_0) then
		return
	end

	manager.net:Push(24034, {
		event_id = arg_26_0
	})
	BattleStageData:UpdateLocationEvent(arg_26_0)
end

function var_0_0.OperateChapterDay(arg_27_0, arg_27_1, arg_27_2)
	manager.net:Push(24036, {
		detector_info = {
			status = 1,
			chapter_id = arg_27_0,
			day = arg_27_1
		}
	})
	BattleStageData:SetOperateChapterDay(arg_27_0, arg_27_1)
	arg_27_2()
end

function var_0_0.ReadLoacationClue(arg_28_0, arg_28_1, arg_28_2)
	if ChapterTools.IsReadClue(arg_28_0, arg_28_1) then
		return
	end

	manager.net:Push(24038, {
		clue_id = arg_28_2
	})
	BattleStageData:UpdateClueLocationData(arg_28_0, arg_28_1, arg_28_2)
end

function var_0_0.OperationRush(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	local var_29_0 = BattleStageFactory.Produce(arg_29_2, arg_29_1, arg_29_4)

	var_29_0:SetMultiple(arg_29_3)

	local var_29_1 = var_29_0:GetType()
	local var_29_2 = var_29_0:GetDest()
	local var_29_3 = var_29_0:GetMultiple()
	local var_29_4 = var_29_0:GetType()
	local var_29_5, var_29_6 = var_29_0:GetHeroTeam()
	local var_29_7 = var_29_0:GetAssistHeroOwnerList()
	local var_29_8 = clone(var_29_5)
	local var_29_9 = clone(var_29_6)

	for iter_29_0 = #var_29_8, 1, -1 do
		if var_29_8[iter_29_0] == 0 then
			table.remove(var_29_8, iter_29_0)
			table.remove(var_29_9, iter_29_0)
		end
	end

	for iter_29_1 = 1, 2 do
		for iter_29_2 = iter_29_1 + 1, 3 do
			if var_29_8[iter_29_1] and var_29_8[iter_29_2] and var_29_8[iter_29_1] ~= 0 and var_29_8[iter_29_1] == var_29_8[iter_29_2] then
				ShowTips("TEAM_REPEAT_HERO")

				return
			end
		end
	end

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == var_29_4 or BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == var_29_4 then
		var_29_8 = var_29_0:GetSystemHeroTeam()

		local var_29_10 = var_29_8
	end

	local var_29_11 = var_29_0:GetComboSkillID() or 0
	local var_29_12 = var_29_0:GetComboSkillLevel() or 0
	local var_29_13 = var_29_0:GetSystemHeroTeam()
	local var_29_14 = {}

	for iter_29_3, iter_29_4 in ipairs(var_29_8) do
		var_29_14[iter_29_3] = {}

		if var_29_6[iter_29_3] ~= 0 and var_29_6[iter_29_3] ~= nil then
			var_29_14[iter_29_3].hero_type = 2
			var_29_14[iter_29_3].owner_id = BattleTeamData.NO_OWNER
			var_29_14[iter_29_3].hero_id = var_29_6[iter_29_3]
		elseif var_29_13[iter_29_3] ~= 0 and var_29_13[iter_29_3] ~= nil then
			var_29_14[iter_29_3].hero_type = 2
			var_29_14[iter_29_3].owner_id = BattleTeamData.NO_OWNER
			var_29_14[iter_29_3].hero_id = var_29_13[iter_29_3]
		else
			var_29_14[iter_29_3].hero_id = var_29_8[iter_29_3]
			var_29_14[iter_29_3].owner_id = var_29_7[iter_29_3] or BattleTeamData.NO_OWNER
			var_29_14[iter_29_3].hero_type = not BattleTeamData.IsValidOwner(var_29_14[iter_29_3].owner_id) and 1 or 3
		end
	end

	local var_29_15 = {
		common_info = {
			hero_list = var_29_14,
			dest = var_29_2,
			activity_id = var_29_0:GetActivityID() or 0,
			battle_times = var_29_3,
			type = var_29_4,
			index = var_29_0:GetServerExtant(),
			cooperate_unique_skill_id = var_29_11,
			cooperate_unique_skill_level = var_29_12,
			battle_vs = LuaForUtil.GetBattleVersion(),
			mimir_info = {
				{
					mimir_id = var_29_0:GetChipManagerID(),
					chip_list = var_29_0:GetChipList(),
					hero_id = var_29_0:GetCharChipBaseID(),
					hero_chip_list = var_29_0:GetCharChipExtraIDList()
				}
			}
		},
		chapter_id = arg_29_0
	}
	local var_29_16 = GetOldPlayerExp()

	manager.net:SendWithLoadingNew(54038, var_29_15, 54039, function(arg_30_0, arg_30_1)
		if isSuccess(arg_30_0.result) then
			if arg_29_5 then
				arg_29_5()
			end

			BattleController.GetInstance():SetBattleStageData(var_29_0)
			BattleFieldData:FinishBattle(arg_30_0)

			local var_30_0 = BattleTeamPlayerTemplate.New(arg_30_0.player_info)

			BattleController.GetInstance():UpdateHeroTeam(var_30_0)

			local var_30_1, var_30_2 = CollectHeroExpChange(var_29_0)
			local var_30_3, var_30_4 = var_29_0:GetHeroTeam()
			local var_30_5 = var_29_0:GetSystemHeroTeam()
			local var_30_6 = var_29_0:GetAssistHeroOwnerList()
			local var_30_7 = var_29_0:GetMultiple()
			local var_30_8 = arg_30_0.battle_result
			local var_30_9 = var_30_8.clear_times * GameSetting.mastery_gain.value[1]

			for iter_30_0 = 1, #var_30_3 do
				local var_30_10 = var_29_0:GetHeroDataByPos(iter_30_0)
				local var_30_11 = not var_30_5[iter_30_0] and (var_30_4[iter_30_0] == 0 or table.isEmpty(var_30_4)) and (var_30_6 and (var_30_6[iter_30_0] == "0" or var_30_6[iter_30_0] ~= "0" and var_30_6[iter_30_0] == PlayerData:GetPlayerInfo().userID) or table.isEmpty(var_30_6))

				if var_30_10 and var_30_11 then
					HeroData:HeroClearTimesModify(var_30_3[iter_30_0], var_30_9)

					local var_30_12 = HeroTools.GetHeroOntologyID(var_30_3[iter_30_0])

					ArchiveData:AddExp(var_30_12, GameSetting.hero_love_exp_gain.value[1] * var_30_7)
				end
			end

			HeroAction.UpdateHeartRedPoint()
			HeroAction.UpdateStoryRedPoint()
			HeroAction.UpdateSuperStoryRedPoint()

			local var_30_13 = {}
			local var_30_14 = {}
			local var_30_15 = {}

			for iter_30_1, iter_30_2 in ipairs(arg_30_0.battle_result.all_drop_list) do
				local var_30_16 = {}
				local var_30_17 = {}

				for iter_30_3, iter_30_4 in ipairs(iter_30_2.gain_list) do
					var_30_16[iter_30_3] = {
						id = iter_30_4.id,
						num = iter_30_4.num
					}
				end

				if iter_30_2.extra_list then
					for iter_30_5, iter_30_6 in ipairs(iter_30_2.extra_list) do
						var_30_17[iter_30_5] = {
							id = iter_30_6.id,
							num = iter_30_6.num
						}
					end
				end

				var_30_15[iter_30_1] = {
					battleTimes = iter_30_2.battle_times,
					rewardItems = var_30_16,
					extraReward = var_30_17
				}
			end

			for iter_30_7, iter_30_8 in ipairs(var_30_15) do
				var_30_13[iter_30_8.battleTimes] = {}
				var_30_14[iter_30_8.battleTimes] = {}

				for iter_30_9, iter_30_10 in ipairs(iter_30_8.rewardItems) do
					table.insert(var_30_13[iter_30_8.battleTimes], {
						iter_30_10.id,
						iter_30_10.num
					})
				end

				for iter_30_11, iter_30_12 in ipairs(iter_30_8.extraReward) do
					table.insert(var_30_14[iter_30_8.battleTimes], {
						iter_30_12.id,
						iter_30_12.num
					})
				end
			end

			if var_29_4 == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL then
				local var_30_18 = ActivityPtRouletteStageCfg[var_29_2].cost[1]

				if var_30_18 and var_30_18 ~= CurrencyConst.CURRENCY_TYPE_VITALITY then
					-- block empty
				else
					ActivityPtScrollData:AddClearTime(var_29_0:GetActivityID(), var_29_0:GetMultiple())
				end

				ActivityPtScrollData:SetClearList(var_29_0:GetActivityID(), var_29_0:GetStageId())
			end

			JumpTools.OpenPageByJump("operationRushAniView", {
				callBack = function()
					JumpTools.Back()
					JumpTools.OpenPageByJump("/operationRushResultView", {
						chapterID = arg_29_0,
						destID = var_29_2,
						stageID = arg_29_1,
						rewardList = var_30_13,
						extraReward = var_30_14,
						stageData = var_29_0,
						multiple = var_30_7,
						activityID = arg_29_4,
						battleResult = {
							challengedNumber = var_30_8.clear_times,
							clear_times = var_30_8.clear_times,
							oldPlayerEXPInfo = var_29_16,
							heroDataCollect = var_30_1
						}
					})
				end
			})
			CheckBattleResultNeedAddHeroExp()
		else
			ShowTips(arg_30_0.result)
		end
	end)
end

return var_0_0
