local var_0_0 = {}

BattleSettlementStrategyBase = require("game/bridge/BattleSettlementStrategy/BattleSettlementStrategyBase")
var_0_0.StrategyPathPrefix = "game/bridge/BattleSettlementStrategy/Impl/"
StageStrategyType = {
	GotoAttributeArenaStage = "GotoAttributeArenaStage",
	GotoActivityRaceStage = "GotoActivityRaceStage",
	GotoActivityWaterStage = "GotoActivityWaterStage",
	GotoScoreStage = "GotoScoreStage",
	GotoSkuldStage = "GotoSkuldStage",
	GotoRaceTrialStage = "GotoRaceTrialStage",
	GotoSoloSurviveStage = "GotoSoloSurviveStage",
	GotoStage = "GotoStage",
	GotoEatGodStage = "GotoEatGodStage",
	GotoActivitySwimsuitStage = "GotoActivitySwimsuitStage",
	GotoSlayerStage = "GotoSlayerStage",
	GotoEquipSeizureScoreStage = "GotoEquipSeizureScoreStage",
	GotoActivityHeroEnhanceStage = "GotoActivityHeroEnhanceStage",
	GotoWhackMoleStage = "GotoWhackMoleStage",
	GotoGuildActivityStage = "GotoGuildActivityStage",
	GotoMythicFinalStage = "GotoMythicFinalStage",
	GotoCatchDuckStage = "GotoCatchDuckStage",
	GotoSPHeroChallengeStage = "GotoSPHeroChallengeStage",
	GotoCoreVerificationChallengeStage = "GotoCoreVerificationChallengeStage",
	GotoAreaBattleStage = "GotoAreaBattleStage",
	GotoActivitySummerWaterStage = "GotoActivitySummerWaterStage",
	GotoSkadiStage = "GotoSkadiStage",
	GotoChallengeRogueTeamStage = "GotoChallengeRogueTeamStage",
	GotoSpKaliStage = "GotoSpKaliStage",
	GotoMultHeartDemonStage = "GotoMultHeartDemonStage",
	GotoDodgeBarrageStage = "GotoDodgeBarrageStage",
	GotoAbyssStage = "GotoAbyssStage",
	GotoSummerPubStage = "GotoSummerPubStage",
	GotoSequentialBattleStage = "GotoSequentialBattleStage",
	GotoAshStage = "GotoAshStage",
	GotoActivityWorldBoss = "GotoActivityWorldBoss",
	GotoActivityRhythmGameStage = "GotoActivityRhythmGameStage",
	GotoOsirisPlayGameStage = "GotoOsirisPlayGameStage",
	GotoHellaPinballStage = "GotoHellaPinballStage",
	GotoActivityHodurStage = "GotoActivityHodurStage",
	GotoPushSnowBallSingleBattleStage = "GotoPushSnowBallSingleBattleStage",
	GotoSoloChallengeStage = "GotoSoloChallengeStage",
	GotoMardukSpecialStage = "GotoMardukSpecialStage",
	GotoMatrixStage = "GotoMatrixStage",
	GotoChapterStage = "GotoChapterStage",
	GotoScoreWithMaxScoreStage = "GotoScoreWithMaxScoreStage",
	GotoSeaWarfareStage = "GotoSeaWarfareStage",
	GotoPolyhedronStage = "GotoPolyhedronStage",
	GotoGuildBossStage = "GotoGuildBossStage",
	GotoBossChallengeStage = "GotoBossChallengeStage",
	GotoEquipBreakThroughStage = "GotoEquipBreakThroughStage",
	GotoCoreVerificationStage = "GotoCoreVerificationStage",
	GotoActivityMatrixStage = "GotoActivityMatrixStage",
	GotoActivityReforgeStage = "GotoActivityReforgeStage",
	GotoMultipleResultStage = "GotoMultipleResultStage",
	GotoSoloHeartDemonStage = "GotoSoloHeartDemonStage",
	GotoMonsterCosplayStage = "GotoMonsterCosplayStage",
	GotoKagutsuchiStage = "GotoKagutsuchiStage",
	GotoSandPlayStage = "GotoSandPlayStage"
}
var_0_0.CustomStageStrategy = {
	[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT] = StageStrategyType.GotoChapterStage,
	[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT] = StageStrategyType.GotoChapterStage,
	[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY] = StageStrategyType.GotoMultipleResultStage,
	[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP] = StageStrategyType.GotoMultipleResultStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME] = StageStrategyType.GotoMultipleResultStage,
	[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT] = StageStrategyType.GotoMultipleResultStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL] = StageStrategyType.GotoMultipleResultStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE] = StageStrategyType.GotoMultipleResultStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL] = StageStrategyType.GotoMultipleResultStage,
	[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE] = StageStrategyType.GotoBossChallengeStage,
	[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE] = StageStrategyType.GotoBossChallengeStage,
	[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX] = StageStrategyType.GotoMatrixStage,
	[BattleConst.STAGE_TYPE_NEW.RACE_TRIAL] = StageStrategyType.GotoRaceTrialStage,
	[BattleConst.STAGE_TYPE_NEW.SLAYER] = StageStrategyType.GotoSlayerStage,
	[BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE] = StageStrategyType.GotoSoloChallengeStage,
	[BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION] = StageStrategyType.GotoScoreStage,
	[BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT] = StageStrategyType.GotoScoreStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD] = StageStrategyType.GotoScoreStage,
	[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST] = StageStrategyType.GotoScoreStage,
	[BattleConst.STAGE_TYPE_NEW.ADVANCE_MONSTER_TEST] = StageStrategyType.GotoScoreStage,
	[BattleConst.STAGE_TYPE_NEW.SKADI_GAME] = StageStrategyType.GotoSkadiStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX] = StageStrategyType.GotoActivityMatrixStage,
	[BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX] = StageStrategyType.GotoActivityMatrixStage,
	[BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE] = StageStrategyType.GotoGuildBossStage,
	[BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE] = StageStrategyType.GotoGuildBossStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE] = StageStrategyType.GotoActivityRaceStage,
	[BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL] = StageStrategyType.GotoEquipBreakThroughStage,
	[BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE] = StageStrategyType.GotoEquipSeizureScoreStage,
	[BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL] = StageStrategyType.GotoMythicFinalStage,
	[BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY] = StageStrategyType.GotoGuildActivityStage,
	[BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP] = StageStrategyType.GotoGuildActivityStage,
	[BattleConst.STAGE_TYPE_NEW.ABYSS] = StageStrategyType.GotoAbyssStage,
	[BattleConst.STAGE_TYPE_NEW.POLYHEDRON] = StageStrategyType.GotoPolyhedronStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS] = StageStrategyType.GotoActivityWorldBoss,
	[BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO] = StageStrategyType.GotoSoloSurviveStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER] = StageStrategyType.GotoActivityWaterStage,
	[BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL] = StageStrategyType.GotoMardukSpecialStage,
	[BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON] = StageStrategyType.GotoSoloHeartDemonStage,
	[BattleConst.STAGE_TYPE_NEW.AREA_BATTLE] = StageStrategyType.GotoAreaBattleStage,
	[BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME] = StageStrategyType.GotoScoreWithMaxScoreStage,
	[BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE] = StageStrategyType.GotoSequentialBattleStage,
	[BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE] = StageStrategyType.GotoPushSnowBallSingleBattleStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME] = StageStrategyType.GotoKagutsuchiStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA] = StageStrategyType.GotoAttributeArenaStage,
	[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION] = StageStrategyType.GotoCoreVerificationStage,
	[BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1] = StageStrategyType.GotoSPHeroChallengeStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE] = StageStrategyType.GotoActivityReforgeStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE] = StageStrategyType.GotoActivityHeroEnhanceStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_WHACK_MOLE] = StageStrategyType.GotoWhackMoleStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE] = StageStrategyType.GotoActivitySwimsuitStage,
	[BattleConst.STAGE_TYPE_NEW.MULT_HEART_DEMON] = StageStrategyType.GotoMultHeartDemonStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME] = StageStrategyType.GotoActivityRhythmGameStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_SUMMER_WATER] = StageStrategyType.GotoActivitySummerWaterStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY] = StageStrategyType.GotoMonsterCosplayStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_CATCH_DUCK] = StageStrategyType.GotoCatchDuckStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_SPKALI_CHALLENGE] = StageStrategyType.GotoSpKaliStage,
	[BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM] = StageStrategyType.GotoChallengeRogueTeamStage,
	[BattleConst.STAGE_TYPE_NEW.ACTIVITY_DODGE_BARRAGE] = StageStrategyType.GotoDodgeBarrageStage,
	[BattleConst.STAGE_TYPE_NEW.SKULD] = StageStrategyType.GotoSkuldStage,
	[BattleConst.STAGE_TYPE_NEW.SEA_WARFARE] = StageStrategyType.GotoSeaWarfareStage,
	[BattleConst.STAGE_TYPE_NEW.SAND_PLAY] = StageStrategyType.GotoSandPlayStage,
	[BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME] = StageStrategyType.GotoOsirisPlayGameStage,
	[BattleConst.STAGE_TYPE_NEW.GOD_EATER_BATTLE] = StageStrategyType.GotoEatGodStage,
	[BattleConst.STAGE_TYPE_NEW.SUMMER_PUB] = StageStrategyType.GotoSummerPubStage,
	[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE] = StageStrategyType.GotoCoreVerificationChallengeStage,
	[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE2] = StageStrategyType.GotoCoreVerificationChallengeStage,
	[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE3] = StageStrategyType.GotoCoreVerificationChallengeStage,
	[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE4] = StageStrategyType.GotoCoreVerificationChallengeStage,
	[BattleConst.STAGE_TYPE_NEW.ASH_BATTLE] = StageStrategyType.GotoAshStage,
	[BattleConst.STAGE_TYPE_NEW.HELLA_PINBALL_BATTLE] = StageStrategyType.GotoHellaPinballStage,
	[BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE] = StageStrategyType.GotoActivityHodurStage
}

function var_0_0.Init(arg_1_0)
	arg_1_0.StrategyInstance = {}
	arg_1_0.snapShot = nil
end

function var_0_0.GetOrCreateGotoStageStartegy(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1 or StageStrategyType.GotoStage

	if not StageStrategyType[arg_2_1] then
		var_2_0 = StageStrategyType.GotoStage
	end

	if not arg_2_0.StrategyInstance[var_2_0] then
		arg_2_0.StrategyInstance[var_2_0] = require(arg_2_0.StrategyPathPrefix .. var_2_0)

		if arg_2_0.StrategyInstance[var_2_0].Init then
			arg_2_0.StrategyInstance[var_2_0]:Init()
		end
	end

	return arg_2_0.StrategyInstance[var_2_0]
end

function var_0_0.GotoResult(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = arg_3_1:GetType()
	local var_3_1 = StageStrategyType.GotoStage

	if var_3_0 then
		var_3_1 = arg_3_0.CustomStageStrategy[var_3_0] or StageStrategyType.GotoStage
	end

	arg_3_0:GetOrCreateGotoStageStartegy(var_3_1):GotoSettlement(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
end

function var_0_0.SnapShot(arg_4_0)
	if arg_4_0.snapShot then
		arg_4_0:ReleaseSnapShot()
	end

	if (SceneManager.sceneCount or 1) >= 2 and LuaForUtil.HasBattleWinPos() then
		arg_4_0.snapShot = UnityEngine.RenderTexture.New(math.floor(Screen.width / 1.5), math.floor(Screen.height / 1.5), 0, UnityEngine.RenderTextureFormat.ARGB32)

		local var_4_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

		if not isNil(var_4_0) then
			var_4_0:CaptureSnapshot(arg_4_0.snapShot)
		end
	end
end

function var_0_0.GetSnapShot(arg_5_0)
	return arg_5_0.snapShot
end

function var_0_0.ReleaseSnapShot(arg_6_0)
	arg_6_0.snapShot:Release()

	arg_6_0.snapShot = nil

	if manager.ui.mainCamera ~= nil and not isNil(manager.ui.mainCamera) then
		local var_6_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

		if not isNil(var_6_0) then
			var_6_0:FreeSnapshot()
		end
	end
end

return var_0_0
