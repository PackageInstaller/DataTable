local System = require("System.System")
local readonly = System.readonly
local Constant = readonly({
  BeforLoginPV1 = {
    Key = "BeforLoginPV1",
    CnID = "常量@登录前视频1",
    Data = {0, 72105}
  },
  BeforLoginPV2 = {
    Key = "BeforLoginPV2",
    CnID = "常量@登录前视频2",
    Data = {70937, 72106}
  },
  LoginPV1 = {
    Key = "LoginPV1",
    CnID = "常量@登录界面循环视频1.0",
    Data = {
      0,
      "login_temp_video_Original.mp4",
      "Play_Mus_Login",
      "LoginPV1_Name",
      "UIResources/UIBigImages/UI_Collection_Image/UI_Collection_Login_01.png"
    }
  },
  LoginPV2 = {
    Key = "LoginPV2",
    CnID = "常量@登录界面循环视频半周年",
    Data = {
      50345,
      "login_temp_video.mp4",
      "Play_Mus_Login_HalfYear",
      "LoginPV2_Name",
      "UIResources/UIBigImages/UI_Collection_Image/UI_Collection_Login_02.png"
    }
  },
  LoginPV3 = {
    Key = "LoginPV3",
    CnID = "常量@登录界面循环视频一周年",
    Data = {
      67914,
      "LoginPV/LoginPV_1_7.mp4",
      "Play_Mus_Login_OneYear",
      "LoginPV3_Name",
      "UIResources/UIBigImages/UI_Collection_Image/UI_Collection_PV_1_8.png"
    }
  },
  LoginPV4 = {
    Key = "LoginPV4",
    CnID = "常量@登录界面循环视频2_0",
    Data = {
      70937,
      "login_temp_video_2.0.mp4",
      "Play_Mus_Login_V20",
      "LoginPV4_Name",
      "UIResources/UIBigImages/UI_Collection_Image/UI_Collection_PV_2_0.png"
    }
  },
  Logo1 = {
    Key = "Logo1",
    CnID = "常量@登录界面Logo1_0",
    Data = {
      0,
      "Logo/Video_Logo_Rgb.mp4",
      "Logo/Video_Logo_Alpha.mp4"
    }
  },
  Logo2 = {
    Key = "Logo2",
    CnID = "常量@登录界面Logo2_0",
    Data = {
      70937,
      "Logo/Video_Logo_Rgb2.mp4",
      "Logo/Video_Logo_Alpha2.mp4"
    }
  },
  GameVersionStartTimeList = {
    Key = "GameVersionStartTimeList",
    CnID = "常量@版本开始时间列表",
    Data = {
      1701291600,
      1703106000,
      1704920400,
      1706734800,
      1708549200,
      1710378000,
      1712192400,
      1714179600,
      1715994000,
      1718586000,
      1721005200,
      1723424400,
      1725843600,
      1728262800,
      1739149200,
      1743987600,
      1746406800,
      1748826000,
      1753059600,
      1755478800,
      1757293200,
      1760922000,
      1763946000,
      1766970000,
      1769389200,
      1773018000,
      1776646800,
      1780102800,
      1782694800,
      1785114000,
      1787533200,
      1789952400,
      1792371600,
      1794790800,
      1796000400,
      1798419600,
      1800838800,
      1803258000,
      1804467600,
      1806886800,
      1809306000,
      1811725200,
      1814144400,
      1816563600,
      1818982800,
      1821402000,
      1823821200,
      1826240400
    }
  },
  SchoolTowerOfflineTime = {
    Key = "SchoolTowerOfflineTime",
    CnID = "常量@界域塔高层下线时间",
    Data = {1706734800}
  },
  AvatarReplacementTimeRange = {
    Key = "AvatarReplacementTimeRange",
    CnID = "常量@玩家头像替换时间区间",
    Data = {1774972800, 1775059200}
  },
  AvatarReplacementItemId = {
    Key = "AvatarReplacementItemId",
    CnID = "常量@玩家头像替换成哪个头像",
    Data = {132672}
  },
  LoginAvgDialogTimeRange = {
    Key = "LoginAvgDialogTimeRange",
    CnID = "常量@登录弹出剧情时间区间",
    Data = {1774972800, 1775059200}
  },
  LoginAvgDialogId = {
    Key = "LoginAvgDialogId",
    CnID = "常量@登录弹出剧情",
    Data = {132684}
  },
  Default_Unlock_Role = {
    Key = "Default_Unlock_Role",
    CnID = "常量@65",
    Data = {
      15595,
      15585,
      15569,
      15570
    }
  },
  Initial_Item_ID = {
    Key = "Initial_Item_ID",
    CnID = "常量@账号初始道具",
    Data = {
      9578,
      300,
      10072,
      5,
      9719,
      5,
      10052,
      1
    }
  },
  RedPointIsNewExpireSeconds = {
    Key = "RedPointIsNewExpireSeconds",
    CnID = "常量@新提示移除时间",
    Data = {1209600}
  },
  EnergyRestoreTime = {
    Key = "EnergyRestoreTime",
    CnID = "常量@体力回复间隔",
    Data = {300}
  },
  EnergyExceedRestoreTime = {
    Key = "EnergyExceedRestoreTime",
    CnID = "常量@体力超出回复上限回复间隔",
    Data = {900}
  },
  EnergyRestoreNum = {
    Key = "EnergyRestoreNum",
    CnID = "常量@95",
    Data = {1}
  },
  EnergyBuyPrice = {
    Key = "EnergyBuyPrice",
    CnID = "常量@体力购买价格",
    Data = {
      9567,
      50,
      100,
      100,
      150,
      150,
      200,
      200,
      250
    }
  },
  Energy_Max = {
    Key = "Energy_Max",
    CnID = "常量@体力上限",
    Data = {3000}
  },
  Role_Press_Time = {
    Key = "Role_Press_Time",
    CnID = "常量@107",
    Data = {0.15}
  },
  ItemAddPressTime = {
    Key = "ItemAddPressTime",
    CnID = "常量@长按多久道具数量增加",
    Data = {0.15}
  },
  ItemAddSpeed = {
    Key = "ItemAddSpeed",
    CnID = "常量@增加道具速度参数",
    Data = {1.2}
  },
  Language = {
    Key = "Language",
    CnID = "常量@115",
    Data = {"CN"}
  },
  Server_Refresh_Time = {
    Key = "Server_Refresh_Time",
    CnID = "常量@134",
    Data = {9}
  },
  Reconnect_Time = {
    Key = "Reconnect_Time",
    CnID = "常量@148",
    Data = {20}
  },
  Reconnect_Repeat_Times = {
    Key = "Reconnect_Repeat_Times",
    CnID = "常量@149",
    Data = {3}
  },
  Reconnect_DataSave_Time = {
    Key = "Reconnect_DataSave_Time",
    CnID = "常量@152",
    Data = {5}
  },
  COMMON_SOUND_BANK = {
    Key = "COMMON_SOUND_BANK",
    CnID = "常量@175",
    Data = {
      2001,
      1001,
      3
    }
  },
  Temp_FontSize = {
    Key = "Temp_FontSize",
    CnID = "常量@221",
    Data = {2}
  },
  ShowReward_Num = {
    Key = "ShowReward_Num",
    CnID = "常量@222",
    Data = {6}
  },
  ShowReward_Anim_Time = {
    Key = "ShowReward_Anim_Time",
    CnID = "常量@223",
    Data = {
      0.33,
      0.46,
      0.56,
      0.66,
      0.76,
      0.86
    }
  },
  init_Energy = {
    Key = "init_Energy",
    CnID = "常量@269",
    Data = {100}
  },
  CanRespawnNum = {
    Key = "CanRespawnNum",
    CnID = "常量@272",
    Data = {1}
  },
  CopyScoreNoticeLimit = {
    Key = "CopyScoreNoticeLimit",
    CnID = "常量@273",
    Data = {1}
  },
  BoutUltiSkillTimes = {
    Key = "BoutUltiSkillTimes",
    CnID = "常量@274",
    Data = {1}
  },
  ClickEffectPath = {
    Key = "ClickEffectPath",
    CnID = "常量@275",
    Data = {
      "UIResources/UIEffects/Effect_dianji.prefab"
    }
  },
  AvgDialog_NumLimit = {
    Key = "AvgDialog_NumLimit",
    CnID = "常量@277",
    Data = {30}
  },
  AvgDialog_BubbleAutoDelay = {
    Key = "AvgDialog_BubbleAutoDelay",
    CnID = "常量@278",
    Data = {2}
  },
  AvgDialog_OneWordTime = {
    Key = "AvgDialog_OneWordTime",
    CnID = "常量@279",
    Data = {0.05}
  },
  AvgDialog_AutoWaitToRead = {
    Key = "AvgDialog_AutoWaitToRead",
    CnID = "常量@280",
    Data = {1.5}
  },
  AvgDialog_AutoWaitToRead_2Speed = {
    Key = "AvgDialog_AutoWaitToRead_2Speed",
    CnID = "常量@2倍Auto等待",
    Data = {0.7}
  },
  AvgDialog_ClickWaitToRead = {
    Key = "AvgDialog_ClickWaitToRead",
    CnID = "常量@281",
    Data = {0.3}
  },
  AvgDialog_StuckTime = {
    Key = "AvgDialog_StuckTime",
    CnID = "常量@AvgStuckTime",
    Data = {10}
  },
  AvgDialog_StuckClickCount = {
    Key = "AvgDialog_StuckClickCount",
    CnID = "常量@AvgStuckClickCount",
    Data = {5}
  },
  AutoTestAvgList = {
    Key = "AutoTestAvgList",
    CnID = "常量@AutoTestAvgList",
    Data = {13055, 15613}
  },
  Task_Appoint_Special_Times = {
    Key = "Task_Appoint_Special_Times",
    CnID = "常量@前N次委派任务特殊定制",
    Data = {1}
  },
  Task_Appoint_Special_Tasks = {
    Key = "Task_Appoint_Special_Tasks",
    CnID = "常量@前N次特殊定制委派任务列表",
    Data = {
      {10320, 10323}
    }
  },
  Task_Appoint_Common_Tasks = {
    Key = "Task_Appoint_Common_Tasks",
    CnID = "常量@常规派遣任务列表",
    Data = {
      10277,
      10302,
      10934,
      10473,
      10680,
      10565,
      10975,
      10538,
      10733,
      10736,
      10787,
      48735,
      48734,
      48733,
      48736
    }
  },
  TaskType_Appoint = {
    Key = "TaskType_Appoint",
    CnID = "常量@任务类型-委派",
    Data = {1}
  },
  TaskType_Appoint_Battle = {
    Key = "TaskType_Appoint_Battle",
    CnID = "常量@任务类型-委派-战斗",
    Data = {1, 1}
  },
  TaskType_Appoint_Dispatch = {
    Key = "TaskType_Appoint_Dispatch",
    CnID = "常量@任务类型-委派-派遣",
    Data = {1, 2}
  },
  TaskType_Daily = {
    Key = "TaskType_Daily",
    CnID = "常量@任务类型-日常",
    Data = {2}
  },
  TaskType_Career = {
    Key = "TaskType_Career",
    CnID = "常量@任务类型-生涯",
    Data = {3}
  },
  TaskType_Career_Main = {
    Key = "TaskType_Career_Main",
    CnID = "常量@任务类型-生涯-父",
    Data = {3, 1}
  },
  TaskType_Career_Sub = {
    Key = "TaskType_Career_Sub",
    CnID = "常量@任务类型-生涯-子",
    Data = {3, 2}
  },
  TaskType_Achivement = {
    Key = "TaskType_Achivement",
    CnID = "常量@任务类型-成就",
    Data = {4}
  },
  TaskType_Weekly = {
    Key = "TaskType_Weekly",
    CnID = "常量@任务类型-每周",
    Data = {5}
  },
  TaskType_Period = {
    Key = "TaskType_Period",
    CnID = "常量@任务类型-每期",
    Data = {6}
  },
  TaskType_School_Main = {
    Key = "TaskType_School_Main",
    CnID = "常量@任务类型-界域精通-父",
    Data = {7, 1}
  },
  TaskType_School_Sub = {
    Key = "TaskType_School_Sub",
    CnID = "常量@任务类型-界域精通-子",
    Data = {7, 2}
  },
  TaskType_PlayerLevel = {
    Key = "TaskType_PlayerLevel",
    CnID = "常量@玩家等级任务",
    Data = {8}
  },
  TaskType_AwakerBreakThrough = {
    Key = "TaskType_AwakerBreakThrough",
    CnID = "常量@玩家状态任务",
    Data = {9}
  },
  TaskType_DailyTask = {
    Key = "TaskType_DailyTask",
    CnID = "常量@每日任务",
    Data = {10}
  },
  TaskType_PVPWeekly = {
    Key = "TaskType_PVPWeekly",
    CnID = "常量@每周相位对弈5胜任务",
    Data = {11}
  },
  TaskType_PVPHistory = {
    Key = "TaskType_PVPHistory",
    CnID = "常量@任务类型_PVP历史积分任务",
    Data = {12}
  },
  TaskType_PVPSeason = {
    Key = "TaskType_PVPSeason",
    CnID = "常量@任务类型_PVP赛季任务",
    Data = {13}
  },
  TaskType_PVPRewardTask = {
    Key = "TaskType_PVPRewardTask",
    CnID = "常量@任务类型-对弈纪录",
    Data = {14}
  },
  TaskType_PVPRewardTask_Main = {
    Key = "TaskType_PVPRewardTask_Main",
    CnID = "常量@任务类型-对弈纪录-父",
    Data = {14, 1}
  },
  TaskType_TargetHint = {
    Key = "TaskType_TargetHint",
    CnID = "常量@任务类型关卡目标提示",
    Data = {15}
  },
  TaskType_Common = {
    Key = "TaskType_Common",
    CnID = "常量@通用需手动领取奖励任务",
    Data = {16}
  },
  TaskType_Common_Main = {
    Key = "TaskType_Common_Main",
    CnID = "常量@通用需手动领取奖励任务-父",
    Data = {16, 1}
  },
  TaskType_DailyChallengeTask = {
    Key = "TaskType_DailyChallengeTask",
    CnID = "常量@任务类型-深潜纪录",
    Data = {17}
  },
  TaskType_DailyChallengeTask_Main = {
    Key = "TaskType_DailyChallengeTask_Main",
    CnID = "常量@任务类型-深潜纪录-父",
    Data = {17, 1}
  },
  TaskType_Activity = {
    Key = "TaskType_Activity",
    CnID = "常量@任务类型-活动",
    Data = {18}
  },
  TaskType_Activity_Main = {
    Key = "TaskType_Activity_Main",
    CnID = "常量@任务类型-活动-父",
    Data = {18, 1}
  },
  TaskType_WorldActivity = {
    Key = "TaskType_WorldActivity",
    CnID = "常量@任务类型-全服活动",
    Data = {19}
  },
  TaskType_RailWay = {
    Key = "TaskType_RailWay",
    CnID = "常量@任务类型-疾驰的欢愉专列",
    Data = {23}
  },
  TaskType_RailWay_Main = {
    Key = "TaskType_RailWay_Main",
    CnID = "常量@任务类型-疾驰的欢愉专列-父",
    Data = {23, 1}
  },
  TaskType_SeasonRoDailyChallenge = {
    Key = "TaskType_SeasonRoDailyChallenge",
    CnID = "常量@任务类型-幻梦深潜赛季轮换任务",
    Data = {24}
  },
  TaskType_SeasonRoPvpPrebuilt = {
    Key = "TaskType_SeasonRoPvpPrebuilt",
    CnID = "常量@任务类型-预组模式赛季轮换任务",
    Data = {25}
  },
  TaskType_SeasonRoRailWay = {
    Key = "TaskType_SeasonRoRailWay",
    CnID = "常量@任务类型-疾驰的欢愉专列赛季轮换任务",
    Data = {26}
  },
  TaskType_SeasonRoPvpDraft = {
    Key = "TaskType_SeasonRoPvpDraft",
    CnID = "常量@任务类型-轮选模式赛季轮换任务",
    Data = {27}
  },
  TaskType_Invitee = {
    Key = "TaskType_Invitee",
    CnID = "常量@任务类型-邀请玩家任务",
    Data = {30}
  },
  TaskType_CollectionHall = {
    Key = "TaskType_CollectionHall",
    CnID = "常量@任务类型-典藏馆收集",
    Data = {41}
  },
  Task_Daily_Picture = {
    Key = "Task_Daily_Picture",
    CnID = "常量@日常任务配图",
    Data = {
      "UIResources/UIBigImages/UI_Large/UI_Large_Task/UI_Task_Image_Daily_PhotoBg2.png"
    }
  },
  Task_Appoint_RefreshNum_Daily = {
    Key = "Task_Appoint_RefreshNum_Daily",
    CnID = "常量@每日刷新委派任务数初始",
    Data = {10}
  },
  Task_Appoint_CompleteNumLimit_Daily = {
    Key = "Task_Appoint_CompleteNumLimit_Daily",
    CnID = "常量@每日可委派任务数上限",
    Data = {100}
  },
  Task_AppointLevel_Init = {
    Key = "Task_AppointLevel_Init",
    CnID = "常量@初始委派等级",
    Data = {1}
  },
  Task_Appoint_CombatGradeNum = {
    Key = "Task_Appoint_CombatGradeNum",
    CnID = "常量@委派任务战力档次数",
    Data = {5}
  },
  Task_Appoint_Unclaimed_MaxNum = {
    Key = "Task_Appoint_Unclaimed_MaxNum",
    CnID = "常量@未领取委派任务数限制",
    Data = {10}
  },
  HomeLand_FunList = {
    Key = "HomeLand_FunList",
    CnID = "常量@家园菜单列表",
    Data = {
      17012,
      17022,
      17042
    }
  },
  AwakerTalent_TabList = {
    Key = "AwakerTalent_TabList",
    CnID = "常量@天赋界面标签列表",
    Data = {
      0,
      1,
      4,
      2,
      3
    }
  },
  AwakerTalent_TabNormalIconList = {
    Key = "AwakerTalent_TabNormalIconList",
    CnID = "常量@天赋界面标签iconNormal列表",
    Data = {
      "Icon/Common/Icon_Common_All_Nor.png",
      "Icon/Common/Icon_Common_Chaos_Nor.png",
      "Icon/Common/Icon_Common_Deep_Nor.png",
      "Icon/Common/Icon_Common_Flesh_Nor.png",
      "Icon/Common/Icon_Common_Surpass_Nor.png"
    }
  },
  AwakerTalent_TabSelectIconList = {
    Key = "AwakerTalent_TabSelectIconList",
    CnID = "常量@天赋界面标签iconSelectl列表",
    Data = {
      "Icon/Common/Icon_Common_All_Sel.png",
      "Icon/Common/Icon_Common_Chaos_Sel.png",
      "Icon/Common/Icon_Common_Deep_Sel.png",
      "Icon/Common/Icon_Common_Flesh_Sel.png",
      "Icon/Common/Icon_Common_Surpass_Sel.png"
    }
  },
  NeutralSchoolId = {
    Key = "NeutralSchoolId",
    CnID = "常量@混沌职业",
    Data = {1}
  },
  Tech_Research_SpeedUpItem = {
    Key = "Tech_Research_SpeedUpItem",
    CnID = "常量@科研加速道具",
    Data = {9567}
  },
  Tech_Research_SpeedUpNum = {
    Key = "Tech_Research_SpeedUpNum",
    CnID = "常量@科研加速消耗数量",
    Data = {
      {15, 20},
      {30, 35},
      {60, 60},
      {90, 85},
      {120, 105},
      {240, 185},
      {360, 255},
      {480, 320},
      {600, 385},
      {720, 445},
      {840, 500},
      {960, 555},
      {1080, 610},
      {1200, 665},
      {1320, 720},
      {1440, 800}
    }
  },
  Homeland_Mine_Rate_ShowRank = {
    Key = "Homeland_Mine_Rate_ShowRank",
    CnID = "常量@家园资源积累进度展示分档",
    Data = {
      0.25,
      0.5,
      0.75,
      1
    }
  },
  Homeland_Mine_Rate_Pickup = {
    Key = "Homeland_Mine_Rate_Pickup",
    CnID = "常量@家园资源生产周期",
    Data = {360}
  },
  Homeland_GoldMine_Output_Period = {
    Key = "Homeland_GoldMine_Output_Period",
    CnID = "常量@金矿各等级每周期产出",
    Data = {
      10108,
      800,
      1200,
      1600,
      2000,
      2400
    }
  },
  Homeland_ExpMine_Output_Period = {
    Key = "Homeland_ExpMine_Output_Period",
    CnID = "常量@经验矿各等级每周期产出",
    Data = {
      9916,
      800,
      1200,
      1600,
      2000,
      2400
    }
  },
  Homeland_EnergyMine_Output_Period = {
    Key = "Homeland_EnergyMine_Output_Period",
    CnID = "常量@饰品经验矿各等级每周期产出",
    Data = {
      10086,
      2,
      3,
      4,
      5,
      6
    }
  },
  Homeland_Mine_Storage = {
    Key = "Homeland_Mine_Storage",
    CnID = "常量@存储周期上限",
    Data = {4}
  },
  Homeland_GoldMine_Icon = {
    Key = "Homeland_GoldMine_Icon",
    CnID = "常量@家园金矿图标",
    Data = {
      "UI/UI_Homeland/UI_Homeland_Image/UI_Homeland_D_Image_Icon_3.png"
    }
  },
  Homeland_ExpMine_Icon = {
    Key = "Homeland_ExpMine_Icon",
    CnID = "常量@家园经验矿图标",
    Data = {
      "UI/UI_Homeland/UI_Homeland_Image/UI_Homeland_D_Image_Icon_2.png"
    }
  },
  Homeland_EnergyMine_Icon = {
    Key = "Homeland_EnergyMine_Icon",
    CnID = "常量@家园饰品经验矿图标",
    Data = {
      "UI/UI_Homeland/UI_Homeland_Image/UI_Homeland_D_Image_Icon_1.png"
    }
  },
  ItemType_Weapon_SmallIcon = {
    Key = "ItemType_Weapon_SmallIcon",
    CnID = "常量@武器类型小图标",
    Data = {
      "UIResources/AtlasSource/2_Icon/Article/IconL_Item_3006.png"
    }
  },
  Quality_SSR_Icon = {
    Key = "Quality_SSR_Icon",
    CnID = "常量@唤醒体武器SSR图标",
    Data = {
      "UIResources/AtlasSource/UI_Summon_Image/UI_Summon_D_Image_SSR.png"
    }
  },
  Quality_SR_Icon = {
    Key = "Quality_SR_Icon",
    CnID = "常量@唤醒体武器SR图标",
    Data = {
      "UIResources/AtlasSource/UI_Summon_Image/UI_Summon_D_Image_SR.png"
    }
  },
  Quality_R_Icon = {
    Key = "Quality_R_Icon",
    CnID = "常量@唤醒体武器R图标",
    Data = {
      "UIResources/AtlasSource/UI_Summon_Image/UI_Summon_D_Image_R.png"
    }
  },
  GetAwakerOwnedTransformNum = {
    Key = "GetAwakerOwnedTransformNum",
    CnID = "常量@获得已有唤醒体转化碎片数量",
    Data = {
      1,
      1,
      1
    }
  },
  AwakerChipMaxOwnedNum = {
    Key = "AwakerChipMaxOwnedNum",
    CnID = "常量@可获得角色碎片数上限",
    Data = {15}
  },
  AwakerChipOverflowTransform = {
    Key = "AwakerChipOverflowTransform",
    CnID = "常量@溢出角色碎片转换为道具数量",
    Data = {
      9615,
      100,
      10,
      1
    }
  },
  AwakerChipSSROverflowExtraItem = {
    Key = "AwakerChipSSROverflowExtraItem",
    CnID = "常量@溢出SSR角色碎片额外获得道具",
    Data = {133766, 1}
  },
  AwakerSelectItemsWithoutCoin = {
    Key = "AwakerSelectItemsWithoutCoin",
    CnID = "常量@不获得根源沉淀的自选道具列表",
    Data = {
      21775,
      34706,
      9597,
      95513,
      95515,
      95512,
      95519,
      95511,
      119151,
      119152,
      119157,
      119159,
      119158
    }
  },
  BeginnerSummonMaxReselectTimes = {
    Key = "BeginnerSummonMaxReselectTimes",
    CnID = "常量@初始卡池重抽次数上限",
    Data = {9999}
  },
  BeginnerSummonReselectPrice = {
    Key = "BeginnerSummonReselectPrice",
    CnID = "常量@初始卡池重抽价格",
    Data = {9567, 50}
  },
  BeginnerSummonTenthItem = {
    Key = "BeginnerSummonTenthItem",
    CnID = "常量@初始卡池第十抽出货"
  },
  BeginnerSummonFreeNum = {
    Key = "BeginnerSummonFreeNum",
    CnID = "常量@初始卡池前几抽免费",
    Data = {10}
  },
  SummonExtraItemGetR = {
    Key = "SummonExtraItemGetR",
    CnID = "常量@抽卡获得R物品时额外获得道具",
    Data = {9615, 1}
  },
  SummonExtraItemGetSR = {
    Key = "SummonExtraItemGetSR",
    CnID = "常量@抽卡获得SR以上物品时额外获得道具",
    Data = {
      9615,
      50,
      5
    }
  },
  SummonExtraItemGet = {
    Key = "SummonExtraItemGet",
    CnID = "常量@抽卡获得不同稀有度卡牌时额外获得道具",
    Data = {
      10112,
      500,
      100,
      20
    }
  },
  SummonExtraWeaponGet = {
    Key = "SummonExtraWeaponGet",
    CnID = "常量@抽卡获得不同稀有度武器时额外获得道具",
    Data = {
      10112,
      500,
      100,
      20
    }
  },
  SSRGuaranteeNumMax = {
    Key = "SSRGuaranteeNumMax",
    CnID = "常量@各卡池类型SSR最大保底数",
    Data = {
      0,
      30,
      1,
      30,
      2,
      30,
      3,
      30,
      4,
      30,
      5,
      30,
      6,
      30,
      7,
      30,
      9,
      5,
      10,
      30,
      12,
      30,
      13,
      30,
      14,
      30,
      16,
      30,
      17,
      30
    }
  },
  SSRGuaranteeNumInit = {
    Key = "SSRGuaranteeNumInit",
    CnID = "常量@各卡池类型SSR保底数初始值",
    Data = {5, 20}
  },
  SSRLuckValueLimit = {
    Key = "SSRLuckValueLimit",
    CnID = "常量@SSR欧气限制",
    Data = {5, 5}
  },
  SSRNotUPNumMax = {
    Key = "SSRNotUPNumMax",
    CnID = "常量@最多连续几次抽到的SSR不是UP",
    Data = {3}
  },
  SSRNotUPMaxSummonType = {
    Key = "SSRNotUPMaxSummonType",
    CnID = "常量@按卡池类型最多连续几次抽到的SSR不是UP",
    Data = {
      1,
      1,
      2,
      2,
      0,
      2,
      7,
      1,
      10,
      2,
      12,
      2,
      13,
      2,
      14,
      1,
      16,
      1
    }
  },
  SSRNotUPNumInit = {
    Key = "SSRNotUPNumInit",
    CnID = "常量@连续几次抽到的SSR不是UP初始值",
    Data = {
      1,
      0,
      2,
      0,
      0,
      0,
      7,
      0,
      10,
      0,
      12,
      0,
      13,
      0,
      14,
      0,
      16,
      0
    }
  },
  SRNotUPNumMax = {
    Key = "SRNotUPNumMax",
    CnID = "常量@最多连续几次抽到的SR不是UP",
    Data = {1}
  },
  SRNotUPNumInit = {
    Key = "SRNotUPNumInit",
    CnID = "常量@连续几次抽到的SR不是UP初始值",
    Data = {
      1,
      0,
      2,
      0
    }
  },
  SelectSSRUPSummonType = {
    Key = "SelectSSRUPSummonType",
    CnID = "常量@支持指定SSR概率UP的卡池类型",
    Data = {0}
  },
  SelectSSRWeaponRatio = {
    Key = "SelectSSRWeaponRatio",
    CnID = "常量@常驻定向SSR命轮的权重占比",
    Data = {3333}
  },
  SelectSSRWeaponDropList = {
    Key = "SelectSSRWeaponDropList",
    CnID = "常量@常驻命轮定向可选掉落列表",
    Data = {66495}
  },
  LastIsNotUPSummonType = {
    Key = "LastIsNotUPSummonType",
    CnID = "常量@上次为UP初始值为否的卡池类型",
    Data = {5, 6}
  },
  SchoolSummonInitShow = {
    Key = "SchoolSummonInitShow",
    CnID = "常量@职业定向初始展示卡池",
    Data = {14117}
  },
  SummonCareerSelectList = {
    Key = "SummonCareerSelectList",
    CnID = "常量@职业定向卡池可选卡池",
    Data = {
      14117,
      14127,
      14142,
      14144
    }
  },
  SummonRecordTypeSelectList = {
    Key = "SummonRecordTypeSelectList",
    CnID = "常量@抽卡记录卡池类型选择",
    Data = {
      2,
      1,
      5,
      0,
      7,
      8,
      9,
      10,
      13,
      14,
      15,
      16,
      17
    }
  },
  LotteryShareAwakerRecordType = {
    Key = "LotteryShareAwakerRecordType",
    CnID = "常量@与卡池类型7共用同个唤醒记录展示",
    Data = {16}
  },
  SummonTypeCorrectedSSRAwardSelect = {
    Key = "SummonTypeCorrectedSSRAwardSelect",
    CnID = "常量@卡池类型相同物品类型不连续掉落限制",
    Data = readonly({
      [10] = 2,
      [13] = 2,
      [17] = 2
    })
  },
  CorrectedSSRAwardSelect = {
    Key = "CorrectedSSRAwardSelect",
    CnID = "常量@卡池保底不连续掉落限制",
    Data = {7, 2}
  },
  NonSelectablePoolPityNonConsecutiveLimit = {
    Key = "NonSelectablePoolPityNonConsecutiveLimit",
    CnID = "常量@无需自选的卡池保底不连续掉落限制",
    Data = {16, 2}
  },
  SummonDropRemoveDuplicateProbability = {
    Key = "SummonDropRemoveDuplicateProbability",
    CnID = "常量@卡池掉落去重后概率计算",
    Data = {149326}
  },
  LuckyBagNoDropPreview = {
    Key = "LuckyBagNoDropPreview",
    CnID = "常量@福袋卡池无需掉落预览",
    Data = {
      117218,
      117217,
      117215,
      117216,
      117219,
      129493,
      129490,
      129497,
      129491,
      149943,
      149339,
      149341
    }
  },
  SSRAwakerSelectOneDrop = {
    Key = "SSRAwakerSelectOneDrop",
    CnID = "常量@N选1卡池唤醒体可选掉落列表",
    Data = {81493}
  },
  SSRAwakerDIYSelectOneDrop = {
    Key = "SSRAwakerDIYSelectOneDrop",
    CnID = "常量@N选1卡池唤醒体自定义掉落列表",
    Data = {
      128044,
      129492,
      128041,
      129495,
      128042,
      129494,
      128043,
      129496
    }
  },
  SSRAwakerSpecialShow = {
    Key = "SSRAwakerSpecialShow",
    CnID = "常量@N选1卡池用两个卡片展示",
    Data = {
      129492,
      129495,
      129494,
      129496
    }
  },
  ReSetSummonTypeChooseAwakerData = {
    Key = "ReSetSummonTypeChooseAwakerData",
    CnID = "常量@重置卡池选择唤醒体数据",
    Data = {7}
  },
  SummonType_14SSRSelectDropList = {
    Key = "SummonType_14SSRSelectDropList",
    CnID = "常量@类型14的卡池可选的掉落列表",
    Data = {131639, 131641}
  },
  SummonType_14SSRSelectNum = {
    Key = "SummonType_14SSRSelectNum",
    CnID = "常量@类型14的卡池可选目标数量",
    Data = {131639, 4}
  },
  SummonType_17SelectNum = {
    Key = "SummonType_17SelectNum",
    CnID = "常量@类型17的卡池可选目标数量",
    Data = {149326, 5}
  },
  SummonType_17SelectTypeIcon_1 = {
    Key = "SummonType_17SelectTypeIcon_1",
    CnID = "常量@类型17的卡池可选类型图标1",
    Data = {
      "UIResources/AtlasSource/UI_Summon_Image/UI_Summon_Image_MixPool_05.png"
    }
  },
  SummonType_17SelectTypeIcon_2 = {
    Key = "SummonType_17SelectTypeIcon_2",
    CnID = "常量@类型17的卡池可选类型图标2",
    Data = {
      "UIResources/AtlasSource/UI_Summon_Image/UI_Summon_Image_MixPool_06.png"
    }
  },
  SummonType_17SelectTypeIcon_3 = {
    Key = "SummonType_17SelectTypeIcon_3",
    CnID = "常量@类型17的卡池可选类型图标3",
    Data = {
      "UIResources/AtlasSource/UI_Summon_Image/UI_Summon_Image_MixPool_07.png"
    }
  },
  SummonType_17SelectTypeIcon_4 = {
    Key = "SummonType_17SelectTypeIcon_4",
    CnID = "常量@类型17的卡池可选类型图标4",
    Data = {
      "UIResources/AtlasSource/UI_Summon_Image/UI_Summon_Image_MixPool_08.png"
    }
  },
  SummonType_17SelectTypeIcon_5 = {
    Key = "SummonType_17SelectTypeIcon_5",
    CnID = "常量@类型17的卡池可选类型图标5",
    Data = {
      "UIResources/AtlasSource/UI_Summon_Image/UI_Summon_Image_MixPool_09.png"
    }
  },
  SummonType_17SelectDropList = {
    Key = "SummonType_17SelectDropList",
    CnID = "常量@类型17的卡池可选掉落列表",
    Data = {
      149326,
      {
        149321,
        149318,
        149316,
        149317,
        149324
      }
    }
  },
  PoolGroupExclusive = {
    Key = "PoolGroupExclusive",
    CnID = "常量@卡池组选择某一卡池"
  },
  ReddotAccountLvLimit = {
    Key = "ReddotAccountLvLimit",
    CnID = "常量@抽卡红点守密人等级",
    Data = {2}
  },
  ReddotSummonType = {
    Key = "ReddotSummonType",
    CnID = "常量@十连需要红点的卡池类型",
    Data = {5}
  },
  OnceBtnHideSummonType = {
    Key = "OnceBtnHideSummonType",
    CnID = "常量@不显示单抽按钮的卡池类型",
    Data = {6, 8}
  },
  SummonCallbackMax = {
    Key = "SummonCallbackMax",
    CnID = "常量@唤醒无回调容错时间",
    Data = {30}
  },
  SummonExtraRewardTimes = {
    Key = "SummonExtraRewardTimes",
    CnID = "常量@常驻池获得额外奖励抽数",
    Data = {150}
  },
  SummonExtraRewardList = {
    Key = "SummonExtraRewardList",
    CnID = "常量@常驻池额外奖励可选道具",
    Data = {
      9583,
      9977,
      9745,
      9603,
      9624,
      9746,
      9932,
      10040,
      9809,
      10027
    }
  },
  SummonCD = {
    Key = "SummonCD",
    CnID = "常量@抽卡冷却时间秒",
    Data = {1}
  },
  ItemNumLimit = {
    Key = "ItemNumLimit",
    CnID = "常量@道具数量上限",
    Data = {999999999}
  },
  ExploreInitialFOV = {
    Key = "ExploreInitialFOV",
    CnID = "常量@探索初始视野",
    Data = {1}
  },
  ExploreInitialStress = {
    Key = "ExploreInitialStress",
    CnID = "常量@探索初始压力值",
    Data = {0}
  },
  ExploreMoveAddStress = {
    Key = "ExploreMoveAddStress",
    CnID = "常量@探索移动增加压力值",
    Data = {10}
  },
  ExploreStressThreshold = {
    Key = "ExploreStressThreshold",
    CnID = "常量@探索压力值阈值",
    Data = {
      100,
      200,
      300,
      400,
      500
    }
  },
  ExploreFinalCurse = {
    Key = "ExploreFinalCurse",
    CnID = "常量@探索5阶诅咒",
    Data = {4142, 1}
  },
  ExploreCurse = {
    Key = "ExploreCurse",
    CnID = "常量@探索前4阶诅咒",
    Data = {
      4119,
      1,
      4645,
      1,
      3960,
      1,
      4496,
      1,
      4560,
      1,
      4569,
      1,
      4142,
      1,
      4625,
      1
    }
  },
  ExploreCurseNumBase = {
    Key = "ExploreCurseNumBase",
    CnID = "常量@探索各压力阶段获取症状卡数量基准",
    Data = {
      1,
      1,
      2,
      2,
      1
    }
  },
  ExploreStressDesc = {
    Key = "ExploreStressDesc",
    CnID = "常量@探索压力值描述",
    Data = {
      "每移动一格，压力提升10点。压力每满100点获得1个诅咒效果\n当压力达到500后，每移动一格，扣除10%生命上限"
    }
  },
  ExploreStressMaxMoveReduceMaxHP = {
    Key = "ExploreStressMaxMoveReduceMaxHP",
    CnID = "常量@探索压力满值移动扣血上限",
    Data = {10}
  },
  ChangeGenderConsume = {
    Key = "ChangeGenderConsume",
    CnID = "常量@更换性别消耗",
    Data = {9567, 1000}
  },
  AvgEmojPath = {
    Key = "AvgEmojPath",
    CnID = "常量@Avg表情路径",
    Data = {
      "UIResources/AtlasSource/UI_Story_Image/"
    }
  },
  AvgSlowCaptionAnim = {
    Key = "AvgSlowCaptionAnim",
    CnID = "常量@Avg慢速字幕",
    Data = {
      "UI_jianbian_yty_vx_01_open",
      "UI_jianbian_yty_vx_01_close"
    }
  },
  AvgMiddleCaptionAnim = {
    Key = "AvgMiddleCaptionAnim",
    CnID = "常量@Avg中速字幕",
    Data = {
      "UI_jianbian_yty_vx_02_open",
      "UI_jianbian_yty_vx_02_close"
    }
  },
  AvgFastCaptionAnim = {
    Key = "AvgFastCaptionAnim",
    CnID = "常量@Avg快速字幕",
    Data = {
      "UI_jianbian_yty_vx_03_open",
      "UI_jianbian_yty_vx_03_close"
    }
  },
  PhiloStone = {
    Key = "PhiloStone",
    CnID = "常量@贤石",
    Data = {
      "PhiloStone",
      "Icon/Dbgcopy/Icon_Dbgcopy_011.png",
      "PhiloStone_Desc"
    }
  },
  DeleteCardEarn = {
    Key = "DeleteCardEarn",
    CnID = "常量@商店删除卡牌获得贤石",
    Data = {25}
  },
  AwakAwakerCost = {
    Key = "AwakAwakerCost",
    CnID = "常量@商店觉醒唤醒体消耗贤石",
    Data = {50}
  },
  RelicSellQuality = {
    Key = "RelicSellQuality",
    CnID = "常量@商店格售卖造物品质",
    Data = {"White", "Orange"}
  },
  EnchantSellQuality = {
    Key = "EnchantSellQuality",
    CnID = "常量@商店格售卖刻印品质",
    Data = {"White"}
  },
  RelicKey = {
    Key = "RelicKey",
    CnID = "常量@固定钥匙",
    Data = {13829}
  },
  AwakerMaxLv = {
    Key = "AwakerMaxLv",
    CnID = "常量@唤醒体最大等级",
    Data = {60}
  },
  AwakerUpgradeLevel_UR = {
    Key = "AwakerUpgradeLevel_UR",
    CnID = "常量@唤醒体等级为UR的升级属性起点",
    Data = {0}
  },
  AwakerUpgradeLevel_Orange = {
    Key = "AwakerUpgradeLevel_Orange",
    CnID = "常量@唤醒体等级为SSR的升级属性起点",
    Data = {0}
  },
  AwakerUpgradeLevel_Purple = {
    Key = "AwakerUpgradeLevel_Purple",
    CnID = "常量@唤醒体等级为SR的升级属性起点",
    Data = {0}
  },
  AwakerUpgradeLevel_Blue = {
    Key = "AwakerUpgradeLevel_Blue",
    CnID = "常量@唤醒体等级为R的升级属性起点",
    Data = {0}
  },
  AwakerSkillUpperLevel = {
    Key = "AwakerSkillUpperLevel",
    CnID = "常量@唤醒体技能等级上限",
    Data = {6}
  },
  AwakerSlotUpgrade_NeedAwakerLv = {
    Key = "AwakerSlotUpgrade_NeedAwakerLv",
    CnID = "常量@唤醒体技能升级等级要求",
    Data = {
      1,
      1,
      1,
      1,
      1
    }
  },
  AwakerExSkillUpgrade_ConsumeTimes = {
    Key = "AwakerExSkillUpgrade_ConsumeTimes",
    CnID = "常量@唤醒体本源降临技能消耗材料倍数",
    Data = {1}
  },
  RespawnImmueState = {
    Key = "RespawnImmueState",
    CnID = "常量@复活免疫状态",
    Data = {3529}
  },
  AwakerSkillIconName = {
    Key = "AwakerSkillIconName",
    CnID = "常量@唤醒体技能图标名狂气爆发_打击_防御_灵知觉醒_技能1_技能2",
    Data = {
      "UC_Skill_Common_10001.png",
      "UC_Skill_Common_10002.png",
      "UC_Skill_Common_10003.png",
      "UC_Skill_Common_10004.png",
      "UC_Skill_Common_10005.png",
      "UC_Skill_Common_10006.png"
    }
  },
  DailyChallengeRandomRelic = {
    Key = "DailyChallengeRandomRelic",
    CnID = "常量@日常挑战随机造物库",
    Data = {13835}
  },
  DailyChallengeFixedBloodRelic = {
    Key = "DailyChallengeFixedBloodRelic",
    CnID = "常量@日常挑战固定血肉造物库",
    Data = {13835}
  },
  DailyChallengeFixedDimensionRelic = {
    Key = "DailyChallengeFixedDimensionRelic",
    CnID = "常量@日常挑战固定超维造物库",
    Data = {13835}
  },
  DailyChallengeFixedOceanRelic = {
    Key = "DailyChallengeFixedOceanRelic",
    CnID = "常量@日常挑战固定深海造物库",
    Data = {13835}
  },
  DailyChallengeRandomRelicOrder = {
    Key = "DailyChallengeRandomRelicOrder",
    CnID = "常量@日常挑战职业造物库轮替顺序",
    Data = {
      "DailyChallengeFixedOceanRelic",
      "DailyChallengeFixedDimensionRelic",
      "DailyChallengeFixedBloodRelic"
    }
  },
  DailyChallengeLevelReplace = {
    Key = "DailyChallengeLevelReplace",
    CnID = "常量@日常挑战关卡轮替池",
    Data = {
      8038,
      7766,
      7767,
      8035,
      8036
    }
  },
  DailyChallengeScoreCalculateConstant = {
    Key = "DailyChallengeScoreCalculateConstant",
    CnID = "常量@日常挑战星数战力计算常数",
    Data = {0.05}
  },
  DailyChallengeScore = {
    Key = "DailyChallengeScore",
    CnID = "常量@日常挑战评分任务"
  },
  DailyChallengeDifficultyParm = {
    Key = "DailyChallengeDifficultyParm",
    CnID = "常量@日常挑战难度评分系数",
    Data = {
      1,
      2,
      3,
      3.5,
      4,
      4.5,
      5,
      6,
      7,
      8,
      9,
      10
    }
  },
  DailyChallengeWeeklyScore = {
    Key = "DailyChallengeWeeklyScore",
    CnID = "常量@本周累计评分",
    Data = {
      300,
      1000,
      2000,
      3000,
      4000,
      5000
    }
  },
  DailyChallengeWeeklyReward = {
    Key = "DailyChallengeWeeklyReward",
    CnID = "常量@本周累计评分奖励",
    Data = {
      {
        9567,
        20,
        9542,
        400,
        10108,
        14000
      },
      {
        9567,
        30,
        9719,
        1,
        9542,
        400,
        10108,
        28000
      },
      {
        9567,
        30,
        9719,
        1,
        9966,
        30,
        9542,
        400,
        10108,
        42000
      },
      {
        9567,
        40,
        9719,
        1,
        9542,
        400,
        10108,
        55000
      },
      {
        9567,
        40,
        9719,
        1,
        9542,
        400,
        10108,
        69000
      },
      {
        9567,
        40,
        9719,
        1,
        9966,
        30,
        9542,
        400,
        10108,
        83000
      }
    }
  },
  DailyChallengeLevel = {
    Key = "DailyChallengeLevel",
    CnID = "常量@日常挑战关卡轮替",
    Data = {
      15953,
      15956,
      15952,
      15954,
      15943,
      15881,
      15880,
      15883,
      15868,
      15948,
      15949,
      15877,
      15879,
      15955,
      15876,
      15957,
      15950
    }
  },
  DailyChallengeDailyRelic = {
    Key = "DailyChallengeDailyRelic",
    CnID = "常量@日常挑战日替造物",
    Data = {
      13848,
      51687,
      51686,
      13771,
      13793,
      35135,
      35139,
      36823,
      36824,
      39303,
      39302,
      51689,
      47444,
      13923,
      50489,
      13768,
      50488,
      50487,
      13799,
      51688,
      13848,
      39303,
      13771,
      13793,
      13923,
      50487,
      51688,
      35135,
      35139,
      36823,
      39302,
      50488,
      51686,
      51689,
      47444,
      51687,
      13768,
      50489,
      13799,
      36824,
      13774
    }
  },
  WeeklyTotalWins = {
    Key = "WeeklyTotalWins",
    CnID = "常量@每周胜场数",
    Data = {
      1,
      3,
      5
    }
  },
  WeeklyTotalWinsReward = {
    Key = "WeeklyTotalWinsReward",
    CnID = "常量@每周胜场数奖励",
    Data = {
      {
        9567,
        100,
        9719,
        2,
        44809,
        1,
        9542,
        2000
      },
      {
        9567,
        150,
        9719,
        3,
        44809,
        1,
        9542,
        3000
      },
      {
        9567,
        250,
        9719,
        5,
        9542,
        5000
      }
    }
  },
  DailyChallengeWeeklyMail = {
    Key = "DailyChallengeWeeklyMail",
    CnID = "常量@日常挑战累计奖励未领取邮件",
    Data = {18034}
  },
  DailyChallengeDayMail = {
    Key = "DailyChallengeDayMail",
    CnID = "常量@日常挑战每日排行奖励邮件",
    Data = {18029}
  },
  DailyChallengeDayMailNew = {
    Key = "DailyChallengeDayMailNew",
    CnID = "常量@日常挑战每日排行奖励邮件新",
    Data = {24280}
  },
  DailyChallengeSkipDayMail = {
    Key = "DailyChallengeSkipDayMail",
    CnID = "常量@日常挑战逃课每日排行奖励邮件",
    Data = {44690}
  },
  DailyChallengeAndPVPWinGoldMail = {
    Key = "DailyChallengeAndPVPWinGoldMail",
    CnID = "常量@深潜对弈每日金券奖励有对弈胜场",
    Data = {47307}
  },
  DailyChallengeAndPVPNoWinGoldMail = {
    Key = "DailyChallengeAndPVPNoWinGoldMail",
    CnID = "常量@深潜对弈每日金券奖励无对弈胜场",
    Data = {47306}
  },
  DailyChallengeAndPVPWinCoinMail = {
    Key = "DailyChallengeAndPVPWinCoinMail",
    CnID = "常量@深潜对弈每日融蚀之珠奖励有对弈胜场",
    Data = {47308}
  },
  DailyChallengeAndPVPNoWinCoinMail = {
    Key = "DailyChallengeAndPVPNoWinCoinMail",
    CnID = "常量@深潜对弈每日融蚀之珠奖励无对弈胜场",
    Data = {47305}
  },
  DailyChallengeAndPVPOnlySkipGoldMail = {
    Key = "DailyChallengeAndPVPOnlySkipGoldMail",
    CnID = "常量@深潜对弈每日金券奖励仅代理",
    Data = {48156}
  },
  DailyChallengeAndPVPOnlySkipCoinMail = {
    Key = "DailyChallengeAndPVPOnlySkipCoinMail",
    CnID = "常量@深潜对弈每日融蚀之珠奖励仅代理",
    Data = {48157}
  },
  DailyChallengeRecClass = {
    Key = "DailyChallengeRecClass",
    CnID = "常量@日常挑战界域推荐轮替"
  },
  DailyChallengeRecommendedSchoolBonus = {
    Key = "DailyChallengeRecommendedSchoolBonus",
    CnID = "常量@日常挑战界域推荐加成",
    Data = {10}
  },
  DailyChallengeRankTopNum = {
    Key = "DailyChallengeRankTopNum",
    CnID = "常量@日常挑战排行榜顶部人数",
    Data = {100}
  },
  DailyChallengeTopRank = {
    Key = "DailyChallengeTopRank",
    CnID = "常量@日常挑战排行榜显示排行的人数",
    Data = {18705}
  },
  DailyChallengeRelicGroupDrop = {
    Key = "DailyChallengeRelicGroupDrop",
    CnID = "日常@日常挑战日替造物组",
    Data = {
      {
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        99,
        100,
        101
      }
    }
  },
  BagCapacity = {
    Key = "BagCapacity",
    CnID = "常量@背包分页容量",
    Data = {
      300,
      1000,
      1000,
      1000
    }
  },
  Weapon_LevelLimit = {
    Key = "Weapon_LevelLimit",
    CnID = "常量@武器精炼上限",
    Data = {5}
  },
  Weapon_LevelUp_Cost = {
    Key = "Weapon_LevelUp_Cost",
    CnID = "常量@武器精炼所需金币",
    Data = {100}
  },
  Weapon_LeveUp_CommonMaterial = {
    Key = "Weapon_LeveUp_CommonMaterial",
    CnID = "常量@通用武器精炼材料",
    Data = {
      9888,
      10082,
      9791
    }
  },
  BagOnceReddotItemList = {
    Key = "BagOnceReddotItemList",
    CnID = "常量@背包特定道具一次性红点",
    Data = {
      21775,
      21898,
      34703,
      34706,
      34699,
      9597
    }
  },
  SpecialBagOnceReddotItemList = {
    Key = "SpecialBagOnceReddotItemList",
    CnID = "常量@背包特定道具特殊一次性红点",
    Data = {67377, 67378}
  },
  TrinketMainAttrTypeWeight_1 = {
    Key = "TrinketMainAttrTypeWeight_1",
    CnID = "常量@I密契获取主属性时_不同属性出现的权重",
    Data = {
      18159,
      1,
      18105,
      1,
      18139,
      1,
      22207,
      1
    }
  },
  TrinketMainAttrTypeWeight_2 = {
    Key = "TrinketMainAttrTypeWeight_2",
    CnID = "常量@II密契获取主属性时_不同属性出现的权重",
    Data = {
      18159,
      1,
      18105,
      1,
      18126,
      1,
      18155,
      1
    }
  },
  TrinketMainAttrTypeWeight_3 = {
    Key = "TrinketMainAttrTypeWeight_3",
    CnID = "常量@III密契获取主属性时_不同属性出现的权重",
    Data = {
      18159,
      1,
      18105,
      1,
      18151,
      1,
      18142,
      1
    }
  },
  TrinketMainAttrTypeWeight_4 = {
    Key = "TrinketMainAttrTypeWeight_4",
    CnID = "常量@IV密契获取主属性时_不同属性出现的权重",
    Data = {
      18126,
      1,
      22207,
      1,
      18155,
      1,
      18139,
      1
    }
  },
  TrinketMainAttrTypeWeight_5 = {
    Key = "TrinketMainAttrTypeWeight_5",
    CnID = "常量@V密契获取主属性时_不同属性出现的权重",
    Data = {
      22207,
      1,
      18151,
      1,
      18139,
      1,
      18142,
      1
    }
  },
  TrinketMainAttrTypeWeight_6 = {
    Key = "TrinketMainAttrTypeWeight_6",
    CnID = "常量@VI密契获取主属性时_不同属性出现的权重",
    Data = {
      18126,
      1,
      18155,
      1,
      18151,
      1,
      18142,
      1
    }
  },
  TrinketSubAttrTypeWeight_1 = {
    Key = "TrinketSubAttrTypeWeight_1",
    CnID = "常量@I密契获取副属性时_不同属性出现的权重",
    Data = {
      18159,
      1,
      18105,
      1,
      22207,
      1,
      18151,
      1,
      18126,
      1,
      18139,
      1,
      18155,
      1,
      18142,
      1
    }
  },
  TrinketSubAttrTypeWeight_2 = {
    Key = "TrinketSubAttrTypeWeight_2",
    CnID = "常量@II密契获取副属性时_不同属性出现的权重",
    Data = {
      18159,
      1,
      18105,
      1,
      22207,
      1,
      18151,
      1,
      18126,
      1,
      18139,
      1,
      18155,
      1,
      18142,
      1
    }
  },
  TrinketSubAttrTypeWeight_3 = {
    Key = "TrinketSubAttrTypeWeight_3",
    CnID = "常量@III密契获取副属性时_不同属性出现的权重",
    Data = {
      18159,
      1,
      18105,
      1,
      22207,
      1,
      18151,
      1,
      18126,
      1,
      18139,
      1,
      18155,
      1,
      18142,
      1
    }
  },
  TrinketSubAttrTypeWeight_4 = {
    Key = "TrinketSubAttrTypeWeight_4",
    CnID = "常量@IV密契获取副属性时_不同属性出现的权重",
    Data = {
      18159,
      1,
      18105,
      1,
      22207,
      1,
      18151,
      1,
      18126,
      1,
      18139,
      1,
      18155,
      1,
      18142,
      1
    }
  },
  TrinketSubAttrTypeWeight_5 = {
    Key = "TrinketSubAttrTypeWeight_5",
    CnID = "常量@V密契获取副属性时_不同属性出现的权重",
    Data = {
      18159,
      1,
      18105,
      1,
      22207,
      1,
      18151,
      1,
      18126,
      1,
      18139,
      1,
      18155,
      1,
      18142,
      1
    }
  },
  TrinketSubAttrTypeWeight_6 = {
    Key = "TrinketSubAttrTypeWeight_6",
    CnID = "常量@VI密契获取副属性时_不同属性出现的权重",
    Data = {
      18159,
      1,
      18105,
      1,
      22207,
      1,
      18151,
      1,
      18126,
      1,
      18139,
      1,
      18155,
      1,
      18142,
      1
    }
  },
  TrinketMainAttrValue = {
    Key = "TrinketMainAttrValue",
    CnID = "常量@密契主属性每个等级的属性份数",
    Data = {
      4,
      4.5,
      5,
      5.5,
      6,
      6.5,
      7,
      7.5,
      8,
      8.5,
      9,
      9.5,
      10
    }
  },
  TrinketSubAttrNumWeight = {
    Key = "TrinketSubAttrNumWeight",
    CnID = "常量@密契初始副属性条目数出现权重",
    Data = {3, 1}
  },
  TrinketSubAttrValueWeight = {
    Key = "TrinketSubAttrValueWeight",
    CnID = "常量@密契副属性份数权重",
    Data = {
      0.5,
      23,
      1,
      20,
      1.5,
      17,
      2,
      14,
      2.5,
      11,
      3,
      8,
      3.5,
      5,
      4,
      2
    }
  },
  TrinketSubAttrValueLevel = {
    Key = "TrinketSubAttrValueLevel",
    CnID = "常量@密契副属性份数等级",
    Data = {
      0.5,
      1,
      1,
      2,
      1.5,
      3,
      2,
      4,
      2.5,
      5,
      3,
      6,
      3.5,
      7,
      4,
      8
    }
  },
  TrinketLevelUpCoinCost = {
    Key = "TrinketLevelUpCoinCost",
    CnID = "常量@密契升级所需金币",
    Data = {
      5000,
      5000,
      5000,
      5000,
      7500,
      7500,
      7500,
      7500,
      10000,
      10000,
      10000,
      10000
    }
  },
  TrinketLevelOverflowReturn = {
    Key = "TrinketLevelOverflowReturn",
    CnID = "常量@密契强化等级溢出时每级返还材料",
    Data = {9619, 1}
  },
  TrinketRefineLockMaxNum = {
    Key = "TrinketRefineLockMaxNum",
    CnID = "常量@密契转录最多锁定副属性数",
    Data = {2}
  },
  TrinketRefineCost = {
    Key = "TrinketRefineCost",
    CnID = "常量@密契每次转录所需材料",
    Data = {
      9619,
      3,
      10108,
      7500
    }
  },
  TrinketUpgradeItemIndex = {
    Key = "TrinketUpgradeItemIndex",
    CnID = "常量@转录材料编号",
    Data = {9619}
  },
  TrinketUpgradeItemNum = {
    Key = "TrinketUpgradeItemNum",
    CnID = "常量@密契升级所需材料数量",
    Data = {
      2,
      2,
      2,
      2,
      3,
      3,
      3,
      3,
      4,
      4,
      4,
      4
    }
  },
  TrinketRefineCostLock1 = {
    Key = "TrinketRefineCostLock1",
    CnID = "常量@密契锁定1个副属性转录所需材料",
    Data = {20}
  },
  TrinketRefineCostLock1Substitute = {
    Key = "TrinketRefineCostLock1Substitute",
    CnID = "常量@密契锁定1个副属性材料不足时替代消耗",
    Data = {9522, 1}
  },
  TrinketRefineCostLock2 = {
    Key = "TrinketRefineCostLock2",
    CnID = "常量@密契锁定2个副属性转录所需材料",
    Data = {9522, 10}
  },
  TrinketDecomposeParams = {
    Key = "TrinketDecomposeParams",
    CnID = "常量@选择已强化的密契进行分解的折算系数",
    Data = {1}
  },
  TrinketMainAttrBindBonusRate = {
    Key = "TrinketMainAttrBindBonusRate",
    CnID = "常量@密契绑定主属性加成比例",
    Data = {0.5}
  },
  TrinketAutoRefineMaxNum = {
    Key = "TrinketAutoRefineMaxNum",
    CnID = "常量@密契自动转录次数上限",
    Data = {100}
  },
  TrinketAutoRefineAttrIntensityGoal = {
    Key = "TrinketAutoRefineAttrIntensityGoal",
    CnID = "常量@密契自动转录目标属性强度",
    Data = {8}
  },
  TrinketUnbindMaterialNum = {
    Key = "TrinketUnbindMaterialNum",
    CnID = "常量@密契解绑所需素材数量",
    Data = {10}
  },
  TrinketAutoRefineExchangeChipSeal = {
    Key = "TrinketAutoRefineExchangeChipSeal",
    CnID = "常量@自动转录密契碎片置换印章数量",
    Data = {1}
  },
  TrinketAutoRefineExchangeFeatherSeal = {
    Key = "TrinketAutoRefineExchangeFeatherSeal",
    CnID = "常量@自动转录追念羽笔置换印章数量",
    Data = {20}
  },
  TrinketRefineGiveUpConfirm = {
    Key = "TrinketRefineGiveUpConfirm",
    CnID = "常量@转录出不小于指定档位的属性时需二次确认",
    Data = {8}
  },
  OrangeTrinketSubAttrNumWeight = {
    Key = "OrangeTrinketSubAttrNumWeight",
    CnID = "常量@SSR饰品初始副属性条目数出现权重_已废弃_",
    Data = {
      4,
      1,
      3,
      2
    }
  },
  PurpleTrinketSubAttrNumWeight = {
    Key = "PurpleTrinketSubAttrNumWeight",
    CnID = "常量@SR饰品初始副属性条目数出现权重_已废弃_",
    Data = {
      3,
      1,
      2,
      2
    }
  },
  BlueTrinketSubAttrNumWeight = {
    Key = "BlueTrinketSubAttrNumWeight",
    CnID = "常量@R饰品初始副属性条目数出现权重_已废弃_",
    Data = {
      2,
      1,
      1,
      2
    }
  },
  TrinketLevelUpSubAttrGet = {
    Key = "TrinketLevelUpSubAttrGet",
    CnID = "常量@饰品到达对应等级时_会获得新副属性_已废弃_",
    Data = {
      3,
      6,
      9,
      12
    }
  },
  TrinketGetExpUp = {
    Key = "TrinketGetExpUp",
    CnID = "常量@饰品每次获得饰品经验值时_有9概率获得双倍经验_1概率获得5倍经验_已废弃_",
    Data = {
      1,
      100,
      2,
      0,
      5,
      0
    }
  },
  TrinketLevelUpTipsLimit = {
    Key = "TrinketLevelUpTipsLimit",
    CnID = "常量@稀有度为SSR的饰品作为强化材料时会弹出提示_已废弃_",
    Data = {"Orange"}
  },
  WeaponLevelUpTipsLimit = {
    Key = "WeaponLevelUpTipsLimit",
    CnID = "常量@稀有度为SSR的武器作为强化材料时会弹出提示_已废弃_",
    Data = {"Orange"}
  },
  TrinketLevelUpGoldCostCoefficient = {
    Key = "TrinketLevelUpGoldCostCoefficient",
    CnID = "常量@饰品获取经验时_需要同时按比例消耗的金币数_已废弃_",
    Data = {0.25}
  },
  OrangeTrinketTrinketLevelLimit = {
    Key = "OrangeTrinketTrinketLevelLimit",
    CnID = "常量@SSR饰品强化等级上限_已废弃_",
    Data = {12}
  },
  PurpleTrinketTrinketLevelLimit = {
    Key = "PurpleTrinketTrinketLevelLimit",
    CnID = "常量@SR饰品强化等级上限_已废弃_",
    Data = {9}
  },
  BlueTrinketTrinketLevelLimit = {
    Key = "BlueTrinketTrinketLevelLimit",
    CnID = "常量@R饰品强化等级上限_已废弃_",
    Data = {6}
  },
  TrinketSubAttrNumLimit = {
    Key = "TrinketSubAttrNumLimit",
    CnID = "常量@饰品副属性达到X种不同的类型时再获得副属性时将会在已有的副属性类型中随机_已废弃_",
    Data = {4}
  },
  OrangeTrinketExpLevel = {
    Key = "OrangeTrinketExpLevel",
    CnID = "常量@SSR饰品作为素材时提供的经验值_已废弃_",
    Data = {9000}
  },
  PurpleTrinketExpLevel = {
    Key = "PurpleTrinketExpLevel",
    CnID = "常量@SR饰品作为素材时提供的经验值_已废弃_",
    Data = {3000}
  },
  BlueTrinketExpLevel = {
    Key = "BlueTrinketExpLevel",
    CnID = "常量@R饰品作为素材时提供的经验值_已废弃_",
    Data = {1000}
  },
  OrangeWeaponExpLevel = {
    Key = "OrangeWeaponExpLevel",
    CnID = "常量@SSR武器作为素材时提供的经验值_已废弃_",
    Data = {25000}
  },
  PurpleWeaponExpLevel = {
    Key = "PurpleWeaponExpLevel",
    CnID = "常量@SR武器作为素材时提供的经验值_已废弃_",
    Data = {5000}
  },
  BlueWeaponExpLevel = {
    Key = "BlueWeaponExpLevel",
    CnID = "常量@R武器作为素材时提供的经验值_已废弃_",
    Data = {500}
  },
  WhiteWeaponExpLevel = {
    Key = "WhiteWeaponExpLevel",
    CnID = "常量@白板武器作为素材时提供的经验值_已废弃_",
    Data = {100}
  },
  TrinketExpConversionRatio = {
    Key = "TrinketExpConversionRatio",
    CnID = "常量@使用已强化的饰品作为素材时的经验转化比例_已废弃_",
    Data = {0.8}
  },
  TrinketSourceList = {
    Key = "TrinketSourceList",
    CnID = "常量@饰品狗粮道具和提供的经验值_已废弃_",
    Data = {
      10086,
      500,
      10107,
      2000,
      9579,
      10000
    }
  },
  ChaosResonanceGroup = {
    Key = "ChaosResonanceGroup",
    CnID = "常量@材料本共鸣组混沌加成",
    Data = {
      "ChaosResonanceGroup"
    }
  },
  BloodResonanceGroup = {
    Key = "BloodResonanceGroup",
    CnID = "常量@材料本共鸣组血肉加成",
    Data = {
      "BloodResonanceGroup"
    }
  },
  DimensionResonanceGroup = {
    Key = "DimensionResonanceGroup",
    CnID = "常量@材料本共鸣组超维加成",
    Data = {
      "DimensionResonanceGroup"
    }
  },
  OceanResonanceGroup = {
    Key = "OceanResonanceGroup",
    CnID = "常量@材料本共鸣组深海加成",
    Data = {
      "OceanResonanceGroup"
    }
  },
  FormulaCorrectionValue = {
    Key = "FormulaCorrectionValue",
    CnID = "常量@战力公式校正值",
    Data = {-83.33}
  },
  HybridizationResonanceGroup = {
    Key = "HybridizationResonanceGroup",
    CnID = "常量@材料本共鸣组混搭加成",
    Data = {
      "HybridizationResonanceGroup"
    }
  },
  WeekChallengeChaosRelicPool = {
    Key = "WeekChallengeChaosRelicPool",
    CnID = "常量@周常挑战混沌造物池",
    Data = {13835}
  },
  WeekChallengeOtherRelicPool = {
    Key = "WeekChallengeOtherRelicPool",
    CnID = "常量@周常挑战其他职业造物池",
    Data = {13835}
  },
  EPGJJCRewardPreview = {
    Key = "EPGJJCRewardPreview",
    CnID = "常量@竞技场奖励预览道具编号",
    Data = {
      9567,
      10083,
      9857
    }
  },
  MailCompensate = {
    Key = "MailCompensate",
    CnID = "常量@邮件补发",
    Data = {18020}
  },
  AwakerLevelStrength = {
    Key = "AwakerLevelStrength",
    CnID = "常量@唤醒体强度",
    Data = {
      135,
      150,
      164,
      178,
      193,
      208,
      224,
      240,
      255,
      272,
      290,
      309,
      328,
      348,
      368,
      390,
      411,
      433,
      456,
      484,
      508,
      532,
      558,
      583,
      609,
      637,
      664,
      693,
      722,
      752,
      782,
      813,
      846,
      878,
      912,
      946,
      981,
      1017,
      1053,
      1126,
      1162,
      1237,
      1274,
      1353,
      1393,
      1477,
      1519,
      1606,
      1652,
      1744,
      1792,
      1890,
      1940,
      2044,
      2097,
      2206,
      2262,
      2377,
      2436,
      2497
    }
  },
  PrologueBeginPlot = {
    Key = "PrologueBeginPlot",
    CnID = "常量@序章开始流程",
    Data = {
      10142,
      "AvgDialog",
      "Name",
      "Name",
      10130,
      "AvgDialog",
      15595,
      "GetAwaker",
      10127,
      "AvgDialog",
      "PrologueMoveCoordinates",
      "Constant",
      15935,
      "StageGroup"
    }
  },
  Prologue0_1Awaker = {
    Key = "Prologue0_1Awaker",
    CnID = "常量@序章0_1_1战斗出战唤醒体",
    Data = {15595}
  },
  Prologue0_2Awaker = {
    Key = "Prologue0_2Awaker",
    CnID = "常量@序章0_2战斗出战唤醒体",
    Data = {15595, 15569}
  },
  Prologue0_1BackupAwaker = {
    Key = "Prologue0_1BackupAwaker",
    CnID = "常量@序章0_1战斗后备唤醒体",
    Data = {
      15585,
      15570,
      15569
    }
  },
  Prologue0_2BackupAwaker = {
    Key = "Prologue0_2BackupAwaker",
    CnID = "常量@序章0_2战斗后备唤醒体",
    Data = {15585, 15570}
  },
  Prologue0_3Awaker = {
    Key = "Prologue0_3Awaker",
    CnID = "常量@序章0_3战斗出战唤醒体",
    Data = {
      15595,
      15585,
      15569,
      15570
    }
  },
  PrologueStageGroup = {
    Key = "PrologueStageGroup",
    CnID = "常量@序章所属关卡组",
    Data = {15935}
  },
  PrologueStage = {
    Key = "PrologueStage",
    CnID = "常量@序章所属关卡",
    Data = {7998}
  },
  PrologueMoveCoordinates = {
    Key = "PrologueMoveCoordinates",
    CnID = "常量@序章初始移动节点坐标",
    Data = {1, 5}
  },
  ProloguePhiloStoneBlock = {
    Key = "ProloguePhiloStoneBlock",
    CnID = "常量@序章关卡屏蔽黑印显示",
    Data = {7998}
  },
  PrologueSettingButtonBlock = {
    Key = "PrologueSettingButtonBlock",
    CnID = "常量@序章关卡屏蔽设置按钮",
    Data = {7998}
  },
  PrologueStressBlock = {
    Key = "PrologueStressBlock",
    CnID = "常量@序章关卡屏蔽压力机制",
    Data = {7998}
  },
  PrologueSpeedBlock = {
    Key = "PrologueSpeedBlock",
    CnID = "常量@序章游戏速度屏蔽",
    Data = {7998}
  },
  PrologueShopRenewBlock = {
    Key = "PrologueShopRenewBlock",
    CnID = "常量@序章0-2商店屏蔽刷新",
    Data = {7998}
  },
  PrologueBlackCoinLock = {
    Key = "PrologueBlackCoinLock",
    CnID = "常量@序章屏蔽黑印掉落加成",
    Data = {7998}
  },
  PrologueInitHp = {
    Key = "PrologueInitHp",
    CnID = "常量@序章初始生命",
    Data = {12}
  },
  EnergyItemTid = {
    Key = "EnergyItemTid",
    CnID = "常量@体力Tid",
    Data = {9578}
  },
  AccountExpItemTid = {
    Key = "AccountExpItemTid",
    CnID = "常量@玩家经验Tid",
    Data = {9556}
  },
  RoleExpItemTid = {
    Key = "RoleExpItemTid",
    CnID = "常量@唤醒体经验Tid",
    Data = {9916}
  },
  GoldItemTid = {
    Key = "GoldItemTid",
    CnID = "常量@金币Tid",
    Data = {10108}
  },
  DiamondItemTid = {
    Key = "DiamondItemTid",
    CnID = "常量@钻石Tid",
    Data = {9567}
  },
  DiamondChargeItemTid = {
    Key = "DiamondChargeItemTid",
    CnID = "常量@充值钻石Tid",
    Data = {9536}
  },
  DiamondBindItemTid = {
    Key = "DiamondBindItemTid",
    CnID = "常量@与源液绑定的道具",
    Data = {140193}
  },
  SummonCoinItemTid = {
    Key = "SummonCoinItemTid",
    CnID = "常量@抽卡币Tid",
    Data = {10112}
  },
  SummonSeniorCoinItemTid = {
    Key = "SummonSeniorCoinItemTid",
    CnID = "常量@高级抽卡币Tid",
    Data = {9615}
  },
  EnergyPotionItemTid = {
    Key = "EnergyPotionItemTid",
    CnID = "常量@体力道具Tid",
    Data = {9803}
  },
  CommonSummonItemTid = {
    Key = "CommonSummonItemTid",
    CnID = "常量@常驻抽卡券Tid",
    Data = {9719}
  },
  SeniroSummonItemTid = {
    Key = "SeniroSummonItemTid",
    CnID = "常量@限时抽卡券Tid",
    Data = {9802}
  },
  VoucherItemTid = {
    Key = "VoucherItemTid",
    CnID = "常量@代金券Tid",
    Data = {21799}
  },
  PlayCoinItemTid = {
    Key = "PlayCoinItemTid",
    CnID = "常量@玩心币Tid",
    Data = {36782}
  },
  DailyCoinItemTid = {
    Key = "DailyCoinItemTid",
    CnID = "常量@日常币Tid",
    Data = {9542}
  },
  FavorBreakThroughItemTid = {
    Key = "FavorBreakThroughItemTid",
    CnID = "常量@同调率突破代币Tid",
    Data = {148404}
  },
  PrologueInfiniteResurrection = {
    Key = "PrologueInfiniteResurrection",
    CnID = "常量@序章无限复活剧情编号",
    Data = {10126}
  },
  AwakerPotencyUpgradeConsumeNum = {
    Key = "AwakerPotencyUpgradeConsumeNum",
    CnID = "常量@启灵升级消耗的唤醒体碎片数量",
    Data = {
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1
    }
  },
  NameLengthRange = {
    Key = "NameLengthRange",
    CnID = "常量@玩家昵称长度区间",
    Data = {2, 14}
  },
  PrologueVideoFileName = {
    Key = "PrologueVideoFileName",
    CnID = "常量@序章PV资源文件名",
    Data = {
      "pv_first_chapter.mp4"
    }
  },
  GuideAwaker = {
    Key = "GuideAwaker",
    CnID = "常量@引导唤醒体",
    Data = {15595}
  },
  MainPanelCurrencies = {
    Key = "MainPanelCurrencies",
    CnID = "常量@主界面货币栏",
    Data = {
      9578,
      10108,
      9536,
      9567
    }
  },
  SummonPanelCurrencies = {
    Key = "SummonPanelCurrencies",
    CnID = "常量@抽卡货币栏",
    Data = {
      9719,
      9802,
      9536,
      9567
    }
  },
  BagPanelCurrencies = {
    Key = "BagPanelCurrencies",
    CnID = "常量@背包货币栏",
    Data = {
      10108,
      9536,
      9567
    }
  },
  DailyMaterialPanelCurrencies = {
    Key = "DailyMaterialPanelCurrencies",
    CnID = "常量@材料本货币栏",
    Data = {9578}
  },
  TrinketCopyPanelCurrencies = {
    Key = "TrinketCopyPanelCurrencies",
    CnID = "常量@饰品本货币栏",
    Data = {9578}
  },
  MainCopyPanelCurrencies = {
    Key = "MainCopyPanelCurrencies",
    CnID = "常量@主线关卡章节选择货币栏"
  },
  MainCopyDetailPanelCurrencies = {
    Key = "MainCopyDetailPanelCurrencies",
    CnID = "常量@主线关卡详情货币栏",
    Data = {9578}
  },
  BPBuyCurrencies = {
    Key = "BPBuyCurrencies",
    CnID = "常量@通行证购买货币栏",
    Data = {9536, 9567}
  },
  ChargePanelCurrencies = {
    Key = "ChargePanelCurrencies",
    CnID = "常量@充值页面货币栏",
    Data = {9536}
  },
  ExchangePanelCurrencies = {
    Key = "ExchangePanelCurrencies",
    CnID = "常量@货币兑换页面货币栏",
    Data = {9536, 9567}
  },
  GiftBagCurrencies = {
    Key = "GiftBagCurrencies",
    CnID = "常量@礼包页面货币栏",
    Data = {9536, 9567}
  },
  SkinConfirMationCurrencies = {
    Key = "SkinConfirMationCurrencies",
    CnID = "常量@时装源液购买确认界面货币栏",
    Data = {9536}
  },
  LevelUpNeedCurreny = {
    Key = "LevelUpNeedCurreny",
    CnID = "常量@升级所需货币栏_废弃_",
    Data = {10108}
  },
  GeneralCultivationNeedCurreny = {
    Key = "GeneralCultivationNeedCurreny",
    CnID = "常量@通用养成所需货币栏",
    Data = {10108}
  },
  TrinketRefineCurrencies = {
    Key = "TrinketRefineCurrencies",
    CnID = "常量@密契转录界面货币栏",
    Data = {
      9522,
      9567,
      10108
    }
  },
  PVPCurrencies = {
    Key = "PVPCurrencies",
    CnID = "常量@PVP界面货币栏"
  },
  TeamUnlockCostCurrencies = {
    Key = "TeamUnlockCostCurrencies",
    CnID = "常量@解锁额外编队货币栏",
    Data = {9615}
  },
  ChallengeCurrencies_MagicStoryActivity = {
    Key = "ChallengeCurrencies_MagicStoryActivity",
    CnID = "常量@剧本迷思关卡界面货币栏",
    Data = {34723, 9578}
  },
  ChallengeCurrencies_WandaActivity = {
    Key = "ChallengeCurrencies_WandaActivity",
    CnID = "常量@湖中之城关卡界面货币栏",
    Data = {
      38704,
      38703,
      38702,
      9578
    }
  },
  ChallengeCurrencies_SalvadorActivity = {
    Key = "ChallengeCurrencies_SalvadorActivity",
    CnID = "常量@圣堂之路关卡界面货币栏",
    Data = {44265, 9578}
  },
  ChallengeCurrencies_A24Activity = {
    Key = "ChallengeCurrencies_A24Activity",
    CnID = "常量@记忆编码关卡界面货币栏",
    Data = {
      46606,
      46608,
      46607,
      9578
    }
  },
  ChallengeCurrencies_ThaisActivity = {
    Key = "ChallengeCurrencies_ThaisActivity",
    CnID = "常量@紊乱情欲关卡界面货币栏",
    Data = {48700, 9578}
  },
  ChallengeCurrencies_MagicStoryActivityReproduce = {
    Key = "ChallengeCurrencies_MagicStoryActivityReproduce",
    CnID = "常量@剧本迷思复刻关卡界面货币栏",
    Data = {51105, 9578}
  },
  ChallengeCurrencies_MiryamActivity = {
    Key = "ChallengeCurrencies_MiryamActivity",
    CnID = "常量@弥利亚姆关卡界面货币栏",
    Data = {
      52039,
      52038,
      52037,
      9578
    }
  },
  ChallengeCurrencies_SorelActivity = {
    Key = "ChallengeCurrencies_SorelActivity",
    CnID = "常量@索蕾尔活动关卡界面货币栏",
    Data = {53746, 9578}
  },
  ChallengeCurrencies_HorlaActivity = {
    Key = "ChallengeCurrencies_HorlaActivity",
    CnID = "常量@奥尔拉活动关卡界面货币栏",
    Data = {
      55128,
      55126,
      55127,
      9578
    }
  },
  ChallengeCurrencies_MurphyActivity = {
    Key = "ChallengeCurrencies_MurphyActivity",
    CnID = "常量@墨菲活动关卡界面货币栏",
    Data = {
      56487,
      56489,
      56488,
      9578
    }
  },
  ChallengeCurrencies_RykerActivity = {
    Key = "ChallengeCurrencies_RykerActivity",
    CnID = "常量@莱克活动关卡界面货币栏",
    Data = {56484, 9578}
  },
  ChallengeCurrencies_SalvadorActivityReproduce = {
    Key = "ChallengeCurrencies_SalvadorActivityReproduce",
    CnID = "常量@萨尔瓦多复刻活动关卡界面货币栏",
    Data = {44265, 9578}
  },
  ChallengeCurrencies_HamelnActivity = {
    Key = "ChallengeCurrencies_HamelnActivity",
    CnID = "常量@哈姆林活动关卡界面货币栏",
    Data = {56485, 9578}
  },
  ChallengeCurrencies_A24ActivityReproduce = {
    Key = "ChallengeCurrencies_A24ActivityReproduce",
    CnID = "常量@24复刻活动关卡界面货币栏",
    Data = {
      46606,
      46608,
      46607,
      9578
    }
  },
  ChallengeCurrencies_OriginHelotActivity = {
    Key = "ChallengeCurrencies_OriginHelotActivity",
    CnID = "常量@本源希洛活动关卡界面货币栏",
    Data = {
      56490,
      56491,
      56492,
      9578
    }
  },
  ChallengeCurrencies_WandaActivityReproduce = {
    Key = "ChallengeCurrencies_WandaActivityReproduce",
    CnID = "常量@旺达复刻活动关卡界面货币栏",
    Data = {
      38704,
      38703,
      38702,
      9578
    }
  },
  ChallengeCurrencies_TawilActivity = {
    Key = "ChallengeCurrencies_TawilActivity",
    CnID = "常量@塔薇活动关卡界面货币栏",
    Data = {56486, 9578}
  },
  ChallengeCurrencies_MiryamActivityReproduce = {
    Key = "ChallengeCurrencies_MiryamActivityReproduce",
    CnID = "常量@弥利亚姆复刻活动关卡界面货币栏",
    Data = {
      52039,
      52038,
      52037,
      9578
    }
  },
  ChallengeCurrencies_OriginDollActivity = {
    Key = "ChallengeCurrencies_OriginDollActivity",
    CnID = "常量@本源朵尔活动关卡界面货币栏",
    Data = {56483, 9578}
  },
  ChallengeCurrencies_TuluActivity = {
    Key = "ChallengeCurrencies_TuluActivity",
    CnID = "常量@图鲁活动关卡界面货币栏",
    Data = {
      68421,
      68419,
      68420,
      9578
    }
  },
  ChallengeCurrencies_DaffodilActivity = {
    Key = "ChallengeCurrencies_DaffodilActivity",
    CnID = "常量@达芙黛尔活动关卡界面货币栏",
    Data = {
      75786,
      75785,
      75784,
      9578
    }
  },
  ChallengeCurrencies_ClementineActivity = {
    Key = "ChallengeCurrencies_ClementineActivity",
    CnID = "常量@克莱门汀活动关卡界面货币栏",
    Data = {79568, 9578}
  },
  ChallengeCurrencies_StElmosFireActivity = {
    Key = "ChallengeCurrencies_StElmosFireActivity",
    CnID = "常量@克珀珊特活动关卡界面货币栏",
    Data = {81250, 9578}
  },
  ChallengeCurrencies_RomeActivity = {
    Key = "ChallengeCurrencies_RomeActivity",
    CnID = "常量@罗马活动关卡界面货币栏",
    Data = {90957, 9578}
  },
  ChallengeCurrencies_KathiguRaActivity = {
    Key = "ChallengeCurrencies_KathiguRaActivity",
    CnID = "常量@凯蒂古拉活动关卡界面货币栏",
    Data = {
      95120,
      95119,
      95169,
      9578
    }
  },
  ChallengeCurrencies_PickManActivity = {
    Key = "ChallengeCurrencies_PickManActivity",
    CnID = "常量@皮克曼活动关卡界面货币栏",
    Data = {
      96827,
      96825,
      96826,
      9578
    }
  },
  ChallengeCurrencies_PolluxActivity = {
    Key = "ChallengeCurrencies_PolluxActivity",
    CnID = "常量@波吕克斯活动关卡界面货币栏",
    Data = {
      116527,
      116559,
      116547,
      9578
    }
  },
  ChallengeCurrencies_OriginMurphyActivity = {
    Key = "ChallengeCurrencies_OriginMurphyActivity",
    CnID = "常量@本源深海淑女活动关卡界面货币栏",
    Data = {
      97594,
      97585,
      97575,
      9578
    }
  },
  ChallengeCurrencies_SummerChapter2Activity = {
    Key = "ChallengeCurrencies_SummerChapter2Activity",
    CnID = "常量@夏日活动下关卡界面货币栏",
    Data = {97789, 9578}
  },
  ChallengeCurrencies_MouchetteActivity = {
    Key = "ChallengeCurrencies_MouchetteActivity",
    CnID = "常量@茉夏活动关卡界面货币栏",
    Data = {
      122263,
      122265,
      122264,
      9578
    }
  },
  ChallengeCurrencies_XuActivity = {
    Key = "ChallengeCurrencies_XuActivity",
    CnID = "常量@徐活动关卡界面货币栏",
    Data = {125173, 9578}
  },
  ChallengeCurrencies_MoskActivity = {
    Key = "ChallengeCurrencies_MoskActivity",
    CnID = "常量@莫丝活动关卡界面货币栏",
    Data = {
      130742,
      130721,
      130778,
      9578
    }
  },
  ChallengeCurrencies_ArachneActivity = {
    Key = "ChallengeCurrencies_ArachneActivity",
    CnID = "常量@阿拉克涅活动关卡界面货币栏",
    Data = {126172, 9578}
  },
  ChallengeCurrencies_SayaActivity = {
    Key = "ChallengeCurrencies_SayaActivity",
    CnID = "常量@沙耶活动关卡界面货币栏",
    Data = {
      130049,
      130097,
      130077,
      9578
    }
  },
  ChallengeCurrencies_PontosActivity = {
    Key = "ChallengeCurrencies_PontosActivity",
    CnID = "常量@庞托斯活动关卡界面货币栏",
    Data = {
      141230,
      141193,
      141225,
      9578
    }
  },
  ChallengeCurrencies_LotanCetarchonActivity = {
    Key = "ChallengeCurrencies_LotanCetarchonActivity",
    CnID = "常量@蚀灭·萝坦活动关卡界面货币栏",
    Data = {145276, 9578}
  },
  ChallengeCurrencies_CarabooActivity = {
    Key = "ChallengeCurrencies_CarabooActivity",
    CnID = "常量@卡拉布活动关卡界面货币栏",
    Data = {
      141680,
      141721,
      141673,
      9578
    }
  },
  ChallengeCurrencies_GenesisOgierActivity = {
    Key = "ChallengeCurrencies_GenesisOgierActivity",
    CnID = "常量@本源奥吉尔活动关卡界面货币栏",
    Data = {146872, 9578}
  },
  ChallengeCurrencies_GenesisTinctActivity = {
    Key = "ChallengeCurrencies_GenesisTinctActivity",
    CnID = "常量@暮星·汀克特活动关卡界面货币栏",
    Data = {
      147274,
      147299,
      147254,
      9578
    }
  },
  ChallengeCurrencies_TaisuiActivity = {
    Key = "ChallengeCurrencies_TaisuiActivity",
    CnID = "常量@太岁活动关卡界面货币栏",
    Data = {
      143937,
      143938,
      143940,
      9578
    }
  },
  ActivityType_UniqueOpen = {
    Key = "ActivityType_UniqueOpen",
    CnID = "常量@不能同时开多个的活动类型",
    Data = {
      "ThaisActivity",
      "MagicStoryActivityReproduce",
      "SorelActivity",
      "HorlaActivity",
      "MurphyActivity",
      "RykerActivity",
      "SalvadorActivityReproduce",
      "HamelnActivity",
      "A24ActivityReproduce",
      "OriginHelotActivity",
      "WandaActivityReproduce",
      "MiryamActivityReproduce",
      "TawilActivity",
      "TuluActivity",
      "OriginDollActivity",
      "DaffodilActivity",
      "ClementineActivity",
      "DoresainActivity",
      "RomeActivity",
      "KathiguRaActivity",
      "PickManActivity",
      "SummerChapter1Activity",
      "SummerChapter2Activity",
      "PolluxActivity",
      "OriginMurphyActivity",
      "MouchetteActivity",
      "XuActivity",
      "MoskActivity",
      "ArachneActivity",
      "SayaActivity",
      "PontosActivity",
      "LotanCetarchonActivity",
      "CarabooActivity",
      "GenesisOgierActivity",
      "GenesisTinctActivity",
      "ModiglianActivity",
      "AntrakActivity",
      "LulimActivity",
      "OriginTuluActivity",
      "TaisuiActivity"
    }
  },
  LargeSubplotCurrencies = {
    Key = "LargeSubplotCurrencies",
    CnID = "常量@特遣纪录选择界面货币栏",
    Data = {36863}
  },
  SmallSubplotCurrencies = {
    Key = "SmallSubplotCurrencies",
    CnID = "常量@意识潜游选择界面货币栏",
    Data = {36863}
  },
  SpecialSubplotCurrencies = {
    Key = "SpecialSubplotCurrencies",
    CnID = "常量@异梦世界选择界面货币栏",
    Data = {36863}
  },
  VindicateCurrencies = {
    Key = "VindicateCurrencies",
    CnID = "常量@繁衍狂热选择界面货币栏",
    Data = {36863}
  },
  LinkageActivityCurrencies = {
    Key = "LinkageActivityCurrencies",
    CnID = "常量@多维连接选择界面货币栏",
    Data = {36863}
  },
  SilverRoadCurrencies = {
    Key = "SilverRoadCurrencies",
    CnID = "常量@银辉之路选择界面货币栏",
    Data = {36863}
  },
  MusicCurrencies = {
    Key = "MusicCurrencies",
    CnID = "常量@图鉴留声机专辑界面货币栏",
    Data = {36863}
  },
  ActivityCGCurrencies = {
    Key = "ActivityCGCurrencies",
    CnID = "常量@图鉴活动影像界面货币栏",
    Data = {36863}
  },
  AwakerExpItem = {
    Key = "AwakerExpItem",
    CnID = "常量@经验书道具和提供经验值",
    Data = {
      9762,
      10000,
      9834,
      2000,
      10064,
      500
    }
  },
  AwakerExpCoinRatio = {
    Key = "AwakerExpCoinRatio",
    CnID = "常量@唤醒体升级所需金币和经验值的比率",
    Data = {0.2}
  },
  MainShopTypeAdvanceDC = {
    Key = "MainShopTypeAdvanceDC",
    CnID = "常量@高级抽卡币商店",
    Data = {18654}
  },
  DailyChallengeShop = {
    Key = "DailyChallengeShop",
    CnID = "常量@日常币商店",
    Data = {18651}
  },
  GiftBagShop = {
    Key = "GiftBagShop",
    CnID = "常量@礼包商店",
    Data = {18656}
  },
  DiamondShop = {
    Key = "DiamondShop",
    CnID = "常量@银芯购买商店",
    Data = {18652}
  },
  LevelAchievements = {
    Key = "LevelAchievements",
    CnID = "常量@关卡成就",
    Data = {19}
  },
  LevelStarRating = {
    Key = "LevelStarRating",
    CnID = "常量@关卡星级",
    Data = {20}
  },
  MonsterHpBarLength = {
    Key = "MonsterHpBarLength",
    CnID = "常量@怪物血条长度",
    Data = {
      127,
      190,
      365,
      800
    }
  },
  PlayerHpBarLength = {
    Key = "PlayerHpBarLength",
    CnID = "常量@玩家血条长度",
    Data = {340}
  },
  CardClickRaisePixel = {
    Key = "CardClickRaisePixel",
    CnID = "常量@点击卡牌抬起高度",
    Data = {50}
  },
  BattleHard_Common = {
    Key = "BattleHard_Common",
    CnID = "常量@普通怪头像框",
    Data = {
      "UIResources/AtlasSource/2_Icon/ToolQuality/UI_Quality_Silver.png"
    }
  },
  BattleHard_Elite = {
    Key = "BattleHard_Elite",
    CnID = "常量@精英怪头像框",
    Data = {
      "UIResources/AtlasSource/2_Icon/ToolQuality/UI_Quality_Silver.png"
    }
  },
  BattleHard_Boss = {
    Key = "BattleHard_Boss",
    CnID = "常量@BOSS头像框",
    Data = {
      "UIResources/AtlasSource/2_Icon/ToolQuality/UI_Quality_Red.png"
    }
  },
  BodyWidth_Monster_Mini = {
    Key = "BodyWidth_Monster_Mini",
    CnID = "常量@迷你怪怪物宽度",
    Data = {140}
  },
  BodyWidth_Monster_Middle = {
    Key = "BodyWidth_Monster_Middle",
    CnID = "常量@中型怪怪物宽度",
    Data = {235}
  },
  BodyWidth_Monster_Big = {
    Key = "BodyWidth_Monster_Big",
    CnID = "常量@大型怪怪物宽度",
    Data = {315}
  },
  BodyWidth_Monster_Huge = {
    Key = "BodyWidth_Monster_Huge",
    CnID = "常量@巨型怪怪物宽度",
    Data = {590}
  },
  UtliSfxFlySpeed = {
    Key = "UtliSfxFlySpeed",
    CnID = "常量@狂气特效飞行速度",
    Data = {600}
  },
  RevivalItemId = {
    Key = "RevivalItemId",
    CnID = "常量@应急灵知体道具编号",
    Data = {10072}
  },
  RevivalItemNumLimit = {
    Key = "RevivalItemNumLimit",
    CnID = "常量@应急灵知体上限",
    Data = {5}
  },
  RevivalItemGetDaily = {
    Key = "RevivalItemGetDaily",
    CnID = "常量@应急灵知体每天恢复次数",
    Data = {1}
  },
  LowMiddleMachineScore = {
    Key = "LowMiddleMachineScore",
    CnID = "常量@低中配机性能评分分隔值",
    Data = {569}
  },
  MiddleHighMachineScore = {
    Key = "MiddleHighMachineScore",
    CnID = "常量@中高配机性能评分分隔值",
    Data = {1597}
  },
  ResonanceGroupChapter1 = {
    Key = "ResonanceGroupChapter1",
    CnID = "常量@共鸣组第一章",
    Data = {
      10058,
      10108,
      2000,
      "Resonance_Group_Name_1",
      "Resonance_Group_Desc_1"
    }
  },
  ResonanceGroupChapter2 = {
    Key = "ResonanceGroupChapter2",
    CnID = "常量@共鸣组第二章",
    Data = {
      10076,
      10108,
      5000,
      "Resonance_Group_Name_2",
      "Resonance_Group_Desc_2"
    }
  },
  ResonanceGroupChapter3 = {
    Key = "ResonanceGroupChapter3",
    CnID = "常量@共鸣组第三章",
    Data = {
      9843,
      10108,
      5000,
      "Resonance_Group_Name_3",
      "Resonance_Group_Desc_3"
    }
  },
  ResonanceGroupChapter4 = {
    Key = "ResonanceGroupChapter4",
    CnID = "常量@共鸣组第四章",
    Data = {
      9754,
      10108,
      5000,
      "Resonance_Group_Name_4",
      "Resonance_Group_Desc_4"
    }
  },
  ResonanceGroupChapter5 = {
    Key = "ResonanceGroupChapter5",
    CnID = "常量@共鸣组第五章",
    Data = {
      9617,
      10108,
      5000,
      "Resonance_Group_Name_5",
      "Resonance_Group_Desc_5"
    }
  },
  ResonanceGroupChapter6 = {
    Key = "ResonanceGroupChapter6",
    CnID = "常量@共鸣组第六章",
    Data = {
      9558,
      10108,
      5000,
      "Resonance_Group_Name_6",
      "Resonance_Group_Desc_6"
    }
  },
  ResonanceGroupChapter7 = {
    Key = "ResonanceGroupChapter7",
    CnID = "常量@共鸣组第七章",
    Data = {
      48924,
      10108,
      5000,
      "Resonance_Group_Name_7",
      "Resonance_Group_Desc_7"
    }
  },
  ResonanceGroupChapter8 = {
    Key = "ResonanceGroupChapter8",
    CnID = "常量@共鸣组第八章",
    Data = {
      56495,
      10108,
      5000,
      "Resonance_Group_Name_8",
      "Resonance_Group_Desc_8"
    }
  },
  ResonanceGroupChapter9 = {
    Key = "ResonanceGroupChapter9",
    CnID = "常量@共鸣组第九章",
    Data = {
      56494,
      10108,
      5000,
      "Resonance_Group_Name_9",
      "Resonance_Group_Desc_9"
    }
  },
  ResonanceGroup2Chapter1 = {
    Key = "ResonanceGroup2Chapter1",
    CnID = "常量@共鸣组星辰第一章",
    Data = {
      74200,
      10108,
      5000,
      "Resonance_Group_Desc_x1",
      "Resonance_Group_Desc_x1"
    }
  },
  ResonanceGroup2Chapter2 = {
    Key = "ResonanceGroup2Chapter2",
    CnID = "常量@共鸣组星辰第二章",
    Data = {
      80192,
      10108,
      5000,
      "Resonance_Group_Desc_x2",
      "Resonance_Group_Desc_x2"
    }
  },
  ResonanceGroup2Chapter3 = {
    Key = "ResonanceGroup2Chapter3",
    CnID = "常量@共鸣组星辰第三章",
    Data = {
      90554,
      10108,
      5000,
      "Resonance_Group_Desc_x3",
      "Resonance_Group_Desc_x3"
    }
  },
  ResonanceGroup2Chapter4 = {
    Key = "ResonanceGroup2Chapter4",
    CnID = "常量@共鸣组星辰第四章",
    Data = {
      117263,
      10108,
      5000,
      "Resonance_Group_Desc_x4",
      "Resonance_Group_Desc_x4"
    }
  },
  ResonanceGroup2Chapter5 = {
    Key = "ResonanceGroup2Chapter5",
    CnID = "常量@共鸣组星辰第五章",
    Data = {
      125875,
      10108,
      5000,
      "Resonance_Group_Desc_x5",
      "Resonance_Group_Desc_x5"
    }
  },
  ResonanceGroup2Chapter6 = {
    Key = "ResonanceGroup2Chapter6",
    CnID = "常量@共鸣组星辰第六章",
    Data = {
      146353,
      10108,
      5000,
      "Resonance_Group_Desc_x6",
      "Resonance_Group_Desc_x6"
    }
  },
  ResonanceGroupMagicStoryActivity = {
    Key = "ResonanceGroupMagicStoryActivity",
    CnID = "常量@共鸣组故事的魔法",
    Data = {
      34724,
      10108,
      5000,
      "Resonance_Group_Name_6",
      "Resonance_Group_Desc_Lily",
      34755
    }
  },
  ResonanceGroupWangda = {
    Key = "ResonanceGroupWangda",
    CnID = "常量@共鸣组旺达活动",
    Data = {
      36889,
      10108,
      5000,
      "Resonance_Group_Name_6",
      "Resonance_Group_Desc_Wangda",
      131090
    }
  },
  ResonanceGroupSEWD = {
    Key = "ResonanceGroupSEWD",
    CnID = "常量@共鸣组萨尔瓦多活动",
    Data = {
      44174,
      10108,
      5000,
      "Resonance_Group_Name_6",
      "Resonance_Group_Desc_SEWD",
      44273
    }
  },
  ResonanceGroup24 = {
    Key = "ResonanceGroup24",
    CnID = "常量@共鸣组24活动",
    Data = {
      47304,
      10108,
      5000,
      "Resonance_Group_Name_6",
      "Resonance_Group_Desc_24",
      124987
    }
  },
  ResonanceGroupO07Activity = {
    Key = "ResonanceGroupO07Activity",
    CnID = "常量@共鸣组弥利亚姆活动",
    Data = {
      52069,
      10108,
      5000,
      "Resonance_Group_Name_6",
      "Resonance_Group_Desc_MLYM",
      67733
    }
  },
  ResonanceGroupHorla = {
    Key = "ResonanceGroupHorla",
    CnID = "常量@共鸣组奥尔拉活动",
    Data = {
      55129,
      10108,
      5000,
      "Resonance_Group_Name_6",
      "Resonance_Group_Desc_Horla",
      67718
    }
  },
  ResonanceGroupOriginHelot = {
    Key = "ResonanceGroupOriginHelot",
    CnID = "常量@共鸣组本源希洛活动",
    Data = {
      56493,
      10108,
      5000,
      "Resonance_Group_Name_6",
      "Resonance_Group_Desc_D05EX",
      67745
    }
  },
  ResonanceGroupRailway = {
    Key = "ResonanceGroupRailway",
    CnID = "常量@共鸣疾驰的欢愉专列活动",
    Data = {
      129143,
      10108,
      5000,
      "Resonance_Group_Name_Railway",
      "Resonance_Group_Desc_Railway"
    }
  },
  MonthlyCardLastDays = {
    Key = "MonthlyCardLastDays",
    CnID = "常量@月卡购买持续时间",
    Data = {30}
  },
  MonthlyCardDailyAward = {
    Key = "MonthlyCardDailyAward",
    CnID = "常量@月卡每日登录可领取奖励",
    Data = {9567, 200}
  },
  MonthlyCardBuyLimit = {
    Key = "MonthlyCardBuyLimit",
    CnID = "常量@月卡购买剩余天数限制",
    Data = {150}
  },
  MonthlyCardOverflowReturn = {
    Key = "MonthlyCardOverflowReturn",
    CnID = "常量@月卡溢出返还",
    Data = {9536, 300}
  },
  MonthlyCardPrice = {
    Key = "MonthlyCardPrice",
    CnID = "常量@月卡购买价格",
    Data = {9536, 300}
  },
  MonthlyCardBuyAward = {
    Key = "MonthlyCardBuyAward",
    CnID = "常量@月卡购买立即获得",
    Data = {9567, 300}
  },
  DefaultCurrencyType = {
    Key = "DefaultCurrencyType",
    CnID = "常量@默认货币类型",
    Data = {"CNY"}
  },
  ChargePriceListShow = {
    Key = "ChargePriceListShow",
    CnID = "常量@充值档次默认购买价格",
    Data = {
      6,
      30,
      98,
      198,
      328,
      648
    }
  },
  MonthCardPriceShow = {
    Key = "MonthCardPriceShow",
    CnID = "常量@月卡默认购买价格",
    Data = {30}
  },
  FirstPayDoubleResetDate = {
    Key = "FirstPayDoubleResetDate",
    CnID = "常量@首充双倍重置日期",
    Data = {1779066000}
  },
  ExchangeNumAddPerClick = {
    Key = "ExchangeNumAddPerClick",
    CnID = "常量@货币兑换每次增量",
    Data = {100}
  },
  RefundNoticeMail = {
    Key = "RefundNoticeMail",
    CnID = "常量@退款通知邮件",
    Data = {18019}
  },
  StageFirstClearGiftDefaultTime = {
    Key = "StageFirstClearGiftDefaultTime",
    CnID = "常量@章节通关礼包缺省持续时间",
    Data = {2592000}
  },
  HpMultiplier = {
    Key = "HpMultiplier",
    CnID = "常量@突破升级生命倍率",
    Data = {
      0.5,
      0.55,
      0.6,
      0.8,
      1,
      1.5
    }
  },
  WeaponUpgradeBoostPropertyRate = {
    Key = "WeaponUpgradeBoostPropertyRate",
    CnID = "常量@武器升级提升属性倍率",
    Data = {0.1}
  },
  SSRWeaponBreakthroughIncreaseMainPropertyAmount = {
    Key = "SSRWeaponBreakthroughIncreaseMainPropertyAmount",
    CnID = "常量@SSR武器突破提升主属性份数",
    Data = {9}
  },
  SRWeaponBreakthroughIncreaseMainPropertyAmount = {
    Key = "SRWeaponBreakthroughIncreaseMainPropertyAmount",
    CnID = "常量@SR武器突破提升主属性份数",
    Data = {7.5}
  },
  RWeaponBreakthroughIncreaseMainPropertyAmount = {
    Key = "RWeaponBreakthroughIncreaseMainPropertyAmount",
    CnID = "常量@R武器突破提升主属性份数",
    Data = {6}
  },
  SSRWeaponBreakthroughIncreaseSubPropertyAmount = {
    Key = "SSRWeaponBreakthroughIncreaseSubPropertyAmount",
    CnID = "常量@SSR武器突破提升副属性份数",
    Data = {0}
  },
  SRWeaponBreakthroughIncreaseSubPropertyAmount = {
    Key = "SRWeaponBreakthroughIncreaseSubPropertyAmount",
    CnID = "常量@SR武器突破提升副属性份数",
    Data = {0}
  },
  RWeaponBreakthroughIncreaseSubPropertyAmount = {
    Key = "RWeaponBreakthroughIncreaseSubPropertyAmount",
    CnID = "常量@R武器突破提升副属性份数",
    Data = {0}
  },
  WeaponFeedItemsAndProvidedExperience = {
    Key = "WeaponFeedItemsAndProvidedExperience",
    CnID = "常量@武器狗粮道具和提供的经验值",
    Data = {
      9773,
      100,
      9792,
      500,
      10017,
      2000
    }
  },
  SSRWeaponMaterialExperience = {
    Key = "SSRWeaponMaterialExperience",
    CnID = "常量@SSR武器作为武器强化素材时提供的经验值",
    Data = {30000}
  },
  SRWeaponMaterialExperience = {
    Key = "SRWeaponMaterialExperience",
    CnID = "常量@SR武器作为武器强化素材时提供的经验值",
    Data = {6000}
  },
  RWeaponMaterialExperience = {
    Key = "RWeaponMaterialExperience",
    CnID = "常量@R武器作为武器强化素材时提供的经验值",
    Data = {1000}
  },
  WhiteWeaponMaterialExperience = {
    Key = "WhiteWeaponMaterialExperience",
    CnID = "常量@N武器作为武器强化素材时提供的经验值",
    Data = {100}
  },
  ExperienceConversionRate = {
    Key = "ExperienceConversionRate",
    CnID = "常量@经验值折算比率",
    Data = {0.8}
  },
  WeaponUpgradeLevelCap = {
    Key = "WeaponUpgradeLevelCap",
    CnID = "常量@武器强化等级上限",
    Data = {60}
  },
  RatioOfGoldToBasicExperienceWhenUpgradingWeapon = {
    Key = "RatioOfGoldToBasicExperienceWhenUpgradingWeapon",
    CnID = "常量@强化武器时金币和基础经验的比率",
    Data = {0.2}
  },
  SSRWeaponBreakthroughMaterialConsumptionCurve = {
    Key = "SSRWeaponBreakthroughMaterialConsumptionCurve",
    CnID = "常量@SSR武器突破第一个消耗材料数量曲线",
    Data = {
      9,
      12,
      27,
      12,
      57
    }
  },
  SRWeaponBreakthroughMaterialConsumptionCurve = {
    Key = "SRWeaponBreakthroughMaterialConsumptionCurve",
    CnID = "常量@SR武器突破第一个消耗材料数量曲线",
    Data = {
      6,
      8,
      18,
      8,
      38
    }
  },
  RWeaponBreakthroughMaterialConsumptionCurve = {
    Key = "RWeaponBreakthroughMaterialConsumptionCurve",
    CnID = "常量@R武器突破第一个消耗材料数量曲线",
    Data = {
      3,
      4,
      9,
      4,
      19
    }
  },
  SSRWeaponBreakthroughFirstWorldMaterialConsumptionCurve = {
    Key = "SSRWeaponBreakthroughFirstWorldMaterialConsumptionCurve",
    CnID = "常量@SSR武器突破第二个消耗材料数量曲线",
    Data = {
      9,
      12,
      27,
      12,
      57
    }
  },
  SRWeaponBreakthroughFirstWorldMaterialConsumptionCurve = {
    Key = "SRWeaponBreakthroughFirstWorldMaterialConsumptionCurve",
    CnID = "常量@SR武器突破第二个消耗材料数量曲线",
    Data = {
      6,
      8,
      18,
      8,
      38
    }
  },
  RWeaponBreakthroughFirstWorldMaterialConsumptionCurve = {
    Key = "RWeaponBreakthroughFirstWorldMaterialConsumptionCurve",
    CnID = "常量@R武器突破第二个消耗材料数量曲线",
    Data = {
      3,
      4,
      9,
      4,
      19
    }
  },
  SSRWeaponBreakthroughSecondWorldMaterialConsumptionCurve = {
    Key = "SSRWeaponBreakthroughSecondWorldMaterialConsumptionCurve",
    CnID = "常量@SSR武器突破第三个消耗材料数量曲线",
    Data = {
      0,
      0,
      0,
      0,
      0
    }
  },
  SRWeaponBreakthroughSecondWorldMaterialConsumptionCurve = {
    Key = "SRWeaponBreakthroughSecondWorldMaterialConsumptionCurve",
    CnID = "常量@SR武器突破第三个消耗材料数量曲线",
    Data = {
      0,
      0,
      0,
      0,
      0
    }
  },
  RWeaponBreakthroughSecondWorldMaterialConsumptionCurve = {
    Key = "RWeaponBreakthroughSecondWorldMaterialConsumptionCurve",
    CnID = "常量@R武器突破第三个消耗材料数量曲线",
    Data = {
      0,
      0,
      0,
      0,
      0
    }
  },
  SSRWeaponBreakthroughGoldConsumption = {
    Key = "SSRWeaponBreakthroughGoldConsumption",
    CnID = "常量@SSR武器突破金币消耗",
    Data = {
      2700,
      10800,
      24300,
      32400,
      153900
    }
  },
  SRWeaponBreakthroughGoldConsumption = {
    Key = "SRWeaponBreakthroughGoldConsumption",
    CnID = "常量@SR武器突破金币消耗",
    Data = {
      1800,
      7200,
      16200,
      21600,
      102600
    }
  },
  RWeaponBreakthroughGoldConsumption = {
    Key = "RWeaponBreakthroughGoldConsumption",
    CnID = "常量@R武器突破金币消耗",
    Data = {
      900,
      3600,
      8100,
      10800,
      51300
    }
  },
  WeaponBreakthroughGoldConsumption = {
    Key = "WeaponBreakthroughGoldConsumption",
    CnID = "常量@武器突破金币消耗",
    Data = {
      900,
      3600,
      8100,
      10800,
      51300
    }
  },
  WeaponBreakthroughRequiredUpgradeLevel = {
    Key = "WeaponBreakthroughRequiredUpgradeLevel",
    CnID = "常量@武器突破所需强化等级",
    Data = {
      10,
      20,
      30,
      40,
      50
    }
  },
  PlayerLevelRequiredForWeaponBreakthrough = {
    Key = "PlayerLevelRequiredForWeaponBreakthrough",
    CnID = "常量@武器突破所需的玩家等级",
    Data = {
      10,
      20,
      30,
      40,
      50
    }
  },
  WeaponBreakthroughMainRatio = {
    Key = "WeaponBreakthroughMainRatio",
    CnID = "常量@武器突破提升主属性值和基础值的倍率",
    Data = {0.6}
  },
  WeaponBreakthroughSubRatio = {
    Key = "WeaponBreakthroughSubRatio",
    CnID = "常量@武器突破提升副属性值和基础值的倍率",
    Data = {0}
  },
  GeneralStageNotChangeLayer = {
    Key = "GeneralStageNotChangeLayer",
    CnID = "常量@非变化层数的通用状态",
    Data = {
      3469,
      2564,
      2934
    }
  },
  CombatGrowParams = {
    Key = "CombatGrowParams",
    CnID = "常量@战力养成系数",
    Data = {
      0,
      1,
      1,
      0,
      0,
      0,
      0,
      2,
      1.5,
      1.5,
      18,
      0
    }
  },
  CombatSegParams = {
    Key = "CombatSegParams",
    CnID = "常量@战力区间分段系数",
    Data = {
      0,
      787.8,
      1084.1,
      1501.4,
      1897.7
    }
  },
  CombatLinearSimSlopes = {
    Key = "CombatLinearSimSlopes",
    CnID = "常量@战力线性模拟斜率系数",
    Data = {
      1,
      1,
      1,
      1,
      1
    }
  },
  CombatLinearSimConstants = {
    Key = "CombatLinearSimConstants",
    CnID = "常量@战力线性模拟常量系数",
    Data = {
      0,
      0,
      0,
      0,
      0
    }
  },
  CombatQualityParams = {
    Key = "CombatQualityParams",
    CnID = "常量@战力品质系数",
    Data = {
      {"Green", 0},
      {"Blue", 4},
      {"Purple", 5},
      {"Orange", 6}
    }
  },
  BPExpWeeklyLimit = {
    Key = "BPExpWeeklyLimit",
    CnID = "常量@BP每周经验上限",
    Data = {600000}
  },
  BPBigRewardInterval = {
    Key = "BPBigRewardInterval",
    CnID = "常量@BP每几级一个大奖励",
    Data = {5}
  },
  BPExpireHours = {
    Key = "BPExpireHours",
    CnID = "常量@BP到期前几小时发送提醒邮件",
    Data = {48}
  },
  BPExpireRemindMail = {
    Key = "BPExpireRemindMail",
    CnID = "常量@BP到期前奖励提醒邮件",
    Data = {18021}
  },
  BPBuyLevelPrice = {
    Key = "BPBuyLevelPrice",
    CnID = "常量@购买BP等级价格",
    Data = {9567, 150}
  },
  BPBuyMaxLevelOnce = {
    Key = "BPBuyMaxLevelOnce",
    CnID = "常量@一次购买BP最大等级数",
    Data = {20}
  },
  ExtraBPLvAward = {
    Key = "ExtraBPLvAward",
    CnID = "常量@BP额外等级奖励",
    Data = {25136}
  },
  BPWeaponBoxId = {
    Key = "BPWeaponBoxId",
    CnID = "常量@任选武器宝箱道具ID",
    Data = {9926}
  },
  BPBaseRewardTotal = {
    Key = "BPBaseRewardTotal",
    CnID = "常量@标准BP奖励汇总",
    Data = {
      9926,
      1,
      9567,
      2500,
      9802,
      12,
      9543,
      3,
      9522,
      300,
      9966,
      390,
      9803,
      6,
      10108,
      4680000
    }
  },
  BPSeniorRewardTotal = {
    Key = "BPSeniorRewardTotal",
    CnID = "常量@高级BP奖励汇总",
    Data = {
      22717,
      1,
      9803,
      10,
      35816,
      1,
      36018,
      1
    }
  },
  SeniorBPBuyReward = {
    Key = "SeniorBPBuyReward",
    CnID = "常量@课题进阶立即获得",
    Data = {9567, 680}
  },
  SeniorBPUpgradeReward = {
    Key = "SeniorBPUpgradeReward",
    CnID = "常量@高级课题升级核心课题赠送银芯",
    Data = {9567, 780}
  },
  DoubleExSeniorBPUpgradeReward = {
    Key = "DoubleExSeniorBPUpgradeReward",
    CnID = "常量@双倍周期高级课题升级核心课题赠送银芯",
    Data = {9567, 390}
  },
  BPExpItemTid = {
    Key = "BPExpItemTid",
    CnID = "常量@BP经验Tid",
    Data = {9607}
  },
  BPPriceList = {
    Key = "BPPriceList",
    CnID = "常量@BP购买价格列表",
    Data = {
      9536,
      680,
      1280,
      1460,
      780
    }
  },
  DoubleExBPPriceList = {
    Key = "DoubleExBPPriceList",
    CnID = "常量@双倍周期BP购买价格列表",
    Data = {
      9536,
      680,
      980,
      1070,
      390
    }
  },
  BPSeniorExtraRewardList = {
    Key = "BPSeniorExtraRewardList",
    CnID = "常量@高级BP额外奖励列表",
    Data = {
      9607,
      10000,
      9803,
      10,
      35816,
      1,
      36018,
      1
    }
  },
  BaseBPState = {
    Key = "BaseBPState",
    CnID = "常量@默认每期是否已购买标准BP",
    Data = {0}
  },
  AwakerSkillListNum = {
    Key = "AwakerSkillListNum",
    CnID = "常量@唤醒体初始技能数量",
    Data = {6}
  },
  AudioCardCreated = {
    Key = "AudioCardCreated",
    CnID = "常量@特殊卡牌生成调用音频",
    Data = {
      {
        1,
        "SFX_REALM_B_EMBRYO_GEN"
      }
    }
  },
  ReplenishEnergyItem = {
    Key = "ReplenishEnergyItem",
    CnID = "常量@体力补充界面显示道具1",
    Data = {9803, 9567}
  },
  ReplenishEnergyItemRestoreNum = {
    Key = "ReplenishEnergyItemRestoreNum",
    CnID = "常量@体力道具回复的灵啡肽数量_客户端展示用_实际走掉落_",
    Data = {120}
  },
  TaskAppointFeature = {
    Key = "TaskAppointFeature",
    CnID = "常量@任务委派功能",
    Data = {35}
  },
  SkillUpgradeRequiredBreakthroughLevelCondition = {
    Key = "SkillUpgradeRequiredBreakthroughLevelCondition",
    CnID = "常量@技能升级所需的突破等阶条件",
    Data = {
      0,
      0,
      0,
      0,
      0
    }
  },
  SSRAwakerSkillBreakThroughFirstMaterialQuantity = {
    Key = "SSRAwakerSkillBreakThroughFirstMaterialQuantity",
    CnID = "常量@SSR唤醒体技能突破第一个材料数量",
    Data = {
      0,
      0,
      0,
      0,
      0,
      0
    }
  },
  SSRAwakerSkillBreakThroughSecondMaterialQuantity = {
    Key = "SSRAwakerSkillBreakThroughSecondMaterialQuantity",
    CnID = "常量@SSR唤醒体技能突破第二个材料数量",
    Data = {
      0,
      0,
      0,
      0,
      0,
      0
    }
  },
  SSRAwakerSkillBreakThroughThirdMaterialQuantity = {
    Key = "SSRAwakerSkillBreakThroughThirdMaterialQuantity",
    CnID = "常量@SSR唤醒体技能突破第三个材料数量",
    Data = {
      0,
      0,
      0,
      0,
      0,
      0
    }
  },
  SSRAwakerSkillBreakThroughFourthMaterialQuantity = {
    Key = "SSRAwakerSkillBreakThroughFourthMaterialQuantity",
    CnID = "常量@SSR唤醒体技能突破第四个材料数量",
    Data = {
      0,
      2,
      0,
      3,
      0,
      0
    }
  },
  SRAwakerSkillBreakThroughFirstMaterialQuantity = {
    Key = "SRAwakerSkillBreakThroughFirstMaterialQuantity",
    CnID = "常量@SR唤醒体技能突破第一个材料数量",
    Data = {
      0,
      0,
      0,
      0,
      0,
      0
    }
  },
  SRAwakerSkillBreakThroughSecondMaterialQuantity = {
    Key = "SRAwakerSkillBreakThroughSecondMaterialQuantity",
    CnID = "常量@SR唤醒体技能突破第二个材料数量",
    Data = {
      0,
      0,
      0,
      0,
      0,
      0
    }
  },
  SRAwakerSkillBreakThroughThirdMaterialQuantity = {
    Key = "SRAwakerSkillBreakThroughThirdMaterialQuantity",
    CnID = "常量@SR唤醒体技能突破第三个材料数量",
    Data = {
      0,
      0,
      0,
      0,
      0,
      0
    }
  },
  SRAwakerSkillBreakThroughFourthMaterialQuantity = {
    Key = "SRAwakerSkillBreakThroughFourthMaterialQuantity",
    CnID = "常量@SR唤醒体技能突破第四个材料数量",
    Data = {
      0,
      1,
      0,
      2,
      0,
      0
    }
  },
  SSRAwakerSkillBreakThroughRequiredGoldCoins = {
    Key = "SSRAwakerSkillBreakThroughRequiredGoldCoins",
    CnID = "常量@SSR唤醒体技能突破所需金币",
    Data = {
      0,
      1800,
      0,
      21600,
      0,
      0
    }
  },
  SRAwakerSkillBreakThroughRequiredGoldCoins = {
    Key = "SRAwakerSkillBreakThroughRequiredGoldCoins",
    CnID = "常量@SR唤醒体技能突破所需金币",
    Data = {
      0,
      1200,
      0,
      14400,
      0,
      0
    }
  },
  AgeTipsIcon_8 = {
    Key = "AgeTipsIcon_8",
    CnID = "常量@适龄图标_8岁",
    Data = {
      "UIResources/AtlasSource/UI_Login_Image/UI_Login_Icon_Age_8.png"
    }
  },
  AgeTipsIcon_12 = {
    Key = "AgeTipsIcon_12",
    CnID = "常量@适龄图标_12岁",
    Data = {
      "UIResources/AtlasSource/UI_Login_Image/UI_Login_Icon_Age_12.png"
    }
  },
  AgeTipsIcon_16 = {
    Key = "AgeTipsIcon_16",
    CnID = "常量@适龄图标_16岁",
    Data = {
      "UIResources/AtlasSource/UI_Login_Image/UI_Login_Icon_Age_16.png"
    }
  },
  MonsterHpFormula = {
    Key = "MonsterHpFormula",
    CnID = "常量@怪物生命公式",
    Data = {
      "StandardHp*MonsterHpPercent*MonsterProportion - MonsterDefPercent*StandardDef*0.5/10*StandardTurn"
    }
  },
  MonsterAtkFormula = {
    Key = "MonsterAtkFormula",
    CnID = "常量@怪物攻击公式",
    Data = {
      "StandardAtk*MonsterAtkPercent*MonsterProportion"
    }
  },
  MonsterDefFormula = {
    Key = "MonsterDefFormula",
    CnID = "常量@怪物防御公式",
    Data = {
      "math.floor(StandardDef/10)"
    }
  },
  MonsterLvFormula = {
    Key = "MonsterLvFormula",
    CnID = "常量@怪物等级公式",
    Data = {
      "StandardLevel"
    }
  },
  RelicGroupCollation = {
    Key = "RelicGroupCollation",
    CnID = "常量@造物分组品质优先级",
    Data = {
      "White",
      "Orange",
      "Red"
    }
  },
  EnchantGroupCollation = {
    Key = "EnchantGroupCollation",
    CnID = "常量@刻印分组品质优先级",
    Data = {
      "White",
      "Orange",
      "Red"
    }
  },
  MonsterTypeImage_Elite = {
    Key = "MonsterTypeImage_Elite",
    CnID = "常量@精英怪物类型图片",
    Data = {
      "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Image_Text_leader2.png"
    }
  },
  MonsterTypeImage_Boss = {
    Key = "MonsterTypeImage_Boss",
    CnID = "常量@首领怪物类型图片",
    Data = {
      "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Image_Text_leader1.png"
    }
  },
  School_None_Icon = {
    Key = "School_None_Icon",
    CnID = "常量@未激活的界域图标",
    Data = {
      "Icon/Career/Icon_Career2_Null.png"
    }
  },
  RecommendedSchoolBonus = {
    Key = "RecommendedSchoolBonus",
    CnID = "常量@推荐界域属性加成",
    Data = {25}
  },
  DoubleOutputActivityRewardExtraMultiple = {
    Key = "DoubleOutputActivityRewardExtraMultiple",
    CnID = "常量@双倍产出活动常规奖励额外倍数",
    Data = {1}
  },
  DoubleOutputActivityRewardItem = {
    Key = "DoubleOutputActivityRewardItem",
    CnID = "常量@双倍产出活动可以额外获得的道具列表",
    Data = {
      10108,
      10064,
      9834,
      9762,
      10030,
      9758,
      9971,
      9755,
      9740,
      9925,
      10044,
      9904,
      9768,
      9940,
      9793,
      9799,
      9825,
      9621,
      9769,
      9771,
      10117,
      9812,
      9549,
      9601,
      9671,
      9726,
      10013,
      9756
    }
  },
  EvaluationTiming = {
    Key = "EvaluationTiming",
    CnID = "常量@通关指定关卡后弹出好评弹窗",
    Data = {7755}
  },
  HeadLaMengNa = {
    Key = "HeadLaMengNa",
    CnID = "常量@特殊头像_拉蒙娜",
    Data = {
      "MUnit/MUnit_02/Role/MUnit_Role_002/Texture/MScene_LaMengNa_Role.png"
    }
  },
  HeadZhanJin = {
    Key = "HeadZhanJin",
    CnID = "常量@特殊头像_詹金",
    Data = {
      "MUnit/MUnit_02/Role/MUnit_Role_002/Texture/MScene_ZhanJin_Role.png"
    }
  },
  HeadBrown = {
    Key = "HeadBrown",
    CnID = "常量@特殊头像_布朗",
    Data = {
      "MUnit/MUnit_02/Role/MUnit_Role_002/Texture/MScene_002_Role.png"
    }
  },
  HeadPlayer = {
    Key = "HeadPlayer",
    CnID = "常量@特殊头像_玩家"
  },
  BattleOcean_Development_Damage = {
    Key = "BattleOcean_Development_Damage",
    CnID = "常量@深海触腕成长公式",
    Data = {
      "TeamAtk*GetTeamSkillMultiplier()*0.2*0.2"
    }
  },
  BattleDamage_Overflow_Target = {
    Key = "BattleDamage_Overflow_Target",
    CnID = "常量@战斗伤害溢出段数重新选择使用目标范围",
    Data = {
      "MinUEAwaker",
      "MaxUEAwaker",
      "RandomAwaker",
      "FrontEnemy",
      "FrontAlly",
      "MinHpEnemy",
      "MinHpAlly",
      "MaxHpEnemy",
      "MaxHpAlly",
      "UpperTarget"
    }
  },
  ItemTipsNum = {
    Key = "ItemTipsNum",
    CnID = "常量@需要在道具tips中显示剩余数量的道具",
    Data = {"TopBarItem", "Material"}
  },
  Batltle_Constant_Cost = {
    Key = "Batltle_Constant_Cost",
    CnID = "常量@初始算力上限",
    Data = {5}
  },
  Batltle_Constant_GetCard = {
    Key = "Batltle_Constant_GetCard",
    CnID = "常量@初始抽牌数",
    Data = {5}
  },
  Wolrd_Not_ClientMsg_Time = {
    Key = "Wolrd_Not_ClientMsg_Time",
    CnID = "常量@副本超时时间",
    Data = {86400}
  },
  WeeklyBossStageRewardCount = {
    Key = "WeeklyBossStageRewardCount",
    CnID = "常量@周常BOSS本每周奖励次数",
    Data = {1}
  },
  PlayerLevelStageGroup = {
    Key = "PlayerLevelStageGroup",
    CnID = "常量@支持玩家等级解锁的关卡组编号",
    Data = {
      2,
      3,
      10,
      23
    }
  },
  AchieveTabSort = {
    Key = "AchieveTabSort",
    CnID = "常量@成就页签排序",
    Data = {
      "AchieveType0",
      "AchieveType2",
      "AchieveType1",
      "AchieveType3",
      "AchieveType4"
    }
  },
  MonsterTime = {
    Key = "MonsterTime",
    CnID = "常量@怪物超维量表描述",
    Data = {
      "当超维空间填满时，地狱犬的意图变为【维度闭锁】并将玩家吞噬进超维空间。 在维度闭锁的回合，你的卡牌会被替换为超维空间的那些牌，并封印所有的狂气爆发。"
    }
  },
  StageTrinketSuitEffect = {
    Key = "StageTrinketSuitEffect",
    CnID = "常量@关卡战斗资料卡中密契效果读取字段名",
    Data = {
      "SuitEffectParam_6"
    }
  },
  DefaultMascotGirl = {
    Key = "DefaultMascotGirl",
    CnID = "常量@默认看板娘",
    Data = {15595}
  },
  StrikeBackStateType = {
    Key = "StrikeBackStateType",
    CnID = "常量@反击状态类型",
    Data = {
      3905,
      3023,
      3255
    }
  },
  ShopRefreshLimit = {
    Key = "ShopRefreshLimit",
    CnID = "常量@商店刷新次数",
    Data = {7}
  },
  ShopRefreshCost = {
    Key = "ShopRefreshCost",
    CnID = "常量@商店刷新消耗",
    Data = {
      1,
      2,
      4,
      8,
      16,
      32,
      64
    }
  },
  DailyChallengeStageGroupID = {
    Key = "DailyChallengeStageGroupID",
    CnID = "常量@日常挑战关卡组",
    Data = {15933}
  },
  Card_CommonMinihead = {
    Key = "Card_CommonMinihead",
    CnID = "常量@非唤醒体卡牌在超维空间通用头像",
    Data = {
      "Portraits/Minihead/Portrait_Minihead_Card_State_03.png"
    }
  },
  EffectType_StoneEffect = {
    Key = "EffectType_StoneEffect",
    CnID = "常量@石化效果",
    Data = {
      1,
      "Stone",
      3.2
    }
  },
  EffectType_VajraBody = {
    Key = "EffectType_VajraBody",
    CnID = "常量@金身效果",
    Data = {
      0,
      "VajraBody",
      2
    }
  },
  EffectType_IgnoreDamage = {
    Key = "EffectType_IgnoreDamage",
    CnID = "常量@蓝身效果",
    Data = {
      0,
      "IgnoreDamage",
      2
    }
  },
  EffectType_GrayBody = {
    Key = "EffectType_GrayBody",
    CnID = "常量@灰身效果",
    Data = {
      0,
      "GrayBody",
      2
    }
  },
  EffectType_StoneEffect_SpecialMatTemple = {
    Key = "EffectType_StoneEffect_SpecialMatTemple",
    CnID = "常量@石化特殊怪材质模板记录",
    Data = {
      "BUnit_Monster_B0006_AT",
      "BUnit_Petrifaction_Materia_B0006_AT",
      "BUnit_Monster_B0006_BT",
      "BUnit_Petrifaction_Materia_B0006_BT",
      "BUnit_Monster_B0006_BT_Crown",
      "BUnit_Petrifaction_Materia_B0006_BT_Crown",
      "BUnit_Monster_B0007",
      "BUnit_Petrifaction_Materia_B0007",
      "BUnit_Monster_B0008",
      "BUnit_Petrifaction_Materia_B0008",
      "BUnit_Monster_B0008_Front",
      "BUnit_Petrifaction_Materia_B0008",
      "BUnit_Monster_B0008_Back",
      "BUnit_Petrifaction_Materia_B0008",
      "BUnit_Monster_B0008_Ring",
      "BUnit_Petrifaction_Materia_B0008",
      "Monster_S2B0001_arm",
      "BUnit_Petrifaction_Materia_S2B0001_arm",
      "BUnit_Monster_S2B0001",
      "BUnit_Petrifaction_Materia_S2B0001",
      "BUnit_Monster_S2B0002",
      "BUnit_Petrifaction_Material_S2B0002",
      "Monster_S2B0002_AT_Star",
      "BUnit_Petrifaction_Material_S2B0002_AT_Star",
      "Monster_S2B0002_BT",
      "BUnit_Petrifaction_Material_S2B0002_BT",
      "Monster_S2B0002_BT_Star",
      "BUnit_Petrifaction_Material_S2B0002_BT_Star",
      "BUnit_Monster_S2B0003",
      "BUnit_Petrifaction_Material_S2B0003",
      "BUnit_Monster_S2B0004",
      "BUnit_Petrifaction_Materia_S2B0004",
      "BUnit_Monster_S2B0004_fender",
      "BUnit_Petrifaction_Materia_S2B0004_fender",
      "BUnit_Monster_S2B0004_Iron",
      "BUnit_Petrifaction_Materia_S2B0004_Iron",
      "BUnit_Monster_S2B0004_lock",
      "BUnit_Petrifaction_Materia_S2B0004_lock",
      "BUnit_Monster_S2B0004_previous_Iron",
      "BUnit_Petrifaction_Materia_S2B0004_previous_Iron",
      "BUnit_Monster_S2B0004_yarn",
      "BUnit_Petrifaction_Materia_S2B0004_yarn"
    }
  },
  EffectType_VajraBody_SpecialMatTemple = {
    Key = "EffectType_VajraBody_SpecialMatTemple",
    CnID = "常量@金身特殊怪材质模板记录",
    Data = {
      "BUnit_Monster_B0006_AT",
      "BUnit_GoldenBody_Material_B0006_AT",
      "BUnit_Monster_B0006_BT",
      "BUnit_GoldenBody_Material_B0006_BT",
      "BUnit_Monster_B0006_BT_Crown",
      "BUnit_GoldenBody_Material_B0006_BT_Crown",
      "BUnit_Monster_B0007",
      "BUnit_GoldenBody_Material_B0007",
      "BUnit_Monster_B0008",
      "BUnit_GoldenBody_Material_B0008",
      "BUnit_Monster_B0008_Front",
      "BUnit_GoldenBody_Material_B0008",
      "BUnit_Monster_B0008_Back",
      "BUnit_GoldenBody_Material_B0008",
      "BUnit_Monster_B0008_Ring",
      "BUnit_GoldenBody_Material_B0008",
      "Monster_S2B0001_arm",
      "BUnit_GoldenBody_Materia_S2B0001_arm",
      "BUnit_Monster_S2B0001",
      "BUnit_GoldenBody_Materia_S2B0001",
      "BUnit_Monster_S2B0004",
      "BUnit_GoldenBody_Materia_S2B0004",
      "BUnit_Monster_S2B0004_fender",
      "BUnit_GoldenBody_Materia_S2B0004_fender",
      "BUnit_Monster_S2B0004_Iron",
      "BUnit_GoldenBody_Materia_S2B0004_Iron",
      "BUnit_Monster_S2B0004_lock",
      "BUnit_GoldenBody_Materia_S2B0004_lock",
      "BUnit_Monster_S2B0004_previous_Iron",
      "BUnit_GoldenBody_Materia_S2B0004_previous_Iron",
      "BUnit_Monster_S2B0004_yarn",
      "BUnit_GoldenBody_Materia_S2B0004_yarn"
    }
  },
  NameChangeIntervalTime = {
    Key = "NameChangeIntervalTime",
    CnID = "常量@改名间隔时间单位秒",
    Data = {86400}
  },
  SweepTicketItemID = {
    Key = "SweepTicketItemID",
    CnID = "常量@扫荡券道具编号",
    Data = {10108}
  },
  SweepLimit = {
    Key = "SweepLimit",
    CnID = "常量@批量扫荡次数上限",
    Data = {50}
  },
  MaxTentacle = {
    Key = "MaxTentacle",
    CnID = "常量@触腕硬上限数量",
    Data = {99}
  },
  ShareBtnStates = {
    Key = "ShareBtnStates",
    CnID = "常量@分享按钮显示",
    Data = {"Orange"}
  },
  ShareLine = {
    Key = "ShareLine",
    CnID = "常量@分享到line",
    Data = {
      "ShareLineText"
    }
  },
  ShareFacebook = {
    Key = "ShareFacebook",
    CnID = "常量@分享到Facebook",
    Data = {
      "ShareFacebookText"
    }
  },
  ShareReward = {
    Key = "ShareReward",
    CnID = "常量@分享奖励银芯数量",
    Data = {9567, 200}
  },
  OriginLang = {
    Key = "OriginLang",
    CnID = "常量@开发语言",
    Data = {"CN"}
  },
  MaximumQuantityLimitForDecomposition = {
    Key = "MaximumQuantityLimitForDecomposition",
    CnID = "常量@批量分解选择材料的数量上限",
    Data = {100}
  },
  MutidamageDelay = {
    Key = "MutidamageDelay",
    CnID = "常量@多次伤害间隔",
    Data = {0.15}
  },
  ExchangeCostItemLimitNum = {
    Key = "ExchangeCostItemLimitNum",
    CnID = "常量@置换消耗道具上限",
    Data = {200}
  },
  MonthCardTid = {
    Key = "MonthCardTid",
    CnID = "常量@月卡商品Tid",
    Data = {18362}
  },
  MapNodeChaosPic = {
    Key = "MapNodeChaosPic",
    CnID = "常量@混沌节点图标",
    Data = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_27a.png",
      "MUnit/Common/Texture/TextureNew/MUnit_Event_27.png",
      "MUnit/Common/Texture/TextureNew/MUnit_Event_27.png"
    }
  },
  MapNodePoison = {
    Key = "MapNodePoison",
    CnID = "常量@毒气节点扣除生命",
    Data = {5}
  },
  MapNodeBorn = {
    Key = "MapNodeBorn",
    CnID = "常量@地图出生节点",
    Data = {11741}
  },
  MapNodeScanEffect = {
    Key = "MapNodeScanEffect",
    CnID = "常量@监视区域效果",
    Data = {
      "Effects/Effect_Scene/E_SE_ScanFloor.prefab"
    }
  },
  LotteryIntervalTime = {
    Key = "LotteryIntervalTime",
    CnID = "常量@抽奖间隔时间",
    Data = {0.5}
  },
  TutorialRewards = {
    Key = "TutorialRewards",
    CnID = "常量@教程奖励",
    Data = {9567, 2}
  },
  LowMiddleIOSMachineScore = {
    Key = "LowMiddleIOSMachineScore",
    CnID = "常量@IOS低中配机性能评分分隔值",
    Data = {708}
  },
  MiddleHighIOSMachineScore = {
    Key = "MiddleHighIOSMachineScore",
    CnID = "常量@IOS中高配机性能评分分隔值",
    Data = {1291}
  },
  FollowersNumberLimit = {
    Key = "FollowersNumberLimit",
    CnID = "常量@关注人数限制",
    Data = {1000}
  },
  FanListLimit = {
    Key = "FanListLimit",
    CnID = "常量@粉丝列表",
    Data = {1200}
  },
  FanGrowthListLimit = {
    Key = "FanGrowthListLimit",
    CnID = "常量@粉丝新增列表",
    Data = {1000}
  },
  VisitorListLimit = {
    Key = "VisitorListLimit",
    CnID = "常量@访客列表上限",
    Data = {1000}
  },
  SocializeAdmireListLimit = {
    Key = "SocializeAdmireListLimit",
    CnID = "常量@点赞列表限制",
    Data = {1000}
  },
  BlacklistNumLimit = {
    Key = "BlacklistNumLimit",
    CnID = "常量@黑名单人数上限",
    Data = {100}
  },
  RecommendListRefreshInterval = {
    Key = "RecommendListRefreshInterval",
    CnID = "常量@推荐列表刷新间隔",
    Data = {3}
  },
  SocializeAdmireNumber = {
    Key = "SocializeAdmireNumber",
    CnID = "常量@每日点赞次数限制",
    Data = {1}
  },
  SocializeAllowAwakerSupportLevelType = {
    Key = "SocializeAllowAwakerSupportLevelType",
    CnID = "常量@允许助战的关卡类型",
    Data = {
      2,
      3,
      9,
      10,
      21,
      22,
      23,
      24,
      25,
      26,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      36,
      37,
      38,
      39,
      40,
      41,
      42,
      43,
      44,
      45,
      46,
      47,
      48,
      49,
      50,
      51,
      52,
      53,
      54,
      55,
      56,
      57,
      58,
      59,
      60,
      61,
      62,
      63,
      64,
      100,
      111,
      113,
      114,
      201
    }
  },
  SpecialAssistStageGroupType = {
    Key = "SpecialAssistStageGroupType",
    CnID = "常量@特殊助战的关卡类型",
    Data = {
      100,
      111,
      113,
      114
    }
  },
  SpecialAssistBanStrangerStageGroupType = {
    Key = "SpecialAssistBanStrangerStageGroupType",
    CnID = "常量@禁用陌生人助战的关卡类型",
    Data = {
      100,
      111,
      113
    }
  },
  AwakerUseTimesLimitByStageGroupType = {
    Key = "AwakerUseTimesLimitByStageGroupType",
    CnID = "常量@限制唤醒体出战次数的关卡组类型",
    Data = {103, 113}
  },
  WeaponUseTimesLimitByStageGroupType = {
    Key = "WeaponUseTimesLimitByStageGroupType",
    CnID = "常量@限制命轮出战次数的关卡组类型",
    Data = {113}
  },
  KeyTokenUseTimesLimitByStageGroupType = {
    Key = "KeyTokenUseTimesLimitByStageGroupType",
    CnID = "常量@限制钥令出战次数的关卡组类型",
    Data = {113}
  },
  WorldBeatTimesAddupByStageGroupType = {
    Key = "WorldBeatTimesAddupByStageGroupType",
    CnID = "常量@统计全服击杀次数的关卡组类型",
    Data = {103}
  },
  SkipBattleStageGroupType = {
    Key = "SkipBattleStageGroupType",
    CnID = "常量@允许选择跳过普通战斗的关卡类型"
  },
  SkipBattleEvent = {
    Key = "SkipBattleEvent",
    CnID = "常量@跳过普通战斗的关卡事件",
    Data = {55819}
  },
  SkipBattleEliteEvent = {
    Key = "SkipBattleEliteEvent",
    CnID = "常量@跳过精英战斗的关卡事件",
    Data = {70892}
  },
  AwakerAssistFollowersNumber = {
    Key = "AwakerAssistFollowersNumber",
    CnID = "常量@助战功能推荐的关注人数",
    Data = {12}
  },
  FollowedAssistNumber = {
    Key = "FollowedAssistNumber",
    CnID = "常量@关注的好友的助战数",
    Data = {45}
  },
  RequireentPlayerLevel = {
    Key = "RequireentPlayerLevel",
    CnID = "常量@突破等级对应的玩家等级",
    Data = {
      0,
      10,
      20,
      30,
      40,
      50
    }
  },
  AwakerBreakThroughLevel = {
    Key = "AwakerBreakThroughLevel",
    CnID = "常量@突破等级",
    Data = {
      0,
      1,
      2,
      3,
      4,
      5
    }
  },
  MaxAwakerLevel = {
    Key = "MaxAwakerLevel",
    CnID = "常量@突破等级对应的唤醒体等级上限",
    Data = {
      10,
      20,
      30,
      40,
      50,
      60
    }
  },
  StrangerAwakerAssistBreakThroughLevelAdjust = {
    Key = "StrangerAwakerAssistBreakThroughLevelAdjust",
    CnID = "常量@陌生人助战唤醒体突破调整值",
    Data = {1}
  },
  StrangerHighLevelNumber = {
    Key = "StrangerHighLevelNumber",
    CnID = "常量@陌生人高等级人数调整值",
    Data = {1}
  },
  AwakerAssistRefreshInterval = {
    Key = "AwakerAssistRefreshInterval",
    CnID = "常量@唤醒体助战列表刷新间隔",
    Data = {1}
  },
  DailyAwakerAssistRewardCount = {
    Key = "DailyAwakerAssistRewardCount",
    CnID = "常量@每日唤醒体助战奖励次数",
    Data = {20}
  },
  AwakerAssistReward = {
    Key = "AwakerAssistReward",
    CnID = "常量@唤醒体助战奖励",
    Data = {10108, 1000}
  },
  AwakerAssistLevelLimit = {
    Key = "AwakerAssistLevelLimit",
    CnID = "常量@陌生人助战唤醒体等级最高不超过守密人等级加X",
    Data = {10}
  },
  AwakerAssistLevelLowerLimit = {
    Key = "AwakerAssistLevelLowerLimit",
    CnID = "常量@陌生人助战唤醒体等级最低不低于守密人等级加X",
    Data = {0}
  },
  AssistRewardQuantityCap = {
    Key = "AssistRewardQuantityCap",
    CnID = "常量@唤醒体助战奖励次数上限",
    Data = {50}
  },
  AwakerAssistNumber = {
    Key = "AwakerAssistNumber",
    CnID = "常量@助战列表人数上限",
    Data = {100}
  },
  StrangerNumber = {
    Key = "StrangerNumber",
    CnID = "常量@添加好友页签中陌生人个数",
    Data = {20}
  },
  AwakerAssistRecent = {
    Key = "AwakerAssistRecent",
    CnID = "常量@显示最近助战的个数",
    Data = {10}
  },
  AwakerAssistRecentShowTime = {
    Key = "AwakerAssistRecentShowTime",
    CnID = "常量@最近助战标签最大存续时间",
    Data = {168}
  },
  AwakerAssistRefreshStrangersProportion = {
    Key = "AwakerAssistRefreshStrangersProportion",
    CnID = "常量@助战列表刷新的陌生人比例",
    Data = {25}
  },
  AwakerAssistRefresh = {
    Key = "AwakerAssistRefresh",
    CnID = "常量@助战列表刷新提示条件",
    Data = {80}
  },
  DefaultKeeperSkill = {
    Key = "DefaultKeeperSkill",
    CnID = "常量@默认选择主角技能",
    Data = {10052}
  },
  BoutKeeperSkillTimes = {
    Key = "BoutKeeperSkillTimes",
    CnID = "常量@主角技能每回合可释放次数",
    Data = {1}
  },
  DefaultPVPBattle = {
    Key = "DefaultPVPBattle",
    CnID = "常量@默认PVP战斗",
    Data = {8635}
  },
  MonsterSizeMiniState = {
    Key = "MonsterSizeMiniState",
    CnID = "常量@改变小体型状态",
    Data = {77947}
  },
  MonsterSizeMiddleState = {
    Key = "MonsterSizeMiddleState",
    CnID = "常量@改变中体型状态",
    Data = {77949}
  },
  MonsterSizeBigState = {
    Key = "MonsterSizeBigState",
    CnID = "常量@改变大体型状态",
    Data = {77948}
  },
  MonsterSizeHugeState = {
    Key = "MonsterSizeHugeState",
    CnID = "常量@改变超大体型状态",
    Data = {77950}
  },
  MiniDieParams = {
    Key = "MiniDieParams",
    CnID = "常量@小体型死亡溶解参数",
    Data = {
      -1,
      1.6,
      1.5
    }
  },
  MiddleDieParams = {
    Key = "MiddleDieParams",
    CnID = "常量@中体型死亡溶解参数",
    Data = {
      -2.3,
      1.6,
      1.5
    }
  },
  BigDieParams = {
    Key = "BigDieParams",
    CnID = "常量@大体型死亡溶解参数",
    Data = {
      -4.9,
      1.6,
      1.5
    }
  },
  HugeDieParams = {
    Key = "HugeDieParams",
    CnID = "常量@超大大体型死亡溶解参数",
    Data = {1, 2}
  },
  AwakerDieParams = {
    Key = "AwakerDieParams",
    CnID = "常量@唤醒体死亡溶解参数",
    Data = {
      -1.3,
      1.6,
      1.5
    }
  },
  SpecialDieDimensionCut = {
    Key = "SpecialDieDimensionCut",
    CnID = "常量@次元斩死亡",
    Data = {
      133481,
      1.3,
      17,
      1.2,
      0.6,
      0.3,
      6,
      1.9
    }
  },
  MiniStoneParams = {
    Key = "MiniStoneParams",
    CnID = "常量@小体型石化溶解参数",
    Data = {
      -0.6,
      1.8,
      1.5
    }
  },
  MiddleStoneParams = {
    Key = "MiddleStoneParams",
    CnID = "常量@中体型石化溶解参数",
    Data = {
      -0.6,
      3.1,
      1.5
    }
  },
  BigStoneParams = {
    Key = "BigStoneParams",
    CnID = "常量@大体型石化溶解参数",
    Data = {
      -0.6,
      5.6,
      1.5
    }
  },
  HugeStoneParams = {
    Key = "HugeStoneParams",
    CnID = "常量@超大大体型石化溶解参数",
    Data = {1, 2}
  },
  AwakerStoneParams = {
    Key = "AwakerStoneParams",
    CnID = "常量@唤醒体石化溶解参数",
    Data = {
      -0.6,
      2.4,
      1.5
    }
  },
  EnergyMonthlyCardLastDays = {
    Key = "EnergyMonthlyCardLastDays",
    CnID = "常量@体力月卡购买持续时间",
    Data = {30}
  },
  EnergyMonthlyCardBuyLimit = {
    Key = "EnergyMonthlyCardBuyLimit",
    CnID = "常量@体力月卡购买剩余天数限制",
    Data = {180}
  },
  EnergyMonthlyCardPrice = {
    Key = "EnergyMonthlyCardPrice",
    CnID = "常量@体力月卡价格",
    Data = {9536, 680}
  },
  EnergyMonthlyCardReward = {
    Key = "EnergyMonthlyCardReward",
    CnID = "常量@体力月卡购买奖励",
    Data = {9567, 680}
  },
  EnergyMonthlyCardDailyReward = {
    Key = "EnergyMonthlyCardDailyReward",
    CnID = "常量@体力月卡每日奖励展示",
    Data = {
      9578,
      300,
      9522,
      30
    }
  },
  EnergyMonthlyCardMail_1 = {
    Key = "EnergyMonthlyCardMail_1",
    CnID = "常量@体力月卡领取邮件一",
    Data = {18035}
  },
  EnergyMonthlyCardMail_2 = {
    Key = "EnergyMonthlyCardMail_2",
    CnID = "常量@体力月卡领取邮件二",
    Data = {18031}
  },
  EnergyMonthlyCardDisplayConditions = {
    Key = "EnergyMonthlyCardDisplayConditions",
    CnID = "常量@体力月卡显示条件",
    Data = {10}
  },
  SocializeBlurbLengthLimit = {
    Key = "SocializeBlurbLengthLimit",
    CnID = "常量@简介字符长度限制",
    Data = {140}
  },
  BattleEnchantOtherCmd = {
    Key = "BattleEnchantOtherCmd",
    CnID = "常量@战斗放弃刻印生效指令",
    Data = {2170}
  },
  EnergyMonthlyCardDropItemId = {
    Key = "EnergyMonthlyCardDropItemId",
    CnID = "常量@体力月卡掉落包ID",
    Data = {9975}
  },
  BattleEnchantOtherString = {
    Key = "BattleEnchantOtherString",
    CnID = "常量@战斗放弃刻印描述",
    Data = {
      "生命上限 +{s1}"
    }
  },
  BattleEnchantOtherStringArg = {
    Key = "BattleEnchantOtherStringArg",
    CnID = "常量@战斗放弃刻印描述参数",
    Data = {
      "math.ceil(PlayerRole.GetStateLayer(2644)*PlayerRole.max_hp*0.01)"
    }
  },
  StoreCurseRemains = {
    Key = "StoreCurseRemains",
    CnID = "常量@商店诅咒造物掉落包",
    Data = {14314}
  },
  CardTypePrice = {
    Key = "CardTypePrice",
    CnID = "常量@卡牌类型售卖价格",
    Data = {
      "Card_Skill",
      50,
      "Card_Strike",
      30,
      "Card_Defend",
      30,
      "Card_Curse",
      "0+PlayerRole.GetStateLayer(2935)",
      "Card_State",
      0
    }
  },
  BattleAwakenEffect = {
    Key = "BattleAwakenEffect",
    CnID = "常量@战斗觉醒特效",
    Data = {14570, 14569}
  },
  MainWeaponSlotUnlockBreakthroughLevel = {
    Key = "MainWeaponSlotUnlockBreakthroughLevel",
    CnID = "常量@主命轮槽位解锁所需突破等阶",
    Data = {0}
  },
  SecondaryWeaponSlotUnlockBreakthroughLevel = {
    Key = "SecondaryWeaponSlotUnlockBreakthroughLevel",
    CnID = "常量@副命轮槽位解锁所需突破等阶",
    Data = {0}
  },
  SSRWeaponNumLimit = {
    Key = "SSRWeaponNumLimit",
    CnID = "常量@唤醒体最多装备SSR命轮个数",
    Data = {1}
  },
  UnLockExtraSSRWeaponLv = {
    Key = "UnLockExtraSSRWeaponLv",
    CnID = "常量@唤醒体装备SSR叠位达到N可装备额外1个SSR命轮",
    Data = {15}
  },
  PVPVictoryReward = {
    Key = "PVPVictoryReward",
    CnID = "常量@PVP胜利奖励",
    Data = {
      10108,
      400,
      10056,
      20
    }
  },
  PVPFailedReward = {
    Key = "PVPFailedReward",
    CnID = "常量@PVP失败奖励",
    Data = {10108, 0}
  },
  PVPFightStyleReward = {
    Key = "PVPFightStyleReward",
    CnID = "常量@PVP战斗风格奖励",
    Data = {
      10108,
      800,
      9556,
      180,
      10056,
      30
    }
  },
  PVPFightStyleScore1 = {
    Key = "PVPFightStyleScore1",
    CnID = "常量@PVP战斗风格1",
    Data = {0.5, 3}
  },
  PVPFightStyleScore2 = {
    Key = "PVPFightStyleScore2",
    CnID = "常量@PVP战斗风格2",
    Data = {2, 8}
  },
  PVPFightStyleScore3 = {
    Key = "PVPFightStyleScore3",
    CnID = "常量@PVP战斗风格3",
    Data = {0.2, 5}
  },
  PVPFightStyleScoreLimt = {
    Key = "PVPFightStyleScoreLimt",
    CnID = "常量@PVP战斗风格积分上限",
    Data = {10}
  },
  PVPDifficultGameAward = {
    Key = "PVPDifficultGameAward",
    CnID = "常量@PVP迎难而上奖励",
    Data = {
      10108,
      200,
      9556,
      20
    }
  },
  GoldShopCurrencies = {
    Key = "GoldShopCurrencies",
    CnID = "常量@金币商店页面货币栏",
    Data = {
      10108,
      9536,
      9567
    }
  },
  GoldShop = {
    Key = "GoldShop",
    CnID = "常量@金币商店",
    Data = {18659}
  },
  RelicKeyMapNodeType = {
    Key = "RelicKeyMapNodeType",
    CnID = "常量@洞悉之眼节点类型",
    Data = {12}
  },
  RelicMaximumNumber = {
    Key = "RelicMaximumNumber",
    CnID = "常量@造物数量上限",
    Data = {8}
  },
  StageCompletenessWeight = {
    Key = "StageCompletenessWeight",
    CnID = "常量@关卡完成度计算权重",
    Data = {
      450,
      50,
      100,
      50
    }
  },
  HardStageCompletenessWeight = {
    Key = "HardStageCompletenessWeight",
    CnID = "常量@困难以上关卡完成度计算权重",
    Data = {
      450,
      0,
      100,
      50
    }
  },
  WeaponRefineSkillParaNum = {
    Key = "WeaponRefineSkillParaNum",
    CnID = "常量@命轮提升技能系数的叠位数",
    Data = {3}
  },
  WeaponRefineAttrNum = {
    Key = "WeaponRefineAttrNum",
    CnID = "常量@命轮提升属性的叠位数",
    Data = {12}
  },
  WeaponRefineAttrRatio = {
    Key = "WeaponRefineAttrRatio",
    CnID = "常量@命轮后12阶精炼每阶提升的属性与主属性的比例的倒数",
    Data = {12}
  },
  InitLanguageCode_CN = {
    Key = "InitLanguageCode_CN",
    CnID = "常量@中国大陆地区初始语言代码",
    Data = {"CN"}
  },
  InitLanguageCode_HKTW = {
    Key = "InitLanguageCode_HKTW",
    CnID = "常量@中国港台地区初始语言代码",
    Data = {"TW"}
  },
  InitLanguageCode_TWZA = {
    Key = "InitLanguageCode_TWZA",
    CnID = "常量@中国台湾资安初始语言代码",
    Data = {"TW"}
  },
  PlatformCode_CN_release = {
    Key = "PlatformCode_CN_release",
    CnID = "常量@大陆地区保底游戏平台代码_发布版本",
    Data = {"P11103"}
  },
  PlatformCode_CN_debug = {
    Key = "PlatformCode_CN_debug",
    CnID = "常量@大陆地区保底游戏平台代码_开发版本",
    Data = {"P11104"}
  },
  PlatformCode_HKTW_release = {
    Key = "PlatformCode_HKTW_release",
    CnID = "常量@港澳台新马地区保底游戏平台代码_发布版本",
    Data = {"P11222"}
  },
  PlatformCode_HKTW_debug = {
    Key = "PlatformCode_HKTW_debug",
    CnID = "常量@港澳台新马地区保底游戏平台代码_开发版本",
    Data = {"P11221"}
  },
  PlatformCode_TWZA_release = {
    Key = "PlatformCode_TWZA_release",
    CnID = "常量@台湾资安地区保底游戏平台代码_发布版本",
    Data = {"P11223"}
  },
  DebugConfigFile = {
    Key = "DebugConfigFile",
    CnID = "常量@调试文件路径",
    Data = {
      "Z1DebugConfigFile.json"
    }
  },
  DebugConfigField_IsDebugMode = {
    Key = "DebugConfigField_IsDebugMode",
    CnID = "常量@调试文件字段_是否开启调试模式",
    Data = {"IsDebug"}
  },
  DebugConfigField_PlatformCode = {
    Key = "DebugConfigField_PlatformCode",
    CnID = "常量@调试文件字段_游戏平台代码",
    Data = {
      "PlatformCode"
    }
  },
  DebugConfigField_SpecificServerId = {
    Key = "DebugConfigField_SpecificServerId",
    CnID = "常量@调试文件字段_指定游戏服务器id",
    Data = {
      "specific_server_id"
    }
  },
  ShowInBuffID = {
    Key = "ShowInBuffID",
    CnID = "常量@显示图标的BUFFID",
    Data = {
      3068,
      2840,
      3255
    }
  },
  InitialTeam = {
    Key = "InitialTeam",
    CnID = "常量@PVP初始阵容",
    Data = {
      18266,
      18265,
      18218,
      18284,
      18253,
      18212,
      18330,
      18207,
      18293,
      18269
    }
  },
  PVPLoadingDisplayTime = {
    Key = "PVPLoadingDisplayTime",
    CnID = "常量@PVP加载界面显示时间",
    Data = {3}
  },
  PVPSettlementMail = {
    Key = "PVPSettlementMail",
    CnID = "常量@PVP结算邮件",
    Data = {20231}
  },
  AIScoreFloatingRange = {
    Key = "AIScoreFloatingRange",
    CnID = "常量@AI积分浮动范围",
    Data = {-50, 0}
  },
  MatchingRemoveDuplicatesRange = {
    Key = "MatchingRemoveDuplicatesRange",
    CnID = "常量@匹配去重范围",
    Data = {1}
  },
  CardiacFlowRegulator = {
    Key = "CardiacFlowRegulator",
    CnID = "常量@心流调节",
    Data = {
      -200,
      -150,
      -100,
      -50,
      0,
      50,
      100,
      150,
      200
    }
  },
  NoviceAIData = {
    Key = "NoviceAIData",
    CnID = "常量@萌新匹配数据",
    Data = {
      {18608, 5},
      {18606, 8},
      {18607, 12},
      {18604, 15},
      {18605, 18},
      {97239, 21},
      {97238, 21},
      {97237, 21},
      {97241, 21},
      {97240, 21}
    }
  },
  WarmAIWaitingTime = {
    Key = "WarmAIWaitingTime",
    CnID = "常量@温暖AI匹配时长",
    Data = {
      4,
      4,
      5,
      5,
      6,
      6,
      7,
      7,
      7,
      8,
      8,
      8,
      8,
      9,
      9,
      9,
      10,
      10,
      11,
      11
    }
  },
  WarmAILineupGroup = {
    Key = "WarmAILineupGroup",
    CnID = "常量@温暖AI阵容组",
    Data = {
      "TimeoutAILineup"
    }
  },
  TimeoutAILineupGroup = {
    Key = "TimeoutAILineupGroup",
    CnID = "常量@超时AI阵容组",
    Data = {
      "TimeoutAILineup"
    }
  },
  PVPGenesisDirective = {
    Key = "PVPGenesisDirective",
    CnID = "常量@PVP战斗创世指令",
    Data = {
      142902,
      140488,
      19280,
      19216,
      19278,
      19215,
      19259,
      19299,
      79213,
      22705,
      23697,
      45370,
      91814,
      94409
    }
  },
  PVPPlaybackSpeed = {
    Key = "PVPPlaybackSpeed",
    CnID = "常量@PVP表现播放倍率",
    Data = {1.5}
  },
  PVPUltiSkillPlaybackSpeed = {
    Key = "PVPUltiSkillPlaybackSpeed",
    CnID = "常量@PVP狂气爆发表现播放倍率",
    Data = {1}
  },
  PVPSeasonBonusAsk = {
    Key = "PVPSeasonBonusAsk",
    CnID = "常量@赛季加成要求",
    Data = {21864}
  },
  PVPScoreInit = {
    Key = "PVPScoreInit",
    CnID = "常量@PVP初始积分",
    Data = {0}
  },
  PVPSeasonScoreReduce = {
    Key = "PVPSeasonScoreReduce",
    CnID = "常量@PVP赛季重置积分减少比例",
    Data = {3000, 0.5}
  },
  PVPGetScoreParas = {
    Key = "PVPGetScoreParas",
    CnID = "常量@PVP结算获得积分基础值参数",
    Data = {1000, 0.05}
  },
  PVPScoreLimitParas = {
    Key = "PVPScoreLimitParas",
    CnID = "常量@PVP积分上限",
    Data = {20000}
  },
  PVPScoreDisparityParas = {
    Key = "PVPScoreDisparityParas",
    CnID = "常量@PVP双方积分差距修正系数参数",
    Data = {1000}
  },
  PVPLowScoreProtectParas = {
    Key = "PVPLowScoreProtectParas",
    CnID = "常量@PVP低分段保护系数参数",
    Data = {0, 1500}
  },
  MatchingSystemCycleInterval = {
    Key = "MatchingSystemCycleInterval",
    CnID = "常量@匹配系统循环间隔",
    Data = {1}
  },
  MaxAIScore = {
    Key = "MaxAIScore",
    CnID = "常量@最大AI积分",
    Data = {1000}
  },
  MaxMatchingScore = {
    Key = "MaxMatchingScore",
    CnID = "常量@最大匹配分",
    Data = {10000}
  },
  MinMatchingScore = {
    Key = "MinMatchingScore",
    CnID = "常量@最小匹配分",
    Data = {250}
  },
  PVPWarmAIconditionScores = {
    Key = "PVPWarmAIconditionScores",
    CnID = "常量@PVP温暖局败场数积分",
    Data = {
      0,
      1000,
      1500,
      99999
    }
  },
  PVPWarmAIconditionValues = {
    Key = "PVPWarmAIconditionValues",
    CnID = "常量@PVP温暖局败场数数值",
    Data = {
      1,
      2,
      99999
    }
  },
  PVPMatchingCycleIndexs = {
    Key = "PVPMatchingCycleIndexs",
    CnID = "常量@PVP匹配周期序号",
    Data = {
      1,
      4,
      8,
      15,
      23,
      30,
      38,
      45,
      53,
      60,
      68,
      75,
      83
    }
  },
  PVPMatchingRangeValues = {
    Key = "PVPMatchingRangeValues",
    CnID = "常量@PVP匹配范围数值",
    Data = {
      0,
      75,
      125,
      250,
      375,
      500,
      625,
      750,
      1500,
      3000,
      5000,
      7000,
      10000
    }
  },
  PVPMatchingCycleIndexsAndRange = {
    Key = "PVPMatchingCycleIndexsAndRange",
    CnID = "常量@PVP匹配周期与范围",
    Data = {
      {0, 0.05},
      {1, 0.1},
      {2, 0.15},
      {3, 0.2},
      {4, 0.25},
      {5, 0.29},
      {10, 0.34},
      {15, 0.4},
      {20, 0.47},
      {25, 0.55},
      {30, 0.65},
      {35, 0.77},
      {40, 0.91},
      {45, 1.07},
      {50, 1.26},
      {55, 1.48},
      {60, 1.74},
      {65, 2.05},
      {70, 2.41},
      {75, 2.84},
      {80, 3.34},
      {85, 3.93},
      {90, 4.63},
      {95, 5.45},
      {100, 6.42},
      {105, 7.56},
      {110, 8.9},
      {115, 10.48},
      {120, 12.34},
      {125, 14.53},
      {130, 17.11},
      {135, 20.14},
      {140, 23.71},
      {145, 27.91},
      {150, 32.86},
      {155, 38.68},
      {160, 45.54},
      {165, 53.61},
      {170, 63.11},
      {175, 74.29},
      {180, 87.46}
    }
  },
  PVPTimeoutAIMatchingTime = {
    Key = "PVPTimeoutAIMatchingTime",
    CnID = "常量@PVP超时匹配时间",
    Data = {
      {
        0,
        1000,
        180
      },
      {
        1000,
        99999,
        180
      }
    }
  },
  PVPRankBaseNum = {
    Key = "PVPRankBaseNum",
    CnID = "常量@PVP排行保底人数",
    Data = {100}
  },
  PVPCardMaxRank = {
    Key = "PVPCardMaxRank",
    CnID = "常量@PVP单卡排行最大排名",
    Data = {5000}
  },
  PVPDailyWarmAI = {
    Key = "PVPDailyWarmAI",
    CnID = "常量@PVP每日温暖局",
    Data = {1500, 1}
  },
  WeaponRefineAttrSSR = {
    Key = "WeaponRefineAttrSSR",
    CnID = "常量@SSR命轮叠位每级提升属性份数",
    Data = {3}
  },
  WeaponRefineAttrSR = {
    Key = "WeaponRefineAttrSR",
    CnID = "常量@SR命轮叠位每级提升属性份数",
    Data = {1.5}
  },
  WeaponRefineAttrR = {
    Key = "WeaponRefineAttrR",
    CnID = "常量@R命轮叠位每级提升属性份数",
    Data = {1}
  },
  PVPShieldValueDisplayState = {
    Key = "PVPShieldValueDisplayState",
    CnID = "常量@PVP护盾数值显示状态",
    Data = {19552}
  },
  PVPShieldHit = {
    Key = "PVPShieldHit",
    CnID = "常量@PVP护盾受击特效",
    Data = {19939}
  },
  PVPShieldBreak = {
    Key = "PVPShieldBreak",
    CnID = "常量@PVP护盾击破特效",
    Data = {19856}
  },
  PVPMinerReadyVFX = {
    Key = "PVPMinerReadyVFX",
    CnID = "常量@己方施法准备特效",
    Data = {19813}
  },
  PVPEnemyReadyVFX = {
    Key = "PVPEnemyReadyVFX",
    CnID = "常量@敌方施法准备特效",
    Data = {19891}
  },
  PVPTurnTime = {
    Key = "PVPTurnTime",
    CnID = "常量@PVP回合时间",
    Data = {
      30,
      45,
      60,
      75
    }
  },
  PVPTurnCountdown = {
    Key = "PVPTurnCountdown",
    CnID = "常量@PVP回合倒计时",
    Data = {20}
  },
  PrologueFirstBattle = {
    Key = "PrologueFirstBattle",
    CnID = "常量@序章第一场战斗",
    Data = {8322}
  },
  FarCameraScenes = {
    Key = "FarCameraScenes",
    CnID = "常量@远距离摄像机战斗场景",
    Data = {44185}
  },
  DeadModeBout = {
    Key = "DeadModeBout",
    CnID = "常量@PVP死斗开始回合",
    Data = {8}
  },
  PVPProcrastinateBout = {
    Key = "PVPProcrastinateBout",
    CnID = "常量@PVP不出牌且倒计时结束的判负回合数",
    Data = {1}
  },
  TrinketRefineMaterialReplace = {
    Key = "TrinketRefineMaterialReplace",
    CnID = "常量@密契洗炼材料不足时可以用其他货币替代",
    Data = {
      9567,
      10,
      9619,
      1
    }
  },
  Death_resist_coefficient = {
    Key = "Death_resist_coefficient",
    CnID = "常量@死亡抵抗衰减系数",
    Data = {0.5}
  },
  BindPhoneEmailReward = {
    Key = "BindPhoneEmailReward",
    CnID = "常量@绑定手机或邮箱后获得奖励",
    Data = {9567, 200}
  },
  PVPandDailyChallengeRewardLimit = {
    Key = "PVPandDailyChallengeRewardLimit",
    CnID = "常量@幻梦深潜和相位对弈对战胜利每日获得玩家经验上限",
    Data = {9556, 0}
  },
  PVPNewSeasonStart = {
    Key = "PVPNewSeasonStart",
    CnID = "常量@PVP新旧赛季分割线",
    Data = {16669}
  },
  PVPBattleConfigList = {
    Key = "PVPBattleConfigList",
    CnID = "常量@PVP战斗配置",
    Data = {
      22040,
      22039,
      22038,
      22043,
      22042,
      22041
    }
  },
  RotationTimeInterval = {
    Key = "RotationTimeInterval",
    CnID = "常量@跑马灯轮播时间间隔",
    Data = {180}
  },
  PVPAIDiscardInterval = {
    Key = "PVPAIDiscardInterval",
    CnID = "常量@PVPAI出牌间隔",
    Data = {1.8}
  },
  PVPSkillShowInterval = {
    Key = "PVPSkillShowInterval",
    CnID = "常量@PVP客户端技能展示间隔",
    Data = {1}
  },
  LoginScreenPV = {
    Key = "LoginScreenPV",
    CnID = "常量@登录视频播放",
    Data = {22135}
  },
  PVPMatchingDisconnectTime = {
    Key = "PVPMatchingDisconnectTime",
    CnID = "常量@PVP匹配掉线踢出时长",
    Data = {7}
  },
  PVPEnterBattleWaitTime = {
    Key = "PVPEnterBattleWaitTime",
    CnID = "常量@PVP进入战斗等待时长",
    Data = {7}
  },
  PVPBattleTimeLimit = {
    Key = "PVPBattleTimeLimit",
    CnID = "常量@PVP战斗时间限制",
    Data = {1800}
  },
  ReviveTextShowDelay = {
    Key = "ReviveTextShowDelay",
    CnID = "常量@应急灵知体文本延迟",
    Data = {0.53}
  },
  RepeatedChallengeAllowSkipPlot = {
    Key = "RepeatedChallengeAllowSkipPlot",
    CnID = "常量@允许重复挑战选择跳过剧情的关卡组编号",
    Data = {
      1,
      11,
      14
    }
  },
  DailyChallengeSpecialScore = {
    Key = "DailyChallengeSpecialScore",
    CnID = "常量@日常挑战特殊评分任务",
    Data = {22}
  },
  DefaultSupportAwaker = {
    Key = "DefaultSupportAwaker",
    CnID = "常量@默认助战角色",
    Data = {15595}
  },
  DailyChallengeHighestScore = {
    Key = "DailyChallengeHighestScore",
    CnID = "常量@幻梦深潜最高评分",
    Data = {
      50,
      100,
      150,
      200,
      250,
      300,
      350,
      400,
      450,
      500,
      550,
      600,
      650,
      700,
      750,
      800,
      850,
      900,
      950,
      1000,
      1050,
      1100,
      1150,
      1200,
      1250,
      1300,
      1350,
      1400,
      1450,
      1500,
      1600,
      1700,
      1800,
      1900,
      2000,
      2100,
      2200,
      2300,
      2400,
      2500,
      2600,
      2700,
      2800,
      2900,
      3000
    }
  },
  DailyChallengeHighestScoreReward = {
    Key = "DailyChallengeHighestScoreReward",
    CnID = "常量@幻梦深潜最高评分奖励",
    Data = {
      {9542, 250},
      {
        9567,
        100,
        9542,
        250
      },
      {
        9567,
        100,
        9542,
        250
      },
      {
        9567,
        100,
        9542,
        250
      },
      {
        9567,
        100,
        9542,
        250
      },
      {
        9567,
        100,
        9966,
        15,
        9542,
        250
      },
      {
        9567,
        100,
        9966,
        15,
        9542,
        250
      },
      {
        9567,
        100,
        9966,
        15,
        9542,
        250
      },
      {
        9567,
        100,
        9966,
        15,
        9542,
        250
      },
      {
        9567,
        100,
        9966,
        15,
        9542,
        250
      },
      {
        9567,
        100,
        9966,
        15,
        9542,
        250
      },
      {
        9567,
        100,
        9966,
        15,
        9542,
        250
      },
      {
        9567,
        100,
        9966,
        15,
        9542,
        250
      },
      {
        9543,
        1,
        9567,
        100,
        9542,
        250
      },
      {
        9567,
        100,
        9966,
        15,
        9542,
        250
      },
      {
        9543,
        1,
        9567,
        100,
        9542,
        250
      },
      {
        9567,
        100,
        9966,
        15,
        9542,
        250
      },
      {
        9543,
        1,
        9567,
        100,
        9542,
        250
      },
      {
        9567,
        100,
        9966,
        15,
        9542,
        250
      },
      {
        9543,
        1,
        9567,
        200,
        9966,
        15,
        9542,
        250
      },
      {
        9567,
        100,
        9966,
        30,
        9542,
        500
      },
      {
        9567,
        100,
        9966,
        30,
        9542,
        500
      },
      {
        9567,
        100,
        9966,
        30,
        9542,
        500
      },
      {
        9543,
        1,
        9567,
        100,
        9542,
        500
      },
      {
        9567,
        100,
        9966,
        30,
        9542,
        500
      },
      {
        9567,
        100,
        9966,
        30,
        9542,
        500
      },
      {
        9567,
        100,
        9966,
        30,
        9542,
        500
      },
      {
        9543,
        1,
        9567,
        100,
        9542,
        500
      },
      {
        9567,
        100,
        9966,
        30,
        9542,
        500
      },
      {
        9543,
        1,
        9567,
        200,
        9966,
        30,
        9542,
        500
      },
      {
        9567,
        150,
        9522,
        20,
        9542,
        1000
      },
      {
        9567,
        150,
        9522,
        20,
        9542,
        1000
      },
      {
        9567,
        150,
        9522,
        20,
        9542,
        1000
      },
      {
        9567,
        150,
        9522,
        20,
        9542,
        1000
      },
      {
        9567,
        300,
        9522,
        20,
        9542,
        1000
      },
      {
        9567,
        150,
        9522,
        20,
        9542,
        1000
      },
      {
        9567,
        150,
        9522,
        20,
        9542,
        1000
      },
      {
        9567,
        150,
        9522,
        20,
        9542,
        1000
      },
      {
        9567,
        150,
        9522,
        20,
        9542,
        1000
      },
      {
        9567,
        300,
        9522,
        20,
        9542,
        1000
      },
      {
        9567,
        150,
        9522,
        20,
        9542,
        1000
      },
      {
        9567,
        150,
        9522,
        20,
        9542,
        1000
      },
      {
        9567,
        150,
        9522,
        20,
        9542,
        1000
      },
      {
        9567,
        150,
        9522,
        20,
        9542,
        1000
      },
      {
        9567,
        300,
        9522,
        20,
        9542,
        1000
      }
    }
  },
  DailyChallengeExperienceRewardItem = {
    Key = "DailyChallengeExperienceRewardItem",
    CnID = "常量@幻梦深潜经验值奖励统计道具",
    Data = {118305}
  },
  DailyChallengeAccumulatedExperience = {
    Key = "DailyChallengeAccumulatedExperience",
    CnID = "常量@幻梦深潜累计经验值",
    Data = {
      50,
      100,
      150,
      200,
      250,
      300,
      350,
      400,
      450,
      500,
      550,
      600,
      650,
      700,
      750,
      800,
      850,
      900,
      950,
      1000,
      1050,
      1100,
      1150,
      1200,
      1250,
      1300,
      1350,
      1400,
      1450,
      1500,
      1600,
      1700,
      1800,
      1900,
      2000,
      2100,
      2200,
      2300,
      2400,
      2500,
      2600,
      2700,
      2800,
      2900,
      3000,
      3100,
      3200,
      3300,
      3400,
      3500,
      3600,
      3700,
      3800,
      3900,
      4000,
      4100,
      4200,
      4300,
      4400,
      4500,
      4600,
      4700,
      4800,
      4900,
      5000,
      5100,
      5200,
      5300,
      5400,
      5500,
      5600,
      5700,
      5800,
      5900,
      6000,
      6100,
      6200,
      6300,
      6400,
      6500,
      6600,
      6700,
      6800,
      6900,
      7000,
      7100,
      7200,
      7300,
      7400,
      7500,
      7600,
      7700,
      7800,
      7900,
      8000,
      8100,
      8200,
      8300,
      8400,
      8500,
      8600,
      8700,
      8800,
      8900,
      9000,
      9100,
      9200,
      9300,
      9400,
      9500,
      9600,
      9700,
      9800,
      9900,
      10000,
      10100,
      10200,
      10300,
      10400,
      10500,
      10600,
      10700,
      10800,
      10900,
      11000,
      11100,
      11200,
      11300,
      11400,
      11500,
      11600,
      11700,
      11800,
      11900,
      12000,
      12100,
      12200,
      12300,
      12400,
      12500,
      12600,
      12700,
      12800,
      12900,
      13000,
      13100,
      13200,
      13300,
      13400,
      13500,
      13600,
      13700,
      13800,
      13900,
      14000,
      14100,
      14200,
      14300,
      14400,
      14500,
      14600,
      14700,
      14800,
      14900,
      15000,
      15100,
      15200,
      15300,
      15400,
      15500,
      15600,
      15700,
      15800,
      15900,
      16000,
      16100,
      16200,
      16300,
      16400,
      16500,
      16600,
      16700,
      16800,
      16900,
      17000,
      17100,
      17200,
      17300,
      17400,
      17500,
      17600,
      17700,
      17800,
      17900,
      18000,
      18100,
      18200,
      18300,
      18400,
      18500,
      18600,
      18700,
      18800,
      18900,
      19000,
      19100,
      19200,
      19300,
      19400,
      19500,
      19600,
      19700,
      19800,
      19900,
      20000
    }
  },
  DailyChallengeAccumulatedExperienceReward = {
    Key = "DailyChallengeAccumulatedExperienceReward",
    CnID = "常量@幻梦深潜累计经验值奖励",
    Data = {
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {9567, 25},
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      },
      {
        9567,
        50,
        10108,
        100000
      }
    }
  },
  PVPandDailyChallengeExpItem = {
    Key = "PVPandDailyChallengeExpItem",
    CnID = "常量@深潜PVP经验预览道具编号",
    Data = {23731}
  },
  DiscountCareerList = {
    Key = "DiscountCareerList",
    CnID = "常量@优惠界域轮换",
    Data = {
      3,
      1,
      4,
      2
    }
  },
  SummonDiscountExtraAward = {
    Key = "SummonDiscountExtraAward",
    CnID = "常量@每日优惠唤醒额外赠送",
    Data = {9567, 60}
  },
  MaxBoutWaitTime = {
    Key = "MaxBoutWaitTime",
    CnID = "常量@战斗结束等待飘字时间",
    Data = {1.3}
  },
  AbyssChallengeScore = {
    Key = "AbyssChallengeScore",
    CnID = "常量@深渊分数",
    Data = {
      50,
      100,
      150,
      225,
      300,
      305,
      310,
      315,
      320,
      325,
      330,
      335,
      340,
      345,
      350,
      355,
      360,
      365,
      370,
      375,
      380,
      385,
      390,
      395,
      400
    }
  },
  AbyssChallengeScoreReward = {
    Key = "AbyssChallengeScoreReward",
    CnID = "常量@深渊分数奖励",
    Data = {
      {
        9567,
        100,
        20481,
        500
      },
      {
        9567,
        100,
        20481,
        500
      },
      {
        9567,
        100,
        20481,
        500
      },
      {
        9567,
        100,
        20481,
        500
      },
      {
        9567,
        250,
        20481,
        2500,
        25218,
        1
      },
      {
        9567,
        100,
        20481,
        500,
        25219,
        3
      },
      {
        9567,
        100,
        20481,
        500,
        25219,
        3
      },
      {
        9567,
        100,
        20481,
        500,
        25219,
        3
      },
      {
        9567,
        100,
        20481,
        500,
        25219,
        3
      },
      {
        9567,
        100,
        20481,
        500,
        25219,
        3
      },
      {
        20481,
        500,
        69986,
        3,
        10108,
        100000
      },
      {
        20481,
        500,
        69986,
        3,
        10108,
        100000
      },
      {
        20481,
        500,
        69986,
        3,
        10108,
        100000
      },
      {
        20481,
        500,
        69986,
        3,
        10108,
        100000
      },
      {
        20481,
        500,
        69986,
        3,
        10108,
        100000
      },
      {
        20481,
        500,
        25219,
        2,
        67377,
        5,
        10108,
        100000
      },
      {
        20481,
        500,
        25219,
        2,
        67377,
        5,
        10108,
        100000
      },
      {
        20481,
        500,
        25219,
        2,
        67377,
        5,
        10108,
        100000
      },
      {
        20481,
        500,
        25219,
        2,
        67377,
        5,
        10108,
        100000
      },
      {
        20481,
        500,
        25219,
        2,
        67377,
        5,
        10108,
        100000
      },
      {
        69986,
        2,
        67377,
        5,
        10108,
        100000
      },
      {
        69986,
        2,
        67377,
        5,
        10108,
        100000
      },
      {
        69986,
        2,
        67377,
        5,
        10108,
        100000
      },
      {
        69986,
        2,
        67377,
        5,
        10108,
        100000
      },
      {
        69986,
        2,
        67377,
        5,
        10108,
        100000
      }
    }
  },
  AbyssChallengeV260Ts = {
    Key = "AbyssChallengeV260Ts",
    CnID = "常量@V260融灾禁区难度重构切换时间",
    Data = 1788138000
  },
  AbyssChallengeScoreV260 = {
    Key = "AbyssChallengeScoreV260",
    CnID = "常量@V260融灾禁区新分数",
    Data = {
      50,
      100,
      150,
      250,
      350,
      360,
      370,
      380,
      390,
      400,
      410,
      420,
      430,
      440,
      450,
      460,
      470,
      480,
      490,
      500
    }
  },
  AbyssChallengeScoreRewardV260 = {
    Key = "AbyssChallengeScoreRewardV260",
    CnID = "常量@V260融灾禁区新积分奖励",
    Data = {
      {
        25219,
        10,
        9567,
        250,
        20481,
        1500
      },
      {
        25219,
        10,
        9567,
        250,
        20481,
        1500
      },
      {
        25219,
        10,
        9567,
        250,
        20481,
        1500
      },
      {
        25219,
        10,
        9567,
        250,
        20481,
        1500
      },
      {
        25219,
        10,
        9567,
        250,
        20481,
        1500
      },
      {
        69986,
        5,
        20481,
        1500,
        67377,
        10,
        10108,
        300000
      },
      {
        69986,
        5,
        20481,
        1500,
        67377,
        10,
        10108,
        300000
      },
      {
        69986,
        5,
        20481,
        1500,
        67377,
        10,
        10108,
        300000
      },
      {
        69986,
        5,
        20481,
        1500,
        67377,
        10,
        10108,
        300000
      },
      {
        69986,
        5,
        20481,
        1500,
        67377,
        10,
        10108,
        300000
      },
      {
        69986,
        5,
        9567,
        250
      },
      {
        69986,
        5,
        9567,
        250
      },
      {
        69986,
        5,
        9567,
        250
      },
      {
        69986,
        5,
        9567,
        250
      },
      {
        69986,
        5,
        9567,
        250
      },
      {67378, 1},
      {67378, 1},
      {67378, 1},
      {67378, 1},
      {67378, 1}
    }
  },
  AbyssChallengeAwakerSupportTimes = {
    Key = "AbyssChallengeAwakerSupportTimes",
    CnID = "常量@深渊助战次数限制",
    Data = {1}
  },
  AbyssChallengePicture = {
    Key = "AbyssChallengePicture",
    CnID = "常量@融灾禁区主界面背景图资源",
    Data = {
      "UIResources/UIBigImages/UI_Large/UI_Large_Dungeous_Bg/UI_Large_Dungeons_Bg_Big06.png"
    }
  },
  AbyssChallengeScoreFixSeason27 = {
    Key = "AbyssChallengeScoreFixSeason27",
    CnID = "常量@融灾禁区27期积分修正",
    Data = {
      71930,
      70,
      71932,
      75,
      71931,
      80,
      71929,
      85,
      71928,
      90
    }
  },
  BacktrackTimeInterval = {
    Key = "BacktrackTimeInterval",
    CnID = "常量@回溯开启时间区间",
    Data = {
      7,
      1739754000,
      1741568400
    }
  },
  BacktrackItemSend = {
    Key = "BacktrackItemSend",
    CnID = "常量@发送的回溯道具ID及其数量"
  },
  BacktrackItemAwakers = {
    Key = "BacktrackItemAwakers",
    CnID = "常量@回溯道具可选唤醒体",
    Data = {
      15565,
      15580,
      15560,
      15588,
      15571,
      15564,
      15575,
      15594,
      15592,
      15566,
      15587,
      15600,
      15598,
      15597,
      15577,
      15562,
      15574,
      15579,
      15593,
      15572
    }
  },
  BacktrackItemWeapons = {
    Key = "BacktrackItemWeapons",
    CnID = "常量@回溯道具可选命轮",
    Data = {
      9856,
      9589,
      9943,
      9689,
      9974,
      9827,
      9630,
      9529,
      9642,
      9530,
      9846,
      10025,
      9877,
      9998,
      9667,
      9623,
      9789,
      9947,
      9845,
      9736
    }
  },
  BacktrackFreeAwaker = {
    Key = "BacktrackFreeAwaker",
    CnID = "常量@上述时间区间内免费开启回溯的唤醒体"
  },
  BacktrackFreeWeapon = {
    Key = "BacktrackFreeWeapon",
    CnID = "常量@上述时间区间内免费开启回溯的命轮"
  },
  NoGiveBackAwakers = {
    Key = "NoGiveBackAwakers",
    CnID = "常量@无法进行黑池归还的唤醒体列表",
    Data = {
      15595,
      15568,
      15585,
      15569,
      15570,
      15591,
      15573,
      15603
    }
  },
  NeedSourceRecordItems = {
    Key = "NeedSourceRecordItems",
    CnID = "常量@需要记录来源的道具",
    Data = {
      9794,
      9921,
      9902,
      10024,
      9826,
      10114,
      9901,
      10038,
      9673,
      9765,
      10063,
      9954,
      10034,
      10047,
      9538,
      9686,
      9801,
      9938,
      10039,
      9880,
      9732,
      9713,
      9777,
      9847,
      9878,
      9766,
      9557,
      9863,
      9712,
      9967,
      9540,
      9814,
      9595,
      9614,
      9647,
      9727,
      9958,
      9750,
      10088,
      54109,
      54112,
      54110,
      54108,
      77890,
      77870,
      77887,
      95690,
      77885,
      77865,
      9981,
      77897,
      125187,
      130765,
      77894,
      130224,
      141229,
      77872,
      94445,
      147229,
      130364,
      78758,
      77868,
      77903,
      94441,
      77858,
      77874,
      77901
    }
  },
  NeedInheritConsumeItems = {
    Key = "NeedInheritConsumeItems",
    CnID = "常量@需要继承消耗数量的道具",
    Data = {9791}
  },
  SSRAwakerSelectItem = {
    Key = "SSRAwakerSelectItem",
    CnID = "常量@任选唤醒体道具",
    Data = {34706}
  },
  SSRWeaponSelectItem = {
    Key = "SSRWeaponSelectItem",
    CnID = "常量@任选命轮道具",
    Data = {34699}
  },
  SSRAwakerChipSelectItem = {
    Key = "SSRAwakerChipSelectItem",
    CnID = "常量@SSR角色残片任选道具",
    Data = {9597}
  },
  SSRWeaponCommonMat = {
    Key = "SSRWeaponCommonMat",
    CnID = "常量@SSR命轮通用叠位材料",
    Data = {9791}
  },
  AwakerBackTrackExtraItem = {
    Key = "AwakerBackTrackExtraItem",
    CnID = "常量@唤醒体回溯额外返还",
    Data = {
      10108,
      2000,
      9762,
      1
    }
  },
  OceanModel1 = {
    Key = "OceanModel1",
    CnID = "常量@深海触腕战斗姿态",
    Data = {25411}
  },
  OceanModel2 = {
    Key = "OceanModel2",
    CnID = "常量@深海触腕护卫姿态",
    Data = {25412}
  },
  OceanModel3 = {
    Key = "OceanModel3",
    CnID = "常量@深海触腕疯狂姿态",
    Data = {25413}
  },
  BirthdayMail = {
    Key = "BirthdayMail",
    CnID = "常量@生日祝福邮件编号",
    Data = {25414, 34667}
  },
  KeeperSkillScaleEnergy = {
    Key = "KeeperSkillScaleEnergy",
    CnID = "常量@钥令每刻度代表钥能",
    Data = {100}
  },
  UltiSkillScaleEnergy = {
    Key = "UltiSkillScaleEnergy",
    CnID = "常量@狂气爆发每刻度代表狂气",
    Data = {10}
  },
  ChallengeDefaultPicture = {
    Key = "ChallengeDefaultPicture",
    CnID = "常量@幕间演习默认背景图资源",
    Data = {
      "UIResources/UIBigImages/UI_Large/UI_Common_Image_Bg7.png"
    }
  },
  BloodHealCount = {
    Key = "BloodHealCount",
    CnID = "常量@血肉职业治疗计数状态",
    Data = {
      "PlayerRole.GetStateLayer(35501)"
    }
  },
  BloodHealCountMax = {
    Key = "BloodHealCountMax",
    CnID = "常量@血肉职业治疗计数最大值",
    Data = {
      "PlayerRole.max_hp*0.25"
    }
  },
  BloodHealSkill = {
    Key = "BloodHealSkill",
    CnID = "常量@血肉职业治疗释放技能",
    Data = {35502}
  },
  AwakerFavorabilityImprove = {
    Key = "AwakerFavorabilityImprove",
    CnID = "常量@使用助战时同调率奖励提升比例",
    Data = {0.5}
  },
  DailyChallengeRewardMail = {
    Key = "DailyChallengeRewardMail",
    CnID = "常量@幻梦深潜每日奖励邮件",
    Data = {36871}
  },
  DailyChallengeSkipConsume = {
    Key = "DailyChallengeSkipConsume",
    CnID = "常量@幻梦深潜逃课消耗",
    Data = {44809, 1}
  },
  EmptyTaskGroup = {
    Key = "EmptyTaskGroup",
    CnID = "常量@空任务组",
    Data = {21}
  },
  RankRewardChangeTime = {
    Key = "RankRewardChangeTime",
    CnID = "常量@幻梦深潜排行奖励改变时间",
    Data = {1709758800}
  },
  MaximumNumberOfKeysHeld = {
    Key = "MaximumNumberOfKeysHeld",
    CnID = "常量@道具持有上限",
    Data = {
      36863,
      10,
      44809,
      5
    }
  },
  KeysItemIndex = {
    Key = "KeysItemIndex",
    CnID = "常量@现实起点道具编号",
    Data = {36863}
  },
  MinimumLapseForReturn = {
    Key = "MinimumLapseForReturn",
    CnID = "常量@回归条件最小流失天数",
    Data = {14}
  },
  MinimumIntervalForReturn = {
    Key = "MinimumIntervalForReturn",
    CnID = "常量@回归条件最小间隔天数",
    Data = {28}
  },
  KeeperLevelForReturn = {
    Key = "KeeperLevelForReturn",
    CnID = "常量@回归条件守密人等级要求",
    Data = {10}
  },
  ReturnMessageRelatedActivity = {
    Key = "ReturnMessageRelatedActivity",
    CnID = "常量@回归通讯触发依赖的回归活动",
    Data = {53729}
  },
  MaximumNumberOfTrinketPlan = {
    Key = "MaximumNumberOfTrinketPlan",
    CnID = "常量@密契方案数量上限",
    Data = {50}
  },
  TrinketPlanNameLengthRange = {
    Key = "TrinketPlanNameLengthRange",
    CnID = "常量@密契方案名称字数范围",
    Data = {1, 16}
  },
  SpecialTeamAssignBlockView = {
    Key = "SpecialTeamAssignBlockView",
    CnID = "常量@特殊编队中不可查看详情的唤醒体",
    Data = {15578}
  },
  BossObject = {
    Key = "BossObject",
    CnID = "常量@需要显示首领目标的关卡组编号",
    Data = {
      23,
      24,
      25,
      26,
      28,
      29,
      34,
      38,
      39,
      40,
      41
    }
  },
  BloodHealStateId = {
    Key = "BloodHealStateId",
    CnID = "常量@血肉熔炉状态层数上限",
    Data = {35501}
  },
  DimensionSKill = {
    Key = "DimensionSKill",
    CnID = "常量@超维黑洞技能",
    Data = {55481}
  },
  WeaponLockDefault = {
    Key = "WeaponLockDefault",
    CnID = "常量@活动SR命轮",
    Data = {
      34858,
      41379,
      44832,
      45297,
      47520,
      47519,
      47521,
      53767,
      56641,
      56640,
      56639,
      56635,
      56642,
      56637,
      68682,
      68683,
      68689,
      78878,
      78871,
      95674,
      78885,
      78874,
      97317,
      94443,
      78884,
      125136,
      78877,
      130727,
      130039,
      141202,
      145277,
      78880,
      94447,
      147234,
      130468,
      68688,
      78872,
      78881,
      78873,
      78882,
      78879
    }
  },
  InitialAvatarFrame = {
    Key = "InitialAvatarFrame",
    CnID = "初始头像框道具",
    Data = {54582}
  },
  InitialEmoji = {
    Key = "InitialEmoji",
    CnID = "初始表情道具",
    Data = {
      46783,
      46782,
      46795,
      46792
    }
  },
  EmojiShowTime = {
    Key = "EmojiShowTime",
    CnID = "表情展示时长",
    Data = {5}
  },
  EmojiCoolTime = {
    Key = "EmojiCoolTime",
    CnID = "表情发送间隔",
    Data = {2}
  },
  EmojiNumLimit = {
    Key = "EmojiNumLimit",
    CnID = "表情使用数量上限",
    Data = {16}
  },
  ActivityBannerShowTime = {
    Key = "ActivityBannerShowTime",
    CnID = "活动Banner显示时长",
    Data = {5}
  },
  AbyssChallengeTutorialAvg = {
    Key = "AbyssChallengeTutorialAvg",
    CnID = "常量@融灾黑潮功能引导",
    Data = {46700}
  },
  PVPUltiSkillSfx = {
    Key = "PVPUltiSkillSfx",
    CnID = "常量@PVP狂气爆发通用特效",
    Data = {47099}
  },
  PVPUltiSkillSfxWaitingTime = {
    Key = "PVPUltiSkillSfxWaitingTime",
    CnID = "常量@PVP狂气爆发通用特效等待时间",
    Data = {0.6}
  },
  Awaker_EX_24_2 = {
    Key = "Awaker_EX_24_2",
    CnID = "常量@24特制第二形态立绘",
    Data = {
      48165,
      "UI/UI_Portrait/Portrait_Middle_Awaker_C06_AF_2.prefab"
    }
  },
  KeepSkillNotTrigger = {
    Key = "KeepSkillNotTrigger",
    CnID = "常量@不触发任何触发器的钥令",
    Data = {47996, 89949}
  },
  Awaker_EX_24_Voice = {
    Key = "Awaker_EX_24_Voice",
    CnID = "常量@24受击语音",
    Data = {
      47226,
      "DepressionHit",
      47227,
      "ManiaHit"
    }
  },
  ChaosSchool_RelicDrop = {
    Key = "ChaosSchool_RelicDrop",
    CnID = "常量@混沌界域初始造物掉落库",
    Data = {48159}
  },
  ChaosSchool_NotStage = {
    Key = "ChaosSchool_NotStage",
    CnID = "常量@混沌界域初始造物不生效关卡",
    Data = {
      7998,
      7688,
      48133,
      24184,
      46272,
      46265,
      46277,
      46278,
      46263,
      48846,
      54412,
      54414,
      54413,
      78001,
      122601,
      77994,
      90490
    }
  },
  ChaosSchool_LostLevel = {
    Key = "ChaosSchool_LostLevel",
    CnID = "常量@混沌界域初始造物最低生效守密人等级",
    Data = {45}
  },
  TeamNameCharacterLimit = {
    Key = "TeamNameCharacterLimit",
    CnID = "常量@编队命名字符数",
    Data = {20}
  },
  TeamUnlockCost_11To20 = {
    Key = "TeamUnlockCost_11To20",
    CnID = "常量@解锁编队11-20消耗",
    Data = {
      9615,
      50,
      9615,
      100,
      9615,
      150,
      9615,
      200,
      9615,
      250,
      9615,
      300,
      9615,
      350,
      9615,
      400,
      9615,
      450,
      9615,
      500
    }
  },
  ChaosSchoolEffectDeathResistNum = {
    Key = "ChaosSchoolEffectDeathResistNum",
    CnID = "常量@混沌界域死亡抵抗加成数值",
    Data = {100}
  },
  AwakerFavorItemTid = {
    Key = "AwakerFavorItemTid",
    CnID = "常量@唤醒体好感度道具Tid",
    Data = {10056}
  },
  FavorabilityScorePerCard = {
    Key = "FavorabilityScorePerCard",
    CnID = "常量@同调率计分_出牌系数",
    Data = {1}
  },
  FavorabilityScorePerCost = {
    Key = "FavorabilityScorePerCost",
    CnID = "常量@同调率计分_算力系数",
    Data = {1}
  },
  FavorabilityScorePerMadness = {
    Key = "FavorabilityScorePerMadness",
    CnID = "常量@同调率计分_狂气系数",
    Data = {0.1}
  },
  FavorabilityScorePerSilverKey = {
    Key = "FavorabilityScorePerSilverKey",
    CnID = "常量@同调率计分_银钥能量系数",
    Data = {0.005}
  },
  FavorabilityAutoBattleRatio = {
    Key = "FavorabilityAutoBattleRatio",
    CnID = "常量@同调率计分_自动战斗折算",
    Data = {0.333}
  },
  FavorabilityStageFactorBase = {
    Key = "FavorabilityStageFactorBase",
    CnID = "常量@同调率计分_关卡系数基础值",
    Data = {0.2}
  },
  FavorabilityStageFactorPerLv = {
    Key = "FavorabilityStageFactorPerLv",
    CnID = "常量@同调率计分_关卡系数等级成长",
    Data = {0.01}
  },
  Set_State_D_LV2 = {
    Key = "Set_State_D_LV2",
    CnID = "常量@BOSS战二阶段",
    Data = {51015}
  },
  Set_State_D_LV3 = {
    Key = "Set_State_D_LV3",
    CnID = "常量@BOSS战三阶段",
    Data = {51035}
  },
  Set_State_D_LV4 = {
    Key = "Set_State_D_LV4",
    CnID = "常量@BOSS战四阶段",
    Data = {60900}
  },
  Set_State_D_LV5 = {
    Key = "Set_State_D_LV5",
    CnID = "常量@BOSS战五阶段",
    Data = {81496}
  },
  ActivityStageExpirationRemind = {
    Key = "ActivityStageExpirationRemind",
    CnID = "常量@活动结束后的关卡提示"
  },
  ShowAwakerCgType = {
    Key = "ShowAwakerCgType",
    CnID = "常量@宿舍显示唤醒体背景类型",
    Data = {49308}
  },
  DefaultDormitoryBgTid = {
    Key = "DefaultDormitoryBgTid",
    CnID = "常量@宿舍默认背景id",
    Data = {50008}
  },
  Nonimagery_1_1_1 = {
    Key = "Nonimagery_1_1_1",
    CnID = "常量@非意象1_1_1",
    Data = {
      "Nonimagery_1_1_1_1",
      "Nonimagery_1_1_1_2",
      "Nonimagery_1_1_1_3"
    }
  },
  Nonimagery_1_2_1 = {
    Key = "Nonimagery_1_2_1",
    CnID = "常量@非意象1_2_1",
    Data = {
      "Nonimagery_1_2_1_1",
      "Nonimagery_1_2_1_2",
      "Nonimagery_1_2_1_3"
    }
  },
  Nonimagery_1_3_1 = {
    Key = "Nonimagery_1_3_1",
    CnID = "常量@非意象1_3_1",
    Data = {
      "Nonimagery_1_3_1_1",
      "Nonimagery_1_3_1_2",
      "Nonimagery_1_3_1_3"
    }
  },
  Nonimagery_1_4_1 = {
    Key = "Nonimagery_1_4_1",
    CnID = "常量@非意象1_3_2",
    Data = {
      "Nonimagery_1_4_1_1",
      "Nonimagery_1_4_1_2",
      "Nonimagery_1_4_1_3"
    }
  },
  PoetryFormatGroup = {
    Key = "PoetryFormatGroup",
    CnID = "常量@诗篇格式组",
    Data = {
      "PoetryFormatGroup_1",
      "PoetryFormatGroup_2",
      "PoetryFormatGroup_3",
      "PoetryFormatGroup_4",
      "PoetryFormatGroup_5",
      "PoetryFormatGroup_6"
    }
  },
  TutorialTabType = {
    Key = "TutorialTabType",
    CnID = "常量@教程分组",
    Data = {
      {
        "All",
        "UI_Course_Icon_TabNor01.png",
        "UI_Course_Icon_TabSel01.png"
      },
      {
        "Battle",
        "UI_Course_Icon_TabNor02.png",
        "UI_Course_Icon_TabSel02.png"
      },
      {
        "Challenge",
        "UI_Course_Icon_TabNor03.png",
        "UI_Course_Icon_TabSel03.png"
      },
      {
        "System",
        "UI_Course_Icon_TabNor04.png",
        "UI_Course_Icon_TabSel04.png"
      },
      {
        "PVP",
        "UI_Course_Icon_TabNor06.png",
        "UI_Course_Icon_TabSel06.png"
      }
    }
  },
  Yixiang1 = {
    Key = "Yixiang1",
    CnID = "常量@意象1映射",
    Data = {
      "yixiang1_1",
      "yixiang1_2",
      "yixiang1_3"
    }
  },
  Yixiang2 = {
    Key = "Yixiang2",
    CnID = "常量@意象2映射",
    Data = {
      "yixiang2_1",
      "yixiang2_2",
      "yixiang2_3"
    }
  },
  Yixiang3 = {
    Key = "Yixiang3",
    CnID = "常量@意象3映射",
    Data = {
      "yixiang3_1",
      "yixiang3_1",
      "yixiang3_3"
    }
  },
  Yixiang4 = {
    Key = "Yixiang4",
    CnID = "常量@意象4映射",
    Data = {
      "yixiang4_1",
      "yixiang4_1",
      "yixiang4_3"
    }
  },
  Yixiang5 = {
    Key = "Yixiang5",
    CnID = "常量@意象5映射",
    Data = {
      "yixiang5_1",
      "yixiang5_1",
      "yixiang5_3"
    }
  },
  Yixiang6 = {
    Key = "Yixiang6",
    CnID = "常量@意象6映射",
    Data = {
      "yixiang6_1",
      "yixiang6_1",
      "yixiang6_3"
    }
  },
  Yixiang7 = {
    Key = "Yixiang7",
    CnID = "常量@意象7映射",
    Data = {
      "yixiang7_1",
      "yixiang7_1",
      "yixiang7_3"
    }
  },
  Yixiang8 = {
    Key = "Yixiang8",
    CnID = "常量@意象8映射",
    Data = {
      "yixiang8_1",
      "yixiang8_1",
      "yixiang8_3"
    }
  },
  Yixiang9 = {
    Key = "Yixiang9",
    CnID = "常量@意象9映射",
    Data = {
      "yixiang9_1",
      "yixiang9_1",
      "yixiang9_3"
    }
  },
  Yixiang10 = {
    Key = "Yixiang10",
    CnID = "常量@意象10映射",
    Data = {
      "yixiang10_1",
      "yixiang10_1",
      "yixiang10_3"
    }
  },
  Yixiang11 = {
    Key = "Yixiang11",
    CnID = "常量@意象11映射",
    Data = {
      "yixiang11_1",
      "yixiang11_1",
      "yixiang11_3"
    }
  },
  Yixiang12 = {
    Key = "Yixiang12",
    CnID = "常量@意象12映射",
    Data = {
      "yixiang12_1",
      "yixiang12_1",
      "yixiang12_3"
    }
  },
  Yixiang13 = {
    Key = "Yixiang13",
    CnID = "常量@意象13映射",
    Data = {
      "yixiang13_1",
      "yixiang13_1",
      "yixiang13_3"
    }
  },
  Yixiang14 = {
    Key = "Yixiang14",
    CnID = "常量@意象14映射",
    Data = {
      "yixiang14_1",
      "yixiang14_1",
      "yixiang14_3"
    }
  },
  DiamondRechargeActivity = {
    Key = "DiamondRechargeActivity",
    CnID = "常量@累计充值活动",
    Data = {54596}
  },
  SkipBattleCmd = {
    Key = "SkipBattleCmd",
    CnID = "常量@肌肉记忆跳过战斗指令",
    Data = {55818}
  },
  Enchant_CardType = {
    Key = "Enchant_CardType",
    CnID = "常量@刻印卡牌类型筛选",
    Data = {
      "Card_Strike",
      "Card_Defend",
      "Card_Skill"
    }
  },
  CommunicatorRefreshPriority = {
    Key = "CommunicatorRefreshPriority",
    CnID = "常量@新抽唤醒体在N天内优先发送一次每日对话",
    Data = {7}
  },
  CommunicatorRefreshMax = {
    Key = "CommunicatorRefreshMax",
    CnID = "常量@对话上限",
    Data = {8}
  },
  CommunicateAward = {
    Key = "CommunicateAward",
    CnID = "常量@银芯通讯器对话奖励",
    Data = {9567, 5}
  },
  C05RelicLost = {
    Key = "C05RelicLost",
    CnID = "常量@莱克专属低级造物",
    Data = {
      57737,
      57736,
      57735
    }
  },
  C05RelicUp = {
    Key = "C05RelicUp",
    CnID = "常量@莱克专属高级造物",
    Data = {
      57732,
      57734,
      57733
    }
  },
  TaWeiFusionStateId = {
    Key = "TaWeiFusionStateId",
    CnID = "常量@双子塔薇融合度显示",
    Data = {57942, 100}
  },
  FriendlyMatchInvitationCountdown = {
    Key = "FriendlyMatchInvitationCountdown",
    CnID = "常量@友谊赛邀请倒计时",
    Data = {60}
  },
  FavorabilityAutomaticallyGetVelocity = {
    Key = "FavorabilityAutomaticallyGetVelocity",
    CnID = "常量@主界面唤醒体同调率自动获取速度",
    Data = {300}
  },
  FavorabilityOfflineNumLimit = {
    Key = "FavorabilityOfflineNumLimit",
    CnID = "常量@主界面唤醒体离线积累同调率上限",
    Data = {300}
  },
  FavorabilityOfflineSlowVelocity = {
    Key = "FavorabilityOfflineSlowVelocity",
    CnID = "常量@主界面唤醒体同调率减速段获取速度",
    Data = {900}
  },
  FavorabilityOfflineHardLimit = {
    Key = "FavorabilityOfflineHardLimit",
    CnID = "常量@主界面唤醒体同调率储存硬上限",
    Data = {3000}
  },
  TaskType_Resonance = {
    Key = "TaskType_Resonance",
    CnID = "常量@共鸣点前置任务",
    Data = {20}
  },
  Unit8_Boss_BloodNum = {
    Key = "Unit8_Boss_BloodNum",
    CnID = "常量@双子塔薇融合度计数状态",
    Data = {57942}
  },
  dailyChallengeDiff1_String = {
    Key = "dailyChallengeDiff1_String",
    CnID = "常量@深潜自选难度1文本",
    Data = {
      "dailyChallengeDiff1_1",
      "dailyChallengeDiff1_2",
      "dailyChallengeDiff1_3",
      "dailyChallengeDiff1_4",
      "dailyChallengeDiff1_5",
      "dailyChallengeDiff1_6",
      "dailyChallengeDiff1_7",
      "dailyChallengeDiff1_8",
      "dailyChallengeDiff1_9",
      "dailyChallengeDiff1_10",
      "dailyChallengeDiff1_11"
    }
  },
  dailyChallengeDiff2_String = {
    Key = "dailyChallengeDiff2_String",
    CnID = "常量@深潜自选难度2文本",
    Data = {
      "dailyChallengeDiff2_1",
      "dailyChallengeDiff2_2",
      "dailyChallengeDiff2_3",
      "dailyChallengeDiff2_4",
      "dailyChallengeDiff2_5",
      "dailyChallengeDiff2_6",
      "dailyChallengeDiff2_7",
      "dailyChallengeDiff2_8",
      "dailyChallengeDiff2_9",
      "dailyChallengeDiff2_10",
      "dailyChallengeDiff2_11"
    }
  },
  dailyChallengeDiff1_1 = {
    Key = "dailyChallengeDiff1_1",
    CnID = "常量@深潜自选难度1_1倍率与施加状态",
    Data = {1, 3288}
  },
  dailyChallengeDiff1_2 = {
    Key = "dailyChallengeDiff1_2",
    CnID = "常量@深潜自选难度1_2倍率与施加状态",
    Data = {
      1.05,
      62393,
      25
    }
  },
  dailyChallengeDiff1_3 = {
    Key = "dailyChallengeDiff1_3",
    CnID = "常量@深潜自选难度1_3倍率与施加状态",
    Data = {
      1.1,
      62393,
      75
    }
  },
  dailyChallengeDiff1_4 = {
    Key = "dailyChallengeDiff1_4",
    CnID = "常量@深潜自选难度1_4倍率与施加状态",
    Data = {
      1.15,
      62393,
      125
    }
  },
  dailyChallengeDiff1_5 = {
    Key = "dailyChallengeDiff1_5",
    CnID = "常量@深潜自选难度1_5倍率与施加状态",
    Data = {
      1.2,
      62393,
      200
    }
  },
  dailyChallengeDiff1_6 = {
    Key = "dailyChallengeDiff1_6",
    CnID = "常量@深潜自选难度1_6倍率与施加状态",
    Data = {
      1.25,
      62393,
      275
    }
  },
  dailyChallengeDiff1_7 = {
    Key = "dailyChallengeDiff1_7",
    CnID = "常量@深潜自选难度1_7倍率与施加状态",
    Data = {
      1.35,
      62393,
      350
    }
  },
  dailyChallengeDiff1_8 = {
    Key = "dailyChallengeDiff1_8",
    CnID = "常量@深潜自选难度1_8倍率与施加状态",
    Data = {
      1.45,
      62393,
      450
    }
  },
  dailyChallengeDiff1_9 = {
    Key = "dailyChallengeDiff1_9",
    CnID = "常量@深潜自选难度1_9倍率与施加状态",
    Data = {
      1.6,
      62393,
      600
    }
  },
  dailyChallengeDiff1_10 = {
    Key = "dailyChallengeDiff1_10",
    CnID = "常量@深潜自选难度1_10倍率与施加状态",
    Data = {
      1.75,
      62393,
      750
    }
  },
  dailyChallengeDiff1_11 = {
    Key = "dailyChallengeDiff1_11",
    CnID = "常量@深潜自选难度1_11倍率与施加状态",
    Data = {
      2,
      62393,
      1000
    }
  },
  dailyChallengeDiff1_12 = {
    Key = "dailyChallengeDiff1_12",
    CnID = "常量@深潜自选难度1_12倍率与施加状态",
    Data = {
      2.1,
      62393,
      1100
    }
  },
  dailyChallengeDiff1_13 = {
    Key = "dailyChallengeDiff1_13",
    CnID = "常量@深潜自选难度1_13倍率与施加状态",
    Data = {
      2.2,
      62393,
      1200
    }
  },
  dailyChallengeDiff1_14 = {
    Key = "dailyChallengeDiff1_14",
    CnID = "常量@深潜自选难度1_14倍率与施加状态",
    Data = {
      2.3,
      62393,
      1300
    }
  },
  dailyChallengeDiff1_15 = {
    Key = "dailyChallengeDiff1_15",
    CnID = "常量@深潜自选难度1_15倍率与施加状态",
    Data = {
      2.4,
      62393,
      1400
    }
  },
  dailyChallengeDiff1_16 = {
    Key = "dailyChallengeDiff1_16",
    CnID = "常量@深潜自选难度1_16倍率与施加状态",
    Data = {
      2.5,
      62393,
      1500
    }
  },
  dailyChallengeDiff2_1 = {
    Key = "dailyChallengeDiff2_1",
    CnID = "常量@深潜自选难度2_1倍率与施加状态",
    Data = {1, 3288}
  },
  dailyChallengeDiff2_2 = {
    Key = "dailyChallengeDiff2_2",
    CnID = "常量@深潜自选难度2_2倍率与施加状态",
    Data = {
      1.05,
      62394,
      5
    }
  },
  dailyChallengeDiff2_3 = {
    Key = "dailyChallengeDiff2_3",
    CnID = "常量@深潜自选难度2_3倍率与施加状态",
    Data = {
      1.1,
      62394,
      15
    }
  },
  dailyChallengeDiff2_4 = {
    Key = "dailyChallengeDiff2_4",
    CnID = "常量@深潜自选难度2_4倍率与施加状态",
    Data = {
      1.15,
      62394,
      25
    }
  },
  dailyChallengeDiff2_5 = {
    Key = "dailyChallengeDiff2_5",
    CnID = "常量@深潜自选难度2_5倍率与施加状态",
    Data = {
      1.2,
      62394,
      40
    }
  },
  dailyChallengeDiff2_6 = {
    Key = "dailyChallengeDiff2_6",
    CnID = "常量@深潜自选难度2_6倍率与施加状态",
    Data = {
      1.25,
      62394,
      55
    }
  },
  dailyChallengeDiff2_7 = {
    Key = "dailyChallengeDiff2_7",
    CnID = "常量@深潜自选难度2_7倍率与施加状态",
    Data = {
      1.35,
      62394,
      70
    }
  },
  dailyChallengeDiff2_8 = {
    Key = "dailyChallengeDiff2_8",
    CnID = "常量@深潜自选难度2_8倍率与施加状态",
    Data = {
      1.45,
      62394,
      90
    }
  },
  dailyChallengeDiff2_9 = {
    Key = "dailyChallengeDiff2_9",
    CnID = "常量@深潜自选难度2_9倍率与施加状态",
    Data = {
      1.6,
      62394,
      120
    }
  },
  dailyChallengeDiff2_10 = {
    Key = "dailyChallengeDiff2_10",
    CnID = "常量@深潜自选难度2_10倍率与施加状态",
    Data = {
      1.75,
      62394,
      150
    }
  },
  dailyChallengeDiff2_11 = {
    Key = "dailyChallengeDiff2_11",
    CnID = "常量@深潜自选难度2_11倍率与施加状态",
    Data = {
      2,
      62394,
      200
    }
  },
  dailyChallengeDiff2_12 = {
    Key = "dailyChallengeDiff2_12",
    CnID = "常量@深潜自选难度2_12倍率与施加状态",
    Data = {
      2.1,
      62394,
      220
    }
  },
  dailyChallengeDiff2_13 = {
    Key = "dailyChallengeDiff2_13",
    CnID = "常量@深潜自选难度2_13倍率与施加状态",
    Data = {
      2.2,
      62394,
      240
    }
  },
  dailyChallengeDiff2_14 = {
    Key = "dailyChallengeDiff2_14",
    CnID = "常量@深潜自选难度2_14倍率与施加状态",
    Data = {
      2.3,
      62394,
      260
    }
  },
  dailyChallengeDiff2_15 = {
    Key = "dailyChallengeDiff2_15",
    CnID = "常量@深潜自选难度2_15倍率与施加状态",
    Data = {
      2.4,
      62394,
      280
    }
  },
  dailyChallengeDiff2_16 = {
    Key = "dailyChallengeDiff2_16",
    CnID = "常量@深潜自选难度2_16倍率与施加状态",
    Data = {
      2.5,
      62394,
      300
    }
  },
  DailyChallengeDifficulyFormula = {
    Key = "DailyChallengeDifficulyFormula",
    CnID = "常量@深潜自选难度积分公式",
    Data = {
      "n1*n2*basics"
    }
  },
  DayChallengeOptionalDifficulyStageList = {
    Key = "DayChallengeOptionalDifficulyStageList",
    CnID = "常量@深潜自选难度关卡列表",
    Data = {
      20950,
      20970,
      20957,
      20902,
      20856,
      20931,
      20896,
      20908,
      20914,
      20943,
      20948,
      20956,
      20920,
      20875,
      20940,
      20924,
      20938,
      20886,
      20904,
      20922,
      20966,
      20861,
      20906,
      20967,
      75260,
      75140,
      75165,
      75174,
      75059,
      75010,
      75197,
      75177,
      75181,
      75037,
      75069,
      75093,
      75217,
      75130,
      75233,
      75026,
      75118,
      75190,
      75188,
      75082,
      75020,
      75098,
      75047,
      75012
    }
  },
  OriginAwakerList = {
    Key = "OriginAwakerList",
    CnID = "常量@本源唤醒体列表",
    Data = {
      15568,
      15567,
      15602,
      15589,
      145363,
      94451
    }
  },
  StageFinalShow = {
    Key = "StageFinalShow",
    CnID = "常量@章节谢幕表演",
    Data = {67786, 59504}
  },
  StageFinalId = {
    Key = "StageFinalId",
    CnID = "常量@最终章节",
    Data = {67914}
  },
  GridMoveTime = {
    Key = "GridMoveTime",
    CnID = "常量@副本走格子速度",
    Data = {0.3}
  },
  GridTriggerDelay = {
    Key = "GridTriggerDelay",
    CnID = "常量@副本格子触发延迟",
    Data = {0.3}
  },
  GridExport = {
    Key = "GridExport",
    CnID = "常量@密道出口",
    Data = {18406}
  },
  GridUpDelay = {
    Key = "GridUpDelay",
    CnID = "常量@副本格子弹起延迟",
    Data = {0.2}
  },
  RoundLimitState = {
    Key = "RoundLimitState",
    CnID = "常量@回合数限制状态",
    Data = {90023}
  },
  StageChapterMorimens = {
    Key = "StageChapterMorimens",
    CnID = "常量@关卡篇章忘却前夜篇",
    Data = {
      "StageChapterMorimens",
      1
    }
  },
  StageChapterStarsCameRight = {
    Key = "StageChapterStarsCameRight",
    CnID = "常量@关卡篇章星辰正位之刻篇",
    Data = {
      "StageChapterStarsCameRight",
      2
    }
  },
  SilverKeyAwakeChapter = {
    Key = "SilverKeyAwakeChapter",
    CnID = "常量@银钥觉醒开启篇章",
    Data = {
      "常量@关卡篇章星辰正位之刻篇"
    }
  },
  SilverKeyAwakeSkill = {
    Key = "SilverKeyAwakeSkill",
    CnID = "常量@银钥觉醒技能",
    Data = {70376}
  },
  SilverKeyAwakeState = {
    Key = "SilverKeyAwakeState",
    CnID = "常量@银钥觉醒状态",
    Data = {76236}
  },
  ChaosType2Skill = {
    Key = "ChaosType2Skill",
    CnID = "常量@新混沌_三重钥令技能",
    Data = {146519}
  },
  ChaosType2SkillDelay = {
    Key = "ChaosType2SkillDelay",
    CnID = "常量@新混沌_三重钥令技能_表演间隔",
    Data = {200}
  },
  ChaosType2Skill2 = {
    Key = "ChaosType2Skill2",
    CnID = "常量@新混沌_双重钥令技能",
    Data = {146517}
  },
  DimensionStateList = {
    Key = "DimensionStateList",
    CnID = "常量@超维回合受影响状态",
    Data = {
      2840,
      2588,
      3068,
      3905,
      3023,
      3095,
      2900,
      3130,
      3902,
      2619,
      126990,
      61145
    }
  },
  SpecialShopMapNodeType = {
    Key = "SpecialShopMapNodeType",
    CnID = "常量@灰烬遗迹节点类型",
    Data = {76256}
  },
  PVPReverseRoundActivityBG = {
    Key = "PVPReverseRoundActivityBG",
    CnID = "常量@PVP逆转回合活动专属场景",
    Data = {
      72101,
      74330,
      76536,
      124801,
      74330,
      76536
    }
  },
  PVPReRoundScoreTask = {
    Key = "PVPReRoundScoreTask",
    CnID = "常量@逆转回合活动积分奖励任务组",
    Data = {72480}
  },
  SubPlotRoleImage = {
    Key = "SubPlotRoleImage",
    CnID = "常量@支线背景和角色立绘",
    Data = {
      74338,
      "Role_PVPReRound"
    }
  },
  PVPTraning_Friendly = {
    Key = "PVPTraning_Friendly",
    CnID = "常量@PVP训练模式友方",
    Data = {78840}
  },
  PVPTraning_Enemy = {
    Key = "PVPTraning_Enemy",
    CnID = "常量@PVP训练模式敌方阵容",
    Data = {78841}
  },
  PVPTrainingGenesisDirective = {
    Key = "PVPTrainingGenesisDirective",
    CnID = "常量@PVP训练模式战斗创世指令",
    Data = {142693}
  },
  PVPTraning_Reset = {
    Key = "PVPTraning_Reset",
    CnID = "常量@PVP训练模式重置状态",
    Data = {78907}
  },
  PVPTraning_EnemyHead = {
    Key = "PVPTraning_EnemyHead",
    CnID = "常量@PVP训练模式校猫名称头像",
    Data = {
      "PVPTraning_EnemyName",
      25192
    }
  },
  InitResummonFreeChances = {
    Key = "InitResummonFreeChances",
    CnID = "常量@免费5连抽卡池类型",
    Data = {9}
  },
  ResummonFreeChancesAvg = {
    Key = "ResummonFreeChancesAvg",
    CnID = "常量@免费5连抽的AVG剧情",
    Data = {80181}
  },
  SeniroSummonAwakerProbability = {
    Key = "SeniroSummonAwakerProbability",
    CnID = "常量@限定唤醒体卡池抽奖概率",
    Data = {
      2.38,
      2.64,
      25,
      69.98
    }
  },
  CommonSummonChaosAwakerProbability = {
    Key = "CommonSummonChaosAwakerProbability",
    CnID = "常量@常驻唤醒体混沌卡池抽奖概率",
    Data = {
      0.5,
      4.52,
      25,
      69.98
    }
  },
  CommonSummonOceanAwakerProbability = {
    Key = "CommonSummonOceanAwakerProbability",
    CnID = "常量@常驻唤醒体深海卡池抽奖概率",
    Data = {
      0.5,
      4.52,
      25,
      69.98
    }
  },
  CommonSummonBloodAwakerProbability = {
    Key = "CommonSummonBloodAwakerProbability",
    CnID = "常量@常驻唤醒体血肉卡池抽奖概率",
    Data = {
      0.5,
      4.52,
      25,
      69.98
    }
  },
  CommonSummonDimensionAwakerProbability = {
    Key = "CommonSummonDimensionAwakerProbability",
    CnID = "常量@常驻唤醒体超维卡池抽奖概率",
    Data = {
      0.5,
      4.52,
      25,
      69.98
    }
  },
  SeniroSummonWeaponProbability = {
    Key = "SeniroSummonWeaponProbability",
    CnID = "常量@限定命轮卡池抽奖概率",
    Data = {
      3.34,
      1.68,
      25,
      69.98
    }
  },
  CommonSummonWeaponProbability = {
    Key = "CommonSummonWeaponProbability",
    CnID = "常量@常驻命轮卡池抽奖概率",
    Data = {
      2.38,
      0.5,
      2.14,
      25,
      69.98
    }
  },
  CommonSummonWeaponProbability2 = {
    Key = "CommonSummonWeaponProbability2",
    CnID = "常量@常驻命轮卡池不含限定抽奖概率",
    Data = {
      2.38,
      2.64,
      25,
      69.98
    }
  },
  LuckyBagSummonProbability = {
    Key = "LuckyBagSummonProbability",
    CnID = "常量@福袋卡池抽奖概率",
    Data = {40, 60}
  },
  AwakerWeaponMixSummonProbability = {
    Key = "AwakerWeaponMixSummonProbability",
    CnID = "常量@N选1卡池抽奖概率",
    Data = {
      3.01,
      2.01,
      25,
      69.98
    }
  },
  FadedLegacyLimitedSummonProbability = {
    Key = "FadedLegacyLimitedSummonProbability",
    CnID = "常量@忘却篇混池抽奖概率",
    Data = {
      2.23,
      2.79,
      25,
      69.98
    }
  },
  SummonType_9Probability = {
    Key = "SummonType_9Probability",
    CnID = "常量@初回限定卡池抽奖概率",
    Data = {
      0,
      20,
      25,
      55
    }
  },
  SpecialLuckyBagSummonProbability = {
    Key = "SpecialLuckyBagSummonProbability",
    CnID = "常量@特殊福袋卡池抽奖概率",
    Data = {
      20,
      20,
      20,
      40
    }
  },
  AwakerWeaponRotationSummonProbability = {
    Key = "AwakerWeaponRotationSummonProbability",
    CnID = "常量@角色命轮轮换混池抽奖概率",
    Data = {
      0.5,
      4.52,
      25,
      69.98
    }
  },
  SchoolAnchorAwakerWeaponSummonProbability = {
    Key = "SchoolAnchorAwakerWeaponSummonProbability",
    CnID = "常量@界域锚定唤醒抽奖概率",
    Data = {
      2.23,
      2.79,
      25,
      69.98
    }
  },
  SummonType_14Probability = {
    Key = "SummonType_14Probability",
    CnID = "常量@卡池类型14抽奖概率",
    Data = {
      3.34,
      1.68,
      25,
      69.98
    }
  },
  SummonType_15Probability = {
    Key = "SummonType_15Probability",
    CnID = "常量@卡池类型15抽奖概率",
    Data = {40, 60}
  },
  SummonType_16Probability = {
    Key = "SummonType_16Probability",
    CnID = "常量@卡池类型16抽奖概率",
    Data = {
      3.01,
      2.01,
      25,
      69.98
    }
  },
  SummonType_17Probability = {
    Key = "SummonType_17Probability",
    CnID = "常量@卡池类型17抽奖概率",
    Data = {
      2.23,
      2.79,
      25,
      69.98
    }
  },
  PoolRate_0_NotLimited = {
    Key = "PoolRate_0_NotLimited",
    CnID = "常量@常驻命轮卡池不含限定概率展示",
    Data = {
      "CommonSummonWeaponProbability2",
      14431,
      14514
    }
  },
  PoolRate_0 = {
    Key = "PoolRate_0",
    CnID = "常量@常驻命轮卡池概率展示",
    Data = {
      "CommonSummonWeaponProbability",
      14431,
      14514
    }
  },
  PoolRate_1 = {
    Key = "PoolRate_1",
    CnID = "常量@限定命轮卡池概率展示",
    Data = {
      "SeniroSummonWeaponProbability",
      14431,
      14514
    }
  },
  PoolRate_2 = {
    Key = "PoolRate_2",
    CnID = "常量@限定唤醒体卡池概率展示",
    Data = {
      "SeniroSummonAwakerProbability",
      14431,
      14514
    }
  },
  PoolRate_5_Chaos = {
    Key = "PoolRate_5_Chaos",
    CnID = "常量@常驻唤醒体混沌卡池概率展示",
    Data = {
      "CommonSummonChaosAwakerProbability",
      14431,
      14514
    }
  },
  PoolRate_5_Ocean = {
    Key = "PoolRate_5_Ocean",
    CnID = "常量@常驻唤醒体深海卡池概率展示",
    Data = {
      "CommonSummonOceanAwakerProbability",
      14431,
      14514
    }
  },
  PoolRate_5_Blood = {
    Key = "PoolRate_5_Blood",
    CnID = "常量@常驻唤醒体血肉卡池概率展示",
    Data = {
      "CommonSummonBloodAwakerProbability",
      14431,
      14514
    }
  },
  PoolRate_5_Dimension = {
    Key = "PoolRate_5_Dimension",
    CnID = "常量@常驻唤醒体超维卡池概率展示",
    Data = {
      "CommonSummonDimensionAwakerProbability",
      14431,
      14514
    }
  },
  PoolRate_7 = {
    Key = "PoolRate_7",
    CnID = "常量@N选1卡池概率展示",
    Data = {
      "AwakerWeaponMixSummonProbability",
      14431,
      14514
    }
  },
  PoolRate_8_Chaos = {
    Key = "PoolRate_8_Chaos",
    CnID = "常量@混沌福袋卡池概率展示",
    Data = {
      "LuckyBagSummonProbability",
      81543,
      81540
    }
  },
  PoolRate_8_Ocean = {
    Key = "PoolRate_8_Ocean",
    CnID = "常量@深海福袋卡池概率展示",
    Data = {
      "LuckyBagSummonProbability",
      81541,
      81544
    }
  },
  PoolRate_8_Blood = {
    Key = "PoolRate_8_Blood",
    CnID = "常量@血肉福袋卡池概率展示",
    Data = {
      "LuckyBagSummonProbability",
      81545,
      81546
    }
  },
  PoolRate_8_Dimension = {
    Key = "PoolRate_8_Dimension",
    CnID = "常量@超维福袋卡池概率展示",
    Data = {
      "LuckyBagSummonProbability",
      81548,
      81547
    }
  },
  PoolRate_8_Attack = {
    Key = "PoolRate_8_Attack",
    CnID = "常量@攻击型福袋卡池概率展示",
    Data = {
      "SpecialLuckyBagSummonProbability",
      117233,
      117223,
      117241,
      117243
    }
  },
  PoolRate_8_Assist = {
    Key = "PoolRate_8_Assist",
    CnID = "常量@辅助型福袋卡池概率展示",
    Data = {
      "SpecialLuckyBagSummonProbability",
      117228,
      117235,
      117239,
      117236
    }
  },
  PoolRate_8_Defence = {
    Key = "PoolRate_8_Defence",
    CnID = "常量@防御型福袋卡池概率展示",
    Data = {
      "SpecialLuckyBagSummonProbability",
      117222,
      117227,
      117238,
      117230
    }
  },
  PoolRate_8_Man = {
    Key = "PoolRate_8_Man",
    CnID = "常量@男性福袋卡池概率展示",
    Data = {
      "SpecialLuckyBagSummonProbability",
      117242,
      117229,
      117231,
      117240
    }
  },
  PoolRate_8_Woman = {
    Key = "PoolRate_8_Woman",
    CnID = "常量@女性福袋卡池概率展示",
    Data = {
      "SpecialLuckyBagSummonProbability",
      117244,
      117232,
      117226,
      117224
    }
  },
  PoolRate_8_MorimensMan = {
    Key = "PoolRate_8_MorimensMan",
    CnID = "常量@忘却篇男性福袋卡池概率展示",
    Data = {
      "LuckyBagSummonProbability",
      117229,
      117240
    }
  },
  PoolRate_8_MorimensWoman = {
    Key = "PoolRate_8_MorimensWoman",
    CnID = "常量@忘却篇女性福袋卡池概率展示",
    Data = {
      "LuckyBagSummonProbability",
      117232,
      117224
    }
  },
  PoolRate_8_StarsMan = {
    Key = "PoolRate_8_StarsMan",
    CnID = "常量@星辰篇男性福袋卡池概率展示",
    Data = {
      "LuckyBagSummonProbability",
      117242,
      117231
    }
  },
  PoolRate_8_StarsWoman = {
    Key = "PoolRate_8_StarsWoman",
    CnID = "常量@星辰篇女性福袋卡池概率展示",
    Data = {
      "LuckyBagSummonProbability",
      117244,
      117226
    }
  },
  PoolRate_8_MorimensAttack = {
    Key = "PoolRate_8_MorimensAttack",
    CnID = "常量@忘却篇攻击型福袋卡池概率展示",
    Data = {
      "LuckyBagSummonProbability",
      117223,
      117243
    }
  },
  PoolRate_8_MorimensAssist = {
    Key = "PoolRate_8_MorimensAssist",
    CnID = "常量@忘却篇辅助型福袋卡池概率展示",
    Data = {
      "LuckyBagSummonProbability",
      117235,
      117236
    }
  },
  PoolRate_8_MorimensDefence = {
    Key = "PoolRate_8_MorimensDefence",
    CnID = "常量@忘却篇防御型福袋卡池概率展示",
    Data = {
      "LuckyBagSummonProbability",
      117227,
      117230
    }
  },
  PoolRate_9 = {
    Key = "PoolRate_9",
    CnID = "常量@初回限定卡池概率展示",
    Data = {
      "SummonType_9Probability",
      14431,
      14514
    }
  },
  PoolRate_10 = {
    Key = "PoolRate_10",
    CnID = "常量@忘却篇混池概率展示",
    Data = {
      "FadedLegacyLimitedSummonProbability",
      14431,
      14514
    }
  },
  PoolRate_12 = {
    Key = "PoolRate_12",
    CnID = "常量@角色命轮轮换混池概率展示",
    Data = {
      "AwakerWeaponRotationSummonProbability",
      14431,
      14514
    }
  },
  PoolRate_13 = {
    Key = "PoolRate_13",
    CnID = "常量@界域锚定卡池概率展示",
    Data = {
      "SchoolAnchorAwakerWeaponSummonProbability",
      14431,
      14514
    }
  },
  PoolRate_14 = {
    Key = "PoolRate_14",
    CnID = "常量@卡池类型14概率展示",
    Data = {
      "SummonType_14Probability",
      14431,
      14514
    }
  },
  PoolRate_15_Attack = {
    Key = "PoolRate_15_Attack",
    CnID = "常量@卡池类型15攻击型概率展示",
    Data = {
      "SummonType_15Probability",
      138797,
      138795
    }
  },
  PoolRate_15_Assist = {
    Key = "PoolRate_15_Assist",
    CnID = "常量@卡池类型15辅助型概率展示",
    Data = {
      "SummonType_15Probability",
      138799,
      138796
    }
  },
  PoolRate_15_Defence = {
    Key = "PoolRate_15_Defence",
    CnID = "常量@卡池类型15防御型概率展示",
    Data = {
      "SummonType_15Probability",
      138802,
      138798
    }
  },
  PoolRate_16 = {
    Key = "PoolRate_16",
    CnID = "常量@卡池类型16概率展示",
    Data = {
      "SummonType_16Probability",
      14431,
      14514
    }
  },
  PoolRate_17 = {
    Key = "PoolRate_17",
    CnID = "常量@卡池类型17概率展示",
    Data = {
      "SummonType_17Probability",
      14431,
      14514
    }
  },
  SpecialPoolRateShow = {
    Key = "SpecialPoolRateShow",
    CnID = "常量@特殊卡池概率展示",
    Data = {
      "PoolRate_8_Attack",
      117218,
      "PoolRate_8_Assist",
      117215,
      "PoolRate_8_Defence",
      117217,
      "PoolRate_8_Man",
      117216,
      "PoolRate_8_Woman",
      117219,
      "PoolRate_8_MorimensMan",
      129493,
      "PoolRate_8_MorimensWoman",
      129490,
      "PoolRate_8_StarsMan",
      129497,
      "PoolRate_8_StarsWoman",
      129491,
      "PoolRate_15_Attack",
      138790,
      "PoolRate_15_Assist",
      138792,
      "PoolRate_15_Defence",
      138793,
      "PoolRate_8_MorimensAttack",
      149943,
      "PoolRate_8_MorimensAssist",
      149341,
      "PoolRate_8_MorimensDefence",
      149339
    }
  },
  GoldenWeekTask1 = {
    Key = "GoldenWeekTask1",
    CnID = "常量@黄金周活动幻梦深潜任务",
    Data = {80274, 81018}
  },
  GoldenWeekTask2 = {
    Key = "GoldenWeekTask2",
    CnID = "常量@黄金周活动通关任意主线任务",
    Data = {80277, 81001}
  },
  GoldenWeekTask3 = {
    Key = "GoldenWeekTask3",
    CnID = "常量@黄金周活动融蚀之墟任务",
    Data = {80278, 81016}
  },
  GoldenWeekTask4 = {
    Key = "GoldenWeekTask4",
    CnID = "常量@黄金周活动相位对弈任务",
    Data = {80273, 81007}
  },
  GoldenWeekTask5 = {
    Key = "GoldenWeekTask5",
    CnID = "常量@黄金周活动蔷薇金券任务",
    Data = {80276, 80997}
  },
  GoldenWeekTask6 = {
    Key = "GoldenWeekTask6",
    CnID = "常量@黄金周活动每日完成任务",
    Data = {80280, 80994}
  },
  GoldenWeekTask7 = {
    Key = "GoldenWeekTask7",
    CnID = "常量@黄金周活动完成所有任务",
    Data = {80279, 81005}
  },
  GoldenWeekTask8 = {
    Key = "GoldenWeekTask8",
    CnID = "常量@黄金周活动首次进入主界面",
    Data = {80275, 81019}
  },
  StageGroupTypeDailyWinCountLimit = {
    Key = "StageGroupTypeDailyWinCountLimit",
    CnID = "常量@关卡组每日通关次数限制",
    Data = {111, 20}
  },
  DimensionTurnCtl = {
    Key = "DimensionTurnCtl",
    CnID = "常量@开启超维回合",
    Data = {1}
  },
  TranscendentCtl = {
    Key = "TranscendentCtl",
    CnID = "常量@超维超越之光开关",
    Data = {126901}
  },
  TranscendentCmd = {
    Key = "TranscendentCmd",
    CnID = "常量@超维超越之光",
    Data = {80035}
  },
  WeaponMainAttrTypeLimit = {
    Key = "WeaponMainAttrTypeLimit",
    CnID = "常量@同属性命轮装配限制",
    Data = {0}
  },
  TrinketSubAttrTypeLimit = {
    Key = "TrinketSubAttrTypeLimit",
    CnID = "常量@同属性密契洗练限制",
    Data = {0}
  },
  Power2TentacleDamage = {
    Key = "Power2TentacleDamage",
    CnID = "常量@力量转触伤倍率",
    Data = {0}
  },
  powerState = {
    Key = "powerState",
    CnID = "常量@力量状态",
    Data = {2900}
  },
  powerStateTemp = {
    Key = "powerStateTemp",
    CnID = "常量@临时力量状态",
    Data = {3130}
  },
  TentacleDamageForPowerPercent = {
    Key = "TentacleDamageForPowerPercent",
    CnID = "常量@触腕力量加成百分比",
    Data = {-100}
  },
  tentacleAttackCountMul = {
    Key = "tentacleAttackCountMul",
    CnID = "常量@触腕攻击次数倍率修正状态",
    Data = {2626}
  },
  tentacleAttackCount = {
    Key = "tentacleAttackCount",
    CnID = "常量@触腕攻击次数修正状态",
    Data = {22067}
  },
  MinimumIntervalReturnChronicle = {
    Key = "MinimumIntervalReturnChronicle",
    CnID = "常量@回归纪行最小间隔天数",
    Data = {28}
  },
  StageGroupLimitSummon = {
    Key = "StageGroupLimitSummon",
    CnID = "常量@限定试玩关卡组",
    Data = {15926}
  },
  StarStageGroupLimitSummon = {
    Key = "StarStageGroupLimitSummon",
    CnID = "常量@星辰篇限定试玩关卡组",
    Data = {99329}
  },
  DungeonsMainView = {
    Key = "DungeonsMainView",
    CnID = "常量@界面幕间演习",
    Data = {
      "DungeonsMainView"
    }
  },
  DungeonsTrinketView = {
    Key = "DungeonsTrinketView",
    CnID = "常量@界面禁忌纂录",
    Data = {
      "DungeonsTrinketView"
    }
  },
  SchoolTowerView = {
    Key = "SchoolTowerView",
    CnID = "常量@界面无光之境",
    Data = {
      "SchoolTowerView"
    }
  },
  DailyChallengeView = {
    Key = "DailyChallengeView",
    CnID = "常量@界面幻梦深潜",
    Data = {
      "DailyChallengeView"
    }
  },
  WeekBossView = {
    Key = "WeekBossView",
    CnID = "常量@界面超验存在",
    Data = {
      "WeekBossView"
    }
  },
  AbyssView = {
    Key = "AbyssView",
    CnID = "常量@界面融灾禁区",
    Data = {"AbyssView"}
  },
  FreeTrialView = {
    Key = "FreeTrialView",
    CnID = "常量@界面唤醒体试玩",
    Data = {
      "FreeTrialView"
    }
  },
  CopyLargeBranchView = {
    Key = "CopyLargeBranchView",
    CnID = "常量@界面特遣记录",
    Data = {
      "CopyLargeBranchView"
    }
  },
  CopySmallBranchView = {
    Key = "CopySmallBranchView",
    CnID = "常量@界面意识潜游",
    Data = {
      "CopySmallBranchView"
    }
  },
  PanelName109 = {
    Key = "PanelName109",
    CnID = "常量@界面多维连接"
  },
  CopyVindicateView = {
    Key = "CopyVindicateView",
    CnID = "常量@界面繁衍狂欢",
    Data = {
      "CopyVindicateView"
    }
  },
  TaskDispatchView = {
    Key = "TaskDispatchView",
    CnID = "常量@界面派遣",
    Data = {
      "TaskDispatchView"
    }
  },
  MainPanelPVP = {
    Key = "MainPanelPVP",
    CnID = "常量@界面相位对弈",
    Data = {
      "MainPanelPVP"
    }
  },
  BpMainView = {
    Key = "BpMainView",
    CnID = "常量@界面课题记录",
    Data = {"BpMainView"}
  },
  ResonanceMainPanel = {
    Key = "ResonanceMainPanel",
    CnID = "常量@界面共鸣",
    Data = {
      "ResonanceMainPanel"
    }
  },
  MainCopyProgressRewardPanel = {
    Key = "MainCopyProgressRewardPanel",
    CnID = "常量@界面星级评价",
    Data = {
      "MainCopyProgressRewardPanel"
    }
  },
  MainCopyShop = {
    Key = "MainCopyShop",
    CnID = "常量@界面调查兑换",
    Data = {
      "MainCopyShop"
    }
  },
  DungeonMaterialView = {
    Key = "DungeonMaterialView",
    CnID = "常量@界面融蚀之墟",
    Data = {
      "DungeonMaterialView"
    }
  },
  AwakerInfoComp = {
    Key = "AwakerInfoComp",
    CnID = "常量@界面唤醒体状态",
    Data = {
      "AwakerInfoComp"
    }
  },
  AwakerSkillComp = {
    Key = "AwakerSkillComp",
    CnID = "常量@界面唤醒体技能",
    Data = {
      "AwakerSkillComp"
    }
  },
  AwakerPotencyComp = {
    Key = "AwakerPotencyComp",
    CnID = "常量@界面唤醒体启灵",
    Data = {
      "AwakerPotencyComp"
    }
  },
  AwakerTalentComp = {
    Key = "AwakerTalentComp",
    CnID = "常量@界面唤醒体天赋",
    Data = {
      "AwakerTalentComp"
    }
  },
  AwakerBackTrackComp = {
    Key = "AwakerBackTrackComp",
    CnID = "常量@界面唤醒体回溯",
    Data = {
      "AwakerBackTrackComp"
    }
  },
  AwakerTrinketComp = {
    Key = "AwakerTrinketComp",
    CnID = "常量@界面唤醒体密契",
    Data = {
      "AwakerTrinketComp"
    }
  },
  TowerShop = {
    Key = "TowerShop",
    CnID = "常量@界面无光兑换",
    Data = {"TowerShop"}
  },
  PopupIllustratePanels = {
    Key = "PopupIllustratePanels",
    CnID = "常量@首次进入弹出帮助界面",
    Data = {
      "DungeonsMainView",
      "SchoolTowerView",
      "DailyChallengeView",
      "WeekBossView",
      "AbyssView",
      "FreeTrialView",
      "CopyLargeBranchView",
      "CopySmallBranchView",
      "PanelName109",
      "CopyVindicateView",
      "TaskDispatchView",
      "MainPanelPVP",
      "BpMainView",
      "ResonanceMainPanel",
      "MainCopyProgressRewardPanel",
      "DungeonMaterialView",
      "DungeonsTrinketView",
      "MainCopyShop",
      "TowerShop",
      "AwakerInfoComp",
      "AwakerSkillComp",
      "AwakerPotencyComp",
      "AwakerTalentComp",
      "AwakerBackTrackComp",
      "MainShopTypeAdvanceDC",
      "DailyChallengeShop"
    }
  },
  PlayUnlockAnimation = {
    Key = "PlayUnlockAnimation",
    CnID = "常量@播放功能解锁动画",
    Data = {
      17015,
      17036,
      21402,
      17075,
      60580,
      17008,
      17054,
      17040,
      21402,
      16972,
      25256
    }
  },
  DeepSeaInvasionDefensiveActiviityTaskEnd = {
    Key = "DeepSeaInvasionDefensiveActiviityTaskEnd",
    CnID = "常量@深海入侵击退战任务结束时间",
    Data = {1749430800}
  },
  DeepSeaInvasionDefensiveActiviityAvg1 = {
    Key = "DeepSeaInvasionDefensiveActiviityAvg1",
    CnID = "常量@深海入侵击退战活动开始剧情",
    Data = {
      "PlayActAvg",
      89879,
      81771
    }
  },
  DeepSeaInvasionDefensiveActiviityAvg2 = {
    Key = "DeepSeaInvasionDefensiveActiviityAvg2",
    CnID = "常量@深海入侵击退战活动结束剧情",
    Data = {
      "PlayActAvg",
      89878,
      81771,
      81774
    }
  },
  FollowCommunityReward = {
    Key = "FollowCommunityReward",
    CnID = "常量@关注社区奖励银芯数量",
    Data = {9567, 100}
  },
  Community = {
    Key = "Community",
    CnID = "常量@社区列表",
    Data = {
      "Steam",
      "X",
      "FaceBook",
      "Discord",
      "Reddit",
      "Youtube",
      "Tiktok"
    }
  },
  CommunityUrl_Discord = {
    Key = "CommunityUrl_Discord",
    CnID = "常量@社区Discord链接",
    Data = {
      "default",
      "https://discord.com/invite/VJhuUdHxmc",
      "tw",
      "https://discord.gg/ghpPrWX7K5"
    }
  },
  CommunityUrl_FaceBook = {
    Key = "CommunityUrl_FaceBook",
    CnID = "常量@社区FaceBook链接",
    Data = {
      "default",
      "https://www.facebook.com/MorimensOfficial/"
    }
  },
  CommunityUrl_Youtube = {
    Key = "CommunityUrl_Youtube",
    CnID = "常量@社区Youtubek链接"
  },
  CommunityUrl_X = {
    Key = "CommunityUrl_X",
    CnID = "常量@社区X链接",
    Data = {
      "default",
      "https://x.com/MorimensOfcl"
    }
  },
  CommunityUrl_Tiktok = {
    Key = "CommunityUrl_Tiktok",
    CnID = "常量@社区Tiktok链接"
  },
  CommunityUrl_Reddit = {
    Key = "CommunityUrl_Reddit",
    CnID = "常量@社区Reddit链接",
    Data = {
      "default",
      "https://www.reddit.com/r/Morimens/"
    }
  },
  CommunityUrl_Steam = {
    Key = "CommunityUrl_Steam",
    CnID = "常量@社区Steam链接",
    Data = {
      "default",
      "https://steamcommunity.com/app/3052450/"
    }
  },
  TranslateGratitudeReward = {
    Key = "TranslateGratitudeReward",
    CnID = "常量@志愿者翻译首次点击奖励",
    Data = {9567, 100}
  },
  GratitudePlayerNamesList = {
    Key = "GratitudePlayerNamesList",
    CnID = "常量@感谢的玩家名字列表",
    Data = {
      "Adelle",
      "AegiX",
      "Alza",
      "Anicillia",
      "Ansu",
      "Arkaether",
      "ASTAR",
      "AsteRIA",
      "Bahisa",
      "Basile",
      "Beenax",
      "Bervernis",
      "Cassius",
      "Chie",
      "Cullet",
      "darkerkuro",
      "Dredge",
      "Elandriah",
      "FongDue",
      "Francis",
      "ghostboots",
      "Goz",
      "Haps",
      "Hierarch",
      "Insigible",
      "Jun",
      "Kainoxis",
      "KD",
      "Larvani",
      "Lasha",
      "LavenderJuly",
      "Lica",
      "Lislium",
      "Loki Locstar",
      "lyaistra",
      "Lykantos",
      "MarcosWG",
      "Miguel Angel",
      "nauravale",
      "Nero",
      "NoEyeBunny",
      "Noah",
      "omnichromia",
      "Orithsuka",
      "Ploara.V.C",
      "Rosemary",
      "Shiraori",
      "SJ88",
      "Solgazm",
      "SophieChoice",
      "Strandiel",
      "Teje",
      "TheRiddleOfCards",
      "Yeon",
      "Yunita",
      "金雀釵",
      "때까치",
      "량",
      "별이",
      "외곽"
    }
  },
  RotationModeThresholdScore = {
    Key = "RotationModeThresholdScore",
    CnID = "常量@巅峰对弈首赛季参与标准线",
    Data = {1500}
  },
  RotationModeInitialRank = {
    Key = "RotationModeInitialRank",
    CnID = "常量@巅峰对弈段位",
    Data = {46157}
  },
  RotationModeMatchDecelerationCoefficient = {
    Key = "RotationModeMatchDecelerationCoefficient",
    CnID = "常量@PVP减速匹配系数",
    Data = {0.33}
  },
  RotationModeRelicConfig = {
    Key = "RotationModeRelicConfig",
    CnID = "常量@巅峰对弈随机造物",
    Data = {
      94696,
      94697,
      94698,
      94695,
      120373,
      120372,
      122627,
      122625,
      122630,
      122626,
      122628,
      122629
    }
  },
  RotationModeAnimationTime = {
    Key = "RotationModeAnimationTime",
    CnID = "常量@巅峰对弈卡池动画显示时长",
    Data = {15}
  },
  RotationModeDecisionTime = {
    Key = "RotationModeDecisionTime",
    CnID = "常量@巅峰对弈玩家选择时间",
    Data = {15}
  },
  RotationModeAISelectCardsTime = {
    Key = "RotationModeAISelectCardsTime",
    CnID = "常量@巅峰对弈人机选牌阶段时间",
    Data = {3, 6}
  },
  RotationModeAIChangePositionTime = {
    Key = "RotationModeAIChangePositionTime",
    CnID = "常量@巅峰对弈人机队伍调整时间",
    Data = {3, 6}
  },
  RotationModeChangePositionTime = {
    Key = "RotationModeChangePositionTime",
    CnID = "常量@巅峰对弈修改站位阶段时长",
    Data = {25}
  },
  RotationModeThresholdLevel = {
    Key = "RotationModeThresholdLevel",
    CnID = "常量@巅峰对弈参所需预组奖励等级",
    Data = {30}
  },
  DraftPhaseDisconnectTimeout = {
    Key = "DraftPhaseDisconnectTimeout",
    CnID = "常量@轮选模式轮选阶段掉线踢出时长",
    Data = {15}
  },
  PrologueResetGuideConfig = {
    Key = "PrologueResetGuideConfig",
    CnID = "常量@序章重置引导ID",
    Data = {29, 30}
  },
  CounterattackCount = {
    Key = "CounterattackCount",
    CnID = "常量@反击计数状态",
    Data = {97742}
  },
  PowerCount = {
    Key = "PowerCount",
    CnID = "常量@力量计数状态",
    Data = {97743}
  },
  ThinkingTime = {
    Key = "ThinkingTime",
    CnID = "常量@PVP思考时长",
    Data = {6}
  },
  OtherDisplayTime = {
    Key = "OtherDisplayTime",
    CnID = "常量@PVP其他对话展示时长",
    Data = {6}
  },
  ReletedAwakerDisplayTime = {
    Key = "ReletedAwakerDisplayTime",
    CnID = "常量@PVP关系对话展示时长",
    Data = {6}
  },
  FriendInvitationCodeEndTime = {
    Key = "FriendInvitationCodeEndTime",
    CnID = "常量@好友邀请码使用时限",
    Data = {168}
  },
  NonLimitedAwakerList = {
    Key = "NonLimitedAwakerList",
    CnID = "常量@非限定SSR唤醒体列表",
    Data = {
      15580,
      15588,
      15560,
      15565,
      15571,
      15592,
      15566,
      15575,
      15594,
      15564,
      15597,
      15577,
      15587,
      15600,
      15598,
      15572,
      15593,
      15562,
      15574,
      15579,
      15595,
      15568,
      15585,
      15569,
      15570,
      15591,
      15573,
      15603
    }
  },
  FriendInvitationMaxNum = {
    Key = "FriendInvitationMaxNum",
    CnID = "常量@好友邀请码人数上限",
    Data = {50}
  },
  FriendInvitationCodeTask = {
    Key = "FriendInvitationCodeTask",
    CnID = "常量@输入邀请码奖励",
    Data = {9567, 300}
  },
  InviteeTaskList = {
    Key = "InviteeTaskList",
    CnID = "常量@受邀方任务列表",
    Data = {
      91131,
      91154,
      91149,
      91129
    }
  },
  InviterTaskList = {
    Key = "InviterTaskList",
    CnID = "常量@邀请方任务列表",
    Data = {
      91145,
      91147,
      91135,
      91155,
      91128,
      91137,
      91144,
      91150,
      91127,
      91141
    }
  },
  DefaultBgCGId = {
    Key = "DefaultBgCGId",
    CnID = "常量@主界面默认背景CGId",
    Data = {50008}
  },
  DefaultBgMusicId = {
    Key = "DefaultBgMusicId",
    CnID = "常量@主界面默认背景音乐Id",
    Data = {71014}
  },
  Alchemy_SeasonS1SmallMtrl = {
    Key = "Alchemy_SeasonS1SmallMtrl",
    CnID = "常量@碎裂余梦id",
    Data = {74093}
  },
  Alchemy_SeasonS1BigMtrl = {
    Key = "Alchemy_SeasonS1BigMtrl",
    CnID = "常量@群星余梦id",
    Data = {74143}
  },
  Alchemy_TrinketMaterial = {
    Key = "Alchemy_TrinketMaterial",
    CnID = "常量@千面印章id",
    Data = {9619}
  },
  Alchemy_TrinketRefineLock = {
    Key = "Alchemy_TrinketRefineLock",
    CnID = "常量@追念羽笔id",
    Data = {9522}
  },
  PVP_PasswordBattle_WaitTime = {
    Key = "PVP_PasswordBattle_WaitTime",
    CnID = "常量@密码对弈总等待时间",
    Data = {180}
  },
  PVP_PasswordBattle_RefusedWaitTime = {
    Key = "PVP_PasswordBattle_RefusedWaitTime",
    CnID = "常量@密码对弈拒绝后等待时间",
    Data = {
      20,
      20,
      300
    }
  },
  PvpDraftStartSeason = {
    Key = "PvpDraftStartSeason",
    CnID = "常量@巅峰轮选起始赛季",
    Data = {16449}
  },
  LimitedTimeActivityStageGroupType = {
    Key = "LimitedTimeActivityStageGroupType",
    CnID = "常量@限时活动关卡组类型",
    Data = {
      22,
      23,
      24,
      25,
      26,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      36,
      37,
      38,
      39,
      40,
      41,
      42,
      43,
      44,
      45,
      46,
      47,
      48,
      49,
      50,
      51,
      52,
      53,
      54,
      55,
      56,
      57,
      58,
      59,
      60,
      100,
      103,
      111,
      113,
      201
    }
  },
  AbandonedTask = {
    Key = "AbandonedTask",
    CnID = "常量@废弃任务",
    Data = {21401}
  },
  SpireModeMapIndex = {
    Key = "SpireModeMapIndex",
    CnID = "常量@尖塔肉鸽模式地图索引",
    Data = 116377
  },
  SpireModeResonanceMaterialDropNumb = {
    Key = "SpireModeResonanceMaterialDropNumb",
    CnID = "常量@尖塔肉鸽模式按层掉落共鸣材料数量",
    Data = {
      1,
      2,
      3,
      4
    }
  },
  SpireModeStageGroup = {
    Key = "SpireModeStageGroup",
    CnID = "常量@尖塔肉鸽模式关卡组",
    Data = 116435
  },
  SpireModeResonance = {
    Key = "SpireModeResonance",
    CnID = "常量@尖塔肉鸽模式共鸣",
    Data = 116444
  },
  SpireModeFinaleModKey = {
    Key = "SpireModeFinaleModKey",
    CnID = "常量@尖塔肉鸽模式终幕钥匙",
    Data = {
      116382,
      116384,
      116383
    }
  },
  SpireModeScoringTask = {
    Key = "SpireModeScoringTask",
    CnID = "常量@尖塔肉鸽模式计分任务"
  },
  SpireModeAwakerSoulforgeAptitudeLevel = {
    Key = "SpireModeAwakerSoulforgeAptitudeLevel",
    CnID = "常量@尖塔肉鸽模式唤醒体灵塑适性等级",
    Data = 10
  },
  SpireModeAwakerSkillLevel = {
    Key = "SpireModeAwakerSkillLevel",
    CnID = "常量@尖塔肉鸽模式唤醒体初始技能等级",
    Data = {
      6,
      6,
      6,
      6,
      6,
      6
    }
  },
  SpireModeAwakerStarLevel = {
    Key = "SpireModeAwakerStarLevel",
    CnID = "常量@尖塔肉鸽模式星数对应的等级",
    Data = {
      1,
      20,
      40,
      60,
      90
    }
  },
  SpireModeAwakerPotency = {
    Key = "SpireModeAwakerPotency",
    CnID = "常量@尖塔肉鸽模式星数对应的启灵",
    Data = {
      0,
      1,
      2,
      3,
      15
    }
  },
  SpireModeAwakerStarLevelIcon = {
    Key = "SpireModeAwakerStarLevelIcon",
    CnID = "常量@尖塔肉鸽模式星数对应的图标",
    Data = {
      "UI_Team_Image_Select_Toggle_I",
      "UI_Team_Image_Select_Toggle_II",
      "UI_Team_Image_Select_Toggle_III",
      "UI_Team_Image_Select_Toggle_IV",
      "UI_Team_Image_Select_Toggle_V"
    }
  },
  SpireMapDisplayParameters = {
    Key = "SpireMapDisplayParameters",
    CnID = "常量@尖塔肉鸽模式地图节点显示参数",
    Data = {
      10,
      10,
      5
    }
  },
  SpireModeRelicSlot = {
    Key = "SpireModeRelicSlot",
    CnID = "常量@尖塔肉鸽模式造物数量",
    Data = 24
  },
  PVEGenesisDirective = {
    Key = "PVEGenesisDirective",
    CnID = "常量@PVE战斗创世指令",
    Data = {116522}
  },
  V240UpdateDate = {
    Key = "V240UpdateDate",
    CnID = "常量@240版本更新日期",
    Data = {1763341200}
  },
  DailyChallengeRevisionRewardCompensation = {
    Key = "DailyChallengeRevisionRewardCompensation",
    CnID = "常量@深潜段位改版结算补偿",
    Data = {
      {
        74093,
        2,
        10108,
        50000
      },
      {
        74093,
        3,
        10108,
        65000
      },
      {
        74093,
        4,
        10108,
        80000
      },
      {
        74093,
        5,
        74143,
        1,
        10108,
        100000
      },
      {
        74093,
        6,
        74143,
        2,
        67377,
        1,
        10108,
        120000
      },
      {
        74093,
        7,
        74143,
        3,
        67377,
        2,
        10108,
        150000
      }
    }
  },
  PerfectRewardCompensation = {
    Key = "PerfectRewardCompensation",
    CnID = "常量@三星补偿关卡",
    Data = {
      2,
      3,
      10
    }
  },
  DailyMaterialPerfectRewardTaskGroup = {
    Key = "DailyMaterialPerfectRewardTaskGroup",
    CnID = "常量@融蚀之墟三星成就任务组",
    Data = {
      118877,
      118842,
      118826,
      118835,
      118852,
      118917,
      118879,
      118907,
      118873,
      118871
    }
  },
  TrinketCopyPerfectRewardTaskGroup = {
    Key = "TrinketCopyPerfectRewardTaskGroup",
    CnID = "常量@禁忌纂录三星成就任务组",
    Data = {
      118922,
      118837,
      118856,
      118918,
      118799,
      118845,
      118809,
      118881
    }
  },
  WeekBossChallengePerfectRewardTaskGroup = {
    Key = "WeekBossChallengePerfectRewardTaskGroup",
    CnID = "常量@超验存在三星成就任务组",
    Data = {
      118860,
      118821,
      118791,
      118913,
      118892,
      118787,
      118796,
      118915
    }
  },
  PVPRewardTask = {
    Key = "PVPRewardTask",
    CnID = "常量@相位对弈的对弈纪录的任务",
    Data = {
      118988,
      119005,
      118979,
      119010
    }
  },
  PVPPreconModeRewardMaxLevel = {
    Key = "PVPPreconModeRewardMaxLevel",
    CnID = "常量@预组奖励的等级上限",
    Data = 45
  },
  PVPPreconModeRewardExp = {
    Key = "PVPPreconModeRewardExp",
    CnID = "常量@预组奖励的经验道具",
    Data = {119012}
  },
  PVPPreconModeRewardEXPRequired = {
    Key = "PVPPreconModeRewardEXPRequired",
    CnID = "常量@预组奖励的等级所需经验",
    Data = {
      1,
      5,
      250,
      6,
      100000,
      500
    }
  },
  PVPPreconModeRewardRewardItem = {
    Key = "PVPPreconModeRewardRewardItem",
    CnID = "常量@预组奖励的等级奖励",
    Data = {
      9567,
      250,
      9567,
      250
    }
  },
  PVPPreconModeFightStyleExp = {
    Key = "PVPPreconModeFightStyleExp",
    CnID = "常量@预组模式的战斗风格经验",
    Data = {119012, 250}
  },
  PVPPreconModeScoreExp = {
    Key = "PVPPreconModeScoreExp",
    CnID = "常量@预组模式的积分加成经验",
    Data = {
      119012,
      10000,
      0.025
    }
  },
  PVPPreconModeExpFailureCoefficient = {
    Key = "PVPPreconModeExpFailureCoefficient",
    CnID = "常量@预组模式的预组经验失败系数",
    Data = 0.5
  },
  PVPDraftPickModeRewardMaxLevel = {
    Key = "PVPDraftPickModeRewardMaxLevel",
    CnID = "常量@轮选奖励的等级上限",
    Data = 45
  },
  PVPDraftPickModeRewardExp = {
    Key = "PVPDraftPickModeRewardExp",
    CnID = "常量@轮选奖励的经验道具",
    Data = {119011}
  },
  PVPDraftPickModeRewardEXPRequired = {
    Key = "PVPDraftPickModeRewardEXPRequired",
    CnID = "常量@轮选奖励的等级所需经验",
    Data = {
      1,
      5,
      250,
      6,
      100000,
      500
    }
  },
  PVPDraftPickModeRewardRewardItem = {
    Key = "PVPDraftPickModeRewardRewardItem",
    CnID = "常量@轮选奖励的等级奖励",
    Data = {
      9567,
      250,
      9567,
      250
    }
  },
  PVPDraftPickModeFightStyleExp = {
    Key = "PVPDraftPickModeFightStyleExp",
    CnID = "常量@轮选模式的战斗风格经验",
    Data = {119011, 250}
  },
  PVPDraftPickModeScoreExp = {
    Key = "PVPDraftPickModeScoreExp",
    CnID = "常量@轮选模式的积分加成经验",
    Data = {
      119011,
      10000,
      0.025
    }
  },
  PVPDraftPickModeExpFailureCoefficient = {
    Key = "PVPDraftPickModeExpFailureCoefficient",
    CnID = "常量@轮选模式的轮选经验失败系数",
    Data = 0.5
  },
  DailyChallengeBasicScore = {
    Key = "DailyChallengeBasicScore",
    CnID = "常量@幻梦深潜难度基础分数",
    Data = {1000}
  },
  PVPSneakState = {
    Key = "PVPSneakState",
    CnID = "常量@PVP潜行状态",
    Data = {97251}
  },
  PVPTauntState = {
    Key = "PVPTauntState",
    CnID = "常量@PVP嘲讽状态",
    Data = {19535}
  },
  KeyShortNameDownLoadOverTimeLimit = {
    Key = "KeyShortNameDownLoadOverTimeLimit",
    CnID = "常量@多语言短Key下载超时限制",
    Data = {300}
  },
  Aniversary2ndTaskActivityTid = {
    Key = "Aniversary2ndTaskActivityTid",
    CnID = "常量@2周年200抽活动Tid",
    Data = {119694}
  },
  PrimalSoulCoreItem = {
    Key = "PrimalSoulCoreItem",
    CnID = "常量@原初灵核道具",
    Data = {25218}
  },
  DailyChallengeExpRatioDecreaseDifficluty1 = {
    Key = "DailyChallengeExpRatioDecreaseDifficluty1",
    CnID = "常量@幻梦深潜难度1经验减少系数",
    Data = {
      20,
      -0.1,
      30,
      -0.3,
      40,
      -0.5,
      50,
      -0.5
    }
  },
  DailyChallengeExpRatioDecreaseDifficluty2 = {
    Key = "DailyChallengeExpRatioDecreaseDifficluty2",
    CnID = "常量@幻梦深潜难度2经验减少系数",
    Data = {
      30,
      -0.1,
      40,
      -0.3,
      50,
      -0.5,
      60,
      -0.5
    }
  },
  DailyChallengeExpRatioDecreaseDifficluty3 = {
    Key = "DailyChallengeExpRatioDecreaseDifficluty3",
    CnID = "常量@幻梦深潜难度3经验减少系数",
    Data = {
      40,
      -0.1,
      50,
      -0.3,
      60,
      -0.5,
      70,
      -0.5
    }
  },
  DailyChallengeExpRatioDecreaseDifficluty4 = {
    Key = "DailyChallengeExpRatioDecreaseDifficluty4",
    CnID = "常量@幻梦深潜难度4经验减少系数",
    Data = {
      50,
      -0.1,
      60,
      -0.3,
      70,
      -0.5,
      80,
      -0.5
    }
  },
  DailyChallengeExpRatioDecreaseDifficluty5 = {
    Key = "DailyChallengeExpRatioDecreaseDifficluty5",
    CnID = "常量@幻梦深潜难度5经验减少系数",
    Data = {
      60,
      -0.1,
      70,
      -0.3,
      80,
      -0.5
    }
  },
  DailyChallengeExpRatioDecreaseDifficluty6 = {
    Key = "DailyChallengeExpRatioDecreaseDifficluty6",
    CnID = "常量@幻梦深潜难度6经验减少系数",
    Data = {
      70,
      -0.1,
      80,
      -0.3
    }
  },
  DailyChallengeExpRatioDecreaseDifficluty7 = {
    Key = "DailyChallengeExpRatioDecreaseDifficluty7",
    CnID = "常量@幻梦深潜难度7经验减少系数",
    Data = {80, -0.1}
  },
  DailyChallengeExpRatioDecreaseDifficluty8 = {
    Key = "DailyChallengeExpRatioDecreaseDifficluty8",
    CnID = "常量@幻梦深潜难度8经验减少系数"
  },
  DailyChallengeTaskGroup = {
    Key = "DailyChallengeTaskGroup",
    CnID = "常量@幻梦深潜生涯任务",
    Data = {
      120885,
      120868,
      120876
    }
  },
  CareerLevelType = {
    Key = "CareerLevelType",
    CnID = "常量@生涯等级类型",
    Data = {
      1,
      118305,
      2,
      119012,
      3,
      119011,
      4,
      129498
    }
  },
  DailyChallengedRewardAttenuationItem = {
    Key = "DailyChallengedRewardAttenuationItem",
    CnID = "常量@幻梦深潜奖励衰减的道具",
    Data = {118305}
  },
  DailyChallengedSelecStageLevel = {
    Key = "DailyChallengedSelecStageLevel",
    CnID = "常量@幻梦深潜选择关卡难度",
    Data = 121205
  },
  DailyChallengeExampleStage = {
    Key = "DailyChallengeExampleStage",
    CnID = "常量@幻梦深潜关卡例子",
    Data = 8145
  },
  DailyChallengeRankingListStartSeason = {
    Key = "DailyChallengeRankingListStartSeason",
    CnID = "常量@幻梦深潜赛季排行榜起始赛季",
    Data = {16648}
  },
  DailyChallengeRandomMonsterIcon = {
    Key = "DailyChallengeRandomMonsterIcon",
    CnID = "常量@幻梦深潜随机怪物图标",
    Data = {
      "Portraits/Minihead/Portrait_Small_Monster_S0001.png"
    }
  },
  DailyChallengedExpRewardCoefficientLevel = {
    Key = "DailyChallengedExpRewardCoefficientLevel",
    CnID = "常量@幻梦深潜经验值衰减等级",
    Data = {
      20,
      2,
      40,
      1
    }
  },
  WeeklyRecCommonRoleList = {
    Key = "WeeklyRecCommonRoleList",
    CnID = "常量@幻梦深潜每周推荐非限定名单",
    Data = {
      15588,
      15585,
      15571,
      15568,
      15570,
      15569,
      15560,
      15580,
      15565,
      15595,
      15575,
      15592,
      15594,
      15564,
      15573,
      15566,
      15591,
      15598,
      15587,
      15600,
      15577,
      15597,
      15574,
      15603,
      15572,
      15593,
      15562,
      15579
    }
  },
  WeeklyRecSpecialRoleList = {
    Key = "WeeklyRecSpecialRoleList",
    CnID = "常量@幻梦深潜每周推荐限定名单",
    Data = {
      15563,
      15590,
      15584,
      15581,
      15576,
      15586,
      15599,
      15601,
      15596,
      15582,
      15583,
      15604,
      54117,
      15567,
      54116,
      15602,
      77925,
      77922,
      77923,
      95786,
      77913,
      77926,
      77917,
      15589,
      94450,
      125346,
      130901,
      77918,
      130226,
      141302,
      145363,
      77921,
      94451,
      147397,
      130384,
      78754
    }
  },
  LastRecRoleInit = {
    Key = "LastRecRoleInit",
    CnID = "常量@幻梦深潜最近每周推荐初始化名单",
    Data = {
      {15595, 14},
      {15566, 13},
      {15597, 14},
      {15562, 13},
      {15568, 15},
      {15594, 14},
      {15598, 13},
      {15586, 14},
      {54116, 3},
      {15589, 16},
      {15600, 16},
      {15585, 16},
      {15576, 13},
      {15584, 4},
      {77923, 13},
      {15570, 5},
      {15563, 12},
      {15579, 14},
      {15581, 6},
      {15573, 15},
      {15596, 6},
      {15593, 15},
      {94450, 7},
      {15577, 15},
      {15574, 16},
      {15569, 8},
      {77922, 14},
      {15565, 9},
      {15575, 16},
      {95786, 9},
      {15590, 9},
      {15560, 10},
      {15582, 15},
      {15599, 10},
      {77925, 10},
      {77913, 11},
      {125346, 12},
      {77917, 11},
      {15588, 11},
      {15592, 11},
      {15591, 11},
      {15603, 11},
      {54117, 12},
      {15583, 16},
      {15571, 12},
      {15564, 12},
      {15587, 12},
      {15572, 12},
      {15604, 13},
      {15567, 13},
      {15580, 13},
      {15602, 14},
      {77926, 16},
      {15601, 16}
    }
  },
  WeeklyRecRolePoolMinLastTime = {
    Key = "WeeklyRecRolePoolMinLastTime",
    CnID = "常量@幻梦深潜每周推荐角色卡池最小持续时间",
    Data = {21}
  },
  CardReviewWordLimit = {
    Key = "CardReviewWordLimit",
    CnID = "常量@卡牌评论字数限制",
    Data = 400
  },
  ThreatVisualSaveColor = {
    Key = "ThreatVisualSaveColor",
    CnID = "常量@威胁可视化安全字色",
    Data = {"8bdab1"}
  },
  ThreatVisualDangerColor = {
    Key = "ThreatVisualDangerColor",
    CnID = "常量@威胁可视化危险字色",
    Data = {"d77376"}
  },
  ThreatVisualUnKnownColor = {
    Key = "ThreatVisualUnKnownColor",
    CnID = "常量@威胁可视化未知字色",
    Data = {"c485d2"}
  },
  ThreatVisualBloodSaveColor = {
    Key = "ThreatVisualBloodSaveColor",
    CnID = "常量@威胁可视化血条预增加颜色",
    Data = {"52BF63"}
  },
  ThreatVisualBloodDangerColor = {
    Key = "ThreatVisualBloodDangerColor",
    CnID = "常量@威胁可视化血条预扣除颜色",
    Data = {"8d4b4d"}
  },
  ThreatVisualShieldSaveColor = {
    Key = "ThreatVisualShieldSaveColor",
    CnID = "常量@威胁可视化护盾预增加颜色",
    Data = {"79DE7A"}
  },
  ThreatVisualShieldDangerColor = {
    Key = "ThreatVisualShieldDangerColor",
    CnID = "常量@威胁可视化护盾预扣除颜色",
    Data = {"E47C79"}
  },
  ThreatPlayerBarrierStateTid = {
    Key = "ThreatPlayerBarrierStateTid",
    CnID = "常量@威胁可视化玩家屏障状态id",
    Data = {3332}
  },
  MaxBacktrackRounds = {
    Key = "MaxBacktrackRounds",
    CnID = "常量@时序逆行回溯回合数",
    Data = {25}
  },
  AvgLongCapAutoDefaultDuration = {
    Key = "AvgLongCapAutoDefaultDuration",
    CnID = "常量@Avg长字幕自动播放的默认间隔时间",
    Data = 4
  },
  ReturnPopupAvg = {
    Key = "ReturnPopupAvg",
    CnID = "常量@弹出回归剧情",
    Data = {119922, 119923}
  },
  ReturnPopupAvgJumpto = {
    Key = "ReturnPopupAvgJumpto",
    CnID = "常量@回归剧情结束跳转活动",
    Data = 53729
  },
  CommonUseBattleHelpNumLimit = {
    Key = "CommonUseBattleHelpNumLimit",
    CnID = "常量@常用助战数量上限",
    Data = {10}
  },
  SupportListLatestTipsRatio = {
    Key = "SupportListLatestTipsRatio",
    CnID = "常量@助战列表刷新后需要弹提示的重复比例",
    Data = {80}
  },
  LanguageKey_CN = {
    Key = "LanguageKey_CN",
    CnID = "常量@多语言标识语言包_CN",
    Data = {
      "简体中文"
    }
  },
  LanguageKey_TW = {
    Key = "LanguageKey_TW",
    CnID = "常量@多语言标识语言包_TW",
    Data = {
      "繁體中文"
    }
  },
  LanguageKey_EN = {
    Key = "LanguageKey_EN",
    CnID = "常量@多语言标识语言包_EN",
    Data = {
      "English (beta)"
    }
  },
  LanguageKey_JP = {
    Key = "LanguageKey_JP",
    CnID = "常量@多语言标识语言包_JP",
    Data = {
      "日本語 (alpha)"
    }
  },
  LanguageKey_KR = {
    Key = "LanguageKey_KR",
    CnID = "常量@多语言标识语言包_KR",
    Data = {
      "한국어 (alpha)"
    }
  },
  LanguageKey_ID = {
    Key = "LanguageKey_ID",
    CnID = "常量@多语言标识语言包_ID",
    Data = {
      "Bahasa Indonesia (alpha)"
    }
  },
  LanguageKey_VN = {
    Key = "LanguageKey_VN",
    CnID = "常量@多语言标识语言包_VN",
    Data = {
      "Tiếng Việt (alpha)"
    }
  },
  LanguageKey_TH = {
    Key = "LanguageKey_TH",
    CnID = "常量@多语言标识语言包_TH",
    Data = {
      "ภาษาไทย (alpha)"
    }
  },
  LanguageKey_PT = {
    Key = "LanguageKey_PT",
    CnID = "常量@多语言标识语言包_PT",
    Data = {
      "Português (alpha)"
    }
  },
  LanguageKey_ES = {
    Key = "LanguageKey_ES",
    CnID = "常量@多语言标识语言包_ES",
    Data = {
      "Español (alpha)"
    }
  },
  LanguageKey_FR = {
    Key = "LanguageKey_FR",
    CnID = "常量@多语言标识语言包_FR",
    Data = {
      "Français (alpha)"
    }
  },
  LanguageKey_DE = {
    Key = "LanguageKey_DE",
    CnID = "常量@多语言标识语言包_DE",
    Data = {
      "Deutsch (alpha)"
    }
  },
  LanguageKey_RU = {
    Key = "LanguageKey_RU",
    CnID = "常量@多语言标识语言包_RU",
    Data = {
      "Русский (alpha)"
    }
  },
  LanguageKey_IT = {
    Key = "LanguageKey_IT",
    CnID = "常量@多语言标识语言包_IT",
    Data = {
      "Italiano (alpha)"
    }
  },
  LanguageKey_TR = {
    Key = "LanguageKey_TR",
    CnID = "常量@多语言标识语言包_TR",
    Data = {
      "Türkçe (alpha)"
    }
  },
  LanguageKey_BN = {
    Key = "LanguageKey_BN",
    CnID = "常量@多语言标识语言包_BN",
    Data = {
      "বাংলা (alpha)"
    }
  },
  StageGroupUnlockFeature = {
    Key = "StageGroupUnlockFeature",
    CnID = "常量@关卡组在活动期间无视解锁条件并解锁对应功能",
    Data = {120952}
  },
  Pvp2ndKeeperSkillCollection = {
    Key = "Pvp2ndKeeperSkillCollection",
    CnID = "常量@Pvp收藏两周年拉蒙娜钥令",
    Data = 121139
  },
  DamagePer2HasState = {
    Key = "DamagePer2HasState",
    CnID = "常量@对特定标识敌人伤害百分比修正属性列表",
    Data = {
      "damage_per2enemy_has_weak",
      "damage_per2enemy_has_vulnerable",
      "damage_per2enemy_has_posion",
      "damage_per2enemy_has_frail",
      "damage_per2petrify_resist",
      "damage_per2enemy_has_sculptor",
      "damage_per2enemy_has_mutated",
      "damage_per2enemy_has_snow",
      "damage_per2enemy_has_blood",
      "damage_per2enemy_has_special1"
    }
  },
  PurchaseTimeframe = {
    Key = "PurchaseTimeframe",
    CnID = "常量@商品的连续购买时间限制",
    Data = {
      5,
      {
        61531,
        61529,
        61530
      }
    }
  },
  ShopEnchantAsGift = {
    Key = "ShopEnchantAsGift",
    CnID = "常量@盒中童趣命轮判据",
    Data = {123110}
  },
  RailWayDifficultyExpMultiplier = {
    Key = "RailWayDifficultyExpMultiplier",
    CnID = "常量@疾驰的欢愉专列难度经验倍率",
    Data = {
      1,
      2.5,
      5
    }
  },
  RailWayTaskGroup = {
    Key = "RailWayTaskGroup",
    CnID = "常量@疾驰的欢愉专列生涯任务组",
    Data = {129536, 129534}
  },
  RailWayRewardItem = {
    Key = "RailWayRewardItem",
    CnID = "常量@疾驰的欢愉专列经验道具",
    Data = {129498}
  },
  PermanentActivity = {
    Key = "PermanentActivity",
    CnID = "常量@活动结束后常驻",
    Data = {129488}
  },
  RailWayTheRandomNodeType = {
    Key = "RailWayTheRandomNodeType",
    CnID = "常量@疾驰的欢愉专列@随机型节点",
    Data = 116420
  },
  RailWayStageGroupTid = {
    Key = "RailWayStageGroupTid",
    CnID = "常量@关卡组-疾驰的欢愉专列",
    Data = 129175
  },
  MultiBossLinearStageGroup = {
    Key = "MultiBossLinearStageGroup",
    CnID = "常量@多首领线性关卡组",
    Data = 129175
  },
  SaveAneExitLimitTime = {
    Key = "SaveAneExitLimitTime",
    CnID = "常量@主动保存并退出最大时长",
    Data = {604800}
  },
  RailWayDeductPointsItem = {
    Key = "RailWayDeductPointsItem",
    CnID = "常量@疾驰的欢愉专列应急灵知体扣分道具",
    Data = {129498, 0.2}
  },
  RailWayActivityRemainRewardHideItems = {
    Key = "RailWayActivityRemainRewardHideItems",
    CnID = "常量@火车活动剩余奖励隐藏道具",
    Data = {129498, 129143}
  },
  OSLoginReward_PC = {
    Key = "OSLoginReward_PC",
    CnID = "常量@PC端登录奖励",
    Data = {
      9802,
      1,
      127525,
      1
    }
  },
  OSLoginReward_MOBILE = {
    Key = "OSLoginReward_MOBILE",
    CnID = "常量@移动端登录奖励",
    Data = {
      9802,
      1,
      127524,
      1
    }
  },
  ReplayDownloadTime = {
    Key = "ReplayDownloadTime",
    CnID = "常量@录像下载时间",
    Data = 30
  },
  NewChaosSchoolAwakerList = {
    Key = "NewChaosSchoolAwakerList",
    CnID = "常量@新混沌唤醒体列表",
    Data = {145363, 94451}
  },
  NewOceanSchoolAwakerList = {
    Key = "NewOceanSchoolAwakerList",
    CnID = "常量@新深海唤醒体列表",
    Data = {
      15589,
      130901,
      141302
    }
  },
  NewBloodSchoolAwakerList = {
    Key = "NewBloodSchoolAwakerList",
    CnID = "常量@新血肉唤醒体列表",
    Data = {130226, 77921}
  },
  NewDimensionSchoolAwakerList = {
    Key = "NewDimensionSchoolAwakerList",
    CnID = "常量@新超维唤醒体列表",
    Data = {77918}
  },
  FilterMaxAwakerCount = {
    Key = "FilterMaxAwakerCount",
    CnID = "常量@筛选唤醒体最大数量",
    Data = 4
  },
  BPSeniorDoubleDailyRewardItem = {
    Key = "BPSeniorDoubleDailyRewardItem",
    CnID = "常量@核心课题每日试训双倍奖励道具",
    Data = {
      9719,
      9556,
      9567,
      36863
    }
  },
  BPExtraRewardMagnification = {
    Key = "BPExtraRewardMagnification",
    CnID = "常量@核心课题每日试训额外奖励倍率",
    Data = {3}
  },
  GuideNoteDailyActivityItem = {
    Key = "GuideNoteDailyActivityItem",
    CnID = "常量@日活跃度道具",
    Data = {132702}
  },
  GuideNoteWeeklyActivityItem = {
    Key = "GuideNoteWeeklyActivityItem",
    CnID = "常量@周活跃度道具",
    Data = {132701}
  },
  GuideNoteDailyActivityTierRewards = {
    Key = "GuideNoteDailyActivityTierRewards",
    CnID = "常量@日活跃度阶阶段性奖励",
    Data = {
      250,
      {
        36863,
        1,
        9607,
        300
      },
      500,
      {
        9719,
        1,
        9607,
        300
      },
      750,
      {
        9556,
        500,
        9607,
        300
      },
      1000,
      {
        9567,
        60,
        9607,
        300
      }
    }
  },
  GuideNoteWeeklyActivityTierRewards = {
    Key = "GuideNoteWeeklyActivityTierRewards",
    CnID = "常量@周活跃度阶阶段性奖励",
    Data = {
      250,
      {
        9719,
        5,
        9607,
        1500
      },
      500,
      {
        9542,
        10000,
        9607,
        1500
      },
      750,
      {
        9719,
        5,
        9607,
        1500
      },
      1000,
      {
        9567,
        500,
        9607,
        1500
      }
    }
  },
  BPLimitItem = {
    Key = "BPLimitItem",
    CnID = "常量@课题纪录限时道具",
    Data = {132905}
  },
  LoginPlatformActivity = {
    Key = "LoginPlatformActivity",
    CnID = "常量@平台登录常驻活动",
    Data = 132688
  },
  AbyssPlayerNameStageTidList = {
    Key = "AbyssPlayerNameStageTidList",
    CnID = "常量@融蚀玩家名关卡列表"
  },
  BPLimitItemTransMail = {
    Key = "BPLimitItemTransMail",
    CnID = "邮件@空幻之芯过期转换邮件",
    Data = 133703
  },
  BPLimitItemTransTipTime = {
    Key = "BPLimitItemTransTipTime",
    CnID = "常量@空幻之芯过期转换提示时间",
    Data = {3}
  },
  BPLimitItemTransTipMail = {
    Key = "BPLimitItemTransTipMail",
    CnID = "常量@空幻之芯过期提示邮件",
    Data = 133704
  },
  AbyssChallengeNoCountdownScore = {
    Key = "AbyssChallengeNoCountdownScore",
    CnID = "常量@不再显示倒计时的特训值",
    Data = 100
  },
  MobileDeviceLocationInVisibleTaskList = {
    Key = "MobileDeviceLocationInVisibleTaskList",
    CnID = "常量@移动设备跳转按钮不可见的任务列表",
    Data = {132691}
  },
  PcDeviceLocationInVisibleTaskList = {
    Key = "PcDeviceLocationInVisibleTaskList",
    CnID = "常量@Pc设备跳转按钮不可见的任务列表",
    Data = {132690}
  },
  FateCutState = {
    Key = "FateCutState",
    CnID = "常量@命运裁断状态",
    Data = 134285
  },
  BacktrackSkipClearOriginItemBpIds = {
    Key = "BacktrackSkipClearOriginItemBpIds",
    CnID = "常量@时间原点跳过回收的通行证周期",
    Data = {
      127083,
      127078,
      127076,
      127079
    }
  },
  AwakerOverflowCraftLimitConversion = {
    Key = "AwakerOverflowCraftLimitConversion",
    CnID = "常量@次数限制为唤醒体溢出次数的炼金配方",
    Data = 137644
  },
  WeaponDecompositionCraftLimitConversion = {
    Key = "WeaponDecompositionCraftLimitConversion",
    CnID = "常量@次数限制为命轮分解次数的配方",
    Data = 137643
  },
  ConversionRedPoint = {
    Key = "ConversionRedPoint",
    CnID = "常量@可合成时需要红点的配方",
    Data = {132680, 132681}
  },
  CollectionHallTaskChangeErrCompatible = {
    Key = "CollectionHallTaskChangeErrCompatible",
    CnID = "常量@典藏馆任务调整类型引起报错处理",
    Data = {
      121476,
      121455,
      121549,
      121593,
      121498,
      121459,
      121579,
      121544,
      121551,
      121501,
      121442,
      121605,
      121528,
      121504,
      121548,
      121479,
      121457,
      121467,
      121446,
      121559,
      121468,
      121493,
      121650,
      121443,
      121478,
      121520,
      121583,
      121522,
      121490,
      121546,
      121565,
      121512,
      121606,
      121573,
      121622,
      121534,
      121477,
      121600,
      121586,
      121517,
      121614,
      121644,
      121543,
      121581,
      121480,
      121458,
      121530,
      121567,
      121595,
      121535,
      121527,
      121577,
      121487,
      121582,
      121620,
      121571,
      121566,
      121545,
      121547,
      121630,
      121461,
      121486,
      121634,
      121450,
      121494,
      121637,
      121563,
      121472,
      121587,
      121466,
      121484,
      121447,
      121597,
      121601,
      121591,
      121645,
      121444,
      121594,
      121596,
      121515,
      121585,
      121529,
      121533,
      121500,
      121635,
      121575,
      121483,
      121460,
      121537,
      121599,
      121602,
      121451,
      121607,
      121584,
      121526,
      121618,
      121542,
      121471,
      121574,
      121538,
      121464,
      121509,
      121488,
      121649,
      121641,
      121495,
      121553,
      121646,
      121588,
      121481,
      121628,
      121475,
      121492,
      121626,
      121638,
      121485,
      121516,
      121627,
      121448,
      121523,
      121496,
      121452,
      121611,
      121518,
      121505,
      121570,
      121510,
      121521,
      121568,
      121598,
      121454,
      121456,
      121613,
      121482,
      121554,
      121578,
      121558,
      121632,
      121564,
      121557,
      121642,
      121589,
      121507,
      121508,
      121603,
      121497,
      121513,
      121615,
      121540,
      121465,
      121536,
      121604,
      121470,
      121576,
      121647,
      121502,
      121469,
      121555,
      121590,
      121623,
      121617,
      121449,
      121569,
      121639,
      121562,
      121629,
      121621,
      121524,
      121473,
      121489,
      121462,
      121541,
      121550,
      121572,
      121624,
      121580,
      121608,
      121643,
      121625,
      121560,
      121503,
      121648,
      121616,
      121552,
      121445,
      121463,
      121609,
      121612,
      121631,
      121610,
      121499,
      121556,
      121519,
      121511,
      121453,
      121633,
      121592,
      121619,
      121474,
      121514,
      121640,
      121525,
      121636,
      121561,
      121491,
      121506,
      121531,
      121532,
      121539
    }
  },
  DiamondExchangeLimit = {
    Key = "DiamondExchangeLimit",
    CnID = "常量@次数限制为历史源液提取数量的商品",
    Data = 140285
  },
  TwoAndAHalfAnniversaryRAIDActiviityWorldTarget = {
    Key = "TwoAndAHalfAnniversaryRAIDActiviityWorldTarget",
    CnID = "常量@2.5周年RAID活动进度任务",
    Data = {139646}
  },
  ItemGainSilence = {
    Key = "ItemGainSilence",
    CnID = "常量@不弹出获得物资弹窗的道具",
    Data = {
      140512,
      140511,
      140510
    }
  },
  ExclusiveStoryGroups = {
    Key = "ExclusiveStoryGroups",
    CnID = "常量@溯梦互斥剧情组",
    Data = {
      {62167, 62168},
      {62169, 62166},
      {62164, 62163}
    }
  },
  QueryRankCdSeconds = {
    Key = "QueryRankCdSeconds",
    CnID = "常量@排行榜数据请求CD限制",
    Data = 1
  },
  QueryRankMaxPageSize = {
    Key = "QueryRankMaxPageSize",
    CnID = "常量@排行榜单页可查看人数限制",
    Data = 100
  },
  QueryRankMaxStartIndex = {
    Key = "QueryRankMaxStartIndex",
    CnID = "常量@排行榜可查看人数限制",
    Data = 2000
  },
  DailyChallengeTaskReplace = {
    Key = "DailyChallengeTaskReplace",
    CnID = "常量@深潜评分项任务替换",
    Data = {
      {
        144311,
        1791766800,
        122411
      }
    }
  },
  SelectDropDefaultShowCard = {
    Key = "SelectDropDefaultShowCard",
    CnID = "常量@选择卡包_默认虚拟卡",
    Data = 144442
  },
  ShopBulkBuyConfirmThreshold = {
    Key = "ShopBulkBuyConfirmThreshold",
    CnID = "常量@大额兑换二次确认阈值",
    Data = {
      {9615, 500},
      {20482, 10000},
      {20481, 10000},
      {9542, 10000},
      {9567, 10000},
      {10108, 1000000}
    }
  },
  RandUnlockKeeperSkillExcludeList = {
    Key = "RandUnlockKeeperSkillExcludeList",
    CnID = "常量@新混沌_特殊钥令列表",
    Data = {
      47996,
      89949,
      146484,
      145995,
      145989,
      145993,
      145992,
      145991,
      145988,
      145990,
      146517,
      146519
    }
  },
  LanguageReplaceTime = {
    Key = "LanguageReplaceTime",
    CnID = "常量@多语言指定时间替换",
    Data = {
      {
        "DailyChallengeInstructionsV2",
        1791766800,
        "DailyChallengeInstructions"
      },
      {
        "RailWayStageCrazyMileExpGetDescV2",
        1790557200,
        "RailWayStageCrazyMileExpGetDesc"
      },
      {
        "RailWayStageCrazyNowDescV2",
        1790557200,
        "RailWayStageCrazyNowDesc"
      },
      {
        "RailWayStageDifficultyBuffContent3V2",
        1790557200,
        "RailWayStageDifficultyBuffContent3"
      },
      {
        "RailWayRulesContentV2",
        1790557200,
        "RailWayRulesContent"
      },
      {
        "AbyssChallengeTipsV2",
        1788138000,
        "AbyssChallengeTips"
      }
    }
  },
  BattleWinConfirmStateList = {
    Key = "BattleWinConfirmStateList",
    CnID = "常量@怪物胜利需确认的状态",
    Data = {74299}
  },
  StageGroupTypeRespawnCost = {
    Key = "StageGroupTypeRespawnCost",
    CnID = "常量@复活时消耗应急灵知体数量",
    Data = {21, 3}
  },
  AwakerFavorFrameShowLevel = {
    Key = "AwakerFavorFrameShowLevel",
    CnID = "常量@显示曜闪至臻卡牌所需同调等级",
    Data = 20
  },
  BlessingCardType = {
    Key = "BlessingCardType",
    CnID = "常量@卡拉布赐福卡标记",
    Data = 149947
  }
})
return Constant
