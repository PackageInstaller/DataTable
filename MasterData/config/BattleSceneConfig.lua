local System = require("System.System")
local readonly = System.readonly
local BattleSceneConfig = readonly({
  [17786] = {
    ID = 17786,
    CnID = "战斗场景@普通战斗@2舞台",
    BaseSortID = 1,
    BattleScene = "Assets/ArtRes/BScene/BScene_Belfry.unity",
    BattleSceneSfx = {3001}
  },
  [17743] = {
    ID = 17743,
    CnID = "战斗场景@普通战斗@3舞台",
    BaseSortID = 2,
    BattleScene = "Assets/ArtRes/BScene/BScene_Belfry.unity",
    BattleSceneSfx = {3002}
  },
  [17783] = {
    ID = 17783,
    CnID = "战斗场景@钟楼",
    BaseSortID = 3,
    BattleScene = "Assets/ArtRes/BScene/BScene_Belfry.unity"
  },
  [17706] = {
    ID = 17706,
    CnID = "战斗场景@精英战斗@2舞台",
    BaseSortID = 4,
    BattleScene = "Assets/ArtRes/BScene/BScene_Belfry.unity"
  },
  [17787] = {
    ID = 17787,
    CnID = "战斗场景@精英战斗@3舞台",
    BaseSortID = 5,
    BattleScene = "Assets/ArtRes/BScene/BScene_Belfry.unity"
  },
  [17782] = {
    ID = 17782,
    CnID = "战斗场景@精英战斗@4舞台",
    BaseSortID = 6,
    BattleScene = "Assets/ArtRes/BScene/BScene_Belfry.unity"
  },
  [17747] = {
    ID = 17747,
    CnID = "战斗场景@Boss战斗",
    BaseSortID = 7,
    BattleScene = "Assets/ArtRes/BScene/BScene_Belfry.unity"
  },
  [17750] = {
    ID = 17750,
    CnID = "战斗场景@RPG战斗",
    BaseSortID = 8,
    BattleScene = "Assets/ArtRes/Scenes/UScene/BattleMaps/S_BM_TreeM_03.unity"
  },
  [17726] = {
    ID = 17726,
    CnID = "战斗场景@RPG竞技场",
    BaseSortID = 9,
    BattleScene = "Assets/ArtRes/Scenes/UScene/RPGMaps/S_RPG_TreeM_01.unity"
  },
  [17707] = {
    ID = 17707,
    CnID = "战斗场景@意识空间",
    BaseSortID = 10,
    BattleScene = "Assets/ArtRes/BScene/BScene_ConsciousSpace.unity"
  },
  [17753] = {
    ID = 17753,
    CnID = "战斗场景@动力室",
    BaseSortID = 11,
    BattleScene = "Assets/ArtRes/BScene/BScene_PowerHouse.unity"
  },
  [17733] = {
    ID = 17733,
    CnID = "战斗场景@星球意识空间",
    BaseSortID = 12,
    BattleScene = "Assets/ArtRes/BScene/BScene_ConsciousSpaceB.unity"
  },
  [17795] = {
    ID = 17795,
    CnID = "战斗场景@济贫院地下研究室@BOSS",
    BaseSortID = 13,
    BattleScene = "Assets/ArtRes/BScene/BScene_JPLab.unity"
  },
  [17776] = {
    ID = 17776,
    CnID = "战斗场景@济贫院外@日@BOSS",
    BaseSortID = 14,
    BattleScene = "Assets/ArtRes/BScene/BScene_JPWorkHouse_light.unity"
  },
  [17775] = {
    ID = 17775,
    CnID = "战斗场景@济贫院外@夜@BOSS",
    BaseSortID = 15,
    BattleScene = "Assets/ArtRes/BScene/BScene_JPWorkHouse_Night.unity"
  },
  [17799] = {
    ID = 17799,
    CnID = "战斗场景@济贫院地下研究室",
    BaseSortID = 16,
    BattleScene = "Assets/ArtRes/BScene/BScene_JPLab.unity"
  },
  [17735] = {
    ID = 17735,
    CnID = "战斗场景@济贫院外@日",
    BaseSortID = 17,
    BattleScene = "Assets/ArtRes/BScene/BScene_JPWorkHouse_light.unity"
  },
  [17704] = {
    ID = 17704,
    CnID = "战斗场景@济贫院外@夜",
    BaseSortID = 18,
    BattleScene = "Assets/ArtRes/BScene/BScene_JPWorkHouse_Night.unity"
  },
  [38718] = {
    ID = 38718,
    CnID = "战斗场景@济贫院外@红月",
    BaseSortID = 19,
    BattleScene = "Assets/ArtRes/BScene/BScene_JPWorkHouse_HY.unity"
  },
  [17701] = {
    ID = 17701,
    CnID = "战斗场景@钟楼@BOSS战",
    BaseSortID = 20,
    BattleScene = "Assets/ArtRes/BScene/BScene_Belfry.unity"
  },
  [17751] = {
    ID = 17751,
    CnID = "战斗场景@钟楼@BOSS战关底专用",
    BaseSortID = 21,
    BattleScene = "Assets/ArtRes/BScene/BScene_Belfry_Boss.unity"
  },
  [17756] = {
    ID = 17756,
    CnID = "战斗场景@济贫院@前院",
    BaseSortID = 22,
    BattleScene = "Assets/ArtRes/BScene/BScene_CourtYard.unity"
  },
  [17723] = {
    ID = 17723,
    CnID = "战斗场景@战斗测试场景1",
    BaseSortID = 23,
    BattleScene = "Assets/ArtRes/BScene/BScene_JPLab.unity",
    EnterAudioEvent = {16299},
    LeaveAudioEvent = {16227}
  },
  [17724] = {
    ID = 17724,
    CnID = "战斗场景@战斗测试场景2",
    BaseSortID = 24,
    BattleScene = "Assets/ArtRes/BScene/BScene_JPWorkHouse_light.unity",
    EnterAudioEvent = {15985},
    LeaveAudioEvent = {16080}
  },
  [17725] = {
    ID = 17725,
    CnID = "战斗场景@战斗测试场景3",
    BaseSortID = 25,
    BattleScene = "Assets/ArtRes/BScene/BScene_JPWorkHouse_Night.unity",
    EnterAudioEvent = {16044},
    LeaveAudioEvent = {16021}
  },
  [17719] = {
    ID = 17719,
    CnID = "战斗场景@战斗测试场景4",
    BaseSortID = 26,
    BattleScene = "Assets/ArtRes/BScene/BScene_WaxRoom.unity"
  },
  [17720] = {
    ID = 17720,
    CnID = "战斗场景@战斗测试场景5",
    BaseSortID = 27,
    BattleScene = "Assets/ArtRes/BScene/BScene_SWaxRoom.unity"
  },
  [17721] = {
    ID = 17721,
    CnID = "战斗场景@战斗测试场景6",
    BaseSortID = 28,
    BattleScene = "Assets/ArtRes/BScene/BScene_WaxMuseum.unity"
  },
  [17722] = {
    ID = 17722,
    CnID = "战斗场景@战斗测试场景7",
    BaseSortID = 29,
    BattleScene = "Assets/ArtRes/BScene/BScene_TheMonth.unity"
  },
  [17727] = {
    ID = 17727,
    CnID = "战斗场景@战斗测试场景8",
    BaseSortID = 30,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_01.unity"
  },
  [17728] = {
    ID = 17728,
    CnID = "战斗场景@战斗测试场景9",
    BaseSortID = 31,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_02.unity"
  },
  [17770] = {
    ID = 17770,
    CnID = "战斗场景@战斗测试场景10",
    BaseSortID = 32,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_03.unity"
  },
  [17771] = {
    ID = 17771,
    CnID = "战斗场景@战斗测试场景11",
    BaseSortID = 33,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_04.unity"
  },
  [17768] = {
    ID = 17768,
    CnID = "战斗场景@战斗测试场景12",
    BaseSortID = 34,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_05.unity"
  },
  [17769] = {
    ID = 17769,
    CnID = "战斗场景@战斗测试场景13",
    BaseSortID = 35,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_06.unity"
  },
  [17766] = {
    ID = 17766,
    CnID = "战斗场景@战斗测试场景14",
    BaseSortID = 36,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_07.unity"
  },
  [17767] = {
    ID = 17767,
    CnID = "战斗场景@战斗测试场景15",
    BaseSortID = 37,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_08.unity"
  },
  [17764] = {
    ID = 17764,
    CnID = "战斗场景@战斗测试场景16",
    BaseSortID = 38,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_09.unity"
  },
  [17765] = {
    ID = 17765,
    CnID = "战斗场景@战斗测试场景17",
    BaseSortID = 39,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_08.unity"
  },
  [17773] = {
    ID = 17773,
    CnID = "战斗场景@战斗测试场景18",
    BaseSortID = 40,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_09.unity"
  },
  [17774] = {
    ID = 17774,
    CnID = "战斗场景@战斗测试场景19",
    BaseSortID = 41,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_12.unity"
  },
  [17788] = {
    ID = 17788,
    CnID = "战斗场景@战斗测试场景20",
    BaseSortID = 42,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_13.unity"
  },
  [17732] = {
    ID = 17732,
    CnID = "战斗场景@战斗测试场景21",
    BaseSortID = 43,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_14.unity"
  },
  [17703] = {
    ID = 17703,
    CnID = "战斗场景@战斗测试场景22",
    BaseSortID = 44,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_15.unity"
  },
  [17785] = {
    ID = 17785,
    CnID = "战斗场景@战斗测试场景23",
    BaseSortID = 45,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_16.unity"
  },
  [17792] = {
    ID = 17792,
    CnID = "战斗场景@战斗测试场景24",
    BaseSortID = 46,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_17.unity"
  },
  [17791] = {
    ID = 17791,
    CnID = "战斗场景@战斗测试场景25",
    BaseSortID = 47,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_18.unity"
  },
  [17708] = {
    ID = 17708,
    CnID = "战斗场景@战斗测试场景26",
    BaseSortID = 48,
    BattleScene = "Assets/ArtRes/BScene/BScene_Btest_19.unity"
  },
  [17789] = {
    ID = 17789,
    CnID = "战斗场景@战斗测试场景27",
    BaseSortID = 49,
    BattleScene = "Assets/ArtRes/BScene/BScene_WaxUnderground_Corrosion.unity"
  },
  [17794] = {
    ID = 17794,
    CnID = "战斗场景@战斗测试场景28",
    BaseSortID = 50,
    BattleScene = "Assets/ArtRes/BScene/BScene_SWRoom_Corrosion.unity"
  },
  [17793] = {
    ID = 17793,
    CnID = "战斗场景@战斗测试场景29",
    BaseSortID = 51,
    BattleScene = "Assets/ArtRes/BScene/BScene_InsideSubway.unity"
  },
  [17801] = {
    ID = 17801,
    CnID = "战斗场景@战斗测试场景30",
    BaseSortID = 52,
    BattleScene = "Assets/ArtRes/BScene/BScene_SanatoriumAisle.unity"
  },
  [17802] = {
    ID = 17802,
    CnID = "战斗场景@战斗测试场景31",
    BaseSortID = 53,
    BattleScene = "Assets/ArtRes/BScene/BScene_TheMonthLight.unity"
  },
  [17730] = {
    ID = 17730,
    CnID = "战斗场景@PVP测试",
    BaseSortID = 54,
    BattleScene = "Assets/ArtRes/PScene/PScene_JPWorkHouse_light.unity"
  },
  [22044] = {
    ID = 22044,
    CnID = "战斗场景@PVP小树林",
    BaseSortID = 55,
    BattleScene = "Assets/ArtRes/PScene/PScene_Tree.unity"
  },
  [23707] = {
    ID = 23707,
    CnID = "战斗场景@PVP伦敦",
    BaseSortID = 56,
    BattleScene = "Assets/ArtRes/PScene/PScene_JPWorkHouse_light.unity"
  },
  [22047] = {
    ID = 22047,
    CnID = "战斗场景@PVP钥匙",
    BaseSortID = 57,
    BattleScene = "Assets/ArtRes/PScene/PScene_BigKey.unity"
  },
  [23705] = {
    ID = 23705,
    CnID = "战斗场景@PVP冬天小镇",
    BaseSortID = 58,
    BattleScene = "Assets/ArtRes/PScene/PScene_TheMonthLight.unity"
  },
  [23706] = {
    ID = 23706,
    CnID = "战斗场景@PVP华丽的大厅",
    BaseSortID = 59,
    BattleScene = "Assets/ArtRes/PScene/PScene_PalaceHaLLNight.unity"
  },
  [23704] = {
    ID = 23704,
    CnID = "战斗场景@PVP蜡像馆",
    BaseSortID = 60,
    BattleScene = "Assets/ArtRes/PScene/PScene_WaxRoom.unity"
  },
  [17780] = {
    ID = 17780,
    CnID = "战斗场景@第二章@蜡像馆普通陈列室",
    BaseSortID = 61,
    BattleScene = "Assets/ArtRes/BScene/BScene_WaxRoom.unity"
  },
  [17778] = {
    ID = 17778,
    CnID = "战斗场景@第二章@蜡像馆工作室",
    BaseSortID = 62,
    BattleScene = "Assets/ArtRes/BScene/BScene_WaxMuseum.unity"
  },
  [17744] = {
    ID = 17744,
    CnID = "战斗场景@第二章@蜡像馆特殊陈列室",
    BaseSortID = 63,
    BattleScene = "Assets/ArtRes/BScene/BScene_SWRoom_Corrosion.unity"
  },
  [17797] = {
    ID = 17797,
    CnID = "战斗场景@第二章@蜡像馆地下室融蚀",
    BaseSortID = 64,
    BattleScene = "Assets/ArtRes/BScene/BScene_WaxUnderground_Corrosion.unity"
  },
  [17752] = {
    ID = 17752,
    CnID = "战斗场景@第二章@蜡像馆特殊陈列室-融蚀版",
    BaseSortID = 65,
    BattleScene = "Assets/ArtRes/BScene/BScene_SWRoom_Corrosion.unity"
  },
  [17702] = {
    ID = 17702,
    CnID = "战斗场景@第三章@小镇街道夜",
    BaseSortID = 66,
    BattleScene = "Assets/ArtRes/BScene/BScene_TheMonth.unity"
  },
  [17746] = {
    ID = 17746,
    CnID = "战斗场景@第三章@小镇街道日",
    BaseSortID = 67,
    BattleScene = "Assets/ArtRes/BScene/BScene_TheMonthLight.unity"
  },
  [20228] = {
    ID = 20228,
    CnID = "战斗场景@第三章@小镇街道夜_雪",
    BaseSortID = 68,
    BattleScene = "Assets/ArtRes/BScene/BScene_TheMonth_Snow.unity",
    BattleSceneSfx = {
      "Snow_texture_Prefab"
    },
    EnterAudioEvent = {16299},
    LeaveAudioEvent = {16227}
  },
  [20229] = {
    ID = 20229,
    CnID = "战斗场景@第三章@小镇街道日_雪",
    BaseSortID = 69,
    BattleScene = "Assets/ArtRes/BScene/BScene_TheMonthLight_Snow.unity",
    BattleSceneSfx = {
      "Snow_texture_Prefab"
    },
    EnterAudioEvent = {16299},
    LeaveAudioEvent = {16227}
  },
  [17745] = {
    ID = 17745,
    CnID = "战斗场景@第三章@小镇地铁内部",
    BaseSortID = 70,
    BattleScene = "Assets/ArtRes/BScene/BScene_InsideSubway.unity",
    CameraController = "TimelineRoot/InScenes/SpecialCycle/SpecialCycle_InsideSubway/SpecialCycle_InsideSubway.prefab"
  },
  [17705] = {
    ID = 17705,
    CnID = "战斗场景@第三章@疗养院走廊",
    BaseSortID = 71,
    BattleScene = "Assets/ArtRes/BScene/BScene_SanatoriumAisle.unity"
  },
  [17781] = {
    ID = 17781,
    CnID = "战斗场景@第三章@疗养院手术室",
    BaseSortID = 72,
    BattleScene = "Assets/ArtRes/BScene/BScene_LYYTheater.unity"
  },
  [17754] = {
    ID = 17754,
    CnID = "战斗场景@第三章@铁路桥",
    BaseSortID = 73,
    BattleScene = "Assets/ArtRes/BScene/BScene_Railway.unity"
  },
  [60826] = {
    ID = 60826,
    CnID = "战斗场景@墓园",
    BaseSortID = 74,
    BattleScene = "Assets/ArtRes/BScene/BScene_BattleGra.unity",
    LeaveAudioEvent = {16021}
  },
  [17784] = {
    ID = 17784,
    CnID = "战斗场景@序章@墓地战斗",
    BaseSortID = 75,
    BattleScene = "Assets/ArtRes/BScene/BScene_BattleGra.unity",
    BattleSceneSfx = {
      "E_MScene_Co_Rain_01"
    },
    EnterAudioEvent = {16044},
    LeaveAudioEvent = {16021}
  },
  [17731] = {
    ID = 17731,
    CnID = "战斗场景@序章@墓园战斗BOSS",
    BaseSortID = 76,
    BattleScene = "Assets/ArtRes/BScene/BScene_Cemetery.unity"
  },
  [21493] = {
    ID = 21493,
    CnID = "战斗场景@第四章@疗养院走廊差分",
    BaseSortID = 77,
    BattleScene = "Assets/ArtRes/BScene/BScene_SanatoriumAisleCF.unity"
  },
  [17742] = {
    ID = 17742,
    CnID = "战斗场景@第四章@BossNew",
    BaseSortID = 78,
    BattleScene = "Assets/ArtRes/BScene/BScene_LYYTheaterCF.unity"
  },
  [17772] = {
    ID = 17772,
    CnID = "战斗场景@第五章@幽灵船甲板异空间",
    BaseSortID = 79,
    BattleScene = "Assets/ArtRes/BScene/BScene_GhostShip.unity",
    CameraController = "TimelineRoot/InScenes/SpecialCycle/SpecialCycle_GhostShip/SpecialCycle_GhostShip.prefab"
  },
  [17748] = {
    ID = 17748,
    CnID = "战斗场景@第五章@幽灵船普通月色",
    BaseSortID = 80,
    BattleScene = "Assets/ArtRes/BScene/BScene_GhostShipML.unity",
    CameraController = "TimelineRoot/InScenes/SpecialCycle/SpecialCycle_GhostShipML/SpecialCycle_GhostShipML.prefab"
  },
  [21729] = {
    ID = 21729,
    CnID = "战斗场景@第五章@甲板船仓",
    BaseSortID = 81,
    BattleScene = "Assets/ArtRes/BScene/BScene_DeckCargoShip.unity"
  },
  [17762] = {
    ID = 17762,
    CnID = "战斗场景@第五章@癫狂海德拉",
    BaseSortID = 82,
    BattleScene = "Assets/ArtRes/BScene/BScene_Hydra.unity"
  },
  [17749] = {
    ID = 17749,
    CnID = "战斗场景@第三章补充雪地",
    BaseSortID = 83,
    BattleScene = "Assets/ArtRes/BScene/BScene_Snowfield.unity"
  },
  [17755] = {
    ID = 17755,
    CnID = "战斗场景@第五章港口",
    BaseSortID = 84,
    BattleScene = "Assets/ArtRes/BScene/BScene_Port.unity"
  },
  [17729] = {
    ID = 17729,
    CnID = "战斗场景@第五章动力室破解版差分",
    BaseSortID = 85,
    BattleScene = "Assets/ArtRes/BScene/BScene_PowerHouseCF.unity"
  },
  [17796] = {
    ID = 17796,
    CnID = "战斗场景@荆棘女王大招场景",
    BaseSortID = 86,
    BattleScene = "Assets/ArtRes/BScene/BScene_AwakerD04.unity"
  },
  [35102] = {
    ID = 35102,
    CnID = "战斗场景@第六章@甲板船仓差分",
    BaseSortID = 87,
    BattleScene = "Assets/ArtRes/BScene/BScene_DeckCargoShipCF.unity"
  },
  [17798] = {
    ID = 17798,
    CnID = "战斗场景@第六章关底Boss",
    BaseSortID = 88,
    BattleScene = "Assets/ArtRes/BScene/BScene_ProwBattle.unity",
    BattleSceneSfx = {
      "Scene_Smork_01"
    }
  },
  [35777] = {
    ID = 35777,
    CnID = "战斗场景@第六章@货轮驾驶仓",
    BaseSortID = 89,
    BattleScene = "Assets/ArtRes/BScene/BScene_SteamerCab.unity"
  },
  [41346] = {
    ID = 41346,
    CnID = "战斗场景@第七章@圣河夜间",
    BaseSortID = 90,
    BattleScene = "Assets/ArtRes/BScene/BScene_SacreDriver.unity"
  },
  [44185] = {
    ID = 44185,
    CnID = "战斗场景@第七章@BOSS战",
    BaseSortID = 91,
    BattleScene = "Assets/ArtRes/BScene/BScene_SeedBearer.unity"
  },
  [74018] = {
    ID = 74018,
    CnID = "战斗场景@朵儿@实验室",
    BaseSortID = 92,
    BattleScene = "Assets/ArtRes/BScene/BScene_Library.unity"
  },
  [17763] = {
    ID = 17763,
    CnID = "战斗场景@材料本测试",
    BaseSortID = 93,
    BattleScene = "Assets/ArtRes/AScene/AScene_Head.unity"
  },
  [17759] = {
    ID = 17759,
    CnID = "战斗场景@材料本测试2",
    BaseSortID = 94,
    BattleScene = "Assets/ArtRes/AScene/AScene_StoneSteles.unity"
  },
  [17760] = {
    ID = 17760,
    CnID = "战斗场景@材料本测试3",
    BaseSortID = 95,
    BattleScene = "Assets/ArtRes/AScene/AScene_RedKey.unity"
  },
  [17757] = {
    ID = 17757,
    CnID = "战斗场景@材料本测试4",
    BaseSortID = 96,
    BattleScene = "Assets/ArtRes/AScene/AScene_BigKey.unity"
  },
  [17758] = {
    ID = 17758,
    CnID = "战斗场景@材料本测试5",
    BaseSortID = 97,
    BattleScene = "Assets/ArtRes/AScene/AScene_Gold.unity"
  },
  [17790] = {
    ID = 17790,
    CnID = "战斗场景@双周爬塔159",
    BaseSortID = 98,
    BattleScene = "Assets/ArtRes/AScene/AScene_Abysm.unity"
  },
  [17709] = {
    ID = 17709,
    CnID = "战斗场景@双周爬塔2610",
    BaseSortID = 99,
    BattleScene = "Assets/ArtRes/AScene/AScene_AbysmTwo.unity"
  },
  [17779] = {
    ID = 17779,
    CnID = "战斗场景@双周爬塔3711",
    BaseSortID = 100,
    BattleScene = "Assets/ArtRes/AScene/AScene_AbysmThree.unity"
  },
  [17804] = {
    ID = 17804,
    CnID = "战斗场景@双周爬塔4812",
    BaseSortID = 101,
    BattleScene = "Assets/ArtRes/AScene/AScene_AbysmFour.unity"
  },
  [17777] = {
    ID = 17777,
    CnID = "战斗场景@材料本金币",
    BaseSortID = 102,
    BattleScene = "Assets/ArtRes/AScene/AScene_Corrosion.unity"
  },
  [17716] = {
    ID = 17716,
    CnID = "战斗场景@日常挑战1",
    BaseSortID = 103,
    BattleScene = "Assets/ArtRes/AScene/AScene_Gold.unity"
  },
  [17717] = {
    ID = 17717,
    CnID = "战斗场景@日常挑战2",
    BaseSortID = 104,
    BattleScene = "Assets/ArtRes/AScene/AScene_StoneSteles.unity"
  },
  [17718] = {
    ID = 17718,
    CnID = "战斗场景@日常挑战3",
    BaseSortID = 105,
    BattleScene = "Assets/ArtRes/AScene/AScene_Head.unity"
  },
  [17712] = {
    ID = 17712,
    CnID = "战斗场景@日常挑战4",
    BaseSortID = 106,
    BattleScene = "Assets/ArtRes/AScene/AScene_BigKey.unity"
  },
  [17713] = {
    ID = 17713,
    CnID = "战斗场景@日常挑战5",
    BaseSortID = 107,
    BattleScene = "Assets/ArtRes/AScene/AScene_RedKey.unity"
  },
  [17714] = {
    ID = 17714,
    CnID = "战斗场景@日常挑战6",
    BaseSortID = 108,
    BattleScene = "Assets/ArtRes/AScene/AScene_Gold.unity"
  },
  [17715] = {
    ID = 17715,
    CnID = "战斗场景@日常挑战7",
    BaseSortID = 109,
    BattleScene = "Assets/ArtRes/AScene/AScene_StoneSteles.unity"
  },
  [17710] = {
    ID = 17710,
    CnID = "战斗场景@日常挑战8",
    BaseSortID = 110,
    BattleScene = "Assets/ArtRes/AScene/AScene_Head.unity"
  },
  [17711] = {
    ID = 17711,
    CnID = "战斗场景@日常挑战9",
    BaseSortID = 111,
    BattleScene = "Assets/ArtRes/AScene/AScene_BigKey.unity"
  },
  [17740] = {
    ID = 17740,
    CnID = "战斗场景@日常挑战10",
    BaseSortID = 112,
    BattleScene = "Assets/ArtRes/AScene/AScene_RedKey.unity"
  },
  [17741] = {
    ID = 17741,
    CnID = "战斗场景@日常挑战11",
    BaseSortID = 113,
    BattleScene = "Assets/ArtRes/AScene/AScene_Gold.unity"
  },
  [17738] = {
    ID = 17738,
    CnID = "战斗场景@日常挑战12",
    BaseSortID = 114,
    BattleScene = "Assets/ArtRes/AScene/AScene_StoneSteles.unity"
  },
  [17739] = {
    ID = 17739,
    CnID = "战斗场景@日常挑战13",
    BaseSortID = 115,
    BattleScene = "Assets/ArtRes/AScene/AScene_Head.unity"
  },
  [17736] = {
    ID = 17736,
    CnID = "战斗场景@日常挑战14",
    BaseSortID = 116,
    BattleScene = "Assets/ArtRes/AScene/AScene_BigKey.unity"
  },
  [17737] = {
    ID = 17737,
    CnID = "战斗场景@日常挑战15",
    BaseSortID = 117,
    BattleScene = "Assets/ArtRes/AScene/AScene_RedKey.unity"
  },
  [17803] = {
    ID = 17803,
    CnID = "战斗场景@角色突破材料本",
    BaseSortID = 118,
    BattleScene = "Assets/ArtRes/AScene/AScene_IceField.unity"
  },
  [17699] = {
    ID = 17699,
    CnID = "战斗场景@技能材料本",
    BaseSortID = 119,
    BattleScene = "Assets/ArtRes/AScene/AScene_Tree.unity"
  },
  [17761] = {
    ID = 17761,
    CnID = "战斗场景@通用暗色树林",
    BaseSortID = 120,
    BattleScene = "Assets/ArtRes/AScene/AScene_DarkTree.unity"
  },
  [17700] = {
    ID = 17700,
    CnID = "战斗场景@达芙黛尔荒原白天",
    BaseSortID = 121,
    BattleScene = "Assets/ArtRes/BScene/BScene_Wasteland.unity"
  },
  [17734] = {
    ID = 17734,
    CnID = "战斗场景@达芙黛尔荒原夜晚",
    BaseSortID = 122,
    BattleScene = "Assets/ArtRes/BScene/BScene_WastelandDark.unity"
  },
  [20230] = {
    ID = 20230,
    CnID = "战斗场景@第三章@小镇街道夜_天气测试",
    BaseSortID = 123,
    BattleScene = "Assets/ArtRes/BScene/BScene_TheMonth.unity",
    BattleSceneSfx = {3001}
  },
  [21409] = {
    ID = 21409,
    CnID = "战斗场景@豪华大厅@日",
    BaseSortID = 124,
    BattleScene = "Assets/ArtRes/BScene/BScene_PalaceHallDay.unity"
  },
  [21405] = {
    ID = 21405,
    CnID = "战斗场景@大手空间",
    BaseSortID = 125,
    BattleScene = "Assets/ArtRes/AScene/AScene_Gold.unity"
  },
  [21404] = {
    ID = 21404,
    CnID = "战斗场景@豪华大厅@夜",
    BaseSortID = 126,
    BattleScene = "Assets/ArtRes/BScene/BScene_PalaceHaLLNight.unity"
  },
  [21408] = {
    ID = 21408,
    CnID = "战斗场景@沙漠@夜",
    BaseSortID = 127,
    BattleScene = "Assets/ArtRes/BScene/BScene_DesertNight.unity"
  },
  [21407] = {
    ID = 21407,
    CnID = "战斗场景@沙漠@日",
    BaseSortID = 128,
    BattleScene = "Assets/ArtRes/BScene/BScene_DesertSun.unity"
  },
  [49744] = {
    ID = 49744,
    CnID = "战斗场景@沙漠@日_风沙",
    BaseSortID = 129,
    BattleScene = "Assets/ArtRes/BScene/BScene_DesertSun.unity",
    BattleSceneSfx = {
      "Scene_Sand_02"
    }
  },
  [21406] = {
    ID = 21406,
    CnID = "战斗场景@沙漠@黄昏",
    BaseSortID = 130,
    BattleScene = "Assets/ArtRes/BScene/BScene_DesertDusk.unity"
  },
  [22379] = {
    ID = 22379,
    CnID = "战斗场景@小树林@日",
    BaseSortID = 131,
    BattleScene = "Assets/ArtRes/AScene/AScene_Tree.unity"
  },
  [23702] = {
    ID = 23702,
    CnID = "战斗场景@莉莉@电影片场_日",
    BaseSortID = 132,
    BattleScene = "Assets/ArtRes/BScene/BScene_Movie.unity"
  },
  [24059] = {
    ID = 24059,
    CnID = "战斗场景@莉莉@电影片场_阴森",
    BaseSortID = 133,
    BattleScene = "Assets/ArtRes/BScene/BScene_MovieCF.unity"
  },
  [24157] = {
    ID = 24157,
    CnID = "战斗场景@索蕾尔@豪华大厅_蔷薇版",
    BaseSortID = 134,
    BattleScene = "Assets/ArtRes/BScene/BScene_PalaceHallFlower.unity"
  },
  [24642] = {
    ID = 24642,
    CnID = "战斗场景@索蕾尔@歌剧院_暗蚀版",
    BaseSortID = 135,
    BattleScene = "Assets/ArtRes/BScene/BScene_OperaHouseDark.unity"
  },
  [24741] = {
    ID = 24741,
    CnID = "战斗场景@索蕾尔@歌剧院_通用",
    BaseSortID = 136,
    BattleScene = "Assets/ArtRes/BScene/BScene_OperaHouse.unity"
  },
  [43603] = {
    ID = 43603,
    CnID = "战斗场景@萨尔瓦多@教堂_血月",
    BaseSortID = 137,
    BattleScene = "Assets/ArtRes/BScene/BScene_ChurchHY.unity"
  },
  [43977] = {
    ID = 43977,
    CnID = "战斗场景@萨尔瓦多@教堂_通用",
    BaseSortID = 138,
    BattleScene = "Assets/ArtRes/BScene/BScene_Church.unity"
  },
  [44922] = {
    ID = 44922,
    CnID = "战斗场景@通用墓地@白天",
    BaseSortID = 139,
    BattleScene = "Assets/ArtRes/BScene/BScene_CCemeteryDay.unity"
  },
  [46121] = {
    ID = 46121,
    CnID = "战斗场景@海洋@日间",
    BaseSortID = 140,
    BattleScene = "Assets/ArtRes/BScene/BScene_OceanDay.unity"
  },
  [47508] = {
    ID = 47508,
    CnID = "战斗场景@通用墓地@夜",
    BaseSortID = 141,
    BattleScene = "Assets/ArtRes/BScene/BScene_CCemeteryDark.unity"
  },
  [48155] = {
    ID = 48155,
    CnID = "战斗场景@意识空间@母树",
    BaseSortID = 142,
    BattleScene = "Assets/ArtRes/BScene/BScene_ConsciousSpaceD.unity"
  },
  [48557] = {
    ID = 48557,
    CnID = "战斗场景@圣河@日间",
    BaseSortID = 143,
    BattleScene = "Assets/ArtRes/BScene/BScene_SacreDriverDay.unity"
  },
  [49158] = {
    ID = 49158,
    CnID = "战斗场景@废弃工厂@沙漠",
    BaseSortID = 144,
    BattleScene = "Assets/ArtRes/BScene/BScene_Camouflage.unity"
  },
  [50391] = {
    ID = 50391,
    CnID = "战斗场景@沙尘暴",
    BaseSortID = 145,
    BattleScene = "Assets/ArtRes/BScene/BScene_InSandstorm.unity",
    BattleSceneSfx = {
      "Scene_Sand_02"
    }
  },
  [53652] = {
    ID = 53652,
    CnID = "战斗场景@济贫院外日奥尔拉",
    BaseSortID = 146,
    BattleScene = "Assets/ArtRes/BScene/BScene_StreetPainting.unity"
  },
  [53761] = {
    ID = 53761,
    CnID = "战斗场景@花园奥尔拉",
    BaseSortID = 147,
    BattleScene = "Assets/ArtRes/BScene/BScene_StreetPGarden.unity"
  },
  [56426] = {
    ID = 56426,
    CnID = "战斗场景@第八章@BOSS战",
    BaseSortID = 148,
    BattleScene = "Assets/ArtRes/BScene/BScene_EightBoss.unity"
  },
  [65560] = {
    ID = 65560,
    CnID = "战斗场景@第九章@BOSS战",
    BaseSortID = 149,
    BattleScene = "Assets/ArtRes/BScene/BScene_Ninth.unity"
  },
  [68417] = {
    ID = 68417,
    CnID = "战斗场景@第九章@BOSS战小怪部分",
    BaseSortID = 150,
    BattleScene = "Assets/ArtRes/BScene/BScene_Ninth_sp.unity"
  },
  [60824] = {
    ID = 60824,
    CnID = "战斗场景@弥撒格校园",
    BaseSortID = 151,
    BattleScene = "Assets/ArtRes/BScene/BScene_SCampus.unity"
  },
  [60835] = {
    ID = 60835,
    CnID = "战斗场景@弥撒格校园夜",
    BaseSortID = 152,
    BattleScene = "Assets/ArtRes/BScene/BScene_SCampusCF.unity"
  },
  [60827] = {
    ID = 60827,
    CnID = "战斗场景@音乐教室",
    BaseSortID = 153,
    BattleScene = "Assets/ArtRes/BScene/BScene_MusicRoom.unity"
  },
  [68316] = {
    ID = 68316,
    CnID = "战斗场景@托乎瓦波活动1悲泣",
    BaseSortID = 154,
    BattleScene = "Assets/ArtRes/BScene/BScene_WorldBoss_01.unity"
  },
  [68315] = {
    ID = 68315,
    CnID = "战斗场景@托乎瓦波活动2恐惧",
    BaseSortID = 155,
    BattleScene = "Assets/ArtRes/BScene/BScene_WorldBoss_02.unity"
  },
  [68320] = {
    ID = 68320,
    CnID = "战斗场景@托乎瓦波活动3刺骨",
    BaseSortID = 156,
    BattleScene = "Assets/ArtRes/BScene/BScene_WorldBoss_03.unity"
  },
  [68318] = {
    ID = 68318,
    CnID = "战斗场景@托乎瓦波活动4诡谲",
    BaseSortID = 157,
    BattleScene = "Assets/ArtRes/BScene/BScene_WorldBoss_04.unity"
  },
  [68319] = {
    ID = 68319,
    CnID = "战斗场景@托乎瓦波活动5邪信",
    BaseSortID = 158,
    BattleScene = "Assets/ArtRes/BScene/BScene_WorldBoss_05.unity"
  },
  [68317] = {
    ID = 68317,
    CnID = "战斗场景@托乎瓦波活动6疯狂",
    BaseSortID = 159,
    BattleScene = "Assets/ArtRes/BScene/BScene_WorldBoss_06.unity"
  },
  [68321] = {
    ID = 68321,
    CnID = "战斗场景@托乎瓦波活动7诞临",
    BaseSortID = 160,
    BattleScene = "Assets/ArtRes/BScene/BScene_WorldBoss_07.unity"
  },
  [77853] = {
    ID = 77853,
    CnID = "战斗场景@熔毁朵尔BOSS战",
    BaseSortID = 161,
    BattleScene = "Assets/ArtRes/BScene/BScene_Library.unity"
  },
  [79251] = {
    ID = 79251,
    CnID = "战斗场景@逆转回合活动PVP背景",
    BaseSortID = 162,
    BattleScene = "Assets/ArtRes/PScene/PScene_ReverseInningBattle.unity"
  },
  [80699] = {
    ID = 80699,
    CnID = "战斗场景@夏盖孵化室",
    BaseSortID = 163,
    BattleScene = "Assets/ArtRes/BScene/BScene_InsectNest.unity"
  },
  [80086] = {
    ID = 80086,
    CnID = "战斗场景@夏盖投影BOSS战",
    BaseSortID = 164,
    BattleScene = "Assets/ArtRes/BScene/BScene_InsectNest2.unity"
  },
  [96044] = {
    ID = 96044,
    CnID = "战斗场景@蹈海者聚合体BOSS战",
    BaseSortID = 165,
    BattleScene = "Assets/ArtRes/BScene/BScene_CCemeteryDarkBoss.unity"
  },
  [96197] = {
    ID = 96197,
    CnID = "战斗场景@古堡厨房",
    BaseSortID = 166,
    BattleScene = "Assets/ArtRes/BScene/BScene_CastleKitchen.unity"
  },
  [99012] = {
    ID = 99012,
    CnID = "战斗场景@沙滩排球",
    BaseSortID = 167,
    BattleScene = "Assets/ArtRes/BScene/BScene_SandyBeachVolleyball.unity"
  },
  [119065] = {
    ID = 119065,
    CnID = "战斗场景@天之帷幕BOSS战",
    BaseSortID = 168,
    BattleScene = "Assets/ArtRes/BScene/BScene_Fourteenth.unity"
  },
  [130489] = {
    ID = 130489,
    CnID = "战斗场景@暗黑阿拉克涅BOSS战",
    BaseSortID = 169,
    BattleScene = "Assets/ArtRes/BScene/BScene_OperahouseFate1or2.unity"
  },
  [149743] = {
    ID = 149743,
    CnID = "战斗场景@巨噬蠕虫BOSS战",
    BaseSortID = 170,
    BattleScene = "Assets/ArtRes/BScene/BScene_SnowMountaintop2.unity"
  },
  [149745] = {
    ID = 149745,
    CnID = "战斗场景@星辰篇第六章通用",
    BaseSortID = 171,
    BattleScene = "Assets/ArtRes/BScene/BScene_Penitentes.unity"
  }
})
return BattleSceneConfig
