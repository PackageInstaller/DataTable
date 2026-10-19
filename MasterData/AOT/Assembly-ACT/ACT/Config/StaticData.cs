using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class StaticData
{
	public readonly Dictionary<int, ItemObtainJump> itemObtainJumps;

	public readonly Dictionary<int, EnvironmentEffect> EnvironmentEffects;

	public readonly Dictionary<int, ServerEffect> ServerEffects;

	public readonly Dictionary<int, EnvironmentElement> EnvironmentElements;

	public readonly Dictionary<int, ExchangeItem> ExchangeItems;

	public readonly Dictionary<int, GameStartLoading> gameStartLoadings;

	public readonly Dictionary<int, Skin> Skins;

	public readonly Dictionary<int, EffectDress> effectDresss;

	public readonly Dictionary<int, Main> Mains;

	public readonly Dictionary<int, MtyAvatar> MtyAvatars;

	public readonly Dictionary<int, Frame> Frames;

	public readonly Dictionary<int, Title> Titles;

	public readonly Dictionary<int, NameCard> NameCards;

	public readonly Dictionary<int, AbyssData> abyssDatas;

	public readonly Dictionary<int, SubabyssData> subabyssDatas;

	public readonly Dictionary<int, AbyssGroupData> abyssGroupDatas;

	public readonly Dictionary<int, JumpAbyss> jumpAbysss;

	public readonly Dictionary<int, StarRewardData> starRewardDatas;

	public readonly Dictionary<int, ConstantStarRewardData> constantStarRewardDatas;

	public readonly Dictionary<int, AchievementMain> achievementMains;

	public readonly Dictionary<int, AchievementGroup> achievementGroups;

	public readonly Dictionary<int, AchievementContents> achievementContentss;

	public readonly Dictionary<int, ActCharacterData> actCharacterDatas;

	public readonly Dictionary<int, ActivePointDailyMission> activePointDailyMissions;

	public readonly Dictionary<int, Navigation> navigations;

	public readonly Dictionary<int, ActivityData> activityDatas;

	public readonly Dictionary<int, ActivityChallengeGroup> activityChallengeGroups;

	public readonly Dictionary<int, ActivityChallengeData> activityChallengeDatas;

	public readonly Dictionary<int, ActivityNpc> activityNpcs;

	public readonly Dictionary<int, Lottery> lotterys;

	public readonly Dictionary<int, PuzzleGame> puzzleGames;

	public readonly Dictionary<int, AppStoreReviewPrompt> appStoreReviewPrompts;

	public readonly Dictionary<int, AppStoreReviewPromptChannel> appStoreReviewPromptChannels;

	public readonly Dictionary<int, ProcessMessage> processMessages;

	public readonly Dictionary<int, NodeMessage> nodeMessages;

	public readonly Dictionary<int, TeamAtackRutorial> teamAtackRutorials;

	public readonly Dictionary<int, ExtraList> extraLists;

	public readonly Dictionary<int, Nodelist> nodelists;

	public readonly Dictionary<int, Parameters> Parameterss;

	public readonly Dictionary<int, TeamParameters> teamParameterss;

	public readonly Dictionary<int, StateName> stateNames;

	public readonly Dictionary<int, GameWorldAudio> gameWorldAudios;

	public readonly Dictionary<int, MapAreaAudio> mapAreaAudios;

	public readonly Dictionary<int, SubMapAreaAudio> subMapAreaAudios;

	public readonly Dictionary<int, Avatar> avatars;

	public readonly Dictionary<int, Bag> bags;

	public readonly Dictionary<int, BagChest> bagChests;

	public readonly Dictionary<int, BaseModuleData> baseModuleDatas;

	public readonly Dictionary<int, BaseModuleLevelData> baseModuleLevelDatas;

	public readonly Dictionary<int, BaseAquariumData> baseAquariumDatas;

	public readonly Dictionary<int, BattlePass> battlePasss;

	public readonly Dictionary<int, LevelReward> levelRewards;

	public readonly Dictionary<int, Quest> quests;

	public readonly Dictionary<int, BattleRulesData> battleRulesDatas;

	public readonly Dictionary<int, Rules> ruless;

	public readonly Dictionary<int, BeaconType> beaconTypes;

	public readonly Dictionary<int, BeaconSentence> beaconSentences;

	public readonly Dictionary<int, BeaconWord> beaconWords;

	public readonly Dictionary<int, BeaconWordType> beaconWordTypes;

	public readonly Dictionary<int, BeaconEmoji> beaconEmojis;

	public readonly Dictionary<int, BookHorizontalData> bookHorizontalDatas;

	public readonly Dictionary<int, BookVerticalData> bookVerticalDatas;

	public readonly Dictionary<int, CardPool> cardPools;

	public readonly Dictionary<int, Challenge> challenges;

	public readonly Dictionary<int, BattleName> battleNames;

	public readonly Dictionary<int, CharacterBehavior> characterBehaviors;

	public readonly Dictionary<int, CharacterConstellationData> characterConstellationDatas;

	public readonly Dictionary<int, CharacterConstellationRgb> characterConstellationRgbs;

	public readonly Dictionary<int, Collection> collections;

	public readonly Dictionary<int, CollectionChip> collectionChips;

	public readonly Dictionary<int, ArraySet> arraySets;

	public readonly Dictionary<int, CollectionPoint> collectionPoints;

	public readonly Dictionary<int, CompendiumMain> compendiumMains;

	public readonly Dictionary<int, CompendiumSecond> compendiumSeconds;

	public readonly Dictionary<int, TextLibraryMain> textLibraryMains;

	public readonly Dictionary<int, TextLibrary> textLibrarys;

	public readonly Dictionary<int, TextLibraryContent> textLibraryContents;

	public readonly Dictionary<int, ItemCookData> itemCookDatas;

	public readonly Dictionary<int, CookSkillLevel> cookSkillLevels;

	public readonly Dictionary<int, ChefsDishTemplate> chefsDishTemplates;

	public readonly Dictionary<int, MenuSkill> menuSkills;

	public readonly Dictionary<int, CookPot> cookPots;

	public readonly Dictionary<int, CookMenu> cookMenus;

	public readonly Dictionary<int, CookSkillPr> cookSkillPrs;

	public readonly Dictionary<int, CookRandomName> cookRandomNames;

	public readonly Dictionary<int, CookChefsDish> cookChefsDishs;

	public readonly Dictionary<int, CookEffectSkill> cookEffectSkills;

	public readonly Dictionary<long, DialogueAVGData> dialogueAVGDatas;

	public readonly Dictionary<long, DialogueAsideData> dialogueAsideDatas;

	public readonly Dictionary<long, DialogueAsideGroupData> dialogueAsideGroupDatas;

	public readonly Dictionary<int, DialogueBGMData> dialogueBGMDatas;

	public readonly Dictionary<int, DialogueBackgroundData> dialogueBackgroundDatas;

	public readonly Dictionary<int, DialogueBubbleGroup> dialogueBubbleGroups;

	public readonly Dictionary<int, DialogueBubbleContent> dialogueBubbleContents;

	public readonly Dictionary<int, DialogueCG> dialogueCGs;

	public readonly Dictionary<int, DialogueCharacterData> dialogueCharacterDatas;

	public readonly Dictionary<int, DialogueEffectData> dialogueEffectDatas;

	public readonly Dictionary<int, DialogueEmojiData> dialogueEmojiDatas;

	public readonly Dictionary<int, DialogueEnvBGMData> dialogueEnvBGMDatas;

	public readonly Dictionary<int, DialogueImageData> dialogueImageDatas;

	public readonly Dictionary<long, DialogueMissionAVGData> dialogueMissionAVGDatas;

	public readonly Dictionary<long, DialogueNPCAVGData> dialogueNPCAVGDatas;

	public readonly Dictionary<int, DialogueSFXData> dialogueSFXDatas;

	public readonly Dictionary<long, DialogueStoryData> dialogueStoryDatas;

	public readonly Dictionary<int, DialogueStoryGroupData> dialogueStoryGroupDatas;

	public readonly Dictionary<int, DramaData> dramaDatas;

	public readonly Dictionary<int, DramaTimelineData> dramaTimelineDatas;

	public readonly Dictionary<int, DramaConversationData> dramaConversationDatas;

	public readonly Dictionary<int, DramaAsideData> dramaAsideDatas;

	public readonly Dictionary<int, DramaInteractData> dramaInteractDatas;

	public readonly Dictionary<int, DramaCharacterData> dramaCharacterDatas;

	public readonly Dictionary<int, DramaDialogData> dramaDialogDatas;

	public readonly Dictionary<int, ElementResonanceData> elementResonanceDatas;

	public readonly Dictionary<int, EliteTrainingMap> eliteTrainingMaps;

	public readonly Dictionary<int, EliteTrainingPoint> eliteTrainingPoints;

	public readonly Dictionary<int, EliteTrainingStage> eliteTrainingStages;

	public readonly Dictionary<int, EliteTrainingConfig> eliteTrainingConfigs;

	public readonly Dictionary<int, EliteTrainingHint> eliteTrainingHints;

	public readonly Dictionary<int, EnemyRespawnRule> enemyRespawnRules;

	public readonly Dictionary<int, EnemyDailyRespawnRule> enemyDailyRespawnRules;

	public readonly Dictionary<int, EnemySpawn> enemySpawns;

	public readonly Dictionary<int, EntityData> entityDatas;

	public readonly Dictionary<int, EntityNPCData> entityNPCDatas;

	public readonly Dictionary<int, EntityRobotData> entityRobotDatas;

	public readonly Dictionary<int, EntityNPCStateData> entityNPCStateDatas;

	public readonly Dictionary<int, EntityNeutralData> entityNeutralDatas;

	public readonly Dictionary<int, ElementConfig> elementConfigs;

	public readonly Dictionary<int, EntityCharacterData> entityCharacterDatas;

	public readonly Dictionary<int, EntityCharacterProbationMessage> entityCharacterProbationMessages;

	public readonly Dictionary<int, EntityCharacterTag> entityCharacterTags;

	public readonly Dictionary<int, EntityCharacterType> entityCharacterTypes;

	public readonly Dictionary<int, EntityCharacterLevelData> entityCharacterLevelDatas;

	public readonly Dictionary<int, EntityCharacterXPData> entityCharacterXPDatas;

	public readonly Dictionary<int, EntityCharacterProfession> entityCharacterProfessions;

	public readonly Dictionary<int, EntityCharacterProbation> entityCharacterProbations;

	public readonly Dictionary<int, CharacterProbationRaid> CharacterProbationRaids;

	public readonly Dictionary<int, EntityCharacterEquipProbation> entityCharacterEquipProbations;

	public readonly Dictionary<int, CharacterEquipProbation> characterEquipProbations;

	public readonly Dictionary<int, EntityEnemyData> entityEnemyDatas;

	public readonly Dictionary<int, EntityEnemyLevelRange> entityEnemyLevelRanges;

	public readonly Dictionary<int, EntityEnemyLevelDataTemplate> entityEnemyLevelDataTemplates;

	public readonly Dictionary<int, EntityEnemyLevelData> entityEnemyLevelDatas;

	public readonly Dictionary<int, TierHPLevelParm> tierHPLevelParms;

	public readonly Dictionary<int, EquipSuitData> equipSuitDatas;

	public readonly Dictionary<int, EquipData> equipDatas;

	public readonly Dictionary<int, EquipAttrData> equipAttrDatas;

	public readonly Dictionary<int, EquipAttrGroupData> equipAttrGroupDatas;

	public readonly Dictionary<int, EquipStrengthenListData> equipStrengthenListDatas;

	public readonly Dictionary<int, EquipMaterialData> equipMaterialDatas;

	public readonly Dictionary<int, EquipFeatureData> equipFeatureDatas;

	public readonly Dictionary<int, EquipFeatureLevelData> equipFeatureLevelDatas;

	public readonly Dictionary<int, EquipCreatMaterialData> equipCreatMaterialDatas;

	public readonly Dictionary<int, EquipGemData> equipGemDatas;

	public readonly Dictionary<int, UseSkill> useSkills;

	public readonly Dictionary<int, FavorabilityLevel> favorabilityLevels;

	public readonly Dictionary<int, FavorabilityStage> favorabilityStages;

	public readonly Dictionary<int, FoodProperty> foodPropertys;

	public readonly Dictionary<int, FoodRecipeData> foodRecipeDatas;

	public readonly Dictionary<int, Gacha> gachas;

	public readonly Dictionary<int, GachaPoolNotice> gachaPoolNotices;

	public readonly Dictionary<int, GachaPool> gachaPools;

	public readonly Dictionary<int, GachaItem> gachaItems;

	public readonly Dictionary<int, GachaDisplay> gachaDisplays;

	public readonly Dictionary<int, GachaDrawBonus> gachaDrawBonuss;

	public readonly Dictionary<int, CeInstructions> ceInstructionss;

	public readonly Dictionary<int, GameWorld> gameWorlds;

	public readonly Dictionary<int, GmCommandGroup> gmCommandGroups;

	public readonly Dictionary<int, GuideData> guideDatas;

	public readonly Dictionary<int, GuideTutorial> guideTutorials;

	public readonly Dictionary<int, GuideTutorialDes> guideTutorialDess;

	public readonly Dictionary<int, TutorialType> tutorialTypes;

	public readonly Dictionary<int, SoftHighLightSystem> softHighLightSystems;

	public readonly Dictionary<int, HandBook> handBooks;

	public readonly Dictionary<int, HandBookMain> handBookMains;

	public readonly Dictionary<int, HbContent> hbContents;

	public readonly Dictionary<int, DailyMission> dailyMissions;

	public readonly Dictionary<int, DailyMissionReward> dailyMissionRewards;

	public readonly Dictionary<int, MainGuid> mainGuids;

	public readonly Dictionary<int, WildBossMain> wildBossMains;

	public readonly Dictionary<int, WildBossUse> wildBossUses;

	public readonly Dictionary<int, InstanceDungeonMap> instanceDungeonMaps;

	public readonly Dictionary<int, InstanceDungeonType> instanceDungeonTypes;

	public readonly Dictionary<int, InstanceDungeon> instanceDungeons;

	public readonly Dictionary<int, InstanceDungeonSkill> instanceDungeonSkills;

	public readonly Dictionary<int, InstanceDungeonStarReward> instanceDungeonStarRewards;

	public readonly Dictionary<int, InteractEntryPriorityData> interactEntryPriorityDatas;

	public readonly Dictionary<int, ItemData> itemDatas;

	public readonly Dictionary<int, ItemType> itemTypes;

	public readonly Dictionary<int, ItemQuality> itemQualitys;

	public readonly Dictionary<int, ExpirableItem> expirableItems;

	public readonly Dictionary<int, ItemFishData> itemFishDatas;

	public readonly Dictionary<int, ItemFishBaitData> itemFishBaitDatas;

	public readonly Dictionary<int, ItemRecipeData> itemRecipeDatas;

	public readonly Dictionary<int, ItemAssistData> itemAssistDatas;

	public readonly Dictionary<int, ItemDyeingSkinData> itemDyeingSkinDatas;

	public readonly Dictionary<int, ItemDyeingColorData> itemDyeingColorDatas;

	public readonly Dictionary<int, ItemMaterialBoook> itemMaterialBoooks;

	public readonly Dictionary<int, ItemNavigation> ItemNavigations;

	public readonly Dictionary<int, ItemSmallData> itemSmallDatas;

	public readonly Dictionary<int, ItemChipData> itemChipDatas;

	public readonly Dictionary<int, ItemChipSuitData> itemChipSuitDatas;

	public readonly Dictionary<int, ItemChipUpdateData> itemChipUpdateDatas;

	public readonly Dictionary<int, ItemChipEntryData> itemChipEntryDatas;

	public readonly Dictionary<int, ItemChipMainPropertyData> itemChipMainPropertyDatas;

	public readonly Dictionary<int, ItemChipSubEntryPropertyData> itemChipSubEntryPropertyDatas;

	public readonly Dictionary<int, ItemCustomizeData> itemCustomizeDatas;

	public readonly Dictionary<int, ChipSelection> chipSelections;

	public readonly Dictionary<int, ItemChipLvUpData> itemChipLvUpDatas;

	public readonly Dictionary<int, ItemChipSiteData> itemChipSiteDatas;

	public readonly Dictionary<int, ItemChipQualityData> itemChipQualityDatas;

	public readonly Dictionary<int, ItemChipOtherPropertyData> itemChipOtherPropertyDatas;

	public readonly Dictionary<int, ItemTreasureData> itemTreasureDatas;

	public readonly Dictionary<int, ItemTreasureType> itemTreasureTypes;

	public readonly Dictionary<int, ItemWeaponData> itemWeaponDatas;

	public readonly Dictionary<int, ItemWeaponBreakthrough> itemWeaponBreakthroughs;

	public readonly Dictionary<int, ItemWeaponType> itemWeaponTypes;

	public readonly Dictionary<int, ItemWeaponProperty> itemWeaponPropertys;

	public readonly Dictionary<int, ItemWeaponUpgrade> itemWeaponUpgrades;

	public readonly Dictionary<int, JumpData> jumpDatas;

	public readonly Dictionary<int, TextLanguageData> textLanguageDatas;

	public readonly Dictionary<int, VoiceLanguageData> voiceLanguageDatas;

	public readonly Dictionary<int, AreaList> areaLists;

	public readonly Dictionary<int, PointList> pointLists;

	public readonly Dictionary<int, CharacterIdel> characterIdels;

	public readonly Dictionary<int, LoungeStory> loungeStorys;

	public readonly Dictionary<int, CharacterStoryList> characterStoryLists;

	public readonly Dictionary<int, CharacterGreet> characterGreets;

	public readonly Dictionary<int, CharacterText> characterTexts;

	public readonly Dictionary<int, Mail> mails;

	public readonly Dictionary<int, MallData> mallDatas;

	public readonly Dictionary<int, Recharge> recharges;

	public readonly Dictionary<int, MapIconData> mapIconDatas;

	public readonly Dictionary<int, SubIconData> subIconDatas;

	public readonly Dictionary<int, IconData> iconDatas;

	public readonly Dictionary<int, MapArea> mapAreas;

	public readonly Dictionary<int, SubMapArea> subMapAreas;

	public readonly Dictionary<int, TipsSubScence> tipsSubScences;

	public readonly Dictionary<int, TipsDetailMessageData> tipsDetailMessageDatas;

	public readonly Dictionary<int, ExploreType> exploreTypes;

	public readonly Dictionary<int, MapExploreAwardData> mapExploreAwardDatas;

	public readonly Dictionary<int, MessageCharacterData> messageCharacterDatas;

	public readonly Dictionary<int, MessageConversationGroup> messageConversationGroups;

	public readonly Dictionary<long, MessageConversation> messageConversations;

	public readonly Dictionary<int, MessageChoose> messageChooses;

	public readonly Dictionary<int, MissionData> missionDatas;

	public readonly Dictionary<int, MainmissionData> mainmissionDatas;

	public readonly Dictionary<int, SubmissionData> submissionDatas;

	public readonly Dictionary<int, SubmissionCondition> submissionConditions;

	public readonly Dictionary<int, DailyMissionData> dailyMissionDatas;

	public readonly Dictionary<int, RoleMissionData> roleMissionDatas;

	public readonly Dictionary<int, MissionRGroup> missionRGroups;

	public readonly Dictionary<int, MissionBase> missionBases;

	public readonly Dictionary<int, MissionDetail> missionDetails;

	public readonly Dictionary<int, MissionConditionActionEnum> missionConditionActionEnums;

	public readonly Dictionary<int, MissionCondition> missionConditions;

	public readonly Dictionary<int, MissionAction> missionActions;

	public readonly Dictionary<int, MissionFocusModeData> missionFocusModeDatas;

	public readonly Dictionary<int, Msgcode> msgcodes;

	public readonly Dictionary<int, MusicBox> musicBoxs;

	public readonly Dictionary<int, MusicCD> musicCDs;

	public readonly Dictionary<int, Name> names;

	public readonly Dictionary<int, Npc> npcs;

	public readonly Dictionary<int, NpcConfig> npcConfigs;

	public readonly Dictionary<int, PopUp> popUps;

	public readonly Dictionary<int, BubbleSystem> bubbleSystems;

	public readonly Dictionary<int, PotionData> potionDatas;

	public readonly Dictionary<int, PotionAdditives> potionAdditivess;

	public readonly Dictionary<int, PotionType> potionTypes;

	public readonly Dictionary<int, TrialPotion> trialPotions;

	public readonly Dictionary<int, PreconditionData> preconditionDatas;

	public readonly Dictionary<int, MissionGroup> missionGroups;

	public readonly Dictionary<int, Mission> missions;

	public readonly Dictionary<int, PresentDate> presentDates;

	public readonly Dictionary<int, PresentType> presentTypes;

	public readonly Dictionary<int, PresentFavorability> presentFavorabilitys;

	public readonly Dictionary<int, PropertyData> propertyDatas;

	public readonly Dictionary<int, PropertyTypeData> propertyTypeDatas;

	public readonly Dictionary<int, RaidTypeData> raidTypeDatas;

	public readonly Dictionary<int, RaidEntranceData> raidEntranceDatas;

	public readonly Dictionary<int, Raid> raids;

	public readonly Dictionary<int, RaidMissionTarget> raidMissionTargets;

	public readonly Dictionary<int, DoubleRaidPara> doubleRaidParas;

	public readonly Dictionary<int, RaidParkourData> raidParkourDatas;

	public readonly Dictionary<int, WorldBossMonster> worldBossMonsters;

	public readonly Dictionary<int, RewardTimes> rewardTimess;

	public readonly Dictionary<int, RaidTypeDes> raidTypeDess;

	public readonly Dictionary<int, Reward> rewards;

	public readonly Dictionary<int, RogueStage> rogueStages;

	public readonly Dictionary<int, RogueTableStageCard> rogueTableStageCards;

	public readonly Dictionary<int, RogueTableBuffCard> rogueTableBuffCards;

	public readonly Dictionary<int, RogueTableCardGroup> rogueTableCardGroups;

	public readonly Dictionary<int, RogueStep> rogueSteps;

	public readonly Dictionary<int, RogueRoom> rogueRooms;

	public readonly Dictionary<int, RogueCardLibrary> rogueCardLibrarys;

	public readonly Dictionary<int, RogueArtifactLibrary> rogueArtifactLibrarys;

	public readonly Dictionary<int, RogueEventLibrary> rogueEventLibrarys;

	public readonly Dictionary<int, RogueBlueprint> rogueBlueprints;

	public readonly Dictionary<int, RogueTriggerCard> rogueTriggerCards;

	public readonly Dictionary<int, RogueEffectCard> rogueEffectCards;

	public readonly Dictionary<int, RogueSuit> rogueSuits;

	public readonly Dictionary<int, RogueEvent> rogueEvents;

	public readonly Dictionary<int, RogueEventTextGroup> rogueEventTextGroups;

	public readonly Dictionary<int, RogueEventText> rogueEventTexts;

	public readonly Dictionary<int, RogueArtifact> rogueArtifacts;

	public readonly Dictionary<int, RogueShop> rogueShops;

	public readonly Dictionary<int, RogueMode> rogueModes;

	public readonly Dictionary<int, MapNodeConfig> mapNodeConfigs;

	public readonly Dictionary<int, GameWorldPool> gameWorldPools;

	public readonly Dictionary<int, MapNodeRewardPool> mapNodeRewardPools;

	public readonly Dictionary<int, RogueElement> rogueElements;

	public readonly Dictionary<int, RogueItem> rogueItems;

	public readonly Dictionary<int, RogueEnemy> rogueEnemys;

	public readonly Dictionary<int, RogueHealthPotion> rogueHealthPotions;

	public readonly Dictionary<int, RogueAssistCharacter> rogueAssistCharacters;

	public readonly Dictionary<int, Inscription> inscriptions;

	public readonly Dictionary<int, Synergy> synergys;

	public readonly Dictionary<int, CombatEffect> combatEffects;

	public readonly Dictionary<int, MetaEffect> metaEffects;

	public readonly Dictionary<int, TalentNode> talentNodes;

	public readonly Dictionary<int, TalentNodeLevelData> talentNodeLevelDatas;

	public readonly Dictionary<int, BdCore> bdCores;

	public readonly Dictionary<int, BdUnlockCondition> bdUnlockConditions;

	public readonly Dictionary<int, Season> seasons;

	public readonly Dictionary<int, RogueFeature> rogueFeatures;

	public readonly Dictionary<int, SceneData> sceneDatas;

	public readonly Dictionary<int, SceneMusicData> sceneMusicDatas;

	public readonly Dictionary<int, SceneAMBData> sceneAMBDatas;

	public readonly Dictionary<int, SensitiveWord> sensitiveWords;

	public readonly Dictionary<int, ShopData> shopDatas;

	public readonly Dictionary<int, SubshopData> subshopDatas;

	public readonly Dictionary<int, SaleList> saleLists;

	public readonly Dictionary<int, BattlepayPass> battlepayPasss;

	public readonly Dictionary<int, ExchangeShop> exchangeShops;

	public readonly Dictionary<int, Bundle> bundles;

	public readonly Dictionary<int, GemRecharge> gemRecharges;

	public readonly Dictionary<int, DoubleGem> doubleGems;

	public readonly Dictionary<int, MonthlyPass> monthlyPasss;

	public readonly Dictionary<int, SkinShop> skinShops;

	public readonly Dictionary<int, CommodityData> commodityDatas;

	public readonly Dictionary<int, SimulateTraining> simulateTrainings;

	public readonly Dictionary<int, TrainingContents> trainingContentss;

	public readonly Dictionary<int, SkillGroupData> skillGroupDatas;

	public readonly Dictionary<int, SkillGroupLevelData> skillGroupLevelDatas;

	public readonly Dictionary<int, SkillDetailData> skillDetailDatas;

	public readonly Dictionary<int, SkillDetailLevelData> skillDetailLevelDatas;

	public readonly Dictionary<int, SkillDetailMessageData> skillDetailMessageDatas;

	public readonly Dictionary<int, SpecialShow> specialShows;

	public readonly Dictionary<int, StateObjectType> stateObjectTypes;

	public readonly Dictionary<int, StateObjectGroup> stateObjectGroups;

	public readonly Dictionary<int, ExplorebranchMission> ExplorebranchMissions;

	public readonly Dictionary<int, SubAreaStateObject> subAreaStateObjects;

	public readonly Dictionary<int, AreaStateObject> areaStateObjects;

	public readonly Dictionary<int, ExplorationReward> explorationRewards;

	public readonly Dictionary<int, Trap> traps;

	public readonly Dictionary<int, TrapTypeData> trapTypeDatas;

	public readonly Dictionary<int, DefenceTower> defenceTowers;

	public readonly Dictionary<int, DefenceTowerTypeData> defenceTowerTypeDatas;

	public readonly Dictionary<int, SystemOpen> systemOpens;

	public readonly Dictionary<int, SystemRecordItem> systemRecordItems;

	public readonly Dictionary<int, Precondition> preconditions;

	public readonly Dictionary<int, PlayerWorldLevelDataNew> playerWorldLevelDataNews;

	public readonly Dictionary<int, PlayerLevelData> playerLevelDatas;

	public readonly Dictionary<int, PlayerWorldLevelData> playerWorldLevelDatas;

	public readonly Dictionary<int, EscSystem> escSystems;

	public readonly Dictionary<int, SystemGuideData> systemGuideDatas;

	public readonly Dictionary<int, ChapterIndex> chapterIndexs;

	public readonly Dictionary<int, TaskItemSubmit> taskItemSubmits;

	public readonly Dictionary<int, TemporaryActivityData> temporaryActivityDatas;

	public readonly Dictionary<int, TemporaryActivityGoalData> temporaryActivityGoalDatas;

	public readonly Dictionary<int, VideoData> videoDatas;

	public readonly Dictionary<int, ShortVideo> shortVideos;

	public readonly Dictionary<int, WorldMonsterPoint> worldMonsterPoints;

	public readonly Game game;

	public Dictionary<int, WildBossUse> wildBossUsesByMonsterID { get; private set; }

	public Dictionary<int, Dictionary<int, Dictionary<int, Msgcode>>> msgcodesByCodeTypeCodeModuleSubCode { get; private set; }

	public Dictionary<int, TrainingContents> trainingContentssByRaidID { get; private set; }

	public void PatchAutoIndexes()
	{
		if (wildBossUses != null)
		{
			wildBossUsesByMonsterID = new Dictionary<int, WildBossUse>();
			foreach (WildBossUse value3 in wildBossUses.Values)
			{
				if (value3 != null)
				{
					int monsterID = value3.monsterID;
					wildBossUsesByMonsterID[monsterID] = value3;
				}
			}
		}
		if (msgcodes != null)
		{
			msgcodesByCodeTypeCodeModuleSubCode = new Dictionary<int, Dictionary<int, Dictionary<int, Msgcode>>>();
			foreach (Msgcode value4 in msgcodes.Values)
			{
				if (value4 != null)
				{
					int codeType = value4.codeType;
					if (!msgcodesByCodeTypeCodeModuleSubCode.TryGetValue(codeType, out var value))
					{
						value = new Dictionary<int, Dictionary<int, Msgcode>>();
						msgcodesByCodeTypeCodeModuleSubCode[codeType] = value;
					}
					int codeModule = value4.codeModule;
					if (!value.TryGetValue(codeModule, out var value2))
					{
						value2 = (value[codeModule] = new Dictionary<int, Msgcode>());
					}
					int subCode = value4.subCode;
					value2[subCode] = value4;
				}
			}
		}
		if (trainingContentss == null)
		{
			return;
		}
		trainingContentssByRaidID = new Dictionary<int, TrainingContents>();
		foreach (TrainingContents value5 in trainingContentss.Values)
		{
			if (value5 != null)
			{
				int raidID = value5.raidID;
				trainingContentssByRaidID[raidID] = value5;
			}
		}
	}

	public WildBossUse GetWildBossUseByMonsterID(int monsterID)
	{
		if (wildBossUsesByMonsterID == null)
		{
			return null;
		}
		if (!wildBossUsesByMonsterID.TryGetValue(monsterID, out var value))
		{
			return null;
		}
		return value;
	}

	public Msgcode GetMsgcodeByCodeTypeCodeModuleSubCode(int codeType, int codeModule, int subCode)
	{
		if (msgcodesByCodeTypeCodeModuleSubCode == null)
		{
			return null;
		}
		if (!msgcodesByCodeTypeCodeModuleSubCode.TryGetValue(codeType, out var value))
		{
			return null;
		}
		if (!value.TryGetValue(codeModule, out var value2))
		{
			return null;
		}
		if (!value2.TryGetValue(subCode, out var value3))
		{
			return null;
		}
		return value3;
	}

	public TrainingContents GetTrainingContentsByRaidID(int raidID)
	{
		if (trainingContentssByRaidID == null)
		{
			return null;
		}
		if (!trainingContentssByRaidID.TryGetValue(raidID, out var value))
		{
			return null;
		}
		return value;
	}
}
