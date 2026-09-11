local var_0_0 = {}
local var_0_1

function var_0_0:OnceMoreBattle()
	local var_1_0 = self:GetType()

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == var_1_0 or BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == var_1_0 then
		if not MythicData:GetIsNew() then
			BattleController.GetInstance():LaunchBattle(self)
		else
			ShowTips("MYTHIC_REFRESH")
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == var_1_0 then
		local var_1_1 = self:GetStageId()
		local var_1_2 = ChapterCfg[getChapterIDByStageID(var_1_1)].section_id_list
		local var_1_3 = table.indexof(var_1_2, var_1_1) or 0

		if var_1_2[var_1_3 + 1] ~= nil then
			BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER, var_1_2[var_1_3 + 1])))
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
				var_0_0.QuitBattle(self)

				var_0_1 = nil
			end, 1.2, 1)

			var_0_1:Start()
		else
			BattleController.GetInstance():LaunchBattle(self)
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == var_1_0 then
		if MatrixData:GetGameState() == MatrixConst.STATE_TYPE.STARTED then
			BattleController.GetInstance():LaunchBattle(self)
		else
			ShowTips("STAGE_REFRESH_DATA")
		end
	elseif BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE == var_1_0 then
		local var_1_4 = SequentialBattleData:GetCurrentFinishStageIndex(activityID) + 1
		local var_1_5 = self:GetActivityID()

		BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, SequentialBattleChapterCfg[var_1_5].stage_id[var_1_4], var_1_5, var_1_5, var_1_4, {
			activityID = self.activityID_
		})))
	elseif BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE == var_1_0 then
		BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE, self:GetStageId(), {
			isRestart = true,
			activityID = self:GetActivityID(),
			chapterID = self:GetChapterID()
		}, self:GetReserveParams())))
	else
		BattleController.GetInstance():LaunchBattle(self)
	end
end

function var_0_0:TryNextBattle()
	if BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == self:GetType() then
		if self.GetNextStage and self:GetNextStage() ~= nil and not MythicData:GetIsNew() then
			BattleController.GetInstance():LaunchBattle(self:GetNextStage())

			return
		else
			BattleInstance.QuitBattle(self)
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
		JumpTools.Jump2SubPlot(getChapterClientCfgByChapterID(arg_4_0).id)
	end

	local var_4_0 = ChapterCfg[arg_4_0]

	if ChapterCfg[arg_4_0].cue_sheet ~= "" then
		manager.audio:PlayBGM(var_4_0.cue_sheet, var_4_0.cue_name, var_4_0.awb)
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

function var_0_0:QuitBattle(arg_5_1, arg_5_2)
	local var_5_0 = self:GetType()

	ReleaseBattleResultSnapshot()

	local var_5_1 = self:GetStageId()

	print(var_5_0, " QuitBattle")

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS == var_5_0 then
		if not arg_5_1 and self.GetNextStage and self:GetNextStage() ~= nil then
			BattleController.GetInstance():LaunchBattle(self:GetNextStage())

			return
		else
			DestroyLua()
			WarChessAction.EnterChessMap()
		end
	elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY == var_5_0 then
		StartGuildActivity(self:GetNodeId())
	elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP == var_5_0 then
		StartGuildActivitySP(self:GetNodeId())

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

		local var_5_2 = self:GetDest()

		if ActivityWhackMoleCfg[var_5_2].type ~= WhackMoleConst.STAGE_TYPE.CHESS then
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/whackMoleMain", {
				activityID = ActivityWhackMoleCfg[var_5_2].activity_id,
				targetSessionIndex = WhackMoleTools.GetLastSessionIndex()
			})
		else
			ChessBoardAction.GoBackFromSmallGame(self:GetBattleResult() == true and 0 or 1, self:GetScore())
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

		if SeaWarfareStageCfg[SeaWarfareTools.GetSeaWarfareStageID(var_5_1)].type == SeaWarfareConst.STAGE_TYPE.CHALLENGE then
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
		if self:GetDest() == SummerPubConst.LEVEL_ID_4030307 then
			OpenPageUntilLoaded("/summerPubStageView")
		end

		DestroyLua()
		gameContext:ClearHistoryByName("setting")
		LuaExchangeHelper.GoToMain()
	elseif BattleConst.STAGE_TYPE_NEW.SKULD == var_5_0 then
		local var_5_4 = self:GetIsStartNext()

		if var_5_4 then
			local var_5_8 = {
				PIECE = 2,
				BATTLE = 1
			}
			local var_5_9 = SkuldStageCfg.all[table.indexof(SkuldStageCfg.all, (self:GetDest())) + 1]

			if SkuldSystemData:GetLevelIDIsOpen(var_5_9) then
				if SkuldStageCfg[var_5_9].type[1] == var_5_8.BATTLE then
					SkuldSystemData:CacheSkuldIconNum()

					if BattleStageTools.GetStageCfg(BattleConst.STAGE_TYPE_NEW.SKULD, SkuldStageCfg[var_5_9].type[2]).tag == BattleConst.BATTLE_TAG.STORY then
						BattleController.GetInstance():LaunchStoryBattle(BattleConst.STAGE_TYPE_NEW.SKULD, SkuldStageCfg[var_5_9].type[2], 0)

						return
					else
						DestroyLua()
						gameContext:ClearHistoryByName("setting")
						LuaExchangeHelper.GoToMain()
					end
				elseif SkuldStageCfg[var_5_9].type[1] == var_5_8.PIECE then
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

	if self:GetIsCooperation() then
		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			CooperationTools.GotoCooperationEntry(var_5_0, self:GetDest(), self:GetActivityID())
		end

		return
	end

	local var_5_10 = getChapterIDByStageID(var_5_1)

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == var_5_0 then
		if ChapterCfg[var_5_10].clientID == ChapterConst.CHAPTER_CLIENT_19 then
			local var_5_11 = BattleFieldData:GetChapterLocationID(var_5_10)

			if ChapterTools.HasNewLocationMainStage(var_5_11) then
				OpenPageUntilLoaded("/chapterPlot19Main/chapterPlot19MapLocationInfo", {
					chapterID = var_5_10,
					locationID = var_5_11
				})
			else
				OpenPageUntilLoaded("/chapterPlot19Main", {})
			end

			return
		end

		local var_5_12 = ChapterConst.ROLL_MAIN_CLINET[getChapterClientCfgByChapterID(var_5_10).id]

		if not arg_5_1 then
			local var_5_13 = getChapterClientCfgByChapterID(var_5_10)

			if #var_5_13.chapter_list > 1 and var_5_13.id ~= ChapterConst.CHAPTER_CLIENT_XUHENG_PART_2_2 and table.keyof(var_5_13.chapter_list, var_5_10) <= #var_5_13.chapter_list and var_5_1 == ChapterCfg[var_5_10].section_id_list[#ChapterCfg[var_5_10].section_id_list] and BattleStageData:GetStageData()[var_5_1].clear_times == 1 and not var_5_12 then
				local var_5_14 = ChapterTools.GetChapterBranchURL(var_5_13.id)

				gameContext:OverrideUrl("/chapterSection", var_5_14, nil, "home")
				OpenPageUntilLoaded(var_5_14, {
					chapterClientID = var_5_13.id
				})

				return
			end

			var_5_10 = StageTools.GetAutoChapter(var_5_10, var_5_1)
		end

		if ChapterCfg[var_5_10].clientID == ChapterConst.CHAPTER_CLIENT_23 or ChapterCfg[var_5_10].clientID == ChapterConst.CHAPTER_CLIENT_24 or ChapterCfg[var_5_10].clientID == ChapterConst.CHAPTER_CLIENT_25 then
			local var_5_15 = ChapterTools.GetChapterBranchURL(ChapterCfg[var_5_10].clientID)

			gameContext:OverrideUrl("/chapterSection", var_5_15, nil, "home")
			OpenPageUntilLoaded(var_5_15, {
				chapterClientID = ChapterCfg[var_5_10].clientID
			})

			return
		end

		if var_5_12 then
			OpenPageUntilLoaded("/chapterSectionRollBg", {
				chapterID = var_5_10
			})
		else
			OpenPageUntilLoaded("/chapterSection", {
				chapterID = var_5_10
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == var_5_0 then
		JumpTools.Jump2SubPlot(getChapterClientCfgByChapterID(var_5_10).id)
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY == var_5_0 then
		OpenPageUntilLoaded("/daily", {
			chapterID = var_5_10
		})
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == var_5_0 then
		OpenPageUntilLoaded("/tower", {
			showInfo = true,
			chapterId = var_5_10
		})
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT == var_5_0 then
		OpenPageUntilLoaded("/enchantment")
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == var_5_0 then
		OpenPageUntilLoaded("/equipSection", {
			chapterID = var_5_10
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
				bossIndex = self:GetBossIndex()
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == var_5_0 then
		OpenPageUntilLoaded("/mythic")
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING == var_5_0 or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING == var_5_0 then
		if BattleConst.COOPERATION_STRONGHOLD_TEACH_STAGE_ID == self:GetStageId() then
			OpenPageUntilLoaded("/cooperationBlank/strongholdMain")
		else
			OpenPageUntilLoaded("/teachStage")
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == var_5_0 then
		local var_5_16 = MatrixData:GetGameState()

		if var_5_16 == MatrixConst.STATE_TYPE.SUCCESS or var_5_16 == MatrixConst.STATE_TYPE.FAIL then
			OpenPageUntilLoaded("/matrixBlank/matrixOver")
		elseif var_5_16 == MatrixConst.STATE_TYPE.STARTED then
			OpenPageUntilLoaded("/matrixBlank/matrixOrigin")
		else
			OpenPageUntilLoaded("/matrixBlank/matrixPrepare", {
				isTimeOut = true
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS == var_5_0 then
		OpenPageUntilLoaded("/warHome")
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY == var_5_0 then
		local var_5_17 = self:GetActivityID()
		local var_5_18 = ActivityTools.GetOriginActivityID(var_5_17)
		local var_5_19 = ActivityTools.GetActivityTheme(var_5_17)

		if var_5_18 == ActivityConst.OSIRIS_STROY then
			OpenPageUntilLoaded("/osirisStoryStage")
		else
			local var_5_21

			if var_5_18 ~= ActivityConst.HELLA_STORY_STAGE_HELLA then
				if var_5_18 == ActivityConst.HELLA_STORY_STAGE_HERMES then
					local var_5_20 = {
						theme = var_5_19
					}

					var_5_20.chapterID = StoryStageActivityData:GetHistoryChapter(var_5_17)

					OpenPageUntilLoaded("/storyStageActivity", var_5_20)
				elseif var_5_18 == ActivityConst.SUMMER_STORY_ISLAND then
					OpenPageUntilLoaded("/summerStageMain", {
						theme = var_5_19,
						chapterID = StoryStageActivityData:GetHistoryChapter(var_5_17)
					})
				elseif var_5_18 == ActivityConst.SUMMER_STORY_SEABED then
					OpenPageUntilLoaded("/summerStageSeabed", {
						theme = var_5_19,
						chapterID = StoryStageActivityData:GetHistoryChapter(var_5_17)
					})
				elseif var_5_18 == ActivityConst.THIRD_VOLUME_PART_2_SUB_PLOT then
					OpenPageUntilLoaded("/activityAthenaStoryStage", {
						theme = var_5_19,
						chapterID = StoryStageActivityData:GetHistoryChapter(var_5_17)
					})
				elseif ActivityTools.GetOriginActivityTheme(var_5_19) == ActivityConst.THEME.FACTORY then
					OpenPageUntilLoaded("/activityFactoryStoryStage", {
						theme = var_5_19,
						chapterID = StoryStageActivityData:GetHistoryChapter(var_5_17)
					})
				end

				var_5_21 = {
					theme = var_5_19
				}
			end

			var_5_21.chapterID = StoryStageActivityData:GetHistoryChapter(var_5_17)

			OpenPageUntilLoaded("/activityStoryStageBase", var_5_21)
		end
	elseif BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON == var_5_0 then
		local var_5_22 = DemonChallengeCfg[self:GetActivityID()].activity_id
		local var_5_23 = ActivityTools.GetMainActivityId(var_5_22)
		local var_5_24 = ActivityTools.GetOriginActivityTheme((ActivityTools.GetActivityTheme(var_5_23)))

		if var_5_24 == ActivityConst.THEME.VOLUME_DOWN then
			OpenPageUntilLoaded("/volumeDemonChallengeMain", {
				activityID = var_5_23,
				childId = var_5_22
			})
		elseif var_5_24 == ActivityConst.THEME.DREAM then
			OpenPageUntilLoaded("/dreamDemonChallengeMain", {
				activityID = var_5_23,
				childId = var_5_22
			})
		elseif var_5_24 == ActivityConst.THEME.ACTIVITY_2_2 then
			OpenPageUntilLoaded("/xuHeng3rddreamDemonChallengeMain", {
				activityID = var_5_23,
				childId = var_5_22
			})
		else
			OpenPageUntilLoaded("/demonChallengeMain", {
				activityID = var_5_23,
				childId = var_5_22
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.HERO_TRIAL == var_5_0 or BattleConst.STAGE_TYPE_NEW.RESIDENT_HERO_TRIAL == var_5_0 then
		HeroTrialTools.GoBackFromBattle(self)
	elseif BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL == var_5_0 then
		local var_5_25 = self:GetActivityID()
		local var_5_26 = SkinTrialData:GetRoute()

		if var_5_26.name == "heroSkin" then
			OpenPageUntilLoaded("/heroSkin", {
				skinID = var_5_26.skinID,
				heroID = var_5_26.heroID
			})
		elseif var_5_26.name == "heroSkinPreview" then
			OpenPageUntilLoaded("/heroSkinPreview", {
				skinID = var_5_26.skinID,
				heroID = var_5_26.heroID,
				initSkinID = var_5_26.initSkinID,
				goodId = var_5_26.goodID
			})
		elseif var_5_26.name == "skinTrialSelect" then
			OpenPageUntilLoaded(string.format("/skinTrialSelect%d", self:GetDest()), {
				activityID = var_5_25,
				skinTrialID = self:GetDest()
			})
		elseif var_5_26.name == "skinTrialSelectView_2_0" then
			OpenPageUntilLoaded("/skinTrialSelectView_2_0", {
				activityID = var_5_25,
				skinTrialID = self:GetDest()
			})
		elseif var_5_26.name == "skinTrialSelectView_2_2" then
			OpenPageUntilLoaded("/skinTrialSelectView_2_2", {
				activityID = var_5_25,
				skinTrialID = self:GetDest()
			})
		elseif var_5_26.name == "skinTrialSelectView_3_0" then
			OpenPageUntilLoaded("/skinTrialSelectView_3_0", {
				activityID = var_5_25,
				skinTrialID = self:GetDest()
			})
		elseif var_5_26.name == "skinTrialSelectView_Resident" then
			OpenPageUntilLoaded("/skinTrialSelectView_Resident", {
				activityID = var_5_25,
				skinTrialID = self:GetDest()
			})
		else
			print("未配置皮肤界面路径！")
		end
	elseif BattleConst.STAGE_TYPE_NEW.RACE_TRIAL == var_5_0 then
		local var_5_27 = self:GetActivityID()
		local var_5_28 = ActivityTools.GetOriginActivityTheme((ActivityTools.GetActivityTheme(var_5_27)))
		local var_5_29 = RaceTrialData:GetMainActivityID(var_5_27)

		if var_5_28 == ActivityConst.THEME.OSIRIS then
			OpenPageUntilLoaded("/raceTrial", {
				activityID = var_5_29
			})
		elseif var_5_28 == ActivityConst.THEME.VOLUME_DOWN then
			OpenPageUntilLoaded("/volumeRaceTrialMain", {
				activityID = var_5_29
			})
		else
			OpenPageUntilLoaded("/raceTrialEnter", {
				activityID = var_5_29
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.SLAYER == var_5_0 then
		local var_5_30 = self:GetActivityID()
		local var_5_31 = self:GetDest()
		local var_5_32 = ActivityTools.GetOriginActivityTheme((ActivityTools.GetActivityTheme(var_5_30)))

		if var_5_32 == ActivityConst.THEME.HELLA then
			OpenPageUntilLoaded("/hellaSlayer", {
				slayer_activity_id = var_5_30
			})
		elseif var_5_32 == ActivityConst.THEME.VOLUME then
			OpenPageUntilLoaded("/volumeSlayer", {
				slayer_activity_id = var_5_30,
				region_activity_id = var_5_31
			})
		elseif var_5_32 == ActivityConst.THEME.TYR then
			OpenPageUntilLoaded("/slayerStageView_1_7", {
				slayer_activity_id = var_5_30,
				region_activity_id = var_5_31
			})
		else
			OpenPageUntilLoaded("/slayerStageView_2_4", {
				slayer_activity_id = var_5_30,
				region_activity_id = var_5_31
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.PARKOUR == var_5_0 then
		local var_5_33 = self:GetActivityID()

		if ActivityTools.GetOriginActivityTheme((ActivityTools.GetActivityTheme(var_5_33))) == ActivityConst.THEME.HELLA then
			if ActivityData:GetActivityIsOpen(var_5_33) then
				OpenPageUntilLoaded("/hellaParkourEntrust", {
					parkour_activity_id = var_5_33,
					entrust_activity_id = self:GetDest()
				})
			else
				OpenPageUntilLoaded("/hellaParkour", {
					parkour_activity_id = var_5_33
				})
			end
		end
	elseif BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE == var_5_0 then
		local var_5_34 = self:GetActivityID()

		if ActivityTools.GetOriginActivityTheme((ActivityTools.GetActivityTheme(var_5_34))) == ActivityConst.THEME.HELLA then
			OpenPageUntilLoaded("/battleFirstPass", {
				activityID = ActivityTools.GetParentActivityID(var_5_34)
			})
		else
			print("未有绑定对应活动！", var_5_34)
		end
	elseif BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE == var_5_0 then
		local var_5_35 = SoloChallengeData:GetActivityID(var_5_1)
		local var_5_36 = SoloChallengeData:GetDifficultyIndex(var_5_1)
		local var_5_37 = ActivityTools.GetActivityTheme(var_5_35)
		local var_5_38 = ActivitySoloChallengeCfg[var_5_35].stage_id[var_5_36][2][#ActivitySoloChallengeCfg[var_5_35].stage_id[var_5_36][2]] == var_5_1

		if var_5_37 == ActivityConst.THEME.SUMMER then
			if not arg_5_1 and var_5_38 then
				local var_5_39 = ActivitySoloChallengeCfg[var_5_35].main_activity_id or ActivityConst.SUMMER_SOLO_CHALLENGE

				OpenPageUntilLoaded("/soloChallengeMain", {
					activityID = var_5_39
				})
			else
				OpenPageUntilLoaded("/soloChallengeSelect", {
					activityID = var_5_35,
					difficultyIndex = var_5_36
				})
			end
		elseif var_5_37 == ActivityConst.THEME.FACTORY then
			if not arg_5_1 and var_5_38 then
				OpenPageUntilLoaded("/factorySoloChallengeMain", {
					activityID = ActivitySoloChallengeCfg[var_5_35].main_activity_id
				})
			else
				OpenPageUntilLoaded("/factorySoloChallengeSelect", {
					activityID = var_5_35,
					difficultyIndex = var_5_36
				})
			end
		elseif var_5_37 == ActivityConst.THEME.TYR then
			if not arg_5_1 and var_5_38 then
				OpenPageUntilLoaded("/soloChallengeMainView_1_7", {
					activityID = ActivitySoloChallengeCfg[var_5_35].main_activity_id
				})
			else
				OpenPageUntilLoaded("/soloChallengeSelectView_1_7", {
					activityID = var_5_35,
					difficultyIndex = var_5_36
				})
			end
		else
			print("未有绑定对应活动！", var_5_35)
		end
	elseif BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION == var_5_0 then
		OpenPageUntilLoaded("/limitedCalculation", {
			activityID = self:GetActivityID()
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
		OpenPageUntilLoaded("/activityPt", {
			activityID = self:GetActivityID()
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
		local var_5_40 = self:GetActivityID()
		local var_5_41 = ActivityMatrixData:GetGameState(var_5_40)

		if var_5_41 == MatrixConst.STATE_TYPE.SUCCESS or var_5_41 == MatrixConst.STATE_TYPE.FAIL then
			OpenPageUntilLoaded("/matrixBlank/activityMatrixOver", {
				matrix_activity_id = var_5_40
			})
		elseif var_5_41 == MatrixConst.STATE_TYPE.STARTED then
			OpenPageUntilLoaded("/matrixBlank/activityMatrixOrigin", {
				matrix_activity_id = var_5_40
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE == var_5_0 then
		local var_5_42 = self:GetActivityID()

		if ActivityTools.GetActivityTheme(var_5_42) == ActivityConst.THEME.VOLUME_DOWN then
			OpenPageUntilLoaded("/activityRaceSwitch", {
				activityID = var_5_42,
				rankID = ActivityConst.ACTIVITY_RACE_RANK
			})
		else
			OpenPageUntilLoaded("/activityRaceSwitch", {
				activityID = var_5_42,
				rankID = ActivityConst.ACTIVITY_RACE_RANK
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == var_5_0 then
		StrategyMatrixAction.GotoAfterBattleMatirx((self:GetActivityID()))
	elseif BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == var_5_0 then
		OpenPageUntilLoaded("/mythicUltimateView")
	elseif BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE == var_5_0 then
		if SequentialBattleData:GetCurrentFinishStageIndex(self:GetActivityID()) >= 4 then
			local var_5_43 = self:GetActivityID()

			SequentialBattleData:ResetChapterTeamData(var_5_43)
			OpenPageUntilLoaded("/sequentialBattleFactory", {
				activityID = SequentialBattleChapterCfg[var_5_43].main_id
			})
		else
			OpenPageUntilLoaded("/sequentialBattleFactoryTeam", {
				activityID = self:GetActivityID()
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.MARDUK_GAME == var_5_0 then
		OpenPageUntilLoaded("/towerGameView", {})
	elseif BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL == var_5_0 then
		local var_5_44 = self:GetActivityID()

		if ActivityCfg[var_5_44].activity_theme == ActivityConst.THEME.FACTORY then
			OpenPageUntilLoaded("/mardukSpecialMain", {
				activityID = ActivityConst.FACTORY_MARDUK
			})
		elseif ActivityCfg[var_5_44].activity_theme == ActivityConst.THEME.ACTIVITY_2_2 then
			OpenPageUntilLoaded("/activityMain_2_2", {
				activityID = ActivityConst.ACTIVITY_2_2,
				subActivityID = ActivityConst.ACTIVITY_2_2_SPECIAL
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO == var_5_0 then
		local var_5_45 = ActivitySoloSlayerCfg[self:GetActivityID()].main_activity_id

		if var_5_45 == ActivityConst.FACTORY_SURVIVE_SOLO or var_5_45 == ActivityConst.TYR_SURVIVE_SOLO then
			OpenPageUntilLoaded("/surviveSolo", {
				activityID = var_5_45
			})
		else
			local var_5_47, var_5_48 = ActivityTools.GetActivityMainRouteByTheme((ActivityTools.GetOriginActivityTheme((ActivityTools.GetActivityTheme(var_5_45)))))

			OpenPageUntilLoaded(var_5_47, var_5_48)
		end
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS == var_5_0 then
		OpenPageUntilLoaded("/nienWorldBoss")
	elseif BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT == var_5_0 then
		local var_5_49 = ActivityTools.GetMainActivityId(self:GetActivityID())

		if var_5_49 == ActivityConst.ACTIVITY_3_2_AFFIX_SELECT then
			OpenPageUntilLoaded("/activityMain_2_8", {
				activityID = ActivityConst.ACTIVITY_3_2,
				subActivityID = var_5_49
			})
		elseif var_5_49 == ActivityConst.ACTIVITY_4_8_AFFIX_SELECT then
			OpenPageUntilLoaded("/affixSelectEnterView4_8", {
				activityID = ActivityConst.ACTIVITY_4_8_AFFIX_SELECT
			})
		else
			OpenPageUntilLoaded("/affixSelectMain", {
				activityID = var_5_49
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST == var_5_0 then
		OpenPageUntilLoaded("/bossCombatSelect", {
			damageTestId = DamageTestCfg.get_id_list_by_stage_id[self:GetStageId()][1]
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL == var_5_0 then
		OpenPageUntilLoaded("/activityPt2", {
			mainActivityId = ActivityPt2Tools:GetMainActivityID(self:GetActivityID()),
			activityID = self:GetActivityID()
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE == var_5_0 then
		OpenPageUntilLoaded("/activityPt2", {
			mainActivityId = ActivityPt2Tools:GetMainActivityID(self:GetActivityID()),
			activityID = self:GetActivityID()
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD == var_5_0 then
		OpenPageUntilLoaded("/activityPt2", {
			mainActivityId = ActivityPt2Tools:GetMainActivityID(self:GetActivityID()),
			activityID = self:GetActivityID()
		})
	elseif BattleConst.STAGE_TYPE_NEW.ABYSS == var_5_0 then
		OpenPageUntilLoaded("/abyssMain", {})
	elseif BattleConst.STAGE_TYPE_NEW.POLYHEDRON == var_5_0 then
		if PolyhedronConst.STATE_TYPE.SETTLEMENT == PolyhedronData:GetPolyhedronInfo():GetState() then
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronOver", {})
		else
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
		end
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER == var_5_0 then
		OpenPageUntilLoaded("/cooperationBlank/xH3rdWaterSelectAssistant", {
			activityID = self:GetMainActivityId()
		})
	elseif BattleConst.STAGE_TYPE_NEW.SAIL_GAME == var_5_0 then
		local var_5_50 = self:GetActivityID()

		if not ActivityData:GetActivityIsOpen(var_5_50) then
			ShowTips("TIME_OVER")
			OpenPageUntilLoaded("/sailMain", {
				activityID = var_5_50
			})

			return
		end

		SailGameAction.SetEventEndMark(var_5_50, (not arg_5_1 or nil) and SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS)
		OpenPageUntilLoaded("/sailMain", {
			activityID = var_5_50
		})

		function _G.OnLoadedCallBack_()
			SailGameTools.GoToGameView(var_5_50)
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
			activityID = self:GetActivityID(),
			difficult = self:GetDifficult()
		})
	elseif BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME == var_5_0 then
		OpenPageUntilLoaded("/destroyBoxGame", {
			activityID = DestroyBoxGameCfg[self:GetDest()].main_activity_id
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME == var_5_0 then
		OpenPageUntilLoaded("/kagutsuchiWork", {})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL == var_5_0 then
		if self:GetActivityID() == ActivityConst.ACTIVITY_PTSCROLL_4_2 then
			OpenPageUntilLoaded("/activityPtScroll_4_2", {
				mainActivityID = self:GetActivityID()
			})
		else
			OpenPageUntilLoaded("/activityPtScroll", {
				mainActivityID = self:GetActivityID()
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA == var_5_0 then
		OpenPageUntilLoaded("/activityAttributeArena", {
			activityID = self:GetActivityID()
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
		OpenPageUntilLoaded("/activityPushBoxMaterial", {
			activityID = self:GetActivityID()
		})
	elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION == var_5_0 then
		OpenPageUntilLoaded("/coreVerificationInfo", {
			bossType = self:GetContID()
		})
	elseif BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1 == var_5_0 then
		OpenPageUntilLoaded("/spHeroChallengeBattleToggleView", {
			stageID = self:GetStageId()
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE == var_5_0 then
		OpenPageUntilLoaded("/activityHeroEnhanceSection_4_5", {
			exitFromBattle = true,
			activityID = self:GetActivityID(),
			cfgId = self:GetHeroEnhanceCfgId()
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE == var_5_0 then
		local var_5_52 = self:GetLevelID()

		OpenPageUntilLoaded("/activityReforgeLevelView", {
			activityID = self:GetMainActivityID(),
			chapterActivityID = self:GetChapterActivityID()
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_SUMMER_WATER == var_5_0 then
		OpenPageUntilLoaded("/summerWaterMain")
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE == var_5_0 then
		OpenPageUntilLoaded("/swimsuitBattleMain", {
			activity = SwimsuitBattleHeroCfg[self:GetActivityID()].activity_id
		})
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WHACK_MOLE == var_5_0 then
		-- block empty
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME == var_5_0 then
		ActivityRhythmGameData:SetCurPage(ActivityRhythmGameTools.GetChapterIDByStageID(self:GetStageId()))

		local var_5_53 = self:GetStageId()

		if ActivityRhythmGameTools.GetStageIsCommand(var_5_53) then
			OpenPageUntilLoaded("/activityRhythmGameCommandView", {
				chapterID = ActivityRhythmGameTools.GetChapterIDByStageID(var_5_53),
				activityID = self:GetActivityID()
			})
		else
			OpenPageUntilLoaded("/activityRhythmGameStageView", {
				activityID = self:GetActivityID(),
				stageID = self:GetStageId()
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
		OpenPageUntilLoaded("/AreaBattleMapView", {
			activityID = self:GetActivityID(),
			mainActivityID = ActivityCfg.get_id_list_by_sub_activity_list[self:GetActivityID()][1],
			stageID = self:GetStageId()
		})
	elseif BattleConst.STAGE_TYPE_NEW.SKULD == var_5_0 then
		CheckManagers()

		local var_5_54 = self:GetDest()

		if self:GetIsStartNext() then
			local var_5_57 = {
				PIECE = 2,
				BATTLE = 1
			}
			local var_5_58 = SkuldStageCfg.all[table.indexof(SkuldStageCfg.all, var_5_54) + 1]

			if SkuldSystemData:GetLevelIDIsOpen(var_5_58) then
				if SkuldStageCfg[var_5_58].type[1] == var_5_57.BATTLE then
					SkuldSystemData:CacheSkuldIconNum()

					if BattleStageTools.GetStageCfg(BattleConst.STAGE_TYPE_NEW.SKULD, SkuldStageCfg[var_5_58].type[2]).tag == BattleConst.BATTLE_TAG.STORY then
						-- block empty
					else
						gameContext:SetUrlAndParams("/skuldSystemStageView", {
							isFinal = var_5_55,
							curLevel = var_5_54
						})
						OpenPageUntilLoaded("/sectionSelectHero", {
							section = SkuldStageCfg[var_5_58].type[2],
							sectionType = BattleConst.STAGE_TYPE_NEW.SKULD
						})
					end
				elseif SkuldStageCfg[var_5_58].type[1] == var_5_57.PIECE then
					gameContext:SetUrlAndParams("/skuldSystemStageView", {
						isFinal = var_5_55,
						curLevel = var_5_54
					})
					OpenPageUntilLoaded("/skuldPuzzleGameView", {
						stageID = SkuldStageCfg[var_5_58].type[2],
						levelID = var_5_58
					})
				end
			else
				ShowTips("ACTIVITY_ZUMA_OPEN_FRONT")
				gameContext:SetUrlAndParams("/skuldSystemStageView", {
					isFinal = var_5_55,
					curLevel = var_5_54
				})
				OpenPageUntilLoaded("/skuldSystemStageView", {
					isFinal = var_5_55,
					curLevel = var_5_54
				})
			end
		elseif var_5_54 == 1030 then
			OpenPageUntilLoaded("/skuldSystemMainView")
		else
			gameContext:SetUrlAndParams("/skuldSystemStageView", {
				isFinal = var_5_55,
				curLevel = var_5_54
			})
			OpenPageUntilLoaded("/skuldSystemStageView", {
				isFinal = var_5_55,
				curLevel = var_5_54
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME == var_5_0 then
		if ActivityGeneralityChapterCfg[ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[self.id][1]].chapter_id].type == 2 then
			OpenPageUntilLoaded("/osirisPlayGameChallegeStageView", {
				activityID_ = self:GetActivityID(),
				chapterID = ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[self.id][1]].chapter_id
			})
		else
			OpenPageUntilLoaded("/osirisPlayGameStageView", {
				isShowTips = 1,
				activityID_ = self:GetActivityID(),
				chapterID = ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[self.id][1]].chapter_id,
				stage_id = self.id,
				isFailed = arg_5_1
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.SUMMER_PUB == var_5_0 then
		local var_5_59 = self:GetDest()

		if SummerPubLevelCfg[var_5_59].auto_jump_screen ~= "" and SummerPubData:GetClearNumByStageID(var_5_59) == 1 then
			if SummerPubLevelCfg[var_5_59].auto_jump_screen[1] == SummerPubConst.AUTO_JUMP_TYPE.STAGE_SEA then
				OpenPageUntilLoaded("/summerPubStageView", {
					index = 1
				})
			elseif SummerPubLevelCfg[var_5_59].auto_jump_screen[1] == SummerPubConst.AUTO_JUMP_TYPE.COOK then
				OpenPageUntilLoaded("summerCookMenuView", {
					dishIndex = SummerPubLevelCfg[var_5_59].auto_jump_screen[3]
				})
			elseif SummerPubLevelCfg[var_5_59].auto_jump_screen[1] == SummerPubConst.AUTO_JUMP_TYPE.MAIN then
				OpenPageUntilLoaded("/summerPubEnterView")
			end
		else
			OpenPageUntilLoaded("/summerPubStageView")
		end
	elseif BattleConst.STAGE_TYPE_NEW.GOD_EATER_BATTLE == var_5_0 then
		local var_5_60 = self:GetViewType()

		if var_5_60 == "dailyMonster" then
			OpenPageUntilLoaded("/eatGodBattleEnterView")
		elseif var_5_60 == "weekBoss" then
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
		local var_5_61 = 0

		for iter_5_0, iter_5_1 in ipairs(AshShootStageCfg.all) do
			if AshShootStageCfg[iter_5_1].stage_group == 4 then
				var_5_61 = AshShootStageCfg[iter_5_1].stage_id

				break
			end
		end

		if self.id == var_5_61 then
			OpenPageUntilLoaded("/ashInfinityView")
		elseif self.id == 5280326 and AshSystemData:GetFirstPass() and not arg_5_1 then
			gameContext:OverrideUrl("/ashSectionView", "/ashInfinityView", nil, "home")
			OpenPageUntilLoaded("/ashInfinityView")
		else
			OpenPageUntilLoaded("/ashSectionView", {
				fromBattle = true
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE == var_5_0 then
		local var_5_62 = self:GetChapterID()

		if HodurTools.IsChallenge(var_5_62) then
			if HodurTools.GetChallengeComplete() then
				HodurTools.SettleChallenge()
				OpenPageUntilLoaded("/hodurChallengeSettleView", {
					chapter_id = var_5_62
				})
			else
				OpenPageUntilLoaded("/hodurChallengeView", {
					chapter_id = 4,
					activity_id = ActivityConst.ACTIVITY_HODUR_MAIN
				})
			end
		elseif HodurTools.GetCurChapterPass(var_5_62) then
			OpenPageUntilLoaded("/hodurChapterSettlementView", {
				chapter_id = var_5_62
			})
		else
			OpenPageUntilLoaded("/hodurMainlineView", {
				chapter_id = var_5_62,
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

function var_0_0:GetToSeverStarList()
	local var_10_0 = {}

	for iter_10_0 = 1, #self do
		if self and self[iter_10_0] then
			table.insert(var_10_0, {
				star_id = iter_10_0 + BattleConst.STAR,
				is_achieve = self[iter_10_0].isComplete and 1 or 0
			})
		end
	end

	return var_10_0
end

function var_0_0:CaculateStarMission(arg_11_1)
	local var_11_0 = self:GetThreeStar()
	local var_11_1 = {}

	if var_11_0 then
		for iter_11_0 = 1, #var_11_0 do
			table.insert(var_11_1, (var_0_0.CaculateStar(self, var_11_0[iter_11_0], arg_11_1)))
		end
	end

	return var_11_1
end

function var_0_0:CaculateStar(arg_12_1, arg_12_2)
	local var_12_0 = {
		isComplete = false,
		total = 0,
		current = 0,
		id = arg_12_1[1],
		xData = arg_12_1[2],
		yData = arg_12_1[3]
	}

	if ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.DEAD_NUM then
		var_12_0.total = arg_12_1[2]
		var_12_0.current = arg_12_2.totalDeadNum
		var_12_0.isComplete = arg_12_2.totalDeadNum <= arg_12_1[2]
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.NO_DEAD then
		var_12_0.total = 1
		var_12_0.current = arg_12_2.totalDeadNum > 0 and 0 or 1
		var_12_0.isComplete = var_12_0.current == 1
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.HITTED_NUM then
		var_12_0.total = arg_12_1[2]
		var_12_0.current = arg_12_2.totalHittedNum
		var_12_0.isComplete = arg_12_2.totalHittedNum <= arg_12_1[2]
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.USE_TIME then
		var_12_0.total = arg_12_1[2]
		var_12_0.current = math.floor(arg_12_2.battleTime)
		var_12_0.isComplete = arg_12_2.battleTime <= arg_12_1[2]
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.COMBO then
		var_12_0.total = arg_12_1[2]
		var_12_0.current = arg_12_2.maxComboNum
		var_12_0.isComplete = var_12_0.current >= var_12_0.total
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.SECOND_DAMAGE then
		var_12_0.total = arg_12_1[3]
		var_12_0.current = var_0_0.CaculateSecondData(arg_12_2.damagePerCount, arg_12_1[3] * 2 + 1)
		var_12_0.isComplete = var_12_0.current >= var_12_0.total
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.SECOND_KILL then
		var_12_0.total = arg_12_1[3]
		var_12_0.current = var_0_0.CaculateSecondData(arg_12_2.enemyKillPerCount, arg_12_1[3] * 2 + 1)
		var_12_0.isComplete = var_12_0.current >= var_12_0.total
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.SUCCESS then
		var_12_0.isComplete = whereami ~= "battle"
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.INJURED_NUM then
		var_12_0.total = arg_12_1[2]
		var_12_0.current = arg_12_2.injuredNum
		var_12_0.isComplete = var_12_0.current <= var_12_0.total
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.MY_FALL then
		var_12_0.total = arg_12_1[2]
		var_12_0.current = arg_12_2.fallDownNum
		var_12_0.isComplete = var_12_0.current <= var_12_0.total
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.ENEMY_FALL then
		var_12_0.total = arg_12_1[2]
		var_12_0.current = arg_12_2.knockoutNum
		var_12_0.isComplete = var_12_0.current >= var_12_0.total
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.HAVE_HERO then
		var_12_0.total = 1
		var_12_0.current = 0

		for iter_12_0, iter_12_1 in ipairs((self:GetHeroTeam())) do
			if arg_12_1[2] == iter_12_1 then
				var_12_0.current = 1
			end
		end

		var_12_0.isComplete = var_12_0.current == 1
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.RESURGENCE_TIME then
		var_12_0.total = arg_12_1[2]
		var_12_0.current = arg_12_2.resurrectTimes
		var_12_0.isComplete = arg_12_2.resurrectTimes <= arg_12_1[2]
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.NO_RESURGENCE then
		var_12_0.total = 1
		var_12_0.current = arg_12_2.resurrectTimes > 0 and 0 or 1
		var_12_0.isComplete = var_12_0.current == 1
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.PROP_MULTI then
		var_12_0.total = arg_12_1[2]
		var_12_0.current = 0

		local var_12_1 = arg_12_2.items:GetEnumerator()

		while var_12_1:MoveNext() do
			if var_12_1.Current.Key == arg_12_1[3] then
				var_12_0.current = var_12_1.Current.Value or 0
			end
		end

		var_12_0.isComplete = var_12_0.current >= var_12_0.total
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.PROP_SINGLE then
		var_12_0.total = 1
		var_12_0.current = 0

		local var_12_2 = arg_12_2.items:GetEnumerator()

		while var_12_2:MoveNext() do
			if var_12_2.Current.Key == arg_12_1[2] then
				var_12_0.current = var_12_2.Current.Value or 0
			end
		end

		var_12_0.isComplete = var_12_0.current >= var_12_0.total
	elseif ThreeStarConditionCfg[arg_12_1[1]].id == BattleConst.STAR_TYPE.ENEMY_EXCUTE then
		var_12_0.total = arg_12_1[2]
		var_12_0.current = LuaExchangeHelper.GetBattleStatisticsData().deathInfos.Count
		var_12_0.isComplete = var_12_0.current >= var_12_0.total
	end

	return var_12_0
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

function var_0_0:CaculateSecondData(arg_15_1)
	local var_15_0 = 0
	local var_15_1 = 0

	if self.Count <= arg_15_1 then
		for iter_15_0 = 0, self.Count - 1 do
			var_15_1 = self[iter_15_0] + var_15_1
		end

		return var_15_1
	else
		for iter_15_1 = 0, arg_15_1 - 1 do
			var_15_1 = self[iter_15_1] + var_15_1
		end

		var_15_0 = var_15_1
	end

	for iter_15_2 = 0, self.Count - arg_15_1 - 1 do
		var_15_0 = math.max(var_15_0, var_15_1 - self[iter_15_2] + self[arg_15_1 + iter_15_2])
		var_15_1 = var_15_1 - self[iter_15_2] + self[arg_15_1 + iter_15_2]
	end

	return var_15_0
end

function var_0_0:GetSumData()
	local var_16_0 = 0

	for iter_16_0 = 0, self.Count - 1 do
		var_16_0 = var_16_0 + self[iter_16_0]
	end

	return var_16_0
end

function var_0_0.GetMapName(arg_17_0)
	if not BattleChapterStageCfg[arg_17_0] then
		return ""
	end

	local var_17_0, var_17_1 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, arg_17_0)

	if ChapterCfg[getChapterIDByStageID(arg_17_0)].difficulty == 1 then
		return string.format("%s %s-%s", GetTips("HARDLEVEL_EASY"), GetI18NText(var_17_0), GetI18NText(var_17_1))
	elseif BattleChapterStageCfg[arg_17_0].type == 2 then
		return string.format("%s %s-%s", GetTips("HARDLEVEL_HARD_2"), GetI18NText(var_17_0), GetI18NText(var_17_1))
	end
end

function var_0_0.GetCurrentBattleId()
	local var_18_0 = BattleChapterStageCfg.all[1]

	for iter_18_0, iter_18_1 in pairs(BattleStageData:GetStageData() or {}) do
		local var_18_1 = getChapterClientCfgByStageID(iter_18_0)

		if var_18_1 and getChapterToggle(var_18_1.id) == BattleConst.TOGGLE.PLOT and var_18_0 < iter_18_0 then
			var_18_0 = iter_18_0
		end
	end

	return var_18_0
end

function var_0_0:BattleResultAddHeroExp()
	local var_19_0, var_19_1 = self:GetHeroTeam()
	local var_19_2 = self:GetSystemHeroTeam()

	if var_19_0[2] == 0 then
		table.remove(var_19_0, 2)
		table.remove(var_19_1, 2)
		table.insert(var_19_0, 0)
		table.insert(var_19_1, 0)
	end

	for iter_19_0 = 1, 3 do
		if var_19_0[iter_19_0] and var_19_0[iter_19_0] ~= 0 then
			local var_19_3 = self:GetHeroDataByPos(iter_19_0)

			if not var_19_2[iter_19_0] and var_19_1[iter_19_0] == 0 and var_0_0.NeedAddExp(self) then
				local var_19_4 = var_19_3.exp - LvTools.LevelToExp(var_19_3.level, "hero_level_exp1")
				local var_19_5 = LvTools.GetMaxTotalExp("hero_level_exp1") - var_19_3.exp

				if var_19_5 < 0 then
					var_19_5 = 0
				end

				local var_19_6 = self:GetAddHeroExp() * self:GetMultiple()
				local var_19_7 = self:GetActivityID()
				local var_19_8 = ActivityData:GetActivityData(var_19_7)
				local var_19_9 = math.min((var_19_7 ~= 0 and (not var_19_8 or not var_19_8:IsActivitying()) or nil) and 0, var_19_5)
				local var_19_10, var_19_11, var_19_12, var_19_13, var_19_14 = LvTools.CheckHeroExp(var_19_3.level, var_19_3.exp + var_19_9, (HeroTools.GetHeroCurrentMaxLevel(var_19_3)))

				HeroAction.AddHeroExpSuccess(var_19_3.id, var_19_10, var_19_3.exp + (var_19_9 - var_19_14))
			end
		end
	end
end

function var_0_0:NeedAddExp()
	local var_20_0 = BattleStageData:GetStageData()[self:GetStageId()]

	if var_20_0 and var_20_0.clear_times <= 1 then
		return true
	elseif not var_20_0 then
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
