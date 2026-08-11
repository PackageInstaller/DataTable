namespace Ase;

public static class Global
{
	public static readonly string[] BattleVerificationAssets = new string[4] { "DataTables", "DefaultPackage", "Paradoxs", "HotCode" };

	public static readonly string[] DataTableNames = new string[280]
	{
		"ExchangeRate", "AccountGrade", "Hero", "HeroSKillInfo", "HeroTalentBig", "HeroTalentSmall", "HeroSKillConfig", "HeroPassive", "ConstantConfig", "EnergyConfig",
		"HeroInfo", "HeroStar", "HeroStarRing", "HeroLabel", "HeroSeat", "HeroGrade", "UIHeroSkin", "Prop", "Entry", "EntryCoordinates",
		"Equipment", "EquipmentRank", "EquipmentFilterType", "EquipmentFilter", "SuitboxMainStore", "EntryStore", "AttributeStore", "Regular", "EquipGrade", "Weapon",
		"WeaponStar", "WeaponGrade", "Audio", "AudioAsset", "Voice", "Trust", "RandomName", "MapItemPreloadConfig", "WorldMap", "SectionMap",
		"Map", "TransferPoint", "CopyPoint", "Cavern", "CavernPoint", "MapExplore", "WeaponCasting", "EquipmentCasting", "HeroPropertyConvert", "ActivityTask",
		"ActivityType", "ActivityTaskReward", "ActivityRank", "ActivityRankTask", "ActivityRankProgress", "ActivitySign", "ActivityTry", "ActivityDisplay", "VersionActivity", "ActivityChallenge",
		"ChallengeCopy", "VersionLock", "VersionMoney", "ActivityPacks", "ActivityPacksInclude", "ActivityPacksChain", "PacksChainInclude", "ActivitySkinGet", "RandomMonsterAttr", "RandomMonster",
		"TowerTalent", "RandomBuff", "TowerBuffUp", "TeamSet", "PresetHeroData", "Question", "AttributeTotal", "Title", "HeadDecorate", "HeadAvatar",
		"ErrorCode", "ReportType", "ReportContent", "EmoticonType", "Emoticon", "CopyMain", "CopyType", "Copy", "CopyDrop", "EnvironmentModifier",
		"Recommend", "Permit", "PermitTask", "DropMaterial", "CopyStar", "StarConditionList", "RankReward", "Rank", "RankType", "RankUIType",
		"StarCondition", "DepthsStar", "ScoreReward", "CopyScore", "CopyKit", "DungeonTask", "ExchangeShop", "ExchangeShopList", "MainShopList", "PopupTip",
		"PopupTipQueue", "PopupIcon", "Level", "DropGroups", "GoodsGroup", "Pay", "SkinTheater", "BoardSpine", "BoardHero", "BoardHeroList",
		"BoardBackGround", "SystemOpen", "HeroFile", "ScreenSettings", "LoadingTips", "Affix", "DamageStatistic", "GuidanceLevel", "BattlePropMake", "BattlePropInfo",
		"BattlePropDrawing", "CultivateSkillLevel", "CultivateSkillEffect", "PropertyKeyName", "Bubble", "BubbleQueue", "BattleTimeline", "ParadoxTimeline", "ActivityScene", "CampaignBuff",
		"WarningIndicator", "Effect", "Monster", "MonsterAttr", "WorldLevel", "Paradox", "SkillTimeLine", "State", "AbnormalState", "WeaknessUIData",
		"WeaknessData", "DamageText", "Buff", "BuffStateConfig", "EntityHitConfig", "EntityCollision", "Bullet", "MonsterAttack", "MonsterPreloadConfig", "NPC",
		"SummonedEntityConfig", "MapItem", "MapItemType", "Task", "DailyTask", "MonsterTask", "BattleEntityConfig", "HitBox", "MonsterInfo", "Guidance",
		"GuidanceStep", "MonsterDrops", "CollectionDrops", "DropPerformance", "LevelNPC", "Story", "DialogButton", "DialogChain", "DialogPrologue", "AttributeMatching",
		"MapMechanism", "BattleVoice", "AchievementType", "AchievementRewards", "AchievementMedal", "IndicatorType", "Suitbox", "SuitboxDecompose", "SuitboxCoin", "PassportReward",
		"PassportTask", "PassportShow", "WeaponShow", "Teaching", "TeachingBook", "HeroTeachingConfig", "LevelTeachingConfig", "HeroTeachingInfo", "TeachingTask", "TimeTask",
		"TeachingFrame", "GameExplain", "Packs", "PacksInclude", "TimeLimit", "GameScore", "GeneralHit", "HeroSkin", "SkinAssociation", "Material",
		"DrawCardInfo", "RareUp", "Choose", "CardByProduct", "DrawCardDrop", "HomeLandShopGoodsGroup", "BuildingInfo", "HomeLandLevelInfo", "HomeLandLevelEffect", "BuildingLevelInfo",
		"FarmLevel", "FarmSeed", "SailEventQualityRate", "SailEvent", "SailLightLevel", "GuildLev", "GuildJobInfo", "GuildActiveReward", "GuildActiveTask", "GuildConfig",
		"GuildBuff", "GuildEvent", "GuildFunction", "GuildCopy", "GameGuideView", "CollectionNote", "TimeLineNote", "BranchTimeLineNote", "VersionTimeLineNote", "CGNote",
		"MonsterNote", "MonsterSkillNote", "MapNote", "SceneryNote", "NPCNote", "HeroNote", "HeroTag", "HeroDetails", "HeroStory", "HeroTreasure",
		"HeroCG", "Decompose", "WholeApart", "Manual", "HeroGuide", "ActiveTask", "ActiveReward", "Money", "Banner", "BankGroup",
		"MonthlyCard", "Rate", "HeroCardFrame", "ChatBox", "BattleEmote", "BattleEmoteGroup", "IndicatorRing", "EquipmentPacks", "LibraryTower", "LibTask",
		"LibraryReward", "HeroSkillSkin", "SkillSkinList", "HeroSkinTimeLine", "SkinMessage", "Campaign", "CampaignClass", "CampaignLevel", "CampaignBuilding", "CampaignTimelimit"
	};

	public const double TOLERANCE = 0.0010000000474974513;

	public const float INITINTERVALTIMER = 0.033f;
}
