EUILayoutLevel = {
  "Bottom",
  "Normal",
  "Middle",
  "High",
  "OverHigh",
  "LowTop",
  "Top",
  "Msg",
  "Max"
}
EUILayoutLevel = CreatEnumTable(EUILayoutLevel, -1)
UIWindowTypeID = {
  LuaTest = 1000,
  Home = 1,
  TopStatus = 2,
  NavigationBar = 3,
  BattleResult = 4,
  ExplorationResult = 6,
  ExplorationResultSettlement = 7,
  ChatSystem = 8,
  OasisEditWindow = 9,
  HomeSide = 10,
  NoticeMessagePush = 11,
  Login = 12,
  LotteryWindow = 13,
  Loading = 14,
  USkySystem = 15,
  CommonRename = 16,
  UserFreined = 17,
  GameNotice = 18,
  UserFreinedSetAlias = 23,
  Task = 25,
  Factory = 26,
  CommonReward = 27,
  AchievementSystem = 28,
  BannerSpread = 29,
  QuickBuy = 30,
  QuickBuyKey = 31,
  GetHero = 34,
  Mail = 35,
  Guide = 36,
  FloatText = 38,
  ClickContinue = 39,
  GlobalItemDetail = 40,
  RewardPreview = 41,
  Setting = 45,
  SettingGraph = 46,
  SettingDescribe = 47,
  CommonMask = 48,
  DormInput = 60,
  DormInteract = 61,
  DormMain = 62,
  DormRoom = 63,
  DormCheckIn = 64,
  DormReplaceHero = 65,
  DormComfort = 66,
  DormTransAnima = 67,
  DormVisit = 68,
  FriendShip = 70,
  FriendShipHeroFoster = 71,
  FriendShipPlotDungeon = 72,
  Avg = 73,
  SectorLevel = 74,
  SectorLevelDetail = 75,
  SectorEntrance = 76,
  SectorUnlockMovie = 77,
  AvgNounDes = 78,
  AvgSkip = 79,
  Formation = 80,
  FormationQuick = 82,
  CampBond = 83,
  FmtChallengeInfo = 84,
  FormationRankPreview = 85,
  FairyFormation = 86,
  MessageSide = 90,
  ViewChips = 95,
  ViewItems = 96,
  MaterialDungeon = 97,
  SelectBoardHero = 98,
  Exploration = 101,
  SelectChip = 102,
  EpChipList = 104,
  ThreeDSelectChip = 105,
  EpBuff = 106,
  SectorTask = 107,
  EpStoreRoom = 109,
  EpBuffShow = 110,
  EpAutoMode = 111,
  OverClock = 120,
  FloatingFrame = 121,
  CSTMain = 123,
  RichIntro = 124,
  ChipDisplace = 128,
  EpTreasureRoom = 130,
  EpEventRoom = 131,
  EpUpgradeRoom = 132,
  EpChipDiscard = 133,
  ATHDungeon = 134,
  EpSupportRoom = 135,
  EpResidentStore = 136,
  EpBuffDesc = 137,
  EpChallengeDiscard = 138,
  EpRewardBag = 141,
  EpRewardPreview = 142,
  CurrentChip = 143,
  EpChipSuit = 144,
  EpMonsterLevelUp = 145,
  EpSelectDebuff = 146,
  LotteryExchange = 147,
  LotteryPoolDetail = 148,
  LotterySelectPool = 149,
  MiniGameTask = 150,
  CommonEpModeSelect = 160,
  EPTalkDialog = 161,
  DormItemDetail = 162,
  LineupRecommend = 163,
  LineupMessageBox = 164,
  ChipScoreShow = 165,
  FormationSave = 166,
  InfinityFmtCheck = 167,
  BattleSkillModule = 203,
  Battle = 204,
  BattlePause = 205,
  BattleEnemyDetail = 206,
  BattleDPS = 207,
  BattleCrazyMode = 208,
  BattleFail = 209,
  DungeonStateInfo = 210,
  DungeonInfoDetail = 211,
  BattleEffectGirdInfo = 212,
  SelectChipSuit = 213,
  ResultSkada = 220,
  UltimateSkillShow = 225,
  GuidePicture = 230,
  GuidePicture_0623New = 231,
  DungeonResult = 250,
  DungeonFailureResult = 251,
  DungeonWaveTip = 252,
  BattleResultExtra = 260,
  BattleAutoMode = 261,
  UltSkillVideo = 262,
  HeroList = 300,
  HeroState = 301,
  HeroLevelUp = 302,
  HeroLevelUpSuccess = 303,
  HeroStarUp = 304,
  HeroSkillUp = 305,
  HeroSkillUpgrade = 306,
  HeroStarUpSuccess = 307,
  HeroPowerUpSuccess = 308,
  HeroPotential = 309,
  HeroPotentialSuccess = 310,
  HeroSkin = 311,
  HeroSkinPreView = 312,
  HeroTask = 313,
  HeroInfomation = 314,
  HeroBackOff = 315,
  HeroTalent = 316,
  SpecWeapon = 317,
  GetHeroSkin = 318,
  ArmaInscriptaQuickEnhance = 319,
  UserNameCreate = 401,
  UserInfo = 500,
  UserInfoDialog = 501,
  UserInfoSelectSupport = 502,
  SelectSupportList = 503,
  SupportHeroState = 504,
  CommonUserInfo = 505,
  MessageSideAddFriend = 506,
  HeroInfoState = 520,
  Report = 550,
  SteinsGateAvg = 560,
  ActLobbyMain = 600,
  ActLbFollowInfo = 601,
  DungeonTowerLevel = 801,
  DungeonLevelDetail = 802,
  DungeonTowerSuccess = 803,
  DungeonTowerSelect = 804,
  DungeonTwinTowerSelect = 805,
  DungeonTwinTowerSelectNoAni = 806,
  DungeonTowerRacing = 807,
  DungeonHexaTower = 808,
  DungeonHexaTowerSelect = 809,
  DungeonLevelDetailSteinsGate = 850,
  CommonRank = 901,
  StageRewardPreview = 902,
  RecommeFormationSeason = 903,
  Ath = 1000,
  AthEfficiency = 1001,
  CommonUpgradeTips = 1002,
  AthItemDetail = 1003,
  AthReplaceHero = 1004,
  AthDecompose = 1006,
  AthRefactor = 1007,
  AthRefactorSuccess = 1008,
  AthItemDetailFloat = 1009,
  AthRefactorSuccessExtra = 1010,
  AthSignMain = 1011,
  AthRefactorConfirm = 1012,
  LotteryResult = 1100,
  LotteryShow = 1101,
  LotterySelectHero = 1102,
  LotterySpecialSelect = 1103,
  MessageCommon = 1200,
  MessageBox = 1250,
  Factory = 1300,
  FactoryQuickProduce = 1302,
  FactoryProduceLine = 1303,
  RecommeFormation = 1305,
  AvgDetail = 1306,
  RecommeFormationNew = 1307,
  StrategyOverview = 1400,
  OasisMain = 1500,
  VowCard = 1510,
  VowCardSign = 1511,
  VowChangeNameDialog = 1512,
  VowShow = 1513,
  VowShowSkip = 1514,
  VowMask = 1515,
  ActivityStarUp = 1600,
  ActivityStarUpRewardPreview = 1601,
  CommonActivityLogin = 1602,
  EventSignin = 1605,
  EventWeChat = 1606,
  EventWeChatInformation = 1607,
  EventWeChatViewQRCode = 1608,
  ActivityLimitTask = 1609,
  SignInMiniGame = 1610,
  EventOptionalGift = 1611,
  EventLadderGift = 1612,
  EventDrawLottery = 1613,
  EventDrawLotteryTaskWindow = 1614,
  SignInLiveStream = 1615,
  ActivityWinterTech = 1620,
  ActivityWinterDungeon = 1621,
  ActivityWinterMainMap = 1622,
  Win21Shop = 1623,
  Win21SectorBar = 1624,
  ActivityComeback = 1625,
  ActivityComebackLite = 1626,
  ActivityComebackSystemTaskWindow = 1627,
  FlappyBird = 1631,
  FlappyBirdRanking = 1632,
  Halloween22Main = 1633,
  Halloween22ModeSelect = 1634,
  Halloween22Achievement = 1635,
  Halloween22Task = 1636,
  Halloween22Bouns = 1637,
  EventBattlePassBuyLevel_Halloween = 1638,
  WhiteDay = 1641,
  WhiteDayLine = 1642,
  WhiteDayAccOrder = 1643,
  WhiteDayFactoryLevel = 1644,
  WhiteDayFactoryLevelUp = 1645,
  WhiteDayHeroList = 1646,
  WhiteDayAlbum = 1647,
  WhiteDayTask = 1648,
  WhiteDayEvent = 1649,
  WhiteDayHistoryAlbum = 1650,
  AprilFool = 1661,
  ActBondMain = 1665,
  ActBondDunSelect = 1666,
  ActBondDetails = 1667,
  Carnival22Main = 1671,
  Carnival22Select = 1672,
  Carnival22Task = 1673,
  Carnival22StrategyOverview = 1674,
  Carnival22MiniGame = 1675,
  Carnival22Progress = 1676,
  Carnival22InfoWindow = 1677,
  Carnival22Challenge = 1678,
  EventDaliyChallenge = 1679,
  ActSum22Main = 1680,
  ActSum22Task = 1681,
  ActSum22Shop = 1682,
  ActSum22Map = 1683,
  ActSum22DunRepeat = 1684,
  ActSum22StrategyMain = 1685,
  ActSum22StrategyTree = 1686,
  ActSum22StrategySelect = 1687,
  ActEntrySpread = 1688,
  ActivityKeyExertion = 1689,
  Christmas22Main = 1690,
  Christmas22Task = 1691,
  Christmas22Bonus = 1692,
  Christmas22ModeSelect = 1693,
  Christmas22StrategyOverview = 1694,
  Christmas22Repeat = 1695,
  ChristmasEnvTask = 1696,
  Christmas22Unlock = 1697,
  EventBattlePass = 1701,
  EventBattlePassPurchase = 1702,
  EventGrowBag = 1703,
  EventBattlePassBuyLevel = 1704,
  EventBattlePassV2 = 1705,
  EventBattlePassRewardPreview = 1706,
  BpSpReward = 1707,
  EventInvitation = 1710,
  EventWeeklyQA = 1711,
  EventAngelaGift = 1712,
  SaveMoney = 1713,
  SaveMoneyPreview = 1715,
  LuckyRaffle = 1716,
  ExplorationFund = 1720,
  ShopMain = 1800,
  CharacterDungeonShop = 1801,
  HeroChipOverflowWindow = 1802,
  ChipGift = 1880,
  CustomHeroGift = 1881,
  CustomHeroSelect = 1882,
  EventNewYear23SkinBag = 1883,
  EventCommonSkinBag = 1884,
  CommonInfo = 1900,
  CommonTextFrame = 1902,
  CommonRuleInfo = 1903,
  PeriodicDebuffSelect = 1910,
  PeriodicBattleBossResult = 1911,
  PeriodicEnvBuffSelect = 1912,
  DailyChallenge = 1950,
  WeeklyChallengeRank = 1961,
  WCDebuffResult = 1962,
  WeeklyChallengeTask = 1963,
  ActivityFrameMain = 2000,
  EventNoviceSign = 2001,
  Warehouse = 2002,
  CommonUseGift = 2003,
  EpTask = 2004,
  GiftPageDetail = 2005,
  CommonSelectGift = 2006,
  CommonThemedPacks = 2007,
  EventFestivalSignIn = 2010,
  ActSummer = 2050,
  ActSummerLvSwitch = 2051,
  ActSum21Exchange = 2052,
  ActSum21ExchangeResult = 2053,
  TDBattle = 2101,
  TDCharactorInfo = 2102,
  TDProcessView = 2103,
  DailyDungeonMain = 2200,
  DailyDungeonLevel = 2201,
  DailyDungeonComplete = 2202,
  SceneChangesMask = 2350,
  EffectMask = 2351,
  MovieBlack = 2401,
  MoviePlayer = 2402,
  ShowCharacter = 2501,
  ShowCharacterSkin = 2502,
  CharacterDungeon = 2510,
  HeroPlotReview = 2511,
  StoryReview = 2512,
  CharDunVer2 = 2513,
  CharDunTaskVer2 = 2514,
  CharDunShopVer2 = 2515,
  CharDunShopVer3 = 2516,
  CharDunTaskVer3 = 2517,
  CharDunVer3 = 2518,
  CharDunVer3Repeat = 2519,
  CahrDunChallengV3 = 2520,
  CahrDunVer3Normal = 2521,
  CahrDunVer3NormalMap = 2522,
  AniModeChange = 2525,
  AdjPreset = 2530,
  AdjPresetNameChange = 2531,
  AdjEditor = 2532,
  HandBookBackground = 2550,
  HandBookHeroCampIndex = 2551,
  HandBookHeroCampHeroList = 2552,
  HandBookCampInfo = 2553,
  HandbookHeroRelation = 2554,
  HandBookSkinList = 2555,
  HandBookSkin = 2556,
  HandBookMain = 2557,
  HandBookActBook = 2558,
  HandBookActBookEx = 2559,
  HandBookActBookFes = 2560,
  HandBookRewardWindow = 2561,
  HandBookCardMain = 2562,
  ChipDetailFloat = 2600,
  WhiteDay2048 = 3001,
  WhiteDay2048Score = 3002,
  WhiteDay2048Rank = 3003,
  SmashingPenguins = 3011,
  SmashingPenguinsRanking = 3012,
  UIBrotatoLobbyMain = 3021,
  UIBrotatoResult = 3022,
  MiniGameMusic = 3031,
  AprilGameDamie = 3201,
  ActivityMiniGameMain = 3202,
  SnakeGame = 3203,
  SnakeGameRank = 3204,
  WarChessMain = 3501,
  WarChessInfo = 3502,
  WarChessMonsterDetail = 3503,
  WarChessPickTeam = 3505,
  WarChessStore = 3506,
  WarChessBattleResult = 3508,
  WarChessEvent = 3509,
  WarChessChipDiscard = 3510,
  WarChessStrategyReward = 3511,
  WarChessLoading = 3520,
  WarChessObjDetail = 3521,
  WarChessSelectChip = 3531,
  WarChessBuyChip = 3532,
  WarChessTalkDialog = 3541,
  WarChessViewChip = 3545,
  WarChessInheritChip = 3546,
  WarChessTimeRewind = 3547,
  RecommeFormationWindow = 3550,
  WarChessNotice = 3600,
  WarChessResult = 3650,
  WarChessGameWin = 3651,
  WarChessGameFail = 3652,
  WarChessSeasonSelectLevel = 3680,
  WarChessSeasonSettle = 3682,
  WCSModeSelect = 3683,
  WCSSavingPanel_Halloween22 = 3701,
  WCSSavingPanel_Christmas22 = 3702,
  WCSSavingPanel_Common = 3703,
  DormFightMain = 3802,
  DormFightFriendInviting = 3803,
  DormFightBeInvited = 3804,
  DormFightFormation = 3805,
  DOrmFightVS = 3806,
  DormFightResult = 3807,
  DormFightLoading = 3808,
  VowSystemTest = 3900,
  VowReward = 3901,
  CardSet = 3920,
  CardSetEntrance = 3921,
  CardSetBattleResult = 3922,
  CardSetLockedTeam = 3923,
  CardRankBattleDetails = 3924,
  CardSetRewind = 3925,
  CardSetDiffUnlock = 3926,
  CardSetRestWithAni = 3927,
  CardSetRankMode = 3928,
  CardSetMEReward = 3929,
  CardSetReward = 3930,
  FairyCultivateMain = 3951,
  FairyLobbyMain = 3952,
  FairyNotice = 3953,
  FairyChangeName = 3954,
  CommonFairyInfo = 3955,
  FairyLottery = 3956,
  FairyLotteryResult = 3957,
  FairySkillDetails = 3958,
  FairyRecovery = 3959,
  FairyLotteryShow = 3960,
  FairyQuickLv = 3961,
  FairyQuickLvSkillSave = 3962,
  FairySkillDetailFloat = 3963,
  Spring23Main = 4001,
  Spring23LevelModSelect = 4002,
  Spring23Challenge = 4003,
  Spring23Interactive = 4004,
  Spring23StrategyOverview = 4011,
  Spring23Misson = 4013,
  Spring23Unlock = 4014,
  Spring23Story = 4015,
  Winter23StrategyOverview = 4020,
  SectorChapterLvSwitch = 4021,
  Winter23Task = 4022,
  Winrwe23Shop = 4023,
  ActivitySeasonBonus = 4100,
  CommonActivityRepeatDungeon = 4101,
  BattlePassActivity = 4102,
  SeasonQuickBattle = 4110,
  ActivitySeasonUnlcok = 4111,
  Summer23Interactive = 4120,
  Summer23QuestUnlock = 4121,
  EventPreciousCompany = 4122,
  MailStoneMian = 4130,
  MilestoneSheet = 4131,
  ActivityFlipCardMain = 4140,
  ActivityFlipCardGetMore = 4141,
  ActivityFlipCardTask = 4142,
  ActivityFlipCardPreview = 4143,
  ActivitySkinLimitMain = 4145,
  ActivitySkinLimitTask = 4146,
  ActivityHazeGiftMain = 4147,
  ActivityAnniversary23Unlock = 4150,
  ActivityBlackHoleMain = 4160,
  ActivitySteinsGateMiniGameMain = 4165,
  ActivityDivergentMain = 4200,
  HeroQuickLvUpMain = 4201,
  HeroQuickLvUpWindow = 4202,
  CommonQuickBattle = 4250,
  CommonMonsterCard = 4255,
  CommonMonsterCardDrop = 4256,
  CommonHardLevel = 4260,
  CommonActRewardBp = 4265,
  UI23SteinsGateTask = 4301,
  UI23SteinsGateGachaponShop = 4302,
  SteinsGateRepeat = 4303,
  Activity23SteinsGateChapterMap = 4304,
  UISteinsGateDiffSelect = 4305,
  UISteinsGate23Interactive = 4306,
  UI23SteinsGateUnlock = 4307,
  SectorStoryReview = 4308,
  SectorLevelDetailSteinsGate = 4309,
  UI23SteinsGateScenesLoading = 4310,
  SteinsGateCommonMask = 4311,
  SteinsGateEffectMask = 4312,
  PerformanceMain = 4320,
  PerformancePlay = 4321,
  PerformanceRank = 4322,
  PerformanceResult = 4323,
  PerformanceSelect = 4324,
  PerformanceGameTask = 4325,
  UI24WinterTask = 4401,
  UISpring24Notice = 4411,
  Spring24Interactive = 4412,
  UI24SpringCollectFortuneMain = 4413,
  UICarnivalMemoryFragments = 4420,
  UICarnivalMemoryAlbums = 4421,
  DeliverySimulatorMain = 4430,
  DeliverySimulatorEntrance = 4431,
  DeliverySimulatorSelect = 4432,
  DeliverySimulatorResult = 4433,
  UIReinforceCardDetailFac = 4500,
  UIReinforceCardDetailSys = 4501,
  UIReinforceCardLvUp = 4502,
  UIReinforceCardPackShop = 4503,
  UIReinforceCardHandBook = 4504,
  UIReinforceCardSet = 4505,
  UIReinforceCardSave = 4506,
  UIReinforceCardSetSelect = 4507,
  UIReinforceCardDun = 4508,
  UIReinforceCardMain = 4509,
  CurrentChip4CardSet = 4510,
  UIReinforceCardDrawShow = 4511,
  UIReinforceCardStorage = 4512,
  UIReinforceCardFriendSup = 4513,
  UIReinforceReward = 4514,
  UIAnni24Interactive = 4515,
  ClosingList = 9996,
  Share = 9997,
  WaterMark = 9998,
  CADPAWarring = 9999
}
UIWindowGlobalConfig = {
  [UIWindowTypeID.UIReinforceCardSave] = {
    PrefabName = "UI_ReinforceCardSave",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Reinforce.UI.CardSave.UIReinforceCardSave")
  },
  [UIWindowTypeID.UIReinforceCardDetailFac] = {
    PrefabName = "UI_ReinforceCardDetailFac",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Reinforce.UI.FactorCard.Detail.UIReinforceCardDetailFac")
  },
  [UIWindowTypeID.UIReinforceCardDetailSys] = {
    PrefabName = "UI_ReinforceCardDetailSys",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Reinforce.UI.SystemCard.Detail.UIReinforceCardDetailSys")
  },
  [UIWindowTypeID.UIReinforceCardLvUp] = {
    PrefabName = "UI_ReinforceCardLvlUp",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Reinforce.UI.SystemCard.LvUp.UIReinforceCardSysLvUp")
  },
  [UIWindowTypeID.UIReinforceCardPackShop] = {
    PrefabName = "UI_ReinforceCardDraw",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Reinforce.UI.SystemCard.PackShop.UIReinforceCardPackShop")
  },
  [UIWindowTypeID.UIReinforceCardDrawShow] = {
    PrefabName = "UI_ReinforceCardDrawShow",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Reinforce.UI.SystemCard.PackShop.UIReinforceCardDrawShow")
  },
  [UIWindowTypeID.UIReinforceCardHandBook] = {
    PrefabName = "UI_ReinforceCardHandbook",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Reinforce.UI.SystemCard.HandBook.UIReinforceCardHandBook")
  },
  [UIWindowTypeID.UIReinforceCardSet] = {
    PrefabName = "UI_ReinforceCardSet",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Reinforce.UI.CardSet.UIReinforceCardSet")
  },
  [UIWindowTypeID.UIReinforceCardSetSelect] = {
    PrefabName = "UI_ReinforceCardSetSelect",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Reinforce.UI.CardSet.Select.UIRfCardSetSelect")
  },
  [UIWindowTypeID.UIReinforceCardDun] = {
    PrefabName = "UI_ReinforceCardDungeon",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Reinforce.UI.CardDun.UIReinforceCardDun")
  },
  [UIWindowTypeID.UIReinforceReward] = {
    PrefabName = "UI_ReinforceReward",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Reinforce.UI.CardDun.UIReinforceReward")
  },
  [UIWindowTypeID.UIReinforceCardMain] = {
    PrefabName = "UI_ReinforceCardMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Reinforce.UI.Main.UIReinforceCardMain")
  },
  [UIWindowTypeID.UIReinforceCardStorage] = {
    PrefabName = "UI_ReinforceCardStorage",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Reinforce.UI.FactorCard.UIRfCardFacStorage"),
    AnimaType = EUIAnimaType.FadeScaleDown
  },
  [UIWindowTypeID.UIReinforceCardFriendSup] = {
    PrefabName = "UI_ReinforceCardFriendSup",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Reinforce.UI.CardSet.FriendSupport.UIReinforceCardFriendSup")
  },
  [UIWindowTypeID.LuaTest] = {
    PrefabName = "UI_LuaTest",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Test.UILuaTest")
  },
  [UIWindowTypeID.Home] = {
    PrefabName = "UI_HomeMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Home.UI.UIHomeMain")
  },
  [UIWindowTypeID.HomeSide] = {
    PrefabName = "UI_HomeSide",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Home.UI.Side.UIHomeSide")
  },
  [UIWindowTypeID.ChatSystem] = {
    PrefabName = "UI_FriendChatMain",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ChatSystem.UI.UIChatSystemMain")
  },
  [UIWindowTypeID.NoticeMessagePush] = {
    PrefabName = "UI_NoticeMessagePush",
    LayoutLevel = EUILayoutLevel.LowTop,
    WindowClass = require("Game.Notice.UI.UINoticeMessagePush")
  },
  [UIWindowTypeID.TopStatus] = {
    PrefabName = "UI_TopStatus",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.TopStatus.UITopStatus"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.NavigationBar] = {
    PrefabName = "UI_NavigationBar",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.TopStatus.Navigation.UINavigationBar")
  },
  [UIWindowTypeID.OasisMain] = {
    PrefabName = "UI_OasisMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Oasis.UI.Main.UIOasisMain")
  },
  [UIWindowTypeID.OasisEditWindow] = {
    PrefabName = "UI_OasisEditor",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Oasis.UI.Editor.UIOasisEditor")
  },
  [UIWindowTypeID.USkySystem] = {
    PrefabName = "UI_USkySystem",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Oasis.UI.Sky.UIUSkySystem")
  },
  [UIWindowTypeID.BattleResult] = {
    PrefabName = "UI_EpBattleResult",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.BattleResult.UIBattleResult")
  },
  [UIWindowTypeID.ExplorationResult] = {
    PrefabName = "UI_ExplorationResult",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.BattleResult.UIExplorationResult")
  },
  [UIWindowTypeID.ExplorationResultSettlement] = {
    PrefabName = "UI_ResultSettlement",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.BattleResult.UIResultSettlement"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.HeroList] = {
    PrefabName = "UI_HeroList",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Hero.NewUI.NewUIHeroList"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1088,
    HideWinAuId = 1089
  },
  [UIWindowTypeID.HeroState] = {
    PrefabName = "UI_HeroState",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Hero.NewUI.State.UIHeroState"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.HeroLevelUp] = {
    PrefabName = "UI_HeroLevelUp",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Hero.NewUI.UpgradeLevel.UIHeroLevelUp"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.Login] = {
    PrefabName = "UI_Login",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Login.UILogin")
  },
  [UIWindowTypeID.LotteryWindow] = {
    PrefabName = "UI_Lottery",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Lottery.UI.UILottery"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.LotteryExchange] = {
    PrefabName = "UI_LotteryExchange",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Lottery.UI.UILotteryExchange")
  },
  [UIWindowTypeID.LotteryPoolDetail] = {
    PrefabName = "UI_LotteryGachaRate",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Lottery.UI.PoolDetail.UILotteryPoolDetail")
  },
  [UIWindowTypeID.LotterySelectPool] = {
    PrefabName = "UI_LotterySelectPool",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Lottery.UI.SelectPool.UILotterySelectPool")
  },
  [UIWindowTypeID.LotteryResult] = {
    PrefabName = "UI_LotteryResult",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Lottery.UI.Result.UILotteryResult")
  },
  [UIWindowTypeID.HeroLevelUpSuccess] = {
    PrefabName = "UI_HeroLevelUpSuccess",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Hero.NewUI.UpgradeLevel.UIHeroLevelUpSuccess")
  },
  [UIWindowTypeID.HeroStarUp] = {
    PrefabName = "UI_HeroStarUp",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Hero.NewUI.UpgradeStar.UIHeroStarUp"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.GetHero] = {
    PrefabName = "UI_GetHero",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.CommonUI.Hero.New.UIGetHero")
  },
  [UIWindowTypeID.GetHeroSkin] = {
    PrefabName = "UI_GetHeroSkin",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.CommonUI.Hero.New.UIGetHeroSkin")
  },
  [UIWindowTypeID.HeroSkillUpgrade] = {
    PrefabName = "UI_HeroSkillUpgrade",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Hero.NewUI.UpgradeSkill.UIHeroSkillUpgrade"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.Task] = {
    PrefabName = "UI_Task",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Task.NewUI.UITask"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.CommonReward] = {
    PrefabName = "UI_CommonReward",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.CommonUI.UICommonReward")
  },
  [UIWindowTypeID.AchievementSystem] = {
    PrefabName = "UI_AchievementSystem",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Achievement.UI.UIAchievementSystem"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1088
  },
  [UIWindowTypeID.BannerSpread] = {
    PrefabName = "UI_HomeAdvTvList",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Home.Banner.UIHomeBannerSpread")
  },
  [UIWindowTypeID.EpTreasureRoom] = {
    PrefabName = "UI_EpTreasureRoom",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Exploration.UI.TreasureRoom.UITreasureRoom"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.SelectChip] = {
    PrefabName = "UI_SelectChip",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Exploration.UI.SelectChip.UISelectChip"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.SelectChipSuit] = {
    PrefabName = "UI_SelectChipSuit",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.DailyDungeon.UI.SelectChipSuit.UISelectChipSuit"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.ThreeDSelectChip] = {
    PrefabName = "UI_3DSelectChip",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Exploration.UI.SelectChip.UISelectChip")
  },
  [UIWindowTypeID.Exploration] = {
    PrefabName = "UI_Exploration",
    LayoutLevel = EUILayoutLevel.Bottom,
    WindowClass = require("Game.Exploration.UI.UIExploration")
  },
  [UIWindowTypeID.EpEventRoom] = {
    PrefabName = "UI_EpEventRoom",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Exploration.UI.EventRoom.UIEpEventRoom"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.EpUpgradeRoom] = {
    PrefabName = "UI_EpChipLevelUp",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Exploration.UI.UpgradeRoom.UIEpUpgradeRoom"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.EpChipDiscard] = {
    PrefabName = "UI_EpChipDiscard",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Exploration.UI.ChipDiscard.UIEpChipDiscardRoom"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.EpChallengeDiscard] = {
    PrefabName = "UI_EpChipDiscard",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Exploration.UI.ChipDiscard.UIEpChallengeDiscard"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.EpSelectDebuff] = {
    PrefabName = "UI_EpDebuffSelect",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Exploration.UI.SelectDebuff.UIEpSelectDebuff"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.EpResidentStore] = {
    PrefabName = "UI_EpResidentStore",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Exploration.UI.ResidentStore.UIEpResidentStore"),
    AnimaType = EUIAnimaType.FadeScaleDown
  },
  [UIWindowTypeID.BattleSkillModule] = {
    PrefabName = "UI_BattleSkillModule",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Battle.UI.SkillModule.UIBattleSkillModule")
  },
  [UIWindowTypeID.UltimateSkillShow] = {
    PrefabName = "UI_UltimateSkillShow",
    LayoutLevel = EUILayoutLevel.Top,
    WindowClass = require("Game.Battle.UI.SkillModule.UIUltrSkillHeroShow")
  },
  [UIWindowTypeID.Battle] = {
    PrefabName = "UI_Battle",
    LayoutLevel = EUILayoutLevel.Bottom,
    WindowClass = require("Game.Battle.UI.UIBattle"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.BattlePause] = {
    PrefabName = "UI_BattlePause",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Battle.UI.UIBattlePause"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.BattleEnemyDetail] = {
    PrefabName = "UI_BattleEnemyDetail",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Battle.UI.UIBattleEnemyDetail"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.Mail] = {
    PrefabName = "UI_Mail",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Mail.UI.New_UIMail"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.Guide] = {
    PrefabName = "UI_Guide",
    LayoutLevel = EUILayoutLevel.Top,
    WindowClass = require("Game.Guide.UIGuide")
  },
  [UIWindowTypeID.QuickBuy] = {
    PrefabName = "UI_QuickPurchaseBox",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.QuickPurchaseBox.New_UIQuickPurchaseBox")
  },
  [UIWindowTypeID.QuickBuyKey] = {
    PrefabName = "UI_QuickPurchaseKey",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.QuickPurchaseBox.PurchaseKey.UIQuickPurchaseKey")
  },
  [UIWindowTypeID.FloatText] = {
    PrefabName = "UI_FloatText",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.CommonUI.FloatText.UIFloatText")
  },
  [UIWindowTypeID.ClickContinue] = {
    PrefabName = "UI_ClickContinue",
    LayoutLevel = EUILayoutLevel.Top,
    WindowClass = require("Game.CommonUI.ClickContinue.UIClickContinue")
  },
  [UIWindowTypeID.CommonMask] = {
    PrefabName = "UI_CommonMask",
    LayoutLevel = EUILayoutLevel.Top,
    WindowClass = require("Game.CommonUI.UICommonMask")
  },
  [UIWindowTypeID.VowMask] = {
    PrefabName = "UI_VowMask",
    LayoutLevel = EUILayoutLevel.Top,
    WindowClass = require("Game.VowSystem.UI.UIVowMask")
  },
  [UIWindowTypeID.GlobalItemDetail] = {
    PrefabName = "UI_CommonItemDetail",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.CommonUI.ItemDetail.UICommonItemDetailWin"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.RewardPreview] = {
    PrefabName = "UI_CommonRewardPreview",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.CommonUI.ItemDetail.UIRewardPreview")
  },
  [UIWindowTypeID.Ath] = {
    PrefabName = "UI_ATHMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Arithmetic.UIATHMain"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.AthEfficiency] = {
    PrefabName = "UI_ATHEfficiency",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Arithmetic.AthEfficiency.UIAthEfficiency")
  },
  [UIWindowTypeID.CommonUpgradeTips] = {
    PrefabName = "UI_CommonUpgradeTips",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.CommonUI.Upgrade.UICommonUpgradeTips")
  },
  [UIWindowTypeID.AthItemDetail] = {
    PrefabName = "UI_ATHDetail",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Arithmetic.AthDetail.UIAthItemDetail")
  },
  [UIWindowTypeID.AthReplaceHero] = {
    PrefabName = "UI_ATHReplaceHero",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Arithmetic.AthReplaceHero.UIAthReplaceHero"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.AthDecompose] = {
    PrefabName = "UI_ATHDecompose",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Arithmetic.Decompose.UIAthDecompose")
  },
  [UIWindowTypeID.AthRefactor] = {
    PrefabName = "UI_ATHRefactor",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Arithmetic.Refactor.UIAthRefactor")
  },
  [UIWindowTypeID.AthRefactorSuccess] = {
    PrefabName = "UI_ATHRefactorSuccess",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Arithmetic.Refactor.UIAthRefactorSuccess")
  },
  [UIWindowTypeID.AthRefactorSuccessExtra] = {
    PrefabName = "UI_ATHRefactorSuccessExtra",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Arithmetic.Refactor.UIAthRefactorSuccess")
  },
  [UIWindowTypeID.AthSignMain] = {
    PrefabName = "UI_ATHSignMain",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Arithmetic.Sign.UIAthSignMain")
  },
  [UIWindowTypeID.AthRefactorConfirm] = {
    PrefabName = "UI_ATHRefactorConfirm",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Arithmetic.Refactor.Confirm.UIAthRefactorConfirm")
  },
  [UIWindowTypeID.AthItemDetailFloat] = {
    PrefabName = "UI_ATHDetailFloat",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Arithmetic.AthDetail.UIAthDetailFloat")
  },
  [UIWindowTypeID.ChipDetailFloat] = {
    PrefabName = "UIChipDetailFloat",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.CommonUI.Chip.UIChipDetailFloat")
  },
  [UIWindowTypeID.Setting] = {
    PrefabName = "UI_Setting",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Setting.UISetting"),
    AnimaType = EUIAnimaType.Fade,
    ShowWinAuId = 1088,
    HideWinAuId = 1089
  },
  [UIWindowTypeID.SettingGraph] = {
    PrefabName = "UI_SettingGraph",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Setting.UISettingGraph")
  },
  [UIWindowTypeID.SettingDescribe] = {
    PrefabName = "UI_SettingDescribe",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Setting.UISettingDescribe")
  },
  [UIWindowTypeID.CommonRename] = {
    PrefabName = "UI_CommonRename",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CommonUI.Rename.UICommonRename")
  },
  [UIWindowTypeID.UserFreined] = {
    PrefabName = "UI_UserFriends",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Friend.UI.UIUserFriend"),
    ShowWinAuId = 1088,
    HideWinAuId = 1089,
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.UserFreinedSetAlias] = {
    PrefabName = "UI_SetFriendAlias",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Friend.UI.UISetFriendAlias")
  },
  [UIWindowTypeID.DormInput] = {
    PrefabName = "UI_DormInput",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Dorm.UI.UIDormInput")
  },
  [UIWindowTypeID.DormInteract] = {
    PrefabName = "UI_DormInteract",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Dorm.UI.Interact.UIDormInteract")
  },
  [UIWindowTypeID.DormMain] = {
    PrefabName = "UI_DormMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Dorm.DUI.UIDormMain")
  },
  [UIWindowTypeID.DormRoom] = {
    PrefabName = "UI_DormRoom",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Dorm.DUI.Room.UIDormRoom")
  },
  [UIWindowTypeID.DormCheckIn] = {
    PrefabName = "UI_DormCheckIn",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Dorm.DUI.CheckIn.UIDormCheckIn"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1066
  },
  [UIWindowTypeID.DormReplaceHero] = {
    PrefabName = "UI_DormReplaceHero",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Dorm.DUI.CheckIn.UIDormReplaceHero")
  },
  [UIWindowTypeID.DormComfort] = {
    PrefabName = "UI_DormComfort",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Dorm.DUI.Comfort.UIDormComfort"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1066
  },
  [UIWindowTypeID.DormVisit] = {
    PrefabName = "UI_DormVisitWindow",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Dorm.DUI.Visit.UIDormVisit"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1066
  },
  [UIWindowTypeID.DormItemDetail] = {
    PrefabName = "UI_FurnitureDetailsWindow",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Dorm.DUI.Detail.UIDormDetail"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.FriendShip] = {
    PrefabName = "UI_FriendshipSkillUpgrade",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Friendship.NewFriendshipUI.UIFriendshipSkillUpgrade"),
    AnimaType = EUIAnimaType.Fade,
    ShowWinAuId = 1066
  },
  [UIWindowTypeID.Avg] = {
    PrefabName = "UI_AVGSystem",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Avg.UI.UIAVGSystem")
  },
  [UIWindowTypeID.AvgSkip] = {
    PrefabName = "UI_AvgSkip",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Avg.UI.AvgSkip.UIAvgSkip")
  },
  [UIWindowTypeID.AvgNounDes] = {
    PrefabName = "UI_AvgNounDes",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Avg.UI.NounDes.UIAvgNounDes")
  },
  [UIWindowTypeID.SteinsGateAvg] = {
    PrefabName = "UI_SteinsGateAvg",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Avg.SteinsGate.UI.UISteinsGateAvg")
  },
  [UIWindowTypeID.FriendShipHeroFoster] = {
    PrefabName = "UI_HeroFoster_Legacy",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Friendship.Foster.UIFoster")
  },
  [UIWindowTypeID.FriendShipPlotDungeon] = {
    PrefabName = "UI_HeroFriendshipDungeon",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Friendship.PlotDungeon.UIPlotDungeon"),
    ShowWinAuId = 1088
  },
  [UIWindowTypeID.SectorLevel] = {
    PrefabName = "UI_SectorLevel",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Sector.SectorLevel.UISectorLevel"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.SectorUnlockMovie] = {
    PrefabName = "UI_SectorPlayMovie",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Sector.UISector.UISectorUnlockMovie")
  },
  [UIWindowTypeID.MoviePlayer] = {
    PrefabName = "UI_MoviePlayer",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.ActivityLobby.UI.Main.UIMoviePlayer")
  },
  [UIWindowTypeID.SectorLevelDetail] = {
    PrefabName = "UI_SectorLevelDetail",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Sector.SectorLevelDetail.UISectorLevelDetail")
  },
  [UIWindowTypeID.SectorLevelDetailSteinsGate] = {
    PrefabName = "UI_SteinsGateSectorLevelDetail",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Sector.SectorLevelDetail.UISectorLevelDetail")
  },
  [UIWindowTypeID.SectorStoryReview] = {
    PrefabName = "UI_SectorStoryReview",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Sector.SectorLevelDetail.StoryReview.UISectorStoryReview")
  },
  [UIWindowTypeID.SectorEntrance] = {
    PrefabName = "UI_SectorEntrance",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Sector.UISector.UISectorEntrance.UISectorEntrance")
  },
  [UIWindowTypeID.SectorTask] = {
    PrefabName = "UI_SectorTask",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Sector.SectorTask.UISectorTask"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1088,
    HideWinAuId = 1089
  },
  [UIWindowTypeID.OverClock] = {
    PrefabName = "UI_Overclock",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Exploration.UI.Overclock.UIEpOverclock"),
    AnimaType = EUIAnimaType.Fade,
    ShowWinAuId = 1088,
    HideWinAuId = 1089
  },
  [UIWindowTypeID.CSTMain] = {
    PrefabName = "UI_CSTMain",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CommanderSkill.UI.UICSTMain"),
    AnimaType = EUIAnimaType.Fade,
    ShowWinAuId = 1088
  },
  [UIWindowTypeID.DungeonResult] = {
    PrefabName = "UI_BattleResult",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.BattleDungeon.UI.UIDungeonResult")
  },
  [UIWindowTypeID.DungeonFailureResult] = {
    PrefabName = "UI_TempBattleFailureResult",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.BattleDungeon.UI.UIDungeonFailureResult_Temp")
  },
  [UIWindowTypeID.DungeonWaveTip] = {
    PrefabName = "UI_DungeonWaveTip",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.BattleDungeon.UI.UIDungeonWaveTip")
  },
  [UIWindowTypeID.BattleResultExtra] = {
    PrefabName = "UI_BattleResultExtra",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.BattleDungeon.UI.UIBattleResultExtra")
  },
  [UIWindowTypeID.Formation] = {
    PrefabName = "UI_Formation",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Formation.UI.2DFormation.UIFormation"),
    AnimaType = EUIAnimaType.Fade,
    ShowWinAuId = 1088
  },
  [UIWindowTypeID.FormationQuick] = {
    PrefabName = "UI_FormationQuick",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Formation.UI.QuickFmt.UIFormationQuick"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.FormationRankPreview] = {
    PrefabName = "UI_FormationRankPreview",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Formation.UI.Rank.UIFormationRankPreview")
  },
  [UIWindowTypeID.CampBond] = {
    PrefabName = "UI_CampBond",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Formation.UI.CampBond.UICampFetter")
  },
  [UIWindowTypeID.DungeonStateInfo] = {
    PrefabName = "UI_DungeonStateInfo",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CommonUI.DungeonState.UIDungeonStateInfo")
  },
  [UIWindowTypeID.DungeonInfoDetail] = {
    PrefabName = "UI_DungeonInfoDetail",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CommonUI.DungeonState.Info.UIDungeonInfoDetail"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.EpStoreRoom] = {
    PrefabName = "UI_EpStoreRoom",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Exploration.UI.StoreRoom.UIEpStoreRoom"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.FloatingFrame] = {
    PrefabName = "UI_FloatingFrame",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.CommonUI.FloatWin.UIFloatFrame")
  },
  [UIWindowTypeID.Loading] = {
    PrefabName = "UI_Loading",
    LayoutLevel = EUILayoutLevel.Top,
    WindowClass = require("Game.Loading.UILoading")
  },
  [UIWindowTypeID.BattleDPS] = {
    PrefabName = "UI_BattleDPS",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Battle.UI.UIBattleDPS")
  },
  [UIWindowTypeID.EpBuffShow] = {
    PrefabName = "UI_EpBuffShow",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Exploration.UI.EpBuffShow.UIEpBuffShow")
  },
  [UIWindowTypeID.GuidePicture] = {
    PrefabName = "UI_GuidePicture",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Guide.GuidePicture.UIGuidePicture"),
    AnimaType = EUIAnimaType.FadeScaleTopLeft
  },
  [UIWindowTypeID.GuidePicture_0623New] = {
    PrefabName = "UI_GuidePicture_0623New",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Guide.GuidePicture.UIGuidePicture_0623New"),
    AnimaType = EUIAnimaType.FadeScaleTopLeft
  },
  [UIWindowTypeID.MessageSide] = {
    PrefabName = "UI_MessageSide",
    LayoutLevel = EUILayoutLevel.LowTop,
    WindowClass = require("Game.Message.Side.UIMessageSide")
  },
  [UIWindowTypeID.MessageSideAddFriend] = {
    PrefabName = "UI_MessageSideAddFriend",
    LayoutLevel = EUILayoutLevel.LowTop,
    WindowClass = require("Game.Friend.SideAddFriend.UISideAddFriend")
  },
  [UIWindowTypeID.ViewChips] = {
    PrefabName = "UI_ViewChips",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.ViewChips.UIViewChips"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1088
  },
  [UIWindowTypeID.ViewItems] = {
    PrefabName = "UI_ViewItems",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.ViewItems.UIViewItems")
  },
  [UIWindowTypeID.MaterialDungeon] = {
    PrefabName = "UI_MaterialDungeon",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.MaterialDungeon.UI.UIMaterialDungeon")
  },
  [UIWindowTypeID.BattleEffectGirdInfo] = {
    PrefabName = "UI_BattleEffectGirdInfo",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Battle.UI.Grid.UIBattleEffectGirdInfo")
  },
  [UIWindowTypeID.SelectBoardHero] = {
    PrefabName = "UI_HeroList",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Home.UI.UISelectBoardHero"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.UserNameCreate] = {
    PrefabName = "UI_UserNameCreate",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.User.UIUserNameCreate"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.ResultSkada] = {
    PrefabName = "UI_ResultSkada",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.BattleResult.SkadaSystem.UIResultSkada"),
    AnimaType = EUIAnimaType.Fade,
    ShowWinAuId = 1066
  },
  [UIWindowTypeID.UserInfo] = {
    PrefabName = "UI_UserInfo",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.User.UIUserInfo"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.CommonUserInfo] = {
    PrefabName = "UI_UserInfoView",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.User.CommonUser.UIUserInfoView"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.UserInfoSelectSupport] = {
    PrefabName = "UI_UserInfoSupport",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.User.SelectSupport.UISelectSupportHero"),
    ShowWinAuId = 1066
  },
  [UIWindowTypeID.SelectSupportList] = {
    PrefabName = "UI_SupportHeroList",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Formation.UI.SupportHeroList.UISupportHeroList"),
    ShowWinAuId = 1088,
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.UserInfoDialog] = {
    PrefabName = "UI_UserInfoDialog",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.User.UIUserInfoDialog")
  },
  [UIWindowTypeID.EpAutoMode] = {
    PrefabName = "UI_EpAutoMode",
    LayoutLevel = EUILayoutLevel.Top,
    WindowClass = require("Game.Exploration.UI.AutoMode.UIEpAutoMode")
  },
  [UIWindowTypeID.MessageCommon] = {
    PrefabName = "UI_MessageItemBox",
    LayoutLevel = EUILayoutLevel.LowTop,
    WindowClass = require("Game.CommonUI.MessageCommon.UIMessageCommon")
  },
  [UIWindowTypeID.MessageBox] = {
    PrefabName = "UI_MessageBox",
    LayoutLevel = EUILayoutLevel.LowTop,
    WindowClass = require("Game.CommonUI.MessageCommon.UIMessageBox")
  },
  [UIWindowTypeID.ATHDungeon] = {
    PrefabName = "UI_ATHDungeon",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ATHDungeon.UI.UIATHDungeon")
  },
  [UIWindowTypeID.Factory] = {
    PrefabName = "UI_Factory",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Factory.UI.UIFactory"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.FactoryQuickProduce] = {
    PrefabName = "UI_FactoryQuickProduce",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Factory.UI.QuickProduce.UIFactoryQuickProduce")
  },
  [UIWindowTypeID.FactoryProduceLine] = {
    PrefabName = "UI_FactoryProductionLine",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Factory.UI.ProduceLine.UIFactoryProduceLine")
  },
  [UIWindowTypeID.LotteryShow] = {
    PrefabName = "UI_LotteryShow",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Lottery.UI.UILotteryShow")
  },
  [UIWindowTypeID.LotterySelectHero] = {
    PrefabName = "UI_LotterySelectHero",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Lottery.UI.SelectHero.UILotterySelectHero")
  },
  [UIWindowTypeID.LotterySpecialSelect] = {
    PrefabName = "UI_LtrHeroSelect",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Lottery.UI.SpecialSelectHero.Win.UILtrSpecialSelectHeroWin")
  },
  [UIWindowTypeID.BattleCrazyMode] = {
    PrefabName = "UI_BattleCrazyMode",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.BattleCrazyMode.UI.UIBattleCrazyMode")
  },
  [UIWindowTypeID.CommonInfo] = {
    PrefabName = "UI_CommonInfo",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.CommonUI.CommonInfo.UICommonInfo"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1066
  },
  [UIWindowTypeID.CommonTextFrame] = {
    PrefabName = "UI_CommonTextFrame",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.CommonUI.UICommonTextFrame")
  },
  [UIWindowTypeID.EpSupportRoom] = {
    PrefabName = "UI_EpSupportRoom",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Exploration.UI.SupportRoom.UIEpSurpportRoom"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.DailyChallenge] = {
    PrefabName = "UI_PeriodicChallenge",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.PeriodicChallenge.UI.UIPeriodicChallenge"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.EpRewardBag] = {
    PrefabName = "UI_EpRewardBag",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Exploration.UI.EpRewardBag.UIEpRewardBag"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.HeroPowerUpSuccess] = {
    PrefabName = "UI_HeroPowerUpSuccess",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Hero.NewUI.UIHeroPowerUpSuccess")
  },
  [UIWindowTypeID.HeroStarUpSuccess] = {
    PrefabName = "UI_HeroStarUpSuccess",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Hero.NewUI.UpgradeStar.UIStarUpSuccess"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.RecommeFormation] = {
    PrefabName = "UI_RecommeFormation",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Formation.UI.RecommeFormation.UIRecommeFormation"),
    ShowWinAuId = 1133
  },
  [UIWindowTypeID.RecommeFormationNew] = {
    PrefabName = "UI_RecommeFormation_New",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Formation.UI.RecommeFormation.UIRecommeFormationNew"),
    ShowWinAuId = 1133
  },
  [UIWindowTypeID.HeroPotential] = {
    PrefabName = "UI_HeroPotential",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Hero.NewUI.UpgradePotential.UIHeroPotential"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1088
  },
  [UIWindowTypeID.StrategyOverview] = {
    PrefabName = "UI_StrategyOverview",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.StrategyOverview.UI.UIStrategyOverview"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.RichIntro] = {
    PrefabName = "UI_RichIntro",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.CommonUI.RichIntro.UIRichIntro")
  },
  [UIWindowTypeID.ActivityStarUp] = {
    PrefabName = "UI_ActivityStarUp",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityStarUp.UI.UIActivityStarUp"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.ChipDisplace] = {
    PrefabName = "UI_EpChipDisplace",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Exploration.UI.ChipDisplace.UIChipDisplace")
  },
  [UIWindowTypeID.HeroPotentialSuccess] = {
    PrefabName = "UI_HeroPotentialSuccess",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Hero.NewUI.UpgradePotential.UIHeroPotentialSuccess")
  },
  [UIWindowTypeID.EventBattlePass] = {
    PrefabName = "UI_EventBattlePass",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.BattlePass.UI.UIEventBattlePass")
  },
  [UIWindowTypeID.EventBattlePassV2] = {
    PrefabName = "UI_EventBattlePassV2",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.BattlePass.UI.UIEventBattlePassV2")
  },
  [UIWindowTypeID.EventBattlePassPurchase] = {
    PrefabName = "UI_EventBattlePassPurchase",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.BattlePass.UI.UIEventBattlePassPurchase")
  },
  [UIWindowTypeID.EventBattlePassBuyLevel] = {
    PrefabName = "UI_EventBattlePassBuyLevel",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.BattlePass.UI.UIEventBattlePassBuyLevel")
  },
  [UIWindowTypeID.EventBattlePassRewardPreview] = {
    PrefabName = "UI_EventBattlePassRewardPreview",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.BattlePass.UI.UIEventBattlePassRewardPreview")
  },
  [UIWindowTypeID.BpSpReward] = {
    PrefabName = "UI_BpSpReward",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.BattlePass.UI.UIBpSpReward")
  },
  [UIWindowTypeID.EventGrowBag] = {
    PrefabName = "UI_EventGrowBag",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.EventGrowBag.UI.UIEventGrowBag"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.EventSignin] = {
    PrefabName = "UI_EventSigninHolder",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.DailySignIn.UI.UIEventSignInHolder")
  },
  [UIWindowTypeID.EventWeChat] = {
    PrefabName = "UI_EventWeChat",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.EventNoviceSign.UI.UIEventWeChat")
  },
  [UIWindowTypeID.HeroSkin] = {
    PrefabName = "UI_HeroSkin",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Skin.UI.UIHeroSkin"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.HeroSkinPreView] = {
    PrefabName = "UI_HeroStarUpSkinPreview",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Skin.UI.Preview.UIPreviewSkin"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.HeroTask] = {
    PrefabName = "UI_HeroTask",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Hero.NewUI.HeroTask.UIHeroTask"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.HeroInfomation] = {
    PrefabName = "UI_HeroInformation",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Hero.NewUI.HeroInfo.UIHeroInformation"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.HeroBackOff] = {
    PrefabName = "UI_HeroBackOff",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Hero.BackOff.UIHeroBackOff")
  },
  [UIWindowTypeID.ShopMain] = {
    PrefabName = "UI_ShopMain",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Shop.UI.UIShop"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1088
  },
  [UIWindowTypeID.HeroChipOverflowWindow] = {
    PrefabName = "UI_HeroChipOverflowWindow",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.ShopMain.HeroFragConvert.UIHeroFragConvert")
  },
  [UIWindowTypeID.PeriodicBattleBossResult] = {
    PrefabName = "UI_PeriodicBattleBossResult",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.PeriodicChallenge.UI.BattleBossResult.UIPeriodicBattleBossResult"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.PeriodicDebuffSelect] = {
    PrefabName = "UI_PeriodicDebuffSelect",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.PeriodicChallenge.UI.UIPeriodicDebuffSelect"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.PeriodicEnvBuffSelect] = {
    PrefabName = "UI_PeriodicDebuffSelectNew",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.PeriodicChallengeNew.UI.UIPeriodicDebuffSelectNew"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.WeeklyChallengeRank] = {
    PrefabName = "UI_WeeklyChallengeRank",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UIWeeklyChallengeRank")
  },
  [UIWindowTypeID.WCDebuffResult] = {
    PrefabName = "UI_PeriodicDebuffSelectResult",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.PeriodicChallenge.UI.WeeklyChallengeDebuffResult.UIWCDebuffResult")
  },
  [UIWindowTypeID.EpRewardPreview] = {
    PrefabName = "UI_EpRewardPreview",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Exploration.UI.EpRewardPreview.UIEpRewardPreview"),
    AnimaType = EUIAnimaType.Fade,
    ShowWinAuId = 1066
  },
  [UIWindowTypeID.CurrentChip] = {
    PrefabName = "UI_CurrentChip",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Exploration.UI.CurrentChip.UICurrentChip"),
    AnimaType = EUIAnimaType.Fade,
    ShowWinAuId = 1088
  },
  [UIWindowTypeID.CurrentChip4CardSet] = {
    PrefabName = "UI_CurrentChip",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Reinforce.UI.CardSet.CurrentChip.UICurrentChip4CardSet"),
    AnimaType = EUIAnimaType.Fade,
    ShowWinAuId = 1088
  },
  [UIWindowTypeID.EpChipSuit] = {
    PrefabName = "UI_EpChipSuit",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Exploration.UI.ChipSuit.UIEpChipSuit")
  },
  [UIWindowTypeID.EpMonsterLevelUp] = {
    PrefabName = "UI_EpMonsterLevelUp",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Exploration.UI.MonsterLevel.UIEpMonsterLevelUp"),
    ShowWinAuId = 1130
  },
  [UIWindowTypeID.ActivityFrameMain] = {
    PrefabName = "UI_EventMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityFrame.UI.UIActivityFrameMain")
  },
  [UIWindowTypeID.EventNoviceSign] = {
    PrefabName = "UI_EventNoviceSign",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.EventNoviceSign.UI.UIEventNoviceSign")
  },
  [UIWindowTypeID.EventFestivalSignIn] = {
    PrefabName = "UI_EventFestivalSignIn",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.EventFestivalSignIn.UI.UIEventFestivalSignIn")
  },
  [UIWindowTypeID.BattleFail] = {
    PrefabName = "UI_BattleFail",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Exploration.UI.BattleFail.UIBattleFail")
  },
  [UIWindowTypeID.Warehouse] = {
    PrefabName = "UI_Warehouse",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Warehouse.UIWarehouse"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1088
  },
  [UIWindowTypeID.CommonUseGift] = {
    PrefabName = "UI_CommonUseGift",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.CommonUI.UseGift.UICommonUseGift")
  },
  [UIWindowTypeID.CADPAWarring] = {
    PrefabName = "UI_CADPAWarring",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CADPA.UICADPAWarringWin")
  },
  [UIWindowTypeID.EpTask] = {
    PrefabName = "UI_EpTask",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Exploration.UI.EpTask.UIEpTask")
  },
  [UIWindowTypeID.ActivityStarUpRewardPreview] = {
    PrefabName = "UI_ActivityStarUpRewardPreview",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityStarUp.UI.UIActivityStarUpPre")
  },
  [UIWindowTypeID.GameNotice] = {
    PrefabName = "UI_GameNotice",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.GameNotice.UI.UIGameNotice"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.WeeklyChallengeTask] = {
    PrefabName = "UI_WeeklyChallengeTask",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.WeeklyChallenge.UIWeeklyChallengeTask"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.TDBattle] = {
    PrefabName = "UI_TDBattle",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.BattleTowerDefence.UI.UITDBattle")
  },
  [UIWindowTypeID.TDCharactorInfo] = {
    PrefabName = "UI_TDCharacterInfo",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.BattleTowerDefence.UI.UITDCharactorInfo")
  },
  [UIWindowTypeID.SupportHeroState] = {
    PrefabName = "UI_SupportHeroState",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Formation.UI.SupportHeroList.UISupportHeroState"),
    ShowWinAuId = 1063
  },
  [UIWindowTypeID.HeroInfoState] = {
    PrefabName = "UI_SupportHeroState",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Lottery.UI.HeroInfo.UIHeroInfoState"),
    ShowWinAuId = 1063
  },
  [UIWindowTypeID.DailyDungeonMain] = {
    PrefabName = "UI_DailyDungeonMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.DailyDungeon.UI.LevelSelect.UIDailyDungeonMain"),
    ShowWinAuId = 1088,
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.DailyDungeonLevel] = {
    PrefabName = "UI_DailyDungeonLevel",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.DailyDungeon.UI.LevelSelect.Level.UIDailyDungeonLevel"),
    ShowWinAuId = 1066
  },
  [UIWindowTypeID.DailyDungeonComplete] = {
    PrefabName = "UI_DailyDungeonComplete",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.DailyDungeon.UI.LevelSelect.CompleteDungeon.UIDailyDungeonComplete")
  },
  [UIWindowTypeID.MovieBlack] = {
    PrefabName = "UI_MovieBlack",
    LayoutLevel = EUILayoutLevel.Top,
    WindowClass = require("Game.Common.UIMovieBlack")
  },
  [UIWindowTypeID.EpBuffDesc] = {
    PrefabName = "UI_EpBuffDesc",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Exploration.UI.EpBuffDesc.UIEpBuffDesc"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.ShowCharacter] = {
    PrefabName = "UI_ShowCharacter",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ShowCharacter.UI.UIShowCharacter")
  },
  [UIWindowTypeID.ShowCharacterSkin] = {
    PrefabName = "UI_ShowCharacterSkin",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ShowCharacterSkin.UI.UIShowCharacterSkin")
  },
  [UIWindowTypeID.BattleAutoMode] = {
    PrefabName = "UI_BattleAutoMode",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.BattleDungeon.UI.BattleDungeonAutoMode.UIBattleDungeonAutoMode")
  },
  [UIWindowTypeID.SceneChangesMask] = {
    PrefabName = "UI_SceneChangesMask",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.CommonUI.SceneChanges.UISceneChangesMask")
  },
  [UIWindowTypeID.DormTransAnima] = {
    PrefabName = "UI_DormTransAnima",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Dorm.UI.UIDormTransAnima"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.EventWeChatInformation] = {
    PrefabName = "UI_EventWeChatInformation",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.EventNoviceSign.UI.UIEventWeChatInformation")
  },
  [UIWindowTypeID.EventWeChatViewQRCode] = {
    PrefabName = "UI_EventWeChatViewQRCode",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.EventNoviceSign.UI.UIEventWeChatViewQRCode")
  },
  [UIWindowTypeID.ActivityLimitTask] = {
    PrefabName = "UI_ActivityLimitTask",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityLimitTask.UI.UIActivityLimitTask")
  },
  [UIWindowTypeID.ActivityWinterTech] = {
    PrefabName = "UI_Win21StrategyOverview",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivitySectorII.Tech.UI.UIWinterActivityTech"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.ActivityWinterDungeon] = {
    PrefabName = "UI_Win21DungeonLevel",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySectorII.Dungeon.UI.UIWin21DungeonLevel"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1154
  },
  [UIWindowTypeID.ActivityWinterMainMap] = {
    PrefabName = "UI_Win21SectorLevel",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySectorII.MainMap.UI.UIWinterActivityMainMap"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1153
  },
  [UIWindowTypeID.Win21SectorBar] = {
    PrefabName = "UI_Win21SectorBar",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySectorII.MainMap.UI.UIWin21SectorBar"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.Win21Shop] = {
    PrefabName = "UI_Win21Shop",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Shop.Activity.UIWin21Shop"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.GiftPageDetail] = {
    PrefabName = "UI_GiftPageDetail",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.QuickPurchaseBox.UIGiftPageDetail")
  },
  [UIWindowTypeID.CommonSelectGift] = {
    PrefabName = "UI_CommonGiftSelect",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.CommonUI.GiftSelect.UICommonGiftSelect")
  },
  [UIWindowTypeID.TDProcessView] = {
    PrefabName = "UI_TDProcessView",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.BattleTowerDefence.UI.UITDProcessView")
  },
  [UIWindowTypeID.ActSum21Exchange] = {
    PrefabName = "UI_ActSum21Exchange",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivitySummer.UI.ActSum21Exchange.UIActSum21Exchange"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.ActSum21ExchangeResult] = {
    PrefabName = "UI_ActSum21ExchangeResult",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.ActivitySummer.UI.ActSum21Exchange.Result.UIActSum21ExchangeResult"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1136
  },
  [UIWindowTypeID.ActSummer] = {
    PrefabName = "UI_ActSum21",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySummer.UI.UIActSummer"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.ActSummerLvSwitch] = {
    PrefabName = "UI_ActSum21LvSwitch",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySummer.UI.UIActSummerLvSwitch"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.CommonActivityLogin] = {
    PrefabName = "UI_CommonActivityLogin",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityFrame.UI.UICommonActivityLogin")
  },
  [UIWindowTypeID.CharacterDungeon] = {
    PrefabName = "UI_CharDun",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityHeroGrow.UI.UICharacterDungeon"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.CharacterDungeonShop] = {
    PrefabName = "UI_CharDunShop",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Shop.CharacterDungeon.UICharacterDungeonShop"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.FmtChallengeInfo] = {
    PrefabName = "UI_FmtChallengeInfo",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.StageChallenge.UI.ChallengeInfo.UIFmtChallengeInfo"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.AniModeChange] = {
    PrefabName = "UI_AniModeChange",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.CommonUI.AniModeChange.UIAniModeChange")
  },
  [UIWindowTypeID.WaterMark] = {
    PrefabName = "UI_WaterMark",
    LayoutLevel = EUILayoutLevel.Max,
    WindowClass = require("Game.CommonUI.WaterMark.UIWaterMark")
  },
  [UIWindowTypeID.Share] = {
    PrefabName = "UI_Share",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Share.UI.Main.UIShare")
  },
  [UIWindowTypeID.FlappyBird] = {
    PrefabName = "UI_FlappyBirdMain",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.TinyGames.FlappyBird.UI.UIFlappyBird")
  },
  [UIWindowTypeID.FlappyBirdRanking] = {
    PrefabName = "UI_FlappyBirdRanking",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.TinyGames.FlappyBird.UI.UIFlappyRanking"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.WhiteDay] = {
    PrefabName = "UI_WhiteDay",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityWhiteDay.UI.UIWhiteDay")
  },
  [UIWindowTypeID.WhiteDayLine] = {
    PrefabName = "UI_WhiteDayLine",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityWhiteDay.UI.Line.UIWhiteDayLine")
  },
  [UIWindowTypeID.WhiteDayAccOrder] = {
    PrefabName = "UI_WhiteDayAccOrder",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityWhiteDay.UI.Acc.UIWhiteDayAccOrder")
  },
  [UIWindowTypeID.WhiteDayFactoryLevel] = {
    PrefabName = "UI_WhiteDayLvInfoView",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityWhiteDay.UI.FactoryLevel.UIWhiteDayFactoryLevel"),
    ShowWinAuId = 1203
  },
  [UIWindowTypeID.WhiteDayFactoryLevelUp] = {
    PrefabName = "UI_WhiteDayLvUp",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityWhiteDay.UI.FactoryLevelUp.UIWhiteDayFactoryLevelUp")
  },
  [UIWindowTypeID.WhiteDayHeroList] = {
    PrefabName = "UI_WhiteDayHeroList",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.ActivityWhiteDay.UI.WDHeroList.UIWhiteDayHeroList")
  },
  [UIWindowTypeID.WhiteDayAlbum] = {
    PrefabName = "UI_WhiteDayAlbum",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.ActivityWhiteDay.UI.Album.UIWhiteDayAlbum")
  },
  [UIWindowTypeID.WhiteDayHistoryAlbum] = {
    PrefabName = "UI_WhiteDayAlbum",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityWhiteDay.UI.Album.UIWhiteDayHistoryAlbum")
  },
  [UIWindowTypeID.AprilFool] = {
    PrefabName = "UI_AprilFoolMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityRefreshDun.UI.UIAprilFoolMain")
  },
  [UIWindowTypeID.ActBondMain] = {
    PrefabName = "UI_BondMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityBond.UI.UIActBond")
  },
  [UIWindowTypeID.ActBondDunSelect] = {
    PrefabName = "UI_BondDunSelect",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityBond.UI.DunSelect.UIActBondDunSelect")
  },
  [UIWindowTypeID.ActBondDetails] = {
    PrefabName = "UI_BondDetailsWindow",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityBond.UI.BondDetail.UIBondDetails")
  },
  [UIWindowTypeID.ActLobbyMain] = {
    PrefabName = "UI_ActivityLobbyMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityLobby.UI.Main.UIActivityLobbyMain")
  },
  [UIWindowTypeID.ActLbFollowInfo] = {
    PrefabName = "UI_ActLbFollowInfo",
    LayoutLevel = EUILayoutLevel.Bottom,
    WindowClass = require("Game.ActivityLobby.UI.FollowInfo.UIActLbFollowInfo")
  },
  [UIWindowTypeID.DungeonTowerLevel] = {
    PrefabName = "UI_DungeonTowerLevel",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.DungeonCenter.TowerUI.UIDungeonTowerLevel")
  },
  [UIWindowTypeID.DungeonTowerSelect] = {
    PrefabName = "UI_DungeonTowerSelect",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.DungeonCenter.TowerUI.UIDungeonTowerSelect")
  },
  [UIWindowTypeID.DungeonHexaTower] = {
    PrefabName = "UI_DungeonHexaTower",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.DungeonCenter.SixHeroTower.UIDunHexaTower")
  },
  [UIWindowTypeID.DungeonHexaTowerSelect] = {
    PrefabName = "UI_DunHexaSelectTower",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.DungeonCenter.SixHeroTower.UIDunHexaTowerSelect"),
    AnimaType = EUIAnimaType.FadeScaleBottomRight
  },
  [UIWindowTypeID.DungeonTwinTowerSelect] = {
    PrefabName = "UI_DungeonTwinTowerSelect",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.DungeonCenter.TowerUI.UIDungeonTwinTowerSelect"),
    AnimaType = EUIAnimaType.FadeScaleBottomLeft
  },
  [UIWindowTypeID.DungeonTwinTowerSelectNoAni] = {
    PrefabName = "UI_DungeonTwinTowerSelect",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.DungeonCenter.TowerUI.UIDungeonTwinTowerSelect")
  },
  [UIWindowTypeID.DungeonLevelDetail] = {
    PrefabName = "UI_DungeonLevelDetail",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.DungeonCenter.LevelUI.UIDungeonLevelDetail")
  },
  [UIWindowTypeID.DungeonLevelDetailSteinsGate] = {
    PrefabName = "UI_SteinsGateDungeonLevelDetail",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.DungeonCenter.LevelUI.UIDungeonLevelDetail")
  },
  [UIWindowTypeID.DungeonTowerSuccess] = {
    PrefabName = "UI_DungeonTowerSuccess",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.DungeonCenter.TowerUI.UIDungeonTowerSuccess")
  },
  [UIWindowTypeID.DungeonTowerRacing] = {
    PrefabName = "UI_DungeonTowerRacing",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.DungeonCenter.TowerUI.UIDungeonTowerRacing")
  },
  [UIWindowTypeID.StageRewardPreview] = {
    PrefabName = "UI_StageRewardPreview",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CommonUI.StageRewardPreview.UIStageRewardPreview")
  },
  [UIWindowTypeID.CommonRank] = {
    PrefabName = "UI_CommonRank",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CommonUI.Rank.UICommonRank")
  },
  [UIWindowTypeID.RecommeFormationSeason] = {
    PrefabName = "UI_RecommeFormationSeason",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.CommonUI.Rank.UIRecommeFormationSeason")
  },
  [UIWindowTypeID.HeroTalent] = {
    PrefabName = "UI_TalentMainNew",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.HeroTalent.UI.UIHeroTalentMain")
  },
  [UIWindowTypeID.HeroPlotReview] = {
    PrefabName = "UI_HeroPlotReview",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CommonUI.PlotReview.UICommonPlotReview")
  },
  [UIWindowTypeID.AdjPreset] = {
    PrefabName = "UI_AdjPreset",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.AdjCustom.AdjPreset.UIAdjPreset")
  },
  [UIWindowTypeID.AdjPresetNameChange] = {
    PrefabName = "UI_AdjPresetNameChange",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.AdjCustom.UIAdjPresetNameChange")
  },
  [UIWindowTypeID.AdjEditor] = {
    PrefabName = "UI_AdjEditor",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.AdjCustom.AdjEdit.UIAdjEditor")
  },
  [UIWindowTypeID.WhiteDay2048] = {
    PrefabName = "UI_WhiteDay2048",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.TinyGames.2048.UI.UIWhiteDay2048")
  },
  [UIWindowTypeID.WhiteDay2048Score] = {
    PrefabName = "UI_WhiteDay2048Score",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.TinyGames.2048.UI.UIWhiteDay2048Score"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.WhiteDay2048Rank] = {
    PrefabName = "UI_WhiteDay2048Rank",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.TinyGames.2048.UI.UIWhiteDay2048Rank"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.EffectMask] = {
    PrefabName = "UI_EffectMask",
    LayoutLevel = EUILayoutLevel.Top,
    WindowClass = require("Game.UIMask.UIEffectMask")
  },
  [UIWindowTypeID.WhiteDayTask] = {
    PrefabName = "UI_WhiteDayTask",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityWhiteDay.UI.Task.UIWhiteDayTask"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1203
  },
  [UIWindowTypeID.WhiteDayEvent] = {
    PrefabName = "UI_WhiteDayEvent",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityWhiteDay.UI.Event.UIWhiteDayEvent"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.ChipGift] = {
    PrefabName = "UI_ChipGift",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.PayGift.UIChipGift")
  },
  [UIWindowTypeID.ActivityComeback] = {
    PrefabName = "UI_EventComebackMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityComeback.UI.UIEventComebackMain")
  },
  [UIWindowTypeID.ActivityComebackLite] = {
    PrefabName = "UI_EventComebackMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityComeback.UI.UIEventComebackLiteMain")
  },
  [UIWindowTypeID.AprilGameDamie] = {
    PrefabName = "UI_AprilFoolMiniGame",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.TinyGames.Damie.UI.UIGameDamie")
  },
  [UIWindowTypeID.CommonRuleInfo] = {
    PrefabName = "UI_CommonRuleInfo",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.CommonUI.CommonRuleInfo.UICommonRuleInfo")
  },
  [UIWindowTypeID.HandBookBackground] = {
    PrefabName = "UI_HandBookBackground",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.HandBook.UI.Main.UI_HandBookBackground")
  },
  [UIWindowTypeID.HandBookHeroCampIndex] = {
    PrefabName = "UI_HandBookCampIndex",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.HandBook.UI.Hero.UI_HBHeroCampIndex"),
    ShowWinAuId = 1220
  },
  [UIWindowTypeID.HandBookHeroCampHeroList] = {
    PrefabName = "UI_HandBookList",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.HandBook.UI.Hero.UI_HBHeroHeroList")
  },
  [UIWindowTypeID.HandBookCampInfo] = {
    PrefabName = "UI_HandBookCampInfo",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.HandBook.UI.Hero.UI_HBCampInfo")
  },
  [UIWindowTypeID.HandbookHeroRelation] = {
    PrefabName = "UI_HandbookHeroRelation",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.HandBook.UI.Hero.UI_HBHeroRelation")
  },
  [UIWindowTypeID.HandBookCardMain] = {
    PrefabName = "UI_HandBookReinforceCard",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.HandBook.UI.Card.UI_HBCardMain"),
    ShowWinAuId = 1220
  },
  [UIWindowTypeID.Carnival22Main] = {
    PrefabName = "UI_Carnival22Main",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityCarnival.UI.CarnivalMain.UICarnival22Main")
  },
  [UIWindowTypeID.Carnival22Progress] = {
    PrefabName = "UI_Carnival22Progress",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityCarnival.UI.CarnivalProgress.UICarnivalProgress"),
    ShowWinAuId = 1224
  },
  [UIWindowTypeID.Carnival22InfoWindow] = {
    PrefabName = "UI_Carnival22InfoWindow",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityCarnival.UI.CarnivalInfoWindow.UICarnivalInfoWindow")
  },
  [UIWindowTypeID.Carnival22Select] = {
    PrefabName = "UI_Carnival22Select",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityCarnival.UI.CarnivalSelect.UICarnival22Select")
  },
  [UIWindowTypeID.Carnival22Task] = {
    PrefabName = "UI_Carnival22Task",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityCarnival.UI.CarnivalTask.UICarnival22Task"),
    ShowWinAuId = 1224
  },
  [UIWindowTypeID.Carnival22StrategyOverview] = {
    PrefabName = "UI_Carnival22StrategyOverview",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityCarnival.UI.CarnivalTech.UICarnival22StrategyOverview")
  },
  [UIWindowTypeID.Carnival22MiniGame] = {
    PrefabName = "UI_Carnival22MiniGame",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityCarnival.UI.CarnivalMiniGame.UICarnival22MiniGame")
  },
  [UIWindowTypeID.Carnival22Challenge] = {
    PrefabName = "UI_Carnival22Challenge",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityCarnival.UI.CarnivalChallenge.UICarnival22Challenge")
  },
  [UIWindowTypeID.HandBookSkinList] = {
    PrefabName = "UI_HandBookSkinList",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.HandBook.UI.Skin.UIHandBookSkinList")
  },
  [UIWindowTypeID.HandBookSkin] = {
    PrefabName = "UI_HandBookSkin",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.HandBook.UI.Skin.UIHandBookSkin")
  },
  [UIWindowTypeID.HandBookMain] = {
    PrefabName = "UI_HandBookMian",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.HandBook.UI.Main.UIHandBookMain")
  },
  [UIWindowTypeID.ActivityMiniGameMain] = {
    PrefabName = "UI_MiniGameGroupMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityHistoryTinyGame.UI.UIMiniGameMain"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.SnakeGame] = {
    PrefabName = "UI_SnakeGame",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.TinyGames.Snake.UI.UISnakeGame")
  },
  [UIWindowTypeID.SnakeGameRank] = {
    PrefabName = "UI_SnakeGameRank",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.TinyGames.Snake.UI.UISnakeGameRank")
  },
  [UIWindowTypeID.HandBookActBook] = {
    PrefabName = "UI_HandBookActBook",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.HandBook.UI.Activity.UIHandBookActBook")
  },
  [UIWindowTypeID.HandBookActBookEx] = {
    PrefabName = "UI_HandBookActBookEx",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.HandBook.UI.Activity.UIHandBookActBookEx")
  },
  [UIWindowTypeID.HandBookActBookFes] = {
    PrefabName = "UI_HandBookActBookFes",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.HandBook.UI.Activity.UIHandBookActBookFes")
  },
  [UIWindowTypeID.HandBookRewardWindow] = {
    PrefabName = "UI_HandBookRewardWindow",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.HandBook.UI.Activity.UIHandBookRewardWindow")
  },
  [UIWindowTypeID.StoryReview] = {
    PrefabName = "UI_CommonStoryReview",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CommonUI.PlotReview.UICommonStoryReview")
  },
  [UIWindowTypeID.EventDaliyChallenge] = {
    PrefabName = "UI_EventDaliyChallenge",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityDailyChallenge.UI.UIEventDailyChallenge"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.CustomHeroGift] = {
    PrefabName = "UI_CustomHeroGift",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.PayGift.UICustomHeroGift")
  },
  [UIWindowTypeID.CustomHeroSelect] = {
    PrefabName = "UI_CustomHeroSelect",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.PayGift.UICustomHeroSelect")
  },
  [UIWindowTypeID.WarChessMain] = {
    PrefabName = "UI_WarChessMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.WarChess.UI.Main.UIWarChessMain")
  },
  [UIWindowTypeID.WarChessInfo] = {
    PrefabName = "UI_WarChessInfo",
    LayoutLevel = EUILayoutLevel.Bottom,
    WindowClass = require("Game.WarChess.UI.Info.UIWarChessInfo")
  },
  [UIWindowTypeID.WarChessMonsterDetail] = {
    PrefabName = "UI_WarChessMonsterDetail",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.WarChess.UI.Detail.UIWarChessMonsterDetail")
  },
  [UIWindowTypeID.WarChessObjDetail] = {
    PrefabName = "UI_WarChessObjDetail",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.WarChess.UI.Detail.UIWarChessObjDetail")
  },
  [UIWindowTypeID.WarChessStore] = {
    PrefabName = "UI_WarChessStore",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.WarChess.UI.Store.UIWarChessStore")
  },
  [UIWindowTypeID.WarChessChipDiscard] = {
    PrefabName = "UI_WarChessChipDiscard",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.WarChess.UI.Discard.UIWarChessDiscard")
  },
  [UIWindowTypeID.WarChessStrategyReward] = {
    PrefabName = "UI_WarChessStrategyReward",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.WarChess.UI.Strategy.UIWarChessStrategyReward")
  },
  [UIWindowTypeID.WarChessBattleResult] = {
    PrefabName = "UI_WarchessBattleResult",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.WarChess.UI.Battle.UIWarChessBattleResult")
  },
  [UIWindowTypeID.WarChessEvent] = {
    PrefabName = "UI_WarChessEvent",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.WarChess.UI.Event.UIWarChessEvent")
  },
  [UIWindowTypeID.WarChessLoading] = {
    PrefabName = "UI_WarChessLoading",
    LayoutLevel = EUILayoutLevel.Top,
    WindowClass = require("Game.Loading.UIWarChessLoading")
  },
  [UIWindowTypeID.WarChessSelectChip] = {
    PrefabName = "UI_WarChessSelectChip",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.WarChess.UI.Chip.UIWarChessSelectChip")
  },
  [UIWindowTypeID.WarChessBuyChip] = {
    PrefabName = "UI_WarChessBuyChip",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.WarChess.UI.Store.UIWarChessBuyChip")
  },
  [UIWindowTypeID.WarChessTalkDialog] = {
    PrefabName = "UI_WarChessTalkDialog",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.WarChess.UI.Dialog.UIWarChessTalkDialog")
  },
  [UIWindowTypeID.WarChessViewChip] = {
    PrefabName = "UI_WarChessViewChips",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.WarChess.UI.ViewAllTeamChip.UIWarChessViewChips")
  },
  [UIWindowTypeID.WarChessInheritChip] = {
    PrefabName = "UI_WarChessInheritChip",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.WarChess.UI.InheritChip.UIWarChessInheritChip")
  },
  [UIWindowTypeID.WarChessTimeRewind] = {
    PrefabName = "UI_WarChessRewind",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.WarChess.UI.TimeRewind.UIWarChessTimeRewind")
  },
  [UIWindowTypeID.WarChessNotice] = {
    PrefabName = "UI_WarChessNotice",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.WarChess.UI.Notice.UIWarChessNotice")
  },
  [UIWindowTypeID.WarChessResult] = {
    PrefabName = "UI_WarChessResult",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.WarChess.UI.Settle.UIWarChessResult")
  },
  [UIWindowTypeID.WarChessGameWin] = {
    PrefabName = "UI_WarChessGameWin",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.WarChess.UI.Settle.UIWarChessGameWin")
  },
  [UIWindowTypeID.WarChessGameFail] = {
    PrefabName = "UI_WarChessGameFail",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.WarChess.UI.Settle.UIWarChessGameFail")
  },
  [UIWindowTypeID.WarChessSeasonSelectLevel] = {
    PrefabName = "UI_WarChessSeasonSelectLevel",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.WarChessSeason.UI.WCSSelectLevel.UIWCSSelectLevel")
  },
  [UIWindowTypeID.WarChessSeasonSettle] = {
    PrefabName = "UI_WarChessSeasonSettle",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.WarChessSeason.UI.WCSSettle.UIWCSSettle")
  },
  [UIWindowTypeID.WCSSavingPanel_Halloween22] = {
    PrefabName = "UI_WCSSavePanel_Halloween22",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.WarChessSeason.UI.WCSSavingPannel.UIWCSSavePanel_Halloween22")
  },
  [UIWindowTypeID.WCSSavingPanel_Christmas22] = {
    PrefabName = "UI_Christmas22SavePanel",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.WarChessSeason.UI.WCSSavingPannel.UIWCSSavePanel_Halloween22")
  },
  [UIWindowTypeID.ActSum22StrategyMain] = {
    PrefabName = "UI_ActSum22StrategyMain",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivitySummer.Year22.Tech.Main.UIActSum22StrategyMain")
  },
  [UIWindowTypeID.ActSum22StrategyTree] = {
    PrefabName = "UI_ActSum22StrategyTree",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivitySummer.Year22.Tech.Tree.UIActSum22StrategyTree")
  },
  [UIWindowTypeID.ActSum22StrategySelect] = {
    PrefabName = "UI_ActSum22StrategySelect",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivitySummer.Year22.Tech.Select.UIActSum22StrategySelect")
  },
  [UIWindowTypeID.ActSum22Main] = {
    PrefabName = "UI_ActSum22Main",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySummer.Year22.UIActSum22Main")
  },
  [UIWindowTypeID.ActSum22Task] = {
    PrefabName = "UI_ActSum22Task",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySummer.Year22.Task.UIActSum22Task")
  },
  [UIWindowTypeID.ActSum22Shop] = {
    PrefabName = "UI_ActSum22Shop",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySummer.Year22.Shop.UIActSum22Shop")
  },
  [UIWindowTypeID.ActSum22Map] = {
    PrefabName = "UI_ActSum22Map",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySummer.Year22.LevelMap.UIActSum22Map")
  },
  [UIWindowTypeID.ActSum22DunRepeat] = {
    PrefabName = "UI_ActSum22DunRepeat",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySummer.Year22.DunRepeat.UIActSum22DunRepeat")
  },
  [UIWindowTypeID.ActEntrySpread] = {
    PrefabName = "UI_HomeActivityList",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Home.UI.Side.UIHomeActivityEntrySpread")
  },
  [UIWindowTypeID.SignInMiniGame] = {
    PrefabName = "UI_SignInMiniGame",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySignInMiniGame.UI.UISignInMiniGame"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1153
  },
  [UIWindowTypeID.SpecWeapon] = {
    PrefabName = "UI_ArmaInscripta",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.SpecWeapon.UI.UIArmaInscripta")
  },
  [UIWindowTypeID.CharDunVer2] = {
    PrefabName = "UI_CharDunVer2",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityHeroGrow.UI.UICharDunVer2")
  },
  [UIWindowTypeID.CharDunTaskVer2] = {
    PrefabName = "UI_CharDunTaskVer2",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityHeroGrow.UI.UICharDunTaskVer2")
  },
  [UIWindowTypeID.CharDunTaskVer3] = {
    PrefabName = "UI_CharDunTaskVer3",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityHeroGrow.UI.UICharDunTaskVer3")
  },
  [UIWindowTypeID.CharDunShopVer2] = {
    PrefabName = "UI_CharDunShopVer2",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityHeroGrow.UI.UICharDunShopVer2")
  },
  [UIWindowTypeID.CharDunShopVer3] = {
    PrefabName = "UI_CharDunShopVer3",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityHeroGrow.UI.UICharDunShopVer3")
  },
  [UIWindowTypeID.CharDunVer3] = {
    PrefabName = "UI_CharDunVer3",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityHeroGrowV3.UI.UIHeroGrowV3")
  },
  [UIWindowTypeID.CahrDunVer3Normal] = {
    PrefabName = "UI_CharDunNormalQuest",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityHeroGrowV3.UI.Normal.UICharDunNormalQuest")
  },
  [UIWindowTypeID.CahrDunVer3NormalMap] = {
    PrefabName = "UI_CharDunNormalQuestMap",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityHeroGrowV3.UI.Normal.UICharDunNormalQuestMap")
  },
  [UIWindowTypeID.CahrDunChallengV3] = {
    PrefabName = "UI_CharDunRepeatVer3",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityHeroGrowV3.UI.UIHeroGrowChallengeV3")
  },
  [UIWindowTypeID.CharDunVer3Repeat] = {
    PrefabName = "UI_CharDunRepeatVer3",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityHeroGrowV3.UI.Repeat.UIHeroGrowV3Repeat")
  },
  [UIWindowTypeID.Halloween22Main] = {
    PrefabName = "UI_Halloween22Main",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityHallowmas.UI.UIHalloween22Main")
  },
  [UIWindowTypeID.Halloween22ModeSelect] = {
    PrefabName = "UI_Halloween22ModeSelect",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityHallowmas.UI.Select.UIHalloween22ModeSelect")
  },
  [UIWindowTypeID.Halloween22Achievement] = {
    PrefabName = "UI_Halloween22Achievement",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityHallowmas.UI.Achievement.UIHalloween22Achievement")
  },
  [UIWindowTypeID.Halloween22Task] = {
    PrefabName = "UI_Halloween22Task",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityHallowmas.UI.Task.UIHalloween22Task")
  },
  [UIWindowTypeID.Halloween22Bouns] = {
    PrefabName = "UI_Halloween22Bonus",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityHallowmas.UI.Bouns.UIHalloween22Bouns")
  },
  [UIWindowTypeID.EventBattlePassBuyLevel_Halloween] = {
    PrefabName = "UI_EventBattlePassBuyLevel",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityHallowmas.UI.Bouns.UIEventBattlePassBuyLevel_Halloween")
  },
  [UIWindowTypeID.ArmaInscriptaQuickEnhance] = {
    PrefabName = "UI_ArmaInscriptaQuickEnhance",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.SpecWeapon.UI.UIArmaInscriptaQuickEnhance")
  },
  [UIWindowTypeID.ActivityKeyExertion] = {
    PrefabName = "UI_EventLuckyBag",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityKeyExertion.UI.UIActivityKeyExertionMain")
  },
  [UIWindowTypeID.Christmas22Task] = {
    PrefabName = "UI_Christmas22Task",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityChristmas.UI.Task.UIChristmas22Task")
  },
  [UIWindowTypeID.Christmas22Bonus] = {
    PrefabName = "UI_Christmas22Bonus",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityChristmas.UI.Bonus.UIChristmas22Bonus")
  },
  [UIWindowTypeID.Christmas22Main] = {
    PrefabName = "UI_Christmas22Main",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityChristmas.UI.UIChristmas22Main")
  },
  [UIWindowTypeID.Christmas22StrategyOverview] = {
    PrefabName = "UI_Christmas22StrategyOverview",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityChristmas.UI.Tech.UIChristmas22StrategyOverview")
  },
  [UIWindowTypeID.Christmas22Repeat] = {
    PrefabName = "UI_Christmas22DunRepeat",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityChristmas.UI.DunRepeat.UIActXMas22DunRepeat")
  },
  [UIWindowTypeID.Christmas22ModeSelect] = {
    PrefabName = "UI_Christmas22ModeSelect",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityChristmas.UI.ModeSelect.UIChristmas22ModeSelect")
  },
  [UIWindowTypeID.ChristmasEnvTask] = {
    PrefabName = "UI_HeroTask",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityChristmas.UI.ModeSelect.UIChristmasEnvTask")
  },
  [UIWindowTypeID.Christmas22Unlock] = {
    PrefabName = "UI_Christmas22Unlock",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityChristmas.UI.UIChristmas22Unlock")
  },
  [UIWindowTypeID.RecommeFormationWindow] = {
    PrefabName = "UI_RecommeFormationWindow",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Formation.UI.FmtRecommend.UIRecommeFormationWindow")
  },
  [UIWindowTypeID.Spring23Main] = {
    PrefabName = "UI_Spring23MainTest",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySpring.UI.UISpring23Main")
  },
  [UIWindowTypeID.Spring23LevelModSelect] = {
    PrefabName = "UI_Spring23ModeSelect",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySpring.UI.SelectLevel.UISpring23ModeSelect")
  },
  [UIWindowTypeID.Spring23Challenge] = {
    PrefabName = "UI_Spring23Challenge",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySpring.UI.HardLevel.UIActSpring23HardLevel")
  },
  [UIWindowTypeID.Spring23Interactive] = {
    PrefabName = "UI_Spring23Interactive",
    LayoutLevel = EUILayoutLevel.Bottom,
    WindowClass = require("Game.ActivitySpring.UI.Interactive.UISpring23Interactive")
  },
  [UIWindowTypeID.Spring24Interactive] = {
    PrefabName = "UI_Spring23Interactive",
    LayoutLevel = EUILayoutLevel.Bottom,
    WindowClass = require("Game.ActivitySpring24.UI.Interactive.UISpring24Interactive")
  },
  [UIWindowTypeID.Spring23StrategyOverview] = {
    PrefabName = "UI_Spring23StrategyOverview",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySpring.UI.Tech.UISpring23StrategyOverview")
  },
  [UIWindowTypeID.Spring23Misson] = {
    PrefabName = "UI_Spring23Misson",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySpring.UI.UISpring23Misson")
  },
  [UIWindowTypeID.Spring23Unlock] = {
    PrefabName = "UI_Spring23Unlock",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.ActivitySpring.UI.UISpring23Unlock")
  },
  [UIWindowTypeID.AvgDetail] = {
    PrefabName = "UI_AvgDetail",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Sector.AvgDetail.UIAvgDetail")
  },
  [UIWindowTypeID.Spring23Story] = {
    PrefabName = "UI_Spring23Story",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivitySpring.UI.StoryReview.UISpring23Story")
  },
  [UIWindowTypeID.EventNewYear23SkinBag] = {
    PrefabName = "UI_EventNewYear23SkinBag",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.PayGift.UIEventNewYear23SkinBagChipGift")
  },
  [UIWindowTypeID.Winter23StrategyOverview] = {
    PrefabName = "UI_Winter23StrategyOverview",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityWinter23.UI.Tech.UIWinter23StrategyOverview")
  },
  [UIWindowTypeID.Winter23Task] = {
    PrefabName = "UI_Spring23Task",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityWinter23.UI.Task.UIWinter23Task")
  },
  [UIWindowTypeID.SectorChapterLvSwitch] = {
    PrefabName = "UI_Winter23Select",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Sector.SectorLevelChapter.UISectorChapterLvSwitch")
  },
  [UIWindowTypeID.DormFightMain] = {
    PrefabName = "UI_DormFightMain",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.DormFight.UI.UIDormFightMain")
  },
  [UIWindowTypeID.Winrwe23Shop] = {
    PrefabName = "UI_Winter23Shop",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityWinter23.UI.Shop.UIWinter23Shop")
  },
  [UIWindowTypeID.EventInvitation] = {
    PrefabName = "UI_EventInvitation",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityInvitation.UI.UIEventInvitation")
  },
  [UIWindowTypeID.SmashingPenguins] = {
    PrefabName = "UI_MiniPenguinMain",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.TinyGames.SmashingPenguins.UI.UISmashingPenguinsMain")
  },
  [UIWindowTypeID.SmashingPenguinsRanking] = {
    PrefabName = "UI_MiniPenguinRanking",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.TinyGames.SmashingPenguins.UI.UISmashingPenguinsRanking"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.WCSModeSelect] = {
    PrefabName = "UI_CommonModeSelect",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.WarChessSeason.UI.WCSSelect.UIWCSModeSelect")
  },
  [UIWindowTypeID.WCSSavingPanel_Common] = {
    PrefabName = "UI_CommonSavePanel",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.WarChessSeason.UI.WCSSavingPannel.UIWCSSavePanel_Common")
  },
  [UIWindowTypeID.EventWeeklyQA] = {
    PrefabName = "UI_EventWeeklyQA",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.EventWeeklyQA.UI.UIEventWeeklyQAMain")
  },
  [UIWindowTypeID.CommonThemedPacks] = {
    PrefabName = "UI_CommonThemedPacks",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.PayGift.CommonThemedPacks.UICommonThemedPacks")
  },
  [UIWindowTypeID.EventAngelaGift] = {
    PrefabName = "UI_EventAngelaGift",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.EventAngelaGift.UI.UIEventAngelaGiftMain")
  },
  [UIWindowTypeID.EventOptionalGift] = {
    PrefabName = "UI_EventOptionalGift",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.EventOptionalGift.UIEventOptionalGift")
  },
  [UIWindowTypeID.EventLadderGift] = {
    PrefabName = "UI_EventLadderGift",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.EventLadderGift.UI.UIEventLadderGift")
  },
  [UIWindowTypeID.UIBrotatoLobbyMain] = {
    PrefabName = "UI_BrotatoMain",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityBrotatoLobby.UI.UIBrotatoLobbyMain")
  },
  [UIWindowTypeID.UIBrotatoResult] = {
    PrefabName = "UI_BrotatoResult",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.ActivityBrotatoLobby.UI.UIBrotatoResult")
  },
  [UIWindowTypeID.ActivitySeasonBonus] = {
    PrefabName = "UI_CommonActivityBPReward",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySeason.UI.UIActivitySeasonBonus")
  },
  [UIWindowTypeID.CommonActivityRepeatDungeon] = {
    PrefabName = "UI_CommonActivityRepeatDungeon",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityFrame.UI.UICommonActivityRepeatDungeon")
  },
  [UIWindowTypeID.SaveMoney] = {
    PrefabName = "UI_EventSaveMoney",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySaveMoney.UI.UIActivitySaveMoneyMain")
  },
  [UIWindowTypeID.SaveMoneyPreview] = {
    PrefabName = "UI_SaveMoneyPreview",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.ActivitySaveMoney.UI.UIActivitySaveMoneyPreview")
  },
  [UIWindowTypeID.LuckyRaffle] = {
    PrefabName = "UI_EventLuckyRaffle",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.ActivityLuckyRaffle.UI.UIActivityLuckyRaffle")
  },
  [UIWindowTypeID.VowSystemTest] = {
    PrefabName = "UI_VowSystemTest",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.VowSystem.UI.VowSystemTest")
  },
  [UIWindowTypeID.VowSystemTest] = {
    PrefabName = "UI_VowSystemTest",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.VowSystem.UI.VowSystemTest")
  },
  [UIWindowTypeID.BattlePassActivity] = {
    PrefabName = "UI_EventBattlePassActivity",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.BattlePass.UI.UIEventBattlePassActivity")
  },
  [UIWindowTypeID.ActivitySeasonUnlcok] = {
    PrefabName = "UI_Spring23Unlock",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.ActivitySeason.UI.UIActivitySeasonUnlock")
  },
  [UIWindowTypeID.SeasonQuickBattle] = {
    PrefabName = "UI_SeasonQuickBattle",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivitySpring.UI.QuickBattle.UISeasonQuickBattle")
  },
  [UIWindowTypeID.FairyQuickLv] = {
    PrefabName = "UI_FairyQuickLvUp",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Fairy.UI.QuickLvUp.UIFairyQkLvUp")
  },
  [UIWindowTypeID.FairySkillDetailFloat] = {
    PrefabName = "UI_FaitySkillDetailFloat",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Fairy.UI.QuickLvUp.UIFaitySkillDetailFloat")
  },
  [UIWindowTypeID.FairyQuickLvSkillSave] = {
    PrefabName = "UI_FairyQkLvUpSkillSave",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Fairy.UI.QuickLvUp.SkillSave.UIFairyQkLvUpSkillSave")
  },
  [UIWindowTypeID.FairyFormation] = {
    PrefabName = "UI_FairyFormation",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Fairy.UI.Formation.UIFairyFormation"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.FairyCultivateMain] = {
    PrefabName = "UI_FairyList",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Fairy.UI.UIFairyCultivateMain")
  },
  [UIWindowTypeID.FairyLobbyMain] = {
    PrefabName = "UI_FairyLobbyMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Fairy.UI.UIFairyLobbyMain")
  },
  [UIWindowTypeID.FairyNotice] = {
    PrefabName = "UI_FairyNotice",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Fairy.UI.Notice.UIFairyNotice")
  },
  [UIWindowTypeID.FairyChangeName] = {
    PrefabName = "UI_FairyChangeName",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Fairy.UI.UIChangeFairyName")
  },
  [UIWindowTypeID.FairyRecovery] = {
    PrefabName = "UI_FairyRecovery",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Fairy.UI.UIFairyRecovery")
  },
  [UIWindowTypeID.FairyLottery] = {
    PrefabName = "UI_FairyLottery",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Fairy.UI.Lottery.UIFairyLottery"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.FairyLotteryResult] = {
    PrefabName = "UI_FairyLotteryResult",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Fairy.UI.Lottery.UIFairyLotteryResult")
  },
  [UIWindowTypeID.FairyLotteryShow] = {
    PrefabName = "UI_FairyLotteryShow",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Fairy.UI.Lottery.UIFairyLotteryShow")
  },
  [UIWindowTypeID.FairySkillDetails] = {
    PrefabName = "UI_FairySkillDetails",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Fairy.UI.SkillDetails.UIFairySkillDetails")
  },
  [UIWindowTypeID.DormFightMain] = {
    PrefabName = "UI_DormFightMain",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.DormFight.UI.UIDormFightMain")
  },
  [UIWindowTypeID.DormFightFriendInviting] = {
    PrefabName = "UI_DormFightFriendInviting",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.DormFight.UI.UIDormFightFriendInviting")
  },
  [UIWindowTypeID.DormFightBeInvited] = {
    PrefabName = "UI_DormFightFriendBeInvited",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.DormFight.UI.UIDormFightBeInvited")
  },
  [UIWindowTypeID.DormFightFormation] = {
    PrefabName = "UI_DormFightFormation",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.DormFight.UI.UIDormFightFormation")
  },
  [UIWindowTypeID.DOrmFightVS] = {
    PrefabName = "UI_DormFightVS",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.DormFight.UI.UIDormFightVS")
  },
  [UIWindowTypeID.DormFightResult] = {
    PrefabName = "UI_DormFightResult",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.DormFight.UI.UIDormFightResult")
  },
  [UIWindowTypeID.Report] = {
    PrefabName = "UI_Report",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Report.UI.UIReport")
  },
  [UIWindowTypeID.CardRankBattleDetails] = {
    PrefabName = "UI_CardRankBattleDetails",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.CardSet.UI.RankBattleDetail.UICardRankBattleDetails")
  },
  [UIWindowTypeID.CardSetBattleResult] = {
    PrefabName = "UI_CardSetResult",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.CardSet.UI.BattleResult.UICardSetBattleResult")
  },
  [UIWindowTypeID.CardSet] = {
    PrefabName = "UI_CardSet",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CardSet.UI.Set.UICardSet")
  },
  [UIWindowTypeID.CardSetEntrance] = {
    PrefabName = "UI_CardMainEntrance",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CardSet.UI.Entrance.UICardSetMainEntrance")
  },
  [UIWindowTypeID.CardSetRankMode] = {
    PrefabName = "UI_CardSetRankMode",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CardSet.UI.RankMode.UICardSetRankMode")
  },
  [UIWindowTypeID.CardSetMEReward] = {
    PrefabName = "UI_CardSetMEReward",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.CardSet.UI.Entrance.UICardSetMEReward")
  },
  [UIWindowTypeID.CardSetReward] = {
    PrefabName = "UI_CardSetReward",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.CardSet.UI.Reward.UICardSetReward")
  },
  [UIWindowTypeID.CardSetDiffUnlock] = {
    PrefabName = "UI_CardDiffUnlock",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.CardSet.UI.DiffUnlock.UICardDiffUnlock")
  },
  [UIWindowTypeID.CardSetRestWithAni] = {
    PrefabName = "UI_CardRestAni",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CardSet.UI.Reset.UICardRestWithAni")
  },
  [UIWindowTypeID.CardSetLockedTeam] = {
    PrefabName = "UI_CardLockedFmt",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CardSet.UI.LockedFmt.UICardSetLockedFmt")
  },
  [UIWindowTypeID.CardSetRewind] = {
    PrefabName = "UI_CardSetRewind",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.CardSet.UI.Rewind.UICardSetRewind")
  },
  [UIWindowTypeID.MiniGameMusic] = {
    PrefabName = "UI_Carnival23Music",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.TinyGames.Music.UI.UIMiniGameMusicMain")
  },
  [UIWindowTypeID.MiniGameTask] = {
    PrefabName = "UI_CommonActivityGameTask",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityBrotatoLobby.UI.UINTaskNode.UIMiniGameTask"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1088,
    HideWinAuId = 1089
  },
  [UIWindowTypeID.Summer23Interactive] = {
    PrefabName = "UI_Summer23Interactive",
    LayoutLevel = EUILayoutLevel.Bottom,
    WindowClass = require("Game.ActivitySummer23.UI.UISummer23ChapterInteractive")
  },
  [UIWindowTypeID.Summer23QuestUnlock] = {
    PrefabName = "UI_Summer23QuestUnlock",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySummer23.UI.UISummer23QuestUnlock")
  },
  [UIWindowTypeID.ActivityDivergentMain] = {
    PrefabName = "UI_AnotherHero",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityDivergent.UI.UIActivityDivergentMain")
  },
  [UIWindowTypeID.Activity23SteinsGateChapterMap] = {
    PrefabName = "UI_SteinsGateChapterMap",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Activity23SteinsGate.UI.ChapterMap.UISteinsGateChapterMap"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.SteinsGateCommonMask] = {
    PrefabName = "UI_SteinsGateCommonMask",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = UIBaseWindow
  },
  [UIWindowTypeID.SteinsGateEffectMask] = {
    PrefabName = "UI_SteinsGateEffectMask",
    LayoutLevel = EUILayoutLevel.Bottom,
    WindowClass = require("Game.Activity23SteinsGate.UI.Effect.UISteinsGateEffectMask")
  },
  [UIWindowTypeID.UISteinsGateDiffSelect] = {
    PrefabName = "UI_SteinsGateDiffSelect",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Activity23SteinsGate.UI.ChapterMap.DiffSelect.UISteinsGateDiffSelect")
  },
  [UIWindowTypeID.UI23SteinsGateScenesLoading] = {
    PrefabName = "UI_SteinsGateScenesLoading",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Activity23SteinsGate.UI.Scene.UISteinsGateScenesLoading")
  },
  [UIWindowTypeID.ExplorationFund] = {
    PrefabName = "UI_ChapterBattlePass",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityExplorationFund.UI.UIActivityExplorationFundMain")
  },
  [UIWindowTypeID.EventPreciousCompany] = {
    PrefabName = "UI_EventPreciousCompany",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityShortTheatre.UI.UIShortTheatre"),
    AnimaType = EUIAnimaType.FadeScaleUp,
    ShowWinAuId = 1153
  },
  [UIWindowTypeID.MailStoneMian] = {
    PrefabName = "UI_MilestoneMain",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.MileStone.UI.Main.UIMileStoneMain")
  },
  [UIWindowTypeID.MilestoneSheet] = {
    PrefabName = "UI_MilestoneSheet",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.MileStone.UI.Sheet.UIMilestoneSheet")
  },
  [UIWindowTypeID.CommonEpModeSelect] = {
    PrefabName = "UI_EpCommonModeSelect",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.CommonUI.ModeSelect.UIEpCommonModeSelect")
  },
  [UIWindowTypeID.CommonFairyInfo] = {
    PrefabName = "UI_FairyInfoWindow",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.CommonUI.Fairy.UIFairyInfoWindow")
  },
  [UIWindowTypeID.VowCard] = {
    PrefabName = "UI_VowCard",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.VowSystem.UI.UIVowCardMain")
  },
  [UIWindowTypeID.VowCardSign] = {
    PrefabName = "UI_VowSignWindow",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.VowSystem.UI.UIVowSign")
  },
  [UIWindowTypeID.ActivityFlipCardPreview] = {
    PrefabName = "UI_EventFlipCardsWindow",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityFlipCard.UI.RewardPreview.UIActivityFlipCardRewardPreview")
  },
  [UIWindowTypeID.ActivityAnniversary23Unlock] = {
    PrefabName = "UI_Anniversary23Unlock",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityAnniversary23.UI.UIActivityAnniversary23Unlock")
  },
  [UIWindowTypeID.ActivityFlipCardMain] = {
    PrefabName = "UI_EventFlipCards",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityFlipCard.UI.UIActivityFlipCardMain")
  },
  [UIWindowTypeID.VowChangeNameDialog] = {
    PrefabName = "UI_VowChangeName",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.VowSystem.UI.UIVowChangeNameDialog")
  },
  [UIWindowTypeID.VowShow] = {
    PrefabName = "UI_AvgVow",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.VowSystem.UI.UIVowShow")
  },
  [UIWindowTypeID.VowShowSkip] = {
    PrefabName = "UI_VowShowSkip",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.VowSystem.UI.UIVowShowSkip")
  },
  [UIWindowTypeID.ActivityFlipCardGetMore] = {
    PrefabName = "UI_EventFlipCardsGetMore",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityFlipCard.UI.UIActivityFlipCardGetMore")
  },
  [UIWindowTypeID.ActivityFlipCardTask] = {
    PrefabName = "UI_HeroTask",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityFlipCard.UI.UIActivityFlipCardTaskWindow")
  },
  [UIWindowTypeID.VowReward] = {
    PrefabName = "UI_VowFavorLvlUpWindow",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.VowSystem.UI.UIVowReward")
  },
  [UIWindowTypeID.ActivitySkinLimitMain] = {
    PrefabName = "UI_EventSkinLimit",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySkinLimit.UI.UIActivitySkinLimitMain")
  },
  [UIWindowTypeID.ActivitySkinLimitTask] = {
    PrefabName = "UI_HeroTask",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivitySkinLimit.UI.UIActivitySkinLimitTask")
  },
  [UIWindowTypeID.CommonQuickBattle] = {
    PrefabName = "UI_CommonQuickBattle",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.CommonUI.QuickBattle.UICommonQuickBattle")
  },
  [UIWindowTypeID.CommonMonsterCard] = {
    PrefabName = "UI_ActCommonMonsterCard",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityFrame.ActivityMonsterCard.UI.UIActCommonMonsterCard")
  },
  [UIWindowTypeID.CommonMonsterCardDrop] = {
    PrefabName = "UI_CardDropDetails",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityFrame.ActivityMonsterCard.UI.Drop.UIActCommonMonsterCardDrop")
  },
  [UIWindowTypeID.CommonHardLevel] = {
    PrefabName = "UI_Spring23Challenge",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityFrame.ActCommonHardLevel.UI.UIActCommonHardLevel")
  },
  [UIWindowTypeID.ActivityBlackHoleMain] = {
    PrefabName = "UI_EventBlackHole",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityBlackHole.UI.UIActBlackHoleMain"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.SteinsGateRepeat] = {
    PrefabName = "UI_SteinsGateRepeat",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Activity23SteinsGate.UI.Repeat.UISteinsGateRepeat"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.UI23SteinsGateTask] = {
    PrefabName = "UI_SteinsGateTask",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityWinter23.UI.Task.UIWinter23Task"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.UI23SteinsGateGachaponShop] = {
    PrefabName = "UI_SteinsGateShop",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Activity23SteinsGate.UI.Shop.UI23SteinsGateGachaponShop"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.UltSkillVideo] = {
    PrefabName = "UI_UltSkillVideo",
    LayoutLevel = EUILayoutLevel.Top,
    WindowClass = require("Game.Battle.UI.UIUltSkillVideo")
  },
  [UIWindowTypeID.EventCommonSkinBag] = {
    PrefabName = "UI_EventCommonSkinBag",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.PayGift.UIEventCommonSkinBag")
  },
  [UIWindowTypeID.ActivitySteinsGateMiniGameMain] = {
    PrefabName = "UI_SteinsGateMiniGame",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivitySteinsGateMiniGame.UI.UIActSGMiniGame"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.HeroQuickLvUpMain] = {
    PrefabName = "UI_HeroQuickLvlUp",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Hero.NewUI.QuickLvUp.UIHeroQuickLvUpMain")
  },
  [UIWindowTypeID.HeroQuickLvUpWindow] = {
    PrefabName = "UI_HeroQuickLvlUpWindow",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Hero.NewUI.QuickLvUp.UIHeroQuickLvUpWindow")
  },
  [UIWindowTypeID.UltSkillVideo] = {
    PrefabName = "UI_UltSkillVideo",
    LayoutLevel = EUILayoutLevel.Top,
    WindowClass = require("Game.Battle.UI.UIUltSkillVideo")
  },
  [UIWindowTypeID.EPTalkDialog] = {
    PrefabName = "UI_EPTalkDialog",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.Exploration.UI.EpTalkDialog.UIEpTalkDialog")
  },
  [UIWindowTypeID.UISteinsGate23Interactive] = {
    PrefabName = "UI_Spring23Interactive",
    LayoutLevel = EUILayoutLevel.Bottom,
    WindowClass = require("Game.Activity23SteinsGate.UI.Interactive.UISteinsGate23Interactive")
  },
  [UIWindowTypeID.UI23SteinsGateUnlock] = {
    PrefabName = "UI_SteinsGateUnlock",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Activity23SteinsGate.UI.Unlock.UI23SteinsGateUnlock")
  },
  [UIWindowTypeID.ActivityHazeGiftMain] = {
    PrefabName = "UI_EventHazeGift",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityHazeGift.UI.UIActivityHazeGiftMain")
  },
  [UIWindowTypeID.EventDrawLottery] = {
    PrefabName = "UI_CommonLotterySkinAct",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.EventDrawLottery.UI.UIEventDrawLottery"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.EventDrawLotteryTaskWindow] = {
    PrefabName = "UI_CommonLotterySkinActWindow",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.EventDrawLottery.UI.Task.UIDrawLotteryTaskWindow"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.UI24WinterTask] = {
    PrefabName = "UI_Spring24Task",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityAnniversary23.UI.Task.UIActivityAnniversary23TaskWindow")
  },
  [UIWindowTypeID.UISpring24Notice] = {
    PrefabName = "UI_Spring24Notice",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.ActivitySpring24.UI.UISpring24Notice"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.ActivityComebackSystemTaskWindow] = {
    PrefabName = "UI_EventComebackSystemNodeTaskWindow",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityComeback.UI.UIEventComebackSystemTaskWindow")
  },
  [UIWindowTypeID.UI24SpringCollectFortuneMain] = {
    PrefabName = "UI_Spring24Collect",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityCollectFortune.UI.UIActivityCollectFortuneMain")
  },
  [UIWindowTypeID.LineupRecommend] = {
    PrefabName = "UI_LineupRecommend",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Formation.UI.LineUpRecommend.UILineupRecommendMain")
  },
  [UIWindowTypeID.LineupMessageBox] = {
    PrefabName = "UI_LineupMessageItemBox",
    LayoutLevel = EUILayoutLevel.LowTop,
    WindowClass = require("Game.Formation.UI.LineUpRecommend.UILineupMessageBox")
  },
  [UIWindowTypeID.PerformanceMain] = {
    PrefabName = "UI_PerformanceMain",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivitySoundPlay.UI.UIPerformanceMain"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.PerformancePlay] = {
    PrefabName = "UI_PerformancePlay",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivitySoundPlay.UI.UIPerformancePlay"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.PerformanceResult] = {
    PrefabName = "UI_PerformanceResult",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivitySoundPlay.UI.UIPerformanceResult"),
    AnimaType = EUIAnimaType.Fade
  },
  [UIWindowTypeID.PerformanceSelect] = {
    PrefabName = "UI_PerformanceSelect",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivitySoundPlay.UI.UIPerformanceSelect"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.PerformanceGameTask] = {
    PrefabName = "UI_PerformanceGameTask",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivitySoundPlay.UI.UIPerformanceGameTask"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.PerformanceRank] = {
    PrefabName = "UI_PerformanceRank",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivitySoundPlay.UI.UIPerformanceRank"),
    AnimaType = EUIAnimaType.FadeScaleUp
  },
  [UIWindowTypeID.SignInLiveStream] = {
    PrefabName = "UI_SignInLiveStream",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActSignInLiveStream.UI.UISignInLiveStream")
  },
  [UIWindowTypeID.FormationSave] = {
    PrefabName = "UI_FormationSave",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Exploration.UI.FormationSave.UIFormationSave")
  },
  [UIWindowTypeID.InfinityFmtCheck] = {
    PrefabName = "UI_InfiniteFrmCheckWindow",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.Exploration.UI.FormationSave.UIInfiniteFrmCheckWindow")
  },
  [UIWindowTypeID.UICarnivalMemoryFragments] = {
    PrefabName = "UI_Carnival24Fragment",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityCarnival24.UI.UICarnivalMemoryFragments")
  },
  [UIWindowTypeID.UICarnivalMemoryAlbums] = {
    PrefabName = "UI_Carnival24Album",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityCarnival24.UI.UICarnivalMemoryAlbums")
  },
  [UIWindowTypeID.ChipScoreShow] = {
    PrefabName = "UI_SectorFxMarkWindow",
    LayoutLevel = EUILayoutLevel.High,
    WindowClass = require("Game.Exploration.UI.ChipScore.UIChipScoreShow")
  },
  [UIWindowTypeID.CommonActRewardBp] = {
    PrefabName = "UI_CommonActivityBPReward",
    LayoutLevel = EUILayoutLevel.Middle,
    WindowClass = require("Game.ActivityFrame.ActCommonRewardBp.UI.UIActCommonRewardBp")
  },
  [UIWindowTypeID.DeliverySimulatorMain] = {
    PrefabName = "UI_DeliverySimulatorMain",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityDeliverySimulator.UI.UIDeliverySimulatorMain")
  },
  [UIWindowTypeID.DeliverySimulatorResult] = {
    PrefabName = "UI_DeliverySimulatorResult",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityDeliverySimulator.UI.UIDeliverySimulatorResult")
  },
  [UIWindowTypeID.DeliverySimulatorEntrance] = {
    PrefabName = "UI_DeliverySimulatorEntrance",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityDeliverySimulator.UI.UIDeliverySimulatorEntrance")
  },
  [UIWindowTypeID.DeliverySimulatorSelect] = {
    PrefabName = "UI_DeliverySimulatorSelect",
    LayoutLevel = EUILayoutLevel.Normal,
    WindowClass = require("Game.ActivityDeliverySimulator.UI.Select.UIDeliverySimulatorSelect")
  },
  [UIWindowTypeID.UIAnni24Interactive] = {
    PrefabName = "UI_Spring23Interactive",
    LayoutLevel = EUILayoutLevel.Bottom,
    WindowClass = require("Game.ActivityAnniversary24.UI.Interactive.UIAnni24Interactive")
  },
  [UIWindowTypeID.ClosingList] = {
    PrefabName = "UI_ClosingList",
    LayoutLevel = EUILayoutLevel.OverHigh,
    WindowClass = require("Game.Setting.UI.UIClosingList")
  }
}
CoverJumpReturnOrder = {
  UIWindowTypeID.HeroSkin,
  UIWindowTypeID.ShopMain,
  UIWindowTypeID.QuickBuy,
  UIWindowTypeID.GiftPageDetail
}
