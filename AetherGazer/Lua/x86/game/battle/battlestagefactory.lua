return {
	Produce = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
		local var_1_0

		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_1_0 then
			var_1_0 = BattleChapterStageTemplate.New(arg_1_1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == arg_1_0 then
			var_1_0 = BattleSubPlotStageTemplate.New(arg_1_1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY == arg_1_0 then
			var_1_0 = BattleDailyStageTemplate.New(arg_1_1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == arg_1_0 then
			var_1_0 = BattleTowerStageTemplate.New(arg_1_1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT == arg_1_0 then
			var_1_0 = BattleEnchantmentStageTemplate.New(arg_1_1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == arg_1_0 then
			var_1_0 = BattleEquipStageTemplate.New(arg_1_1)
		elseif BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL == arg_1_0 then
			var_1_0 = BattleEquipBreakThroughMaterialStageTemplate.New(arg_1_1)
		elseif BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE == arg_1_0 then
			var_1_0 = BattleEquipSeizureStageTemplate.New(arg_1_1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == arg_1_0 then
			local var_1_1 = arg_1_2

			var_1_0 = BattleBossStageTemplate.New(arg_1_1, var_1_1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE == arg_1_0 then
			local var_1_2 = arg_1_2

			var_1_0 = BattleBossAdvanceStageTemplate.New(arg_1_1, var_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == arg_1_0 then
			var_1_0 = BattleMythicStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING == arg_1_0 then
			var_1_0 = BattleBaseTeachStageTemplate.New(arg_1_1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING == arg_1_0 then
			var_1_0 = BattleHeroTeachStageTemplate.New(arg_1_1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == arg_1_0 then
			var_1_0 = BattleMatrixStageTemplate.New(arg_1_1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS == arg_1_0 then
			var_1_0 = BattleChessStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY == arg_1_0 then
			var_1_0 = BattleOsirisStoryStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON == arg_1_0 then
			var_1_0 = BattleOsirisDemonStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.NEW_DEMON == arg_1_0 then
			var_1_0 = BattleNewDemonStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.RACE_TRIAL == arg_1_0 then
			var_1_0 = BattleRaceTrialStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.HERO_TRIAL == arg_1_0 then
			var_1_0 = BattleHeroTrialStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.RESIDENT_HERO_TRIAL == arg_1_0 then
			var_1_0 = BattleResidentHeroTrialStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL == arg_1_0 then
			var_1_0 = BattleSkinTrialStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.SLAYER == arg_1_0 then
			var_1_0 = BattleSlayerStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE == arg_1_0 then
			var_1_0 = BattleTowerDefenceStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.PARKOUR == arg_1_0 then
			var_1_0 = BattleParkourStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE == arg_1_0 then
			var_1_0 = BattleSoloChallengeStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ARTIFACT == arg_1_0 then
			var_1_0 = BattleArtifactStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION == arg_1_0 then
			var_1_0 = BattleLimitedCalculationStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.SKADI_GAME == arg_1_0 then
			var_1_0 = BattleSkadiLittleGameTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME == arg_1_0 then
			var_1_0 = BattleActivityPtGameTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE == arg_1_0 then
			var_1_0 = BattleGuildBossPrepareTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE == arg_1_0 then
			var_1_0 = BattleGuildBossChallengeTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE == arg_1_0 then
			var_1_0 = BattleActivityRaceStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == arg_1_0 then
			var_1_0 = BattleMythicFinalTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY == arg_1_0 then
			var_1_0 = BattleGuildActivityStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP == arg_1_0 then
			var_1_0 = BattleGuildActivitySPStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL == arg_1_0 then
			var_1_0 = BattleMardukSpecialTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE == arg_1_0 then
			var_1_0 = BattleSequentialBattleStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO == arg_1_0 then
			var_1_0 = BattleSurviveSoloStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS == arg_1_0 then
			var_1_0 = BattleActivityWorldBossTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT == arg_1_0 then
			var_1_0 = BattleAffixSelectTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST == arg_1_0 then
			var_1_0 = BattleDamageTestTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL == arg_1_0 then
			var_1_0 = BattleActivityPt2NormalTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE == arg_1_0 then
			var_1_0 = BattleActivityPt2ChallengeTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD == arg_1_0 then
			var_1_0 = BattleActivityPt2HardTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ABYSS == arg_1_0 then
			var_1_0 = BattleAbyssTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER == arg_1_0 then
			var_1_0 = BattleActivityWaterTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.SAIL_GAME == arg_1_0 then
			var_1_0 = BattleSailGameTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST == arg_1_0 then
			var_1_0 = BattleAdvanceTestStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON == arg_1_0 then
			var_1_0 = BattleSoloHeartDemonTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME == arg_1_0 then
			var_1_0 = BattleDestroyBoxGameTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME == arg_1_0 then
			var_1_0 = BattleActivityKagutsuchiTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL == arg_1_0 then
			var_1_0 = BattleActivityPtScrollTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS == arg_1_0 then
			var_1_0 = BattleNewWarChessStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA == arg_1_0 then
			var_1_0 = BattleActivityAttributeArenaTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE == arg_1_0 then
			var_1_0 = BattlePushSnowBallSingleStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL == arg_1_0 then
			var_1_0 = BattlePushSnowBallTeamSurvivalStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS == arg_1_0 then
			var_1_0 = BattlePushSnowBallTeamBossStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN == arg_1_0 then
			var_1_0 = BattleIndiaNianStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE == arg_1_0 then
			var_1_0 = BattleActivityPushBoxTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION == arg_1_0 then
			var_1_0 = BattleCoreVerificationTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1 == arg_1_0 then
			var_1_0 = BattleSPHeroChallengeTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE == arg_1_0 then
			var_1_0 = BattleActivityReforgeTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WHACK_MOLE == arg_1_0 then
			var_1_0 = BattleWhackMoleTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_SUMMER_WATER == arg_1_0 then
			var_1_0 = BattleActivityWaterGunnerTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE == arg_1_0 then
			var_1_0 = BattleSwimsuitTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME == arg_1_0 then
			var_1_0 = ActivityRhythmGameTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.CHESS_BOARD == arg_1_0 then
			var_1_0 = BattleChessBoardTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_CATCH_DUCK == arg_1_0 then
			var_1_0 = BattleCatchDuckTemplate.New(arg_1_1)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY == arg_1_0 then
			var_1_0 = BattleMonsterCosplayTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.MULT_HEART_DEMON == arg_1_0 then
			var_1_0 = BattleMultHeartDemonTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ADVANCE_MONSTER_TEST == arg_1_0 then
			var_1_0 = BattleAdvanceMonsterTestTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_SPKALI_CHALLENGE == arg_1_0 then
			var_1_0 = BattleKaliChallengeTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM == arg_1_0 then
			var_1_0 = BattleChallengeRogueTeamTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.AREA_BATTLE == arg_1_0 then
			var_1_0 = BattleAreaBattleTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_DODGE_BARRAGE == arg_1_0 then
			var_1_0 = BattleDodgeBarrageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.SEA_WARFARE == arg_1_0 then
			var_1_0 = BattleSeaWarfareStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.SKULD == arg_1_0 then
			var_1_0 = BattleSkuldTemplate.New(arg_1_1)
		elseif BattleConst.STAGE_TYPE_NEW.SAND_PLAY == arg_1_0 then
			var_1_0 = BattleSandPlayStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME == arg_1_0 then
			var_1_0 = BattleOsirisPlayGameStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.GOD_EATER_BATTLE == arg_1_0 then
			var_1_0 = BattleGodEaterTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.SUMMER_PUB == arg_1_0 then
			var_1_0 = BattleSummerPubTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE == arg_1_0 then
			var_1_0 = BattleCoreVerificationChallengeStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE2 == arg_1_0 then
			var_1_0 = BattleCoreVerificationChallengeStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE3 == arg_1_0 then
			var_1_0 = BattleCoreVerificationChallengeStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE4 == arg_1_0 then
			var_1_0 = BattleCoreVerificationChallengeStageTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.ASH_BATTLE == arg_1_0 then
			var_1_0 = BattleAshTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.HELLA_PINBALL_BATTLE == arg_1_0 then
			var_1_0 = BattleHellaPinBallTemplate.New(arg_1_1, arg_1_2)
		elseif BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE == arg_1_0 then
			var_1_0 = BattleHodurStageTemplate.New(arg_1_1, arg_1_2)
		end

		var_1_0:SetReserveParams(arg_1_3)
		var_1_0:Init()

		return var_1_0
	end,
	ProduceCooperation = function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0

		if BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO == arg_2_0 then
			var_2_0 = BattleCooperationDemoTemplate.New(arg_2_1)
		elseif BattleConst.STAGE_TYPE_NEW.STRONGHOLD == arg_2_0 then
			var_2_0 = BattleCooperationStrongholdTemplate.New(arg_2_1)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION == arg_2_0 then
			var_2_0 = BattleActivityWaterCooperationTemplate.New(arg_2_1, arg_2_2)
		end

		return var_2_0
	end
}
