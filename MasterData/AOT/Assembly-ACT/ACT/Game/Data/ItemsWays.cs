using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum ItemsWays
{
	[OriginalName("ITEMSWAY_ENTERGAME")]
	ItemswayEntergame = 0,
	[OriginalName("ITEMSWAY_GET_TOPUP")]
	ItemswayGetTopup = 1,
	[OriginalName("ITEMSWAY_GET_MENGJING_EXCHANGE")]
	ItemswayGetMengjingExchange = 2,
	[OriginalName("ITEMSWAY_GET_MONTHLY_PASS")]
	ItemswayGetMonthlyPass = 3,
	[OriginalName("ITEMSWAY_GET_PASS")]
	ItemswayGetPass = 4,
	[OriginalName("ITEMSWAY_GET_WEAPON_MONTHLY_PASS")]
	ItemswayGetWeaponMonthlyPass = 5,
	[OriginalName("ITEMSWAY_GET_XINGHUI_EXCHANGE")]
	ItemswayGetXinghuiExchange = 6,
	[OriginalName("ITEMSWAY_GET_YUHUI_EXCHANGE")]
	ItemswayGetYuhuiExchange = 7,
	[OriginalName("ITEMSWAY_GET_SHOP_GIFT")]
	ItemswayGetShopGift = 8,
	[OriginalName("ITEMSWAY_GET_ABYSS_FIRST_COMPLETE")]
	ItemswayGetAbyssFirstComplete = 9,
	[OriginalName("ITEMSWAY_GET_ROGUE")]
	ItemswayGetRogue = 10,
	[OriginalName("ITEMSWAY_GET_DAILY_MISSION")]
	ItemswayGetDailyMission = 11,
	[OriginalName("ITEMSWAY_GET_ACTIVITY")]
	ItemswayGetActivity = 12,
	[OriginalName("ITEMSWAY_GET_MAIL")]
	ItemswayGetMail = 13,
	[OriginalName("ITEMSWAY_GET_MAIN_MISSION_GUID")]
	ItemswayGetMainMissionGuid = 14,
	[OriginalName("ITEMSWAY_GET_MISSION")]
	ItemswayGetMission = 15,
	[OriginalName("ITEMSWAY_GET_MONSTER_KILL")]
	ItemswayGetMonsterKill = 16,
	[OriginalName("ITEMSWAY_GET_TREASURE")]
	ItemswayGetTreasure = 17,
	[OriginalName("ITEMSWAY_GET_DAILY_RAID")]
	ItemswayGetDailyRaid = 18,
	[OriginalName("ITEMSWAY_GET_ACTIVITY_RAID")]
	ItemswayGetActivityRaid = 19,
	[OriginalName("ITEMSWAY_GET_BOSS_RAID")]
	ItemswayGetBossRaid = 20,
	[OriginalName("ITEMSWAY_GET_MISSION_RAID")]
	ItemswayGetMissionRaid = 21,
	[OriginalName("ITEMSWAY_GET_ONCE_RAID")]
	ItemswayGetOnceRaid = 22,
	[OriginalName("ITEMSWAY_GET_SHOP_EXCHANGE")]
	ItemswayGetShopExchange = 23,
	[OriginalName("ITEMSWAY_GET_ACHIEVEMENT")]
	ItemswayGetAchievement = 24,
	[OriginalName("ITEMWAYS_GET_CHARACTER_INIT_WEAPON")]
	ItemwaysGetCharacterInitWeapon = 25,
	[OriginalName("ITEMSWAY_GET_COLLECTION")]
	ItemswayGetCollection = 26,
	[OriginalName("ITEMSWAY_GET_DESTROY")]
	ItemswayGetDestroy = 27,
	[OriginalName("ITEMSWAY_GET_GM")]
	ItemswayGetGm = 28,
	[OriginalName("ITEMSWAY_GET_ABYSS_STARS")]
	ItemswayGetAbyssStars = 29,
	[OriginalName("ITEMWAYS_GET_OVER_PLAYER_EXP")]
	ItemwaysGetOverPlayerExp = 30,
	[OriginalName("ITEMWAYS_GET_GACHA")]
	ItemwaysGetGacha = 31,
	[OriginalName("ITEMWAYS_GET_ITEM_USE")]
	ItemwaysGetItemUse = 32,
	[OriginalName("ITEMWAYS_GET_ITEM_COMPOSE")]
	ItemwaysGetItemCompose = 33,
	[OriginalName("ITEMWAYS_GET_CHARACTER_STAGE_REWARD")]
	ItemwaysGetCharacterStageReward = 34,
	[OriginalName("ITEMWAYS_GET_PLAYER_LEVEL_REWARD")]
	ItemwaysGetPlayerLevelReward = 35,
	[OriginalName("ITEMWAYS_GET_POWER_BUY")]
	ItemwaysGetPowerBuy = 36,
	[OriginalName("ITEMWAYS_GET_RAID_FIRST_COMPLETE")]
	ItemwaysGetRaidFirstComplete = 37,
	[OriginalName("ITEMWAYS_GET_DAILY_PLAYER_ACTIVITY")]
	ItemwaysGetDailyPlayerActivity = 38,
	[OriginalName("ITEMWAYS_GET_GUIDE_REWARDS")]
	ItemwaysGetGuideRewards = 39,
	[OriginalName("ITEMWAYS_GET_ACTIVE_POINT_DAILY_REWARDS")]
	ItemwaysGetActivePointDailyRewards = 40,
	[OriginalName("ITEMWAYS_GET_ACTIVE_POINT_EXTRA_REWARDS")]
	ItemwaysGetActivePointExtraRewards = 41,
	[OriginalName("ITEMWAYS_GET_WORLD_BOSS_REWARDS")]
	ItemwaysGetWorldBossRewards = 42,
	[OriginalName("ITEMWAYS_GET_WORLD_TREASURE_REWARDS")]
	ItemwaysGetWorldTreasureRewards = 43,
	[OriginalName("ITEMWAYS_GET_CHIP_DECOMPOSE")]
	ItemwaysGetChipDecompose = 44,
	[OriginalName("ITEMWAYS_GET_REDEEM_CODE")]
	ItemwaysGetRedeemCode = 45,
	[OriginalName("ITEMWAYS_GET_EQUIP_CREATE")]
	ItemwaysGetEquipCreate = 46,
	[OriginalName("ITEMWAYS_GET_EQUIP_DISMANTLE")]
	ItemwaysGetEquipDismantle = 47,
	[OriginalName("ITEMWAYS_GET_GEM_FUSION")]
	ItemwaysGetGemFusion = 48,
	[OriginalName("ITEMWAYS_GET_TEMPLE_STAR_REWARD")]
	ItemwaysGetTempleStarReward = 49,
	[OriginalName("ITEMWAYS_GET_GACHA_ACCUMULATIVE_REWARD")]
	ItemwaysGetGachaAccumulativeReward = 50,
	[OriginalName("ITEMWAYS_GET_GACHA_CUSTOM_FINAL_GUARANTEED")]
	ItemwaysGetGachaCustomFinalGuaranteed = 51,
	[OriginalName("ITEMWAYS_GET_GACHA_ROLL_FINAL_GUARANTEED")]
	ItemwaysGetGachaRollFinalGuaranteed = 52,
	[OriginalName("ITEMWAYS_GET_POWER_CONSUME")]
	ItemwaysGetPowerConsume = 53,
	[OriginalName("ITEMWAYS_GET_POWER_NATURAL_RECOVER")]
	ItemwaysGetPowerNaturalRecover = 54,
	[OriginalName("ITEMWAYS_GET_RAID_SWEEP")]
	ItemwaysGetRaidSweep = 55,
	[OriginalName("ITEMWAYS_GET_ACTIVITY_LEVEL_REWARD")]
	ItemwaysGetActivityLevelReward = 56,
	[OriginalName("ITEMWAYS_GET_ACTIVITY_DOUBLE_DUNGEON")]
	ItemwaysGetActivityDoubleDungeon = 57,
	[OriginalName("ITEMWAYS_GET_ACTIVITY_SIGN_IN")]
	ItemwaysGetActivitySignIn = 58,
	[OriginalName("ITEMWAYS_GET_ACTIVITY_ABYSS")]
	ItemwaysGetActivityAbyss = 59,
	[OriginalName("ITEMWAYS_GET_ACTIVITY_COMBINATION")]
	ItemwaysGetActivityCombination = 60,
	[OriginalName("ITEMWAYS_GET_MESSAGE_REWARD")]
	ItemwaysGetMessageReward = 61,
	[OriginalName("ITEMWAYS_GET_GACHA_EXCHANGE_TICKET")]
	ItemwaysGetGachaExchangeTicket = 62,
	[OriginalName("ITEMWAYS_GET_CHARACTER_ELITE_RESET")]
	ItemwaysGetCharacterEliteReset = 63,
	[OriginalName("ITEMWAYS_GET_WORLD_LEVEL_BREAK_THROUGH")]
	ItemwaysGetWorldLevelBreakThrough = 64,
	[OriginalName("ITEMWAYS_GET_SYSTEM_GUIDE_CHAPTER_REWARD")]
	ItemwaysGetSystemGuideChapterReward = 65,
	[OriginalName("ITEMWAYS_GET_ACTIVITY_ROLE_TRIAL")]
	ItemwaysGetActivityRoleTrial = 66,
	[OriginalName("ITEMSWAY_GET_WEEKLY_RAID")]
	ItemswayGetWeeklyRaid = 67,
	[OriginalName("ITEMSWAY_GET_DIVINE_PUPIL_CLAIM_REWARD")]
	ItemswayGetDivinePupilClaimReward = 68,
	[OriginalName("ITEMWAYS_GET_ACTIVITY_DAILY_LOTTERY")]
	ItemwaysGetActivityDailyLottery = 69,
	[OriginalName("ITEMWAYS_GET_AREA_EXPLORE_REWARD")]
	ItemwaysGetAreaExploreReward = 70,
	[OriginalName("ITEMWAYS_GET_SUB_AREA_EXPLORE_REWARD")]
	ItemwaysGetSubAreaExploreReward = 71,
	[OriginalName("ITEMWAYS_GET_BATTLE_PASS_REWARD")]
	ItemwaysGetBattlePassReward = 72,
	[OriginalName("ITEMWAYS_GET_ITEM_RECYCLE")]
	ItemwaysGetItemRecycle = 73,
	[OriginalName("ITEMWAYS_GET_MAIN_GUIDE_MISSION_REWARD")]
	ItemwaysGetMainGuideMissionReward = 74,
	[OriginalName("ITEMWAYS_GET_MAIN_GUIDE_CHAPTER_REWARD")]
	ItemwaysGetMainGuideChapterReward = 75,
	[OriginalName("ITEMWAYS_GET_BAG_CHEST_REWARD")]
	ItemwaysGetBagChestReward = 76,
	[OriginalName("ITEMWAYS_GET_WILD_BOSS_REWARD")]
	ItemwaysGetWildBossReward = 77,
	[OriginalName("ITEMWAYS_GET_MONTHLY_PASS_BUY")]
	ItemwaysGetMonthlyPassBuy = 78,
	[OriginalName("ITEMWAYS_GET_GACHA_MILESTONE_REWARD")]
	ItemwaysGetGachaMilestoneReward = 79,
	[OriginalName("ITEMWAYS_GET_CHARACTER_CONSTELLATION_RESET")]
	ItemwaysGetCharacterConstellationReset = 80,
	[OriginalName("ITEMWAYS_GET_ACTIVITY_SKIN_TRIAL")]
	ItemwaysGetActivitySkinTrial = 81,
	[OriginalName("ITEMWAYS_GET_BLOOD_STAIN_REWARD")]
	ItemwaysGetBloodStainReward = 82,
	[OriginalName("ITEMWAYS_GET_ACTIVITY_TOTAL_RECHARGE")]
	ItemwaysGetActivityTotalRecharge = 83,
	[OriginalName("ITEMWAYS_GET_ACTIVITY_KUJI")]
	ItemwaysGetActivityKuji = 84,
	[OriginalName("ITEMWAYS_GET_ACTIVITY_MAIN_STORY")]
	ItemwaysGetActivityMainStory = 85,
	[OriginalName("ITEMWAYS_GET_STATE_OBJECT_UNLOCK_REWARD")]
	ItemwaysGetStateObjectUnlockReward = 86,
	[OriginalName("ITEMWAYS_GET_POWER_EXCHANGE")]
	ItemwaysGetPowerExchange = 87,
	[OriginalName("ITEMWAYS_GET_ACTIVITY_MAP_EXPLORE")]
	ItemwaysGetActivityMapExplore = 88,
	[OriginalName("ITEMWAYS_GET_ACTIVITY_MULTI_DEVICE")]
	ItemwaysGetActivityMultiDevice = 89,
	[OriginalName("ITEMWAYS_GET_EXCHANGE_DIAMOND")]
	ItemwaysGetExchangeDiamond = 90,
	[OriginalName("ITEMWAYS_GET_SKILLGROUP_LEVELUP")]
	ItemwaysGetSkillgroupLevelup = 91,
	[OriginalName("ITEMWAYS_COST_GM")]
	ItemwaysCostGm = 1051,
	[OriginalName("ITEMWAYS_COST_SHOP_EXCHANGE")]
	ItemwaysCostShopExchange = 1052,
	[OriginalName("ITEMWAYS_COST_MENGJING_EXCHANGE")]
	ItemwaysCostMengjingExchange = 1053,
	[OriginalName("ITEMWAYS_COST_QUICK_BUY")]
	ItemwaysCostQuickBuy = 1054,
	[OriginalName("ITEMWAYS_COST_POWER_BUY")]
	ItemwaysCostPowerBuy = 1055,
	[OriginalName("ITEMWAYS_COST_PASS_LEVEL_BUY")]
	ItemwaysCostPassLevelBuy = 1056,
	[OriginalName("ITEMWAYS_COST_CHARACTER_LEVEL_UP")]
	ItemwaysCostCharacterLevelUp = 1057,
	[OriginalName("ITEMWAYS_COST_CHARACTER_STAGE_UP")]
	ItemwaysCostCharacterStageUp = 1058,
	[OriginalName("ITEMWAYS_COST_CHARACTER_SKILL_UP")]
	ItemwaysCostCharacterSkillUp = 1059,
	[OriginalName("ITEMWAYS_COST_WEAPON_LEVEL_UP")]
	ItemwaysCostWeaponLevelUp = 1060,
	[OriginalName("ITEMWAYS_COST_WEAPON_STAGE_UP")]
	ItemwaysCostWeaponStageUp = 1061,
	[OriginalName("ITEMWAYS_COST_WEAPON_REFINE")]
	ItemwaysCostWeaponRefine = 1062,
	[OriginalName("ITEMWAYS_COST_CHIP_LEVEL_UP")]
	ItemwaysCostChipLevelUp = 1063,
	[OriginalName("ITEMWAYS_COST_ITEM_COMPOSE")]
	ItemwaysCostItemCompose = 1064,
	[OriginalName("ITEMWAYS_COST_ITEM_DELETE")]
	ItemwaysCostItemDelete = 1065,
	[OriginalName("ITEMWAYS_COST_ITEM_USE")]
	ItemwaysCostItemUse = 1066,
	[OriginalName("ITEMWAYS_COST_MISSION")]
	ItemwaysCostMission = 1067,
	[OriginalName("ITEMWAYS_COST_COOK")]
	ItemwaysCostCook = 1068,
	[OriginalName("ITEMWAYS_COST_CHARACTER_CONSTELLATION")]
	ItemwaysCostCharacterConstellation = 1069,
	[OriginalName("ITEMWAYS_COST_GACHA")]
	ItemwaysCostGacha = 1070,
	[OriginalName("ITEMWAYS_COST_RAID")]
	ItemwaysCostRaid = 1071,
	[OriginalName("ITEMWAYS_COST_ACTIVE_POINT_DAILY_EXCHANGE")]
	ItemwaysCostActivePointDailyExchange = 1072,
	[OriginalName("ITEMWAYS_COST_ACTIVE_POINT_EXTRA_EXCHANGE")]
	ItemwaysCostActivePointExtraExchange = 1073,
	[OriginalName("ITEMWAYS_COST_UNLOCK_CHARACTER_MISSION")]
	ItemwaysCostUnlockCharacterMission = 1074,
	[OriginalName("ITEMWAYS_COST_WORLD_BOSS_TAKE_REWARDS")]
	ItemwaysCostWorldBossTakeRewards = 1075,
	[OriginalName("ITEMWAYS_COST_WORLD_TREASURE_REWARDS")]
	ItemwaysCostWorldTreasureRewards = 1076,
	[OriginalName("ITEMWAYS_COST_CHIP_DECOMPOSE")]
	ItemwaysCostChipDecompose = 1077,
	[OriginalName("ITEMWAYS_COST_POTION_LEVEL_UP")]
	ItemwaysCostPotionLevelUp = 1078,
	[OriginalName("ITEMWAYS_COST_EQUIP_CREATE")]
	ItemwaysCostEquipCreate = 1079,
	[OriginalName("ITEMWAYS_COST_EQUIP_ENHANCE")]
	ItemwaysCostEquipEnhance = 1080,
	[OriginalName("ITEMWAYS_COST_EQUIP_DISMANTLE")]
	ItemwaysCostEquipDismantle = 1081,
	[OriginalName("ITEMWAYS_COST_GEM_FUSION")]
	ItemwaysCostGemFusion = 1082,
	[OriginalName("ITEMWAYS_COST_CONVERT_ELITE_POINT")]
	ItemwaysCostConvertElitePoint = 1083,
	[OriginalName("ITEMWAYS_COST_RAID_SWEEP")]
	ItemwaysCostRaidSweep = 1084,
	[OriginalName("ITEMWAYS_COST_GACHA_EXCHANGE_TICKET")]
	ItemwaysCostGachaExchangeTicket = 1085,
	[OriginalName("ITEMWAYS_COST_CHARACTER_ELITE_LEVEL_UP")]
	ItemwaysCostCharacterEliteLevelUp = 1086,
	[OriginalName("ITEMWAYS_COST_DIVINE_PUPIL_SUBMIT")]
	ItemwaysCostDivinePupilSubmit = 1087,
	[OriginalName("ITEMWAYS_COST_CHARACTER_GIFT")]
	ItemwaysCostCharacterGift = 1088,
	[OriginalName("ITEMWAYS_COST_BATTLE_PASS_BUY_LEVEL")]
	ItemwaysCostBattlePassBuyLevel = 1089,
	[OriginalName("ITEMWAYS_COST_ITEM_RECYCLE")]
	ItemwaysCostItemRecycle = 1090,
	[OriginalName("ITEMWAYS_COST_WILD_BOSS_TAKE_REWARDS")]
	ItemwaysCostWildBossTakeRewards = 1091,
	[OriginalName("ITEMWAYS_COST_WILD_BOSS_BUY_REWARDS_COUNT")]
	ItemwaysCostWildBossBuyRewardsCount = 1092,
	[OriginalName("ITEMSWAY_COST_ROGUE")]
	ItemswayCostRogue = 1093,
	[OriginalName("ITEMWAYS_COST_ACTIVITY_KUJI")]
	ItemwaysCostActivityKuji = 1094,
	[OriginalName("ITEMWAYS_COST_MIRROR_REPAIR")]
	ItemwaysCostMirrorRepair = 1095,
	[OriginalName("ITEMWAYS_COST_POWER_EXCHANGE")]
	ItemwaysCostPowerExchange = 1096,
	[OriginalName("ITEMWAYS_COST_EXCHANGE_DIAMOND")]
	ItemwaysCostExchangeDiamond = 1097,
	[OriginalName("ITEMWAYS_COST_MESSAGE_BOARD")]
	ItemwaysCostMessageBoard = 1098,
	[OriginalName("ITEMWAYS_OTHER")]
	ItemwaysOther = 9999
}
