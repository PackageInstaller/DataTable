local var_0_0 = {}

function var_0_0.GetStageName(arg_1_0, arg_1_1)
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == arg_1_0 then
		local var_1_0 = MatrixData:GetTierID()
		local var_1_1 = MatrixTierCfg[var_1_0]

		return ""
	end

	local var_1_2 = var_0_0.GetStageCfg(arg_1_0, arg_1_1)

	if var_1_2 then
		return GetI18NText(var_1_2.name) or ""
	else
		return ""
	end
end

function var_0_0.GetChapterByStageId(arg_2_0, arg_2_1)
	local var_2_0 = ChapterCfg.get_id_list_by_type[arg_2_0]

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		local var_2_1 = ChapterCfg[iter_2_1]

		if table.keyof(var_2_1.section_id_list, arg_2_1) then
			return iter_2_1
		end
	end

	return 0
end

function var_0_0.GetChapterSectionIndex(arg_3_0, arg_3_1)
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == arg_3_0 then
		local var_3_0 = BattleInstance.GetEquipStageShowIndex(arg_3_1)
		local var_3_1 = BattleInstance.GetHardLevel(arg_3_1)
		local var_3_2 = ChapterCfg.get_id_list_by_type[arg_3_0][1]

		return ChapterCfg[var_3_2].english, string.format("%d-%d", var_3_0, var_3_1)
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT == arg_3_0 then
		local var_3_3 = BattleInstance.GetEquipStageShowIndex(arg_3_1)
		local var_3_4 = ChapterCfg.get_id_list_by_type[arg_3_0][1]

		return ChapterCfg[var_3_4].english, var_3_3
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY == arg_3_0 then
		local var_3_5 = ChapterCfg.get_id_list_by_type[arg_3_0]

		for iter_3_0, iter_3_1 in pairs(var_3_5) do
			local var_3_6 = ChapterCfg[iter_3_1]
			local var_3_7 = table.keyof(var_3_6.section_id_list, arg_3_1)

			if var_3_7 then
				return var_3_6.english, var_3_7
			end
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_3_0 then
		local var_3_8 = BattleChapterStageCfg[arg_3_1]

		if var_3_8.stage_num ~= "" then
			local var_3_9 = var_3_8.stage_num
			local var_3_10 = string.split(var_3_9, "-")
			local var_3_11 = ""

			for iter_3_2 = 1, #var_3_10 - 1 do
				if iter_3_2 == 1 then
					var_3_11 = var_3_10[iter_3_2]
				else
					var_3_11 = var_3_11 .. "-" .. var_3_10[iter_3_2]
				end
			end

			return var_3_11, var_3_10[#var_3_10]
		end

		local var_3_12 = getChapterIDByStageID(arg_3_1)
		local var_3_13 = ChapterCfg[var_3_12]
		local var_3_14 = table.keyof(var_3_13.section_id_list, arg_3_1)

		return var_3_13.english, var_3_14
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == arg_3_0 then
		local var_3_15 = ChapterCfg.get_id_list_by_type[arg_3_0]

		for iter_3_3, iter_3_4 in pairs(var_3_15) do
			local var_3_16 = ChapterCfg[iter_3_4]
			local var_3_17 = table.keyof(var_3_16.section_id_list, arg_3_1)

			if var_3_17 then
				return var_3_16.english, var_3_17
			end
		end
	end

	return "", ""
end

function var_0_0.GetRestrictHeroList(arg_4_0, arg_4_1)
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == arg_4_0 or BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE == arg_4_0 then
		return nil
	end

	local var_4_0 = var_0_0.GetStageCfg(arg_4_0, arg_4_1)

	if var_4_0 then
		return var_4_0.hero_list, var_4_0.can_switch_restrict_hero_list
	end

	return nil
end

function var_0_0.GetStageCfg(arg_5_0, arg_5_1)
	local var_5_0

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_5_0 then
		var_5_0 = BattleChapterStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == arg_5_0 then
		var_5_0 = BattleActivityStoryStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY == arg_5_0 then
		var_5_0 = BattleDailyStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == arg_5_0 then
		var_5_0 = BattleTowerStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT == arg_5_0 then
		var_5_0 = BattleEnchantmentStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == arg_5_0 then
		var_5_0 = BattleEquipStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL == arg_5_0 then
		var_5_0 = BattleEquipBreakThroughMaterialStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE == arg_5_0 then
		var_5_0 = BattleEquipSeizureStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == arg_5_0 then
		var_5_0 = BattleBossStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE == arg_5_0 then
		var_5_0 = BattleBossStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == arg_5_0 then
		var_5_0 = BattleMythicStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING == arg_5_0 then
		var_5_0 = BattleBaseTeachStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING == arg_5_0 then
		var_5_0 = BattleHeroTeachStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == arg_5_0 then
		var_5_0 = BattleMatrixStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS == arg_5_0 then
		var_5_0 = BattleChessStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY == arg_5_0 then
		var_5_0 = BattleActivityStoryStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON == arg_5_0 then
		var_5_0 = BattleHeartDemonStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.NEW_DEMON == arg_5_0 then
		var_5_0 = BattleNewHeartDemonStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.RACE_TRIAL == arg_5_0 then
		var_5_0 = BattleRaceTrialStageCfg[ActivityRaceTrialCfg[arg_5_1].stage_id]
	elseif BattleConst.STAGE_TYPE_NEW.HERO_TRIAL == arg_5_0 then
		var_5_0 = BattleHeroTrialStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.RESIDENT_HERO_TRIAL == arg_5_0 then
		var_5_0 = BattleResidentHeroTrialStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL == arg_5_0 then
		var_5_0 = BattleSkinTrialStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.SLAYER == arg_5_0 then
		var_5_0 = BattleSlayerStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.PARKOUR == arg_5_0 then
		var_5_0 = BattleParkourStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE == arg_5_0 then
		var_5_0 = BattleShotStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE == arg_5_0 then
		var_5_0 = BattleSoloChallengeStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ARTIFACT == arg_5_0 then
		var_5_0 = BattleArtifactCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION == arg_5_0 then
		var_5_0 = BattleLimitedCalculationStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME == arg_5_0 then
		var_5_0 = BattleLeviathanGamesCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.SKADI_GAME == arg_5_0 then
		var_5_0 = BattleCrosswaveCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME == arg_5_0 then
		var_5_0 = BattleActivityPtStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == arg_5_0 then
		var_5_0 = BattleActivityMatrixCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE == arg_5_0 then
		var_5_0 = BattleClubBossPreposeCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE == arg_5_0 then
		var_5_0 = BattleClubBossCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE == arg_5_0 then
		var_5_0 = BattleActivityRaceStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == arg_5_0 then
		var_5_0 = BattleStrategyMatrixCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == arg_5_0 then
		var_5_0 = BattleMythicFinalCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY == arg_5_0 then
		var_5_0 = BattleClubActivityCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP == arg_5_0 then
		var_5_0 = BattleClubActivitySPCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO == arg_5_0 then
		var_5_0 = BattleCooperationDemoCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE == arg_5_0 then
		var_5_0 = BattleSequentialBattleStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.MARDUK_GAME == arg_5_0 then
		var_5_0 = BattleTowerGameCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO == arg_5_0 then
		var_5_0 = BattleSoloSlayerCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL == arg_5_0 then
		var_5_0 = BattleQuickTrainingCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS == arg_5_0 then
		var_5_0 = BattleActivityWorldBossCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT == arg_5_0 then
		var_5_0 = BattleActivityAffixSelectCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST == arg_5_0 then
		var_5_0 = BattleDamageTestCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL == arg_5_0 then
		var_5_0 = BattleActivityPtStageV2NormalCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE == arg_5_0 then
		var_5_0 = BattleActivityPtStageV2ChallengeCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD == arg_5_0 then
		var_5_0 = BattleActivityPtStageV2HardCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ABYSS == arg_5_0 then
		var_5_0 = BattleAbyssCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.POLYHEDRON == arg_5_0 then
		var_5_0 = BattlePolyhedronStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER == arg_5_0 then
		var_5_0 = BattleActivityWaterCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.SAIL_GAME == arg_5_0 then
		var_5_0 = BattleSailGameStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION == arg_5_0 then
		var_5_0 = BattleActivityWaterCooperationCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STRONGHOLD == arg_5_0 then
		var_5_0 = BattleStrongholdStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST == arg_5_0 then
		var_5_0 = BattleAdvanceTestStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON == arg_5_0 then
		var_5_0 = BattleSoloHeartDemonCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.AREA_BATTLE == arg_5_0 then
		var_5_0 = BattleAreaBattleCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME == arg_5_0 then
		var_5_0 = BattleDestroyBoxGameCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME == arg_5_0 then
		var_5_0 = BattleKagutsuchiStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL == arg_5_0 then
		var_5_0 = BattleActivityRouletteCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS == arg_5_0 then
		var_5_0 = BattleNewWarChessStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA == arg_5_0 then
		var_5_0 = BattleAttributeArenaCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN == arg_5_0 then
		var_5_0 = BattleIndiaNianCfg[arg_5_1]
		var_5_0.extra_cost = IndiaNianData:GetSelectedStageCost()
	elseif BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE == arg_5_0 then
		var_5_0 = BattleActivityCelebrationCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION == arg_5_0 then
		var_5_0 = BattleCoreVerificationCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1 == arg_5_0 then
		var_5_0 = BattleVerthandiExclusiveCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE == arg_5_0 then
		var_5_0 = BattleHeroEnhanceCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE == arg_5_0 then
		var_5_0 = BattleActivityReforgeCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_CATCH_DUCK == arg_5_0 then
		var_5_0 = BattleCatchDuckStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY == arg_5_0 then
		var_5_0 = BattleActivityMonsterCosplayCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME == arg_5_0 then
		var_5_0 = BattleRhythmGameStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WHACK_MOLE == arg_5_0 then
		var_5_0 = BattleWhackMoleStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_SUMMER_WATER == arg_5_0 then
		var_5_0 = BattleActivityWaterGunnerCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE == arg_5_0 then
		var_5_0 = BattleSwimsuitCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.CHESS_BOARD == arg_5_0 then
		var_5_0 = BattleChessBoardCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ADVANCE_MONSTER_TEST == arg_5_0 then
		var_5_0 = BattleActivityAdvanceMonsterTestCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_SPKALI_CHALLENGE == arg_5_0 then
		var_5_0 = BattleCoreKaliCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM == arg_5_0 then
		var_5_0 = BattleRogueTeamStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_DODGE_BARRAGE == arg_5_0 then
		var_5_0 = BattleDodgeBarrageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.SEA_WARFARE == arg_5_0 then
		var_5_0 = BattleSeaWarfareStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.SKULD == arg_5_0 then
		var_5_0 = BattleSkuldStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.SAND_PLAY == arg_5_0 then
		var_5_0 = BattleSandPlayStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME == arg_5_0 then
		var_5_0 = BattleOsirisGameStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.GOD_EATER_BATTLE == arg_5_0 then
		var_5_0 = BattleGodEaterDailyMonsterCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.SUMMER_PUB == arg_5_0 then
		var_5_0 = BattleSummerPubStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE == arg_5_0 then
		var_5_0 = BattleCoreVerificationClCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE2 == arg_5_0 then
		var_5_0 = BattleCoreVerificationCl2Cfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE3 == arg_5_0 then
		var_5_0 = BattleCoreVerificationCl3Cfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE4 == arg_5_0 then
		var_5_0 = BattleCoreVerificationCl4Cfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.ASH_BATTLE == arg_5_0 then
		var_5_0 = BattleAshShootStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.HELLA_PINBALL_BATTLE == arg_5_0 then
		var_5_0 = BattleHellaPinballStageCfg[arg_5_1]
	elseif BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE == arg_5_0 then
		var_5_0 = BattleHodurStageCfg[arg_5_1]
	end

	if var_5_0 == nil then
		print(string.format("配置表中没有关卡<color=#ff0000>%s</color>", arg_5_1))
	end

	return var_5_0 or {}
end

function var_0_0.IsHeroClearAnyTrialStage(arg_6_0)
	local var_6_0 = HeroCfg[arg_6_0]

	if var_6_0.study_stage and var_6_0.study_stage[1] and BattleTeachData:GetHeroTeachInfo(arg_6_0, var_6_0.study_stage[1]) > 0 then
		return true
	end

	if HeroTrialData:IsHeroTrialed(arg_6_0) then
		return true
	end

	return false
end

function var_0_0.CheckPopTrailStage(arg_7_0, arg_7_1, arg_7_2)
	if _G.SkipTip.SkipBattleHeroTrialPopTip then
		return false
	end

	local var_7_0 = BattleStageTools.GetStageCfg(arg_7_0, arg_7_1).jump_trial

	if not var_7_0 or var_7_0 == "" then
		return false
	end

	local var_7_1 = var_7_0[1]
	local var_7_2 = var_7_0[2]

	if var_7_2 and BattleStageData:GetStageClearTimes(var_7_2) > 0 or BattleStageTools.IsHeroClearAnyTrialStage(var_7_1) then
		return false
	end

	local var_7_3 = "battleQueryHeroTrailPop"
	local var_7_4 = {
		stageType = arg_7_0,
		stageID = arg_7_1,
		heroID = var_7_1,
		trailStageID = var_7_2,
		startCallback = arg_7_2,
		trailCallback = function()
			BattleStageTools.SectionStartTrail(arg_7_0, arg_7_1, var_7_1, var_7_2)
		end
	}

	if whereami == "battleResult" or whereami == "battle" then
		local var_7_5 = getChapterIDByStageID(arg_7_1)

		if arg_7_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT then
			gameContext:OverrideUrl("/chapterSectionRollBg/chapterSectionInfo", "/chapterSectionRollBg/chapterSectionInfo", {
				chapterID = var_7_5,
				section = arg_7_1,
				sectionType = arg_7_0
			}, "home")
			gameContext:OverrideUrl("/chapterSection/chapterSectionInfo", "/chapterSection/chapterSectionInfo", {
				chapterID = var_7_5,
				section = arg_7_1,
				sectionType = arg_7_0
			}, "home")
			BattleInstance.GotoBattleReadyPage(var_7_5, arg_7_1, arg_7_0, function()
				local var_9_0 = {
					section = arg_7_1,
					sectionType = arg_7_0
				}

				table.merge(var_9_0, var_7_4)
				gameContext:OverrideUrl("/sectionSelectHero", "/sectionSelectHero/" .. var_7_3, var_9_0, "home")
			end)
		elseif arg_7_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
			BattleInstance.GotoBattleReadyPage(var_7_5, arg_7_1, arg_7_0, function()
				local var_10_0 = {
					section = arg_7_1,
					sectionType = arg_7_0
				}

				table.merge(var_10_0, var_7_4)

				local var_10_1 = ChapterCfg[var_7_5].clientID
				local var_10_2 = ChapterTools.GetSubPlotUrl(var_7_5)

				OpenPageUntilLoaded(var_10_2 .. "/subPlotSectionInfo", {
					chapterClientID = var_10_1,
					section = arg_7_1,
					chapterID = var_7_5,
					sectionType = arg_7_0
				})
				OpenPageUntilLoaded("/sectionSelectHero/" .. var_7_3, var_10_0)
			end)
		end
	else
		gameContext:Go(var_7_3, var_7_4)
	end

	return true
end

function var_0_0.SectionStartTrail(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0, var_11_1 = gameContext:GetLastOpenPageHandler()

	if var_11_1 == "sectionSelectHero" then
		var_11_0:Back()
	end

	local var_11_2 = HeroCfg[arg_11_2]
	local var_11_3 = HeroTrialTools.GetLastOpenHeroTrial(arg_11_2)

	if var_11_3 ~= 0 and HeroTrialTools.GetActivityIsUnlock(var_11_3) then
		HeroTrialTools.EnterActivityBattle(var_11_3)
	else
		HeroTrialTools.EnterResidentBattle(var_11_2.trial_stage)
	end

	BattleStageTools.SetSectionTrailBattleWay(arg_11_0, arg_11_1)
end

function var_0_0.SetSectionTrailBattleWay(arg_12_0, arg_12_1)
	local var_12_0 = getChapterIDByStageID(arg_12_1)

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_12_0 then
		if ChapterCfg[var_12_0].clientID == ChapterConst.CHAPTER_CLIENT_19 then
			local var_12_1 = BattleFieldData:GetChapterLocationID(var_12_0)

			if ChapterTools.HasNewLocationMainStage(var_12_1) then
				HeroTrialData:SetBattleWay(nil, "/chapterPlot19Main", {
					chapterID = var_12_0,
					locationID = var_12_1
				})
			else
				HeroTrialData:SetBattleWay(nil, "/chapterPlot19Main", {})
			end

			return
		elseif ChapterCfg[var_12_0].clientID == ChapterConst.CHAPTER_CLIENT_23 then
			HeroTrialData:SetBattleWay(nil, "/chapterV2MapMain", {
				chapterClientID = ChapterConst.CHAPTER_CLIENT_23
			})

			return
		elseif ChapterCfg[var_12_0].clientID == ChapterConst.CHAPTER_CLIENT_24 then
			HeroTrialData:SetBattleWay(nil, "/chapterV2MapMain", {
				chapterClientID = ChapterConst.CHAPTER_CLIENT_24
			})

			return
		elseif ChapterCfg[var_12_0].clientID == ChapterConst.CHAPTER_CLIENT_25 then
			HeroTrialData:SetBattleWay(nil, "/chapterV2MapMain", {
				chapterClientID = ChapterConst.CHAPTER_CLIENT_25
			})

			return
		end

		local var_12_2 = getChapterClientCfgByChapterID(var_12_0)

		if ChapterConst.ROLL_MAIN_CLINET[var_12_2.id] then
			HeroTrialData:SetBattleWay(nil, "/chapterSectionRollBg/chapterSectionInfo", {
				chapterID = var_12_0,
				section = arg_12_1,
				sectionType = arg_12_0
			})
		else
			HeroTrialData:SetBattleWay(nil, "/chapterSection/chapterSectionInfo", {
				chapterID = var_12_0,
				section = arg_12_1,
				sectionType = arg_12_0
			})
		end
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == arg_12_0 then
		local var_12_3 = getChapterClientCfgByChapterID(var_12_0)
		local var_12_4 = var_12_3.id
		local var_12_5 = BattleFieldData:GetCacheChapter(var_12_4)

		if not table.keyof(var_12_3.chapter_list, var_12_5) then
			var_12_5 = var_12_3.chapter_list[1]

			BattleFieldData:SetCacheChapterClient(var_12_3.toggle, var_12_4)
			BattleFieldData:SetCacheChapter(var_12_4, var_12_5)
			BattleStageAction.ClickSubPlot(var_12_5)
		end

		local var_12_6 = ChapterTools.GetSubPlotUrl(var_12_5, isEntrace) .. "/subPlotSectionInfo"
		local var_12_7 = {
			chapterClientID = var_12_4,
			section = arg_12_1,
			chapterID = var_12_5,
			sectionType = arg_12_0
		}

		HeroTrialData:SetBattleWay(nil, var_12_6, var_12_7)
	else
		ShowTips("ERROR_BAD_ARG")
	end
end

function var_0_0.SkipSectionSelectHero(arg_13_0, arg_13_1)
	if arg_13_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT then
		local var_13_0 = BattleChapterStageCfg[arg_13_1].hero_list or {}

		if var_13_0 == "" then
			var_13_0 = {}
		end

		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			if iter_13_1[1] == 6147 then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetStageFixedChipInfo(arg_14_0, arg_14_1)
	if arg_14_1 and arg_14_1 ~= 0 then
		local var_14_0 = BattleStageTools.GetStageCfg(arg_14_0, arg_14_1)

		if var_14_0 and type(var_14_0.chip_list) == "table" then
			local var_14_1 = 0
			local var_14_2 = {}
			local var_14_3 = 0
			local var_14_4 = {}

			for iter_14_0, iter_14_1 in ipairs(var_14_0.chip_list) do
				local var_14_5 = ChipCfg[iter_14_1]

				if var_14_5 then
					if var_14_5.role_type_id == ChipConst.ROLE_TYPE_CHAR_CHIP_BASE then
						var_14_3 = iter_14_1
					elseif var_14_5.role_type_id == ChipConst.ROLE_TYPE_CHAR_CHIP_EXTRA then
						table.insert(var_14_4, iter_14_1)
					elseif var_14_5.type_id == ChipConst.TYPE_MANAGER then
						var_14_1 = iter_14_1
					elseif var_14_5.type_id == ChipConst.TYPE_CHIP then
						table.insert(var_14_2, iter_14_1)
					end
				end
			end

			return true, var_14_1, var_14_2, var_14_3, var_14_4
		end
	end

	return false
end

return var_0_0
