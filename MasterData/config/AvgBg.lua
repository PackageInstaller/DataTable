local System = require("System.System")
local readonly = System.readonly
local AvgBg = readonly({
  SScene_SchoolDaytime = {
    ID = "SScene_SchoolDaytime",
    CnID = "学院_日",
    BaseSortID = 1,
    Res = "Scenebg/SScene_SchoolDaytime.png"
  },
  SScene_SchoolDust = {
    ID = "SScene_SchoolDust",
    CnID = "学院_傍晚",
    BaseSortID = 2,
    Res = "Scenebg/SScene_SchoolDust.png"
  },
  SScene_SchoolNight = {
    ID = "SScene_SchoolNight",
    CnID = "学院_夜",
    BaseSortID = 3,
    Res = "Scenebg/SScene_SchoolNight.png"
  },
  SScene_Almshouse = {
    ID = "SScene_Almshouse",
    CnID = "济贫院内",
    BaseSortID = 4,
    Res = "Scenebg/SScene_Almshouse.png"
  },
  SScene_OfficeNight = {
    ID = "SScene_OfficeNight",
    CnID = "通用办公室_夜",
    BaseSortID = 5,
    Res = "Scenebg/SScene_OfficeNight.png"
  },
  SScene_Corridor = {
    ID = "SScene_Corridor",
    CnID = "走廊",
    BaseSortID = 6,
    Res = "Scenebg/SScene_Corridor.png"
  },
  SScene_CourtYard = {
    ID = "SScene_CourtYard",
    CnID = "济贫院前院",
    BaseSortID = 7,
    Res = "Scenebg/SScene_CourtYard.png"
  },
  SScene_LondonDaytime = {
    ID = "SScene_LondonDaytime",
    CnID = "伦敦街头_日",
    BaseSortID = 8,
    Res = "Scenebg/SScene_LondonDaytime.png"
  },
  SScene_LondonNight = {
    ID = "SScene_LondonNight",
    CnID = "伦敦街头_夜",
    BaseSortID = 9,
    Res = "Scenebg/SScene_LondonNight.png"
  },
  SScene_LondonFog = {
    ID = "SScene_LondonFog",
    CnID = "伦敦街头_夜雾",
    BaseSortID = 10,
    Res = "Scenebg/SScene_LondonFog.png"
  },
  DOG_ACTION = {
    ID = "DOG_ACTION",
    CnID = "背景1",
    BaseSortID = 11,
    Res = "UIResources/UIView/Dialog/DogAction1.prefab"
  },
  SScene_Black = {
    ID = "SScene_Black",
    CnID = "黑底",
    BaseSortID = 12,
    Res = "Scenebg/SScene_Black.png"
  },
  SScene_YardDay = {
    ID = "SScene_YardDay",
    CnID = "济贫院外_日",
    BaseSortID = 13,
    Res = "Scenebg/SScene_YardDay.png"
  },
  SScene_YardNight = {
    ID = "SScene_YardNight",
    CnID = "济贫院外_夜",
    BaseSortID = 14,
    Res = "Scenebg/SScene_YardNight.png"
  },
  SScene_YardRedMoon = {
    ID = "SScene_YardRedMoon",
    CnID = "济贫院外_血月",
    BaseSortID = 15,
    Res = "Scenebg/SScene_YardRedMoon.png"
  },
  SScene_SubLab = {
    ID = "SScene_SubLab",
    CnID = "济贫院地下实验室",
    BaseSortID = 16,
    Res = "Scenebg/SScene_SubLab.png"
  },
  SScene_White = {
    ID = "SScene_White",
    CnID = "白底",
    BaseSortID = 17,
    Res = "Scenebg/SScene_White.png"
  },
  SScene_ClockTower = {
    ID = "SScene_ClockTower",
    CnID = "济贫院钟楼",
    BaseSortID = 18,
    Res = "Scenebg/SScene_ClockTower.png"
  },
  SScene_AlmsRoomDay = {
    ID = "SScene_AlmsRoomDay",
    CnID = "济贫院房间_日",
    BaseSortID = 19,
    Res = "Scenebg/SScene_AlmsRoomDay.png"
  },
  SScene_AlmsRoomNight = {
    ID = "SScene_AlmsRoomNight",
    CnID = "济贫院房间_夜",
    BaseSortID = 20,
    Res = "Scenebg/SScene_AlmsRoomNight.png"
  },
  SScene_CG_Test_1 = {
    ID = "SScene_CG_Test_1",
    CnID = "主线剧情背景_CG_测试1",
    BaseSortID = 21,
    Res = "Scenebg/SScene_CG_Test_1.png"
  },
  SScene_WaxRoom = {
    ID = "SScene_WaxRoom",
    CnID = "蜡像馆陈列室",
    BaseSortID = 22,
    Res = "Scenebg/SScene_WaxRoom.png"
  },
  SScene_WaxWorkRm = {
    ID = "SScene_WaxWorkRm",
    CnID = "蜡像馆工作室",
    BaseSortID = 23,
    Res = "Scenebg/SScene_WaxWorkRm.png"
  },
  SScene_ExhibitionSp_Normal = {
    ID = "SScene_ExhibitionSp_Normal",
    CnID = "蜡像馆馆长室",
    BaseSortID = 24,
    Res = "Scenebg/SScene_ExhibitionSp_Normal.png"
  },
  SScene_WaxUnderground = {
    ID = "SScene_WaxUnderground",
    CnID = "地下室",
    BaseSortID = 25,
    Res = "Scenebg/SScene_WaxUnderground.png"
  },
  SScene_WaxUnderground_Corrision = {
    ID = "SScene_WaxUnderground_Corrision",
    CnID = "蜡像馆地下室",
    BaseSortID = 26,
    Res = "Scenebg/SScene_WaxUnderground_Corrosion.png"
  },
  SScene_WaxDoor = {
    ID = "SScene_WaxDoor",
    CnID = "蜡像馆正门",
    BaseSortID = 27,
    Res = "Scenebg/SScene_WaxDoor.png"
  },
  SScene_RestrictedArea = {
    ID = "SScene_RestrictedArea",
    CnID = "研究院地底",
    BaseSortID = 28,
    Res = "Scenebg/SScene_RestrictedArea.png"
  },
  SScene_IllusionSpace = {
    ID = "SScene_IllusionSpace",
    CnID = "幻象空间",
    BaseSortID = 29,
    Res = "Scenebg/SScene_IllusionSpace.png"
  },
  SScene_IllusionWhite = {
    ID = "SScene_IllusionWhite",
    CnID = "白色幻境",
    BaseSortID = 30,
    Res = "Scenebg/SScene_IllusionWhite.png"
  },
  SScene_TownsST_Day = {
    ID = "SScene_TownsST_Day",
    CnID = "拉伊小镇_日",
    BaseSortID = 31,
    Res = "Scenebg/SScene_TownsST_Day.png"
  },
  SScene_TownST_Night = {
    ID = "SScene_TownST_Night",
    CnID = "拉伊小镇_夜",
    BaseSortID = 32,
    Res = "Scenebg/SScene_TownST_Night.png"
  },
  SScene_DaffodilShop_Normal = {
    ID = "SScene_DaffodilShop_Normal",
    CnID = "达芙黛尔的小店_正常",
    BaseSortID = 33,
    Res = "Scenebg/SScene_DaffodilShop_Normal.png"
  },
  SScene_DaffodilShop_Bones = {
    ID = "SScene_DaffodilShop_Bones",
    CnID = "达芙黛尔的小店_人头",
    BaseSortID = 34,
    Res = "Scenebg/SScene_DaffodilShop_Bones.png"
  },
  SScene_DaffodilShop_Black = {
    ID = "SScene_DaffodilShop_Black",
    CnID = "达芙黛尔的小店_融蚀",
    BaseSortID = 35,
    Res = "Scenebg/SScene_DaffodilShop_Black.png"
  },
  SScene_InsideSubway_Light = {
    ID = "SScene_InsideSubway_Light",
    CnID = "地铁内部_亮",
    BaseSortID = 36,
    Res = "Scenebg/SScene_InsideSubway_Light.png"
  },
  SScene_InsideSubway_Dark = {
    ID = "SScene_InsideSubway_Dark",
    CnID = "地铁内部_暗",
    BaseSortID = 37,
    Res = "Scenebg/SScene_InsideSubway_Dark.png"
  },
  SScene_SnowWind = {
    ID = "SScene_SnowWind",
    CnID = "南极风雪",
    BaseSortID = 38,
    Res = "Scenebg/SScene_SnowWind.png"
  },
  SScene_SnowAltars = {
    ID = "SScene_SnowAltars",
    CnID = "南极祭坛",
    BaseSortID = 39,
    Res = "Scenebg/SScene_SnowAltars.png"
  },
  SScene_SnowCage = {
    ID = "SScene_SnowCage",
    CnID = "南极牢笼",
    BaseSortID = 40,
    Res = "Scenebg/SScene_SnowCage.png"
  },
  SScene_SanatoriumAisle = {
    ID = "SScene_SanatoriumAisle",
    CnID = "疗养院走廊",
    BaseSortID = 41,
    Res = "Scenebg/SScene_SanatoriumAisle.png"
  },
  SScene_SanatoriumOperatingRoom = {
    ID = "SScene_SanatoriumOperatingRoom",
    CnID = "疗养院手术室",
    BaseSortID = 42,
    Res = "Scenebg/SScene_SanatoriumOperatingRoom.png"
  },
  SScene_SanatoriumOperatingRoomInvaded = {
    ID = "SScene_SanatoriumOperatingRoomInvaded",
    CnID = "手术室-入侵",
    BaseSortID = 43,
    Res = "Scenebg/SScene_SanatoriumOperatingRoomInvaded.png"
  },
  SScene_Blood = {
    ID = "SScene_Blood",
    CnID = "剧情背景-溅血",
    BaseSortID = 44,
    Res = "Scenebg/SScene_Blood.png"
  },
  SScene_ExhibitionSp_Diss = {
    ID = "SScene_ExhibitionSp_Diss",
    CnID = "蜡像馆出口",
    BaseSortID = 45,
    Res = "Scenebg/SScene_ExhibitionSp_Diss.png"
  },
  SScene_SchoolPassageway = {
    ID = "SScene_SchoolPassageway",
    CnID = "逃生通道",
    BaseSortID = 46,
    Res = "Scenebg/SScene_SchoolPassageway.png"
  },
  SScene_SchoolOffice = {
    ID = "SScene_SchoolOffice",
    CnID = "校办公室",
    BaseSortID = 47,
    Res = "Scenebg/SScene_SchoolOffice.png"
  },
  SScene_SchoolGraveyard = {
    ID = "SScene_SchoolGraveyard",
    CnID = "校墓园",
    BaseSortID = 48,
    Res = "Scenebg/SScene_SchoolGraveyard.png"
  },
  SScene_SchoolBlackPool = {
    ID = "SScene_SchoolBlackPool",
    CnID = "校黑池",
    BaseSortID = 49,
    Res = "Scenebg/SScene_SchoolBlackPool.png"
  },
  SScene_SilverGate = {
    ID = "SScene_SilverGate",
    CnID = "塔薇在大门前",
    BaseSortID = 50,
    Res = "Scenebg/SScene_SilverGate.png"
  },
  SScene_ExamineRoom = {
    ID = "SScene_ExamineRoom",
    CnID = "诊疗室",
    BaseSortID = 51,
    Res = "Scenebg/SScene_ExamineRoom.png"
  },
  SScene_Woods = {
    ID = "SScene_Woods",
    CnID = "通用小树林",
    BaseSortID = 52,
    Res = "Scenebg/SScene_Woods.png"
  },
  SScene_WoodsNight = {
    ID = "SScene_WoodsNight",
    CnID = "通用小树林_夜",
    BaseSortID = 53,
    Res = "Scenebg/SScene_WoodsNight.png"
  },
  SScene_Ward = {
    ID = "SScene_Ward",
    CnID = "通用病房",
    BaseSortID = 54,
    Res = "Scenebg/SScene_Ward.png"
  },
  SScene_CG_C01_001 = {
    ID = "SScene_CG_C01_001",
    CnID = "CG静态图1",
    BaseSortID = 55,
    Res = "CG/C01/Static/CG_C01_001.png"
  },
  CGDynamic_C01_000 = {
    ID = "CGDynamic_C01_000",
    CnID = "白色淡入淡出",
    BaseSortID = 56,
    Res = "CG/C01/Prefab/CGDynamic_C01_000.prefab"
  },
  CGDynamic_C01_001 = {
    ID = "CGDynamic_C01_001",
    CnID = "CG动态图组1",
    BaseSortID = 57,
    Res = "CG/C01/Prefab/CGDynamic_C01_001.prefab"
  },
  CGDynamic_C01_001_02 = {
    ID = "CGDynamic_C01_001_02",
    CnID = "CG动态图组1过渡",
    BaseSortID = 58,
    Res = "CG/C01/Prefab/CGDynamic_C01_001_02.prefab"
  },
  CGDynamic_C01_002 = {
    ID = "CGDynamic_C01_002",
    CnID = "CG动态图组2",
    BaseSortID = 59,
    Res = "CG/C01/Prefab/CGDynamic_C01_002.prefab"
  },
  CGDynamic_C01_003 = {
    ID = "CGDynamic_C01_003",
    CnID = "CG动态图组3",
    BaseSortID = 60,
    Res = "CG/C01/Prefab/CGDynamic_C01_003.prefab"
  },
  CGDynamic_C01_004 = {
    ID = "CGDynamic_C01_004",
    CnID = "CG动态图组4",
    BaseSortID = 61,
    Res = "CG/C01/Prefab/CGDynamic_C01_004.prefab"
  },
  CGDynamic_C01_005 = {
    ID = "CGDynamic_C01_005",
    CnID = "CG动态图组5",
    BaseSortID = 62,
    Res = "CG/C01/Prefab/CGDynamic_C01_005.prefab"
  },
  CGDynamic_C01_006 = {
    ID = "CGDynamic_C01_006",
    CnID = "CG动态图组6",
    BaseSortID = 63,
    Res = "CG/C01/Prefab/CGDynamic_C01_006.prefab"
  },
  CGDynamic_C01_007 = {
    ID = "CGDynamic_C01_007",
    CnID = "CG动态图组7",
    BaseSortID = 64,
    Res = "CG/C01/Prefab/CGDynamic_C01_007.prefab"
  },
  CGDynamic_C01_008 = {
    ID = "CGDynamic_C01_008",
    CnID = "CG动态图组8",
    BaseSortID = 65,
    Res = "CG/C01/Prefab/CGDynamic_C01_008.prefab"
  },
  CGDynamic_C01_009 = {
    ID = "CGDynamic_C01_009",
    CnID = "CG动态图组9",
    BaseSortID = 66,
    Res = "CG/C01/Prefab/CGDynamic_C01_009.prefab"
  },
  CGDynamic_C01_010 = {
    ID = "CGDynamic_C01_010",
    CnID = "CG动态图组10",
    BaseSortID = 67,
    Res = "CG/C01/Prefab/CGDynamic_C01_010.prefab"
  },
  CGDynamic_C01_011 = {
    ID = "CGDynamic_C01_011",
    CnID = "CG动态图组11",
    BaseSortID = 68,
    Res = "CG/C01/Prefab/CGDynamic_C01_011.prefab"
  },
  CGDynamic_C01_012 = {
    ID = "CGDynamic_C01_012",
    CnID = "黑色淡入淡出",
    BaseSortID = 69,
    Res = "CG/C01/Prefab/CGDynamic_C01_012.prefab"
  },
  CGDynamic_C00_009 = {
    ID = "CGDynamic_C00_009",
    CnID = "序章黑色淡入",
    BaseSortID = 70,
    Res = "CG/C00/Prefab/CGDynamic_C00_009.prefab"
  },
  CGDynamic_C00_011 = {
    ID = "CGDynamic_C00_011",
    CnID = "序章拉蒙娜微笑叠化",
    BaseSortID = 71,
    Res = "CG/C00/Prefab/CGDynamic_C00_011.prefab"
  },
  CGDynamic_C00_004 = {
    ID = "CGDynamic_C00_004",
    CnID = "序章利维坦黑屏淡入",
    BaseSortID = 72,
    Res = "CG/C00/Prefab/CGDynamic_C00_004.prefab"
  },
  SScene_CG_C00_001 = {
    ID = "SScene_CG_C00_001",
    CnID = "序章CG_静态_拉蒙娜遇刺瞬间",
    BaseSortID = 73,
    Res = "CG/C00/Static/CG_C00_001.png"
  },
  SScene_CG_C00_002 = {
    ID = "SScene_CG_C00_002",
    CnID = "序章CG_静态_拉蒙娜遇刺1",
    BaseSortID = 74,
    Res = "CG/C00/Static/CG_C00_002.png"
  },
  SScene_CG_C00_003 = {
    ID = "SScene_CG_C00_003",
    CnID = "序章CG_静态_拉蒙娜遇刺2",
    BaseSortID = 75,
    Res = "CG/C00/Static/CG_C00_003.png"
  },
  SScene_CG_C00_004 = {
    ID = "SScene_CG_C00_004",
    CnID = "序章CG_静态_利维坦战损1",
    BaseSortID = 76,
    Res = "CG/C00/Static/CG_C00_004.png"
  },
  SScene_CG_C00_005 = {
    ID = "SScene_CG_C00_005",
    CnID = "序章CG_静态_利维坦战损2",
    BaseSortID = 77,
    Res = "CG/C00/Static/CG_C00_005.png"
  },
  SScene_CG_C00_006 = {
    ID = "SScene_CG_C00_006",
    CnID = "序章CG_静态_利维坦战损3",
    BaseSortID = 78,
    Res = "CG/C00/Static/CG_C00_006.png"
  },
  SScene_CG_C00_007 = {
    ID = "SScene_CG_C00_007",
    CnID = "序章CG_静态_利维坦战损4",
    BaseSortID = 79,
    Res = "CG/C00/Static/CG_C00_007.png"
  },
  SScene_CG_C00_008 = {
    ID = "SScene_CG_C00_008",
    CnID = "序章CG_Boss",
    BaseSortID = 80,
    Res = "CG/C00/Static/CG_C00_008.png"
  },
  SScene_CG_C00_009 = {
    ID = "SScene_CG_C00_009",
    CnID = "序章CG_塔薇贴贴1",
    BaseSortID = 81,
    Res = "CG/C00/Static/CG_C00_009.png"
  },
  SScene_CG_C00_010 = {
    ID = "SScene_CG_C00_010",
    CnID = "序章CG_塔薇贴贴2",
    BaseSortID = 82,
    Res = "CG/C00/Static/CG_C00_010.png"
  },
  SScene_CG_C00_011 = {
    ID = "SScene_CG_C00_011",
    CnID = "序章CG_静态_拉蒙娜面对面1",
    BaseSortID = 83,
    Res = "CG/C00/Static/CG_C00_011.png"
  },
  SScene_CG_C00_012 = {
    ID = "SScene_CG_C00_012",
    CnID = "序章CG_静态_拉蒙娜面对面2",
    BaseSortID = 84,
    Res = "CG/C00/Static/CG_C00_012.png"
  },
  SScene_CG_C00_014 = {
    ID = "SScene_CG_C00_014",
    CnID = "序章CG_静态_拉蒙娜牵手",
    BaseSortID = 85,
    Res = "CG/C00/Static/CG_C00_014.png"
  },
  SScene_CG_C00_013 = {
    ID = "SScene_CG_C00_013",
    CnID = "序章CG_静态_对抗萝坦",
    BaseSortID = 86,
    Res = "CG/C00/Static/CG_C00_013.png"
  },
  CGDynamic_C00_001 = {
    ID = "CGDynamic_C00_001",
    CnID = "序章CG_动态图组1",
    BaseSortID = 87,
    Res = "CG/C00/Prefab/CGDynamic_C00_001.prefab"
  },
  CGDynamic_C00_002 = {
    ID = "CGDynamic_C00_002",
    CnID = "序章CG_动态图组2",
    BaseSortID = 88,
    Res = "CG/C00/Prefab/CGDynamic_C00_002.prefab"
  },
  Test_Img_Prefab = {
    ID = "Test_Img_Prefab",
    CnID = "测试轮播图片",
    BaseSortID = 89,
    Res = "UI/UI_Story/UI_Story_Prefab/UI_Story_Test_Image.prefab"
  },
  SScene_dreamarea = {
    ID = "SScene_dreamarea",
    CnID = "意识空间",
    BaseSortID = 90,
    Res = "Scenebg/SScene_dreamarea.png"
  },
  SScene_GnosticSpace = {
    ID = "SScene_GnosticSpace",
    CnID = "意识空间恒星版",
    BaseSortID = 91,
    Res = "Scenebg/SScene_GnosticSpace.png"
  },
  SScene_BedRoom = {
    ID = "SScene_BedRoom",
    CnID = "通用卧室",
    BaseSortID = 92,
    Res = "Scenebg/SScene_HotelRoomNight.png"
  },
  SScene_BedRoomDay = {
    ID = "SScene_BedRoomDay",
    CnID = "通用卧室_日",
    BaseSortID = 93,
    Res = "Scenebg/SScene_HotelRoomDay.png"
  },
  SScene_HerbertOffice = {
    ID = "SScene_HerbertOffice",
    CnID = "赫伯特办公室",
    BaseSortID = 94,
    Res = "Scenebg/SScene_ExamineRoom.png"
  },
  SScene_ForrestBridge = {
    ID = "SScene_ForrestBridge",
    CnID = "福勒斯钢桥",
    BaseSortID = 95,
    Res = "Scenebg/SScene_Railwaybridge.png"
  },
  SScene_CG_C02_001 = {
    ID = "SScene_CG_C02_001",
    CnID = "第二章CG_24",
    BaseSortID = 96,
    Res = "CG/C02/Static/CG_C02_001.png"
  },
  SScene_CG_C02_002 = {
    ID = "SScene_CG_C02_002",
    CnID = "第二章CG_蜡像笑",
    BaseSortID = 97,
    Res = "CG/C02/Static/CG_C02_002.png"
  },
  SScene_CG_C02_003 = {
    ID = "SScene_CG_C02_003",
    CnID = "第二章CG_蜡像哭",
    BaseSortID = 98,
    Res = "CG/C02/Static/CG_C02_003.png"
  },
  SScene_CG_C02_004 = {
    ID = "SScene_CG_C02_004",
    CnID = "第二章CG_詹金1",
    BaseSortID = 99,
    Res = "CG/C02/Static/CG_C02_004.png"
  },
  SScene_CG_C02_005 = {
    ID = "SScene_CG_C02_005",
    CnID = "第二章CG_詹金2",
    BaseSortID = 100,
    Res = "CG/C02/Static/CG_C02_005.png"
  },
  SScene_CG_C02_006 = {
    ID = "SScene_CG_C02_006",
    CnID = "第二章CG_詹金3",
    BaseSortID = 101,
    Res = "CG/C02/Static/CG_C02_006.png"
  },
  SScene_Dock = {
    ID = "SScene_Dock",
    CnID = "码头",
    BaseSortID = 102,
    Res = "Scenebg/SScene_Dock.png"
  },
  SScene_WhiteWall = {
    ID = "SScene_WhiteWall",
    CnID = "白墙",
    BaseSortID = 103,
    Res = "Scenebg/SScene_Black.png"
  },
  SScene_DeckIllusion = {
    ID = "SScene_DeckIllusion",
    CnID = "幻光甲板",
    BaseSortID = 104,
    Res = "Scenebg/SScene_DeckIllusion.png"
  },
  SScene_DeckNight = {
    ID = "SScene_DeckNight",
    CnID = "月光甲板",
    BaseSortID = 105,
    Res = "Scenebg/SScene_DeckNight.png"
  },
  SScene_Cabin = {
    ID = "SScene_Cabin",
    CnID = "货舱",
    BaseSortID = 106,
    Res = "Scenebg/SScene_Cabin.png"
  },
  SScene_EngineRoom = {
    ID = "SScene_EngineRoom",
    CnID = "动力室",
    BaseSortID = 107,
    Res = "Scenebg/SScene_EngineRoom.png"
  },
  SScene_Corrosion = {
    ID = "SScene_Corrosion",
    CnID = "融蚀粘液",
    BaseSortID = 108,
    Res = "Scenebg/SScene_Corrosion.png"
  },
  CGDynamic_C02_002a = {
    ID = "CGDynamic_C02_002a",
    CnID = "第二章CG_动态蜡像笑",
    BaseSortID = 109,
    Res = "CG/C02/Prefab/CGDynamic_C02_002a.prefab"
  },
  CGDynamic_C02_002a_01 = {
    ID = "CGDynamic_C02_002a_01",
    CnID = "第二章CG_动态蜡像笑1",
    BaseSortID = 110,
    Res = "CG/C02/Prefab/CGDynamic_C02_002a_01.prefab"
  },
  CGDynamic_C02_002a_02 = {
    ID = "CGDynamic_C02_002a_02",
    CnID = "第二章CG_动态蜡像笑2",
    BaseSortID = 111,
    Res = "CG/C02/Prefab/CGDynamic_C02_002a_02.prefab"
  },
  CGDynamic_C02_002a_03 = {
    ID = "CGDynamic_C02_002a_03",
    CnID = "第二章CG_动态蜡像笑3",
    BaseSortID = 112,
    Res = "CG/C02/Prefab/CGDynamic_C02_002a_03.prefab"
  },
  CGDynamic_C02_004 = {
    ID = "CGDynamic_C02_004",
    CnID = "第二章CG_詹金出来",
    BaseSortID = 113,
    Res = "CG/C02/Prefab/CGDynamic_C02_004.prefab"
  },
  CGDynamic_C02_005 = {
    ID = "CGDynamic_C02_005",
    CnID = "第二章CG_詹金拿钥匙",
    BaseSortID = 114,
    Res = "CG/C02/Prefab/CGDynamic_C02_005.prefab"
  },
  CGDynamic_C02_006 = {
    ID = "CGDynamic_C02_006",
    CnID = "第二章CG_詹金牺牲",
    BaseSortID = 115,
    Res = "CG/C02/Prefab/CGDynamic_C02_006.prefab"
  },
  SScene_CG_C04_001 = {
    ID = "SScene_CG_C04_001",
    CnID = "第四章CG_莉莉走近",
    BaseSortID = 116,
    Res = "CG/C04/Static/CG_C04_001.png"
  },
  SScene_CG_C04_002 = {
    ID = "SScene_CG_C04_002",
    CnID = "第四章CG_莉莉微笑",
    BaseSortID = 117,
    Res = "CG/C04/Static/CG_C04_002.png"
  },
  SScene_CG_C04_003 = {
    ID = "SScene_CG_C04_003",
    CnID = "第四章CG_母女拥抱",
    BaseSortID = 118,
    Res = "CG/C04/Static/CG_C04_003.png"
  },
  CGDynamic_C02_006_out = {
    ID = "CGDynamic_C02_006_out",
    CnID = "通用黑色淡入淡出",
    BaseSortID = 119,
    Res = "CG/C02/Prefab/CGDynamic_C02_006_out.prefab"
  },
  SScene_EngineRoomPostbattle = {
    ID = "SScene_EngineRoomPostbattle",
    CnID = "战后动力室",
    BaseSortID = 120,
    Res = "Scenebg/SScene_EngineRoomPostbattle.png"
  },
  CGDynamic_C04_001 = {
    ID = "CGDynamic_C04_001",
    CnID = "第四章CG1_淡入",
    BaseSortID = 121,
    Res = "CG/C04/Prefab/CGDynamic_C04_001.prefab"
  },
  CGDynamic_C04_003 = {
    ID = "CGDynamic_C04_003",
    CnID = "第四章CG3_切特写",
    BaseSortID = 122,
    Res = "CG/C04/Prefab/CGDynamic_C04_003.prefab"
  },
  CGDynamic_C04_002 = {
    ID = "CGDynamic_C04_002",
    CnID = "第四章CG1_淡出",
    BaseSortID = 123,
    Res = "CG/C04/Prefab/CGDynamic_C04_002.prefab"
  },
  CGDynamic_C04_004 = {
    ID = "CGDynamic_C04_004",
    CnID = "第四章CG2_淡入",
    BaseSortID = 124,
    Res = "CG/C04/Prefab/CGDynamic_C04_004.prefab"
  },
  CGDynamic_C04_005 = {
    ID = "CGDynamic_C04_005",
    CnID = "第四章CG3_淡入",
    BaseSortID = 125,
    Res = "CG/C04/Prefab/CGDynamic_C04_005.prefab"
  },
  CGDynamic_C04_006 = {
    ID = "CGDynamic_C04_006",
    CnID = "第四章CG2_淡出",
    BaseSortID = 126,
    Res = "CG/C04/Prefab/CGDynamic_C04_006.prefab"
  },
  SScene_CG_C05_001 = {
    ID = "SScene_CG_C05_001",
    CnID = "第五章CG_静态_海底",
    BaseSortID = 127,
    Res = "CG/C05/Static/CG_C05_001.png"
  },
  SScene_CG_C05_002 = {
    ID = "SScene_CG_C05_002",
    CnID = "第五章CG_静态_神胎",
    BaseSortID = 128,
    Res = "CG/C05/Static/CG_C05_002.png"
  },
  SScene_CG_C05_003 = {
    ID = "SScene_CG_C05_003",
    CnID = "第五章CG_静态_弥利亚姆1",
    BaseSortID = 129,
    Res = "CG/C05/Static/CG_C05_003.png"
  },
  SScene_CG_C05_004 = {
    ID = "SScene_CG_C05_004",
    CnID = "第五章CG_静态_弥利亚姆2",
    BaseSortID = 130,
    Res = "CG/C05/Static/CG_C05_004.png"
  },
  SScene_StudentDorm = {
    ID = "SScene_StudentDorm",
    CnID = "学生宿舍",
    BaseSortID = 131,
    Res = "Scenebg/SScene_StudentDorm.png"
  },
  SScene_Blood2 = {
    ID = "SScene_Blood2",
    CnID = "剧情背景-溅血2",
    BaseSortID = 132,
    Res = "Scenebg/SScene_Blood2.png"
  },
  CGDynamic_C05_001 = {
    ID = "CGDynamic_C05_001",
    CnID = "第五章CG_动态_弥利亚姆拉近镜头",
    BaseSortID = 133,
    Res = "CG/C05/Prefab/CGDynamic_C05_001.prefab"
  },
  SScene_WaxUnderground_depths = {
    ID = "SScene_WaxUnderground_depths",
    CnID = "蜡像馆深处",
    BaseSortID = 134,
    Res = "Scenebg/SScene_WaxUnderground_depths.png"
  },
  SScene_CG_C04_004 = {
    ID = "SScene_CG_C04_004",
    CnID = "第四章CG_静态_地狱犬",
    BaseSortID = 135,
    Res = "CG/C04/Static/CG_C04_004.png"
  },
  SScene_CG_C04_005 = {
    ID = "SScene_CG_C04_005",
    CnID = "第四章CG_静态_地狱犬特写",
    BaseSortID = 136,
    Res = "CG/C04/Static/CG_C04_005.png"
  },
  CGDynamic_C04_007 = {
    ID = "CGDynamic_C04_007",
    CnID = "淡出至白屏",
    BaseSortID = 137,
    Res = "CG/C04/Prefab/CGDynamic_C04_007.prefab"
  },
  CGDynamic_C04_008 = {
    ID = "CGDynamic_C04_008",
    CnID = "第四章CG_静态_淡入地狱犬特写",
    BaseSortID = 138,
    Res = "CG/C04/Prefab/CGDynamic_C04_008.prefab"
  },
  SScene_Passageway = {
    ID = "SScene_Passageway",
    CnID = "下水道",
    BaseSortID = 139,
    Res = "Scenebg/SScene_Passageway.png"
  },
  SScene_ScaryEyes = {
    ID = "SScene_ScaryEyes",
    CnID = "地狱犬之眼",
    BaseSortID = 140,
    Res = "CG/C03/Static/CG_C03_001.png"
  },
  SScene_WeeklyRuins02 = {
    ID = "SScene_WeeklyRuins02",
    CnID = "通用雪原",
    BaseSortID = 141,
    Res = "Scenebg/SScene_WeeklyRuins02.png"
  },
  SScene_ShipCornerLogo = {
    ID = "SScene_ShipCornerLogo",
    CnID = "货舱角落",
    BaseSortID = 142,
    Res = "Scenebg/SScene_ShipCornerLogo.png"
  },
  SScene_ShipCorner = {
    ID = "SScene_ShipCorner",
    CnID = "仓库角落",
    BaseSortID = 143,
    Res = "Scenebg/SScene_ShipCorner.png"
  },
  SScene_CG_C06_001 = {
    ID = "SScene_CG_C06_001",
    CnID = "第六章CG-墨菲的手",
    BaseSortID = 144,
    Res = "CG/C06/Static/CG_C06_001.png"
  },
  SScene_CG_C06_002 = {
    ID = "SScene_CG_C06_002",
    CnID = "第六章CG-墨菲趴背前",
    BaseSortID = 145,
    Res = "CG/C06/Static/CG_C06_002.png"
  },
  SScene_CG_C06_003 = {
    ID = "SScene_CG_C06_003",
    CnID = "第六章CG-墨菲趴背后",
    BaseSortID = 146,
    Res = "CG/C06/Static/CG_C06_003.png"
  },
  SScene_CG_C06_004 = {
    ID = "SScene_CG_C06_004",
    CnID = "第六章CG-脖子上的刀",
    BaseSortID = 147,
    Res = "CG/C06/Static/CG_C06_004.png"
  },
  SScene_CG_C06_005 = {
    ID = "SScene_CG_C06_005",
    CnID = "第六章CG-药瓶",
    BaseSortID = 148,
    Res = "CG/C06/Static/CG_C06_005.png"
  },
  SScene_CG_C06_006 = {
    ID = "SScene_CG_C06_006",
    CnID = "第六章CG-月亮和蛇",
    BaseSortID = 149,
    Res = "CG/C06/Static/CG_C06_006.png"
  },
  SScene_CG_C06_007 = {
    ID = "SScene_CG_C06_007",
    CnID = "第六章CG-特写白色心脏",
    BaseSortID = 150,
    Res = "CG/C06/Static/CG_C06_007.png"
  },
  SScene_CG_C06_008 = {
    ID = "SScene_CG_C06_008",
    CnID = "第六章CG-月亮和墨菲",
    BaseSortID = 151,
    Res = "CG/C06/Static/CG_C06_008.png"
  },
  SScene_CG_C06_009 = {
    ID = "SScene_CG_C06_009",
    CnID = "第六章CG-匕首",
    BaseSortID = 152,
    Res = "CG/C06/Static/CG_C06_009.png"
  },
  SScene_CG_C06_010 = {
    ID = "SScene_CG_C06_010",
    CnID = "第六章CG-墨菲刺穿",
    BaseSortID = 153,
    Res = "CG/C06/Static/CG_C06_010.png"
  },
  SScene_CG_C06_011 = {
    ID = "SScene_CG_C06_011",
    CnID = "第六章CG-破碎",
    BaseSortID = 154,
    Res = "CG/C06/Static/CG_C06_011.png"
  },
  SScene_CG_C06_018 = {
    ID = "SScene_CG_C06_018",
    CnID = "第六章CG-黑色光点",
    BaseSortID = 155,
    Res = "CG/C06/Static/CG_C06_018.png"
  },
  SScene_CG_C01_002 = {
    ID = "SScene_CG_C01_002",
    CnID = "蚂蚁群",
    BaseSortID = 156,
    Res = "CG/C01/Static/CG_C01_002.png"
  },
  SScene_CG_C01_003 = {
    ID = "SScene_CG_C01_003",
    CnID = "蚂蚁行",
    BaseSortID = 157,
    Res = "CG/C01/Static/CG_C01_003.png"
  },
  SScene_OperaHouse = {
    ID = "SScene_OperaHouse",
    CnID = "歌剧院舞台",
    BaseSortID = 158,
    Res = "Scenebg/SScene_OperaHouse.png"
  },
  SScene_OperaHousewithoutPeople = {
    ID = "SScene_OperaHousewithoutPeople",
    CnID = "歌剧院无人版",
    BaseSortID = 159,
    Res = "Scenebg/SScene_OperaHousewithoutPeople.png"
  },
  SScene_ChurchNight = {
    ID = "SScene_ChurchNight",
    CnID = "教堂内景_夜",
    BaseSortID = 160,
    Res = "Scenebg/SScene_ChurchNight.png"
  },
  SScene_ChurchDay = {
    ID = "SScene_ChurchDay",
    CnID = "教堂内景_日",
    BaseSortID = 161,
    Res = "Scenebg/SScene_ChurchDay.png"
  },
  SScene_BloodChurchIn = {
    ID = "SScene_BloodChurchIn",
    CnID = "教堂内景_血月",
    BaseSortID = 162,
    Res = "Scenebg/SScene_BloodChurchIn.png"
  },
  SScene_ChurchAisle = {
    ID = "SScene_ChurchAisle",
    CnID = "教堂大厅_日",
    BaseSortID = 163,
    Res = "Scenebg/SScene_ChurchAisle.png"
  },
  SScene_BloodChurchAisle = {
    ID = "SScene_BloodChurchAisle",
    CnID = "教堂大厅_血月",
    BaseSortID = 164,
    Res = "Scenebg/SScene_BloodChurchAisle.png"
  },
  SScene_CG_C03_002 = {
    ID = "SScene_CG_C03_002",
    CnID = "第三章CG-莉莉初见",
    BaseSortID = 165,
    Res = "CG/C03/Static/CG_C03_002.png"
  },
  SScene_CG_C03_003 = {
    ID = "SScene_CG_C03_003",
    CnID = "第三章CG-莉莉和库姆",
    BaseSortID = 166,
    Res = "CG/C03/Static/CG_C03_003.png"
  },
  SScene_CG_C03_004 = {
    ID = "SScene_CG_C03_004",
    CnID = "第三章CG-希洛面对列车",
    BaseSortID = 167,
    Res = "CG/C03/Static/CG_C03_004.png"
  },
  SScene_CG_C03_005 = {
    ID = "SScene_CG_C03_005",
    CnID = "第三章CG-萝坦对打希洛",
    BaseSortID = 168,
    Res = "CG/C03/Static/CG_C03_005.png"
  },
  CGDynamic_C00M_02WhiteOut = {
    ID = "CGDynamic_C00M_02WhiteOut",
    CnID = "白色淡出",
    BaseSortID = 169,
    Res = "CG/COOM/Prefab/CGDynamic_C00M_05WhiteOut.prefab"
  },
  SScene_MirageOfRlyeh = {
    ID = "SScene_MirageOfRlyeh",
    CnID = "拉莱耶幻境",
    BaseSortID = 170,
    Res = "Scenebg/SScene_MirageOfRlyeh.png"
  },
  SScene_PalaceHallDay = {
    ID = "SScene_PalaceHallDay",
    CnID = "豪华大厅_日",
    BaseSortID = 171,
    Res = "Scenebg/SScene_PalaceHallDay.png"
  },
  SScene_PalaceHallNight = {
    ID = "SScene_PalaceHallNight",
    CnID = "豪华大厅_夜",
    BaseSortID = 172,
    Res = "Scenebg/SScene_PalaceHallNight.png"
  },
  SScene_PalaceHallMoonight = {
    ID = "SScene_PalaceHallMoonight",
    CnID = "豪华大厅_月光",
    BaseSortID = 173,
    Res = "Scenebg/SScene_PalaceHallMoonight.png"
  },
  CG_C01_004 = {
    ID = "CG_C01_004",
    CnID = "糖像群",
    BaseSortID = 174,
    Res = "CG/C01/Static/CG_C01_004.png"
  },
  SScene_CG_SD_S_C03_01 = {
    ID = "SScene_CG_SD_S_C03_01",
    CnID = "奥吉尔小型支线CG1",
    BaseSortID = 175,
    Res = "CG/CG_SD/Static/CG_SD_S_C03_1.png"
  },
  SScene_CG_SD_S_C03_02 = {
    ID = "SScene_CG_SD_S_C03_02",
    CnID = "奥吉尔小型支线CG2",
    BaseSortID = 176,
    Res = "CG/CG_SD/Static/CG_SD_S_C03_2.png"
  },
  SScene_StarrySky = {
    ID = "SScene_StarrySky",
    CnID = "通用星空",
    BaseSortID = 177,
    Res = "Scenebg/SScene_StarrySky.png"
  },
  SScene_WeeklyDream02 = {
    ID = "SScene_WeeklyDream02",
    CnID = "幻梦深潜通用2",
    BaseSortID = 178,
    Res = "Scenebg/SScene_WeeklyDream02.png"
  },
  SScene_WeeklyDream03 = {
    ID = "SScene_WeeklyDream03",
    CnID = "幻梦深潜通用3",
    BaseSortID = 179,
    Res = "Scenebg/SScene_WeeklyDream03.png"
  },
  SScene_WeeklyDream04 = {
    ID = "SScene_WeeklyDream04",
    CnID = "幻梦深潜通用4",
    BaseSortID = 180,
    Res = "Scenebg/SScene_WeeklyDream04.png"
  },
  SScene_Meteor = {
    ID = "SScene_Meteor",
    CnID = "星空流星版",
    BaseSortID = 181,
    Res = "Scenebg/SScene_Meteor.png"
  },
  SScene_WastelandDay = {
    ID = "SScene_WastelandDay",
    CnID = "荒地_黎明",
    BaseSortID = 182,
    Res = "Scenebg/SScene_WastelandDay.png"
  },
  SScene_WastelandNight = {
    ID = "SScene_WastelandNight",
    CnID = "荒地_夜晚",
    BaseSortID = 183,
    Res = "Scenebg/SScene_WastelandNight.png"
  },
  SScene_SeasideNight = {
    ID = "SScene_SeasideNight",
    CnID = "海边_夜",
    BaseSortID = 184,
    Res = "Scenebg/SScene_SeasideNight.png"
  },
  SScene_SeasideDay = {
    ID = "SScene_SeasideDay",
    CnID = "海边_日",
    BaseSortID = 185,
    Res = "Scenebg/SScene_SeasideDay.png"
  },
  SScene_SeasideOvercast = {
    ID = "SScene_SeasideOvercast",
    CnID = "海边_阴",
    BaseSortID = 186,
    Res = "Scenebg/SScene_SeasideOvercast.png"
  },
  SScene_CrimeScene = {
    ID = "SScene_CrimeScene",
    CnID = "案发现场",
    BaseSortID = 187,
    Res = "Scenebg/SScene_CrimeScene.png"
  },
  SScene_Abyss01 = {
    ID = "SScene_Abyss01",
    CnID = "深渊场景1",
    BaseSortID = 188,
    Res = "Scenebg/SScene_Abyss01.png"
  },
  SScene_Abyss02 = {
    ID = "SScene_Abyss02",
    CnID = "深渊场景2",
    BaseSortID = 189,
    Res = "Scenebg/SScene_Abyss02.png"
  },
  SScene_Abyss03 = {
    ID = "SScene_Abyss03",
    CnID = "深渊场景3",
    BaseSortID = 190,
    Res = "Scenebg/SScene_Abyss03.png"
  },
  SScene_Abyss04 = {
    ID = "SScene_Abyss04",
    CnID = "深渊场景4",
    BaseSortID = 191,
    Res = "Scenebg/SScene_Abyss04.png"
  },
  SScene_Sunny = {
    ID = "SScene_Sunny",
    CnID = "晴天",
    BaseSortID = 192,
    Res = "Scenebg/SScene_Sunny.png"
  },
  SScene_Dusk = {
    ID = "SScene_Dusk",
    CnID = "黄昏",
    BaseSortID = 193,
    Res = "Scenebg/SScene_Dusk.png"
  },
  SScene_Overcast = {
    ID = "SScene_Overcast",
    CnID = "阴天",
    BaseSortID = 194,
    Res = "Scenebg/SScene_Overcast.png"
  },
  SScene_Cloudy = {
    ID = "SScene_Cloudy",
    CnID = "多云",
    BaseSortID = 195,
    Res = "Scenebg/SScene_Cloudy.png"
  },
  SScene_HyleSeaPeace = {
    ID = "SScene_HyleSeaPeace",
    CnID = "原质之海_黑白",
    BaseSortID = 196,
    Res = "Scenebg/SScene_HyleSeaPeace.png"
  },
  SScene_HyleSeaIntense = {
    ID = "SScene_HyleSeaIntense",
    CnID = "原质之海_彩色",
    BaseSortID = 197,
    Res = "Scenebg/SScene_HyleSeaIntense.png"
  },
  Transparent = {
    ID = "Transparent",
    CnID = "透明",
    BaseSortID = 198,
    Res = "Transparent"
  },
  SScene_ShipBow = {
    ID = "SScene_ShipBow",
    CnID = "甲板_战损",
    BaseSortID = 199,
    Res = "Scenebg/SScene_ShipBow.png"
  },
  SScene_CG_SD_S_D08_1 = {
    ID = "SScene_CG_SD_S_D08_1",
    CnID = "艾瑞卡小型支线CG1",
    BaseSortID = 200,
    Res = "CG/CG_SD/Static/CG_SD_S_D08_1.png"
  },
  SScene_CG_SD_S_D08_2 = {
    ID = "SScene_CG_SD_S_D08_2",
    CnID = "艾瑞卡小型支线CG2",
    BaseSortID = 201,
    Res = "CG/CG_SD/Static/CG_SD_S_D08_2.png"
  },
  SScene_CG_SD_S_D08_3 = {
    ID = "SScene_CG_SD_S_D08_3",
    CnID = "艾瑞卡小型支线CG3",
    BaseSortID = 202,
    Res = "CG/CG_SD/Static/CG_SD_S_D08_3.png"
  },
  SScene_CG_SD_S_D08_4 = {
    ID = "SScene_CG_SD_S_D08_4",
    CnID = "艾瑞卡小型支线CG4",
    BaseSortID = 203,
    Res = "CG/CG_SD/Static/CG_SD_S_D08_4.png"
  },
  SScene_CG_SD_S_D08_5 = {
    ID = "SScene_CG_SD_S_D08_5",
    CnID = "艾瑞卡小型支线CG5",
    BaseSortID = 204,
    Res = "CG/CG_SD/Static/CG_SD_S_D08_5.png"
  },
  SScene_CG_SD_L_D02_1 = {
    ID = "SScene_CG_SD_L_D02_1",
    CnID = "达芙黛尔的微笑1",
    BaseSortID = 205,
    Res = "CG/CG_SD/Static/CG_SD_L_D02_1.png"
  },
  SScene_CG_SD_L_D02_2 = {
    ID = "SScene_CG_SD_L_D02_2",
    CnID = "达芙黛尔的微笑2",
    BaseSortID = 206,
    Res = "CG/CG_SD/Static/CG_SD_L_D02_2.png"
  },
  SScene_CG_SD_L_D02_3 = {
    ID = "SScene_CG_SD_L_D02_3",
    CnID = "达芙黛尔的微笑3",
    BaseSortID = 207,
    Res = "CG/CG_SD/Static/CG_SD_L_D02_3.png"
  },
  SScene_CG_SD_L_D02_4 = {
    ID = "SScene_CG_SD_L_D02_4",
    CnID = "达芙黛尔夜袭",
    BaseSortID = 208,
    Res = "CG/CG_SD/Static/CG_SD_L_D02_4.png"
  },
  SScene_CG_SD_S_O08_1 = {
    ID = "SScene_CG_SD_S_O08_1",
    CnID = "珊瑚之死1",
    BaseSortID = 209,
    Res = "CG/CG_SD/Static/CG_SD_S_O08_1.png"
  },
  SScene_CG_SD_S_O08_2 = {
    ID = "SScene_CG_SD_S_O08_2",
    CnID = "珊瑚之死2",
    BaseSortID = 210,
    Res = "CG/CG_SD/Static/CG_SD_S_O08_2.png"
  },
  SScene_SeaRuins = {
    ID = "SScene_SeaRuins",
    CnID = "海洋废墟",
    BaseSortID = 211,
    Res = "Scenebg/SScene_SeaRuins.png"
  },
  SScene_GraveyardDay = {
    ID = "SScene_GraveyardDay",
    CnID = "通用墓地_日",
    BaseSortID = 212,
    Res = "Scenebg/SScene_GraveyardDay.png"
  },
  SScene_CG_SD_L_B02_1 = {
    ID = "SScene_CG_SD_L_B02_1",
    CnID = "萨尔瓦多大型支线CG1",
    BaseSortID = 213,
    Res = "CG/CG_SD/Static/CG_SD_L_B02_1.png"
  },
  SScene_CG_SD_S_B07_1 = {
    ID = "SScene_CG_SD_S_B07_1",
    CnID = "尤乌哈希1",
    BaseSortID = 214,
    Res = "CG/CG_SD/Static/CG_SD_S_B07_1.png"
  },
  SScene_CG_SD_S_B07_2 = {
    ID = "SScene_CG_SD_S_B07_2",
    CnID = "尤乌哈希2",
    BaseSortID = 215,
    Res = "CG/CG_SD/Static/CG_SD_S_B07_2.png"
  },
  SScene_CG_SD_S_B07_3 = {
    ID = "SScene_CG_SD_S_B07_3",
    CnID = "尤乌哈希3",
    BaseSortID = 216,
    Res = "CG/CG_SD/Static/CG_SD_S_B07_3.png"
  },
  SScene_CG_SD_S_B07_4 = {
    ID = "SScene_CG_SD_S_B07_4",
    CnID = "尤乌哈希4",
    BaseSortID = 217,
    Res = "CG/CG_SD/Static/CG_SD_S_B07_4.png"
  },
  SScene_GraveyardNight = {
    ID = "SScene_GraveyardNight",
    CnID = "通用墓地_夜",
    BaseSortID = 218,
    Res = "Scenebg/SScene_GraveyardNight.png"
  },
  SScene_LondonStreet = {
    ID = "SScene_LondonStreet",
    CnID = "伦敦市区",
    BaseSortID = 219,
    Res = "Scenebg/SScene_LondonStreet.png"
  },
  SScene_CG_SD_S_B06_1 = {
    ID = "SScene_CG_SD_S_B06_1",
    CnID = "阿格里帕1",
    BaseSortID = 220,
    Res = "CG/CG_SD/Static/CG_SD_S_B06_1.png"
  },
  SScene_CG_SD_S_B06_2 = {
    ID = "SScene_CG_SD_S_B06_2",
    CnID = "阿格里帕2",
    BaseSortID = 221,
    Res = "CG/CG_SD/Static/CG_SD_S_B06_2.png"
  },
  SScene_DesertDay = {
    ID = "SScene_DesertDay",
    CnID = "沙漠白天",
    BaseSortID = 222,
    Res = "Scenebg/SScene_DesertDay.png"
  },
  SScene_DesertNight = {
    ID = "SScene_DesertNight",
    CnID = "沙漠夜晚",
    BaseSortID = 223,
    Res = "Scenebg/SScene_DesertNight.png"
  },
  SScene_DesertDust = {
    ID = "SScene_DesertDust",
    CnID = "沙漠黄昏",
    BaseSortID = 224,
    Res = "Scenebg/SScene_DesertDust.png"
  },
  SScene_WeeklyRuins01 = {
    ID = "SScene_WeeklyRuins01",
    CnID = "融蚀之墟1",
    BaseSortID = 225,
    Res = "Scenebg/SScene_WeeklyRuins01.png"
  },
  SScene_CG_C03_006 = {
    ID = "SScene_CG_C03_006",
    CnID = "第三章CG-希洛扑来",
    BaseSortID = 226,
    Res = "CG/C03/Static/CG_C03_006.png"
  },
  SScene_CG_C03_007 = {
    ID = "SScene_CG_C03_007",
    CnID = "第三章CG-希洛回忆特写",
    BaseSortID = 227,
    Res = "CG/C03/Static/CG_C03_007.png"
  },
  SScene_CG_C04_006 = {
    ID = "SScene_CG_C04_006",
    CnID = "第四章CG_近景莉莉走近左",
    BaseSortID = 228,
    Res = "CG/C04/Static/CG_C04_006.png"
  },
  SScene_CG_C04_007 = {
    ID = "SScene_CG_C04_007",
    CnID = "第四章CG_近景莉莉走近右",
    BaseSortID = 229,
    Res = "CG/C04/Static/CG_C04_007.png"
  },
  SScene_CG_C04_008 = {
    ID = "SScene_CG_C04_008",
    CnID = "第四章CG_莉莉背影特写",
    BaseSortID = 230,
    Res = "CG/C04/Static/CG_C04_008.png"
  },
  SScene_CG_C04_009 = {
    ID = "SScene_CG_C04_009",
    CnID = "第四章CG_静态_差分地狱犬",
    BaseSortID = 231,
    Res = "CG/C04/Static/CG_C04_009.png"
  },
  CGDynamic_C03_001 = {
    ID = "CGDynamic_C03_001",
    CnID = "第三章CG-隧道震动",
    BaseSortID = 232,
    Res = "CG/C03/Prefab/CGDynamic_C03_001.prefab"
  },
  CGDynamic_C03_002 = {
    ID = "CGDynamic_C03_002",
    CnID = "第三章CG-罗坦挡剑",
    BaseSortID = 233,
    Res = "CG/C03/Prefab/CGDynamic_C03_002.prefab"
  },
  SScene_IceLake = {
    ID = "SScene_IceLake",
    CnID = "南极冰湖",
    BaseSortID = 234,
    Res = "Scenebg/SScene_IceLake.png"
  },
  SScene_SanatoriumAisleInvaded = {
    ID = "SScene_SanatoriumAisleInvaded",
    CnID = "疗养院走廊维度",
    BaseSortID = 235,
    Res = "Scenebg/SScene_SanatoriumAisleInvaded.png"
  },
  SScene_CG_SD_L_C10_1 = {
    ID = "SScene_CG_SD_L_C10_1",
    CnID = "莉莉支线CG1日出",
    BaseSortID = 236,
    Res = "CG/CG_SD/Static/CG_SD_L_C10_1.png"
  },
  SScene_CG_SD_L_C10_2 = {
    ID = "SScene_CG_SD_L_C10_2",
    CnID = "莉莉支线CG2微笑",
    BaseSortID = 237,
    Res = "CG/CG_SD/Static/CG_SD_L_C10_2.png"
  },
  SScene_AuritaRoom = {
    ID = "SScene_AuritaRoom",
    CnID = "奥瑞塔房间",
    BaseSortID = 238,
    Res = "Scenebg/SScene_AuritaRoom.png"
  },
  SScene_CG_SD_S_O05_1 = {
    ID = "SScene_CG_SD_S_O05_1",
    CnID = "奥瑞塔小支线CG1",
    BaseSortID = 239,
    Res = "CG/CG_SD/Static/CG_SD_S_O05_1.png"
  },
  SScene_CG_SD_S_O05_2 = {
    ID = "SScene_CG_SD_S_O05_2",
    CnID = "奥瑞塔小支线CG2",
    BaseSortID = 240,
    Res = "CG/CG_SD/Static/CG_SD_S_O05_2.png"
  },
  SScene_MovieSet = {
    ID = "SScene_MovieSet",
    CnID = "片场",
    BaseSortID = 241,
    Res = "Scenebg/SScene_MovieSet.png"
  },
  SScene_MovieSetHorror = {
    ID = "SScene_MovieSetHorror",
    CnID = "恐怖片场",
    BaseSortID = 242,
    Res = "Scenebg/SScene_MovieSetHorror.png"
  },
  SScene_CG_SD_S_C01EX_1 = {
    ID = "SScene_CG_SD_S_C01EX_1",
    CnID = "本源拉蒙娜小支线CG1",
    BaseSortID = 243,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_1.png"
  },
  SScene_CG_SD_S_C01EX_2 = {
    ID = "SScene_CG_SD_S_C01EX_2",
    CnID = "本源拉蒙娜小支线CG2",
    BaseSortID = 244,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_2.png"
  },
  SScene_CG_SD_S_C01EX_3 = {
    ID = "SScene_CG_SD_S_C01EX_3",
    CnID = "本源拉蒙娜小支线CG3",
    BaseSortID = 245,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_3.png"
  },
  SScene_CG_SD_L_B04_1 = {
    ID = "SScene_CG_SD_L_B04_1",
    CnID = "索蕾尔之死1",
    BaseSortID = 246,
    Res = "CG/CG_SD/Static/CG_SD_L_B04_1.png"
  },
  SScene_CG_SD_L_B04_2 = {
    ID = "SScene_CG_SD_L_B04_2",
    CnID = "索蕾尔之死2",
    BaseSortID = 247,
    Res = "CG/CG_SD/Static/CG_SD_L_B04_2.png"
  },
  SScene_CG_SD_L_B04_3 = {
    ID = "SScene_CG_SD_L_B04_3",
    CnID = "索蕾尔复出1",
    BaseSortID = 248,
    Res = "CG/CG_SD/Static/CG_SD_L_B04_3.png"
  },
  SScene_CG_SD_L_B04_4 = {
    ID = "SScene_CG_SD_L_B04_4",
    CnID = "索蕾尔复出2",
    BaseSortID = 249,
    Res = "CG/CG_SD/Static/CG_SD_L_B04_4.png"
  },
  SScene_PalaceHallRose = {
    ID = "SScene_PalaceHallRose",
    CnID = "豪华大厅-蔷薇",
    BaseSortID = 250,
    Res = "Scenebg/SScene_PalaceHallRose.png"
  },
  SScene_Stage = {
    ID = "SScene_Stage",
    CnID = "通用舞台",
    BaseSortID = 251,
    Res = "Scenebg/SScene_Stage.png"
  },
  SScene_InCarNight = {
    ID = "SScene_InCarNight",
    CnID = "通用汽车内饰-夜",
    BaseSortID = 252,
    Res = "Scenebg/SScene_InCarNight.png"
  },
  SScene_CG_SD_L_C10_3 = {
    ID = "SScene_CG_SD_L_C10_3",
    CnID = "莉莉支线CG3儿童画",
    BaseSortID = 253,
    Res = "CG/CG_SD/Static/CG_SD_L_C10_7.png"
  },
  SScene_CG_SD_L_C10_4 = {
    ID = "SScene_CG_SD_L_C10_4",
    CnID = "莉莉支线CG4日出差分",
    BaseSortID = 254,
    Res = "CG/CG_SD/Static/CG_SD_L_C10_4.png"
  },
  SScene_CG_SD_L_C10_5 = {
    ID = "SScene_CG_SD_L_C10_5",
    CnID = "莉莉支线CG5微笑差分",
    BaseSortID = 255,
    Res = "CG/CG_SD/Static/CG_SD_L_C10_3.png"
  },
  SScene_CG_SD_L_C10_6 = {
    ID = "SScene_CG_SD_L_C10_6",
    CnID = "莉莉支线CG6舞台剧背景板",
    BaseSortID = 256,
    Res = "CG/CG_SD/Static/CG_SD_L_C10_5.png"
  },
  CGDynamic_SD_L_C10_1 = {
    ID = "CGDynamic_SD_L_C10_1",
    CnID = "莉莉支线文字版_1_Inablink",
    BaseSortID = 257,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_C10_1.prefab"
  },
  CGDynamic_SD_L_C10_2 = {
    ID = "CGDynamic_SD_L_C10_2",
    CnID = "莉莉支线水面一层",
    BaseSortID = 258,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_C10_2.prefab"
  },
  CGDynamic_SD_L_C10_3 = {
    ID = "CGDynamic_SD_L_C10_3",
    CnID = "莉莉支线水面多层",
    BaseSortID = 259,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_C10_3.prefab"
  },
  CGDynamic_SD_L_C10_4 = {
    ID = "CGDynamic_SD_L_C10_4",
    CnID = "莉莉支线_笑脸叠化",
    BaseSortID = 260,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_C10_4.prefab"
  },
  CGDynamic_SD_L_C10_5 = {
    ID = "CGDynamic_SD_L_C10_5",
    CnID = "莉莉支线_黄昏特写",
    BaseSortID = 261,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_C10_5.prefab"
  },
  CGDynamic_SD_L_C10_6 = {
    ID = "CGDynamic_SD_L_C10_6",
    CnID = "莉莉支线_黄昏叠化到剪影",
    BaseSortID = 262,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_C10_6.prefab"
  },
  CGDynamic_SD_L_C10_7 = {
    ID = "CGDynamic_SD_L_C10_7",
    CnID = "莉莉支线文字版_2_thegirl",
    BaseSortID = 263,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_C10_7.prefab"
  },
  CGDynamic_SD_L_C10_8 = {
    ID = "CGDynamic_SD_L_C10_8",
    CnID = "莉莉支线文字版_3_Scene1A1",
    BaseSortID = 264,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_C10_8.prefab"
  },
  CGDynamic_SD_L_C10_9 = {
    ID = "CGDynamic_SD_L_C10_9",
    CnID = "莉莉支线文字版_4_Scene2A1",
    BaseSortID = 265,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_C10_9.prefab"
  },
  CGDynamic_SD_L_C10_10 = {
    ID = "CGDynamic_SD_L_C10_10",
    CnID = "莉莉支线文字版_5_Scene3A2",
    BaseSortID = 266,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_C10_10.prefab"
  },
  CGDynamic_SD_L_C10_11 = {
    ID = "CGDynamic_SD_L_C10_11",
    CnID = "莉莉支线文字版_6_Scene4A2",
    BaseSortID = 267,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_C10_11.prefab"
  },
  CGDynamic_SD_L_C10_12 = {
    ID = "CGDynamic_SD_L_C10_12",
    CnID = "莉莉支线文字版_7_Scene4A3",
    BaseSortID = 268,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_C10_12.prefab"
  },
  CGDynamic_SD_L_C10_13 = {
    ID = "CGDynamic_SD_L_C10_13",
    CnID = "莉莉支线文字版_7_Therewasno",
    BaseSortID = 269,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_C10_13.prefab"
  },
  CGDynamic_SD_S_O05_1 = {
    ID = "CGDynamic_SD_S_O05_1",
    CnID = "奥瑞塔支线_闭眼叠化",
    BaseSortID = 270,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_O05_1.prefab"
  },
  SScene_LondonDaytime_Sunny = {
    ID = "SScene_LondonDaytime_Sunny",
    CnID = "伦敦街头_晴",
    BaseSortID = 271,
    Res = "Scenebg/SScene_LondonDaytime_Sunny.png"
  },
  SScene_CG_SD_S_C01EX_4 = {
    ID = "SScene_CG_SD_S_C01EX_4",
    CnID = "本源拉蒙娜小支线CG4",
    BaseSortID = 272,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_4.png"
  },
  SScene_CG_SD_S_C01EX_5 = {
    ID = "SScene_CG_SD_S_C01EX_5",
    CnID = "本源拉蒙娜小支线CG5回头兴奋",
    BaseSortID = 273,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_5.png"
  },
  SScene_CG_SD_S_C01EX_6 = {
    ID = "SScene_CG_SD_S_C01EX_6",
    CnID = "本源拉蒙娜小支线CG6回头惊恐",
    BaseSortID = 274,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_6.png"
  },
  SScene_CG_SD_S_C01EX_7 = {
    ID = "SScene_CG_SD_S_C01EX_7",
    CnID = "本源拉蒙娜小支线CG7改色",
    BaseSortID = 275,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_7.png"
  },
  SScene_CG_SD_S_C01EX_8 = {
    ID = "SScene_CG_SD_S_C01EX_8",
    CnID = "本源拉蒙娜小支线CG8虚空光点",
    BaseSortID = 276,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_8.png"
  },
  SScene_CG_SD_S_C01EX_9 = {
    ID = "SScene_CG_SD_S_C01EX_9",
    CnID = "本源拉蒙娜小支线CG9虚空光点近",
    BaseSortID = 277,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_9.png"
  },
  SScene_CG_SD_S_C01EX_10 = {
    ID = "SScene_CG_SD_S_C01EX_10",
    CnID = "本源拉蒙娜小支线CG10塔薇飞扑",
    BaseSortID = 278,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_10.png"
  },
  SScene_CG_SD_S_C01EX_11 = {
    ID = "SScene_CG_SD_S_C01EX_11",
    CnID = "本源拉蒙娜小支线CG11拯救",
    BaseSortID = 279,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_11.png"
  },
  SScene_CG_SD_S_C01EX_12 = {
    ID = "SScene_CG_SD_S_C01EX_12",
    CnID = "本源拉蒙娜小支线CG12命运天堑",
    BaseSortID = 280,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_12.png"
  },
  SScene_CG_SD_S_C01EX_13 = {
    ID = "SScene_CG_SD_S_C01EX_13",
    CnID = "本源拉蒙娜小支线CG13塔薇贴贴改色",
    BaseSortID = 281,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_13.png"
  },
  SScene_CG_SD_S_C01EX_14 = {
    ID = "SScene_CG_SD_S_C01EX_14",
    CnID = "时钟底图",
    BaseSortID = 282,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_14.png"
  },
  SScene_CG_SD_S_C01EX_14_1 = {
    ID = "SScene_CG_SD_S_C01EX_14_1",
    CnID = "长指针",
    BaseSortID = 283,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_14_1.png"
  },
  SScene_CG_SD_S_C01EX_14_2 = {
    ID = "SScene_CG_SD_S_C01EX_14_2",
    CnID = "短指针",
    BaseSortID = 284,
    Res = "CG/CG_SD/Static/CG_SD_S_C01EX_14_2.png"
  },
  SScene_GraveyardRose = {
    ID = "SScene_GraveyardRose",
    CnID = "通用墓地_蔷薇",
    BaseSortID = 285,
    Res = "Scenebg/SScene_GraveyardRose.png"
  },
  SScene_ConsciousSpacewhiteship = {
    ID = "SScene_ConsciousSpacewhiteship",
    CnID = "白船空间",
    BaseSortID = 286,
    Res = "Scenebg/SScene_ConsciousSpacewhiteship.png"
  },
  CGDynamic_SD_S_C01EX_1 = {
    ID = "CGDynamic_SD_S_C01EX_1",
    CnID = "本源拉蒙娜小支线_跃入黑池叠化",
    BaseSortID = 287,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C01EX_1.prefab"
  },
  CGDynamic_SD_S_C01EX_2 = {
    ID = "CGDynamic_SD_S_C01EX_2",
    CnID = "本源拉蒙娜小支线_回头惊恐",
    BaseSortID = 288,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C01EX_2.prefab"
  },
  CGDynamic_SD_S_C01EX_3 = {
    ID = "CGDynamic_SD_S_C01EX_3",
    CnID = "本源拉蒙娜小支线_塔薇慢速",
    BaseSortID = 289,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C01EX_3.prefab"
  },
  SScene_OperaHouseDark = {
    ID = "SScene_OperaHouseDark",
    CnID = "暗蚀歌剧院",
    BaseSortID = 290,
    Res = "Scenebg/SScene_OperaHouseDark.png"
  },
  CGDynamic_SD_S_C01EX_4 = {
    ID = "CGDynamic_SD_S_C01EX_4",
    CnID = "通道开启",
    BaseSortID = 291,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C01EX_4.prefab"
  },
  SScene_DarkGalaxy = {
    ID = "SScene_DarkGalaxy",
    CnID = "宇宙裂口",
    BaseSortID = 292,
    Res = "Scenebg/SScene_DarkGalaxy.png"
  },
  SScene_CG_C05_005 = {
    ID = "SScene_CG_C05_005",
    CnID = "第五章CG_静态_刀特写",
    BaseSortID = 293,
    Res = "CG/C05/Static/CG_C05_005.png"
  },
  SScene_CG_C05_006 = {
    ID = "SScene_CG_C05_006",
    CnID = "第五章CG_静态_圣母特写",
    BaseSortID = 294,
    Res = "CG/C05/Static/CG_C05_006.png"
  },
  SScene_CG_SD_S_D04_1 = {
    ID = "SScene_CG_SD_S_D04_1",
    CnID = "旺达支线_晚宴全景",
    BaseSortID = 295,
    Res = "CG/CG_SD/Static/CG_SD_S_D04_1.png"
  },
  SScene_CG_SD_S_D04_2 = {
    ID = "SScene_CG_SD_S_D04_2",
    CnID = "旺达支线_旺达特写_正常",
    BaseSortID = 296,
    Res = "CG/CG_SD/Static/CG_SD_S_D04_2.png"
  },
  SScene_CG_SD_S_D04_3 = {
    ID = "SScene_CG_SD_S_D04_3",
    CnID = "旺达支线_旺达特写_融蚀",
    BaseSortID = 297,
    Res = "CG/CG_SD/Static/CG_SD_S_D04_3.png"
  },
  SScene_CG_SD_S_D04_4 = {
    ID = "SScene_CG_SD_S_D04_4",
    CnID = "旺达支线_旺达举杯_融蚀",
    BaseSortID = 298,
    Res = "CG/CG_SD/Static/CG_SD_S_D04_4.png"
  },
  CGDynamic_SD_S_D04_1 = {
    ID = "CGDynamic_SD_S_D04_1",
    CnID = "旺达支线_白色淡入晚宴全景",
    BaseSortID = 299,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_D04_1.prefab"
  },
  CGDynamic_SD_S_D04_2 = {
    ID = "CGDynamic_SD_S_D04_2",
    CnID = "旺达支线_晚宴全景叠化特写",
    BaseSortID = 300,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_D04_2.prefab"
  },
  CGDynamic_SD_S_D04_3 = {
    ID = "CGDynamic_SD_S_D04_3",
    CnID = "旺达支线_举杯叠化",
    BaseSortID = 301,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_D04_3.prefab"
  },
  SScene_CoralCabin = {
    ID = "SScene_CoralCabin",
    CnID = "珊瑚货舱",
    BaseSortID = 302,
    Res = "Scenebg/SScene_CoralCabin.png"
  },
  SScene_Pilothouse = {
    ID = "SScene_Pilothouse",
    CnID = "珊瑚驾驶室",
    BaseSortID = 303,
    Res = "Scenebg/SScene_Pilothouse.png"
  },
  SScene_CG_C06_012 = {
    ID = "SScene_CG_C06_012",
    CnID = "第六章CG-乱线条",
    BaseSortID = 304,
    Res = "CG/C06/Static/CG_C06_012.png"
  },
  SScene_CG_C06_015 = {
    ID = "SScene_CG_C06_015",
    CnID = "第六章CG-匕首强调",
    BaseSortID = 305,
    Res = "CG/C06/Static/CG_C06_015.png"
  },
  SScene_CG_C06_017 = {
    ID = "SScene_CG_C06_017",
    CnID = "第六章CG-墨菲自刎差分",
    BaseSortID = 306,
    Res = "CG/C06/Static/CG_C06_017.png"
  },
  CGDynamic_C06_01 = {
    ID = "CGDynamic_C06_01",
    CnID = "第六章CG-乱线条抖动边框",
    BaseSortID = 307,
    Res = "CG/C06/Prefab/CGDynamic_C06_01.prefab"
  },
  CGDynamic_C06_02 = {
    ID = "CGDynamic_C06_02",
    CnID = "第六章CG-匕首反光叠化",
    BaseSortID = 308,
    Res = "CG/C06/Prefab/CGDynamic_C06_02.prefab"
  },
  CGDynamic_C06_03 = {
    ID = "CGDynamic_C06_03",
    CnID = "第六章CG-墨菲自刎颜色叠化",
    BaseSortID = 309,
    Res = "CG/C06/Prefab/CGDynamic_C06_03.prefab"
  },
  CGDynamic_C06_04 = {
    ID = "CGDynamic_C06_04",
    CnID = "第六章CG-匕首强调叠化",
    BaseSortID = 310,
    Res = "CG/C06/Prefab/CGDynamic_C06_04.prefab"
  },
  Sscene_CG_SD_L_B02_2 = {
    ID = "Sscene_CG_SD_L_B02_2",
    CnID = "萨尔瓦多大支线CG_跪地差分",
    BaseSortID = 311,
    Res = "CG/CG_SD/Static/CG_SD_L_B02_2.png"
  },
  Sscene_CG_SD_L_B02_4 = {
    ID = "Sscene_CG_SD_L_B02_4",
    CnID = "萨尔瓦多大支线CG_石板保护",
    BaseSortID = 312,
    Res = "CG/CG_SD/Static/CG_SD_L_B02_4.png"
  },
  Sscene_CG_SD_L_B02_6 = {
    ID = "Sscene_CG_SD_L_B02_6",
    CnID = "萨尔瓦多大支线CG_疯狂聚会",
    BaseSortID = 313,
    Res = "CG/CG_SD/Static/CG_SD_L_B02_6.png"
  },
  Sscene_CG_SD_L_B02_8 = {
    ID = "Sscene_CG_SD_L_B02_8",
    CnID = "萨尔瓦多大支线CG_主教治愈",
    BaseSortID = 314,
    Res = "CG/CG_SD/Static/CG_SD_L_B02_8.png"
  },
  CGDynamic_SD_L_B02_1 = {
    ID = "CGDynamic_SD_L_B02_1",
    CnID = "萨尔瓦多大支线_跪地叠化",
    BaseSortID = 315,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_B02_1.prefab"
  },
  CGDynamic_SD_L_B02_2 = {
    ID = "CGDynamic_SD_L_B02_2",
    CnID = "萨尔瓦多大支线_跪地渐黑",
    BaseSortID = 316,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_B02_2.prefab"
  },
  CGDynamic_SD_L_B02_3 = {
    ID = "CGDynamic_SD_L_B02_3",
    CnID = "萨尔瓦多大支线_光芒闪过",
    BaseSortID = 317,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_B02_3.prefab"
  },
  CGDynamic_SD_L_B02_4 = {
    ID = "CGDynamic_SD_L_B02_4",
    CnID = "萨尔瓦多大支线_红光闪烁",
    BaseSortID = 318,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_B02_4.prefab"
  },
  CGDynamic_SD_L_B02_5 = {
    ID = "CGDynamic_SD_L_B02_5",
    CnID = "萨尔瓦多大支线_黑屏闪红聚会",
    BaseSortID = 319,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_B02_5.prefab"
  },
  CGDynamic_SD_L_B02_6 = {
    ID = "CGDynamic_SD_L_B02_6",
    CnID = "萨尔瓦多大支线_链路叠化",
    BaseSortID = 320,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_B02_6.prefab"
  },
  Sscene_CG_SD_L_B02_7_A = {
    ID = "Sscene_CG_SD_L_B02_7_A",
    CnID = "萨尔瓦多大支线CG_蓝色链路",
    BaseSortID = 321,
    Res = "CG/CG_SD/Static/CG_SD_L_B02_7_A.png"
  },
  SScene_DesertRiverNight = {
    ID = "SScene_DesertRiverNight",
    CnID = "圣河沙丘_夜",
    BaseSortID = 322,
    Res = "Scenebg/SScene_DesertRiverNight.png"
  },
  SScene_DesertRiverDay = {
    ID = "SScene_DesertRiverDay",
    CnID = "圣河沙丘_日",
    BaseSortID = 323,
    Res = "Scenebg/SScene_DesertRiverDay.png"
  },
  SScene_DesertTown = {
    ID = "SScene_DesertTown",
    CnID = "亚兰聚居地",
    BaseSortID = 324,
    Res = "Scenebg/SScene_DesertTown.png"
  },
  SScene_DesertRitual = {
    ID = "SScene_DesertRitual",
    CnID = "亚兰仪式",
    BaseSortID = 325,
    Res = "Scenebg/SScene_DesertRitual.png"
  },
  SScene_AbandonedFactories = {
    ID = "SScene_AbandonedFactories",
    CnID = "废弃工厂",
    BaseSortID = 326,
    Res = "Scenebg/SScene_AbandonedFactories.png"
  },
  SScene_GnosticSpaceTree = {
    ID = "SScene_GnosticSpaceTree",
    CnID = "意识空间_母树",
    BaseSortID = 327,
    Res = "Scenebg/SScene_GnosticSpaceTree.png"
  },
  SScene_InTent = {
    ID = "SScene_InTent",
    CnID = "帐篷之内",
    BaseSortID = 328,
    Res = "Scenebg/SScene_InTent.png"
  },
  SScene_TentFireNight = {
    ID = "SScene_TentFireNight",
    CnID = "篝火营地_夜",
    BaseSortID = 329,
    Res = "Scenebg/SScene_SScene_TentFireNight.png"
  },
  SScene_SScene_TentFireDay = {
    ID = "SScene_SScene_TentFireDay",
    CnID = "篝火营地_日",
    BaseSortID = 330,
    Res = "Scenebg/SScene_SScene_TentFireDay.png"
  },
  SScene_CG_SD_S_O06_1 = {
    ID = "SScene_CG_SD_S_O06_1",
    CnID = "戈利亚支线_面对敌人",
    BaseSortID = 331,
    Res = "CG/CG_SD/Static/CG_SD_S_O06_1.png"
  },
  SScene_CG_SD_S_O06_2 = {
    ID = "SScene_CG_SD_S_O06_2",
    CnID = "戈利亚支线_杀戮特写",
    BaseSortID = 332,
    Res = "CG/CG_SD/Static/CG_SD_S_O06_2.png"
  },
  SScene_CG_SD_S_O06_3 = {
    ID = "SScene_CG_SD_S_O06_3",
    CnID = "戈利亚支线_三滴血",
    BaseSortID = 333,
    Res = "CG/CG_SD/Static/CG_SD_S_O06_3.png"
  },
  SScene_CG_SD_S_O06_4 = {
    ID = "SScene_CG_SD_S_O06_4",
    CnID = "戈利亚支线_一滩血",
    BaseSortID = 334,
    Res = "CG/CG_SD/Static/CG_SD_S_O06_4.png"
  },
  SScene_CG_SD_S_O06_6 = {
    ID = "SScene_CG_SD_S_O06_6",
    CnID = "戈利亚支线_战败",
    BaseSortID = 335,
    Res = "CG/CG_SD/Static/CG_SD_S_O06_6.png"
  },
  SScene_CG_SD_S_O06_7 = {
    ID = "SScene_CG_SD_S_O06_7",
    CnID = "戈利亚支线_水底笑容",
    BaseSortID = 336,
    Res = "CG/CG_SD/Static/CG_SD_S_O06_7.png"
  },
  SScene_CG_SD_S_O06_8 = {
    ID = "SScene_CG_SD_S_O06_8",
    CnID = "戈利亚支线_面对阳光特写",
    BaseSortID = 337,
    Res = "CG/CG_SD/Static/CG_SD_S_O06_8.png"
  },
  CGDynamic_SD_S_O06_1 = {
    ID = "CGDynamic_SD_S_O06_1",
    CnID = "戈利亚支线_血滴过渡",
    BaseSortID = 338,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_O06_1.prefab"
  },
  CGDynamic_SD_S_O06_2 = {
    ID = "CGDynamic_SD_S_O06_2",
    CnID = "戈利亚支线_溅血2到3",
    BaseSortID = 339,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_O06_2.prefab"
  },
  CGDynamic_SD_S_O06_3 = {
    ID = "CGDynamic_SD_S_O06_3",
    CnID = "戈利亚支线_战败出现",
    BaseSortID = 340,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_O06_3.prefab"
  },
  SScene_Blood3 = {
    ID = "SScene_Blood3",
    CnID = "剧情背景-溅血3",
    BaseSortID = 341,
    Res = "Scenebg/SScene_Blood3.png"
  },
  SScene_SeasideDusk = {
    ID = "SScene_SeasideDusk",
    CnID = "剧情背景-海边黄昏",
    BaseSortID = 342,
    Res = "Scenebg/SScene_SeasideDusk.png"
  },
  SScene_CG_SD_S_O06_9 = {
    ID = "SScene_CG_SD_S_O06_9",
    CnID = "戈利亚支线_脖子受伤",
    BaseSortID = 343,
    Res = "CG/CG_SD/Static/CG_SD_S_O06_9.png"
  },
  Sscene_CG_SD_S_C06_6 = {
    ID = "Sscene_CG_SD_S_C06_6",
    CnID = "光点飞舞",
    BaseSortID = 344,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_6.png"
  },
  Sscene_CG_SD_S_C06_5 = {
    ID = "Sscene_CG_SD_S_C06_5",
    CnID = "光点飞舞_大",
    BaseSortID = 345,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_5.png"
  },
  Sscene_CG_SD_S_C06_11 = {
    ID = "Sscene_CG_SD_S_C06_11",
    CnID = "成片光点_小",
    BaseSortID = 346,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_11.png"
  },
  CGDynamic_SD_S_C06_1 = {
    ID = "CGDynamic_SD_S_C06_1",
    CnID = "24小支线_人物特写摇镜头",
    BaseSortID = 347,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C06_1.prefab"
  },
  CGDynamic_SD_S_C06_2 = {
    ID = "CGDynamic_SD_S_C06_2",
    CnID = "24小支线_闭眼特写",
    BaseSortID = 348,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C06_2.prefab"
  },
  CGDynamic_SD_S_C06_3 = {
    ID = "CGDynamic_SD_S_C06_3",
    CnID = "24小支线_光河",
    BaseSortID = 349,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C06_3.prefab"
  },
  CGDynamic_SD_S_C06_4 = {
    ID = "CGDynamic_SD_S_C06_4",
    CnID = "24小支线_光河摇镜头",
    BaseSortID = 350,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C06_4.prefab"
  },
  CGDynamic_SD_S_C06_5 = {
    ID = "CGDynamic_SD_S_C06_5",
    CnID = "24小支线_光点近景变中景",
    BaseSortID = 351,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C06_5.prefab"
  },
  CGDynamic_SD_S_C06_6 = {
    ID = "CGDynamic_SD_S_C06_6",
    CnID = "24小支线_光河中景变远景",
    BaseSortID = 352,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C06_6.prefab"
  },
  CGDynamic_SD_S_C06_7 = {
    ID = "CGDynamic_SD_S_C06_7",
    CnID = "24小支线_手碰光点发光",
    BaseSortID = 353,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C06_7.prefab"
  },
  SScene_CG_SD_S_C06_1 = {
    ID = "SScene_CG_SD_S_C06_1",
    CnID = "24小支线_怀抱影子24睁眼",
    BaseSortID = 354,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_1.png"
  },
  SScene_CG_SD_S_C06_2 = {
    ID = "SScene_CG_SD_S_C06_2",
    CnID = "24小支线_怀抱影子24闭眼",
    BaseSortID = 355,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_2.png"
  },
  SScene_CG_SD_S_C06_3 = {
    ID = "SScene_CG_SD_S_C06_3",
    CnID = "24小支线_怀抱影子消失",
    BaseSortID = 356,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_3.png"
  },
  SScene_CG_SD_S_C06_4 = {
    ID = "SScene_CG_SD_S_C06_4",
    CnID = "24小支线_光点近景",
    BaseSortID = 357,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_4.png"
  },
  SScene_CG_SD_S_C06_5 = {
    ID = "SScene_CG_SD_S_C06_5",
    CnID = "24小支线_光点中景",
    BaseSortID = 358,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_5.png"
  },
  SScene_CG_SD_S_C06_6 = {
    ID = "SScene_CG_SD_S_C06_6",
    CnID = "24小支线_光点远景",
    BaseSortID = 359,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_6.png"
  },
  SScene_CG_SD_S_C06_7 = {
    ID = "SScene_CG_SD_S_C06_7",
    CnID = "24小支线_嘴部特写",
    BaseSortID = 360,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_7.png"
  },
  SScene_CG_SD_S_C06_8 = {
    ID = "SScene_CG_SD_S_C06_8",
    CnID = "24小支线_PV中融蚀的怪物",
    BaseSortID = 361,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_8.png"
  },
  SScene_CG_SD_S_C06_10 = {
    ID = "SScene_CG_SD_S_C06_10",
    CnID = "24小支线_光河全景",
    BaseSortID = 362,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_10.png"
  },
  SScene_CG_SD_S_C06_11 = {
    ID = "SScene_CG_SD_S_C06_11",
    CnID = "24小支线_光河回忆中",
    BaseSortID = 363,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_11.png"
  },
  SScene_CG_SD_S_C06_14 = {
    ID = "SScene_CG_SD_S_C06_14",
    CnID = "24小支线_多重人格河",
    BaseSortID = 364,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_14.png"
  },
  SScene_CG_SD_S_C06_15 = {
    ID = "SScene_CG_SD_S_C06_15",
    CnID = "24小支线_手碰光点",
    BaseSortID = 365,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_15.png"
  },
  SScene_CG_SD_S_C06_17 = {
    ID = "SScene_CG_SD_S_C06_17",
    CnID = "24小支线_24核心远景",
    BaseSortID = 366,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_17.png"
  },
  SScene_CG_SD_S_C06_9 = {
    ID = "SScene_CG_SD_S_C06_9",
    CnID = "24小支线_24分裂",
    BaseSortID = 367,
    Res = "CG/CG_SD/Static/CG_SD_S_C06_9.png"
  },
  SScene_InStorm = {
    ID = "SScene_InStorm",
    CnID = "沙尘暴",
    BaseSortID = 368,
    Res = "Scenebg/SScene_InStorm.png"
  },
  Sscene_CG_SD_L_B02_7_C = {
    ID = "Sscene_CG_SD_L_B02_7_C",
    CnID = "白色链路",
    BaseSortID = 369,
    Res = "CG/CG_SD/Static/CG_SD_L_B02_7_C.png"
  },
  SScene_CG_C07_001 = {
    ID = "SScene_CG_C07_001",
    CnID = "第七章CG-跳舞",
    BaseSortID = 370,
    Res = "CG/C07/Static/CG_C07_001.png"
  },
  SScene_CG_C07_002 = {
    ID = "SScene_CG_C07_002",
    CnID = "第七章CG-靠近",
    BaseSortID = 371,
    Res = "CG/C07/Static/CG_C07_002.png"
  },
  SScene_CG_C07_003 = {
    ID = "SScene_CG_C07_003",
    CnID = "临别相拥",
    BaseSortID = 372,
    Res = "CG/C07/Static/CG_C07_003.png"
  },
  SScene_CG_C07_004 = {
    ID = "SScene_CG_C07_004",
    CnID = "第七章CG-面部特写",
    BaseSortID = 373,
    Res = "CG/C07/Static/CG_C07_004.png"
  },
  SScene_CG_C07_005 = {
    ID = "SScene_CG_C07_005",
    CnID = "第七章CG-1个融蚀脚印",
    BaseSortID = 374,
    Res = "CG/C07/Static/CG_C07_005.png"
  },
  SScene_CG_C07_007 = {
    ID = "SScene_CG_C07_007",
    CnID = "第七章CG-多个融蚀脚印",
    BaseSortID = 375,
    Res = "CG/C07/Static/CG_C07_007.png"
  },
  SScene_CG_C07_008 = {
    ID = "SScene_CG_C07_008",
    CnID = "风暴之壁",
    BaseSortID = 376,
    Res = "CG/C07/Static/CG_C07_008.png"
  },
  SScene_CG_C07_009 = {
    ID = "SScene_CG_C07_009",
    CnID = "第七章CG-破碎银钥",
    BaseSortID = 377,
    Res = "CG/C07/Static/CG_C07_009.png"
  },
  SScene_CG_C07_010 = {
    ID = "SScene_CG_C07_010",
    CnID = "第七章CG-提灯",
    BaseSortID = 378,
    Res = "CG/C07/Static/CG_C07_010.png"
  },
  SScene_CG_C07_011 = {
    ID = "SScene_CG_C07_011",
    CnID = "威廉之死",
    BaseSortID = 379,
    Res = "CG/C07/Static/CG_C07_011.png"
  },
  SScene_CG_C07_012 = {
    ID = "SScene_CG_C07_012",
    CnID = "黑白混乱内心",
    BaseSortID = 380,
    Res = "CG/C07/Static/CG_C07_012.png"
  },
  SScene_CG_C07_013 = {
    ID = "SScene_CG_C07_013",
    CnID = "第七章CG-眼睛特写",
    BaseSortID = 381,
    Res = "CG/C07/Static/CG_C07_013.png"
  },
  SScene_CG_C07_014 = {
    ID = "SScene_CG_C07_014",
    CnID = "第七章CG-吊坠特写",
    BaseSortID = 382,
    Res = "CG/C07/Static/CG_C07_014.png"
  },
  CGDynamic_C07_001 = {
    ID = "CGDynamic_C07_001",
    CnID = "第七章CG-2个融蚀脚印出现",
    BaseSortID = 383,
    Res = "CG/C07/Prefab/CGDynamic_C07_01.prefab"
  },
  CGDynamic_C07_002 = {
    ID = "CGDynamic_C07_002",
    CnID = "第七章CG-多个融蚀脚印出现",
    BaseSortID = 384,
    Res = "CG/C07/Prefab/CGDynamic_C07_02.prefab"
  },
  CGDynamic_C07_003 = {
    ID = "CGDynamic_C07_003",
    CnID = "第七章CG-亲吻胸口特写",
    BaseSortID = 385,
    Res = "CG/C07/Prefab/CGDynamic_C07_03.prefab"
  },
  CGDynamic_C07_004 = {
    ID = "CGDynamic_C07_004",
    CnID = "月下之吻",
    BaseSortID = 386,
    Res = "CG/C07/Prefab/CGDynamic_C07_04.prefab"
  },
  CGDynamic_C07_005 = {
    ID = "CGDynamic_C07_005",
    CnID = "第七章CG-亲吻嘴部特写",
    BaseSortID = 387,
    Res = "CG/C07/Prefab/CGDynamic_C07_05.prefab"
  },
  SScene_CG_C07_017 = {
    ID = "SScene_CG_C07_017",
    CnID = "圣树复生",
    BaseSortID = 388,
    Res = "CG/C07/Static/CG_C07_017.png"
  },
  CGDynamic_C07_006 = {
    ID = "CGDynamic_C07_006",
    CnID = "第七章CG-威廉之死导入",
    BaseSortID = 389,
    Res = "CG/C07/Prefab/CGDynamic_C07_06.prefab"
  },
  SScene_CG_C07_018 = {
    ID = "SScene_CG_C07_018",
    CnID = "亚兰人献祭",
    BaseSortID = 390,
    Res = "CG/C07/Static/CG_C07_018.png"
  },
  SScene_CG_C07_019 = {
    ID = "SScene_CG_C07_019",
    CnID = "亚兰人献祭远景",
    BaseSortID = 391,
    Res = "CG/C07/Static/CG_C07_019.png"
  },
  CGDynamic_C07_007 = {
    ID = "CGDynamic_C07_007",
    CnID = "第七章CG-胸口特写",
    BaseSortID = 392,
    Res = "CG/C07/Prefab/CGDynamic_C07_07.prefab"
  },
  CGDynamic_C07_008 = {
    ID = "CGDynamic_C07_008",
    CnID = "第七章CG-笑脸特写",
    BaseSortID = 393,
    Res = "CG/C07/Prefab/CGDynamic_C07_08.prefab"
  },
  CGDynamic_C07_009 = {
    ID = "CGDynamic_C07_009",
    CnID = "第七章CG-笑脸到跳舞",
    BaseSortID = 394,
    Res = "CG/C07/Prefab/CGDynamic_C07_09.prefab"
  },
  SScene_CG_C07_020 = {
    ID = "SScene_CG_C07_020",
    CnID = "呼吸",
    BaseSortID = 395,
    Res = "CG/C07/Static/CG_C07_020.png"
  },
  SScene_GrownTree = {
    ID = "SScene_GrownTree",
    CnID = "母树高天",
    BaseSortID = 396,
    Res = "Scenebg/SScene_GrownTree.png"
  },
  SScene_CG_C07_021 = {
    ID = "SScene_CG_C07_021",
    CnID = "风暴之壁-黑影版",
    BaseSortID = 397,
    Res = "CG/C07/Static/CG_C07_021.png"
  },
  CGDynamic_C07_010 = {
    ID = "CGDynamic_C07_010",
    CnID = "第七章CG-风暴之壁现身",
    BaseSortID = 398,
    Res = "CG/C07/Prefab/CGDynamic_C07_10.prefab"
  },
  CGDynamic_C07_011 = {
    ID = "CGDynamic_C07_011",
    CnID = "第七章CG-战后投河的亚兰人",
    BaseSortID = 399,
    Res = "CG/C07/Prefab/CGDynamic_C07_11.prefab"
  },
  SScene_CG_C07_022 = {
    ID = "SScene_CG_C07_022",
    CnID = "第七章CG-BOSS战前定格",
    BaseSortID = 400,
    Res = "CG/C07/Static/CG_C07_022.png"
  },
  CGDynamic_C07_012 = {
    ID = "CGDynamic_C07_012",
    CnID = "第七章CG-亲吻切换到种子",
    BaseSortID = 401,
    Res = "CG/C07/Prefab/CGDynamic_C07_12.prefab"
  },
  SScene_CG_SD_L_B05EX_1 = {
    ID = "SScene_CG_SD_L_B05EX_1",
    CnID = "本源希洛_亚弗姆扎剪影",
    BaseSortID = 402,
    Res = "CG/CG_SD/Static/CG_SD_L_B05EX_1.png"
  },
  SScene_CG_SD_L_B05EX_2 = {
    ID = "SScene_CG_SD_L_B05EX_2",
    CnID = "本源希洛_脓包包裹",
    BaseSortID = 403,
    Res = "CG/CG_SD/Static/CG_SD_L_B05EX_2.png"
  },
  SScene_CG_SD_L_B05EX_3 = {
    ID = "SScene_CG_SD_L_B05EX_3",
    CnID = "本源希洛_跪地特写",
    BaseSortID = 404,
    Res = "CG/CG_SD/Static/CG_SD_L_B05EX_3.png"
  },
  SScene_CG_SD_L_B05EX_4 = {
    ID = "SScene_CG_SD_L_B05EX_4",
    CnID = "本源希洛_跪地全身",
    BaseSortID = 405,
    Res = "CG/CG_SD/Static/CG_SD_L_B05EX_4.png"
  },
  SScene_CG_SD_L_B05EX_5 = {
    ID = "SScene_CG_SD_L_B05EX_5",
    CnID = "本源希洛_背影雪山中景",
    BaseSortID = 406,
    Res = "CG/CG_SD/Static/CG_SD_L_B05EX_7.png"
  },
  SScene_CG_SD_L_B05EX_6 = {
    ID = "SScene_CG_SD_L_B05EX_6",
    CnID = "本源希洛_新闻报导",
    BaseSortID = 407,
    Res = "CG/CG_SD/Static/CG_SD_L_B05EX_6.png"
  },
  SScene_CG_SD_L_B05EX_7 = {
    ID = "SScene_CG_SD_L_B05EX_7",
    CnID = "本源希洛_背影雪山远景",
    BaseSortID = 408,
    Res = "CG/CG_SD/Static/CG_SD_L_B05EX_8.png"
  },
  CGDynamic_SD_L_B05EX_1 = {
    ID = "CGDynamic_SD_L_B05EX_1",
    CnID = "本源希洛_背影雪山拉远",
    BaseSortID = 409,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_B05EX_1.prefab"
  },
  CGDynamic_SD_L_B05EX_2 = {
    ID = "CGDynamic_SD_L_B05EX_2",
    CnID = "本源希洛_黑入脓包包裹",
    BaseSortID = 410,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_B05EX_2.prefab"
  },
  SScene_PoetryGarden = {
    ID = "SScene_PoetryGarden",
    CnID = "诗中世界_花园",
    BaseSortID = 411,
    Res = "Scenebg/SScene_PoetryGarden.png"
  },
  SScene_PoetryGarden1 = {
    ID = "SScene_PoetryGarden1",
    CnID = "诗中世界_花园街道",
    BaseSortID = 412,
    Res = "Scenebg/SScene_PoetryGarden1.png"
  },
  SScene_PoetryStreet1 = {
    ID = "SScene_PoetryStreet1",
    CnID = "诗中世界_街道",
    BaseSortID = 413,
    Res = "Scenebg/SScene_PoetryStreet1.png"
  },
  SScene_PoetryStreet2 = {
    ID = "SScene_PoetryStreet2",
    CnID = "诗中世界_异化街道",
    BaseSortID = 414,
    Res = "Scenebg/SScene_PoetryStreet2.png"
  },
  SScene_PoetryManor = {
    ID = "SScene_PoetryManor",
    CnID = "诗中世界_庄园",
    BaseSortID = 415,
    Res = "Scenebg/SScene_PoetryManor.png"
  },
  SScene_GlacialRelics = {
    ID = "SScene_GlacialRelics",
    CnID = "冰川遗迹",
    BaseSortID = 416,
    Res = "Scenebg/SScene_GlacialRelics.png"
  },
  SScene_CG_SD_L_O07_1 = {
    ID = "SScene_CG_SD_L_O07_1",
    CnID = "弥利亚姆_图鲁梦境",
    BaseSortID = 417,
    Res = "CG/CG_SD/Static/CG_SD_L_O07_1.png"
  },
  SScene_CG_SD_L_O07_2 = {
    ID = "SScene_CG_SD_L_O07_2",
    CnID = "弥利亚姆_图鲁王座远景",
    BaseSortID = 418,
    Res = "CG/CG_SD/Static/CG_SD_L_O07_2.png"
  },
  SScene_CG_SD_L_O07_3 = {
    ID = "SScene_CG_SD_L_O07_3",
    CnID = "弥利亚姆_血腥匕首",
    BaseSortID = 419,
    Res = "CG/CG_SD/Static/CG_SD_L_O07_3.png"
  },
  SScene_CG_SD_L_O07_4 = {
    ID = "SScene_CG_SD_L_O07_4",
    CnID = "弥利亚姆_扭曲三滴血",
    BaseSortID = 420,
    Res = "CG/CG_SD/Static/CG_SD_L_O07_4.png"
  },
  SScene_CG_SD_L_O07_5 = {
    ID = "SScene_CG_SD_L_O07_5",
    CnID = "弥利亚姆_扭曲红屏血",
    BaseSortID = 421,
    Res = "CG/CG_SD/Static/CG_SD_L_O07_5.png"
  },
  SScene_CG_SD_L_O07_6 = {
    ID = "SScene_CG_SD_L_O07_6",
    CnID = "弥利亚姆_迷茫特写",
    BaseSortID = 422,
    Res = "CG/CG_SD/Static/CG_SD_L_O07_6.png"
  },
  SScene_CG_SD_L_O07_7 = {
    ID = "SScene_CG_SD_L_O07_7",
    CnID = "弥利亚姆_闭眼特写",
    BaseSortID = 423,
    Res = "CG/CG_SD/Static/CG_SD_L_O07_7.png"
  },
  SScene_CG_SD_L_O07_8 = {
    ID = "SScene_CG_SD_L_O07_8",
    CnID = "弥利亚姆_浪花",
    BaseSortID = 424,
    Res = "CG/CG_SD/Static/CG_SD_L_O07_8.png"
  },
  SScene_CG_SD_L_O07_9 = {
    ID = "SScene_CG_SD_L_O07_9",
    CnID = "弥利亚姆_剖腹圣婴",
    BaseSortID = 425,
    Res = "CG/CG_SD/Static/CG_SD_L_O07_9.png"
  },
  SScene_CG_SD_L_O07_10 = {
    ID = "SScene_CG_SD_L_O07_10",
    CnID = "弥利亚姆_簇拥圣胎",
    BaseSortID = 426,
    Res = "CG/CG_SD/Static/CG_SD_L_O07_10.png"
  },
  SScene_CG_SD_L_O07_11 = {
    ID = "SScene_CG_SD_L_O07_11",
    CnID = "弥利亚姆_雕像特写",
    BaseSortID = 427,
    Res = "CG/CG_SD/Static/CG_SD_L_O07_11.png"
  },
  SScene_CG_SD_L_O07_12 = {
    ID = "SScene_CG_SD_L_O07_12",
    CnID = "弥利亚姆_风暴袭岛",
    BaseSortID = 428,
    Res = "CG/CG_SD/Static/CG_SD_L_O07_12.png"
  },
  CGDynamic_SD_L_O07_1 = {
    ID = "CGDynamic_SD_L_O07_1",
    CnID = "弥利亚姆_进入图鲁梦境叠化",
    BaseSortID = 429,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_O07_1.prefab"
  },
  CGDynamic_SD_L_O07_2 = {
    ID = "CGDynamic_SD_L_O07_2",
    CnID = "弥利亚姆_梦境叠化清晰",
    BaseSortID = 430,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_O07_2.prefab"
  },
  CGDynamic_SD_L_O07_3 = {
    ID = "CGDynamic_SD_L_O07_3",
    CnID = "弥利亚姆_血液叠化扭曲",
    BaseSortID = 431,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_O07_3.prefab"
  },
  CGDynamic_SD_L_O07_4 = {
    ID = "CGDynamic_SD_L_O07_4",
    CnID = "弥利亚姆_迷茫叠化闭眼",
    BaseSortID = 432,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_O07_4.prefab"
  },
  CGDynamic_SD_L_O07_5 = {
    ID = "CGDynamic_SD_L_O07_5",
    CnID = "弥利亚姆_闭眼叠化浪花",
    BaseSortID = 433,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_O07_5.prefab"
  },
  CGDynamic_SD_L_O07_6 = {
    ID = "CGDynamic_SD_L_O07_6",
    CnID = "弥利亚姆_血滩叠化血屏扭曲",
    BaseSortID = 434,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_O07_6.prefab"
  },
  SScene_StoneTemple = {
    ID = "SScene_StoneTemple",
    CnID = "利莫里亚神殿内部",
    BaseSortID = 435,
    Res = "Scenebg/SScene_StoneTemple.png"
  },
  SScene_StoneAltar = {
    ID = "SScene_StoneAltar",
    CnID = "利莫里亚神殿内部_祭坛",
    BaseSortID = 436,
    Res = "Scenebg/SScene_StoneAltar.png"
  },
  SScene_CG_SD_L_D06_1 = {
    ID = "SScene_CG_SD_L_D06_1",
    CnID = "奥尔拉_冲破荆棘_黑",
    BaseSortID = 437,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_1.png"
  },
  SScene_CG_SD_L_D06_2 = {
    ID = "SScene_CG_SD_L_D06_2",
    CnID = "奥尔拉_冲破荆棘_彩",
    BaseSortID = 438,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_2.png"
  },
  SScene_CG_SD_L_D06_3 = {
    ID = "SScene_CG_SD_L_D06_3",
    CnID = "奥尔拉_手握玫瑰_黑1",
    BaseSortID = 439,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_3.png"
  },
  ["SScene_CG_SD_L_D06_3-2"] = {
    ID = "SScene_CG_SD_L_D06_3-2",
    CnID = "奥尔拉_手握玫瑰_黑2",
    BaseSortID = 440,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_3-2.png"
  },
  ["SScene_CG_SD_L_D06_3-3"] = {
    ID = "SScene_CG_SD_L_D06_3-3",
    CnID = "奥尔拉_手握玫瑰_黑3",
    BaseSortID = 441,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_3-3.png"
  },
  SScene_CG_SD_L_D06_4 = {
    ID = "SScene_CG_SD_L_D06_4",
    CnID = "奥尔拉_手握玫瑰_彩",
    BaseSortID = 442,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_4.png"
  },
  ["SScene_CG_SD_L_D06_4-1"] = {
    ID = "SScene_CG_SD_L_D06_4-1",
    CnID = "奥尔拉_手握玫瑰_彩上",
    BaseSortID = 443,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_4-1.png"
  },
  SScene_CG_SD_L_D06_5 = {
    ID = "SScene_CG_SD_L_D06_5",
    CnID = "奥尔拉_玫瑰沾血",
    BaseSortID = 444,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_5.png"
  },
  ["SScene_CG_SD_L_D06_5-1"] = {
    ID = "SScene_CG_SD_L_D06_5-1",
    CnID = "奥尔拉_玫瑰沾血_左",
    BaseSortID = 445,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_5-1.png"
  },
  SScene_CG_SD_L_D06_6 = {
    ID = "SScene_CG_SD_L_D06_6",
    CnID = "奥尔拉_两人特写",
    BaseSortID = 446,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_6.png"
  },
  ["SScene_CG_SD_L_D06_7-1"] = {
    ID = "SScene_CG_SD_L_D06_7-1",
    CnID = "奥尔拉_气氛变暖1",
    BaseSortID = 447,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_7-1.png"
  },
  ["SScene_CG_SD_L_D06_7-2"] = {
    ID = "SScene_CG_SD_L_D06_7-2",
    CnID = "奥尔拉_气氛变暖2",
    BaseSortID = 448,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_7-2.png"
  },
  ["SScene_CG_SD_L_D06_7-3"] = {
    ID = "SScene_CG_SD_L_D06_7-3",
    CnID = "奥尔拉_气氛变暖3",
    BaseSortID = 449,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_7-3.png"
  },
  ["SScene_CG_SD_L_D06_7-4"] = {
    ID = "SScene_CG_SD_L_D06_7-4",
    CnID = "奥尔拉_气氛变暖4",
    BaseSortID = 450,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_7-4.png"
  },
  ["SScene_CG_SD_L_D06_7-5"] = {
    ID = "SScene_CG_SD_L_D06_7-5",
    CnID = "奥尔拉_济贫院外_黑白",
    BaseSortID = 451,
    Res = "CG/CG_SD/Static/CG_SD_L_D06_7-5.png"
  },
  CGDynamic_SD_L_D06_1 = {
    ID = "CGDynamic_SD_L_D06_1",
    CnID = "奥尔拉_玫瑰沾血_右移",
    BaseSortID = 452,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_D06_1.prefab"
  },
  CGDynamic_SD_L_D06_2 = {
    ID = "CGDynamic_SD_L_D06_2",
    CnID = "奥尔拉_荆棘全景叠化特写",
    BaseSortID = 453,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_D06_2.prefab"
  },
  CGDynamic_SD_L_D06_3 = {
    ID = "CGDynamic_SD_L_D06_3",
    CnID = "奥尔拉_手握玫瑰彩_下摇",
    BaseSortID = 454,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_D06_3.prefab"
  },
  CGDynamic_SD_L_D06_4 = {
    ID = "CGDynamic_SD_L_D06_4",
    CnID = "奥尔拉_手握玫瑰1叠2",
    BaseSortID = 455,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_D06_4.prefab"
  },
  CGDynamic_SD_L_D06_5 = {
    ID = "CGDynamic_SD_L_D06_5",
    CnID = "奥尔拉_手握玫瑰2叠3",
    BaseSortID = 456,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_D06_5.prefab"
  },
  CGDynamic_SD_L_D06_6 = {
    ID = "CGDynamic_SD_L_D06_6",
    CnID = "奥尔拉_玫瑰叠化溅血",
    BaseSortID = 457,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_D06_6.prefab"
  },
  CGDynamic_SD_L_D06_7 = {
    ID = "CGDynamic_SD_L_D06_7",
    CnID = "奥尔拉_白色叠化玫瑰",
    BaseSortID = 458,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_D06_7.prefab"
  },
  CGDynamic_SD_L_D06_8 = {
    ID = "CGDynamic_SD_L_D06_8",
    CnID = "奥尔拉_暖色叠化冲破荆棘",
    BaseSortID = 459,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_L_D06_8.prefab"
  },
  SScene_AncientMurals = {
    ID = "SScene_AncientMurals",
    CnID = "古代壁画",
    BaseSortID = 460,
    Res = "Scenebg/SScene_AncientMurals.png"
  },
  SScene_CG_SD_S_C05_1 = {
    ID = "SScene_CG_SD_S_C05_1",
    CnID = "莱克_给枪上膛",
    BaseSortID = 461,
    Res = "CG/CG_SD/Static/CG_SD_S_C05_1.png"
  },
  SScene_CG_SD_S_C05_2 = {
    ID = "SScene_CG_SD_S_C05_2",
    CnID = "莱克_枪抵喉咙",
    BaseSortID = 462,
    Res = "CG/CG_SD/Static/CG_SD_S_C05_2.png"
  },
  SScene_CG_SD_S_C05_3 = {
    ID = "SScene_CG_SD_S_C05_3",
    CnID = "莱克_枪抵喉咙特写",
    BaseSortID = 463,
    Res = "CG/CG_SD/Static/CG_SD_S_C05_3.png"
  },
  SScene_CG_SD_S_C05_5 = {
    ID = "SScene_CG_SD_S_C05_5",
    CnID = "莱克_窗前双人",
    BaseSortID = 464,
    Res = "CG/CG_SD/Static/CG_SD_S_C05_5.png"
  },
  SScene_CG_SD_S_C05_6 = {
    ID = "SScene_CG_SD_S_C05_6",
    CnID = "莱克_月下奔袭",
    BaseSortID = 465,
    Res = "CG/CG_SD/Static/CG_SD_S_C05_6.png"
  },
  SScene_CG_SD_S_C05_7 = {
    ID = "SScene_CG_SD_S_C05_7",
    CnID = "莱克_举枪",
    BaseSortID = 466,
    Res = "CG/CG_SD/Static/CG_SD_S_C05_7.png"
  },
  SScene_CG_SD_S_C05_8 = {
    ID = "SScene_CG_SD_S_C05_8",
    CnID = "莱克_射中屏幕",
    BaseSortID = 467,
    Res = "CG/CG_SD/Static/CG_SD_S_C05_8.png"
  },
  CGDynamic_SD_SD_S_C05_1 = {
    ID = "CGDynamic_SD_SD_S_C05_1",
    CnID = "莱克_枪抵喉咙摇镜头",
    BaseSortID = 468,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C05_1.prefab"
  },
  CGDynamic_SD_SD_S_C05_2 = {
    ID = "CGDynamic_SD_SD_S_C05_2",
    CnID = "莱克_枪击快闪",
    BaseSortID = 469,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C05_2.prefab"
  },
  SScene_RedClock = {
    ID = "SScene_RedClock",
    CnID = "红色时钟",
    BaseSortID = 470,
    Res = "Scenebg/SScene_RedClock.png"
  },
  SScene_GraffitiMurals = {
    ID = "SScene_GraffitiMurals",
    CnID = "古代壁画_变异",
    BaseSortID = 471,
    Res = "Scenebg/SScene_GraffitiMurals.png"
  },
  SScene_EmptyBlackPool = {
    ID = "SScene_EmptyBlackPool",
    CnID = "空白黑池",
    BaseSortID = 472,
    Res = "Scenebg/SScene_EmptyBlackPool.png"
  },
  SScene_MusicRoom = {
    ID = "SScene_MusicRoom",
    CnID = "音乐教室",
    BaseSortID = 473,
    Res = "Scenebg/SScene_MusicRoom.png"
  },
  SScene_SchoolCorridor = {
    ID = "SScene_SchoolCorridor",
    CnID = "弥萨格走廊",
    BaseSortID = 474,
    Res = "Scenebg/SScene_SchoolCorridor.png"
  },
  SScene_SchoolGround = {
    ID = "SScene_SchoolGround",
    CnID = "弥萨格广场",
    BaseSortID = 475,
    Res = "Scenebg/SScene_SchoolGround.png"
  },
  SScene_SchoolGroundNight = {
    ID = "SScene_SchoolGroundNight",
    CnID = "弥萨格广场_夜",
    BaseSortID = 476,
    Res = "Scenebg/SScene_SchoolGroundNight.png"
  },
  SScene_CG_C08_001 = {
    ID = "SScene_CG_C08_001",
    CnID = "第八章CG-起手式",
    BaseSortID = 477,
    Res = "CG/C08/Static/CG_C08_001.png"
  },
  SScene_CG_C08_002 = {
    ID = "SScene_CG_C08_002",
    CnID = "第八章CG-踏步",
    BaseSortID = 478,
    Res = "CG/C08/Static/CG_C08_002.png"
  },
  SScene_CG_C08_003 = {
    ID = "SScene_CG_C08_003",
    CnID = "第八章CG-站立致意",
    BaseSortID = 479,
    Res = "CG/C08/Static/CG_C08_003.png"
  },
  SScene_CG_C08_004 = {
    ID = "SScene_CG_C08_004",
    CnID = "第八章CG-指尖乐谱",
    BaseSortID = 480,
    Res = "CG/C08/Static/CG_C08_004.png"
  },
  SScene_CG_C08_005 = {
    ID = "SScene_CG_C08_005",
    CnID = "第八章CG-哈姆林出场",
    BaseSortID = 481,
    Res = "CG/C08/Static/CG_C08_005.png"
  },
  SScene_CG_C08_006 = {
    ID = "SScene_CG_C08_006",
    CnID = "第八章CG-拉蒙娜受困",
    BaseSortID = 482,
    Res = "CG/C08/Static/CG_C08_006.png"
  },
  SScene_CG_C08_007 = {
    ID = "SScene_CG_C08_007",
    CnID = "第八章CG-N现身",
    BaseSortID = 483,
    Res = "CG/C08/Static/CG_C08_007.png"
  },
  SScene_CG_C08_008 = {
    ID = "SScene_CG_C08_008",
    CnID = "第八章CG-哈姆林叛变闭眼",
    BaseSortID = 484,
    Res = "CG/C08/Static/CG_C08_008.png"
  },
  SScene_CG_C08_009 = {
    ID = "SScene_CG_C08_009",
    CnID = "第八章CG-哈姆林叛变睁眼",
    BaseSortID = 485,
    Res = "CG/C08/Static/CG_C08_009.png"
  },
  SScene_CG_C08_010 = {
    ID = "SScene_CG_C08_010",
    CnID = "第八章CG-哈姆林叛变特写",
    BaseSortID = 486,
    Res = "CG/C08/Static/CG_C08_010.png"
  },
  SScene_CG_C08_011 = {
    ID = "SScene_CG_C08_011",
    CnID = "第八章CG-门",
    BaseSortID = 487,
    Res = "CG/C08/Static/CG_C08_011.png"
  },
  SScene_CG_C08_012 = {
    ID = "SScene_CG_C08_012",
    CnID = "第八章CG-眼睛",
    BaseSortID = 488,
    Res = "CG/C08/Static/CG_C08_012.png"
  },
  CGDynamic_C08_001 = {
    ID = "CGDynamic_C08_001",
    CnID = "第八章CG-起手式到星星点点",
    BaseSortID = 489,
    Res = "CG/C08/Prefab/CGDynamic_C08_01.prefab"
  },
  CGDynamic_C08_002 = {
    ID = "CGDynamic_C08_002",
    CnID = "第八章CG-踏步到站立致意",
    BaseSortID = 490,
    Res = "CG/C08/Prefab/CGDynamic_C08_02.prefab"
  },
  CGDynamic_C08_003 = {
    ID = "CGDynamic_C08_003",
    CnID = "第八章CG-哈姆林叛变闭眼到睁眼",
    BaseSortID = 491,
    Res = "CG/C08/Prefab/CGDynamic_C08_03.prefab"
  },
  CGDynamic_C08_004 = {
    ID = "CGDynamic_C08_004",
    CnID = "第八章CG-N出现到抽象白点",
    BaseSortID = 492,
    Res = "CG/C08/Prefab/CGDynamic_C08_04.prefab"
  },
  CGDynamic_C08_005 = {
    ID = "CGDynamic_C08_005",
    CnID = "第八章CG-拉蒙娜受困到黑屏",
    BaseSortID = 493,
    Res = "CG/C08/Prefab/CGDynamic_C08_05.prefab"
  },
  CGDynamic_C08_006 = {
    ID = "CGDynamic_C08_006",
    CnID = "第八章CG-星星点点到黑屏",
    BaseSortID = 494,
    Res = "CG/C08/Prefab/CGDynamic_C08_06.prefab"
  },
  CGDynamic_C08_007 = {
    ID = "CGDynamic_C08_007",
    CnID = "第八章CG-站立致意到黑屏",
    BaseSortID = 495,
    Res = "CG/C08/Prefab/CGDynamic_C08_07.prefab"
  },
  SScene_CG_C01_test_M = {
    ID = "SScene_CG_C01_test_M",
    CnID = "测试男",
    BaseSortID = 496,
    Res = "CG/C01/Static/test_M.png"
  },
  SScene_CG_C01_test_F = {
    ID = "SScene_CG_C01_test_F",
    CnID = "测试女",
    BaseSortID = 497,
    Res = "CG/C01/Static/test_F.png"
  },
  SScene_CG_C09_001 = {
    ID = "SScene_CG_C09_001",
    CnID = "塔微近景",
    BaseSortID = 498,
    Res = "CG/C09/Static/CG_C09_001.png"
  },
  SScene_CG_C09_002 = {
    ID = "SScene_CG_C09_002",
    CnID = "塔微中景",
    BaseSortID = 499,
    Res = "CG/C09/Static/CG_C09_002.png"
  },
  SScene_CG_C09_003 = {
    ID = "SScene_CG_C09_003",
    CnID = "黑池-无塔微版",
    BaseSortID = 500,
    Res = "CG/C09/Static/CG_C09_003.png"
  },
  SScene_CG_C09_004_1_F = {
    ID = "SScene_CG_C09_004_1_F",
    CnID = "门内女学生闭眼静态",
    BaseSortID = 501,
    Res = "CG/C09/Static/CG_C09_004_1_F.png"
  },
  SScene_CG_C09_004_1_M = {
    ID = "SScene_CG_C09_004_1_M",
    CnID = "门内男学生闭眼静态",
    BaseSortID = 502,
    Res = "CG/C09/Static/CG_C09_004_1_M.png"
  },
  SScene_CG_C09_004_F = {
    ID = "SScene_CG_C09_004_F",
    CnID = "门内女学生睁眼静态",
    BaseSortID = 503,
    Res = "CG/C09/Static/CG_C09_004_F.png"
  },
  SScene_CG_C09_004_M = {
    ID = "SScene_CG_C09_004_M",
    CnID = "门内男学生睁眼静态",
    BaseSortID = 504,
    Res = "CG/C09/Static/CG_C09_004_M.png"
  },
  SScene_CG_C09_005_F = {
    ID = "SScene_CG_C09_005_F",
    CnID = "黑底女学生闭眼",
    BaseSortID = 505,
    Res = "CG/C09/Static/CG_C09_005_F.png"
  },
  SScene_CG_C09_005_M = {
    ID = "SScene_CG_C09_005_M",
    CnID = "黑底男学生闭眼",
    BaseSortID = 506,
    Res = "CG/C09/Static/CG_C09_005_M.png"
  },
  SScene_CG_C09_006_F = {
    ID = "SScene_CG_C09_006_F",
    CnID = "女学生漂浮",
    BaseSortID = 507,
    Res = "CG/C09/Static/CG_C09_006_F.png"
  },
  SScene_CG_C09_006_M = {
    ID = "SScene_CG_C09_006_M",
    CnID = "男学生漂浮",
    BaseSortID = 508,
    Res = "CG/C09/Static/CG_C09_006_M.png"
  },
  SScene_CG_C09_007 = {
    ID = "SScene_CG_C09_007",
    CnID = "学生手心混沌",
    BaseSortID = 509,
    Res = "CG/C09/Static/CG_C09_007.png"
  },
  SScene_CG_C09_008 = {
    ID = "SScene_CG_C09_008",
    CnID = "学生手心周围出现亮点",
    BaseSortID = 510,
    Res = "CG/C09/Static/CG_C09_008.png"
  },
  SScene_CG_C09_009 = {
    ID = "SScene_CG_C09_009",
    CnID = "学生手心恢复",
    BaseSortID = 511,
    Res = "CG/C09/Static/CG_C09_009.png"
  },
  SScene_CG_C09_010 = {
    ID = "SScene_CG_C09_010",
    CnID = "拉蒙娜望向玩家",
    BaseSortID = 512,
    Res = "CG/C09/Static/CG_C09_010.png"
  },
  SScene_CG_C09_011_F = {
    ID = "SScene_CG_C09_011_F",
    CnID = "女学生面对阿撒",
    BaseSortID = 513,
    Res = "CG/C09/Static/CG_C09_011_F.png"
  },
  SScene_CG_C09_011_M = {
    ID = "SScene_CG_C09_011_M",
    CnID = "男学生面对阿撒",
    BaseSortID = 514,
    Res = "CG/C09/Static/CG_C09_011_M.png"
  },
  SScene_CG_C09_012 = {
    ID = "SScene_CG_C09_012",
    CnID = "拉蒙娜拿着钥匙",
    BaseSortID = 515,
    Res = "CG/C09/Static/CG_C09_012.png"
  },
  SScene_CG_C09_013 = {
    ID = "SScene_CG_C09_013",
    CnID = "拉蒙娜拿着钥匙泪水模糊",
    BaseSortID = 516,
    Res = "CG/C09/Static/CG_C09_013.png"
  },
  SScene_CG_C09_014 = {
    ID = "SScene_CG_C09_014",
    CnID = "门口的钥匙",
    BaseSortID = 517,
    Res = "CG/C09/Static/CG_C09_014.png"
  },
  SScene_CG_C09_015 = {
    ID = "SScene_CG_C09_015",
    CnID = "点点中景-门内世界版",
    BaseSortID = 518,
    Res = "CG/C09/Static/CG_C09_015.png"
  },
  SScene_CG_C09_016 = {
    ID = "SScene_CG_C09_016",
    CnID = "门内泡泡单独",
    BaseSortID = 519,
    Res = "CG/C09/Static/CG_C09_016.png"
  },
  SScene_CG_C09_017 = {
    ID = "SScene_CG_C09_017",
    CnID = "托乎瓦波睁眼",
    BaseSortID = 520,
    Res = "CG/C09/Static/CG_C09_017.png"
  },
  CGDynamic_C09_001 = {
    ID = "CGDynamic_C09_001",
    CnID = "第九章CG-塔微近景转中景",
    BaseSortID = 521,
    Res = "CG/C09/Prefab/CGDynamic_C09_01.prefab"
  },
  CGDynamic_C09_002_0_F = {
    ID = "CGDynamic_C09_002_0_F",
    CnID = "门内女学生闭眼",
    BaseSortID = 522,
    Res = "CG/C09/Prefab/CGDynamic_C09_02_0_F.prefab"
  },
  CGDynamic_C09_002_0_M = {
    ID = "CGDynamic_C09_002_0_M",
    CnID = "门内男学生闭眼",
    BaseSortID = 523,
    Res = "CG/C09/Prefab/CGDynamic_C09_02_0_M.prefab"
  },
  CGDynamic_C09_002_1_F = {
    ID = "CGDynamic_C09_002_1_F",
    CnID = "门内女学生睁眼",
    BaseSortID = 524,
    Res = "CG/C09/Prefab/CGDynamic_C09_02_1_F.prefab"
  },
  CGDynamic_C09_002_1_M = {
    ID = "CGDynamic_C09_002_1_M",
    CnID = "门内男学生睁眼",
    BaseSortID = 525,
    Res = "CG/C09/Prefab/CGDynamic_C09_02_1_M.prefab"
  },
  CGDynamic_C09_002_F = {
    ID = "CGDynamic_C09_002_F",
    CnID = "门内女学生睁眼中景拉镜头",
    BaseSortID = 526,
    Res = "CG/C09/Prefab/CGDynamic_C09_02_F.prefab"
  },
  CGDynamic_C09_002_M = {
    ID = "CGDynamic_C09_002_M",
    CnID = "门内男学生睁眼中景拉镜头",
    BaseSortID = 527,
    Res = "CG/C09/Prefab/CGDynamic_C09_02_M.prefab"
  },
  CGDynamic_C09_003 = {
    ID = "CGDynamic_C09_003",
    CnID = "拉蒙娜的意识声音响起",
    BaseSortID = 528,
    Res = "CG/C09/Prefab/CGDynamic_C09_03.prefab"
  },
  CGDynamic_C09_004 = {
    ID = "CGDynamic_C09_004",
    CnID = "唤醒体们的意识声音响起",
    BaseSortID = 529,
    Res = "CG/C09/Prefab/CGDynamic_C09_04.prefab"
  },
  CGDynamic_C09_005 = {
    ID = "CGDynamic_C09_005",
    CnID = "守密人恢复神志",
    BaseSortID = 530,
    Res = "CG/C09/Prefab/CGDynamic_C09_05.prefab"
  },
  CGDynamic_C09_006 = {
    ID = "CGDynamic_C09_006",
    CnID = "门前的钥匙摇镜头",
    BaseSortID = 531,
    Res = "CG/C09/Prefab/CGDynamic_C09_06.prefab"
  },
  CGDynamic_C09_007 = {
    ID = "CGDynamic_C09_007",
    CnID = "拉蒙娜眼前泪水模糊",
    BaseSortID = 532,
    Res = "CG/C09/Prefab/CGDynamic_C09_07.prefab"
  },
  CGDynamic_C09_008 = {
    ID = "CGDynamic_C09_008",
    CnID = "萝坦回忆淡出",
    BaseSortID = 533,
    Res = "CG/C09/Prefab/CGDynamic_C09_08.prefab"
  },
  CGDynamic_C09_009 = {
    ID = "CGDynamic_C09_009",
    CnID = "奥吉尔回忆淡出",
    BaseSortID = 534,
    Res = "CG/C09/Prefab/CGDynamic_C09_09.prefab"
  },
  CGDynamic_C09_010 = {
    ID = "CGDynamic_C09_010",
    CnID = "艾继丝回忆淡出",
    BaseSortID = 535,
    Res = "CG/C09/Prefab/CGDynamic_C09_10.prefab"
  },
  CGDynamic_C09_011 = {
    ID = "CGDynamic_C09_011",
    CnID = "詹金回忆淡出",
    BaseSortID = 536,
    Res = "CG/C09/Prefab/CGDynamic_C09_11.prefab"
  },
  CGDynamic_C09_012 = {
    ID = "CGDynamic_C09_012",
    CnID = "莉莉回忆淡出",
    BaseSortID = 537,
    Res = "CG/C09/Prefab/CGDynamic_C09_12.prefab"
  },
  CGDynamic_C09_013 = {
    ID = "CGDynamic_C09_013",
    CnID = "墨菲回忆淡出",
    BaseSortID = 538,
    Res = "CG/C09/Prefab/CGDynamic_C09_13.prefab"
  },
  CGDynamic_C09_014 = {
    ID = "CGDynamic_C09_014",
    CnID = "泰旖丝回忆淡出",
    BaseSortID = 539,
    Res = "CG/C09/Prefab/CGDynamic_C09_14.prefab"
  },
  CGDynamic_C09_015 = {
    ID = "CGDynamic_C09_015",
    CnID = "拉蒙娜回忆淡出",
    BaseSortID = 540,
    Res = "CG/C09/Prefab/CGDynamic_C09_15.prefab"
  },
  CGDynamic_C09_016 = {
    ID = "CGDynamic_C09_016",
    CnID = "奥吉尔回忆静态",
    BaseSortID = 541,
    Res = "CG/C09/Prefab/CGDynamic_C09_16.prefab"
  },
  SScene_SchoolPanorama = {
    ID = "SScene_SchoolPanorama",
    CnID = "学院全景",
    BaseSortID = 542,
    Res = "Scenebg/SScene_SchoolPanorama.png"
  },
  SScene_CG_SD_S_C02EX_1 = {
    ID = "SScene_CG_SD_S_C02EX_1",
    CnID = "本源朵尔-矿洞学生",
    BaseSortID = 543,
    Res = "CG/CG_SD/Static/CG_SD_S_C02EX_1.png"
  },
  SScene_CG_SD_S_C02EX_7 = {
    ID = "SScene_CG_SD_S_C02EX_7",
    CnID = "本源朵尔-出场",
    BaseSortID = 544,
    Res = "CG/CG_SD/Static/CG_SD_S_C02EX_7.png"
  },
  SScene_CG_SD_S_C02EX_8 = {
    ID = "SScene_CG_SD_S_C02EX_8",
    CnID = "本源朵尔-正脸特写",
    BaseSortID = 545,
    Res = "CG/CG_SD/Static/CG_SD_S_C02EX_8.png"
  },
  SScene_CG_SD_S_C02EX_10 = {
    ID = "SScene_CG_SD_S_C02EX_10",
    CnID = "本源朵尔-本源朵尔被带走",
    BaseSortID = 546,
    Res = "CG/CG_SD/Static/CG_SD_S_C02EX_10.png"
  },
  CGDynamic_C02EX_001 = {
    ID = "CGDynamic_C02EX_001",
    CnID = "本源朵尔-守密人昏迷",
    BaseSortID = 547,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C02EX_1.prefab"
  },
  CGDynamic_C02EX_002 = {
    ID = "CGDynamic_C02EX_002",
    CnID = "本源朵尔-本源朵尔突然靠近",
    BaseSortID = 548,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C02EX_2.prefab"
  },
  CGDynamic_C02EX_003 = {
    ID = "CGDynamic_C02EX_003",
    CnID = "本源朵尔-近景摇镜头",
    BaseSortID = 549,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C02EX_3.prefab"
  },
  CGDynamic_C02EX_004 = {
    ID = "CGDynamic_C02EX_004",
    CnID = "本源朵尔-近景渐黑",
    BaseSortID = 550,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C02EX_4.prefab"
  },
  CGDynamic_C02EX_005 = {
    ID = "CGDynamic_C02EX_005",
    CnID = "本源朵尔-手中银芯发光",
    BaseSortID = 551,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C02EX_5.prefab"
  },
  CGDynamic_C02EX_006 = {
    ID = "CGDynamic_C02EX_006",
    CnID = "本源朵尔-嘴部特写",
    BaseSortID = 552,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C02EX_6.prefab"
  },
  CGDynamic_C02EX_007 = {
    ID = "CGDynamic_C02EX_007",
    CnID = "本源朵尔-正脸特写淡入",
    BaseSortID = 553,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C02EX_7.prefab"
  },
  CGDynamic_C02EX_008 = {
    ID = "CGDynamic_C02EX_008",
    CnID = "本源朵尔-本源朵尔被带走淡入",
    BaseSortID = 554,
    Res = "CG/CG_SD/Prefab/CGDynamic_SD_S_C02EX_8.prefab"
  },
  SScene_CG_SD_S_O01_1 = {
    ID = "SScene_CG_SD_S_O01_1",
    CnID = "图鲁-海怪袭来",
    BaseSortID = 555,
    Res = "CG/CG_SD/Static/CG_SD_S_O01_1.png"
  },
  SScene_CG_SD_S_O01_2 = {
    ID = "SScene_CG_SD_S_O01_2",
    CnID = "图鲁-海怪袭来王冠发光",
    BaseSortID = 556,
    Res = "CG/CG_SD/Static/CG_SD_S_O01_2.png"
  },
  SScene_CG_SD_S_O01_3 = {
    ID = "SScene_CG_SD_S_O01_3",
    CnID = "图鲁-图鲁特写",
    BaseSortID = 557,
    Res = "CG/CG_SD/Static/CG_SD_S_O01_3.png"
  },
  SScene_CG_SD_S_O01_4 = {
    ID = "SScene_CG_SD_S_O01_4",
    CnID = "石质阶梯-室外",
    BaseSortID = 558,
    Res = "CG/CG_SD/Static/CG_SD_S_O01_4.png"
  },
  SScene_CG_SD_S_O01_5 = {
    ID = "SScene_CG_SD_S_O01_5",
    CnID = "石质阶梯-室内",
    BaseSortID = 559,
    Res = "CG/CG_SD/Static/CG_SD_S_O01_5.png"
  },
  SScene_CG_C201_001 = {
    ID = "SScene_CG_C201_001",
    CnID = "星辰章一-脑缸",
    BaseSortID = 560,
    Res = "CG/C201/Static/CG_C201_001.png"
  },
  CGDynamic_C201_01 = {
    ID = "CGDynamic_C201_01",
    CnID = "星辰章一-黑色太阳黑屏渐入",
    BaseSortID = 561,
    Res = "CG/C201/Prefab/CGDynamic_C201_01.prefab"
  },
  CGDynamic_C201_02 = {
    ID = "CGDynamic_C201_02",
    CnID = "星辰章一-黑色太阳向上摇镜",
    BaseSortID = 562,
    Res = "CG/C201/Prefab/CGDynamic_C201_02.prefab"
  },
  SScene_CG_C201_003 = {
    ID = "SScene_CG_C201_003",
    CnID = "星辰章一-双朵尔对峙",
    BaseSortID = 563,
    Res = "CG/C201/Static/CG_C201_003.png"
  },
  SScene_CG_C201_004 = {
    ID = "SScene_CG_C201_004",
    CnID = "星辰章一-阅读论文",
    BaseSortID = 564,
    Res = "CG/C201/Static/CG_C201_004.png"
  },
  SScene_CG_C201_005 = {
    ID = "SScene_CG_C201_005",
    CnID = "星辰章一-阅读论文差分",
    BaseSortID = 565,
    Res = "CG/C201/Static/CG_C201_005.png"
  },
  SScene_DollLab = {
    ID = "SScene_DollLab",
    CnID = "朵尔实验室",
    BaseSortID = 566,
    Res = "Scenebg/SScene_DollLab.png"
  },
  SScene_CG_Coll_Entry_10 = {
    ID = "SScene_CG_Coll_Entry_10",
    CnID = "银钥匙",
    BaseSortID = 567,
    Res = "CG/CG_Coll/CG_Coll_Entry_10.png"
  },
  SScene_CG_Coll_Entry_08 = {
    ID = "SScene_CG_Coll_Entry_08",
    CnID = "银芯",
    BaseSortID = 568,
    Res = "CG/CG_Coll/CG_Coll_Entry_08.png"
  },
  SScene_NZHH_dreamarea = {
    ID = "SScene_NZHH_dreamarea",
    CnID = "逆转回合-意识空间",
    BaseSortID = 569,
    Res = "Scenebg/SScene_dreamarea_MyTurn.png"
  },
  SScene_NZHH_Main_CG = {
    ID = "SScene_NZHH_Main_CG",
    CnID = "逆转回合-对决",
    BaseSortID = 570,
    Res = "CG/CG_SD/Static/CG_SD_MyTurn_01.png"
  },
  SScene_Traphase_Room = {
    ID = "SScene_Traphase_Room",
    CnID = "相位对弈房间",
    BaseSortID = 571,
    Res = "Scenebg/SScene_Traphase_Room.png"
  },
  SScene_CG_C201_006 = {
    ID = "SScene_CG_C201_006",
    CnID = "星辰章一-对峙B68",
    BaseSortID = 572,
    Res = "CG/C201/Static/CG_C201_006.png"
  },
  SScene_CG_C201_007 = {
    ID = "SScene_CG_C201_007",
    CnID = "星辰章一-对峙本朵",
    BaseSortID = 573,
    Res = "CG/C201/Static/CG_C201_007.png"
  },
  SScene_CG_C201_008 = {
    ID = "SScene_CG_C201_008",
    CnID = "星辰章一-四人组不笑",
    BaseSortID = 574,
    Res = "CG/C201/Static/CG_C201_008.png"
  },
  SScene_CG_C201_009 = {
    ID = "SScene_CG_C201_009",
    CnID = "星辰章一-四人组笑",
    BaseSortID = 575,
    Res = "CG/C201/Static/CG_C201_009.png"
  },
  SScene_CG_C201_010 = {
    ID = "SScene_CG_C201_010",
    CnID = "星辰章一-黑色太阳静态",
    BaseSortID = 576,
    Res = "CG/C201/Static/CG_C201_010.png"
  },
  SScene_CG_C202_007 = {
    ID = "SScene_CG_C202_007",
    CnID = "克莱门汀PV观察",
    BaseSortID = 577,
    Res = "CG/C202/Static/CG_C202_007.png"
  },
  SScene_CG_C202_008 = {
    ID = "SScene_CG_C202_008",
    CnID = "克莱门汀PV观察复眼版",
    BaseSortID = 578,
    Res = "CG/C202/Static/CG_C202_008.png"
  },
  SScene_pendulum = {
    ID = "SScene_pendulum",
    CnID = "克莱门汀PV钟摆",
    BaseSortID = 579,
    Res = "Scenebg/SScene_pendulum.png"
  },
  SScene_CG_C202_006 = {
    ID = "SScene_CG_C202_006",
    CnID = "克莱门汀PV治疗患者",
    BaseSortID = 580,
    Res = "CG/C202/Static/CG_C202_006.png"
  },
  SScene_CG_C202_010 = {
    ID = "SScene_CG_C202_010",
    CnID = "克莱门汀PV虫族投影",
    BaseSortID = 581,
    Res = "CG/C202/Static/CG_C202_010.png"
  },
  SScene_CG_C202_001 = {
    ID = "SScene_CG_C202_001",
    CnID = "威廉诀别CG",
    BaseSortID = 582,
    Res = "CG/C202/Static/CG_C202_001.png"
  },
  SScene_CG_C202_002 = {
    ID = "SScene_CG_C202_002",
    CnID = "克莱门汀送礼-虫蛹",
    BaseSortID = 583,
    Res = "CG/C202/Static/CG_C202_002.png"
  },
  SScene_CG_C202_003 = {
    ID = "SScene_CG_C202_003",
    CnID = "克莱门汀送礼-银钥匙",
    BaseSortID = 584,
    Res = "CG/C202/Static/CG_C202_003.png"
  },
  SScene_CG_C202_004 = {
    ID = "SScene_CG_C202_004",
    CnID = "克莱门汀送礼-消散",
    BaseSortID = 585,
    Res = "CG/C202/Static/CG_C202_004.png"
  },
  SScene_ShaggaiNest = {
    ID = "SScene_ShaggaiNest",
    CnID = "虫族孵化室-正常",
    BaseSortID = 586,
    Res = "Scenebg/SScene_ShaggaiNest.png"
  },
  SScene_ShaggaiNestPupae = {
    ID = "SScene_ShaggaiNestPupae",
    CnID = "虫族孵化室-人蛹",
    BaseSortID = 587,
    Res = "Scenebg/SScene_ShaggaiNestPupae.png"
  },
  SScene_Butterfly = {
    ID = "SScene_Butterfly",
    CnID = "意识光蝶",
    BaseSortID = 588,
    Res = "Scenebg/SScene_Butterfly.png"
  },
  SScene_ButterflyHand = {
    ID = "SScene_ButterflyHand",
    CnID = "意识光蝶-手掌",
    BaseSortID = 589,
    Res = "Scenebg/SScene_ButterflyHand.png"
  },
  SScene_ShaggaiTemple = {
    ID = "SScene_ShaggaiTemple",
    CnID = "阿撒托斯神殿",
    BaseSortID = 590,
    Res = "Scenebg/SScene_ShaggaiTemple.png"
  },
  SScene_CG_C202_005 = {
    ID = "SScene_CG_C202_005",
    CnID = "银芯克莱门汀死亡CG",
    BaseSortID = 591,
    Res = "CG/C202/Static/CG_C202_005.png"
  },
  SScene_CG_C202_009 = {
    ID = "SScene_CG_C202_009",
    CnID = "克莱门汀门后分身",
    BaseSortID = 592,
    Res = "CG/C202/Static/CG_C202_009.png"
  },
  CGDynamic_C202_01 = {
    ID = "CGDynamic_C202_01",
    CnID = "克莱门汀剧情-虫族光蝶场景叠图过度",
    BaseSortID = 593,
    Res = "CG/C202/Prefab/CGDynamic_C202_01.prefab"
  },
  CGDynamic_C202_03 = {
    ID = "CGDynamic_C202_03",
    CnID = "克莱门汀剧情-意识光蝶-手掌叠图过度",
    BaseSortID = 594,
    Res = "CG/C202/Prefab/CGDynamic_C202_03.prefab"
  },
  CGDynamic_C202_04 = {
    ID = "CGDynamic_C202_04",
    CnID = "克莱门汀剧情-拉蒙娜黑影消失",
    BaseSortID = 595,
    Res = "CG/C202/Prefab/CGDynamic_C202_04.prefab"
  },
  CGDynamic_C202_05 = {
    ID = "CGDynamic_C202_05",
    CnID = "克莱门汀剧情-怪物艾伦叠图过度",
    BaseSortID = 596,
    Res = "CG/C202/Prefab/CGDynamic_C202_05.prefab"
  },
  CGDynamic_C202_07 = {
    ID = "CGDynamic_C202_07",
    CnID = "克莱门汀剧情-泪滴场景缓慢出现",
    BaseSortID = 597,
    Res = "CG/C202/Prefab/CGDynamic_C202_07.prefab"
  },
  SScene_SanatoriumAisle2 = {
    ID = "SScene_SanatoriumAisle2",
    CnID = "疗养院变色",
    BaseSortID = 598,
    Res = "Scenebg/SScene_SanatoriumAisle2.png"
  },
  SScene_DesertInnDay = {
    ID = "SScene_DesertInnDay",
    CnID = "沙漠旅馆-日",
    BaseSortID = 599,
    Res = "Scenebg/SScene_DesertInnDay.png"
  },
  SScene_DesertInnNight = {
    ID = "SScene_DesertInnNight",
    CnID = "沙漠旅馆-夜",
    BaseSortID = 600,
    Res = "Scenebg/SScene_DesertInnNight.png"
  },
  SScene_DesertInnRedMoon = {
    ID = "SScene_DesertInnRedMoon",
    CnID = "沙漠旅馆-血月",
    BaseSortID = 601,
    Res = "Scenebg/SScene_DesertInnRedMoon.png"
  },
  SScene_BloodDesertInn = {
    ID = "SScene_BloodDesertInn",
    CnID = "沙漠旅馆-血月特写",
    BaseSortID = 602,
    Res = "Scenebg/SScene_BloodDesertInn.png"
  },
  SScene_LightBearerTemple = {
    ID = "SScene_LightBearerTemple",
    CnID = "提灯神殿",
    BaseSortID = 603,
    Res = "Scenebg/SScene_LightBearerTemple.png"
  },
  Scene_O08_AF_1 = {
    ID = "Scene_O08_AF_1",
    CnID = "暗淡水面",
    BaseSortID = 604,
    Res = "Scenebg/Scene_O08_AF_1.png"
  },
  SScene_CG_SD_L_O10_1 = {
    ID = "SScene_CG_SD_L_O10_1",
    CnID = "克珀珊特CG1",
    BaseSortID = 605,
    Res = "CG/CG_SD/Static/CG_SD_L_O10_1.png"
  },
  SScene_CG_SD_L_O10_2 = {
    ID = "SScene_CG_SD_L_O10_2",
    CnID = "克珀珊特CG2",
    BaseSortID = 606,
    Res = "CG/CG_SD/Static/CG_SD_L_O10_2.png"
  },
  SScene_CG_SD_L_O10_3 = {
    ID = "SScene_CG_SD_L_O10_3",
    CnID = "克珀珊特CG3",
    BaseSortID = 607,
    Res = "CG/CG_SD/Static/CG_SD_L_O10_3.png"
  },
  SScene_CG_C202_014 = {
    ID = "SScene_CG_C202_014",
    CnID = "虫蛹近景",
    BaseSortID = 608,
    Res = "CG/C202/Static/CG_C202_014.png"
  },
  SScene_CG_C202_015 = {
    ID = "SScene_CG_C202_015",
    CnID = "银钥匙近景",
    BaseSortID = 609,
    Res = "CG/C202/Static/CG_C202_015.png"
  },
  SScene_CG_C202_011 = {
    ID = "SScene_CG_C202_011",
    CnID = "克莱门汀死亡CG1",
    BaseSortID = 610,
    Res = "CG/C202/Static/CG_C202_011.png"
  },
  SScene_CG_C202_012 = {
    ID = "SScene_CG_C202_012",
    CnID = "克莱门汀死亡CG2",
    BaseSortID = 611,
    Res = "CG/C202/Static/CG_C202_012.png"
  },
  SScene_CG_C202_013 = {
    ID = "SScene_CG_C202_013",
    CnID = "克莱门汀死亡CG3",
    BaseSortID = 612,
    Res = "CG/C202/Static/CG_C202_013.png"
  },
  SScene_ShaggaiNest2 = {
    ID = "SScene_ShaggaiNest2",
    CnID = "虫族孵化室-正常2",
    BaseSortID = 613,
    Res = "Scenebg/SScene_ShaggaiNest2.png"
  },
  SScene_CastlePanorama = {
    ID = "SScene_CastlePanorama",
    CnID = "古堡全景",
    BaseSortID = 614,
    Res = "Scenebg/SScene_CastlePanorama.png"
  },
  SScene_CastleCorridor = {
    ID = "SScene_CastleCorridor",
    CnID = "古堡走廊",
    BaseSortID = 615,
    Res = "Scenebg/SScene_CastleCorridor.png"
  },
  SScene_CG_C203_001 = {
    ID = "SScene_CG_C203_001",
    CnID = "杜勒赛因跳舞",
    BaseSortID = 616,
    Res = "CG/C203/Static/CG_C203_001.png"
  },
  SScene_CG_C203_002 = {
    ID = "SScene_CG_C203_002",
    CnID = "杜勒赛因与小女孩",
    BaseSortID = 617,
    Res = "CG/C203/Static/CG_C203_002.png"
  },
  SScene_CG_C203_003 = {
    ID = "SScene_CG_C203_003",
    CnID = "杜勒赛因战斗前",
    BaseSortID = 618,
    Res = "CG/C203/Static/CG_C203_003.png"
  },
  SScene_CG_C203_004 = {
    ID = "SScene_CG_C203_004",
    CnID = "杜勒赛因重伤",
    BaseSortID = 619,
    Res = "CG/C203/Static/CG_C203_004.png"
  },
  SScene_CastleKitchen = {
    ID = "SScene_CastleKitchen",
    CnID = "古堡厨房",
    BaseSortID = 620,
    Res = "Scenebg/SScene_CastleKitchen.png"
  },
  SScene_DesertTownNight = {
    ID = "SScene_DesertTownNight",
    CnID = "亚兰聚居地_夜",
    BaseSortID = 621,
    Res = "Scenebg/SScene_DesertTownNight.png"
  },
  SScene_CG_SD_L_D11_1 = {
    ID = "SScene_CG_SD_L_D11_1",
    CnID = "卡斯托尔背刺CG",
    BaseSortID = 622,
    Res = "CG/CG_SD/Static/CG_SD_L_D11_1.png"
  },
  SScene_SchoolKitchen = {
    ID = "SScene_SchoolKitchen",
    CnID = "弥萨格厨房",
    BaseSortID = 623,
    Res = "Scenebg/SScene_SchoolKitchen.png"
  },
  SScene_CG_C203_005 = {
    ID = "SScene_CG_C203_005",
    CnID = "杜勒赛因用餐1",
    BaseSortID = 624,
    Res = "CG/C203/Static/CG_C203_005.png"
  },
  SScene_CG_C203_006 = {
    ID = "SScene_CG_C203_006",
    CnID = "杜勒赛因用餐2",
    BaseSortID = 625,
    Res = "CG/C203/Static/CG_C203_006.png"
  },
  SScene_CG_C203_007 = {
    ID = "SScene_CG_C203_007",
    CnID = "杜勒赛因用餐3",
    BaseSortID = 626,
    Res = "CG/C203/Static/CG_C203_007.png"
  },
  SScene_CG_C203_008 = {
    ID = "SScene_CG_C203_008",
    CnID = "杜勒赛因跳舞特写",
    BaseSortID = 627,
    Res = "CG/C203/Static/CG_C203_008.png"
  },
  SScene_CG_C203_009 = {
    ID = "SScene_CG_C203_009",
    CnID = "人肉分解",
    BaseSortID = 628,
    Res = "CG/C203/Static/CG_C203_009.png"
  },
  SScene_GhoulCity = {
    ID = "SScene_GhoulCity",
    CnID = "食尸鬼王城",
    BaseSortID = 629,
    Res = "Scenebg/SScene_GhoulCity.png"
  },
  SScene_FullMoon = {
    ID = "SScene_FullMoon",
    CnID = "满月",
    BaseSortID = 630,
    Res = "Scenebg/SScene_FullMoon.png"
  },
  CGDynamic_C203_01 = {
    ID = "CGDynamic_C203_01",
    CnID = "杜勒赛因亲吻手臂近景-中景叠图过渡",
    BaseSortID = 631,
    Res = "CG/C203/Prefab/CGDynamic_C203_01.prefab"
  },
  CGDynamic_C203_02 = {
    ID = "CGDynamic_C203_02",
    CnID = "杜勒赛因跳舞中景-远景叠图过渡",
    BaseSortID = 632,
    Res = "CG/C203/Prefab/CGDynamic_C203_02.prefab"
  },
  SScene_CG_C203_010 = {
    ID = "SScene_CG_C203_010",
    CnID = "杜勒赛因闭眼特写",
    BaseSortID = 633,
    Res = "CG/C203/Static/CG_C203_010.png"
  },
  SScene_SandyBeachVolleyball = {
    ID = "SScene_SandyBeachVolleyball",
    CnID = "夏活沙滩_排球",
    BaseSortID = 634,
    Res = "Scenebg/SScene_SandyBeachVolleyball.png"
  },
  SScene_SandyBeach = {
    ID = "SScene_SandyBeach",
    CnID = "夏活沙滩_日",
    BaseSortID = 635,
    Res = "Scenebg/SScene_SandyBeach.png"
  },
  SScene_SandyBeachNight = {
    ID = "SScene_SandyBeachNight",
    CnID = "夏活沙滩_夜",
    BaseSortID = 636,
    Res = "Scenebg/SScene_SandyBeachNight.png"
  },
  CG_SD_S_C16_1 = {
    ID = "CG_SD_S_C16_1",
    CnID = "N的大脸",
    BaseSortID = 637,
    Res = "CG/CG_SD/Static/CG_SD_S_C16_1.png"
  },
  CG_SD_S_C16_2 = {
    ID = "CG_SD_S_C16_2",
    CnID = "凯蒂古拉开枪",
    BaseSortID = 638,
    Res = "CG/CG_SD/Static/CG_SD_S_C16_2.png"
  },
  SScene_FireAltars = {
    ID = "SScene_FireAltars",
    CnID = "燃烧的神殿",
    BaseSortID = 639,
    Res = "Scenebg/SScene_FireAltars.png"
  },
  CG_SD_S_B12_1 = {
    ID = "CG_SD_S_B12_1",
    CnID = "皮克曼的世界",
    BaseSortID = 640,
    Res = "CG/CG_SD/Static/CG_SD_S_B12_1.png"
  },
  CG_SD_L_FarewellNeverland_1 = {
    ID = "CG_SD_L_FarewellNeverland_1",
    CnID = "夏活上大合照",
    BaseSortID = 641,
    Res = "CG/CG_SD/Static/CG_SD_L_FarewellNeverland_1.png"
  },
  CG_SD_L_FarewellNeverland_2 = {
    ID = "CG_SD_L_FarewellNeverland_2",
    CnID = "夏活上大合照照片版",
    BaseSortID = 642,
    Res = "CG/CG_SD/Static/CG_SD_L_FarewellNeverland_2.png"
  },
  CG_SD_L_FarewellNeverland_3 = {
    ID = "CG_SD_L_FarewellNeverland_3",
    CnID = "夏活上大合照拉蒙娜照片版",
    BaseSortID = 643,
    Res = "CG/CG_SD/Static/CG_SD_L_FarewellNeverland_3.png"
  },
  SScene_Pik_PoetryGarden = {
    ID = "SScene_Pik_PoetryGarden",
    CnID = "皮克曼_画中世界_花园1",
    BaseSortID = 644,
    Res = "Scenebg/SScene_Pik_PoetryGarden.png"
  },
  SScene_PoetryGarden2 = {
    ID = "SScene_PoetryGarden2",
    CnID = "皮克曼_画中世界_花园2",
    BaseSortID = 645,
    Res = "Scenebg/SScene_PoetryGarden2.png"
  },
  SScene_PoetryGarden3 = {
    ID = "SScene_PoetryGarden3",
    CnID = "皮克曼_画中世界_花园街道1",
    BaseSortID = 646,
    Res = "Scenebg/SScene_PoetryGarden3.png"
  },
  SScene_PoetryGarden4 = {
    ID = "SScene_PoetryGarden4",
    CnID = "皮克曼_画中世界_花园街道2",
    BaseSortID = 647,
    Res = "Scenebg/SScene_PoetryGarden4.png"
  },
  SScene_Pik_PoetryManor = {
    ID = "SScene_Pik_PoetryManor",
    CnID = "皮克曼_画中世界_庄园1",
    BaseSortID = 648,
    Res = "Scenebg/SScene_Pik_PoetryManor.png"
  },
  SScene_PoetryManor2 = {
    ID = "SScene_PoetryManor2",
    CnID = "皮克曼_画中世界_庄园2",
    BaseSortID = 649,
    Res = "Scenebg/SScene_PoetryManor2.png"
  },
  SScene_SchoolGraveyard1 = {
    ID = "SScene_SchoolGraveyard1",
    CnID = "通用墓地无融蚀",
    BaseSortID = 650,
    Res = "Scenebg/SScene_SchoolGraveyard1.png"
  },
  SScene_HTPCharacter = {
    ID = "SScene_HTPCharacter",
    CnID = "房树人守密人",
    BaseSortID = 651,
    Res = "Scenebg/SScene_HTPCharacter.png"
  },
  SScene_HTPErica = {
    ID = "SScene_HTPErica",
    CnID = "房树人艾瑞卡",
    BaseSortID = 652,
    Res = "Scenebg/SScene_HTPErica.png"
  },
  SScene_HTPEricaExplosion = {
    ID = "SScene_HTPEricaExplosion",
    CnID = "房树人艾瑞卡爆炸",
    BaseSortID = 653,
    Res = "Scenebg/SScene_HTPEricaExplosion.png"
  },
  SScene_HTPHorla = {
    ID = "SScene_HTPHorla",
    CnID = "房树人奥尔拉",
    BaseSortID = 654,
    Res = "Scenebg/SScene_HTPHorla.png"
  },
  SScene_HTPHorlaWither = {
    ID = "SScene_HTPHorlaWither",
    CnID = "房树人奥尔拉枯萎",
    BaseSortID = 655,
    Res = "Scenebg/SScene_HTPHorlaWither.png"
  },
  SScene_HTPHorlaFire = {
    ID = "SScene_HTPHorlaFire",
    CnID = "房树人奥尔拉燃烧",
    BaseSortID = 656,
    Res = "Scenebg/SScene_HTPHorlaFire.png"
  },
  SScene_HTPLily = {
    ID = "SScene_HTPLily",
    CnID = "房树人莉莉",
    BaseSortID = 657,
    Res = "Scenebg/SScene_HTPLily.png"
  },
  SScene_HTPLilyDoor = {
    ID = "SScene_HTPLilyDoor",
    CnID = "房树人莉莉门",
    BaseSortID = 658,
    Res = "Scenebg/SScene_HTPLilyDoor.png"
  },
  SScene_HTPErica1 = {
    ID = "SScene_HTPErica1",
    CnID = "房树人艾瑞卡无人",
    BaseSortID = 659,
    Res = "Scenebg/SScene_HTPErica1.png"
  },
  CG_SD_S_D14_1 = {
    ID = "CG_SD_S_D14_1",
    CnID = "波吕克斯展翅",
    BaseSortID = 660,
    Res = "CG/CG_SD/Static/CG_SD_L_D14_1.png"
  },
  SScene_Living_room_Murphy = {
    ID = "SScene_Living_room_Murphy",
    CnID = "墨菲起居室",
    BaseSortID = 661,
    Res = "Scenebg/SScene_HotelRoomO2EX.png"
  },
  SScene_Storm_sea = {
    ID = "SScene_Storm_sea",
    CnID = "海上风暴",
    BaseSortID = 662,
    Res = "Scenebg/SScene_SeasideNight.png"
  },
  SScene_Sky_sea = {
    ID = "SScene_Sky_sea",
    CnID = "海国天空",
    BaseSortID = 663,
    Res = "Scenebg/SScene_SeasideDay.png"
  },
  SScene_Apt_Corridor = {
    ID = "SScene_Apt_Corridor",
    CnID = "阿帕忒走廊",
    BaseSortID = 664,
    Res = "Scenebg/SScene_CabinCorridor.png"
  },
  SScene_Apt_CorridorNight = {
    ID = "SScene_Apt_CorridorNight",
    CnID = "阿帕忒走廊_夜",
    BaseSortID = 665,
    Res = "Scenebg/SScene_CabinCorridor_N.png"
  },
  SScene_Apt_EngineRoom = {
    ID = "SScene_Apt_EngineRoom",
    CnID = "阿帕忒动力室",
    BaseSortID = 666,
    Res = "Scenebg/SScene_EngineRoom.png"
  },
  SScene_Apt_Deck = {
    ID = "SScene_Apt_Deck",
    CnID = "阿帕忒甲板",
    BaseSortID = 667,
    Res = "Scenebg/SScene_DeckNight.png"
  },
  SScene_Apt_Bottom_layer = {
    ID = "SScene_Apt_Bottom_layer",
    CnID = "阿帕忒底层船舱",
    BaseSortID = 668,
    Res = "Scenebg/SScene_ShipCornerLogo.png"
  },
  SScene_CG_C204_001 = {
    ID = "SScene_CG_C204_001",
    CnID = "诞妄墨菲CG1",
    BaseSortID = 669,
    Res = "CG/C204/Static/CG_C204_001.png"
  },
  SScene_Apt_Captainroom = {
    ID = "SScene_Apt_Captainroom",
    CnID = "阿帕忒船长室",
    BaseSortID = 670,
    Res = "Scenebg/SScene_Pilothouse.png"
  },
  Sscene_C01_Light = {
    ID = "Sscene_C01_Light",
    CnID = "拉蒙娜光点背景",
    BaseSortID = 671
  },
  Sscene_Bigwhirlpool = {
    ID = "Sscene_Bigwhirlpool",
    CnID = "巨大漩涡",
    BaseSortID = 672,
    Res = "Scenebg/SScene_Blacksun.png"
  },
  Sscene_EmbraceC01 = {
    ID = "Sscene_EmbraceC01",
    CnID = "拥抱拉蒙娜",
    BaseSortID = 673,
    Res = "CG/CG_SD/Static/CG_SD_S_WB2_1.png"
  },
  Sscene_HoldhandsC01 = {
    ID = "Sscene_HoldhandsC01",
    CnID = "牵手拉蒙娜",
    BaseSortID = 674,
    Res = "Scenebg/SScene_Corridor.png"
  },
  Sscene_C01push = {
    ID = "Sscene_C01push",
    CnID = "拉蒙娜推开",
    BaseSortID = 675,
    Res = "CG/CG_SD/Static/CG_SD_S_WB2_2.png"
  },
  Sscene_C01push_2 = {
    ID = "Sscene_C01push_2",
    CnID = "拉蒙娜推开_2",
    BaseSortID = 676,
    Res = "CG/CG_SD/Static/CG_SD_S_WB2_2_2.png"
  },
  Sscene_EmbraceC01_2 = {
    ID = "Sscene_EmbraceC01_2",
    CnID = "拥抱拉蒙娜_2",
    BaseSortID = 677,
    Res = "CG/CG_SD/Static/CG_SD_S_WB2_1_2.png"
  },
  SScene_Apt_Bottom = {
    ID = "SScene_Apt_Bottom",
    CnID = "阿帕忒船舱",
    BaseSortID = 678,
    Res = "Scenebg/SScene_ShipCornerLogo.png"
  },
  SScene_CG_C204_003 = {
    ID = "SScene_CG_C204_003",
    CnID = "群星正位之刻CG",
    BaseSortID = 679,
    Res = "CG/C204/Static/CG_C204_003.png"
  },
  SScene_CG_C204_002 = {
    ID = "SScene_CG_C204_002",
    CnID = "诞妄墨菲诞生CG",
    BaseSortID = 680,
    Res = "CG/C204/Static/CG_C204_004.png"
  },
  SScene_CG_C204_004 = {
    ID = "SScene_CG_C204_004",
    CnID = "诞妄墨菲BOSS战",
    BaseSortID = 681
  },
  SScene_CG_C204_005 = {
    ID = "SScene_CG_C204_005",
    CnID = "诞妄墨菲BOSS入场",
    BaseSortID = 682
  },
  SScene_CG_C204_006 = {
    ID = "SScene_CG_C204_006",
    CnID = "弥利亚姆亲吻墨菲",
    BaseSortID = 683,
    Res = "CG/C204/Static/CG_C204_002.png"
  },
  SScene_Dock_new = {
    ID = "SScene_Dock_new",
    CnID = "星辰码头",
    BaseSortID = 684,
    Res = "Scenebg/SScene_Dock.png"
  },
  SScene_Apt_Jump = {
    ID = "SScene_Apt_Jump",
    CnID = "阿帕忒跳船",
    BaseSortID = 685
  },
  SScene_Blacksun = {
    ID = "SScene_Blacksun",
    CnID = "黑日内部",
    BaseSortID = 686,
    Res = "Scenebg/SScene_Blacksun.png"
  },
  SScene_PV1_2_CG1 = {
    ID = "SScene_PV1_2_CG1",
    CnID = "墨菲逃跑CG",
    BaseSortID = 687,
    Res = "CG/C204/Static/CG_C204_005.png"
  },
  SScene_PV1_2_CG2 = {
    ID = "SScene_PV1_2_CG2",
    CnID = "墨菲逃跑_跑动中CG",
    BaseSortID = 688,
    Res = "CG/C204/Static/CG_C204_008.png"
  },
  SScene_CG_C204_007 = {
    ID = "SScene_CG_C204_007",
    CnID = "守密人背影",
    BaseSortID = 689,
    Res = "CG/C204/Static/CG_C204_007.png"
  },
  SScene_CG_C204_009 = {
    ID = "SScene_CG_C204_009",
    CnID = "墨菲初见CG",
    BaseSortID = 690,
    Res = "CG/C204/Static/CG_C204_009.png"
  },
  SScene_CG_C204_010 = {
    ID = "SScene_CG_C204_010",
    CnID = "墨菲受伤CG",
    BaseSortID = 691,
    Res = "CG/C204/Static/CG_C204_010.png"
  },
  SScene_CG_C204_011 = {
    ID = "SScene_CG_C204_011",
    CnID = "墨菲枷锁CG-说话",
    BaseSortID = 692,
    Res = "CG/C204/Static/CG_C204_011.png"
  },
  SScene_CG_C204_012 = {
    ID = "SScene_CG_C204_012",
    CnID = "墨菲枷锁CG-微笑",
    BaseSortID = 693,
    Res = "CG/C204/Static/CG_C204_012.png"
  },
  SScene_BlackYarnship = {
    ID = "SScene_BlackYarnship",
    CnID = "甲板船头-黑纱",
    BaseSortID = 694,
    Res = "Scenebg/SScene_BlackYarnship.png"
  },
  SScene_CG_C204_013 = {
    ID = "SScene_CG_C204_013",
    CnID = "守密人背影_女",
    BaseSortID = 695,
    Res = "CG/C204/Static/CG_C204_006.png"
  },
  SScene_DeepSeaThrone = {
    ID = "SScene_DeepSeaThrone",
    CnID = "青石王座",
    BaseSortID = 696,
    Res = "Scenebg/SScene_DeepSeaThrone.png"
  },
  SScene_CG_C204_014 = {
    ID = "SScene_CG_C204_014",
    CnID = "墨菲分娩",
    BaseSortID = 697,
    Res = "CG/C204/Static/CG_C204_013.png"
  },
  CG_SD_S_C17_01 = {
    ID = "CG_SD_S_C17_01",
    CnID = "茉夏受洗",
    BaseSortID = 698,
    Res = "CG/CG_SD/Static/CG_SD_S_C17_01.png"
  },
  CG_SD_S_C17_02 = {
    ID = "CG_SD_S_C17_02",
    CnID = "茉夏受洗_无人1",
    BaseSortID = 699,
    Res = "CG/CG_SD/Static/CG_SD_S_C17_02.png"
  },
  CG_SD_S_C17_02_2 = {
    ID = "CG_SD_S_C17_02_2",
    CnID = "茉夏受洗_无人2",
    BaseSortID = 700,
    Res = "CG/CG_SD/Static/CG_SD_S_C17_02_2.png"
  },
  CG_SD_S_C17_01_2 = {
    ID = "CG_SD_S_C17_01_2",
    CnID = "茉夏受洗_疯狂",
    BaseSortID = 701,
    Res = "CG/CG_SD/Static/CG_SD_S_C17_01_2.png"
  },
  CG_SD_S_C17_01_3 = {
    ID = "CG_SD_S_C17_01_3",
    CnID = "茉夏受洗_正常",
    BaseSortID = 702,
    Res = "CG/CG_SD/Static/CG_SD_S_C17_01_3.png"
  },
  SScene_Consciousness_Star = {
    ID = "SScene_Consciousness_Star",
    CnID = "心象空间_星空",
    BaseSortID = 703,
    Res = "Scenebg/SScene_Consciousness_Star.png"
  },
  SScene_HefangRoomInNIght = {
    ID = "SScene_HefangRoomInNIght",
    CnID = "何家大宅内夜",
    BaseSortID = 704,
    Res = "Scenebg/SScene_ChineseHouseInNight.png"
  },
  SScene_HefangRoomOutNIght = {
    ID = "SScene_HefangRoomOutNIght",
    CnID = "何家大宅外夜",
    BaseSortID = 705,
    Res = "Scenebg/SScene_ChineseHouseOutNight.png"
  },
  SScene_HefangRoomNoon = {
    ID = "SScene_HefangRoomNoon",
    CnID = "何家大宅内日",
    BaseSortID = 706,
    Res = "Scenebg/SScene_ChineseHouseInDay.png"
  },
  SScene_HefangRoomOutNoon = {
    ID = "SScene_HefangRoomOutNoon",
    CnID = "何家大宅外日",
    BaseSortID = 707,
    Res = "Scenebg/SScene_ChineseHouseOutDay.png"
  },
  CG_SD_S_B14_1 = {
    ID = "CG_SD_S_B14_1",
    CnID = "千扇CG原版",
    BaseSortID = 708,
    Res = "CG/CG_SD/Static/CG_SD_S_B14_1.png"
  },
  CG_SD_S_B14_3 = {
    ID = "CG_SD_S_B14_3",
    CnID = "千扇CG差分",
    BaseSortID = 709,
    Res = "CG/CG_SD/Static/CG_SD_S_B14_3.png"
  },
  CG_SD_L_SF1_01 = {
    ID = "CG_SD_L_SF1_01",
    CnID = "千扇眼睛特写",
    BaseSortID = 710,
    Res = "CG/CG_SD/Static/CG_SD_L_SF1_01.png"
  },
  CG_SD_S_B14_2 = {
    ID = "CG_SD_S_B14_2",
    CnID = "千扇合扇遮面",
    BaseSortID = 711,
    Res = "CG/CG_SD/Static/CG_SD_S_B14_2.png"
  },
  CG_SD_S_B14_4 = {
    ID = "CG_SD_S_B14_4",
    CnID = "千扇开扇遮面",
    BaseSortID = 712,
    Res = "CG/CG_SD/Static/CG_SD_S_B14_4.png"
  },
  CG_SD_L_SF1_02 = {
    ID = "CG_SD_L_SF1_02",
    CnID = "烟花升空",
    BaseSortID = 713,
    Res = "CG/CG_SD/Static/CG_SD_L_SF1_02.png"
  },
  CG_SD_L_SF1_03 = {
    ID = "CG_SD_L_SF1_03",
    CnID = "烟花漫天",
    BaseSortID = 714,
    Res = "CG/CG_SD/Static/CG_SD_L_SF1_03.png"
  },
  CG_SD_S_O11_01 = {
    ID = "CG_SD_S_O11_01",
    CnID = "莫丝日常CG",
    BaseSortID = 715,
    Res = "CG/CG_SD/Static/CG_SD_S_O11_01.png"
  },
  CG_SD_S_O11_02 = {
    ID = "CG_SD_S_O11_02",
    CnID = "莫丝沉溺CG",
    BaseSortID = 716,
    Res = "CG/CG_SD/Static/CG_SD_S_O11_02.png"
  },
  SScene_OperahouseFate1 = {
    ID = "SScene_OperahouseFate1",
    CnID = "命运歌剧院",
    BaseSortID = 717,
    Res = "Scenebg/SScene_OperahouseFate1.png"
  },
  SScene_Tavern = {
    ID = "SScene_Tavern",
    CnID = "城市酒吧",
    BaseSortID = 718,
    Res = "Scenebg/SScene_Tavern.png"
  },
  SScene_OperahouseFate2 = {
    ID = "SScene_OperahouseFate2",
    CnID = "命运歌剧院2",
    BaseSortID = 719,
    Res = "Scenebg/SScene_OperahouseFate2.png"
  },
  CG_SD_S_D01_1 = {
    ID = "CG_SD_S_D01_1",
    CnID = "莉兹精二CG",
    BaseSortID = 720,
    Res = "CG/CG_SD/Static/CG_SD_S_D01_1.png"
  },
  SScene_Oppression = {
    ID = "SScene_Oppression",
    CnID = "融蚀_压力",
    BaseSortID = 721,
    Res = "Scenebg/SScene_Oppression.png"
  },
  SScene_ChapterMultiverse = {
    ID = "SScene_ChapterMultiverse",
    CnID = "虚空",
    BaseSortID = 722,
    Res = "Scenebg/SScene_ChapterMultiverse.png"
  },
  CG_C205_001 = {
    ID = "CG_C205_001",
    CnID = "阿拉克涅织网",
    BaseSortID = 723,
    Res = "CG/C205/Static/CG_C205_001.png"
  },
  CG_C205_002 = {
    ID = "CG_C205_002",
    CnID = "阿拉克涅织网2",
    BaseSortID = 724,
    Res = "CG/C205/Static/CG_C205_002.png"
  },
  CG_C205_003 = {
    ID = "CG_C205_003",
    CnID = "黑天鹅之死",
    BaseSortID = 725,
    Res = "CG/C205/Static/CG_C205_003.png"
  },
  CG_C205_004 = {
    ID = "CG_C205_004",
    CnID = "主角的表演",
    BaseSortID = 726,
    Res = "CG/C205/Static/CG_C205_004.png"
  },
  CG_C205_005 = {
    ID = "CG_C205_005",
    CnID = "送别黑涅",
    BaseSortID = 727,
    Res = "CG/C205/Static/CG_C205_005.png"
  },
  CG_C205_006 = {
    ID = "CG_C205_006",
    CnID = "送别黑涅_PV",
    BaseSortID = 728,
    Res = "CG/C205/Static/CG_C205_006.png"
  },
  CG_C205_007 = {
    ID = "CG_C205_007",
    CnID = "爬满的蜘蛛",
    BaseSortID = 729,
    Res = "CG/C205/Static/CG_C205_007.png"
  },
  CG_C205_008 = {
    ID = "CG_C205_008",
    CnID = "送别黑涅_无眼泪",
    BaseSortID = 730,
    Res = "CG/C205/Static/CG_C205_008.png"
  },
  CG_C205_009 = {
    ID = "CG_C205_009",
    CnID = "阿拉克涅与城市",
    BaseSortID = 731,
    Res = "CG/C205/Static/CG_C205_009.png"
  },
  CG_C205_010 = {
    ID = "CG_C205_010",
    CnID = "主角的表演_男",
    BaseSortID = 732,
    Res = "CG/C205/Static/CG_C205_010.png"
  },
  CG_C205_011 = {
    ID = "CG_C205_011",
    CnID = "主角的表演_女闭眼",
    BaseSortID = 733,
    Res = "CG/C205/Static/CG_C205_011.png"
  },
  CG_C205_012 = {
    ID = "CG_C205_012",
    CnID = "主角的表演_男闭眼",
    BaseSortID = 734,
    Res = "CG/C205/Static/CG_C205_012.png"
  },
  CG_C205_013 = {
    ID = "CG_C205_013",
    CnID = "织网的手",
    BaseSortID = 735,
    Res = "CG/C205/Static/CG_C205_013.png"
  },
  CG_C205_014 = {
    ID = "CG_C205_014",
    CnID = "命运纺轮",
    BaseSortID = 736,
    Res = "CG/C205/Static/CG_C205_014.png"
  },
  CG_C205_015 = {
    ID = "CG_C205_015",
    CnID = "黑涅操控阿拉克涅",
    BaseSortID = 737,
    Res = "CG/C205/Static/CG_C205_015.png"
  },
  CG_C205_016 = {
    ID = "CG_C205_016",
    CnID = "命运丝线毁灭",
    BaseSortID = 738,
    Res = "CG/C205/Static/CG_C205_016.png"
  },
  CG_C205_017 = {
    ID = "CG_C205_017",
    CnID = "创造的城市",
    BaseSortID = 739,
    Res = "CG/C205/Static/CG_C205_017.png"
  },
  SScene_LondonArachne = {
    ID = "SScene_LondonArachne",
    CnID = "伦敦阿拉克涅操纵",
    BaseSortID = 740,
    Res = "Scenebg/SScene_LondonArachne.png"
  },
  CG_SD_S_Fool = {
    ID = "CG_SD_S_Fool",
    CnID = "愚人节",
    BaseSortID = 741,
    Res = "CG/CG_SD/Static/CG_SD_S_Fool.png"
  },
  SScene_Dandelion = {
    ID = "SScene_Dandelion",
    CnID = "蒲公英花田",
    BaseSortID = 742,
    Res = "Scenebg/SScene_Dandelion.png"
  },
  SScene_BadDandelion = {
    ID = "SScene_BadDandelion",
    CnID = "融蚀蒲公英花田",
    BaseSortID = 743,
    Res = "Scenebg/SScene_BadDandelion.png"
  },
  CG_SD_S_B15_01 = {
    ID = "CG_SD_S_B15_01",
    CnID = "拉蒙娜异变",
    BaseSortID = 744,
    Res = "CG/CG_SD/Static/CG_SD_S_B15_01.png"
  },
  CG_SD_S_B15_02 = {
    ID = "CG_SD_S_B15_02",
    CnID = "沙耶初遇",
    BaseSortID = 745,
    Res = "CG/CG_SD/Static/CG_SD_S_B15_02.png"
  },
  CG_SD_S_B15_03 = {
    ID = "CG_SD_S_B15_03",
    CnID = "虚弱的沙耶",
    BaseSortID = 746,
    Res = "CG/CG_SD/Static/CG_SD_S_B15_03.png"
  },
  CG_SD_S_B15_04 = {
    ID = "CG_SD_S_B15_04",
    CnID = "沙耶的记忆",
    BaseSortID = 747,
    Res = "CG/CG_SD/Static/CG_SD_S_B15_04.png"
  },
  CG_SD_S_B15_05 = {
    ID = "CG_SD_S_B15_05",
    CnID = "沙耶开花",
    BaseSortID = 748,
    Res = "CG/CG_SD/Static/CG_SD_S_B15_05.png"
  },
  SScene_RedWorld = {
    ID = "SScene_RedWorld",
    CnID = "血肉世界",
    BaseSortID = 749,
    Res = "Scenebg/SScene_RedWorld.png"
  },
  CG_SD_S_B15_06 = {
    ID = "CG_SD_S_B15_06",
    CnID = "拉蒙娜异变牵手",
    BaseSortID = 750,
    Res = "CG/CG_SD/Static/CG_SD_S_B15_06.png"
  },
  CG_SD_S_B15_07 = {
    ID = "CG_SD_S_B15_07",
    CnID = "沙耶开花远景",
    BaseSortID = 751,
    Res = "CG/CG_SD/Static/CG_SD_S_B15_07.png"
  },
  CG_SD_S_B15_08 = {
    ID = "CG_SD_S_B15_08",
    CnID = "沙耶全身",
    BaseSortID = 752,
    Res = "CG/CG_SD/Static/CG_SD_S_B15_08.png"
  },
  CG_SD_S_B15_09 = {
    ID = "CG_SD_S_B15_09",
    CnID = "沙耶吐绒毛",
    BaseSortID = 753,
    Res = "CG/CG_SD/Static/CG_SD_S_B15_09.png"
  },
  CG_SD_S_B15_10 = {
    ID = "CG_SD_S_B15_10",
    CnID = "沙耶的记忆-沙耶模糊",
    BaseSortID = 754,
    Res = "CG/CG_SD/Static/CG_SD_S_B15_10.png"
  },
  CG_SD_S_B15_11 = {
    ID = "CG_SD_S_B15_11",
    CnID = "沙耶的记忆-男人模糊",
    BaseSortID = 755,
    Res = "CG/CG_SD/Static/CG_SD_S_B15_11.png"
  },
  CG_SD_S_B15_12 = {
    ID = "CG_SD_S_B15_12",
    CnID = "虚弱的沙耶伸手",
    BaseSortID = 756,
    Res = "CG/CG_SD/Static/CG_SD_S_B15_12.png"
  },
  SScene_NormalVillageNoon = {
    ID = "SScene_NormalVillageNoon",
    CnID = "通用小镇日",
    BaseSortID = 757,
    Res = "Scenebg/SScene_NormalVillageNoon.png"
  },
  SScene_NormalVillageNight = {
    ID = "SScene_NormalVillageNight",
    CnID = "通用小镇夜",
    BaseSortID = 758,
    Res = "Scenebg/SScene_NormalVillageNight.png"
  },
  CG_SD_S_O13_1 = {
    ID = "CG_SD_S_O13_1",
    CnID = "庞托斯融蚀爬",
    BaseSortID = 759,
    Res = "CG/CG_SD/Static/CG_SD_S_O13_1.png"
  },
  CG_SD_S_O13_2 = {
    ID = "CG_SD_S_O13_2",
    CnID = "正常狂欢",
    BaseSortID = 760,
    Res = "CG/CG_SD/Static/CG_SD_S_O13_2.png"
  },
  CG_SD_S_O13_3 = {
    ID = "CG_SD_S_O13_3",
    CnID = "无灯光狂欢",
    BaseSortID = 761,
    Res = "CG/CG_SD/Static/CG_SD_S_O13_3.png"
  },
  CG_SD_S_O13_4 = {
    ID = "CG_SD_S_O13_4",
    CnID = "融蚀狂欢",
    BaseSortID = 762,
    Res = "CG/CG_SD/Static/CG_SD_S_O13_4.png"
  },
  CG_SD_S_O13_5 = {
    ID = "CG_SD_S_O13_5",
    CnID = "庞托斯普通爬",
    BaseSortID = 763,
    Res = "CG/CG_SD/Static/CG_SD_S_O13_5.png"
  },
  CG_SD_S_O13_6 = {
    ID = "CG_SD_S_O13_6",
    CnID = "黑色手",
    BaseSortID = 764,
    Res = "CG/CG_SD/Static/CG_SD_S_O13_6.png"
  },
  CG_SD_S_O13_7 = {
    ID = "CG_SD_S_O13_7",
    CnID = "庞托斯红色爬",
    BaseSortID = 765,
    Res = "CG/CG_SD/Static/CG_SD_S_O13_7.png"
  },
  CG_SD_S_O13_8 = {
    ID = "CG_SD_S_O13_8",
    CnID = "庞托斯大狂暴",
    BaseSortID = 766,
    Res = "CG/CG_SD/Static/CG_SD_S_O13_8.png"
  },
  SScene_Arena = {
    ID = "SScene_Arena",
    CnID = "角斗场-日",
    BaseSortID = 767,
    Res = "Scenebg/SScene_Arena.png"
  },
  SScene_ArenaNight = {
    ID = "SScene_ArenaNight",
    CnID = "角斗场-夜",
    BaseSortID = 768,
    Res = "Scenebg/SScene_ArenaNight.png"
  },
  SScene_SnowMountaintown = {
    ID = "SScene_SnowMountaintown",
    CnID = "雪山脚下",
    BaseSortID = 769,
    Res = "Scenebg/SScene_SnowMountaintown.png"
  },
  SScene_SnowMountaintop = {
    ID = "SScene_SnowMountaintop",
    CnID = "雪山风光",
    BaseSortID = 770,
    Res = "Scenebg/SScene_SnowMountaintop2.png"
  },
  SScene_Penitentes = {
    ID = "SScene_Penitentes",
    CnID = "雪山尖峰",
    BaseSortID = 771,
    Res = "Scenebg/SScene_SnowMountaintop1.png"
  },
  CG_C206_001 = {
    ID = "CG_C206_001",
    CnID = "卡拉布引路",
    BaseSortID = 772,
    Res = "CG/C206/Static/CG_C206_001.png"
  },
  CG_C206_002 = {
    ID = "CG_C206_002",
    CnID = "雪中苹果",
    BaseSortID = 773,
    Res = "CG/C206/Static/CG_C206_002.png"
  },
  CG_C206_003 = {
    ID = "CG_C206_003",
    CnID = "雪埋苹果",
    BaseSortID = 774,
    Res = "CG/C206/Static/CG_C206_003.png"
  },
  CG_C206_004 = {
    ID = "CG_C206_004",
    CnID = "卡拉布躺",
    BaseSortID = 775,
    Res = "CG/C206/Static/CG_C206_004.png"
  },
  CG_C206_005 = {
    ID = "CG_C206_005",
    CnID = "卡拉布笑",
    BaseSortID = 776,
    Res = "CG/C206/Static/CG_C206_005.png"
  },
  CG_C206_006 = {
    ID = "CG_C206_006",
    CnID = "卡拉布仪式",
    BaseSortID = 777,
    Res = "CG/C206/Static/CG_C206_006.png"
  },
  CG_C206_007 = {
    ID = "CG_C206_007",
    CnID = "卡拉布仪式红",
    BaseSortID = 778,
    Res = "CG/C206/Static/CG_C206_007.png"
  },
  CG_C206_008 = {
    ID = "CG_C206_008",
    CnID = "卡拉布玩苹果",
    BaseSortID = 779,
    Res = "CG/C206/Static/CG_C206_008.png"
  },
  CG_C206_009 = {
    ID = "CG_C206_009",
    CnID = "雪山绝壁",
    BaseSortID = 780,
    Res = "CG/C206/Static/CG_C206_009.png"
  },
  CG_SD_S_C04EX_1 = {
    ID = "CG_SD_S_C04EX_1",
    CnID = "萝坦面对星天之鲸",
    BaseSortID = 781,
    Res = "CG/CG_SD/Static/CG_SD_S_C04EX_1.png"
  },
  CG_SD_S_C04EX_2 = {
    ID = "CG_SD_S_C04EX_2",
    CnID = "萝坦面对星天之鲸-近景",
    BaseSortID = 782,
    Res = "CG/CG_SD/Static/CG_SD_S_C04EX_2.png"
  },
  CG_SD_S_C04EX_3 = {
    ID = "CG_SD_S_C04EX_3",
    CnID = "萝坦面对星天之鲸-平静",
    BaseSortID = 783,
    Res = "CG/CG_SD/Static/CG_SD_S_C04EX_3.png"
  },
  CG_SD_S_C04EX_4 = {
    ID = "CG_SD_S_C04EX_4",
    CnID = "萝坦面对星天之鲸-凶狠",
    BaseSortID = 784,
    Res = "CG/CG_SD/Static/CG_SD_S_C04EX_4.png"
  },
  Scene_B08_AF_1 = {
    ID = "Scene_B08_AF_1",
    CnID = "微光",
    BaseSortID = 785,
    Res = "Scenebg/Scene_B08_AF_1.jpg"
  },
  SScene_SnowRoad = {
    ID = "SScene_SnowRoad",
    CnID = "雪域之路",
    BaseSortID = 786,
    Res = "Scenebg/SScene_SnowRoad.png"
  },
  SScene_FireCave = {
    ID = "SScene_FireCave",
    CnID = "篝火洞窟",
    BaseSortID = 787,
    Res = "CG/C206/Static/CG_C206_010.png"
  },
  SScene_MoonLake = {
    ID = "SScene_MoonLake",
    CnID = "月湖",
    BaseSortID = 788,
    Res = "Scenebg/SScene_MoonLake.png"
  },
  SScene_SnowWood = {
    ID = "SScene_SnowWood",
    CnID = "雪山林地",
    BaseSortID = 789,
    Res = "Scenebg/SScene_Penitentes.png"
  },
  SScene_SmallFire = {
    ID = "SScene_SmallFire",
    CnID = "小火苗",
    BaseSortID = 790,
    Res = "Scenebg/Scene_SmallFire.png"
  },
  Scene_Bonfire = {
    ID = "Scene_Bonfire",
    CnID = "篝火",
    BaseSortID = 791,
    Res = "Scenebg/Scene_Bonfire.png"
  },
  Scene_DarkLight2 = {
    ID = "Scene_DarkLight2",
    CnID = "一缕大光",
    BaseSortID = 792,
    Res = "Scenebg/Scene_DarkLight2.png"
  },
  Scene_DarkLight = {
    ID = "Scene_DarkLight",
    CnID = "一缕小光",
    BaseSortID = 793,
    Res = "Scenebg/Scene_DarkLight.png"
  },
  CG_C206_012 = {
    ID = "CG_C206_012",
    CnID = "丝线",
    BaseSortID = 794,
    Res = "CG/C206/Static/CG_C206_012.png"
  },
  CG_C206_011 = {
    ID = "CG_C206_011",
    CnID = "卡拉布仪式红近景",
    BaseSortID = 795,
    Res = "CG/C206/Static/CG_C206_011.png"
  },
  CG_C206_013 = {
    ID = "CG_C206_013",
    CnID = "卡拉布玩红苹果",
    BaseSortID = 796,
    Res = "CG/C206/Static/CG_C206_013.png"
  },
  SScene_WastelandDusk = {
    ID = "SScene_WastelandDusk",
    CnID = "黄昏村庄",
    BaseSortID = 797,
    Res = "Scenebg/SScene_WastelandDusk.png"
  },
  SScene_StormyTown = {
    ID = "SScene_StormyTown",
    CnID = "暴雨城镇",
    BaseSortID = 798,
    Res = "Scenebg/SScene_StormyTown.png"
  },
  CG_C206_014 = {
    ID = "CG_C206_014",
    CnID = "奥吉尔授勋",
    BaseSortID = 799,
    Res = "CG/C206/Static/CG_C206_014.png"
  },
  CG_C206_015 = {
    ID = "CG_C206_015",
    CnID = "奥吉尔授勋-回忆",
    BaseSortID = 800,
    Res = "CG/C206/Static/CG_C206_015.png"
  },
  CG_C206_016 = {
    ID = "CG_C206_016",
    CnID = "奥吉尔授勋-发誓",
    BaseSortID = 801,
    Res = "CG/C206/Static/CG_C206_016.png"
  }
})
return AvgBg
