local var_0_0 = {}
local var_0_1

function var_0_0.OnceMoreBattle(arg_1_0)
	local var_1_0 = arg_1_0:GetType()

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == var_1_0 or BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == var_1_0 then
		if not MythicData:GetIsNew() then
			BattleController.GetInstance():LaunchBattle(arg_1_0)
		else
			ShowTips("MYTHIC_REFRESH")
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == var_1_0 then
		local var_1_1 = arg_1_0:GetStageId()
		local var_1_2 = getChapterIDByStageID(var_1_1)
		local var_1_3 = ChapterCfg[var_1_2].section_id_list
		local var_1_4 = table.indexof(var_1_3, var_1_1) or 0

		if var_1_3[var_1_4 + 1] ~= nil then
			local var_1_5 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER, var_1_3[var_1_4 + 1])

			BattleController.GetInstance():LaunchBattle(var_1_5)
		else
			ShowTips("ERROR_BAD_TEMPLATE")
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == var_1_0 then
		if BattleEquipData:GetBattleEquipData().next_refresh_time < manager.time:GetServerTime() then
			if var_0_1 ~= nil then
				return
			end

			ShowTips("STAGE_REFRESH_DATA")

			var_0_1 = Timer.New(function()
				var_0_0.QuitBattle(arg_1_0)

				var_0_1 = nil
			end, 1.2, 1)

			var_0_1:Start()
		else
			BattleController.GetInstance():LaunchBattle(arg_1_0)
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == var_1_0 then
		if MatrixData:GetGameState() == MatrixConst.STATE_TYPE.STARTED then
			BattleController.GetInstance():LaunchBattle(arg_1_0)
		else
			ShowTips("STAGE_REFRESH_DATA")
		end
	elseif BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE == var_1_0 then
		local var_1_6 = SequentialBattleData:GetCurrentFinishStageIndex(activityID) + 1
		local var_1_7 = arg_1_0:GetActivityID()
		local var_1_8 = var_1_7
		local var_1_9 = var_1_6
		local var_1_10 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, SequentialBattleChapterCfg[var_1_7].stage_id[var_1_6], var_1_7, var_1_8, var_1_9, {
			activityID = self.activityID_
		})

		BattleController.GetInstance():LaunchBattle(var_1_10)
	elseif BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE == var_1_0 then
		local var_1_11 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE, arg_1_0:GetStageId(), {
			isRestart = true,
			activityID = arg_1_0:GetActivityID(),
			chapterID = arg_1_0:GetChapterID()
		}, arg_1_0:GetReserveParams())

		BattleController.GetInstance():LaunchBattle(var_1_11)
	else
		BattleController.GetInstance():LaunchBattle(arg_1_0)
	end
end

function var_0_0.TryNextBattle(arg_3_0)
	local var_3_0 = arg_3_0:GetType()

	if BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == var_3_0 then
		if arg_3_0.GetNextStage and arg_3_0:GetNextStage() ~= nil and not MythicData:GetIsNew() then
			BattleController.GetInstance():LaunchBattle(arg_3_0:GetNextStage())

			return
		else
			BattleInstance.QuitBattle(arg_3_0)
		end
	end
end

function var_0_0.GotoBattleReadyPage(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if whereami == "battleResult" or whereami == "battle" then
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	else
		gameContext:Back()
		BattleFieldData:SetStoryBackFlag(true)
		gameContext:Back()
	end

	if arg_4_2 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT then
		gameContext:OverrideUrl("/chapterSection", "/chapterSection", {
			chapterID = arg_4_0,
			section = arg_4_1
		}, "home")
	elseif arg_4_2 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
		BattleFieldData:SetCacheStage(arg_4_0, arg_4_1)

		local var_4_0 = getChapterClientCfgByChapterID(arg_4_0)

		JumpTools.Jump2SubPlot(var_4_0.id)
	end

	local var_4_1 = ChapterCfg[arg_4_0]

	if var_4_1.cue_sheet ~= "" then
		manager.audio:PlayBGM(var_4_1.cue_sheet, var_4_1.cue_name, var_4_1.awb)
	end

	if arg_4_3 then
		arg_4_3()
	else
		OpenPageUntilLoaded("/sectionSelectHero", {
			section = arg_4_1,
			sectionType = arg_4_2
		})
	end
end

function var_0_0.QuitBattle(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:GetType()

	ReleaseBattleResultSnapshot()

	local var_5_1 = arg_5_0:GetStageId()

	print(var_5_0, " QuitBattle")

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS == var_5_0 then
		if not arg_5_1 and arg_5_0.GetNextStage and arg_5_0:GetNextStage() ~= nil then
			BattleController.GetInstance():LaunchBattle(arg_5_0:GetNextStage())

			return
		else
			DestroyLua()
			WarChessAction.EnterChessMap()
		end
	elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY == var_5_0 then
		StartGuildActivity(arg_5_0:GetNodeId())
	elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP == var_5_0 then
		StartGuildActivitySP(arg_5_0:GetNodeId())

		return
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS == var_5_0 then
		DestroyLua()
		NewWarChessAction.EnterChessMap()

		return
	elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE == var_5_0 then
		DestroyLua()
		gameContext:ClearHistoryByName("setting")

		if ActivityData:GetActivityData(PushSnowBallData:GetActivityID()).stopTime > manager.time:GetServerTime() then
			gameContext.oldRoutes_ = {}

			PushSnowBallData:SetGoViewStr("/pushSnowBallSingle")
			DormMinigame.Launch("HZ07_tuanxue1")

			_G.OnLoadedCallBack_ = nil
		else
			LuaExchangeHelper.GoToMain()
		end

		return
	elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS == var_5_0 or BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL == var_5_0 then
		DestroyLua()
		gameContext:ClearHistoryByName("setting")

		if arg_5_2 then
			PushSnowBallAction:SendQuitBattle()
		end

		if ActivityData:GetActivityData(PushSnowBallData:GetActivityID()).stopTime > manager.time:GetServerTime() then
			gameContext.oldRoutes_ = {}

			PushSnowBallData:SetGoViewStr("/pushSnowBallTeam")
			DormMinigame.Launch("HZ07_tuanxue1")

			_G.OnLoadedCallBack_ = nil
		else
			LuaExchangeHelper.GoToMain()
		end

		return
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WHACK_MOLE == var_5_0 then
		DestroyLua()
		gameContext:ClearHistoryByName("setting")

		local var_5_2 = arg_5_0:GetDest()

		if ActivityWhackMoleCfg[var_5_2].type ~= WhackMoleConst.STAGE_TYPE.CHESS then
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/whackMoleMain", {
				activityID = ActivityWhackMoleCfg[var_5_2].activity_id,
				targetSessionIndex = WhackMoleTools.GetLastSessionIndex()
			})
		else
			ChessBoardAction.GoBackFromSmallGame(arg_5_0:GetBattleResult() == true and 0 or 1, arg_5_0:GetScore())
		end

		return
	elseif BattleConst.STAGE_TYPE_NEW.CHESS_BOARD == var_5_0 then
		DestroyLua()
		gameContext:ClearHistoryByName("setting")

		if arg_5_1 then
			ChessBoardAction.GoBackFromSmallGame(1, 0)
		else
			ChessBoardAction.GoBackFromSmallGame(0, 0)
		end

		return
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME == var_5_0 then
		if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
			DestroyLua()
			gameContext:ClearHistoryByName("setting")
			ChessBoardAction.GoBackFromSmallGame(arg_5_1 and 1 or 0, 0)

			return
		else
			DestroyLua()
			gameContext:ClearHistoryByName("setting")
			LuaExchangeHelper.GoToMain()
		end
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_CATCH_DUCK == var_5_0 then
		DestroyLua()
		gameContext:ClearHistoryByName("setting")

		if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
			ChessBoardAction.GoBackFromSmallGame(arg_5_1 and 1 or 0, 0)

			return
		else
			LuaExchangeHelper.GoToMain()
		end
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY == var_5_0 and manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
		DestroyLua()
		ChessBoardAction.GoBackFromSmallGame(arg_5_1 and 1 or 0, 0)

		return
	elseif BattleConst.STAGE_TYPE_NEW.SEA_WARFARE == var_5_0 then
		DestroyLua()
		SeaWarfareTools.SetIsGoBackFromBattle(true)

		local var_5_3 = QWorldData:GetQWorldContextByMapId(QWorldMgr:GetMapId())
		local var_5_4 = SeaWarfareTools.GetSeaWarfareStageID(var_5_1)

		if SeaWarfareStageCfg[var_5_4].type == SeaWarfareConst.STAGE_TYPE.CHALLENGE then
			if var_5_3 then
				var_5_3.cacheTag = SeaWarfareConst.CHALLENGE_STAGE_TAG_ID
			end
		elseif not arg_5_1 and var_5_3 then
			var_5_3.cacheTag = nil
		end

		LaunchQWorld(true)

		return
	elseif BattleConst.STAGE_TYPE_NEW.SAND_PLAY == var_5_0 then
		DestroyLua()
		LaunchQWorld(true)

		return
	elseif BattleConst.STAGE_TYPE_NEW.SUMMER_PUB == var_5_0 then
		if arg_5_0:GetDest() == SummerPubConst.LEVEL_ID_4030307 then
			OpenPageUntilLoaded("/summerPubStageView")
		end

		DestroyLua()
		gameContext:ClearHistoryByName("setting")
		LuaExchangeHelper.GoToMain()
	elseif BattleConst.STAGE_TYPE_NEW.SKULD == var_5_0 then
		local var_5_5 = arg_5_0:GetIsStartNext()
		local var_5_6 = arg_5_0:GetDest()
		local var_5_7 = SkuldStageCfg[var_5_6]
		local var_5_8
		local var_5_9

		var_5_9 = var_5_7.section == 9 and true or false

		if var_5_5 then
			local var_5_10 = {
				PIECE = 2,
				BATTLE = 1
			}
			local var_5_11 = SkuldStageCfg.all[table.indexof(SkuldStageCfg.all, var_5_6) + 1]
			local var_5_12 = SkuldStageCfg[var_5_11]
			local var_5_13 = var_5_12.type[2]
			local var_5_14 = BattleConst.STAGE_TYPE_NEW.SKULD

			if SkuldSystemData:GetLevelIDIsOpen(var_5_11) then
				if var_5_12.type[1] == var_5_10.BATTLE then
					local var_5_15 = BattleStageTools.GetStageCfg(var_5_14, var_5_13)

					SkuldSystemData:CacheSkuldIconNum()

					if var_5_15.tag == BattleConst.BATTLE_TAG.STORY then
						BattleController.GetInstance():LaunchStoryBattle(var_5_14, var_5_13, 0)

						return
					else
						DestroyLua()
						gameContext:ClearHistoryByName("setting")
						LuaExchangeHelper.GoToMain()
					end
				elseif var_5_12.type[1] == var_5_10.PIECE then
					DestroyLua()
					gameContext:ClearHistoryByName("setting")
					LuaExchangeHelper.GoToMain()
				end
			else
				DestroyLua()
				gameContext:ClearHistoryByName("setting")
				LuaExchangeHelper.GoToMain()
			end
		else
			DestroyLua()
			gameContext:ClearHistoryByName("setting")
			LuaExchangeHelper.GoToMain()
		end
	elseif BattleConst.STAGE_TYPE_NEW.ASH_BATTLE == var_5_0 then
		DestroyLua()
		gameContext:ClearHistoryByName("setting")
		LuaExchangeHelper.GoToMain(CustomLoadingConst.ASHGAME_Loading)
	else
		DestroyLua()
		gameContext:ClearHistoryByName("setting")
		LuaExchangeHelper.GoToMain()
	end

	if arg_5_0:GetIsCooperation() then
		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			CooperationTools.GotoCooperationEntry(var_5_0, arg_5_0:GetDest(), arg_5_0:GetActivityID())
		end

		return
	end

	local var_5_16 = getChapterIDByStageID(var_5_1)

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == var_5_0 then
		if ChapterCfg[var_5_16].clientID == ChapterConst.CHAPTER_CLIENT_19 then
			local var_5_17 = BattleFieldData:GetChapterLocationID(var_5_16)

			if ChapterTools.HasNewLocationMainStage(var_5_17) then
				OpenPageUntilLoaded("/chapterPlot19Main/chapterPlot19MapLocationInfo", {
					chapterID = var_5_16,
					locationID = var_5_17
				})
			else
				OpenPageUntilLoaded("/chapterPlot19Main", {})
			end

			return
		end

		local var_5_18 = getChapterClientCfgByChapterID(var_5_16)
		local var_5_19 = ChapterConst.ROLL_MAIN_CLINET[var_5_18.id]

		if not arg_5_1 then
			local var_5_20 = getChapterClientCfgByChapterID(var_5_16)

			if #var_5_20.chapter_list > 1 and var_5_20.id ~= ChapterConst.CHAPTER_CLIENT_XUHENG_PART_2_2 and table.keyof(var_5_20.chapter_list, var_5_16) <= #var_5_20.chapter_list and var_5_1 == ChapterCfg[var_5_16].section_id_list[#ChapterCfg[var_5_16].section_id_list] and BattleStageData:GetStageData()[var_5_1].clear_times == 1 and not var_5_19 then
				local var_5_21 = ChapterTools.GetChapterBranchURL(var_5_20.id)

				gameContext:OverrideUrl("/chapterSection", var_5_21, nil, "home")
				OpenPageUntilLoaded(var_5_21, {
					chapterClientID = var_5_20.id
				})

				return
			end

			var_5_16 = StageTools.GetAutoChapter(var_5_16, var_5_1)
		end

		if ChapterCfg[var_5_16].clientID == ChapterConst.CHAPTER_CLIENT_23 or ChapterCfg[var_5_16].clientID == ChapterConst.CHAPTER_CLIENT_24 or ChapterCfg[var_5_16].clientID == ChapterConst.CHAPTER_CLIENT_25 then
			local var_5_22 = ChapterTools.GetChapterBranchURL(ChapterCfg[var_5_16].clientID)

			gameContext:OverrideUrl("/chapterSection", var_5_22, nil, "home")
			OpenPageUntilLoaded(var_5_22, {
				chapterClientID = ChapterCfg[var_5_16].clientID
			})

			return
		end

		if var_5_19 then
			OpenPageUntilLoaded("/chapterSectionRollBg", {
				chapterID = var_5_16
			})
		else
			OpenPageUntilLoaded("/chapterSection", {
				chapterID = var_5_16
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == var_5_0 then
		local var_5_23 = getChapterClientCfgByChapterID(var_5_16)

		JumpTools.Jump2SubPlot(var_5_23.id)
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY == var_5_0 then
		OpenPageUntilLoaded("/daily", {
			chapterID = var_5_16
		})
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == var_5_0 then
		OpenPageUntilLoaded("/tower", {
			showInfo = true,
			chapterId = var_5_16
		})
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT == var_5_0 then
		OpenPageUntilLoaded("/enchantment")
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == var_5_0 then
		OpenPageUntilLoaded("/equipSection", {
			chapterID = var_5_16
		})
	elseif BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL == var_5_0 then
		if EquipBreakThroughMaterialData:GetSelectModeID() == 0 then
			gameContext:OverrideUrl("/equipBreakThroughMaterialMap", "/equipBreakThroughMaterialMode", nil, "home")
			OpenPageUntilLoaded("/equipBreakThroughMaterialMode")
		else
			OpenPageUntilLoaded("/equipBreakThroughMaterialMap")
		end
	elseif BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE == var_5_0 then
		OpenPageUntilLoaded("/equipSeizure")
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == var_5_0 then
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
			if #BattleBossChallengeData:GetOpenModeList() >= 2 then
				gameContext:OverrideUrl("/bossSwitch", "/bossMode", nil, "home")
				gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode", nil, "home")
				OpenPageUntilLoaded("/bossMode")
			else
				OpenPageUntilLoaded("/bossSwitch")
			end
		else
			OpenPageUntilLoaded("/bossChallenge")
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE == var_5_0 then
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
			gameContext:OverrideUrl("/bossSwitch", "/bossMode", nil, "home")
			gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode", nil, "home")
			OpenPageUntilLoaded("/bossMode")
		else
			OpenPageUntilLoaded("/bossAdvanceInfo", {
				bossIndex = arg_5_0:GetBossIndex()
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == var_5_0 then
		OpenPageUntilLoaded("/mythic")
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING == var_5_0 or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING == var_5_0 then
		if BattleConst.COOPERATION_STRONGHOLD_TEACH_STAGE_ID == arg_5_0:GetStageId() then
			OpenPageUntilLoaded("/cooperationBlank/strongholdMain")
		else
			OpenPageUntilLoaded("/teachStage")
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == var_5_0 then
		local var_5_24 = MatrixData:GetGameState()

		if var_5_24 == MatrixConst.STATE_TYPE.SUCCESS or var_5_24 == MatrixConst.STATE_TYPE.FAIL then
			OpenPageUntilLoaded("/matrixBlank/matrixOver")
		elseif var_5_24 == MatrixConst.STATE_TYPE.STARTED then
			OpenPageUntilLoaded("/matrixBlank/matrixOrigin")
		else
			OpenPageUntilLoaded("/matrixBlank/matrixPrepare", {
				isTimeOut = true
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS == var_5_0 then
		OpenPageUntilLoaded("/warHome")
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY == var_5_0 then
		local var_5_25 = arg_5_0:GetActivityID()
		local var_5_26 = ActivityTools.GetOriginActivityID(var_5_25)
		local var_5_27 = ActivityTools.GetActivityTheme(var_5_25)
		local var_5_28 = ActivityTools.GetOriginActivityTheme(var_5_27)

		if var_5_26 == ActivityConst.OSIRIS_STROY then
			OpenPageUntilLoaded("/osirisStoryStage")
		elseif var_5_26 == ActivityConst.HELLA_STORY_STAGE_HELLA or var_5_26 == ActivityConst.HELLA_STORY_STAGE_HERMES then
			local var_5_29 = StoryStageActivityData:GetHistoryChapter(var_5_25)

			OpenPageUntilLoaded("/storyStageActivity", {
				theme = var_5_27,
				chapterID = var_5_29
			})
		elseif var_5_26 == ActivityConst.SUMMER_STORY_ISLAND then
			local var_5_30 = StoryStageActivityData:GetHistoryChapter(var_5_25)

			OpenPageUntilLoaded("/summerStageMain", {
				theme = var_5_27,
				chapterID = var_5_30
			})
		elseif var_5_26 == ActivityConst.SUMMER_STORY_SEABED then
			local var_5_31 = StoryStageActivityData:GetHistoryChapter(var_5_25)

			OpenPageUntilLoaded("/summerStageSeabed", {
				theme = var_5_27,
				chapterID = var_5_31
			})
		elseif var_5_26 == ActivityConst.THIRD_VOLUME_PART_2_SUB_PLOT then
			local var_5_32 = StoryStageActivityData:GetHistoryChapter(var_5_25)

			OpenPageUntilLoaded("/activityAthenaStoryStage", {
				theme = var_5_27,
				chapterID = var_5_32
			})
		elseif var_5_28 == ActivityConst.THEME.FACTORY then
			local var_5_33 = StoryStageActivityData:GetHistoryChapter(var_5_25)

			OpenPageUntilLoaded("/activityFactoryStoryStage", {
				theme = var_5_27,
				chapterID = var_5_33
			})
		else
			local var_5_34 = StoryStageActivityData:GetHistoryChapter(var_5_25)

			OpenPageUntilLoaded("/activityStoryStageBase", {
				theme = var_5_27,
				chapterID = var_5_34
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON == var_5_0 then
		local var_5_35 = arg_5_0:GetActivityID()
		local var_5_36 = DemonChallengeCfg[var_5_35].activity_id
		local var_5_37 = ActivityTools.GetMainActivityId(var_5_36)
		local var_5_38 = ActivityTools.GetActivityTheme(var_5_37)
		local var_5_39 = ActivityTools.GetOriginActivityTheme(var_5_38)

		if var_5_39 == ActivityConst.THEME.VOLUME_DOWN then
			OpenPageUntilLoaded("/volumeDemonChallengeMain", {
				activityID = var_5_37,
				childId = var_5_36
			})
		elseif var_5_39 == ActivityConst.THEME.DREAM then
			OpenPageUntilLoaded("/dreamDemonChallengeMain", {
				activityID = var_5_37,
				childId = var_5_36
			})
		elseif var_5_39 == ActivityConst.THEME.ACTIVITY_2_2 then
			OpenPageUntilLoaded("/xuHeng3rddreamDemonChallengeMain", {
				activityID = var_5_37,
				childId = var_5_36
			})
		else
			OpenPageUntilLoaded("/demonChallengeMain", {
				activityID = var_5_37,
				childId = var_5_36
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.HERO_TRIAL == var_5_0 or BattleConst.STAGE_TYPE_NEW.RESIDENT_HERO_TRIAL == var_5_0 then
		HeroTrialTools.GoBackFromBattle(arg_5_0)
	elseif BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL == var_5_0 then
		local var_5_40 = arg_5_0:GetActivityID()
		local var_5_41 = SkinTrialData:GetRoute()
		local var_5_42 = var_5_41.name

		if var_5_42 == "heroSkin" then
			OpenPageUntilLoaded("/heroSkin", {
				skinID = var_5_41.skinID,
				heroID = var_5_41.heroID
			})
		elseif var_5_42 == "heroSkinPreview" then
			OpenPageUntilLoaded("/heroSkinPreview", {
				skinID = var_5_41.skinID,
				heroID = var_5_41.heroID,
				initSkinID = var_5_41.initSkinID,
				goodId = var_5_41.goodID
			})
		elseif var_5_42 == "skinTrialSelect" then
			local var_5_43 = string.format("/skinTrialSelect%d", arg_5_0:GetDest())

			OpenPageUntilLoaded(var_5_43, {
				activityID = var_5_40,
				skinTrialID = arg_5_0:GetDest()
			})
		elseif var_5_42 == "skinTrialSelectView_2_0" then
			OpenPageUntilLoaded("/skinTrialSelectView_2_0", {
				activityID = var_5_40,
				skinTrialID = arg_5_0:GetDest()
			})
		elseif var_5_42 == "skinTrialSelectView_2_2" then
			OpenPageUntilLoaded("/skinTrialSelectView_2_2", {
				activityID = var_5_40,
				skinTrialID = arg_5_0:GetDest()
			})
		elseif var_5_42 == "skinTrialSelectView_3_0" then
			OpenPageUntilLoaded("/skinTrialSelectView_3_0", {
				activityID = var_5_40,
				skinTrialID = arg_5_0:GetDest()
			})
		elseif var_5_42 == "skinTrialSelectView_Resident" then
			OpenPageUntilLoaded("/skinTrialSelectView_Resident", {
				activityID = var_5_40,
				skinTrialID = arg_5_0:GetDest()
			})
		else
			print("未配置皮肤界面路径！")
		end
	elseif BattleConst.STAGE_TYPE_NEW.RACE_TRIAL == var_5_0 then
		local var_5_44 = arg_5_0:GetActivityID()
		local var_5_45 = ActivityTools.GetActivityTheme(var_5_44)
		local var_5_46 = ActivityTools.GetOriginActivityTheme(var_5_45)
		local var_5_47 = RaceTrialData:GetMainActivityID(var_5_44)

		if var_5_46 == ActivityConst.THEME.OSIRIS then
			OpenPageUntilLoaded("/raceTrial", {
				activityID = var_5_47
			})
		elseif var_5_46 == ActivityConst.THEME.VOLUME_DOWN then
			OpenPageUntilLoaded("/volumeRaceTrialMain", {
				activityID = var_5_47
			})
		else
			OpenPageUntilLoaded("/raceTrialEnter", {
				activityID = var_5_47
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.SLAYER == var_5_0 then
		local var_5_48 = arg_5_0:GetActivityID()
		local var_5_49 = arg_5_0:GetDest()
		local var_5_50 = ActivityTools.GetActivityTheme(var_5_48)
		local var_5_51 = ActivityTools.GetOriginActivityTheme(var_5_50)

		if var_5_51 == ActivityConst.THEME.HELLA then
			OpenPageUntilLoaded("/hellaSlayer", {
				slayer_activity_id = var_5_48
			})
		elseif var_5_51 == ActivityConst.THEME.VOLUME then
			OpenPageUntilLoaded("/volumeSlayer", {
				slayer_activity_id = var_5_48,
				region_activity_id = var_5_49
			})
		elseif var_5_51 == ActivityConst.THEME.TYR then
			OpenPageUntilLoaded("/slayerStageView_1_7", {
				slayer_activity_id = var_5_48,
				region_activity_id = var_5_49
			})
		else
			OpenPageUntilLoaded("/slayerStageView_2_4", {
				slayer_activity_id = var_5_48,
				region_activity_id = var_5_49
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.PARKOUR == var_5_0 then
		local var_5_52 = arg_5_0:GetActivityID()
		local var_5_53 = arg_5_0:GetDest()
		local var_5_54 = ActivityTools.GetActivityTheme(var_5_52)

		if ActivityTools.GetOriginActivityTheme(var_5_54) == ActivityConst.THEME.HELLA then
			if ActivityData:GetActivityIsOpen(var_5_52) then
				OpenPageUntilLoaded("/hellaParkourEntrust", {
					parkour_activity_id = var_5_52,
					entrust_activity_id = var_5_53
				})
			else
				OpenPageUntilLoaded("/hellaParkour", {
					parkour_activity_id = var_5_52
				})
			end
		end
	elseif BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE == var_5_0 then
		local var_5_55 = arg_5_0:GetActivityID()
		local var_5_56 = ActivityTools.GetActivityTheme(var_5_55)

		if ActivityTools.GetOriginActivityTheme(var_5_56) == ActivityConst.THEME.HELLA then
			OpenPageUntilLoaded("/battleFirstPass", {
				activityID = ActivityTools.GetParentActivityID(var_5_55)
			})
		else
			print("未有绑定对应活动！", var_5_55)
		end
	elseif BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE == var_5_0 then
		local var_5_57 = var_5_1
		local var_5_58 = SoloChallengeData:GetActivityID(var_5_57)
		local var_5_59 = SoloChallengeData:GetDifficultyIndex(var_5_57)
		local var_5_60 = ActivityTools.GetActivityTheme(var_5_58)
		local var_5_61 = ActivitySoloChallengeCfg[var_5_58].stage_id[var_5_59][2]
		local var_5_62 = var_5_61[#var_5_61] == var_5_57

		if var_5_60 == ActivityConst.THEME.SUMMER then
			if not arg_5_1 and var_5_62 then
				local var_5_63 = ActivitySoloChallengeCfg[var_5_58].main_activity_id or ActivityConst.SUMMER_SOLO_CHALLENGE

				OpenPageUntilLoaded("/soloChallengeMain", {
					activityID = var_5_63
				})
			else
				OpenPageUntilLoaded("/soloChallengeSelect", {
					activityID = var_5_58,
					difficultyIndex = var_5_59
				})
			end
		elseif var_5_60 == ActivityConst.THEME.FACTORY then
			if not arg_5_1 and var_5_62 then
				local var_5_64 = ActivitySoloChallengeCfg[var_5_58].main_activity_id

				OpenPageUntilLoaded("/factorySoloChallengeMain", {
					activityID = var_5_64
				})
			else
				OpenPageUntilLoaded("/factorySoloChallengeSelect", {
					activityID = var_5_58,
					difficultyIndex = var_5_59
				})
			end
		elseif var_5_60 == ActivityConst.THEME.TYR then
			if not arg_5_1 and var_5_62 then
				local var_5_65 = ActivitySoloChallengeCfg[var_5_58].main_activity_id

				OpenPageUntilLoaded("/soloChallengeMainView_1_7", {
					activityID = var_5_65
				})
			else
				OpenPageUntilLoaded("/soloChallengeSelectView_1_7", {
					activityID = var_5_58,
					difficultyIndex = var_5_59
				})
			end
		else
			print("未有绑定对应活动！", var_5_58)
		end
	elseif BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION == var_5_0 then
		local var_5_66 = arg_5_0:GetActivityID()

		OpenPageUntilLoaded("/limitedCalculation", {
			activityID = var_5_66
		})
	elseif BattleConst.STAGE_TYPE_NEW.ARTIFACT == var_5_0 then
		OpenPageUntilLoaded("/artifactLevel", {
			activityID = ActivityConst.SUMMER_ARTIFACT
		})
	elseif BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME == var_5_0 then
		OpenPageUntilLoaded("/leviathanLittleGame", {
			activityID = ActivityConst.LEVIATHAN_GAME
		})
	elseif BattleConst.STAGE_TYPE_NEW.SKADI_GAME == var_5_0 then
		OpenPageUntilLoaded("/skadiLittleGame", {
			activityID = ActivityConst.SIKADI_GAME
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME == var_5_0 then
		local var_5_67 = arg_5_0:GetActivityID()

		OpenPageUntilLoaded("/activityPt", {
			activityID = var_5_67
		})
	elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE == var_5_0 then
		if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
			OpenPageUntilLoaded("/home", {})
		else
			OpenPageUntilLoaded("/guildBossMain", {
				isFailed = arg_5_1 and true or false
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE == var_5_0 then
		if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
			OpenPageUntilLoaded("/home", {})
		else
			OpenPageUntilLoaded("/guildBossChallenge", {
				isFailed = arg_5_1 and true or false
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == var_5_0 then
		local var_5_68 = arg_5_0:GetActivityID()
		local var_5_69 = ActivityMatrixData:GetGameState(var_5_68)

		if var_5_69 == MatrixConst.STATE_TYPE.SUCCESS or var_5_69 == MatrixConst.STATE_TYPE.FAIL then
			OpenPageUntilLoaded("/matrixBlank/activityMatrixOver", {
				matrix_activity_id = var_5_68
			})
		elseif var_5_69 == MatrixConst.STATE_TYPE.STARTED then
			OpenPageUntilLoaded("/matrixBlank/activityMatrixOrigin", {
				matrix_activity_id = var_5_68
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE == var_5_0 then
		local var_5_70 = arg_5_0:GetActivityID()

		if ActivityTools.GetActivityTheme(var_5_70) == ActivityConst.THEME.VOLUME_DOWN then
			OpenPageUntilLoaded("/activityRaceSwitch", {
				activityID = var_5_70,
				rankID = ActivityConst.ACTIVITY_RACE_RANK
			})
		else
			OpenPageUntilLoaded("/activityRaceSwitch", {
				activityID = var_5_70,
				rankID = ActivityConst.ACTIVITY_RACE_RANK
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == var_5_0 then
		local var_5_71 = arg_5_0:GetActivityID()

		StrategyMatrixAction.GotoAfterBattleMatirx(var_5_71)
	elseif BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == var_5_0 then
		OpenPageUntilLoaded("/mythicUltimateView")
	elseif BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE == var_5_0 then
		local var_5_72 = arg_5_0:GetActivityID()

		if SequentialBattleData:GetCurrentFinishStageIndex(arg_5_0:GetActivityID()) >= 4 then
			local var_5_73 = arg_5_0:GetActivityID()
			local var_5_74 = SequentialBattleChapterCfg[var_5_73].main_id

			SequentialBattleData:ResetChapterTeamData(var_5_73)
			OpenPageUntilLoaded("/sequentialBattleFactory", {
				activityID = var_5_74
			})
		else
			OpenPageUntilLoaded("/sequentialBattleFactoryTeam", {
				activityID = var_5_72
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.MARDUK_GAME == var_5_0 then
		OpenPageUntilLoaded("/towerGameView", {})
	elseif BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL == var_5_0 then
		local var_5_75 = arg_5_0:GetActivityID()

		if ActivityCfg[var_5_75].activity_theme == ActivityConst.THEME.FACTORY then
			OpenPageUntilLoaded("/mardukSpecialMain", {
				activityID = ActivityConst.FACTORY_MARDUK
			})
		elseif ActivityCfg[var_5_75].activity_theme == ActivityConst.THEME.ACTIVITY_2_2 then
			OpenPageUntilLoaded("/activityMain_2_2", {
				activityID = ActivityConst.ACTIVITY_2_2,
				subActivityID = ActivityConst.ACTIVITY_2_2_SPECIAL
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO == var_5_0 then
		local var_5_76 = arg_5_0:GetActivityID()
		local var_5_77 = ActivitySoloSlayerCfg[var_5_76].main_activity_id
		local var_5_78 = ActivityCfg[var_5_77]

		if var_5_77 == ActivityConst.FACTORY_SURVIVE_SOLO or var_5_77 == ActivityConst.TYR_SURVIVE_SOLO then
			OpenPageUntilLoaded("/surviveSolo", {
				activityID = var_5_77
			})
		else
			local var_5_79 = ActivityTools.GetActivityTheme(var_5_77)
			local var_5_80 = ActivityTools.GetOriginActivityTheme(var_5_79)
			local var_5_81, var_5_82 = ActivityTools.GetActivityMainRouteByTheme(var_5_80)

			OpenPageUntilLoaded(var_5_81, var_5_82)
		end
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS == var_5_0 then
		OpenPageUntilLoaded("/nienWorldBoss")
	elseif BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT == var_5_0 then
		local var_5_83 = ActivityTools.GetMainActivityId(arg_5_0:GetActivityID())

		if var_5_83 == ActivityConst.ACTIVITY_3_2_AFFIX_SELECT then
			OpenPageUntilLoaded("/activityMain_2_8", {
				activityID = ActivityConst.ACTIVITY_3_2,
				subActivityID = var_5_83
			})
		elseif var_5_83 == ActivityConst.ACTIVITY_4_8_AFFIX_SELECT then
			OpenPageUntilLoaded("/affixSelectEnterView4_8", {
				activityID = ActivityConst.ACTIVITY_4_8_AFFIX_SELECT
			})
		else
			OpenPageUntilLoaded("/affixSelectMain", {
				activityID = var_5_83
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST == var_5_0 then
		OpenPageUntilLoaded("/bossCombatSelect", {
			damageTestId = DamageTestCfg.get_id_list_by_stage_id[arg_5_0:GetStageId()][1]
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL == var_5_0 then
		local var_5_84 = ActivityPt2Tools:GetMainActivityID(arg_5_0:GetActivityID())

		OpenPageUntilLoaded("/activityPt2", {
			mainActivityId = var_5_84,
			activityID = arg_5_0:GetActivityID()
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE == var_5_0 then
		local var_5_85 = ActivityPt2Tools:GetMainActivityID(arg_5_0:GetActivityID())

		OpenPageUntilLoaded("/activityPt2", {
			mainActivityId = var_5_85,
			activityID = arg_5_0:GetActivityID()
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD == var_5_0 then
		local var_5_86 = ActivityPt2Tools:GetMainActivityID(arg_5_0:GetActivityID())

		OpenPageUntilLoaded("/activityPt2", {
			mainActivityId = var_5_86,
			activityID = arg_5_0:GetActivityID()
		})
	elseif BattleConst.STAGE_TYPE_NEW.ABYSS == var_5_0 then
		OpenPageUntilLoaded("/abyssMain", {})
	elseif BattleConst.STAGE_TYPE_NEW.POLYHEDRON == var_5_0 then
		local var_5_87 = PolyhedronData:GetPolyhedronInfo():GetState()

		if PolyhedronConst.STATE_TYPE.SETTLEMENT == var_5_87 then
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronOver", {})
		else
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
		end
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER == var_5_0 then
		OpenPageUntilLoaded("/cooperationBlank/xH3rdWaterSelectAssistant", {
			activityID = arg_5_0:GetMainActivityId()
		})
	elseif BattleConst.STAGE_TYPE_NEW.SAIL_GAME == var_5_0 then
		local var_5_88 = arg_5_0:GetActivityID()

		if not ActivityData:GetActivityIsOpen(var_5_88) then
			ShowTips("TIME_OVER")
			OpenPageUntilLoaded("/sailMain", {
				activityID = var_5_88
			})

			return
		end

		local var_5_89

		if not arg_5_1 then
			var_5_89 = SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS
		end

		SailGameAction.SetEventEndMark(var_5_88, var_5_89)
		OpenPageUntilLoaded("/sailMain", {
			activityID = var_5_88
		})

		function _G.OnLoadedCallBack_()
			SailGameTools.GoToGameView(var_5_88)
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST == var_5_0 then
		OpenPageUntilLoaded("/advanceTestMain", {
			activityID = AdvanceTestData:GetCacheActivityID()
		})
	elseif BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON == var_5_0 then
		OpenPageUntilLoaded("/soloHeartDemonMain")
	elseif BattleConst.STAGE_TYPE_NEW.MULT_HEART_DEMON == var_5_0 then
		OpenPageUntilLoaded("/MultHeartDemonCombine", {
			isOver = true,
			activityID = arg_5_0:GetActivityID(),
			difficult = arg_5_0:GetDifficult()
		})
	elseif BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME == var_5_0 then
		local var_5_90 = arg_5_0:GetDest()
		local var_5_91 = DestroyBoxGameCfg[var_5_90].main_activity_id

		OpenPageUntilLoaded("/destroyBoxGame", {
			activityID = var_5_91
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME == var_5_0 then
		OpenPageUntilLoaded("/kagutsuchiWork", {})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL == var_5_0 then
		if arg_5_0:GetActivityID() == ActivityConst.ACTIVITY_PTSCROLL_4_2 then
			OpenPageUntilLoaded("/activityPtScroll_4_2", {
				mainActivityID = arg_5_0:GetActivityID()
			})
		else
			OpenPageUntilLoaded("/activityPtScroll", {
				mainActivityID = arg_5_0:GetActivityID()
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA == var_5_0 then
		OpenPageUntilLoaded("/activityAttributeArena", {
			activityID = arg_5_0:GetActivityID()
		})
	elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE == var_5_0 then
		if not LuaExchangeHelper.GetSceneIsHanding() then
			CheckManagers()

			function _G.OnLoadedCallBack_()
				if ActivityData:GetActivityData(PushSnowBallData:GetActivityID()).stopTime > manager.time:GetServerTime() then
					PushSnowBallData:SetGoViewStr("/pushSnowBallTeam")
					DormMinigame.Launch("HZ07_xueqiu1")
				end
			end
		end
	elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS == var_5_0 or BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL == var_5_0 then
		if not LuaExchangeHelper.GetSceneIsHanding() then
			CheckManagers()

			function _G.OnLoadedCallBack_()
				if ActivityData:GetActivityData(PushSnowBallData:GetActivityID()).stopTime > manager.time:GetServerTime() then
					PushSnowBallData:SetGoViewStr("/pushSnowBallTeam")
					DormMinigame.Launch("HZ07_xueqiu1")
				end
			end
		end
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN == var_5_0 then
		OpenPageUntilLoaded("/indiaNianMain")
	elseif BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE == var_5_0 then
		local var_5_92 = arg_5_0:GetActivityID()

		OpenPageUntilLoaded("/activityPushBoxMaterial", {
			activityID = var_5_92
		})
	elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION == var_5_0 then
		OpenPageUntilLoaded("/coreVerificationInfo", {
			bossType = arg_5_0:GetContID()
		})
	elseif BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1 == var_5_0 then
		local var_5_93 = arg_5_0:GetStageId()

		OpenPageUntilLoaded("/spHeroChallengeBattleToggleView", {
			stageID = var_5_93
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE == var_5_0 then
		OpenPageUntilLoaded("/activityHeroEnhanceSection_4_5", {
			exitFromBattle = true,
			activityID = arg_5_0:GetActivityID(),
			cfgId = arg_5_0:GetHeroEnhanceCfgId()
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE == var_5_0 then
		local var_5_94 = arg_5_0:GetMainActivityID()
		local var_5_95 = arg_5_0:GetChapterActivityID()
		local var_5_96 = arg_5_0:GetLevelID()

		OpenPageUntilLoaded("/activityReforgeLevelView", {
			activityID = var_5_94,
			chapterActivityID = var_5_95
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_SUMMER_WATER == var_5_0 then
		OpenPageUntilLoaded("/summerWaterMain")
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE == var_5_0 then
		local var_5_97 = SwimsuitBattleHeroCfg[arg_5_0:GetActivityID()].activity_id

		OpenPageUntilLoaded("/swimsuitBattleMain", {
			activity = var_5_97
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WHACK_MOLE == var_5_0 then
		-- block empty
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME == var_5_0 then
		ActivityRhythmGameData:SetCurPage(ActivityRhythmGameTools.GetChapterIDByStageID(arg_5_0:GetStageId()))

		local var_5_98 = arg_5_0:GetStageId()

		if ActivityRhythmGameTools.GetStageIsCommand(var_5_98) then
			OpenPageUntilLoaded("/activityRhythmGameCommandView", {
				chapterID = ActivityRhythmGameTools.GetChapterIDByStageID(var_5_98),
				activityID = arg_5_0:GetActivityID()
			})
		else
			OpenPageUntilLoaded("/activityRhythmGameStageView", {
				activityID = arg_5_0:GetActivityID(),
				stageID = arg_5_0:GetStageId()
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_CATCH_DUCK == var_5_0 then
		OpenPageUntilLoaded("/catchDuckMain")
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY == var_5_0 then
		OpenPageUntilLoaded("/MonsterCosplayStage")
	elseif BattleConst.STAGE_TYPE_NEW.ADVANCE_MONSTER_TEST == var_5_0 then
		OpenPageUntilLoaded("/advanceMonsterTestMainView")
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_SPKALI_CHALLENGE == var_5_0 then
		OpenPageUntilLoaded("/SpKaliChallenge")
	elseif BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM == var_5_0 then
		OpenPageUntilLoaded("/challengeRogueTeamPathMain", {
			isBattleBack = true
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_DODGE_BARRAGE == var_5_0 then
		OpenPageUntilLoaded("/dodgeBarrageMainView")
	elseif BattleConst.STAGE_TYPE_NEW.AREA_BATTLE == var_5_0 then
		local var_5_99 = ActivityCfg.get_id_list_by_sub_activity_list[arg_5_0:GetActivityID()][1]

		OpenPageUntilLoaded("/AreaBattleMapView", {
			activityID = arg_5_0:GetActivityID(),
			mainActivityID = var_5_99,
			stageID = arg_5_0:GetStageId()
		})
	elseif BattleConst.STAGE_TYPE_NEW.SKULD == var_5_0 then
		CheckManagers()

		local var_5_100 = arg_5_0:GetIsStartNext()
		local var_5_101 = arg_5_0:GetDest()
		local var_5_102 = SkuldStageCfg[var_5_101]
		local var_5_103
		local var_5_104 = var_5_102.section == 9 and true or false

		if var_5_100 then
			local var_5_105 = {
				PIECE = 2,
				BATTLE = 1
			}
			local var_5_106 = SkuldStageCfg.all[table.indexof(SkuldStageCfg.all, var_5_101) + 1]
			local var_5_107 = SkuldStageCfg[var_5_106]
			local var_5_108 = var_5_107.type[2]
			local var_5_109 = BattleConst.STAGE_TYPE_NEW.SKULD

			if SkuldSystemData:GetLevelIDIsOpen(var_5_106) then
				if var_5_107.type[1] == var_5_105.BATTLE then
					local var_5_110 = BattleStageTools.GetStageCfg(var_5_109, var_5_108)

					SkuldSystemData:CacheSkuldIconNum()

					if var_5_110.tag == BattleConst.BATTLE_TAG.STORY then
						-- block empty
					else
						gameContext:SetUrlAndParams("/skuldSystemStageView", {
							isFinal = var_5_104,
							curLevel = var_5_101
						})
						OpenPageUntilLoaded("/sectionSelectHero", {
							section = var_5_108,
							sectionType = var_5_109
						})
					end
				elseif var_5_107.type[1] == var_5_105.PIECE then
					gameContext:SetUrlAndParams("/skuldSystemStageView", {
						isFinal = var_5_104,
						curLevel = var_5_101
					})
					OpenPageUntilLoaded("/skuldPuzzleGameView", {
						stageID = var_5_108,
						levelID = var_5_106
					})
				end
			else
				ShowTips("ACTIVITY_ZUMA_OPEN_FRONT")
				gameContext:SetUrlAndParams("/skuldSystemStageView", {
					isFinal = var_5_104,
					curLevel = var_5_101
				})
				OpenPageUntilLoaded("/skuldSystemStageView", {
					isFinal = var_5_104,
					curLevel = var_5_101
				})
			end
		elseif var_5_101 == 1030 then
			OpenPageUntilLoaded("/skuldSystemMainView")
		else
			gameContext:SetUrlAndParams("/skuldSystemStageView", {
				isFinal = var_5_104,
				curLevel = var_5_101
			})
			OpenPageUntilLoaded("/skuldSystemStageView", {
				isFinal = var_5_104,
				curLevel = var_5_101
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME == var_5_0 then
		local var_5_111 = arg_5_0.id
		local var_5_112 = ActivityGeneralityStageCfg.get_id_list_by_stage_id[var_5_111][1]
		local var_5_113 = ActivityGeneralityStageCfg[var_5_112].chapter_id

		if ActivityGeneralityChapterCfg[var_5_113].type == 2 then
			OpenPageUntilLoaded("/osirisPlayGameChallegeStageView", {
				activityID_ = arg_5_0:GetActivityID(),
				chapterID = var_5_113
			})
		else
			OpenPageUntilLoaded("/osirisPlayGameStageView", {
				isShowTips = 1,
				activityID_ = arg_5_0:GetActivityID(),
				chapterID = var_5_113,
				stage_id = var_5_111,
				isFailed = arg_5_1
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.SUMMER_PUB == var_5_0 then
		local var_5_114 = arg_5_0:GetDest()
		local var_5_115 = SummerPubLevelCfg[var_5_114].auto_jump_screen

		if var_5_115 ~= "" and SummerPubData:GetClearNumByStageID(var_5_114) == 1 then
			if var_5_115[1] == SummerPubConst.AUTO_JUMP_TYPE.STAGE_SEA then
				OpenPageUntilLoaded("/summerPubStageView", {
					index = 1
				})
			elseif var_5_115[1] == SummerPubConst.AUTO_JUMP_TYPE.COOK then
				OpenPageUntilLoaded("summerCookMenuView", {
					dishIndex = var_5_115[3]
				})
			elseif var_5_115[1] == SummerPubConst.AUTO_JUMP_TYPE.MAIN then
				OpenPageUntilLoaded("/summerPubEnterView")
			end
		else
			OpenPageUntilLoaded("/summerPubStageView")
		end
	elseif BattleConst.STAGE_TYPE_NEW.GOD_EATER_BATTLE == var_5_0 then
		local var_5_116 = arg_5_0:GetViewType()

		if var_5_116 == "dailyMonster" then
			OpenPageUntilLoaded("/eatGodBattleEnterView")
		elseif var_5_116 == "weekBoss" then
			OpenPageUntilLoaded("/weekBossMainView")
		end
	elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE == var_5_0 then
		OpenPageUntilLoaded("/coreVerificationEnterStageView")
	elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE2 == var_5_0 then
		OpenPageUntilLoaded("/coreVerificationEnterStageViewMode2")
	elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE3 == var_5_0 then
		OpenPageUntilLoaded("/coreVerificationEnterStageViewMode3")
	elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE4 == var_5_0 then
		OpenPageUntilLoaded("/coreVerificationEnterStageViewMode4")
	elseif BattleConst.STAGE_TYPE_NEW.ASH_BATTLE == var_5_0 then
		local var_5_117 = 0
		local var_5_118 = 5280326

		for iter_5_0, iter_5_1 in ipairs(AshShootStageCfg.all) do
			local var_5_119 = AshShootStageCfg[iter_5_1]

			if var_5_119.stage_group == 4 then
				var_5_117 = var_5_119.stage_id

				break
			end
		end

		if arg_5_0.id == var_5_117 then
			OpenPageUntilLoaded("/ashInfinityView")
		elseif arg_5_0.id == var_5_118 and AshSystemData:GetFirstPass() and not arg_5_1 then
			gameContext:OverrideUrl("/ashSectionView", "/ashInfinityView", nil, "home")
			OpenPageUntilLoaded("/ashInfinityView")
		else
			OpenPageUntilLoaded("/ashSectionView", {
				fromBattle = true
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE == var_5_0 then
		local var_5_120 = arg_5_0:GetChapterID()

		if HodurTools.IsChallenge(var_5_120) then
			if HodurTools.GetChallengeComplete() then
				HodurTools.SettleChallenge()
				OpenPageUntilLoaded("/hodurChallengeSettleView", {
					chapter_id = var_5_120
				})
			else
				OpenPageUntilLoaded("/hodurChallengeView", {
					chapter_id = 4,
					activity_id = ActivityConst.ACTIVITY_HODUR_MAIN
				})
			end
		elseif HodurTools.GetCurChapterPass(var_5_120) then
			OpenPageUntilLoaded("/hodurChapterSettlementView", {
				chapter_id = var_5_120
			})
		else
			OpenPageUntilLoaded("/hodurMainlineView", {
				chapter_id = var_5_120,
				activity_id = ActivityConst.ACTIVITY_HODUR_MAIN
			})
		end
	end
end

function var_0_0.hideBattlePanel()
	local var_9_0 = GameObject.Find("UICamera/Canvas/UIMain")

	if var_9_0 == nil then
		return
	end

	local var_9_1 = var_9_0.transform:Find("BattlePanel")

	if var_9_1 ~= nil then
		SetActive(var_9_1.gameObject, false)
	end

	LuaForCursor.SwitchCursor(true)
end

function var_0_0.GetToSeverStarList(arg_10_0)
	local var_10_0 = {}

	for iter_10_0 = 1, #arg_10_0 do
		if arg_10_0 and arg_10_0[iter_10_0] then
			local var_10_1 = {
				star_id = iter_10_0 + BattleConst.STAR,
				is_achieve = arg_10_0[iter_10_0].isComplete and 1 or 0
			}

			table.insert(var_10_0, var_10_1)
		end
	end

	return var_10_0
end

function var_0_0.CaculateStarMission(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:GetThreeStar()
	local var_11_1 = {}

	if var_11_0 then
		for iter_11_0 = 1, #var_11_0 do
			local var_11_2 = var_0_0.CaculateStar(arg_11_0, var_11_0[iter_11_0], arg_11_1)

			table.insert(var_11_1, var_11_2)
		end
	end

	return var_11_1
end

function var_0_0.CaculateStar(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = ThreeStarConditionCfg[arg_12_1[1]]
	local var_12_1 = {
		isComplete = false,
		total = 0,
		current = 0,
		id = arg_12_1[1],
		xData = arg_12_1[2],
		yData = arg_12_1[3]
	}

	if var_12_0.id == BattleConst.STAR_TYPE.DEAD_NUM then
		var_12_1.total = arg_12_1[2]
		var_12_1.current = arg_12_2.totalDeadNum
		var_12_1.isComplete = arg_12_2.totalDeadNum <= arg_12_1[2]
	elseif var_12_0.id == BattleConst.STAR_TYPE.NO_DEAD then
		var_12_1.total = 1
		var_12_1.current = arg_12_2.totalDeadNum > 0 and 0 or 1
		var_12_1.isComplete = var_12_1.current == 1
	elseif var_12_0.id == BattleConst.STAR_TYPE.HITTED_NUM then
		var_12_1.total = arg_12_1[2]
		var_12_1.current = arg_12_2.totalHittedNum
		var_12_1.isComplete = arg_12_2.totalHittedNum <= arg_12_1[2]
	elseif var_12_0.id == BattleConst.STAR_TYPE.USE_TIME then
		var_12_1.total = arg_12_1[2]
		var_12_1.current = math.floor(arg_12_2.battleTime)
		var_12_1.isComplete = arg_12_2.battleTime <= arg_12_1[2]
	elseif var_12_0.id == BattleConst.STAR_TYPE.COMBO then
		var_12_1.total = arg_12_1[2]
		var_12_1.current = arg_12_2.maxComboNum
		var_12_1.isComplete = var_12_1.current >= var_12_1.total
	elseif var_12_0.id == BattleConst.STAR_TYPE.SECOND_DAMAGE then
		var_12_1.total = arg_12_1[3]
		var_12_1.current = var_0_0.CaculateSecondData(arg_12_2.damagePerCount, arg_12_1[3] * 2 + 1)
		var_12_1.isComplete = var_12_1.current >= var_12_1.total
	elseif var_12_0.id == BattleConst.STAR_TYPE.SECOND_KILL then
		var_12_1.total = arg_12_1[3]
		var_12_1.current = var_0_0.CaculateSecondData(arg_12_2.enemyKillPerCount, arg_12_1[3] * 2 + 1)
		var_12_1.isComplete = var_12_1.current >= var_12_1.total
	elseif var_12_0.id == BattleConst.STAR_TYPE.SUCCESS then
		var_12_1.isComplete = whereami ~= "battle"
	elseif var_12_0.id == BattleConst.STAR_TYPE.INJURED_NUM then
		var_12_1.total = arg_12_1[2]
		var_12_1.current = arg_12_2.injuredNum
		var_12_1.isComplete = var_12_1.current <= var_12_1.total
	elseif var_12_0.id == BattleConst.STAR_TYPE.MY_FALL then
		var_12_1.total = arg_12_1[2]
		var_12_1.current = arg_12_2.fallDownNum
		var_12_1.isComplete = var_12_1.current <= var_12_1.total
	elseif var_12_0.id == BattleConst.STAR_TYPE.ENEMY_FALL then
		var_12_1.total = arg_12_1[2]
		var_12_1.current = arg_12_2.knockoutNum
		var_12_1.isComplete = var_12_1.current >= var_12_1.total
	elseif var_12_0.id == BattleConst.STAR_TYPE.HAVE_HERO then
		var_12_1.total = 1
		var_12_1.current = 0

		local var_12_2 = arg_12_0:GetHeroTeam()

		for iter_12_0, iter_12_1 in ipairs(var_12_2) do
			if arg_12_1[2] == iter_12_1 then
				var_12_1.current = 1
			end
		end

		var_12_1.isComplete = var_12_1.current == 1
	elseif var_12_0.id == BattleConst.STAR_TYPE.RESURGENCE_TIME then
		var_12_1.total = arg_12_1[2]
		var_12_1.current = arg_12_2.resurrectTimes
		var_12_1.isComplete = arg_12_2.resurrectTimes <= arg_12_1[2]
	elseif var_12_0.id == BattleConst.STAR_TYPE.NO_RESURGENCE then
		var_12_1.total = 1
		var_12_1.current = arg_12_2.resurrectTimes > 0 and 0 or 1
		var_12_1.isComplete = var_12_1.current == 1
	elseif var_12_0.id == BattleConst.STAR_TYPE.PROP_MULTI then
		var_12_1.total = arg_12_1[2]
		var_12_1.current = 0

		local var_12_3 = arg_12_2.items:GetEnumerator()

		while var_12_3:MoveNext() do
			if var_12_3.Current.Key == arg_12_1[3] then
				var_12_1.current = var_12_3.Current.Value or 0
			end
		end

		var_12_1.isComplete = var_12_1.current >= var_12_1.total
	elseif var_12_0.id == BattleConst.STAR_TYPE.PROP_SINGLE then
		var_12_1.total = 1
		var_12_1.current = 0

		local var_12_4 = arg_12_2.items:GetEnumerator()

		while var_12_4:MoveNext() do
			if var_12_4.Current.Key == arg_12_1[2] then
				var_12_1.current = var_12_4.Current.Value or 0
			end
		end

		var_12_1.isComplete = var_12_1.current >= var_12_1.total
	elseif var_12_0.id == BattleConst.STAR_TYPE.ENEMY_EXCUTE then
		local var_12_5 = LuaExchangeHelper.GetBattleStatisticsData()

		var_12_1.total = arg_12_1[2]
		var_12_1.current = var_12_5.deathInfos.Count
		var_12_1.isComplete = var_12_1.current >= var_12_1.total
	end

	return var_12_1
end

function var_0_0.GetStarMissionText(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = ThreeStarConditionCfg[arg_13_0]
	local var_13_1 = arg_13_1
	local var_13_2 = arg_13_2

	if arg_13_0 == BattleConst.STAR_TYPE.HAVE_HERO then
		var_13_1 = ItemTools.getItemName(tonumber(var_13_1))
	elseif arg_13_0 == BattleConst.STAR_TYPE.PROP_MULTI then
		var_13_2 = ItemTools.getItemName(tonumber(var_13_2))
	elseif arg_13_0 == BattleConst.STAR_TYPE.PROP_SINGLE then
		var_13_1 = ItemTools.getItemName(tonumber(var_13_1))
	end

	return System.String.Format(GetI18NText(var_13_0.desc), GetI18NText(var_13_1), GetI18NText(var_13_2))
end

function var_0_0.RecordThreeStar(arg_14_0, arg_14_1, arg_14_2)
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_14_0 then
		BattleStageAction.ClientModifyThreeStar(arg_14_1, arg_14_2)
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == arg_14_0 and manager.time:GetServerTime() < BattleBossChallengeData:GetNextRefreshTime() then
		BattleBossChallengeAction.ClientModifyThreeStar(arg_14_1, arg_14_2)
	end
end

function var_0_0.CaculateSecondData(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.Count
	local var_15_1 = 0
	local var_15_2 = 0

	if var_15_0 <= arg_15_1 then
		for iter_15_0 = 0, var_15_0 - 1 do
			var_15_2 = arg_15_0[iter_15_0] + var_15_2
		end

		return var_15_2
	else
		for iter_15_1 = 0, arg_15_1 - 1 do
			var_15_2 = arg_15_0[iter_15_1] + var_15_2
		end

		var_15_1 = var_15_2
	end

	for iter_15_2 = 0, var_15_0 - arg_15_1 - 1 do
		local var_15_3 = var_15_2 - arg_15_0[iter_15_2] + arg_15_0[arg_15_1 + iter_15_2]

		var_15_1 = math.max(var_15_1, var_15_3)
		var_15_2 = var_15_3
	end

	return var_15_1
end

function var_0_0.GetSumData(arg_16_0)
	local var_16_0 = arg_16_0.Count
	local var_16_1 = 0

	for iter_16_0 = 0, var_16_0 - 1 do
		var_16_1 = var_16_1 + arg_16_0[iter_16_0]
	end

	return var_16_1
end

function var_0_0.GetMapName(arg_17_0)
	local var_17_0 = BattleChapterStageCfg[arg_17_0]

	if not var_17_0 then
		return ""
	end

	local var_17_1, var_17_2 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, arg_17_0)
	local var_17_3 = getChapterIDByStageID(arg_17_0)

	if ChapterCfg[var_17_3].difficulty == 1 then
		return string.format("%s %s-%s", GetTips("HARDLEVEL_EASY"), GetI18NText(var_17_1), GetI18NText(var_17_2))
	elseif var_17_0.type == 2 then
		return string.format("%s %s-%s", GetTips("HARDLEVEL_HARD_2"), GetI18NText(var_17_1), GetI18NText(var_17_2))
	end
end

function var_0_0.GetCurrentBattleId()
	local var_18_0 = BattleChapterStageCfg.all[1]
	local var_18_1 = BattleStageData:GetStageData() or {}

	for iter_18_0, iter_18_1 in pairs(var_18_1) do
		local var_18_2 = getChapterClientCfgByStageID(iter_18_0)

		if var_18_2 and getChapterToggle(var_18_2.id) == BattleConst.TOGGLE.PLOT and var_18_0 < iter_18_0 then
			var_18_0 = iter_18_0
		end
	end

	return var_18_0
end

function var_0_0.BattleResultAddHeroExp(arg_19_0)
	local var_19_0, var_19_1 = arg_19_0:GetHeroTeam()
	local var_19_2 = arg_19_0:GetSystemHeroTeam()

	if var_19_0[2] == 0 then
		table.remove(var_19_0, 2)
		table.remove(var_19_1, 2)
		table.insert(var_19_0, 0)
		table.insert(var_19_1, 0)
	end

	for iter_19_0 = 1, 3 do
		if var_19_0[iter_19_0] and var_19_0[iter_19_0] ~= 0 then
			local var_19_3 = arg_19_0:GetHeroDataByPos(iter_19_0)

			if not var_19_2[iter_19_0] and var_19_1[iter_19_0] == 0 and var_0_0.NeedAddExp(arg_19_0) then
				local var_19_4 = var_19_3.level
				local var_19_5 = var_19_3.exp - LvTools.LevelToExp(var_19_4, "hero_level_exp1")
				local var_19_6 = LvTools.GetMaxTotalExp("hero_level_exp1") - var_19_3.exp

				if var_19_6 < 0 then
					var_19_6 = 0
				end

				local var_19_7 = arg_19_0:GetMultiple()
				local var_19_8 = arg_19_0:GetAddHeroExp() * var_19_7
				local var_19_9 = arg_19_0:GetActivityID()
				local var_19_10 = ActivityData:GetActivityData(var_19_9)

				if var_19_9 ~= 0 and (not var_19_10 or not var_19_10:IsActivitying()) then
					var_19_8 = 0
				end

				local var_19_11 = math.min(var_19_8, var_19_6)
				local var_19_12 = HeroTools.GetHeroCurrentMaxLevel(var_19_3)
				local var_19_13, var_19_14, var_19_15, var_19_16, var_19_17 = LvTools.CheckHeroExp(var_19_4, var_19_3.exp + var_19_11, var_19_12)
				local var_19_18 = var_19_11 - var_19_17

				HeroAction.AddHeroExpSuccess(var_19_3.id, var_19_13, var_19_3.exp + var_19_18)
			end
		end
	end
end

function var_0_0.NeedAddExp(arg_20_0)
	local var_20_0 = arg_20_0:GetStageId()
	local var_20_1 = BattleStageData:GetStageData()[var_20_0]

	if var_20_1 and var_20_1.clear_times <= 1 then
		return true
	elseif not var_20_1 then
		return true
	else
		return false
	end
end

function var_0_0.GetHardLevel(arg_21_0)
	return arg_21_0 % 10
end

function var_0_0.GetEquipStageShowIndex(arg_22_0)
	return math.floor(arg_22_0 / 10) % 10
end

return var_0_0
