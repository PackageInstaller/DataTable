local var_0_0 = {
	HOME_SCENE_TYPE = {
		LOCK = 0,
		TRIAL = 1,
		UNLOCK = 2
	},
	HOME_SCENE_IMPACT = {
		WEATHER = 1,
		DATA = 2,
		TIME = 3
	},
	HOME_SCENE_TIME = {
		DAY = "X10",
		NIGHT = "X10a"
	},
	HOME_SCENE_WEATHER = {
		SUNNY = 1,
		RAINY = 2
	},
	HOME_SCENE_SETTING = {
		SCENE_SOUND_EFFECT = 1,
		CAMERA_FOLLOW = 2
	},
	SCENE_NAME = {
		reserve = "X104",
		hero = "X100"
	},
	NEED_CHANGE_SCENE_URL_LIST = {
		userinfo = true,
		furniturePreview = true,
		chat = true,
		furniturePreviewWithEntity = true,
		homePreview = true,
		home = true,
		clubBoss = true
	},
	RESERVE_VIEW_PAGE = {
		activityHeroEnhanceTeamInfo = true,
		mythicHeroTeamInfoView = true,
		heroTeamInfoBoss = true,
		sectionSelectHero = true,
		challengeRogueTeamHeroSelect = true,
		guildActivitySPTeamInfo = true,
		heroTeamInfoSoloChallenge = true,
		guildActivitySetFightHero = true,
		summerWaterSectionSelectHero = true,
		heroTeamInfoCoreVerification = true,
		guildActivitySPSetFightHero = true,
		guildBossSetAssistant = true,
		sequentialBattleSectionSelectHero = true,
		guildActivityTeamInfo = true,
		mythicSectionSelectHero = true,
		newHeroTeamInfo = true,
		advanceTestTeamInfo = true,
		challengeRogueTeamTeamInfo = true,
		guildBossTeamInfo = true,
		coreVerificationChallengeSectionSelectHeroView = true,
		osirisPlayGameHeroTeamInfoView = true,
		multHeartDemonHeroTeamInfo = true,
		osirisPlayGameSectionSelectHeroView = true,
		cooperationSectionSelectHero = true,
		swimsuitBattleTeamInfo = true,
		kagutsuchiTeamInfo = true,
		challengeRogueTeamSectionSelectHero = true,
		newWarChessHeroTeamInfoView = true,
		hodurChallengeSelectHeroBaseView = true,
		heroTeamInfoAttributeArena = true,
		heroTeamInfoChessView = true,
		summerWaterTeamInfo = true,
		xH3rdWaterTeamInfo = true
	}
}

for iter_0_0, iter_0_1 in pairs(var_0_0.RESERVE_VIEW_PAGE) do
	var_0_0.NEED_CHANGE_SCENE_URL_LIST[iter_0_0] = true
end

return var_0_0
