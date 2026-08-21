local var_0_0 = {
	GetChapterUnlockActivity = function(arg_1_0)
		return nullable(ChapterCfg, arg_1_0, "unlock_activity_id")
	end,
	GetChapterActivity = function(arg_2_0)
		return nullable(ChapterCfg, arg_2_0, "activity_id")
	end,
	GetChapterIDFromSystemLink = function(arg_3_0)
		local var_3_0 = arg_3_0[1]

		if var_3_0 == ViewConst.JUMP_SPECIAL_ID.BATTLE_MAIN_CHAPTER_19 then
			return ChapterConst.CHAPTER_CLIENT_19
		elseif var_3_0 == ViewConst.JUMP_SPECIAL_ID.BATTLE_MAIN then
			return arg_3_0[2]
		end
	end
}

function var_0_0.IsChapterAnyStageNeedOpenByOathAssignment(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(WeddingAssignmentCfg.get_id_list_by_hero_id) do
		if OathTools.IsOath(iter_4_0) then
			for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
				local var_4_0 = WeddingAssignmentCfg[iter_4_3]

				if var_4_0.condition == 401 and var_0_0.GetChapterIDFromSystemLink(var_4_0.jump) == arg_4_0 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.IsFinishPreChapter(arg_5_0)
	local var_5_0 = ChapterCfg[arg_5_0]

	if var_5_0 == nil then
		return false, arg_5_0
	end

	local var_5_1 = var_5_0.pre_chapter
	local var_5_2 = var_5_0.activity_id
	local var_5_3 = var_5_0.connect_group

	if var_5_0.unlock_activity_id ~= 0 and not ActivityData:GetActivityIsOpen(var_5_0.unlock_activity_id) then
		return false, -2
	end

	if var_5_3 and var_5_3 ~= "" then
		for iter_5_0, iter_5_1 in pairs(var_5_3) do
			local var_5_4 = ChapterCfg.get_id_list_by_connect_group[iter_5_1]

			for iter_5_2, iter_5_3 in pairs(var_5_4) do
				local var_5_5 = ChapterCfg[iter_5_3].activity_id

				if ActivityData:GetActivityIsOpen(var_5_5) then
					if GameSetting.activity_main_plot_unlock_level.value[1] > PlayerData:GetPlayerInfo().userLevel then
						return false, -1
					end

					if arg_5_0 == ChapterConst.CHAPTER_CLIENT_24 then
						local var_5_6 = ChapterClientCfg[ChapterConst.CHAPTER_CLIENT_23].chapter_list[2]

						if not var_0_0.IsClearChapter(var_5_6) then
							return true, var_5_6
						else
							return true, 0
						end
					elseif arg_5_0 == ChapterConst.CHAPTER_CLIENT_25 then
						local var_5_7 = ChapterClientCfg[ChapterConst.CHAPTER_CLIENT_23].chapter_list[2]

						if not var_0_0.IsClearChapter(var_5_7) then
							return true, var_5_7
						end

						local var_5_8 = ChapterClientCfg[ChapterConst.CHAPTER_CLIENT_24].chapter_list[1]

						if not var_0_0.IsClearChapter(var_5_8) then
							return true, var_5_8
						else
							return true, 0
						end
					end

					return true, 0
				end
			end
		end
	end

	if ActivityData:GetActivityIsOpen(var_5_2) then
		for iter_5_4, iter_5_5 in pairs(var_5_1) do
			if var_5_2 == ChapterCfg[iter_5_5].activity_id and var_0_0.IsClearChapter(iter_5_5) == false then
				return false, iter_5_5
			end
		end

		if GameSetting.activity_main_plot_unlock_level.value[1] > PlayerData:GetPlayerInfo().userLevel then
			return false, -1
		end

		return true, 0
	end

	if var_0_0.IsChapterAnyStageNeedOpenByOathAssignment(arg_5_0) then
		return true, 0
	end

	local var_5_9 = var_5_0.section_id_list[1] and BattleChapterStageCfg[var_5_0.section_id_list[1]] and BattleChapterStageCfg[var_5_0.section_id_list[1]].level

	if var_5_9 and var_5_9 > PlayerData:GetPlayerInfo().userLevel then
		return false, -1
	end

	return var_0_0.IsFinishAllPreChapter(arg_5_0)
end

function var_0_0.IsFinishAllPreChapter(arg_6_0)
	local var_6_0 = ChapterCfg[arg_6_0]
	local var_6_1 = var_6_0.pre_chapter

	if var_6_1 == "" then
		return true
	end

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		local var_6_2 = ChapterCfg[iter_6_1]

		if type(var_6_2.pre_chapter) ~= "table" then
			return true, 0
		end

		if arg_6_0 == 10106 then
			local var_6_3 = var_6_0.section_id_list[1]
			local var_6_4 = BattleStageData:GetStageData()[var_6_3]

			if var_6_4 ~= nil and var_6_4.clear_times > 0 then
				return true, 0
			end
		end

		if not var_0_0.IsFinishPreChapterWithoutActivity(iter_6_1) then
			return false, iter_6_1
		end

		local var_6_5 = var_6_2.section_id_list[#var_6_2.section_id_list]
		local var_6_6 = BattleStageData:GetStageData()[var_6_5]

		if var_6_6 == nil or var_6_6.clear_times <= 0 then
			return false, iter_6_1
		end
	end

	return true, 0
end

function var_0_0.IsFinishPreChapterWithoutActivity(arg_7_0)
	if ChapterCfg[arg_7_0] == nil then
		return false, arg_7_0
	end

	return var_0_0.IsFinishAllPreChapter(arg_7_0)
end

function var_0_0.GetChapterLockText(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == -1 then
		local var_8_0 = ChapterCfg[arg_8_0]
		local var_8_1 = ActivityData:GetActivityIsOpen(var_8_0.activity_id)
		local var_8_2 = var_8_0.section_id_list[1] and BattleChapterStageCfg[var_8_0.section_id_list[1]] and BattleChapterStageCfg[var_8_0.section_id_list[1]].level

		if var_8_1 then
			return string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.activity_main_plot_unlock_level.value[1])
		else
			return string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_8_2)
		end
	end

	if arg_8_1 == -2 then
		local var_8_3 = ChapterCfg[arg_8_0]
		local var_8_4 = ActivityData:GetActivityData(var_8_3.unlock_activity_id)

		return string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_8_4.startTime))
	end

	local var_8_5 = ChapterCfg[arg_8_1]

	if var_8_5.difficulty == 1 and not arg_8_2 then
		return "NEED_FINISH_PRE_NORMAL_STAGE"
	end

	local var_8_6 = ChapterClientCfg[var_8_5.clientID]

	return string.format(GetTips("NEED_FINISH_PRE_STAGE"), GetTips(BattleConst.HARD_LANGUAGE[var_8_5.difficulty]), GetI18NText(var_8_6.desc))
end

function var_0_0.GetOptimalChapterClientID(arg_9_0)
	if arg_9_0 and GameSetting.activity_main_plot_unlock_level.value[1] > PlayerData:GetPlayerInfo().userLevel then
		return var_0_0.GetClearMaxChapterClientID(), 0
	end

	local var_9_0 = getChapterClientList()[1]

	for iter_9_0 = #var_9_0, 1, -1 do
		local var_9_1 = var_9_0[iter_9_0]
		local var_9_2, var_9_3 = var_0_0.IsOpenChapterClientID(var_9_1)

		if var_9_2 then
			return var_9_1, var_9_3
		end
	end

	return var_0_0.GetClearMaxChapterClientID(), 0
end

function var_0_0.IsOpenChapterClientID(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(ChapterClientCfg[arg_10_0].chapter_list) do
		local var_10_0 = ChapterCfg[iter_10_1].activity_id

		if var_10_0 ~= 0 and ActivityData:GetActivityIsOpen(var_10_0) then
			return true, var_10_0
		end
	end

	return false
end

function var_0_0.GetClearMaxChapterClientID()
	local var_11_0 = getChapterClientList()[1]
	local var_11_1 = var_11_0[1]

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_2 = ChapterClientCfg[iter_11_1].chapter_list[1]
		local var_11_3 = ChapterCfg[var_11_2].section_id_list[1]

		if BattleStageData:GetStageData()[var_11_3] and var_0_0.IsClearChapterClient(var_11_1) and var_0_0.IsUnlockChapter(var_11_2) then
			var_11_1 = iter_11_1
		else
			return var_11_1
		end
	end

	return var_11_0[#var_11_0]
end

function var_0_0.GetChapterTotalStarCnt(arg_12_0)
	if ChapterCfg[arg_12_0].clientID == ChapterConst.CHAPTER_CLIENT_19 then
		return #AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_19]
	elseif ChapterCfg[arg_12_0].clientID == ChapterConst.CHAPTER_CLIENT_23 then
		return ChapterV2MapTools.GetChapterTotalStarCnt(ChapterCfg[arg_12_0].clientID)
	elseif ChapterCfg[arg_12_0].clientID == ChapterConst.CHAPTER_CLIENT_24 then
		return ChapterV2MapTools.GetChapterTotalStarCnt(ChapterCfg[arg_12_0].clientID)
	elseif ChapterCfg[arg_12_0].clientID == ChapterConst.CHAPTER_CLIENT_25 then
		return ChapterV2MapTools.GetChapterTotalStarCnt(ChapterCfg[arg_12_0].clientID)
	end

	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(ChapterCfg[arg_12_0].section_id_list) do
		var_12_0 = var_12_0 + #BattleChapterStageCfg[iter_12_1].three_star_need
	end

	return var_12_0
end

function var_0_0.GetChapterStarCnt(arg_13_0)
	if ChapterCfg[arg_13_0].clientID == ChapterConst.CHAPTER_CLIENT_19 then
		local var_13_0 = 0

		for iter_13_0, iter_13_1 in ipairs(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_19]) do
			local var_13_1 = AssignmentCfg[iter_13_1]
			local var_13_2 = TaskData2:GetTask(iter_13_1)

			if var_13_2 and var_13_2.progress >= var_13_1.need then
				var_13_0 = var_13_0 + 1
			end
		end

		return var_13_0
	elseif ChapterCfg[arg_13_0].clientID == ChapterConst.CHAPTER_CLIENT_23 then
		return ChapterV2MapTools.GetChapterStarCnt(ChapterCfg[arg_13_0].clientID)
	elseif ChapterCfg[arg_13_0].clientID == ChapterConst.CHAPTER_CLIENT_24 then
		return ChapterV2MapTools.GetChapterStarCnt(ChapterCfg[arg_13_0].clientID)
	elseif ChapterCfg[arg_13_0].clientID == ChapterConst.CHAPTER_CLIENT_25 then
		return ChapterV2MapTools.GetChapterStarCnt(ChapterCfg[arg_13_0].clientID)
	end

	return BattleStageData:GetChapterStarCnt(arg_13_0)
end

function var_0_0.GetChapterStarPercentage(arg_14_0)
	local var_14_0 = var_0_0.GetChapterTotalStarCnt(arg_14_0)

	return var_0_0.GetChapterStarCnt(arg_14_0) / var_14_0
end

function var_0_0.GetChapterClientTotalStarCnt(arg_15_0)
	local var_15_0 = ChapterClientCfg[arg_15_0]
	local var_15_1 = 0

	for iter_15_0, iter_15_1 in ipairs(var_15_0.chapter_list) do
		var_15_1 = var_15_1 + var_0_0.GetChapterTotalStarCnt(iter_15_1)
	end

	return var_15_1
end

function var_0_0.GetChapterClientStarCnt(arg_16_0)
	local var_16_0 = ChapterClientCfg[arg_16_0]
	local var_16_1 = 0

	for iter_16_0, iter_16_1 in ipairs(var_16_0.chapter_list) do
		var_16_1 = var_16_1 + var_0_0.GetChapterStarCnt(iter_16_1)
	end

	return var_16_1
end

function var_0_0.GetChapterClientStarPercentage(arg_17_0)
	local var_17_0 = var_0_0.GetChapterClientTotalStarCnt(arg_17_0)

	return var_0_0.GetChapterClientStarCnt(arg_17_0) / var_17_0
end

function var_0_0.GetSubPlotFinishPercentage(arg_18_0)
	local var_18_0 = 0
	local var_18_1 = 0

	if arg_18_0 == ChapterConst.CHAPTER_CLIENT_SUMMER_CHESS_BOARD then
		var_18_1 = SummerChessBoardTools.GetChessExploreFinishCnt()
		var_18_0 = GameSetting.summer_chess_board_collect_cnt.value[1]

		return var_18_1 / var_18_0
	end

	local var_18_2 = BattleStageData:GetStageData()

	for iter_18_0, iter_18_1 in ipairs(ChapterClientCfg[arg_18_0].chapter_list) do
		local var_18_3 = ChapterCfg[iter_18_1]

		var_18_0 = var_18_0 + #var_18_3.section_id_list

		for iter_18_2, iter_18_3 in ipairs(var_18_3.section_id_list) do
			if var_18_2[iter_18_3] and var_18_2[iter_18_3].clear_times > 0 then
				var_18_1 = var_18_1 + 1
			end
		end
	end

	if arg_18_0 ~= 6010002 then
		local var_18_4 = WarchessLevelCfg.get_id_list_by_chapter_tag[arg_18_0]

		if var_18_4 ~= nil then
			for iter_18_4, iter_18_5 in pairs(var_18_4) do
				var_18_0 = var_18_0 + 1

				if ChessTools.GetChapterProgress(iter_18_5) >= 100 then
					var_18_1 = var_18_1 + 1
				end
			end
		end
	end

	if var_18_0 == 0 then
		return 0
	end

	return var_18_1 / var_18_0
end

function var_0_0.GetChapterClientFinishPercentage(arg_19_0)
	local var_19_0 = ChapterClientCfg[arg_19_0]

	if var_19_0.toggle == BattleConst.TOGGLE.PLOT then
		return var_0_0.GetChapterClientStarPercentage(arg_19_0)
	elseif var_19_0.toggle == BattleConst.TOGGLE.SUB_PLOT then
		return var_0_0.GetSubPlotFinishPercentage(arg_19_0)
	else
		return 0
	end
end

function var_0_0.GetChapterByActivityID(arg_20_0)
	local var_20_0 = ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT]
	local var_20_1 = {}

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if ChapterCfg[iter_20_1].activity_id == arg_20_0 then
			table.insert(var_20_1, iter_20_1)
		end
	end

	for iter_20_2, iter_20_3 in ipairs(var_20_1) do
		if not var_0_0.IsClearChapter(iter_20_3) then
			return iter_20_3
		end
	end

	return var_20_1[1]
end

function var_0_0.IsClearChapterClient(arg_21_0)
	local var_21_0 = ChapterClientCfg[arg_21_0].chapter_list
	local var_21_1 = var_21_0[#var_21_0]

	return var_0_0.IsClearChapter(var_21_1)
end

function var_0_0.IsClearChapter(arg_22_0)
	if ChapterCfg[arg_22_0].clientID == ChapterConst.CHAPTER_CLIENT_19 then
		local var_22_0 = ChapterMapCfg.get_id_list_by_chapter_id[arg_22_0]
		local var_22_1 = ChapterMapCfg[#var_22_0].location_list

		for iter_22_0, iter_22_1 in ipairs(var_22_1) do
			for iter_22_2, iter_22_3 in ipairs(ChapterLocationCfg[iter_22_1].stage_list) do
				if not var_0_0.IsClearStage(iter_22_3) then
					return false
				end
			end
		end

		return true
	end

	if ChapterCfg[arg_22_0].clientID == ChapterConst.CHAPTER_CLIENT_23 or ChapterCfg[arg_22_0].clientID == ChapterConst.CHAPTER_CLIENT_24 or ChapterCfg[arg_22_0].clientID == ChapterConst.CHAPTER_CLIENT_25 then
		local var_22_2 = ChapterV2MapCfg.get_id_list_by_chapter_client_id[ChapterCfg[arg_22_0].clientID]
		local var_22_3 = var_22_2[#var_22_2]
		local var_22_4 = ChapterV2MapTools.GetNextEvent(var_22_3, nil, true, true)

		if var_22_4 and var_22_4 == 0 then
			return true
		elseif var_22_4 == 4080216 then
			return true
		else
			return false
		end
	end

	local var_22_5 = ChapterCfg[arg_22_0].section_id_list
	local var_22_6 = var_22_5[#var_22_5]

	return var_0_0.IsClearStage(var_22_6)
end

function var_0_0.IsClearFirstStage(arg_23_0)
	local var_23_0 = ChapterCfg[arg_23_0].section_id_list[1]

	return var_0_0.IsClearStage(var_23_0)
end

function var_0_0.IsClearStage(arg_24_0)
	local var_24_0 = BattleStageData:GetStageData()[arg_24_0]

	if var_24_0 == nil or var_24_0.clear_times <= 0 then
		return false
	end

	return true
end

function var_0_0.HasChapterStage(arg_25_0)
	local var_25_0 = ChapterClientCfg[arg_25_0].chapter_list[1]

	return #ChapterCfg[var_25_0].section_id_list > 0
end

function var_0_0.IsUnlockChapter(arg_26_0)
	local var_26_0 = ChapterCfg[arg_26_0]
	local var_26_1 = var_26_0.sub_type
	local var_26_2 = var_26_0.unlock_activity_id

	if var_26_0.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
		var_26_2 = var_26_0.activity_id

		if var_26_2 ~= 0 then
			local var_26_3 = ActivityData:GetActivityRefreshTime(var_26_2)
			local var_26_4 = manager.time:GetServerTime()

			if ActivityTools.GetActivityStatus(var_26_2) == 1 and var_26_3 ~= 0 and var_26_4 < var_26_3 then
				return false
			end
		end
	elseif var_26_2 ~= 0 then
		local var_26_5 = ActivityData:GetActivityData(var_26_2)

		if manager.time:GetServerTime() < var_26_5.startTime then
			return false
		end
	end

	if var_26_1 == 13 and arg_26_0 == 11112 and not SkuldTravelData:IsCollectAllPhoto() then
		return false
	end

	return true
end

function var_0_0.GetChapterIDByClient(arg_27_0)
	local var_27_0 = ChapterClientCfg[arg_27_0]
	local var_27_1 = var_27_0.chapter_list[1]

	for iter_27_0, iter_27_1 in ipairs(var_27_0.chapter_list) do
		if not ChapterTools.IsUnlockChapter(iter_27_1) then
			return var_27_1
		end

		local var_27_2 = table.keyof(var_27_0.chapter_list, iter_27_1)

		if var_27_2 > 1 then
			local var_27_3 = var_27_0.chapter_list[var_27_2 - 1]

			if not ChapterTools.IsClearChapter(var_27_3) then
				return var_27_1
			end
		end

		if #ChapterCfg[iter_27_1].section_id_list <= 0 then
			return var_27_1
		end

		var_27_1 = iter_27_1
	end

	return var_27_1
end

function var_0_0.GetNeighborClientID(arg_28_0, arg_28_1)
	local var_28_0 = ChapterClientCfg[arg_28_0]
	local var_28_1 = {}

	if var_28_0.toggle == BattleConst.TOGGLE.PLOT then
		local var_28_2 = var_28_0.difficulty

		var_28_1 = getChapterClientList()[var_28_2]
	elseif var_28_0.toggle == BattleConst.TOGGLE.SUB_PLOT then
		var_28_1 = ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT]
	end

	local var_28_3 = table.keyof(var_28_1, arg_28_0)

	if arg_28_1 and var_28_3 < #var_28_1 then
		var_28_3 = var_28_3 + 1
	elseif not arg_28_1 and var_28_3 > 1 then
		var_28_3 = var_28_3 - 1
	end

	return var_28_1[var_28_3]
end

function var_0_0.GetUnclearStageCnt(arg_29_0)
	local var_29_0 = ChapterCfg[arg_29_0]
	local var_29_1 = #var_29_0.section_id_list

	for iter_29_0, iter_29_1 in ipairs(var_29_0.section_id_list) do
		local var_29_2 = BattleStageData:GetStageData()[iter_29_1]

		if var_29_2 and var_29_2.clear_times > 0 then
			var_29_1 = var_29_1 - 1
		else
			return var_29_1
		end
	end

	return var_29_1
end

function var_0_0.GetOpenStageList(arg_30_0, arg_30_1)
	local var_30_0 = BattleStageData:GetStageData()
	local var_30_1 = ChapterCfg[arg_30_0].section_id_list
	local var_30_2 = {}

	for iter_30_0, iter_30_1 in ipairs(var_30_1) do
		if var_30_0[iter_30_1] then
			if table.keyof(var_30_2, iter_30_1) or iter_30_1 == GameSetting.travel_skuld_new_ending_stage_id.value[1] and var_30_0[iter_30_1].clear_times < 1 then
				-- block empty
			else
				table.insert(var_30_2, iter_30_1)
			end

			if var_30_0[iter_30_1].clear_times > 0 then
				local var_30_3 = arg_30_1[iter_30_1].next_show_id_list

				if var_30_3 == "" then
					var_30_3 = {}
				end

				for iter_30_2, iter_30_3 in ipairs(var_30_3) do
					if not table.keyof(var_30_2, iter_30_3) then
						if iter_30_3 == GameSetting.travel_skuld_new_ending_stage_id.value[1] then
							if not var_30_0[iter_30_3] or var_30_0[iter_30_3] and var_30_0[iter_30_3].clear_times < 1 then
								-- block empty
							else
								table.insert(var_30_2, iter_30_3)
							end
						else
							table.insert(var_30_2, iter_30_3)
						end
					end
				end
			end
		end
	end

	return var_30_2
end

function var_0_0.GetActivityChapterIndex(arg_31_0)
	local var_31_0
	local var_31_1
	local var_31_2
	local var_31_3 = 1

	for iter_31_0 = #arg_31_0, 1, -1 do
		local var_31_4 = arg_31_0[iter_31_0]
		local var_31_5, var_31_6, var_31_7 = var_0_0.GetDeltaTime(var_31_4[2])

		if var_31_0 == nil then
			var_31_0, var_31_1, var_31_2 = var_31_5, var_31_6, var_31_7
			var_31_3 = iter_31_0
		elseif var_31_7 == true and var_31_2 == false then
			var_31_0 = var_31_5
			var_31_1 = var_31_6
			var_31_2 = var_31_7
			var_31_3 = iter_31_0
		elseif var_31_7 == false and var_31_2 == true then
			-- block empty
		elseif var_31_2 == true and var_31_7 == true then
			if var_31_1 > 0 and var_31_6 > 0 and var_31_6 < var_31_1 then
				var_31_0 = var_31_5
				var_31_1 = var_31_6
				var_31_2 = var_31_7
				var_31_3 = iter_31_0
			end
		elseif var_31_0 < 0 and var_31_5 < 0 and var_31_1 > 0 and var_31_6 > 0 then
			var_31_0 = var_31_5
			var_31_1 = var_31_6
			var_31_2 = var_31_7
			var_31_3 = iter_31_0
		elseif var_31_0 > 0 and var_31_5 > 0 and var_31_1 < 0 and var_31_6 < 0 then
			-- block empty
		elseif var_31_5 > 0 then
			var_31_0 = var_31_5
			var_31_1 = var_31_6
			var_31_2 = var_31_7
			var_31_3 = iter_31_0
		end
	end

	return var_31_3
end

function var_0_0.GetDeltaTime(arg_32_0)
	local var_32_0 = ActivityData:GetActivityData(arg_32_0)
	local var_32_1 = manager.time:GetServerTime()
	local var_32_2 = var_32_1 - var_32_0.startTime
	local var_32_3 = var_32_0.stopTime - var_32_1

	return var_32_2, var_32_3, var_32_1 >= var_32_0.startTime and var_32_1 <= var_32_0.stopTime
end

function var_0_0.GotoChapterStagePage(arg_33_0)
	local var_33_0 = arg_33_0[var_0_0.GetActivityChapterIndex(arg_33_0)]
	local var_33_1 = var_33_0[3]

	if var_33_0[1] == 1 then
		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, var_33_1)
		gameContext:Go("/chapterMapContent", {
			chapterToggle = BattleConst.TOGGLE.PLOT
		})
	else
		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT, var_33_1)
		gameContext:Go("/chapterSubPlotContent")
	end
end

function var_0_0.GotoMaxChapterClient()
	local var_34_0 = var_0_0.GetClearMaxChapterClientID()

	BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, var_34_0)
	gameContext:Go("/chapterMapContent")
end

function var_0_0.GotoChapterSection(arg_35_0)
	local var_35_0 = ChapterCfg[arg_35_0].clientID
	local var_35_1 = ChapterClientCfg[var_35_0]
	local var_35_2 = var_35_1.asset_pend_key

	if not manager.assetPend:CheckAssetPend(var_35_2) then
		manager.assetPend:ShowAssetPendMessageBox(var_35_2)

		return
	end

	print("点击章节，chapterID:", arg_35_0, "chapterClientID:", var_35_0)

	if #var_35_1.chapter_list > 1 and var_35_1.id ~= ChapterConst.CHAPTER_CLIENT_XUHENG_PART_2_2 and not ChapterConst.ROLL_MAIN_CLINET[var_35_1.id] then
		local var_35_3 = var_35_1.chapter_list[2]
		local var_35_4 = ChapterCfg[var_35_3].section_id_list[1]

		if BattleStageData:GetStageData()[var_35_4] or var_35_0 == ChapterConst.CHAPTER_CLIENT_16 or var_35_0 == ChapterConst.CHAPTER_CLIENT_17 or var_35_0 == ChapterConst.CHAPTER_CLIENT_18 or var_35_0 == ChapterConst.CHAPTER_CLIENT_20 or var_35_0 == ChapterConst.CHAPTER_CLIENT_23 or var_35_0 == ChapterConst.CHAPTER_CLIENT_24 or var_35_0 == ChapterConst.CHAPTER_CLIENT_25 then
			print("进入选章节界面")
			JumpTools.OpenPageByJump(var_0_0.GetChapterBranchURL(var_35_1.id), {
				chapterClientID = var_35_1.id
			})

			return
		end
	end

	if not ChapterTools.IsUnlockChapter(arg_35_0) then
		local var_35_5 = ChapterCfg[arg_35_0].unlock_activity_id
		local var_35_6 = ActivityData:GetActivityData(var_35_5)

		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_35_6.startTime)))

		return
	end

	local var_35_7 = table.keyof(var_35_1.chapter_list, arg_35_0)

	if var_35_7 > 1 then
		local var_35_8 = var_35_1.chapter_list[var_35_7 - 1]

		if not ChapterTools.IsClearChapter(var_35_8) then
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), "", GetI18NText(ChapterCfg[var_35_8].subhead)))

			return
		end
	end

	if arg_35_0 == ChapterConst.CHAPTER_CLIENT_19 then
		JumpTools.OpenPageByJump(var_0_0.GetChapterBranchURL(var_35_1.id), {
			chapterID = arg_35_0
		})

		return
	elseif arg_35_0 == ChapterConst.CHAPTER_CLIENT_23 then
		JumpTools.OpenPageByJump(var_0_0.GetChapterBranchURL(var_35_1.id), {
			chapterClientID = var_35_0
		})

		return
	elseif arg_35_0 == ChapterConst.CHAPTER_CLIENT_24 then
		local var_35_9, var_35_10 = ChapterTools.IsFinishPreChapter(arg_35_0)

		if var_35_10 and var_35_10 > 0 then
			ShowMessageBox({
				content = GetTips("CHAPTERV2_JUMP_TO_CONNECT_CHAPTER"),
				OkCallback = function()
					JumpTools.OpenPageByJump(var_0_0.GetChapterBranchURL(ChapterConst.CHAPTER_CLIENT_23), {
						chapterClientID = ChapterConst.CHAPTER_CLIENT_23
					})
				end
			})
		else
			JumpTools.OpenPageByJump(var_0_0.GetChapterBranchURL(var_35_1.id), {
				chapterClientID = var_35_0
			})
		end

		return
	elseif arg_35_0 == ChapterConst.CHAPTER_CLIENT_25 then
		local var_35_11, var_35_12 = ChapterTools.IsFinishPreChapter(arg_35_0)

		if var_35_12 > 0 then
			ShowMessageBox({
				content = GetTips("CHAPTERV2_JUMP_TO_CONNECT_CHAPTER"),
				OkCallback = function()
					if var_35_12 == ChapterClientCfg[ChapterConst.CHAPTER_CLIENT_23].chapter_list[2] then
						JumpTools.OpenPageByJump(var_0_0.GetChapterBranchURL(ChapterConst.CHAPTER_CLIENT_23), {
							chapterClientID = ChapterConst.CHAPTER_CLIENT_23
						})
					elseif var_35_12 == ChapterClientCfg[ChapterConst.CHAPTER_CLIENT_24].chapter_list[1] then
						JumpTools.OpenPageByJump(var_0_0.GetChapterBranchURL(ChapterConst.CHAPTER_CLIENT_24), {
							chapterClientID = ChapterConst.CHAPTER_CLIENT_24
						})
					end
				end
			})
		else
			JumpTools.OpenPageByJump(var_0_0.GetChapterBranchURL(var_35_1.id), {
				chapterClientID = var_35_1.id
			})
		end

		return
	end

	if ChapterConst.ROLL_MAIN_CLINET[var_35_1.id] then
		JumpTools.OpenPageByJump("/chapterSectionRollBg", {
			chapterID = arg_35_0
		})
	else
		JumpTools.OpenPageByJump("/chapterSection", {
			chapterID = arg_35_0
		})
	end
end

function var_0_0.GetChapterBranchURL(arg_38_0)
	if arg_38_0 == ChapterConst.CHAPTER_CLIENT_EMPTY_DREAM then
		return "/chapterVariantEmptyDream"
	elseif arg_38_0 == ChapterConst.CHAPTER_CLIENT_XUHENG_PART_3 then
		return "/chapterVariantXuHengPart3"
	elseif arg_38_0 == ChapterConst.CHAPTER_CLIENT_16 then
		return "/chapterVariant16"
	elseif arg_38_0 == ChapterConst.CHAPTER_CLIENT_17 then
		return "/chapterVariant17"
	elseif arg_38_0 == ChapterConst.CHAPTER_CLIENT_18 then
		return "/chapterVariant18"
	elseif arg_38_0 == ChapterConst.CHAPTER_CLIENT_19 then
		return "/chapterPlot19Main"
	elseif arg_38_0 == ChapterConst.CHAPTER_CLIENT_20 then
		return "/chapterVariant20"
	elseif arg_38_0 == ChapterConst.CHAPTER_CLIENT_23 then
		return "/chapterV2MapMain"
	elseif arg_38_0 == ChapterConst.CHAPTER_CLIENT_24 then
		return "/chapterV2MapMain"
	elseif arg_38_0 == ChapterConst.CHAPTER_CLIENT_25 then
		return "/chapterV2MapMain"
	else
		print("未实现对应的篇章选择界面")

		return "/chapterVariantXuHengPart3"
	end
end

function var_0_0.GetSubPlotUrl(arg_39_0, arg_39_1)
	local var_39_0
	local var_39_1

	if arg_39_0 == 6010101 then
		var_39_0 = "/osirisStoryRemastered"
	elseif arg_39_0 == 6010102 or arg_39_0 == 6010103 or arg_39_0 == 6010104 then
		var_39_0 = "/hellaStoryRemastered"
	elseif arg_39_0 == 6010105 then
		var_39_0 = "/hellaStoryRemastered"
	elseif arg_39_0 == 6010106 or arg_39_0 == 6010107 then
		if arg_39_1 then
			var_39_0 = "/summerStoryMainRemastered"
		elseif arg_39_0 == 6010106 then
			var_39_0 = "/summerStoryRemastered"
		elseif arg_39_0 == 6010107 then
			local var_39_2 = ChapterCfg[arg_39_0]

			var_39_1 = BattleStageData:GetStageData()[var_39_2.section_id_list[1]] == nil

			if var_39_1 then
				var_39_0 = "/summerStoryMainRemastered"

				ShowTips("ACTIVITY_FINISH_ALL_SUMMER_STORY")
			else
				var_39_0 = "/summerSeabedStoryRemastered"
			end
		end
	else
		var_39_0 = arg_39_0 == 6010109 and "/subPlotHera" or (arg_39_0 == 6010110 or arg_39_0 == 6010111 or arg_39_0 == 6010112) and "/activityFactoryStoryStage" or arg_39_0 == 6010113 and "/subPlotTyr" or (arg_39_0 == 6010116 or arg_39_0 == 6010117) and "/subPlotLuWuAndZhiMing" or (arg_39_0 == 6010118 or arg_39_0 == 6010119) and (arg_39_1 and "/chapterVariantThoth" or "/subPlotSection") or arg_39_0 == 6010121 and "/summerChessBoardMainEntry" or (arg_39_0 == 6010122 or arg_39_0 == 6010123) and "/subPlotOuMoFeiSi" or (arg_39_0 == 6010124 or arg_39_0 == 6010125) and "/subPlotBaiChao" or (arg_39_0 == 6010126 or arg_39_0 == 6010127) and "/subPlotKeErGai" or arg_39_0 == 6010128 and "/skuldSystemMainView" or arg_39_0 == 6010108 and "/athenaStoryStage" or arg_39_0 == 6010129 and "/subPlotLinKage_4_2View" or arg_39_0 == 6010134 and "/subPlotNoah" or "/subPlotSection"
	end

	return var_39_0, var_39_1
end

function var_0_0.GetOpenSubPlotClient()
	local var_40_0
	local var_40_1 = -1
	local var_40_2 = ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT]

	for iter_40_0 = #var_40_2, 1, -1 do
		local var_40_3 = var_40_2[iter_40_0]
		local var_40_4 = ChapterClientCfg[var_40_3]
		local var_40_5 = ChapterClientCfg[var_40_3]

		if var_40_5.show_tag_type == ChapterConst.SHOW_TYPE.LIMIT_TIME then
			local var_40_6 = ChapterCfg[var_40_5.chapter_list[1]].activity_id

			if ActivityData:GetActivityIsOpen(var_40_6) then
				return var_40_3
			end
		elseif var_40_1 < var_40_4.sort then
			var_40_1 = var_40_4.sort

			for iter_40_1, iter_40_2 in ipairs(var_40_4.chapter_list) do
				var_40_0 = var_40_3

				break
			end
		end
	end

	if var_40_0 then
		return var_40_0
	else
		return var_40_2[#var_40_2]
	end
end

function var_0_0.IsUnlockSubPlotClient(arg_41_0)
	local var_41_0 = ChapterCfg[arg_41_0].clientID
	local var_41_1 = ChapterClientCfg[var_41_0].chapter_list[1]
	local var_41_2, var_41_3 = var_0_0.IsOpenSubPlotByTime(var_41_1)

	if not var_41_2 then
		local var_41_4 = GetTips("OPEN_TIME")

		return false, string.format(var_41_4, manager.time:GetLostTimeStr(var_41_3))
	end

	return true
end

function var_0_0.GetSubPlotMaxStageID(arg_42_0)
	local var_42_0 = ChapterCfg[arg_42_0].clientID
	local var_42_1 = ChapterClientCfg[var_42_0]
	local var_42_2 = var_42_1.chapter_list[1]
	local var_42_3 = ChapterCfg[var_42_2].section_id_list[1]
	local var_42_4 = BattleStageData:GetStageData()

	for iter_42_0, iter_42_1 in ipairs(var_42_1.chapter_list) do
		if var_0_0.IsOpenSubPlotByTime(iter_42_1) then
			for iter_42_2, iter_42_3 in ipairs(ChapterCfg[iter_42_1].section_id_list) do
				if var_42_4[iter_42_3] then
					var_42_3 = iter_42_3
					var_42_2 = iter_42_1
				else
					return var_42_2, var_42_3
				end
			end
		end
	end

	return var_42_2, var_42_3
end

function var_0_0.IsOpenSubPlotByTime(arg_43_0)
	local var_43_0 = ChapterCfg[arg_43_0].activity_id
	local var_43_1 = ActivityData:GetActivityRefreshTime(var_43_0)

	if var_43_1 == 0 or var_43_1 < manager.time:GetServerTime() then
		return true, var_43_1
	end

	return false, var_43_1
end

function var_0_0.DoReadyBattle(arg_44_0, arg_44_1)
	local var_44_0 = BattleStageTools.GetStageCfg(arg_44_0, arg_44_1)

	if BattleConst.BATTLE_TAG.STORY == var_44_0.tag then
		BattleController.GetInstance():LaunchStoryBattle(arg_44_0, arg_44_1, 0)
	else
		gameContext:Go("/sectionSelectHero", {
			section = arg_44_1,
			sectionType = arg_44_0
		})
	end
end

function var_0_0.GetChapterChallengeLnkList()
	local var_45_0 = {}
	local var_45_1 = PlayerData:GetPlayerInfo().userLevel
	local var_45_2 = GameLevelSetting[var_45_1].challenge_lnk_id_list
	local var_45_3 = GameLevelSetting[var_45_1].challenge_next_id_list

	if var_45_3 and #var_45_3 > 0 then
		for iter_45_0, iter_45_1 in ipairs(var_45_2) do
			if not ChapterTools.IsChapterSystemLock(iter_45_1) and var_0_0.CheckSystemShow(iter_45_1) and #var_45_0 < 3 then
				table.insert(var_45_0, iter_45_1)
			end
		end

		table.insert(var_45_0, var_45_3[1])
	else
		for iter_45_2, iter_45_3 in ipairs(var_45_2) do
			if not ChapterTools.IsChapterSystemLock(iter_45_3) and var_0_0.CheckSystemShow(iter_45_3) and #var_45_0 < 4 then
				table.insert(var_45_0, iter_45_3)
			end
		end
	end

	return var_45_0
end

function var_0_0.CheckSystemShow(arg_46_0)
	if arg_46_0 == 2011 or arg_46_0 == 2012 or arg_46_0 == 2013 or arg_46_0 == 2014 or arg_46_0 == 2015 or arg_46_0 == 2016 or arg_46_0 == 202 or arg_46_0 == 203 or arg_46_0 == 204 then
		return true
	end

	if arg_46_0 == 205 then
		return #EquipSeizureData:GetReceiveList() < #EquipSeizurePointRewardCfg.all
	end

	if arg_46_0 == 301 then
		local var_46_0 = BattleBossChallengeData:GetSelectMode()
		local var_46_1
		local var_46_2

		if var_46_0 == BossConst.MODE_NONE then
			return true
		elseif var_46_0 == BossConst.MODE_NORMAL then
			var_46_1 = BattleBossChallengeNormalData:GetReceiveStarList()
			var_46_2 = BattleBossChallengeNormalData:GetBossChallengeCfg().reward
		else
			var_46_1 = BattleBossChallengeAdvanceData:GetReceiveRewardList()
			var_46_2 = BattleBossChallengeAdvanceData:GetSortRewardList()
		end

		return #var_46_1 < #var_46_2
	end

	if arg_46_0 == 302 then
		local var_46_3
		local var_46_4

		if MythicData:GetDifficulty() == MythicData:GetFinalId() then
			var_46_3 = MythicData:GetFinalIsReward()
			var_46_4 = #MythicFinalCfg.all
		else
			var_46_3 = MythicData:GetStarRewardCount()
			var_46_4 = 3
		end

		return var_46_3 < var_46_4
	end

	if arg_46_0 == 305 then
		local var_46_5 = CoreVerificationData:CheckCycleReward()
		local var_46_6 = not CoreVerificationChallengeTools.CheckCycleReward()

		return var_46_5 or var_46_6
	end

	if arg_46_0 == 401 then
		return (TowerData:CheckTowerOver())
	end

	if arg_46_0 == 701 then
		local var_46_7 = SPHeroChallengeData:GetActivityData(ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1)

		return var_46_7 and not var_46_7:CheckDailyScheduleAwardReceived() and (not var_46_7:CheckHasReceiveHeroAward() or not var_46_7:CheckHasReceiveWeaponAward())
	end
end

function var_0_0.GetSystemRewardInfo(arg_47_0)
	local var_47_0
	local var_47_1

	if arg_47_0 == 2011 or arg_47_0 == 2012 or arg_47_0 == 2013 or arg_47_0 == 2014 or arg_47_0 == 2015 or arg_47_0 == 2016 or arg_47_0 == 204 then
		local var_47_2 = 2010101
		local var_47_3 = ChapterCfg[arg_47_0].section_id_list

		for iter_47_0, iter_47_1 in ipairs(var_47_3) do
			local var_47_4 = BattleDailyStageCfg[iter_47_1]
			local var_47_5 = PlayerData:GetPlayerInfo().userLevel

			if BattleStageData:GetStageData()[iter_47_1] and var_47_5 >= var_47_4.level then
				var_47_2 = iter_47_1
			end
		end

		local var_47_6 = BattleDailyStageCfg[var_47_2].drop_lib_id
		local var_47_7 = getRewardFromDropCfg(var_47_6, false)

		if var_47_7[1] then
			var_47_0 = var_47_7[1].id
		end

		if var_47_7[2] then
			var_47_1 = var_47_7[2].id
		end
	end

	if arg_47_0 == 202 then
		local var_47_8 = 2020011
		local var_47_9 = BattleEquipData:GetBattleEquipData().baseStageId or 30004
		local var_47_10 = StageGroupCfg[var_47_9].stage_list

		for iter_47_2, iter_47_3 in ipairs(var_47_10) do
			local var_47_11 = BattleInstance.GetHardLevel(iter_47_3)
			local var_47_12 = GameSetting.equip_stage_unlock.value

			if not JumpTools.IsConditionLocked({
				ViewConst.SYSTEM_LOCK_TYPE.LEVEL,
				var_47_12[var_47_11]
			}) then
				var_47_8 = iter_47_3
			end
		end

		local var_47_13 = BattleEquipStageCfg[var_47_8].drop_lib_id
		local var_47_14 = getRewardFromDropCfg(var_47_13, false)

		if var_47_14[1] then
			var_47_0 = var_47_14[1].id
		end

		if var_47_14[2] then
			var_47_1 = var_47_14[2].id
		end
	end

	if arg_47_0 == 401 then
		var_47_0, var_47_1 = TowerData:GetMaxLevelReward()
	end

	if arg_47_0 == 203 then
		var_47_0 = 40603
		var_47_1 = 40602
	end

	if arg_47_0 == 205 then
		var_47_0 = 40504
		var_47_1 = 47
	end

	if arg_47_0 == 301 then
		local var_47_15 = BattleBossChallengeData:GetSelectMode()

		if var_47_15 == BossConst.MODE_NONE then
			if #BattleBossChallengeData:GetOpenModeList() >= 2 then
				var_47_0 = 42
				var_47_1 = 1
			else
				var_47_0 = 41
				var_47_1 = 1
			end
		elseif var_47_15 == BossConst.MODE_NORMAL then
			var_47_0 = 41
			var_47_1 = 1
		else
			var_47_0 = 42
			var_47_1 = 1
		end
	end

	if arg_47_0 == 302 then
		if MythicData:GetDifficulty() == MythicData:GetFinalId() then
			var_47_0 = 40701
			var_47_1 = 43
		else
			var_47_0 = 40701
			var_47_1 = 25
		end
	end

	if arg_47_0 == 305 then
		var_47_0 = 40415
		var_47_1 = 40310
	end

	if arg_47_0 == 701 then
		var_47_0 = SPHeroChallengeData.activityCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].heroID or 0

		local var_47_16 = ShopCfg[SPHeroChallengeData.activityCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].shopItemID]

		var_47_1 = var_47_16 and var_47_16.give_id or 0
	end

	return {
		var_47_0,
		var_47_1
	}
end

function var_0_0.SortChapterLnk(arg_48_0, arg_48_1)
	table.sort(arg_48_0, function(arg_49_0, arg_49_1)
		local var_49_0 = arg_49_0
		local var_49_1 = arg_49_1
		local var_49_2 = 0
		local var_49_3 = 0

		if arg_48_1 then
			var_49_2 = var_0_0.GetChallengeNextRefreshTimeStamp(var_49_0)
			var_49_3 = var_0_0.GetChallengeNextRefreshTimeStamp(var_49_1)
		end

		if var_49_2 == var_49_3 then
			return arg_49_0 < arg_49_1
		elseif var_49_2 ~= 0 and var_49_3 ~= 0 then
			return var_49_2 < var_49_3
		else
			return var_49_2 ~= 0
		end
	end)

	return arg_48_0
end

function var_0_0.GetChallengeNextRefreshTimeStamp(arg_50_0)
	local var_50_0 = ChapterClientCfg[arg_50_0].chapter_list[1]
	local var_50_1 = ChapterCfg[var_50_0]

	if var_50_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
		return BattleBossChallengeData:GetNextRefreshTime()
	elseif var_50_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC then
		return MythicData:GetNextRefreshTime()
	elseif var_50_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		local var_50_2 = PolyhedronData:GetActivityID()

		return ActivityData:GetActivityData(var_50_2).stopTime
	elseif var_50_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING or var_50_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING then
		-- block empty
	elseif var_50_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ABYSS then
		return AbyssData:GetRefreshTimestamp()
	elseif var_50_1.type == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON then
		return SoloHeartDemonData:GetDataByPara("remainTime")
	elseif var_50_1.type == BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE then
		return EquipSeizureData:NextRefreshTimestamp()
	elseif var_50_1.type == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION then
		return CoreVerificationData:GetRefreshTime()
	end

	return 0
end

function var_0_0.GetRedPoint(arg_51_0)
	local var_51_0 = ChapterClientCfg[arg_51_0].chapter_list[1]
	local var_51_1 = ChapterCfg[var_51_0]

	if var_51_1.type == BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE then
		return RedPointConst.EQUIP_SEIZURE
	elseif var_51_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP then
		return RedPointConst.BATTLE_EQUIP
	elseif var_51_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
		return RedPointConst.BOSS_CHALLENGE
	elseif var_51_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC then
		if MythicData:GetDifficulty() == MythicData:GetFinalId() then
			return RedPointConst.MYTHIC_FINAL_AWARD
		else
			return RedPointConst.MYTHIC_TIMES_AWARD
		end
	elseif var_51_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		return RedPointConst.POLYHEDRON
	elseif var_51_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING then
		return RedPointConst.TEACH
	elseif var_51_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ABYSS then
		return RedPointConst.ABYSS
	elseif var_51_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		return RedPointConst.WARCHESS
	elseif var_51_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER then
		return RedPointConst.TOWER
	elseif var_51_1.type == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON then
		return RedPointConst.SOLO_HEART_DEMON
	elseif var_51_1.type == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION then
		return RedPointConst.CORE_VERIFICATION
	elseif var_51_1.type == BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1 then
		return RedPointConst.SP_HERO_CHALLENGE_3_1
	elseif var_51_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY then
		return table.concat({
			RedPointConst.STAGE_TYPE_DAILY,
			"_",
			var_51_0
		})
	elseif var_51_1.type == BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM then
		return RedPointConst.CHALLENGE_ROGUE_TEAM
	end

	return RedPointConst.COMBAT_UNLL
end

function var_0_0.HasStageIDByDay(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_52_0][arg_52_1]

	for iter_52_0, iter_52_1 in ipairs(var_52_0) do
		for iter_52_2, iter_52_3 in ipairs(ChapterMapCfg[iter_52_1].location_list) do
			if table.keyof(ChapterLocationCfg[iter_52_3].stage_list, arg_52_2) then
				return true
			end
		end
	end

	return false
end

function var_0_0.IsNeedOperateFirstDayWatch(arg_53_0, arg_53_1)
	local var_53_0 = GameSetting.chapter19_activate.value[1]
	local var_53_1 = BattleStageData:GetStageData()[var_53_0]

	return var_53_1 and var_53_1.clear_times >= 1 and not BattleStageData:GetOperateChapterDay(arg_53_0, arg_53_1) and var_0_0.HasStageIDByDay(arg_53_0, arg_53_1, var_53_0)
end

function var_0_0.IsNeedOperateLastDayWatch(arg_54_0, arg_54_1)
	local var_54_0 = var_0_0.GetChapterDayList(arg_54_0)

	if #var_54_0 >= GameSetting.chapter19_timeline.value[1] and arg_54_1 ~= var_54_0[#var_54_0 - 1] then
		return false
	end

	local var_54_1 = GameSetting.chapter19_exit.value[1]
	local var_54_2 = BattleStageData:GetStageData()[var_54_1]

	return var_54_2 and var_54_2.clear_times >= 1 and not BattleStageData:GetOperateChapterDay(arg_54_0, var_54_0[GameSetting.chapter19_timeline.value[1]])
end

function var_0_0.IsUnlockScan()
	local var_55_0 = GameSetting.chapter19_scan_unlock.value[1]
	local var_55_1 = BattleStageData:GetStageData()[var_55_0]

	return var_55_1 and var_55_1.clear_times >= 1
end

function var_0_0.HasUnscanClue(arg_56_0)
	if not var_0_0.IsUnlockScan() then
		return false
	end

	local var_56_0 = ChapterMapCfg[arg_56_0]

	for iter_56_0, iter_56_1 in ipairs(var_56_0.location_list) do
		local var_56_1 = ChapterLocationCfg[iter_56_1]
		local var_56_2 = var_56_1.type

		if var_56_1.need_scan == 1 and BattleStageData:GetMapLocationData(arg_56_0)[iter_56_1] == nil then
			return true
		end
	end

	return false
end

function var_0_0.HasClueLocation(arg_57_0)
	if not var_0_0.IsUnlockScan() then
		return false
	end

	local var_57_0 = ChapterMapCfg[arg_57_0]

	for iter_57_0, iter_57_1 in ipairs(var_57_0.location_list) do
		local var_57_1 = ChapterLocationCfg[iter_57_1]
		local var_57_2 = var_57_1.type

		if var_57_1.need_scan == 1 and var_57_2 == BattleConst.LOCATION_TYPE.CLUE or var_57_2 == BattleConst.LOCATION_TYPE.BATTLE_CLUE then
			return true
		end
	end

	return false
end

function var_0_0.GetChapterClueCnt(arg_58_0)
	local var_58_0 = 0
	local var_58_1 = 0

	for iter_58_0, iter_58_1 in ipairs(ChapterMapCfg.get_id_list_by_chapter_id[arg_58_0]) do
		local var_58_2 = BattleStageData:GetMapLocationData(iter_58_1)

		for iter_58_2, iter_58_3 in ipairs(ChapterMapCfg[iter_58_1].location_list) do
			local var_58_3 = ChapterLocationCfg[iter_58_3]

			if var_58_3.type == BattleConst.LOCATION_TYPE.CLUE or var_58_3.type == BattleConst.LOCATION_TYPE.BATTLE_CLUE then
				var_58_0 = var_58_0 + 1

				if var_58_2[iter_58_3] and var_58_2[iter_58_3] ~= 0 then
					var_58_1 = var_58_1 + 1
				end
			end
		end
	end

	return var_58_1, var_58_0
end

function var_0_0.GetChapterCollectClueList(arg_59_0)
	local var_59_0 = {}

	for iter_59_0, iter_59_1 in ipairs(ChapterMapCfg.get_id_list_by_chapter_id[arg_59_0]) do
		local var_59_1 = BattleStageData:GetMapLocationData(iter_59_1)

		for iter_59_2, iter_59_3 in ipairs(ChapterMapCfg[iter_59_1].location_list) do
			local var_59_2 = ChapterLocationCfg[iter_59_3]

			if (var_59_2.type == BattleConst.LOCATION_TYPE.CLUE or var_59_2.type == BattleConst.LOCATION_TYPE.BATTLE_CLUE) and var_59_1[iter_59_3] and var_59_1[iter_59_3] ~= 0 then
				table.insert(var_59_0, var_59_1[iter_59_3])
			end
		end
	end

	table.sort(var_59_0, function(arg_60_0, arg_60_1)
		return arg_60_0 < arg_60_1
	end)

	return var_59_0
end

function var_0_0.GetChapterAudioIDList(arg_61_0)
	local var_61_0 = ChapterMapCfg[arg_61_0].audio_id
	local var_61_1 = {}

	for iter_61_0 = #var_61_0, 1, -1 do
		local var_61_2 = var_61_0[iter_61_0]
		local var_61_3 = ChapterAudioCfg[var_61_2]

		if var_61_3.unlock_by_stage_id ~= 0 then
			local var_61_4 = BattleStageData:GetStageData()[var_61_3.unlock_by_stage_id]

			if var_61_4 and var_61_4.clear_times > 0 then
				return {
					var_61_2
				}
			end
		else
			table.insert(var_61_1, 1, var_61_2)
		end
	end

	return var_61_1
end

function var_0_0.GetSkuildAudio()
	local var_62_0 = 11
	local var_62_1 = SkuldStageCfg.all

	for iter_62_0 = #var_62_1, 1, -1 do
		local var_62_2 = var_62_1[iter_62_0]
		local var_62_3 = ChapterAudioCfg.get_id_list_by_unlock_by_skuld_stage_id[var_62_2]

		if var_62_3 and SkuldSystemData:GetLevelIDIsClear(var_62_2) then
			return var_62_3[1]
		end
	end

	return var_62_0
end

function var_0_0.GetChapterDayList(arg_63_0)
	local var_63_0 = {}

	for iter_63_0, iter_63_1 in pairs(ChapterMapCfg.get_id_list_by_chapter_id_day[arg_63_0]) do
		table.insert(var_63_0, iter_63_0)
	end

	table.sort(var_63_0, function(arg_64_0, arg_64_1)
		return arg_64_0 < arg_64_1
	end)

	return var_63_0
end

function var_0_0.IsLastDay(arg_65_0, arg_65_1)
	local var_65_0 = var_0_0.GetChapterDayList(arg_65_0)

	return GameSetting.chapter19_timeline.value[1] == table.keyof(var_65_0, arg_65_1)
end

function var_0_0.IsNeedExpandDay(arg_66_0)
	local var_66_0 = var_0_0.GetChapterDayList(arg_66_0)

	for iter_66_0, iter_66_1 in ipairs(var_66_0) do
		if iter_66_0 ~= 1 and iter_66_0 ~= 2 and iter_66_0 ~= GameSetting.chapter19_timeline.value[1] and var_0_0.IsNeedGuildDay(arg_66_0, iter_66_1) then
			return true
		end
	end

	return false
end

function var_0_0.IsNeedGuildDay(arg_67_0, arg_67_1)
	local var_67_0 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_67_0][arg_67_1][1]
	local var_67_1 = ChapterMapCfg[var_67_0].location_list[1]
	local var_67_2 = ChapterLocationCfg[var_67_1].stage_list[1]
	local var_67_3 = BattleStageData:GetStageData()[var_67_2]
	local var_67_4 = var_0_0.GetChapterDayList(arg_67_0)
	local var_67_5 = table.keyof(var_67_4, arg_67_1)

	if var_67_5 == 2 or var_67_5 == GameSetting.chapter19_timeline.value[1] then
		return false
	end

	if var_67_3 and var_67_3.clear_times <= 0 and var_0_0.IsUnlockChapterDay(arg_67_0, arg_67_1) and not BattleStageData:GetOperateChapterDay(arg_67_0, arg_67_1) and not var_0_0.IsLastDay(arg_67_0, arg_67_1) then
		return true
	end

	return false
end

function var_0_0.IsUnlockChapterDay(arg_68_0, arg_68_1)
	if not ChapterTools.IsClearPreChapterDayAllStage(arg_68_0, arg_68_1) then
		return false
	end

	local var_68_0 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_68_0][arg_68_1][1]
	local var_68_1 = ChapterMapCfg[var_68_0]

	if ActivityTools.GetActivityStatus(var_68_1.activity_id) == 0 then
		return false
	end

	return true
end

function var_0_0.IsClearPreChapterDayAllStage(arg_69_0, arg_69_1)
	local var_69_0 = var_0_0.GetChapterDayList(arg_69_0)
	local var_69_1 = table.keyof(var_69_0, arg_69_1)

	if var_69_1 == 1 then
		return true
	end

	local var_69_2 = var_69_0[var_69_1 - 1]

	return var_0_0.IsClearChapterDayAllStage(arg_69_0, var_69_2)
end

function var_0_0.IsClearChapterDayAllStage(arg_70_0, arg_70_1)
	for iter_70_0, iter_70_1 in ipairs(ChapterMapCfg.get_id_list_by_chapter_id_day[arg_70_0][arg_70_1]) do
		if var_0_0.IsClearMapAllStage(iter_70_1) == false then
			return false
		end
	end

	return true
end

function var_0_0.IsClearMapAllStage(arg_71_0)
	for iter_71_0, iter_71_1 in ipairs(ChapterMapCfg[arg_71_0].location_list) do
		if var_0_0.IsClearLocationAllStage(iter_71_1) == false then
			return false
		end
	end

	return true
end

function var_0_0.IsClearLocationAllStage(arg_72_0)
	for iter_72_0, iter_72_1 in ipairs(ChapterLocationCfg[arg_72_0].stage_list) do
		local var_72_0 = BattleStageData:GetStageData()[iter_72_1]

		if not var_72_0 or not (var_72_0.clear_times > 0) then
			return false
		end
	end

	return true
end

function var_0_0.GetUnclearMainStageLocationID(arg_73_0)
	for iter_73_0, iter_73_1 in ipairs(ChapterMapCfg[arg_73_0].location_list) do
		local var_73_0 = ChapterLocationCfg[iter_73_1].stage_list

		for iter_73_2, iter_73_3 in ipairs(var_73_0) do
			local var_73_1 = BattleStageData:GetStageData()[iter_73_3]

			if var_73_1 and var_73_1.clear_times <= 0 then
				return iter_73_1
			end
		end
	end

	return nil
end

function var_0_0.NeedShowSwitchMapGuild(arg_74_0, arg_74_1, arg_74_2)
	if var_0_0.GetUnclearMainStageLocationID(arg_74_2) then
		return false
	end

	local var_74_0 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_74_0][arg_74_1]

	for iter_74_0, iter_74_1 in ipairs(var_74_0) do
		if iter_74_1 ~= arg_74_2 and var_0_0.GetUnclearMainStageLocationID(iter_74_1) then
			return true
		end
	end

	return false
end

function var_0_0.HasNewLocationMainStage(arg_75_0)
	local var_75_0 = ChapterLocationCfg[arg_75_0]

	for iter_75_0, iter_75_1 in ipairs(var_75_0.stage_list) do
		local var_75_1 = BattleStageData:GetStageData()[iter_75_1]

		if var_75_1 and var_75_1.clear_times <= 0 then
			return true
		end
	end

	return false
end

function var_0_0.HasNewLocationStage(arg_76_0, arg_76_1)
	local var_76_0 = ChapterLocationCfg[arg_76_1]

	for iter_76_0, iter_76_1 in ipairs(var_76_0.sub_stage_list) do
		local var_76_1 = BattleStageData:GetStageData()[iter_76_1]

		if var_76_1 and var_76_1.clear_times <= 0 then
			return true
		end
	end

	for iter_76_2, iter_76_3 in ipairs(var_76_0.event_list) do
		if var_0_0.IsUnlockEvent(iter_76_3) and not var_0_0.HasReadEventID(iter_76_3) then
			return true
		end
	end

	if #var_76_0.clue > 0 then
		local var_76_2 = BattleStageData:GetMapLocationData(arg_76_0)[arg_76_1]

		if var_76_2 == nil or var_76_2 == 0 then
			return true
		end
	end

	return false
end

function var_0_0.IsReadFirstEvent(arg_77_0)
	for iter_77_0, iter_77_1 in ipairs(ChapterStoryCollectCfg.get_id_list_by_chapter_id[arg_77_0]) do
		if var_0_0.HasReadEvent(iter_77_1) then
			return true
		end
	end

	return false
end

function var_0_0.HasReadEvent(arg_78_0)
	for iter_78_0, iter_78_1 in ipairs(ChapterStoryCollectCfg[arg_78_0].story_id_list) do
		if var_0_0.HasReadEventID(iter_78_1) then
			return true
		end
	end

	return false
end

function var_0_0.HasReadEventID(arg_79_0)
	return BattleStageData:HasReadLocationEvent(arg_79_0)
end

function var_0_0.IsUnlockEvent(arg_80_0)
	local var_80_0 = StageArchiveCfg[arg_80_0]

	if var_80_0.unlock_by_stage_id ~= 0 then
		local var_80_1 = BattleStageData:GetStageData()[var_80_0.unlock_by_stage_id]

		if var_80_1 and var_80_1.clear_times > 0 then
			-- block empty
		else
			return false
		end
	end

	return true
end

function var_0_0.NeedShowLocation(arg_81_0, arg_81_1)
	local var_81_0 = ChapterLocationCfg[arg_81_1]

	if var_81_0.unlock_stage_id ~= 0 then
		local var_81_1 = BattleStageData:GetStageData()[var_81_0.unlock_stage_id]

		if var_81_1 and var_81_1.clear_times > 0 then
			-- block empty
		else
			return false
		end
	end

	local var_81_2 = BattleStageData:GetStageData()[var_81_0.show_by_stage_id]

	if var_81_2 and var_81_2.clear_times > 0 then
		return true
	end

	local var_81_3 = BattleStageData:GetStageData()[var_81_0.hide_by_stage_id]

	if var_81_3 and var_81_3.clear_times > 0 then
		return false
	end

	if var_81_0.type == BattleConst.LOCATION_TYPE.CLUE or var_81_0.type == BattleConst.LOCATION_TYPE.BATTLE_CLUE then
		local var_81_4 = BattleStageData:GetMapLocationData(arg_81_0)

		if var_81_0.need_scan == 1 and (not var_81_4 or not var_81_4[arg_81_1]) then
			return false
		else
			return true
		end
	end

	for iter_81_0, iter_81_1 in pairs(var_81_0.stage_list) do
		if BattleStageData:GetStageData()[iter_81_1] then
			return true
		end
	end

	for iter_81_2, iter_81_3 in pairs(var_81_0.sub_stage_list) do
		if BattleStageData:GetStageData()[iter_81_3] then
			return true
		end
	end

	for iter_81_4, iter_81_5 in ipairs(var_81_0.event_list) do
		if var_0_0.IsUnlockEvent(iter_81_5) then
			return true
		end
	end

	return false
end

function var_0_0.IsReadClue(arg_82_0, arg_82_1)
	local var_82_0 = BattleStageData:GetMapLocationData(arg_82_0)

	if var_82_0 and var_82_0[arg_82_1] and var_82_0[arg_82_1] ~= 0 then
		return true
	end

	return false
end

function var_0_0.IsEnableLocation(arg_83_0)
	if not var_0_0.IsNeedShowFog() then
		return true
	end

	return ChapterLocationCfg[arg_83_0].can_not_click_until_unlock_fog ~= 1
end

function var_0_0.GetChapter19MapState(arg_84_0)
	local var_84_0 = ChapterMapCfg[arg_84_0]

	if var_84_0.unlock_map_state_by_stage_id == "" then
		return 0
	end

	for iter_84_0, iter_84_1 in ipairs(var_84_0.unlock_map_state_by_stage_id) do
		if not var_0_0.IsClearStage(iter_84_1) then
			return iter_84_0 - 1
		end
	end

	return 0
end

function var_0_0.IsNeedShowFog()
	local var_85_0 = GameSetting.chapter19_fog_dissipation.value[1]

	if var_0_0.IsClearStage(var_85_0) then
		return false
	end

	return true
end

function var_0_0.NeedPlayFogAnimator()
	local var_86_0 = GameSetting.chapter19_fog_dissipation.value[1]
	local var_86_1 = BattleChapterStageCfg[var_86_0].next_unlock_id_list

	if BattleStageData:GetFogAnimatorFlag() or var_0_0.IsClearStage(var_86_1) then
		return false
	end

	return true
end

function var_0_0.GetChapterGroupList(arg_87_0)
	local var_87_0 = ChapterClientCfg[arg_87_0]
	local var_87_1 = {}

	if var_87_0.toggle == BattleConst.TOGGLE.PLOT then
		local var_87_2 = var_87_0.difficulty
		local var_87_3 = ChapterMainPlotToggleCfg.get_id_list_by_difficulty[var_87_2]

		for iter_87_0, iter_87_1 in ipairs(var_87_3) do
			local var_87_4 = ChapterMainPlotToggleCfg[iter_87_1].chapter_client_list

			if table.keyof(var_87_4, arg_87_0) then
				for iter_87_2, iter_87_3 in ipairs(var_87_4) do
					table.insert(var_87_1, {
						2,
						iter_87_3
					})
				end
			elseif #var_87_4 == 1 then
				table.insert(var_87_1, {
					2,
					var_87_4[1]
				})
			else
				table.insert(var_87_1, {
					1,
					iter_87_1
				})
			end
		end
	elseif var_87_0.toggle == BattleConst.TOGGLE.SUB_PLOT then
		local var_87_5 = ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT]

		for iter_87_4, iter_87_5 in ipairs(var_87_5) do
			local var_87_6 = ChapterClientCfg[iter_87_5]

			if var_87_6.show_tag_type == ChapterConst.SHOW_TYPE.LIMIT_TIME then
				if ActivityData:GetActivityIsOpen(ChapterCfg[var_87_6.chapter_list[1]].activity_id) then
					table.insert(var_87_1, {
						2,
						iter_87_5
					})
				end
			else
				table.insert(var_87_1, {
					2,
					iter_87_5
				})
			end
		end
	end

	return var_87_1
end

function var_0_0.IsChapterSystemLock(arg_88_0)
	local var_88_0 = ChapterClientCfg[arg_88_0]

	if not var_88_0 then
		return false
	end

	if var_88_0.show_tag_type == ChapterConst.SHOW_TYPE.LIMIT_TIME and not ActivityData:GetActivityIsOpen(ChapterCfg[var_88_0.chapter_list[1]].activity_id) then
		return false
	end

	local var_88_1 = type(var_88_0.jump_system) == "table" and var_88_0.jump_system[1]

	return var_88_1 and SystemCfg[var_88_1] and SystemCfg[var_88_1].system_hide == 1
end

function var_0_0.GetChapterShowTypeData(arg_89_0)
	local var_89_0 = ChapterClientCfg[arg_89_0]
	local var_89_1

	return var_89_0.show_tag_type == ChapterConst.SHOW_TYPE.ACTIVITY and "activity" or var_89_0.show_tag_type == ChapterConst.SHOW_TYPE.LIMIT_TIME and "limitTime" or "normal"
end

function var_0_0.GetNormalPlotAndSubPlotChapterList()
	local var_90_0 = {}
	local var_90_1 = ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.PLOT]

	for iter_90_0, iter_90_1 in ipairs(var_90_1) do
		if ChapterCfg[ChapterClientCfg[iter_90_1].chapter_list[1]].difficulty == 1 and ChapterClientCfg[iter_90_1].recommend_order > 0 then
			table.insert(var_90_0, iter_90_1)
		end
	end

	local var_90_2 = ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT]

	for iter_90_2, iter_90_3 in ipairs(var_90_2) do
		if ChapterClientCfg[iter_90_3].recommend_order > 0 then
			table.insert(var_90_0, iter_90_3)
		end
	end

	table.sort(var_90_0, function(arg_91_0, arg_91_1)
		local var_91_0 = ChapterClientCfg[arg_91_0]
		local var_91_1 = ChapterClientCfg[arg_91_1]

		return var_91_0.recommend_order < var_91_1.recommend_order
	end)

	return var_90_0
end

function var_0_0.GetChapterClassIDList()
	return ChapterClassCfg.all
end

function var_0_0.GetBigChapterClassIDList()
	local var_93_0 = {}
	local var_93_1 = ChapterClassCfg.get_id_list_by_big_id

	for iter_93_0, iter_93_1 in ipairs(var_93_1) do
		table.insert(var_93_0, iter_93_0)
	end

	return var_93_0
end

function var_0_0.GetCacheSelectFilterType(arg_94_0)
	return getData("storyTimeline", "filterType" .. arg_94_0) or 0
end

function var_0_0.SetCacheSelectFilterType(arg_95_0, arg_95_1)
	saveData("storyTimeline", "filterType" .. arg_95_1, arg_95_0)
end

function var_0_0.GetCacheSelectTabIndex(arg_96_0)
	return getData("storyTimeline", "tabIndex" .. arg_96_0) or 1
end

function var_0_0.SetCacheSelectTabIndex(arg_97_0, arg_97_1)
	saveData("storyTimeline", "tabIndex" .. arg_97_1, arg_97_0)
end

function var_0_0.GetCacheSelectChapterClientID(arg_98_0)
	return getData("storyTimeline", "chapterClientID" .. arg_98_0) or 0
end

function var_0_0.SetCacheSelectChapterClientID(arg_99_0, arg_99_1)
	saveData("storyTimeline", "chapterClientID" .. arg_99_1, arg_99_0)
end

function var_0_0.GetCacheSelectChapterID(arg_100_0)
	return getData("storyTimeline", "chapterID" .. arg_100_0) or 0
end

function var_0_0.SetCacheSelectChapterID(arg_101_0, arg_101_1)
	saveData("storyTimeline", "chapterID" .. arg_101_1, arg_101_0)
end

function var_0_0.GetChapterClientIDByChapterID(arg_102_0)
	for iter_102_0, iter_102_1 in ipairs(ChapterClientCfg.all) do
		for iter_102_2, iter_102_3 in ipairs(ChapterClientCfg[iter_102_1].chapter_list) do
			if iter_102_3 == arg_102_0 then
				return iter_102_1
			end
		end
	end

	return 0
end

function var_0_0.GetLockPreChapterCount(arg_103_0)
	local var_103_0 = 0
	local var_103_1 = 0
	local var_103_2 = ChapterCfg[arg_103_0].pre_chapter

	if not var_103_2 or #var_103_2 == 0 then
		return 0
	end

	for iter_103_0, iter_103_1 in ipairs(var_103_2) do
		if ChapterTools.IsFinishPreChapter(iter_103_1) then
			var_103_0, var_103_1 = var_103_0 + 1, arg_103_0
		else
			local var_103_3
			local var_103_4, var_103_5 = var_0_0.GetLockPreChapterCount(iter_103_1)

			var_103_1 = var_103_5
			var_103_0 = var_103_0 + var_103_4 + 1

			break
		end
	end

	return var_103_0, var_103_1
end

return var_0_0
