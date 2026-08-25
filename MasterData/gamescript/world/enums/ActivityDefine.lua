local Readonly = System.readonly
local M = {}
M.ActivityDisplayType = {
  NeverShow = 0,
  Normal = 1,
  AlwaysShow = 2
}
M.WhereShow = {ActivityMainPanel = 0, GamePassport = 1}
M.ActivityState = {
  NotOpen = "NotOpen",
  Ready = "Ready",
  Running = "Running",
  Finish = "Finish"
}
M.ActivityTimeType = {
  CreateRoleAfter = "AfterCreateRole",
  Permanent = "Permanent",
  FixedTime = "FixedTime"
}
M.ActivityType = {
  SummerChapter1Activity = "SummerChapter1Activity",
  SummerChapter2Activity = "SummerChapter2Activity",
  SecondAnniversarySign = "TwoYearCelebrationSignActivity",
  SevenDayLogin = "SevenDayLoginActivity",
  TaskList = "TaskListActivity",
  PreOrder = "PreOrderActivity",
  NewPreOrder = "NewPreOrderActivity",
  DoubleOutput = "DoubleOutputActivity",
  AwakerTrial = "AwakerTrialActivity",
  SubPlot = "SubplotActivity",
  DoubleExp = "DoubleExperienceActivity",
  Abyss = "AbyssChallengeActivity",
  MagicStory = "MagicStoryActivity",
  Wanda = "WandaActivity",
  Salvador = "SalvadorActivity",
  SpecialTaskList = "SpecialTaskList",
  A24 = "A24Activity",
  Thais = "ThaisActivity",
  SignReceiveAwake = "SignReceiveAwakerActivity",
  FiveDaySign = "FiveDaySignActivity",
  SignReceiveWeapon = "SignReceiveWeaponActivity",
  ConfessionEventDiscountActivity = "ConfessionEventDiscountActivity",
  HomologyDoubleActivity = "HomologyDoubleActivity",
  MagicStoryActivityReproduce = "MagicStoryActivityReproduce",
  Miryam = "MiryamActivity",
  ShopActivity = "ShopActivity",
  SorelActivity = "SorelActivity",
  HorlaActivity = "HorlaActivity",
  MurphyActivity = "MurphyActivity",
  RykerActivity = "RykerActivity",
  HamelnActivity = "HamelnActivity",
  A24ActivityReproduce = "A24ActivityReproduce",
  OriginHelotActivity = "OriginHelotActivity",
  WandaActivityReproduce = "WandaActivityReproduce",
  TawilActivity = "TawilActivity",
  TuluActivity = "TuluActivity",
  TurntableActivity = "TurntableActivity",
  MiryamActivityReproduce = "MiryamActivityReproduce",
  OriginDollActivity = "OriginDollActivity",
  SalvadorActivityReproduce = "SalvadorActivityReproduce",
  LinkPackageSale = "LinkPackageSaleActivity",
  SignReceiveAnyWeaponActivity = "SignReceiveAnyWeaponActivity",
  WorldBoss = "WorldBossActivity",
  DeepSeaInvasionDefensive = "DeepSeaInvasionDefensiveActiviity",
  DaffodilActivity = "DaffodilActivity",
  ClementineActivity = "ClementineActivity",
  ModiglianActivity = "ModiglianActivity",
  OriginMurphyActivity = "OriginMurphyActivity",
  FirstTimeLimitedSale = "FirstTimeLimitedSale",
  AntrakActivity = "AntrakActivity",
  LulimActivity = "LulimActivity",
  OriginTuluActivity = "OriginTuluActivity",
  StageOnlyActivity = "StageOnlyActivity",
  PVPReverseRoundActivity = "PVPReverseRoundActivity",
  GoldenWeekActivity = "GoldenWeekActivity",
  StElmosFireActivity = "StElmosFireActivity",
  CastorActivity = "CastorActivity",
  DoresainActivity = "DoresainActivity",
  RomeActivity = "RomeActivity",
  KathiguRaActivity = "KathiguRaActivity",
  PickManActivity = "PickManActivity",
  PolluxActivity = "PolluxActivity",
  TwoAnniversaryWorldBossActivity = "TwoAnniversaryWorldBossActivity",
  MouchetteActivity = "MouchetteActivity",
  XuActivity = "XuActivity",
  RailWayActivity = "RailWayActivity",
  RailWaySeasonRankActivity = "RailWaySeasonRankActivity",
  MoskActivity = "MoskActivity",
  ArachneActivity = "ArachneActivity",
  SayaActivity = "SayaActivity",
  TwoAndAHalfAnniversaryRAIDActiviity = "TwoAndAHalfAnniversaryRAIDActiviity",
  TwoAndAHalfAnniversaryRechargeActiviity = "TwoAndAHalfAnniversaryRechargeActiviity",
  PontosActivity = "PontosActivity",
  LotanCetarchonActivity = "LotanCetarchonActivity",
  CarabooActivity = "CarabooActivity"
}
M.ActivitySystemType = {
  ReturnEvent = "ReturnEvent",
  HalfAnniversaryCelebrationActivity = "HalfAnniversaryCelebrationActivity",
  SecondAnniversaryCelebrationActivity = "TwoYearCelebrationActivity",
  BattlePassActivity = "BattlePassActivity",
  ReturnEventGroup = "ReturnEventGroup",
  LoginByMonthActivity = "LoginByMonthActivity",
  YearAndAHalfCelebrationActivity = "YearAndAHalfCelebrationActivity",
  SkinTask = "SkinTask",
  MouchetteCrossoverActivity = "MouchetteCrossoverActivity",
  BattleTeachingActivity = "BattleTeachingActivity"
}
M.ActivityCompClsInfo = {
  [M.ActivityType.SevenDayLogin] = {
    compPath = SevenDayLoginComp,
    resPath = UI_Events_Panel_AttendanceResource
  },
  [M.ActivityType.GoldenWeekActivity] = {
    compPath = ActivityKarenComp,
    resPath = UI_Events_Panel_KarenResource,
    fadeTime = 0.5,
    openAnim = "UI_Events_Panel_Karen_Open",
    closeAnim = "UI_Events_Panel_Karen_Close"
  },
  [M.ActivityType.AwakerTrial] = {
    compPath = AwakerTrialComp,
    resPath = UI_Events_Panel_TryResource
  },
  [M.ActivityType.SubPlot] = {
    compPath = ActivitySubplotComp,
    resPath = UI_Events_Panel_BranchResource
  },
  [M.ActivityType.DoubleOutput] = {
    compPath = DoubleOutputComp,
    resPath = UI_Events_Panel_DoubleDropResource
  },
  [M.ActivityType.TaskList] = {
    compPath = ActivityTaskListComp,
    resPath = UI_Events_Panel_SurveyDiaryResource,
    [M.ActivitySystemType.ReturnEventGroup] = {
      compPath = ActivityPassportTaskListComp,
      resPath = UI_Events_Panel_ActivityPassportResource
    },
    [M.ActivitySystemType.BattlePassActivity] = {
      compPath = ActivityGamePassportComp,
      resPath = ActivityGamePassportComp.uiResCls
    },
    [M.ActivitySystemType.BattleTeachingActivity] = {
      compPath = ActivityBattleTeachingTaskListComp,
      resPath = UI_Events_BattleTeachingResource
    }
  },
  [M.ActivityType.TwoAndAHalfAnniversaryRechargeActiviity] = {
    compPath = ActivityTaskListComp,
    resPath = UI_Events_Panel_SurveyDiaryResource,
    [M.ActivitySystemType.ReturnEventGroup] = {
      compPath = ActivityPassportTaskListComp,
      resPath = UI_Events_Panel_ActivityPassportResource
    },
    [M.ActivitySystemType.BattlePassActivity] = {
      compPath = ActivityGamePassportComp,
      resPath = ActivityGamePassportComp.uiResCls
    },
    [M.ActivitySystemType.BattleTeachingActivity] = {
      compPath = ActivityBattleTeachingTaskListComp,
      resPath = UI_Events_BattleTeachingResource
    }
  },
  [M.ActivityType.PreOrder] = {
    compPath = ActivityPreOrderPanel,
    resPath = UI_Events_Panel_PreOrderGiftResource
  },
  [M.ActivityType.NewPreOrder] = {
    compPath = ActivityPreOrderPanel,
    resPath = UI_Events_Panel_PreOrderGiftResource
  },
  [M.ActivityType.DoubleExp] = {
    compPath = ActivityDoubleExpComp,
    resPath = UI_Events_Panel_AwardResource
  },
  [M.ActivityType.MagicStory] = {
    compPath = ActivityMagicStoryComp,
    resPath = UI_Events_Panel_MagicStoryResource
  },
  [M.ActivityType.Wanda] = {
    compPath = ActivityWandaComp,
    resPath = UI_Events_Panel_WandaResource,
    avgFeatureId = CommonDefine.FeatureId.WandaActivity,
    resonanceGroup = CommonDefine.WandaResonance,
    isUniqueRed = true
  },
  [M.ActivityType.Salvador] = {
    compPath = ActivitySalvadorComp,
    resPath = UI_Events_Panel_BanquetResource,
    avgFeatureId = CommonDefine.FeatureId.Salvador,
    resonanceGroup = CommonDefine.SalvadorResonance,
    isUniqueRed = true
  },
  [M.ActivityType.SpecialTaskList] = {
    compPath = ActivitySpecialTaskListComp,
    resPath = UI_Events_Panel_SurveyDiaryResource
  },
  [M.ActivityType.A24] = {
    compPath = ActivityTwentyFourComp,
    resPath = UI_Events_Panel_TwentyFourResource,
    avgFeatureId = CommonDefine.FeatureId.TwentyFourActivity,
    resonanceGroup = CommonDefine.TwentyFourResonance,
    isUniqueRed = true
  },
  [M.ActivityType.Thais] = {
    compPath = ActivityThaisComp,
    resPath = UI_Events_Panel_ThaisResource,
    avgFeatureId = CommonDefine.FeatureId.ThaisActivity,
    isUniqueRed = true
  },
  [M.ActivityType.SignReceiveAwake] = {
    compPath = ActivitySignReceiveAwakeComp,
    resPath = UI_Event_Activity_XiaomaoGiftResource,
    [M.ActivitySystemType.MouchetteCrossoverActivity] = {
      compPath = ActivitySignReceiveMouchetteComp,
      resPath = UI_Event_Activity_SummonBenefitsResource
    }
  },
  [M.ActivityType.ShopActivity] = {
    compPath = ActivityShopComp,
    resPath = UI_Events_Panel_Back_To_SchoolResource
  },
  [M.ActivityType.FiveDaySign] = {
    compPath = ActivityDaySignComp,
    resPath = UI_Events_SignDiamondResource
  },
  [M.ActivityType.SignReceiveWeapon] = {
    compPath = ActivitySignReceiveWeaponComp,
    resPath = UI_Events_Activity_WeaponSignResource
  },
  [M.ActivityType.MagicStoryActivityReproduce] = {
    compPath = ActivityLilyComp,
    resPath = UI_Events_Panel_LilyResource,
    resonanceGroup = CommonDefine.LilyResonance,
    isUniqueRed = true
  },
  [M.ActivityType.Miryam] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_MiriamResource,
    resonanceGroup = CommonDefine.ResonanceGroupO07Activity,
    isUniqueRed = true,
    fadeTime = 0.5,
    openAnim = nil,
    closeAnim = nil
  },
  [M.ActivityType.SorelActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_SorelResource,
    isUniqueRed = true,
    fadeTime = 0.5,
    openAnim = "UI_Events_Panel_Sorel_Open",
    closeAnim = "UI_Events_Panel_Sorel_Close"
  },
  [M.ActivityType.HorlaActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_HorlaResource,
    resonanceGroup = CommonDefine.HorlaResonanceGroup,
    isUniqueRed = true,
    fadeTime = 2.5,
    openTimeline = "TimelineRoot/AwakerPortrait/UI_Events_Ani_Awaker_D06/UI_Events_Ani_Awaker_D06.prefab"
  },
  [M.ActivityType.MurphyActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_MurphyResource,
    isUniqueRed = true,
    openAnim = "UI_Events_Panel_Murphy_Open",
    closeAnim = "UI_Events_Panel_Murphy_Close"
  },
  [M.ActivityType.SummerChapter1Activity] = {
    compPath = ActivitySummerChapter1Comp,
    resPath = UI_Events_Panel_Summer1Resource,
    isUniqueRed = true,
    fadeTime = 0.5,
    openAnim = "UI_Events_Panel_Summer1_Open",
    closeAnim = "UI_Events_Panel_Summer1_Close"
  },
  [M.ActivityType.SummerChapter2Activity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_Summer2Resource,
    isUniqueRed = true,
    fadeTime = 1,
    openAnim = "UI_Events_Panel_Summer2_Open",
    closeAnim = "UI_Events_Panel_Summer2_Close"
  },
  [M.ActivityType.RykerActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_RykerResource,
    isUniqueRed = true,
    fadeTime = 0.5,
    openAnim = "UI_Events_Panel_Ryker_Open",
    closeAnim = "UI_Events_Panel_Ryker_Close"
  },
  [M.ActivityType.RomeActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_RomeResource,
    isUniqueRed = true,
    openAnim = "UI_Events_Panel_Rome_Open",
    closeAnim = "UI_Events_Panel_Rome_Close"
  },
  [M.ActivityType.HamelnActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_HamlineResource,
    isUniqueRed = true,
    fadeTime = 1.5,
    openTimeline = "TimelineRoot/AwakerPortrait/UI_Events_Ani_Awaker_D12/UI_Events_Ani_Awaker_D12.prefab"
  },
  [M.ActivityType.A24ActivityReproduce] = {
    compPath = ActivityTwentyFourComp,
    resPath = UI_Events_Panel_TwentyFourResource,
    avgFeatureId = CommonDefine.FeatureId.TwentyFourActivity,
    resonanceGroup = CommonDefine.TwentyFourResonance,
    isUniqueRed = true,
    fadeTime = 0.6
  },
  [M.ActivityType.OriginHelotActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_OriHelotResource,
    resonanceGroup = CommonDefine.ResonanceGroupOriginHelot,
    isUniqueRed = true,
    fadeTime = 4.8,
    openTimeline = "TimelineRoot/AwakerPortrait/UI_Events_Ani_Awaker_B05EX/UI_Events_Ani_Awaker_B05EX.prefab"
  },
  [M.ActivityType.WandaActivityReproduce] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_WandaResource,
    avgFeatureId = CommonDefine.FeatureId.WandaActivity,
    resonanceGroup = CommonDefine.WandaResonance,
    isUniqueRed = true,
    fadeTime = 0.5,
    openAnim = "UI_Events_Panel_Wanda_Open",
    closeAnim = "UI_Events_Panel_Wanda_Close"
  },
  [M.ActivityType.TawilActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_TawilResource,
    isUniqueRed = true,
    fadeTime = 1,
    openAnim = "UI_Events_Panel_Tawil_Open",
    closeAnim = "UI_Events_Panel_Tawil_Close"
  },
  [M.ActivityType.TuluActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_TuluResource,
    isUniqueRed = true,
    fadeTime = 1.2,
    openAnim = "UI_Events_Panel_Tulu_Open",
    closeAnim = "UI_Events_Panel_Tulu_Close"
  },
  [M.ActivityType.TurntableActivity] = {
    compPath = ActivityTurntableComp,
    resPath = UI_Events_Panel_ClotherLotteryResource,
    fadeTime = 0.5,
    openAnim = "UI_Events_Panel_ClotherLottery_Open",
    closeAnim = "UI_Events_Panel_ClotherLottery_Close"
  },
  [M.ActivityType.MiryamActivityReproduce] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_MiriamResource,
    resonanceGroup = CommonDefine.ResonanceGroupO07Activity,
    isUniqueRed = true,
    fadeTime = 1.3,
    openAnim = nil,
    closeAnim = nil
  },
  [M.ActivityType.OriginDollActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_OriDollResource,
    isUniqueRed = true,
    fadeTime = 0.8,
    openTimeline = "TimelineRoot/AwakerPortrait/UI_Events_Ani_Awaker_C02EX/UI_Events_Ani_Awaker_C02EX.prefab"
  },
  [M.ActivityType.StageOnlyActivity] = {
    compPath = ActivitySchoolCatComp,
    resPath = UI_Events_Panel_TeamSchoolResource,
    isUniqueRed = true,
    fadeTime = 1.2,
    openAnim = "UI_Events_Panel_TeamSchool_Open",
    closeAnim = "UI_Events_Panel_TeamSchool_Close"
  },
  [M.ActivityType.SalvadorActivityReproduce] = {
    compPath = ActivitySalvadorComp,
    resPath = UI_Events_Panel_BanquetResource,
    avgFeatureId = CommonDefine.FeatureId.Salvador,
    resonanceGroup = CommonDefine.SalvadorResonance,
    isUniqueRed = true,
    fadeTime = 0.6
  },
  [M.ActivityType.SignReceiveAnyWeaponActivity] = {
    compPath = ActivityWeaponOptionalComp,
    resPath = UI_Event_WeaponOptionalResource
  },
  [M.ActivityType.WorldBoss] = {
    compPath = ActivityWorldBossComp,
    resPath = UI_Events_Panel_WorldBossResource,
    fadeTime = 1,
    changeBgImage = M.ActivityType.WorldBoss,
    openAnim = "UI_Events_Panel_WorldBoss_Open",
    closeAnim = "UI_Events_Panel_WorldBoss_Close",
    startHideChild = 2
  },
  [M.ActivityType.TwoAnniversaryWorldBossActivity] = {
    compPath = ActivityWorldBossComp,
    resPath = UI_Events_Panel_WorldBossResource,
    fadeTime = 1,
    changeBgImage = M.ActivityType.WorldBoss,
    openAnim = "UI_Events_Panel_WorldBoss_Open",
    closeAnim = "UI_Events_Panel_WorldBoss_Close",
    startHideChild = 2
  },
  [M.ActivityType.DeepSeaInvasionDefensive] = {
    compPath = ActivityWorldOceanBossComp,
    resPath = UI_Events_Panel_OceanBossResource,
    fadeTime = 1,
    openTimeline = "TimelineRoot/AwakerPortrait/UI_Events_Ani_Awaker_William/UI_Events_Ani_Awaker_William.prefab",
    startHideChild = 2
  },
  [M.ActivityType.PVPReverseRoundActivity] = {
    compPath = ActivityPVPReRoundComp,
    resPath = UI_Events_Panel_PVPReRoundResource,
    fadeTime = 1.2,
    isUniqueRed = true,
    openAnim = "UI_Events_Panel_PVPReRound_Open",
    closeAnim = "UI_Events_Panel_PVPReRound_Close"
  },
  [M.ActivityType.DaffodilActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_DaffodilResource,
    isUniqueRed = true,
    openAnim = "UI_Events_Panel_Daffodil_Open",
    closeAnim = "UI_Events_Panel_Daffodil_Close"
  },
  [M.ActivityType.ClementineActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_ClementineResource,
    isUniqueRed = true,
    fadeTime = 1.2,
    openTimeline = "TimelineRoot/AwakerPortrait/UI_Events_Ani_Awaker_D13_AT/UI_Events_Ani_Awaker_D13_AT.prefab",
    closeAnim = "UI_Events_Panel_Clementine_Close"
  },
  [M.ActivityType.StElmosFireActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_StElmosFireResource,
    isUniqueRed = true,
    openAnim = "UI_Events_Panel_StElmosFire_Open",
    closeAnim = "UI_Events_Panel_StElmosFire_Close"
  },
  [M.ActivityType.CastorActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_CastorResource,
    isUniqueRed = true,
    openAnim = "UI_Events_Panel_Castor_Open",
    closeAnim = "UI_Events_Panel_Castor_Close"
  },
  [M.ActivityType.DoresainActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_DoresainResource,
    isUniqueRed = true,
    openTimeline = "TimelineRoot/AwakerPortrait/UI_Events_Ani_Awaker_B10/UI_Events_Ani_Awaker_B10.prefab",
    closeAnim = "UI_Events_Panel_Doresain_Close"
  },
  [M.ActivityType.KathiguRaActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_KathiguRaResource,
    isUniqueRed = true,
    openAnim = "UI_Events_Panel_KathiguRa_Open",
    closeAnim = "UI_Events_Panel_KathiguRa_Close"
  },
  [M.ActivityType.MouchetteActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_MouchetteResource,
    isUniqueRed = true,
    fadeTime = 1,
    openAnim = "UI_Events_Panel_Mouchette_Open",
    closeAnim = "UI_Events_Panel_Mouchette_Close"
  },
  [M.ActivityType.PolluxActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_PolluxResource,
    isUniqueRed = true,
    fadeTime = 2,
    openAnim = "UI_Events_Panel_Pollux_Open",
    closeAnim = "UI_Events_Panel_Pollux_Close"
  },
  [M.ActivityType.XuActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_XuResource,
    isUniqueRed = true,
    fadeTime = 1,
    openAnim = "UI_Events_Panel_Xu_Open",
    closeAnim = "UI_Events_Panel_Xu_Close"
  },
  [M.ActivityType.MoskActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_MoskResource,
    isUniqueRed = true,
    fadeTime = 1,
    openAnim = "UI_Events_Panel_Mosk_Open",
    closeAnim = "UI_Events_Panel_Mosk_Close"
  },
  [M.ActivityType.ArachneActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_ArachneResource,
    isUniqueRed = true,
    fadeTime = 1,
    openAnim = "UI_Events_Panel_Common_Open",
    closeAnim = "UI_Events_Panel_Common_Close",
    openVideoPath = "Vx/UI_Events_Panel_Arachne.mp4"
  },
  [M.ActivityType.RailWayActivity] = {
    compPath = ActivityRailWayComp,
    resPath = UI_Events_Panel_RailWayResource,
    isUniqueRed = true,
    fadeTime = 0.7,
    openAnim = "UI_Events_Panel_RailWay_Open",
    closeAnim = "UI_Events_Panel_RailWay_Close",
    resonanceGroup = CommonDefine.ResonanceGroupRailway
  },
  [M.ActivityType.TwoAndAHalfAnniversaryRAIDActiviity] = {
    compPath = ActivityRAIDComp,
    resPath = UI_Events_Panel_RAIDResource,
    fadeTime = 0.5
  },
  [M.ActivityType.SayaActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_SayaResource,
    isUniqueRed = true,
    fadeTime = 1,
    openAnim = "UI_Events_Panel_Common_Open",
    closeAnim = "UI_Events_Panel_Common_Close",
    openVideoPath = "Vx/UI_Events_Panel_Saya.mp4"
  },
  [M.ActivityType.PontosActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_PontosResource,
    isUniqueRed = true,
    fadeTime = 1,
    openAnim = "UI_Events_Panel_Common_Open",
    closeAnim = "UI_Events_Panel_Common_Close",
    openVideoPath = "Vx/UI_Events_Panel_Pontos.mp4"
  },
  [M.ActivityType.ModiglianActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_TuluResource,
    isUniqueRed = true
  },
  [M.ActivityType.OriginMurphyActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_OriMurphyResource,
    isUniqueRed = true,
    openTimeline = "TimelineRoot/AwakerPortrait/UI_Events_Ani_Awaker_O02EX/UI_Events_Ani_Awaker_O02EX.prefab",
    closeAnim = "UI_Events_Panel_OriMurphy_Close"
  },
  [M.ActivityType.AntrakActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_TuluResource,
    isUniqueRed = true
  },
  [M.ActivityType.LulimActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_TuluResource,
    isUniqueRed = true
  },
  [M.ActivityType.OriginTuluActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_TuluResource,
    isUniqueRed = true
  },
  [M.ActivityType.PickManActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_PickmanResource,
    isUniqueRed = true,
    fadeTime = 1,
    openAnim = "UI_Events_Panel_Pickman_Open",
    closeAnim = "UI_Events_Panel_Pickman_Close"
  },
  [M.ActivityType.LotanCetarchonActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_LotanCetarchonResource,
    isUniqueRed = true,
    fadeTime = 1,
    openAnim = "UI_Events_Panel_Common_Open",
    closeAnim = "UI_Events_Panel_Common_Close",
    openVideoPath = "Vx/UI_Events_Panel_LotanCetarchon.mp4"
  },
  [M.ActivityType.CarabooActivity] = {
    compPath = ActivityAwakerTopicComp,
    resPath = UI_Events_Panel_CarabooResource,
    isUniqueRed = true,
    fadeTime = 1.4,
    openAnim = "UI_Events_Panel_Common_Open",
    closeAnim = "UI_Events_Panel_Common_Close",
    openIntroVideoPath = "Vx/UI_Events_Panel_Caraboo_In.mp4",
    openVideoPath = "Vx/UI_Events_Panel_Caraboo.mp4"
  }
}
M.DefaultCompClsInfo = {
  compPath = ActivityAwakerTopicComp,
  resPath = UI_Events_Panel_TuluResource,
  isUniqueRed = true,
  fadeTime = 1.2,
  openAnim = "UI_Events_Panel_Tulu_Open",
  closeAnim = "UI_Events_Panel_Tulu_Close",
  videoPlayerNodeName = "VideoPlayer",
  videoPlayerBakNodeName = "VideoPlayerBak"
}
M.DefaultStageGroupDefine = {
  StageGroupCellObjName = "UI_Event_Item_TwentyFour_Level",
  StageGroupChildUINodeName = "UI_Events_Item_TwentyFour_",
  StageGroupUIResCls = UI_Event_Item_TwentyFour_LevelResource,
  StageGroupChildUIResCls = UI_Events_Item_TwentyFourResource,
  StageGroupDiffPosNum = 5
}
M.StageGroupDefine = {
  [M.ActivityType.A24] = {
    StageGroupCellObjName = "UI_Event_Item_TwentyFour_Level",
    StageGroupChildUINodeName = "UI_Events_Item_TwentyFour_",
    StageGroupUIResCls = UI_Event_Item_TwentyFour_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_TwentyFourResource,
    StageGroupDiffPosNum = 5,
    PanelResCls = UI_Event_Panel_Activity_TwentyFourResource,
    isDoubleFight = true,
    isSetDailyIcon = false
  },
  [M.ActivityType.Salvador] = {
    StageGroupCellObjName = "UI_Events_Item_Level",
    StageGroupChildUINodeName = "UI_Events_Item_Lake_City_",
    StageGroupUIResCls = UI_Events_Item_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_Lake_CityResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Lake_CityResource,
    isDoubleFight = true,
    isSetDailyIcon = false
  },
  [M.ActivityType.Thais] = {
    StageGroupCellObjName = "UI_Events_Item_Level",
    StageGroupChildUINodeName = "UI_Events_Item_Lake_City_",
    StageGroupUIResCls = UI_Events_Item_Level_ThaisResource,
    StageGroupChildUIResCls = UI_Events_Item_ThaisResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Thais_StageGroupResource,
    isSetDailyIcon = true
  },
  [M.ActivityType.MagicStoryActivityReproduce] = {
    StageGroupCellObjName = "UI_Event_Item_Lily_Level",
    StageGroupChildUINodeName = "UI_Events_Item_Lily_",
    StageGroupUIResCls = UI_Event_Item_Lily_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_LilyResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Lily_StageGroupResource,
    isSetDailyIcon = true
  },
  [M.ActivityType.Wanda] = {
    StageGroupCellObjName = "UI_Events_Item_Wanda_Level",
    StageGroupChildUINodeName = "UI_Events_Item_Wanda_",
    StageGroupUIResCls = UI_Events_Item_Wanda_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_WandaResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Wanda_StageGroupResource,
    isSetDailyIcon = true
  },
  [M.ActivityType.Miryam] = {
    StageGroupCellObjName = "UI_Event_Item_Miriam_Level",
    StageGroupChildUINodeName = "UI_Events_Item_Miriam_",
    StageGroupUIResCls = UI_Event_Item_Miriam_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_MiriamResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Miriam_StageGroupResource,
    isSetDailyIcon = false,
    isDoubleFight = true
  },
  [M.ActivityType.SorelActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Sorel_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.HorlaActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Horla_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.MurphyActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Murphy_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.RykerActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Ryker_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.SummerChapter1Activity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Summer1_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.SummerChapter2Activity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Summer2_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.HamelnActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Hameln_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.A24ActivityReproduce] = {
    StageGroupCellObjName = "UI_Event_Item_TwentyFour_Level",
    StageGroupChildUINodeName = "UI_Events_Item_TwentyFour_",
    StageGroupUIResCls = UI_Event_Item_TwentyFour_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_TwentyFourResource,
    StageGroupDiffPosNum = 5,
    PanelResCls = UI_Event_Panel_Activity_TwentyFourResource,
    isDoubleFight = true,
    isSetDailyIcon = false
  },
  [M.ActivityType.OriginHelotActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_OriHelot_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.WandaActivityReproduce] = {
    StageGroupCellObjName = "UI_Events_Item_Wanda_Level",
    StageGroupChildUINodeName = "UI_Events_Item_Wanda_",
    StageGroupUIResCls = UI_Events_Item_Wanda_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_WandaResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Wanda_StageGroupResource,
    isSetDailyIcon = true
  },
  [M.ActivityType.TawilActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Tawil_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.TuluActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Tulu_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.MiryamActivityReproduce] = {
    StageGroupCellObjName = "UI_Event_Item_Miriam_Level",
    StageGroupChildUINodeName = "UI_Events_Item_Miriam_",
    StageGroupUIResCls = UI_Event_Item_Miriam_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_MiriamResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Miriam_StageGroupResource,
    isSetDailyIcon = false,
    isDoubleFight = true
  },
  [M.ActivityType.OriginDollActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_OriDoll_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.RomeActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Rome_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.SalvadorActivityReproduce] = {
    StageGroupCellObjName = "UI_Events_Item_Level",
    StageGroupChildUINodeName = "UI_Events_Item_Lake_City_",
    StageGroupUIResCls = UI_Events_Item_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_Lake_CityResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Lake_CityResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.WorldBoss] = {
    StageGroupCellObjName = "UI_Event_WorldBoss_Level",
    StageGroupChildUINodeName = "UI_Events_Item_WorldBoss_",
    StageGroupUIResCls = UI_Event_WorldBoss_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_WorldBossResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_WorldBoss_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.TwoAndAHalfAnniversaryRAIDActiviity] = {
    StageGroupCellObjName = "UI_Event_Item_RAID_Level",
    StageGroupChildUINodeName = "UI_Events_Item_RAID_",
    StageGroupUIResCls = UI_Event_Item_RAID_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_RAIDResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_RAID_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.TwoAnniversaryWorldBossActivity] = {
    StageGroupCellObjName = "UI_Event_2ndAnnivWorldBoss_Level",
    StageGroupChildUINodeName = "UI_Events_Item_WorldBoss_",
    StageGroupUIResCls = UI_Event_2ndAnnivWorldBoss_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_BossStageGroupResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_2ndAnnivWB_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.DeepSeaInvasionDefensive] = {
    StageGroupCellObjName = "UI_Event_OceanBoss_Level",
    StageGroupChildUINodeName = "UI_Events_Item_OceanBoss_",
    StageGroupUIResCls = UI_Event_OceanBoss_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_OceanBossResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_OceanBoss_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.DaffodilActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Daffodil_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.ClementineActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Clementine_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.StElmosFireActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_StElmosFire_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.CastorActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Castor_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.DoresainActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Doresain_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.KathiguRaActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_KathiguRa_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.PickManActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Pickman_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.PolluxActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Pollux_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.MouchetteActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Mouchette_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.XuActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Xu_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.MoskActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Mosk_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.ArachneActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Arachne_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.SayaActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Saya_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.PontosActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Pontos_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.LotanCetarchonActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_LotanCetarchon_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.CarabooActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Caraboo_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.ModiglianActivity] = {
    StageGroupCellObjName = "UI_Event_Item_Sorel_Level",
    StageGroupChildUINodeName = "UI_Events_Item_Sorel_",
    StageGroupUIResCls = UI_Event_Item_Sorel_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_SorelResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Sorel_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.OriginMurphyActivity] = {
    StageGroupCellObjName = "UI_Event_Item_StElmosFire_Level",
    StageGroupChildUINodeName = "UI_Events_Item_StElmosFire_",
    StageGroupUIResCls = UI_Event_Item_StElmosFire_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_StElmosFireResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_OriMurphy_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.AntrakActivity] = {
    StageGroupCellObjName = "UI_Event_Item_Sorel_Level",
    StageGroupChildUINodeName = "UI_Events_Item_Sorel_",
    StageGroupUIResCls = UI_Event_Item_Sorel_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_SorelResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Sorel_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.LulimActivity] = {
    StageGroupCellObjName = "UI_Event_Item_Sorel_Level",
    StageGroupChildUINodeName = "UI_Events_Item_Sorel_",
    StageGroupUIResCls = UI_Event_Item_Sorel_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_SorelResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Sorel_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.OriginTuluActivity] = {
    StageGroupCellObjName = "UI_Event_Item_Sorel_Level",
    StageGroupChildUINodeName = "UI_Events_Item_Sorel_",
    StageGroupUIResCls = UI_Event_Item_Sorel_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_SorelResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_Panel_Sorel_StageGroupResource,
    isSetDailyIcon = false
  },
  [M.ActivityType.StageOnlyActivity] = {
    StageGroupCellObjName = "UI_Event_Item_TeamSchool_Level",
    StageGroupChildUINodeName = "UI_Events_Item_TeamSchool_",
    StageGroupUIResCls = UI_Event_Item_TeamSchool_LevelResource,
    StageGroupChildUIResCls = UI_Events_Item_TeamSchoolResource,
    StageGroupDiffPosNum = 2,
    PanelResCls = UI_Events_TeamSchool_StageGroupResource,
    isSetDailyIcon = false,
    ScrollToOpeningStageGroup = true
  }
}
M.ActivityNone = 0
M.SevenDayLoginLastDay = 7
M.ReturnAwardTaskTid = 0

function M.GetActivityCompInfo(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    Logger.Error("找不到活动配置:", activityTid)
    return nil, nil
  end
  local activityClsInfo = ActivityDefine.ActivityCompClsInfo[config.ActivityType]
  if not activityClsInfo then
    Logger.Error(string.format("找不到活动类名信息: %s 将使用默认的图鲁活动信息", config.ActivityType))
  end
  return activityClsInfo or ActivityDefine.DefaultCompClsInfo
end

function M.GetActivityCompResPath(activityTid)
  local activityClsInfo = M.GetActivityCompInfo(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if activityClsInfo[config.ActivitySystemType] then
    activityClsInfo = activityClsInfo[config.ActivitySystemType]
  end
  if not (activityClsInfo and activityClsInfo.compPath) or not activityClsInfo.resPath then
    local reason = ""
    if not activityClsInfo then
      reason = reason .. " activityClsInfo=nil "
    elseif not activityClsInfo.compPath then
      reason = reason .. " compPath=nil "
    else
      reason = reason .. " resPath=nil "
    end
    Logger.Error(string.format("找不到活动类名信息, activityTid=%s, activityType=%s, activitySystemType=%s, reason=%s", tostring(activityTid), tostring(config and config.ActivityType), tostring(config and config.ActivitySystemType), reason))
    return nil, nil
  end
  assert(System.is(activityClsInfo.compPath, ActivityBaseComp), "活动类必须继承ActivityBaseComp")
  if config.ActivityType == M.ActivityType.SevenDayLogin and config.ActivitySystemType and config.ActivitySystemType == M.ActivitySystemType.LoginByMonthActivity then
    if #config.ActivityPara1 > 42 then
      return LoginByMonthComp, UI_Events_Panel_DailySignResource
    elseif #config.ActivityPara1 > 28 then
      return LoginByThreeWeeksComp, UI_Events_Panel_ThreeWeekResource
    else
      return LoginByTwoWeeksComp, UI_Events_Panel_TwoWeekSignResource
    end
  end
  if config.ActivityType == M.ActivityType.SevenDayLogin and config.ActivityPara4 then
    return ActivityHorseSpringSignComp, UI_Events_Panel_SpringSignResource
  end
  return activityClsInfo.compPath, activityClsInfo.resPath
end

M = Readonly(M, "ActivityDefine")
return M
