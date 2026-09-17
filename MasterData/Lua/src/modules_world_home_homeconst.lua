L_HomeConst = {}
local C_HomeConst = CS.Lens.Gameplay.Home.HomeConst
local _gameConstTpl = L_GameTpl:getGameConstTpl()
L_HomeConst.useCS = true
L_HomeConst.homeMainMode = {
  NONE = 0,
  CROP = 1,
  BUILD = 2,
  BUILD_LOCK = 3
}
L_HomeConst.homeBehaviorTree = {BEHAVIOR_ID = 601001, STRIKE_SKILL_ID = 9999}
L_HomeConst.homeLaborType = {
  PLANT = 1001,
  WATER = 1002,
  HARVEST = 1003,
  WOOD = 2001,
  STONE = 2002,
  MINE = 2003,
  HUNT = 2003,
  SMELT = 3003,
  COLLECTION_MANAGE = 5002,
  RANCH_GATHER = 6001,
  RANCH_PRODUCT = 6002,
  SATIETY_RESTORE = 7001
}
L_HomeConst.isWildLabor = {
  [L_HomeConst.homeLaborType.WOOD] = true,
  [L_HomeConst.homeLaborType.STONE] = true,
  [L_HomeConst.homeLaborType.MINE] = true,
  [L_HomeConst.homeLaborType.HUNT] = true
}
L_HomeConst.blockType = {
  BUILD = 0,
  CROP = 1,
  RANCH = 2,
  REST = 99
}
L_HomeConst.homeNormalSkillType = {BLINK = 1, HAPPY = 2}
L_HomeConst.operateDir = {
  C_Vector3.forward,
  C_Vector3.right,
  C_Vector3.back,
  C_Vector3.left
}
L_HomeConst.buffMergeType = {
  NONE = 0,
  BOOL = 1,
  SKILL = 2,
  ADD = 3,
  REPLACE = 4,
  ADD_MUL = 5,
  MINUS_MUL = 6,
  MIN = 7
}
L_HomeConst.buffConditionType = {
  FIELD_TYPE = 1011,
  SEED_TYPE = 1021,
  SEED_ID = 1022,
  COLLECTION_GROUP = 2011,
  COLLECTION_ID = 2012,
  PRODUCT_TYPE = 2021,
  PRODUCT_ID = 2022,
  PETEGG_ELEMENT = 2023,
  HOME_DROP_ELEMENT = 2024,
  HOME_DROP_RACE = 2025,
  PRODUCT_ELEMENT = 2026
}
L_HomeConst.buffValueType = {
  NORMAL = 1,
  PERCENT = 2,
  TIME = 3,
  PET_CAPTURE = 4
}
L_HomeConst.buffId = {
  CROP_SEED_SAVE_PROB = 1011,
  CROP_UPGRADE_PROB = 1012,
  CROP_REDUCE_TIME_PERCENT = 1013,
  CROP_DO_WATER_VALUE = 1021,
  CROP_FIELD_WATER_PERCENT = 1022,
  CROP_HARVEST_MULTIPLY_PROB = 1031,
  CROP_HARVEST_ADD_VALUE = 1032,
  CROP_HARVEST_EXTRA_ITEM_PROB = 1036,
  CROP_HARVEST_SEED_HARVEST = 1037,
  COLLECT_REDUCE_TIME_PERCENT = 2001,
  COLLECT_REWARD_ADD_VALUE = 2002,
  PRODUCT_REDUCE_TIME_PERCENT = 2011,
  PRODUCT_REWARD_EXTRA_ITEM_PROB = 2012,
  RANCH_REDUCE_TIME_PERCENT = 3001,
  ACCESSORY_REDUCE_TIME_PERCENT = 2027,
  EGG_REDUCE_TIME_PERCENT = 4002,
  PRODUCT_STATIC_TIME_VALUE = 5007,
  PET_CAPTURE_STRENGTH = 10000,
  FORMATION_HERO_ATTRIBUTE = 20000,
  FORMATION_PET_ATTTRIBUTE = 30000,
  CROP_OPEN_HYPER_NUM = 90001,
  CROP_PLANT_HYPER_NUM = 90002,
  CROP_WATER_HYPER_NUM = 90003,
  PETEGG_HATCHTIME_DECREASE_VALUE = 4001,
  PETEGG_HATCHTIME_DECREASE_PERCENT = 4002,
  COLLECTION_TOOL_RARITY_UNLOCK = 5027
}
L_HomeConst.workType2AutoType = {
  [L_HomeConst.homeLaborType.PLANT] = L_Const.HomePetAutoWorkType.HPAWT_PLANT,
  [L_HomeConst.homeLaborType.WATER] = L_Const.HomePetAutoWorkType.HPAWT_WATER,
  [L_HomeConst.homeLaborType.HARVEST] = L_Const.HomePetAutoWorkType.HPAWT_HARVEST
}
L_HomeConst.HomeLevelUnlockModuleType = {
  Block = 1,
  Building = 2,
  System = 3,
  Technology = 4,
  CommonItem = 5,
  BuildingNum = 6,
  MountSaddle = 7,
  Currency = 8
}
L_HomeConst.HomeLevelUnlockModuleRes = {
  [L_HomeConst.HomeLevelUnlockModuleType.Building] = {
    icon = "UI/Atlas/HomeLevel/tex_homelevle_icon_jz.png",
    color = C_Color(0.7137255, 0.6196079, 0.5058824, 1),
    unlockTip = "home_newBuildingTip"
  },
  [L_HomeConst.HomeLevelUnlockModuleType.System] = {
    icon = "UI/Atlas/HomeLevel/tex_homelevle_icon_gn.png",
    bg = "UI/Atlas/HomeLevel/tex_homelevle_bg_iconlx01.png",
    color = C_Color(0.7686275, 0.5803922, 0.5490196, 1)
  },
  [L_HomeConst.HomeLevelUnlockModuleType.Block] = {
    icon = "UI/Atlas/HomeLevel/tex_homelevle_icon_qy.png",
    bg = "UI/Atlas/HomeLevel/tex_homelevle_bg_iconlx03.png",
    color = C_Color(0.5647059, 0.7137255, 0.5058824, 1),
    unlockTip = "home_newAreaTip"
  },
  [L_HomeConst.HomeLevelUnlockModuleType.Technology] = {
    icon = "UI/Atlas/HomeLevel/tex_homelevle_icon_kj.png",
    bg = "UI/Atlas/HomeLevel/tex_homelevle_bg_iconlx02.png",
    color = C_Color(0.5803922, 0.6196079, 0.7215686, 1),
    unlockTip = "science_unlockTip"
  },
  [L_HomeConst.HomeLevelUnlockModuleType.CommonItem] = {
    icon = "UI/Atlas/HomeLevel/tex_homelevle_icon_jn.png",
    color = C_LuaUtility.ParseHtmlStringColor("#969FB9")
  },
  [L_HomeConst.HomeLevelUnlockModuleType.Currency] = {
    icon = "UI/Atlas/HomeLevel/tex_homelevle_icon_jn.png",
    color = C_LuaUtility.ParseHtmlStringColor("#969FB9")
  },
  [L_HomeConst.HomeLevelUnlockModuleType.MountSaddle] = {
    icon = "UI/Atlas/HomeLevel/tex_homelevle_icon_jn.png",
    color = C_LuaUtility.ParseHtmlStringColor("#969FB9")
  },
  [L_HomeConst.HomeLevelUnlockModuleType.BuildingNum] = {
    icon = "UI/Atlas/HomeLevel/tex_homelevle_icon_jz.png",
    color = C_Color(0.7137255, 0.6196079, 0.5058824, 1),
    unlockTip = "home_newBuildingTip"
  }
}
L_HomeConst.HomeOperateMode = {
  NONE = 0,
  BUILD = 1,
  CROP = 2
}
L_HomeConst.HomeCropState = {
  NONE = 0,
  SEED = 1,
  GROW1 = 2,
  GROW2 = 3,
  HARVEST = 4
}
L_HomeConst.HomeCropStateName = {
  [L_HomeConst.HomeCropState.NONE] = "",
  [L_HomeConst.HomeCropState.SEED] = "ui_homePlant_01",
  [L_HomeConst.HomeCropState.GROW1] = "ui_homePlant_02",
  [L_HomeConst.HomeCropState.GROW2] = "ui_homePlant_03",
  [L_HomeConst.HomeCropState.HARVEST] = "ui_homePlant_04"
}
L_HomeConst.ProductQueueState = {
  NONE = 0,
  WAITING = 1,
  PAUSE = 2,
  RUNNING = 3,
  FINISH = 4
}
L_HomeConst.FocusType = {
  NONE = 0,
  UPGRADE = 1,
  CENTER = 2
}
L_HomeConst.HomeBuffCountType = {
  PRODUCT = 10,
  PRODUCT_NO_ELEMENT = 11,
  PRODUCT_ELEMENT = 12,
  PLANT = 20,
  WATER = 21,
  HARVEST = 22,
  RANCH = 30,
  COLLECT = 40,
  COLLECT_NO_ELEMENT = 41,
  COLLECT_ELEMENT = 42,
  HATCH = 50
}
L_HomeConst.CommonItemRarity2PageBg = {
  [0] = "UI/Atlas/HomeProductBuilding/tex_homebuilding_bg_raritysqrtd_0.png",
  [1] = "UI/Atlas/HomeProductBuilding/tex_homebuilding_bg_raritysqrtd_1.png",
  [2] = "UI/Atlas/HomeProductBuilding/tex_homebuilding_bg_raritysqrtd_2.png",
  [3] = "UI/Atlas/HomeProductBuilding/tex_homebuilding_bg_raritysqrtd_3.png",
  [4] = "UI/Atlas/HomeProductBuilding/tex_homebuilding_bg_raritysqrtd_4.png"
}
L_HomeConst.HideNodeOfHomePet = "[Node-HomePet]"
L_HomeConst.HomeBuildIdOfPlow = C_HomeConst.HomeBuildIdOfPlow
L_HomeConst.HomeLaborId = {
  GENG_ZUO = 5,
  JIAO_SHUI = 6,
  ZHAO_LIAO = 9
}
L_HomeConst.HomeBuildingGroupIdType = {GENG_ZUO_XIAO_WU = 2017}
L_HomeConst.HomeBuildGroupType = {
  TABLE_WORK_BENCH = 1,
  TABLE_SAWBUCK = 2,
  TABLE_BRICK_KILN = 3,
  TABLE_SMELTER = 4,
  TABLE_SPINNING_WHEEL = 5,
  TABLE_LEATHER_TANNER = 6,
  TABLE_ELEMENTAL_STONE_FURNACE = 7,
  TABLE_PET_WORKSHOP = 8,
  TABLE_CUISINE = 9,
  TABLE_WEAPON_STATION = 10,
  TABLE_ARMOR = 11,
  TABLE_MILL = 14,
  SHOP_SAW_MILL = 15,
  SHOP_BRICK = 16,
  SHOP_SMELTER = 17,
  SHOP_LEATHER_TANNER = 18,
  SHOP_TEXTILE = 19,
  SHOP_WORK = 20,
  SHOP_FORGE = 21,
  SHOP_ARMOR = 22,
  SHOP_CUISINE = 24,
  MILL_SMELTER = 25
}
L_HomeConst.HomeBuildFunctionType = {
  PRODUCT = 1,
  CUISINE = 2,
  EQUIP = 3
}
L_HomeConst.HomeBuildGroupID = {
  PET_DINING_TABLE = 1001,
  DRY_FARMLAND = 2016,
  FARMING_HUT = 2017,
  HATCHING_PILE = 3023,
  DRY_FERTILE_FARMLAND = 2033
}
L_HomeConst.BuildType2Page = {
  [L_Const.WorldMapBuildType.WMBT_DORM] = "pageHomeDormitory",
  [L_Const.WorldMapBuildType.WMBT_PRO_BUILD] = "pageProduct",
  [L_Const.WorldMapBuildType.WMBT_PRO_ORNAMENT] = "pageProduct",
  [L_Const.WorldMapBuildType.WMBT_PRO_COMMON] = "pageProduct",
  [L_Const.WorldMapBuildType.WMBT_PRODUCT] = "pageProduct",
  [L_Const.WorldMapBuildType.WMBT_PET_CANTEEN] = "pageSatiety",
  [L_Const.WorldMapBuildType.WMBT_COOK] = "pageProduct",
  [L_Const.WorldMapBuildType.WMBT_HATCH] = "pageProduct",
  [L_Const.WorldMapBuildType.WMBT_PRO_ORNAMENT] = "pageProductAccessory",
  [11] = "pageProduct",
  [13] = "pageHomeCollectionManage",
  [16] = "pageHomeCropPet",
  [L_Const.WorldMapBuildType.WMBT_HOME_ORDER] = "PageHomeExchangeSell",
  [L_Const.WorldMapBuildType.WMBT_HOME_COLLECT] = "pageHomeCollection"
}
L_HomeConst.StationBuildingType = {
  HomeBuilding = 1,
  Collection = 2,
  Crop = 3,
  Ranch = 4,
  HomeCollection = 6
}
L_HomeConst.StationType = {
  HomeBuilding = 1,
  Collection = 2,
  Crop = 3,
  Ranch = 4,
  CollectionManage = 5,
  HomeCollection = 6
}
L_HomeConst.HomeCenterProductionBuildingStatus = {
  Working = 1,
  NotSetPet = 2,
  Pause = 3,
  Free = 4,
  UnFixed = 5,
  Full = 6,
  CanReceiveAllQueueReward = 7
}
L_HomeConst.HomeCenterProductionBuildingStatusText = {
  [L_HomeConst.HomeCenterProductionBuildingStatus.Working] = "notice_cellHomeCollection_01",
  [L_HomeConst.HomeCenterProductionBuildingStatus.NotSetPet] = "notice_cellHomeCollection_02",
  [L_HomeConst.HomeCenterProductionBuildingStatus.Pause] = "notice_cellHomeCollection_03",
  [L_HomeConst.HomeCenterProductionBuildingStatus.Free] = "notice_cellHomeCollection_04",
  [L_HomeConst.HomeCenterProductionBuildingStatus.UnFixed] = "",
  [L_HomeConst.HomeCenterProductionBuildingStatus.Full] = "notice_cellHomeCollection_05",
  [L_HomeConst.HomeCenterProductionBuildingStatus.CanReceiveAllQueueReward] = "ui_homemanage_tag_tobeclaimed"
}
L_HomeConst.HomeCenterProductionBuildingStatusColor = {
  [L_HomeConst.HomeCenterProductionBuildingStatus.Working] = "#819965",
  [L_HomeConst.HomeCenterProductionBuildingStatus.NotSetPet] = "#ba3f2e",
  [L_HomeConst.HomeCenterProductionBuildingStatus.Pause] = "#ba3f2e",
  [L_HomeConst.HomeCenterProductionBuildingStatus.Free] = "#87725A",
  [L_HomeConst.HomeCenterProductionBuildingStatus.UnFixed] = "#87725A",
  [L_HomeConst.HomeCenterProductionBuildingStatus.Full] = "#e0923e",
  [L_HomeConst.HomeCenterProductionBuildingStatus.CanReceiveAllQueueReward] = "#e0923e"
}
L_HomeConst.HomeCenterProductionBuildingStatusIcon = {
  [L_HomeConst.HomeCenterProductionBuildingStatus.Working] = "UI/Atlas/Collection/tex_home_collection_markers_icon_gzz.png",
  [L_HomeConst.HomeCenterProductionBuildingStatus.NotSetPet] = "UI/Atlas/Collection/tex_home_collection_markers_icon_cw.png",
  [L_HomeConst.HomeCenterProductionBuildingStatus.Pause] = "UI/Atlas/Collection/tex_home_collection_markers_icon_jg.png",
  [L_HomeConst.HomeCenterProductionBuildingStatus.Free] = "",
  [L_HomeConst.HomeCenterProductionBuildingStatus.UnFixed] = "",
  [L_HomeConst.HomeCenterProductionBuildingStatus.Full] = "UI/Atlas/Collection/tex_home_collection_markers_icon_ck.png",
  [L_HomeConst.HomeCenterProductionBuildingStatus.CanReceiveAllQueueReward] = "UI/Atlas/Collection/tex_homemanage_icon_item_sh.png"
}
L_HomeConst.ProductInfoDescType = {
  Normal = 1,
  Egg = 2,
  Accessory = 3
}
L_HomeConst.SourceOfPlayModuleProductInfoAnimation = {OnClickTab = 1, OnClickItem = 2}
L_HomeConst.MainHeroHomeSkillIdList = {
  _gameConstTpl:getData("HOME_SKILLID_HOE_HEROINE", L_Const.GameTplType.int),
  _gameConstTpl:getData("HOME_SKILLID_SOW_HEROINE", L_Const.GameTplType.int),
  _gameConstTpl:getData("HOME_SKILLID_WATER_HEROINE", L_Const.GameTplType.int),
  _gameConstTpl:getData("HOME_SKILLID_HOE_HERO", L_Const.GameTplType.int),
  _gameConstTpl:getData("HOME_SKILLID_SOW_HERO", L_Const.GameTplType.int),
  _gameConstTpl:getData("HOME_SKILLID_WATER", L_Const.GameTplType.int)
}
