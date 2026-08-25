local Z1ButtonState = CS.Z1Client.Z1ButtonState
local CommonDefine = {}
CommonDefine.MaxEquipTrinketsNum = 6
CommonDefine.MaxTrinketUpgradeMatSlotsNum = 8
CommonDefine.OneDaySecond = 86400
CommonDefine.AvatarReplacementTimeRangeKey = "AvatarReplacementTimeRange"
CommonDefine.AvatarReplacementItemIdKey = "AvatarReplacementItemId"
CommonDefine.PublishRegion = {HKTW = "HKTW", JP = "JP"}
CommonDefine.Lang = {
  CN = "CN",
  TW = "TW",
  EN = "EN"
}
CommonDefine.Zone = {Global = 1, JP = 2}
CommonDefine.ZoneFeature = {
  GoogleCustomerUrl = "GoogleCustomerUrl",
  MainCopy = "MainCopy",
  MainCopyHard = "MainCopyHard",
  DrawCard = "DrawCard",
  Shop = "Shop",
  ItemConversion = "ItemConversion",
  Mail = "Mail",
  Task = "Task",
  RiskCheck = "RiskCheck",
  TrinketTrain = "TrinketTrain",
  TrinketUpgrade = "TrinketUpgrade",
  WeaponAdvance = "WeaponAdvance",
  Decompose = "Decompose",
  Compose = "Compose",
  MaterialExchange = "MaterialExchange",
  CreateRole = "CreateRole",
  Backtrack = "Backtrack",
  AbyssChallenge = "AbyssChallenge",
  Resummon = "Resummon",
  AwakerSkin = "AwakerSkin",
  SummonRateDetail = "SummonRateDetail",
  JPDiscord = "JPDiscord",
  JPAutoBattle = "JPAutoBattle",
  JPShare = "JPShare",
  JPCharge = "JPCharge",
  JPCBTTest = "JPCBTTest",
  JPPriceSymbol = "JPPriceSymbol",
  SocialInviteCode = "SocialInviteCode",
  JPLoginLogo = "JPLoginLogo",
  WeaponAutoRefine = "WeaponAutoRefine"
}
CommonDefine.GameEvent = {
  EnterGame = "EnterGame",
  EnterAvg = "EnterAvg",
  ExitAvg = "ExitAvg",
  EnterMainPanel = "EnterMainPanel",
  ExitMainPanel = "ExitMainPanel",
  EnterCopy = "EnterCopy",
  ExitCopy = "ExitCopy",
  LoginPVManualChanged = "LoginPVManualChanged"
}
CommonDefine.SceneType = {
  Null = "Null",
  Login = "Login",
  Town = "Town ",
  Copies = "Copies",
  Challenge = "Challenge",
  Introduction = "Introduction",
  Battle = "Battle",
  Empty = "Empty"
}
CommonDefine.BattleCardDropShowType = {
  Normal = 0,
  Fade = 1,
  Burn = 2
}
CommonDefine.LoginWay = {None = "None", UseSdk = "UseSdk"}
CommonDefine.CountryCode = {
  CN = "CN",
  US = "US",
  TW = "TW",
  HK = "HK",
  SG = "SG",
  MY = "MY",
  KR = "KR"
}
CommonDefine.IntroStepType = {
  AvgDialog = "AvgDialog",
  Name = "Name",
  GetAwaker = "GetAwaker",
  PrologueMoveCoordinates = "PrologueMoveCoordinates",
  Constant = "Constant",
  StageGroup = "StageGroup"
}
CommonDefine.StageChapterName = {
  StageChapterMorimens = "StageChapterMorimens",
  StageChapterStarsCameRight = "StageChapterStarsCameRight"
}
CommonDefine.StageAjustType = {
  AdjustAwaker = "AdjustAwaker",
  AdjustPlayer = "AdjustPlayer",
  AdjustAwakerAndPlayer = "AdjustAwakerAndPlayer"
}
CommonDefine.PvPMoreGameState = {
  CanPlay = 1,
  CantPlay = 2,
  Refuse = 3,
  ClickRefuse = 4,
  NoMoreGame = 5,
  AiOpponent = 6
}
CommonDefine.PvPCamp = {Player = 1, Enermy = 2}
CommonDefine.PvPPlayOrder = {First = 1, Second = 2}
CommonDefine.PvPReplaceCardState = {
  NotSelect = 1,
  Select = 2,
  AfterReplace = 3
}
CommonDefine.PvPUnitSettleType = {Awaker = 1, Keeper = 2}
CommonDefine.PvPSettleRewardDataType = {
  PVP = "PVP",
  PVPStyle = "PVPStyle",
  ExpBonus = "ExpBonus"
}
CommonDefine.PvpSettleReason = {
  Normal = 0,
  GiveUpPrepare = 1,
  Timeout = 2,
  GM = 3
}
CommonDefine.PvPRankRewardType = {
  BattleRst = 1,
  seasonBonus = 2,
  streakBonus = 3,
  firstWinBonus = 4
}
CommonDefine.PVPGameplayType = {Match = 1, Friend = 2}
CommonDefine.PvpStatusLayerColorLangKey = {
  Positive = "PositiveStatusColor",
  Negative = "NegativeStatusColor",
  Other = "OtherStatusColor"
}
CommonDefine.AllyPosAwakerNameWordsEffectKeys = {
  "AllyPosAwaker1Name",
  "AllyPosAwaker2Name",
  "AllyPosAwaker3Name",
  "AllyPosAwaker4Name"
}
CommonDefine.EnemyPosAwakerNameWordsEffectKeys = {
  "EnemyPosAwaker1Name",
  "EnemyPosAwaker2Name",
  "EnemyPosAwaker3Name",
  "EnemyPosAwaker4Name"
}
CommonDefine.SeasonGameplayType = {
  ConsciousnessDiving = 1,
  PvpPreBuilt = 2,
  ConsciousnessRailway = 3,
  PvpDraft = 4
}
CommonDefine.KeyBordMoveDir = {
  Top = "Top",
  Bottom = "Bottom",
  Left = "Left",
  Right = "Right"
}
CommonDefine.RoleType = {Player = "Player", RotPlayer = "RotPlayer"}
CommonDefine.InteractionType = {Npc = "NPC", Other = "Other"}
CommonDefine.NPCType = {
  CopiesNpc = 0,
  TownNpc = 1,
  ChatNpc = 2,
  StaticConditionNpc = 5
}
CommonDefine.AvgConst = {EndFadeTime = 2, ReviewEndFadeTime = 1}
CommonDefine.AvgBgType = {PrefabTop = 1}
CommonDefine.PackageChannel = {
  TWTest = 1,
  CN = 2,
  HK = 3,
  TW = 4,
  XIAO_7 = 5
}
CommonDefine.AvgUseReason = {
  PureAvgStage = "PureAvgStage",
  AvgGear = "AvgGear",
  AvgBeforeStage = "AvgBeforeStage",
  AvgAfterStage = "AvgAfterStage"
}
CommonDefine.AvgDialogType = {
  NameDialog = 1,
  HeadIconDialog = 2,
  AsideDialog = 3,
  CaptionDialog = 4,
  OptionDialog = 5,
  CaptionDialogWhite = 6,
  LongCaption = 7,
  AvgBubble = 8,
  RollCaption = 9,
  Novel = 10,
  NovelEnd = 11,
  RadioDrama = 12
}
CommonDefine.AvgAudioTime = {Start = 0, End = 1}
CommonDefine.AvgMaterialType = {
  Disturb = "UIResources/VX/Material/UI_Common_Disturb_18.mat"
}
CommonDefine.AvgFontType = {
  Small = "AvgFontSmall",
  Normal = "AvgFontNormal",
  Big = "AvgFontBig",
  Bold = "AvgFontBold"
}
CommonDefine.AvgCaptionAnim = {
  Slow = "AvgSlowCaptionAnim",
  Middle = "AvgMiddleCaptionAnim",
  Fast = "AvgFastCaptionAnim"
}
CommonDefine.BgTrans = {
  FromRight = 1,
  FastWhiteFlash = 2,
  SlowWhiteFlash = 3,
  FastBlackFlash = 4,
  SlowBlackFlash = 5,
  VerySlowBlack = 6,
  GradualBlack = 7,
  SlowTimePass = 8,
  FastTimePass = 9,
  QuickBlack = 10
}
CommonDefine.BgTransVideoPath = {
  [CommonDefine.BgTrans.SlowTimePass] = {
    "Avg/UI_TimePassing_Slow_rgb.mp4",
    "Avg/UI_TimePassing_Slow_alpha.mp4",
    false,
    2.4
  },
  [CommonDefine.BgTrans.FastTimePass] = {
    "Avg/UI_TimePassing_Fast_rgb.mp4",
    "Avg/UI_TimePassing_Fast_alpha.mp4",
    false,
    1
  }
}
CommonDefine.NumberTrue = 1
CommonDefine.NumberFalse = 0
CommonDefine.AvgRoleTag = {
  Talker = 0,
  All = 1,
  AllExceptTalker = -1
}
CommonDefine.AvgVideoType = {
  VideoPure = 0,
  VideoFramePlay = 1,
  VideoFramePause = 2,
  VideoLoop = 3
}
CommonDefine.AvgAction = {
  FadeIn = "FadeIn",
  FadeOut = "FadeOut",
  PlayBgTransAnim = "PlayBgTransAnim",
  SetBg = "SetBg",
  BgAnim = "BgAnim",
  PlayVideo = "PlayVideo",
  PrepareVideo = "PrepareVideo",
  SetTalkerInfo = "SetTalkerInfo",
  PlayScreenEffect = "PlayScreenEffect",
  SetOption = "SetOption",
  SetCaption = "SetCaption",
  PlayDialogEnterAnim = "PlayDialogEnterAnim",
  ShowDialogText = "ShowDialogText",
  ShowOtherAnim = "ShowOtherAnim",
  EndPrefabAnimation = "EndPrefabAnimation",
  ShakeDialog = "ShakeDialog",
  RoleHurt = "RoleHurt",
  PlayCfgEndAnim = "PlayCfgEndAnim",
  AvgRole = "AvgRole",
  ExitRoleEffect = "ExitRoleEffect",
  HideDialogAnim = "HideDialogAnim",
  ShowItemAnim = "ShowItemAnim",
  LongCaption = "LongCaption",
  RollCaption = "RollCaption",
  AvgNovel = "AvgNovel",
  WaterColor = "WaterColor",
  RadioDrama = "RadioDrama"
}
CommonDefine.AvgActionCls = {
  FadeIn = "AvgActionFadeIn",
  FadeOut = "AvgActionFadeOut",
  PlayBgTransAnim = "AvgActionPlayBgTransAnim",
  SetBg = "AvgActionSetBg",
  BgAnim = "AvgActionBgAnim",
  PlayVideo = "AvgActionPlayVideo",
  PrepareVideo = "AvgActionPrepareVideo",
  SetTalkerInfo = "AvgActionSetTalkerInfo",
  PlayScreenEffect = "AvgActionPlayScreenEffect",
  SetOption = "AvgActionSetOption",
  SetCaption = "AvgActionSetCaption",
  PlayDialogEnterAnim = "AvgActionPlayDialogEnterAnim",
  ShowDialogText = "AvgActionShowDialogText",
  ShowOtherAnim = "AvgActionShowOtherAnim",
  EndPrefabAnimation = "AvgActionEndPrefabAnimation",
  ShakeDialog = "AvgActionShakeDialog",
  RoleHurt = "AvgActionRoleHurt",
  PlayCfgEndAnim = "AvgActionPlayCfgEndAnim",
  AvgRole = "AvgActionAvgRole",
  ExitRoleEffect = "AvgActionExitRoleEffect",
  HideDialogAnim = "AvgActionHideDialogAnim",
  ShowItemAnim = "AvgActionShowItemAnim",
  LongCaption = "AvgActionLongCaption",
  RollCaption = "AvgActionRollCaption",
  AvgNovel = "AvgActionAvgNovel",
  WaterColor = "AvgActionWaterColor",
  RadioDrama = "AvgActionRadioDrama"
}
CommonDefine.AvgRoleAction = {
  EnterAnim = "EnterAnim",
  ShakeAnim = "ShakeAnim",
  HideAnim = "HideAnim",
  HurtEffect = "HurtEffect",
  ExitAnim = "ExitAnim"
}
CommonDefine.AvgScreenEffect = {
  Smoke = "smoke",
  Awake = "awake",
  Retro = "retro",
  Mucus = "mucus",
  Flame = "flame",
  Snow = "snow",
  Rain = "rain",
  Disturb = "disturb",
  DisturbFx = "disturbFx",
  SpeedLine = "speedLine",
  KeyWorkVideo = "keyWorkVideo",
  KeyWorkEffect = "keyWorkEffect",
  ContinueShake = "continueShake",
  WhiteSmoke = "whiteSmoke",
  WhiteSmokeFall = "whiteSmokeFall",
  WhiteSmokeFallLoop = "whiteSmokeFallLoop",
  LightRain = "lightRain",
  OldFilm = "oldFilm",
  RedScreen = "redScreen",
  CloseEye = "closeEye",
  RedFlower = "redFlower",
  BlackFlower = "blackFlower",
  BloodSmoke = "bloodSmoke",
  BlackSmoke = "blackSmoke",
  RedLoop = "redLoop",
  BlinkEye = "blinkEye",
  StarLight = "starlight",
  LampLight = "lamplight",
  SandStorm = "sandStorm",
  Erosion = "erosion"
}
CommonDefine.AvgScreenEffectAni = {
  Awake = "UI_Story_Effect_yanjing_vx",
  CloseEye = "UI_Story_Effect_yanjingClose_vx",
  BlinkEye = "UI_Story_Effect_yanjingBlink_vx"
}
CommonDefine.ScreenEffectVideoPath = {
  [CommonDefine.AvgScreenEffect.Mucus] = {
    "Slime_01_Normal.mp4",
    "Slime_01_Alpha.mp4",
    true
  },
  [CommonDefine.AvgScreenEffect.KeyWorkVideo] = {
    "Avg/UI_Key_Work_rgb.mp4",
    "Avg/UI_Key_Work_alpha.mp4",
    false
  }
}
CommonDefine.AvgFontSize = 44
CommonDefine.PrefabFold = "Portrait/Portrait_Prefab/"
CommonDefine.AvgDialogPlayerId = 1001
CommonDefine.AvgMalePlayerRes = "SpChar_PlayerM_NF"
CommonDefine.AvgFemalePlayerRes = "SpChar_PlayerF_NF"
CommonDefine.AvgRoleExitTime = 1
CommonDefine.FadeInStayTime = 1
CommonDefine.ShowCommonTipsLimit = 4
CommonDefine.AvgRolePos = {
  Left = 1,
  Middle = 2,
  Right = 3
}
CommonDefine.AvgRoleType = {
  Normal = "AvgNormal",
  Vertical = "AvgVertical",
  Horizontal = "AvgHorizontal",
  Big = "AvgBig"
}
CommonDefine.AvgRoleShakeDirection = {Horizontal = 0, Vertical = 1}
CommonDefine.AvgVideoStartTime = 0
CommonDefine.AvgVideoEndTime = -1
CommonDefine.AwakerChatType = {
  AwakerText = 1,
  PlayerText = 2,
  PlayerEmoj = 3,
  AwakerEmoj = 4,
  WaitBubble = 5
}
CommonDefine.AwakerChatInterval = 0.8
CommonDefine.MaxStageNodeNum = 20
CommonDefine.MaxNodeOptionNum = 10
CommonDefine.UINodeOptionNum = 3
CommonDefine.StageNodeType = {
  None = -1,
  Story = 0,
  Battle = 1,
  Event = 2
}
CommonDefine.StageHideAwardNodeType = 29
CommonDefine.StageStoryState = {
  Unplayed = 0,
  InStartStory = 1,
  FinishStartStory = 2,
  InEndStory = 3,
  FinishEndStory = 4
}
CommonDefine.StageSpecialMode = {SecondMode = 1}
CommonDefine.TaskPage = {
  Career = 1,
  PlayerLevel = 2,
  School = 3,
  Achievement = 4,
  Tutorial = 5,
  AwakerTrial = 6,
  BattleTeaching = 7
}
CommonDefine.DailyTaskPage = {Daily = 1, Weekly = 2}
CommonDefine.DefaultTaskIndex = 100
CommonDefine.TaskType = {
  TaskType_Achivement = "TaskType_Achivement",
  TaskType_Daily = "TaskType_Daily",
  TaskType_Career_Main = "TaskType_Career_Main",
  TaskType_Career_Sub = "TaskType_Career_Sub",
  TaskType_Appoint_Battle = "TaskType_Appoint_Battle",
  TaskType_Appoint_Dispatch = "TaskType_Appoint_Dispatch",
  TaskType_Weekly = "TaskType_Weekly",
  TaskType_Period = "TaskType_Period",
  TaskType_School_Main = "TaskType_School_Main",
  TaskType_School_Sub = "TaskType_School_Sub",
  TaskType_PlayerLevel = "TaskType_PlayerLevel",
  TaskType_AwakerBreakThrough = "TaskType_AwakerBreakThrough",
  TaskType_DailyTask = "TaskType_DailyTask",
  LevelAchievements = "LevelAchievements",
  TaskType_PVPWeekly = "TaskType_PVPWeekly",
  TaskType_PVPHistory = "TaskType_PVPHistory",
  TaskType_PVPSeason = "TaskType_PVPSeason",
  TaskType_PVPRewardTask_Main = "TaskType_PVPRewardTask_Main",
  TaskType_PVPRewardTask = "TaskType_PVPRewardTask",
  TaskType_DailyChallengeTask = "TaskType_DailyChallengeTask",
  TaskType_DailyChallengeTask_Main = "TaskType_DailyChallengeTask_Main",
  TaskType_CollectionHall = "TaskType_CollectionHall",
  TaskType_RailWay_Main = "TaskType_RailWay_Main",
  TaskType_RailWay = "TaskType_RailWay"
}
CommonDefine.TaskCond = {
  StepNumCountHigh = "StepNumCountHigh",
  StepNumCountLow = "StepNumCountLow",
  CardCountHigh = "CardCountHigh",
  CardCountLow = "CardCountLow",
  EnchantCountHigh = "EnchantCountHigh",
  EnchantCountLow = "EnchantCountLow",
  RelicCountHigh = "RelicCountHigh",
  RelicCountLow = "RelicCountLow",
  BattleNodeCountHigh = "BattleNodeCountHigh",
  BattleNodeCountLow = "BattleNodeCountLow",
  AwakerAppointSchoolBreakLevelNum = "AwakerAppointSchoolBreakLevelNum",
  PlayerLevel = "PlayerLevel",
  DeadCountLow = "DeadCountLow",
  AwakerIn = "AwakerIn",
  AwakerTypeIn = "AwakerTypeIn",
  EXSkillCountLow = "EXSkillCountLow",
  MoneyCountHigh = "MoneyCountHigh",
  AwakerAroNumHigh = "AwakerAroNumHigh",
  TargetCardsCountLow = "TargetCardsCountLow",
  TargetCampCureCountLow = "TargetCampCureCountLow",
  DeathResistTriggerLow = "DeathResistTriggerLow",
  AppointTotalLevel = "AppointTotalLevel"
}
CommonDefine.StageTaskShowType = {
  Common = 1,
  Percent = 2,
  Current = 3
}
CommonDefine.StageStats = {
  StepCount = "StepCount",
  BattleCount = "BattleCount",
  RelicCount = "RelicCount",
  EnchantCount = "EnchantCount",
  CurseCardCount = "CurseCardCount",
  OtherCount = "OtherCount"
}
CommonDefine.AchievementHistoryDataType = {
  AchieveCommemorativeData_Time = "AchieveCommemorativeData_Time",
  AchieveCommemorativeData_Dmg = "AchieveCommemorativeData_Dmg"
}
CommonDefine.AchievementSubTaskType = {
  All = "AchieveType0",
  Growth = "AchieveType1",
  Exploration = "AchieveType2",
  Battle = "AchieveType3",
  Other = "AchieveType4"
}
CommonDefine.AchiSubTaskTypeLang = {
  [CommonDefine.AchievementSubTaskType.All] = "AllAchievement",
  [CommonDefine.AchievementSubTaskType.Growth] = "InvestAchievement",
  [CommonDefine.AchievementSubTaskType.Exploration] = "AwakerAchievement",
  [CommonDefine.AchievementSubTaskType.Battle] = "BattleAchievement",
  [CommonDefine.AchievementSubTaskType.Other] = "OtherAchievement"
}
CommonDefine.BookingTaskTag = "BookTaskTag"
CommonDefine.AchievementTrophyType = {
  Gold = "GoldAchieve",
  Silver = "SilverAchieve",
  Bronze = "CopperAchieve"
}
CommonDefine.WorldEventOptionType = {
  DisplayCardList = 1,
  DisplayPanel = 2,
  DisplayListPanel = 3
}
CommonDefine.CompareType = {
  Equal = 0,
  Greater = 1,
  Less = 2
}
CommonDefine.TaskServerIndex = {
  Appoint = DT.GetConstant("TaskType_Appoint"),
  Daily = DT.GetConstant("TaskType_Daily"),
  Career = DT.GetConstant("TaskType_Career"),
  Common = DT.GetConstant("TaskType_Common"),
  Achivement = DT.GetConstant("TaskType_Achivement"),
  Weekly = DT.GetConstant("TaskType_Weekly"),
  Period = DT.GetConstant("TaskType_Period"),
  School = DT.GetConstant("TaskType_School_Main"),
  PlayerLevel = DT.GetConstant("TaskType_PlayerLevel"),
  AwakerBreakThrough = DT.GetConstant("TaskType_AwakerBreakThrough"),
  DailyTask = DT.GetConstant("TaskType_DailyTask"),
  PVPWeekly = DT.GetConstant("TaskType_PVPWeekly"),
  PVPHistory = DT.GetConstant("TaskType_PVPHistory"),
  PVPSeason = DT.GetConstant("TaskType_PVPSeason"),
  PVPRewardMainTask = DT.GetConstant("TaskType_PVPRewardTask_Main"),
  PVPRewardChildTask = DT.GetConstant("TaskType_PVPRewardTask"),
  DailyChallengeMainTask = DT.GetConstant("TaskType_DailyChallengeTask_Main"),
  DailyChallengeChildTask = DT.GetConstant("TaskType_DailyChallengeTask"),
  RailWayMainTask = DT.GetConstant("TaskType_RailWay_Main"),
  RailWayChildTask = DT.GetConstant("TaskType_RailWay"),
  CollectionHallTask = DT.GetConstant("TaskType_CollectionHall")
}
CommonDefine.TaskType2ServerIndex = {
  [CommonDefine.TaskType.TaskType_Appoint_Battle] = CommonDefine.TaskServerIndex.Appoint,
  [CommonDefine.TaskType.TaskType_Appoint_Dispatch] = CommonDefine.TaskServerIndex.Appoint,
  [CommonDefine.TaskType.TaskType_Daily] = CommonDefine.TaskServerIndex.Daily,
  [CommonDefine.TaskType.TaskType_Career_Main] = CommonDefine.TaskServerIndex.Career,
  [CommonDefine.TaskType.TaskType_Career_Sub] = CommonDefine.TaskServerIndex.Career,
  [CommonDefine.TaskType.TaskType_Achivement] = CommonDefine.TaskServerIndex.Achivement,
  [CommonDefine.TaskType.TaskType_Weekly] = CommonDefine.TaskServerIndex.Weekly,
  [CommonDefine.TaskType.TaskType_Period] = CommonDefine.TaskServerIndex.Period,
  [CommonDefine.TaskType.TaskType_School_Main] = CommonDefine.TaskServerIndex.School,
  [CommonDefine.TaskType.TaskType_School_Sub] = CommonDefine.TaskServerIndex.School,
  [CommonDefine.TaskType.TaskType_PlayerLevel] = CommonDefine.TaskServerIndex.PlayerLevel,
  [CommonDefine.TaskType.TaskType_AwakerBreakThrough] = CommonDefine.TaskServerIndex.AwakerBreakThrough,
  [CommonDefine.TaskType.TaskType_DailyTask] = CommonDefine.TaskServerIndex.DailyTask,
  [CommonDefine.TaskType.TaskType_PVPWeekly] = CommonDefine.TaskServerIndex.PVPWeekly,
  [CommonDefine.TaskType.TaskType_PVPHistory] = CommonDefine.TaskServerIndex.PVPHistory,
  [CommonDefine.TaskType.TaskType_PVPSeason] = CommonDefine.TaskServerIndex.PVPSeason,
  [CommonDefine.TaskType.TaskType_CollectionHall] = CommonDefine.TaskServerIndex.CollectionHallTask
}
CommonDefine.TaskState = {
  UnDone = 1,
  Doing = 2,
  Receive = 9,
  Done = 10
}
CommonDefine.TaskDelegateType = {Battle = 1, Delegate = 2}
CommonDefine.InviteTaskState = {Completed = 10}
CommonDefine.GearItemType = {
  LittleMonster = 1,
  EliteMonster = 2,
  Boss = 3,
  Camp = 4,
  Shop = 5,
  Event = 6,
  Treasure = 7,
  BoxDrop = 8,
  StoneDrop = 9,
  Wall = 10,
  Door = 11,
  Machine = 12,
  Obstacle = 13,
  Transport = 14,
  Born = 15,
  Story = 16,
  Relic = 17,
  MysteryShop = 18,
  SingleTransport = 19,
  RelicShop = 20,
  EnchantShop = 21,
  CustomizeRelicShop = 22,
  CustomizeEnchantShop = 23,
  Beacon = 24,
  HiddenChannel = 26,
  DropTerrain = 27,
  HiddenAward = 29,
  StageGroup_1_Talent = 30,
  StageGroup_2_Talent = 31,
  ShadowEffect = 32,
  ChangeAvatarRes = 33,
  PoisonGas = 34,
  BloodPool = 36,
  SpecialShop = 40
}
CommonDefine.GearBattleType = {
  [CommonDefine.GearItemType.LittleMonster] = true,
  [CommonDefine.GearItemType.EliteMonster] = true,
  [CommonDefine.GearItemType.Boss] = true
}
CommonDefine.GearState = {
  Pending = 1,
  Running = 2,
  Finished = 6
}
CommonDefine.TerrainTriggerType = {
  OnEnter = 1,
  Trigger = 2,
  OnLeave = 3
}
CommonDefine.CardSelectPanelType = {sellCard = 1, enchantCard = 2}
CommonDefine.DropType = {
  Item = 0,
  Drop = 1,
  Relic = 2,
  Enchant = 3,
  Stone = 4
}
CommonDefine.DisplayType = {
  RelicConfig = "RelicConfig",
  EnchantConfig = "EnchantConfig",
  Skill = "Skill"
}
CommonDefine.WorldStageShopItemType = {
  Relic = "Relic",
  Enchant = "Enchant",
  Item = "Item",
  SaleCard = "SaleCard",
  RelieveAbCard = "RelieveAbCard"
}
CommonDefine.StateShowType = {
  Hide = "Hide",
  Normal = "Normal",
  Affix = "Affix",
  Describe = "Describe",
  HideFloatText = "HideFloatText",
  WeaponIconAndDesc = "WeaponIconAndDesc",
  AwakerAffix = "AwakerAffix"
}
CommonDefine.StageMapType = {
  Story = 0,
  Normal = 1,
  OneLine = 2,
  Railway = 3
}
CommonDefine.StageRelicGrid = 8
CommonDefine.StageRelicGridMax = 12
CommonDefine.RelicNumMax = 36
CommonDefine.CommonState = {
  Realy = 1,
  Running = 2,
  Confirm = 8,
  GainPrize = 9,
  Finish = 10
}
CommonDefine.RewardState = {
  Dummy = 0,
  Unavailable = 1,
  Available = 2,
  Received = 3
}
CommonDefine.AffectionRewardState = {CanGain = 1, AlreadyGain = 2}
CommonDefine.EnchantQuality = {
  White = "White",
  Blue = "Blue",
  Orange = "Orange",
  Red = "Red"
}
CommonDefine.CommonItemUIEffectPath = {
  TopGreen = "UI/UI_Common/UI_Common_Prefab/UI_Vx_Item_Greenglow.prefab",
  TopPurple = "UI/UI_Common/UI_Common_Prefab/UI_Vx_Item_Purpleglow.prefab",
  TopBlue = "UI/UI_Common/UI_Common_Prefab/UI_Vx_Item_Blueglow.prefab",
  TopYellow = "UI/UI_Common/UI_Common_Prefab/UI_Vx_Item_Goldenglow.prefab",
  BgYellow = "UI/UI_Common/UI_Common_Prefab/UI_Vx_Item_Goldenglow_02.prefab"
}
CommonDefine.CommonQuality = {
  White = "White",
  Green = "Green",
  Blue = "Blue",
  Purple = "Purple",
  Orange = "Orange",
  Red = "Red",
  Char = "Char",
  UR = "UR"
}
CommonDefine.Quality2CommonItemTopEffectMap = {
  [CommonDefine.CommonQuality.Green] = CommonDefine.CommonItemUIEffectPath.TopGreen,
  [CommonDefine.CommonQuality.Purple] = CommonDefine.CommonItemUIEffectPath.TopPurple,
  [CommonDefine.CommonQuality.Blue] = CommonDefine.CommonItemUIEffectPath.TopBlue,
  [CommonDefine.CommonQuality.Orange] = CommonDefine.CommonItemUIEffectPath.TopYellow
}
CommonDefine.Quality2CommonItemBgEffectMap = {
  [CommonDefine.CommonQuality.Orange] = CommonDefine.CommonItemUIEffectPath.BgYellow
}
CommonDefine.RelicQuality = {Holy = "Holy", Forged = "Forged"}
CommonDefine.WorldStageSpecialShopRefreshType = {RefreshAll = "1", RefreshByColumn = "2"}
CommonDefine.QualitySortID = {
  White = 1,
  Green = 2,
  Blue = 3,
  Purple = 4,
  Orange = 5,
  Red = 6,
  Char = 7,
  UR = 8
}
CommonDefine.QualityTrainValue = {
  White = 0,
  Green = 0,
  Blue = 4,
  Purple = 5,
  Orange = 6,
  Red = 7,
  Char = 8,
  UR = 9
}
CommonDefine.TrainIndex = {
  Level = 3,
  WeaponQuality = 4,
  WeaponLevel = 5,
  WeaponEnhanceLevel = 6,
  WeaponBreakLevel = 7,
  TrinketQuality = 8,
  TrinketLevel = 9,
  TrinketAttrNum = 10,
  TrinketSuitEffectCount = 11
}
CommonDefine.ItemAwardType = {
  First = 0,
  Complete = 1,
  Explore = 2,
  Loot = 3,
  Extra = 4,
  Normal = 5,
  Advance = 6,
  First3Star = 7,
  Shop = 8,
  Battle = 9,
  Hide = 10,
  Achievement = 11,
  FirstMult = 12,
  DoubleOutput = 13,
  DailyFirst = 14,
  Talent = 15,
  BonusCard = 17,
  CoreReward = 18,
  ExpBonus = 19,
  GM = 100
}
CommonDefine.ItemReason = {
  StageMoppingUp = "StageMoppingUp",
  ExpBonus = "ExpBonus",
  UseItem = "UseItem",
  Turntable = "Turntable",
  Task = "Task",
  XGC = "XGC",
  RW = "RW",
  ChapterAward = "ChapterAward",
  MCP = "MCP",
  GmCommand = "GmCommand",
  Arena = "Arena",
  Shop = "Shop",
  Recharge = "Recharge",
  Techonlogy = "Techonlogy",
  Mail = "Mail",
  Questionnaire = "Questionnaire",
  Recasting = "Recasting",
  PlatformMail = "PlatformMail",
  GainStageAchievementRw = "GainStageAchievementRw",
  PlotWorldRet = "PlotWorldRet",
  Home = "Home",
  SpecialSkill = "SpecialSkill",
  UseChooseItem = "UseChooseItem",
  Item = "Item",
  BattlePass = "BattlePass",
  Activity = "Activity",
  Decompose = "Decompose",
  Exchange = "Exchange",
  Share = "Share",
  AwakerGainLikeReward = "AwakerGainLikeReward",
  MoonCard = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  AssistReward = "AssistReward",
  Backtrack = "Backtrack",
  AwakerChipChest = "AwakerChipChest",
  Common = "Common",
  DailyChallengeCut = "DailyChallengeCut",
  AvgCommunicate = "AvgCommunicate",
  Summon = "Summon",
  AutoDecompose = "AutoDecompose",
  WeaponAutoRefine = "WeaponAutoRefine",
  Lottery = "Lottery",
  Weapon = "Weapon",
  GuideNoteExtra = "GuideNoteExtra",
  BattlePassDoubleEx = "BattlePassDoubleEx",
  AwakerInit = "AwakerInit",
  AppointTask = "AppointTask"
}
CommonDefine.ResonanceTagState = {
  Lock = 1,
  Clash = 2,
  Choose = 3,
  UnChoose = 4
}
CommonDefine.StageGroupType = {
  MainCopy = 1,
  MaterialCopy = 2,
  TrinketCopy = 3,
  WeeklyCopy = 5,
  WeeklyCopy2 = 6,
  MainCopyHard = 7,
  Prologue = 8,
  DailyChallenge = 9,
  WeekBoss = 10,
  LargeSubplotNormal = 11,
  LargeSubplotHard = 12,
  LargeSubplotCrazy = 13,
  SmallSubplotNormal = 14,
  SmallSubplotHard = 15,
  SmallSubplotCrazy = 16,
  DisposableSchoolTower = 17,
  AlternationSchoolTower = 18,
  MainCopyCrazy = 19,
  MockCopy = 20,
  AbyssChallenge = 21,
  LakeCity = 23,
  SEWD = 24,
  A24 = 25,
  Vindicate = 27,
  Lily = 28,
  LimitTrial = 4,
  CommonTrial = 101,
  StarTrial = 112,
  SpecialSubplotNormal = 102,
  SpecialSubplotHard = 103,
  SpecialSubplotCrazy = 104,
  LinkageActivityNormal = 105,
  LinkageActivityHard = 106,
  LinkageActivityCrazy = 107,
  OceanBoss = 111,
  BattleTeaching = 120,
  RailWay = 201,
  CopyEntry = 1000
}
CommonDefine.StoryCopy = {
  CommonDefine.StageGroupType.Prologue,
  CommonDefine.StageGroupType.MainCopy,
  CommonDefine.StageGroupType.LargeSubplotNormal,
  CommonDefine.StageGroupType.SmallSubplotNormal,
  CommonDefine.StageGroupType.SpecialSubplotNormal
}
CommonDefine.StageGroupHardModeIndex = {
  Normal = 0,
  Hard = 1,
  Crazy = 2
}
CommonDefine.MainCopyPanelPage = {
  MainChapter = 1,
  SmallSubplot = 2,
  LargeSubplot = 3,
  Vindicate = 4,
  SpecialSubplot = 5,
  LinkageActivity = 6
}
CommonDefine.MainCopyBackGroudBGPath = {
  StageSelectPanel = "Icon/Chaper/Chaper_Bg_%s.png",
  StageGroupSelectItemUnlock = "Icon/Chaper/Chaper_Bg_Small_%s.png",
  StageGroupSelectItemLock = "Icon/Chaper/Chaper_Bg_Small_%s_Dis.png"
}
CommonDefine.TrialType = {
  Normal = 1,
  Limit = 2,
  Star = 3
}
CommonDefine.CardType = {Ability = "Ability"}
CommonDefine.SwipeDirection = {
  SwipeRightToLeft = "SwipeRightToLeft",
  SwipeLeftToRight = "SwipeLeftToRight",
  SwipeDownToUp = "SwipeDownToUp",
  SwipeUpToDown = "SwipeUpToDown"
}
CommonDefine.RoleStateType = {
  Idle = "Idle",
  Move = "Move",
  Jump = "Jump",
  RotMove = "RotMove",
  SmoothMove = "SmoothMove"
}
CommonDefine.RoleDirType = {
  E = "E",
  N = "N",
  NE = "NE",
  NW = "NW",
  S = "S",
  SE = "SE",
  SW = "SW",
  W = "W"
}
CommonDefine.AvailTriggerType = {Click = "Click", Arrive = "Arrive"}
CommonDefine.TriggerShape = {Rect = "Rect", Sphere = "Sphere"}
CommonDefine.TriggerItems = {
  GearTrigger = "GearTrigger",
  GearAudio = "GearAudio",
  GearPreTrigger = "GearPreTrigger",
  Interaction = "Interaction",
  Article = "Article"
}
CommonDefine.RoleAimName = {
  Run_east = "Run_east",
  Run_north = "Run_north",
  Run_northeast = "Run_northeast",
  Run_northwest = "Run_northwest",
  Run_south = "Run_south",
  Run_southeast = "Run_southeast",
  Run_southwest = "Run_southwest",
  Run_west = "Run_west"
}
CommonDefine.NodeType = {
  Born = "Born",
  Event = "Event",
  Npc = "Npc",
  LeftBottom = "LeftBottom",
  RightTop = "RightTop",
  Area = "Area",
  RoadBlock = "RoadBlock",
  CopiesEnterBorn = "CopiesEnterBorn"
}
CommonDefine.GearType = {Boss = 18396}
CommonDefine.AudioBankType = {Bgm = "Bgm", SoundEffct = "SoundEffct"}
CommonDefine.DirCount = {EIGHT = 8, FOUR = 4}
CommonDefine.LocalSaveKey = {
  TalentTree = "TalentTree",
  CheckedTalentList = "CheckedTalentList",
  TalentAllOpen = "TalentAllOpen",
  IsAdvance = "IsAdvance",
  AdvanceIndex = "AdvanceIndex",
  AdvanceId = "AdvanceId",
  ShowADTaskInCopy = "ShowADTaskInCopy",
  ShowADTaskInBattle = "ShowADTaskInBattle",
  AdvanceTaskData = "AdvanceTaskData",
  MapPrefix = "Map",
  RedPoint = "Redpoint_",
  TipDontRemind = "tipsDontRemind",
  AutoStory = "AutoStory",
  LastSelectCopy = "LastSelectCopy",
  ConveyTriggered = "conveyTriggered",
  BattleSpeed = "BattleSpeed",
  WorldStageTeam = "WorldStageTeam",
  MainUIAwakerTid = "MainUIAwakerTid",
  TriggeredGuideList = "TriggeredGuideList",
  DbgCopyTaskFold = "DbgCOpyTaskFold",
  AvgSavedSpeed = "AvgSavedSpeed",
  AvgLastAutoSpeed = "AvgLastAutoSpeed",
  RecoverStoryId = "RecoverStoryId",
  CopyRecoverSettleData = "CopyRecoverSettleData",
  CopyRecoverType = "CopyRecoverType",
  LocalSurveyMailRead = "LocalSurveyMailRead_",
  FirstCompleteStage = "FirstCompleteStage_",
  DailyFirstDispatchRed = "DailyFirstDispatchRed",
  SpecificItemOnceRed = "SpecificItemOnceRed_",
  SkipPlotStageId = "SkipPlotStageId",
  BackTrackOnce = "BackTrackOnce_",
  BattleAssistDailyRefresh = "BattleAssistDailyRefresh",
  DailyChallengeLastId = "DailyChallengeLastId",
  ShopOneKeyPurchaseIds = "ShopOneKeyPurchaseIds",
  BattleTriggeredGuideList = "BattleTriggeredGuideList"
}
CommonDefine.LocalSaveKeyCommon = {
  ServerId = "serverId",
  RecentLoginServerIds = "recentLoginServerIds",
  Account = "account",
  SDKLoginType = "SDKLoginType",
  GMPrefix = "Gm",
  RecentGm = "__recentgm",
  AudioPrefix = "Audio_",
  NewAnnouncement = "newAnnouncement",
  ArtMockRolePrefix = "artMockRole",
  RpgMockRoleAtk = "RpgMockRoleAtk",
  RpgMockRoleDef = "RpgMockRoleDef",
  RpgMockBattleId = "RpgMockBattleId",
  GameAuto = "GameAuto",
  SystemSetting = "SystemSetting_",
  IsAutoBattle = "IsAutoBattle",
  PreviewVideo = "PreviewVideo",
  ShowLogConsole = "ShowLogConsole",
  StageExploreBgm = "StageExploreBgm",
  AVGTutorial = "AVGTutorial",
  PvVideo = "PvVideo",
  PvMusic = "PvMusic",
  PvCaption = "PvCaption",
  AutoPvPlayCount = "AutoPvPlayCount",
  ManualPvVideo = "ManualPvVideo",
  ManualPvMusic = "ManualPvMusic",
  ManualPvCaption = "ManualPvCaption",
  BeforeLoginAvgId = "BeforeLoginAvgId",
  PlayedPvIdList = "PlayedPvIdList",
  LastLoginAccount = "LastLoginAccount",
  LastPassedStageId = "LastPassedStageId"
}
local Z1Const = CS.FrameWork.Z1Const
if Z1Const and Z1Const.IsSteam and Z1Const.IsSteam() then
  CommonDefine.LocalSaveKeyCommon.SystemSetting = "Steam" .. CommonDefine.LocalSaveKeyCommon.SystemSetting
end
CommonDefine.MiniMapShowType = {
  Hide = "Hide",
  NormalShow = "NormalShow",
  AlwaysShow = "AlwaysShow"
}
CommonDefine.EventType = {
  None = "None",
  Exit = "Exit",
  Loot = "Loot",
  Story = "Story",
  Shop = "Shop",
  Rest = "Rest",
  BattleNormal = "NormalBattle",
  BattleElite = "EliteBattle",
  BattleBoss = "BossBattle",
  Survey = "Survey",
  Convey = "Convey",
  GiveUp = "GiveUp",
  Delivery = "Delivery"
}
CommonDefine.HitBoxType = {Click = "Click", Arrive = "Arrive"}
CommonDefine.RunningStateType = {
  Awake = "Awake",
  Running = "Running",
  End = "End"
}
CommonDefine.ExcelBoolType = {TRUE = 1, FALSE = 0}
CommonDefine.DirectionDefine = {
  RightTop = "RightTop",
  LeftTop = "LeftTop",
  RightBottom = "RightBottom",
  LeftBottom = "LeftBottom"
}
CommonDefine.TextColorDefine = {
  Gray = "#AAAAAA",
  White = "#FFFFFF",
  Black = "#000000",
  Blue = "#6BACE5",
  Red = "#FF0000",
  Green = "#00FF00",
  TrinketBindBonus = "#f5df94"
}
CommonDefine.RankTitleColor = {
  Blue = "#a6c4e7",
  Purple = "#e0bee8",
  Yellow = "#f5e5bc"
}
CommonDefine.Color = {
  Content = "#ffffff",
  Title = "#d8d5b9",
  Info = "#909395",
  Positive = "#189a9f",
  Negative = "#e25312"
}
CommonDefine.StoryDirctionType = {
  GiveDirction = "GiveDirction",
  SelectNpc = "SelectNpc"
}
CommonDefine.StoryEffectPosType = {
  ActorHead = "ActorHead",
  ActorFoot = "ActorFoot",
  ScenePos = "ScenePos",
  ScreenPos = "ScreenPos"
}
CommonDefine.StoryNodeName = {
  ActorDirction = "ActorDirction",
  ActorMove = "ActorMove",
  ActorPlayAnim = "ActorPlayAnim",
  CameraGroup = "CameraGroup",
  CameraShake = "CameraShake",
  CreateNpc = "CreateNpc",
  DeleteNpc = "DeleteNpc",
  Dialog = "Dialog",
  Option = "Option",
  PlayCG = "PlayCG",
  PlayEffect = "PlayEffect",
  PlayVioce = "PlayVioce",
  ResetCamera = "ResetCamera",
  StopEffect = "StopEffect"
}
CommonDefine.StoryDialogType = {
  UIDialog = "UIDialog",
  NPCDialog = "NPCDialog",
  SideDialog = "SideDialog",
  MaskDialog = "MaskDialog",
  HalfMaskDialog = "HalfMaskDialog",
  CGDialog = "CGDialog",
  None = "None",
  DynamicComic = "DynamicComic",
  SceneDialog = "SceneDialog"
}
CommonDefine.SceneCameraAni = {
  Revert = "Revert",
  Shake = "Shake",
  Zoom = "Zoom",
  ZoomIn = "ZoomIn",
  ZoomOut = "ZoomOut",
  Stop = "Stop"
}
CommonDefine.SpineBoneEnum = {Body = "Body", Head = "Head"}
CommonDefine.AwakerSchool = {
  Aequor = 1,
  Caro = 2,
  Dimension = 3,
  NewAequor = 4
}
CommonDefine.BattleAwakerTid = {Saye = 130226}
CommonDefine.AssetType = {
  Sprite = "png",
  Prefab = "prefab",
  ScritableData = "asset",
  Material = "mat",
  Bytes = "bytes",
  Text = "txt",
  AudioClip = "mp3",
  VideoClip = "video",
  SpineData = "asset"
}
CommonDefine.GearIconPos = {Point = 0, Npc = 1}
CommonDefine.LoadSceneModeType = {Single = 0, Additive = 1}
CommonDefine.MaxWeaponLevel = 15
CommonDefine.ItemType = {
  Currency = 1,
  CopiesItem = 2,
  TrainItem = 3,
  Consumables = 4,
  Card = 5,
  Relic = 6,
  Rune = 7,
  Weapon = "Weapon",
  Trinket = "Trinket",
  AwakerItem = "AwakerItem",
  TopBarItem = "TopBarItem",
  Material = "Material",
  Special = "Special",
  DropItem = "DropItem",
  Energy = "Energy",
  KeeperSkill = "KeeperSkill",
  AwakerFavor = "AwakerFavor",
  SkinItem = "SkinItem"
}
CommonDefine.ItemSubType = {
  AwakerChip = "AwakerChip",
  Weapon = "Weapon",
  TrinketMaterial = "TrinketMaterial",
  ResonanceParticle = "ResonanceParticle",
  SkillMaterial = "SkillMaterial",
  StoryItem = "StoryItem",
  SpecialMaterial = "SpecialMaterial",
  Trinket = "Trinket",
  ConsumeItem = "ConsumeItem",
  Awaker = "Awaker",
  FastPromotion = "FastPromotion",
  Chest = "Chest",
  AwakerChest = "AwakerChest",
  WeaponChest = "WeaponChest",
  TrinketDropItem = "TrinketDropItem",
  TopBarItem = "TopBarItem",
  PlayerAvatar = "PlayerAvatar",
  BackTrack = "Backtrack",
  AwakerChipChest = "AwakerChipChest",
  Emoji = "Emoji",
  GenderDifference = "GenderDifference",
  TrinketChip = "TrinketChip",
  TrinketRefineLock = "TrinketRefineLock",
  AvatarFrame = "AvatarFrame",
  ExpBonus = "ExpBonus",
  CosmeticsRandChest = "CosmeticsRandChest",
  CosmeticsChest = "CosmeticsChest",
  SkinVoucher = "SkinVoucher",
  AwakerRandomChest = "AwakerRandomChest",
  WeaponRandomChest = "WeaponRandomChest",
  AwakerSkin = "AwakerSkin",
  MultiSelectChest = "MultiSelectChest",
  WeaponChestChip = "WeaponChestChip",
  AwakerChestChip = "AwakerChestChip",
  ActivityShowDropItem = "ActivityShowDropItem"
}
CommonDefine.ShowAvatarPreviewType = {
  [CommonDefine.ItemSubType.CosmeticsRandChest] = true,
  [CommonDefine.ItemSubType.CosmeticsChest] = true
}
CommonDefine.ShowAvatarPreviewType = {
  [CommonDefine.ItemSubType.CosmeticsRandChest] = true,
  [CommonDefine.ItemSubType.CosmeticsChest] = true
}
CommonDefine.SuitType = {
  Full = 1,
  TwoHalf = 2,
  OneHalf = 3,
  None = 4
}
CommonDefine.BackTrackType = {
  NormalAwaker = "NormalAwaker",
  UniqueAwaker = "UniqueAwaker",
  Weapon = "Weapon"
}
CommonDefine.BackTrackOpenType = {
  NotOpen = 0,
  FreeOpen = 1,
  ItemOpen = 2,
  GmOpen = 3
}
CommonDefine.BackTrackUseStateBit = {
  NotUse = 0,
  UsedBackLevel = 1,
  UsedBackPotency = 2
}
CommonDefine.BackTrackAwakerType = {
  Level = "LEVEL_UP",
  Break = "BREAK",
  Skill = "SKILL",
  Talent = "TALENT",
  Potency = "POTENCY",
  PotencyLevelReset = "POTENCY_LEVEL_RESET",
  Black = "REMOVE"
}
CommonDefine.BackTrackWeaponType = {Weapon = "WEAPON", Advance = "ADVANCE"}
CommonDefine.DropFilterType = {NoAwaker = "NoAwaker", NoItem = "NoItem"}
CommonDefine.ItemDispatch = System.NewEnum({
  Currency = "Currency",
  Stackable = "Stackable",
  Trinket = "Trinket",
  Weapon = "Weapon"
})
CommonDefine.ItemTypeDispatch = {
  [CommonDefine.ItemType.TopBarItem] = CommonDefine.ItemDispatch.Currency,
  [CommonDefine.ItemType.Material] = CommonDefine.ItemDispatch.Stackable,
  [CommonDefine.ItemType.Special] = CommonDefine.ItemDispatch.Stackable,
  [CommonDefine.ItemType.DropItem] = CommonDefine.ItemDispatch.Stackable,
  [CommonDefine.ItemType.Trinket] = CommonDefine.ItemDispatch.Trinket,
  [CommonDefine.ItemType.Weapon] = CommonDefine.ItemDispatch.Weapon,
  [CommonDefine.ItemType.Energy] = CommonDefine.ItemDispatch.Currency,
  [CommonDefine.ItemType.KeeperSkill] = CommonDefine.ItemDispatch.Stackable
}
CommonDefine.FastPromotionSpParamKey = {
  RequiredPlayerLevel = "RequiredPlayerLevel",
  AvailableAwaker = "AvailableAwaker",
  DirectPromotionLevel = "DirectPromotionLevel",
  DirectSkillPromotionLevel = "DirectSkillPromotionLevel",
  DirectBreakthroughStage = "DirectBreakthroughStage",
  BreakthroughSkill1Unlocked = "BreakthroughSkill1Unlocked",
  BreakthroughSkill2Unlocked = "BreakthroughSkill2Unlocked"
}
CommonDefine.ItemChooseType = {
  None = 1,
  Single = 2,
  Multiple = 3
}
CommonDefine.ItemDataSourceType = {Runtime = 1, Config = 2}
CommonDefine.MoneyVariable = {
  SeniorMoney = "SeniorMoney",
  MiddleMoney = "MiddleMoney",
  JuniorMoney = "JuniorMoney",
  CopiesMoney = "PhiloStone",
  ExclusiveMoney = "ExclusiveCardMoney"
}
CommonDefine.SortOrder = {Ascend = "Ascend", Descend = "Descend"}
CommonDefine.FollowSortOrder = {
  LastOnlineTimeAsc = {
    feq = "LastOnlineTime",
    order = CommonDefine.SortOrder.Ascend,
    ops = "LastOnlineTimeDesc"
  },
  LastOnlineTimeDesc = {
    feq = "LastOnlineTime",
    order = CommonDefine.SortOrder.Descend,
    ops = "LastOnlineTimeAsc"
  },
  ClientLevelAsc = {
    feq = "ClientLevel",
    order = CommonDefine.SortOrder.Ascend,
    ops = "ClientLevelDesc"
  },
  ClientLevelDesc = {
    feq = "ClientLevel",
    order = CommonDefine.SortOrder.Descend,
    ops = "ClientLevelAsc"
  },
  AwakerLevelAsc = {
    feq = "AwakerLevel",
    order = CommonDefine.SortOrder.Ascend,
    ops = "AwakerLevelDesc"
  },
  AwakerLevelDesc = {
    feq = "AwakerLevel",
    order = CommonDefine.SortOrder.Descend,
    ops = "AwakerLevelAsc"
  }
}
CommonDefine.InteractionRemoveType = {
  StayNotDestory = "StayNotDestory",
  OutEyes = "OutEyes",
  AlwaysStay = "AlwaysStay"
}
CommonDefine.InteractionState = {Finish = 0, Idle = 1}
CommonDefine.InteractionParamType = {
  Awakers = "Awakers",
  Talent = "Talent",
  EnterGamecopy = "EnterGamecopy",
  EnterGamecopyPanel = "EnterGamecopyPanel",
  TeamPanel = "TeamPanel",
  ChooseRelic = "ChooseRelic",
  ChooseCard = "ChooseCard",
  Bag = "Bag",
  Task = "TaskPanel",
  Tower = "Tower"
}
CommonDefine.NPC_RANGE_STATE = {
  NONE = 0,
  LONG = 1,
  MIDDLE = 2,
  SHORT = 3
}
CommonDefine.NPC_DEFAULT_DISTANCE = {
  LONG = 16,
  MIDDLE = 8,
  SHORT = 3
}
CommonDefine.CourseLevelState = {
  Normal = 0,
  CanFinish = 1,
  Finish = 10
}
CommonDefine.AwakersSkillActiveType = {Passive = 0, Initiative = 1}
CommonDefine.CurrencyType = {
  SeniorMoney = DT.GetConstant("DiamondItemTid"),
  PayMoney = DT.GetConstant("DiamondChargeItemTid"),
  FreePayMoney = DT.GetConstant("DiamondBindItemTid"),
  JuniorMoney = DT.GetConstant("GoldItemTid"),
  AwakerUpgradeExp = 9916,
  Ticket = 5,
  ResidentSummonMoney = 9719,
  SpecialSummonMoney = 9802,
  TechAccelerateTicket = DT.GetConstant("Tech_Research_SpeedUpItem"),
  SummerChapter1Ticket = DT.GetConstant("SummerChapter1Ticket"),
  StageGroupUnlockItemTid = DT.GetConstant("KeysItemIndex"),
  SkinTicket = 84249,
  SummonGiftMoney = 9615,
  CopiesMoney = 100,
  ExclusiveMoney = 101,
  Energy = 9578,
  PlayerExp = 9556,
  BpExp = 9607,
  AwakerLike = 10056,
  ResearchMoney = 18,
  InvitationCoin = 91157,
  FavorBreakThroughTicket = DT.GetConstant("FavorBreakThroughItemTid")
}
CommonDefine.CommonIconExtraDescBgType = {Default = "Default", Blue = "Blue"}
CommonDefine.ExtraDescBgType2GoNameMap = {
  [CommonDefine.CommonIconExtraDescBgType.Default] = "Group_Tab_Special_Bg_Default",
  [CommonDefine.CommonIconExtraDescBgType.Blue] = "Group_Tab_Special_Bg_Blue"
}
CommonDefine.SettingID = {AutoLockSR = 18435, AutoLockSSR = 18447}
CommonDefine.BtnType = {
  High = "High",
  Normal = "Normal",
  Disabled = "Disabled",
  Unclickable = "Unclickable"
}
CommonDefine.Z1ButtonState = {
  Default = Z1ButtonState.Default,
  Unclickable = Z1ButtonState.Unclickable,
  Normal = Z1ButtonState.Normal,
  High = Z1ButtonState.High
}
CommonDefine.PerformanceLevel = {
  Level1 = 0,
  Level2 = 1,
  Level3 = 2
}
CommonDefine.RelicOperationType = {
  RemoveSelectedRelic = 0,
  TransformSelectedRelicToRelic = 1,
  RandomTransformSelectedRelic = 2,
  TransformSelectRelicToSelectRelic = 3
}
CommonDefine.CardOperationType = {
  Gain = 1,
  Remove = 2,
  Upgrade = 3,
  Transform = 4,
  Duplicate = 5
}
CommonDefine.AudioTriggerType = {
  DefaultTrigger = "DefaultTrigger",
  ScopeTrigger = "ScopeTrigger",
  CounterTrigger = "CounterTrigger"
}
CommonDefine.EnergySourceType = {
  CopyBack = "CopyBack",
  Item = "Item",
  Restore = "Restore",
  LvUp = "LvUp"
}
CommonDefine.CourseSubTaskState = {
  Lock = 1,
  Running = 2,
  CanFinish = 9,
  Finish = 10
}
CommonDefine.CourseSubTaskRecordState = {UnLock = 1, Finish = 10}
CommonDefine.CourseStoryLineAwardState = {
  Normal = 0,
  CanFinish = 1,
  Finish = 10
}
CommonDefine.MainCopyAchieveState = {
  NotAchieved = 0,
  IsFinish = 1,
  IsGot = 2
}
CommonDefine.CardSyncType = {Add = "add", Update = "update"}
CommonDefine.RedDotType = {
  Dot = 1,
  Num = 2,
  TextNew = 3
}
CommonDefine.FeatureUnlockType = {
  CopiesArea = 1,
  CopiesStoryLine = 2,
  Copies = 3,
  CopiesPlotMopping = 4,
  CopiesAdvance = 5,
  DailyCopies = 6,
  DialyCopyLevel = 7
}
CommonDefine.CourseChapterAwardState = {
  Normal = 0,
  CanFinish = 1,
  Finish = 10
}
CommonDefine.BtnAniTrigger = {Appear = "Chuxian", Click = "Dianji"}
CommonDefine.ColorType = {
  Dark = "Dark",
  Normal = "Normal",
  NormalLow = "NormalLow",
  Light = "Light"
}
CommonDefine.AwakerName = "AwakerName"
CommonDefine.BuildingStatus = {
  Idle = 1,
  Working = 2,
  Finish = 3
}
CommonDefine.ComicAuto = {
  Never = -1,
  Forever = 1,
  Normal = 0
}
CommonDefine.TipsType = {
  PopMsg = 1,
  AlertConfirm = 2,
  SideMsg = 3,
  ToolTips = 7,
  FeatureBottomTips = 8
}
CommonDefine.ExitGameConfirmTipTid = 20099
CommonDefine.TaskConditionIcon = {
  IsAchieveIcon = "UIResources/AtlasSource/UI_Common_Image/UI_Common_Image_Tick2.png",
  NotAchieveIcon = "UIResources/AtlasSource/HD/UI_Common_Image/UI_Common_D_Image_Ban_Icon.png"
}
CommonDefine.TaskConditionTextColor = {IsAchieveColor = "#93D1A0", NotAchieveColor = "#ACBFCA"}
CommonDefine.TaskExtraCond = {
  BoughtShopItem = "BoughtShopItem",
  BoughtShopItemEvent = "BoughtShopItemEvent"
}
CommonDefine.TaskCommonState = {
  Lock = 1,
  Running = 2,
  CanFinish = 9,
  Finish = 10
}
CommonDefine.TaskAwardState = {
  Running = 0,
  CanFinish = 1,
  Finish = 10
}
CommonDefine.TaskExtraAwardType = {
  AppointTotalLevel = "AppointTotalLevel"
}
CommonDefine.TaskUnlockCondType = {
  SpecificFeatureUnlock = "SpecificFeatureUnlock",
  CompleteTask = "CompleteTask",
  PlayerLevel = "PlayerLevel",
  StageFirstClear = "StageFirstClear",
  HaveSpecificItem = "HaveSpecificItem"
}
CommonDefine.PvPBuildTagType = {
  All = "All",
  Chaos = "Chaos",
  Ocean = "Ocean",
  Blood = "Blood",
  Dimension = "Dimension",
  KeeperSkill = "KeeperSkill",
  Weapon = "Weapon"
}
CommonDefine.AwakersRecordState = {
  Lock = 1,
  CanUnlock = 2,
  Unlock = 3
}
CommonDefine.DefaultSkinTid = 0
CommonDefine.SkinReplace = {
  BattleEffect = 0,
  BattleSpine = 1,
  BattleAudio = 2,
  BattleTalk = 3,
  BattleCard = 4
}
CommonDefine.AwakerRedUpdateDelay = 0.3
CommonDefine.ConveyGroupState = {
  NotTrigger = 1,
  Triggering = 2,
  TriggerEnd = 3
}
CommonDefine.AvgComposeItemState = {
  Locked = 1,
  Lacked = 2,
  Enabled = 3
}
CommonDefine.NpcFuncTipsType = {RedPoint = 1, Bubble = 2}
CommonDefine.MiniMapCourseTaskType = {Running = 1, Finish = 2}
CommonDefine.AwakerSkillSlot = {
  Slot_Super = 1,
  Slot_Strike = 2,
  Slot_Defend = 3,
  Slot_Awake = 4,
  Slot_Skill1 = 5,
  Slot_Skill2 = 6
}
CommonDefine.PortraitType = {
  Full = "Full",
  Middle = "Middle",
  Middleface = "Middleface",
  Miniface = "Miniface",
  Minihead = "Minihead",
  Circularhead = "Circularhead"
}
CommonDefine.PortraitAlign = {
  HorizontalCenter = 1,
  VerticalCenter = 2,
  Center = 3
}
CommonDefine.AFNF = {AF = "AF", NF = "NF"}
CommonDefine.TrinketCountToASuit = 4
CommonDefine.TypeAwakerSkill = "Slot_Awake"
CommonDefine.AwakerSkillUnlockType = {
  Default = 1,
  Advance = 2,
  Potency = 3
}
CommonDefine.SkillNumType = {Percent = 1}
CommonDefine.CopyAwardType = {
  NormalBattle = 1,
  Elite = 2,
  Boss = 3
}
CommonDefine.MonsterClass = {
  Common = "Common",
  Elite = "Elite",
  Boss = "Boss"
}
CommonDefine.FeatureId = {
  Tower = "Tower",
  Building = "Building",
  DailyCopy = "DailyCopy",
  Talent = "Talent",
  HardCopy = "HardCopy",
  Arena = "Arena",
  MoneyLevel = "MoneyLevel",
  BattleGround = "BattleGround",
  Dungeons = "Dungeons",
  Ruins = "Ruins",
  MainCopy = "MainCopy",
  MainCopyHard = "MainCopyHard",
  MainCopyCrazy = "MainCopyCrazy",
  FirstChapterFinish = "FirstChapterFinish",
  DrawCard = "DrawCard",
  Shop = "Shop",
  ResCopy = "DailyMaterial",
  TrinketCopy = "TrinketCopy",
  DailyChallenge = "DailyChallenge",
  WeekChallenge = "WeekChallenge",
  Task = "Task",
  Home = "Home",
  Institute = "Institute",
  Mail = "Mail",
  ItemConversion = "ItemConversion",
  Compose = "Compose",
  Decompose = "Decompose",
  TrinketDecompose = "TrinketDecompose",
  ItemDecompose = "ItemDecompose",
  Recast = "Recast",
  Exchange = "Exchange",
  DBGCopyGroup = "DBGCopyGroup",
  BattlePass = "BattlePass",
  SpecialSkillList = "SpecialSkillList",
  AlternationSchoolTower = "AlternationSchoolTower",
  MaterialDecompose = "MaterialDecompose",
  Manual = "Manual",
  Friends = "Friends",
  Guild = "Guild",
  Tutorial = "Tutorial",
  WeekBossChallenge = "WeekBossChallenge",
  LargeSubplot = "LargeSubplot",
  LargeSubplotHard = "LargeSubplotHard",
  LargeSubplotCrazy = "LargeSubplotCrazy",
  SmallSubplot = "SmallSubplot",
  SmallSubplotHard = "SmallSubplotHard",
  SmallSubplotCrazy = "SmallSubplotCrazy",
  KeeperSkill = "KeeperSkill",
  Activity = "Activity",
  LargeSubplotTab = "LargeSubplotTab",
  SmallSubplotTab = "SmallSubplotTab",
  TrinketLevelUp = "TrinketLevelUp",
  TrinketConversion = "TrinketConversion",
  AwakerSkillLevel = "AwakerSkillLevel",
  MainWeapon = "MainWeapon",
  SecondaryWeapon = "SecondaryWeapon",
  PVP = "PVP",
  MockBattle = "MockBattle",
  DailyTask = "DailyTask",
  AbyssChallenge = "AbyssChallenge",
  WandaActivity = "WandaActivity",
  SalvadorActivity = "SalvadorActivity",
  TwentyFourActivity = "A24Activity",
  MagicStoryActivityReproduce = "MagicStoryActivityReproduce",
  ResidentTrial = "ResidentTrial",
  ThaisActivity = "ThaisActivity",
  CollectionHall = "CollectionHall",
  CollectionStory = "CollectionStory",
  CollectionPicture = "CollectionPicture",
  CollectionOST = "CollectionOST",
  CollectionCharacter = "CollectionCharacter",
  CollectionEvent = "CollectionEvent",
  CollectionRelic = "CollectionRelic",
  CollectionWeapon = "CollectionWeapon",
  CollectionTrinket = "CollectionTrinket",
  ConfessionEvent = "ConfessionEvent",
  SpecialSubplotTab = "SpecialSubplotTab",
  CollaborationSubplotTab = "CollaborationSubplotTab",
  SpecialSubplot = "SpecialSubplot",
  Communicator = "Communicator",
  QuickClear = "QuickClear",
  PopUp = "PopUp",
  AutoSynthesis = "AutoSynthesis",
  AutoReplacement = "AutoReplacement",
  FriendInvitation = "FriendInvitation",
  GuideNote = "GuideNote",
  GuideNote_DailyTask = "GuideNote_DailyTask",
  GuideNote_WeekTask = "GuideNote_WeekTask",
  BattleTeaching = "BattleTeaching",
  GuideNoteSeason = "GuideNote_Season",
  RailWayActivity = "RailWayActivity",
  TrinketBind = "TrinketBind"
}
CommonDefine.ScrollSensitivity = 50
CommonDefine.WorldStorySubFeature = {
  History = 1,
  Organization = 2,
  Concept = 3
}
CommonDefine.PictureSubFeature = {
  MainCG = 1,
  SceneCG = 2,
  PV = 3,
  Activity = 4,
  RadioDrama = 5
}
CommonDefine.OSTSubFeature = {
  OST1 = 1,
  OST2 = 2,
  OST3 = 3
}
CommonDefine.RoleSubFeature = {Role = 1}
CommonDefine.ArtCollectUnlockType = {
  AvgFirstTrigger = "AnyAvgFirstTrigger"
}
CommonDefine.CommunicateType = {
  Option = "DialogType4"
}
CommonDefine.ArtCollectSort = {Unlock = 0, BaseSortId = 1}
CommonDefine.AVGTutorialKeyWord = {
  AbyssChallengeRule = "AbyssChallengeRule",
  KarenActivityFirstOpen = "KarenActivityFirstOpen"
}
CommonDefine.ClientDataMainKey = {
  Client = "Client",
  Assist = "AssistFilter",
  AwakerFilter = "AwakerFilter",
  AVG_Feature = "AVG_Feature",
  AVG = "AVG",
  AVG_Review = "AVG_Review",
  AVG_Review_Story = "AVG_Review_Story",
  AVG_ONCE = "AVG_ONCE",
  FeatureFirstOpen = "FeatureFirstOpen",
  FirstClearGoodsFirstOpen = "FirstClearGoodsFirstOpen",
  ActivityTaskGroupFirstOpen = "ActivityTaskGroupFirstOpen",
  ShortCut = "ShortCut",
  ShortCutReseted = "ShortCutReseted",
  LimitGoodFirstOpen = "LimitGoodFirstOpen",
  Toggle = "Toggle",
  TipsDontMind = "TipsDontMind",
  TipsDontMindFunc = "TipsDontMindFunc",
  OpenIllustrate = "OpenIllustrate",
  PopupAd = "PopupAd",
  NewbieGuide = "NewbieGuide",
  NewbieGuideCount = "NewbieGuideCount",
  NewObtainSkin = "NewObtainSkin",
  PoolGroupRecord = "PoolGroupRecord",
  PvpPwdRejectUidTimes = "PvpPwdRejectUidTimes",
  StageEntered = "StageEntered",
  Setting = "Setting",
  SettingRange = "SettingRange",
  Language = "Language",
  LimitGiftPopUp = "LimitGiftPopUp",
  StageDiff = "StageDiff",
  GM = "GM",
  LoginByMonthActivityPopup = "LoginByMonthActivityPopupStamp",
  BackTrack = "BackTrack",
  TimeLimitedLuckyBagGroupFirstOpen = "TimeLimitedLuckyBagGroupFirstOpen",
  Aniversary2ndInviteTips = "Aniversary2ndInviteTips",
  PvpMatchParam = "PvpMatchParam",
  BattleTeachingStage = "BattleTeachingStage"
}
CommonDefine.ClientSubKey = {
  TrinketTrain = "TrinketTrain",
  GuideNoteAwakerStrengthenExcludeTalent = "GuideNoteAwakerStrengthenExcludeTalent",
  AutoBattle = "AutoBattle",
  DailyChallengeBoardTab = "DailyChallengeBoardTab",
  FirstResummon = "FirstResummon",
  EverFailed = "EverFailed",
  EverDeadResist = "EverDeadResist",
  EventRunePanel = "EventRunePanel",
  CommunityRed = "CommunityRed",
  LoginAvgDialogPopupStamp = "LoginAvgDialogPopupStamp",
  Played2YearReturnAvg = "Played2YearReturnAvg",
  PlayedSkinSummon = "PlayedSkinSummon",
  BattleTrackBackTutorial = "BattleTrackBackTutorial",
  BattleTrackBackNewTag = "BattleTrackBackNewTag",
  LastBattleKey = "LastBattleKey",
  LastBattleCameraId = "LastBattleCameraId",
  CloseBestPromptToday = "CloseBestPromptToday",
  TodayHideDoubleBpTag = "TodayHideDoubleBpTag",
  TimeLimitedLuckyBagGroupFirstOpen_ = "TimeLimitedLuckyBagGroupFirstOpen_",
  PvpMatchIsMatchMachine = "PvpMatchIsMatchMachine",
  PvpMatchIsSpeedFirst = "PvpMatchIsSpeedFirst",
  PvpMatchIsOpenPreBuilt = "PvpMatchIsOpenPreBuilt",
  PvpMatchIsOpenDraft = "PvpMatchIsOpenDraft",
  BindRewardEntryTips = "BindRewardEntryTips"
}
CommonDefine.NewbieGuideFinishState = 0
CommonDefine.DoubleExpActivityTimes = 2
CommonDefine.SvrserWorldType = {
  Copy = "Copy",
  DailyChallenge = "DailyChallenge",
  WeekChallenge = "WeekChallenge",
  Minor = "Minor",
  WeekBossChallenge = "WeekBossChallenge",
  AbyssChallenge = "AbyssChallenge"
}
CommonDefine.SettleWorldType = {
  Copy = "Copy",
  DailyChallenge = "DailyChallenge"
}
CommonDefine.RpgTeamBuildPanelModel = {Normal = 1, ShowOpponent = 2}
CommonDefine.JumpFuncType = {
  AwakerDetail = "AwakerDetail",
  StageNoDetail = "StageNoDetail",
  Stage = "Stage",
  ItemConversion = "ItemConversion",
  Trinket = "Trinket",
  Settings = "Settings",
  MaterialDecompose = "MaterialDecompose"
}
CommonDefine.AwakerJumpPage = {
  Skill = "Skill",
  Level = "Level",
  Trinket = "Trinket",
  Weapon = "Weapon"
}
CommonDefine.AwakerPanelState = {
  BigHead = "BigHead",
  MiniHead = "MiniHead",
  Detail = "Detail",
  Close = "Close"
}
CommonDefine.AwakerPageAction = {
  Open = "Open",
  Close = "Close",
  EnterDetail = "EnterDetail",
  ExitDetail = "ExitDetail"
}
CommonDefine.AwakerPage = {
  Quit = 0,
  List = 1,
  Detail = 2,
  Skill = 3,
  Potency = 4,
  Weapon = 5,
  Trinket = 6,
  Story = 7,
  SkillDetail = 8,
  WeaponRefine = 9,
  WeaponChange = 10,
  PotencyDetail = 11,
  TrinketChange = 12,
  TrinketStrengthen = 13,
  StoryDetail = 14,
  VoiceDetail = 15,
  Breakthrough = 16,
  WeaponEnhance = 17,
  NewLevelUp = 18,
  LevelLimitIncrease = 19,
  BackTrack = 20,
  Talent = 21,
  TalentDetail = 22,
  TrinketBind = 23
}
CommonDefine.AwakerTalentType = {
  CrazyOmen = 1,
  AttrPotency = 2,
  AttrTalent = 3
}
CommonDefine.AwakerTalentName = {
  [CommonDefine.AwakerTalentType.CrazyOmen] = "疯狂预兆",
  [CommonDefine.AwakerTalentType.AttrPotency] = "灵塑适性",
  [CommonDefine.AwakerTalentType.AttrTalent] = "内在灵格"
}
CommonDefine.AwakerTalentOrderedType = {
  CommonDefine.AwakerTalentType.CrazyOmen,
  CommonDefine.AwakerTalentType.AttrPotency,
  CommonDefine.AwakerTalentType.AttrTalent
}
CommonDefine.AwakerAttrTalentKey = {
  physique = "Talent_Attr_Lv_physique",
  atk = "Talent_Attr_Lv_atk",
  def = "Talent_Attr_Lv_def"
}
CommonDefine.AwakerWeaponPage = {
  View = 1,
  Refine = 2,
  Change = 2
}
CommonDefine.MaxWeaponLevel = 15
CommonDefine.AwakerState = {NotOwn = 1, Owned = 2}
CommonDefine.AwakerTrinketDetailShowType = {Selected = 1, Equipped = 2}
CommonDefine.AwakerPotencyState = {
  Locked = 1,
  Unlocked = 2,
  Active = 3
}
CommonDefine.AwakerPotencyType = {
  PassiveSkill = "PassiveSkill",
  Attr_Promote = "Attr_Promote"
}
CommonDefine.AwakerPotencyEffectType = {
  Attr_Promote = "Attr_Promote",
  LevelLimit_Promote = "LevelLimit_Promote",
  UtlSkill_Promote = "UtlSkill_Promote",
  ComingSoon = "ComingSoon"
}
CommonDefine.AwakerSkillMode = {DBG = 1, RPG = 2}
CommonDefine.AwakerSkillType = {
  Ulti_Skill = "Ulti_Skill",
  Card_Awake = "Card_Awake",
  Card_Strike = "Card_Strike",
  Card_Defend = "Card_Defend"
}
CommonDefine.AwakerPositionType = {
  Tank = 1,
  Sup = 2,
  Dps = 3
}
CommonDefine.PotencyEffectType = {
  Skill = 1,
  Card = 2,
  Attr = 3
}
CommonDefine.MainShopTypeTag = {
  MoonCard = "MonthlyCard",
  AdvanceDC = "MainShopTypeAdvanceDC",
  DailyChallenge = "DailyChallengeShop",
  GiftBag = "GiftBagShop",
  BattlePassReview = "BattlePass",
  DiamondShop = "DiamondShop",
  SeasonConvert = "SeasonConvert",
  GoldShop = "GoldShop",
  Recharge = "Recharge",
  PVPShop = "PVPShop",
  TowerShop = "TowerShop",
  MainCopyShop = "MainCopyShop",
  ClothersShop = "ClothersShop",
  ActivityShop = "ActivityShop",
  ActivityShop1 = "ActivityShop1",
  ActivityShop2 = "ActivityShop2",
  ActivityShop3 = "ActivityShop3",
  ActivityShop4 = "ActivityShop4",
  ActivityShop5 = "ActivityShop5",
  ReturnCoinShop = "ReturnCoinShop",
  ActivityShop6 = "ActivityShop6",
  ActivityShop7 = "ActivityShop7",
  ActivityShop8 = "ActivityShop8",
  ActivityShop9 = "ActivityShop9",
  ActivityShop10 = "ActivityShop10",
  ActivityShop11 = "ActivityShop11",
  ActivityShop18 = "ActivityShop18",
  DailyFreeGiftBagShop = "DailyFreeGiftBagShop",
  ChangeShop = "ChangeShop",
  LimitedTimeGiftBox = "LimitedTimeGiftBox",
  HiddenShop = "HiddenShop"
}
CommonDefine.ShopUnlockType = {
  PlayerLevelCondition = "PlayerLevelCondition",
  StageFirstClear = "StageFirstClear",
  HaveSpecificItem = "HaveSpecificItem"
}
CommonDefine.MainShopContentItemDescBgType = {Blue = 1, Yellow = 2}
CommonDefine.MatchingLevel = {
  Low = 1,
  Middle = 2,
  High = 3
}
CommonDefine.ChagreType = {
  Recharge = 1,
  MoonCard = 2,
  BP = 3
}
CommonDefine.MonthCardType = {Diamond = "Diamond", Energy = "Energy"}
CommonDefine.GuideEvent = {
  GuideTouchEvent = "GuideTouchEvent",
  GearAppear = "GearAppear",
  GearDone = "GearDone",
  GearTrigger = "GearTrigger",
  GuideRoleMove = "GuideRoleMove",
  GuideCloseShop = "GuideCloseShop",
  GuideTime_FirstPutRune = "GuideTime_FirstPutRune"
}
CommonDefine.GuideBattle = {
  Begin = "Begin",
  Bout = "Bout",
  GuideAwakerRage100 = "GuideAwakerRage100",
  GuideCondBoutBegin = "GuideCondBoutBegin",
  GuideCondKeeperSkillEnergyFull = "GuideCondKeeperSkillEnergyFull",
  GuideBattleUseCard = "GuideBattleUseCard",
  GuideAwakerUseSkill = "GuideAwakerUseSkill",
  FirstRevival = "FirstRevival",
  GuideEndLock = "GuideEndLock",
  OnDeadResistRecord = "OnDeadResistRecord",
  GuideTime_FirstDeadResist = "GuideTime_FirstDeadResist",
  GuideCondOpenedEnemyIntentionView = "GuideCondOpenedEnemyIntentionView",
  GuideCondOceanHide = "GuideCondOceanHide",
  GuideCondOceanModeSwitched = "GuideCondOceanModeSwitched",
  GuideCondBloodSchoolSkillUsed = "GuideCondBloodSchoolSkillUsed",
  GuideCondDimensionSchoolSkillUsed = "GuideCondDimensionSchoolSkillUsed",
  GuideCondBoutFirstCard = "GuideCondBoutFirstCard",
  GuideCondAfterUseUltiSkill = "GuideCondAfterUseUltiSkill",
  GuideCondillustratePanelClose = "GuideCondillustratePanelClose",
  GuideCondAvgEnd = "GuideCondAvgEnd"
}
CommonDefine.GuideEndLockCheck = {
  GuideEndLock_Card_Awaker = "GuideEndLock_Card_Awaker",
  GuideEndLock_Card_Awaker_Keeper = "GuideEndLock_Card_Awaker_Keeper",
  TurnLockCard = "TurnLockCard",
  TurnLockExSkill = "TurnLockExSkill",
  TurnLockPosse = "TurnLockPosse"
}
CommonDefine.GuideGameObjType = {
  CommonillustratePanel = "CommonillustratePanel",
  GuideCompAwakerUltiSkill_1 = "GuideCompAwakerUltiSkill_1",
  GuideCompAwakerUltiSkill_2 = "GuideCompAwakerUltiSkill_2",
  GuideCompAwakerUltiSkill_3 = "GuideCompAwakerUltiSkill_3",
  GuideCompAwakerUltiSkill_4 = "GuideCompAwakerUltiSkill_4",
  GuideCompBloodSchoolSkill = "GuideCompBloodSchoolSkill",
  GuideCompDimensionSchoolSkill = "GuideCompDimensionSchoolSkill",
  GuideCompOceanModeSwtichToDefence = "GuideCompOceanModeSwtichToDefence",
  GuideCompOceanModeSwtichToFrantic = "GuideCompOceanModeSwtichToFrantic",
  GuideCompIntroduceEnemyIntention = "GuideCompIntroduceEnemyIntention"
}
CommonDefine.GuidePos = {
  GO_UP = "GO_UP",
  GO_DOWN = "GO_DOWN",
  GO_CENTER = "GO_CENTER",
  GO_LEFT = "GO_LEFT",
  GO_RIGHT = "GO_RIGHT"
}
CommonDefine.TimeParseType = {
  hms = 1,
  ms = 2,
  hm = 3,
  dhms = 4,
  dhmsEx = 4
}
CommonDefine.SpineDieDissolve = {
  [0] = "AwakerDieParams",
  [1] = "MiniDieParams",
  [2] = "MiddleDieParams",
  [3] = "MiddleDieParams",
  [4] = "BigDieParams"
}
CommonDefine.SpineStoneDissolve = {
  [0] = "AwakerStoneParams",
  [1] = "MiniStoneParams",
  [2] = "MiddleStoneParams",
  [3] = "MiddleStoneParams",
  [4] = "BigStoneParams"
}
CommonDefine.BattleStatsType = {
  DamageDone = "damageDone",
  DamageTaken = "damageTaken",
  Block = "block",
  Heal = "heal"
}
CommonDefine.BattleStatsShowType = {
  Damage = 1,
  Hurt = 2,
  Survival = 3
}
CommonDefine.BattleResult = {Win = 1, Fail = 0}
CommonDefine.BattleFinishOverTime = 10
CommonDefine.ReplayCommandWaitTime = 1.2
CommonDefine.MainNaviTab = {
  Main = "Main",
  Awaker = "Awaker",
  Battle = "Battle",
  Community = "Community",
  Shop = "Shop",
  Summon = "Summon",
  Menu = "Menu"
}
CommonDefine.TutorialTabType = {
  Challenge = "Challenge",
  System = "System",
  Battle = "Battle",
  Awaker = "Awaker",
  All = "All"
}
CommonDefine.TutorialItemState = {
  Receive = 1,
  Done = 2,
  Hide = 100
}
CommonDefine.AwakerEquipPosType = {
  All = 0,
  Left = 1,
  Center = 2,
  Right = 3
}
CommonDefine.AwakerSortType = {
  Level = 1,
  Quality = 3,
  Potency = 4,
  Hp = 5,
  Atk = 6,
  Def = 7,
  Favorability = 10
}
CommonDefine.AttrShowType = {
  AwakerShow = "AwakerShow",
  TrinketShow = "TrinketShow",
  BattleShow = "BattleShow",
  StageShow = "StageShow",
  WeaponShow = "WeaponShow"
}
CommonDefine.AwakerTrinketSortType = {
  CompletionRate = 1,
  Level = 2,
  Quality = 3,
  MaxHpPer = 4,
  AtkPer = 5,
  DefPer = 6,
  Crit = 7,
  CritDamage = 8,
  BlockHealPer = 9,
  DeathResist = 10,
  UltiEnergyInit = 11,
  UltiEnergyPassive = 12,
  UltiEnergyReturn = 13,
  Timestamp = 14
}
CommonDefine.TrinketStrengthenTap = {Upgrade = 0, Conversion = 1}
CommonDefine.TrinketUpgradeType = {One = 0, Max = 1}
CommonDefine.TrinketChoosenType = {SingleTrinket = 0, TrinketSuit = 1}
CommonDefine.AwakerWeaponSortType = {
  Quality = 1,
  Potency = 2,
  Crit = 3,
  CritDamage = 4,
  BlockHealPer = 5,
  UltiEnergyInit = 6,
  UltiEnergyPassive = 7,
  DeathResist = 8,
  Timestamp = 9,
  School = 11
}
CommonDefine.AssistAwakerSortType = {
  Level = "AwakerLevel",
  PotencyLv = "AwakerPotencyLevel",
  Skill = "AwakerSkillLevel",
  TalentLv = "TalentLv",
  WeaponPotency = "WeaponPotency",
  TrinketCompletion = "TrinketCompletion"
}
CommonDefine.SummonPoolType = {
  NormalWeapon = 0,
  LimitWeapon = 1,
  LimitAwaker = 2,
  NormalAwaker = 5,
  Begin = 6,
  ChooseUp = 7,
  LuckyBag = 8,
  NewbiePool = 9,
  MixPool = 10,
  OpenServerPool = 11,
  AwakerWeapon = 12,
  MultiAwakerWeapon = 13,
  WishPool = 14,
  TripleLuckyBag = 15,
  TargetedAwakerWeapon = 16,
  CategorySelect = 17
}
CommonDefine.SummonGroup = {Awaker = 1, Weapon = 2}
CommonDefine.SummonGroupTitle = {
  Weapon = 1,
  Awaker = 2,
  LuckyBag = 8
}
CommonDefine.SummonIntroPage = {
  UP = 1,
  DETAIL = 2,
  INVENTORY = 3,
  HISTORY = 4
}
CommonDefine.SchoolType = {
  Chaos = "Chaos",
  Blood = "Blood",
  Dimension = "Dimension",
  Ocean = "Ocean"
}
CommonDefine.ShoolTypeSortWeight = {
  [CommonDefine.SchoolType.Chaos] = 4,
  [CommonDefine.SchoolType.Ocean] = 3,
  [CommonDefine.SchoolType.Blood] = 2,
  [CommonDefine.SchoolType.Dimension] = 1
}
CommonDefine.SchoolId = {
  Choas = 1,
  Blood = 2,
  Dimension = 3,
  Ocean = 4
}
CommonDefine.SchoolLimitType = {
  None = "None",
  ContainOneKind = "ContainOneKind",
  RequireTwoKind = "RequireTwoKind",
  JustOneKind = "JustOneKind"
}
CommonDefine.SchoolIconMix = {
  [CommonDefine.SchoolId.Choas * CommonDefine.SchoolId.Ocean] = "Icon/Career/Icon_CareerDouble_1.png",
  [CommonDefine.SchoolId.Choas * CommonDefine.SchoolId.Blood] = "Icon/Career/Icon_CareerDouble_2.png",
  [CommonDefine.SchoolId.Choas * CommonDefine.SchoolId.Dimension] = "Icon/Career/Icon_CareerDouble_3.png",
  [CommonDefine.SchoolId.Ocean * CommonDefine.SchoolId.Blood] = "Icon/Career/Icon_CareerDouble_4.png",
  [CommonDefine.SchoolId.Ocean * CommonDefine.SchoolId.Dimension] = "Icon/Career/Icon_CareerDouble_5.png",
  [CommonDefine.SchoolId.Blood * CommonDefine.SchoolId.Dimension] = "Icon/Career/Icon_CareerDouble_6.png"
}
CommonDefine.SchoolIconLittle = {
  [CommonDefine.SchoolId.Choas] = "Icon/Career/Icon_EventCareer_Hundun.png",
  [CommonDefine.SchoolId.Ocean] = "Icon/Career/Icon_EventCareer_Shenhai.png",
  [CommonDefine.SchoolId.Dimension] = "Icon/Career/Icon_EventCareer_Chaowei.png",
  [CommonDefine.SchoolId.Blood] = "Icon/Career/Icon_EventCareer_Xuerou.png"
}
CommonDefine.SchoolIconMixLittle = {
  [CommonDefine.SchoolId.Choas * CommonDefine.SchoolId.Ocean] = "Icon/Career/Icon_EventCareerDouble_1.png",
  [CommonDefine.SchoolId.Choas * CommonDefine.SchoolId.Blood] = "Icon/Career/Icon_EventCareerDouble_2.png",
  [CommonDefine.SchoolId.Choas * CommonDefine.SchoolId.Dimension] = "Icon/Career/Icon_EventCareerDouble_3.png",
  [CommonDefine.SchoolId.Ocean * CommonDefine.SchoolId.Blood] = "Icon/Career/Icon_EventCareerDouble_4.png",
  [CommonDefine.SchoolId.Ocean * CommonDefine.SchoolId.Dimension] = "Icon/Career/Icon_EventCareerDouble_5.png",
  [CommonDefine.SchoolId.Blood * CommonDefine.SchoolId.Dimension] = "Icon/Career/Icon_EventCareerDouble_6.png"
}
CommonDefine.SchoolTypeSortWeight = {
  [CommonDefine.SchoolType.Chaos] = 4,
  [CommonDefine.SchoolType.Ocean] = 3,
  [CommonDefine.SchoolType.Blood] = 2,
  [CommonDefine.SchoolType.Dimension] = 1
}
CommonDefine.FreeTrialSchoolBgIcon = {
  [CommonDefine.SchoolType.Chaos] = "UIResources/UIBigImages/UI_Dungeous/UI_Dungeous_Try_Quality_1.png",
  [CommonDefine.SchoolType.Ocean] = "UIResources/UIBigImages/UI_Dungeous/UI_Dungeous_Try_Quality_2.png",
  [CommonDefine.SchoolType.Blood] = "UIResources/UIBigImages/UI_Dungeous/UI_Dungeous_Try_Quality_3.png",
  [CommonDefine.SchoolType.Dimension] = "UIResources/UIBigImages/UI_Dungeous/UI_Dungeous_Try_Quality_4.png"
}
CommonDefine.AwakerBaseMaxLevel = 60
CommonDefine.AwakerMaxLevel = 90
CommonDefine.ItemMaxLevel = DT.GetConstant("WeaponRefineSkillParaNum") + DT.GetConstant("WeaponRefineAttrNum")
CommonDefine.RefineMtrlSlotCount = 4
CommonDefine.CommonRefineMtrlTid = 9791
CommonDefine.SummonItemType = {
  Awaker = 1,
  Weapon = 2,
  Skin = 3
}
CommonDefine.SummonItemTypeName = {Weapon = "Weapon", AwakerItem = "AwakerItem"}
CommonDefine.TeamType = {
  Normal = 1,
  Weekly = 2,
  Daily = 3,
  Social = 4,
  SchoolTower = 5,
  AbyssChallenge = 6,
  Special = 7
}
CommonDefine.StageGroupType2TeamTypeMap = {
  [CommonDefine.StageGroupType.WeeklyCopy] = CommonDefine.TeamType.Normal,
  [CommonDefine.StageGroupType.WeeklyCopy2] = CommonDefine.TeamType.Normal,
  [CommonDefine.StageGroupType.DailyChallenge] = CommonDefine.TeamType.Normal,
  [CommonDefine.StageGroupType.AlternationSchoolTower] = CommonDefine.TeamType.Normal,
  [CommonDefine.StageGroupType.DisposableSchoolTower] = CommonDefine.TeamType.Normal,
  [CommonDefine.StageGroupType.AbyssChallenge] = CommonDefine.TeamType.Normal
}
CommonDefine.StageDiffType = {
  Normal = 0,
  High = 1,
  Boss = 2
}
CommonDefine.StageSkipStory = {WinToSkip = 1, SkipAfterFirstTime = 2}
CommonDefine.CopyRecordsSortType = {TimeAscend = 1, TimeDescend = -1}
CommonDefine.Difficulty = {
  Normal = 0,
  Hard = 1,
  Super = 2
}
CommonDefine.BothSideUILimitDeltaLen = {
  Batltle = 170,
  WorldStage = 170,
  MainPanel = 80,
  AvgDialogPanelNew = 170
}
CommonDefine.DBGTeamBuildPage = {
  Main = "Main",
  SingleChoose = "SingleChoose",
  QuickChoose = "QuickChoose"
}
CommonDefine.PopupQueType = {fullFuncQue = 1, rewardFuncQue = 2}
CommonDefine.CloseBtnImagesPath = {
  FogBg = "UIResources/UIBigImages/UI_Large/UI_Common_Image_Back_Fog.png",
  CommonBg = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Btn_Back2_Bg.png",
  CloseIcon = "UIResources/AtlasSource/HD/UI_Common_Image/UI_Common_D_Image_Btn_Close_Icon.png",
  TitleLine = "UIResources/UIBigImages/UI_Large/UI_Common_Popup_Tips_Title_Line8.png"
}
CommonDefine.SkillType = {
  Card_Skill = "Card_Skill",
  Card_Strike = "Card_Strike",
  Card_Defend = "Card_Defend",
  Card_Awake = "Card_Awake",
  Ulti_Skill = "Ulti_Skill",
  Card_Curse = "Card_Curse",
  Card_State = "Card_State"
}
CommonDefine.ArtCollectionPage = {
  Roles = 1,
  World = 2,
  CG = 3,
  Music = 4,
  Weapon = 5,
  Trinket = 6,
  Relic = 7,
  Event = 8
}
CommonDefine.UltiEnergyPerSkill = 100
CommonDefine.DBGEntryPage = {
  MaterialPanel = 1,
  TrinketPanel = 2,
  DailyPanel = 3,
  WeeklyPanel = 4,
  DailyChallengePanel = 5,
  WeekBossPanel = 6,
  SchoolTowerPanel = 7,
  MockPanel = 8,
  Abyss = 9,
  SendPanel = 11,
  Quit = 100
}
CommonDefine.DbgDungeonBgType = {Normal = 1, Red = 2}
CommonDefine.ConfirmTipsType = {
  S = 1,
  L = 2,
  M = 3
}
CommonDefine.PopupTipsType = {S = 1, L = 2}
CommonDefine.AwakerVoiceTab = {
  Daily = "Daily",
  Battle = "Battle",
  Pvp = "Pvp"
}
CommonDefine.IsShowAwakerDate = {Yes = 1, No = 0}
CommonDefine.AwakerStoryType = {BaseMessage = 1, Story = 2}
CommonDefine.AwakerVoiceFormat = {
  Play_VOC_Awaker = "Play_VOC_Awaker_%s_%s",
  Battle_Awaker_Bank = "Sound_Ingame_%s"
}
CommonDefine.CurrencyCharacterMap = {
  CNY = "¥",
  USD = "$",
  HKD = "HK$",
  MOP = "MOP$",
  TWD = "NT$",
  MYR = "RM",
  SGD = "S$",
  KRW = "KRW"
}
CommonDefine.CurrencyCharacterCountryCodeMap = {
  [CommonDefine.CountryCode.CN] = "¥",
  [CommonDefine.CountryCode.US] = "$",
  [CommonDefine.CountryCode.HK] = "HK$",
  [CommonDefine.CountryCode.TW] = "NT$",
  [CommonDefine.CountryCode.SG] = "S$",
  [CommonDefine.CountryCode.MY] = "RM",
  [CommonDefine.CountryCode.KR] = "KRW"
}
CommonDefine.AwakerVoiceTrigger = {
  GetAwaker = "GetAwaker",
  AwakerPromote = "AwakerPromote",
  StageStart = "StageStart",
  StageVictory = "StageVictory",
  StageFail = "StageFail",
  Slot_Strike = "Slot_Strike",
  Slot_Defend = "Slot_Defend",
  Hit = "Hit",
  Slot_Skill1 = "Slot_Skill1",
  Slot_Skill2 = "Slot_Skill2",
  Slot_Awake = "Slot_Awake",
  Slot_Super = "Slot_Super",
  Slot_Super_Ultl = "UtlSkill_Promote",
  ActivatePotency_1 = "ActivatePotency_1",
  ActivatePotency_2 = "ActivatePotency_2",
  ActivatePotency_3 = "ActivatePotency_3",
  ActivatePotency_4 = "ActivatePotency_4",
  ActivatePotency_5 = "ActivatePotency_5",
  ActivatePotency_6 = "ActivatePotency_6",
  ActivatePotency_7 = "ActivatePotency_7",
  ClickAwaker = "ClickAwaker",
  AwakerAppear = "AwakerAppear",
  LongPressAwaker = "LongPressAwaker",
  DepressionHit = "DepressionHit",
  ManiaHit = "ManiaHit"
}
CommonDefine.AwakerBreakThrough = {
  NullLevel = -1,
  RewardAvailable = 1,
  RewardUnavailable = 2,
  RewardReceived = 3
}
CommonDefine.AwakerStoryVoiceState = {
  Hide = -1,
  Lock = 0,
  Unlock = 1,
  Read = 2
}
CommonDefine.AwakerSpecialSkillType = {
  All = "All",
  ResNeedReduce = "ResNeedReduce",
  AppointTaskRewardAdd = "AppointTaskRewardAdd",
  HarvestAdd = "HarvestAdd",
  StageDropAdd = "StageDropAdd",
  MaterialsReturn = "MaterialsReturn",
  MultiplierXP = "MultiplierXP"
}
CommonDefine.QualitySortValueTable = {
  White = 1,
  Green = 2,
  Blue = 3,
  Purple = 4,
  Orange = 5,
  UR = 6
}
CommonDefine.ItemTypeSortValueTable = {
  [CommonDefine.ItemType.Trinket] = 1,
  [CommonDefine.ItemType.Weapon] = 2
}
CommonDefine.ItemAwardTypeSortWeightMap = {
  [CommonDefine.ItemAwardType.First3Star] = 1,
  [CommonDefine.ItemAwardType.First] = 2,
  [CommonDefine.ItemAwardType.Normal] = 3
}
CommonDefine.WeaponEnhance = {
  DetailPanelType_1 = 1,
  DetailPanelType_2 = 2,
  AutoMtrlType_1 = 3,
  AutoMtrlType_2 = 4,
  MtrlSlotCount = 20,
  MaxLevel = #DT.WeaponLevelUpExp + 1,
  MaxBreakthroughStar = #DT.GetOriginalConstant("WeaponBreakthroughRequiredUpgradeLevel")
}
CommonDefine.WeaponEnhanceAutoMtrlQuality = {White = true, Blue = true}
CommonDefine.DummyWeapon = {
  Weapon = {
    tid = 0,
    uid = 0,
    mainAttr = {
      physique = 0,
      atk = 0,
      def = 0
    },
    subAttr = {dummy = 0},
    enhanceLevel = 0,
    breakLevel = 0,
    level = 0
  },
  Config = {
    ID = 0,
    Type = "Weapon",
    SubType = "Weapon",
    Quality = "White",
    WeaponMainAttribute = {
      2969,
      0,
      3,
      0,
      5,
      0
    },
    WeaponSubAttribute = {0, 0}
  }
}
CommonDefine.WeaponBtnState = {
  ShowNone = 0,
  ShowChange = 1,
  ShowEquip = 2,
  ShowUnequip = 3
}
CommonDefine.TutorialPopTipIcon = {
  Single = "Icon/Common/UI_Common_Course_01.png",
  Multi = "Icon/Common/UI_Common_Course_02.png"
}
CommonDefine.BpComp = {
  BpRewardList = 1,
  BpTask = 2,
  BpWeapon = 3,
  BpRecharge = 4,
  BpShow = 5,
  BpReview = 6
}
CommonDefine.BpBg = {
  Reward = "UIResources/UIBigImages/UI_Large/UI_Large_Passport/UI_Passport_Progress_Bg1.png",
  Other = "UIResources/UIBigImages/UI_Large/UI_Large_Passport/UI_Passport_Progress_Bg6.png"
}
CommonDefine.BpPrivilegeLevel = {
  Ordinary = 0,
  Advanced = 1,
  Core = 2
}
CommonDefine.BpRewardState = {
  LockByMoney = 1,
  LockByLevel = 2,
  CanReceive = 3,
  HaveReceive = 4
}
CommonDefine.LotteryPage = {Pool = 1, Result = 2}
CommonDefine.BpPage = {
  ItemReward = 1,
  Task = 2,
  WeaponReward = 3,
  Recharge = 4,
  Show = 5,
  Review = 6,
  Quit = 10
}
CommonDefine.BpChargeKey = {
  Ordinary = 2,
  Advanced = 3,
  AdvancedDiscount = 4,
  Core = 5
}
CommonDefine.ExchangeType = {EnergyItemExchange = 1, DiamondExchange = 2}
CommonDefine.StartUnlockTeamIndex = 10
CommonDefine.TeamAssign = {}
CommonDefine.TeamAssign.eStageTeamMode = {
  Normal = 1,
  Special = 2,
  Preview = 3
}
CommonDefine.TeamMixSchoolCount = 2
CommonDefine.TeamAssign.ePosState = {
  FreeBattlePos = "FreeBattlePos",
  BanBattlePos = "BanBattlePos"
}
CommonDefine.TeamAssistPos = 4
CommonDefine.TeamAssign.UseDataType = {ConfigData = 0, RealData = 1}
CommonDefine.ReplayType = {PVP = "P", PVE = "E"}
CommonDefine.AwakerFilterType = {
  CopyRecords = "CopyRecords",
  DailyChallengeRank = "DailyChallengeRank"
}
CommonDefine.SelectType = {
  None = -1,
  Part = 0,
  All = 1
}
CommonDefine.AwakerFilterLimitSchoolNum = 2
CommonDefine.AwakerFilterUnableSelectReason = {
  SchoolConflict = "SchoolConflict",
  MutualConflict = "MutualConflict"
}
CommonDefine.AwakerFilterMutualExclusionGroups = {
  {15595, 15568}
}
CommonDefine.TeamAwakerCount = 4
CommonDefine.TeamWeaponCount = 2
CommonDefine.TeamTrinketCount = 6
CommonDefine.PvpTeamImportAwakerCount = 4
CommonDefine.PvpTeamImportWeaponCount = 4
CommonDefine.PVPTeamKeeperSkillCount = 2
CommonDefine.TeamAssign.MaxBattleNum = 4
CommonDefine.TeamBuildType = {QuickBuild = 1, ChooseBuild = 2}
CommonDefine.TeamAssignAwaker = {
  UseConfigData = 0,
  UseOwnedAwaker = 1,
  SwitchSameAwaker = 2,
  Trail = 3
}
CommonDefine.TeamAssignAwakerFixedSlot = {
  [CommonDefine.TeamAssignAwaker.SwitchSameAwaker] = true,
  [CommonDefine.TeamAssignAwaker.Trail] = true
}
CommonDefine.AwakerFileUnlock_Condition = {
  Awaker_Level = "Awaker_Level",
  AwakerFavorabilityLevel = "AwakerFavorabilityLevel",
  StageFirstClear = "StageFirstClear",
  PotencyLevel = "PotencyLevel"
}
CommonDefine.AwakerfileType = {Story = 1, Voice = 2}
CommonDefine.GenderID = {Boy = 1, Girl = 2}
CommonDefine.GenderString = {
  Gender_Boy = "Gender_Boy",
  Gender_Girl = "Gender_Girl"
}
CommonDefine.GenderName = {
  [1] = CommonDefine.GenderString.Gender_Boy,
  [2] = CommonDefine.GenderString.Gender_Girl
}
CommonDefine.ProbabilityUpDescFormatType = {LeftTimes = "LeftTimes"}
CommonDefine.SummonResultOpeningVideo = {
  Blue = "Vx/Summon_Front_R.mp4",
  Purple = "Vx/Summon_Front_SR.mp4",
  Orange = "Vx/Summon_Front_SSR.mp4"
}
CommonDefine.SummonItemQualityVideo = {
  Blue = "Vx/Summon_R.mp4",
  Purple = "Vx/Summon_SR.mp4",
  Orange = "Vx/Summon_SSR.mp4"
}
CommonDefine.SummonItemLogo = {
  Blue = {
    Normal = "Icon/Summon/Icon_Summon_001.png",
    Glow = "Icon/Summon/Icon_Summon_001.png",
    NormalSmall = "Icon/Summon/Icon_Summon_004.png",
    GlowSmall = "Icon/Summon/Icon_Summon_001.png"
  },
  Purple = {
    Normal = "Icon/Summon/Icon_Summon_002.png",
    Glow = "Icon/Summon/Icon_Summon_002b.png",
    NormalSmall = "Icon/Summon/Icon_Summon_004.png",
    GlowSmall = "Icon/Summon/Icon_Summon_002a.png"
  },
  Orange = {
    Normal = "Icon/Summon/Icon_Summon_003.png",
    Glow = "Icon/Summon/Icon_Summon_003b.png",
    NormalSmall = "Icon/Summon/Icon_Summon_004.png",
    GlowSmall = "Icon/Summon/Icon_Summon_003a.png"
  }
}
CommonDefine.SummonSkinIcon = {
  Blue = {
    Normal = nil,
    Glow = nil,
    NormalSmall = nil,
    GlowSmall = nil
  },
  Purple = {
    Normal = "Icon/Summon/UI_Summon_D_Icon_AwakerSkine.png",
    Glow = "Icon/Summon/UI_Summon_D_Icon_AwakerSkina.png",
    NormalSmall = "Icon/Summon/UI_Summon_D_Icon_AwakerSkine.png",
    GlowSmall = "Icon/Summon/UI_Summon_D_Icon_AwakerSkina.png"
  },
  Orange = {
    Normal = "Icon/Summon/UI_Summon_D_Icon_AwakerSkinc.png",
    Glow = "Icon/Summon/UI_Summon_D_Icon_AwakerSkind.png",
    NormalSmall = "Icon/Summon/UI_Summon_D_Icon_AwakerSkinc.png",
    GlowSmall = "Icon/Summon/UI_Summon_D_Icon_AwakerSkind.png"
  }
}
CommonDefine.SummonSchoolLogo = {
  Chaos = {
    Blue = {
      NormalSmall = "Icon/Summon/UI_Summon_D_Icon_Career4.png",
      GlowSmall = "Icon/Summon/UI_Summon_D_Icon_Career4.png"
    },
    Purple = {
      Normal = "Icon/Summon/UI_Summon_D_Icon_Career4e.png",
      Glow = "Icon/Summon/UI_Summon_D_Icon_Career4f.png",
      NormalSmall = "Icon/Summon/UI_Summon_D_Icon_Career4.png",
      GlowSmall = "Icon/Summon/UI_Summon_D_Icon_Career4a.png"
    },
    Orange = {
      Normal = "Icon/Summon/UI_Summon_D_Icon_Career4c.png",
      Glow = "Icon/Summon/UI_Summon_D_Icon_Career4d.png",
      NormalSmall = "Icon/Summon/UI_Summon_D_Icon_Career4.png",
      GlowSmall = "Icon/Summon/UI_Summon_D_Icon_Career4b.png"
    }
  },
  Blood = {
    Blue = {
      NormalSmall = "Icon/Summon/UI_Summon_D_Icon_Career3.png",
      GlowSmall = "Icon/Summon/UI_Summon_D_Icon_Career3.png"
    },
    Purple = {
      Normal = "Icon/Summon/UI_Summon_D_Icon_Career3e.png",
      Glow = "Icon/Summon/UI_Summon_D_Icon_Career3f.png",
      NormalSmall = "Icon/Summon/UI_Summon_D_Icon_Career3.png",
      GlowSmall = "Icon/Summon/UI_Summon_D_Icon_Career3a.png"
    },
    Orange = {
      Normal = "Icon/Summon/UI_Summon_D_Icon_Career3c.png",
      Glow = "Icon/Summon/UI_Summon_D_Icon_Career3d.png",
      NormalSmall = "Icon/Summon/UI_Summon_D_Icon_Career3.png",
      GlowSmall = "Icon/Summon/UI_Summon_D_Icon_Career3b.png"
    }
  },
  Dimension = {
    Blue = {
      NormalSmall = "Icon/Summon/UI_Summon_D_Icon_Career1.png",
      GlowSmall = "Icon/Summon/UI_Summon_D_Icon_Career1.png"
    },
    Purple = {
      Normal = "Icon/Summon/UI_Summon_D_Icon_Career1e.png",
      Glow = "Icon/Summon/UI_Summon_D_Icon_Career1f.png",
      NormalSmall = "Icon/Summon/UI_Summon_D_Icon_Career1.png",
      GlowSmall = "Icon/Summon/UI_Summon_D_Icon_Career1a.png"
    },
    Orange = {
      Normal = "Icon/Summon/UI_Summon_D_Icon_Career1c.png",
      Glow = "Icon/Summon/UI_Summon_D_Icon_Career1d.png",
      NormalSmall = "Icon/Summon/UI_Summon_D_Icon_Career1.png",
      GlowSmall = "Icon/Summon/UI_Summon_D_Icon_Career1b.png"
    }
  },
  Ocean = {
    Blue = {
      NormalSmall = "Icon/Summon/UI_Summon_D_Icon_Career2.png",
      GlowSmall = "Icon/Summon/UI_Summon_D_Icon_Career2.png"
    },
    Purple = {
      Normal = "Icon/Summon/UI_Summon_D_Icon_Career2e.png",
      Glow = "Icon/Summon/UI_Summon_D_Icon_Career2f.png",
      NormalSmall = "Icon/Summon/UI_Summon_D_Icon_Career2.png",
      GlowSmall = "Icon/Summon/UI_Summon_D_Icon_Career2a.png"
    },
    Orange = {
      Normal = "Icon/Summon/UI_Summon_D_Icon_Career2c.png",
      Glow = "Icon/Summon/UI_Summon_D_Icon_Career2d.png",
      NormalSmall = "Icon/Summon/UI_Summon_D_Icon_Career2.png",
      GlowSmall = "Icon/Summon/UI_Summon_D_Icon_Career2b.png"
    }
  }
}
CommonDefine.SummonItemFragment = {
  Purple = "Icon/Summon/Icon_Summon_SR.png",
  Orange = "Icon/Summon/Icon_Summon_SSR.png"
}
CommonDefine.SummonSoundID = {
  OpeningVideo = {
    Blue = "ANIM_AWAKING_RAFFLE_R",
    Purple = "ANIM_AWAKING_RAFFLE_SR",
    Orange = "ANIM_AWAKING_RAFFLE_SSR"
  },
  SkipOpeningVideo = "STOP_ANIM_AWAKING_RAFFLE",
  ShowQuality = {
    Blue = "ANIM_AWAKING_UNVEIL_LEVEL_R",
    Purple = "ANIM_AWAKING_UNVEIL_LEVEL_SR",
    Orange = "ANIM_AWAKING_UNVEIL_LEVEL_SSR"
  },
  ShowItemDetail = {
    Blue = "ANIM_AWAKING_UNVEIL_CONTENT_R",
    Purple = "ANIM_AWAKING_UNVEIL_CONTENT_SR",
    Orange = "ANIM_AWAKING_UNVEIL_CONTENT_SSR"
  },
  SkipItemDetail = "STOP_ANIM_AWAKING_UNVEIL_CONTENT",
  ShowResult = "TRANS_AWAKING_SUM_ENTER",
  ShowHighlight = {
    Purple = "VFX_AWAKING_SUM_SPOTLIGHT_SR",
    Orange = "VFX_AWAKING_SUM_SPOTLIGHT_SSR"
  },
  ShowFragment = "VFX_AWAKING_SUM_FRAGMENTCONVERT"
}
CommonDefine.SummonFXTime = {
  QualityFXAppearTime = 0.3,
  QualityFXTimeSpan = 0.3,
  AwakerClipAppearTime = 0.3,
  AwakerClipTimeSpan = 0.0
}
CommonDefine.SummonItemDetailStayTime = 0.25
CommonDefine.SettingItemType = {
  Title = "Title",
  SliderText = "SliderText",
  SliderNoText = "SliderNoText",
  BtnToggle = "BtnToggle",
  BtnSingle = "BtnSingle",
  BtnDrop = "BtnDrop",
  BundleShortcutKey = "BundleShortcutKey",
  Space = "Space"
}
CommonDefine.SettingTab = {
  System = "System",
  Image = "Image",
  Voice = "Voice",
  Language = "Language",
  Key = "Key",
  Account = "Account"
}
CommonDefine.SettingPanelTabSequence = {
  CommonDefine.SettingTab.System,
  CommonDefine.SettingTab.Image,
  CommonDefine.SettingTab.Language,
  CommonDefine.SettingTab.Key,
  CommonDefine.SettingTab.Voice,
  CommonDefine.SettingTab.Account
}
CommonDefine.SettingValue = {Open = "Open", Close = "Close"}
CommonDefine.SettingToServerUse = {Open = 1, Close = 0}
CommonDefine.SettingUniqueName = {
  HealthBarIntegration = "HealthBarIntegration",
  UltiSkillConfirm = "UltiSkillConfirm",
  BattleSpeed = "BattleSpeed",
  AwakerLevelUpConfirm = "AwakerLevelUpConfirm",
  TeamImbalanceConfirm = "TeamImbalanceConfirm",
  CombatInsufficientConfirm = "CombatInsufficientConfirm",
  InfomationPush = "InfomationPush",
  EnergyFull = "EnergyFull",
  TaskFinish = "TaskFinish",
  ResBuildingFullPush = "ResBuildingFullPush",
  DevicePerformance = "DevicePerformance",
  GraphicQuality = "GraphicQuality",
  Brightness = "Brightness",
  Resolution = "Resolution",
  FPSLimit = "FPSLimit",
  Bloom = "Bloom",
  AntiAliasing = "AntiAliasing",
  ShadowmapResolution = "ShadowmapResolution",
  DepthOfField = "DepthOfField",
  Dispersion = "Dispersion",
  ChromaticAberration = "ChromaticAberration",
  Volume = "Volume",
  Music = "Music",
  Voice = "Voice",
  SoundEffect = "SoundEffect",
  LanguageWord = "LanguageWord",
  KeyShortName = "KeyShortName",
  LanguageRes = "LanguageRes",
  UserCenter = "UserCenter",
  RedemptionCode = "RedemptionCode",
  BindReward = "BindReward",
  PrivacyPolicy = "PrivacyPolicy",
  UserAgreement = "UserAgreement",
  CopyrightMark = "CopyrightMark",
  DataRecovery = "DataRecovery",
  TextureQuality = "TextureQuality",
  ParticleQuality = "ParticleQuality",
  ScenesEffects = "ScenesEffects",
  RealTimeLight = "RealTimeLight",
  UseSoftMask = "UseSoftMask",
  AutoDecompositionOfRWeapon = "AutoDecompositionOfRWeapon",
  AutoDecompositionOfSRWeapon = "AutoDecompositionOfSRWeapon",
  AutoLockOfSRWeapon = "AutoLockOfSRWeapon",
  AutoLockOfSSRWeapon = "AutoLockOfSSRWeapon",
  CustomerService = "CustomerService",
  PlayPV = "PlayPV",
  LoginPVModify = "LoginPVModify",
  GyroscopeSwitch = "GyroscopeSwitch",
  BindPhone = "BindPhone",
  WindowResolution = "WindowResolution",
  WindowSetting = "WindowSetting",
  DisplayShortcutKey = "DisplayShortcutKey",
  ShotDownGame = "ShotDownGame",
  WindowNotFocusVoice = "WindowNotFocusVoice",
  BattleDynamicBackground = "BattleDynamicBackground",
  TranslationProgress = "TranslationProgress",
  BindPhoneOrEmail = "BindPhoneOrEmail",
  KeyTraning1 = "KeyTraning1",
  KeyTraning2 = "KeyTraning2",
  KeyTraning3 = "KeyTraning3",
  KeyTraning4 = "KeyTraning4",
  KeyTraning5 = "KeyTraning5",
  BackTrackItemHideRed = "BackTrackItemHideRed",
  Outline = "Outline",
  CardBorderEffect = "CardBorderEffect"
}
CommonDefine.rtpcWwiseName = {
  Main = "Main_Vol",
  Mus = "Mus_Vol",
  Voc = "Voc_Vol",
  Sfx = "Sfx_Vol"
}
CommonDefine.rtpcSetName2WwiseNameMap = {
  [CommonDefine.SettingUniqueName.Volume] = CommonDefine.rtpcWwiseName.Main,
  [CommonDefine.SettingUniqueName.Music] = CommonDefine.rtpcWwiseName.Mus,
  [CommonDefine.SettingUniqueName.Voice] = CommonDefine.rtpcWwiseName.Voc,
  [CommonDefine.SettingUniqueName.SoundEffect] = CommonDefine.rtpcWwiseName.Sfx
}
CommonDefine.SweepCondition = {
  ThreeStar = 1,
  StageFinish = 2,
  SingleDay = 3,
  ReceiveAllAchievement = 4,
  PlayerLevel = 10,
  NotEnoughEnergy = 11
}
CommonDefine.AwakerQualityIcon = {
  Purple = "Icon/Awaker/Awaker_Quality_SR.png",
  Orange = "Icon/Awaker/Awaker_Quality_SSR.png"
}
CommonDefine.RuneQualityBg = {
  White = "UIResources/AtlasSource/2_Icon/Rune/UI_Rune_Small_Ordinary.png",
  Orange = "UIResources/AtlasSource/2_Icon/Rune/UI_Rune_Small_Senior.png",
  Red = "UIResources/AtlasSource/2_Icon/Rune/UI_Rune_Small_Curse.png"
}
CommonDefine.ItemCommonIcon = {
  Weapon = "Icon/Career/Icon_Career_Weapons.png"
}
CommonDefine.KeeperSkillEnergyLevel = {
  Neg4 = -4,
  Neg3 = -3,
  Neg2 = -2,
  Neg1 = -1,
  Pos0 = 0,
  Pos1 = 1,
  Pos2 = 2,
  Pos3 = 3
}
CommonDefine.KeeperSkillEnergyMinLevel = CommonDefine.KeeperSkillEnergyLevel.Neg3
CommonDefine.KeeperSkillEnergyMaxLevel = CommonDefine.KeeperSkillEnergyLevel.Pos3
CommonDefine.SdkNoticePage = {
  GameNotice = "GameNotice",
  ActivityNotice = "ActivityNotice",
  BugFixes = "BugFixes"
}
CommonDefine.SdkFriendType = {Friend = "friend"}
CommonDefine.SdkJfEventNameType = {
  Story = "client.read.story",
  RankBoard = "client.read.rank",
  IngameDownload = "client.read.ingamedownload"
}
CommonDefine.SdkJfStoryActionType = {
  StartStory = 1,
  Read = 2,
  Jump = 3
}
CommonDefine.SdkChannelId = {
  JiuYou = 511314,
  TapTap = 998247,
  QookkaGames = 998236
}
CommonDefine.SdkPlayerInfoType = {
  ENTERGAME = "enterGame",
  UPDATES = "updates",
  CREATEROLE = "createRole",
  EXITGAME = "exitGame"
}
CommonDefine.SdkPublishArea = {
  tw = "tw",
  hk = "hk",
  global = "global"
}
CommonDefine.SdkCommitEventName = {
  click_purchase = "click_purchase"
}
CommonDefine.ResonanceType = {Normal = "normal", Elite = "elite"}
CommonDefine.ResonanceUnlockType = {Or = 0, And = 1}
CommonDefine.RelicGroupTabType = {RELIC = 1, ENCHANT = 2}
CommonDefine.MagicStoryResonance = "ResonanceGroupMagicStoryActivity"
CommonDefine.WandaResonance = "ResonanceGroupWangda"
CommonDefine.SalvadorResonance = "ResonanceGroupSEWD"
CommonDefine.TwentyFourResonance = "ResonanceGroup24"
CommonDefine.LilyResonance = "ResonanceGroupMagicStoryActivity"
CommonDefine.ResonanceGroupO07Activity = "ResonanceGroupO07Activity"
CommonDefine.HorlaResonanceGroup = "ResonanceGroupHorla"
CommonDefine.ResonanceGroupOriginHelot = "ResonanceGroupOriginHelot"
CommonDefine.ResonanceGroupRailway = "ResonanceGroupRailway"
CommonDefine.ResonancePrefab = {
  ResonanceGroupChapter1 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupChapter1.prefab",
  ResonanceGroupChapter2 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupChapter2.prefab",
  ResonanceGroupChapter3 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupChapter3.prefab",
  ResonanceGroupChapter4 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupChapter4.prefab",
  ResonanceGroupChapter5 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupChapter5.prefab",
  ResonanceGroupChapter6 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupChapter6.prefab",
  ResonanceGroupChapter7 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupChapter7.prefab",
  ResonanceGroupChapter8 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupChapter8.prefab",
  ResonanceGroupChapter9 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupChapter9.prefab",
  ResonanceGroup2Chapter1 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroup2Chapter1.prefab",
  ResonanceGroup2Chapter2 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroup2Chapter2.prefab",
  ResonanceGroup2Chapter3 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroup2Chapter3.prefab",
  ResonanceGroup2Chapter4 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroup2Chapter4.prefab",
  ResonanceGroup2Chapter5 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroup2Chapter5.prefab",
  ResonanceGroup2Chapter6 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroup2Chapter6.prefab",
  ResonanceGroupMagicStoryActivity = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupMagicStoryActivity.prefab",
  ResonanceGroupWangda = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupWandaGameplay.prefab",
  ResonanceGroupSEWD = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupSalvadorGameplay.prefab",
  ResonanceGroup24 = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupTwentyFour.prefab",
  ResonanceGroupO07Activity = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupMiriam.prefab",
  ResonanceGroupHorla = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupHorla.prefab",
  ResonanceGroupOriginHelot = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupOriHelotGameplay.prefab",
  ResonanceGroupRailway = "UI/UI_Chapter/UI_Chapter_Prefab/ResonanceGroupRailWay.prefab"
}
CommonDefine.ResonanceRes = {
  ResonanceGroupChapter1 = "UI.UIPackages.ResonanceGroupChapter1Resource",
  ResonanceGroupChapter2 = "UI.UIPackages.ResonanceGroupChapter2Resource",
  ResonanceGroupChapter3 = "UI.UIPackages.ResonanceGroupChapter3Resource",
  ResonanceGroupChapter4 = "UI.UIPackages.ResonanceGroupChapter4Resource",
  ResonanceGroupChapter5 = "UI.UIPackages.ResonanceGroupChapter5Resource",
  ResonanceGroupChapter6 = "UI.UIPackages.ResonanceGroupChapter6Resource",
  ResonanceGroupChapter7 = "UI.UIPackages.ResonanceGroupChapter7Resource",
  ResonanceGroupChapter8 = "UI.UIPackages.ResonanceGroupChapter8Resource",
  ResonanceGroupChapter9 = "UI.UIPackages.ResonanceGroupChapter9Resource",
  ResonanceGroup2Chapter1 = "UI.UIPackages.ResonanceGroup2Chapter1Resource",
  ResonanceGroup2Chapter2 = "UI.UIPackages.ResonanceGroup2Chapter2Resource",
  ResonanceGroup2Chapter3 = "UI.UIPackages.ResonanceGroup2Chapter3Resource",
  ResonanceGroup2Chapter4 = "UI.UIPackages.ResonanceGroup2Chapter4Resource",
  ResonanceGroup2Chapter5 = "UI.UIPackages.ResonanceGroup2Chapter5Resource",
  ResonanceGroup2Chapter6 = "UI.UIPackages.ResonanceGroup2Chapter6Resource",
  ResonanceGroupMagicStoryActivity = "UI.UIPackages.ResonanceGroupMagicStoryActivityResource",
  ResonanceGroupWangda = "UI.UIPackages.ResonanceGroupWandaGameplayResource",
  ResonanceGroupSEWD = "UI.UIPackages.ResonanceGroupSalvadorGameplayResource",
  ResonanceGroup24 = "UI.UIPackages.ResonanceGroupTwentyFourResource",
  ResonanceGroupO07Activity = "UI.UIPackages.ResonanceGroupMiriamResource",
  ResonanceGroupHorla = "UI.UIPackages.ResonanceGroupHorlaResource",
  ResonanceGroupOriginHelot = "UI.UIPackages.ResonanceGroupOriHelotGameplayResource",
  ResonanceGroupRailway = "UI.UIPackages.ResonanceGroupRailWayResource"
}
CommonDefine.BackCommandBlacklist = {
  [Urls.AwakerBasePanel] = true,
  [Urls.AvgDialogPanelNew] = true,
  [Urls.GmEntryPanel] = true,
  [Urls.ReqMaskPanel] = true,
  [Urls.CommonFloatTipsPanel] = true,
  [Urls.LoadingPanel] = true,
  [Urls.ActiveSuccessPanel] = true,
  [Urls.TrinketAutoRefineSuccessView] = true,
  [Urls.CommonVideoPanel] = true,
  [Urls.CommonFloatTipsPanel] = true,
  [Urls.DbgCopyTaskPanel] = true,
  [Urls.WorldStageCardFlyPanel] = true,
  [Urls.WorldStageSelectSingleCardPanel] = true,
  [Urls.WorldStageBattleSettleTip] = true,
  [Urls.WorldStageMainPanel] = true,
  [Urls.WorldStageAwakerSelectPanel] = true,
  [Urls.WorldStageRelicThreeSelectPanel] = true,
  [Urls.WorldStageEnterPanel] = true,
  [Urls.WorldStageCardSelectPanel] = true,
  [Urls.WorldStageOpeningAnim] = true,
  [Urls.WorldStageDescPanel] = true,
  [Urls.DailyChallengeDescPanel] = true,
  [Urls.SummonResultPanel] = true,
  [Urls.WorldStageEventPanel] = true,
  [Urls.DbgAwakerSkillPanel] = true,
  [Urls.DbgBattlePanel] = true,
  [Urls.PvPBattleMainPanel] = true,
  [Urls.PvPBattleTrainPanel] = true,
  [Urls.BattleReplayWaitPanel] = true,
  [Urls.GuideView] = true,
  [Urls.SetGenderPanel] = true,
  [Urls.SetNamePanel] = true,
  [Urls.PopMsgPanel] = true,
  [Urls.MarqueePanel] = true,
  [Urls.ResUpdatePanel] = true,
  [Urls.VideoCaptionPanel] = true,
  [Urls.CardUnlockAbPanel] = true,
  [Urls.WorldStageBattleRewardPanel] = true,
  [Urls.PVEReplayBattlePanel] = true,
  [Urls.PVPReplayBattlePanel] = true,
  [Urls.DbgAwakerSelectionPanel] = true,
  [Urls.PvPSelectInitCardPanel] = true,
  [Urls.PvPMatchRstPanel] = true,
  [Urls.PvpPasswordCreateView] = true,
  [Urls.PvpPasswordJoinView] = true,
  [Urls.PvpPasswordWaitingView] = true,
  [Urls.PvpPasswordRoleListView] = true,
  [Urls.KeeperSkillSelectPanel] = true,
  [Urls.BattleCardDropSelectView] = true,
  [Urls.KeyMaskView] = true,
  [Urls.SkillCastSelectPanel] = true,
  [Urls.AlertConfirm2Panel] = true,
  [Urls.TaskSchoolView] = true,
  [Urls.TaskCareerView] = true,
  [Urls.TaskPlayerLevelView] = true,
  [Urls.TaskHomeAchievementView] = true,
  [Urls.SocialRelationFollowPanel] = true,
  [Urls.SocialRelationFansPanel] = true,
  [Urls.SocialRelationVisiterPanel] = true,
  [Urls.SocialRelationSearchPanel] = true,
  [Urls.SocialRankView] = true,
  [Urls.SocialRelationBanPanel] = true,
  [Urls.InvitaionCodeView] = true,
  [Urls.CommunityJumpPanel] = true,
  [Urls.AbyssPanel] = true,
  [Urls.AlchemyExchangePanel] = true,
  [Urls.AlchemyExchangeItemBagPanel] = true,
  [Urls.AlchemyDecomposePanel] = true,
  [Urls.AlchemyCompositePanel] = true,
  [Urls.WorldStageRelicSelectPanel] = true,
  [Urls.KeeperSkillSelectPanel] = true,
  [Urls.DeckCardSelectPanel] = true,
  [Urls.DbgMainCopyAwakerSelectionPanel] = true,
  [Urls.PvPMatchingPanel] = true,
  [Urls.WorldStageBattleFailTip] = true,
  [Urls.PvPBattleRankSettlePanel] = true,
  [Urls.PVPBattleDataSettlePanel] = true,
  [Urls.WorldStageBattleWinTip] = true,
  [Urls.NewbieGuideView] = true,
  [Urls.FriendMatchWaitPanel] = true,
  [Urls.FriendMatchWaitFormation] = true,
  [Urls.FriendMatchPopTipPanel] = true,
  [Urls.PvpDraftView] = true,
  [Urls.PvpDraftAdjustTeamView] = true
}
CommonDefine.DimentionStatusState = {
  Empty = 1,
  Recarge = 2,
  Lock = 3
}
CommonDefine.SectorAngle = 7
CommonDefine.SectorShift = -50
CommonDefine.MaxDeltaAngle = 3
CommonDefine.SectorPadding = 10
CommonDefine.BattleCardScale = 0.8
CommonDefine.DeckDisplayY = 200
CommonDefine.DeckBackDisplay = 200
CommonDefine.DeckUseY = 200
CommonDefine.DragEnoughToUse = 100
CommonDefine.CardCheck = {
  None = "None",
  Display = "Display",
  Ready = "Ready"
}
CommonDefine.CardAnim = {
  CardReset = "CardReset",
  CardDraw = "CardDraw",
  CardDrop = "CardDrop",
  CardDropFadeAway = "CardDropFadeAway",
  CardDropBurnPVP = "CardDropBurnPVP",
  CardDropBurn = "CardDropBurn",
  CardRelayout = "CardRelayout",
  CardDisplay = "CardDisplay",
  CardOtherDisplay = "CardOtherDisplay",
  CardDisplayBack = "CardDisplayBack",
  CardSelectBack = "CardSelectBack",
  CardDrag = "CardDrag",
  CardOtherDrag = "CardOtherDrag",
  CardPutBack = "CardPutBack",
  CardUse = "CardUse",
  CardRecordUse = "CardRecordUse",
  CardForceUse = "CardForceUse",
  CardUseBack = "CardUseBack",
  CardDisappear = "CardDisappear",
  CardConsume = "CardConsume",
  CardInsert = "CardInsert",
  CardEmbryoNew = "CardEmbryoNew",
  CardEmbryoSwallow = "CardEmbryoSwallow",
  CardBlessingUse = "CardBlessingUse",
  CardFromDimension = "CardFromDimension",
  CardChange = "CardChange"
}
CommonDefine.CardManualAnim = {
  CardDisplay = "CardDisplay",
  CardDisplayBack = "CardDisplayBack",
  CardDrag = "CardDrag",
  CardPutBack = "CardPutBack",
  CardUseBack = "CardUseBack"
}
CommonDefine.OutsideStageMemberField = "outsideStageTid"
CommonDefine.MonthCardState = {
  Dummy = 0,
  NeverPurchased = 1,
  InEffect = 2,
  Expired = 3
}
CommonDefine.AwakerType = {BaseType = 0, OriginType = 1}
CommonDefine.PlayerPanelType = {
  Player = 0,
  PVE = 1,
  PVP = 2
}
CommonDefine.PlayerStatsType = {
  AttentionCommunity = "AttentionCommunity",
  ShareReward = "ShareReward",
  LoginDay = "LoginDay",
  PeriodLoginDay = "PeriodLoginDay",
  Summon = "Summon",
  DiamondSummon = "DiamondSummon",
  DiamondSummonWeapon = "DiamondSummonWeapon",
  HiddenItem = "HiddenItem",
  AppointTask = "AppointTask",
  PassStageGroup = "PassStageGroup",
  ShopBuy = "ShopBuy",
  ItemCompose = "ItemCompose",
  TalentActive = "TalentActive",
  TrinketSuitMaxNum = "TrinketSuitMaxNum",
  Stage = "Stage",
  Awaker = "Awaker",
  AwakerUnlockBreakSkill = "AwakerUnlockBreakSkill",
  AwakerSkillUpgrade = "AwakerSkillUpgrade",
  OnceMaxDamage = "OnceMaxDamage",
  UseBlackPrintNum = "UseBlackPrintNum",
  PersonalStageGroupTypeWinCount = "PersonalStageGroupTypeWinCount",
  LevelHideCount = "LevelHideCount",
  TrinketTrain = "TrinketTrain",
  TranslateGratitudeReward = "TranslateGratitudeReward",
  OSLoginReward_PC = "OSLoginReward_PC",
  OSLoginReward_MOBILE = "OSLoginReward_MOBILE"
}
CommonDefine.TrinketEquipViewType = {
  PartSelect = "PartSelect",
  SuitSelect = "SuitSelect",
  SuitEdit = "SuitEdit"
}
CommonDefine.SummonType = {Normal = 1, Diamond = 2}
CommonDefine.PlayerStatsKey = {
  base = "base",
  daily = "daily",
  week = "week",
  stage = "stage",
  global = "global"
}
CommonDefine.TransparentBG = "Transparent"
CommonDefine.MultiSummonTimes = 5
CommonDefine.Player_Respawn_Timeline = "TimelineRoot/Skill/Keeper/BUnit_Keeper/BUnit_Keeper_Skill0.prefab"
CommonDefine.Player_Respawn_TLKey = "BUnit_Keeper"
CommonDefine.Player_Respawn_TLSkillKey = "Skill0"
CommonDefine.WeaponSlotType = {Primary = 1, Secondary = 2}
CommonDefine.WeaponSlotGroup = {
  CommonDefine.WeaponSlotType.Primary,
  CommonDefine.WeaponSlotType.Secondary
}
CommonDefine.LotteryRewardType = {Core = 1, Normal = 2}
CommonDefine.StateDurationIcon = {
  CurrRound = "UIResources/AtlasSource/UI_Battle_Icon/UI_Battle_White_Buff_012.png",
  CurrBattle = "UIResources/AtlasSource/UI_Battle_Icon/UI_Battle_White_Buff_013.png",
  CurrExplore = "UIResources/AtlasSource/UI_Battle_Icon/UI_Battle_White_Buff_014.png"
}
CommonDefine.BloodHealIcon = "UIResources/AtlasSource/UI_Battle_Icon/Battle_Job_4.png"
CommonDefine.DerivativeCardIcon = "UIResources/AtlasSource/UI_Battle_Card/Battle_Card_Buff_044.png"
CommonDefine.PVPCollectionFilterType = {
  All = "All",
  Chaos = "Chaos",
  Blood = "Blood",
  Dimension = "Dimension",
  Ocean = "Ocean",
  Weapon = "Weapon",
  KeeperSkill = "KeeperSkill"
}
CommonDefine.PVPCollectionType = {
  Awaker = "CollectionTypeAwaker",
  Weapon = "CollectionTypeWeapon",
  KeeperSkill = "CollectionTypeKeeperSkill"
}
CommonDefine.PVPCollectionDetailTab = {
  Detail = "Detail",
  Rank = "Rank",
  Comment = "Comment"
}
CommonDefine.WeaponRefineAttrFactor = {
  Orange = DT.GetConstant("WeaponRefineAttrSSR"),
  Purple = DT.GetConstant("WeaponRefineAttrSR"),
  Blue = DT.GetConstant("WeaponRefineAttrR")
}
CommonDefine.PvpMatchingAnimState = {
  None = "None",
  SearchingLoop = "SearchingLoop",
  SearchingSuccess = "SearchingSuccess",
  TransformVideo = "TransformVideo",
  End = "End"
}
local pvpRanks = {}
for _, rank in pairs(DT.PVPRank) do
  table.insert(pvpRanks, rank)
end
table.sort(pvpRanks, function(a, b)
  return a.BaseSortID > b.BaseSortID
end)
CommonDefine.HighestPVPRank = pvpRanks[1]
CommonDefine.PVPRankStageIcon = {
  ["Ⅰ"] = "UIResources/AtlasSource/HD/UI_Awaker_Image/UI_Awaker_Image_Trinket_Parts1.png",
  ["Ⅱ"] = "UIResources/AtlasSource/HD/UI_Awaker_Image/UI_Awaker_Image_Trinket_Parts2.png",
  ["Ⅲ"] = "UIResources/AtlasSource/HD/UI_Awaker_Image/UI_Awaker_Image_Trinket_Parts3.png",
  ["Ⅳ"] = "UIResources/AtlasSource/HD/UI_Awaker_Image/UI_Awaker_Image_Trinket_Parts4.png",
  ["Ⅴ"] = "UIResources/AtlasSource/HD/UI_Awaker_Image/UI_Awaker_Image_Trinket_Parts5.png",
  ["Ⅵ"] = "UIResources/AtlasSource/HD/UI_Awaker_Image/UI_Awaker_Image_Trinket_Parts6.png"
}
CommonDefine.AbyssPassTextBgImg = {
  Normal = "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_Image_Quality_1.png",
  Perfect = "UIResources/AtlasSource/UI_Dungeous_Image/UI_Dungeous_Common/UI_Dungeous_Image_Quality_2.png"
}
CommonDefine.TrinketFilterState = {
  FilterDefault = 0,
  FilterInclude = 1,
  FilterExclude = 2
}
CommonDefine.PVPShopID = 18653

function CommonDefine.GetRelicTypeNameMap()
  return {
    Orange = LT.Text("OrangeRelicTypeName"),
    White = LT.Text("WhiteRelicTypeName"),
    Purple = LT.Text("PurpleRelicTypeName"),
    Red = LT.Text("RedRelicTypeName"),
    Forged = LT.Text("ForgedRelicTypeName")
  }
end

function CommonDefine.GetEnchantTypeNameMap()
  return {
    Orange = LT.Text("OrangeEnchantConfigTypeName"),
    White = LT.Text("WhiteEnchantConfigTypeName"),
    Red = LT.Text("RedEnchantConfigTypeName")
  }
end

function CommonDefine.ItemAwardType2TagMap()
  return {
    [CommonDefine.ItemAwardType.Normal] = "",
    [CommonDefine.ItemAwardType.First3Star] = LT.Text("CommonItemFirst3Star"),
    [CommonDefine.ItemAwardType.First] = LT.Text("CommonItemFirst"),
    [CommonDefine.ItemAwardType.FirstMult] = LT.Text("FirstTimeNormalRewardTagText"),
    [CommonDefine.ItemAwardType.Explore] = LT.Text("CommonItemExplore"),
    [CommonDefine.ItemAwardType.Battle] = LT.Text("CommonItemBattle"),
    [CommonDefine.ItemAwardType.Shop] = LT.Text("CommonItemShop"),
    [CommonDefine.ItemAwardType.Hide] = LT.Text("CommonItemHide"),
    [CommonDefine.ItemAwardType.Achievement] = LT.Text("CommonItemAchievement"),
    [CommonDefine.ItemAwardType.DoubleOutput] = LT.Text("CommonItemDoubleOutputActivity"),
    [CommonDefine.ItemAwardType.DailyFirst] = LT.Text("CommonItemDailyFirst"),
    [CommonDefine.ItemAwardType.Talent] = LT.Text("ResonanceRewardTagText"),
    [CommonDefine.ItemAwardType.CoreReward] = LT.Text("LotteryCoreRewardLabel"),
    [CommonDefine.ItemAwardType.BonusCard] = LT.Text("BonusCardAwardText"),
    [CommonDefine.ItemAwardType.ExpBonus] = LT.Text("RewardItemAccelerateTag")
  }
end

CommonDefine.CannotRuneType = {
  Card_Awake = true,
  Card_Curse = true,
  Card_Potion = true,
  Card_State = true,
  Card_Imagery = true,
  Card_AdvancedImagery = true
}
CommonDefine.FriendMatchStatus = {
  Close = 0,
  Inviting = 1,
  ChooseTeam = 2,
  Finish = 3,
  Timeout = 100,
  Refused = 101
}
CommonDefine.UseTimesLimitType = {
  Awaker = "Awaker",
  Weapon = "Weapon",
  KeyToken = "KeyToken"
}
CommonDefine.SpecialMonsterAnim = {Cat = 71645}
CommonDefine.AttachPostActionPerformType = {
  None = 0,
  ActorPainting = 1,
  CardFace = 2
}
CommonDefine.Schoolweight = {
  [1] = 4,
  [2] = 2,
  [3] = 1,
  [4] = 3
}
CommonDefine.ExpiredItemTidList = {
  DT.GetConstant("BPLimitItem")
}
CommonDefine.TimeEndShowColor = {
  Near = "#FF5C5C",
  Middle = "#B5AE88",
  Far = "#ACBFC9"
}
return CommonDefine
