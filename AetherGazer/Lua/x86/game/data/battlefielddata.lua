local var_0_0 = singletonClass("BattleFieldData")

function var_0_0.Init(arg_1_0)
	arg_1_0.currentSelectHeroID_ = 0
	arg_1_0.trialID_ = 0
	arg_1_0.cacheChapter_ = {}
	arg_1_0.cacheToggle_ = {}
	arg_1_0.cacheStage_ = {}
	arg_1_0.secondCacheStage_ = {}
	arg_1_0.clientIDAndStage_ = {}
	arg_1_0.chapterMapDayList_ = {}
	arg_1_0.chapterMapIDList_ = {}
	arg_1_0.chapterLocationList_ = {}
	arg_1_0.serverBattleID_ = nil
	arg_1_0.battleServerIP_ = nil
	arg_1_0.battleServerPort_ = nil
	arg_1_0.battleResultData_ = {}
end

function var_0_0.GetCurrentSelectHeroID(arg_2_0)
	return arg_2_0.currentSelectHeroID_, arg_2_0.trialID_
end

function var_0_0.SetCurrentSelectHeroData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.currentSelectHeroID_ = arg_3_1
	arg_3_0.trialID_ = arg_3_2
end

function var_0_0.SetCacheChapterClient(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 and arg_4_0.cacheToggle_[arg_4_1] ~= arg_4_2 then
		arg_4_0.cacheToggle_[arg_4_1] = arg_4_2

		saveData("BattleField", "toggle_" .. arg_4_1, arg_4_2)
	end
end

function var_0_0.GetCacheChapterClient(arg_5_0, arg_5_1)
	local var_5_0 = ChapterClientCfg.get_id_list_by_toggle[arg_5_1][1]

	for iter_5_0, iter_5_1 in ipairs(ChapterClientCfg.get_id_list_by_toggle[arg_5_1]) do
		if not ChapterTools.IsChapterSystemLock(iter_5_1) then
			var_5_0 = iter_5_1

			break
		end
	end

	local var_5_1 = getData("BattleField", "toggle_" .. arg_5_1)

	if ChapterClientCfg[var_5_1] == nil then
		return var_5_0
	end

	local var_5_2 = true

	if var_5_1 and ChapterClientCfg[var_5_1].show_tag_type == ChapterConst.SHOW_TYPE.LIMIT_TIME then
		var_5_2 = ActivityData:GetActivityIsOpen(ChapterCfg[ChapterClientCfg[var_5_1].chapter_list[1]].activity_id)
	end

	if var_5_1 and (ChapterTools.IsChapterSystemLock(var_5_1) or not var_5_2) then
		saveData("BattleField", "toggle_" .. arg_5_1, nil)
	end

	local var_5_3 = arg_5_0.cacheToggle_[arg_5_1] or getData("BattleField", "toggle_" .. arg_5_1) or arg_5_1 == BattleConst.TOGGLE.PLOT and ChapterTools.GetOptimalChapterClientID(true) or arg_5_1 == BattleConst.TOGGLE.SUB_PLOT and ChapterTools.GetOpenSubPlotClient() or arg_5_1 == BattleConst.TOGGLE.RESIDENT_ACT and var_5_0 or var_5_0

	if ChapterClientCfg[var_5_3] == nil then
		var_5_3 = var_5_0
	end

	return var_5_3
end

function var_0_0.SetCacheChapter(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 and arg_6_0.cacheChapter_[arg_6_1] ~= arg_6_2 then
		arg_6_0.cacheChapter_[arg_6_1] = arg_6_2

		saveData("BattleField", "chapterClientID_" .. arg_6_1, arg_6_2)
	end
end

function var_0_0.GetCacheChapter(arg_7_0, arg_7_1)
	return arg_7_0.cacheChapter_[arg_7_1] or getData("BattleField", "chapterClientID_" .. arg_7_1) or ChapterClientCfg[arg_7_1].chapter_list[1]
end

function var_0_0.SetSecondCacheChapter(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = string.format("secondChapterID_%s_%s", arg_8_3, arg_8_1)

	if arg_8_2 and arg_8_0.secondCacheStage_[var_8_0] ~= arg_8_2 then
		arg_8_0.secondCacheStage_[var_8_0] = arg_8_2

		saveData("BattleField", var_8_0, arg_8_2)
	end
end

function var_0_0.GetSecondCacheChapter(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = string.format("secondChapterID_%s_%s", arg_9_2, arg_9_1)

	return arg_9_0.secondCacheStage_[var_9_0] or getData("BattleField", var_9_0)
end

function var_0_0.SetCacheStage(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.cacheStage_[arg_10_1] ~= arg_10_2 then
		arg_10_0.cacheStage_[arg_10_1] = arg_10_2

		saveData("BattleField", "chapterID" .. arg_10_1, arg_10_2)
	end
end

function var_0_0.GetCacheStage(arg_11_0, arg_11_1)
	if arg_11_1 then
		return arg_11_0.cacheStage_[arg_11_1] or getData("BattleField", "chapterID" .. arg_11_1)
	end
end

function var_0_0.GetStageByClientID(arg_12_0, arg_12_1)
	if arg_12_1 then
		return arg_12_0.clientIDAndStage_[arg_12_1] or getData("BattleField", "clientID" .. arg_12_1)
	end
end

function var_0_0.SetStageByClientID(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.clientIDAndStage_[arg_13_1] ~= arg_13_2 then
		arg_13_0.clientIDAndStage_[arg_13_1] = arg_13_2

		saveData("BattleField", "clientID" .. arg_13_1, arg_13_2)
	end
end

function var_0_0.GetPlotHardLevel(arg_14_0)
	local var_14_0 = arg_14_0:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)
	local var_14_1 = arg_14_0:GetCacheChapter(var_14_0)

	return ChapterCfg[var_14_1].difficulty
end

function var_0_0.ChangePlotHardLevel(arg_15_0, arg_15_1)
	local var_15_0 = BattleConst.TOGGLE.PLOT
	local var_15_1 = arg_15_0:GetCacheChapterClient(var_15_0)
	local var_15_2 = ChapterClientCfg[var_15_1].chapter_list[1]
	local var_15_3 = ChapterCfg[var_15_2].sub_type
	local var_15_4 = getChapterList()
	local var_15_5 = getChapterClientList()[arg_15_1]

	for iter_15_0 = var_15_3, 1, -1 do
		if var_15_4[iter_15_0][arg_15_1] then
			local var_15_6 = var_15_4[iter_15_0][arg_15_1][1]
			local var_15_7 = getChapterClientCfgByChapterID(var_15_6).id

			if table.keyof(var_15_5, var_15_7) then
				arg_15_0:SetCacheChapterClient(var_15_0, var_15_7)

				return
			end
		end
	end

	for iter_15_1 = var_15_3 + 1, #getChapterClientList()[ChapterCfg[var_15_2].difficulty] do
		if var_15_4[iter_15_1][arg_15_1] then
			local var_15_8 = var_15_4[iter_15_1][arg_15_1][1]
			local var_15_9 = getChapterClientCfgByChapterID(var_15_8).id

			if table.keyof(var_15_5, var_15_9) then
				arg_15_0:SetCacheChapterClient(var_15_0, var_15_9)

				return
			end
		end
	end
end

function var_0_0.SaveChapterMapDay(arg_16_0, arg_16_1, arg_16_2)
	saveData("BattleField", string.format("chapterID_%s_day", arg_16_1), arg_16_2)

	arg_16_0.chapterMapDayList_[arg_16_1] = arg_16_2
end

function var_0_0.GetChapterMapDay(arg_17_0, arg_17_1)
	return arg_17_0.chapterMapDayList_[arg_17_1] or getData("BattleField", string.format("chapterID_%s_day", arg_17_1)) or ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id[arg_17_1][1]].day
end

function var_0_0.SaveChapterMapID(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	saveData("BattleField", string.format("chapterID_%s_day_%s_mapID", arg_18_1, arg_18_2), arg_18_3)

	if arg_18_0.chapterMapIDList_[arg_18_1] == nil then
		arg_18_0.chapterMapIDList_[arg_18_1] = {}
	end

	arg_18_0.chapterMapIDList_[arg_18_1][arg_18_2] = arg_18_3
end

function var_0_0.GetChapterMapID(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0

	if arg_19_0.chapterMapIDList_[arg_19_1] == nil then
		var_19_0 = saveData("BattleField", string.format("chapterID_%s_day_%s_mapID", arg_19_1, arg_19_2), var_19_0)
	else
		var_19_0 = arg_19_0.chapterMapIDList_[arg_19_1][arg_19_2]
	end

	if var_19_0 == nil then
		var_19_0 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_19_1][arg_19_2][1]
	end

	return var_19_0
end

function var_0_0.SetChapterLocationID(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0.chapterLocationList_[arg_20_1] = arg_20_2
end

function var_0_0.GetChapterLocationID(arg_21_0, arg_21_1)
	return arg_21_0.chapterLocationList_[arg_21_1]
end

function var_0_0.SetServerBattleParams(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_0.serverBattleID_ = arg_22_1
	arg_22_0.battleServerIP_ = arg_22_2
	arg_22_0.battleServerPort_ = arg_22_3
	arg_22_0.isInBattle_ = true
end

function var_0_0.FinishBattle(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.battle_result

	arg_23_0.isInBattle_ = false

	local var_23_1 = {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0.star_list) do
		var_23_1[iter_23_0] = {
			starID = iter_23_1.star_id,
			isComplete = iter_23_1.is_achieve
		}
	end

	local var_23_2 = {}

	for iter_23_2, iter_23_3 in ipairs(var_23_0.all_drop_list) do
		local var_23_3 = {}
		local var_23_4 = {}

		for iter_23_4, iter_23_5 in ipairs(iter_23_3.gain_list) do
			var_23_3[iter_23_4] = {
				id = iter_23_5.id,
				num = iter_23_5.num
			}
		end

		if iter_23_3.extra_list then
			for iter_23_6, iter_23_7 in ipairs(iter_23_3.extra_list) do
				var_23_4[iter_23_6] = {
					id = iter_23_7.id,
					num = iter_23_7.num
				}
			end
		end

		var_23_2[iter_23_2] = {
			battleTimes = iter_23_3.battle_times,
			rewardItems = var_23_3,
			extraReward = var_23_4
		}
	end

	arg_23_0.battleResultData_ = {
		serverBattleID = var_23_0.dest,
		cleanTimes = var_23_0.clear_times,
		targetTimes = var_23_0.target_times,
		starList = var_23_1,
		dropList = var_23_2,
		useSecond = var_23_0.use_seconds,
		result = var_23_0.result,
		buffID = var_23_0.buff_id or 0,
		player_list = {},
		battle_record_dir = {}
	}
end

function var_0_0.FishCooperationBattle(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.battle_result

	arg_24_0.isInBattle_ = false

	local var_24_1 = {}

	for iter_24_0, iter_24_1 in ipairs(var_24_0.star_list) do
		var_24_1[iter_24_0] = {
			starID = iter_24_1.star_id,
			isComplete = iter_24_1.is_achieve
		}
	end

	local var_24_2 = {}

	for iter_24_2, iter_24_3 in ipairs(var_24_0.all_drop_list) do
		local var_24_3 = {}

		for iter_24_4, iter_24_5 in ipairs(iter_24_3.gain_list) do
			var_24_3[iter_24_4] = {
				id = iter_24_5.id,
				num = iter_24_5.num
			}
		end

		var_24_2[iter_24_2] = {
			battleTimes = iter_24_3.battle_times,
			rewardItems = var_24_3
		}
	end

	local var_24_4 = {}

	for iter_24_6, iter_24_7 in ipairs(var_24_0.player_list) do
		table.insert(var_24_4, BattleTeamPlayerTemplate.New(iter_24_7))
	end

	local var_24_5 = {}

	for iter_24_8, iter_24_9 in ipairs(var_24_0.battle_record) do
		local var_24_6 = {}

		for iter_24_10, iter_24_11 in ipairs(iter_24_9.battle_record) do
			var_24_6[iter_24_11.id] = iter_24_11.value
		end

		var_24_5[iter_24_9.user_id] = var_24_6
	end

	arg_24_0.battleResultData_ = {
		serverBattleID = var_24_0.dest,
		starList = var_24_1,
		dropList = var_24_2,
		useSecond = var_24_0.use_seconds,
		result = var_24_0.result,
		player_list = var_24_4,
		battle_record_dir = var_24_5
	}
end

function var_0_0.IsInBattle(arg_25_0)
	return arg_25_0.isInBattle_
end

function var_0_0.GetBattleResultData(arg_26_0)
	return arg_26_0.battleResultData_
end

function var_0_0.GetServerBattleID(arg_27_0)
	return arg_27_0.serverBattleID_
end

function var_0_0.GetBattleServerIPAndPort(arg_28_0)
	return arg_28_0.battleServerIP_, arg_28_0.battleServerPort_
end

function var_0_0.SetStoryBackFlag(arg_29_0, arg_29_1)
	arg_29_0.storyBackFlag_ = arg_29_1
end

function var_0_0.GetStoryBackFlag(arg_30_0)
	return arg_30_0.storyBackFlag_
end

return var_0_0
