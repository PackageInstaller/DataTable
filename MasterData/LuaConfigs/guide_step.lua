local __rt_1 = {}
local __rt_2 = {1}
local __rt_3 = {1011}
local __rt_4 = {170, 260}
local __rt_5 = {1021}
local __rt_6 = {200, 200}
local guide_step = {
  [100] = {
    condition = 1,
    delay = 0.0,
    guide_skip = false,
    info = 128888,
    info_type = 0,
    step_type = 0,
    wait_target = false
  },
  [101] = {
    delay = 0.0,
    id = 101,
    info_type = 0,
    op_refresh = true,
    target_name = "Down/Btn_Sector",
    target_parent = 1,
    target_type = 1
  },
  [102] = {
    delay = 1.5,
    id = 102,
    info = 251769,
    info_type = 0,
    target_name = "SectorHolder/1",
    target_parent = "shanqu",
    target_type = 2
  },
  [103] = {
    delay = 0.0,
    id = 103,
    info = 289308,
    info_type = 0,
    target_name = "DeploySectorTeam/Btn_Start",
    target_parent = 8,
    target_type = 1
  },
  [201] = {
    condition = 3,
    delay = 0.0,
    guide_skip = false,
    id = 201,
    info = 135197,
    info_type = 0,
    step_type = 0,
    wait_target = false
  },
  [202] = {
    id = 202,
    info = 308335,
    info_type = 0,
    target_name = "return GuideUtil.GetEpFirstRoomTarget()",
    target_type = 3
  },
  [301] = {
    condition = 4,
    id = 301,
    info = 235328,
    info_type = 0,
    target_name = "GameMain/UIRoot/Normal/UI_Battle/Panel_Battle/RightLayout/BattleStart",
    target_type = 2
  },
  [401] = {
    condition = 5,
    delay = 1.2,
    id = 401,
    info_type = 0,
    target_name = "PropHolder/2",
    target_parent = 102,
    target_type = 1
  },
  [402] = {
    condition = 5,
    id = 402,
    info_type = 0,
    target_name = "PropHolder/2/Select",
    target_parent = 102,
    target_type = 1
  },
  [403] = {
    condition = 6,
    delay = 2,
    id = 403,
    info_type = 0,
    target_name = "Btn_Contiune",
    target_parent = 4,
    target_type = 1
  },
  [501] = {
    condition = 1,
    condition_arg = __rt_2,
    delay = 1,
    id = 501,
    info = 3204,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_Exproation/Btn_ContinueEp",
    target_parent = 1,
    target_type = 1
  },
  [600] = {
    condition = 1,
    delay = 0.0,
    guide_skip = false,
    id = 600,
    info = 296206,
    info_type = 0,
    step_type = 0,
    wait_target = false
  },
  [601] = {
    id = 601,
    info = 22181,
    info_type = 0,
    op_refresh = true,
    target_name = "Down/Btn_Oasis",
    target_parent = 1,
    target_type = 1,
    wait_target = false
  },
  [602] = {
    delay = 1.5,
    id = 602,
    info_type = 0,
    target_name = "SidebarButton",
    target_parent = 3,
    target_type = 1
  },
  [603] = {
    delay = 0.8,
    id = 603,
    info = 369299,
    info_type = 0,
    target_name = "BuildingSidebar/Scroll View/Content/1002",
    target_parent = 3,
    target_type = 1
  },
  [604] = {
    delay = 1.2,
    id = 604,
    info_type = 0,
    target_name = "BulidInfoNode/UpgradeInfo/ReadyPage/Btn_Upgrade",
    target_parent = 16,
    target_type = 1
  },
  [605] = {
    delay = 0.8,
    id = 605,
    info_type = 0,
    target_name = "BulidInfoNode/Btn_Close",
    target_parent = 16,
    target_type = 1
  },
  [700] = {
    condition = 1,
    delay = 0.8,
    id = 700,
    info = 257023,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_Exproation",
    target_parent = 1,
    target_type = 1
  },
  [701] = {
    avg_name = "cpt00_tutorial_06",
    delay = 1,
    guide_skip = false,
    id = 701,
    info_type = 0,
    step_type = 2,
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [702] = {
    delay = 0.8,
    id = 702,
    info = 409303,
    target_name = "SectorRoot/UISectorSceneCanvas/SectorNode/1/InfoItem",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [703] = {
    id = 703,
    info = 472043,
    target_name = "return GuideUtil.LocationSectorStageItem(1101)",
    target_type = 3
  },
  [704] = {
    id = 704,
    info = 203610,
    target_name = "DetailNode/Buttom/BtnGroup/Btn_Battle",
    target_parent = 75,
    target_type = 1
  },
  [705] = {
    delay = 1,
    id = 705,
    info = 465031,
    target_name = "NotEditorNode/Btn_Battle",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [800] = {
    avg_name = "cpt00_tutorial_08",
    condition = 3,
    condition_arg = __rt_3,
    guide_skip = false,
    id = 800,
    info_type = 0,
    step_type = 2
  },
  [801] = {
    delay = 0.4,
    id = 801,
    info = 493809,
    target_name = "return GuideUtil.GetEpFirstRoomTarget()",
    target_type = 3
  },
  [900] = {
    condition = 15,
    delay = 0.4,
    id = 900,
    info = 2375,
    step_type = 5,
    target_name = "UINEnemyDetail",
    target_parent = 206,
    target_type = 1
  },
  [901] = {
    delay = 0.4,
    id = 901,
    info = 379486,
    target_name = "Frame/Btn_BattleStart",
    target_type = 2
  },
  [1000] = {
    condition = 5,
    delay = 0.9,
    id = 1000,
    info = 54061,
    target_name = "Frame/PropList/10222/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click",
    target_parent = 102,
    target_type = 1
  },
  [1001] = {
    delay = 0.3,
    id = 1001,
    info = 339215,
    target_name = "Frame/PropList/10222/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click",
    target_parent = 102,
    target_type = 1
  },
  [1101] = {
    condition = 7,
    id = 1101,
    info = 272960,
    target_name = "Frame/TreasureNode/TreasureList/10207/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click",
    target_parent = 130,
    target_type = 1
  },
  [1102] = {
    delay = 0.3,
    id = 1102,
    info = 327201,
    target_name = "Frame/TreasureNode/TreasureList/10207/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click",
    target_parent = 130,
    target_type = 1
  },
  [1200] = {
    avg_name = "cpt00_tutorial_13",
    condition = 3,
    condition_arg = __rt_3,
    delay = 0.0,
    guide_skip = false,
    id = 1200,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [1201] = {
    condition = 8,
    id = 1201,
    info = 495092,
    target_name = "Frame/PageHolder/EventNode/ChoiceList/Rect/1/ItemNode",
    target_parent = 131,
    target_type = 1
  },
  [1202] = {
    condition = 8,
    delay = 0.2,
    id = 1202,
    info = 23311,
    target_name = "Frame/PageHolder/EventNode/ChoiceList/Rect/2/ItemNode",
    target_parent = 131,
    target_type = 1
  },
  [1300] = {
    condition = 9,
    delay = 0.2,
    id = 1300,
    info = 32600,
    target_name = "Top/TopButtonGroup/Btn_Back",
    target_parent = 74,
    target_type = 1
  },
  [1301] = {
    delay = 0.2,
    id = 1301,
    info = 1321,
    target_name = "Top/TopButtonGroup/Btn_Back",
    target_parent = 76,
    target_type = 1
  },
  [1302] = {
    condition = 1,
    delay = 1,
    guide_skip = false,
    id = 1302,
    info = 383124,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_Oasis",
    target_parent = 1,
    target_type = 1
  },
  [1303] = {
    avg_name = "cpt00_tutorial_11",
    guide_skip = false,
    id = 1303,
    info_type = 0,
    step_type = 2
  },
  [1305] = {
    guide_skip = false,
    id = 1305,
    info = 403565,
    target_name = "Btn_Editor",
    target_parent = 1500,
    target_type = 1
  },
  [1306] = {
    guide_skip = false,
    id = 1306,
    info = 464277,
    target_name = "Frame/ScrollRect/Rect/1",
    target_parent = 9,
    target_type = 1
  },
  [1307] = {
    guide_skip = false,
    id = 1307,
    info = 377955,
    target_name = "SelectNode/Editor/Btn_Confirm",
    target_parent = 1500,
    target_type = 1
  },
  [1308] = {
    guide_skip = false,
    id = 1308,
    info = 1503,
    target_name = "TopButtonGroup/Btn_Back",
    target_parent = 2,
    target_type = 1
  },
  [1321] = {
    complete_code = "GuideUtil.CancelReturnHomeCv()",
    condition = 9,
    delay = 0.2,
    guide_skip = false,
    id = 1321,
    info = 169866,
    target_name = "TopButtonGroup/Btn_GoHome",
    target_parent = 2,
    target_type = 1
  },
  [1349] = {
    delay = 0.2,
    id = 1349,
    info = 515774,
    info_pos = "5",
    step_type = 5,
    target_name = "Frame/Scroll",
    target_parent = 3,
    target_type = 1
  },
  [1350] = {
    delay = 0.2,
    id = 1350,
    info = 132820,
    target_name = "TopButtonGroup/Btn_GoHome",
    target_parent = 2,
    target_type = 1
  },
  [1351] = {
    avg_name = "cpt00_e_01_05",
    custom_code = "GuideUtil.UnlockOasisMask()",
    delay = 0.0,
    guide_skip = false,
    id = 1351,
    info_type = 0,
    step_type = 3,
    target_parent = "003_Oasis_001",
    target_type = 2
  },
  [1352] = {
    avg_name = "cpt00_e_01_05",
    custom_code = "GuideUtil.UnlockOasisMask()",
    delay = 0.0,
    guide_skip = false,
    id = 1352,
    info_type = 0,
    step_type = 3,
    target_parent = "003_Oasis_001",
    target_type = 2
  },
  [1353] = {
    complete_code = "GuideUtil.CancelReturnHomeCv()",
    condition = 12,
    delay = 0.2,
    guide_skip = false,
    id = 1353,
    info = 169866,
    target_name = "TopButtonGroup/Btn_GoHome",
    target_parent = 2,
    target_type = 1
  },
  [1400] = {
    condition = 10,
    id = 1400,
    info = 483434,
    target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/DetailItem/Upgraded/But_Accelerate",
    target_parent = 3,
    target_type = 1
  },
  [1401] = {
    id = 1401,
    info = 364964,
    target_name = "QuickUpgraded/Frame/Right/btn_DoComplete",
    target_parent = 3,
    target_type = 1
  },
  [1402] = {
    avg_name = "cpt00_tutorial_16",
    condition = 10,
    delay = 0.0,
    guide_skip = false,
    id = 1402,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [1497] = {
    condition = 10,
    guide_skip = false,
    id = 1497,
    info = 132820,
    target_name = "TopButtonGroup/Btn_GoHome",
    target_parent = 2,
    target_type = 1
  },
  [1498] = {
    delay = 0.2,
    id = 1498,
    info = 202111,
    target_name = "Frame/Scroll/Rect/MAIN SYSTEM/List/1",
    target_parent = 3,
    target_type = 1
  },
  [1500] = {
    condition = 1,
    delay = 0.8,
    id = 1500,
    info = 176166,
    op_refresh = true,
    target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG",
    target_parent = 1,
    target_type = 1
  },
  [1501] = {
    delay = 0.7,
    id = 1501,
    info = 230861,
    target_name = "return GuideUtil.GetHeroListHeroItem(1003,true,false)",
    target_parent = "300",
    target_type = 3
  },
  [1502] = {
    id = 1502,
    info = 81788,
    target_name = "Center/Level/Btn_LevelUp",
    target_parent = 301,
    target_type = 1
  },
  [1503] = {
    delay = 0.7,
    id = 1503,
    info = 74198,
    info_pos = "9",
    step_type = 5,
    target_name = "Detail/LevelNode",
    target_parent = 309,
    target_type = 1
  },
  [1504] = {
    delay = 0.4,
    id = 1504,
    info = 18467,
    info_pos = "2",
    step_type = 5,
    target_name = "Detail/AttriNode",
    target_parent = 309,
    target_type = 1
  },
  [1505] = {
    delay = 0.3,
    id = 1505,
    info = 315654,
    info_pos = "4",
    step_type = 5,
    target_name = "Control/ItemList",
    target_parent = 309,
    target_type = 1
  },
  [1506] = {
    delay = 0.3,
    id = 1506,
    info = 89871,
    target_name = "Control/CanUP/Btn_Confirm",
    target_parent = 309,
    target_type = 1
  },
  [1507] = {
    condition = 24,
    custom_size = __rt_4,
    delay = 0.8,
    id = 1507,
    info = 408649,
    target_name = "return GuideUtil.GetHeroPotentialFmtPlat()",
    target_type = 3
  },
  [1508] = {
    id = 1508,
    info = 74198,
    target_name = "Center/Level/Btn_QuickLevelUp",
    target_parent = 301,
    target_type = 1
  },
  [1509] = {
    id = 1509,
    info = 249080,
    target_name = "Control/CanUP/Btn_Confirm",
    target_parent = 309,
    target_type = 1
  },
  [1598] = {
    condition = 9,
    id = 1598,
    info = 32600,
    target_name = "TopButtonGroup/Btn_GoHome",
    target_parent = 2,
    target_type = 1
  },
  [1599] = {
    delay = 0.8,
    id = 1599,
    info = 176166,
    op_refresh = true,
    target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG",
    target_parent = 1,
    target_type = 1
  },
  [1600] = {
    condition = 11,
    condition_arg = {1, 1102},
    delay = 1,
    guide_skip = false,
    id = 1600,
    info = 20516,
    target_name = "NotEditorNode/Normal/Btn_Editor",
    target_parent = 80,
    target_type = 1
  },
  [1601] = {
    custom_code = "GuideUtil.StartFormationGuide(1021,4)",
    delay = 0.0,
    guide_skip = false,
    id = 1601,
    info = 89076,
    info_pos = "1",
    step_type = 3,
    wait_target = false
  },
  [1602] = {
    custom_code = "GuideUtil.StartFormationGuide(1006,5)",
    delay = 0.0,
    guide_skip = false,
    id = 1602,
    info = 117937,
    info_pos = "1",
    step_type = 3,
    wait_target = false
  },
  [1603] = {
    guide_skip = false,
    id = 1603,
    info = 275402,
    target_name = "EditorNode/Btn_Close",
    target_parent = 80,
    target_type = 1
  },
  [1604] = {
    condition = 11,
    id = 1604,
    info = 422805,
    target_name = "NotEditorNode/Btn_Battle",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [1700] = {
    avg_name = "cpt00_tutorial_12",
    condition = 3,
    condition_arg = __rt_5,
    guide_skip = false,
    id = 1700,
    info_type = 0,
    step_type = 2
  },
  [1800] = {
    avg_name = "cpt00_tutorial_19",
    condition = 4,
    delay = 0.0,
    guide_skip = false,
    id = 1800,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [1801] = {
    delay = 0.4,
    id = 1801,
    info = 475729,
    info_pos = "2",
    target_name = "BattleHolder/FloorTileHolder/(1, 2)",
    target_parent = "006_Arena_003",
    target_type = 2
  },
  [1802] = {
    custom_code = "GuideUtil.StartBattleDeployGuide(1,4,1,2)",
    delay = 0.0,
    guide_skip = false,
    id = 1802,
    info = 46765,
    info_pos = "11",
    step_type = 3,
    wait_target = false
  },
  [1900] = {
    avg_name = "cpt00_tutorial_14",
    condition = 3,
    condition_arg = __rt_5,
    delay = 0.0,
    guide_skip = false,
    id = 1900,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [2000] = {
    condition = 9,
    delay = 0.4,
    guide_skip = false,
    id = 2000,
    info = 226886,
    target_name = "TopButtonGroup/Btn_GoHome",
    target_parent = 2,
    target_type = 1
  },
  [2001] = {
    condition = 1,
    delay = 1,
    id = 2001,
    info = 66471,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_HeroList",
    target_parent = 1,
    target_type = 1
  },
  [2002] = {
    delay = 1,
    id = 2002,
    info = 432054,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_HeroList",
    target_parent = 1,
    target_type = 1
  },
  [2003] = {
    id = 2003,
    info = 389466,
    target_name = "return GuideUtil.GetHeroListHeroItem(1003,true,false)",
    target_parent = "300",
    target_type = 3
  },
  [2004] = {
    id = 2004,
    info = 291158,
    target_name = "Center/Btn_StarUp",
    target_parent = 301,
    target_type = 1
  },
  [2005] = {
    id = 2005,
    info = 445853,
    target_name = "InfoNode/consumeNode/NotFullRank/Btn_StarUp",
    target_parent = 304,
    target_type = 1
  },
  [2006] = {
    delay = 0.2,
    id = 2006,
    info = 132820,
    target_name = "Frame/Scroll/Rect/MAIN SYSTEM/List/1",
    target_parent = 3,
    target_type = 1
  },
  [2100] = {
    avg_name = "cpt00_tutorial_15",
    condition = 3,
    condition_arg = {1031},
    delay = 0.0,
    guide_skip = false,
    id = 2100,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [2200] = {
    condition = 9,
    delay = 0.2,
    id = 2200,
    info = 246488,
    target_name = "Top/TopButtonGroup/Btn_Back",
    target_parent = 74,
    target_type = 1
  },
  [2201] = {
    id = 2201,
    info = 460856,
    target_name = "SectorRoot/UICanvas/ProgressNode/1_1",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [2202] = {
    id = 2202,
    info = 384389,
    target_name = "ConstructionInfo/BuildIngList/202/2003",
    target_parent = 18,
    target_type = 1
  },
  [2203] = {
    id = 2203,
    info = 489732,
    target_name = "QuickUpgraded/3DModifier/Frame/Right/btn_DoComplete",
    target_parent = 18,
    target_type = 1
  },
  [2300] = {
    condition = 1,
    delay = 1,
    id = 2300,
    info = 70662,
    op_refresh = true,
    target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG",
    target_parent = 1,
    target_type = 1
  },
  [2301] = {
    condition = 9,
    delay = 0.2,
    id = 2301,
    info = 367625,
    target_name = "Top/TopButtonGroup/Btn_GoHome",
    target_parent = 74,
    target_type = 1
  },
  [2302] = {
    condition = 14,
    delay = 0.6,
    id = 2302,
    info = 70662,
    op_refresh = true,
    target_name = "Buttom/Detail/HeroSkillList/Btn_Skill",
    target_parent = 301,
    target_type = 1
  },
  [2303] = {
    delay = 1,
    id = 2303,
    info = 222675,
    target_name = "SkillNode/Rect/obj_skillItem2/SkillUpgradeItem",
    target_parent = 306,
    target_type = 1
  },
  [2304] = {
    id = 2304,
    info = 451690,
    step_type = 5,
    target_name = "InfoNode/SkillDetailNode/Scroll/SkillDetaiList",
    target_parent = 306,
    target_type = 1
  },
  [2305] = {
    delay = 1,
    first_code = "GuideManager:AddGuideFeature(1)",
    id = 2305,
    info = 449377,
    target_name = "InfoNode/BottomNode/ItemList/ExtrItem(Clone)/UINBaseItem",
    target_parent = 306,
    target_type = 1
  },
  [2306] = {
    delay = 0.8,
    id = 2306,
    info = 57013,
    target_name = "Frame/Detail/Normal/Layout/List/JumpList/Rect/jumpInfoItem(Clone)/JumpDescrItem(Clone)/Btn_Goto",
    target_parent = 40,
    target_type = 1
  },
  [2401] = {
    condition = 1,
    id = 2401,
    info = 35944,
    target_name = "Main/Left/Btn_Task",
    target_parent = 1,
    target_type = 1
  },
  [2402] = {
    id = 2402,
    info = 229889,
    target_name = "TaskPage/BasePos/TaskListNode/Rect/taskItem0/StepItem/RewardItemList/State/Btn_ItemClick",
    target_parent = 25,
    target_type = 1
  },
  [2501] = {
    condition = 11,
    id = 2501,
    info = 236197,
    target_name = "NotEditorNode/Btn_CommanderSkill",
    target_parent = 80,
    target_type = 1
  },
  [2502] = {
    id = 2502,
    info = 129239,
    info_pos = "2",
    step_type = 5,
    target_name = "SkillNode/SkillList",
    target_parent = 123,
    target_type = 1
  },
  [2503] = {
    delay = 0.3,
    id = 2503,
    info = 266496,
    info_pos = "10",
    step_type = 5,
    target_name = "SkillNode/Passive",
    target_parent = 123,
    target_type = 1
  },
  [2504] = {
    delay = 0.2,
    id = 2504,
    info = 391382,
    step_type = 5,
    target_name = "SkillNode/OverrideNode/OverrideSkill1/Skill/Btn_Root",
    target_parent = 123,
    target_type = 1
  },
  [2505] = {
    delay = 0.2,
    id = 2505,
    info = 159500,
    info_pos = "2",
    target_name = "Btn_TreeLevel",
    target_parent = 123,
    target_type = 1
  },
  [2506] = {
    delay = 0.3,
    id = 2506,
    info = 137854,
    step_type = 5,
    target_name = "CSTLevelUpNode/Frame/Normal/ScrollRect/Rect",
    target_parent = 123,
    target_type = 1
  },
  [2507] = {
    delay = 0.3,
    id = 2507,
    info = 39841,
    target_name = "CSTLevelUpNode/Frame/Info/Cost/List/5005/Btn_Add",
    target_parent = 123,
    target_type = 1
  },
  [2508] = {
    delay = 0.2,
    id = 2508,
    info = 279169,
    target_name = "CSTLevelUpNode/Frame/Normal/Btn_Upgrade",
    target_parent = 123,
    target_type = 1
  },
  [2509] = {
    delay = 0.2,
    id = 2509,
    info = 472837,
    target_name = "CSTLevelUpNode/Frame/Btn_Close",
    target_parent = 123,
    target_type = 1
  },
  [2510] = {
    delay = 0.4,
    id = 2510,
    info = 499143,
    target_name = "SkillNode/OverrideNode/OverrideSkill1/Skill/Btn_Root",
    target_parent = 123,
    target_type = 1
  },
  [2511] = {
    delay = 0.4,
    id = 2511,
    info = 320922,
    step_type = 5,
    target_name = "CSTDetailNode/Buttom",
    target_parent = 123,
    target_type = 1
  },
  [2512] = {
    delay = 0.3,
    id = 2512,
    info = 151119,
    target_name = "CSTDetailNode/Btn_Equip",
    target_parent = 123,
    target_type = 1
  },
  [2513] = {
    delay = 0.3,
    id = 2513,
    info = 299883,
    info_pos = "2",
    step_type = 5,
    target_name = "TreeList",
    target_parent = 123,
    target_type = 1
  },
  [2600] = {
    condition = 14,
    delay = 1,
    id = 2600,
    info = 172366,
    info_pos = "5",
    target_name = "Buttom/Detail/AlgorithmNode",
    target_parent = 301,
    target_type = 1
  },
  [2601] = {
    guide_skip = false,
    id = 2601,
    info = 350016,
    info_pos = "6",
    step_type = 5,
    target_name = "InfoNode/AreaList",
    target_parent = 1000,
    target_type = 1
  },
  [2602] = {
    delay = 0.2,
    guide_skip = false,
    id = 2602,
    info = 145788,
    info_pos = "7",
    step_type = 5,
    target_name = "InfoNode/AreaList",
    target_parent = 1000,
    target_type = 1
  },
  [2603] = {
    delay = 0.3,
    id = 2603,
    info = 28359,
    info_pos = "7",
    target_name = "InfoNode/AreaList/1",
    target_parent = 1000,
    target_type = 1
  },
  [2604] = {
    delay = 0.3,
    guide_skip = false,
    id = 2604,
    info = 135023,
    info_pos = "2",
    step_type = 5,
    target_name = "ATHListNode/List",
    target_parent = 1000,
    target_type = 1
  },
  [2605] = {
    delay = 0.3,
    id = 2605,
    info = 25229,
    target_name = "return GuideUtil.GetSpaceAthByAthList(1)",
    target_type = 3
  },
  [2606] = {
    delay = 0.3,
    id = 2606,
    info = 1834,
    target_name = "ListDetailPos/UINATHDetailItem(Clone)/BtnGroup/Btn_Equip",
    target_parent = 1003,
    target_type = 1
  },
  [2607] = {
    delay = 0.3,
    guide_skip = false,
    id = 2607,
    info = 34349,
    step_type = 5,
    target_name = "InfoNode/AreaList/1",
    target_parent = 1000,
    target_type = 1
  },
  [2608] = {
    delay = 0.3,
    id = 2608,
    info = 241054,
    target_name = "TopButtonGroup/Btn_Back",
    target_parent = 2,
    target_type = 1
  },
  [2609] = {
    delay = 0.2,
    id = 2609,
    info = 109090,
    target_name = "Btn_Efficiency",
    target_parent = 1000,
    target_type = 1
  },
  [2610] = {
    delay = 0.4,
    id = 2610,
    info = 97892,
    info_pos = "2",
    step_type = 5,
    target_name = "ATHListNode",
    target_parent = 1001,
    target_type = 1
  },
  [2611] = {
    delay = 0.4,
    id = 2611,
    info = 297479,
    info_type = 1000,
    step_type = 5,
    target_name = "ATHListNode/List/AreaTogGroup",
    target_parent = 1000,
    target_type = 1
  },
  [2612] = {
    delay = 0.4,
    id = 2612,
    info = 156431,
    info_type = 1000,
    step_type = 5,
    target_name = "InfoNode/Info/Pages",
    target_parent = 1000,
    target_type = 1
  },
  [2613] = {
    delay = 0.4,
    guide_skip = false,
    id = 2613,
    info_type = 0,
    pic_id = 10,
    step_type = 7,
    target_name = "Btn_Efficiency",
    target_parent = 1000,
    target_type = 1
  },
  [2614] = {
    delay = 0.0,
    guide_skip = false,
    id = 2614,
    info_type = 0,
    pic_id = 11,
    step_type = 7,
    wait_target = false
  },
  [2615] = {
    condition = 14,
    delay = 1,
    id = 2615,
    info = 302906,
    info_pos = "5",
    info_type = 1005,
    target_name = "Buttom/Detail/AlgorithmNode",
    target_parent = 301,
    target_type = 1
  },
  [2616] = {
    delay = 0.3,
    id = 2616,
    info = 273985,
    info_pos = "7",
    info_type = 1005,
    target_name = "InfoNode/Btn_Deploy",
    target_parent = 1000,
    target_type = 1
  },
  [2617] = {
    delay = 0.3,
    id = 2617,
    info = 475280,
    info_pos = "13",
    info_type = 1005,
    target_name = "ATHListNode/List/AreaNode/Scroll/Rect/AthGroup(Clone)/1",
    target_parent = 1000,
    target_type = 1
  },
  [2618] = {
    delay = 0.3,
    id = 2618,
    info = 331418,
    info_pos = "7",
    info_type = 1005,
    target_name = "ListDetailPos/UINATHDetailItem(Clone)/BtnGroup/Btn_Link",
    target_parent = 1003,
    target_type = 1
  },
  [2619] = {
    delay = 0.3,
    id = 2619,
    info = 410532,
    info_pos = "7",
    info_type = 1005,
    step_type = 5,
    target_name = "Main/ATHDetailItem/AffixList/AttriItem(Clone)",
    target_parent = 1011,
    target_type = 1
  },
  [2620] = {
    delay = 0.3,
    id = 2620,
    info = 8873,
    info_pos = "7",
    info_type = 1005,
    step_type = 5,
    target_name = "Main/ATHDetailItem/AffixList/Tips",
    target_parent = 1011,
    target_type = 1
  },
  [2621] = {
    delay = 0.3,
    id = 2621,
    info = 482690,
    info_pos = "7",
    info_type = 1005,
    step_type = 5,
    target_name = "Main/ATHDetailItem/ConsumeItem",
    target_parent = 1011,
    target_type = 1
  },
  [2622] = {
    delay = 0.3,
    id = 2622,
    info = 155141,
    info_pos = "9",
    info_type = 1005,
    step_type = 5,
    target_name = "Main/Left",
    target_parent = 1011,
    target_type = 1
  },
  [2623] = {
    delay = 0.3,
    id = 2623,
    info = 159861,
    info_pos = "5",
    info_type = 1005,
    step_type = 5,
    target_name = "Main/ATHDetailItem/Btn_Link",
    target_parent = 1011,
    target_type = 1
  },
  [2701] = {
    condition = 12,
    delay = 0.8,
    first_code = "GuideUtil.SectorForceFocus(22)",
    id = 2701,
    info = 27937,
    info_pos = "8",
    target_name = "Main/PageList/LayoutGroup/pageBtn_3",
    target_type = 2
  },
  [2702] = {
    id = 2702,
    info = 161659,
    target_name = "Main/ResDungeonPage/Scroll/Rect/102",
    target_type = 2
  },
  [2703] = {
    id = 2703,
    info = 523958,
    step_type = 5,
    target_name = "Frontground/Main/HeroList/Rect",
    target_parent = 72,
    target_type = 1
  },
  [2704] = {
    id = 2704,
    info = 218639,
    target_name = "Frontground/Main/StoryDetailNode/2DMaskLayer/LevelRewardNode/Level/01",
    target_parent = 72,
    target_type = 1
  },
  [2705] = {
    id = 2705,
    info = 446662,
    step_type = 5,
    target_name = "Frontground/Main/StoryDetailNode/2DMaskLayer/LevelRewardNode/RewardScroll/RewardRect/NormalReward/ItemWithCount(Clone)/UINBaseItem",
    target_parent = 72,
    target_type = 1
  },
  [2706] = {
    delay = 0.3,
    id = 2706,
    info = 60425,
    step_type = 5,
    target_name = "Frontground/Top/LimitCount",
    target_parent = 72,
    target_type = 1
  },
  [2707] = {
    delay = 0.3,
    id = 2707,
    info = 290564,
    target_name = "Frontground/Main/StoryDetailNode/2DMaskLayer/Btn_Friendship",
    target_parent = 72,
    target_type = 1
  },
  [2708] = {
    delay = 1,
    id = 2708,
    info = 325706,
    step_type = 5,
    target_name = "SkillNode/PresentNode/PresentScroll",
    target_parent = 70,
    target_type = 1
  },
  [2709] = {
    delay = 0.3,
    id = 2709,
    info = 22663,
    step_type = 5,
    target_name = "SkillNode/Scroll/Rect",
    target_parent = 70,
    target_type = 1
  },
  [2801] = {
    condition = 12,
    delay = 0.8,
    first_code = "GuideUtil.SectorForceFocus(11)",
    id = 2801,
    info = 27937,
    target_name = "Main/PageList/LayoutGroup/pageBtn_3",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [2802] = {
    id = 2802,
    info = 105984,
    target_name = "Main/ResDungeonPage/Scroll/Rect/101",
    target_type = 2
  },
  [2803] = {
    id = 2803,
    info = 92242,
    step_type = 5,
    target_name = "Frontground/Main/Scroll/Rect/DungeonList",
    target_parent = 97,
    target_type = 1
  },
  [2804] = {
    delay = 0.3,
    id = 2804,
    info = 306133,
    target_name = "Frontground/Main/Scroll/Rect/DungeonList/DGC GATHERING",
    target_parent = 97,
    target_type = 1
  },
  [2805] = {
    delay = 0.3,
    id = 2805,
    info = 258972,
    target_name = "Frontground/Main/DungeonDetailNode/2DMaskLayer/LevelRewardNode/Level/01",
    target_parent = 97,
    target_type = 1
  },
  [2806] = {
    delay = 0.3,
    guide_skip = false,
    id = 2806,
    info = 232134,
    step_type = 5,
    target_name = "Frontground/Main/DungeonDetailNode/2DMaskLayer/LevelRewardNode/NormalReward",
    target_parent = 97,
    target_type = 1
  },
  [2901] = {
    condition = 9,
    condition_arg = __rt_2,
    delay = 0.3,
    id = 2901,
    info = 255777,
    target_name = "SectorInfoHolder/UI_NormalSectorInfo(Clone)/Btn_DifficultMainHolder/BtnGroup/DiffBtn_normal",
    target_parent = 74,
    target_type = 1
  },
  [2902] = {
    delay = 0.3,
    id = 2902,
    info = 212185,
    target_name = "SectorInfoHolder/UI_NormalSectorInfo(Clone)/Btn_DifficultMainHolder/BtnGroup/DiffcultListHolder/DiffBtn_nightmare",
    target_parent = 74,
    target_type = 1
  },
  [3000] = {
    delay = 0.2,
    id = 3000,
    info = 32600,
    target_name = "TopButtonGroup/Btn_GoHome",
    target_parent = 2,
    target_type = 1
  },
  [3001] = {
    condition = 1,
    delay = 1,
    id = 3001,
    info = 422412,
    op_refresh = true,
    target_name = "Main/Right/PageList/Rect/CenterPage/OasisLayout/Btn_Oasis_BIG",
    target_parent = 1,
    target_type = 1
  },
  [3002] = {
    delay = 1,
    id = 3002,
    info = 275082,
    target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/1003",
    target_parent = 3,
    target_type = 1
  },
  [3003] = {
    id = 3003,
    info = 260478,
    target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/DetailItem/Upgraded/Btn_Upgrade",
    target_parent = 3,
    target_type = 1
  },
  [3200] = {
    condition = 18,
    delay = 0.3,
    id = 3200,
    info = 121048,
    step_type = 5,
    target_name = "StrengthPage/Page/OptimizPage/ATHNode",
    target_parent = 1005,
    target_type = 1
  },
  [3201] = {
    delay = 0.3,
    id = 3201,
    info = 4610,
    target_name = "StrengthPage/Page/OptimizPage/ATHNode/AffixList/1",
    target_parent = 1005,
    target_type = 1
  },
  [3202] = {
    delay = 0.2,
    id = 3202,
    info = 114782,
    step_type = 5,
    target_name = "StrengthPage/Page/OptimizPage/UpgadeNode/Slider",
    target_parent = 1005,
    target_type = 1
  },
  [3203] = {
    delay = 0.2,
    id = 3203,
    info = 159870,
    step_type = 5,
    target_name = "StrengthPage/Page/OptimizPage/UpgadeNode/FailBar",
    target_parent = 1005,
    target_type = 1
  },
  [3204] = {
    delay = 0.3,
    id = 3204,
    info = 280163,
    target_name = "StrengthPage/ToggleGroup/Tog_Dismantle",
    target_parent = 1005,
    target_type = 1
  },
  [3205] = {
    delay = 0.3,
    id = 3205,
    info = 417680,
    info_pos = "2",
    step_type = 5,
    target_name = "ATHListNode",
    target_parent = 1005,
    target_type = 1
  },
  [3300] = {
    delay = 0.2,
    id = 3300,
    info = 147426,
    target_name = "StrengthPage/ToggleGroup/Tog_refactor",
    target_parent = 1005,
    target_type = 1
  },
  [3301] = {
    condition = 18,
    delay = 0.2,
    id = 3301,
    info = 314643,
    step_type = 5,
    target_name = "Frame/ATHDetailItem/AffixList",
    target_parent = 1007,
    target_type = 1,
    wait_target = false
  },
  [3302] = {
    delay = 0.3,
    id = 3302,
    info = 241640,
    step_type = 5,
    target_name = "Frame/ATHDetailItem/AffixList",
    target_parent = 1007,
    target_type = 1
  },
  [3303] = {
    delay = 0.2,
    id = 3303,
    info = 286723,
    step_type = 5,
    target_name = "Frame/LeftArea/Scrollbar",
    target_parent = 1007,
    target_type = 1
  },
  [3304] = {
    delay = 0.2,
    id = 3304,
    info = 39596,
    step_type = 5,
    target_name = "Frame/ATHDetailItem/Btn_Refactor",
    target_parent = 1007,
    target_type = 1
  },
  [3400] = {
    condition = 1,
    delay = 1,
    id = 3400,
    info = 95511,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_openRightSide",
    target_parent = 1,
    target_type = 1
  },
  [3401] = {
    delay = 0.3,
    id = 3401,
    info = 426865,
    target_name = "Right/Mask/PageList/Rect/FactorAndWarehouse/Btn_Factor",
    target_parent = 1,
    target_type = 1
  },
  [3402] = {
    id = 3402,
    info = 218148,
    target_name = "Rooms/Factory_B_002",
    target_parent = "008_Factory_001",
    target_type = 2
  },
  [3403] = {
    delay = 0.3,
    id = 3403,
    info = 411374,
    target_name = "FactoryRomeNode/FactoryRoomFunc/Btn_Production",
    target_parent = 1300,
    target_type = 1
  },
  [3404] = {
    delay = 0.4,
    id = 3404,
    info = 392789,
    target_name = "OrderListNode/FactoryItemList/Rect/FactoryItem(Clone)",
    target_parent = 1300,
    target_type = 1
  },
  [3405] = {
    delay = 0.3,
    id = 3405,
    info = 428559,
    target_name = "FactoryOrderNode/Btn_Add",
    target_parent = 1300,
    target_type = 1
  },
  [3406] = {
    delay = 0.3,
    id = 3406,
    info = 458218,
    step_type = 5,
    target_name = "FactoryOrderNode/Btn_Confirm",
    target_parent = 1300,
    target_type = 1
  },
  [3407] = {
    delay = 0.3,
    id = 3407,
    info = 220086,
    step_type = 5,
    target_name = "FactoryOrderNode/Btn_Quick",
    target_parent = 1300,
    target_type = 1
  },
  [3408] = {
    delay = 0.3,
    id = 3408,
    info = 329462,
    target_name = "OrderListNode/ToggleGroup/Tog_Dig",
    target_parent = 1300,
    target_type = 1
  },
  [3500] = {
    condition = 9,
    delay = 0.2,
    id = 3500,
    info = 426641,
    target_name = "TopButtonGroup/Btn_GoHome",
    target_parent = 2,
    target_type = 1
  },
  [3501] = {
    condition = 1,
    delay = 1,
    id = 3501,
    info = 25282,
    op_refresh = true,
    target_name = "Left/ButtonGroup/Btn_Novice",
    target_parent = 1,
    target_type = 1
  },
  [3502] = {
    delay = 0.8,
    id = 3502,
    info = 368658,
    step_type = 5,
    target_name = "CanvasAdd/TaskNode/Scroll/Rect",
    target_parent = 1600,
    target_type = 1
  },
  [3503] = {
    delay = 0.4,
    id = 3503,
    info = 96250,
    step_type = 5,
    target_name = "CanvasAdd/TaskNode/Reward",
    target_parent = 1600,
    target_type = 1
  },
  [3504] = {
    delay = 0.4,
    id = 3504,
    info = 72511,
    step_type = 5,
    target_name = "CanvasAdd/TitleInfo",
    target_parent = 1600,
    target_type = 1
  },
  [3505] = {
    delay = 0.2,
    id = 3505,
    info = 25320,
    target_name = "Frame/Scroll/Rect/MAIN SYSTEM/List/1",
    target_parent = 3,
    target_type = 1
  },
  [3600] = {
    condition = 4,
    id = 3600,
    info = 141132,
    step_type = 5,
    target_name = "Frame/Tog_Auto",
    target_parent = 204,
    target_type = 1
  },
  [3601] = {
    condition = 4,
    delay = 0.4,
    id = 3601,
    info = 430405,
    step_type = 5,
    target_name = "Frame/Btn_SpeedUP",
    target_parent = 204,
    target_type = 1
  },
  [3700] = {
    condition = 11,
    delay = 0.8,
    id = 3700,
    info = 502295,
    target_name = "Buttom/CampList/Btn_Title",
    target_parent = 80,
    target_type = 1
  },
  [3701] = {
    delay = 0.4,
    id = 3701,
    info = 57282,
    step_type = 5,
    target_name = "Frame/Camp/List",
    target_parent = 83,
    target_type = 1
  },
  [3702] = {
    delay = 0.4,
    id = 3702,
    info = 496198,
    info_pos = "2",
    step_type = 5,
    target_name = "Frame/BondEff/List",
    target_parent = 83,
    target_type = 1
  },
  [3703] = {
    id = 3703,
    info = 335701,
    step_type = 5,
    target_name = "Frame/Camp/List",
    target_parent = 83,
    target_type = 1
  },
  [3800] = {
    condition = 1,
    delay = 1,
    id = 3800,
    info = 55928,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_Exproation",
    target_parent = 1,
    target_type = 1
  },
  [3801] = {
    delay = 1,
    id = 3801,
    info = 150166,
    target_name = "SectorRoot/UISectorSceneCanvas/SectorNode/1/InfoItem",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [3802] = {
    delay = 0.8,
    id = 3802,
    info = 164388,
    target_name = "return GuideUtil.LocationSectorStageItem(1101,true)",
    target_type = 3
  },
  [3803] = {
    delay = 0.6,
    id = 3803,
    info = 275945,
    target_name = "DetailNode/Buttom/BtnGroup/Btn_ViewAvg",
    target_parent = 75,
    target_type = 1
  },
  [3804] = {
    condition = 1,
    delay = 0.6,
    id = 3804,
    info = 136005,
    op_refresh = true,
    target_name = "Main/Right/PageTog/Tog_FuncPageItem2",
    target_parent = 1,
    target_type = 1
  },
  [3900] = {
    condition = 9,
    id = 3900,
    info = 512173,
    target_name = "return GuideUtil.LocationSectorStageItem(1102)",
    target_type = 3
  },
  [3901] = {
    id = 3901,
    info = 518890,
    target_name = "DetailNode/Buttom/BtnGroup/Btn_Battle",
    target_parent = 75,
    target_type = 1
  },
  [3902] = {
    condition = 1,
    delay = 1,
    id = 3902,
    info = 55928,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_Exproation",
    target_parent = 1,
    target_type = 1
  },
  [3903] = {
    delay = 1,
    id = 3903,
    info = 67530,
    target_name = "SectorRoot/UISectorSceneCanvas/SectorNode/1/InfoItem",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [4000] = {
    condition = 9,
    condition_arg = __rt_2,
    delay = 0.3,
    id = 4000,
    info = 65301,
    target_name = "SectorInfoHolder/UI_NormalSectorInfo(Clone)/Btn_DifficultMainHolder/BtnGroup/DiffBtn_normal",
    target_parent = 74,
    target_type = 1
  },
  [4001] = {
    delay = 0.3,
    id = 4001,
    info = 111577,
    target_name = "SectorInfoHolder/UI_NormalSectorInfo(Clone)/Btn_DifficultMainHolder/BtnGroup/DiffcultListHolder/DiffBtn_infinity",
    target_parent = 74,
    target_type = 1
  },
  [4002] = {
    delay = 0.6,
    id = 4002,
    info = 456148,
    info_pos = "2",
    step_type = 5,
    target_name = "DifficultList/UI_SectorLevelInfinityMap(Clone)/UIAdapter/ScrollRect",
    target_parent = 74,
    target_type = 1
  },
  [4003] = {
    avg_name = "cpt00_tutorial_25",
    delay = 0.0,
    guide_skip = false,
    id = 4003,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [4100] = {
    avg_name = "cpt00_tutorial_22",
    condition = 3,
    condition_arg = {1051},
    delay = 0.0,
    guide_skip = false,
    id = 4100,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [4200] = {
    condition = 12,
    delay = 1,
    first_code = "GuideUtil.SectorForceFocus(23)",
    id = 4200,
    info = 27937,
    target_name = "Main/PageList/LayoutGroup/pageBtn_3",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [4201] = {
    id = 4201,
    info = 254674,
    target_name = "Main/ResDungeonPage/Scroll/Rect/301",
    target_type = 2
  },
  [4202] = {
    id = 4202,
    info = 390703,
    step_type = 5,
    target_name = "LevelNode/DailyNode",
    target_parent = 1950,
    target_type = 1
  },
  [4203] = {
    delay = 0.4,
    id = 4203,
    info = 130187,
    step_type = 5,
    target_name = "Btn_WeeklyShop",
    target_parent = 1950,
    target_type = 1
  },
  [4204] = {
    delay = 0.4,
    id = 4204,
    info = 112737,
    target_name = "LevelNode/DailyNode",
    target_parent = 1950,
    target_type = 1
  },
  [4205] = {
    delay = 0.3,
    id = 4205,
    info = 44123,
    target_name = "DetailNode/Buttom/BtnGroup/Btn_Battle",
    target_parent = 75,
    target_type = 1
  },
  [4206] = {
    custom_size = __rt_4,
    id = 4206,
    info = 382706,
    target_name = "Formation(Clone)/Scene/BasePlatform1",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [4207] = {
    id = 4207,
    info = 162962,
    info_pos = "4",
    step_type = 5,
    target_name = "Right/HeroList/Rect",
    target_parent = 82,
    target_type = 1
  },
  [4300] = {
    condition = 12,
    delay = 1,
    id = 4300,
    info = 320902,
    target_name = "Main/SectorPage/LayoutGroup/Btn_StrategyOverview",
    target_parent = 76,
    target_type = 1
  },
  [4301] = {
    id = 4301,
    info = 516893,
    step_type = 5,
    target_name = "StOList/Rect/Unlock/ChessLayout/1",
    target_parent = 1400,
    target_type = 1
  },
  [4302] = {
    delay = 0.3,
    id = 4302,
    info = 192912,
    step_type = 5,
    target_name = "Side/Down",
    target_parent = 1400,
    target_type = 1
  },
  [4303] = {
    delay = 0.3,
    id = 4303,
    info = 424417,
    step_type = 5,
    target_name = "Side/Down",
    target_parent = 1400,
    target_type = 1
  },
  [4304] = {
    delay = 0.3,
    id = 4304,
    info = 335697,
    step_type = 5,
    target_name = "Side/SkillInfo",
    target_parent = 1400,
    target_type = 1
  },
  [4305] = {
    delay = 0.3,
    id = 4305,
    info = 219478,
    target_name = "Side/Down/Consume/Btn_Upgrade",
    target_parent = 1400,
    target_type = 1
  },
  [4400] = {
    condition = 1,
    delay = 0.6,
    id = 4400,
    info = 254729,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_Shop",
    target_parent = 1,
    target_type = 1
  },
  [4401] = {
    after_code = "GuideUtil.SetGuideShopHeroActive(false)",
    avg_name = "cpt00_tutorial_23",
    clear_code = "GuideUtil.SetGuideShopHeroActive(true)",
    delay = 0.0,
    guide_skip = false,
    id = 4401,
    info_type = 0,
    step_type = 2,
    target_parent = 1800,
    target_type = 1
  },
  [4402] = {
    delay = 0.4,
    id = 4402,
    info = 103794,
    target_name = "pageButtonList/Layout/Scroll/Rect/403",
    target_parent = 1800,
    target_type = 1
  },
  [4403] = {
    delay = 1,
    id = 4403,
    info = 303401,
    info_pos = "2",
    step_type = 5,
    target_name = "PageHolder/UI_ShopNormal/ShopItemList/Rect",
    target_parent = 1800,
    target_type = 1
  },
  [4404] = {
    delay = 0.4,
    id = 4404,
    info = 299566,
    target_name = "PageHolder/UI_ShopNormal/ShopItemList/Rect/ShopItem(Clone)",
    target_parent = 1800,
    target_type = 1
  },
  [4405] = {
    delay = 0.4,
    id = 4405,
    info = 273135,
    step_type = 5,
    target_name = "Side/GameResourceGroup/1006",
    target_parent = 30,
    target_type = 1
  },
  [4500] = {
    avg_name = "cpt00_tutorial_24",
    condition = 9,
    delay = 0.0,
    guide_skip = false,
    id = 4500,
    info = 261934,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [4501] = {
    id = 4501,
    info = 60020,
    target_name = "TopButtonGroup/Btn_OpenNavigation",
    target_parent = 2,
    target_type = 1
  },
  [4502] = {
    delay = 0.8,
    id = 4502,
    info = 96184,
    info_pos = "2",
    step_type = 5,
    target_name = "Go_NavigationParent/UI_NavigationBar/Frame/Scroll/Rect",
    target_parent = 2,
    target_type = 1
  },
  [4503] = {
    delay = 0.3,
    id = 4503,
    info = 2457,
    target_name = "Go_NavigationParent/UI_NavigationBar/Frame/Scroll/Rect/MAIN SYSTEM/List/3",
    target_parent = 2,
    target_type = 1
  },
  [4601] = {
    condition = 19,
    delay = 0.4,
    id = 4601,
    info = 391294,
    step_type = 5,
    target_name = "return GuideUtil.GetEpCuroomTarget()",
    target_type = 3
  },
  [4701] = {
    condition = 4,
    custom_code = "GuideUtil.StartBattleDeployClickGuide(100,0)",
    delay = 0.0,
    id = 4701,
    info = 429065,
    info_pos = "4",
    step_type = 3,
    wait_target = false
  },
  [4702] = {
    delay = 0,
    id = 4702,
    info = 296515,
    step_type = 5,
    target_name = "BattleGirdInfoNode",
    target_parent = 212,
    target_type = 1
  },
  [4801] = {
    condition = 8,
    delay = 0.3,
    id = 4801,
    info = 453432,
    target_name = "Frame/PageHolder/EventNode/ChoiceList/Rect/1/ItemNode",
    target_parent = 131,
    target_type = 1
  },
  [4802] = {
    delay = 0.3,
    id = 4802,
    info = 58774,
    target_name = "Frame/ScrollRect/Rect/SupportList/SupportList/1/HeroHeadItem",
    target_parent = 135,
    target_type = 1
  },
  [4803] = {
    delay = 0.4,
    id = 4803,
    info = 493135,
    step_type = 5,
    target_name = "Frame/ScrollRect/Rect/HeroList/CurrentList",
    target_parent = 135,
    target_type = 1
  },
  [4901] = {
    condition = 20,
    id = 4901,
    info = 390090,
    info_pos = "2",
    step_type = 5,
    target_name = "Frame/RewardNode",
    target_parent = 141,
    target_type = 1
  },
  [4902] = {
    delay = 0.3,
    guide_skip = false,
    id = 4902,
    info = 503191,
    step_type = 5,
    target_name = "Frame/RewardNode/RewardList/Scroll/Rect/RewardBagItem(Clone)/Selecttable",
    target_parent = 141,
    target_type = 1
  },
  [4903] = {
    delay = 0.3,
    id = 4903,
    info = 123260,
    step_type = 5,
    target_name = "Frame/Btn_Close",
    target_parent = 141,
    target_type = 1
  },
  [4904] = {
    delay = 0.3,
    id = 4904,
    info = 2003,
    step_type = 5,
    target_name = "Frame/Btn_Get",
    target_parent = 141,
    target_type = 1
  },
  [5001] = {
    condition = 3,
    condition_arg = {1041},
    delay = 0.3,
    id = 5001,
    info = 316542,
    target_name = "Frame/ChipSuitNode/Brief/Scroll View/Viewport/List/4",
    target_parent = 101,
    target_type = 1
  },
  [5002] = {
    delay = 0.3,
    id = 5002,
    info = 307143,
    step_type = 5,
    target_name = "Detail/Frame/SuitInfo",
    target_parent = 144,
    target_type = 1
  },
  [5003] = {
    delay = 0.3,
    id = 5003,
    info = 271100,
    step_type = 5,
    target_name = "Detail/Frame/SuitInfo/Scroll/Rect",
    target_parent = 144,
    target_type = 1
  },
  [5004] = {
    delay = 0.3,
    id = 5004,
    info = 169544,
    step_type = 5,
    target_name = "Detail/Frame/SuitInfo/ChipList",
    target_parent = 144,
    target_type = 1
  },
  [5100] = {
    condition = 4,
    custom_code = "GuideUtil.StartBattleDeployClickGuide(100,GuideUtil.GetBestBenchRoleY())",
    id = 5100,
    info = 461839,
    info_pos = "12",
    step_type = 3,
    wait_target = false
  },
  [5200] = {
    condition = 23,
    delay = 0.3,
    id = 5200,
    info = 271706,
    step_type = 5,
    target_name = "Frame/UI_EpShopNode/BuyList/Rect",
    target_parent = 109,
    target_type = 1
  },
  [5201] = {
    delay = 0.3,
    id = 5201,
    info = 238252,
    step_type = 5,
    target_name = "Frame/UI_EpShopNode/btn_Refresh",
    target_parent = 109,
    target_type = 1
  },
  [5202] = {
    delay = 0.3,
    id = 5202,
    info = 32889,
    step_type = 5,
    target_name = "Frame/UI_EpShopNode/TradeTypeTile/Btn_SellTypeItem",
    target_parent = 109,
    target_type = 1
  },
  [5300] = {
    condition = 22,
    delay = 0.6,
    id = 5300,
    info = 353172,
    step_type = 5,
    target_name = "Frame/FailureNode/Suggest/SuggestBtn/Btn_GotoLevelUpItem",
    target_parent = 6,
    target_type = 1
  },
  [5301] = {
    delay = 0.3,
    id = 5301,
    info = 433603,
    target_name = "Frame/FailureNode/Suggest/SuggestBtn/Btn_GotoLevelUpItem",
    target_parent = 6,
    target_type = 1
  },
  [5302] = {
    id = 5302,
    info = 37314,
    target_name = "return GuideUtil.GetHeroListHeroItem(1005,true,false)",
    target_parent = "300",
    target_type = 3
  },
  [5303] = {
    delay = 0.4,
    id = 5303,
    info = 385925,
    step_type = 5,
    target_name = "Center/Level",
    target_parent = 301,
    target_type = 1
  },
  [5304] = {
    delay = 0.3,
    id = 5304,
    info = 302518,
    step_type = 5,
    target_name = "Center/Btn_StarUp",
    target_parent = 301,
    target_type = 1
  },
  [5400] = {
    condition = 11,
    condition_arg = {7},
    id = 5400,
    info = 36348,
    target_name = "NotEditorNode/DebuffSelect/Btn_Layer",
    target_parent = 80,
    target_type = 1
  },
  [5500] = {
    condition = 3,
    condition_arg = {0, 1},
    id = 5500,
    info = 58509,
    target_name = "Frame/AutoModuleNode/Btn_AutoModule",
    target_parent = 101,
    target_type = 1
  },
  [5501] = {
    id = 5501,
    info = 82667,
    step_type = 5,
    target_name = "Frame/AutoModuleNode/Btn_StartAuto",
    target_parent = 101,
    target_type = 1
  },
  [5600] = {
    condition = 24,
    condition_arg = __rt_2,
    id = 5600,
    info = 237810,
    target_name = "return GuideUtil.GetHeroQuickLevelUpFmtPlat()",
    target_type = 3
  },
  [5701] = {
    condition = 11,
    condition_arg = {1, 1103},
    id = 5701,
    info = 236197,
    target_name = "NotEditorNode/Btn_CommanderSkill",
    target_parent = 80,
    target_type = 1
  },
  [5702] = {
    id = 5702,
    info = 286386,
    info_pos = "2",
    step_type = 5,
    target_name = "SkillNode/SkillList",
    target_parent = 123,
    target_type = 1
  },
  [5703] = {
    delay = 0.2,
    id = 5703,
    info = 74640,
    step_type = 5,
    target_name = "SkillNode/OverrideNode/OverrideSkill1/Skill/Btn_Root",
    target_parent = 123,
    target_type = 1
  },
  [5704] = {
    delay = 0.4,
    id = 5704,
    info = 147289,
    target_name = "SkillNode/OverrideNode/OverrideSkill1/Skill/Btn_Root",
    target_parent = 123,
    target_type = 1
  },
  [5705] = {
    delay = 0.3,
    id = 5705,
    info = 151119,
    target_name = "CSTDetailNode/Btn_Equip",
    target_parent = 123,
    target_type = 1
  },
  [5706] = {
    delay = 0.3,
    id = 5706,
    info = 299883,
    info_pos = "2",
    step_type = 5,
    target_name = "TreeList",
    target_parent = 123,
    target_type = 1
  },
  [5707] = {
    delay = 0.3,
    id = 5707,
    info = 215768,
    step_type = 5,
    target_name = "CSTDetailNode",
    target_parent = 123,
    target_type = 1
  },
  [5800] = {
    condition = 1,
    delay = 0.4,
    id = 5800,
    info = 421941,
    target_name = "Right/Mask/PageList/Rect/Btn_Dorm",
    target_parent = 1,
    target_type = 1
  },
  [5801] = {
    delay = 1.5,
    id = 5801,
    info = 312548,
    info_pos = "2",
    step_type = 5,
    target_name = "StateNode",
    target_parent = 62,
    target_type = 1
  },
  [5802] = {
    delay = 0.3,
    id = 5802,
    info = 145847,
    step_type = 5,
    target_name = "MainNode/Btn_Buy",
    target_parent = 62,
    target_type = 1
  },
  [5803] = {
    id = 5803,
    info = 489211,
    target_name = "BaseNode/Btn_Comfort",
    target_parent = 62,
    target_type = 1
  },
  [5804] = {
    id = 5804,
    info = 503963,
    info_pos = "2",
    step_type = 5,
    target_name = "Frame/ComfortInfo/Scroll",
    target_parent = 66,
    target_type = 1
  },
  [5805] = {
    delay = 0.3,
    id = 5805,
    info = 146714,
    target_name = "Frame/Btn_Close",
    target_parent = 66,
    target_type = 1
  },
  [5806] = {
    id = 5806,
    info = 210867,
    target_name = "DormHolder/-1_0",
    target_parent = "004_Interior_001",
    target_type = 2
  },
  [5807] = {
    id = 5807,
    info = 111441,
    step_type = 5,
    target_name = "Joystick",
    target_parent = 63,
    target_type = 1
  },
  [5808] = {
    delay = 0.3,
    id = 5808,
    info = 473506,
    step_type = 5,
    target_name = "BtnGroup/Btn_Hero",
    target_parent = 63,
    target_type = 1
  },
  [5809] = {
    delay = 0.4,
    id = 5809,
    info = 239299,
    step_type = 5,
    target_name = "BtnGroup/Btn_Edit",
    target_parent = 63,
    target_type = 1
  },
  [5900] = {
    condition = 12,
    delay = 0.3,
    id = 5900,
    info = 257124,
    target_name = "Main/SectorPage/LayoutGroup/Btn_StrategyOverview",
    target_parent = 76,
    target_type = 1
  },
  [5901] = {
    id = 5901,
    info = 106993,
    target_name = "ToogleGroup/Tog_GotoCareer",
    target_parent = 1400,
    target_type = 1
  },
  [5902] = {
    id = 5902,
    info = 498961,
    info_pos = "2",
    step_type = 5,
    target_name = "CareerList/Head",
    target_parent = 1400,
    target_type = 1
  },
  [5903] = {
    id = 5903,
    info = 44240,
    step_type = 5,
    target_name = "Side/Down/Consume/Btn_Upgrade",
    target_parent = 1400,
    target_type = 1
  },
  [6000] = {
    condition = 12,
    condition_arg = __rt_2,
    delay = 1,
    first_code = "GuideUtil.SectorForceFocus(23)",
    id = 6000,
    info = 27937,
    target_name = "Main/PageList/LayoutGroup/pageBtn_3",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [6001] = {
    delay = 0.8,
    id = 6001,
    info = 162580,
    target_name = "Main/ResDungeonPage/Scroll/Rect/201",
    target_type = 2
  },
  [6002] = {
    delay = 0.8,
    id = 6002,
    info = 248433,
    step_type = 5,
    target_name = "Tex_DungeonName",
    target_parent = 2200,
    target_type = 1
  },
  [6003] = {
    delay = 0.4,
    id = 6003,
    info = 229002,
    step_type = 5,
    target_name = "RefreshTime",
    target_parent = 2200,
    target_type = 1
  },
  [6004] = {
    delay = 0.4,
    id = 6004,
    info = 124586,
    step_type = 5,
    target_name = "Btn_Shop",
    target_parent = 2200,
    target_type = 1
  },
  [6005] = {
    id = 6005,
    info = 199579,
    target_name = "LevelScroll/LevelGroup/1/bg/Buttom",
    target_parent = 2200,
    target_type = 1
  },
  [6006] = {
    id = 6006,
    info = 415687,
    target_name = "LevelScroll/Rect/0/LevelItem(Clone)",
    target_parent = 2201,
    target_type = 1
  },
  [6007] = {
    id = 6007,
    info = 74139,
    target_name = "Frame/YesNoNode/ButtonYes",
    target_parent = 1200,
    target_type = 1
  },
  [6008] = {
    guide_skip = false,
    id = 6008,
    info_type = 0,
    pic_id = 7,
    step_type = 7,
    target_name = "RoomMap",
    target_parent = "006_Arena_000",
    target_type = 2
  },
  [6009] = {
    id = 6009,
    info = 340845,
    target_name = "Top/ChipList/Btn_ChipSuitSelect",
    target_parent = 210,
    target_type = 1
  },
  [6010] = {
    id = 6010,
    info = 200356,
    step_type = 5,
    target_name = "Frame/SuitScroll/Rect",
    target_parent = 213,
    target_type = 1
  },
  [6011] = {
    id = 6011,
    info = 268034,
    step_type = 5,
    target_name = "Frame/SuitDetailScroll/Rect/SuitDetail(Clone)",
    target_parent = 213,
    target_type = 1
  },
  [6012] = {
    id = 6012,
    info = 456477,
    step_type = 5,
    target_name = "Frame/Btn_Confirm",
    target_parent = 213,
    target_type = 1
  },
  [6100] = {
    condition = 11,
    condition_arg = {1, 1111},
    id = 6100,
    info = 496594,
    target_name = "NotEditorNode/BtnLayout/Btn_Editor",
    target_parent = 80,
    target_type = 1
  },
  [6101] = {
    id = 6101,
    info = 371974,
    target_name = "EditorNode/Layout/SupportHolder/SupportHeroCardItem/Img_Support",
    target_parent = 80,
    target_type = 1
  },
  [6102] = {
    delay = 0.4,
    guide_skip = false,
    id = 6102,
    info_type = 0,
    pic_id = 6,
    step_type = 7,
    target_name = "PageList",
    target_parent = 503,
    target_type = 1
  },
  [6200] = {
    condition = 1,
    delay = 0.4,
    id = 6200,
    info = 421941,
    target_name = "Right/Mask/PageList/Rect/Btn_Dorm",
    target_parent = 1,
    target_type = 1
  },
  [6201] = {
    guide_skip = false,
    id = 6201,
    info_type = 0,
    pic_id = 8,
    step_type = 7,
    target_name = "ViewNode/MainNode/Btn_Editor",
    target_parent = 62,
    target_type = 1
  },
  [6202] = {
    id = 6202,
    info = 210867,
    target_name = "DormHolder/-1_0",
    target_parent = "004_Interior_001",
    target_type = 2
  },
  [6203] = {
    guide_skip = false,
    id = 6203,
    info_type = 0,
    pic_id = 9,
    step_type = 7,
    target_name = "BaseNode",
    target_parent = 63,
    target_type = 1
  },
  [6300] = {
    delay = 0.0,
    guide_skip = false,
    id = 6300,
    info_type = 0,
    pic_id = 12,
    step_type = 7,
    wait_target = false
  },
  [6500] = {
    condition = 12,
    id = 6500,
    info = 12187,
    target_name = "Main/PageList/LayoutGroup/pageBtn_4",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [6501] = {
    first_code = "GuideUtil.SectorForceFocus(27)",
    guide_skip = false,
    id = 6501,
    info_type = 0,
    target_name = "Main/ChallengePage/Scroll/Rect/401",
    target_type = 2
  },
  [6502] = {
    avg_name = "cpt_inner",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 6502,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [6503] = {
    guide_skip = false,
    id = 6503,
    info_type = 0,
    pic_id = 14,
    step_type = 7,
    target_name = "Frame/Main/ScrollRect/Rect/TowerItem(Clone)/TowerItem/InfoHolder/TowerInfo",
    target_parent = 801,
    target_type = 1
  },
  [6504] = {
    id = 6504,
    info = 146671,
    target_name = "Main/Btn_Jump",
    target_parent = 804,
    target_type = 1
  },
  [6600] = {
    condition = 26,
    guide_skip = false,
    id = 6600,
    info_type = 0,
    pic_id = 15,
    step_type = 7,
    target_name = "Frame/InfoNode/Btn_Challenge/Buttom",
    target_parent = 1622,
    target_type = 1
  },
  [6700] = {
    condition = 27,
    guide_skip = false,
    id = 6700,
    info_type = 0,
    pic_id = 16,
    step_type = 7,
    target_name = "MainCanvas/Btn_Info",
    target_parent = 1641,
    target_type = 1
  },
  [6800] = {
    condition = 28,
    guide_skip = false,
    id = 6800,
    info_type = 0,
    pic_id = 18,
    step_type = 7,
    target_name = "Main/BtnList/Btn_Shop",
    target_parent = 1661,
    target_type = 1
  },
  [6900] = {
    condition = 1,
    id = 6900,
    info = 348622,
    info_type = 1005,
    step_type = 5,
    target_name = "Right/Mask/PageList/Rect/Btn_HeroList",
    target_parent = 1,
    target_type = 1
  },
  [6901] = {
    clear_code = "GuideUtil.SetHomeHandBookState(true)",
    complete_code = "GuideUtil.SetHomeHandBookState(true)",
    first_code = "GuideUtil.SetHomeHandBookState(false)",
    id = 6901,
    info = 348229,
    info_type = 1005,
    target_name = "Right/Mask/PageList/Rect/Btn_HeroList",
    target_parent = 1,
    target_type = 1
  },
  [6902] = {
    delay = 0.7,
    id = 6902,
    info = 276858,
    info_type = 1005,
    target_name = "return GuideUtil.GetHeroListHeroItem(1019,true,false)",
    target_parent = "300",
    target_type = 3
  },
  [6903] = {
    id = 6903,
    info = 249437,
    info_type = 1005,
    target_name = "Center/Btn_Arma",
    target_parent = 301,
    target_type = 1
  },
  [6904] = {
    id = 6904,
    info = 326430,
    info_type = 1005,
    step_type = 5,
    target_name = "Main/img_Breakthroughlv2/Image",
    target_parent = 317,
    target_type = 1
  },
  [6905] = {
    id = 6905,
    info = 275453,
    info_type = 1005,
    step_type = 5,
    target_name = "Main/Img_Center/CenterFrame",
    target_parent = 317,
    target_type = 1
  },
  [6906] = {
    id = 6906,
    info = 60559,
    info_type = 1005,
    step_type = 5,
    target_name = "Main/img_Breakthroughlv1/Image (2)",
    target_parent = 317,
    target_type = 1
  },
  [6907] = {
    id = 6907,
    info = 282484,
    info_type = 1005,
    target_name = "Main/Img_Center/CenterFrame",
    target_parent = 317,
    target_type = 1
  },
  [6908] = {
    id = 6908,
    info = 27085,
    info_type = 1005,
    step_type = 5,
    target_name = "RightArea/ContentArea/BreakthroughAction",
    target_parent = 317,
    target_type = 1
  },
  [6909] = {
    id = 6909,
    info = 326665,
    info_type = 1005,
    step_type = 5,
    target_name = "RightArea/ContentArea/UnlockAction",
    target_parent = 317,
    target_type = 1
  },
  [6910] = {
    id = 6910,
    info = 517089,
    info_type = 1005,
    step_type = 5,
    target_name = "RightArea/ContentArea/CostArea",
    target_parent = 317,
    target_type = 1
  },
  [6911] = {
    id = 6911,
    info = 88195,
    info_type = 1005,
    step_type = 5,
    target_name = "RightArea/BtnGroup",
    target_parent = 317,
    target_type = 1
  },
  [7000] = {
    condition = 33,
    condition_arg = __rt_2,
    id = 7000,
    info = 253870,
    step_type = 5,
    target_name = "InfoNode/RealDailyInfoHolder",
    target_parent = 1950,
    target_type = 1
  },
  [10001] = {
    condition = 12,
    id = 10001,
    info = 32294,
    target_name = "SectorRoot/UISectorSceneCanvas/Btn_STNewbee",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [10002] = {
    id = 10002,
    info = 51913,
    target_name = "return GuideUtil.LocationSectorStageItem(100102)",
    target_type = 3
  },
  [10003] = {
    id = 10003,
    info = 118059,
    target_name = "DetailNode/Buttom/BtnGroup/Btn_Battle",
    target_parent = 75,
    target_type = 1
  },
  [10004] = {
    id = 10004,
    info = 483206,
    target_name = "NotEditorNode/BtnLayout/Btn_Battle",
    target_parent = 80,
    target_type = 1
  },
  [10005] = {
    id = 10005,
    info = 350601,
    step_type = 5,
    target_name = "DetailNode/Detail/NormalNode/RewardRank/Reward/Rect/NormalList/RewardItem(Clone)/UINBaseItem",
    target_parent = 75,
    target_type = 1
  },
  [10101] = {
    avg_name = "101",
    avg_skip = true,
    condition = 12,
    delay = 0.0,
    guide_skip = false,
    id = 10101,
    info_type = 0,
    step_type = 6,
    wait_target = false
  },
  [10201] = {
    condition = 9,
    id = 10201,
    info = 13863,
    target_name = "return GuideUtil.LocationSectorStageItem(100103)",
    target_type = 3
  },
  [10202] = {
    id = 10202,
    info = 118059,
    target_name = "DetailNode/Buttom/BtnGroup/Btn_Battle",
    target_parent = 75,
    target_type = 1
  },
  [10203] = {
    id = 10203,
    info = 269840,
    target_name = "NotEditorNode/BtnLayout/Btn_Battle",
    target_parent = 80,
    target_type = 1
  },
  [10301] = {
    condition = 9,
    id = 10301,
    info = 13863,
    target_name = "return GuideUtil.LocationSectorStageItem(100104)",
    target_type = 3
  },
  [10302] = {
    id = 10302,
    info = 118059,
    target_name = "DetailNode/Buttom/BtnGroup/Btn_Battle",
    target_parent = 75,
    target_type = 1
  },
  [10303] = {
    id = 10303,
    info = 269840,
    target_name = "NotEditorNode/BtnLayout/Btn_Battle",
    target_parent = 80,
    target_type = 1
  },
  [10401] = {
    avg_name = "102",
    avg_skip = true,
    condition = 9,
    delay = 0.0,
    guide_skip = false,
    id = 10401,
    info_type = 0,
    step_type = 6,
    wait_target = false
  },
  [10501] = {
    condition = 9,
    condition_arg = __rt_2,
    id = 10501,
    info = 13863,
    target_name = "return GuideUtil.LocationSectorStageItem(100105)",
    target_type = 3
  },
  [10502] = {
    id = 10502,
    info = 118059,
    target_name = "DetailNode/Buttom/BtnGroup/Btn_Battle",
    target_parent = 75,
    target_type = 1
  },
  [10503] = {
    id = 10503,
    info = 269840,
    target_name = "NotEditorNode/BtnLayout/Btn_Battle",
    target_parent = 80,
    target_type = 1
  },
  [10504] = {
    condition = 9,
    id = 10504,
    info = 362122,
    target_name = "DetailNode/Buttom/BtnGroup/Btn_Battle",
    target_parent = 75,
    target_type = 1
  },
  [10601] = {
    avg_name = "103",
    avg_skip = true,
    condition = 9,
    delay = 0.0,
    guide_skip = false,
    id = 10601,
    info_type = 0,
    step_type = 6,
    wait_target = false
  },
  [10701] = {
    avg_name = "cpt00_tutorial_06",
    delay = 1,
    first_code = "GuideUtil.SectorForceFocus(10)",
    guide_skip = false,
    id = 10701,
    info_type = 0,
    step_type = 2,
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [10702] = {
    delay = 0.8,
    id = 10702,
    info = 409303,
    target_name = "SectorRoot/UISectorSceneCanvas/SectorNode/1/InfoItem",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [10703] = {
    id = 10703,
    info = 472043,
    target_name = "return GuideUtil.LocationSectorStageItem(1101)",
    target_type = 3
  },
  [10704] = {
    id = 10704,
    info = 203610,
    target_name = "DetailNode/Buttom/BtnGroup/Btn_Battle",
    target_parent = 75,
    target_type = 1
  },
  [10801] = {
    condition = 11,
    condition_arg = {1, 1101},
    delay = 1,
    guide_skip = false,
    id = 10801,
    info = 20516,
    target_name = "NotEditorNode/BtnLayout/Btn_Editor",
    target_parent = 80,
    target_type = 1
  },
  [10802] = {
    custom_code = "GuideUtil.StartFormationGuide(1009,4)",
    delay = 0.0,
    guide_skip = false,
    id = 10802,
    info = 284307,
    info_pos = "1",
    step_type = 3,
    wait_target = false
  },
  [10803] = {
    custom_code = "GuideUtil.StartFormationGuide(1006,5)",
    delay = 0.0,
    guide_skip = false,
    id = 10803,
    info = 117937,
    info_pos = "1",
    step_type = 3,
    wait_target = false
  },
  [10804] = {
    guide_skip = false,
    id = 10804,
    info = 275402,
    target_name = "EditorNode/Btn_Close",
    target_parent = 80,
    target_type = 1
  },
  [10901] = {
    condition = 9,
    id = 10901,
    info = 60020,
    target_name = "TopButtonGroup/Btn_OpenNavigation",
    target_parent = 2,
    target_type = 1
  },
  [10902] = {
    delay = 0.8,
    id = 10902,
    info = 96184,
    info_pos = "2",
    step_type = 5,
    target_name = "Go_NavigationParent/UI_NavigationBar/Frame/Scroll/Rect",
    target_parent = 2,
    target_type = 1
  },
  [10903] = {
    delay = 0.3,
    id = 10903,
    info = 215116,
    target_name = "Go_NavigationParent/UI_NavigationBar/Frame/Scroll/Rect/MAIN SYSTEM/List/2",
    target_parent = 2,
    target_type = 1
  },
  [10904] = {
    delay = 0.0,
    guide_skip = false,
    id = 10904,
    info_type = 0,
    step_type = 0,
    wait_target = false
  },
  [10905] = {
    delay = 1,
    id = 10905,
    info = 432054,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_HeroList",
    target_parent = 1,
    target_type = 1
  },
  [10906] = {
    id = 10906,
    info = 389466,
    target_name = "return GuideUtil.GetHeroListHeroItem(1003,true,false)",
    target_parent = "300",
    target_type = 3
  },
  [10907] = {
    id = 10907,
    info = 291158,
    target_name = "Center/Btn_StarUp",
    target_parent = 301,
    target_type = 1
  },
  [10908] = {
    id = 10908,
    info = 445853,
    target_name = "InfoNode/consumeNode/NotFullRank/Btn_StarUp",
    target_parent = 304,
    target_type = 1
  },
  [10909] = {
    condition = 1,
    delay = 1,
    id = 10909,
    info = 66471,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_HeroList",
    target_parent = 1,
    target_type = 1
  },
  [11101] = {
    condition = 25,
    delay = 0.3,
    id = 11101,
    info = 11272,
    step_type = 5,
    target_name = "return GuideUtil.GetLotteryFragChangeUI()",
    target_type = 3
  },
  [11201] = {
    avg_name = "cpt00_e_01_06",
    avg_skip = true,
    condition = 1,
    delay = 0.1,
    id = 11201,
    info_type = 0,
    step_type = 2
  },
  [11300] = {
    condition = 9,
    delay = 0.8,
    id = 11300,
    info = 164388,
    target_name = "return GuideUtil.LocationSectorStageItem(1101,true)",
    target_type = 3
  },
  [11301] = {
    delay = 0.6,
    id = 11301,
    info = 275945,
    target_name = "DetailNode/Buttom/BtnGroup/Btn_ViewAvg",
    target_parent = 75,
    target_type = 1
  },
  [11601] = {
    avg_name = "103",
    avg_skip = true,
    condition = 12,
    delay = 0.0,
    guide_skip = false,
    id = 11601,
    info_type = 0,
    step_type = 6,
    wait_target = false
  },
  [11801] = {
    avg_name = "cpt_longtail_tutorial",
    avg_skip = true,
    condition = 14,
    delay = 0.0,
    guide_skip = false,
    id = 11801,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [11802] = {
    delay = 0.0,
    guide_skip = false,
    id = 11802,
    info_type = 0,
    pic_id = 25,
    step_type = 7,
    wait_target = false
  },
  [40001] = {
    avg_name = "22child_01_02",
    delay = 0.0,
    id = 40001,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [40002] = {
    id = 40002,
    info = 12229,
    info_type = 1017,
    target_name = "Holder/UI_MiniGameGroupList(Clone)/Main/GameList/Content/1/Bottom",
    target_parent = 3202,
    target_type = 1
  },
  [40101] = {
    delay = 0.0,
    id = 40101,
    info = 464181,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [40102] = {
    delay = 0.0,
    id = 40102,
    info = 483427,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [40103] = {
    id = 40103,
    info = 437445,
    info_type = 1002,
    step_type = 5,
    target_name = "Btn_Battle",
    target_parent = 1633,
    target_type = 1
  },
  [40104] = {
    id = 40104,
    info = 200482,
    info_type = 1002,
    step_type = 5,
    target_name = "Btn_Guide",
    target_parent = 1633,
    target_type = 1
  },
  [40105] = {
    id = 40105,
    info = 29133,
    info_type = 1002,
    step_type = 5,
    target_name = "Btn_Reward",
    target_parent = 1633,
    target_type = 1
  },
  [40106] = {
    id = 40106,
    info = 189062,
    info_type = 1002,
    step_type = 5,
    target_name = "Btn_LimitTask",
    target_parent = 1633,
    target_type = 1
  },
  [40107] = {
    id = 40107,
    info = 164596,
    info_type = 1002,
    step_type = 5,
    target_name = "Btn_Achievement",
    target_parent = 1633,
    target_type = 1
  },
  [40108] = {
    delay = 0.0,
    id = 40108,
    info = 475979,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [40109] = {
    id = 40109,
    info = 455837,
    info_type = 1002,
    step_type = 5,
    target_name = "Btn_StoryReview",
    target_parent = 1633,
    target_type = 1
  },
  [40110] = {
    delay = 0.0,
    id = 40110,
    info = 215810,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [50001] = {
    avg_name = "cpt06_tutorial_tower",
    avg_skip = true,
    delay = 0.1,
    id = 50001,
    info_type = 0,
    step_type = 2
  },
  [50002] = {
    delay = 0.0,
    guide_skip = false,
    id = 50002,
    info_type = 0,
    pic_id = 31,
    step_type = 7,
    wait_target = false
  },
  [50011] = {
    avg_name = "23winter_defend_tutorial",
    avg_skip = true,
    delay = 0.1,
    id = 50011,
    info_type = 0,
    step_type = 2
  },
  [90101] = {
    condition = 16,
    delay = 2.5,
    id = 90101,
    info = 382313,
    op_refresh = true,
    step_type = 5,
    target_name = "Frame/RewardLayout/CCNode",
    target_parent = 4,
    target_type = 1
  },
  [100001] = {
    avg_name = "cpt00_tutorial_01",
    delay = 0.0,
    guide_skip = false,
    id = 100001,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [100002] = {
    id = 100002,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [101200] = {
    id = 101200,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [101201] = {
    avg_name = "cpt00_tutorial_04",
    delay = 0.0,
    guide_skip = false,
    id = 101201,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [101202] = {
    id = 101202,
    info = 83683,
    target_name = "UltimateNode/HeroList/1005",
    target_parent = 203,
    target_type = 1
  },
  [101401] = {
    avg_name = "cpt00_tutorial_01temp1",
    delay = 0.0,
    guide_skip = false,
    id = 101401,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [101402] = {
    id = 101402,
    info = 137230,
    target_name = "UltimateNode/HeroList/1001",
    target_parent = 203,
    target_type = 1
  },
  [101403] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1003)",
    delay = 0.0,
    id = 101403,
    info = 81085,
    info_pos = "4",
    step_type = 3,
    wait_target = false
  },
  [101501] = {
    avg_name = "cpt00_tutorial_01temp2",
    delay = 0.0,
    guide_skip = false,
    id = 101501,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [101502] = {
    id = 101502,
    info = 52997,
    target_name = "UltimateNode/HeroList/1037",
    target_parent = 203,
    target_type = 1
  },
  [101503] = {
    custom_code = "GuideUtil.StartManualSkillSelectCoord(4,2)",
    delay = 0.0,
    id = 101503,
    info = 475541,
    info_pos = "11",
    step_type = 3,
    wait_target = false
  },
  [102101] = {
    avg_name = "cpt00_tutorial_01temp3",
    delay = 0.0,
    guide_skip = false,
    id = 102101,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [102102] = {
    custom_code = "GuideUtil.StartBattleDeployGuide(1,2,0,2)",
    delay = 0.0,
    id = 102102,
    info = 7961,
    step_type = 3,
    wait_target = false
  },
  [102103] = {
    id = 102103,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [102104] = {
    delay = 0.2,
    id = 102104,
    info = 121560,
    step_type = 5,
    target_name = "BattleHolder/FloorTileHolder/(0, 2)",
    target_parent = "006_Arena_008",
    target_type = 2
  },
  [102105] = {
    delay = 0.2,
    id = 102105,
    info = 84395,
    step_type = 5,
    target_name = "BattleHolder/FloorTileHolder/(1, 2)",
    target_parent = "006_Arena_008",
    target_type = 2
  },
  [102106] = {
    delay = 0.0,
    guide_skip = false,
    id = 102106,
    info_type = 0,
    pic_id = 2,
    step_type = 7,
    wait_target = false
  },
  [102201] = {
    avg_name = "cpt00_tutorial_01temp4",
    delay = 0.0,
    guide_skip = false,
    id = 102201,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [102202] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(0,2)",
    delay = 0.0,
    id = 102202,
    info = 61424,
    step_type = 3,
    wait_target = false
  },
  [102203] = {
    custom_code = "GuideUtil.StartBattleDeployGuide(1,1,0,2)",
    delay = 0.0,
    id = 102203,
    info = 318289,
    info_pos = "11",
    step_type = 3,
    wait_target = false
  },
  [102204] = {
    custom_code = "GuideUtil.StartBattleDeployGuide(1,3,0,3)",
    delay = 0.0,
    id = 102204,
    info = 459687,
    step_type = 3,
    wait_target = false
  },
  [102205] = {
    id = 102205,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [102206] = {
    custom_code = "GuideUtil.RestartEpBattle()",
    delay = 0.0,
    guide_skip = false,
    id = 102206,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [102207] = {
    delay = 0.0,
    id = 102207,
    info = 338704,
    step_type = 5,
    target_name = "BattleGirdInfoNode",
    target_parent = 212,
    target_type = 1
  },
  [102208] = {
    avg_name = "cpt00_tutorial_01temp9",
    delay = 0.0,
    guide_skip = false,
    id = 102208,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [102209] = {
    custom_code = "GuideUtil.SetTimeScale(0)",
    delay = 0.0,
    guide_skip = false,
    id = 102209,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [102210] = {
    delay = 0.4,
    id = 102210,
    info = 46303,
    step_type = 5,
    target_name = "BattleHolder/FloorTileHolder/(1, 1)",
    target_parent = "006_Arena_008",
    target_type = 2
  },
  [102301] = {
    id = 102301,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [103101] = {
    custom_code = "GuideUtil.RestartEpBattle()",
    delay = 0.0,
    guide_skip = false,
    id = 103101,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [103102] = {
    avg_name = "cpt00_tutorial_01temp5",
    delay = 0.0,
    guide_skip = false,
    id = 103102,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [103103] = {
    id = 103103,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [103104] = {
    avg_name = "cpt00_tutorial_01temp10",
    delay = 0.0,
    guide_skip = false,
    id = 103104,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [103201] = {
    id = 103201,
    info = 446887,
    target_name = "PlayerSkillNode/Normal/1",
    target_parent = 203,
    target_type = 1
  },
  [103202] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1003)",
    delay = 0.0,
    id = 103202,
    info = 252871,
    step_type = 3,
    wait_target = false
  },
  [103203] = {
    custom_code = "GuideUtil.StartManualSkillSelectCoord(5,0)",
    delay = 0.0,
    id = 103203,
    info = 41278,
    info_pos = "17",
    step_type = 3,
    wait_target = false
  },
  [103401] = {
    delay = 0.4,
    id = 103401,
    info = 337556,
    info_pos = "2",
    step_type = 5,
    target_name = "BattleHolder/FloorTileHolder/(2, 2)",
    target_parent = "006_Arena_008",
    target_type = 2
  },
  [103402] = {
    id = 103402,
    info = 484693,
    target_name = "PlayerSkillNode/Normal/1",
    target_parent = 203,
    target_type = 1
  },
  [103403] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1001)",
    delay = 0.0,
    id = 103403,
    info = 484316,
    step_type = 3,
    wait_target = false
  },
  [103404] = {
    custom_code = "GuideUtil.StartManualSkillSelectCoord(5,0)",
    delay = 0.0,
    id = 103404,
    info = 230340,
    step_type = 3,
    wait_target = false
  },
  [103501] = {
    avg_name = "cpt00_tutorial_01temp8",
    delay = 0.0,
    id = 103501,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [103601] = {
    id = 103601,
    info = 172378,
    target_name = "PlayerSkillNode/Normal/1",
    target_parent = 203,
    target_type = 1
  },
  [103602] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1003)",
    delay = 0.0,
    id = 103602,
    info = 252871,
    step_type = 3,
    wait_target = false
  },
  [103603] = {
    custom_code = "GuideUtil.StartManualSkillSelectCoord(4,1)",
    delay = 0.0,
    id = 103603,
    info = 226718,
    info_pos = "17",
    step_type = 3,
    wait_target = false
  },
  [104100] = {
    avg_name = "cpt00_tutorial_01temp7",
    delay = 0.0,
    guide_skip = false,
    id = 104100,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [104101] = {
    delay = 0.2,
    id = 104101,
    info = 317331,
    target_name = "Top/ChipList/ChipLoopList/Rect/EpChipItem(Clone)/UINChipItem",
    target_parent = 210,
    target_type = 1
  },
  [104200] = {
    delay = 0.0,
    guide_skip = false,
    id = 104200,
    info_type = 0,
    pic_id = 3,
    step_type = 7,
    wait_target = false
  },
  [104201] = {
    delay = 0.2,
    id = 104201,
    info = 125490,
    target_name = "Frame/PropList/10267/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/ChipInfoNode/Desc/SuitList",
    target_parent = 102,
    target_type = 1
  },
  [104202] = {
    delay = 0.2,
    id = 104202,
    info = 67037,
    target_name = "Frame/PropList/10267/UINEpChipDetail/Root/ItemHolder/Btn_Group/btn_Select",
    target_parent = 102,
    target_type = 1
  },
  [104203] = {
    delay = 0.2,
    id = 104203,
    info = 36872,
    step_type = 5,
    target_name = "Frame/PropList/10267/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/ChipInfoNode/Desc",
    target_parent = 102,
    target_type = 1
  },
  [104204] = {
    delay = 0.2,
    id = 104204,
    info = 464515,
    step_type = 5,
    target_name = "Frame/PropList/10267/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/ChipInfoNode/Desc/ChipSuitDetail/ScrollRect",
    target_parent = 102,
    target_type = 1
  },
  [104301] = {
    avg_name = "cpt00_tutorial_01temp11",
    delay = 0.0,
    guide_skip = false,
    id = 104301,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [105101] = {
    avg_name = "cpt00_tutorial_08",
    delay = 0.4,
    guide_skip = false,
    id = 105101,
    info_type = 0,
    step_type = 2
  },
  [105102] = {
    delay = 0.4,
    id = 105102,
    info = 493809,
    target_name = "return GuideUtil.GetEpFirstRoomTarget()",
    target_type = 3
  },
  [105103] = {
    delay = 0.0,
    guide_skip = false,
    id = 105103,
    info_type = 0,
    pic_id = 4,
    step_type = 7,
    wait_target = false
  },
  [105201] = {
    avg_name = "cpt00_tutorial_15",
    delay = 0.0,
    guide_skip = false,
    id = 105201,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [105301] = {
    avg_name = "cpt00_tutorial_09",
    delay = 0.0,
    guide_skip = false,
    id = 105301,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [105401] = {
    avg_name = "cpt00_tutorial_14",
    delay = 0.0,
    guide_skip = false,
    id = 105401,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [105501] = {
    avg_name = "cpt00_tutorial_22",
    delay = 0.0,
    guide_skip = false,
    id = 105501,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [105601] = {
    avg_name = "cpt00_tutorial_13",
    delay = 0.0,
    guide_skip = false,
    id = 105601,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [105700] = {
    delay = 0.0,
    guide_skip = false,
    id = 105700,
    info_type = 0,
    pic_id = 5,
    step_type = 7,
    wait_target = false
  },
  [105701] = {
    delay = 0.0,
    id = 105701,
    info = 484693,
    target_name = "PlayerSkillNode/Normal/2",
    target_parent = 203,
    target_type = 1
  },
  [105702] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1003)",
    delay = 0.0,
    id = 105702,
    info = 250776,
    step_type = 3,
    wait_target = false
  },
  [140101] = {
    condition = 1,
    delay = 1.5,
    id = 140101,
    info = 41652,
    info_type = 0,
    op_refresh = true,
    target_name = "RotateWithMian/MainUI/Middle/Btn_Oasis",
    target_parent = 1,
    target_type = 1
  },
  [140102] = {
    id = 140102,
    info = 360483,
    info_type = 0,
    target_name = "UINode/Btn_OpenSide",
    target_parent = 3,
    target_type = 1
  },
  [140103] = {
    id = 140103,
    info = 132118,
    info_type = 0,
    target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/1003",
    target_parent = 3,
    target_type = 1
  },
  [140201] = {
    guide_skip = false,
    id = 140201,
    info = 444500,
    target_name = "Frame/ScrollRect/Rect/1",
    target_parent = 9,
    target_type = 1
  },
  [140202] = {
    guide_skip = false,
    id = 140202,
    info = 174446,
    target_name = "SelectNode/Editor/Btn_Confirm",
    target_parent = 1500,
    target_type = 1
  },
  [140203] = {
    condition = 1,
    delay = 1,
    guide_skip = false,
    id = 140203,
    info = 367790,
    target_name = "Right/Mask/PageList/Rect/Btn_Oasis",
    target_parent = 1,
    target_type = 1
  },
  [140204] = {
    guide_skip = false,
    id = 140204,
    info = 130123,
    target_name = "Btn_Editor",
    target_parent = 1500,
    target_type = 1
  },
  [140205] = {
    delay = 2,
    guide_skip = false,
    id = 140205,
    info = 22724,
    target_name = "ResNode/1003",
    target_parent = 1500,
    target_type = 1
  },
  [150100] = {
    condition = 1,
    delay = 1.7,
    guide_skip = false,
    id = 150100,
    info = 103780,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_openRightSide",
    target_parent = 1,
    target_type = 1
  },
  [150101] = {
    delay = 1.7,
    guide_skip = false,
    id = 150101,
    info = 103780,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_openRightSide",
    target_parent = 1,
    target_type = 1
  },
  [150102] = {
    guide_skip = false,
    id = 150102,
    info = 414212,
    target_name = "Right/Mask/PageList/Rect/Btn_Lottery",
    target_parent = 1,
    target_type = 1
  },
  [150103] = {
    after_code = "GuideUtil.SelectLotteryPool(1)",
    guide_skip = false,
    id = 150103,
    info = 467003,
    op_refresh = true,
    target_name = "Buttom/ButtonGroup/Btn_Once",
    target_parent = 13,
    target_type = 1
  },
  [150104] = {
    guide_skip = false,
    id = 150104,
    info = 516282,
    target_name = "Frame/YesNoNode/ButtonYes",
    target_parent = 1200,
    target_type = 1
  },
  [150105] = {
    after_code = "GuideUtil.ScrollLotteryPoolEnd()",
    condition = 17,
    delay = 0.4,
    guide_skip = false,
    id = 150105,
    info = 268718,
    target_name = "InfoScroll/Rect/2",
    target_parent = 13,
    target_type = 1
  },
  [150106] = {
    delay = 0.2,
    guide_skip = false,
    id = 150106,
    info = 228134,
    op_refresh = true,
    target_name = "Buttom/ButtonGroup/Btn_Once",
    target_parent = 13,
    target_type = 1
  },
  [150107] = {
    after_code = "GuideUtil.ScrollLotteryPoolEnd()",
    condition = 17,
    delay = 1.2,
    guide_skip = false,
    id = 150107,
    info = 197148,
    target_name = "InfoScroll/Rect/2",
    target_parent = 13,
    target_type = 1
  },
  [150108] = {
    after_code = "GuideUtil.ScrollLotteryPoolEnd()",
    delay = 1,
    guide_skip = false,
    id = 150108,
    info = 327906,
    target_name = "InfoScroll/Rect/1",
    target_parent = 13,
    target_type = 1
  },
  [150109] = {
    after_code = "GuideUtil.ScrollLotteryPoolEnd()",
    delay = 1,
    guide_skip = false,
    id = 150109,
    info = 163443,
    target_name = "InfoScroll/Rect/1",
    target_parent = 13,
    target_type = 1
  },
  [150201] = {
    guide_skip = false,
    id = 150201,
    info = 249080,
    target_name = "InfoNode/Btn_LimitUp",
    target_parent = 302,
    target_type = 1
  },
  [150301] = {
    condition = 1,
    delay = 0.8,
    id = 150301,
    info = 70853,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_HeroList",
    target_parent = 1,
    target_type = 1
  },
  [150302] = {
    delay = 0.7,
    id = 150302,
    info = 396942,
    target_name = "return GuideUtil.GetHeroListHeroItem(1003,true,false)",
    target_parent = "300",
    target_type = 3
  },
  [150303] = {
    id = 150303,
    info = 487752,
    step_type = 5,
    target_name = "Center/Level",
    target_parent = 301,
    target_type = 1
  },
  [150304] = {
    id = 150304,
    info = 312245,
    target_name = "Center/Level/Btn_QuickLevelUp",
    target_parent = 301,
    target_type = 1
  },
  [150305] = {
    delay = 0.3,
    id = 150305,
    info = 176676,
    target_name = "InfoNode/Btn_StarUp",
    target_parent = 302,
    target_type = 1
  },
  [150306] = {
    condition = 17,
    delay = 0.4,
    id = 150306,
    info = 499343,
    target_name = "TopButtonGroup/Btn_Back",
    target_parent = 2,
    target_type = 1
  },
  [160101] = {
    condition = 1,
    delay = 1,
    id = 160101,
    info = 122976,
    op_refresh = true,
    target_name = "Right/Mask/PageList/Rect/Btn_Exproation",
    target_parent = 1,
    target_type = 1
  },
  [160102] = {
    delay = 1,
    id = 160102,
    info = 161322,
    target_name = "SectorRoot/UISectorSceneCanvas/SectorNode/1/InfoItem",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [160103] = {
    id = 160103,
    info = 304552,
    target_name = "return GuideUtil.LocationSectorStageItem(1102)",
    target_type = 3
  },
  [160104] = {
    id = 160104,
    info = 406466,
    target_name = "DetailNode/Buttom/BtnGroup/Btn_Battle",
    target_parent = 75,
    target_type = 1
  },
  [160105] = {
    id = 160105,
    info = 380844,
    target_name = "NotEditorNode/Btn_Battle",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [200001] = {
    condition = 1,
    id = 200001,
    info = 41652,
    target_name = "RotateWithMian/MainUI/Middle/Btn_Oasis",
    target_parent = 1,
    target_type = 1
  },
  [200002] = {
    id = 200002,
    info = 360483,
    target_name = "UINode/Btn_OpenSide",
    target_parent = 3,
    target_type = 1
  },
  [200003] = {
    id = 200003,
    info = 435007,
    target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/1011",
    target_parent = 3,
    target_type = 1
  },
  [200004] = {
    id = 200004,
    info = 264065,
    target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/DetailItem/Upgraded/Btn_Upgrade",
    target_parent = 3,
    target_type = 1
  },
  [202001] = {
    delay = 0.1,
    id = 202001,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [202101] = {
    delay = 0.1,
    id = 202101,
    info = 144790,
    step_type = 5,
    target_name = "BattleHolder/FloorTileHolder/(5, 2)",
    target_parent = "006_Arena_003",
    target_type = 2
  },
  [202102] = {
    delay = 0.1,
    id = 202102,
    info = 164999,
    target_name = "PlayerSkillNode/Normal/1",
    target_parent = 203,
    target_type = 1
  },
  [202103] = {
    custom_code = "GuideUtil.StartManualSkillSelectCoord(2,2)",
    delay = 0.0,
    id = 202103,
    info = 226375,
    step_type = 3,
    wait_target = false
  },
  [202201] = {
    id = 202201,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [202301] = {
    delay = 0.1,
    id = 202301,
    info = 443438,
    step_type = 5,
    target_name = "BattleHolder/FloorTileHolder/(5, 2)",
    target_parent = "006_Arena_003",
    target_type = 2
  },
  [202302] = {
    delay = 0.1,
    id = 202302,
    info = 380348,
    target_name = "PlayerSkillNode/Normal/1",
    target_parent = 203,
    target_type = 1
  },
  [202303] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1006)",
    delay = 0.0,
    id = 202303,
    info = 495884,
    step_type = 3,
    wait_target = false
  },
  [203101] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(1,1)",
    delay = 0.0,
    id = 203101,
    info = 45911,
    step_type = 3,
    wait_target = false
  },
  [204101] = {
    delay = 0.2,
    id = 204101,
    info = 407740,
    target_name = "Top/ChipList/ChipLoopList/Rect/EpChipItem(Clone)/UINChipItem",
    target_parent = 210,
    target_type = 1
  },
  [204201] = {
    delay = 0.0,
    id = 204201,
    info = 199404,
    target_name = "PlayerSkillNode/Consume/UIBattleSkillItem(Clone)",
    target_parent = 203,
    target_type = 1
  },
  [204202] = {
    avg_name = "cpt00_tutorial_01temp12",
    delay = 0.0,
    guide_skip = false,
    id = 204202,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [204203] = {
    custom_code = "GuideUtil.StartManualSkillSelectCoord(5,2)",
    delay = 0.0,
    id = 204203,
    info = 449982,
    step_type = 3,
    wait_target = false
  },
  [204301] = {
    delay = 0.2,
    id = 204301,
    info = 53239,
    target_name = "Frame/PropList/901009/UINEpChipDetail/Root/ItemHolder/Btn_Group/btn_Select",
    target_parent = 102,
    target_type = 1
  },
  [204401] = {
    delay = 0.0,
    guide_skip = false,
    id = 204401,
    info = 96652,
    info_type = 0,
    step_type = 0,
    wait_target = false
  },
  [207101] = {
    delay = 0.1,
    id = 207101,
    info = 430043,
    step_type = 5,
    target_name = "BattleHolder/FloorTileHolder/(5, 0)",
    target_parent = "006_Arena_003",
    target_type = 2
  },
  [207102] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(0,4)",
    delay = 0.0,
    id = 207102,
    info = 317645,
    step_type = 3,
    wait_target = false
  },
  [207103] = {
    custom_code = "GuideUtil.StartBattleDeployGuide(0,2,0,4)",
    delay = 0.0,
    id = 207103,
    info = 225402,
    step_type = 3,
    wait_target = false
  },
  [207104] = {
    id = 207104,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [208101] = {
    condition = 3,
    id = 208101,
    info = 390255,
    step_type = 5,
    target_name = "Frame/Lower/MonsterLevel",
    target_parent = 101,
    target_type = 1
  },
  [208102] = {
    id = 208102,
    info = 314622,
    target_name = "Frame/Lower/MonsterLevel",
    target_parent = 101,
    target_type = 1
  },
  [208103] = {
    id = 208103,
    info = 393566,
    info_pos = "2",
    step_type = 5,
    target_name = "Frame/LogicPreviewNode/Frame/Table",
    target_parent = 101,
    target_type = 1
  },
  [300001] = {
    avg_name = "cpt00_tutorial_03xx",
    condition = 9,
    delay = 0.0,
    guide_skip = false,
    id = 300001,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [301101] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(2,2)",
    delay = 0.0,
    id = 301101,
    info = 313539,
    step_type = 3,
    wait_target = false
  },
  [301102] = {
    delay = 0.1,
    id = 301102,
    info = 87993,
    step_type = 5,
    target_name = "UINEnemyDetail/BattleGirdInfoNode",
    target_parent = 206,
    target_type = 1
  },
  [301103] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(5,0)",
    delay = 0.0,
    id = 301103,
    info = 388124,
    step_type = 3,
    wait_target = false
  },
  [301104] = {
    delay = 0.1,
    id = 301104,
    info = 87993,
    step_type = 5,
    target_name = "UINEnemyDetail/BattleGirdInfoNode",
    target_parent = 206,
    target_type = 1
  },
  [301201] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(0,4)",
    delay = 0.0,
    id = 301201,
    info = 106428,
    step_type = 3,
    wait_target = false
  },
  [301301] = {
    delay = 0.1,
    id = 301301,
    info = 126378,
    step_type = 5,
    target_name = "BattleHolder/FloorTileHolder/(2, 2)",
    target_parent = "006_Arena_002",
    target_type = 2
  },
  [301401] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(0,3)",
    delay = 0.0,
    id = 301401,
    info = 63932,
    step_type = 3,
    wait_target = false
  },
  [301402] = {
    custom_code = "GuideUtil.StartBattleDeployGuide(1,1,0,3)",
    delay = 0.0,
    id = 301402,
    info = 42100,
    step_type = 3,
    wait_target = false
  },
  [301403] = {
    delay = 0.1,
    id = 301403,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [301501] = {
    avg_name = "cpt02_tutorial_01",
    delay = 0.0,
    guide_skip = false,
    id = 301501,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [301601] = {
    avg_name = "cpt02_tutorial_02",
    delay = 0.0,
    guide_skip = false,
    id = 301601,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [301701] = {
    avg_name = "cpt02_tutorial_03",
    delay = 0.0,
    guide_skip = false,
    id = 301701,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [301801] = {
    avg_name = "cpt02_tutorial_04",
    delay = 0.0,
    guide_skip = false,
    id = 301801,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [301901] = {
    avg_name = "cpt02_tutorial_05",
    delay = 0.0,
    guide_skip = false,
    id = 301901,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [302001] = {
    avg_name = "cpt02_tutorial_06",
    delay = 0.0,
    guide_skip = false,
    id = 302001,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [303101] = {
    delay = 0.1,
    id = 303101,
    info = 448662,
    target_name = "PlayerSkillNode/Normal/1",
    target_parent = 203,
    target_type = 1
  },
  [303201] = {
    delay = 0.1,
    id = 303201,
    info = 434619,
    target_name = "PlayerSkillNode/Normal/3",
    target_parent = 203,
    target_type = 1
  },
  [303202] = {
    custom_code = "GuideUtil.StartManualSkillSelectCoord(5,2)",
    delay = 0.0,
    id = 303202,
    info = 38109,
    step_type = 3,
    wait_target = false
  },
  [303203] = {
    avg_name = "cpt00_tutorial_01temp13",
    delay = 0.0,
    guide_skip = false,
    id = 303203,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [303204] = {
    avg_name = "cpt00_tutorial_01temp14",
    delay = 0.0,
    guide_skip = false,
    id = 303204,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [303205] = {
    avg_name = "cpt00_tutorial_01temp15",
    delay = 0.0,
    guide_skip = false,
    id = 303205,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [303601] = {
    delay = 0.1,
    id = 303601,
    info = 54169,
    target_name = "PlayerSkillNode/Normal/2",
    target_parent = 203,
    target_type = 1
  },
  [303602] = {
    custom_code = "GuideUtil.StartManualSkillSelectCoord(3,2)",
    delay = 0.0,
    id = 303602,
    info = 415804,
    step_type = 3,
    wait_target = false
  },
  [307101] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(2,4)",
    delay = 0.0,
    id = 307101,
    info = 118601,
    step_type = 3,
    wait_target = false
  },
  [307102] = {
    delay = 0.1,
    id = 307102,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [307103] = {
    delay = 0.1,
    id = 307103,
    info = 183590,
    step_type = 5,
    target_name = "UINEnemyDetail",
    target_parent = 206,
    target_type = 1
  },
  [307201] = {
    delay = 0.1,
    id = 307201,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [307301] = {
    delay = 0.1,
    id = 307301,
    info = 434619,
    target_name = "PlayerSkillNode/Normal/1",
    target_parent = 203,
    target_type = 1
  },
  [307302] = {
    custom_code = "GuideUtil.StartManualSkillSelectCoord(5,2)",
    delay = 0.0,
    id = 307302,
    step_type = 3,
    wait_target = false
  },
  [307401] = {
    delay = 0.1,
    id = 307401,
    info = 353492,
    target_name = "PlayerSkillNode/Normal/2",
    target_parent = 203,
    target_type = 1
  },
  [307402] = {
    custom_code = "GuideUtil.StartManualSkillSelectCoord(0,4)",
    delay = 0.0,
    id = 307402,
    step_type = 3,
    wait_target = false
  },
  [401101] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(2,2)",
    delay = 0.0,
    id = 401101,
    info = 484757,
    step_type = 3,
    wait_target = false
  },
  [401102] = {
    custom_code = "GuideUtil.StartBattleDeployGuide(0,2,2,2)",
    delay = 0.0,
    id = 401102,
    info = 479767,
    step_type = 3,
    wait_target = false
  },
  [401103] = {
    delay = 0.1,
    id = 401103,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [401201] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(0,2)",
    delay = 0.0,
    id = 401201,
    info = 90736,
    step_type = 3,
    wait_target = false
  },
  [401202] = {
    custom_code = "GuideUtil.StartBattleDeployGuide(0,4,0,2)",
    delay = 0.0,
    id = 401202,
    info = 478141,
    step_type = 3,
    wait_target = false
  },
  [401203] = {
    delay = 0.1,
    id = 401203,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [414101] = {
    avg_name = "cpt00_tutorial_01temp16",
    delay = 0.0,
    guide_skip = false,
    id = 414101,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [501101] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(3,1)",
    delay = 0.0,
    id = 501101,
    info = 52172,
    step_type = 3,
    wait_target = false
  },
  [501201] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(2,3)",
    delay = 0.0,
    id = 501201,
    info = 289663,
    step_type = 3,
    wait_target = false
  },
  [600001] = {
    condition = 31,
    condition_arg = {5003},
    delay = 0.0,
    id = 600001,
    info = 267664,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [600002] = {
    id = 600002,
    info = 324414,
    info_pos = "3",
    info_type = 1002,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Team/Mask/Rect/1",
    target_parent = 3501,
    target_type = 1
  },
  [600003] = {
    id = 600003,
    info_type = 0,
    target_name = "NotEditorNode/BtnLayout/Btn_Editor",
    target_parent = 80,
    target_type = 1
  },
  [600004] = {
    id = 600004,
    info = 488908,
    info_pos = "3",
    info_type = 1002,
    target_name = "EditorNode/BtnGroup/Btn_OfficialSupport",
    target_parent = 80,
    target_type = 1
  },
  [600005] = {
    id = 600005,
    info = 105032,
    info_pos = "3",
    info_type = 1002,
    step_type = 5,
    target_name = "EditorNode/Layout/List/CardList/Rect/HeroCardHolder(Clone)",
    target_parent = 80,
    target_type = 1
  },
  [600006] = {
    id = 600006,
    info = 159644,
    info_pos = "3",
    info_type = 1002,
    step_type = 5,
    target_name = "EditorNode/Layout/List/CardList/Rect/HeroCardHolder(Clone)",
    target_parent = 80,
    target_type = 1
  },
  [600007] = {
    delay = 0.0,
    id = 600007,
    info = 335633,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [601101] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(3,1)",
    delay = 0.0,
    id = 601101,
    info = 5685,
    step_type = 3,
    wait_target = false
  },
  [601102] = {
    delay = 0.0,
    id = 601102,
    info = 87993,
    step_type = 5,
    target_name = "BattleGirdInfoNode",
    target_parent = 212,
    target_type = 1
  },
  [601103] = {
    delay = 0.0,
    id = 601103,
    info = 241617,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [601201] = {
    avg_name = "cpt00_tutorial_01temp17",
    delay = 0.0,
    guide_skip = false,
    id = 601201,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [601501] = {
    avg_name = "cpt05_tutorial_01",
    delay = 0.0,
    guide_skip = false,
    id = 601501,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [601502] = {
    avg_name = "cpt05_tutorial_02",
    delay = 0.0,
    guide_skip = false,
    id = 601502,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [701101] = {
    delay = 0.0,
    id = 701101,
    info = 241617,
    info_type = 1002,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [701201] = {
    avg_name = "cpt06_tutorial_01",
    delay = 0.0,
    guide_skip = false,
    id = 701201,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [701301] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(2,2)",
    delay = 0.0,
    id = 701301,
    info = 479819,
    info_type = 1002,
    step_type = 3,
    wait_target = false
  },
  [701302] = {
    delay = 0.1,
    id = 701302,
    info = 453765,
    info_type = 1002,
    step_type = 5,
    target_name = "DetailNode/BattleGirdInfoNode",
    target_parent = 211,
    target_type = 1
  },
  [701303] = {
    delay = 0.0,
    id = 701303,
    info = 241617,
    info_type = 1002,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [704101] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(0,0)",
    delay = 0.0,
    id = 704101,
    info = 283897,
    info_type = 1002,
    step_type = 3,
    wait_target = false
  },
  [704102] = {
    delay = 0.1,
    id = 704102,
    info = 447854,
    info_type = 1002,
    step_type = 5,
    target_name = "UINEnemyDetail",
    target_parent = 206,
    target_type = 1
  },
  [704103] = {
    delay = 0.0,
    id = 704103,
    info = 241617,
    info_type = 1002,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [704201] = {
    avg_name = "cpt06_tutorial_02",
    delay = 0.0,
    guide_skip = false,
    id = 704201,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [704301] = {
    delay = 0.1,
    id = 704301,
    info = 296543,
    info_type = 1002,
    step_type = 5,
    target_name = "BattleHolder/FloorTileHolder/(3, 2)",
    target_parent = "006_Arena_SE2021_002",
    target_type = 2
  },
  [704302] = {
    avg_name = "cpt06_tutorial_04",
    delay = 0.0,
    guide_skip = false,
    id = 704302,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [707101] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(3,2)",
    delay = 0.0,
    id = 707101,
    info = 495170,
    info_type = 1002,
    step_type = 3,
    wait_target = false
  },
  [707102] = {
    delay = 0.1,
    id = 707102,
    info = 408025,
    info_type = 1002,
    step_type = 5,
    target_name = "UINEnemyDetail",
    target_parent = 206,
    target_type = 1
  },
  [707103] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(5,2)",
    delay = 0.0,
    id = 707103,
    info = 115935,
    info_type = 1002,
    step_type = 3,
    wait_target = false
  },
  [707104] = {
    delay = 0.1,
    id = 707104,
    info = 37584,
    info_type = 1002,
    step_type = 5,
    target_name = "UINEnemyDetail",
    target_parent = 206,
    target_type = 1
  },
  [707105] = {
    avg_name = "cpt06_tutorial_03",
    delay = 0.0,
    guide_skip = false,
    id = 707105,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [707106] = {
    delay = 0.0,
    id = 707106,
    info = 241617,
    info_type = 1002,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [716101] = {
    delay = 0.0,
    guide_skip = false,
    id = 716101,
    info_type = 0,
    pic_id = 12,
    step_type = 7,
    wait_target = false
  },
  [725101] = {
    delay = 0.0,
    guide_skip = false,
    id = 725101,
    info_type = 0,
    pic_id = 13,
    step_type = 7,
    wait_target = false
  },
  [727101] = {
    avg_name = "cpt06_tutorial_101",
    delay = 0.0,
    guide_skip = false,
    id = 727101,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [727102] = {
    avg_name = "cpt06_tutorial_102",
    delay = 0.0,
    guide_skip = false,
    id = 727102,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [727103] = {
    avg_name = "cpt06_tutorial_103",
    delay = 0.0,
    guide_skip = false,
    id = 727103,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [727104] = {
    avg_name = "cpt06_tutorial_104",
    delay = 0.0,
    guide_skip = false,
    id = 727104,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [727105] = {
    avg_name = "cpt06_tutorial_106",
    delay = 0.0,
    guide_skip = false,
    id = 727105,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [727106] = {
    avg_name = "cpt06_tutorial_107",
    delay = 0.0,
    guide_skip = false,
    id = 727106,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [727107] = {
    avg_name = "cpt06_tutorial_108",
    delay = 0.0,
    guide_skip = false,
    id = 727107,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [727108] = {
    avg_name = "cpt06_tutorial_109",
    delay = 0.0,
    guide_skip = false,
    id = 727108,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [728101] = {
    avg_name = "cpt06_tutorial_120",
    delay = 0.0,
    guide_skip = false,
    id = 728101,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [1001201] = {
    condition = 5,
    delay = 1,
    id = 1001201,
    info = 313690,
    target_name = "Frame/PropList/10206/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click",
    target_parent = 102,
    target_type = 1
  },
  [1001202] = {
    delay = 0.3,
    id = 1001202,
    info = 378746,
    target_name = "Frame/PropList/10206/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click",
    target_parent = 102,
    target_type = 1
  },
  [1001400] = {
    condition = 7,
    delay = 0.3,
    id = 1001400,
    info = 42590,
    step_type = 5,
    target_name = "Top/ChipList/ChipLoopList/Rect/EpChipItem(Clone)/UINChipItem",
    target_parent = 210,
    target_type = 1
  },
  [1001401] = {
    delay = 1,
    id = 1001401,
    info = 331574,
    target_name = "Frame/TreasureNode/TreasureList/10247/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click",
    target_parent = 130,
    target_type = 1
  },
  [1001402] = {
    delay = 0.3,
    id = 1001402,
    info = 122069,
    target_name = "Frame/TreasureNode/TreasureList/10247/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click",
    target_parent = 130,
    target_type = 1
  },
  [1002201] = {
    condition = 1,
    delay = 1,
    id = 1002201,
    info = 140098,
    op_refresh = true,
    target_name = "RotateWithMian/MainUI/Middle/Btn_Exproation",
    target_parent = 1,
    target_type = 1
  },
  [1002202] = {
    delay = 1.5,
    id = 1002202,
    info = 460856,
    target_name = "SectorRoot/UICanvas/ProgressNode/1_1",
    target_parent = "002_Sector_001",
    target_type = 2
  },
  [1053051] = {
    delay = 0.0,
    id = 1053051,
    info = 426423,
    info_pos = "16",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [1053052] = {
    delay = 0.0,
    id = 1053052,
    info = 88728,
    info_pos = "16",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [1053053] = {
    delay = 0.0,
    id = 1053053,
    info = 197158,
    info_pos = "18",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [1053054] = {
    delay = 0.0,
    id = 1053054,
    info = 139658,
    info_pos = "18",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [2000301] = {
    id = 2000301,
    info = 56018,
    info_type = 1045,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [2000302] = {
    custom_code = "GuideUtil.SetTimeScale(0)",
    delay = 0.0,
    guide_skip = false,
    id = 2000302,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [2000303] = {
    delay = 0.0,
    id = 2000303,
    info = 431076,
    info_type = 1045,
    step_type = 4,
    wait_target = false
  },
  [2000304] = {
    custom_code = "GuideUtil.RestartEpBattle()",
    delay = 0.0,
    guide_skip = false,
    id = 2000304,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [2000305] = {
    delay = 0.0,
    id = 2000305,
    info = 341657,
    info_type = 1045,
    step_type = 4,
    wait_target = false
  },
  [2000306] = {
    custom_code = "GuideUtil.StartBattleDeployGuide(2,2,0,2)",
    delay = 0.0,
    id = 2000306,
    info = 429845,
    info_type = 1045,
    step_type = 3,
    wait_target = false
  },
  [2000307] = {
    id = 2000307,
    info = 56018,
    info_type = 1045,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [2000308] = {
    delay = 0.0,
    id = 2000308,
    info = 104141,
    info_type = 1045,
    target_name = "PlayerSkillNode/Consume/UIBattleSkillItem(Clone)",
    target_parent = 203,
    target_type = 1
  },
  [2000309] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1013)",
    delay = 0.0,
    id = 2000309,
    info = 439584,
    info_type = 1045,
    step_type = 3,
    wait_target = false
  },
  [2000310] = {
    delay = 0.0,
    id = 2000310,
    info = 188326,
    info_type = 1045,
    target_name = "PlayerSkillNode/Consume/UIBattleSkillItem(Clone)",
    target_parent = 203,
    target_type = 1
  },
  [2000311] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1003)",
    delay = 0.0,
    id = 2000311,
    info = 277095,
    info_type = 1045,
    step_type = 3,
    wait_target = false
  },
  [2000312] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(4,2)",
    delay = 0.0,
    id = 2000312,
    info = 134944,
    info_type = 1045,
    step_type = 3,
    wait_target = false
  },
  [2000313] = {
    delay = 0.0,
    id = 2000313,
    info = 286904,
    info_type = 1045,
    step_type = 4,
    wait_target = false
  },
  [2000314] = {
    delay = 0.0,
    id = 2000314,
    info = 411048,
    info_type = 1045,
    target_name = "PlayerSkillNode/Consume/UIBattleSkillItem(Clone)",
    target_parent = 203,
    target_type = 1
  },
  [2000315] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1005)",
    delay = 0.0,
    id = 2000315,
    info = 482893,
    info_type = 1045,
    step_type = 3,
    wait_target = false
  },
  [2000316] = {
    delay = 0.0,
    id = 2000316,
    info = 168771,
    info_type = 1045,
    target_name = "PlayerSkillNode/Consume/UIBattleSkillItem(Clone)",
    target_parent = 203,
    target_type = 1
  },
  [2000317] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1003)",
    delay = 0.0,
    id = 2000317,
    info = 250256,
    info_type = 1045,
    step_type = 3,
    wait_target = false
  },
  [2000318] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(4,2)",
    delay = 0.0,
    id = 2000318,
    info = 497010,
    info_type = 1045,
    step_type = 3,
    wait_target = false
  },
  [2000319] = {
    delay = 0.0,
    id = 2000319,
    info = 483428,
    info_type = 1045,
    step_type = 4,
    wait_target = false
  },
  [2000320] = {
    delay = 0.0,
    id = 2000320,
    info = 362926,
    info_type = 1045,
    target_name = "PlayerSkillNode/Consume/UIBattleSkillItem(Clone)",
    target_parent = 203,
    target_type = 1
  },
  [2000321] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1013)",
    delay = 0.0,
    id = 2000321,
    info = 255264,
    info_type = 1045,
    step_type = 3,
    wait_target = false
  },
  [2000322] = {
    delay = 0.0,
    id = 2000322,
    info = 134303,
    info_type = 1045,
    target_name = "PlayerSkillNode/Consume/UIBattleSkillItem(Clone)",
    target_parent = 203,
    target_type = 1
  },
  [2000323] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1005)",
    delay = 0.0,
    id = 2000323,
    info = 447400,
    info_type = 1045,
    step_type = 3,
    wait_target = false
  },
  [2000324] = {
    id = 2000324,
    info = 56018,
    info_type = 1045,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [2000325] = {
    id = 2000325,
    info = 241617,
    info_type = 1041,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [2000326] = {
    id = 2000326,
    info = 241617,
    info_type = 1041,
    target_name = "Frame/Btn_BattleStart",
    target_parent = 204,
    target_type = 1
  },
  [2000601] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(3,1)",
    delay = 0.0,
    id = 2000601,
    info = 167204,
    info_type = 1041,
    step_type = 3,
    wait_target = false
  },
  [2000602] = {
    delay = 0.0,
    id = 2000602,
    info = 109253,
    info_type = 1041,
    step_type = 4,
    wait_target = false
  },
  [2000603] = {
    delay = 0.0,
    id = 2000603,
    info = 185512,
    info_type = 1041,
    target_name = "PlayerSkillNode/Consume/UIBattleSkillItem(Clone)",
    target_parent = 203,
    target_type = 1
  },
  [2000604] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1007)",
    delay = 0.0,
    id = 2000604,
    info = 233263,
    info_type = 1041,
    step_type = 3,
    wait_target = false
  },
  [2000605] = {
    delay = 0.0,
    id = 2000605,
    info = 246011,
    info_type = 1041,
    target_name = "PlayerSkillNode/Consume/UIBattleSkillItem(Clone)",
    target_parent = 203,
    target_type = 1
  },
  [2000606] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1003)",
    delay = 0.0,
    id = 2000606,
    info = 355923,
    info_type = 1041,
    step_type = 3,
    wait_target = false
  },
  [2000607] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(3,1)",
    delay = 0.0,
    id = 2000607,
    info = 457417,
    info_type = 1041,
    step_type = 3,
    wait_target = false
  },
  [2000608] = {
    delay = 0.0,
    id = 2000608,
    info = 30998,
    info_type = 1041,
    step_type = 4,
    wait_target = false
  },
  [2000609] = {
    delay = 0.0,
    id = 2000609,
    info = 201364,
    info_type = 1041,
    target_name = "PlayerSkillNode/Consume/UIBattleSkillItem(Clone)",
    target_parent = 203,
    target_type = 1
  },
  [2000610] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1013)",
    delay = 0.0,
    id = 2000610,
    info = 519339,
    info_type = 1041,
    step_type = 3,
    wait_target = false
  },
  [2000611] = {
    delay = 0.0,
    id = 2000611,
    info = 115811,
    info_type = 1041,
    target_name = "PlayerSkillNode/Consume/UIBattleSkillItem(Clone)",
    target_parent = 203,
    target_type = 1
  },
  [2000612] = {
    custom_code = "GuideUtil.StartManualSkillSelectHero(1006)",
    delay = 0.0,
    id = 2000612,
    info = 302784,
    info_type = 1041,
    step_type = 3,
    wait_target = false
  },
  [2000613] = {
    delay = 0.0,
    id = 2000613,
    info = 405128,
    info_type = 1041,
    step_type = 4,
    wait_target = false
  },
  [2000614] = {
    condition = 8,
    id = 2000614,
    info = 76953,
    info_type = 1041,
    target_name = "Frame/PageHolder/MetalGearNode/ItemMode/Left/UINEpEventPartItem_1",
    target_parent = 131,
    target_type = 1
  },
  [2000615] = {
    condition = 8,
    id = 2000615,
    info = 117938,
    info_type = 1041,
    target_name = "Frame/PageHolder/MetalGearNode/ItemMode/Right/UINEpEventPartItem_4",
    target_parent = 131,
    target_type = 1
  },
  [2000616] = {
    condition = 8,
    id = 2000616,
    info = 43124,
    info_type = 1041,
    target_name = "Frame/PageHolder/MetalGearNode/Btn_Exit",
    target_parent = 131,
    target_type = 1
  },
  [2000617] = {
    delay = 0.0,
    id = 2000617,
    info = 301892,
    info_type = 1041,
    step_type = 4,
    wait_target = false
  },
  [2000618] = {
    condition = 8,
    id = 2000618,
    info = 307331,
    info_type = 1041,
    target_name = "Frame/PageHolder/MetalGearNode/ItemMode/Left/UINEpEventPartItem_1",
    target_parent = 131,
    target_type = 1
  },
  [2000619] = {
    condition = 8,
    id = 2000619,
    info = 215332,
    info_type = 1041,
    target_name = "Frame/PageHolder/MetalGearNode/ItemMode/Right/UINEpEventPartItem_4",
    target_parent = 131,
    target_type = 1
  },
  [2000620] = {
    condition = 8,
    id = 2000620,
    info = 318086,
    info_type = 1041,
    target_name = "Frame/PageHolder/MetalGearNode/ProductList /Rect/2",
    target_parent = 131,
    target_type = 1
  },
  [2000621] = {
    condition = 8,
    id = 2000621,
    info = 153133,
    info_type = 1041,
    target_name = "Frame/PageHolder/MetalGearNode/Btn_Mix",
    target_parent = 131,
    target_type = 1
  },
  [2000622] = {
    delay = 0.0,
    id = 2000622,
    info = 487728,
    info_type = 1041,
    target_name = "PlayerSkillNode/Consume/UIBattleSkillItem(Clone)",
    target_parent = 203,
    target_type = 1
  },
  [2000623] = {
    custom_code = "GuideUtil.StartManualSkillSelectCoord(0,3)",
    delay = 0.0,
    id = 2000623,
    info = 473190,
    info_type = 1041,
    step_type = 3,
    wait_target = false
  },
  [2000801] = {
    avg_name = "cpt_hb_tutorial_111",
    delay = 0.0,
    guide_skip = false,
    id = 2000801,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [2001101] = {
    avg_name = "cpt_hb_tutorial_11",
    delay = 0.0,
    guide_skip = false,
    id = 2001101,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [2001301] = {
    avg_name = "cpt_hb_tutorial_21",
    delay = 0.0,
    guide_skip = false,
    id = 2001301,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [2001401] = {
    avg_name = "cpt_hb_tutorial_01",
    delay = 0.0,
    guide_skip = false,
    id = 2001401,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [2001402] = {
    avg_name = "cpt_hb_tutorial_02",
    delay = 0.0,
    guide_skip = false,
    id = 2001402,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [2001403] = {
    avg_name = "cpt_hb_tutorial_03",
    delay = 0.0,
    guide_skip = false,
    id = 2001403,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [2001404] = {
    avg_name = "cpt_hb_tutorial_04",
    delay = 0.0,
    guide_skip = false,
    id = 2001404,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [2001405] = {
    avg_name = "cpt_hb_tutorial_05",
    delay = 0.0,
    guide_skip = false,
    id = 2001405,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [2001406] = {
    avg_name = "cpt_hb_tutorial_06",
    delay = 0.0,
    guide_skip = false,
    id = 2001406,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [2001407] = {
    avg_name = "cpt_hb_tutorial_07",
    delay = 0.0,
    guide_skip = false,
    id = 2001407,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [2001408] = {
    avg_name = "cpt_hb_tutorial_08",
    delay = 0.0,
    guide_skip = false,
    id = 2001408,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [2001409] = {
    avg_name = "cpt_hb_tutorial_09",
    delay = 0.0,
    guide_skip = false,
    id = 2001409,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [3100101] = {
    id = 3100101,
    info = 87563,
    info_type = 1045,
    target_name = "StOList/Rect/ChessLayout/TechItemLayout/1_3",
    target_parent = 1620,
    target_type = 1
  },
  [3100102] = {
    id = 3100102,
    info = 482408,
    info_type = 1045,
    step_type = 5,
    target_name = "GameResourceGroup/1025",
    target_parent = 2,
    target_type = 1
  },
  [3100103] = {
    id = 3100103,
    info = 117650,
    info_type = 1045,
    step_type = 5,
    target_name = "Side/Down/Consume",
    target_parent = 1620,
    target_type = 1
  },
  [3100104] = {
    id = 3100104,
    info = 167730,
    info_type = 1045,
    target_name = "Side/Down/Consume/Btn_Upgrade",
    target_parent = 1620,
    target_type = 1
  },
  [4010201] = {
    avg_name = "22hallo_e_guide",
    avg_skip = true,
    condition = 30,
    condition_arg = {5000, 5002},
    delay = 0.0,
    id = 4010201,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [4010202] = {
    delay = 0.0,
    id = 4010202,
    info = 120086,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4010203] = {
    delay = 0.0,
    id = 4010203,
    info = 235242,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4010204] = {
    id = 4010204,
    info_pos = "1",
    info_type = 1002,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [4010205] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,3)",
    id = 4010205,
    info_pos = "1",
    info_type = 1002,
    step_type = 3,
    target_type = 2
  },
  [4010206] = {
    id = 4010206,
    info_pos = "1",
    info_type = 1002,
    target_name = "3_3/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [4010207] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,2)",
    id = 4010207,
    info = 385980,
    info_pos = "5",
    info_type = 1002,
    step_type = 3,
    target_type = 2
  },
  [4010208] = {
    id = 4010208,
    info_pos = "1",
    info_type = 1002,
    target_name = "3_2/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [4010209] = {
    id = 4010209,
    info = 191505,
    info_pos = "1",
    info_type = 1002,
    step_type = 5,
    target_name = "Top/Trans_SpBottleHolder/UINWCBottleHalloween22(Clone)",
    target_parent = 3501,
    target_type = 1
  },
  [4010210] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(7,5)",
    id = 4010210,
    info = 483277,
    info_pos = "3",
    info_type = 1002,
    step_type = 3,
    target_type = 2
  },
  [4010211] = {
    id = 4010211,
    info = 101887,
    info_pos = "3",
    info_type = 1002,
    step_type = 4
  },
  [4010212] = {
    delay = 0.0,
    id = 4010212,
    info = 259893,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4010213] = {
    delay = 0.0,
    id = 4010213,
    info = 473013,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4010214] = {
    delay = 0.0,
    id = 4010214,
    info = 42456,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4010215] = {
    id = 4010215,
    info_pos = "1",
    info_type = 1002,
    target_name = "Top/Btn_Close",
    target_parent = 3701,
    target_type = 1
  },
  [4010216] = {
    delay = 0.0,
    id = 4010216,
    info = 337751,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4010217] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,5)",
    id = 4010217,
    info_pos = "1",
    info_type = 1002,
    step_type = 3,
    target_type = 2
  },
  [4010218] = {
    id = 4010218,
    info = 385195,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    target_name = "Main",
    target_parent = 3680,
    target_type = 1
  },
  [4010219] = {
    id = 4010219,
    info = 280824,
    info_pos = "14",
    info_type = 1002,
    step_type = 5,
    target_name = "Main/Item(Clone)/Canvas/Mask/Tex_Mode",
    target_parent = 3680,
    target_type = 1
  },
  [4010220] = {
    id = 4010220,
    info = 308174,
    info_pos = "14",
    info_type = 1002,
    step_type = 5,
    target_name = "Main/Item(Clone)/Canvas/Tex_ModeDiff",
    target_parent = 3680,
    target_type = 1
  },
  [4010221] = {
    id = 4010221,
    info = 516401,
    info_pos = "16",
    info_type = 1002,
    step_type = 5,
    target_name = "Main/Item(Clone)/Canvas/Img_EnviroBg",
    target_parent = 3680,
    target_type = 1
  },
  [4010222] = {
    id = 4010222,
    info = 429043,
    info_pos = "16",
    info_type = 1002,
    step_type = 5,
    target_name = "Main/Item(Clone)/Canvas/Award",
    target_parent = 3680,
    target_type = 1
  },
  [4010223] = {
    delay = 0.0,
    id = 4010223,
    info = 248156,
    info_pos = "8",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4010224] = {
    id = 4010224,
    info = 282400,
    info_pos = "8",
    info_type = 1002,
    target_name = "Btn_Close",
    target_parent = 3680,
    target_type = 1
  },
  [4010225] = {
    delay = 0.0,
    id = 4010225,
    info = 483479,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4020101] = {
    delay = 0.0,
    id = 4020101,
    info = 464181,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4020102] = {
    delay = 0.0,
    id = 4020102,
    info = 483427,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4020103] = {
    id = 4020103,
    info = 437445,
    info_type = 1002,
    step_type = 5,
    target_name = "Btn_Battle",
    target_parent = 1690,
    target_type = 1
  },
  [4020104] = {
    id = 4020104,
    info = 200482,
    info_type = 1002,
    step_type = 5,
    target_name = "Btn_Guide",
    target_parent = 1690,
    target_type = 1
  },
  [4020105] = {
    id = 4020105,
    info = 29133,
    info_type = 1002,
    step_type = 5,
    target_name = "Btn_Reward",
    target_parent = 1690,
    target_type = 1
  },
  [4020106] = {
    id = 4020106,
    info = 189062,
    info_type = 1002,
    step_type = 5,
    target_name = "Btn_LimitTask",
    target_parent = 1690,
    target_type = 1
  },
  [4020107] = {
    id = 4020107,
    info = 164596,
    info_type = 1002,
    step_type = 5,
    target_name = "Btn_Achievement",
    target_parent = 1690,
    target_type = 1
  },
  [4020108] = {
    delay = 0.0,
    id = 4020108,
    info = 475979,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4020109] = {
    id = 4020109,
    info = 455837,
    info_type = 1002,
    step_type = 5,
    target_name = "Btn_StoryReview",
    target_parent = 1690,
    target_type = 1
  },
  [4020110] = {
    delay = 0.0,
    id = 4020110,
    info = 246776,
    info_type = 1002,
    step_type = 4,
    target_parent = "1690",
    wait_target = false
  },
  [4020111] = {
    delay = 0.0,
    guide_skip = false,
    id = 4020111,
    info = 275378,
    info_type = 0,
    step_type = 0,
    target_parent = "1693",
    wait_target = false
  },
  [4020112] = {
    delay = 0.0,
    guide_skip = false,
    id = 4020112,
    info = 72657,
    info_type = 0,
    step_type = 0,
    target_parent = "1693",
    wait_target = false
  },
  [4020113] = {
    delay = 0.0,
    guide_skip = false,
    id = 4020113,
    info = 167643,
    info_type = 0,
    step_type = 0,
    target_parent = "1693",
    wait_target = false
  },
  [4020201] = {
    avg_name = "22Christ_hall",
    avg_skip = true,
    condition = 30,
    condition_arg = {7007},
    delay = 0.0,
    id = 4020201,
    info = 120086,
    info_pos = "3",
    info_type = 1002,
    step_type = 2,
    wait_target = false
  },
  [4020202] = {
    delay = 0.0,
    id = 4020202,
    info = 120086,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4020203] = {
    delay = 0.0,
    id = 4020203,
    info = 235242,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4020204] = {
    id = 4020204,
    info_pos = "1",
    info_type = 1002,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [4020205] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,1)",
    id = 4020205,
    info_pos = "1",
    info_type = 1002,
    step_type = 3,
    target_type = 2
  },
  [4020206] = {
    id = 4020206,
    info_pos = "1",
    info_type = 1002,
    target_name = "3_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [4020207] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,2)",
    id = 4020207,
    info = 279299,
    info_pos = "5",
    info_type = 1002,
    step_type = 3,
    target_type = 2
  },
  [4020208] = {
    id = 4020208,
    info_pos = "1",
    info_type = 1002,
    target_name = "3_2/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [4020209] = {
    id = 4020209,
    info = 28351,
    info_pos = "1",
    info_type = 1002,
    step_type = 5,
    target_name = "Top/Trans_SpBottleHolder/UINWCBottleChristmas22(Clone)/Img_BtnBottom",
    target_parent = 3501,
    target_type = 1
  },
  [4020210] = {
    delay = 0.0,
    id = 4020210,
    info = 337751,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4020211] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,5)",
    id = 4020211,
    info_pos = "1",
    info_type = 1002,
    step_type = 3,
    target_type = 2
  },
  [4020212] = {
    id = 4020212,
    info = 296080,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    target_name = "Main",
    target_parent = 3680,
    target_type = 1
  },
  [4020213] = {
    id = 4020213,
    info = 280824,
    info_pos = "14",
    info_type = 1002,
    step_type = 5,
    target_name = "Main/Item(Clone)/Canvas/Mask/Tex_Mode",
    target_parent = 3680,
    target_type = 1
  },
  [4020214] = {
    id = 4020214,
    info = 308174,
    info_pos = "14",
    info_type = 1002,
    step_type = 5,
    target_name = "Main/Item(Clone)/Canvas/Tex_ModeDiff",
    target_parent = 3680,
    target_type = 1
  },
  [4020215] = {
    id = 4020215,
    info = 92764,
    info_pos = "16",
    info_type = 1002,
    step_type = 5,
    target_name = "Main/Item(Clone)/Canvas/NoBuff",
    target_parent = 3680,
    target_type = 1
  },
  [4020216] = {
    id = 4020216,
    info = 429043,
    info_pos = "16",
    info_type = 1002,
    step_type = 5,
    target_name = "Main/Item(Clone)/Canvas/Award",
    target_parent = 3680,
    target_type = 1
  },
  [4020217] = {
    delay = 0.0,
    id = 4020217,
    info = 248156,
    info_pos = "8",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [4020218] = {
    id = 4020218,
    info = 282400,
    info_pos = "8",
    info_type = 1002,
    target_name = "Btn_Close",
    target_parent = 3680,
    target_type = 1
  },
  [4020219] = {
    delay = 0.0,
    id = 4020219,
    info = 483479,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [5000901] = {
    delay = 1,
    id = 5000901,
    info = 397896,
    info_pos = "1",
    info_type = 1088,
    step_type = 4,
    wait_target = false
  },
  [5000902] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(3,2)",
    delay = 1,
    id = 5000902,
    info = 297713,
    info_type = 1088,
    step_type = 3,
    wait_target = false
  },
  [5000903] = {
    id = 5000903,
    info = 247380,
    info_pos = "1",
    info_type = 1088,
    step_type = 4,
    wait_target = false
  },
  [5000904] = {
    id = 5000904,
    info = 62099,
    info_pos = "1",
    info_type = 1088,
    step_type = 4,
    wait_target = false
  },
  [6100001] = {
    condition = 31,
    delay = 0.0,
    id = 6100001,
    info = 29095,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [6100002] = {
    id = 6100002,
    info = 322218,
    info_pos = "3",
    info_type = 1002,
    target_name = "Top/Btn_Menu",
    target_parent = 3501,
    target_type = 1
  },
  [6100003] = {
    id = 6100003,
    info = 413047,
    info_pos = "2",
    info_type = 1002,
    target_name = "ButtonGroup/Btn_Setting",
    target_parent = 205,
    target_type = 1
  },
  [6100004] = {
    id = 6100004,
    info = 466984,
    info_pos = "3",
    info_type = 1002,
    step_type = 5,
    target_name = "Frame/Detail/GameSetPanel/Scroll/List/3",
    target_parent = 45,
    target_type = 1
  },
  [6100005] = {
    delay = 0.0,
    id = 6100005,
    info = 111912,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [6100006] = {
    delay = 0.0,
    id = 6100006,
    info = 45493,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [6100007] = {
    delay = 0.0,
    guide_skip = false,
    id = 6100007,
    info_type = 0,
    pic_id = 46,
    step_type = 7,
    wait_target = false
  },
  [6100008] = {
    avg_name = "survivors_tutorial",
    avg_skip = true,
    condition = 4,
    condition_arg = {330013100},
    delay = 0.0,
    guide_skip = false,
    id = 6100008,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [6100009] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(3,2)",
    delay = 0.0,
    id = 6100009,
    info = 516271,
    step_type = 3,
    wait_target = false
  },
  [6100013] = {
    delay = 1,
    id = 6100013,
    info = 259558,
    info_pos = "7",
    info_type = 1037,
    step_type = 4,
    wait_target = false
  },
  [6100014] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(3,2)",
    delay = 0.0,
    id = 6100014,
    info = 464157,
    info_type = 1006,
    step_type = 3,
    wait_target = false
  },
  [6100015] = {
    id = 6100015,
    info = 98938,
    info_pos = "3",
    info_type = 1037,
    step_type = 5,
    target_name = "GamePlayScore/Collect/Bar",
    target_parent = 204,
    target_type = 1
  },
  [6100016] = {
    id = 6100016,
    info = 517604,
    info_pos = "7",
    info_type = 1037,
    step_type = 4
  },
  [6100017] = {
    id = 6100017,
    info = 119710,
    info_pos = "7",
    info_type = 1037,
    target_name = "UltimateNode/HeroList/1037",
    target_parent = 203,
    target_type = 1
  },
  [6100018] = {
    custom_code = "GuideUtil.StartManualSkillSelectCoord(5,2)",
    delay = 0.0,
    id = 6100018,
    info = 440460,
    info_pos = "7",
    info_type = 1037,
    step_type = 3,
    wait_target = false
  },
  [6100019] = {
    delay = 1,
    id = 6100019,
    info = 410282,
    info_pos = "7",
    info_type = 1006,
    step_type = 4,
    wait_target = false
  },
  [6100020] = {
    delay = 1,
    id = 6100020,
    info = 276564,
    info_pos = "7",
    info_type = 1006,
    step_type = 4,
    wait_target = false
  },
  [6100021] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(3,2)",
    delay = 0.0,
    id = 6100021,
    info = 453764,
    info_type = 1037,
    step_type = 3,
    wait_target = false
  },
  [6100031] = {
    custom_code = "GuideUtil.SetTimeScale(0)",
    delay = 0.2,
    id = 6100031,
    info_type = 0,
    step_type = 3
  },
  [6100032] = {
    delay = 0.2,
    id = 6100032,
    info = 177629,
    info_pos = "6",
    info_type = 1037,
    step_type = 5,
    target_name = "GamePlayScore/Collect/Bar",
    target_parent = 204,
    target_type = 1
  },
  [6100033] = {
    id = 6100033,
    info = 295117,
    info_pos = "3",
    info_type = 1037,
    step_type = 5,
    target_name = "BattleHolder/FloorTileHolder/(2, 0)",
    target_parent = "006_Arena_018",
    target_type = 2
  },
  [6100034] = {
    delay = 0.1,
    id = 6100034,
    info = 434233,
    info_pos = "3",
    info_type = 1037,
    target_name = "UltimateNode/HeroList/1037",
    target_parent = 203,
    target_type = 1
  },
  [6100035] = {
    custom_code = "GuideUtil.StartManualSkillSelectCoord(5,2)",
    delay = 0.2,
    id = 6100035,
    info = 379801,
    info_pos = "13",
    info_type = 1037,
    step_type = 3
  },
  [6100036] = {
    custom_code = "GuideUtil.SetTimeScale(1)",
    delay = 0.1,
    id = 6100036,
    info_type = 0,
    step_type = 3
  },
  [6100037] = {
    delay = 2,
    id = 6100037,
    info = 175119,
    info_pos = "13",
    info_type = 1037,
    step_type = 4
  },
  [7000001] = {
    id = 7000001,
    info = 512661,
    info_type = 1071,
    step_type = 4,
    target_parent = 3921,
    target_type = 1
  },
  [7000002] = {
    id = 7000002,
    info = 284987,
    info_type = 1071,
    step_type = 4,
    target_parent = 3921,
    target_type = 1
  },
  [7000003] = {
    id = 7000003,
    info = 341893,
    info_type = 1071,
    step_type = 4,
    target_parent = 3921,
    target_type = 1
  },
  [7000004] = {
    id = 7000004,
    info = 494937,
    info_type = 1071,
    target_name = "Main/RegularMode/Main/Btn_Jump",
    target_parent = 3921,
    target_type = 1
  },
  [7000005] = {
    delay = 1,
    id = 7000005,
    info = 289390,
    info_type = 1071,
    step_type = 5,
    target_name = "Main/HeadItemList",
    target_parent = 3920,
    target_type = 1
  },
  [7000006] = {
    delay = 1,
    id = 7000006,
    info = 333309,
    info_type = 1071,
    step_type = 5,
    target_name = "Right/Img_Bottom1/TagInfoList",
    target_parent = 3920,
    target_type = 1
  },
  [7000007] = {
    id = 7000007,
    info = 319545,
    info_type = 1071,
    step_type = 5,
    target_name = "Down/Group/Bonus",
    target_parent = 3920,
    target_type = 1
  },
  [7000008] = {
    id = 7000008,
    info = 362647,
    info_type = 1071,
    step_type = 5,
    target_name = "Down/Btn_Potion",
    target_parent = 3920,
    target_type = 1
  },
  [7000009] = {
    id = 7000009,
    info = 354344,
    info_type = 1071,
    step_type = 5,
    target_name = "Down/Group/Obj_RemainNum",
    target_parent = 3920,
    target_type = 1
  },
  [7000010] = {
    id = 7000010,
    info = 239952,
    info_type = 1071,
    step_type = 5,
    target_name = "Down/Group/Difficulty/Btn_DiffSwitch",
    target_parent = 3920,
    target_type = 1
  },
  [7000011] = {
    id = 7000011,
    info = 230742,
    info_type = 1071,
    step_type = 5,
    target_name = "Down/Btn_NextRound",
    target_parent = 3920,
    target_type = 1
  },
  [7000012] = {
    id = 7000012,
    info = 268678,
    info_type = 1071,
    step_type = 5,
    target_name = "Left/LeftNormal/Point",
    target_parent = 3920,
    target_type = 1
  },
  [7000013] = {
    id = 7000013,
    info = 511365,
    info_type = 1071,
    step_type = 5,
    target_name = "Left/LeftNormal/Reset",
    target_parent = 3920,
    target_type = 1
  },
  [7000014] = {
    id = 7000014,
    info = 470270,
    info_type = 1071,
    step_type = 4,
    target_parent = 3920,
    target_type = 1
  },
  [8000001] = {
    condition = 1,
    delay = 0.0,
    id = 8000001,
    info = 499680,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [8000002] = {
    delay = 0.0,
    id = 8000002,
    info = 196856,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [8000003] = {
    id = 8000003,
    info = 483783,
    info_type = 1002,
    target_name = "Right/Mask/PageList/Rect/btn_FairyEntrance",
    target_parent = 1,
    target_type = 1
  },
  [8000004] = {
    id = 8000004,
    info = 149407,
    info_type = 1002,
    step_type = 4,
    target_parent = 3952,
    target_type = 1
  },
  [8000005] = {
    id = 8000005,
    info = 99443,
    info_type = 1002,
    target_name = "Btn_GetElf",
    target_parent = 3952,
    target_type = 1
  },
  [8000006] = {
    id = 8000006,
    info = 24395,
    info_type = 1002,
    target_name = "Main/InfoGroup/Btn_10Lottery",
    target_parent = 3956,
    target_type = 1
  },
  [8000007] = {
    id = 8000007,
    info = 503710,
    info_type = 1002,
    step_type = 4,
    target_parent = 3957,
    target_type = 1
  },
  [8000008] = {
    id = 8000008,
    info = 501612,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [8000009] = {
    arrow_offset = {600, 100},
    id = 8000009,
    info = 106017,
    info_pos = "6",
    info_type = 1002,
    target_name = "BG",
    target_parent = 3957,
    target_type = 1
  },
  [8000010] = {
    id = 8000010,
    info = 319208,
    info_type = 1002,
    target_name = "TopButtonGroup/Btn_Back",
    target_parent = 2,
    target_type = 1
  },
  [8000011] = {
    id = 8000011,
    info = 458911,
    info_type = 1002,
    target_name = "Btn_ElfList",
    target_parent = 3952,
    target_type = 1
  },
  [8000012] = {
    id = 8000012,
    info = 166103,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [8000013] = {
    id = 8000013,
    info = 333877,
    info_type = 1002,
    pic_id = 56,
    step_type = 7,
    wait_target = false
  },
  [9000001] = {
    condition = 35,
    id = 9000001,
    info = 493616,
    info_pos = "6",
    info_type = 1002,
    step_type = 4,
    target_parent = 4130,
    target_type = 1
  },
  [9000002] = {
    id = 9000002,
    info = 31214,
    info_pos = "6",
    info_type = 1002,
    step_type = 4,
    target_parent = 4130,
    target_type = 1
  },
  [9000003] = {
    id = 9000003,
    info = 81467,
    info_type = 1002,
    target_name = "Mid/Lay2/pos1/UiNMilestoneMainItem(Clone)/btn_click",
    target_parent = 4130,
    target_type = 1
  },
  [9000004] = {
    id = 9000004,
    info = 508308,
    info_type = 1002,
    step_type = 5,
    target_name = "Main/BandList",
    target_parent = 4131,
    target_type = 1
  },
  [9000005] = {
    id = 9000005,
    info = 366725,
    info_type = 1002,
    step_type = 5,
    target_name = "Left/RewardInfo",
    target_parent = 4131,
    target_type = 1
  },
  [9000006] = {
    id = 9000006,
    info = 252493,
    info_type = 1002,
    target_name = "Main/Top/Btn_QuickCheck",
    target_parent = 4131,
    target_type = 1
  },
  [9000007] = {
    id = 9000007,
    info = 32962,
    info_type = 1002,
    step_type = 5,
    target_name = "TaskOverviewNode/Main",
    target_parent = 4131,
    target_type = 1
  },
  [9000008] = {
    id = 9000008,
    info = 465814,
    info_pos = "6",
    info_type = 1002,
    step_type = 4,
    target_parent = 4131,
    target_type = 1
  },
  [60300011] = {
    condition = 27,
    delay = 1,
    id = 60300011,
    info = 3141,
    info_pos = "6",
    info_type = 1014,
    step_type = 4
  },
  [60300012] = {
    id = 60300012,
    info = 436445,
    info_pos = "6",
    info_type = 1014,
    target_name = "ProductCanvas/Obj_OrderSlot(Clone)",
    target_parent = 1641,
    target_type = 1
  },
  [60300013] = {
    delay = 1,
    id = 60300013,
    info = 121510,
    info_pos = "6",
    info_type = 1014,
    step_type = 4
  },
  [60300014] = {
    id = 60300014,
    info = 188476,
    info_pos = "6",
    info_type = 1014,
    target_name = "Frame/ItemNode/Scroll/Rect/ProduceItem(Clone)/Btn_Produce",
    target_parent = 1642,
    target_type = 1
  },
  [60300015] = {
    id = 60300015,
    info = 179686,
    info_pos = "6",
    info_type = 1014,
    step_type = 5,
    target_name = "EventFrame/Table/LineFrame/Scroll",
    target_parent = 1646,
    target_type = 1
  },
  [60300016] = {
    id = 60300016,
    info = 331525,
    info_pos = "6",
    info_type = 1014,
    step_type = 5,
    target_name = "EventFrame/Btn_Confirm",
    target_parent = 1646,
    target_type = 1
  },
  [60300021] = {
    delay = 1,
    id = 60300021,
    info = 123067,
    info_pos = "6",
    info_type = 1014,
    step_type = 4
  },
  [60300022] = {
    id = 60300022,
    info = 101109,
    info_pos = "6",
    info_type = 1014,
    target_name = "MainCanvas/Btn_Photo",
    target_parent = 1641,
    target_type = 1
  },
  [60300023] = {
    id = 60300023,
    info = 76437,
    info_pos = "8",
    info_type = 1014,
    step_type = 5,
    target_name = "Frame/ResourcesNode",
    target_parent = 1647,
    target_type = 1
  },
  [60300024] = {
    id = 60300024,
    info = 437824,
    info_pos = "6",
    info_type = 1014,
    target_name = "Frame/Btn_GetPhoto",
    target_parent = 1647,
    target_type = 1
  },
  [240003101] = {
    delay = 0.0,
    guide_skip = false,
    id = 240003101,
    info_type = 0,
    pic_id = 42,
    step_type = 7,
    wait_target = false
  },
  [240012101] = {
    avg_name = "23winter_s08_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 240012101,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [240012201] = {
    avg_name = "23winter_s12_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 240012201,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [240012301] = {
    avg_name = "23winter_s13_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 240012301,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [240012401] = {
    avg_name = "23winter_s17_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 240012401,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [240012501] = {
    avg_name = "23winter_s18_1",
    avg_skip = true,
    delay = 0.2,
    guide_skip = false,
    id = 240012501,
    info_type = 0,
    step_type = 2
  },
  [240017101] = {
    delay = 0.0,
    guide_skip = false,
    id = 240017101,
    info_type = 0,
    pic_id = 42,
    step_type = 7,
    wait_target = false
  },
  [240022201] = {
    avg_name = "23winter_s12_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 240022201,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [240022301] = {
    avg_name = "23winter_s13_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 240022301,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [240022401] = {
    avg_name = "23winter_s17_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 240022401,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [240022501] = {
    avg_name = "23winter_s18_1",
    avg_skip = true,
    delay = 0.2,
    guide_skip = false,
    id = 240022501,
    info_type = 0,
    step_type = 2
  },
  [240026101] = {
    avg_name = "23winter_s08_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 240026101,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [250006101] = {
    custom_code = "GuideUtil.SetTimeScale(0)",
    delay = 0.2,
    guide_skip = false,
    id = 250006101,
    info_type = 0,
    step_type = 3
  },
  [250006102] = {
    condition = 6,
    delay = 0.2,
    id = 250006102,
    info = 421429,
    info_pos = "3",
    info_type = 1,
    step_type = 4
  },
  [250006103] = {
    delay = 0.0,
    id = 250006103,
    info = 421756,
    info_pos = "3",
    info_type = 1,
    step_type = 4
  },
  [250006104] = {
    custom_size = __rt_6,
    delay = 0.0,
    id = 250006104,
    info = 40202,
    info_pos = "3",
    info_type = 1,
    step_type = 5,
    target_name = "PlayerSkillNode/Normal/2",
    target_parent = 203,
    target_type = 1
  },
  [250006105] = {
    custom_size = __rt_6,
    delay = 0.0,
    id = 250006105,
    info = 73470,
    info_pos = "3",
    info_type = 1,
    step_type = 5,
    target_name = "PlayerSkillNode/Normal/2",
    target_parent = 203,
    target_type = 1
  },
  [250006106] = {
    delay = 0.0,
    id = 250006106,
    info = 383813,
    info_pos = "3",
    info_type = 1,
    step_type = 4,
    wait_target = false
  },
  [250006107] = {
    custom_code = "GuideUtil.SetTimeScale(1)",
    delay = 1,
    guide_skip = false,
    id = 250006107,
    info_type = 0,
    step_type = 3
  },
  [250006201] = {
    avg_name = "23carnival_s06_1",
    avg_skip = true,
    delay = 0.2,
    id = 250006201,
    info_type = 0,
    step_type = 2
  },
  [250006301] = {
    avg_name = "23carnival_s06_2",
    avg_skip = true,
    delay = 0.2,
    id = 250006301,
    info_type = 0,
    step_type = 2
  },
  [250006401] = {
    avg_name = "23carnival_s06_3",
    avg_skip = true,
    delay = 0.2,
    id = 250006401,
    info_type = 0,
    step_type = 2
  },
  [250007101] = {
    avg_name = "23carnival_s07_1",
    avg_skip = true,
    delay = 0.2,
    id = 250007101,
    info_type = 0,
    step_type = 2
  },
  [260000000] = {
    avg_name = "45001171",
    avg_skip = true,
    delay = 0.2,
    id = 260000000,
    info_type = 0,
    step_type = 6
  },
  [260000101] = {
    avg_name = "45001172",
    avg_skip = true,
    delay = 0.2,
    id = 260000101,
    info_type = 0,
    step_type = 6
  },
  [260000201] = {
    avg_name = "45001173",
    avg_skip = true,
    delay = 0.2,
    id = 260000201,
    info_type = 0,
    step_type = 6
  },
  [260000301] = {
    avg_name = "45001174",
    avg_skip = true,
    delay = 0.2,
    id = 260000301,
    info_type = 0,
    step_type = 6
  },
  [260000401] = {
    avg_name = "45001175",
    avg_skip = true,
    delay = 0.2,
    id = 260000401,
    info_type = 0,
    step_type = 6
  },
  [260000501] = {
    avg_name = "45001176",
    avg_skip = true,
    delay = 0.2,
    id = 260000501,
    info_type = 0,
    step_type = 6
  },
  [260000601] = {
    avg_name = "45001177",
    avg_skip = true,
    delay = 0.2,
    id = 260000601,
    info_type = 0,
    step_type = 6
  },
  [260000701] = {
    avg_name = "45001178",
    avg_skip = true,
    delay = 0.2,
    id = 260000701,
    info_type = 0,
    step_type = 6
  },
  [260000801] = {
    avg_name = "45001179",
    avg_skip = true,
    delay = 0.2,
    id = 260000801,
    info_type = 0,
    step_type = 6
  },
  [260000901] = {
    avg_name = "45001180",
    avg_skip = true,
    delay = 0.2,
    id = 260000901,
    info_type = 0,
    step_type = 6
  },
  [260001001] = {
    avg_name = "45001181",
    avg_skip = true,
    delay = 0.2,
    id = 260001001,
    info_type = 0,
    step_type = 6
  },
  [260001101] = {
    avg_name = "45001182",
    avg_skip = true,
    delay = 0.2,
    id = 260001101,
    info_type = 0,
    step_type = 6
  },
  [260001201] = {
    avg_name = "45001183",
    avg_skip = true,
    delay = 0.2,
    id = 260001201,
    info_type = 0,
    step_type = 6
  },
  [260001301] = {
    delay = 0.0,
    id = 260001301,
    info = 284671,
    info_type = 1071,
    step_type = 4,
    wait_target = false
  },
  [260001302] = {
    delay = 0.0,
    id = 260001302,
    info = 209975,
    info_type = 1071,
    step_type = 4,
    wait_target = false
  },
  [260001303] = {
    delay = 0.0,
    id = 260001303,
    info = 388094,
    info_type = 1071,
    step_type = 4,
    wait_target = false
  },
  [260001304] = {
    delay = 0.0,
    id = 260001304,
    info = 465688,
    info_type = 1071,
    step_type = 4,
    wait_target = false
  },
  [260001401] = {
    delay = 0.0,
    id = 260001401,
    info = 16494,
    info_type = 1071,
    step_type = 4,
    wait_target = false
  },
  [260001402] = {
    delay = 0.0,
    id = 260001402,
    info = 455501,
    info_type = 1071,
    step_type = 4,
    wait_target = false
  },
  [260001501] = {
    delay = 1.5,
    id = 260001501,
    info = 241753,
    info_type = 1071,
    step_type = 4,
    wait_target = false
  },
  [260001502] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(1,2)",
    delay = 0.0,
    id = 260001502,
    info = 477584,
    info_type = 1071,
    step_type = 3,
    wait_target = false
  },
  [260001503] = {
    custom_code = "GuideUtil.StartBattleDeployClickGuide(5,2)",
    delay = 0.0,
    id = 260001503,
    info = 510488,
    info_type = 1071,
    step_type = 3,
    wait_target = false
  },
  [260001504] = {
    delay = 0.0,
    id = 260001504,
    info = 323732,
    info_type = 1071,
    step_type = 4,
    wait_target = false
  },
  [260001601] = {
    custom_code = "GuideUtil.StartCameraEffect(5,0.6,0)",
    delay = 0.0,
    id = 260001601,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [260001701] = {
    custom_code = "GuideUtil.BlockRoadByChipId(200100,3,1)",
    delay = 0.2,
    id = 260001701,
    info_type = 0,
    step_type = 3
  },
  [260001702] = {
    custom_code = "GuideUtil.BlockRoadByChipId(200101,3,2)",
    delay = 0.2,
    id = 260001702,
    info_type = 0,
    step_type = 3
  },
  [260001703] = {
    custom_code = "GuideUtil.BlockRoadByChipId(200102,3,2)",
    delay = 0.2,
    id = 260001703,
    info_type = 0,
    step_type = 3
  },
  [260001704] = {
    custom_code = "GuideUtil.AVGCheckCondition(200100,45001186,0)",
    delay = 0.2,
    id = 260001704,
    info_type = 0,
    step_type = 3
  },
  [260001705] = {
    custom_code = "GuideUtil.AVGCheckCondition(200101,45001193,0)",
    delay = 0.2,
    id = 260001705,
    info_type = 0,
    step_type = 3
  },
  [260001706] = {
    custom_code = "GuideUtil.AVGCheckCondition(200102,45001194,0)",
    delay = 0.2,
    id = 260001706,
    info_type = 0,
    step_type = 3
  },
  [260001801] = {
    custom_code = "GuideUtil.BlockRoadByChipId(200103,4,3)",
    delay = 0.2,
    id = 260001801,
    info_type = 0,
    step_type = 3
  },
  [260001802] = {
    custom_code = "GuideUtil.BlockRoadByChipId(200104,4,2)",
    delay = 0.2,
    id = 260001802,
    info_type = 0,
    step_type = 3
  },
  [260001803] = {
    custom_code = "GuideUtil.AVGCheckCondition(200103,45001187,0)",
    delay = 0.2,
    id = 260001803,
    info_type = 0,
    step_type = 3
  },
  [260001804] = {
    custom_code = "GuideUtil.AVGCheckCondition(200104,45001195,0)",
    delay = 0.2,
    id = 260001804,
    info_type = 0,
    step_type = 3
  },
  [260001805] = {
    custom_code = "GuideUtil.EndCheckCondition(200101)",
    delay = 0.2,
    id = 260001805,
    info_type = 0,
    step_type = 3
  },
  [260001806] = {
    custom_code = "GuideUtil.EndCheckCondition(200102)",
    delay = 0.2,
    id = 260001806,
    info_type = 0,
    step_type = 3
  },
  [260001901] = {
    custom_code = "GuideUtil.BlockRoadByChipId(200105,5,2)",
    delay = 0.2,
    id = 260001901,
    info_type = 0,
    step_type = 3
  },
  [260001902] = {
    custom_code = "GuideUtil.BlockRoadByChipId(200106,5,1)",
    delay = 0.2,
    id = 260001902,
    info_type = 0,
    step_type = 3
  },
  [260001903] = {
    custom_code = "GuideUtil.BlockRoadByChipId(200107,5,2)",
    delay = 0.2,
    id = 260001903,
    info_type = 0,
    step_type = 3
  },
  [260001904] = {
    custom_code = "GuideUtil.AVGCheckCondition(200105,45001196,0)",
    delay = 0.2,
    id = 260001904,
    info_type = 0,
    step_type = 3
  },
  [260001905] = {
    custom_code = "GuideUtil.AVGCheckCondition(200106,45001188,0)",
    delay = 0.2,
    id = 260001905,
    info_type = 0,
    step_type = 3
  },
  [260001906] = {
    custom_code = "GuideUtil.AVGCheckCondition(200107,45001197,0)",
    delay = 0.2,
    id = 260001906,
    info_type = 0,
    step_type = 3
  },
  [260001907] = {
    custom_code = "GuideUtil.EndCheckCondition(200104)",
    delay = 0.2,
    id = 260001907,
    info_type = 0,
    step_type = 3
  },
  [260002001] = {
    custom_code = "GuideUtil.AVGCheckCondition(200108,45001198,0)",
    delay = 0.2,
    id = 260002001,
    info_type = 0,
    step_type = 3
  },
  [260002002] = {
    custom_code = "GuideUtil.AVGCheckCondition(200109,45001189,0)",
    delay = 0.2,
    id = 260002002,
    info_type = 0,
    step_type = 3
  },
  [260002003] = {
    custom_code = "GuideUtil.EndCheckCondition(200105)",
    delay = 0.2,
    id = 260002003,
    info_type = 0,
    step_type = 3
  },
  [260002004] = {
    custom_code = "GuideUtil.EndCheckCondition(200107)",
    delay = 0.2,
    id = 260002004,
    info_type = 0,
    step_type = 3
  },
  [260002005] = {
    custom_code = "GuideUtil.AVGCheckCondition(200108,45001192,1)",
    delay = 0.2,
    id = 260002005,
    info_type = 0,
    step_type = 3
  },
  [260002101] = {
    avg_name = "45001189",
    avg_skip = true,
    delay = 0.2,
    id = 260002101,
    info_type = 0,
    step_type = 6
  },
  [260002201] = {
    custom_code = "GuideUtil.AVGCheckCondition(200109,45001192,0)",
    delay = 0.2,
    id = 260002201,
    info_type = 0,
    step_type = 3
  },
  [260002203] = {
    custom_code = "GuideUtil.BlockRoadByChipId(200108,6,3)",
    delay = 0.2,
    id = 260002203,
    info_type = 0,
    step_type = 3
  },
  [260002204] = {
    custom_code = "GuideUtil.BlockRoadByChipId(200109,6,2)",
    delay = 0.2,
    id = 260002204,
    info_type = 0,
    step_type = 3
  },
  [260002801] = {
    custom_size = __rt_6,
    delay = 1.2,
    id = 260002801,
    info = 192735,
    info_pos = "18",
    info_type = 1076,
    step_type = 5,
    target_name = "BattleHolder/FloorTileHolder/(2, 3)",
    target_parent = "006_Arena_015",
    target_type = 2
  },
  [260002802] = {
    custom_code = "GuideUtil.StartBattleDeployGuide(2,3,0,2)",
    delay = 0.2,
    id = 260002802,
    info = 412632,
    info_type = 1076,
    step_type = 3
  },
  [260002803] = {
    delay = 0.2,
    id = 260002803,
    info = 324447,
    info_type = 1076,
    step_type = 5,
    target_name = "GamePlayScore/Collect",
    target_parent = 204,
    target_type = 1
  },
  [260002804] = {
    avg_name = "45001061",
    avg_skip = true,
    delay = 0.2,
    id = 260002804,
    info_type = 0,
    step_type = 6
  },
  [260002805] = {
    delay = 0.2,
    id = 260002805,
    info = 33622,
    info_pos = "13",
    info_type = 1076,
    step_type = 4
  },
  [260002806] = {
    delay = 0.2,
    id = 260002806,
    info = 26293,
    info_pos = "13",
    info_type = 1076,
    step_type = 5,
    target_name = "Top/BuffListParent/BuffListScrollRect/BuffList",
    target_parent = 210,
    target_type = 1
  },
  [260002807] = {
    delay = 0.2,
    id = 260002807,
    info = 501263,
    info_pos = "13",
    info_type = 1076,
    step_type = 5,
    target_name = "return GuideUtil.GetEpRoomTarget(5,3)",
    target_type = 3
  },
  [260002808] = {
    delay = 0.2,
    id = 260002808,
    info = 442863,
    info_pos = "18",
    info_type = 1076,
    step_type = 4
  },
  [260002809] = {
    delay = 0.2,
    id = 260002809,
    info = 13864,
    info_type = 1076,
    step_type = 4
  },
  [260002810] = {
    custom_code = "GuideUtil.SetTimeScale(0)",
    delay = 0.2,
    id = 260002810,
    info_type = 0,
    step_type = 3
  },
  [260002811] = {
    custom_code = "GuideUtil.SetTimeScale(1)",
    delay = 0.2,
    id = 260002811,
    info_type = 0,
    step_type = 3
  },
  [260003201] = {
    avg_name = "45001094",
    avg_skip = true,
    delay = 0.2,
    id = 260003201,
    info_type = 0,
    step_type = 6
  },
  [260003301] = {
    avg_name = "45001081",
    avg_skip = true,
    delay = 0.2,
    id = 260003301,
    info_type = 0,
    step_type = 6
  },
  [260003401] = {
    avg_name = "45001152",
    avg_skip = true,
    delay = 0.2,
    id = 260003401,
    info_type = 0,
    step_type = 6
  },
  [260003501] = {
    avg_name = "45001155",
    avg_skip = true,
    delay = 0.2,
    id = 260003501,
    info_type = 0,
    step_type = 6
  },
  [260003601] = {
    avg_name = "45001156",
    avg_skip = true,
    delay = 0.2,
    id = 260003601,
    info_type = 0,
    step_type = 6
  },
  [450010101] = {
    condition = 32,
    delay = 1,
    id = 450010101,
    info = 104224,
    info_pos = "1",
    info_type = 1071,
    step_type = 4,
    wait_target = false
  },
  [450010102] = {
    id = 450010102,
    info = 205203,
    info_pos = "15",
    info_type = 1071,
    target_name = "SteinsGate_Interactive(Clone)(Clone)/Btn_Group",
    target_parent = 4306,
    target_type = 1
  },
  [450010103] = {
    custom_code = "GuideUtil.ActLobbyWaitPopInteractUI(nil,\"InteractNode/SteinsGateInteract(Clone)/interactItem_8\")",
    delay = 0.0,
    guide_skip = false,
    id = 450010103,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [450010104] = {
    id = 450010104,
    info = 107352,
    info_pos = "9",
    info_type = 1071,
    target_name = "InteractNode/SteinsGateInteract(Clone)/interactItem_8",
    target_parent = 600,
    target_type = 1
  },
  [500032101] = {
    avg_name = "33061031",
    avg_skip = true,
    delay = 0.2,
    id = 500032101,
    info_type = 0,
    step_type = 6
  },
  [500091101] = {
    custom_code = "GuideUtil.BlockRoadByChipId(200100,3,1)",
    delay = 0.2,
    id = 500091101,
    info_type = 0,
    step_type = 3
  },
  [500131101] = {
    custom_code = "GuideUtil.BlockRoadByChipId(200101,3,2)",
    delay = 0.2,
    id = 500131101,
    info_type = 0,
    step_type = 3
  },
  [500290101] = {
    condition = 29,
    delay = 0.0,
    id = 500290101,
    info = 160285,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [500290102] = {
    condition = 29,
    delay = 0.0,
    id = 500290102,
    info = 440435,
    info_pos = "3",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [500290103] = {
    condition = 29,
    delay = 0.3,
    id = 500290103,
    info = 48103,
    info_pos = "3",
    info_type = 1002,
    step_type = 5,
    target_name = "Down/Btn_Select/Tex_PageName",
    target_parent = 1685,
    target_type = 1
  },
  [500290104] = {
    condition = 29,
    delay = 0.3,
    id = 500290104,
    info = 325840,
    info_pos = "9",
    info_type = 1002,
    step_type = 5,
    target_name = "Main/StrategyList",
    target_parent = 1685,
    target_type = 1
  },
  [500290105] = {
    condition = 29,
    delay = 0.3,
    id = 500290105,
    info = 301624,
    info_pos = "10",
    info_type = 1002,
    step_type = 5,
    target_name = "Main/BuffList",
    target_parent = 1685,
    target_type = 1
  },
  [500290106] = {
    condition = 29,
    delay = 0.3,
    id = 500290106,
    info = 139443,
    info_pos = "3",
    info_type = 1002,
    target_name = "Down/Btn_Select",
    target_parent = 1685,
    target_type = 1
  },
  [501000101] = {
    avg_name = "22summer_p_1_1_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 501000101,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [501000102] = {
    delay = 0.0,
    id = 501000102,
    info = 404860,
    info_pos = "3",
    info_type = 1049,
    step_type = 4,
    wait_target = false
  },
  [501000103] = {
    custom_code = "GuideUtil.StartWarChessDeploy(1,2,2)",
    delay = 0.0,
    id = 501000103,
    info = 470764,
    info_pos = "1",
    info_type = 1028,
    step_type = 3,
    wait_target = false
  },
  [501000104] = {
    delay = 0.0,
    id = 501000104,
    info = 296523,
    info_pos = "1",
    info_type = 1028,
    step_type = 4,
    wait_target = false
  },
  [501000105] = {
    id = 501000105,
    info = 109110,
    info_pos = "3",
    info_type = 1049,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Deploy/Btn_BattleStart",
    target_parent = 3501,
    target_type = 1
  },
  [501000106] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,2)",
    delay = 0.0,
    id = 501000106,
    info = 403741,
    info_pos = "1",
    info_type = 1028,
    step_type = 3,
    wait_target = false
  },
  [501000107] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,2)",
    id = 501000107,
    info = 228639,
    info_pos = "1",
    info_type = 1028,
    step_type = 3,
    wait_target = false
  },
  [501000201] = {
    avg_name = "22summer_p_1_1_2",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 501000201,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [501000202] = {
    delay = 0.0,
    id = 501000202,
    info = 294463,
    info_pos = "15",
    info_type = 1052,
    step_type = 4,
    wait_target = false
  },
  [501000203] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,3)",
    delay = 0.0,
    id = 501000203,
    info = 178802,
    info_pos = "6",
    info_type = 1028,
    step_type = 3,
    wait_target = false
  },
  [501000204] = {
    delay = 0.0,
    id = 501000204,
    info = 444841,
    info_pos = "8",
    info_type = 1049,
    step_type = 4,
    wait_target = false
  },
  [501000205] = {
    id = 501000205,
    info = 196026,
    info_pos = "3",
    info_type = 1028,
    step_type = 5,
    target_name = "4_3/OpHolder/OpBtnGroup/1/Obj_ActionPoint",
    target_parent = 3502,
    target_type = 1
  },
  [501000206] = {
    id = 501000206,
    info = 391851,
    info_pos = "11",
    info_type = 1028,
    step_type = 5,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale",
    target_parent = 3501,
    target_type = 1
  },
  [501000207] = {
    delay = 0.0,
    id = 501000207,
    info = 141529,
    info_pos = "8",
    info_type = 1028,
    step_type = 4,
    wait_target = false
  },
  [501000208] = {
    id = 501000208,
    info = 61165,
    info_pos = "6",
    info_type = 1049,
    target_name = "4_3/OpHolder/OpBtnGroup/1",
    target_parent = 3502,
    target_type = 1
  },
  [501000301] = {
    delay = 0.0,
    id = 501000301,
    info = 458376,
    info_pos = "1",
    info_type = 1049,
    step_type = 4,
    wait_target = false
  },
  [501000302] = {
    delay = 0.0,
    id = 501000302,
    info = 453099,
    info_pos = "15",
    info_type = 1028,
    step_type = 4,
    wait_target = false
  },
  [501000303] = {
    delay = 0.0,
    id = 501000303,
    info = 149336,
    info_pos = "1",
    info_type = 1052,
    step_type = 4,
    wait_target = false
  },
  [501000304] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,3)",
    id = 501000304,
    info = 382586,
    info_pos = "15",
    info_type = 1028,
    step_type = 3,
    wait_target = false
  },
  [501000401] = {
    delay = 0.0,
    id = 501000401,
    info = 392633,
    info_pos = "8",
    info_type = 1049,
    step_type = 4,
    wait_target = false
  },
  [501000402] = {
    custom_size = __rt_6,
    id = 501000402,
    info = 515316,
    info_pos = "18",
    info_type = 1028,
    step_type = 5,
    target_name = "AreaRoot/0,0/5,2",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [501000403] = {
    custom_size = __rt_6,
    id = 501000403,
    info = 16042,
    info_pos = "6",
    info_type = 1052,
    step_type = 5,
    target_name = "AreaRoot/0,0/5,3",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [501000404] = {
    delay = 0.0,
    id = 501000404,
    info = 269276,
    info_pos = "18",
    info_type = 1049,
    step_type = 4,
    wait_target = false
  },
  [501000405] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,4)",
    id = 501000405,
    info = 360350,
    info_pos = "6",
    info_type = 1028,
    step_type = 3,
    wait_target = false
  },
  [501000501] = {
    delay = 0.0,
    id = 501000501,
    info = 47902,
    info_pos = "5",
    info_type = 1049,
    step_type = 4,
    wait_target = false
  },
  [501000502] = {
    delay = 0.0,
    id = 501000502,
    info = 261904,
    info_pos = "15",
    info_type = 1052,
    step_type = 4,
    wait_target = false
  },
  [501000503] = {
    delay = 0.0,
    id = 501000503,
    info = 380152,
    info_pos = "5",
    info_type = 1028,
    step_type = 4,
    wait_target = false
  },
  [501000504] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,4)",
    id = 501000504,
    info = 443617,
    info_pos = "15",
    info_type = 1052,
    step_type = 3,
    wait_target = false
  },
  [501000505] = {
    id = 501000505,
    info = 229372,
    info_pos = "5",
    info_type = 1028,
    step_type = 5,
    target_name = "6_4/OpHolder/OpBtnGroup/2/Obj_ActionPoint",
    target_parent = 3502,
    target_type = 1
  },
  [501000506] = {
    id = 501000506,
    info = 339743,
    info_pos = "1",
    info_type = 1028,
    step_type = 5,
    target_name = "1/TeamHolder/TeamInfo(Clone)/TeamAP",
    target_parent = 3502,
    target_type = 1
  },
  [501000507] = {
    id = 501000507,
    info = 443377,
    info_pos = "15",
    info_type = 1049,
    target_name = "6_4/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501000601] = {
    delay = 0.0,
    id = 501000601,
    info = 478672,
    info_pos = "5",
    info_type = 1052,
    step_type = 4,
    wait_target = false
  },
  [501000602] = {
    delay = 0.0,
    id = 501000602,
    info = 175846,
    info_pos = "1",
    info_type = 1049,
    step_type = 4,
    wait_target = false
  },
  [501000603] = {
    delay = 0.0,
    id = 501000603,
    info = 85783,
    info_pos = "5",
    info_type = 1052,
    step_type = 4,
    wait_target = false
  },
  [501000604] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,2)",
    id = 501000604,
    info = 469882,
    info_pos = "17",
    info_type = 1028,
    step_type = 3,
    wait_target = false
  },
  [501000701] = {
    avg_name = "22summer_p_1_2_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 501000701,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [501010101] = {
    avg_name = "22summer_p_1_2_2",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 501010101,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [501010102] = {
    delay = 1,
    guide_skip = false,
    id = 501010102,
    info = 477250,
    info_pos = "1",
    info_type = 1016,
    step_type = 4
  },
  [501010103] = {
    delay = 1,
    guide_skip = false,
    id = 501010103,
    info = 416826,
    info_pos = "1",
    info_type = 1050,
    step_type = 4
  },
  [501010104] = {
    guide_skip = false,
    id = 501010104,
    info = 487347,
    info_pos = "1",
    info_type = 1016,
    step_type = 4
  },
  [501010105] = {
    guide_skip = false,
    id = 501010105,
    info = 190738,
    info_pos = "1",
    info_type = 1016,
    step_type = 4
  },
  [501010106] = {
    custom_code = "GuideUtil.StartWarChessDeploy(1,1,1)",
    guide_skip = false,
    id = 501010106,
    info = 160492,
    info_pos = "1",
    info_type = 1051,
    step_type = 3
  },
  [501010107] = {
    custom_code = "GuideUtil.StartWarChessDeploy(2,5,1)",
    delay = 0.0,
    guide_skip = false,
    id = 501010107,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501010108] = {
    guide_skip = false,
    id = 501010108,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Deploy/Btn_BattleStart",
    target_parent = 3501,
    target_type = 1
  },
  [501010201] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,2)",
    guide_skip = false,
    id = 501010201,
    info = 12441,
    info_pos = "1",
    info_type = 1051,
    step_type = 3
  },
  [501010202] = {
    delay = 0.0,
    guide_skip = false,
    id = 501010202,
    info = 356527,
    info_pos = "1",
    info_type = 1016,
    step_type = 4,
    wait_target = false
  },
  [501010203] = {
    delay = 0.0,
    guide_skip = false,
    id = 501010203,
    info = 87897,
    info_pos = "1",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [501010204] = {
    delay = 0.0,
    guide_skip = false,
    id = 501010204,
    info = 162589,
    info_pos = "1",
    info_type = 1016,
    step_type = 4,
    wait_target = false
  },
  [501010205] = {
    delay = 0.0,
    guide_skip = false,
    id = 501010205,
    info = 460292,
    info_pos = "1",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [501010206] = {
    guide_skip = false,
    id = 501010206,
    info = 124872,
    info_pos = "1",
    info_type = 1016,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/2/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501010207] = {
    delay = 0.0,
    guide_skip = false,
    id = 501010207,
    info = 270410,
    info_pos = "1",
    info_type = 1051,
    step_type = 4,
    wait_target = false
  },
  [501010301] = {
    guide_skip = false,
    id = 501010301,
    info = 89880,
    info_pos = "1",
    info_type = 1051,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501010302] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,3)",
    delay = 0.0,
    guide_skip = false,
    id = 501010302,
    info = 262088,
    info_pos = "1",
    info_type = 1051,
    step_type = 3,
    wait_target = false
  },
  [501010303] = {
    delay = 0.0,
    guide_skip = false,
    id = 501010303,
    info = 411041,
    info_pos = "1",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [501010304] = {
    delay = 0.0,
    guide_skip = false,
    id = 501010304,
    info = 153278,
    info_pos = "1",
    info_type = 1016,
    step_type = 4,
    wait_target = false
  },
  [501010305] = {
    delay = 0.0,
    guide_skip = false,
    id = 501010305,
    info = 358792,
    info_pos = "1",
    info_type = 1051,
    step_type = 4,
    wait_target = false
  },
  [501010306] = {
    guide_skip = false,
    id = 501010306,
    info = 315221,
    info_pos = "1",
    info_type = 1016,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/2/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501010307] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,4)",
    guide_skip = false,
    id = 501010307,
    info = 53852,
    info_pos = "1",
    info_type = 1016,
    step_type = 3,
    wait_target = false
  },
  [501010308] = {
    delay = 0.0,
    guide_skip = false,
    id = 501010308,
    info = 154616,
    info_pos = "5",
    info_type = 1051,
    step_type = 4,
    wait_target = false
  },
  [501010309] = {
    delay = 1,
    guide_skip = false,
    id = 501010309,
    info = 60264,
    info_pos = "1",
    info_type = 1016,
    target_name = "4_4/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501010310] = {
    delay = 2,
    guide_skip = false,
    id = 501010310,
    info = 400897,
    info_pos = "1",
    info_type = 1016,
    target_name = "Frame/PropList/93002/Root/ItemHolder/Btn_Select",
    target_parent = 3531,
    target_type = 1
  },
  [501010311] = {
    delay = 0.0,
    guide_skip = false,
    id = 501010311,
    info = 161626,
    info_pos = "1",
    info_type = 1016,
    step_type = 4,
    wait_target = false
  },
  [501010312] = {
    guide_skip = false,
    id = 501010312,
    info = 76820,
    info_pos = "1",
    info_type = 1016,
    target_name = "Frame/TeamList/UINWarChessSelectTeam/1/Btn_Equip",
    target_parent = 3531,
    target_type = 1
  },
  [501010313] = {
    delay = 0.0,
    guide_skip = false,
    id = 501010313,
    info = 385734,
    info_pos = "1",
    info_type = 1051,
    step_type = 4,
    wait_target = false
  },
  [501010314] = {
    delay = 0.0,
    guide_skip = false,
    id = 501010314,
    info = 46088,
    info_pos = "1",
    info_type = 1051,
    step_type = 4,
    wait_target = false
  },
  [501010315] = {
    guide_skip = false,
    id = 501010315,
    info = 219195,
    info_pos = "1",
    info_type = 1050,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501010401] = {
    delay = 1,
    guide_skip = false,
    id = 501010401,
    info = 94482,
    info_pos = "1",
    info_type = 1051,
    step_type = 4,
    wait_target = false
  },
  [501010402] = {
    delay = 1,
    guide_skip = false,
    id = 501010402,
    info = 393169,
    info_pos = "1",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [501010403] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,4)",
    guide_skip = false,
    id = 501010403,
    info = 54430,
    info_pos = "1",
    info_type = 1016,
    step_type = 3,
    wait_target = false
  },
  [501010501] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,5)",
    delay = 0.0,
    guide_skip = false,
    id = 501010501,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501010601] = {
    delay = 1,
    guide_skip = false,
    id = 501010601,
    info = 47694,
    info_pos = "1",
    info_type = 1051,
    step_type = 4,
    wait_target = false
  },
  [501010602] = {
    delay = 1,
    guide_skip = false,
    id = 501010602,
    info = 55768,
    info_pos = "1",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [501010603] = {
    guide_skip = false,
    id = 501010603,
    info = 410695,
    info_pos = "1",
    info_type = 1016,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/Btn_TurnEnd",
    target_parent = 3501,
    target_type = 1
  },
  [501010604] = {
    delay = 1,
    guide_skip = false,
    id = 501010604,
    info = 337368,
    info_pos = "7",
    info_type = 1016,
    step_type = 4,
    wait_target = false
  },
  [501010605] = {
    delay = 1,
    guide_skip = false,
    id = 501010605,
    info = 43383,
    info_pos = "7",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [501010606] = {
    guide_skip = false,
    id = 501010606,
    info = 332306,
    info_pos = "7",
    info_type = 1051,
    target_name = "Frame/YesNoNode/ButtonYes",
    target_parent = 1200,
    target_type = 1
  },
  [501010607] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,6)",
    delay = 3,
    guide_skip = false,
    id = 501010607,
    info = 433864,
    info_pos = "1",
    info_type = 1016,
    step_type = 3,
    wait_target = false
  },
  [501010608] = {
    guide_skip = false,
    id = 501010608,
    info = 414041,
    info_pos = "1",
    info_type = 1051,
    target_name = "2_6/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501010609] = {
    guide_skip = false,
    id = 501010609,
    info = 354991,
    info_pos = "1",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [501010610] = {
    guide_skip = false,
    id = 501010610,
    info = 410505,
    info_pos = "1",
    info_type = 1016,
    step_type = 4,
    wait_target = false
  },
  [501010611] = {
    guide_skip = false,
    id = 501010611,
    info = 198811,
    info_pos = "1",
    info_type = 1016,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/2/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501010612] = {
    guide_skip = false,
    id = 501010612,
    info = 456460,
    info_pos = "1",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [501010701] = {
    avg_name = "22summer_p_1_3_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 501010701,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [501010801] = {
    guide_skip = false,
    id = 501010801,
    info = 299187,
    info_pos = "1",
    info_type = 1016,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501010802] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,2)",
    guide_skip = false,
    id = 501010802,
    info = 272649,
    info_pos = "1",
    info_type = 1050,
    step_type = 3,
    wait_target = false
  },
  [501010803] = {
    guide_skip = false,
    id = 501010803,
    info = 417713,
    info_pos = "1",
    info_type = 1051,
    target_name = "2_2/OpHolder/OpBtnGroup/1",
    target_parent = 3502,
    target_type = 1
  },
  [501020101] = {
    avg_name = "22summer_p_1_4_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 501020101,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [501020102] = {
    custom_code = "GuideUtil.StartWarChessDeploy(1,0,1)",
    delay = 0.0,
    guide_skip = false,
    id = 501020102,
    info = 116693,
    info_pos = "3",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [501020103] = {
    delay = 0.2,
    guide_skip = false,
    id = 501020103,
    info = 263390,
    info_pos = "3",
    info_type = 1053,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Deploy/Btn_BattleStart",
    target_parent = 3501,
    target_type = 1
  },
  [501020104] = {
    delay = 2,
    guide_skip = false,
    id = 501020104,
    info = 370764,
    info_pos = "3",
    info_type = 1048,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501020105] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,1)",
    guide_skip = false,
    id = 501020105,
    info = 65649,
    info_pos = "3",
    info_type = 1053,
    step_type = 3,
    wait_target = false
  },
  [501020106] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,1)",
    guide_skip = false,
    id = 501020106,
    info = 98118,
    info_pos = "3",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [501020107] = {
    guide_skip = false,
    id = 501020107,
    info = 300740,
    info_pos = "3",
    info_type = 1053,
    target_name = "2_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501020108] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,1)",
    guide_skip = false,
    id = 501020108,
    info = 26781,
    info_pos = "3",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [501020109] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,1)",
    guide_skip = false,
    id = 501020109,
    info = 246122,
    info_pos = "3",
    info_type = 1053,
    step_type = 3,
    wait_target = false
  },
  [501020110] = {
    guide_skip = false,
    id = 501020110,
    info = 436230,
    info_pos = "1",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [501020111] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020111,
    info = 218922,
    info_pos = "1",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [501020112] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020112,
    info = 503349,
    info_pos = "1",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [501020113] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020113,
    info = 140661,
    info_pos = "1",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [501020114] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,1)",
    guide_skip = false,
    id = 501020114,
    info = 449370,
    info_pos = "1",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [501020115] = {
    guide_skip = false,
    id = 501020115,
    info = 87440,
    info_pos = "1",
    info_type = 1048,
    target_name = "4_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501020116] = {
    guide_skip = false,
    id = 501020116,
    info = 324097,
    info_pos = "3",
    info_type = 1048,
    target_name = "Frame/EpStoreRoom/BuyNode/BuyList/Rect/GroupItem/StoreChipItem(Clone)",
    target_parent = 3506,
    target_type = 1
  },
  [501020117] = {
    guide_skip = false,
    id = 501020117,
    info = 448069,
    info_pos = "3",
    info_type = 1048,
    target_name = "Frame/UINWarChessSelectTeam/1/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [501020118] = {
    guide_skip = false,
    id = 501020118,
    info = 134831,
    info_pos = "3",
    info_type = 1053,
    target_name = "Frame/Btn_Return",
    target_parent = 3532,
    target_type = 1
  },
  [501020119] = {
    guide_skip = false,
    id = 501020119,
    info = 272164,
    info_pos = "3",
    info_type = 1048,
    target_name = "Frame/EpStoreRoom/Btn_Group/btn_Skip",
    target_parent = 3506,
    target_type = 1
  },
  [501020120] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,2)",
    guide_skip = false,
    id = 501020120,
    info = 428637,
    info_pos = "1",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [501020121] = {
    guide_skip = false,
    id = 501020121,
    info = 260854,
    info_pos = "1",
    info_type = 1053,
    target_name = "3_2/OpHolder/OpBtnGroup/1",
    target_parent = 3502,
    target_type = 1
  },
  [501020201] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,2)",
    guide_skip = false,
    id = 501020201,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501020202] = {
    guide_skip = false,
    id = 501020202,
    info_type = 0,
    target_name = "4_2/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501020203] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,2)",
    delay = 0.0,
    guide_skip = false,
    id = 501020203,
    info = 222030,
    info_pos = "16",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [501020204] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020204,
    info = 124541,
    info_pos = "16",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [501020205] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020205,
    info = 314970,
    info_pos = "16",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [501020206] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020206,
    info = 405947,
    info_pos = "16",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [501020207] = {
    delay = 1,
    guide_skip = false,
    id = 501020207,
    info = 119818,
    info_pos = "16",
    info_type = 1053,
    step_type = 4,
    target_type = 2
  },
  [501020208] = {
    guide_skip = false,
    id = 501020208,
    info = 55866,
    info_pos = "16",
    info_type = 1053,
    step_type = 4
  },
  [501020209] = {
    delay = 1,
    guide_skip = false,
    id = 501020209,
    info = 416959,
    info_pos = "1",
    info_type = 1048,
    step_type = 4
  },
  [501020210] = {
    delay = 1,
    guide_skip = false,
    id = 501020210,
    info = 16112,
    info_pos = "1",
    info_type = 1048,
    step_type = 4
  },
  [501020211] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,3)",
    guide_skip = false,
    id = 501020211,
    info = 322642,
    info_pos = "16",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [501020212] = {
    guide_skip = false,
    id = 501020212,
    info_type = 0,
    target_name = "2_3/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501020213] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,1)",
    guide_skip = false,
    id = 501020213,
    info = 194886,
    info_pos = "1",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [501020214] = {
    guide_skip = false,
    id = 501020214,
    info = 104009,
    info_pos = "1",
    info_type = 1048,
    target_name = "4_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501020215] = {
    guide_skip = false,
    id = 501020215,
    info = 10441,
    info_pos = "16",
    info_type = 1053,
    target_name = "Frame/EpStoreRoom/TradeTypeTile/Btn_ExchangeTypeItem",
    target_parent = 3506,
    target_type = 1
  },
  [501020216] = {
    guide_skip = false,
    id = 501020216,
    info = 286844,
    info_pos = "16",
    info_type = 1048,
    target_name = "Frame/EpStoreRoom/ExchangeNode/ExchangeList/Rect/GroupItem (1)/StoreBuffItem(Clone)",
    target_parent = 3506,
    target_type = 1
  },
  [501020217] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020217,
    info = 377050,
    info_pos = "16",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [501020218] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020218,
    info = 191794,
    info_pos = "16",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [501020219] = {
    guide_skip = false,
    id = 501020219,
    info = 178519,
    info_pos = "16",
    info_type = 1048,
    target_name = "Frame/EpStoreRoom/UINBuffDetail/btn_Buy",
    target_parent = 3506,
    target_type = 1
  },
  [501020220] = {
    guide_skip = false,
    id = 501020220,
    info_type = 0,
    target_name = "Frame/EpStoreRoom/Btn_Group/btn_Skip",
    target_parent = 3506,
    target_type = 1
  },
  [501020221] = {
    guide_skip = false,
    id = 501020221,
    info = 504418,
    info_pos = "5",
    info_type = 1048,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/Btn_TurnEnd",
    target_parent = 3501,
    target_type = 1
  },
  [501020222] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020222,
    info = 72743,
    info_pos = "5",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [501020223] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,3)",
    delay = 1,
    guide_skip = false,
    id = 501020223,
    info = 481384,
    info_pos = "5",
    info_type = 1048,
    step_type = 3,
    target_type = 2
  },
  [501020224] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020224,
    info = 464390,
    info_pos = "5",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [501020225] = {
    guide_skip = false,
    id = 501020225,
    info = 335998,
    info_pos = "5",
    info_type = 1053,
    target_name = "4_3/OpHolder/OpBtnGroup/1",
    target_parent = 3502,
    target_type = 1
  },
  [501020301] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020301,
    info = 211362,
    info_pos = "5",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [501020302] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,3)",
    delay = 0.0,
    guide_skip = false,
    id = 501020302,
    info = 246122,
    info_pos = "5",
    info_type = 1053,
    step_type = 3,
    wait_target = false
  },
  [501020303] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,3)",
    guide_skip = false,
    id = 501020303,
    info = 203643,
    info_pos = "5",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [501020304] = {
    guide_skip = false,
    id = 501020304,
    info = 343393,
    info_pos = "5",
    info_type = 1053,
    target_name = "5_3/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501020305] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,3)",
    guide_skip = false,
    id = 501020305,
    info = 130077,
    info_pos = "5",
    info_type = 1048,
    step_type = 3,
    target_type = 2
  },
  [501020306] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,3)",
    guide_skip = false,
    id = 501020306,
    info = 236447,
    info_pos = "5",
    info_type = 1053,
    step_type = 3,
    wait_target = false
  },
  [501020307] = {
    guide_skip = false,
    id = 501020307,
    info = 7815,
    info_pos = "5",
    info_type = 1048,
    target_name = "6_3/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501020308] = {
    avg_name = "22summer_p_1_5_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 501020308,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [501020309] = {
    delay = 1,
    guide_skip = false,
    id = 501020309,
    info = 480303,
    info_pos = "3",
    info_type = 1048,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/Btn_DeployNewTeam",
    target_parent = 3501,
    target_type = 1
  },
  [501020310] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020310,
    info = 470531,
    info_pos = "1",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [501020311] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020311,
    info = 290709,
    info_pos = "3",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [501020312] = {
    custom_code = "GuideUtil.StartWarChessDeploy(2,4,5)",
    delay = 0.0,
    guide_skip = false,
    id = 501020312,
    info = 122954,
    info_pos = "1",
    info_type = 1010,
    step_type = 3,
    wait_target = false
  },
  [501020313] = {
    guide_skip = false,
    id = 501020313,
    info = 265383,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/DynDeploy/Btn_ApplyDynDeploy",
    target_parent = 3501,
    target_type = 1
  },
  [501020314] = {
    guide_skip = false,
    id = 501020314,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/2/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501020315] = {
    guide_skip = false,
    id = 501020315,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/2/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501020316] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,5)",
    guide_skip = false,
    id = 501020316,
    info = 151404,
    info_pos = "16",
    info_type = 1010,
    step_type = 3,
    wait_target = false
  },
  [501020317] = {
    guide_skip = false,
    id = 501020317,
    info = 328681,
    info_pos = "11",
    info_type = 1010,
    target_name = "5_5/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501020318] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,5)",
    guide_skip = false,
    id = 501020318,
    info = 189339,
    info_pos = "11",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [501020319] = {
    guide_skip = false,
    id = 501020319,
    info_type = 0,
    target_name = "6_5/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501020320] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,4)",
    guide_skip = false,
    id = 501020320,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501020321] = {
    guide_skip = false,
    id = 501020321,
    info_type = 0,
    target_name = "6_4/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501020322] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(7,4)",
    guide_skip = false,
    id = 501020322,
    info = 411335,
    info_pos = "16",
    info_type = 1010,
    step_type = 3,
    wait_target = false
  },
  [501020323] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020323,
    info = 112125,
    info_pos = "16",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [501020324] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020324,
    info = 345724,
    info_pos = "11",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [501020325] = {
    guide_skip = false,
    id = 501020325,
    info = 411598,
    info_pos = "16",
    info_type = 1010,
    step_type = 5,
    target_name = "Top/ResList/Coin2",
    target_parent = 3501,
    target_type = 1
  },
  [501020326] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020326,
    info = 480327,
    info_pos = "11",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [501020327] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020327,
    info = 238749,
    info_pos = "16",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [501020328] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020328,
    info = 65468,
    info_pos = "16",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [501020329] = {
    guide_skip = false,
    id = 501020329,
    info = 160356,
    info_pos = "11",
    info_type = 1048,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501020330] = {
    guide_skip = false,
    id = 501020330,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501020331] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,2)",
    guide_skip = false,
    id = 501020331,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501020332] = {
    guide_skip = false,
    id = 501020332,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501020333] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,1)",
    guide_skip = false,
    id = 501020333,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501020334] = {
    guide_skip = false,
    id = 501020334,
    info_type = 0,
    target_name = "4_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501020335] = {
    guide_skip = false,
    id = 501020335,
    info_type = 0,
    target_name = "Frame/EpStoreRoom/BuyNode/BuyList/Rect/GroupItem/StoreChipItem(Clone)",
    target_parent = 3506,
    target_type = 1
  },
  [501020336] = {
    guide_skip = false,
    id = 501020336,
    info = 513433,
    info_pos = "9",
    info_type = 1048,
    target_name = "Frame/UINWarChessSelectTeam/2/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [501020337] = {
    guide_skip = false,
    id = 501020337,
    info = 224501,
    info_pos = "9",
    info_type = 1048,
    target_name = "Frame/UINWarChessSelectTeam/2/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [501020338] = {
    guide_skip = false,
    id = 501020338,
    info_type = 0,
    target_name = "Frame/UINWarChessSelectTeam/2/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [501020339] = {
    guide_skip = false,
    id = 501020339,
    info_type = 0,
    target_name = "Frame/UINWarChessSelectTeam/2/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [501020340] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020340,
    info = 32505,
    info_pos = "1",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [501020341] = {
    delay = 0.0,
    guide_skip = false,
    id = 501020341,
    info = 67427,
    info_pos = "1",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [501020401] = {
    avg_name = "22summer_p_1_5_2",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 501020401,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [501030101] = {
    avg_name = "22summer_p_1_6_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 501030101,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [501030102] = {
    delay = 0.0,
    guide_skip = false,
    id = 501030102,
    info = 26441,
    info_pos = "1",
    info_type = 1022,
    step_type = 4,
    wait_target = false
  },
  [501030103] = {
    custom_code = "GuideUtil.StartWarChessDeploy(1,1,1)",
    guide_skip = false,
    id = 501030103,
    info = 100188,
    info_pos = "1",
    step_type = 3,
    wait_target = false
  },
  [501030104] = {
    guide_skip = false,
    id = 501030104,
    info = 151680,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Deploy/Btn_BattleStart",
    target_parent = 3501,
    target_type = 1
  },
  [501030201] = {
    avg_name = "22summer_p_1_7_1",
    avg_skip = true,
    delay = 0.0,
    guide_skip = false,
    id = 501030201,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [501030301] = {
    delay = 0.0,
    guide_skip = false,
    id = 501030301,
    info = 474724,
    info_pos = "1",
    info_type = 1039,
    step_type = 4,
    wait_target = false
  },
  [501030302] = {
    delay = 0.0,
    guide_skip = false,
    id = 501030302,
    info = 387267,
    info_pos = "1",
    info_type = 1022,
    step_type = 4,
    wait_target = false
  },
  [501030303] = {
    guide_skip = false,
    id = 501030303,
    info = 162620,
    info_pos = "1",
    target_name = "Top/PressureBar",
    target_parent = 3501,
    target_type = 1
  },
  [501030304] = {
    guide_skip = false,
    id = 501030304,
    info = 110443,
    info_pos = "1",
    step_type = 4,
    wait_target = false
  },
  [501030305] = {
    guide_skip = false,
    id = 501030305,
    info = 176076,
    info_pos = "1",
    step_type = 4,
    wait_target = false
  },
  [501030306] = {
    guide_skip = false,
    id = 501030306,
    info = 192546,
    info_pos = "1",
    info_type = 1022,
    step_type = 4,
    wait_target = false
  },
  [501030307] = {
    guide_skip = false,
    id = 501030307,
    info = 464131,
    info_pos = "1",
    step_type = 4,
    wait_target = false
  },
  [501030308] = {
    guide_skip = false,
    id = 501030308,
    info = 416778,
    info_pos = "1",
    info_type = 1039,
    step_type = 4,
    wait_target = false
  },
  [501030309] = {
    guide_skip = false,
    id = 501030309,
    info = 170068,
    info_pos = "1",
    step_type = 4,
    wait_target = false
  },
  [501030310] = {
    guide_skip = false,
    id = 501030310,
    info = 18763,
    info_pos = "1",
    info_type = 1022,
    target_name = "PressureFrame/Pressure/Btn_Close",
    target_parent = 3501,
    target_type = 1
  },
  [501050101] = {
    custom_code = "GuideUtil.WCCameraFocus(4,1,0.5)",
    delay = 0,
    id = 501050101,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501050102] = {
    delay = 1,
    guide_skip = false,
    id = 501050102,
    info = 150182,
    info_type = 1003,
    step_type = 4,
    wait_target = false
  },
  [501050103] = {
    id = 501050103,
    info = 477185,
    info_pos = "1",
    info_type = 1002,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501050104] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,3)",
    id = 501050104,
    info = 61249,
    info_pos = "10",
    info_type = 1002,
    step_type = 3,
    wait_target = false
  },
  [501050105] = {
    id = 501050105,
    info = 241801,
    info_pos = "10",
    info_type = 1005,
    target_name = "4_3/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501050106] = {
    id = 501050106,
    info = 413803,
    info_pos = "1",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [501050107] = {
    id = 501050107,
    info = 224909,
    info_pos = "10",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [501050108] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,1)",
    id = 501050108,
    info = 371294,
    info_pos = "10",
    info_type = 1005,
    step_type = 3,
    wait_target = false
  },
  [501050109] = {
    id = 501050109,
    info = 115483,
    info_pos = "1",
    info_type = 1002,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501050110] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,2)",
    id = 501050110,
    info = 316146,
    info_pos = "10",
    info_type = 1003,
    step_type = 3,
    wait_target = false
  },
  [501050111] = {
    delay = 1,
    guide_skip = false,
    id = 501050111,
    info = 182209,
    info_type = 1003,
    step_type = 4,
    wait_target = false
  },
  [501050112] = {
    delay = 1,
    guide_skip = false,
    id = 501050112,
    info = 321408,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [501050113] = {
    delay = 1,
    guide_skip = false,
    id = 501050113,
    info = 321337,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [501050114] = {
    delay = 1,
    guide_skip = false,
    id = 501050114,
    info = 342007,
    info_type = 1003,
    step_type = 4,
    wait_target = false
  },
  [501050115] = {
    delay = 1,
    guide_skip = false,
    id = 501050115,
    info = 362788,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [501090101] = {
    custom_code = "GuideUtil.WCCameraFocus(2,2,0.5)",
    delay = 0,
    id = 501090101,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501090102] = {
    id = 501090102,
    info = 467758,
    info_pos = "1",
    info_type = 1002,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [501090103] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,3)",
    id = 501090103,
    info = 395590,
    info_pos = "10",
    info_type = 1002,
    step_type = 3,
    wait_target = false
  },
  [501090104] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,3)",
    id = 501090104,
    info = 101696,
    info_pos = "10",
    info_type = 1002,
    step_type = 3,
    wait_target = false
  },
  [501090105] = {
    id = 501090105,
    info = 65637,
    info_pos = "10",
    info_type = 1002,
    target_name = "1_3/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501090106] = {
    delay = 1,
    guide_skip = false,
    id = 501090106,
    info = 362788,
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [501150101] = {
    custom_code = "GuideUtil.WCCameraFocus(5,1,0.5)",
    id = 501150101,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501150102] = {
    custom_code = "GuideUtil.StartWarChessDeploy(1,5,1)",
    id = 501150102,
    info = 113387,
    info_pos = "1",
    info_type = 1057,
    step_type = 3,
    wait_target = false
  },
  [501150103] = {
    custom_code = "GuideUtil.WCCameraFocus(8,9,0.5)",
    id = 501150103,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501150104] = {
    custom_code = "GuideUtil.StartWarChessDeploy(2,8,9)",
    id = 501150104,
    info = 246837,
    info_pos = "1",
    info_type = 1003,
    step_type = 3,
    wait_target = false
  },
  [501150105] = {
    delay = 1,
    guide_skip = false,
    id = 501150105,
    info = 347508,
    info_type = 1057,
    step_type = 4,
    wait_target = false
  },
  [501150106] = {
    id = 501150106,
    info = 337152,
    info_type = 1003,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Deploy/Btn_BattleStart",
    target_parent = 3501,
    target_type = 1
  },
  [501150107] = {
    custom_code = "GuideUtil.WCCameraFocus(7,2,0.5)",
    id = 501150107,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501150108] = {
    delay = 1,
    guide_skip = false,
    id = 501150108,
    info = 292697,
    info_type = 1057,
    step_type = 4,
    wait_target = false
  },
  [501150109] = {
    custom_code = "GuideUtil.WCCameraFocus(7,9,0.5)",
    id = 501150109,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501150110] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(8,9)",
    id = 501150110,
    info = 178717,
    info_pos = "10",
    info_type = 1003,
    step_type = 3,
    wait_target = false
  },
  [501150111] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(7,9)",
    id = 501150111,
    info = 268716,
    info_pos = "10",
    info_type = 1003,
    step_type = 3,
    wait_target = false
  },
  [501150112] = {
    id = 501150112,
    info = 145436,
    info_pos = "10",
    info_type = 1003,
    target_name = "7_9/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501150113] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(7,9)",
    delay = 3,
    id = 501150113,
    info = 363286,
    info_pos = "10",
    info_type = 1003,
    step_type = 3,
    wait_target = false
  },
  [501150114] = {
    id = 501150114,
    info = 419722,
    info_pos = "10",
    info_type = 1003,
    target_name = "7_9/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501150115] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(7,9)",
    delay = 3,
    id = 501150115,
    info = 410200,
    info_pos = "10",
    info_type = 1057,
    step_type = 3,
    wait_target = false
  },
  [501150116] = {
    id = 501150116,
    info = 498836,
    info_pos = "10",
    info_type = 1003,
    target_name = "7_9/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501150117] = {
    delay = 1,
    guide_skip = false,
    id = 501150117,
    info = 216760,
    info_type = 1057,
    step_type = 4,
    wait_target = false
  },
  [501150118] = {
    delay = 1,
    guide_skip = false,
    id = 501150118,
    info = 447862,
    info_type = 1003,
    step_type = 4,
    wait_target = false
  },
  [501150201] = {
    delay = 1,
    guide_skip = false,
    id = 501150201,
    info = 323983,
    info_type = 1057,
    step_type = 4,
    wait_target = false
  },
  [501150202] = {
    custom_code = "GuideUtil.WCCameraFocus(10,7,0.5)",
    id = 501150202,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501150203] = {
    custom_size = __rt_6,
    id = 501150203,
    info = 117881,
    info_pos = "18",
    info_type = 1003,
    step_type = 5,
    target_name = "AreaRoot/0,0/11,6",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [501160101] = {
    custom_code = "GuideUtil.WCCameraFocus(4,2,0.5)",
    id = 501160101,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501160102] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,0)",
    id = 501160102,
    info = 224164,
    info_pos = "10",
    info_type = 1005,
    step_type = 3,
    wait_target = false
  },
  [501160103] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,0)",
    id = 501160103,
    info = 269429,
    info_pos = "10",
    info_type = 1055,
    step_type = 3,
    wait_target = false
  },
  [501160104] = {
    id = 501160104,
    info = 136069,
    info_pos = "10",
    info_type = 1055,
    target_name = "6_0/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501160105] = {
    delay = 1,
    guide_skip = false,
    id = 501160105,
    info = 449312,
    info_type = 1005,
    step_type = 4,
    wait_target = false
  },
  [501160106] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,0)",
    id = 501160106,
    info = 483102,
    info_pos = "10",
    info_type = 1055,
    step_type = 3,
    wait_target = false
  },
  [501160107] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,1)",
    id = 501160107,
    info = 227349,
    info_pos = "10",
    info_type = 1005,
    step_type = 3,
    wait_target = false
  },
  [501160108] = {
    id = 501160108,
    info = 213311,
    info_pos = "10",
    info_type = 1005,
    target_name = "4_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501160109] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,0)",
    id = 501160109,
    info = 60433,
    info_pos = "10",
    info_type = 1005,
    step_type = 3,
    wait_target = false
  },
  [501160110] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,0)",
    id = 501160110,
    info = 85903,
    info_pos = "10",
    info_type = 1055,
    step_type = 3,
    wait_target = false
  },
  [501160111] = {
    id = 501160111,
    info = 83278,
    info_pos = "10",
    info_type = 1055,
    target_name = "6_0/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [501160112] = {
    delay = 1,
    guide_skip = false,
    id = 501160112,
    info = 173633,
    info_type = 1005,
    step_type = 4,
    wait_target = false
  },
  [501200101] = {
    avg_name = "22summer_s16_t8",
    avg_skip = true,
    delay = 2,
    guide_skip = false,
    id = 501200101,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [501210101] = {
    avg_name = "22summer_s17_3",
    avg_skip = true,
    delay = 2,
    guide_skip = false,
    id = 501210101,
    info_type = 0,
    step_type = 2,
    wait_target = false
  },
  [501600100] = {
    custom_code = "GuideUtil.WCCameraFocus(1,0,0.5)",
    id = 501600100,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501600101] = {
    id = 501600101,
    info = 443074,
    info_pos = "11",
    info_type = 1005,
    step_type = 5,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale",
    target_parent = 3501,
    target_type = 1
  },
  [501600102] = {
    delay = 1,
    id = 501600102,
    info = 251296,
    info_pos = "11",
    info_type = 1055,
    step_type = 4,
    wait_target = false
  },
  [501600103] = {
    id = 501600103,
    info = 412052,
    info_pos = "11",
    info_type = 1055,
    step_type = 5,
    target_name = "Top/PressureBar",
    target_parent = 3501,
    target_type = 1
  },
  [501600104] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,0)",
    id = 501600104,
    info = 89731,
    info_pos = "7",
    info_type = 1005,
    step_type = 3,
    wait_target = false
  },
  [501600105] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,0)",
    id = 501600105,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [501600106] = {
    delay = 1,
    id = 501600106,
    info = 505047,
    info_pos = "7",
    info_type = 1055,
    step_type = 4,
    wait_target = false
  },
  [501600107] = {
    delay = 1,
    id = 501600107,
    info = 199014,
    info_pos = "7",
    info_type = 1005,
    step_type = 4,
    wait_target = false
  },
  [501600108] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,0)",
    id = 501600108,
    info = 113870,
    info_pos = "7",
    info_type = 1055,
    step_type = 3,
    wait_target = false
  },
  [501600109] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(0,0)",
    id = 501600109,
    info = 102847,
    info_pos = "7",
    info_type = 1055,
    step_type = 3,
    wait_target = false
  },
  [501600110] = {
    id = 501600110,
    info = 59264,
    info_pos = "7",
    info_type = 1055,
    step_type = 4,
    wait_target = false
  },
  [501600111] = {
    guide_skip = false,
    id = 501600111,
    info = 508551,
    info_pos = "1",
    info_type = 1055,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/Btn_TurnEnd",
    target_parent = 3501,
    target_type = 1,
    wait_target = false
  },
  [502010001] = {
    custom_code = "GuideUtil.WCCameraFocus(0,7,0.5)",
    id = 502010001,
    info_type = 0,
    step_type = 3
  },
  [502010002] = {
    delay = 0.0,
    id = 502010002,
    info = 458994,
    info_pos = "14",
    info_type = 1058,
    step_type = 4,
    wait_target = false
  },
  [502010003] = {
    delay = 0.0,
    id = 502010003,
    info = 464733,
    info_pos = "14",
    info_type = 1058,
    step_type = 4,
    wait_target = false
  },
  [502010004] = {
    delay = 0.0,
    id = 502010004,
    info = 385482,
    info_pos = "14",
    info_type = 1058,
    step_type = 4,
    wait_target = false
  },
  [502010100] = {
    custom_size = __rt_6,
    id = 502010100,
    info = 193274,
    info_pos = "7",
    info_type = 1058,
    step_type = 5,
    target_name = "AreaRoot/0,0/0,1",
    target_parent = "Test_WarChess",
    target_type = 2,
    wait_target = false
  },
  [502010101] = {
    custom_size = __rt_6,
    id = 502010101,
    info = 424239,
    info_pos = "7",
    info_type = 1058,
    step_type = 5,
    target_name = "AreaRoot/0,0/1,1",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [502010102] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(0,0)",
    id = 502010102,
    info = 308518,
    info_pos = "7",
    info_type = 1058,
    step_type = 3
  },
  [502010103] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(0,1)",
    delay = 0.25,
    id = 502010103,
    info = 420491,
    info_pos = "7",
    info_type = 1058,
    step_type = 3
  },
  [502010104] = {
    delay = 0.25,
    id = 502010104,
    info = 268020,
    info_pos = "7",
    info_type = 1058,
    target_name = "0_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [502010105] = {
    id = 502010105,
    info_type = 0,
    step_type = 4
  },
  [502010106] = {
    custom_code = "GuideUtil.WCCameraFocus(5,1,0.5)",
    id = 502010106,
    info_type = 0,
    step_type = 3
  },
  [502010107] = {
    custom_size = __rt_6,
    id = 502010107,
    info = 63575,
    info_pos = "7",
    info_type = 1058,
    step_type = 5,
    target_name = "AreaRoot/0,0/5,1",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [502010200] = {
    guide_skip = false,
    id = 502010200,
    info_pos = "7",
    info_type = 0,
    step_type = 4
  },
  [502010201] = {
    custom_size = __rt_6,
    delay = 0.0,
    guide_skip = false,
    id = 502010201,
    info = 341626,
    info_pos = "7",
    info_type = 1058,
    step_type = 5,
    target_name = "AreaRoot/0,0/6,2",
    target_parent = "Test_WarChess",
    target_type = 2,
    wait_target = false
  },
  [502010202] = {
    guide_skip = false,
    id = 502010202,
    info = 266974,
    info_pos = "7",
    info_type = 1058,
    step_type = 4,
    wait_target = false
  },
  [502010203] = {
    custom_size = __rt_6,
    delay = 0.0,
    guide_skip = false,
    id = 502010203,
    info = 95465,
    info_pos = "7",
    info_type = 1058,
    step_type = 5,
    target_name = "AreaRoot/0,0/6,3",
    target_parent = "Test_WarChess",
    target_type = 2,
    wait_target = false
  },
  [502010301] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,2)",
    delay = 0.0,
    guide_skip = false,
    id = 502010301,
    info = 225733,
    info_pos = "7",
    info_type = 1058,
    step_type = 3,
    wait_target = false
  },
  [502010302] = {
    guide_skip = false,
    id = 502010302,
    info_type = 0,
    target_name = "6_2/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1,
    wait_target = false
  },
  [502010303] = {
    delay = 0.0,
    guide_skip = false,
    id = 502010303,
    info = 197373,
    info_pos = "7",
    info_type = 1058,
    step_type = 4,
    wait_target = false
  },
  [502010304] = {
    custom_size = __rt_6,
    guide_skip = false,
    id = 502010304,
    info = 299916,
    info_pos = "7",
    info_type = 1058,
    step_type = 5,
    target_name = "AreaRoot/0,0/6,1",
    target_parent = "Test_WarChess",
    target_type = 2,
    wait_target = false
  },
  [502010305] = {
    custom_code = "GuideUtil.WCCameraFocus(0,1,0.5)",
    guide_skip = false,
    id = 502010305,
    info_type = 0,
    step_type = 3
  },
  [502010306] = {
    custom_size = __rt_6,
    guide_skip = false,
    id = 502010306,
    info = 194643,
    info_pos = "7",
    info_type = 1058,
    step_type = 5,
    target_name = "AreaRoot/0,0/0,1",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [502010307] = {
    custom_code = "GuideUtil.WCCameraFocus(6,1,0.5)",
    guide_skip = false,
    id = 502010307,
    info_type = 0,
    step_type = 3
  },
  [502010308] = {
    custom_size = __rt_6,
    guide_skip = false,
    id = 502010308,
    info = 279770,
    info_pos = "7",
    info_type = 1058,
    step_type = 5,
    target_name = "AreaRoot/0,0/6,1",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [502050101] = {
    custom_size = __rt_6,
    delay = 0.0,
    guide_skip = false,
    id = 502050101,
    info = 80683,
    info_pos = "1",
    info_type = 1058,
    step_type = 5,
    target_name = "AreaRoot/0,0/6,0",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [502050102] = {
    guide_skip = false,
    id = 502050102,
    info = 486930,
    info_pos = "1",
    info_type = 1058,
    step_type = 4
  },
  [502050201] = {
    guide_skip = false,
    id = 502050201,
    info = 521997,
    info_pos = "7",
    info_type = 1058,
    step_type = 4
  },
  [502050202] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,5)",
    delay = 0.0,
    guide_skip = false,
    id = 502050202,
    info = 487513,
    info_pos = "7",
    info_type = 1058,
    step_type = 3
  },
  [502050203] = {
    delay = 0.25,
    guide_skip = false,
    id = 502050203,
    info = 68882,
    info_pos = "7",
    info_type = 1058,
    target_name = "6_5/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [502050204] = {
    custom_code = "GuideUtil.WCCameraFocus(6,7,0.5)",
    guide_skip = false,
    id = 502050204,
    info_type = 0,
    step_type = 3
  },
  [502050205] = {
    custom_size = __rt_6,
    delay = 0.0,
    guide_skip = false,
    id = 502050205,
    info = 103406,
    info_pos = "7",
    info_type = 1058,
    step_type = 5,
    target_name = "AreaRoot/0,0/6,7",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [502050206] = {
    guide_skip = false,
    id = 502050206,
    info = 259925,
    info_pos = "7",
    info_type = 1058,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/Btn_DeployNewTeam",
    target_parent = 3501,
    target_type = 1
  },
  [502050207] = {
    guide_skip = false,
    id = 502050207,
    info = 336721,
    info_pos = "7",
    info_type = 1058,
    step_type = 5,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Team/Mask/Rect/2",
    target_parent = 3501,
    target_type = 1
  },
  [503000101] = {
    custom_code = "GuideUtil.WCCameraFocus(2,0,0.5)",
    id = 503000101,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [503000102] = {
    id = 503000102,
    info = 154821,
    info_pos = "7",
    info_type = 1059,
    step_type = 4,
    wait_target = false
  },
  [503000103] = {
    id = 503000103,
    info = 415365,
    info_pos = "11",
    info_type = 1059,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [503000104] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,0)",
    id = 503000104,
    info = 508106,
    info_pos = "7",
    info_type = 1059,
    step_type = 3,
    wait_target = false
  },
  [503000105] = {
    id = 503000105,
    info = 172070,
    info_pos = "7",
    info_type = 1059,
    step_type = 4,
    wait_target = false
  },
  [503000106] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,0)",
    id = 503000106,
    info = 208259,
    info_pos = "7",
    info_type = 1059,
    step_type = 3,
    wait_target = false
  },
  [503000107] = {
    custom_size = __rt_6,
    id = 503000107,
    info = 336617,
    info_pos = "18",
    info_type = 1059,
    step_type = 5,
    target_name = "AreaRoot/0,0/1,0",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [503000108] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,0)",
    id = 503000108,
    info = 25168,
    info_pos = "7",
    info_type = 1059,
    step_type = 3,
    wait_target = false
  },
  [503000109] = {
    id = 503000109,
    info = 468705,
    info_pos = "7",
    info_type = 1059,
    step_type = 4,
    wait_target = false
  },
  [503000201] = {
    id = 503000201,
    info = 394153,
    info_pos = "7",
    info_type = 1059,
    step_type = 4,
    wait_target = false
  },
  [503000202] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,3)",
    id = 503000202,
    info = 470521,
    info_pos = "7",
    info_type = 1059,
    step_type = 3,
    wait_target = false
  },
  [503000203] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,4)",
    id = 503000203,
    info = 228769,
    info_pos = "7",
    info_type = 1059,
    step_type = 3,
    wait_target = false
  },
  [503000204] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,4)",
    id = 503000204,
    info = 465911,
    info_pos = "7",
    info_type = 1059,
    step_type = 3,
    wait_target = false
  },
  [503000205] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,3)",
    id = 503000205,
    info = 481334,
    info_pos = "7",
    info_type = 1059,
    step_type = 3,
    wait_target = false
  },
  [503000206] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,3)",
    id = 503000206,
    info = 309270,
    info_pos = "7",
    info_type = 1059,
    step_type = 3,
    wait_target = false
  },
  [503000207] = {
    id = 503000207,
    info = 145819,
    info_pos = "7",
    info_type = 1059,
    step_type = 4,
    wait_target = false
  },
  [503000208] = {
    id = 503000208,
    info = 522715,
    info_pos = "7",
    info_type = 1059,
    step_type = 4,
    wait_target = false
  },
  [504000000] = {
    avg_name = "cpt_dupin_chess_prologue",
    avg_skip = true,
    delay = 0.4,
    guide_skip = false,
    id = 504000000,
    info_type = 0,
    step_type = 2
  },
  [504000101] = {
    custom_code = "GuideUtil.WCCameraFocus(2,4,0.5)",
    id = 504000101,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [504000102] = {
    custom_size = {600, 600},
    id = 504000102,
    info = 76355,
    info_pos = "1",
    info_type = 1060,
    step_type = 5,
    target_name = "AreaRoot/0,0/2,4",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [504000103] = {
    custom_code = "GuideUtil.WCCameraFocus(4,0,0.5)",
    id = 504000103,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [504000104] = {
    custom_size = {800, 200},
    id = 504000104,
    info = 62874,
    info_pos = "1",
    info_type = 1060,
    step_type = 5,
    target_name = "AreaRoot/0,0/4,0",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [504000105] = {
    id = 504000105,
    info = 354685,
    info_pos = "1",
    info_type = 1060,
    step_type = 4,
    wait_target = false
  },
  [504000106] = {
    custom_code = "GuideUtil.StartWarChessDeploy(2,1,0)",
    id = 504000106,
    info = 466734,
    info_pos = "1",
    info_type = 1060,
    step_type = 3,
    wait_target = false
  },
  [504000107] = {
    id = 504000107,
    info = 425731,
    info_type = 1060,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Deploy/Btn_BattleStart",
    target_parent = 3501,
    target_type = 1
  },
  [504000108] = {
    custom_code = "GuideUtil.WCCameraFocus(2,4,0.5)",
    id = 504000108,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [504000109] = {
    custom_size = __rt_6,
    id = 504000109,
    info = 507884,
    info_pos = "18",
    info_type = 1060,
    step_type = 5,
    target_name = "AreaRoot/0,0/1,5",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [504000110] = {
    custom_code = "GuideUtil.WCCameraFocus(4,0,0.5)",
    id = 504000110,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [504000111] = {
    custom_size = __rt_6,
    id = 504000111,
    info = 422911,
    info_pos = "18",
    info_type = 1060,
    step_type = 5,
    target_name = "AreaRoot/0,0/2,0",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [504000112] = {
    custom_code = "GuideUtil.WCCameraFocus(3,3,0.5)",
    id = 504000112,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [504000113] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,3)",
    id = 504000113,
    info = 24182,
    info_pos = "1",
    info_type = 1060,
    step_type = 3,
    wait_target = false
  },
  [504000114] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,5)",
    id = 504000114,
    info = 492400,
    info_pos = "7",
    info_type = 1060,
    step_type = 3,
    wait_target = false
  },
  [504000115] = {
    id = 504000115,
    info = 114275,
    info_pos = "10",
    info_type = 1060,
    target_name = "1_5/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [504000201] = {
    custom_code = "GuideUtil.WCCameraFocus(3,1,0.5)",
    id = 504000201,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [504000202] = {
    custom_size = __rt_6,
    id = 504000202,
    info = 131985,
    info_pos = "18",
    info_type = 1060,
    step_type = 5,
    target_name = "AreaRoot/0,0/2,0",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [504000203] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,0)",
    id = 504000203,
    info = 86215,
    info_pos = "1",
    info_type = 1060,
    step_type = 3,
    wait_target = false
  },
  [504000204] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,0)",
    id = 504000204,
    info = 503492,
    info_pos = "7",
    info_type = 1060,
    step_type = 3,
    wait_target = false
  },
  [504000205] = {
    id = 504000205,
    info = 481207,
    info_pos = "10",
    info_type = 1060,
    target_name = "3_0/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [504000301] = {
    id = 504000301,
    info = 92260,
    info_pos = "18",
    info_type = 1060,
    step_type = 4,
    wait_target = false
  },
  [504000401] = {
    avg_name = "cpt_dupin_chess_end",
    avg_skip = true,
    delay = 0.4,
    guide_skip = false,
    id = 504000401,
    info_type = 0,
    step_type = 2
  },
  [505000000] = {
    avg_name = "cpt_undline_chess_prologue",
    avg_skip = true,
    delay = 0.4,
    guide_skip = false,
    id = 505000000,
    info_type = 0,
    step_type = 2
  },
  [505000101] = {
    custom_code = "GuideUtil.WCCameraFocus(2,0,0.5)",
    id = 505000101,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [505000102] = {
    id = 505000102,
    info = 274210,
    info_pos = "7",
    info_type = 1061,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [505000103] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,1)",
    id = 505000103,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [505000104] = {
    id = 505000104,
    info = 507863,
    info_pos = "7",
    info_type = 1061,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1,
    wait_target = false
  },
  [505000201] = {
    custom_code = "GuideUtil.WCCameraFocus(6,5,0.5)",
    id = 505000201,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [505000202] = {
    id = 505000202,
    info = 449994,
    info_pos = "7",
    info_type = 1061,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [505000203] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,5)",
    id = 505000203,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [505000204] = {
    id = 505000204,
    info = 252288,
    info_pos = "7",
    info_type = 1061,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1,
    wait_target = false
  },
  [505000205] = {
    custom_code = "GuideUtil.WCCameraFocus(4,5,0.5)",
    id = 505000205,
    info = 216068,
    info_pos = "7",
    info_type = 1061,
    step_type = 3,
    wait_target = false
  },
  [505000206] = {
    custom_code = "GuideUtil.WCCameraFocus(4,5,0.5)",
    id = 505000206,
    info = 216068,
    info_pos = "7",
    info_type = 1061,
    step_type = 4,
    wait_target = false
  },
  [505000207] = {
    custom_code = "GuideUtil.WCCameraFocus(8,5,0.5)",
    id = 505000207,
    info = 508755,
    info_pos = "7",
    info_type = 1061,
    step_type = 3,
    wait_target = false
  },
  [505000208] = {
    custom_code = "GuideUtil.WCCameraFocus(8,5,0.5)",
    id = 505000208,
    info = 508755,
    info_pos = "7",
    info_type = 1061,
    step_type = 4,
    wait_target = false
  },
  [505000301] = {
    avg_name = "cpt_undline_chess_end",
    avg_skip = true,
    delay = 0.4,
    guide_skip = false,
    id = 505000301,
    info_type = 0,
    step_type = 2
  },
  [506000000] = {
    avg_name = "cpt_jiangyu_chess_601_0",
    avg_skip = true,
    delay = 0.4,
    guide_skip = false,
    id = 506000000,
    info_type = 0,
    step_type = 2
  },
  [506000100] = {
    delay = 1,
    guide_skip = false,
    id = 506000100,
    info = 283082,
    info_type = 1062,
    step_type = 4,
    wait_target = false
  },
  [506000101] = {
    custom_size = __rt_6,
    id = 506000101,
    info = 200051,
    info_pos = "7",
    info_type = 1062,
    step_type = 5,
    target_name = "AreaRoot/0,0/3,0",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [506000102] = {
    id = 506000102,
    info = 432480,
    info_pos = "7",
    info_type = 1062,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [506000103] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,0)",
    id = 506000103,
    info = 522261,
    info_pos = "7",
    info_type = 1062,
    step_type = 3
  },
  [506000104] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,0)",
    id = 506000104,
    info = 47824,
    info_pos = "7",
    info_type = 1062,
    step_type = 3
  },
  [506000200] = {
    avg_name = "cpt_jiangyu_chess_602_0",
    avg_skip = true,
    delay = 0.4,
    guide_skip = false,
    id = 506000200,
    info_type = 0,
    step_type = 2
  },
  [506000301] = {
    custom_size = __rt_6,
    id = 506000301,
    info = 19558,
    info_pos = "7",
    info_type = 1062,
    step_type = 5,
    target_name = "AreaRoot/0,0/2,0",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [506000302] = {
    delay = 1,
    guide_skip = false,
    id = 506000302,
    info = 347718,
    info_type = 1062,
    step_type = 4,
    wait_target = false
  },
  [506000303] = {
    delay = 1,
    guide_skip = false,
    id = 506000303,
    info = 350393,
    info_type = 1062,
    step_type = 4,
    wait_target = false
  },
  [506000304] = {
    id = 506000304,
    info = 180774,
    info_pos = "7",
    info_type = 1062,
    step_type = 5,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1
  },
  [506000305] = {
    id = 506000305,
    info = 353657,
    info_pos = "7",
    info_type = 1062,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [506000306] = {
    id = 506000306,
    info = 195001,
    info_pos = "7",
    info_type = 1062,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1
  },
  [506000307] = {
    id = 506000307,
    info = 387934,
    info_pos = "7",
    info_type = 1062,
    target_name = "3DUIRoot/UI_WarChessJumpSystem/JumpNode/btn_right",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [506000308] = {
    id = 506000308,
    info = 67756,
    info_pos = "7",
    info_type = 1062,
    step_type = 4
  },
  [506000309] = {
    custom_size = {500, 500},
    id = 506000309,
    info = 310047,
    info_pos = "7",
    info_type = 1062,
    step_type = 5,
    target_name = "AreaRoot/0,0/4,0",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [506000310] = {
    id = 506000310,
    info = 297616,
    info_pos = "7",
    info_type = 1062,
    step_type = 5,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1
  },
  [506000400] = {
    avg_name = "cpt_jiangyu_chess_603_0",
    avg_skip = true,
    delay = 0.4,
    guide_skip = false,
    id = 506000400,
    info_type = 0,
    step_type = 2
  },
  [507000000] = {
    delay = 1,
    id = 507000000,
    info = 9633,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [507000001] = {
    delay = 1,
    id = 507000001,
    info = 234982,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [507000002] = {
    delay = 1,
    id = 507000002,
    info = 419152,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [507000003] = {
    delay = 1,
    id = 507000003,
    info = 97216,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [507000004] = {
    id = 507000004,
    info = 353657,
    info_pos = "7",
    info_type = 1063,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [507000005] = {
    id = 507000005,
    info = 99396,
    info_pos = "7",
    info_type = 1063,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1
  },
  [507000006] = {
    delay = 1,
    id = 507000006,
    info = 110589,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [507000007] = {
    id = 507000007,
    info = 45854,
    info_pos = "7",
    info_type = 1063,
    step_type = 5,
    target_name = "GoalNode/GoalAll/GoalSuccItem",
    target_parent = 3501,
    target_type = 1
  },
  [507000008] = {
    custom_size = __rt_6,
    id = 507000008,
    info = 48198,
    info_pos = "7",
    info_type = 1063,
    step_type = 5,
    target_name = "AreaRoot/0,0/0,0",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [507000009] = {
    custom_size = __rt_6,
    id = 507000009,
    info = 302380,
    info_pos = "7",
    info_type = 1063,
    step_type = 5,
    target_name = "AreaRoot/0,0/0,1",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [507000010] = {
    delay = 1,
    id = 507000010,
    info = 226322,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [507000011] = {
    id = 507000011,
    info = 84704,
    info_pos = "7",
    info_type = 1063,
    step_type = 5,
    target_name = "GoalNode/GoalAll/GoalSuccItem",
    target_parent = 3501,
    target_type = 1
  },
  [507000012] = {
    custom_code = "GuideUtil.WCCameraFocus(6,3,0.5)",
    id = 507000012,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [507000013] = {
    custom_size = __rt_6,
    id = 507000013,
    info = 277293,
    info_pos = "7",
    info_type = 1063,
    step_type = 5,
    target_name = "AreaRoot/0,0/6,3",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [507000014] = {
    delay = 1,
    id = 507000014,
    info = 58009,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [507000015] = {
    delay = 1,
    id = 507000015,
    info = 323682,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [507000016] = {
    custom_code = "GuideUtil.WCCameraFocus(0,0,0.5)",
    id = 507000016,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [507000017] = {
    delay = 1,
    id = 507000017,
    info = 314108,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [508000000] = {
    delay = 0.0,
    id = 508000000,
    info = 159898,
    info_pos = "1",
    info_type = 1043,
    step_type = 4,
    wait_target = false
  },
  [508000001] = {
    delay = 0.0,
    id = 508000001,
    info = 493925,
    info_pos = "1",
    info_type = 1043,
    step_type = 4,
    wait_target = false
  },
  [508000002] = {
    custom_code = "GuideUtil.StartWarChessDeploy(1,2,2)",
    delay = 0.0,
    id = 508000002,
    info = 94050,
    info_pos = "1",
    info_type = 1043,
    step_type = 3,
    wait_target = false
  },
  [508000003] = {
    delay = 0.0,
    id = 508000003,
    info = 29062,
    info_pos = "1",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [508000004] = {
    id = 508000004,
    info = 88778,
    info_pos = "1",
    info_type = 1043,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Deploy/Btn_BattleStart",
    target_parent = 3501,
    target_type = 1
  },
  [508000005] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,2)",
    delay = 0.0,
    id = 508000005,
    info = 340342,
    info_pos = "1",
    info_type = 1010,
    step_type = 3,
    wait_target = false
  },
  [508000006] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,2)",
    id = 508000006,
    info = 210052,
    info_pos = "1",
    info_type = 1043,
    step_type = 3,
    wait_target = false
  },
  [508000007] = {
    delay = 0.0,
    id = 508000007,
    info = 417372,
    info_pos = "15",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [508000008] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,3)",
    delay = 0.0,
    id = 508000008,
    info = 57471,
    info_pos = "1",
    info_type = 1043,
    step_type = 3,
    wait_target = false
  },
  [508000009] = {
    id = 508000009,
    info = 220439,
    info_pos = "1",
    info_type = 1043,
    step_type = 5,
    target_name = "UINWCEnemyDetail/Layout",
    target_parent = 3503,
    target_type = 1
  },
  [508000010] = {
    id = 508000010,
    info = 105950,
    info_pos = "1",
    info_type = 1043,
    step_type = 5,
    target_name = "4_3/OpHolder/OpBtnGroup/1/Obj_ActionPoint",
    target_parent = 3502,
    target_type = 1
  },
  [508000011] = {
    id = 508000011,
    info = 193301,
    info_pos = "1",
    info_type = 1043,
    step_type = 5,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale",
    target_parent = 3501,
    target_type = 1
  },
  [508000012] = {
    id = 508000012,
    info = 247675,
    info_pos = "1",
    info_type = 1010,
    target_name = "4_3/OpHolder/OpBtnGroup/1",
    target_parent = 3502,
    target_type = 1
  },
  [508000013] = {
    custom_code = "GuideUtil.WCCameraFocus(3,3,0.5)",
    id = 508000013,
    info_type = 0,
    step_type = 3
  },
  [508000014] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,3)",
    delay = 0.0,
    id = 508000014,
    info = 196521,
    info_pos = "1",
    info_type = 1043,
    step_type = 3,
    wait_target = false
  },
  [508000015] = {
    custom_size = __rt_6,
    id = 508000015,
    info = 146604,
    info_pos = "1",
    info_type = 1010,
    step_type = 5,
    target_name = "AreaRoot/0,0/5,2",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [508000016] = {
    custom_size = __rt_6,
    id = 508000016,
    info = 480839,
    info_pos = "15",
    info_type = 1010,
    step_type = 5,
    target_name = "AreaRoot/0,0/5,3",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [508000017] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,4)",
    id = 508000017,
    info = 433931,
    info_pos = "17",
    info_type = 1043,
    step_type = 3,
    wait_target = false
  },
  [508000018] = {
    delay = 0.0,
    id = 508000018,
    info = 139464,
    info_pos = "15",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [508000019] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,4)",
    delay = 0.0,
    id = 508000019,
    info_pos = "1",
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [508000020] = {
    id = 508000020,
    info = 274095,
    info_pos = "15",
    info_type = 1043,
    step_type = 5,
    target_name = "6_4/OpHolder/OpBtnGroup/2/Obj_ActionPoint",
    target_parent = 3502,
    target_type = 1
  },
  [508000021] = {
    id = 508000021,
    info = 186649,
    info_pos = "15",
    info_type = 1010,
    target_name = "6_4/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [508000022] = {
    delay = 0.0,
    id = 508000022,
    info = 331241,
    info_pos = "15",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [508000023] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,2)",
    id = 508000023,
    info = 210046,
    info_pos = "1",
    info_type = 1043,
    step_type = 3,
    wait_target = false
  },
  [508011001] = {
    delay = 1,
    guide_skip = false,
    id = 508011001,
    info = 227072,
    info_pos = "1",
    info_type = 1043,
    step_type = 4
  },
  [508011002] = {
    delay = 1,
    guide_skip = false,
    id = 508011002,
    info = 440564,
    info_pos = "5",
    info_type = 1022,
    step_type = 4
  },
  [508011003] = {
    custom_code = "GuideUtil.StartWarChessDeploy(1,1,1)",
    guide_skip = false,
    id = 508011003,
    info = 509541,
    info_pos = "1",
    info_type = 1043,
    step_type = 3
  },
  [508011004] = {
    custom_code = "GuideUtil.StartWarChessDeploy(2,5,1)",
    guide_skip = false,
    id = 508011004,
    info_pos = "5",
    info_type = 0,
    step_type = 3
  },
  [508011005] = {
    guide_skip = false,
    id = 508011005,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Deploy/Btn_BattleStart",
    target_parent = 3501,
    target_type = 1
  },
  [508011006] = {
    guide_skip = false,
    id = 508011006,
    info = 74741,
    info_pos = "1",
    info_type = 1010,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [508011007] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,2)",
    guide_skip = false,
    id = 508011007,
    info = 305090,
    info_pos = "1",
    info_type = 1010,
    step_type = 3,
    wait_target = false
  },
  [508011008] = {
    guide_skip = false,
    id = 508011008,
    info = 147787,
    info_pos = "1",
    info_type = 1010,
    target_name = "2_2/OpHolder/OpBtnGroup/1",
    target_parent = 3502,
    target_type = 1
  },
  [508011009] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,2)",
    guide_skip = false,
    id = 508011009,
    info = 312115,
    info_pos = "1",
    info_type = 1010,
    step_type = 3
  },
  [508011010] = {
    delay = 0.0,
    guide_skip = false,
    id = 508011010,
    info = 252319,
    info_pos = "1",
    info_type = 1043,
    step_type = 4,
    wait_target = false
  },
  [508011011] = {
    guide_skip = false,
    id = 508011011,
    info = 439325,
    info_pos = "1",
    info_type = 1043,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/2/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [508011012] = {
    delay = 0.0,
    guide_skip = false,
    id = 508011012,
    info = 2669,
    info_pos = "5",
    info_type = 1022,
    step_type = 4,
    wait_target = false
  },
  [508012000] = {
    custom_code = "GuideUtil.WCCameraFocus(4,3,0.5)",
    delay = 0.0,
    guide_skip = false,
    id = 508012000,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [508012001] = {
    delay = 0.0,
    guide_skip = false,
    id = 508012001,
    info = 450869,
    info_pos = "5",
    info_type = 1022,
    step_type = 4,
    wait_target = false
  },
  [508012002] = {
    delay = 0.0,
    guide_skip = false,
    id = 508012002,
    info = 384548,
    info_pos = "1",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [508012003] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,4)",
    guide_skip = false,
    id = 508012003,
    info = 346141,
    info_pos = "5",
    info_type = 1043,
    step_type = 3,
    wait_target = false
  },
  [508012004] = {
    delay = 0.0,
    guide_skip = false,
    id = 508012004,
    info = 337573,
    info_pos = "5",
    info_type = 1043,
    step_type = 4,
    wait_target = false
  },
  [508012005] = {
    delay = 1,
    guide_skip = false,
    id = 508012005,
    info = 265948,
    info_pos = "5",
    info_type = 1043,
    target_name = "4_4/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [508012006] = {
    delay = 2,
    guide_skip = false,
    id = 508012006,
    info = 215114,
    info_pos = "5",
    info_type = 1022,
    target_name = "Frame/PropList/93002/Root/ItemHolder/Btn_Select",
    target_parent = 3531,
    target_type = 1
  },
  [508012007] = {
    delay = 0.0,
    guide_skip = false,
    id = 508012007,
    info = 38166,
    info_pos = "1",
    info_type = 1043,
    step_type = 4,
    wait_target = false
  },
  [508012008] = {
    guide_skip = false,
    id = 508012008,
    info = 298086,
    info_pos = "5",
    info_type = 1022,
    target_name = "Frame/TeamList/UINWarChessSelectTeam/1/Btn_Equip",
    target_parent = 3531,
    target_type = 1
  },
  [508013000] = {
    custom_code = "GuideUtil.WCCameraFocus(2,5,0.5)",
    delay = 0.0,
    guide_skip = false,
    id = 508013000,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [508013001] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,6)",
    guide_skip = false,
    id = 508013001,
    info = 280140,
    info_pos = "1",
    info_type = 1010,
    step_type = 3
  },
  [508013002] = {
    guide_skip = false,
    id = 508013002,
    info = 226189,
    info_pos = "1",
    info_type = 1010,
    step_type = 4
  },
  [508013003] = {
    delay = 0.0,
    guide_skip = false,
    id = 508013003,
    info = 464258,
    info_pos = "1",
    info_type = 1043,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/Btn_TurnEnd",
    target_parent = 3501,
    target_type = 1,
    wait_target = false
  },
  [508013004] = {
    guide_skip = false,
    id = 508013004,
    info = 434196,
    info_pos = "1",
    info_type = 1043,
    target_name = "Frame/YesNoNode/ButtonYes",
    target_parent = 1200,
    target_type = 1
  },
  [508013005] = {
    custom_size = __rt_6,
    delay = 0.0,
    guide_skip = false,
    id = 508013005,
    info = 314922,
    info_pos = "1",
    info_type = 1010,
    step_type = 5,
    target_name = "AreaRoot/0,0/2,6",
    target_parent = "Test_WarChess",
    target_type = 2,
    wait_target = false
  },
  [508014000] = {
    custom_code = "GuideUtil.WCCameraFocus(2,6,0.5)",
    delay = 0.0,
    guide_skip = false,
    id = 508014000,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [508014001] = {
    custom_size = __rt_6,
    guide_skip = false,
    id = 508014001,
    info = 430382,
    info_pos = "5",
    info_type = 1022,
    step_type = 5,
    target_name = "AreaRoot/0,0/5,5",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [508014002] = {
    custom_size = __rt_6,
    guide_skip = false,
    id = 508014002,
    info = 468815,
    info_pos = "5",
    info_type = 1043,
    step_type = 5,
    target_name = "AreaRoot/0,0/5,5",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [508021001] = {
    custom_code = "GuideUtil.StartWarChessDeploy(1,0,1)",
    delay = 0.0,
    guide_skip = false,
    id = 508021001,
    info = 298238,
    info_pos = "1",
    info_type = 1043,
    step_type = 3,
    wait_target = false
  },
  [508021002] = {
    guide_skip = false,
    id = 508021002,
    info = 157134,
    info_pos = "1",
    info_type = 1043,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Deploy/Btn_BattleStart",
    target_parent = 3501,
    target_type = 1
  },
  [508022000] = {
    custom_code = "GuideUtil.WCCameraFocus(1,1,0.5)",
    delay = 0.0,
    guide_skip = false,
    id = 508022000,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [508022001] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,1)",
    guide_skip = false,
    id = 508022001,
    info = 121910,
    info_pos = "1",
    info_type = 1010,
    step_type = 3,
    wait_target = false
  },
  [508022002] = {
    guide_skip = false,
    id = 508022002,
    info = 262952,
    info_pos = "1",
    info_type = 1043,
    target_name = "2_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [508023000] = {
    custom_code = "GuideUtil.WCCameraFocus(3,1,0.5)",
    delay = 0.0,
    guide_skip = false,
    id = 508023000,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [508023001] = {
    custom_size = __rt_6,
    guide_skip = false,
    id = 508023001,
    info = 229732,
    info_pos = "1",
    info_type = 1010,
    step_type = 5,
    target_name = "AreaRoot/0,0/3,2",
    target_parent = "Test_WarChess",
    target_type = 2,
    wait_target = false
  },
  [508023002] = {
    guide_skip = false,
    id = 508023002,
    info = 114175,
    info_pos = "1",
    info_type = 1043,
    step_type = 4,
    wait_target = false
  },
  [508023003] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,1)",
    guide_skip = false,
    id = 508023003,
    info = 303020,
    info_pos = "1",
    info_type = 1010,
    step_type = 3,
    wait_target = false
  },
  [508023004] = {
    guide_skip = false,
    id = 508023004,
    info = 8237,
    info_pos = "1",
    info_type = 1043,
    target_name = "4_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [508023005] = {
    guide_skip = false,
    id = 508023005,
    info = 417023,
    info_pos = "1",
    info_type = 1010,
    target_name = "Frame/EpStoreRoom/BuyNode/BuyList/Rect/GroupItem/StoreChipItem(Clone)",
    target_parent = 3506,
    target_type = 1
  },
  [508023006] = {
    guide_skip = false,
    id = 508023006,
    info = 444540,
    info_pos = "1",
    info_type = 1010,
    target_name = "Frame/UINWarChessSelectTeam/1/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [508023007] = {
    guide_skip = false,
    id = 508023007,
    info = 329283,
    info_pos = "1",
    info_type = 1010,
    target_name = "Frame/Btn_Return",
    target_parent = 3532,
    target_type = 1
  },
  [508024000] = {
    custom_code = "GuideUtil.WCCameraFocus(2,3,0.5)",
    delay = 0.0,
    guide_skip = false,
    id = 508024000,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [508024001] = {
    delay = 0.0,
    guide_skip = false,
    id = 508024001,
    info = 95347,
    info_pos = "1",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [508024002] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,3)",
    guide_skip = false,
    id = 508024002,
    info = 364693,
    info_pos = "1",
    info_type = 1043,
    step_type = 3,
    wait_target = false
  },
  [508024003] = {
    guide_skip = false,
    id = 508024003,
    info_type = 0,
    target_name = "2_3/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [508024004] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,1)",
    guide_skip = false,
    id = 508024004,
    info = 518033,
    info_pos = "1",
    info_type = 1010,
    step_type = 3,
    wait_target = false
  },
  [508024005] = {
    guide_skip = false,
    id = 508024005,
    info = 158439,
    info_pos = "1",
    info_type = 1010,
    target_name = "4_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [508024006] = {
    guide_skip = false,
    id = 508024006,
    info = 226134,
    info_pos = "1",
    info_type = 1043,
    target_name = "Frame/EpStoreRoom/TradeTypeTile/Btn_ExchangeTypeItem",
    target_parent = 3506,
    target_type = 1
  },
  [508024007] = {
    guide_skip = false,
    id = 508024007,
    info = 370719,
    info_pos = "1",
    info_type = 1043,
    target_name = "Frame/EpStoreRoom/ExchangeNode/ExchangeList/Rect/GroupItem (1)/StoreBuffItem(Clone)",
    target_parent = 3506,
    target_type = 1
  },
  [508024008] = {
    delay = 0.0,
    guide_skip = false,
    id = 508024008,
    info = 219076,
    info_pos = "1",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [508024009] = {
    delay = 0.0,
    guide_skip = false,
    id = 508024009,
    info_pos = "1",
    info_type = 0,
    step_type = 4,
    wait_target = false
  },
  [508024010] = {
    guide_skip = false,
    id = 508024010,
    info = 189335,
    info_pos = "1",
    info_type = 1010,
    target_name = "Frame/EpStoreRoom/UINBuffDetail/btn_Buy",
    target_parent = 3506,
    target_type = 1
  },
  [508025000] = {
    custom_code = "GuideUtil.WCCameraFocus(4,3,0.5)",
    delay = 0.0,
    guide_skip = false,
    id = 508025000,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [508025001] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,3)",
    guide_skip = false,
    id = 508025001,
    info_pos = "16",
    info_type = 0,
    step_type = 3
  },
  [508025002] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,3)",
    guide_skip = false,
    id = 508025002,
    info = 443247,
    info_pos = "16",
    info_type = 1010,
    step_type = 3,
    wait_target = false
  },
  [508025003] = {
    guide_skip = false,
    id = 508025003,
    info = 2174,
    info_pos = "16",
    info_type = 1043,
    target_name = "5_3/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [508025004] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,3)",
    guide_skip = false,
    id = 508025004,
    info = 85797,
    info_pos = "16",
    info_type = 1010,
    step_type = 3,
    target_type = 2
  },
  [508025005] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,3)",
    guide_skip = false,
    id = 508025005,
    info = 403364,
    info_pos = "16",
    info_type = 1010,
    step_type = 3,
    wait_target = false
  },
  [508025006] = {
    guide_skip = false,
    id = 508025006,
    info = 96268,
    info_pos = "16",
    info_type = 1010,
    target_name = "6_3/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [508025007] = {
    delay = 1,
    guide_skip = false,
    id = 508025007,
    info = 200302,
    info_pos = "1",
    info_type = 1043,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/Btn_DeployNewTeam",
    target_parent = 3501,
    target_type = 1
  },
  [508025008] = {
    delay = 0.0,
    guide_skip = false,
    id = 508025008,
    info = 438378,
    info_pos = "5",
    info_type = 1003,
    step_type = 4,
    wait_target = false
  },
  [508025009] = {
    delay = 0.0,
    guide_skip = false,
    id = 508025009,
    info_pos = "1",
    info_type = 1003,
    step_type = 4,
    wait_target = false
  },
  [508025010] = {
    custom_code = "GuideUtil.StartWarChessDeploy(2,4,5)",
    delay = 0.0,
    guide_skip = false,
    id = 508025010,
    info = 119971,
    info_pos = "5",
    info_type = 1003,
    step_type = 3,
    wait_target = false
  },
  [508025011] = {
    guide_skip = false,
    id = 508025011,
    info = 112355,
    info_pos = "5",
    info_type = 1003,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/DynDeploy/Btn_ApplyDynDeploy",
    target_parent = 3501,
    target_type = 1
  },
  [508026000] = {
    custom_code = "GuideUtil.WCCameraFocus(6,4,0.5)",
    delay = 0.0,
    guide_skip = false,
    id = 508026000,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [508026001] = {
    delay = 0.0,
    guide_skip = false,
    id = 508026001,
    info = 304311,
    info_pos = "17",
    info_type = 1003,
    step_type = 4,
    wait_target = false
  },
  [508026002] = {
    delay = 0.0,
    guide_skip = false,
    id = 508026002,
    info = 457555,
    info_pos = "17",
    info_type = 1003,
    step_type = 4,
    wait_target = false
  },
  [508026003] = {
    guide_skip = false,
    id = 508026003,
    info = 356116,
    info_pos = "7",
    info_type = 1010,
    step_type = 5,
    target_name = "Top/ResList/Coin2",
    target_parent = 3501,
    target_type = 1
  },
  [508026004] = {
    delay = 0.0,
    guide_skip = false,
    id = 508026004,
    info = 107182,
    info_pos = "17",
    info_type = 1003,
    step_type = 4,
    wait_target = false
  },
  [508026005] = {
    delay = 0.0,
    guide_skip = false,
    id = 508026005,
    info = 328766,
    info_pos = "7",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [508026006] = {
    delay = 0.0,
    guide_skip = false,
    id = 508026006,
    info = 122621,
    info_pos = "17",
    info_type = 1003,
    step_type = 4,
    wait_target = false
  },
  [508026007] = {
    guide_skip = false,
    id = 508026007,
    info = 57362,
    info_pos = "7",
    info_type = 1010,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [508026008] = {
    guide_skip = false,
    id = 508026008,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [508026009] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,2)",
    guide_skip = false,
    id = 508026009,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [508026010] = {
    custom_code = "GuideUtil.WCCameraFocus(4,1,0.5)",
    guide_skip = false,
    id = 508026010,
    info_type = 0,
    step_type = 3
  },
  [508026011] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,1)",
    guide_skip = false,
    id = 508026011,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [508026012] = {
    guide_skip = false,
    id = 508026012,
    info_type = 0,
    target_name = "4_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [508026013] = {
    guide_skip = false,
    id = 508026013,
    info_type = 0,
    target_name = "Frame/EpStoreRoom/BuyNode/BuyList/Rect/GroupItem/StoreChipItem(Clone)",
    target_parent = 3506,
    target_type = 1
  },
  [508026014] = {
    guide_skip = false,
    id = 508026014,
    info = 106790,
    info_pos = "1",
    info_type = 1010,
    target_name = "Frame/UINWarChessSelectTeam/2/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [508026015] = {
    guide_skip = false,
    id = 508026015,
    info = 170412,
    info_pos = "1",
    info_type = 1010,
    target_name = "Frame/UINWarChessSelectTeam/2/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [508026016] = {
    guide_skip = false,
    id = 508026016,
    info_type = 0,
    target_name = "Frame/UINWarChessSelectTeam/2/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [508026017] = {
    guide_skip = false,
    id = 508026017,
    info_type = 0,
    target_name = "Frame/UINWarChessSelectTeam/2/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [508026018] = {
    delay = 0.0,
    guide_skip = false,
    id = 508026018,
    info = 468338,
    info_pos = "5",
    info_type = 1003,
    step_type = 4,
    wait_target = false
  },
  [508026019] = {
    delay = 0.0,
    guide_skip = false,
    id = 508026019,
    info = 319823,
    info_pos = "5",
    info_type = 1003,
    step_type = 4,
    wait_target = false
  },
  [508027001] = {
    guide_skip = false,
    id = 508027001,
    info = 289326,
    info_pos = "5",
    info_type = 1003,
    step_type = 4
  },
  [508027002] = {
    delay = 0.0,
    guide_skip = false,
    id = 508027002,
    info = 462711,
    info_pos = "1",
    info_type = 1043,
    step_type = 4,
    wait_target = false
  },
  [508027003] = {
    delay = 0.0,
    guide_skip = false,
    id = 508027003,
    info = 452048,
    info_pos = "1",
    info_type = 1043,
    step_type = 4,
    wait_target = false
  },
  [508030001] = {
    custom_code = "GuideUtil.StartWarChessDeploy(1,1,1)",
    guide_skip = false,
    id = 508030001,
    info_pos = "1",
    info_type = 0,
    step_type = 3
  },
  [508030002] = {
    guide_skip = false,
    id = 508030002,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Deploy/Btn_BattleStart",
    target_parent = 3501,
    target_type = 1
  },
  [508030003] = {
    delay = 0.0,
    guide_skip = false,
    id = 508030003,
    info = 338318,
    info_pos = "1",
    info_type = 1043,
    step_type = 4,
    wait_target = false
  },
  [508030004] = {
    delay = 0.0,
    guide_skip = false,
    id = 508030004,
    info_pos = "5",
    info_type = 0,
    step_type = 4,
    wait_target = false
  },
  [508030005] = {
    guide_skip = false,
    id = 508030005,
    info = 497936,
    info_pos = "1",
    info_type = 1043,
    target_name = "Top/PressureBar",
    target_parent = 3501,
    target_type = 1
  },
  [508030006] = {
    guide_skip = false,
    id = 508030006,
    info = 52046,
    info_pos = "1",
    info_type = 1043,
    step_type = 4,
    wait_target = false
  },
  [508030007] = {
    guide_skip = false,
    id = 508030007,
    info = 302370,
    info_pos = "1",
    info_type = 1043,
    step_type = 4,
    wait_target = false
  },
  [508030008] = {
    guide_skip = false,
    id = 508030008,
    info = 378512,
    info_pos = "1",
    info_type = 1043,
    step_type = 4,
    wait_target = false
  },
  [508030009] = {
    guide_skip = false,
    id = 508030009,
    info = 47569,
    info_pos = "5",
    info_type = 1043,
    step_type = 4,
    wait_target = false
  },
  [508030010] = {
    guide_skip = false,
    id = 508030010,
    info = 253543,
    info_pos = "1",
    info_type = 1043,
    target_name = "PressureFrame/Pressure/Btn_Close",
    target_parent = 3501,
    target_type = 1
  },
  [508030011] = {
    guide_skip = false,
    id = 508030011,
    info = 180110,
    info_pos = "1",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [508030012] = {
    guide_skip = false,
    id = 508030012,
    info = 417731,
    info_pos = "5",
    info_type = 1003,
    step_type = 4,
    wait_target = false
  },
  [560010101] = {
    id = 560010101,
    info = 36825,
    info_pos = "6",
    info_type = 1084,
    step_type = 4,
    target_parent = 4421,
    target_type = 1
  },
  [560010102] = {
    id = 560010102,
    info = 493598,
    info_type = 1084,
    step_type = 5,
    target_name = "Left/Btn_StoryReview",
    target_parent = 4421,
    target_type = 1
  },
  [560010103] = {
    id = 560010103,
    info = 14173,
    info_type = 1084,
    target_name = "Right/Entrance1/Touch",
    target_parent = 4421,
    target_type = 1
  },
  [560010104] = {
    id = 560010104,
    info = 170895,
    info_type = 1084,
    target_name = "Main/LayoutGroup/List/Rect/Item(Clone)/Btn_Reminisce",
    target_parent = 4420,
    target_type = 1
  },
  [560010201] = {
    avg_name = "56001101",
    avg_skip = true,
    delay = 0.2,
    id = 560010201,
    info_type = 0,
    step_type = 6
  },
  [590010101] = {
    delay = 2,
    id = 590010101,
    info = 229209,
    info_pos = "1",
    info_type = 1071,
    step_type = 4,
    target_parent = 4509,
    target_type = 1
  },
  [590010102] = {
    id = 590010102,
    info = 442425,
    info_type = 1071,
    step_type = 5,
    target_name = "BtnGroup/Btn_Draw",
    target_parent = 4509,
    target_type = 1
  },
  [590010103] = {
    id = 590010103,
    info = 99533,
    info_type = 1071,
    step_type = 5,
    target_name = "BtnGroup/Btn_Handbook",
    target_parent = 4509,
    target_type = 1
  },
  [590010104] = {
    id = 590010104,
    info = 34836,
    info_type = 1071,
    target_name = "BtnGroup/Btn_RepeatDun",
    target_parent = 4509,
    target_type = 1
  },
  [590010105] = {
    delay = 1,
    id = 590010105,
    info = 259332,
    info_type = 1071,
    step_type = 5,
    target_name = "Mid/List",
    target_parent = 4505,
    target_type = 1
  },
  [590010106] = {
    id = 590010106,
    info = 249735,
    info_type = 1071,
    step_type = 5,
    target_name = "Mid/Btn_ChipCheck",
    target_parent = 4505,
    target_type = 1
  },
  [590010107] = {
    id = 590010107,
    info = 245394,
    info_type = 1071,
    step_type = 5,
    target_name = "Down/FacBonus",
    target_parent = 4505,
    target_type = 1
  },
  [590010108] = {
    id = 590010108,
    info = 58811,
    info_type = 1071,
    target_name = "Down/Btn_Battle",
    target_parent = 4505,
    target_type = 1
  },
  [590010201] = {
    delay = 1,
    id = 590010201,
    info = 8920,
    info_pos = "1",
    info_type = 1071,
    step_type = 5,
    target_name = "Left",
    target_parent = 4506,
    target_type = 1
  },
  [590010202] = {
    id = 590010202,
    info = 392909,
    info_type = 1071,
    step_type = 5,
    target_name = "Left/UINRfCardFacBig/FactorCard",
    target_parent = 4506,
    target_type = 1
  },
  [590010203] = {
    id = 590010203,
    info = 260030,
    info_type = 1071,
    step_type = 5,
    target_name = "Left/UINRfCardFacBig/FactorCard/InfoGroup/Bonus",
    target_parent = 4506,
    target_type = 1
  },
  [590010204] = {
    id = 590010204,
    info = 26254,
    info_type = 1071,
    target_name = "Left/UINRfCardFacBig/Btn_Switch",
    target_parent = 4506,
    target_type = 1
  },
  [590010205] = {
    id = 590010205,
    info = 282462,
    info_type = 1071,
    step_type = 5,
    target_name = "Left/UINRfCardFacBig/FactorCardFmt",
    target_parent = 4506,
    target_type = 1
  },
  [590010206] = {
    id = 590010206,
    info = 124433,
    info_type = 1071,
    step_type = 5,
    target_name = "Right",
    target_parent = 4506,
    target_type = 1
  },
  [590010207] = {
    id = 590010207,
    info = 390238,
    info_type = 1071,
    target_name = "Left/Btn_RandomRule",
    target_parent = 4506,
    target_type = 1
  },
  [590010301] = {
    delay = 2,
    id = 590010301,
    info = 137963,
    info_type = 1071,
    step_type = 5,
    target_name = "BtnGroup/Btn_Draw",
    target_parent = 4509,
    target_type = 1
  },
  [590010401] = {
    delay = 1,
    id = 590010401,
    info = 153750,
    info_pos = "1",
    info_type = 1071,
    step_type = 4,
    target_parent = 4503,
    target_type = 1
  },
  [590010402] = {
    id = 590010402,
    info = 129871,
    info_type = 1071,
    step_type = 5,
    target_name = "Left/List/Rect",
    target_parent = 4503,
    target_type = 1
  },
  [590010403] = {
    id = 590010403,
    info = 49112,
    info_type = 1071,
    step_type = 5,
    target_name = "Bottom/Btn_Draw/Bg",
    target_parent = 4503,
    target_type = 1
  },
  [590010404] = {
    avg_name = "59001201",
    avg_skip = true,
    delay = 1,
    guide_skip = false,
    id = 590010404,
    info_type = 0,
    step_type = 6,
    target_parent = 4503,
    target_type = 1
  },
  [590010405] = {
    id = 590010405,
    info = 12530,
    info_type = 1071,
    step_type = 5,
    target_name = "Bottom/Btn_HandBook",
    target_parent = 4503,
    target_type = 1
  },
  [590010406] = {
    id = 590010406,
    info = 482023,
    info_type = 1071,
    target_name = "Bottom/Btn_Draw",
    target_parent = 4503,
    target_type = 1
  },
  [590010501] = {
    delay = 1,
    id = 590010501,
    info = 243609,
    info_pos = "1",
    info_type = 1071,
    step_type = 4,
    target_parent = 4504,
    target_type = 1
  },
  [590010502] = {
    id = 590010502,
    info = 9815,
    info_type = 1071,
    step_type = 5,
    target_name = "Right",
    target_parent = 4504,
    target_type = 1
  },
  [590010503] = {
    id = 590010503,
    info = 108752,
    info_type = 1071,
    step_type = 5,
    target_name = "Top/StoryList",
    target_parent = 4504,
    target_type = 1
  },
  [590010504] = {
    id = 590010504,
    info = 54758,
    info_type = 1071,
    step_type = 5,
    target_name = "Top/Btn_RewardCheck",
    target_parent = 4504,
    target_type = 1
  },
  [590010505] = {
    id = 590010505,
    info = 265641,
    info_pos = "1",
    info_type = 1071,
    step_type = 4,
    target_parent = 4504,
    target_type = 1
  },
  [601000101] = {
    delay = 0.0,
    id = 601000101,
    info = 404860,
    info_pos = "3",
    info_type = 1049,
    step_type = 4,
    wait_target = false
  },
  [601000102] = {
    custom_code = "GuideUtil.StartWarChessDeploy(1,2,2)",
    delay = 0.0,
    id = 601000102,
    info = 470764,
    info_pos = "1",
    info_type = 1028,
    step_type = 3,
    wait_target = false
  },
  [601000103] = {
    delay = 0.0,
    id = 601000103,
    info = 296523,
    info_pos = "1",
    info_type = 1028,
    step_type = 4,
    wait_target = false
  },
  [601000104] = {
    id = 601000104,
    info = 109110,
    info_pos = "3",
    info_type = 1049,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Deploy/Btn_BattleStart",
    target_parent = 3501,
    target_type = 1
  },
  [601000105] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,2)",
    delay = 0.0,
    id = 601000105,
    info = 403741,
    info_pos = "1",
    info_type = 1028,
    step_type = 3,
    wait_target = false
  },
  [601000106] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,2)",
    id = 601000106,
    info = 228639,
    info_pos = "1",
    info_type = 1028,
    step_type = 3,
    wait_target = false
  },
  [601000201] = {
    delay = 0.0,
    id = 601000201,
    info = 294463,
    info_pos = "15",
    info_type = 1052,
    step_type = 4,
    wait_target = false
  },
  [601000202] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,3)",
    delay = 0.0,
    id = 601000202,
    info = 178802,
    info_pos = "6",
    info_type = 1028,
    step_type = 3,
    wait_target = false
  },
  [601000203] = {
    delay = 0.0,
    id = 601000203,
    info = 444841,
    info_pos = "8",
    info_type = 1049,
    step_type = 4,
    wait_target = false
  },
  [601000204] = {
    id = 601000204,
    info = 196026,
    info_pos = "3",
    info_type = 1028,
    step_type = 5,
    target_name = "4_3/OpHolder/OpBtnGroup/1/Obj_ActionPoint",
    target_parent = 3502,
    target_type = 1
  },
  [601000205] = {
    id = 601000205,
    info = 391851,
    info_pos = "11",
    info_type = 1028,
    step_type = 5,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale",
    target_parent = 3501,
    target_type = 1
  },
  [601000206] = {
    delay = 0.0,
    id = 601000206,
    info = 141529,
    info_pos = "8",
    info_type = 1028,
    step_type = 4,
    wait_target = false
  },
  [601000207] = {
    id = 601000207,
    info = 61165,
    info_pos = "6",
    info_type = 1049,
    target_name = "4_3/OpHolder/OpBtnGroup/1",
    target_parent = 3502,
    target_type = 1
  },
  [601000301] = {
    delay = 0.0,
    id = 601000301,
    info = 458376,
    info_pos = "1",
    info_type = 1049,
    step_type = 4,
    wait_target = false
  },
  [601000302] = {
    delay = 0.0,
    id = 601000302,
    info = 453099,
    info_pos = "15",
    info_type = 1028,
    step_type = 4,
    wait_target = false
  },
  [601000303] = {
    delay = 0.0,
    id = 601000303,
    info = 149336,
    info_pos = "1",
    info_type = 1052,
    step_type = 4,
    wait_target = false
  },
  [601000304] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,3)",
    id = 601000304,
    info = 382586,
    info_pos = "15",
    info_type = 1028,
    step_type = 3,
    wait_target = false
  },
  [601000401] = {
    delay = 0.0,
    id = 601000401,
    info = 392633,
    info_pos = "8",
    info_type = 1049,
    step_type = 4,
    wait_target = false
  },
  [601000402] = {
    custom_size = __rt_6,
    id = 601000402,
    info = 515316,
    info_pos = "18",
    info_type = 1028,
    step_type = 5,
    target_name = "AreaRoot/0,0/5,2",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [601000403] = {
    custom_size = __rt_6,
    id = 601000403,
    info = 16042,
    info_pos = "6",
    info_type = 1052,
    step_type = 5,
    target_name = "AreaRoot/0,0/5,3",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [601000404] = {
    delay = 0.0,
    id = 601000404,
    info = 269276,
    info_pos = "18",
    info_type = 1049,
    step_type = 4,
    wait_target = false
  },
  [601000405] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,4)",
    id = 601000405,
    info = 360350,
    info_pos = "6",
    info_type = 1028,
    step_type = 3,
    wait_target = false
  },
  [601000501] = {
    delay = 0.0,
    id = 601000501,
    info = 47902,
    info_pos = "5",
    info_type = 1049,
    step_type = 4,
    wait_target = false
  },
  [601000502] = {
    delay = 0.0,
    id = 601000502,
    info = 261904,
    info_pos = "15",
    info_type = 1052,
    step_type = 4,
    wait_target = false
  },
  [601000503] = {
    delay = 0.0,
    id = 601000503,
    info = 380152,
    info_pos = "5",
    info_type = 1028,
    step_type = 4,
    wait_target = false
  },
  [601000504] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,4)",
    id = 601000504,
    info = 443617,
    info_pos = "15",
    info_type = 1052,
    step_type = 3,
    wait_target = false
  },
  [601000505] = {
    id = 601000505,
    info = 229372,
    info_pos = "5",
    info_type = 1028,
    step_type = 5,
    target_name = "6_4/OpHolder/OpBtnGroup/2/Obj_ActionPoint",
    target_parent = 3502,
    target_type = 1
  },
  [601000506] = {
    id = 601000506,
    info = 339743,
    info_pos = "1",
    info_type = 1028,
    step_type = 5,
    target_name = "1/TeamHolder/TeamInfo(Clone)/TeamAP",
    target_parent = 3502,
    target_type = 1
  },
  [601000507] = {
    id = 601000507,
    info = 443377,
    info_pos = "15",
    info_type = 1049,
    target_name = "6_4/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [601000601] = {
    delay = 0.0,
    id = 601000601,
    info = 478672,
    info_pos = "5",
    info_type = 1052,
    step_type = 4,
    wait_target = false
  },
  [601000602] = {
    delay = 0.0,
    id = 601000602,
    info = 175846,
    info_pos = "1",
    info_type = 1049,
    step_type = 4,
    wait_target = false
  },
  [601000603] = {
    delay = 0.0,
    id = 601000603,
    info = 85783,
    info_pos = "5",
    info_type = 1052,
    step_type = 4,
    wait_target = false
  },
  [601000604] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,2)",
    id = 601000604,
    info = 469882,
    info_pos = "17",
    info_type = 1028,
    step_type = 3,
    wait_target = false
  },
  [601010101] = {
    delay = 1,
    guide_skip = false,
    id = 601010101,
    info = 477250,
    info_pos = "1",
    info_type = 1016,
    step_type = 4
  },
  [601010102] = {
    delay = 1,
    guide_skip = false,
    id = 601010102,
    info = 416826,
    info_pos = "1",
    info_type = 1050,
    step_type = 4
  },
  [601010103] = {
    guide_skip = false,
    id = 601010103,
    info = 487347,
    info_pos = "1",
    info_type = 1016,
    step_type = 4
  },
  [601010104] = {
    guide_skip = false,
    id = 601010104,
    info = 190738,
    info_pos = "1",
    info_type = 1016,
    step_type = 4
  },
  [601010105] = {
    custom_code = "GuideUtil.StartWarChessDeploy(1,1,1)",
    guide_skip = false,
    id = 601010105,
    info = 160492,
    info_pos = "1",
    info_type = 1051,
    step_type = 3
  },
  [601010106] = {
    custom_code = "GuideUtil.StartWarChessDeploy(2,5,1)",
    delay = 0.0,
    guide_skip = false,
    id = 601010106,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [601010107] = {
    guide_skip = false,
    id = 601010107,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Deploy/Btn_BattleStart",
    target_parent = 3501,
    target_type = 1
  },
  [601010201] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,2)",
    guide_skip = false,
    id = 601010201,
    info = 12441,
    info_pos = "1",
    info_type = 1051,
    step_type = 3
  },
  [601010202] = {
    delay = 0.0,
    guide_skip = false,
    id = 601010202,
    info = 356527,
    info_pos = "1",
    info_type = 1016,
    step_type = 4,
    wait_target = false
  },
  [601010203] = {
    delay = 0.0,
    guide_skip = false,
    id = 601010203,
    info = 87897,
    info_pos = "1",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [601010204] = {
    delay = 0.0,
    guide_skip = false,
    id = 601010204,
    info = 162589,
    info_pos = "1",
    info_type = 1016,
    step_type = 4,
    wait_target = false
  },
  [601010205] = {
    delay = 0.0,
    guide_skip = false,
    id = 601010205,
    info = 460292,
    info_pos = "1",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [601010206] = {
    guide_skip = false,
    id = 601010206,
    info = 124872,
    info_pos = "1",
    info_type = 1016,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/2/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [601010207] = {
    delay = 0.0,
    guide_skip = false,
    id = 601010207,
    info = 270410,
    info_pos = "1",
    info_type = 1051,
    step_type = 4,
    wait_target = false
  },
  [601010301] = {
    guide_skip = false,
    id = 601010301,
    info = 89880,
    info_pos = "1",
    info_type = 1051,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [601010302] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,3)",
    delay = 0.0,
    guide_skip = false,
    id = 601010302,
    info = 262088,
    info_pos = "1",
    info_type = 1051,
    step_type = 3,
    wait_target = false
  },
  [601010303] = {
    delay = 0.0,
    guide_skip = false,
    id = 601010303,
    info = 411041,
    info_pos = "1",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [601010304] = {
    delay = 0.0,
    guide_skip = false,
    id = 601010304,
    info = 153278,
    info_pos = "1",
    info_type = 1016,
    step_type = 4,
    wait_target = false
  },
  [601010305] = {
    delay = 0.0,
    guide_skip = false,
    id = 601010305,
    info = 358792,
    info_pos = "1",
    info_type = 1051,
    step_type = 4,
    wait_target = false
  },
  [601010306] = {
    guide_skip = false,
    id = 601010306,
    info = 315221,
    info_pos = "1",
    info_type = 1016,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/2/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [601010307] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,4)",
    guide_skip = false,
    id = 601010307,
    info = 53852,
    info_pos = "1",
    info_type = 1016,
    step_type = 3,
    wait_target = false
  },
  [601010308] = {
    delay = 0.0,
    guide_skip = false,
    id = 601010308,
    info = 154616,
    info_pos = "5",
    info_type = 1051,
    step_type = 4,
    wait_target = false
  },
  [601010309] = {
    delay = 1,
    guide_skip = false,
    id = 601010309,
    info = 60264,
    info_pos = "1",
    info_type = 1016,
    target_name = "4_4/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [601010310] = {
    delay = 2,
    guide_skip = false,
    id = 601010310,
    info = 400897,
    info_pos = "1",
    info_type = 1016,
    target_name = "Frame/PropList/93002/Root/ItemHolder/Btn_Select",
    target_parent = 3531,
    target_type = 1
  },
  [601010311] = {
    delay = 0.0,
    guide_skip = false,
    id = 601010311,
    info = 161626,
    info_pos = "1",
    info_type = 1016,
    step_type = 4,
    wait_target = false
  },
  [601010312] = {
    guide_skip = false,
    id = 601010312,
    info = 76820,
    info_pos = "1",
    info_type = 1016,
    target_name = "Frame/TeamList/UINWarChessSelectTeam/1/Btn_Equip",
    target_parent = 3531,
    target_type = 1
  },
  [601010313] = {
    delay = 0.0,
    guide_skip = false,
    id = 601010313,
    info = 385734,
    info_pos = "1",
    info_type = 1051,
    step_type = 4,
    wait_target = false
  },
  [601010314] = {
    delay = 0.0,
    guide_skip = false,
    id = 601010314,
    info = 46088,
    info_pos = "1",
    info_type = 1051,
    step_type = 4,
    wait_target = false
  },
  [601010315] = {
    guide_skip = false,
    id = 601010315,
    info = 219195,
    info_pos = "1",
    info_type = 1050,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [601010401] = {
    delay = 1,
    guide_skip = false,
    id = 601010401,
    info = 94482,
    info_pos = "1",
    info_type = 1051,
    step_type = 4,
    wait_target = false
  },
  [601010402] = {
    delay = 1,
    guide_skip = false,
    id = 601010402,
    info = 393169,
    info_pos = "1",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [601010403] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,4)",
    guide_skip = false,
    id = 601010403,
    info = 54430,
    info_pos = "1",
    info_type = 1016,
    step_type = 3,
    wait_target = false
  },
  [601010501] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,5)",
    delay = 0.0,
    guide_skip = false,
    id = 601010501,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [601010601] = {
    delay = 1,
    guide_skip = false,
    id = 601010601,
    info = 47694,
    info_pos = "1",
    info_type = 1051,
    step_type = 4,
    wait_target = false
  },
  [601010602] = {
    delay = 1,
    guide_skip = false,
    id = 601010602,
    info = 55768,
    info_pos = "1",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [601010603] = {
    guide_skip = false,
    id = 601010603,
    info = 410695,
    info_pos = "1",
    info_type = 1016,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/Btn_TurnEnd",
    target_parent = 3501,
    target_type = 1
  },
  [601010604] = {
    delay = 1,
    guide_skip = false,
    id = 601010604,
    info = 337368,
    info_pos = "7",
    info_type = 1016,
    step_type = 4,
    wait_target = false
  },
  [601010605] = {
    delay = 1,
    guide_skip = false,
    id = 601010605,
    info = 43383,
    info_pos = "7",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [601010606] = {
    guide_skip = false,
    id = 601010606,
    info = 332306,
    info_pos = "7",
    info_type = 1051,
    target_name = "Frame/YesNoNode/ButtonYes",
    target_parent = 1200,
    target_type = 1
  },
  [601010607] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,6)",
    delay = 3,
    guide_skip = false,
    id = 601010607,
    info = 433864,
    info_pos = "1",
    info_type = 1016,
    step_type = 3,
    wait_target = false
  },
  [601010608] = {
    guide_skip = false,
    id = 601010608,
    info = 414041,
    info_pos = "1",
    info_type = 1051,
    target_name = "2_6/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [601010609] = {
    guide_skip = false,
    id = 601010609,
    info = 354991,
    info_pos = "1",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [601010610] = {
    guide_skip = false,
    id = 601010610,
    info = 410505,
    info_pos = "1",
    info_type = 1016,
    step_type = 4,
    wait_target = false
  },
  [601010611] = {
    guide_skip = false,
    id = 601010611,
    info = 198811,
    info_pos = "1",
    info_type = 1016,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/2/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [601010612] = {
    guide_skip = false,
    id = 601010612,
    info = 456460,
    info_pos = "1",
    info_type = 1050,
    step_type = 4,
    wait_target = false
  },
  [601010801] = {
    guide_skip = false,
    id = 601010801,
    info = 299187,
    info_pos = "1",
    info_type = 1016,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [601010802] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,2)",
    guide_skip = false,
    id = 601010802,
    info = 272649,
    info_pos = "1",
    info_type = 1050,
    step_type = 3,
    wait_target = false
  },
  [601010803] = {
    guide_skip = false,
    id = 601010803,
    info = 417713,
    info_pos = "1",
    info_type = 1051,
    target_name = "2_2/OpHolder/OpBtnGroup/1",
    target_parent = 3502,
    target_type = 1
  },
  [601020101] = {
    custom_code = "GuideUtil.StartWarChessDeploy(1,0,1)",
    delay = 0.0,
    guide_skip = false,
    id = 601020101,
    info = 116693,
    info_pos = "3",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [601020102] = {
    delay = 0.2,
    guide_skip = false,
    id = 601020102,
    info = 263390,
    info_pos = "3",
    info_type = 1053,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Deploy/Btn_BattleStart",
    target_parent = 3501,
    target_type = 1
  },
  [601020103] = {
    delay = 2,
    guide_skip = false,
    id = 601020103,
    info = 370764,
    info_pos = "3",
    info_type = 1048,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [601020104] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,1)",
    guide_skip = false,
    id = 601020104,
    info = 65649,
    info_pos = "3",
    info_type = 1053,
    step_type = 3,
    wait_target = false
  },
  [601020105] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,1)",
    guide_skip = false,
    id = 601020105,
    info = 98118,
    info_pos = "3",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [601020106] = {
    guide_skip = false,
    id = 601020106,
    info = 300740,
    info_pos = "3",
    info_type = 1053,
    target_name = "2_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [601020107] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,1)",
    guide_skip = false,
    id = 601020107,
    info = 26781,
    info_pos = "3",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [601020108] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,1)",
    guide_skip = false,
    id = 601020108,
    info = 246122,
    info_pos = "3",
    info_type = 1053,
    step_type = 3,
    wait_target = false
  },
  [601020109] = {
    guide_skip = false,
    id = 601020109,
    info = 436230,
    info_pos = "1",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [601020110] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020110,
    info = 218922,
    info_pos = "1",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [601020111] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020111,
    info = 503349,
    info_pos = "1",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [601020112] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020112,
    info = 140661,
    info_pos = "1",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [601020113] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,1)",
    guide_skip = false,
    id = 601020113,
    info = 449370,
    info_pos = "1",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [601020114] = {
    guide_skip = false,
    id = 601020114,
    info = 87440,
    info_pos = "1",
    info_type = 1048,
    target_name = "4_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [601020115] = {
    guide_skip = false,
    id = 601020115,
    info = 324097,
    info_pos = "3",
    info_type = 1048,
    target_name = "Frame/EpStoreRoom/BuyNode/BuyList/Rect/GroupItem/StoreChipItem(Clone)",
    target_parent = 3506,
    target_type = 1
  },
  [601020116] = {
    guide_skip = false,
    id = 601020116,
    info = 448069,
    info_pos = "3",
    info_type = 1048,
    target_name = "Frame/UINWarChessSelectTeam/1/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [601020117] = {
    guide_skip = false,
    id = 601020117,
    info = 134831,
    info_pos = "3",
    info_type = 1053,
    target_name = "Frame/Btn_Return",
    target_parent = 3532,
    target_type = 1
  },
  [601020118] = {
    guide_skip = false,
    id = 601020118,
    info = 272164,
    info_pos = "3",
    info_type = 1048,
    target_name = "Frame/EpStoreRoom/Btn_Group/btn_Skip",
    target_parent = 3506,
    target_type = 1
  },
  [601020119] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,2)",
    guide_skip = false,
    id = 601020119,
    info = 428637,
    info_pos = "1",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [601020120] = {
    guide_skip = false,
    id = 601020120,
    info = 260854,
    info_pos = "1",
    info_type = 1053,
    target_name = "3_2/OpHolder/OpBtnGroup/1",
    target_parent = 3502,
    target_type = 1
  },
  [601020201] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,2)",
    guide_skip = false,
    id = 601020201,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [601020202] = {
    guide_skip = false,
    id = 601020202,
    info_type = 0,
    target_name = "4_2/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [601020203] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,2)",
    delay = 0.0,
    guide_skip = false,
    id = 601020203,
    info = 222030,
    info_pos = "16",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [601020204] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020204,
    info = 124541,
    info_pos = "16",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [601020205] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020205,
    info = 314970,
    info_pos = "16",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [601020206] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020206,
    info = 405947,
    info_pos = "16",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [601020207] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,3)",
    guide_skip = false,
    id = 601020207,
    info = 322642,
    info_pos = "16",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [601020208] = {
    guide_skip = false,
    id = 601020208,
    info_type = 0,
    target_name = "2_3/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [601020209] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,1)",
    guide_skip = false,
    id = 601020209,
    info = 194886,
    info_pos = "1",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [601020210] = {
    guide_skip = false,
    id = 601020210,
    info = 104009,
    info_pos = "1",
    info_type = 1048,
    target_name = "4_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [601020211] = {
    guide_skip = false,
    id = 601020211,
    info = 10441,
    info_pos = "16",
    info_type = 1053,
    target_name = "Frame/EpStoreRoom/TradeTypeTile/Btn_ExchangeTypeItem",
    target_parent = 3506,
    target_type = 1
  },
  [601020212] = {
    guide_skip = false,
    id = 601020212,
    info = 286844,
    info_pos = "16",
    info_type = 1048,
    target_name = "Frame/EpStoreRoom/ExchangeNode/ExchangeList/Rect/GroupItem (1)/StoreBuffItem(Clone)",
    target_parent = 3506,
    target_type = 1
  },
  [601020213] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020213,
    info = 377050,
    info_pos = "16",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [601020214] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020214,
    info = 191794,
    info_pos = "16",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [601020215] = {
    guide_skip = false,
    id = 601020215,
    info = 178519,
    info_pos = "16",
    info_type = 1048,
    target_name = "Frame/EpStoreRoom/UINBuffDetail/btn_Buy",
    target_parent = 3506,
    target_type = 1
  },
  [601020216] = {
    guide_skip = false,
    id = 601020216,
    info_type = 0,
    target_name = "Frame/EpStoreRoom/Btn_Group/btn_Skip",
    target_parent = 3506,
    target_type = 1
  },
  [601020217] = {
    guide_skip = false,
    id = 601020217,
    info = 504418,
    info_pos = "5",
    info_type = 1048,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/Btn_TurnEnd",
    target_parent = 3501,
    target_type = 1
  },
  [601020218] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020218,
    info = 72743,
    info_pos = "5",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [601020219] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,3)",
    delay = 1,
    guide_skip = false,
    id = 601020219,
    info = 481384,
    info_pos = "5",
    info_type = 1048,
    step_type = 3,
    target_type = 2
  },
  [601020220] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020220,
    info = 464390,
    info_pos = "5",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [601020221] = {
    guide_skip = false,
    id = 601020221,
    info = 335998,
    info_pos = "5",
    info_type = 1053,
    target_name = "4_3/OpHolder/OpBtnGroup/1",
    target_parent = 3502,
    target_type = 1
  },
  [601020301] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020301,
    info = 211362,
    info_pos = "5",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [601020302] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,3)",
    delay = 0.0,
    guide_skip = false,
    id = 601020302,
    info = 246122,
    info_pos = "5",
    info_type = 1053,
    step_type = 3,
    wait_target = false
  },
  [601020303] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,3)",
    guide_skip = false,
    id = 601020303,
    info = 203643,
    info_pos = "5",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [601020304] = {
    guide_skip = false,
    id = 601020304,
    info = 343393,
    info_pos = "5",
    info_type = 1053,
    target_name = "5_3/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [601020305] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,3)",
    guide_skip = false,
    id = 601020305,
    info = 130077,
    info_pos = "5",
    info_type = 1048,
    step_type = 3,
    target_type = 2
  },
  [601020306] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,3)",
    guide_skip = false,
    id = 601020306,
    info = 236447,
    info_pos = "5",
    info_type = 1053,
    step_type = 3,
    wait_target = false
  },
  [601020307] = {
    guide_skip = false,
    id = 601020307,
    info = 7815,
    info_pos = "5",
    info_type = 1048,
    target_name = "6_3/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [601020308] = {
    delay = 1,
    guide_skip = false,
    id = 601020308,
    info = 480303,
    info_pos = "3",
    info_type = 1048,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/Btn_DeployNewTeam",
    target_parent = 3501,
    target_type = 1
  },
  [601020309] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020309,
    info = 470531,
    info_pos = "1",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [601020310] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020310,
    info = 290709,
    info_pos = "3",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [601020311] = {
    custom_code = "GuideUtil.StartWarChessDeploy(2,4,5)",
    delay = 0.0,
    guide_skip = false,
    id = 601020311,
    info = 122954,
    info_pos = "1",
    info_type = 1010,
    step_type = 3,
    wait_target = false
  },
  [601020312] = {
    guide_skip = false,
    id = 601020312,
    info = 265383,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/DynDeploy/Btn_ApplyDynDeploy",
    target_parent = 3501,
    target_type = 1
  },
  [601020313] = {
    guide_skip = false,
    id = 601020313,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/2/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [601020314] = {
    guide_skip = false,
    id = 601020314,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/2/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [601020315] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,5)",
    guide_skip = false,
    id = 601020315,
    info = 151404,
    info_pos = "16",
    info_type = 1010,
    step_type = 3,
    wait_target = false
  },
  [601020316] = {
    guide_skip = false,
    id = 601020316,
    info = 328681,
    info_pos = "11",
    info_type = 1010,
    target_name = "5_5/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [601020317] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,5)",
    guide_skip = false,
    id = 601020317,
    info = 189339,
    info_pos = "11",
    info_type = 1048,
    step_type = 3,
    wait_target = false
  },
  [601020318] = {
    guide_skip = false,
    id = 601020318,
    info_type = 0,
    target_name = "6_5/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [601020319] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(6,4)",
    guide_skip = false,
    id = 601020319,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [601020320] = {
    guide_skip = false,
    id = 601020320,
    info_type = 0,
    target_name = "6_4/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [601020321] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(7,4)",
    guide_skip = false,
    id = 601020321,
    info = 411335,
    info_pos = "16",
    info_type = 1010,
    step_type = 3,
    wait_target = false
  },
  [601020322] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020322,
    info = 112125,
    info_pos = "16",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [601020323] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020323,
    info = 345724,
    info_pos = "11",
    info_type = 1048,
    step_type = 4,
    wait_target = false
  },
  [601020324] = {
    guide_skip = false,
    id = 601020324,
    info = 411598,
    info_pos = "16",
    info_type = 1010,
    step_type = 5,
    target_name = "Top/ResList/Coin2",
    target_parent = 3501,
    target_type = 1
  },
  [601020325] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020325,
    info = 480327,
    info_pos = "11",
    info_type = 1053,
    step_type = 4,
    wait_target = false
  },
  [601020326] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020326,
    info = 238749,
    info_pos = "16",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [601020327] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020327,
    info = 65468,
    info_pos = "16",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [601020328] = {
    guide_skip = false,
    id = 601020328,
    info = 160356,
    info_pos = "11",
    info_type = 1048,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [601020329] = {
    guide_skip = false,
    id = 601020329,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [601020330] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,2)",
    guide_skip = false,
    id = 601020330,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [601020331] = {
    guide_skip = false,
    id = 601020331,
    info_type = 0,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [601020332] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,1)",
    guide_skip = false,
    id = 601020332,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [601020333] = {
    guide_skip = false,
    id = 601020333,
    info_type = 0,
    target_name = "4_1/OpHolder/OpBtnGroup/2",
    target_parent = 3502,
    target_type = 1
  },
  [601020334] = {
    guide_skip = false,
    id = 601020334,
    info_type = 0,
    target_name = "Frame/EpStoreRoom/BuyNode/BuyList/Rect/GroupItem/StoreChipItem(Clone)",
    target_parent = 3506,
    target_type = 1
  },
  [601020335] = {
    guide_skip = false,
    id = 601020335,
    info = 513433,
    info_pos = "9",
    info_type = 1048,
    target_name = "Frame/UINWarChessSelectTeam/2/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [601020336] = {
    guide_skip = false,
    id = 601020336,
    info = 224501,
    info_pos = "9",
    info_type = 1048,
    target_name = "Frame/UINWarChessSelectTeam/2/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [601020337] = {
    guide_skip = false,
    id = 601020337,
    info_type = 0,
    target_name = "Frame/UINWarChessSelectTeam/2/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [601020338] = {
    guide_skip = false,
    id = 601020338,
    info_type = 0,
    target_name = "Frame/UINWarChessSelectTeam/2/Btn_Buy",
    target_parent = 3532,
    target_type = 1
  },
  [601020339] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020339,
    info = 32505,
    info_pos = "1",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [601020340] = {
    delay = 0.0,
    guide_skip = false,
    id = 601020340,
    info = 67427,
    info_pos = "1",
    info_type = 1010,
    step_type = 4,
    wait_target = false
  },
  [601030101] = {
    delay = 0.0,
    guide_skip = false,
    id = 601030101,
    info = 26441,
    info_pos = "1",
    info_type = 1022,
    step_type = 4,
    wait_target = false
  },
  [601030102] = {
    custom_code = "GuideUtil.StartWarChessDeploy(1,1,1)",
    guide_skip = false,
    id = 601030102,
    info = 100188,
    info_pos = "1",
    step_type = 3,
    wait_target = false
  },
  [601030103] = {
    guide_skip = false,
    id = 601030103,
    info = 151680,
    target_name = "Trans_Down/UINWarChessDeploy(Clone)/Frame/NormalMode/Deploy/Btn_BattleStart",
    target_parent = 3501,
    target_type = 1
  },
  [601030201] = {
    delay = 0.0,
    guide_skip = false,
    id = 601030201,
    info = 474724,
    info_pos = "1",
    info_type = 1039,
    step_type = 4,
    wait_target = false
  },
  [601030202] = {
    delay = 0.0,
    guide_skip = false,
    id = 601030202,
    info = 387267,
    info_pos = "1",
    info_type = 1022,
    step_type = 4,
    wait_target = false
  },
  [601030203] = {
    guide_skip = false,
    id = 601030203,
    info = 162620,
    info_pos = "1",
    target_name = "Top/PressureBar",
    target_parent = 3501,
    target_type = 1
  },
  [601030204] = {
    guide_skip = false,
    id = 601030204,
    info = 110443,
    info_pos = "1",
    step_type = 4,
    wait_target = false
  },
  [601030205] = {
    guide_skip = false,
    id = 601030205,
    info = 176076,
    info_pos = "1",
    step_type = 4,
    wait_target = false
  },
  [601030206] = {
    guide_skip = false,
    id = 601030206,
    info = 192546,
    info_pos = "1",
    info_type = 1022,
    step_type = 4,
    wait_target = false
  },
  [601030207] = {
    guide_skip = false,
    id = 601030207,
    info = 464131,
    info_pos = "1",
    step_type = 4,
    wait_target = false
  },
  [601030208] = {
    guide_skip = false,
    id = 601030208,
    info = 416778,
    info_pos = "1",
    info_type = 1039,
    step_type = 4,
    wait_target = false
  },
  [601030209] = {
    guide_skip = false,
    id = 601030209,
    info = 170068,
    info_pos = "1",
    step_type = 4,
    wait_target = false
  },
  [601030210] = {
    guide_skip = false,
    id = 601030210,
    info = 18763,
    info_pos = "1",
    info_type = 1022,
    target_name = "PressureFrame/Pressure/Btn_Close",
    target_parent = 3501,
    target_type = 1
  },
  [601201101] = {
    avg_name = "59001091",
    avg_skip = true,
    guide_skip = false,
    id = 601201101,
    info_type = 0,
    step_type = 6
  },
  [601201102] = {
    custom_code = "GuideUtil.PlayEpTip(11000)",
    delay = 1,
    id = 601201102,
    info_type = 0,
    step_type = 3
  },
  [602000101] = {
    condition = 32,
    delay = 0.0,
    id = 602000101,
    info = 69201,
    info_pos = "1",
    info_type = 1005,
    step_type = 4,
    wait_target = false
  },
  [602000102] = {
    id = 602000102,
    info = 312382,
    info_pos = "3",
    info_type = 1005,
    target_name = "InteractEntityInfo/1",
    target_parent = 601,
    target_type = 1
  },
  [602000103] = {
    custom_code = "GuideUtil.ActLobbyWaitPopInteractUI(1)",
    delay = 0.0,
    guide_skip = false,
    id = 602000103,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [602000104] = {
    id = 602000104,
    info = 45721,
    info_pos = "9",
    info_type = 1005,
    target_name = "InteractNode/interactItem_1",
    target_parent = 600,
    target_type = 1
  },
  [602000105] = {
    delay = 0.0,
    id = 602000105,
    info = 153984,
    info_pos = "6",
    info_type = 1005,
    step_type = 4,
    wait_target = false
  },
  [602001101] = {
    id = 602001101,
    info = 274407,
    info_pos = "18",
    info_type = 1,
    step_type = 4
  },
  [602001102] = {
    id = 602001102,
    info = 283927,
    info_pos = "15",
    info_type = 1,
    step_type = 5,
    target_name = "PlayerSkillNode/Normal/1",
    target_parent = 203,
    target_type = 1
  },
  [602001103] = {
    id = 602001103,
    info = 228512,
    info_pos = "18",
    info_type = 1,
    step_type = 4
  },
  [602010200] = {
    guide_skip = false,
    id = 602010200,
    info = 3330,
    info_pos = "1",
    info_type = 1,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [602010201] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,2)",
    guide_skip = false,
    id = 602010201,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [602010202] = {
    guide_skip = false,
    id = 602010202,
    info = 203140,
    info_pos = "1",
    info_type = 1,
    target_name = "3_2/OpHolder/OpBtnGroup/1",
    target_parent = 3502,
    target_type = 1
  },
  [602010203] = {
    guide_skip = false,
    id = 602010203,
    info = 475723,
    info_pos = "1",
    info_type = 1,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1
  },
  [602010204] = {
    custom_code = "GuideUtil.WCCameraFocus(4,1,0.5)",
    id = 602010204,
    info = 42834,
    info_pos = "1",
    info_type = 1,
    step_type = 3,
    wait_target = false
  },
  [602010205] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(4,1)",
    guide_skip = false,
    id = 602010205,
    info = 280983,
    info_pos = "1",
    info_type = 1,
    step_type = 3,
    wait_target = false
  },
  [602010206] = {
    guide_skip = false,
    id = 602010206,
    info = 131446,
    info_pos = "1",
    info_type = 1,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1
  },
  [602010207] = {
    id = 602010207,
    info = 501863,
    info_pos = "1",
    info_type = 1,
    step_type = 4,
    wait_target = false
  },
  [602010208] = {
    guide_skip = false,
    id = 602010208,
    info = 171620,
    info_pos = "1",
    info_type = 1,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1
  },
  [602010209] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(3,2)",
    id = 602010209,
    info = 139551,
    info_pos = "15",
    info_type = 1,
    step_type = 3,
    wait_target = false
  },
  [602010211] = {
    delay = 0.0,
    id = 602010211,
    info = 396346,
    info_pos = "15",
    info_type = 1,
    step_type = 4,
    wait_target = false
  },
  [602010212] = {
    delay = 0.0,
    guide_skip = false,
    id = 602010212,
    info = 185000,
    info_pos = "1",
    info_type = 1,
    step_type = 4,
    wait_target = false
  },
  [602010213] = {
    guide_skip = false,
    id = 602010213,
    info = 141178,
    info_pos = "1",
    info_type = 1,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [602010214] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(7,1)",
    guide_skip = false,
    id = 602010214,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [602010215] = {
    guide_skip = false,
    id = 602010215,
    info = 269820,
    info_pos = "15",
    info_type = 1,
    target_name = "7_1/OpHolder/OpBtnGroup/1",
    target_parent = 3502,
    target_type = 1
  },
  [602010216] = {
    guide_skip = false,
    id = 602010216,
    info = 443627,
    info_pos = "1",
    info_type = 1,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1
  },
  [602010217] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(5,2)",
    guide_skip = false,
    id = 602010217,
    info = 344042,
    info_pos = "1",
    info_type = 1,
    step_type = 3,
    wait_target = false
  },
  [602010220] = {
    custom_code = "GuideUtil.WCCameraFocus(3,2,1)",
    guide_skip = false,
    id = 602010220,
    info_type = 0,
    step_type = 3
  },
  [602010221] = {
    custom_code = "GuideUtil.WCCameraFocus(3,2,1)",
    guide_skip = false,
    id = 602010221,
    info_type = 0,
    step_type = 3
  },
  [602010222] = {
    custom_code = "GuideUtil.WCCameraFocus(3,2,1)",
    guide_skip = false,
    id = 602010222,
    info_type = 0,
    step_type = 3
  },
  [602010223] = {
    custom_code = "GuideUtil.WCCameraFocus(6,1,1)",
    guide_skip = false,
    id = 602010223,
    info_type = 0,
    step_type = 3
  },
  [602010224] = {
    custom_code = "GuideUtil.WCCameraFocus(6,1,1)",
    guide_skip = false,
    id = 602010224,
    info_type = 0,
    step_type = 3
  },
  [602010225] = {
    custom_code = "GuideUtil.WCCameraFocus(0,0,1)",
    guide_skip = false,
    id = 602010225,
    info_type = 0,
    step_type = 3
  },
  [602010226] = {
    custom_code = "GuideUtil.WCCameraFocus(0,0,1)",
    guide_skip = false,
    id = 602010226,
    info_type = 0,
    step_type = 3
  },
  [602010227] = {
    custom_code = "GuideUtil.WCCameraFocus(0,0,1)",
    guide_skip = false,
    id = 602010227,
    info_type = 0,
    step_type = 3
  },
  [602020000] = {
    id = 602020000,
    info = 191412,
    info_pos = "7",
    info_type = 1,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [602020001] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,0)",
    id = 602020001,
    info = 130407,
    info_pos = "7",
    info_type = 1,
    step_type = 3
  },
  [602020100] = {
    id = 602020100,
    info = 327335,
    info_pos = "7",
    info_type = 1,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1
  },
  [602020101] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,2)",
    id = 602020101,
    info = 213772,
    info_pos = "7",
    info_type = 1,
    step_type = 3
  },
  [602020200] = {
    avg_name = "23winter_s09_1",
    avg_skip = true,
    delay = 0.4,
    guide_skip = false,
    id = 602020200,
    info_type = 0,
    step_type = 2
  },
  [602020201] = {
    delay = 1,
    id = 602020201,
    info = 174494,
    info_pos = "7",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [602020202] = {
    id = 602020202,
    info = 268938,
    info_pos = "7",
    info_type = 1002,
    step_type = 4
  },
  [602020203] = {
    custom_code = "GuideUtil.WCCameraFocus(13,13,1.5)",
    guide_skip = false,
    id = 602020203,
    info_type = 0,
    step_type = 3
  },
  [602020204] = {
    custom_code = "GuideUtil.WCCameraFocus(0,0,1.5)",
    guide_skip = false,
    id = 602020204,
    info_type = 0,
    step_type = 3
  },
  [602020205] = {
    id = 602020205,
    info = 309140,
    info_pos = "7",
    info_type = 1003,
    step_type = 4
  },
  [602020206] = {
    id = 602020206,
    info = 370653,
    info_pos = "7",
    info_type = 1002,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [602020207] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,0)",
    id = 602020207,
    info = 24918,
    info_pos = "7",
    info_type = 1002,
    step_type = 3
  },
  [602020208] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,0)",
    id = 602020208,
    info = 164958,
    info_pos = "7",
    info_type = 1003,
    step_type = 3
  },
  [612801101] = {
    avg_name = "59001221",
    avg_skip = true,
    delay = 0.2,
    id = 612801101,
    info_type = 0,
    step_type = 6
  },
  [613801101] = {
    avg_name = "59001281",
    avg_skip = true,
    delay = 0.2,
    id = 613801101,
    info_type = 0,
    step_type = 6
  },
  [613801102] = {
    avg_name = "59001283",
    avg_skip = true,
    delay = 0.2,
    id = 613801102,
    info_type = 0,
    step_type = 6
  },
  [613801103] = {
    avg_name = "59001284",
    avg_skip = true,
    delay = 0.2,
    id = 613801103,
    info_type = 0,
    step_type = 6
  },
  [613801104] = {
    avg_name = "59001285",
    avg_skip = true,
    delay = 0.2,
    id = 613801104,
    info_type = 0,
    step_type = 6
  },
  [613801105] = {
    avg_name = "59001286",
    avg_skip = true,
    delay = 0.2,
    id = 613801105,
    info_type = 0,
    step_type = 6
  },
  [613801106] = {
    avg_name = "59001287",
    avg_skip = true,
    delay = 0.2,
    id = 613801106,
    info_type = 0,
    step_type = 6
  },
  [614101101] = {
    avg_name = "59001301",
    avg_skip = true,
    delay = 0.2,
    id = 614101101,
    info_type = 0,
    step_type = 6
  },
  [614102101] = {
    id = 614102101,
    info = 32265,
    info_pos = "18",
    info_type = 1,
    step_type = 4
  },
  [614102201] = {
    id = 614102201,
    info = 475895,
    info_pos = "18",
    info_type = 1,
    step_type = 4
  },
  [614102301] = {
    id = 614102301,
    info = 49378,
    info_pos = "18",
    info_type = 1,
    step_type = 4
  },
  [614102401] = {
    id = 614102401,
    info = 15583,
    info_pos = "18",
    info_type = 1,
    step_type = 4
  },
  [614102501] = {
    id = 614102501,
    info = 90129,
    info_pos = "18",
    info_type = 1,
    step_type = 4
  },
  [701000101] = {
    delay = 1,
    id = 701000101,
    info = 105429,
    info_pos = "7",
    info_type = 1080,
    step_type = 4,
    wait_target = false
  },
  [701000102] = {
    delay = 1,
    guide_skip = false,
    id = 701000102,
    info = 423975,
    info_type = 1080,
    step_type = 4,
    wait_target = false
  },
  [701000103] = {
    delay = 1,
    guide_skip = false,
    id = 701000103,
    info = 278707,
    info_type = 1080,
    step_type = 4,
    wait_target = false
  },
  [701000104] = {
    id = 701000104,
    info = 475413,
    info_pos = "7",
    info_type = 1080,
    step_type = 5,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1
  },
  [701000105] = {
    id = 701000105,
    info = 363170,
    info_pos = "7",
    info_type = 1080,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [701000106] = {
    id = 701000106,
    info = 169269,
    info_pos = "7",
    info_type = 1080,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1
  },
  [701000107] = {
    id = 701000107,
    info = 219204,
    info_pos = "7",
    info_type = 1080,
    target_name = "3DUIRoot/UI_WarChessJumpSystem/JumpNode/btn_up",
    target_parent = "Test_WarChess",
    target_type = 2
  },
  [701000108] = {
    id = 701000108,
    info = 283028,
    info_pos = "7",
    info_type = 1080,
    step_type = 4
  },
  [701000109] = {
    id = 701000109,
    info = 213226,
    info_pos = "7",
    info_type = 1080,
    step_type = 4
  },
  [701000110] = {
    id = 701000110,
    info = 310616,
    info_pos = "7",
    info_type = 1080,
    step_type = 4
  },
  [701000111] = {
    id = 701000111,
    info = 132824,
    info_pos = "7",
    info_type = 1080,
    step_type = 4
  },
  [810000001] = {
    delay = 1,
    id = 810000001,
    info = 34837,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [810000002] = {
    delay = 1,
    id = 810000002,
    info = 125140,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [810000003] = {
    delay = 1,
    id = 810000003,
    info = 344599,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [810000004] = {
    delay = 1,
    id = 810000004,
    info = 264179,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [810000005] = {
    delay = 1,
    id = 810000005,
    info = 349424,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [810000006] = {
    custom_code = "GuideUtil.WCCameraFocus(3,6,0)",
    delay = 0,
    id = 810000006,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [810000007] = {
    delay = 1,
    id = 810000007,
    info = 209644,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [810000008] = {
    delay = 1,
    id = 810000008,
    info = 338131,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [810000009] = {
    custom_code = "GuideUtil.WCCameraFocus(1,0,0)",
    delay = 0,
    id = 810000009,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [810000010] = {
    delay = 1,
    id = 810000010,
    info = 507302,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [810000011] = {
    delay = 1,
    id = 810000011,
    info = 520063,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [810000012] = {
    delay = 1,
    id = 810000012,
    info = 326626,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [810000013] = {
    delay = 1,
    id = 810000013,
    info = 70360,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [810000014] = {
    id = 810000014,
    info = 185981,
    info_pos = "7",
    info_type = 1070,
    step_type = 5,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1
  },
  [810000015] = {
    delay = 1,
    id = 810000015,
    info = 312623,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [810000016] = {
    delay = 1,
    id = 810000016,
    info = 356786,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [810000017] = {
    delay = 1,
    id = 810000017,
    info = 312609,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [810000018] = {
    delay = 1,
    id = 810000018,
    info = 484348,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [810000019] = {
    id = 810000019,
    info = 353657,
    info_pos = "7",
    info_type = 1070,
    target_name = "Trans_Down/UINWarChessInPlay(Clone)/TeamList/Rect/1/TeamScale/TeamItem/Bottom",
    target_parent = 3501,
    target_type = 1
  },
  [810000020] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(2,1)",
    id = 810000020,
    info = 522261,
    info_pos = "7",
    info_type = 1070,
    step_type = 3
  },
  [810000021] = {
    id = 810000021,
    info = 188774,
    info_pos = "7",
    info_type = 1070,
    target_name = "Top/Trans_SpBottleHolder/UINWarChessLevelTrigger(Clone)",
    target_parent = 3501,
    target_type = 1
  },
  [810000022] = {
    custom_code = "GuideUtil.StartWCGridClickGuide(1,2)",
    id = 810000022,
    info = 411464,
    info_pos = "7",
    info_type = 1070,
    step_type = 3
  },
  [812000001] = {
    delay = 1,
    id = 812000001,
    info = 517704,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [812000002] = {
    delay = 1,
    id = 812000002,
    info = 504319,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [812000003] = {
    delay = 1,
    id = 812000003,
    info = 253092,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [812000004] = {
    delay = 1,
    id = 812000004,
    info = 507639,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [812000005] = {
    delay = 1,
    id = 812000005,
    info = 491606,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [812000006] = {
    delay = 1,
    id = 812000006,
    info = 452223,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [812000007] = {
    delay = 1,
    id = 812000007,
    info = 459371,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [812000008] = {
    delay = 1,
    id = 812000008,
    info = 507370,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [812000009] = {
    delay = 1,
    id = 812000009,
    info = 274507,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [812000010] = {
    custom_code = "GuideUtil.WCCameraFocus(4,8,0)",
    delay = 0,
    id = 812000010,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [812000011] = {
    delay = 1,
    id = 812000011,
    info = 155361,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [812000012] = {
    delay = 1,
    id = 812000012,
    info = 1126,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [812000013] = {
    delay = 1,
    id = 812000013,
    info = 133657,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [812000014] = {
    custom_code = "GuideUtil.WCCameraFocus(6,6,0)",
    delay = 0,
    id = 812000014,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [812000015] = {
    delay = 1,
    id = 812000015,
    info = 201765,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [812000016] = {
    custom_code = "GuideUtil.WCCameraFocus(6,12,0)",
    delay = 0,
    id = 812000016,
    info_type = 0,
    step_type = 3,
    wait_target = false
  },
  [812000017] = {
    delay = 1,
    id = 812000017,
    info = 248805,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [812000018] = {
    delay = 1,
    id = 812000018,
    info = 214471,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [812000019] = {
    delay = 1,
    id = 812000019,
    info = 513321,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [812000020] = {
    delay = 1,
    id = 812000020,
    info = 396934,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [812000021] = {
    delay = 1,
    id = 812000021,
    info = 398899,
    info_pos = "7",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [812000022] = {
    delay = 1,
    id = 812000022,
    info = 179917,
    info_pos = "7",
    info_type = 1002,
    step_type = 4,
    wait_target = false
  },
  [812000023] = {
    delay = 1,
    id = 812000023,
    info = 451559,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [812000024] = {
    delay = 1,
    id = 812000024,
    info = 347715,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [812000025] = {
    delay = 1,
    id = 812000025,
    info = 516420,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  },
  [812000026] = {
    delay = 1,
    id = 812000026,
    info = 273254,
    info_pos = "7",
    info_type = 1063,
    step_type = 4,
    wait_target = false
  },
  [812000027] = {
    delay = 1,
    id = 812000027,
    info = 483332,
    info_pos = "7",
    info_type = 1070,
    step_type = 4,
    wait_target = false
  }
}
local __default_values = {
  after_code = "",
  arrow_offset = __rt_1,
  avg_name = "",
  avg_skip = false,
  clear_code = "",
  complete_code = "",
  condition = 0,
  condition_arg = __rt_1,
  custom_code = "",
  custom_size = __rt_1,
  delay = 0.5,
  first_code = "",
  guide_skip = true,
  id = 100,
  info = "",
  info_pos = "",
  info_type = 1001,
  op_refresh = false,
  pic_id = 0,
  step_type = 1,
  target_name = "",
  target_parent = "",
  target_type = 0,
  wait_target = true
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(guide_step) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(guide_step, {__index = __rawdata})
return guide_step
