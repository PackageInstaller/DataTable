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

function var_0_0:GetCurrentSelectHeroID()
	return self.currentSelectHeroID_, self.trialID_
end

function var_0_0.SetCurrentSelectHeroData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.currentSelectHeroID_ = arg_3_1
	arg_3_0.trialID_ = arg_3_2
end

function var_0_0:SetCacheChapterClient(arg_4_1, arg_4_2)
	if arg_4_2 and self.cacheToggle_[arg_4_1] ~= arg_4_2 then
		self.cacheToggle_[arg_4_1] = arg_4_2

		saveData("BattleField", "toggle_" .. arg_4_1, arg_4_2)
	end
end

function var_0_0:GetCacheChapterClient(arg_5_1)
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

	if var_5_1 and (ChapterTools.IsChapterSystemLock(var_5_1) or not ((var_5_1 and ChapterClientCfg[var_5_1].show_tag_type == ChapterConst.SHOW_TYPE.LIMIT_TIME or nil) and ActivityData:GetActivityIsOpen(ChapterCfg[ChapterClientCfg[var_5_1].chapter_list[1]].activity_id))) then
		saveData("BattleField", "toggle_" .. arg_5_1, nil)
	end

	local var_5_3 = self.cacheToggle_[arg_5_1]

	if not self.cacheToggle_[arg_5_1] then
		var_5_3 = getData("BattleField", "toggle_" .. arg_5_1)

		if not var_5_3 then
			if arg_5_1 == BattleConst.TOGGLE.PLOT then
				var_5_3 = ChapterTools.GetOptimalChapterClientID(true)

				if not var_5_3 then
					if arg_5_1 == BattleConst.TOGGLE.SUB_PLOT then
						var_5_3 = ChapterTools.GetOpenSubPlotClient() or arg_5_1 == BattleConst.TOGGLE.RESIDENT_ACT and var_5_0 or var_5_0

						if ChapterClientCfg[var_5_3] == nil then
							var_5_3 = var_5_0
						end
					end
				end
			end
		end
	end

	return var_5_3
end

function var_0_0:SetCacheChapter(arg_6_1, arg_6_2)
	if arg_6_2 and self.cacheChapter_[arg_6_1] ~= arg_6_2 then
		self.cacheChapter_[arg_6_1] = arg_6_2

		saveData("BattleField", "chapterClientID_" .. arg_6_1, arg_6_2)
	end
end

function var_0_0:GetCacheChapter(arg_7_1)
	local var_7_0 = self.cacheChapter_[arg_7_1]

	if not self.cacheChapter_[arg_7_1] then
		var_7_0 = getData("BattleField", "chapterClientID_" .. arg_7_1)
		var_7_0 = var_7_0 or ChapterClientCfg[arg_7_1].chapter_list[1]
	end

	return var_7_0
end

function var_0_0:SetSecondCacheChapter(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = string.format("secondChapterID_%s_%s", arg_8_3, arg_8_1)

	if arg_8_2 and self.secondCacheStage_[var_8_0] ~= arg_8_2 then
		self.secondCacheStage_[var_8_0] = arg_8_2

		saveData("BattleField", var_8_0, arg_8_2)
	end
end

function var_0_0:GetSecondCacheChapter(arg_9_1, arg_9_2)
	local var_9_0 = string.format("secondChapterID_%s_%s", arg_9_2, arg_9_1)

	return self.secondCacheStage_[var_9_0] or getData("BattleField", var_9_0)
end

function var_0_0:SetCacheStage(arg_10_1, arg_10_2)
	if self.cacheStage_[arg_10_1] ~= arg_10_2 then
		self.cacheStage_[arg_10_1] = arg_10_2

		saveData("BattleField", "chapterID" .. arg_10_1, arg_10_2)
	end
end

function var_0_0:GetCacheStage(arg_11_1)
	if arg_11_1 then
		return self.cacheStage_[arg_11_1] or getData("BattleField", "chapterID" .. arg_11_1)
	end
end

function var_0_0:GetStageByClientID(arg_12_1)
	if arg_12_1 then
		return self.clientIDAndStage_[arg_12_1] or getData("BattleField", "clientID" .. arg_12_1)
	end
end

function var_0_0:SetStageByClientID(arg_13_1, arg_13_2)
	if self.clientIDAndStage_[arg_13_1] ~= arg_13_2 then
		self.clientIDAndStage_[arg_13_1] = arg_13_2

		saveData("BattleField", "clientID" .. arg_13_1, arg_13_2)
	end
end

function var_0_0:GetPlotHardLevel()
	return ChapterCfg[self:GetCacheChapter((self:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)))].difficulty
end

function var_0_0:ChangePlotHardLevel(arg_15_1)
	local var_15_0 = ChapterClientCfg[self:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)].chapter_list[1]
	local var_15_1 = getChapterList()
	local var_15_2 = getChapterClientList()[arg_15_1]

	for iter_15_0 = ChapterCfg[var_15_0].sub_type, 1, -1 do
		if var_15_1[iter_15_0][arg_15_1] then
			local var_15_3 = getChapterClientCfgByChapterID(var_15_1[iter_15_0][arg_15_1][1]).id

			if table.keyof(var_15_2, var_15_3) then
				self:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, var_15_3)

				return
			end
		end
	end

	for iter_15_1 = ChapterCfg[var_15_0].sub_type + 1, #getChapterClientList()[ChapterCfg[var_15_0].difficulty] do
		if var_15_1[iter_15_1][arg_15_1] then
			local var_15_4 = getChapterClientCfgByChapterID(var_15_1[iter_15_1][arg_15_1][1]).id

			if table.keyof(var_15_2, var_15_4) then
				self:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, var_15_4)

				return
			end
		end
	end
end

function var_0_0:SaveChapterMapDay(arg_16_1, arg_16_2)
	saveData("BattleField", string.format("chapterID_%s_day", arg_16_1), arg_16_2)

	self.chapterMapDayList_[arg_16_1] = arg_16_2
end

function var_0_0:GetChapterMapDay(arg_17_1)
	local var_17_0 = self.chapterMapDayList_[arg_17_1]

	if not self.chapterMapDayList_[arg_17_1] then
		var_17_0 = getData("BattleField", string.format("chapterID_%s_day", arg_17_1))
		var_17_0 = var_17_0 or ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id[arg_17_1][1]].day
	end

	return var_17_0
end

function var_0_0:SaveChapterMapID(arg_18_1, arg_18_2, arg_18_3)
	saveData("BattleField", string.format("chapterID_%s_day_%s_mapID", arg_18_1, arg_18_2), arg_18_3)

	if self.chapterMapIDList_[arg_18_1] == nil then
		self.chapterMapIDList_[arg_18_1] = {}
	end

	self.chapterMapIDList_[arg_18_1][arg_18_2] = arg_18_3
end

function var_0_0:GetChapterMapID(arg_19_1, arg_19_2)
	local var_19_0

	var_19_0 = self.chapterMapIDList_[arg_19_1] == nil and saveData("BattleField", string.format("chapterID_%s_day_%s_mapID", arg_19_1, arg_19_2), var_19_0) or self.chapterMapIDList_[arg_19_1][arg_19_2]

	if var_19_0 == nil then
		var_19_0 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_19_1][arg_19_2][1]
	end

	return var_19_0
end

function var_0_0:SetChapterLocationID(arg_20_1, arg_20_2)
	self.chapterLocationList_[arg_20_1] = arg_20_2
end

function var_0_0:GetChapterLocationID(arg_21_1)
	return self.chapterLocationList_[arg_21_1]
end

function var_0_0.SetServerBattleParams(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_0.serverBattleID_ = arg_22_1
	arg_22_0.battleServerIP_ = arg_22_2
	arg_22_0.battleServerPort_ = arg_22_3
	arg_22_0.isInBattle_ = true
end

function var_0_0.FinishBattle(arg_23_0, arg_23_1)
	arg_23_0.isInBattle_ = false

	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_1.battle_result.star_list) do
		var_23_0[iter_23_0] = {
			starID = iter_23_1.star_id,
			isComplete = iter_23_1.is_achieve
		}
	end

	local var_23_1 = {}

	for iter_23_2, iter_23_3 in ipairs(arg_23_1.battle_result.all_drop_list) do
		local var_23_2 = {}
		local var_23_3 = {}

		for iter_23_4, iter_23_5 in ipairs(iter_23_3.gain_list) do
			var_23_2[iter_23_4] = {
				id = iter_23_5.id,
				num = iter_23_5.num
			}
		end

		if iter_23_3.extra_list then
			for iter_23_6, iter_23_7 in ipairs(iter_23_3.extra_list) do
				var_23_3[iter_23_6] = {
					id = iter_23_7.id,
					num = iter_23_7.num
				}
			end
		end

		var_23_1[iter_23_2] = {
			battleTimes = iter_23_3.battle_times,
			rewardItems = var_23_2,
			extraReward = var_23_3
		}
	end

	local var_23_4 = {
		serverBattleID = arg_23_1.battle_result.dest,
		cleanTimes = arg_23_1.battle_result.clear_times,
		targetTimes = arg_23_1.battle_result.target_times,
		starList = var_23_0,
		dropList = var_23_1,
		useSecond = arg_23_1.battle_result.use_seconds,
		result = arg_23_1.battle_result.result
	}

	var_23_4.buffID = arg_23_1.battle_result.buff_id or 0
	var_23_4.player_list = {}
	var_23_4.battle_record_dir = {}
	arg_23_0.battleResultData_ = var_23_4
end

function var_0_0.FishCooperationBattle(arg_24_0, arg_24_1)
	arg_24_0.isInBattle_ = false

	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_1.battle_result.star_list) do
		var_24_0[iter_24_0] = {
			starID = iter_24_1.star_id,
			isComplete = iter_24_1.is_achieve
		}
	end

	local var_24_1 = {}

	for iter_24_2, iter_24_3 in ipairs(arg_24_1.battle_result.all_drop_list) do
		local var_24_2 = {}

		for iter_24_4, iter_24_5 in ipairs(iter_24_3.gain_list) do
			var_24_2[iter_24_4] = {
				id = iter_24_5.id,
				num = iter_24_5.num
			}
		end

		var_24_1[iter_24_2] = {
			battleTimes = iter_24_3.battle_times,
			rewardItems = var_24_2
		}
	end

	local var_24_3 = {}

	for iter_24_6, iter_24_7 in ipairs(arg_24_1.battle_result.player_list) do
		table.insert(var_24_3, BattleTeamPlayerTemplate.New(iter_24_7))
	end

	local var_24_4 = {}

	for iter_24_8, iter_24_9 in ipairs(arg_24_1.battle_result.battle_record) do
		local var_24_5 = {}

		for iter_24_10, iter_24_11 in ipairs(iter_24_9.battle_record) do
			var_24_5[iter_24_11.id] = iter_24_11.value
		end

		var_24_4[iter_24_9.user_id] = var_24_5
	end

	arg_24_0.battleResultData_ = {
		serverBattleID = arg_24_1.battle_result.dest,
		starList = var_24_0,
		dropList = var_24_1,
		useSecond = arg_24_1.battle_result.use_seconds,
		result = arg_24_1.battle_result.result,
		player_list = var_24_3,
		battle_record_dir = var_24_4
	}
end

function var_0_0:IsInBattle()
	return self.isInBattle_
end

function var_0_0:GetBattleResultData()
	return self.battleResultData_
end

function var_0_0:GetServerBattleID()
	return self.serverBattleID_
end

function var_0_0:GetBattleServerIPAndPort()
	return self.battleServerIP_, self.battleServerPort_
end

function var_0_0.SetStoryBackFlag(arg_29_0, arg_29_1)
	arg_29_0.storyBackFlag_ = arg_29_1
end

function var_0_0:GetStoryBackFlag()
	return self.storyBackFlag_
end

return var_0_0
