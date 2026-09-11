local var_0_0 = {}
local BattleConst = import("game.const.BattleConst")
local BattleInstance = import("game.tools.BattleInstance")
local ViewConst = import("game.const.ViewConst")

function var_0_0:GetName()
	if SystemLinkCfg[self[1]].id == ViewConst.JUMP_SPECIAL_ID.BATTLE_MAIN or SystemLinkCfg[self[1]].id == ViewConst.JUMP_SPECIAL_ID.BATTLE_MAIN_CHAPTER_19 then
		return BattleInstance.GetMapName(self[3]), SystemLinkCfg[self[1]].text_display_1
	elseif SystemLinkCfg[self[1]].id == ViewConst.JUMP_SPECIAL_ID.BATTLE_ASTROLABE or SystemLinkCfg[self[1]].id == ViewConst.JUMP_SPECIAL_ID.BATTLE_EQUIP then
		return ChapterCfg[self[2]].subhead, SystemLinkCfg[self[1]].text_display_1
	else
		return SystemLinkCfg[self[1]].text_display_2, SystemLinkCfg[self[1]].text_display_1
	end
end

function var_0_0.OpenPageUntilLoaded(arg_2_0, arg_2_1, arg_2_2)
	if LuaExchangeHelper.GetSceneIsHanding() then
		gameContext:SetUrlAndParams(arg_2_0, arg_2_1)
	else
		CheckManagers()
		var_0_0.OpenPageByJump(arg_2_0, arg_2_1, arg_2_2)
	end
end

function var_0_0.OpenPageUntilLoadedByTable(arg_3_0, arg_3_1)
	local var_3_0, var_3_1 = var_0_0.GetLinkAndParams(arg_3_0)

	var_0_0.OpenPageUntilLoaded(var_3_0, var_3_1, arg_3_1)
end

var_0_0.IS_OPENING_PAGE = false

function var_0_0.JumpToPage(arg_4_0)
	var_0_0.JumpToPage2(arg_4_0)
end

function var_0_0:JumpToPage2(arg_5_1)
	if SystemLinkCfg[self[1]] == nil then
		return
	end

	local var_5_0, var_5_1 = manager.assetPend:CheckJumpToPage(self)

	if not var_5_0 then
		manager.assetPend:ShowAssetPendMessageBox(var_5_1)

		return
	end

	local var_5_2 = var_0_0.GetSystemActivityID(self)

	if var_5_2 and var_5_2 ~= 0 then
		if ActivityTools.CheckActivityIsSuspended(var_5_2) then
			return
		end

		local var_5_3, var_5_4, var_5_5 = var_0_0.GetActivityTime(var_5_2)

		if var_5_3 > manager.time:GetServerTime() then
			ShowTips(string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStrWith2Unit(var_5_3)))

			return
		end

		if var_5_4 <= manager.time:GetServerTime() then
			if ChapterResidentTools.IsResidentActList(var_5_2) then
				JumpTools.GoToSystem("/chapterMap", {
					chapterToggle = BattleConst.TOGGLE.RESIDENT_ACT,
					activityID = var_5_2
				})

				return
			end

			ShowTips("TIME_OVER")

			return
		end

		local var_5_6 = ActivityEntraceCfg[var_5_2]

		if ActivityEntraceCfg[var_5_2] and var_5_6.story_id ~= 0 and not manager.story:IsStoryPlayed(var_5_6.story_id) then
			manager.notify:Invoke(MUTE_MAIN_AUDIO)

			if JumpTools.GetLinkIsLocked(self) then
				local var_5_7, var_5_8 = JumpTools.GetSystemLockedText(self)

				ShowTips(var_5_8)

				return
			end

			manager.story:StartStoryById(var_5_6.story_id, function()
				PlayerData:StoryModify(var_5_6.story_id)
				var_0_0.JumpToPage2(self, arg_5_1)
			end)

			return
		end

		if self[1] ~= 11001 and not ActivityTools.IsUnlockActivity(var_5_2) then
			if ActivityCfg[var_5_2].unlock_condition[1] == 100 then
				ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityStoryChapterCfg[ActivityCfg[var_5_2].unlock_condition[2][1]].name, BattleActivityStoryStageCfg[ActivityCfg[var_5_2].unlock_condition[2][2]].name))

				return
			elseif ActivityCfg[var_5_2].unlock_condition[1] == 101 then
				if ActivityCfg[var_5_2].unlock_condition[2][1] == 12113 then
					ShowTips(string.format(GetTips("NEED_FINISH_PRE_CHAPTER_STAGE"), GetTips(BattleConst.HARD_LANGUAGE[ChapterCfg[ActivityCfg[var_5_2].unlock_condition[2][1]].difficulty]), GetI18NText(ChapterClientCfg[ChapterCfg[ActivityCfg[var_5_2].unlock_condition[2][1]].clientID].desc), GetI18NText(ChapterClientCfg[ChapterCfg[ActivityCfg[var_5_2].unlock_condition[2][1]].clientID].name)))
				else
					ShowTips(string.format(GetTips("NEED_FINISH_PRE_STAGE"), GetTips(BattleConst.HARD_LANGUAGE[ChapterCfg[ActivityCfg[var_5_2].unlock_condition[2][1]].difficulty]), GetI18NText(ChapterClientCfg[ChapterCfg[ActivityCfg[var_5_2].unlock_condition[2][1]].clientID].desc)))
				end

				return
			end
		end

		if not var_5_5 then
			ShowTips("ERROR_ACTIVITY_NOT_EXIST")

			return
		end

		if self[1] == ViewConst.JUMP_SPECIAL_ID.BATTLE_MAIN and GameSetting.activity_main_plot_unlock_level.value[1] > PlayerData:GetPlayerInfo().userLevel then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.activity_main_plot_unlock_level.value[1]))

			return
		end

		if ActivityCfg[var_5_2].activity_template == ActivityTemplateConst.ACTIVITY_WHACK_MOLE then
			local var_5_9 = SystemLinkCfg[self[1]].params[2] or WhackMoleConst.SESSION_INDEX.FIRST

			if WhackMoleTools.GetSessionIsLock(var_5_2, var_5_9) then
				local var_5_10 = WhackMoleTools.GetSessionID(var_5_2, var_5_9)

				if var_5_10 ~= 0 then
					ShowTips(string.format(GetTips("OPEN_TIME"), ConditionCfg[ActivitySummerChessConditionCfg[var_5_10].condition].desc))
				end

				return
			end
		end

		if ActivityCfg[var_5_2].sub_activity_list[1] ~= nil and ActivityCfg[ActivityCfg[var_5_2].sub_activity_list[1]].activity_template == ActivityTemplateConst.ACTIVITY_MONSTER_COSPLAY then
			if IsConditionAchieved(ActivitySummerChessConditionCfg[(ActivitySummerChessConditionCfg.get_id_list_by_activity_id[var_5_2] or {})[1]].condition) == false then
				ShowTips(string.format(GetTips("OPEN_TIME"), ConditionCfg[ActivitySummerChessConditionCfg[(ActivitySummerChessConditionCfg.get_id_list_by_activity_id[var_5_2] or {})[1]].condition].desc))

				return
			end
		end

		if ActivityCfg[var_5_2].activity_template == ActivityTemplateConst.ACTIVITY_CATCH_DUCK then
			if not CatchDuckData:IsOpenActivity() then
				if ActivitySummerChessConditionCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_CHESS_BOARD_DUCK][1] ~= 0 then
					ShowTips(string.format(GetTips("OPEN_TIME"), ConditionCfg[ActivitySummerChessConditionCfg[ActivitySummerChessConditionCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_CHESS_BOARD_DUCK][1]].condition].desc))
				end

				return
			else
				JumpTools.GoToSystem("/catchDuckMain", {
					isFirst = self[3] == 1
				})

				return
			end
		end

		if var_5_2 == ActivityConst.SUMMER_CHESS_BOARD_RHYTHM then
			local var_5_12 = SystemLinkCfg[self[1]].params[2] or ActivityRhythmGameConst.Chapter_ID.ONE

			if var_5_12 == 1 then
				var_5_12 = ActivityRhythmGameConst.Chapter_ID.ONE
			elseif var_5_12 == 2 then
				var_5_12 = ActivityRhythmGameConst.Chapter_ID.TWO
			end

			if ActivityRhythmGameTools.GetSessionIsLockByID(var_5_12) then
				if var_5_12 ~= 0 then
					ShowTips(string.format(GetTips("OPEN_TIME"), ConditionCfg[ActivitySummerChessConditionCfg[var_5_12].condition].desc))
				end

				return
			end
		end

		if var_5_2 == ActivityConst.SUMMER_CHESS_BOARD_BUBBLE then
			local var_5_13 = SystemLinkCfg[self[1]].params[2] or 1

			if BlisterGameTool.GetSessionIsLock(var_5_2, var_5_13) then
				if var_5_13 ~= 0 then
					local var_5_14 = BlisterGameTool.GetSession(var_5_2, var_5_13)

					ShowTips(string.format(GetTips("OPEN_TIME"), ConditionCfg[(ActivitySummerChessConditionCfg[var_5_14] or nil) and (ActivitySummerChessConditionCfg[var_5_14].condition or 0)].desc))
				end

				return
			end
		end

		if var_5_2 == ActivityConst.SUMMER_CHESS_BOARD_PLUZZE then
			local var_5_15 = SystemLinkCfg[self[1]].params[2] or TangramGameConst.chapterID.ONE

			if not TangramGameTools:CheckChapterIsOpen(var_5_15) then
				if var_5_15 ~= 0 then
					conditionID = ActivitySummerChessConditionCfg[var_5_15 == TangramGameConst.chapterID.ONE and ActivitySummerChessConditionCfg.get_id_list_by_activity_id[var_5_2][1] or ActivitySummerChessConditionCfg.get_id_list_by_activity_id[var_5_2][2]].condition

					ShowTips(string.format(GetTips("OPEN_TIME"), ConditionCfg[conditionID].desc))
				end

				return
			end
		end
	end

	if self[1] == ViewConst.JUMP_SPECIAL_ID.BATTLE_MAIN or self[1] == ViewConst.JUMP_SPECIAL_ID.BATTLE_ROLL_MAIN or self[1] == ViewConst.JUMP_SPECIAL_ID.BATTLE_MAIN_CHAPTER_19 then
		local var_5_17 = self[1]
		local var_5_20 = ChapterCfg[ChapterTools.GetChapterIDFromSystemLink(self)].section_id_list
		local var_5_21, var_5_22 = getMaxOpenSection(self[3] or var_5_20[#var_5_20])

		if ChapterCfg[var_5_22].unlock_activity_id ~= 0 then
			local var_5_23 = ActivityData:GetActivityData(ChapterCfg[var_5_22].unlock_activity_id)

			if manager.time:GetServerTime() < var_5_23.startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_5_23.startTime)))

				return
			end
		end

		if var_5_22 == 11112 then
			if ChapterTools.IsClearChapter(10112) == false then
				var_0_0.JumpToPage2({
					var_5_17,
					10112
				}, arg_5_1)

				return
			end

			if not SkuldTravelData:IsCollectAllPhoto() then
				ShowTips(GetTips("TRAVEL_SKULD_COLLECT_ALL_PHOTO"))

				return
			end
		elseif var_5_22 == 12112 and BattleStageData:GetStageData()[var_5_20[1]] == nil then
			var_0_0.JumpToPage2({
				var_5_17,
				11112
			}, arg_5_1)

			return
		end

		if var_5_22 == ChapterConst.CHAPTER_CLIENT_19 then
			ChapterTools.GotoChapterSection(var_5_22)

			return
		end

		local var_5_25 = getChapterClientCfgByChapterID(var_5_22)

		if var_5_25.id == ChapterConst.CHAPTER_CLIENT_23 or var_5_25.id == ChapterConst.CHAPTER_CLIENT_24 or var_5_25.id == ChapterConst.CHAPTER_CLIENT_25 then
			ChapterTools.GotoChapterSection(var_5_22)

			return
		end

		var_0_0.OpenPageByJump(var_0_0.GetLinkAndParams({
			(ChapterConst.ROLL_MAIN_CLINET[var_5_25.id] or nil) and ViewConst.JUMP_SPECIAL_ID.BATTLE_ROLL_MAIN,
			var_5_22,
			var_5_21
		}))

		return
	elseif self[1] == ViewConst.SYSTEM_ID.BUY_FATIGUE and self[2] == 2 then
		if var_0_0.GetLinkIsLocked(self) then
			local var_5_26, var_5_27 = JumpTools.GetSystemLockedText(self)

			ShowTips(var_5_27)

			return
		end

		if CurrencyData:GetFatigueBuyTimes() >= GameSetting.fatigue_max_buy_time.value[1] then
			ShowTips("ERROR_ITEM_DIAMOND_FATIGUE_TIMES_OVER_LIMIT")

			return
		end
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.MATRIX then
		var_0_0.GoToMatrix()

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.CLUB_TASK then
		var_0_0.GoToGuildTask()

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.BOSS_CHALLENGE then
		if var_0_0.GetLinkIsLocked(self) then
			local var_5_28, var_5_29 = JumpTools.GetSystemLockedText(self)

			ShowTips(var_5_29)

			return
		end

		BattleBossChallengeAction.EnterBossChallenge()

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.STRATEGY_MATRIX then
		StrategyMatrixAction.GotoStrategyMatrix(SystemLinkCfg[self[1]].params[1])

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.THOR_MATRIX then
		StrategyMatrixAction.GotoStrategyMatrix(SystemLinkCfg[self[1]].params[1])

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.POLYHEDRON then
		var_0_0.GoToPolyhedron()

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.BATTLE_EQUIP_BREAK_THROUGH_MATERIAL then
		if var_0_0.GetLinkIsLocked(self) then
			local var_5_30, var_5_31 = JumpTools.GetSystemLockedText(self)

			ShowTips(var_5_31)

			return
		end

		EquipBreakThroughMaterialAction.EnterEquipBTMaterial()

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.MYTHIC then
		if var_0_0.GetLinkIsLocked(self) then
			local var_5_32, var_5_33 = JumpTools.GetSystemLockedText(self)

			ShowTips(var_5_33)

			return
		else
			if MythicData:GetDifficulty() == MythicData:GetFinalId() then
				JumpTools.GoToSystem("/mythicUltimateView", nil, ViewConst.SYSTEM_ID.MYTHIC)
			else
				JumpTools.GoToSystem("/mythic", nil, ViewConst.SYSTEM_ID.MYTHIC)
			end

			return
		end
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.CANTEEN_MAP then
		local var_5_34 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM)

		if var_5_34 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.DORM, var_5_34))

			return nil
		else
			BackHomeTools:GotoBackHomeRoom(DormConst.CANTEEN_ID)

			return
		end
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.DORM_MAP then
		local var_5_35 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM)

		if var_5_35 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.DORM, var_5_35))

			return nil
		else
			BackHomeTools:GotoBackHomeRoom(DormConst.PUBLIC_DORM_ID)

			return
		end
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.BACKHOME_MAP then
		local var_5_36 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM)

		if var_5_36 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.DORM, var_5_36))

			return nil
		else
			JumpTools.OpenPageByJump("/dormChooseRoomView")
			BackHomeDataManager:EnterBackHomeSystem()

			return
		end
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.IDOL_TRAINEE then
		local var_5_37 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM)

		if var_5_37 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.DORM, var_5_37))

			return nil
		else
			BackHomeTools:GotoBackHomeRoom(nil, true)

			return
		end
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.HERO_TEACH then
		if self[2] ~= nil then
			if HeroData:GetHeroData(self[2]).unlock ~= 1 then
				ShowTips("ERROR_HERO_NOT_UNLOCK")

				return
			end

			local var_5_38 = HeroCfg[self[2]]

			if HeroCfg[self[2]] and var_5_38.study_stage and var_5_38.study_stage[1] then
				JumpTools.OpenPageByJump("/teachStage", {
					switchType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
					heroID = self[2]
				})
				JumpTools.OpenPageByJump("teachSectionInfo", {
					sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
					section = var_5_38.study_stage[1]
				})
			end
		else
			JumpTools.OpenPageByJump("/teachStage", {
				switchType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING
			})
		end

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.CLUB_FOUNDED then
		GuildAction.EnterGuild()

		return
	elseif SystemLinkCfg[self[1]].system_id == ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT then
		if var_0_0.GetLinkIsLocked(self) then
			local var_5_39, var_5_40 = JumpTools.GetSystemLockedText(self)

			ShowTips(var_5_40)

			return
		end

		var_0_0.GotoSubPlot(self)

		return
	elseif self[1] == ViewConst.SYSTEM_ID.SKIN_DRAW then
		ActivitySkinDrawTools.OnJumpToSkinDraw(var_5_2)

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.MOON_CAKE then
		local var_5_41 = tostring(self[2])

		if var_5_41 == USER_ID then
			JumpTools.OpenPageByJump("/moonCakeParty", {
				activityID = SystemLinkCfg[self[1]].activity_id,
				mainActivityID = MoonCakeTools.GetMainActivityID(SystemLinkCfg[self[1]].activity_id),
				partyOwnerUID = USER_ID
			})
		else
			MoonCakeAction.VisitParty(SystemLinkCfg[self[1]].activity_id, var_5_41, MoonCakeConst.VISIT_WAY.SHARE)
		end

		return
	elseif self[1] == ViewConst.SYSTEM_ID.SERVANT_SHOP then
		local var_5_42 = ShopTools.GetGoodsIDListByItemID(SystemLinkCfg[self[1]].params[1], self[2])
		local var_5_44 = {}

		for iter_5_0, iter_5_1 in pairs((ShopTools.FilterShopDataList(SystemLinkCfg[self[1]].params[1]))) do
			if iter_5_1.id == var_5_42[1] then
				var_5_44 = iter_5_1
			end
		end

		if getShopCfg(var_5_42[1]) then
			local var_5_45 = getShopCfg(var_5_42[1])
		end

		if JumpTools.GetLinkIsLocked(self) then
			local var_5_46, var_5_47 = JumpTools.GetSystemLockedText(self)

			ShowTips(var_5_47)
		else
			JumpTools.OpenPageByJump("/shop", {
				shopId = SystemLinkCfg[self[1]].params[1]
			}, ViewConst.SYSTEM_ID.SHOP)

			local var_5_48 = getShopCfg(var_5_44.id, SystemLinkCfg[self[1]].params[1])

			if ItemCfg[var_5_48.give_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
				if ShopTools.HaveSkin(var_5_48.give_id) then
					return
				end
			elseif var_5_48.limit_num then
				if var_5_48.limit_num ~= -1 and var_5_48.limit_num <= var_5_44.buyTime then
					return
				end

				local var_5_49, var_5_50 = ShopTools.JudgeIsLvLimit(var_5_48.level_limit)

				if var_5_49 then
					return
				end
			end

			JumpTools.OpenPopUp("shopBuy", {
				goodInfo = var_5_44
			})
		end

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.WEAPON_SERVANT_MERGE then
		local var_5_51 = {
			guideForce = true,
			openTab = "callName",
			race = WeaponServantCfg[self[2]].race,
			servantID = self[2]
		}

		manager.notify:Invoke(SERVANT_SWITCH_TO_CALLNAME, var_5_51)
		JumpTools.OpenPageByJump("/weaponServant", var_5_51)

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.SP_HERO_CHALLENGE_BARBECUE then
		SPHeroChallengeAction:OnEnterBarbuceScene()

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.SP_HERO_CHALLENGE_MAIN_VIEW or self[1] == ViewConst.JUMP_SPECIAL_ID.SP_HERO_CHALLENGE_MAIN_VIEW_RESOURCE then
		if SystemLinkCfg[self[1]] then
			SPHeroChallengeTools:EnterSystem(SystemLinkCfg[self[1]].activity_id)
		end

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.SUMMER_CHESSBOARD then
		local var_5_52, var_5_53 = SummerChessBoardData:CallFun("CurrentUnlockStageID", self[2])

		if not var_5_52 then
			ShowTips(SummerChessBoardData:CallFun("GetUnlockTips", self[2]))

			return
		end

		if gameContext:GetLastOpenPage() == "summerChessBoardTask" then
			var_0_0.Back()
		end

		JumpTools.GoToSystem("/summerChessBoardMainEntry")
		var_0_0.OpenPageByJump(var_0_0.GetLinkAndParams(self))

		return
	elseif SystemLinkCfg[self[1]].system_id >= ViewConst.SYSTEM_ID.HERO and SystemLinkCfg[self[1]].system_id <= ViewConst.SYSTEM_ID.TRANSITION then
		if var_0_0.GetLinkIsLocked(self) then
			local var_5_54, var_5_55 = JumpTools.GetSystemLockedText(self)

			ShowTips(var_5_55)

			return
		end

		local var_5_56, var_5_57, var_5_58 = var_0_0.GetLinkAndParams(self)

		var_5_57.isEnter = true

		var_0_0.OpenPageByJump(var_5_56, var_5_57, var_5_58)

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.GODEATER_SPECIAL_SERVANT then
		if ActivityTools.GetActivityIsOpenWithTip(ActivityConst.ACTIVITY_GODEATER_SERVANT) then
			JumpTools.OpenPageByJump("/draw", {
				poolType = 2,
				poolId = self[2]
			}, ViewConst.SYSTEM_ID.DRAW)
		end

		return
	elseif SystemLinkCfg[self[1]].system_id == ViewConst.SYSTEM_ID.PASSPORT_MAIN or SystemLinkCfg[self[1]].system_id == ViewConst.SYSTEM_ID.PASSPORT_BUY then
		if not PassportData:IsOpen() then
			ShowTips("BATTLEPASS_EXPIRED")

			return
		end
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.SKULD_SELECT_LEVEL then
		JumpTools.OpenPageByJump("/skuldSystemStageView", {
			isFinal = false,
			startNext = false
		})

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.SKULD_SELECT_LEVEL_FINAL then
		local var_5_59 = false

		for iter_5_2, iter_5_3 in pairs(SkuldStageCfg.get_id_list_by_section[9]) do
			if SkuldSystemData:GetLevelIDIsOpen(iter_5_3) then
				var_5_59 = true

				break
			end
		end

		if var_5_59 then
			JumpTools.OpenPageByJump("/skuldSystemStageView", {
				isFinal = true,
				startNext = false
			})
		else
			ShowTips("SKULD_ENDING_LOCK")
		end

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.MUSIC_SELECT then
		JumpTools.OpenPageByJump("/residentMusicGameMainView", {
			activity_id = self[2]
		})
		manager.notify:Invoke(MUSIC_JUMP_SELECT, self[3])

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.OATH_RING_COUPON_FROM_ACTIVITY_DRAW then
		local var_5_60 = ActivityTools.GetAnyOpenActivityByTemplate(ActivityTemplateConst.ACTIVITY_OATH_DRAW_MAIN)

		if var_5_60 then
			JumpTools.OpenPageByJump("/activityOathDrawMainView", {
				activityID = var_5_60
			})
		end

		return
	elseif self[1] == ViewConst.JUMP_SPECIAL_ID.OATH_RING_COUPON_FROM_SKIN_SHOP then
		local var_5_61 = OathTools.CheckAnySkinGiveBackOathRingCoupon()

		if var_5_61 then
			JumpTools.OpenPageByJump("/heroSkin", {
				isDlc = false,
				heroID = SkinCfg[var_5_61].hero,
				skinID = var_5_61,
				shopID = getShopCfg((HeroTools.GetShopIdBySkinId(var_5_61))).shop_id
			})
		end

		return
	elseif var_0_0.GetLinkIsLocked(self) then
		local var_5_62, var_5_63 = JumpTools.GetSystemLockedText(self)

		ShowTips(var_5_63)

		return
	end

	var_0_0.OpenPageByJump(var_0_0.GetLinkAndParams(self))

	if arg_5_1 then
		arg_5_1()
	end
end

function var_0_0.GoToMatrix()
	local var_7_0 = MatrixData:GetGameState()

	if var_7_0 == MatrixConst.STATE_TYPE.SUCCESS or var_7_0 == MatrixConst.STATE_TYPE.FAIL then
		OpenPageUntilLoaded("/matrixBlank/matrixOver")
	else
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare", nil, ViewConst.SYSTEM_ID.MATRIX)
	end
end

function var_0_0.GoToPolyhedron()
	if not PolyhedronData:GetPolyhedronInfo() then
		ShowTips("TIME_OVER")

		return
	end

	if not ActivityData:GetActivityIsOpen((PolyhedronData:GetActivityID())) then
		ShowTips("TIME_OVER")

		return
	end

	JumpTools.GoToSystem("/polyhedronBlank/polyhedronLobby", nil, ViewConst.SYSTEM_ID.MATRIX)
end

function var_0_0.GoToGuildTask()
	if JumpTools.IsSystemOperationStoped(ViewConst.SYSTEM_ID.GUILD) then
		ShowTips("ERROR_FUNCTION_STOP")

		return nil
	end

	local var_9_0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.GUILD)

	if var_9_0 then
		ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.GUILD, var_9_0))

		return
	end

	if GuildData:GetGuildInfo().id == nil then
		GuildAction.EnterGuild()
	else
		JumpTools.OpenPageByJump("/communityTask")
	end
end

function var_0_0.Jump2SubPlot(arg_10_0, arg_10_1, arg_10_2)
	if not manager.assetPend:CheckAssetPend(ChapterClientCfg[arg_10_0].asset_pend_key) then
		manager.assetPend:ShowAssetPendMessageBox(ChapterClientCfg[arg_10_0].asset_pend_key)

		return
	end

	local var_10_0 = BattleFieldData:GetCacheChapter(arg_10_0)

	if not table.keyof(ChapterClientCfg[arg_10_0].chapter_list, var_10_0) then
		var_10_0 = ChapterClientCfg[arg_10_0].chapter_list[1]

		BattleFieldData:SetCacheChapterClient(ChapterClientCfg[arg_10_0].toggle, arg_10_0)
		BattleFieldData:SetCacheChapter(arg_10_0, var_10_0)
		BattleStageAction.ClickSubPlot(var_10_0)
	end

	local var_10_1 = ChapterTools.GetSubPlotUrl(var_10_0, arg_10_2)
	local var_10_2 = {
		chapterClientID = arg_10_0
	}

	if LuaExchangeHelper.GetSceneIsHanding() then
		gameContext:SetUrlAndParams(var_10_1, var_10_2)
	else
		CheckManagers()
		JumpTools.OpenPageByJump(var_10_1, var_10_2, nil, arg_10_1)
	end
end

function var_0_0.Jump2SubPlotByChapterID(arg_11_0, arg_11_1)
	if not ChapterTools.IsUnlockChapter(arg_11_0) then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr((ActivityData:GetActivityRefreshTime(ChapterCfg[arg_11_0].activity_id)))))

		return
	end

	local var_11_0 = getChapterClientCfgByChapterID(arg_11_0)
	local var_11_1 = table.keyof(var_11_0.chapter_list, arg_11_0)

	if var_11_1 > 1 then
		if not ChapterTools.IsClearChapter(var_11_0.chapter_list[var_11_1 - 1]) then
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), "", GetI18NText(ChapterCfg[var_11_0.chapter_list[var_11_1 - 1]].subhead)))

			return
		end
	end

	BattleStageAction.ClickSubPlot(arg_11_0)

	if arg_11_1 then
		JumpTools.OpenPageByJump(ChapterTools.GetSubPlotUrl(arg_11_0, isEntrace), {
			chapterClientID = var_11_0.id,
			chapterID = arg_11_0
		})
	else
		manager.notify:Invoke(CHANGE_CHAPTER, arg_11_0)
	end
end

function var_0_0:GotoSubPlot()
	local var_12_1, var_12_2 = ChapterTools.GetSubPlotUrl(self[2], false)
	local var_12_3 = {
		chapterClientID = ChapterCfg[self[2]].clientID
	}

	if self[3] and BattleStageData:GetStageData()[self[3]] and not var_12_2 and not StageTools.IsLockSubChapterStage(self[2], self[3]) then
		var_12_1 = var_12_1 .. "/subPlotSectionInfo"
		var_12_3 = {
			chapterClientID = ChapterCfg[self[2]].clientID,
			section = self[3],
			chapterID = self[2],
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
		}

		if self[2] then
			BattleFieldData:SetCacheStage(self[2], self[3])
			BattleFieldData:SetCacheChapter(ChapterCfg[self[2]].clientID, self[2])
			BattleStageAction.ClickSubPlot(self[2])
		end
	else
		local var_12_4, var_12_5 = ChapterTools.GetSubPlotMaxStageID(self[2])

		BattleFieldData:SetCacheStage(var_12_4, var_12_5)
		BattleFieldData:SetCacheChapter(ChapterCfg[self[2]].clientID, var_12_4)
		BattleStageAction.ClickSubPlot(var_12_4)
	end

	CheckManagers()
	gameContext:Go(var_12_1, var_12_3)
end

function var_0_0.GetActivityTime(arg_13_0)
	local var_13_0 = ChapterResidentTools.GetResidentActMainID(arg_13_0)

	if var_13_0 then
		arg_13_0 = var_13_0
	end

	local var_13_1 = ActivityData:GetActivityData(arg_13_0)

	return var_13_1.startTime, var_13_1.stopTime, (var_13_1:GetStateBool())
end

function var_0_0:GetLinkAndParams()
	local var_14_0 = SystemLinkCfg[self[1]]
	local var_14_1 = {}

	if SystemLinkCfg[self[1]].paramName and type(var_14_0.paramName) == "table" then
		local var_14_2 = 0

		if var_14_0.params and type(var_14_0.params) == "table" then
			var_14_2 = #var_14_0.params
		end

		local var_14_3 = 2

		for iter_14_0 = 1, #var_14_0.paramName do
			if iter_14_0 <= var_14_2 then
				var_14_1[var_14_0.paramName[iter_14_0]] = var_14_0.params[iter_14_0]
			else
				var_14_1[var_14_0.paramName[iter_14_0]] = self[var_14_3]
				var_14_3 = var_14_3 + 1
			end
		end
	end

	for iter_14_1, iter_14_2 in pairs(self) do
		if type(iter_14_1) == "string" then
			var_14_1[iter_14_1] = iter_14_2
		end
	end

	if self[1] == ViewConst.JUMP_SPECIAL_ID.BATTLE_MAIN or self[1] == ViewConst.JUMP_SPECIAL_ID.BATTLE_ROLL_MAIN then
		var_14_1.sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT
	end

	return var_14_0.link, var_14_1, var_14_0.system_id
end

function var_0_0:GetLinkIsLocked()
	if JumpTools.IsSystemOperationStoped(SystemLinkCfg[self[1]].system_id) then
		return true
	end

	if var_0_0.IsSystemLocked(SystemLinkCfg[self[1]].system_id) then
		return true
	end

	if SystemLinkCfg[self[1]].id == ViewConst.JUMP_SPECIAL_ID.BATTLE_MAIN and not BattleStageData:GetStageData()[self[2]] then
		return true
	end

	if SystemLinkCfg[self[1]].id == ViewConst.JUMP_SPECIAL_ID.BATTLE_DAILY then
		return PlayerData:GetPlayerInfo().userLevel < BattleDailyStageCfg[ChapterCfg[self[2]].section_id_list[1]].level
	end

	if SystemLinkCfg[self[1]].id == ViewConst.JUMP_SPECIAL_ID.BATTLE_ASTROLABE and not BattleStageData:IsOpenChapter(self[2]) then
		return true
	end

	if SystemLinkCfg[self[1]].id == ViewConst.JUMP_SPECIAL_ID.BATTLE_EQUIP and not BattleStageData:IsOpenChapter(self[2]) then
		return true
	end

	if SystemLinkCfg[self[1]].id == ViewConst.JUMP_SPECIAL_ID.HERO_TRUST then
		return not HeroTools.GetHeroIsUnlock(self[2])
	end

	local var_15_0 = var_0_0.GetSystemActivityID(self)

	if var_15_0 and var_15_0 ~= 0 then
		local var_15_1, var_15_2, var_15_3 = var_0_0.GetActivityTime(var_15_0)

		if var_15_1 > manager.time:GetServerTime() then
			return true
		end

		if var_15_2 <= manager.time:GetServerTime() then
			return true
		end

		if self[1] ~= 11001 and not ActivityTools.IsUnlockActivity(var_15_0) then
			return true
		end

		if not var_15_3 then
			return true
		end
	end

	if SystemLinkCfg[self[1]].system_id == ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT and not ChapterTools.IsUnlockSubPlotClient(self[2]) then
		return true
	end

	if (SystemLinkCfg[self[1]].system_id == ViewConst.SYSTEM_ID.PASSPORT_MAIN or SystemLinkCfg[self[1]].system_id == ViewConst.SYSTEM_ID.PASSPORT_BUY) and not PassportData:IsOpen() then
		return true
	end

	return false
end

function var_0_0:GetSystemLockedText()
	if self[1] == ViewConst.JUMP_SPECIAL_ID.HERO_TRUST and not HeroTools.GetHeroIsUnlock(self[2]) then
		return true, GetTips("ERROR_HERO_NOT_GET")
	end

	if JumpTools.IsSystemOperationStoped(SystemLinkCfg[self[1]].system_id) then
		return true, GetTips("ERROR_FUNCTION_STOP")
	end

	if SystemCfg[SystemLinkCfg[self[1]].system_id] and SystemCfg[SystemLinkCfg[self[1]].system_id].open_condition then
		for iter_16_0, iter_16_1 in ipairs(SystemCfg[SystemLinkCfg[self[1]].system_id].open_condition) do
			if iter_16_1[1] == ViewConst.SYSTEM_LOCK_TYPE.LOCK then
				return true, GetTips("SYSTEM_LOCK")
			elseif iter_16_1[1] == ViewConst.SYSTEM_LOCK_TYPE.LEVEL then
				if PlayerData:GetPlayerInfo().userLevel < iter_16_1[2] then
					return true, string.format(GetTips("PLAYER_LEVEL_UNLOCK"), iter_16_1[2])
				end
			elseif iter_16_1[1] == ViewConst.SYSTEM_LOCK_TYPE.BATTLE then
				local var_16_0 = BattleStageData:GetStageData()
				local var_16_1 = iter_16_1[3] and var_16_0[iter_16_1[3]]

				if var_16_0[iter_16_1[2]] and var_16_0[iter_16_1[2]].clear_times > 0 or var_16_1 and var_16_1.clear_times > 0 then
					return false, ""
				elseif BattleChapterStageCfg[iter_16_1[2]] == nil then
					return true, "未知的关卡ID" .. iter_16_1[2]
				else
					local var_16_2 = getChapterDifficulty(iter_16_1[2])
					local var_16_3, var_16_4 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(iter_16_1[2]).toggle, iter_16_1[2])

					return true, string.format(GetTips("MISSION_PROGRESS_UNLOCK"), GetI18NText(var_16_2), GetI18NText(var_16_3), GetI18NText(var_16_4))
				end
			elseif iter_16_1[1] == ViewConst.SYSTEM_LOCK_TYPE.HERO_FAVORABILITY then
				if ArchiveData:GetArchive(iter_16_1[2]).lv < iter_16_1[3] then
					return true, string.format(GetTips("HERO_FAVORABILITY_UNLOCK"), HeroRecordCfg[iter_16_1[2]].name, iter_16_1[3])
				end
			elseif iter_16_1[1] == ViewConst.SYSTEM_LOCK_TYPE.ANY_HERO_FAVORABILITY then
				return true, string.format(GetTips("ANY_FAVORABILITY_UNLOCK"), iter_16_1[2])
			else
				print("未实现的系统解锁判断方式:", iter_16_1[1])
			end
		end
	end

	local var_16_5 = var_0_0.GetSystemActivityID(self)

	if var_16_5 and var_16_5 ~= 0 then
		local var_16_6, var_16_7, var_16_8 = var_0_0.GetActivityTime(var_16_5)

		if var_16_6 > manager.time:GetServerTime() then
			return true, string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_16_6))
		end

		if var_16_7 <= manager.time:GetServerTime() then
			return true, GetTips("TIME_OVER")
		end

		if self[1] ~= 11001 and not ActivityTools.IsUnlockActivity(var_16_5) then
			if ActivityCfg[var_16_5].unlock_condition[1] == 100 then
				return true, string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityStoryChapterCfg[ActivityCfg[var_16_5].unlock_condition[2][1]].name, BattleActivityStoryStageCfg[ActivityCfg[var_16_5].unlock_condition[2][2]].name)
			elseif ActivityCfg[var_16_5].unlock_condition[1] == 101 then
				return true, string.format(GetTips("NEED_FINISH_PRE_STAGE"), GetTips(BattleConst.HARD_LANGUAGE[ChapterCfg[ActivityCfg[var_16_5].unlock_condition[2][1]].difficulty]), GetI18NText(ChapterClientCfg[ChapterCfg[ActivityCfg[var_16_5].unlock_condition[2][1]].clientID].desc))
			elseif ActivityCfg[var_16_5].unlock_condition[1] == 102 then
				return ChapterTools.IsClearStage(ActivityCfg[var_16_5].unlock_condition[2][2]), string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ChapterCfg[ActivityCfg[var_16_5].unlock_condition[2][1]].subhead, BattleActivityStoryStageCfg[ActivityCfg[var_16_5].unlock_condition[2][2]].name)
			end
		end

		if not var_16_8 then
			return true, GetTips("TIME_OVER")
		end
	end

	if SystemLinkCfg[self[1]].system_id == ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT then
		local var_16_9, var_16_10 = ChapterTools.IsUnlockSubPlotClient(self[2])

		if not var_16_9 then
			return true, var_16_10
		end
	end

	if SystemCfg[SystemLinkCfg[self[1]].system_id] and not SystemData:GetSystemIsOpen(SystemLinkCfg[self[1]].system_id) then
		return true, GetTips("SYSTEM_LOCK")
	end

	local var_16_11 = var_0_0.CustomLock(SystemLinkCfg[self[1]].system_id)

	if var_16_11 then
		return true, GetTips(var_16_11[1])
	end

	return false, ""
end

function var_0_0.GetSystemActivityID(arg_17_0)
	local var_17_0 = var_0_0.GetSystemParamActivityID(arg_17_0, "subActivityID")

	if var_17_0 and var_17_0 ~= 0 then
		return var_17_0
	end

	local var_17_1 = var_0_0.GetSystemParamActivityID(arg_17_0, "activityId")

	if var_17_1 and var_17_1 ~= 0 then
		return var_17_1
	end

	local var_17_2 = var_0_0.GetSystemParamActivityID(arg_17_0, "activityID")

	if var_17_2 and var_17_2 ~= 0 then
		return var_17_2
	end
end

function var_0_0:GetSystemParamActivityID(arg_18_1)
	local var_18_0 = SystemLinkCfg[self[1]].activity_id

	if type(SystemLinkCfg[self[1]].paramName) == "table" then
		local var_18_1 = table.keyof(SystemLinkCfg[self[1]].paramName, arg_18_1)

		if var_18_1 then
			var_18_0 = type(SystemLinkCfg[self[1]].params) == "table" and SystemLinkCfg[self[1]].params[var_18_1] and SystemLinkCfg[self[1]].params[var_18_1] or self[var_18_1 + 1]
		end
	end

	return var_18_0
end

function var_0_0.IsSystemOperationStoped(arg_19_0)
	if arg_19_0 == nil then
		return false
	end

	local var_19_0 = SystemCfg[arg_19_0]

	if not SystemCfg[arg_19_0] then
		return false
	end

	if var_19_0.operation_stop_id ~= 0 then
		if OperationData:IsFunctionStoped(var_19_0.operation_stop_id) then
			return true
		end

		return false
	end
end

function var_0_0.IsSystemLocked(arg_20_0)
	if SystemCfg[arg_20_0] then
		if SystemCfg[arg_20_0].open_condition then
			for iter_20_0, iter_20_1 in ipairs(SystemCfg[arg_20_0].open_condition) do
				local var_20_0 = var_0_0.IsConditionLocked(iter_20_1)

				if var_20_0 then
					return var_20_0
				end
			end
		end

		if SystemCfg[arg_20_0].system_hide == 1 then
			return {
				"server_lock"
			}
		end

		if not SystemData:GetSystemIsOpen(arg_20_0) then
			return {
				"server_lock"
			}
		end
	end

	return var_0_0.CustomLock(arg_20_0)
end

function var_0_0:IsConditionLocked()
	if self[1] == ViewConst.SYSTEM_LOCK_TYPE.LOCK then
		return self
	elseif self[1] == ViewConst.SYSTEM_LOCK_TYPE.LEVEL then
		if PlayerData:GetPlayerInfo().userLevel < self[2] then
			return self
		end
	elseif self[1] == ViewConst.SYSTEM_LOCK_TYPE.BATTLE then
		local var_21_0 = BattleStageData:GetStageData()
		local var_21_1 = self[3] and var_21_0[self[3]]

		if var_21_0[self[2]] and var_21_0[self[2]].clear_times > 0 or var_21_1 and var_21_1.clear_times > 0 then
			return false
		else
			return self
		end
	elseif self[1] == ViewConst.SYSTEM_LOCK_TYPE.HERO_FAVORABILITY then
		if ArchiveData:GetArchive(self[2]).lv < self[3] then
			return self
		end
	elseif self[1] == ViewConst.SYSTEM_LOCK_TYPE.ANY_HERO_FAVORABILITY then
		local var_21_2 = false

		for iter_21_0, iter_21_1 in pairs((HeroData:GetHeroList())) do
			if HeroTools.GetHeroIsUnlock(iter_21_0) and self[2] <= ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[iter_21_0][1]).lv then
				var_21_2 = true

				break
			end
		end

		if not var_21_2 then
			return self
		end
	else
		print("未实现的系统解锁判断方式:", self[1])
	end
end

local var_0_4 = {}

function var_0_0.SetSystemOpenCheck(arg_22_0, arg_22_1)
	var_0_4[arg_22_0] = arg_22_1
end

function var_0_0.GoToSystem(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if var_0_0.IS_OPENING_PAGE then
		return
	end

	if ShopTools.IsPC() and arg_23_1 and arg_23_1.shopId and not SDKTools.GetIsOverSea() and ShopConst.PC_LOCK_SHOP[arg_23_1.shopID] and ShopTools.IsLimitRecharge() then
		ShowTips("PC_SHOP_TIPS1")

		return
	end

	if ShopTools.IsPC() and arg_23_1 and arg_23_1.childShopIndex and not SDKTools.GetIsOverSea() and ShopConst.PC_LOCK_RECHARGE[arg_23_1.childShopIndex .. "_" .. arg_23_1.page] and ShopTools.IsLimitRecharge() then
		ShowTips("PC_SHOP_TIPS1")

		return
	end

	if var_0_0.IsSystemOperationStoped(arg_23_2) then
		ShowTips("ERROR_FUNCTION_STOP")

		return nil
	end

	local var_23_0 = var_0_0.IsSystemLocked(arg_23_2)

	if arg_23_2 and var_23_0 then
		ShowTips(var_0_0.GetSystemLockedTip(arg_23_2, var_23_0))

		return nil
	end

	if var_0_4[arg_23_2] then
		local var_23_1, var_23_2 = var_0_4[arg_23_2](arg_23_1)

		if not var_23_1 then
			ShowTips(var_23_2)

			return nil
		end
	end

	gameContext:Go(arg_23_0, arg_23_1, arg_23_3, true)
end

function var_0_0.GetSystemLockedTip(arg_24_0, arg_24_1)
	if arg_24_0 and arg_24_1 then
		if arg_24_1[1] == ViewConst.SYSTEM_LOCK_TYPE.LEVEL then
			return string.format(GetTips("PLAYER_LEVEL_UNLOCK"), arg_24_1[2])
		elseif arg_24_1[1] == ViewConst.SYSTEM_LOCK_TYPE.BATTLE then
			local var_24_0, var_24_1 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(arg_24_1[2]).toggle, arg_24_1[2])

			return string.format(GetTips("MISSION_PROGRESS_UNLOCK"), getChapterDifficulty(arg_24_1[2]), GetI18NText(var_24_0), GetI18NText(var_24_1))
		elseif arg_24_1[1] == ViewConst.SYSTEM_LOCK_TYPE.HERO_FAVORABILITY then
			return string.format(GetTips("HERO_FAVORABILITY_UNLOCK"), GetI18NText(HeroRecordCfg[arg_24_1[2]].name), arg_24_1[3])
		elseif arg_24_1[1] == ViewConst.SYSTEM_LOCK_TYPE.ANY_HERO_FAVORABILITY then
			return string.format(GetTips("ANY_FAVORABILITY_UNLOCK"), arg_24_1[2])
		elseif arg_24_1[1] == "TIME_OVER" then
			return GetTips("TIME_OVER")
		end
	end

	return GetTips("SYSTEM_LOCK")
end

function var_0_0.Back(arg_25_0, arg_25_1)
	GlobalCall.register("AfterGo", function()
		var_0_0.RefreshGaussianBg()
	end)
	gameContext:Back(arg_25_0, arg_25_1)
end

function var_0_0.OpenPageByJump(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if var_0_0.IS_OPENING_PAGE then
		return
	end

	if ShopTools.IsPC() and arg_27_1 and arg_27_1.shopId and not SDKTools.GetIsOverSea() and ShopConst.PC_LOCK_SHOP[arg_27_1.shopID] then
		ShowTips("PC_SHOP_TIPS1")

		return
	end

	if ShopTools.IsPC() and arg_27_1 and arg_27_1.childShopIndex and not SDKTools.GetIsOverSea() and ShopConst.PC_LOCK_RECHARGE[arg_27_1.childShopIndex .. "_" .. arg_27_1.page] then
		ShowTips("PC_SHOP_TIPS1")

		return
	end

	local var_27_1 = string.char(string.byte(arg_27_0)) == "/" and string.split(string.sub(arg_27_0, 2, #arg_27_0), "/") or string.split(arg_27_0, "/")

	GlobalCall.register("AfterGo", function()
		var_0_0.RefreshGaussianBg()
	end)
	var_0_0.GoToSystem(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
end

function var_0_0.OpenPopUp(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	GlobalCall.register("AfterGo", function()
		var_0_0.RefreshGaussianBg()

		if arg_29_3 then
			arg_29_3()
		end
	end)
	var_0_0.GoToSystem(arg_29_0, arg_29_1, arg_29_2)
end

function var_0_0.GetRealPageName(arg_31_0)
	if string.char(string.byte(arg_31_0)) == "/" then
		return string.sub(arg_31_0, 2, #arg_31_0)
	else
		return arg_31_0
	end
end

function var_0_0.RefreshGaussianBg()
	local var_32_0 = gameContext:GetAllOpenRoute()
	local var_32_1 = false

	for iter_32_0 = #var_32_0, 1, -1 do
		if var_0_0.SetGaussionBg(var_32_0[iter_32_0], ViewConst.NEED_GAUSSIAN_POPUP[var_32_0[iter_32_0]] or false) then
			var_32_1 = true
		end
	end

	manager.ui:SetUISeparateRender(var_32_1)
end

function var_0_0.SetGaussionBg(arg_33_0, arg_33_1)
	local var_33_0 = gameContext:GetOpenPageHandler(arg_33_0)

	if var_33_0 then
		return var_33_0:SetGaussionBg(arg_33_1)
	end

	return false
end

function var_0_0.JudgeIsHaveGaussian(arg_34_0)
	for iter_34_0, iter_34_1 in ipairs(arg_34_0) do
		if ViewConst.NEED_GAUSSIAN_POPUP[iter_34_1] then
			return true
		end
	end

	return false
end

function var_0_0.IsActivityOpen(arg_35_0)
	local var_35_0 = var_0_0.GetSystemActivityID(arg_35_0)

	if var_35_0 and var_35_0 ~= 0 then
		local var_35_1, var_35_2, var_35_3 = var_0_0.GetActivityTime(var_35_0)

		if var_35_1 > manager.time:GetServerTime() or var_35_2 <= manager.time:GetServerTime() then
			return false
		end
	end

	return true
end

function var_0_0:NeedHide(arg_36_1)
	if SystemLinkCfg[self[1]].need_hide ~= 1 then
		return false
	end

	if var_0_0.IsActivityOpen(self) == false then
		return true
	end

	if SystemLinkCfg[self[1]].system_id == ViewConst.SYSTEM_ID.SHOP_ENTER then
		local var_36_0, var_36_1 = var_0_0.GetLinkAndParams(self)

		if var_36_1.shopId and ShopTools.IsGoodCanExchange(var_36_1.shopId, (ShopTools.GetGoodsIDListByItemID(var_36_1.shopId, arg_36_1))) == false then
			return true
		end
	end

	return false
end

function var_0_0.CustomLock(arg_37_0)
	if arg_37_0 == ViewConst.SYSTEM_ID.BATTLE_ABYSS then
		if manager.time:GetServerTime() + 1 >= AbyssData:GetRefreshTimestamp() then
			return {
				"TIME_OVER"
			}
		end
	elseif arg_37_0 == ViewConst.SYSTEM_ID.MATRIX and manager.time:GetServerTime() + 1 >= ActivityData:GetActivityData((PolyhedronData:GetActivityID())).stopTime then
		return {
			"TIME_OVER"
		}
	end

	return false
end

return var_0_0
