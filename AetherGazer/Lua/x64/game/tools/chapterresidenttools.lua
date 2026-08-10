local var_0_0 = {}
local var_0_1 = false
local var_0_2

local function var_0_3(arg_1_0)
	local var_1_0 = ActivityToggleCfg and ActivityToggleCfg.get_id_list_by_activity_id and ActivityToggleCfg.get_id_list_by_activity_id[arg_1_0]
	local var_1_1 = type(var_1_0) == "table" and var_1_0[1] or nil
	local var_1_2 = var_1_1 ~= nil and ActivityToggleCfg[var_1_1] or nil

	if var_1_2 ~= nil and var_1_2.desc ~= nil then
		return GetI18NText(var_1_2.desc)
	end

	return ""
end

local function var_0_4()
	if var_0_2 == nil then
		var_0_2 = {}

		for iter_2_0, iter_2_1 in pairs(ChapterResidentTools.GetResidentChapterList() or {}) do
			local var_2_0 = ChapterClientCfg[iter_2_1]

			if var_2_0 and var_2_0.activity_id then
				var_0_2[var_2_0.activity_id] = true
			end
		end
	end

	return var_0_2
end

function var_0_0.InitRedPoint()
	local var_3_0 = {}
	local var_3_1 = ChapterResidentTools.GetResidentChapterOpenList()

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		local var_3_2 = ChapterClientCfg[iter_3_1].activity_id
		local var_3_3 = RedPointConst.RESIDENT_ACT .. var_3_2

		manager.redPoint:addGroup(var_3_3, {
			ActivityTools.GetRedPointKey(var_3_2) .. var_3_2,
			RedPointConst.RESIDENT_ACT_NEW_TAG .. var_3_2
		})
		table.insert(var_3_0, var_3_3)
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

	local var_4_0 = var_0_0.GetResidentChapterOpenList()

	for iter_4_0, iter_4_1 in pairs(var_4_0 or {}) do
		local var_4_1 = ChapterClientCfg[iter_4_1].activity_id

		if not getData("ResidentAct", "NewTag_" .. var_4_1) then
			manager.redPoint:setTip(RedPointConst.RESIDENT_ACT_NEW_TAG .. var_4_1, 1, RedPointStyle.SHOW_NEW_TAG)
		else
			manager.redPoint:setTip(RedPointConst.RESIDENT_ACT_NEW_TAG .. var_4_1, 0, RedPointStyle.SHOW_NEW_TAG)
		end
	end
end

function var_0_0.GetOpenResidentActChapterID()
	local var_5_0 = ChapterResidentTools.GetResidentChapterList()
	local var_5_1

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		local var_5_2 = ChapterClientCfg[iter_5_1].activity_id
		local var_5_3 = ChapterResidentTools.GetResidentActMainID(var_5_2)

		if ActivityData:GetActivityData(var_5_3).stopTime <= manager.time:GetServerTime() then
			var_5_1 = iter_5_1

			break
		end
	end

	return var_5_1
end

function var_0_0.GetResidentChapterList()
	return ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.RESIDENT_ACT]
end

function var_0_0.GetResidentChapterOpenList()
	local var_7_0 = ChapterResidentTools.GetResidentChapterList()
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		local var_7_2 = ChapterClientCfg[iter_7_1].activity_id
		local var_7_3 = ChapterResidentTools.GetResidentActMainID(var_7_2)

		if ActivityData:GetActivityData(var_7_3).stopTime <= manager.time:GetServerTime() then
			table.insert(var_7_1, iter_7_1)
		end
	end

	table.sort(var_7_1, function(arg_8_0, arg_8_1)
		local var_8_0 = ChapterClientCfg[arg_8_0]
		local var_8_1 = ChapterClientCfg[arg_8_1]
		local var_8_2 = var_8_0.activity_id
		local var_8_3 = var_8_1.activity_id
		local var_8_4 = ChapterResidentTools.GetResidentActFinishState(var_8_2) and 1 or 0
		local var_8_5 = ChapterResidentTools.GetResidentActFinishState(var_8_3) and 1 or 0

		if var_8_4 ~= var_8_5 then
			return var_8_4 < var_8_5
		end

		return var_8_3 < var_8_2
	end)

	return var_7_1
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
	local var_12_0 = ChapterClientCfg[arg_12_0]

	return "Widget/System/Activity_Theme/Theme_" .. var_12_0.activity_id
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
		local var_13_3 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_HODUR_MAIN]

		var_13_0 = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_HODUR_MAIN)
		var_13_1 = #var_13_3
	elseif arg_13_0 == ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN then
		local var_13_4 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN]

		var_13_0 = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN)
		var_13_1 = #var_13_4
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
		local var_14_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_MAIN]

		for iter_14_0, iter_14_1 in pairs(var_14_0) do
			if not SkuldSystemData:GetPointRewardIsGet(iter_14_1) then
				return false
			end
		end

		return true
	elseif arg_14_0 == ActivityConst.ACTIVITY_QUANZHOU_ENTRY then
		local var_14_1 = QWorldBookletTools.GetNdLevelIDList()

		for iter_14_2, iter_14_3 in ipairs(var_14_1) do
			if not ActivityPointData:IsCompleteID(iter_14_3) then
				return false
			end
		end

		return true
	elseif arg_14_0 == ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME then
		local var_14_2 = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME]

		for iter_14_4, iter_14_5 in pairs(var_14_2) do
			if OsirisPlayGameData:IsCompleteID(iter_14_5) ~= 2 then
				return false
			end
		end

		return true
	elseif arg_14_0 == ActivityConst.ACTIVITY_NYA_SUMMER_PUB or arg_14_0 == ActivityConst.ACTIVITY_AUTO_CHESS_MAIN or arg_14_0 == ActivityConst.ACTIVITY_HELLA_PINBALL_MAIN or arg_14_0 == ActivityConst.ACTIVITY_HODUR_MAIN or arg_14_0 == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 or arg_14_0 == ActivityConst.ACTIVITY_ROGUECARD_5_0 then
		local var_14_3 = AssignmentCfg.get_id_list_by_activity_id[arg_14_0]

		if not var_14_3 then
			return false
		end

		for iter_14_6, iter_14_7 in ipairs(var_14_3) do
			local var_14_4 = TaskData2:GetTask(iter_14_7)

			if not var_14_4 then
				return false
			end

			if var_14_4.complete_flag < 1 then
				return false
			end
		end

		return true
	elseif arg_14_0 == ActivityConst.ACTIVITY_ASH_MAIN then
		local var_14_5 = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ASH_MAIN] or {}

		for iter_14_8, iter_14_9 in pairs(var_14_5) do
			if not AshSystemData:GetPointRewardIsGet(iter_14_9) then
				return false
			end
		end

		return true
	elseif arg_14_0 == ActivityConst.ACTIVITY_4_6_MUSIC then
		return false
	elseif arg_14_0 == ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN then
		local var_14_6 = AssignmentCfg.get_id_list_by_activity_id[arg_14_0]

		if not var_14_6 then
			return false
		end

		for iter_14_10, iter_14_11 in ipairs(var_14_6) do
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
		local var_14_7, var_14_8 = ChapterResidentTools.GetTaskInfo(arg_14_0)

		return var_14_8 > 0 and var_14_8 <= var_14_7
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
		local var_15_0 = QWorldMgr:GetActivityMap(arg_15_0)
		local var_15_1 = SandPlayMapCfg[var_15_0]
		local var_15_2 = var_15_1 and var_15_1.story_id

		if not var_15_2 or var_15_2 == 0 or manager.story:IsStoryPlayed(var_15_2) then
			LaunchQWorld(false, arg_15_0)
		else
			manager.story:StartStoryById(var_15_2, function()
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
		local var_15_3, var_15_4 = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_AUTO_CHESS_MAIN)

		if var_15_3 < var_15_4 and not getData("auto_chess_pop", "PREVIOUS") then
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
		local var_15_5 = RogueCardGameData:GetChallengeBattleId()

		if var_15_5 and tonumber(var_15_5) > 0 then
			RogueCardGameAction.GetStageSaveDataJumpChallenge(var_15_5, 2)
		end

		local var_15_6 = PlayerData:GetStoryList()
		local var_15_7 = GameSetting.rogue_card_start_story.value[1]

		if var_15_6[var_15_7] then
			JumpTools.OpenPageByJump("/rogueCardGameHomeView", {
				isHome = true
			})
		else
			manager.story:StartStoryById(var_15_7, function(arg_20_0)
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
	local var_23_0

	if arg_23_0 == ActivityConst.ACTIVITY_4_6_MUSIC then
		var_23_0 = GameSetting.v210_music_describe and GameSetting.v210_music_describe.value or {}
	end

	return var_23_0
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
	local var_25_0 = arg_25_0
	local var_25_1 = AssignmentCfg.get_id_list_by_activity_id[var_25_0]
	local var_25_2 = 0

	for iter_25_0, iter_25_1 in ipairs(var_25_1 or {}) do
		local var_25_3 = AssignmentCfg[iter_25_1]

		if TaskData2:GetTaskComplete(iter_25_1) then
			var_25_2 = var_25_2 + 1
		elseif var_25_3 and var_25_3.need <= TaskData2:GetTaskProgress(iter_25_1) then
			var_25_2 = var_25_2 + 1
		end
	end

	local var_25_4 = var_25_1 and #var_25_1 or 0

	return var_25_2, var_25_4
end

return var_0_0
