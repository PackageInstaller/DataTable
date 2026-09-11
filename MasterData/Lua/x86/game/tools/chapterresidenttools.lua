local var_0_0 = {}
local var_0_1 = false
local var_0_2

local function var_0_4()
	if var_0_2 == nil then
		var_0_2 = {}

		for iter_2_0, iter_2_1 in pairs(ChapterResidentTools.GetResidentChapterList() or {}) do
			if ChapterClientCfg[iter_2_1] and ChapterClientCfg[iter_2_1].activity_id then
				var_0_2[ChapterClientCfg[iter_2_1].activity_id] = true
			end
		end
	end

	return var_0_2
end

function var_0_0.InitRedPoint()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs((ChapterResidentTools.GetResidentChapterOpenList())) do
		manager.redPoint:addGroup(RedPointConst.RESIDENT_ACT .. ChapterClientCfg[iter_3_1].activity_id, {
			ActivityTools.GetRedPointKey(ChapterClientCfg[iter_3_1].activity_id) .. ChapterClientCfg[iter_3_1].activity_id,
			RedPointConst.RESIDENT_ACT_NEW_TAG .. ChapterClientCfg[iter_3_1].activity_id
		})
		table.insert(var_3_0, RedPointConst.RESIDENT_ACT .. ChapterClientCfg[iter_3_1].activity_id)
	end

	manager.redPoint:addGroup(RedPointConst.RESIDENT_ACT, var_3_0)
	ChapterResidentTools.SetNewTag()
end

function var_0_0.SetNewTag()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.RESIDENT_ACT) then
		return
	end

	if var_0_1 then
		return
	end

	var_0_1 = true

	for iter_4_0, iter_4_1 in pairs(var_0_0.GetResidentChapterOpenList() or {}) do
		if not getData("ResidentAct", "NewTag_" .. ChapterClientCfg[iter_4_1].activity_id) then
			manager.redPoint:setTip(RedPointConst.RESIDENT_ACT_NEW_TAG .. ChapterClientCfg[iter_4_1].activity_id, 1, RedPointStyle.SHOW_NEW_TAG)
		else
			manager.redPoint:setTip(RedPointConst.RESIDENT_ACT_NEW_TAG .. ChapterClientCfg[iter_4_1].activity_id, 0, RedPointStyle.SHOW_NEW_TAG)
		end
	end
end

function var_0_0.GetOpenResidentActChapterID()
	local var_5_0

	for iter_5_0, iter_5_1 in pairs((ChapterResidentTools.GetResidentChapterList())) do
		if ActivityData:GetActivityData((ChapterResidentTools.GetResidentActMainID(ChapterClientCfg[iter_5_1].activity_id))).stopTime <= manager.time:GetServerTime() then
			var_5_0 = iter_5_1

			break
		end
	end

	return var_5_0
end

function var_0_0.GetResidentChapterList()
	return ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.RESIDENT_ACT]
end

function var_0_0.GetResidentChapterOpenList()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs((ChapterResidentTools.GetResidentChapterList())) do
		if ActivityData:GetActivityData((ChapterResidentTools.GetResidentActMainID(ChapterClientCfg[iter_7_1].activity_id))).stopTime <= manager.time:GetServerTime() then
			table.insert(var_7_0, iter_7_1)
		end
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		local var_8_0 = ChapterClientCfg[arg_8_0].activity_id
		local var_8_1 = ChapterClientCfg[arg_8_1].activity_id
		local var_8_2 = ChapterResidentTools.GetResidentActFinishState(ChapterClientCfg[arg_8_0].activity_id) and 1 or 0
		local var_8_3 = ChapterResidentTools.GetResidentActFinishState(ChapterClientCfg[arg_8_1].activity_id) and 1 or 0

		if var_8_2 ~= var_8_3 then
			return var_8_2 < var_8_3
		end

		return var_8_1 < var_8_0
	end)

	return var_7_0
end

function var_0_0.GetResidentActMainID(arg_9_0)
	if ChapterResidentTools.IsResidentActList(arg_9_0) then
		return ActivityCfg.get_id_list_by_sub_activity_list[arg_9_0][1]
	else
		return nil
	end
end

function var_0_0.IsResidentActList(arg_10_0)
	return var_0_4()[arg_10_0] == true
end

function var_0_0.GetResidentMainActTime(arg_11_0)
	local var_11_0 = ChapterResidentTools.GetResidentActMainID(arg_11_0)

	if var_11_0 then
		local var_11_1 = ActivityData:GetActivityData(var_11_0)

		return var_11_1.startTime, var_11_1.stopTime
	else
		return nil, nil
	end
end

function var_0_0.GetResidentActPrafabPath(arg_12_0)
	return "Widget/System/Activity_Theme/Theme_" .. ChapterClientCfg[arg_12_0].activity_id
end

function var_0_0.GetResidentActProgress(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = 0
	local var_13_2

	if arg_13_0 == ActivityConst.SUMMER_CHESS_BOARD_ENTRY then
		var_13_0 = SummerChessBoardTools.GetChessExploreFinishCnt()
		var_13_1 = GameSetting.summer_chess_board_collect_cnt.value[1]
	elseif arg_13_0 == ActivityConst.ACTIVITY_SKULD_MAIN then
		var_13_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id)
		var_13_1 = GameSetting.skuld_trust_max.value[1]
	elseif arg_13_0 == ActivityConst.ACTIVITY_QUANZHOU_ENTRY then
		var_13_0, var_13_1 = QWorldBookletTools.GetNdLevelInfo()
		var_13_2 = string.format("%s<size=60>/%s</size>", var_13_0, var_13_1)
	elseif arg_13_0 == ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME then
		var_13_1 = #ActivityPointRewardCfg.get_id_list_by_activity_id[arg_13_0]
		var_13_0 = OsirisPlayGameData:GetNum()
	elseif arg_13_0 == ActivityConst.ACTIVITY_NYA_SUMMER_PUB then
		var_13_0, var_13_1 = SummerPubTool:GetTaskInfo()
		var_13_2 = "<size=90><color=\"#F4D179\">" .. var_13_0 .. "</color></size><color=\"#93847D\">/" .. var_13_1 .. "</color>"
	elseif arg_13_0 == ActivityConst.ACTIVITY_ASH_MAIN then
		var_13_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id)
		var_13_1 = GameSetting.skuld_trust_max.value[1]
	elseif arg_13_0 == ActivityConst.ACTIVITY_HODUR_MAIN then
		var_13_0 = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_HODUR_MAIN)
		var_13_1 = #AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_HODUR_MAIN]
	elseif arg_13_0 == ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN then
		var_13_0 = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN)
		var_13_1 = #AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN]
	elseif arg_13_0 == ActivityConst.ACTIVITY_SUMMER_RACE_MAIN then
		var_13_0, var_13_1 = ChapterResidentTools.GetTaskInfo(arg_13_0)
		var_13_2 = string.format("<size=48>%d</size>/%d", math.max(0, var_13_0), math.max(0, var_13_1))
	else
		var_13_0, var_13_1 = TaskTools.GetTaskNumInfo(arg_13_0)
	end

	return var_13_0, var_13_1, var_13_2
end

function var_0_0.GetResidentActFinishState(arg_14_0)
	if arg_14_0 == ActivityConst.SUMMER_CHESS_BOARD_ENTRY then
		return SummerChessBoardTools.GetChessExploreFinishCnt() >= GameSetting.summer_chess_board_collect_cnt.value[1]
	elseif arg_14_0 == ActivityConst.ACTIVITY_SKULD_MAIN then
		for iter_14_0, iter_14_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_MAIN]) do
			if not SkuldSystemData:GetPointRewardIsGet(iter_14_1) then
				return false
			end
		end

		return true
	elseif arg_14_0 == ActivityConst.ACTIVITY_QUANZHOU_ENTRY then
		for iter_14_2, iter_14_3 in ipairs((QWorldBookletTools.GetNdLevelIDList())) do
			if not ActivityPointData:IsCompleteID(iter_14_3) then
				return false
			end
		end

		return true
	elseif arg_14_0 == ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME then
		for iter_14_4, iter_14_5 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME]) do
			if OsirisPlayGameData:IsCompleteID(iter_14_5) ~= 2 then
				return false
			end
		end

		return true
	elseif arg_14_0 == ActivityConst.ACTIVITY_NYA_SUMMER_PUB or arg_14_0 == ActivityConst.ACTIVITY_AUTO_CHESS_MAIN or arg_14_0 == ActivityConst.ACTIVITY_HELLA_PINBALL_MAIN or arg_14_0 == ActivityConst.ACTIVITY_HODUR_MAIN or arg_14_0 == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 or arg_14_0 == ActivityConst.ACTIVITY_ROGUECARD_5_0 then
		local var_14_0 = AssignmentCfg.get_id_list_by_activity_id[arg_14_0]

		if not AssignmentCfg.get_id_list_by_activity_id[arg_14_0] then
			return false
		end

		for iter_14_6, iter_14_7 in ipairs(var_14_0) do
			local var_14_1 = TaskData2:GetTask(iter_14_7)

			if not var_14_1 then
				return false
			end

			if var_14_1.complete_flag < 1 then
				return false
			end
		end

		return true
	elseif arg_14_0 == ActivityConst.ACTIVITY_ASH_MAIN then
		for iter_14_8, iter_14_9 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ASH_MAIN] or {}) do
			if not AshSystemData:GetPointRewardIsGet(iter_14_9) then
				return false
			end
		end

		return true
	elseif arg_14_0 == ActivityConst.ACTIVITY_4_6_MUSIC then
		return false
	elseif arg_14_0 == ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN then
		if not AssignmentCfg.get_id_list_by_activity_id[arg_14_0] then
			return false
		end

		for iter_14_10, iter_14_11 in ipairs(AssignmentCfg.get_id_list_by_activity_id[arg_14_0]) do
			if TaskData2:GetTask(iter_14_11).complete_flag < 1 then
				return false
			end
		end

		for iter_14_12, iter_14_13 in ipairs(MergeBallBuffCfg.all) do
			if #MergeBallBuffCfg[iter_14_13].reward > 0 and (VehicleBallData:GetBuffRewardState(iter_14_13) == nil or VehicleBallData:GetBuffRewardState(iter_14_13) ~= BilliardGameConst.VehicleBallBuffRewardState.RECEIVED) then
				return false
			end
		end

		return true
	elseif arg_14_0 == ActivityConst.ACTIVITY_SUMMER_RACE_MAIN then
		local var_14_3, var_14_4 = ChapterResidentTools.GetTaskInfo(arg_14_0)

		return var_14_4 > 0 and var_14_4 <= var_14_3
	else
		return false
	end
end

function var_0_0.GotoResidentActView(arg_15_0)
	if arg_15_0 == ActivityConst.SUMMER_CHESS_BOARD_ENTRY then
		JumpTools.GoToSystem("/summerChessBoardMainEntry")
	elseif arg_15_0 == ActivityConst.ACTIVITY_SKULD_MAIN then
		JumpTools.OpenPageByJump("/skuldSystemEnterView")
	elseif arg_15_0 == ActivityConst.ACTIVITY_QUANZHOU_ENTRY then
		local var_15_0 = SandPlayMapCfg[QWorldMgr:GetActivityMap(arg_15_0)]
		local var_15_1 = var_15_0 and var_15_0.story_id

		if not (var_15_0 and var_15_0.story_id) or var_15_1 == 0 or manager.story:IsStoryPlayed(var_15_1) then
			LaunchQWorld(false, arg_15_0)
		else
			manager.story:StartStoryById(var_15_1, function()
				LaunchQWorld(false, arg_15_0)
			end)
		end
	elseif arg_15_0 == ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME then
		JumpTools.OpenPageByJump("/osirisPlayGameEnterView", {
			activityID_ = arg_15_0
		})
	elseif arg_15_0 == ActivityConst.ACTIVITY_NYA_SUMMER_PUB then
		SummerPubTool:MainToEnterView()
	elseif arg_15_0 == ActivityConst.ACTIVITY_ASH_MAIN then
		JumpTools.OpenPageByJump("/cowBoyHomeView")
	elseif arg_15_0 == ActivityConst.ACTIVITY_AUTO_CHESS_MAIN then
		JumpTools.OpenPageByJump("/autoChessMain")
	elseif arg_15_0 == ActivityConst.ACTIVITY_4_6_MUSIC then
		JumpTools.OpenPageByJump("/residentMusicGameMainView")
	elseif arg_15_0 == ActivityConst.ACTIVITY_HELLA_PINBALL_MAIN then
		manager.story:CheckBattleStory(5300101, manager.story.BEFORE, function()
			if not PinballData.activityID then
				PinballAction.InitNormalData()
			end

			PinballAction.EnterPinballGameScene()
			manager.story:RemovePlayer()
			saveData("PinballGame", "firstEnter", true)
			PinballAction.UpdateStageRedPoint()
		end)
	elseif arg_15_0 == ActivityConst.ACTIVITY_HODUR_MAIN then
		HodurTools.GotoMainlineView()
	elseif arg_15_0 == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 then
		local var_15_2, var_15_3 = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_AUTO_CHESS_MAIN)

		if var_15_2 < var_15_3 and not getData("auto_chess_pop", "PREVIOUS") then
			JumpTools.OpenPageByJump("autoChessQuitPopView", {
				gameType = AutoChessConst.GAME_TYPE.ONLINE,
				type = AutoChessConst.POP_TYPE.PREVIOUS_ADVICE,
				okCb = function()
					manager.notify:Invoke(CHAPTER_RESIDENT_ACT_SWITCH_VIEW, ActivityConst.ACTIVITY_AUTO_CHESS_MAIN)
				end,
				cancelCb = function()
					JumpTools.OpenPageByJump("/autoChessRemakeMainView")
				end
			})
		else
			JumpTools.OpenPageByJump("/autoChessRemakeMainView")
		end

		saveData("auto_chess_pop", "PREVIOUS", true)
	elseif arg_15_0 == ActivityConst.ACTIVITY_ROGUECARD_5_0 then
		local var_15_4 = RogueCardGameData:GetChallengeBattleId()

		if var_15_4 and tonumber(var_15_4) > 0 then
			RogueCardGameAction.GetStageSaveDataJumpChallenge(var_15_4, 2)
		end

		if PlayerData:GetStoryList()[GameSetting.rogue_card_start_story.value[1]] then
			JumpTools.OpenPageByJump("/rogueCardGameHomeView", {
				isHome = true
			})
		else
			manager.story:StartStoryById(GameSetting.rogue_card_start_story.value[1], function(arg_20_0)
				JumpTools.OpenPageByJump("/rogueCardGameHomeView", {
					isHome = true
				})
			end, false)
		end
	elseif arg_15_0 == ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN then
		JumpTools.OpenPageByJump("/activityWuluoVehicleMainView")
	elseif arg_15_0 == ActivityConst.ACTIVITY_SUMMER_RACE_MAIN then
		SummerRaceAction.OpenMainView({
			playBodyDisplayOnEnter = true,
			playFirstPlotOnEnter = true
		})
	end
end

function var_0_0.OpenResidentActTips(arg_21_0)
	local var_21_0 = ChapterResidentTools.GetResidentActPrefabTips(arg_21_0)

	if var_21_0 then
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_21_0
		})
	else
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = ChapterResidentTools.GetResidentActDescTips(arg_21_0)
		})
	end
end

function var_0_0.GetResidentActDescTips(arg_22_0)
	local var_22_0

	if arg_22_0 == ActivityConst.SUMMER_CHESS_BOARD_ENTRY then
		var_22_0 = GetTips("ACTIVITY_CHESS_BOARD_DESC")
	elseif arg_22_0 == ActivityConst.ACTIVITY_SKULD_MAIN then
		var_22_0 = GetTips("SKULD_SYSTEM_TIPS_1")
	elseif arg_22_0 == ActivityConst.ACTIVITY_QUANZHOU_ENTRY then
		var_22_0 = GetTips("QUANZHOU_DESC")
	elseif arg_22_0 == ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME then
		var_22_0 = GetTips("ACTIVITY_GENERALITY_DESC")
	elseif arg_22_0 == ActivityConst.ACTIVITY_NYA_SUMMER_PUB then
		var_22_0 = GetTips("NYA_SUMMER_ENTRANCE_TIP")
	elseif arg_22_0 == ActivityConst.ACTIVITY_ASH_MAIN then
		var_22_0 = GetTips("ASH_ENTRANCE_TIP")
	elseif arg_22_0 == ActivityConst.ACTIVITY_AUTO_CHESS_MAIN then
		var_22_0 = GetTips("AUTO_CHESS_ENTRANCE_TIP")
	elseif arg_22_0 == ActivityConst.ACTIVITY_HELLA_PINBALL_MAIN then
		var_22_0 = GetTips("PINBALLGAME_GAME_ENTRANCE_TITLE")
	elseif arg_22_0 == ActivityConst.ACTIVITY_HODUR_MAIN then
		var_22_0 = GetTips("ACTIVITY_HODUR_INFO_TIP")
	elseif arg_22_0 == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 then
		var_22_0 = GetTips("AUTO_CHESS_2_ENTRANCE_TIP")
	elseif arg_22_0 == ActivityConst.ACTIVITY_ROGUECARD_5_0 then
		var_22_0 = GetTips("ROGUE_CARD_GAME_DESC")
	elseif arg_22_0 == ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN then
		var_22_0 = GetTips("MERGE_BALL_ENTRANCE_DESC")
	elseif arg_22_0 == ActivityConst.ACTIVITY_SUMMER_RACE_MAIN then
		var_22_0 = GetTips("ACTIVITY_TANK_DESC")
	end

	return var_22_0
end

function var_0_0.GetResidentActPrefabTips(arg_23_0)
	return (arg_23_0 == ActivityConst.ACTIVITY_4_6_MUSIC or nil) and (GameSetting.v210_music_describe and GameSetting.v210_music_describe.value or {})
end

function var_0_0.GetResidentActViewClass(arg_24_0)
	if arg_24_0 == ActivityConst.ACTIVITY_SKULD_MAIN then
		return ChapterResidentActSkuldView
	elseif arg_24_0 == ActivityConst.ACTIVITY_QUANZHOU_ENTRY then
		return ChapterResidentActQuanZhouView
	elseif arg_24_0 == ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME then
		return ChapterResidentActOsirisView
	elseif arg_24_0 == ActivityConst.ACTIVITY_ASH_MAIN then
		return ChapterResidentAshView
	elseif arg_24_0 == ActivityConst.ACTIVITY_HELLA_PINBALL_MAIN then
		return ChapterResidentHellaPinballView
	elseif arg_24_0 == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 then
		return ChapterResidentActAutoChessView_4_8
	elseif arg_24_0 == ActivityConst.ACTIVITY_ROGUECARD_5_0 then
		return ChapterResidentActRogueCardGameView
	elseif arg_24_0 == ActivityConst.ACTIVITY_SUMMER_RACE_MAIN then
		return ChapterResidentSummerRaceView
	else
		return ChapterResidentActBaseView
	end
end

function var_0_0.GetTaskInfo(arg_25_0)
	local var_25_0 = 0

	for iter_25_0, iter_25_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[arg_25_0] or {}) do
		if TaskData2:GetTaskComplete(iter_25_1) then
			var_25_0 = var_25_0 + 1
		elseif AssignmentCfg[iter_25_1] and AssignmentCfg[iter_25_1].need <= TaskData2:GetTaskProgress(iter_25_1) then
			var_25_0 = var_25_0 + 1
		end
	end

	return var_25_0, (AssignmentCfg.get_id_list_by_activity_id[arg_25_0] or nil) and (#AssignmentCfg.get_id_list_by_activity_id[arg_25_0] or 0)
end

return var_0_0
