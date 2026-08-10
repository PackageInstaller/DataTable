local var_0_0 = {}
local var_0_1 = import("game.const.BattleConst")
local var_0_2 = import("game.tools.BattleInstance")
local var_0_3 = import("game.const.ViewConst")

function var_0_0.GetName(arg_1_0)
	local var_1_0 = SystemLinkCfg[arg_1_0[1]]

	if var_1_0.id == var_0_3.JUMP_SPECIAL_ID.BATTLE_MAIN or var_1_0.id == var_0_3.JUMP_SPECIAL_ID.BATTLE_MAIN_CHAPTER_19 then
		return var_0_2.GetMapName(arg_1_0[3]), var_1_0.text_display_1
	elseif var_1_0.id == var_0_3.JUMP_SPECIAL_ID.BATTLE_ASTROLABE or var_1_0.id == var_0_3.JUMP_SPECIAL_ID.BATTLE_EQUIP then
		return ChapterCfg[arg_1_0[2]].subhead, var_1_0.text_display_1
	else
		return var_1_0.text_display_2, var_1_0.text_display_1
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

function var_0_0.JumpToPage2(arg_5_0, arg_5_1)
	local var_5_0 = SystemLinkCfg[arg_5_0[1]]

	if var_5_0 == nil then
		return
	end

	local var_5_1, var_5_2 = manager.assetPend:CheckJumpToPage(arg_5_0)

	if not var_5_1 then
		manager.assetPend:ShowAssetPendMessageBox(var_5_2)

		return
	end

	local var_5_3 = var_0_0.GetSystemActivityID(arg_5_0)

	if var_5_3 and var_5_3 ~= 0 then
		if ActivityTools.CheckActivityIsSuspended(var_5_3) then
			return
		end

		local var_5_4, var_5_5, var_5_6 = var_0_0.GetActivityTime(var_5_3)

		if var_5_4 > manager.time:GetServerTime() then
			local var_5_7 = GetTips("UNLOCK")

			ShowTips(string.format(var_5_7, manager.time:GetLostTimeStrWith2Unit(var_5_4)))

			return
		end

		if var_5_5 <= manager.time:GetServerTime() then
			if ChapterResidentTools.IsResidentActList(var_5_3) then
				JumpTools.GoToSystem("/chapterMap", {
					chapterToggle = var_0_1.TOGGLE.RESIDENT_ACT,
					activityID = var_5_3
				})

				return
			end

			ShowTips("TIME_OVER")

			return
		end

		local var_5_8 = ActivityEntraceCfg[var_5_3]

		if var_5_8 and var_5_8.story_id ~= 0 and not manager.story:IsStoryPlayed(var_5_8.story_id) then
			manager.notify:Invoke(MUTE_MAIN_AUDIO)

			if JumpTools.GetLinkIsLocked(arg_5_0) then
				local var_5_9, var_5_10 = JumpTools.GetSystemLockedText(arg_5_0)

				ShowTips(var_5_10)

				return
			end

			manager.story:StartStoryById(var_5_8.story_id, function()
				PlayerData:StoryModify(var_5_8.story_id)
				var_0_0.JumpToPage2(arg_5_0, arg_5_1)
			end)

			return
		end

		if arg_5_0[1] ~= 11001 and not ActivityTools.IsUnlockActivity(var_5_3) then
			local var_5_11 = ActivityCfg[var_5_3].unlock_condition

			if var_5_11[1] == 100 then
				ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityStoryChapterCfg[var_5_11[2][1]].name, BattleActivityStoryStageCfg[var_5_11[2][2]].name))

				return
			elseif var_5_11[1] == 101 then
				local var_5_12 = ChapterCfg[var_5_11[2][1]]
				local var_5_13 = ChapterClientCfg[var_5_12.clientID]

				if var_5_11[2][1] == 12113 then
					ShowTips(string.format(GetTips("NEED_FINISH_PRE_CHAPTER_STAGE"), GetTips(var_0_1.HARD_LANGUAGE[var_5_12.difficulty]), GetI18NText(var_5_13.desc), GetI18NText(var_5_13.name)))
				else
					ShowTips(string.format(GetTips("NEED_FINISH_PRE_STAGE"), GetTips(var_0_1.HARD_LANGUAGE[var_5_12.difficulty]), GetI18NText(var_5_13.desc)))
				end

				return
			end
		end

		if not var_5_6 then
			ShowTips("ERROR_ACTIVITY_NOT_EXIST")

			return
		end

		local var_5_14 = GameSetting.activity_main_plot_unlock_level.value[1]

		if arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.BATTLE_MAIN and var_5_14 > PlayerData:GetPlayerInfo().userLevel then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.activity_main_plot_unlock_level.value[1]))

			return
		end

		if ActivityCfg[var_5_3].activity_template == ActivityTemplateConst.ACTIVITY_WHACK_MOLE then
			local var_5_15 = var_5_0.params[2] or WhackMoleConst.SESSION_INDEX.FIRST

			if WhackMoleTools.GetSessionIsLock(var_5_3, var_5_15) then
				local var_5_16 = WhackMoleTools.GetSessionID(var_5_3, var_5_15)

				if var_5_16 ~= 0 then
					local var_5_17 = ActivitySummerChessConditionCfg[var_5_16].condition

					ShowTips(string.format(GetTips("OPEN_TIME"), ConditionCfg[var_5_17].desc))
				end

				return
			end
		end

		local var_5_18 = ActivityCfg[var_5_3].sub_activity_list[1]

		if var_5_18 ~= nil and ActivityCfg[var_5_18].activity_template == ActivityTemplateConst.ACTIVITY_MONSTER_COSPLAY then
			local var_5_19 = (ActivitySummerChessConditionCfg.get_id_list_by_activity_id[var_5_3] or {})[1]
			local var_5_20 = ActivitySummerChessConditionCfg[var_5_19].condition

			if IsConditionAchieved(var_5_20) == false then
				ShowTips(string.format(GetTips("OPEN_TIME"), ConditionCfg[var_5_20].desc))

				return
			end
		end

		if ActivityCfg[var_5_3].activity_template == ActivityTemplateConst.ACTIVITY_CATCH_DUCK then
			if not CatchDuckData:IsOpenActivity() then
				local var_5_21 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_CHESS_BOARD_DUCK][1]

				if var_5_21 ~= 0 then
					local var_5_22 = ActivitySummerChessConditionCfg[var_5_21].condition

					ShowTips(string.format(GetTips("OPEN_TIME"), ConditionCfg[var_5_22].desc))
				end

				return
			else
				JumpTools.GoToSystem("/catchDuckMain", {
					isFirst = arg_5_0[3] == 1
				})

				return
			end
		end

		if var_5_3 == ActivityConst.SUMMER_CHESS_BOARD_RHYTHM then
			local var_5_23 = var_5_0.params[2] or ActivityRhythmGameConst.Chapter_ID.ONE

			if var_5_23 == 1 then
				var_5_23 = ActivityRhythmGameConst.Chapter_ID.ONE
			elseif var_5_23 == 2 then
				var_5_23 = ActivityRhythmGameConst.Chapter_ID.TWO
			end

			if ActivityRhythmGameTools.GetSessionIsLockByID(var_5_23) then
				if var_5_23 ~= 0 then
					local var_5_24 = ActivitySummerChessConditionCfg[var_5_23].condition

					ShowTips(string.format(GetTips("OPEN_TIME"), ConditionCfg[var_5_24].desc))
				end

				return
			end
		end

		if var_5_3 == ActivityConst.SUMMER_CHESS_BOARD_BUBBLE then
			local var_5_25 = var_5_0.params[2] or 1

			if BlisterGameTool.GetSessionIsLock(var_5_3, var_5_25) then
				if var_5_25 ~= 0 then
					local var_5_26 = BlisterGameTool.GetSession(var_5_3, var_5_25)
					local var_5_27 = ActivitySummerChessConditionCfg[var_5_26] and ActivitySummerChessConditionCfg[var_5_26].condition or 0

					ShowTips(string.format(GetTips("OPEN_TIME"), ConditionCfg[var_5_27].desc))
				end

				return
			end
		end

		if var_5_3 == ActivityConst.SUMMER_CHESS_BOARD_PLUZZE then
			local var_5_28 = var_5_0.params[2] or TangramGameConst.chapterID.ONE

			if not TangramGameTools:CheckChapterIsOpen(var_5_28) then
				if var_5_28 ~= 0 then
					local var_5_29 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[var_5_3]
					local var_5_30

					if var_5_28 == TangramGameConst.chapterID.ONE then
						var_5_30 = var_5_29[1]
					else
						var_5_30 = var_5_29[2]
					end

					conditionID = ActivitySummerChessConditionCfg[var_5_30].condition

					ShowTips(string.format(GetTips("OPEN_TIME"), ConditionCfg[conditionID].desc))
				end

				return
			end
		end
	end

	if arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.BATTLE_MAIN or arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.BATTLE_ROLL_MAIN or arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.BATTLE_MAIN_CHAPTER_19 then
		local var_5_31 = arg_5_0[1]
		local var_5_32
		local var_5_33
		local var_5_34 = ChapterTools.GetChapterIDFromSystemLink(arg_5_0)
		local var_5_35 = ChapterCfg[var_5_34].section_id_list
		local var_5_36 = arg_5_0[3] or var_5_35[#var_5_35]
		local var_5_37, var_5_38 = getMaxOpenSection(var_5_36)
		local var_5_39 = ChapterCfg[var_5_38].unlock_activity_id

		if var_5_39 ~= 0 then
			local var_5_40 = ActivityData:GetActivityData(var_5_39)

			if manager.time:GetServerTime() < var_5_40.startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_5_40.startTime)))

				return
			end
		end

		if var_5_38 == 11112 then
			if ChapterTools.IsClearChapter(10112) == false then
				var_0_0.JumpToPage2({
					var_5_31,
					10112
				}, arg_5_1)

				return
			end

			if not SkuldTravelData:IsCollectAllPhoto() then
				ShowTips(GetTips("TRAVEL_SKULD_COLLECT_ALL_PHOTO"))

				return
			end
		elseif var_5_38 == 12112 and BattleStageData:GetStageData()[var_5_35[1]] == nil then
			var_0_0.JumpToPage2({
				var_5_31,
				11112
			}, arg_5_1)

			return
		end

		if var_5_38 == ChapterConst.CHAPTER_CLIENT_19 then
			ChapterTools.GotoChapterSection(var_5_38)

			return
		end

		local var_5_41 = arg_5_0[1]
		local var_5_42 = getChapterClientCfgByChapterID(var_5_38)

		if var_5_42.id == ChapterConst.CHAPTER_CLIENT_23 or var_5_42.id == ChapterConst.CHAPTER_CLIENT_24 or var_5_42.id == ChapterConst.CHAPTER_CLIENT_25 then
			ChapterTools.GotoChapterSection(var_5_38)

			return
		end

		if ChapterConst.ROLL_MAIN_CLINET[var_5_42.id] then
			var_5_41 = var_0_3.JUMP_SPECIAL_ID.BATTLE_ROLL_MAIN
		end

		var_0_0.OpenPageByJump(var_0_0.GetLinkAndParams({
			var_5_41,
			var_5_38,
			var_5_37
		}))

		return
	elseif arg_5_0[1] == var_0_3.SYSTEM_ID.BUY_FATIGUE and arg_5_0[2] == 2 then
		if var_0_0.GetLinkIsLocked(arg_5_0) then
			local var_5_43, var_5_44 = JumpTools.GetSystemLockedText(arg_5_0)

			ShowTips(var_5_44)

			return
		end

		if CurrencyData:GetFatigueBuyTimes() >= GameSetting.fatigue_max_buy_time.value[1] then
			ShowTips("ERROR_ITEM_DIAMOND_FATIGUE_TIMES_OVER_LIMIT")

			return
		end
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.MATRIX then
		var_0_0.GoToMatrix()

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.CLUB_TASK then
		var_0_0.GoToGuildTask()

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.BOSS_CHALLENGE then
		if var_0_0.GetLinkIsLocked(arg_5_0) then
			local var_5_45, var_5_46 = JumpTools.GetSystemLockedText(arg_5_0)

			ShowTips(var_5_46)

			return
		end

		BattleBossChallengeAction.EnterBossChallenge()

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.STRATEGY_MATRIX then
		StrategyMatrixAction.GotoStrategyMatrix(var_5_0.params[1])

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.THOR_MATRIX then
		StrategyMatrixAction.GotoStrategyMatrix(var_5_0.params[1])

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.POLYHEDRON then
		var_0_0.GoToPolyhedron()

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.BATTLE_EQUIP_BREAK_THROUGH_MATERIAL then
		if var_0_0.GetLinkIsLocked(arg_5_0) then
			local var_5_47, var_5_48 = JumpTools.GetSystemLockedText(arg_5_0)

			ShowTips(var_5_48)

			return
		end

		EquipBreakThroughMaterialAction.EnterEquipBTMaterial()

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.MYTHIC then
		if var_0_0.GetLinkIsLocked(arg_5_0) then
			local var_5_49, var_5_50 = JumpTools.GetSystemLockedText(arg_5_0)

			ShowTips(var_5_50)

			return
		else
			if MythicData:GetDifficulty() == MythicData:GetFinalId() then
				JumpTools.GoToSystem("/mythicUltimateView", nil, var_0_3.SYSTEM_ID.MYTHIC)
			else
				JumpTools.GoToSystem("/mythic", nil, var_0_3.SYSTEM_ID.MYTHIC)
			end

			return
		end
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.CANTEEN_MAP then
		local var_5_51 = JumpTools.IsSystemLocked(var_0_3.SYSTEM_ID.DORM)

		if var_5_51 then
			ShowTips(JumpTools.GetSystemLockedTip(var_0_3.SYSTEM_ID.DORM, var_5_51))

			return nil
		else
			BackHomeTools:GotoBackHomeRoom(DormConst.CANTEEN_ID)

			return
		end
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.DORM_MAP then
		local var_5_52 = JumpTools.IsSystemLocked(var_0_3.SYSTEM_ID.DORM)

		if var_5_52 then
			ShowTips(JumpTools.GetSystemLockedTip(var_0_3.SYSTEM_ID.DORM, var_5_52))

			return nil
		else
			BackHomeTools:GotoBackHomeRoom(DormConst.PUBLIC_DORM_ID)

			return
		end
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.BACKHOME_MAP then
		local var_5_53 = JumpTools.IsSystemLocked(var_0_3.SYSTEM_ID.DORM)

		if var_5_53 then
			ShowTips(JumpTools.GetSystemLockedTip(var_0_3.SYSTEM_ID.DORM, var_5_53))

			return nil
		else
			JumpTools.OpenPageByJump("/dormChooseRoomView")
			BackHomeDataManager:EnterBackHomeSystem()

			return
		end
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.IDOL_TRAINEE then
		local var_5_54 = JumpTools.IsSystemLocked(var_0_3.SYSTEM_ID.DORM)

		if var_5_54 then
			ShowTips(JumpTools.GetSystemLockedTip(var_0_3.SYSTEM_ID.DORM, var_5_54))

			return nil
		else
			BackHomeTools:GotoBackHomeRoom(nil, true)

			return
		end
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.HERO_TEACH then
		local var_5_55 = arg_5_0[2]

		if var_5_55 ~= nil then
			if HeroData:GetHeroData(var_5_55).unlock ~= 1 then
				ShowTips("ERROR_HERO_NOT_UNLOCK")

				return
			end

			local var_5_56 = HeroCfg[var_5_55]

			if var_5_56 and var_5_56.study_stage and var_5_56.study_stage[1] then
				JumpTools.OpenPageByJump("/teachStage", {
					switchType = var_0_1.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
					heroID = var_5_55
				})
				JumpTools.OpenPageByJump("teachSectionInfo", {
					sectionType = var_0_1.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
					section = var_5_56.study_stage[1]
				})
			end
		else
			JumpTools.OpenPageByJump("/teachStage", {
				switchType = var_0_1.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING
			})
		end

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.CLUB_FOUNDED then
		GuildAction.EnterGuild()

		return
	elseif var_5_0.system_id == var_0_3.SYSTEM_ID.BATTLE_SUB_PLOT then
		if var_0_0.GetLinkIsLocked(arg_5_0) then
			local var_5_57, var_5_58 = JumpTools.GetSystemLockedText(arg_5_0)

			ShowTips(var_5_58)

			return
		end

		var_0_0.GotoSubPlot(arg_5_0)

		return
	elseif arg_5_0[1] == var_0_3.SYSTEM_ID.SKIN_DRAW then
		ActivitySkinDrawTools.OnJumpToSkinDraw(var_5_3)

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.MOON_CAKE then
		local var_5_59 = tostring(arg_5_0[2])
		local var_5_60 = SystemLinkCfg[arg_5_0[1]].activity_id
		local var_5_61 = MoonCakeTools.GetMainActivityID(var_5_60)

		if var_5_59 == USER_ID then
			JumpTools.OpenPageByJump("/moonCakeParty", {
				activityID = var_5_60,
				mainActivityID = var_5_61,
				partyOwnerUID = USER_ID
			})
		else
			MoonCakeAction.VisitParty(var_5_60, var_5_59, MoonCakeConst.VISIT_WAY.SHARE)
		end

		return
	elseif arg_5_0[1] == var_0_3.SYSTEM_ID.SERVANT_SHOP then
		local var_5_62 = arg_5_0[2]
		local var_5_63 = SystemLinkCfg[arg_5_0[1]].params[1]
		local var_5_64 = ShopTools.GetGoodsIDListByItemID(var_5_63, var_5_62)
		local var_5_65 = {}
		local var_5_66 = {}
		local var_5_67 = ShopTools.FilterShopDataList(var_5_63)

		for iter_5_0, iter_5_1 in pairs(var_5_67) do
			if iter_5_1.id == var_5_64[1] then
				var_5_66 = iter_5_1
			end
		end

		if getShopCfg(var_5_64[1]) then
			local var_5_68 = getShopCfg(var_5_64[1])
		end

		if JumpTools.GetLinkIsLocked(arg_5_0) then
			local var_5_69, var_5_70 = JumpTools.GetSystemLockedText(arg_5_0)

			ShowTips(var_5_70)
		else
			JumpTools.OpenPageByJump("/shop", {
				shopId = var_5_63
			}, var_0_3.SYSTEM_ID.SHOP)

			local var_5_71 = getShopCfg(var_5_66.id, var_5_63)

			if ItemCfg[var_5_71.give_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
				if ShopTools.HaveSkin(var_5_71.give_id) then
					return
				end
			elseif var_5_71.limit_num then
				if var_5_71.limit_num ~= -1 and var_5_71.limit_num <= var_5_66.buyTime then
					return
				end

				local var_5_72, var_5_73 = ShopTools.JudgeIsLvLimit(var_5_71.level_limit)

				if var_5_72 then
					return
				end
			end

			JumpTools.OpenPopUp("shopBuy", {
				goodInfo = var_5_66
			})
		end

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.WEAPON_SERVANT_MERGE then
		local var_5_74 = arg_5_0[2]
		local var_5_75 = WeaponServantCfg[var_5_74].race
		local var_5_76 = {
			guideForce = true,
			openTab = "callName",
			race = var_5_75,
			servantID = var_5_74
		}

		manager.notify:Invoke(SERVANT_SWITCH_TO_CALLNAME, var_5_76)
		JumpTools.OpenPageByJump("/weaponServant", var_5_76)

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.SP_HERO_CHALLENGE_BARBECUE then
		SPHeroChallengeAction:OnEnterBarbuceScene()

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.SP_HERO_CHALLENGE_MAIN_VIEW or arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.SP_HERO_CHALLENGE_MAIN_VIEW_RESOURCE then
		if SystemLinkCfg[arg_5_0[1]] then
			local var_5_77 = SystemLinkCfg[arg_5_0[1]].activity_id

			SPHeroChallengeTools:EnterSystem(var_5_77)
		end

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.SUMMER_CHESSBOARD then
		local var_5_78 = arg_5_0[2]
		local var_5_79, var_5_80 = SummerChessBoardData:CallFun("CurrentUnlockStageID", var_5_78)

		if not var_5_79 then
			ShowTips(SummerChessBoardData:CallFun("GetUnlockTips", var_5_78))

			return
		end

		if gameContext:GetLastOpenPage() == "summerChessBoardTask" then
			var_0_0.Back()
		end

		JumpTools.GoToSystem("/summerChessBoardMainEntry")
		var_0_0.OpenPageByJump(var_0_0.GetLinkAndParams(arg_5_0))

		return
	elseif var_5_0.system_id >= var_0_3.SYSTEM_ID.HERO and var_5_0.system_id <= var_0_3.SYSTEM_ID.TRANSITION then
		if var_0_0.GetLinkIsLocked(arg_5_0) then
			local var_5_81, var_5_82 = JumpTools.GetSystemLockedText(arg_5_0)

			ShowTips(var_5_82)

			return
		end

		local var_5_83, var_5_84, var_5_85 = var_0_0.GetLinkAndParams(arg_5_0)

		var_5_84.isEnter = true

		var_0_0.OpenPageByJump(var_5_83, var_5_84, var_5_85)

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.GODEATER_SPECIAL_SERVANT then
		if ActivityTools.GetActivityIsOpenWithTip(ActivityConst.ACTIVITY_GODEATER_SERVANT) then
			JumpTools.OpenPageByJump("/draw", {
				poolType = 2,
				poolId = arg_5_0[2]
			}, var_0_3.SYSTEM_ID.DRAW)
		end

		return
	elseif var_5_0.system_id == var_0_3.SYSTEM_ID.PASSPORT_MAIN or var_5_0.system_id == var_0_3.SYSTEM_ID.PASSPORT_BUY then
		if not PassportData:IsOpen() then
			ShowTips("BATTLEPASS_EXPIRED")

			return
		end
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.SKULD_SELECT_LEVEL then
		JumpTools.OpenPageByJump("/skuldSystemStageView", {
			isFinal = false,
			startNext = false
		})

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.SKULD_SELECT_LEVEL_FINAL then
		local var_5_86 = false

		for iter_5_2, iter_5_3 in pairs(SkuldStageCfg.get_id_list_by_section[9]) do
			if SkuldSystemData:GetLevelIDIsOpen(iter_5_3) then
				var_5_86 = true

				break
			end
		end

		if var_5_86 then
			JumpTools.OpenPageByJump("/skuldSystemStageView", {
				isFinal = true,
				startNext = false
			})
		else
			ShowTips("SKULD_ENDING_LOCK")
		end

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.MUSIC_SELECT then
		JumpTools.OpenPageByJump("/residentMusicGameMainView", {
			activity_id = arg_5_0[2]
		})
		manager.notify:Invoke(MUSIC_JUMP_SELECT, arg_5_0[3])

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.OATH_RING_COUPON_FROM_ACTIVITY_DRAW then
		local var_5_87 = ActivityTools.GetAnyOpenActivityByTemplate(ActivityTemplateConst.ACTIVITY_OATH_DRAW_MAIN)

		if var_5_87 then
			JumpTools.OpenPageByJump("/activityOathDrawMainView", {
				activityID = var_5_87
			})
		end

		return
	elseif arg_5_0[1] == var_0_3.JUMP_SPECIAL_ID.OATH_RING_COUPON_FROM_SKIN_SHOP then
		local var_5_88 = OathTools.CheckAnySkinGiveBackOathRingCoupon()

		if var_5_88 then
			local var_5_89 = HeroTools.GetShopIdBySkinId(var_5_88)
			local var_5_90 = getShopCfg(var_5_89).shop_id

			JumpTools.OpenPageByJump("/heroSkin", {
				isDlc = false,
				heroID = SkinCfg[var_5_88].hero,
				skinID = var_5_88,
				shopID = var_5_90
			})
		end

		return
	elseif var_0_0.GetLinkIsLocked(arg_5_0) then
		local var_5_91, var_5_92 = JumpTools.GetSystemLockedText(arg_5_0)

		ShowTips(var_5_92)

		return
	end

	var_0_0.OpenPageByJump(var_0_0.GetLinkAndParams(arg_5_0))

	if arg_5_1 then
		arg_5_1()
	end
end

function var_0_0.GoToMatrix()
	local var_7_0 = MatrixData:GetGameState()

	if var_7_0 == MatrixConst.STATE_TYPE.SUCCESS or var_7_0 == MatrixConst.STATE_TYPE.FAIL then
		OpenPageUntilLoaded("/matrixBlank/matrixOver")
	else
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare", nil, var_0_3.SYSTEM_ID.MATRIX)
	end
end

function var_0_0.GoToPolyhedron()
	if not PolyhedronData:GetPolyhedronInfo() then
		ShowTips("TIME_OVER")

		return
	end

	local var_8_0 = PolyhedronData:GetActivityID()

	if not ActivityData:GetActivityIsOpen(var_8_0) then
		ShowTips("TIME_OVER")

		return
	end

	JumpTools.GoToSystem("/polyhedronBlank/polyhedronLobby", nil, var_0_3.SYSTEM_ID.MATRIX)
end

function var_0_0.GoToGuildTask()
	if JumpTools.IsSystemOperationStoped(var_0_3.SYSTEM_ID.GUILD) then
		ShowTips("ERROR_FUNCTION_STOP")

		return nil
	end

	local var_9_0 = JumpTools.IsSystemLocked(var_0_3.SYSTEM_ID.GUILD)

	if var_9_0 then
		ShowTips(JumpTools.GetSystemLockedTip(var_0_3.SYSTEM_ID.GUILD, var_9_0))

		return
	end

	if GuildData:GetGuildInfo().id == nil then
		GuildAction.EnterGuild()
	else
		JumpTools.OpenPageByJump("/communityTask")
	end
end

function var_0_0.Jump2SubPlot(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = ChapterClientCfg[arg_10_0]
	local var_10_1 = var_10_0.asset_pend_key

	if not manager.assetPend:CheckAssetPend(var_10_1) then
		manager.assetPend:ShowAssetPendMessageBox(var_10_1)

		return
	end

	local var_10_2 = BattleFieldData:GetCacheChapter(arg_10_0)

	if not table.keyof(var_10_0.chapter_list, var_10_2) then
		var_10_2 = var_10_0.chapter_list[1]

		BattleFieldData:SetCacheChapterClient(var_10_0.toggle, arg_10_0)
		BattleFieldData:SetCacheChapter(arg_10_0, var_10_2)
		BattleStageAction.ClickSubPlot(var_10_2)
	end

	local var_10_3 = ChapterTools.GetSubPlotUrl(var_10_2, arg_10_2)
	local var_10_4 = {
		chapterClientID = arg_10_0
	}

	if LuaExchangeHelper.GetSceneIsHanding() then
		gameContext:SetUrlAndParams(var_10_3, var_10_4)
	else
		CheckManagers()
		JumpTools.OpenPageByJump(var_10_3, var_10_4, nil, arg_10_1)
	end
end

function var_0_0.Jump2SubPlotByChapterID(arg_11_0, arg_11_1)
	if not ChapterTools.IsUnlockChapter(arg_11_0) then
		local var_11_0 = ChapterCfg[arg_11_0].activity_id
		local var_11_1 = ActivityData:GetActivityRefreshTime(var_11_0)

		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_11_1)))

		return
	end

	local var_11_2 = getChapterClientCfgByChapterID(arg_11_0)
	local var_11_3 = table.keyof(var_11_2.chapter_list, arg_11_0)

	if var_11_3 > 1 then
		local var_11_4 = var_11_2.chapter_list[var_11_3 - 1]

		if not ChapterTools.IsClearChapter(var_11_4) then
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), "", GetI18NText(ChapterCfg[var_11_4].subhead)))

			return
		end
	end

	BattleStageAction.ClickSubPlot(arg_11_0)

	if arg_11_1 then
		local var_11_5 = ChapterTools.GetSubPlotUrl(arg_11_0, isEntrace)
		local var_11_6 = {
			chapterClientID = var_11_2.id,
			chapterID = arg_11_0
		}

		JumpTools.OpenPageByJump(var_11_5, var_11_6)
	else
		manager.notify:Invoke(CHANGE_CHAPTER, arg_11_0)
	end
end

function var_0_0.GotoSubPlot(arg_12_0)
	local var_12_0 = SystemLinkCfg[arg_12_0[1]]
	local var_12_1 = arg_12_0[2]
	local var_12_2 = arg_12_0[3]
	local var_12_3 = ChapterCfg[var_12_1].clientID
	local var_12_4, var_12_5 = ChapterTools.GetSubPlotUrl(var_12_1, false)
	local var_12_6 = {
		chapterClientID = var_12_3
	}
	local var_12_7 = StageTools.IsLockSubChapterStage(var_12_1, var_12_2)

	if var_12_2 and BattleStageData:GetStageData()[var_12_2] and not var_12_5 and not var_12_7 then
		var_12_4 = var_12_4 .. "/subPlotSectionInfo"
		var_12_6 = {
			chapterClientID = var_12_3,
			section = var_12_2,
			chapterID = var_12_1,
			sectionType = var_0_1.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
		}

		if var_12_1 then
			BattleFieldData:SetCacheStage(var_12_1, var_12_2)
			BattleFieldData:SetCacheChapter(var_12_3, var_12_1)
			BattleStageAction.ClickSubPlot(var_12_1)
		end
	else
		local var_12_8, var_12_9 = ChapterTools.GetSubPlotMaxStageID(var_12_1)

		BattleFieldData:SetCacheStage(var_12_8, var_12_9)
		BattleFieldData:SetCacheChapter(var_12_3, var_12_8)
		BattleStageAction.ClickSubPlot(var_12_8)
	end

	CheckManagers()
	gameContext:Go(var_12_4, var_12_6)
end

function var_0_0.GetActivityTime(arg_13_0)
	local var_13_0 = ChapterResidentTools.GetResidentActMainID(arg_13_0)

	if var_13_0 then
		arg_13_0 = var_13_0
	end

	local var_13_1 = ActivityData:GetActivityData(arg_13_0)
	local var_13_2 = var_13_1.startTime
	local var_13_3 = var_13_1.stopTime
	local var_13_4 = var_13_1:GetStateBool()

	return var_13_2, var_13_3, var_13_4
end

function var_0_0.GetLinkAndParams(arg_14_0)
	local var_14_0 = SystemLinkCfg[arg_14_0[1]]
	local var_14_1 = {}

	if var_14_0.paramName and type(var_14_0.paramName) == "table" then
		local var_14_2 = 0
		local var_14_3 = #var_14_0.paramName

		if var_14_0.params and type(var_14_0.params) == "table" then
			var_14_2 = #var_14_0.params
		end

		local var_14_4 = 2

		for iter_14_0 = 1, var_14_3 do
			if iter_14_0 <= var_14_2 then
				var_14_1[var_14_0.paramName[iter_14_0]] = var_14_0.params[iter_14_0]
			else
				var_14_1[var_14_0.paramName[iter_14_0]] = arg_14_0[var_14_4]
				var_14_4 = var_14_4 + 1
			end
		end
	end

	for iter_14_1, iter_14_2 in pairs(arg_14_0) do
		if type(iter_14_1) == "string" then
			var_14_1[iter_14_1] = iter_14_2
		end
	end

	if arg_14_0[1] == var_0_3.JUMP_SPECIAL_ID.BATTLE_MAIN or arg_14_0[1] == var_0_3.JUMP_SPECIAL_ID.BATTLE_ROLL_MAIN then
		var_14_1.sectionType = var_0_1.STAGE_TYPE_NEW.STAGE_TYPE_PLOT
	end

	return var_14_0.link, var_14_1, var_14_0.system_id
end

function var_0_0.GetLinkIsLocked(arg_15_0)
	local var_15_0 = SystemLinkCfg[arg_15_0[1]]

	if JumpTools.IsSystemOperationStoped(var_15_0.system_id) then
		return true
	end

	if var_0_0.IsSystemLocked(var_15_0.system_id) then
		return true
	end

	local var_15_1 = BattleStageData:GetStageData()

	if var_15_0.id == var_0_3.JUMP_SPECIAL_ID.BATTLE_MAIN and not var_15_1[arg_15_0[2]] then
		return true
	end

	if var_15_0.id == var_0_3.JUMP_SPECIAL_ID.BATTLE_DAILY then
		local var_15_2 = arg_15_0[2]
		local var_15_3 = ChapterCfg[var_15_2].section_id_list[1]

		return PlayerData:GetPlayerInfo().userLevel < BattleDailyStageCfg[var_15_3].level
	end

	if var_15_0.id == var_0_3.JUMP_SPECIAL_ID.BATTLE_ASTROLABE and not BattleStageData:IsOpenChapter(arg_15_0[2]) then
		return true
	end

	if var_15_0.id == var_0_3.JUMP_SPECIAL_ID.BATTLE_EQUIP and not BattleStageData:IsOpenChapter(arg_15_0[2]) then
		return true
	end

	if var_15_0.id == var_0_3.JUMP_SPECIAL_ID.HERO_TRUST then
		local var_15_4 = arg_15_0[2]

		return not HeroTools.GetHeroIsUnlock(var_15_4)
	end

	local var_15_5 = var_0_0.GetSystemActivityID(arg_15_0)

	if var_15_5 and var_15_5 ~= 0 then
		local var_15_6, var_15_7, var_15_8 = var_0_0.GetActivityTime(var_15_5)

		if var_15_6 > manager.time:GetServerTime() then
			return true
		end

		if var_15_7 <= manager.time:GetServerTime() then
			return true
		end

		if arg_15_0[1] ~= 11001 and not ActivityTools.IsUnlockActivity(var_15_5) then
			return true
		end

		if not var_15_8 then
			return true
		end
	end

	if var_15_0.system_id == var_0_3.SYSTEM_ID.BATTLE_SUB_PLOT and not ChapterTools.IsUnlockSubPlotClient(arg_15_0[2]) then
		return true
	end

	if (var_15_0.system_id == var_0_3.SYSTEM_ID.PASSPORT_MAIN or var_15_0.system_id == var_0_3.SYSTEM_ID.PASSPORT_BUY) and not PassportData:IsOpen() then
		return true
	end

	return false
end

function var_0_0.GetSystemLockedText(arg_16_0)
	local var_16_0 = arg_16_0[1]
	local var_16_1 = SystemLinkCfg[var_16_0].system_id
	local var_16_2 = SystemCfg[var_16_1]

	if var_16_0 == var_0_3.JUMP_SPECIAL_ID.HERO_TRUST then
		local var_16_3 = arg_16_0[2]

		if not HeroTools.GetHeroIsUnlock(var_16_3) then
			return true, GetTips("ERROR_HERO_NOT_GET")
		end
	end

	if JumpTools.IsSystemOperationStoped(var_16_1) then
		return true, GetTips("ERROR_FUNCTION_STOP")
	end

	if var_16_2 and var_16_2.open_condition then
		for iter_16_0, iter_16_1 in ipairs(var_16_2.open_condition) do
			if iter_16_1[1] == var_0_3.SYSTEM_LOCK_TYPE.LOCK then
				return true, GetTips("SYSTEM_LOCK")
			elseif iter_16_1[1] == var_0_3.SYSTEM_LOCK_TYPE.LEVEL then
				if PlayerData:GetPlayerInfo().userLevel < iter_16_1[2] then
					return true, string.format(GetTips("PLAYER_LEVEL_UNLOCK"), iter_16_1[2])
				end
			elseif iter_16_1[1] == var_0_3.SYSTEM_LOCK_TYPE.BATTLE then
				local var_16_4 = BattleStageData:GetStageData()
				local var_16_5 = iter_16_1[2]
				local var_16_6 = var_16_4[var_16_5]
				local var_16_7 = iter_16_1[3] and var_16_4[iter_16_1[3]]

				if var_16_6 and var_16_6.clear_times > 0 or var_16_7 and var_16_7.clear_times > 0 then
					return false, ""
				elseif BattleChapterStageCfg[var_16_5] == nil then
					return true, "未知的关卡ID" .. var_16_5
				else
					local var_16_8 = getChapterDifficulty(var_16_5)
					local var_16_9 = getChapterClientCfgByStageID(var_16_5).toggle
					local var_16_10, var_16_11 = BattleStageTools.GetChapterSectionIndex(var_16_9, var_16_5)

					return true, string.format(GetTips("MISSION_PROGRESS_UNLOCK"), GetI18NText(var_16_8), GetI18NText(var_16_10), GetI18NText(var_16_11))
				end
			elseif iter_16_1[1] == var_0_3.SYSTEM_LOCK_TYPE.HERO_FAVORABILITY then
				local var_16_12 = iter_16_1[2]
				local var_16_13 = ArchiveData:GetArchive(var_16_12).lv
				local var_16_14 = HeroRecordCfg[iter_16_1[2]].name
				local var_16_15 = iter_16_1[3]

				if var_16_13 < iter_16_1[3] then
					return true, string.format(GetTips("HERO_FAVORABILITY_UNLOCK"), var_16_14, var_16_15)
				end
			elseif iter_16_1[1] == var_0_3.SYSTEM_LOCK_TYPE.ANY_HERO_FAVORABILITY then
				local var_16_16 = iter_16_1[2]

				return true, string.format(GetTips("ANY_FAVORABILITY_UNLOCK"), var_16_16)
			else
				print("未实现的系统解锁判断方式:", iter_16_1[1])
			end
		end
	end

	local var_16_17 = var_0_0.GetSystemActivityID(arg_16_0)

	if var_16_17 and var_16_17 ~= 0 then
		local var_16_18, var_16_19, var_16_20 = var_0_0.GetActivityTime(var_16_17)

		if var_16_18 > manager.time:GetServerTime() then
			local var_16_21 = GetTips("OPEN_TIME")

			return true, string.format(var_16_21, manager.time:GetLostTimeStr(var_16_18))
		end

		if var_16_19 <= manager.time:GetServerTime() then
			return true, GetTips("TIME_OVER")
		end

		if var_16_0 ~= 11001 and not ActivityTools.IsUnlockActivity(var_16_17) then
			local var_16_22 = ActivityCfg[var_16_17].unlock_condition

			if var_16_22[1] == 100 then
				return true, string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityStoryChapterCfg[var_16_22[2][1]].name, BattleActivityStoryStageCfg[var_16_22[2][2]].name)
			elseif var_16_22[1] == 101 then
				local var_16_23 = ChapterCfg[var_16_22[2][1]]
				local var_16_24 = ChapterClientCfg[var_16_23.clientID]

				return true, string.format(GetTips("NEED_FINISH_PRE_STAGE"), GetTips(var_0_1.HARD_LANGUAGE[var_16_23.difficulty]), GetI18NText(var_16_24.desc))
			elseif var_16_22[1] == 102 then
				return ChapterTools.IsClearStage(var_16_22[2][2]), string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ChapterCfg[var_16_22[2][1]].subhead, BattleActivityStoryStageCfg[var_16_22[2][2]].name)
			end
		end

		if not var_16_20 then
			return true, GetTips("TIME_OVER")
		end
	end

	if var_16_1 == var_0_3.SYSTEM_ID.BATTLE_SUB_PLOT then
		local var_16_25, var_16_26 = ChapterTools.IsUnlockSubPlotClient(arg_16_0[2])

		if not var_16_25 then
			return true, var_16_26
		end
	end

	if var_16_2 and not SystemData:GetSystemIsOpen(var_16_1) then
		return true, GetTips("SYSTEM_LOCK")
	end

	local var_16_27 = var_0_0.CustomLock(var_16_1)

	if var_16_27 then
		return true, GetTips(var_16_27[1])
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

function var_0_0.GetSystemParamActivityID(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0[1]
	local var_18_1 = SystemLinkCfg[var_18_0]
	local var_18_2 = var_18_1.activity_id

	if type(var_18_1.paramName) == "table" then
		local var_18_3 = table.keyof(var_18_1.paramName, arg_18_1)

		if var_18_3 then
			if type(var_18_1.params) == "table" and var_18_1.params[var_18_3] then
				var_18_2 = var_18_1.params[var_18_3]
			else
				var_18_2 = arg_18_0[var_18_3 + 1]
			end
		end
	end

	return var_18_2
end

function var_0_0.IsSystemOperationStoped(arg_19_0)
	if arg_19_0 == nil then
		return false
	end

	local var_19_0 = SystemCfg[arg_19_0]

	if not var_19_0 then
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
	local var_20_0 = SystemCfg[arg_20_0]

	if var_20_0 then
		if var_20_0.open_condition then
			for iter_20_0, iter_20_1 in ipairs(var_20_0.open_condition) do
				local var_20_1 = var_0_0.IsConditionLocked(iter_20_1)

				if var_20_1 then
					return var_20_1
				end
			end
		end

		if var_20_0.system_hide == 1 then
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

function var_0_0.IsConditionLocked(arg_21_0)
	if arg_21_0[1] == var_0_3.SYSTEM_LOCK_TYPE.LOCK then
		return arg_21_0
	elseif arg_21_0[1] == var_0_3.SYSTEM_LOCK_TYPE.LEVEL then
		if PlayerData:GetPlayerInfo().userLevel < arg_21_0[2] then
			return arg_21_0
		end
	elseif arg_21_0[1] == var_0_3.SYSTEM_LOCK_TYPE.BATTLE then
		local var_21_0 = BattleStageData:GetStageData()
		local var_21_1 = var_21_0[arg_21_0[2]]
		local var_21_2 = arg_21_0[3] and var_21_0[arg_21_0[3]]

		if var_21_1 and var_21_1.clear_times > 0 or var_21_2 and var_21_2.clear_times > 0 then
			return false
		else
			return arg_21_0
		end
	elseif arg_21_0[1] == var_0_3.SYSTEM_LOCK_TYPE.HERO_FAVORABILITY then
		local var_21_3 = arg_21_0[2]

		if ArchiveData:GetArchive(var_21_3).lv < arg_21_0[3] then
			return arg_21_0
		end
	elseif arg_21_0[1] == var_0_3.SYSTEM_LOCK_TYPE.ANY_HERO_FAVORABILITY then
		local var_21_4 = arg_21_0[2]
		local var_21_5 = HeroData:GetHeroList()
		local var_21_6 = false

		for iter_21_0, iter_21_1 in pairs(var_21_5) do
			if HeroTools.GetHeroIsUnlock(iter_21_0) then
				local var_21_7 = HeroRecordCfg.get_id_list_by_hero_id[iter_21_0][1]

				if var_21_4 <= ArchiveData:GetArchive(var_21_7).lv then
					var_21_6 = true

					break
				end
			end
		end

		if not var_21_6 then
			return arg_21_0
		end
	else
		print("未实现的系统解锁判断方式:", arg_21_0[1])
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
		if arg_24_1[1] == var_0_3.SYSTEM_LOCK_TYPE.LEVEL then
			return string.format(GetTips("PLAYER_LEVEL_UNLOCK"), arg_24_1[2])
		elseif arg_24_1[1] == var_0_3.SYSTEM_LOCK_TYPE.BATTLE then
			local var_24_0 = arg_24_1[2]
			local var_24_1 = getChapterDifficulty(var_24_0)
			local var_24_2 = getChapterClientCfgByStageID(var_24_0).toggle
			local var_24_3, var_24_4 = BattleStageTools.GetChapterSectionIndex(var_24_2, var_24_0)

			return string.format(GetTips("MISSION_PROGRESS_UNLOCK"), var_24_1, GetI18NText(var_24_3), GetI18NText(var_24_4))
		elseif arg_24_1[1] == var_0_3.SYSTEM_LOCK_TYPE.HERO_FAVORABILITY then
			local var_24_5 = HeroRecordCfg[arg_24_1[2]].name
			local var_24_6 = arg_24_1[3]

			return string.format(GetTips("HERO_FAVORABILITY_UNLOCK"), GetI18NText(var_24_5), var_24_6)
		elseif arg_24_1[1] == var_0_3.SYSTEM_LOCK_TYPE.ANY_HERO_FAVORABILITY then
			local var_24_7 = arg_24_1[2]

			return string.format(GetTips("ANY_FAVORABILITY_UNLOCK"), var_24_7)
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

	local var_27_0 = string.char(string.byte(arg_27_0)) == "/"
	local var_27_1

	if var_27_0 then
		local var_27_2 = string.split(string.sub(arg_27_0, 2, #arg_27_0), "/")
	else
		local var_27_3 = string.split(arg_27_0, "/")
	end

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
	local var_32_1 = #var_32_0
	local var_32_2 = false

	for iter_32_0 = var_32_1, 1, -1 do
		local var_32_3 = var_32_0[iter_32_0]
		local var_32_4 = var_0_3.NEED_GAUSSIAN_POPUP[var_32_3] or false

		if var_0_0.SetGaussionBg(var_32_3, var_32_4) then
			var_32_2 = true
		end
	end

	manager.ui:SetUISeparateRender(var_32_2)
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
		if var_0_3.NEED_GAUSSIAN_POPUP[iter_34_1] then
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

function var_0_0.NeedHide(arg_36_0, arg_36_1)
	local var_36_0 = SystemLinkCfg[arg_36_0[1]]

	if var_36_0.need_hide ~= 1 then
		return false
	end

	if var_0_0.IsActivityOpen(arg_36_0) == false then
		return true
	end

	if var_36_0.system_id == var_0_3.SYSTEM_ID.SHOP_ENTER then
		local var_36_1, var_36_2 = var_0_0.GetLinkAndParams(arg_36_0)
		local var_36_3 = var_36_2.shopId

		if var_36_3 then
			local var_36_4 = ShopTools.GetGoodsIDListByItemID(var_36_3, arg_36_1)

			if ShopTools.IsGoodCanExchange(var_36_3, var_36_4) == false then
				return true
			end
		end
	end

	return false
end

function var_0_0.CustomLock(arg_37_0)
	if arg_37_0 == var_0_3.SYSTEM_ID.BATTLE_ABYSS then
		if manager.time:GetServerTime() + 1 >= AbyssData:GetRefreshTimestamp() then
			return {
				"TIME_OVER"
			}
		end
	elseif arg_37_0 == var_0_3.SYSTEM_ID.MATRIX then
		local var_37_0 = PolyhedronData:GetActivityID()
		local var_37_1 = ActivityData:GetActivityData(var_37_0)

		if manager.time:GetServerTime() + 1 >= var_37_1.stopTime then
			return {
				"TIME_OVER"
			}
		end
	end

	return false
end

return var_0_0
