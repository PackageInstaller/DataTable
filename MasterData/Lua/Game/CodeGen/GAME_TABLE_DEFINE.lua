local GameTableDefine = {}
GameTableDefine.CommonTable = {
  Achievement = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  AcquireReward = {Key = true},
  Activity = {Key = true},
  ActivityAvgLevel = {
    Key = true,
    Lang = {
      "Index",
      "Name",
      "Desc"
    }
  },
  ActivityDouble = {
    Key = true,
    Lang = {"DesText"}
  },
  ActivityDoubleQuest = {
    Key = true,
    Lang = {"Desc"}
  },
  ActivityEntrance = {Key = true},
  ActivityGoods = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  ActivityGroup = {
    Key = true,
    Lang = {"DesText"}
  },
  ActivityIceCreamLevel = {
    Key = true,
    Lang = {
      "IslandName",
      "Name",
      "Des",
      "PassScoreDes",
      "OrderNumDes"
    }
  },
  ActivityLevelsFloor = {Key = true},
  ActivityLevelsLevel = {
    Key = true,
    Lang = {
      "Name",
      "OneStarDesc",
      "TwoStarDesc",
      "ThreeStarDesc",
      "Desc"
    }
  },
  ActivityMailBindControl = {
    Key = true,
    Lang = {"Desc"}
  },
  ActivityPenguinCardLevel = {
    Key = true,
    Lang = {"Name"}
  },
  ActivityPenguinCardQuest = {
    Key = true,
    Lang = {"Desc"}
  },
  ActivityPenguinCardQuestGroup = {
    Key = true,
    Lang = {"GroupName"}
  },
  ActivityReturnee = {Key = true},
  ActivityReturneeCard = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  ActivityReturneeLoginRewardControl = {
    Key = true,
    Lang = {"DesText"}
  },
  ActivityReturneeLoginRewardGroup = {
    Key = true,
    Lang = {"RewardDesc"}
  },
  ActivityReturneePack = {
    Key = true,
    Lang = {
      "Name",
      "DetailName",
      "SimpleName"
    }
  },
  ActivityReturneeQuest = {
    Key = true,
    Lang = {"Title"}
  },
  ActivityReturneeQuestGroup = {Key = true},
  ActivityReturneeQuestPoint = {},
  ActivityReturneeReunionReward = {Key = true},
  ActivityReturneeTrialBuild = {Key = true},
  ActivityReturneeTrialBuildGroup = {Key = true},
  ActivityShop = {
    Key = true,
    Lang = {"Name"}
  },
  ActivityShopControl = {Key = true},
  ActivityStory = {
    Key = true,
    Lang = {
      "Index",
      "Title",
      "Desc",
      "Aim"
    }
  },
  ActivityStoryChapter = {
    Key = true,
    Lang = {"Title", "StoryTime"}
  },
  ActivityStoryCondition = {Key = true},
  ActivityStoryEvidence = {Key = true},
  ActivityStoryLine = {
    Key = true,
    Lang = {"Title"}
  },
  ActivityTask = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  ActivityTaskControl = {},
  ActivityTaskGroup = {
    Key = true,
    Lang = {"TabText"}
  },
  AdControl = {Key = true},
  AddBuffAction = {Key = true},
  AffinityGift = {Key = true},
  AffinityLevel = {
    Key = true,
    Lang = {
      "AffinityLevelName"
    }
  },
  AffinityQuest = {
    Key = true,
    Lang = {"Desc"}
  },
  AffinityUpReward = {
    Key = true,
    Lang = {
      "DescFront1",
      "DescFront2",
      "DescFront3",
      "DescAfter1",
      "DescAfter2",
      "DescAfter3"
    }
  },
  Agent = {
    Key = true,
    Lang = {
      "Note",
      "Name",
      "Desc",
      "Consignor"
    }
  },
  AgentSpecialPerformance = {Key = true},
  AgentTab = {
    Key = true,
    Lang = {"Name"}
  },
  AI = {Key = true},
  AreaEffect = {},
  AssistAttribute = {
    Key = true,
    Lang = {
      "Desc",
      "CharDesc1",
      "CharDesc2",
      "CharDesc3",
      "TeamTitle"
    }
  },
  AssistQuest = {
    Key = true,
    Lang = {"Title"}
  },
  AssistQuestGroup = {Key = true},
  Attribute = {Key = true},
  AttributeLimit = {Key = true},
  AttributeSetLimit = {Key = true},
  Banner = {Key = true},
  BattlePass = {},
  BattlePassLevel = {},
  BattlePassQuest = {
    Key = true,
    Lang = {"Title"}
  },
  BattlePassReward = {},
  BattleThreshold = {},
  BdConvert = {Key = true},
  BdConvertCondition = {
    Key = true,
    Lang = {"RequestDes"}
  },
  BdConvertContent = {
    Key = true,
    Lang = {"Des"}
  },
  BdConvertControl = {
    Key = true,
    Lang = {"DesText"}
  },
  BdConvertRewardGroup = {
    Key = true,
    Lang = {"Des"}
  },
  BoardNPC = {
    Key = true,
    Lang = {"Name", "Alias"}
  },
  BreakOutCharacter = {
    Key = true,
    Lang = {"Name"}
  },
  BreakOutControl = {Key = true},
  BreakOutEnemySpr = {Key = true},
  BreakOutFloor = {Key = true},
  BreakOutLevel = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  Buff = {Key = true},
  BuffEffect = {Key = true},
  BuffValue = {Key = true},
  Chapter = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  Character = {
    Key = true,
    Lang = {"Name"}
  },
  CharacterAdvance = {Key = true},
  CharacterArchive = {Key = true},
  CharacterArchiveBaseInfo = {
    Key = true,
    Lang = {
      "Title",
      "Content",
      "UpdateContent1"
    }
  },
  CharacterArchiveContent = {
    Key = true,
    Lang = {
      "Title",
      "Content",
      "UpdateContent1"
    }
  },
  CharacterArchiveVoice = {
    Key = true,
    Lang = {"Title"}
  },
  CharacterCG = {
    Key = true,
    Lang = {"Name"}
  },
  CharacterDes = {
    Key = true,
    Lang = {
      "Alias",
      "CnCv",
      "JpCv",
      "CharDes",
      "PotentialMain1",
      "PotentialMain2",
      "PotentialAssistant1",
      "PotentialAssistant2",
      "PotentialMainContent1",
      "PotentialMainContent2",
      "PotentialAssistantContent1",
      "PotentialAssistantContent2"
    }
  },
  CharacterSkillUpgrade = {Key = true},
  CharacterSkin = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  CharacterSkinOverlap = {Key = true},
  CharacterSkinPanelFace = {Key = true},
  CharacterSkinTheme = {Key = true},
  CharacterSpine = {Key = true},
  CharacterTag = {
    Key = true,
    Lang = {"Title"}
  },
  CharacterUpgrade = {Key = true},
  CharacterVoiceControl = {Key = true},
  CharAffinityTemplate = {Key = true},
  CharGem = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  CharGemAttrValue = {Key = true},
  CharGemInstance = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  CharGemInstanceFloor = {Key = true},
  CharGemInstanceRewardGroup = {
    Key = true,
    Lang = {"RewardName"}
  },
  CharGemInstanceType = {
    Key = true,
    Lang = {"Name"}
  },
  CharGemSlotControl = {Key = true},
  CharGetLines = {
    Key = true,
    Lang = {"Lines"}
  },
  CharGrade = {},
  CharItemExp = {Key = true},
  CharPotential = {Key = true},
  CharRaritySequence = {Key = true},
  Chat = {Key = true},
  Chest = {Key = true},
  Config = {Key = true},
  ContentWord = {
    Key = true,
    Lang = {"Word"}
  },
  CookieControl = {Key = true},
  CookieFloor = {Key = true},
  CookieLevel = {
    Key = true,
    Lang = {
      "Name",
      "PackContent"
    }
  },
  CookiePackagePathsGroup = {Key = true},
  CookieQuest = {Key = true},
  CookieRhythmlResult = {Key = true},
  DailyInstance = {
    Key = true,
    Lang = {
      "Name",
      "Desc",
      "OneStarDesc",
      "TwoStarDesc",
      "ThreeStarDesc"
    }
  },
  DailyInstanceFloor = {Key = true},
  DailyInstanceRewardGroup = {
    Key = true,
    Lang = {"RewardName", "RewardDes"}
  },
  DailyInstanceType = {
    Key = true,
    Lang = {"Name"}
  },
  DailyQuest = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  DailyQuestActive = {Key = true},
  DailyQuestAward = {Key = true},
  DatingBranch = {
    Key = true,
    Lang = {
      "Option1",
      "Option2",
      "Option3",
      "Option4",
      "Option5"
    }
  },
  DatingCharacterEvent = {
    Key = true,
    Lang = {
      "Desc1",
      "Desc2",
      "Desc3",
      "Name",
      "Clue",
      "Memory"
    }
  },
  DatingCharResponse = {Key = true},
  DatingCharTag = {Key = true},
  DatingLandmark = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  DatingLandmarkEvent = {
    Key = true,
    Lang = {
      "Desc1",
      "Desc2",
      "Desc3"
    }
  },
  DatingStartEndEvent = {
    Key = true,
    Lang = {
      "Desc1",
      "Desc2",
      "Desc3"
    }
  },
  DemonAdvance = {
    Key = true,
    Lang = {
      "AdvanceName"
    }
  },
  DemonQuest = {Key = true},
  DestroyObject = {Key = true},
  DestroyObjectSpr = {Key = true},
  DictionaryDiagram = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  DictionaryEntry = {
    Key = true,
    Lang = {"Title"}
  },
  DictionaryTab = {
    Key = true,
    Lang = {"Title"}
  },
  DictionaryTopBarEntry = {
    Key = true,
    Lang = {"Title"}
  },
  Disc = {Key = true},
  DiscExtraAttribute = {Key = true},
  DiscIP = {
    Key = true,
    Lang = {
      "VoName1",
      "VoName2",
      "StoryName",
      "StoryDesc"
    }
  },
  DiscItemExp = {Key = true},
  DiscPromote = {Key = true},
  DiscPromoteLimit = {Key = true},
  DiscStrengthen = {Key = true},
  DiscTag = {
    Key = true,
    Lang = {"Title"}
  },
  DormAchievement = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  DormFurniture = {Key = true},
  DormHonorTitle = {Key = true},
  DormInteractive = {Key = true},
  DormLayoutReward = {
    Key = true,
    Lang = {
      "RoomLayoutName",
      "RoomLayoutDesc",
      "RoomLayoutTag",
      "GetWay"
    }
  },
  DormQuest = {
    Key = true,
    Lang = {"Title"}
  },
  DormQuestGroup = {
    Key = true,
    Lang = {"Title"}
  },
  DormReward = {Key = true},
  DormRole = {Key = true},
  DormRoleSkin = {Key = true},
  DormRoom = {
    Key = true,
    Lang = {
      "DefaultName"
    }
  },
  DormRoomLayout = {Key = true},
  DormRoomScene = {
    Key = true,
    Lang = {"Desc"}
  },
  DormRoomSize = {Key = true},
  Drop = {},
  DropItemShow = {},
  DropObject = {Key = true},
  DropObjectGroup = {},
  DropPkg = {},
  Effect = {Key = true},
  EffectDesc = {
    Key = true,
    Lang = {
      "Desc",
      "RandomAttrDesc"
    }
  },
  EffectValue = {Key = true},
  EndSceneType = {Key = true},
  EnergyBuy = {
    Key = true,
    Lang = {"GroupName"}
  },
  EnumDesc = {},
  ErrorCode = {
    Key = true,
    Lang = {"Template"}
  },
  EventOptions = {
    Key = true,
    Lang = {"Desc"}
  },
  EventOptionsRules = {Key = true},
  EventReminder = {
    Key = true,
    Lang = {"Name"}
  },
  EventResult = {Key = true},
  FactionRelation = {Key = true},
  FateCard = {
    Key = true,
    Lang = {
      "Name",
      "Desc",
      "Desc2"
    }
  },
  FloorBuff = {Key = true},
  FollowSocialMediaControl = {Key = true},
  FollowSocialMediaLinkConfig = {
    Key = true,
    Lang = {"Name"}
  },
  Force = {
    Key = true,
    Lang = {"Title"}
  },
  FormationScene = {},
  Gacha = {
    Key = true,
    Lang = {"Name"}
  },
  GachaATypeProb = {},
  GachaNewbie = {Key = true},
  GachaPkg = {},
  GachaReward = {Key = true},
  GachaStorage = {
    Key = true,
    Lang = {"Name"}
  },
  GachaType = {
    Key = true,
    Lang = {
      "Name",
      "Title1",
      "Desc1",
      "Title2",
      "Desc2",
      "Title3",
      "Desc3",
      "Title4",
      "Desc4",
      "Desc5",
      "Title5",
      "Desc6",
      "Desc7",
      "Desc8",
      "Desc9",
      "Desc10",
      "Desc11"
    }
  },
  GamepadAction = {Key = true},
  GamepadButton = {Key = true},
  GMBuild = {Key = true},
  GMOrder = {},
  GMSuperman = {Key = true},
  GMTeam = {Key = true},
  GoldenSpyBuffCard = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  GoldenSpyBuffCardPool = {Key = true},
  GoldenSpyConfig = {Key = true},
  GoldenSpyControl = {Key = true},
  GoldenSpyExtraScore = {Key = true},
  GoldenSpyFloor = {Key = true},
  GoldenSpyItem = {
    Key = true,
    Lang = {"Name"}
  },
  GoldenSpyLevel = {
    Key = true,
    Lang = {
      "LevelName",
      "WinCondDesc",
      "LevelDesc"
    }
  },
  GoldenSpyLevelGroup = {
    Key = true,
    Lang = {"GroupName"}
  },
  GoldenSpyObstacle = {Key = true},
  GoldenSpySkill = {Key = true},
  Guide = {Key = true},
  GuideGroup = {Key = true},
  GuideMissionChapter = {
    Key = true,
    Lang = {"Index", "Title"}
  },
  GuideMissionQuest = {
    Key = true,
    Lang = {"Title"}
  },
  GuideMissionQuestGroup = {Key = true},
  Handbook = {Key = true},
  HitDamage = {Key = true},
  Honor = {
    Key = true,
    Lang = {"Name"}
  },
  HonorCharacter = {Key = true},
  HonorLevel = {Key = true},
  HtmlConfig = {Key = true},
  IceCreamBuff = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  IceCreamBuffPool = {Key = true},
  IceCreamChar = {Key = true},
  IceCreamCharPool = {Key = true},
  IceCreamCreate = {Key = true},
  IceCreamFever = {},
  InfinityTower = {
    Key = true,
    Lang = {"Name"}
  },
  InfinityTowerAffix = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  InfinityTowerBountyLevel = {Key = true},
  InfinityTowerDifficulty = {
    Key = true,
    Lang = {"Name", "UnlockTips"}
  },
  InfinityTowerEnemySet = {},
  InfinityTowerFloor = {Key = true},
  InfinityTowerLevel = {
    Key = true,
    Lang = {"Name"}
  },
  InfinityTowerMap = {Key = true},
  InfinityTowerMsg = {
    Key = true,
    Lang = {"Title", "Content"}
  },
  InfinityTowerPlot = {Key = true},
  InteractiveAction = {
    Key = true,
    Lang = {"Title0", "Title1"}
  },
  Item = {
    Key = true,
    Lang = {
      "Title",
      "Desc",
      "Literary"
    }
  },
  ItemPackMark = {
    Key = true,
    Lang = {"Name"}
  },
  JointDrillAffix = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  JointDrillBattleThreshold = {},
  JointDrillControl = {
    Key = true,
    Lang = {
      "PlotTitle",
      "PlotDesc",
      "DescText",
      "DetailDesc"
    }
  },
  JointDrillFloor = {Key = true},
  JointDrillLevel = {
    Key = true,
    Lang = {"SubName"}
  },
  JointDrillQuest = {
    Key = true,
    Lang = {"Title"}
  },
  JointDrillRank = {Key = true},
  JointDrill_2_Floor = {Key = true},
  JointDrill_2_FloorChange = {Key = true},
  JointDrill_2_Level = {
    Key = true,
    Lang = {"SubName", "LevelName"}
  },
  JointDrill_2_MonsterGroup = {Key = true},
  JumpTo = {
    Key = true,
    Lang = {"Desc"}
  },
  LevelQuest = {
    Key = true,
    Lang = {"QuestName"}
  },
  LevelQuestTarget = {
    Key = true,
    Lang = {"QuestDes"}
  },
  LoginRewardControl = {
    Key = true,
    Lang = {"DesText"}
  },
  LoginRewardGroup = {
    Key = true,
    Lang = {"RewardDesc"}
  },
  MailTemplate = {
    Key = true,
    Lang = {
      "Author",
      "Subject",
      "Desc"
    }
  },
  Mainline = {Key = true},
  MainlineFloor = {Key = true},
  MainScreenCG = {
    Key = true,
    Lang = {"Name"}
  },
  MainSkill = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  MallActivity = {
    Key = true,
    Lang = {"Name"}
  },
  MallAdvRecommend = {Key = true},
  MallGem = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  MallMonthlyCard = {
    Key = true,
    Lang = {
      "Name",
      "Desc",
      "Name2"
    }
  },
  MallPackage = {
    Key = true,
    Lang = {
      "Name",
      "DetailName",
      "SimpleName"
    }
  },
  MallPackagePage = {
    Key = true,
    Lang = {"Name"}
  },
  MallRecommendGroup = {
    Key = true,
    Lang = {"Name"}
  },
  MallShop = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  MallShopPage = {
    Key = true,
    Lang = {"Name"}
  },
  MangaLoading = {
    Key = true,
    Lang = {"Title"}
  },
  MathParkourAreaConfig = {Key = true},
  MathParkourBuffItem = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  MathParkourConfig = {Key = true},
  MathParkourControl = {
    Key = true,
    Lang = {"Desc"}
  },
  MathParkourItemGroup = {Key = true},
  MathParkourLevel = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  MathParkourObject = {
    Key = true,
    Lang = {"Name"}
  },
  MathParkourQuest = {
    Key = true,
    Lang = {"Desc"}
  },
  MathParkourQuestGroup = {
    Key = true,
    Lang = {"GroupName"}
  },
  MiningControl = {
    Key = true,
    Lang = {"Desc"}
  },
  MiningDemoConfig = {Key = true},
  MiningDemoRewardConfig = {},
  MiningQuest = {
    Key = true,
    Lang = {"QuestDes"}
  },
  MiningQuestGroup = {
    Key = true,
    Lang = {"GroupName"}
  },
  MiningStory = {Key = true},
  MiningSupport = {
    Key = true,
    Lang = {"SkillName", "SkillDes"}
  },
  MiningTreasure = {
    Key = true,
    Lang = {"Name", "Des"}
  },
  Monster = {Key = true},
  MonsterActionBranch = {Key = true},
  MonsterAI = {Key = true},
  MonsterAttackAjust = {Key = true},
  MonsterAttributeContact = {Key = true},
  MonsterBornGroup = {},
  MonsterGroup = {Key = true},
  MonsterManual = {
    Key = true,
    Lang = {
      "Name",
      "Desc",
      "SkillDesc"
    }
  },
  MonsterSkin = {Key = true},
  MonsterTeam = {Key = true},
  MonsterValueTemplete = {Key = true},
  MonsterValueTempleteAdjust = {Key = true},
  MonsterValueTempleteModify = {Key = true},
  MonthlyCard = {Key = true},
  NotificationConfig = {
    Key = true,
    Lang = {"Title", "Content"}
  },
  NPCAffinityGroup = {
    Key = true,
    Lang = {
      "RelationshipName"
    }
  },
  NPCAffinityPlot = {
    Key = true,
    Lang = {
      "Name",
      "Desc",
      "PlotSum"
    }
  },
  NPCConfig = {
    Key = true,
    Lang = {
      "Name",
      "Desc",
      "Literary"
    }
  },
  NPCSkin = {Key = true},
  OnceAdditionalAttribute = {Key = true},
  OnceAdditionalAttributeValue = {Key = true},
  OpenFunc = {
    Key = true,
    Lang = {
      "Name",
      "Desc",
      "Tips"
    }
  },
  PenguinBaseCard = {
    Key = true,
    Lang = {"Title"}
  },
  PenguinBaseCardPool = {Key = true},
  PenguinCard = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  PenguinCardAide = {
    Key = true,
    Lang = {"Title"}
  },
  PenguinCardAidePool = {Key = true},
  PenguinCardBuff = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  PenguinCardBuffWeight = {Key = true},
  PenguinCardControl = {
    Key = true,
    Lang = {"DesText"}
  },
  PenguinCardCost = {Key = true},
  PenguinCardEndlessLevel = {
    Key = true,
    Lang = {"Desc"}
  },
  PenguinCardFixedTurn = {Key = true},
  PenguinCardFloor = {
    Key = true,
    Lang = {"Floortips", "FloorDesc"}
  },
  PenguinCardHandRank = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  PenguinCardQuest = {
    Key = true,
    Lang = {"Desc"}
  },
  PenguinCardQuestWeight = {Key = true},
  PenguinCardTendency = {Key = true},
  PenguinCardWeight = {Key = true},
  PeriodicQuest = {
    Key = true,
    Lang = {"Title"}
  },
  PeriodicQuestControl = {
    Key = true,
    Lang = {"DesText"}
  },
  PeriodicQuestGroup = {},
  PlayerHead = {
    Key = true,
    Lang = {"Desc"}
  },
  Plot = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  PopUp = {Key = true},
  PopUpSequence = {Key = true},
  Potential = {
    Key = true,
    Lang = {"BriefDesc", "Desc"}
  },
  PotentialPassiveSkill = {Key = true},
  PotentialPreset = {
    Key = true,
    Lang = {
      "Name",
      "Description"
    }
  },
  PreviewMonsterGroup = {Key = true},
  ProduceHelper = {Key = true},
  Production = {
    Key = true,
    Lang = {"Name", "UnlockTip"}
  },
  ProductionType = {
    Key = true,
    Lang = {"TypeName"}
  },
  RandomLevelMonster = {Key = true},
  Rank = {},
  RegionBoss = {
    Key = true,
    Lang = {
      "Name",
      "OpenDayDesc"
    }
  },
  RegionBossAffix = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  RegionBossFloor = {Key = true},
  RegionBossLevel = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  ResidentGoods = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  ResidentShop = {
    Key = true,
    Lang = {"Name"}
  },
  ScoreBossAbility = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  ScoreBossBattleThreshold = {},
  ScoreBossControl = {Key = true},
  ScoreBossFloor = {Key = true},
  ScoreBossGetControl = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  ScoreBossLevel = {Key = true},
  ScoreBossRank = {Key = true},
  ScoreBossReward = {Key = true},
  ScoreBossStar = {},
  ScoreGetSwitch = {Key = true},
  ScriptParameter = {Key = true},
  ScriptParameterValue = {Key = true},
  SecondarySkill = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  Shield = {Key = true},
  ShieldValue = {Key = true},
  SignIn = {},
  Skill = {
    Key = true,
    Lang = {
      "Title",
      "BriefDesc",
      "Desc"
    }
  },
  SkillDamage = {Key = true},
  SkillInstance = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  SkillInstanceFloor = {Key = true},
  SkillInstanceType = {
    Key = true,
    Lang = {"Name"}
  },
  SoldierBossPersonalityGrade = {},
  SoldierBossTemplate = {
    Key = true,
    Lang = {
      "Name",
      "Title",
      "Desc"
    }
  },
  SoldierBuff = {Key = true},
  SoldierCardEffect = {Key = true},
  SoldierCharacter = {
    Key = true,
    Lang = {"Name"}
  },
  SoldierCharGrowthTier = {Key = true},
  SoldierCharTierAttrBonus = {Key = true},
  SoldierCheckStageAddScore = {Key = true},
  SoldierChessAI = {Key = true},
  SoldierChessType = {
    Key = true,
    Lang = {"Name"}
  },
  SoldierClientBuff = {Key = true},
  SoldierControl = {
    Key = true,
    Lang = {"DesText"}
  },
  SoldierDifficultyAdjustGrade = {Key = true},
  SoldierEndingPlan = {
    Key = true,
    Lang = {
      "EndingTitle",
      "Desc"
    }
  },
  SoldierEventBattlePool = {
    Key = true,
    Lang = {"Title", "Name"}
  },
  SoldierEventPersonalityStory = {Key = true},
  SoldierEventPlan = {Key = true},
  SoldierFloor = {Key = true},
  SoldierGradeChallenge = {
    Key = true,
    Lang = {"Name"}
  },
  SoldierKeyGrade = {
    Key = true,
    Lang = {"Name"}
  },
  SoldierLabelMark = {Key = true},
  SoldierNodePlan = {Key = true},
  SoldierOptionType = {
    Key = true,
    Lang = {"OptionDesc", "CostDesc"}
  },
  SoldierPartner = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  SoldierPartnerGroup = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  SoldierPositionEffect = {
    Key = true,
    Lang = {
      "Name",
      "KeyEffectDes"
    }
  },
  SoldierPotential = {
    Key = true,
    Lang = {"Name", "Des"}
  },
  SoldierQuest = {
    Key = true,
    Lang = {"Desc"}
  },
  SoldierQuestGroup = {
    Key = true,
    Lang = {"Des"}
  },
  SoldierRecommendBuilds = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  SoldierSeason = {Key = true},
  SoldierShopLevel = {},
  SoldierShopPool = {Key = true},
  SoldierSkin = {
    Key = true,
    Lang = {"Name"}
  },
  SoldierStarterCard = {
    Key = true,
    Lang = {
      "Name",
      "Des",
      "Desc"
    }
  },
  SoldierStoryPersonalityOption = {Key = true},
  SoldierStoryResult = {
    Key = true,
    Lang = {"ResultText"}
  },
  SoldierStoryReward = {Key = true},
  SoldierStoryType = {
    Key = true,
    Lang = {
      "Title",
      "Desc",
      "OptionTitleDesc1"
    }
  },
  SoldierStrategyCard = {
    Key = true,
    Lang = {
      "Name",
      "Des",
      "Desc"
    }
  },
  SoldierTechBattleEffect = {Key = true},
  SoldierTechNode = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  SoldierTotalReward = {Key = true},
  StarTower = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  StarTowerBookEntrance = {
    Key = true,
    Lang = {"Position", "Desc"}
  },
  StarTowerBookEventReward = {
    Key = true,
    Lang = {
      "Name",
      "Story",
      "Source"
    }
  },
  StarTowerBookFateCard = {
    Key = true,
    Lang = {"Source"}
  },
  StarTowerBookFateCardBundle = {
    Key = true,
    Lang = {"Name", "ShortName"}
  },
  StarTowerBookFateCardQuest = {
    Key = true,
    Lang = {"Desc"}
  },
  StarTowerBookPotentialReward = {Key = true},
  StarTowerBuild = {Key = true},
  StarTowerBuildRank = {Key = true},
  StarTowerCombatEvent = {Key = true},
  StarTowerCombo = {Key = true},
  StarTowerDropItem = {Key = true},
  StarTowerEnemySet = {},
  StarTowerEvent = {Key = true},
  StarTowerEventAction = {
    Key = true,
    Lang = {"Desc"}
  },
  StarTowerEventOptionAction = {
    Key = true,
    Lang = {"Desc"}
  },
  StarTowerFloor = {Key = true},
  StarTowerFloorExp = {Key = true},
  StarTowerFloorSet = {Key = true},
  StarTowerGroup = {
    Key = true,
    Lang = {"Name"}
  },
  StarTowerGrowthGroup = {
    Key = true,
    Lang = {"Name"}
  },
  StarTowerGrowthNode = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  StarTowerMap = {Key = true},
  StarTowerMapMaxNumPerStage = {Key = true},
  StarTowerMonsterBornGroup = {},
  StarTowerMonsterSpAttr = {Key = true},
  StarTowerNPC = {
    Key = true,
    Lang = {"Name", "NPCDesc"}
  },
  StarTowerQuest = {
    Key = true,
    Lang = {"Title"}
  },
  StarTowerScenePrefab = {Key = true},
  StarTowerShopGoods = {Key = true},
  StarTowerSpecificCombat = {Key = true},
  StarTowerSpMode = {Key = true},
  StarTowerStage = {Key = true},
  StarTowerTalk = {
    Key = true,
    Lang = {"Name", "Content"}
  },
  StarTowerTeamExp = {Key = true},
  Story = {
    Key = true,
    Lang = {
      "Index",
      "Title",
      "Desc",
      "Aim"
    }
  },
  StoryChapter = {
    Key = true,
    Lang = {
      "Name",
      "Desc",
      "ChapterYear"
    }
  },
  StoryChapterTimeStamp = {
    Key = true,
    Lang = {"TimeStamp"}
  },
  StoryCondition = {Key = true},
  StoryEvidence = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  StoryLine = {
    Key = true,
    Lang = {"TitleMain", "TitleSub"}
  },
  StoryPersonality = {
    Key = true,
    Lang = {"Name"}
  },
  StoryPreview = {
    Key = true,
    Lang = {"Title"}
  },
  StoryRolePersonality = {
    Key = true,
    Lang = {
      "Amax",
      "Bmax",
      "Cmax",
      "Aplus",
      "Bplus",
      "Cplus",
      "Abc",
      "Bac",
      "Cab",
      "Normal"
    }
  },
  StorySetChapter = {
    Key = true,
    Lang = {
      "Title",
      "Name",
      "LockText"
    }
  },
  StorySetSection = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  StorySetTab = {
    Key = true,
    Lang = {"TabName"}
  },
  SubNoteSkill = {
    Key = true,
    Lang = {
      "Name",
      "BriefDesc",
      "Desc"
    }
  },
  SubNoteSkillDropGroup = {Key = true},
  SubNoteSkillPromoteGroup = {Key = true},
  Talent = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  TalentGroup = {
    Key = true,
    Lang = {"Title"}
  },
  TestCharacterAtt = {Key = true},
  TestCharacterList = {Key = true},
  TestTeamData = {Key = true},
  ThrowGiftFloor = {Key = true},
  ThrowGiftGuideLine = {Key = true},
  ThrowGiftItem = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  ThrowGiftItemPool = {Key = true},
  ThrowGiftLevel = {
    Key = true,
    Lang = {
      "DifficultyName",
      "LevelName",
      "ThrowGiftLevelCondDesc"
    }
  },
  ThrowGiftSpawnPoints = {Key = true},
  ThrowGiftSpecialObstacle = {Key = true},
  Title = {
    Key = true,
    Lang = {"Desc"}
  },
  TopBar = {
    Key = true,
    Lang = {"Title"}
  },
  TourGuideQuest = {
    Key = true,
    Lang = {"Title"}
  },
  TourGuideQuestGroup = {Key = true},
  TowerDefenceCharacterAI = {Key = true},
  TowerDefenseCharacter = {
    Key = true,
    Lang = {"Name"}
  },
  TowerDefenseControl = {
    Key = true,
    Lang = {"DesText"}
  },
  TowerDefenseFloor = {Key = true},
  TowerDefenseGuide = {Key = true},
  TowerDefenseItem = {
    Key = true,
    Lang = {
      "Name",
      "Des",
      "ItemTips"
    }
  },
  TowerDefenseLevel = {
    Key = true,
    Lang = {
      "LevelName",
      "Des1",
      "Des2",
      "Des3"
    }
  },
  TowerDefenseMonster = {
    Key = true,
    Lang = {"Brief"}
  },
  TowerDefensePotential = {
    Key = true,
    Lang = {
      "Name",
      "PotentialDes"
    }
  },
  TowerDefenseQuest = {
    Key = true,
    Lang = {"Desc"}
  },
  TowerDefenseQuestGroup = {
    Key = true,
    Lang = {"GroupName"}
  },
  TowerDefenseStory = {Key = true},
  TowerDefenseTeamExp = {Key = true},
  TowerVitaDefalutValue = {Key = true},
  TowerVitaOption = {
    Key = true,
    Lang = {
      "OptionText1",
      "OptionText2",
      "OptionText3",
      "OptionText4",
      "OptionText5",
      "OptionText6",
      "OptionText7",
      "OptionText8",
      "OptionText9"
    }
  },
  TraceHuntBoss = {Key = true},
  TraceHuntControl = {Key = true},
  TraceHuntDifficulty = {},
  TraceHuntFloor = {Key = true},
  TraceHuntFloorGroup = {Key = true},
  TraceHuntLevel = {},
  TraceHuntLogEntryTemplate = {
    Key = true,
    Lang = {"Desc"}
  },
  TraceHuntScoreSwitch = {Key = true},
  TraceHuntSelfHuntExtraCost = {},
  TraceHuntStar = {Key = true},
  Trap = {Key = true},
  TrapAttribute = {Key = true},
  TravelerDuelBoss = {
    Key = true,
    Lang = {"Name"}
  },
  TravelerDuelBossLevel = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  TravelerDuelChallengeAffix = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  TravelerDuelChallengeControl = {Key = true},
  TravelerDuelChallengeDifficulty = {Key = true},
  TravelerDuelChallengeQuest = {
    Key = true,
    Lang = {"Title"}
  },
  TravelerDuelFansLevel = {Key = true},
  TravelerDuelFloor = {Key = true},
  TravelerDuelHotValueItem = {Key = true},
  TravelerDuelHotValueRewards = {Key = true},
  TravelerDuelIdleRewards = {},
  TravelerDuelTarget = {
    Key = true,
    Lang = {"RivalName"}
  },
  TrialBuild = {
    Key = true,
    Lang = {"Name"}
  },
  TrialCharacter = {
    Key = true,
    Lang = {"Name"}
  },
  TrialControl = {Key = true},
  TrialDisc = {Key = true},
  TrialFloor = {Key = true},
  TrialGroup = {Key = true},
  TrialPotential = {Key = true},
  TutorialLevel = {
    Key = true,
    Lang = {"Title"}
  },
  TutorialLevelFloor = {Key = true},
  UIText = {
    Key = true,
    Lang = {"Text"}
  },
  VampireBattleThreshold = {},
  VampireEnemyPool = {},
  VampireEnemySet = {},
  VampireEnemySpAttr = {Key = true},
  VampireFloor = {Key = true},
  VampireMap = {Key = true},
  VampireRankSeason = {Key = true},
  VampireSurvivor = {
    Key = true,
    Lang = {
      "Name",
      "Name1",
      "Name2"
    }
  },
  VampireSurvivorLevel = {},
  VampireSurvivorQuest = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  VampireTalent = {
    Key = true,
    Lang = {"Name"}
  },
  VampireTalentDesc = {
    Key = true,
    Lang = {"Num"}
  },
  VampireTalentFloor = {Key = true},
  VoDirectory = {Key = true},
  WeekBossAffix = {
    Key = true,
    Lang = {"Name", "Desc"}
  },
  WeekBossFloor = {Key = true},
  WeekBossLevel = {
    Key = true,
    Lang = {"Name"}
  },
  WeekBossType = {
    Key = true,
    Lang = {"Name"}
  },
  WeeklyQuest = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  WeeklyQuestActive = {Key = true},
  WeightParameter = {},
  Word = {
    Key = true,
    Lang = {"Title", "Desc"}
  },
  WorldClass = {
    Key = true,
    Lang = {
      "FuncChangeText1",
      "FuncChangeText2",
      "FuncChangeText3"
    }
  }
}
return GameTableDefine
