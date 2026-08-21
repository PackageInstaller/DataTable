local HomeLandErrorType = {
  E_HOME_LAND_TYPE_SUCCESS = 0,
  E_HOME_LAND_TYPE_FAILURE = 1,
  E_HOME_LAND_LOAD_ERROR = 2,
  E_HOME_LAND_SAVE_ERROR = 3,
  E_HOME_LAND_UNLOCK = 4,
  E_MATERIAL_NOT_ENOUGH = 5,
  E_QUEUE_NOT_UNLOCK = 6,
  E_DRAWING_NOT_ENOUGH = 7,
  E_ARCHITECTURE_NOT_UNLOCK = 8,
  E_FORGE_TIME_NOT_END = 9,
  E_CONFIG_ERROR = 10,
  E_QUEUE_REPEATED = 11,
  E_NOT_FORGE_ITEM = 12,
  E_FORGE_END = 13,
  E_FORGE_LIMIT = 14,
  E_HOME_LAND_CAN_NOT_SIGN = 15,
  E_PLAY_FUNCTION_UNLOCK = 20,
  E_PLAY_FUNCTION_AS_Shabby = 21,
  E_PLAY_FUNCTION_Fix_Shabby_No_Arch = 22,
  E_PLAY_FUNCTION_Fix_Shabby_ArchId_Invalid = 23,
  E_PLAY_FUNCTION_Fix_Shabby_Asset_Not_Enough = 24,
  E_PLAY_FUNCTION_Fix_Shabby_Del_Asset_Error = 25,
  E_SCENE_NOT_ARCHITECTURE = 30,
  E_SKIN_NOT_EXIST = 31,
  E_ARCHITECTURE_NOT_ENOUGH = 32,
  E_DORMITORY_HAS_PET = 33,
  E_ARCHITECTURE_NOT_DELETE = 34,
  E_ARCHITECTURE_NOT_UPDATE = 35,
  E_LAND_CULTIATION = 36,
  E_BUILD_MAX_LIMIT = 37,
  E_BUILD_SON_ARCH_ERROR = 38,
  E_TOOL_NOT_EXIST = 40,
  E_FELL_TIMES_NOT_ENOUGH = 41,
  E_DROP_TIMES_LIMIT = 42,
  E_TREE_ERROR = 43,
  E_TOOL_DROPID_NOT_EXIST = 44,
  E_HANG_POINT_ALREADY_CLEAN = 45,
  E_DORMITORY_INDEX_INVALID = 60,
  E_DORMITORY_PET_HAS_CHECKIN = 61,
  E_DORMITORY_PET_INDEX_INVALID = 62,
  E_DORMITORY_PET_INVALID = 63,
  E_HET_TREASURE_MAXSIZE = 80,
  E_HET_TREASURE_REQ_ERROR = 81,
  E_HET_TREASURE_COUNT_FEW = 82,
  E_HET_TREASURE_REQ_REPEAT = 83,
  E_HET_TREASURE_CFG_ERROR = 84,
  E_HET_TREASURE_CFGVIEW_ERROR = 85,
  E_HET_TREASURE_REQ_NOFIND = 86,
  E_HET_TREASURE_REQ_STATE = 87,
  E_HET_TREASURE_DB_CFG = 88,
  E_HET_TREASURE_NO_SHOVEL = 89,
  E_HET_SHOP_REQ_ID_ERROR = 100,
  E_HET_SHOP_REQ_NUM_ERROR = 101,
  E_HET_SHOP_CFG_ERROR = 102,
  E_HET_SHOP_LIMIT = 103,
  E_HET_SHOP_NUM_FEW = 104,
  E_HET_SHOP_REQ_NOFIND = 105,
  E_HET_SHOP_REFRESH_FEW = 106,
  E_HET_SHOP_REFRESH_ERROR = 107,
  E_HET_SHOP_GOODS_SELL_ERROR = 108,
  E_HET_SHOP_GOODS_NUM_FEW = 109,
  E_HET_SHOP_BUY_ONCELIMIT = 110,
  E_HET_SHOP_ITEMMAX = 111,
  E_HET_SHOP_INITFIX = 112,
  E_FISHINT_PLAYER_HAVE_NO_ROD = 201,
  E_FISHINT_PLAYER_RODLEVEL_OR_POSTIONID_ERROR = 202,
  E_FISHINT_BITE_HOOK_TOO_OFTEN = 203,
  E_FISHING_RANDOM_OUTPUT_EMPTY = 204,
  E_FISHING_HAVENT_BITE_HOOK = 205,
  E_FISHING_CLUE_TIMES_BEYOND_LIMIT = 206,
  E_FISHING_CLUE_RARE_POSITION_EXIST = 207,
  E_FISHING_ASSET_NOT_ENOUGH = 208,
  E_FISHING_RAND_RARE_HAVENT_RESULT = 209,
  E_FISHING_REWARD_ERROR = 210,
  E_CHALLENGE_END = 211,
  E_ARCHITECTURE_NOT_FOUND = 301,
  E_CULTIVATION_END = 302,
  E_ARCHITECTURE_CULTIVATING = 303,
  E_CULTIVATION_SEED_NOT_ENOUGH = 304,
  E_CULTIVATION_RARITY_NOT_S = 305,
  E_WISH_ITEM_ID_ERROR = 401,
  E_WISH_NOT_VIEWER_FISH = 402,
  E_WISH_CANNT_FIND_CFG = 403,
  E_WISH_NO_FISH_CAN_COLLECT = 404,
  E_WISH_THIS_COIN_IN_POOL = 405,
  E_WISH_THIS_FISH_NOT_IN_POOL = 406,
  E_WISH_ONLY_FISH_CAN_TAKEOUT = 407,
  E_WISH_TOO_MANY_FISHES = 408,
  E_EVENT_TRIGGER_NUM_ERROR = 501,
  E_EVENT_TRIGGER_ID_INVALID = 502,
  E_EVENT_TRIGGER_LIMIT_SCENE = 503,
  E_EVENT_TRIGGER_LIMIT_TODAY = 504,
  E_EVENT_TRIGGER_IS_TRIGGER = 505,
  E_EVENT_TRIGGER_PET_REPEAT = 506,
  E_EVENT_PET_INVALID = 507,
  E_EVENT_TRIGGER_EVENT_IS_FINISH = 508,
  E_EVENT_TRIGGER_COND_INVALID = 509,
  E_EVENT_TRIGGER_MANY = 510,
  E_EVENT_TRIGGER_PET_NOT_IN_DORMITORY = 511,
  E_EVENT_TREASURE_IS_TRIGGER = 512,
  E_DAIRY_NOT_FIND_CFG = 531,
  E_DAIRY_EVENT_NOT_FINISH = 532,
  E_EVENT_FINISH_ID_INVALID = 550,
  E_HET_VISIT_NO_FRIEND = 600,
  E_HET_VISIT_NO_PEER_FRIEND = 601,
  E_HET_VISIT_PEER_UNLOCK = 602,
  E_HET_VISIT_NOT_PID = 603,
  E_HET_VISIT_TAKE_NO_ITEM = 604,
  E_HET_VISIT_TAKE_NO_SAME = 605,
  E_HET_VISIT_TAKE_TIME_MAX = 606,
  E_HET_VISIT_TAKE_ONCE = 607,
  E_HET_VISIT_MOVE_NUM_FEW = 608,
  E_HET_VISIT_MOVE_NUM_MAX = 609,
  E_HET_VISIT_MOVE_NO_ITEM = 610,
  E_HET_VISIT_FORGE_TIME_MAX = 611,
  E_HET_VISIT_FORGE_ONCE = 612,
  E_HET_VISIT_FORGE_NO_ACC = 613,
  E_HET_VISIT_CULTIVATE_TIME_MAX = 614,
  E_HET_VISIT_CULTIVATE_ONCE = 615,
  E_HET_VISIT_CULTIVATE_NO_ACC = 616,
  E_HET_VISIT_CULTIVATE_NO_LAND = 617,
  E_HET_VISIT_MOVE_NO_CFG = 618,
  E_HET_VISIT_MOVE_CFG_OVERFLOW = 619,
  E_HET_VISIT_MOVE_NO_CHANGE = 620,
  E_HET_VISIT_TAKE_ID_ZERO = 621,
  E_HET_VISIT_STATE_LOCK = 622,
  E_HET_TASK_NOT_FIND = 700,
  E_HET_TASK_WAS_COMPLETED = 701,
  E_HET_TASK_CONFIG_ERROR = 702,
  E_HET_TASK_CAMPAIGN_NOT_OPEN = 703,
  E_HET_TASK_PRE_QUEST_NOT_COMPLETE = 704,
  E_HET_TASK_GROUP_NOT_OPEN = 705,
  E_HET_TASK_GROUP_NEEDITEM = 706,
  E_HET_TASK_CAMPAIGN_IS_END = 707,
  E_HET_TASK_CAMPAIGN_COMP_IS_END = 708,
  E_HET_TASK_BEFORE_STORY_NOT_VIEW = 709,
  E_HET_TASK_AFTER_STORY_NOT_VIEW = 710,
  E_HET_TASK_COMPLETE_COND_NO_FINISH = 711,
  E_HET_TASK_STORY_MASK_ERROR = 712,
  E_HET_TASK_STORY_NO_BEFORE = 713,
  E_HET_TASK_STORY_NO_AFTER = 714,
  E_HET_TASK_STATUS_ISNOT_COMPLETE = 715,
  E_HET_TASK_QUEST_TAKE_ERROR = 716,
  E_HET_TASK_GROUP_ID_INVALID = 717,
  E_HET_TASK_GROUP_END_QUEST_NOT_FINISH = 718,
  E_HET_TASK_GROUP_HAD_RECVED = 719,
  E_HET_STORY_TASK_NOT_CFG = 800,
  E_HET_STORY_TASK_ERROR_CFG = 801,
  E_HET_STORY_TASK_ERROR_CFG_LOCK = 802,
  E_HET_STORY_TASK_ERROR_CFG_TIME = 803,
  E_HET_STORY_TASK_ERROR_ID_REPEAT = 804,
  E_HET_STORY_TASK_ERROR_ITEMNUM_FEW = 805,
  E_HET_STORY_TASK_ERROR_LOCK = 806,
  E_HET_STORY_TASK_ERROR_NO_AUTOOPERATE = 807,
  E_HET_STORY_TASK_ERROR_ID_TASKID_MATCH = 808,
  E_HET_STORY_TASK_ERROR_UNLOCK_MODULE = 809,
  E_MOVICE_NOT_UNLOCK = 901,
  E_ROLE_NUM_ERROR = 902,
  E_ITEM_NUM_ERROR = 903,
  E_CHOSE_ERROR = 904,
  E_ANONYMOUS_LETTER_ALREADY_RECEIVE = 905,
  E_ANONYMOUS_LETTER_NOT_UNLOCK = 906
}
_enum("HomeLandErrorType", HomeLandErrorType)
local HomelandPlayType = {
  HomelandPlayType_Begin = 1,
  E_PLAY_FORGE = 1,
  E_PLAY_BUILD = 2,
  E_PLAY_FISHING = 3,
  E_PLAY_FELL = 4,
  E_PLAY_DORMITORY = 5,
  E_PLAY_SHOP = 6,
  E_PLAY_TREASURE = 7,
  E_PLAY_CULTIVATION = 8,
  E_PLAY_EVENT = 9,
  E_PLAY_WISHING_POOL = 10,
  E_PLAY_MINING = 11,
  E_PLAY_SIGN = 12,
  E_PLAY_VISIT = 13,
  E_PLAY_TASK = 14,
  E_PLAY_TASK_MOVE_ITEM = 15,
  E_PLAY_STORY_TASK = 16,
  E_PLAY_FATHER_ARCH = 17,
  E_PLAY_FISH_TANK = 18,
  E_PALY_MOVICE = 19,
  HomelandPlayType_End = 20
}
_enum("HomelandPlayType", HomelandPlayType)
local HomelandUnlockType = {
  HomelandUnlockType_Begin = 0,
  E_HOMELAND_UNLOCK_SIGN_UI = 0,
  E_HOMELAND_UNLOCK_FELL_UI = 1,
  E_HOMELAND_UNLOCK_MINING_UI = 2,
  E_HOMELAND_UNLOCK_QUEST_BTN = 3,
  E_HOMELAND_UNLOCK_QUEST_GUIDE_UI = 4,
  E_HOMELAND_UNLOCK_BAG_UI = 5,
  E_HOMELAND_UNLOCK_MAIN_ARC_UI = 6,
  E_HOMELAND_UNLOCK_BUILD_UI = 7,
  E_HOMELAND_UNLOCK_LEVEL_BTN_UI = 8,
  E_HOMELAND_UNLOCK_DAIRY_UI = 9,
  E_HOMELAND_UNLOCK_FISHING_UI = 10,
  E_HOMELAND_UNLOCK_SHOP_ARC_UI = 11,
  E_HOMELAND_UNLOCK_FISHING_BOX = 12,
  E_HOMELAND_UNLOCK_PHOTO_UI = 13,
  E_HOMELAND_UNLOCK_WISHING_POOL_UI = 14,
  E_HOMELAND_UNLOCK_QUEST_STAGE_UI = 15,
  E_HOMELAND_UNLOCK_VISIT_UI = 16,
  E_HOMELAND_UNLOCK_VISIT_BOX_UI = 17,
  E_HOMELAND_UNLOCK_QUEST_COMMON_UI = 18,
  E_HOMELAND_UNLOCK_EVENT = 19,
  E_HOMELAND_UNLOCK_FOLLOW_UI = 20,
  E_HOMELAND_UNLOCK_CAMPAIGN = 21,
  E_HOMELAND_UNLOCK_TREASURE = 22,
  E_HOMELAND_UNLOCK_STORY_TASK = 23,
  E_HOMELAND_UNLOCK_ALBUM = 24,
  E_HOMELAND_UNLOCK_MEDAL_WALL = 25,
  HomelandUnlockType_End = 26
}
_enum("HomelandUnlockType", HomelandUnlockType)
local EHomelandGroupTaskCond = {
  EHomelandGroupTaskCond_INVALID = 0,
  EHomelandGroupTaskCond_Begin = 2100,
  EHomelandGroupTaskCond_GroupTask = 2100,
  EHomelandGroupTaskCond_ViewStory = 2101,
  EHomelandGroupTaskCond_End = 2200
}
_enum("EHomelandGroupTaskCond", EHomelandGroupTaskCond)
local ToolType = {
  TT_AXE = 1,
  TT_FISHING_ROD = 2,
  TT_PICK = 3,
  TT_SHOVEL = 4
}
_enum("ToolType", ToolType)
local FishType = {
  FT_OrderFish = 1,
  FT_ViewerFish = 2,
  FT_Garbage = 3
}
_enum("FishType", FishType)
local CultivationItemType = {
  E_ACCELERATION = 1,
  E_MUST_BREAK = 2,
  E_DIRECTIONAL_BREAK = 3,
  E_DYE = 4,
  E_STATE_CHANGE = 5
}
_enum("CultivationItemType", CultivationItemType)
local RarityType = {
  C = 1,
  B = 2,
  A = 3,
  S = 4
}
_enum("RarityType", RarityType)
local HomelandShopType = {
  HST_NOTHING = 0,
  HST_WEEK = 1,
  HST_LIMIT = 2,
  HST_MONTH = 3
}
_enum("HomelandShopType", HomelandShopType)
local HomelandGoodsType = {
  HGT_COMMON = 0,
  HGT_ADVANCED = 1,
  HGT_INITFIX = 2
}
_enum("HomelandGoodsType", HomelandGoodsType)
local TreasureState = {
  TS_BORN = 0,
  TS_FIND = 1,
  TS_GRAB = 2,
  TS_DEAD = 3,
  TS_DESTROY = 4
}
_enum("TreasureState", TreasureState)
local TreasureViewType = {
  TVT_NULL = 1,
  TVT_SIGN = 2,
  TVT_ASSO = 3
}
_enum("TreasureViewType", TreasureViewType)
local FinishConditionEnum = {
  FinishConditionEnum_Begin = 1,
  Position = 1,
  Dialog = 2,
  PetSearch = 3,
  PetNeed = 4,
  FinishGame = 5,
  Item = 6,
  PetInteraction = 7,
  NpcInteraction = 8,
  FinishConditionEnum_End = 1000,
  Other = 1001
}
_enum("FinishConditionEnum", FinishConditionEnum)
local HomelandVisitMask = {
  HVM_Enter = 1,
  HVM_Forge = 2,
  HVM_Cultivation = 4,
  HVM_Item = 8
}
_enum("HomelandVisitMask", HomelandVisitMask)
local HomelandVisitItemNum = {HV_PutItemMaxNum = 10}
_enum("HomelandVisitItemNum", HomelandVisitItemNum)
local ArchitectureType = {Homeland_Put_Architecture = 1, Homeland_Default_Architecture = 2}
_enum("ArchitectureType", ArchitectureType)
local ArchitectureSubType = {
  Normal = 1,
  Air_Style_Architecture = 101,
  Fence = 201,
  Wall = 202,
  Floor = 203,
  Table = 301,
  Chair = 302,
  Landscape = 303,
  Decorate = 304,
  Interesting_Furnishing = 401,
  Dormitory = 402,
  Land = 403,
  FishTank = 404,
  White_Tower = 501,
  Museum = 502,
  Shop = 503,
  Wishing_Pool = 504,
  Storage_Box = 505,
  Album = 506,
  Medal_Wall = 507,
  Tree = 601,
  Father_Architecture = 701,
  Son_Architecture = 702
}
_enum("ArchitectureSubType", ArchitectureSubType)
local CultivationType = {
  Mutation = 1,
  Directional = 2,
  Dyeing = 3,
  StateChange = 4
}
_enum("CultivationType", CultivationType)
local ScoreType = {
  RoleScore = 1,
  ItemScore = 2,
  OptionScore = 3
}
_enum("ScoreType", ScoreType)
_class("PosInfo", Object)
PosInfo = PosInfo

function PosInfo:Constructor()
  self.x = 0
  self.y = 0
  self.z = 0
end

PosInfo._proto = {
  [1] = {"x", "float"},
  [2] = {"y", "float"},
  [3] = {"z", "float"}
}
_class("ForgeItemInfo", Object)
ForgeItemInfo = ForgeItemInfo

function ForgeItemInfo:Constructor()
  self.item_id = 0
  self.begin_time = 0
  self.end_time = 0
  self.index = 0
  self.total_reduce_time = 0
end

ForgeItemInfo._proto = {
  [1] = {"item_id", "int"},
  [2] = {"begin_time", "time"},
  [3] = {"end_time", "time"},
  [4] = {"index", "int"},
  [5] = {
    "total_reduce_time",
    "time"
  }
}
_class("ForgeQueueInfo", Object)
ForgeQueueInfo = ForgeQueueInfo

function ForgeQueueInfo:Constructor()
  self.forge_list = {}
  self.unlock_architecture_list = {}
  self.already_forge_list = {}
end

ForgeQueueInfo._proto = {
  [1] = {
    "forge_list",
    "list<ForgeItemInfo>"
  },
  [2] = {
    "unlock_architecture_list",
    "list<int>"
  },
  [3] = {
    "already_forge_list",
    "list<int>"
  }
}
_class("Architecture", Object)
Architecture = Architecture

function Architecture:Constructor()
  self.asset_id = 0
  self.skin = 0
  self.pos_x = 0
  self.pos_z = 0
  self.rot = 0
  self.pstid = 0
  self.status = 1
  self.parent = 0
  self.pos_y = 0
end

Architecture._proto = {
  [1] = {"asset_id", "int"},
  [2] = {"skin", "int"},
  [3] = {"pos_x", "int"},
  [4] = {"pos_z", "int"},
  [5] = {"rot", "int"},
  [6] = {"pstid", "uint64"},
  [7] = {"status", "int"},
  [8] = {"parent", "int"},
  [9] = {"pos_y", "int"}
}
_class("SceneArchitecture", Object)
SceneArchitecture = SceneArchitecture

function SceneArchitecture:Constructor()
  self.architecture_list = {}
end

SceneArchitecture._proto = {
  [1] = {
    "architecture_list",
    "map<uint64,Architecture>"
  }
}
local FishingEntryType = {
  FET_Normal = 1,
  FET_SpecialWishingCoin = 2,
  FET_FishingCampaignChallenge = 3,
  FET_RarePosition = 4,
  FET_FishingPetChallenge = 5
}
_enum("FishingEntryType", FishingEntryType)
local FishingMatchResult = {Success = 0, Fail = 1}
_enum("FishingMatchResult", FishingMatchResult)
_class("FishingPositionData", Object)
FishingPositionData = FishingPositionData

function FishingPositionData:Constructor()
  self.fishing_position_id = 0
  self.fishs_num = 0
  self.next_refresh_time = 0
end

FishingPositionData._proto = {
  [1] = {
    "fishing_position_id",
    "int"
  },
  [2] = {"fishs_num", "int"},
  [3] = {
    "next_refresh_time",
    "time"
  }
}
_class("ClueRareStatus", Object)
ClueRareStatus = ClueRareStatus

function ClueRareStatus:Constructor()
  self.rare_fishing_position = 0
  self.today_submit_times = 0
end

ClueRareStatus._proto = {
  [1] = {
    "rare_fishing_position",
    "int"
  },
  [2] = {
    "today_submit_times",
    "int"
  }
}
_class("FishingData", Object)
FishingData = FishingData

function FishingData:Constructor()
  self.last_bite_hook_time = 0
  self.last_refresh_postion = 0
  self.fishing_postions_data = {}
  self.append_wishingcoin_position = {}
  self.clue_submit_status = {}
  self.clue_submit_refresh_time = 0
  self.challenge_pet_times = {}
end

FishingData._proto = {
  [1] = {
    "last_bite_hook_time",
    "time"
  },
  [2] = {
    "last_refresh_postion",
    "time"
  },
  [3] = {
    "fishing_postions_data",
    "list<FishingPositionData>"
  },
  [4] = {
    "append_wishingcoin_position",
    "list<int>"
  },
  [5] = {
    "clue_submit_status",
    "map<int,ClueRareStatus>"
  },
  [6] = {
    "clue_submit_refresh_time",
    "time"
  },
  [7] = {
    "challenge_pet_times",
    "map<int,int>"
  }
}
_class("TreeInfo", Object)
TreeInfo = TreeInfo

function TreeInfo:Constructor()
  self.tree_id = 0
  self.fell_times = 0
end

TreeInfo._proto = {
  [1] = {"tree_id", "int"},
  [2] = {"fell_times", "int"}
}
_class("FellInfo", Object)
FellInfo = FellInfo

function FellInfo:Constructor()
  self.infos = {}
  self.last_fell_time = 0
  self.next_refresh_time = 0
end

FellInfo._proto = {
  [1] = {
    "infos",
    "list<TreeInfo>"
  },
  [2] = {
    "last_fell_time",
    "time"
  },
  [3] = {
    "next_refresh_time",
    "time"
  }
}
_class("homelandGoodsInfo", Object)
homelandGoodsInfo = homelandGoodsInfo

function homelandGoodsInfo:Constructor()
  self.item_info = {}
  self.cfg_id = 0
end

homelandGoodsInfo._proto = {
  [1] = {
    "item_info",
    "list<RoleAsset>"
  },
  [2] = {"cfg_id", "int"}
}
_class("homelandShopInfo", Object)
homelandShopInfo = homelandShopInfo

function homelandShopInfo:Constructor()
  self.chs_map = {}
  self.goods_info = {}
  self.goods_refresh_time = 0
  self.goods_num = 0
  self.goods_rand_num = {}
  self.goods_week_time = 0
  self.goods_moth_time = 0
end

homelandShopInfo._proto = {
  [1] = {
    "chs_map",
    "map<int,int>"
  },
  [2] = {
    "goods_info",
    "map<int,homelandGoodsInfo>"
  },
  [3] = {
    "goods_refresh_time",
    "time"
  },
  [4] = {"goods_num", "int"},
  [5] = {
    "goods_rand_num",
    "list<int>"
  },
  [6] = {
    "goods_week_time",
    "time"
  },
  [7] = {
    "goods_moth_time",
    "time"
  }
}
_class("treasureInfo", Object)
treasureInfo = treasureInfo

function treasureInfo:Constructor()
  self.content_id = 0
  self.content_view_id = 0
  self.tips_id = 0
  self.dead_time = 0
  self.state = 0
  self.asso_pos = PosInfo:New()
  self.pet_id = 0
end

treasureInfo._proto = {
  [1] = {"content_id", "int"},
  [2] = {
    "content_view_id",
    "int"
  },
  [3] = {"tips_id", "int"},
  [4] = {"dead_time", "time"},
  [5] = {"state", "int"},
  [6] = {"asso_pos", "PosInfo"},
  [7] = {"pet_id", "int64"}
}
_class("homelandTreasure", Object)
homelandTreasure = homelandTreasure

function homelandTreasure:Constructor()
  self.treasures = {}
  self.trea_refresh_time = 0
end

homelandTreasure._proto = {
  [1] = {
    "treasures",
    "map<int,treasureInfo>"
  },
  [2] = {
    "trea_refresh_time",
    "time"
  }
}
_class("dormitory_room", Object)
dormitory_room = dormitory_room

function dormitory_room:Constructor()
  self.petList = {}
  self.name = ""
  self.index = 0
  self.bBulid = false
  self.hasAddFaPetList = {}
  self.architectureID = 0
  self.buildTime = 0
end

dormitory_room._proto = {
  [1] = {
    "petList",
    "map<int,int64>"
  },
  [2] = {"name", "string"},
  [3] = {"index", "int"},
  [4] = {"bBulid", "bool"},
  [5] = {
    "hasAddFaPetList",
    "list<int64>"
  },
  [6] = {
    "architectureID",
    "int64"
  },
  [7] = {"buildTime", "time"}
}
_class("dormitoryInfo", Object)
dormitoryInfo = dormitoryInfo

function dormitoryInfo:Constructor()
  self.list = {}
  self.pop_tips = false
  self.next_refresh_story_time = 0
end

dormitoryInfo._proto = {
  [1] = {
    "list",
    "list<dormitory_room>"
  },
  [2] = {"pop_tips", "bool"},
  [3] = {
    "next_refresh_story_time",
    "time"
  }
}
local HomelandEventType = {
  HET_Normal = 0,
  HET_ClientForceFinish = 1,
  HET_QuestTrigger = 2,
  HET_QuestComplete = 3,
  HET_NewPlayerGuide = 4
}
_enum("HomelandEventType", HomelandEventType)
_class("homelandEventInfo", Object)
homelandEventInfo = homelandEventInfo

function homelandEventInfo:Constructor()
  self.trigger_event_list = {}
  self.finish_event_list = {}
  self.today_finish_times = 0
  self.last_refresh_time = 0
  self.next_not_trigger_pets = {}
end

homelandEventInfo._proto = {
  [1] = {
    "trigger_event_list",
    "map<int,time>"
  },
  [2] = {
    "finish_event_list",
    "map<int,time>"
  },
  [3] = {
    "today_finish_times",
    "int"
  },
  [4] = {
    "last_refresh_time",
    "time"
  },
  [5] = {
    "next_not_trigger_pets",
    "list<int>"
  }
}
_class("MutationCultivation", Object)
MutationCultivation = MutationCultivation

function MutationCultivation:Constructor()
  self.main_seed_id = 0
  self.second_seed_id = 0
  self.addtion_item_id = 0
  self.target_tree_id = 0
end

MutationCultivation._proto = {
  [1] = {
    "main_seed_id",
    "int"
  },
  [2] = {
    "second_seed_id",
    "int"
  },
  [3] = {
    "addtion_item_id",
    "int"
  },
  [4] = {
    "target_tree_id",
    "int"
  }
}
_class("DirectionalCultivation", Object)
DirectionalCultivation = DirectionalCultivation

function DirectionalCultivation:Constructor()
  self.seed_id = 0
end

DirectionalCultivation._proto = {
  [1] = {"seed_id", "int"}
}
_class("DyeCultivation", Object)
DyeCultivation = DyeCultivation

function DyeCultivation:Constructor()
  self.tree_id = 0
  self.dye_item_id = 0
end

DyeCultivation._proto = {
  [1] = {"tree_id", "int"},
  [2] = {
    "dye_item_id",
    "int"
  }
}
_class("StateChangeCultivation", Object)
StateChangeCultivation = StateChangeCultivation

function StateChangeCultivation:Constructor()
  self.tree_id = 0
  self.item_id = 0
end

StateChangeCultivation._proto = {
  [1] = {"tree_id", "int"},
  [2] = {"item_id", "int"}
}
_class("ClietCultivationInfo", Object)
ClietCultivationInfo = ClietCultivationInfo

function ClietCultivationInfo:Constructor()
  self.mutation_cultivation = {}
  self.directional_cultivation = {}
  self.dye_cultivation = {}
  self.land_pstid = 0
  self.state_change_cultivation = {}
end

ClietCultivationInfo._proto = {
  [1] = {
    "mutation_cultivation",
    "list<MutationCultivation>"
  },
  [2] = {
    "directional_cultivation",
    "list<DirectionalCultivation>"
  },
  [3] = {
    "dye_cultivation",
    "list<DyeCultivation>"
  },
  [4] = {"land_pstid", "int64"},
  [5] = {
    "state_change_cultivation",
    "list<StateChangeCultivation>"
  }
}
_class("LandCultivationInfo", Object)
LandCultivationInfo = LandCultivationInfo

function LandCultivationInfo:Constructor()
  self.client_info = ClietCultivationInfo:New()
  self.start_time = 0
  self.end_time = 0
  self.cultivation_result = {}
  self.is_break = false
  self.total_reduce_time = 0
end

LandCultivationInfo._proto = {
  [1] = {
    "client_info",
    "ClietCultivationInfo"
  },
  [2] = {"start_time", "time"},
  [3] = {"end_time", "time"},
  [4] = {
    "cultivation_result",
    "list<RoleAsset>"
  },
  [5] = {"is_break", "bool"},
  [6] = {
    "total_reduce_time",
    "time"
  }
}
_class("CultivationInfo", Object)
CultivationInfo = CultivationInfo

function CultivationInfo:Constructor()
  self.land_cultivation_infos = {}
  self.already_cultivation_list = {}
  self.tree_lucky_value = {}
  self.extra_reward_count = {}
  self.last_refresh_time = 0
  self.advance_info = {}
end

CultivationInfo._proto = {
  [1] = {
    "land_cultivation_infos",
    "map<int64,LandCultivationInfo>"
  },
  [2] = {
    "already_cultivation_list",
    "list<int>"
  },
  [3] = {
    "tree_lucky_value",
    "map<int,int>"
  },
  [4] = {
    "extra_reward_count",
    "map<int,int>"
  },
  [5] = {
    "last_refresh_time",
    "time"
  },
  [6] = {
    "advance_info",
    "map<int,int>"
  }
}
_class("WishingPoolData", Object)
WishingPoolData = WishingPoolData

function WishingPoolData:Constructor()
  self.waiting_output_coin = {}
  self.item_count = {}
  self.wishing_coin_list = {}
  self.fish_tank_item_count = {}
end

WishingPoolData._proto = {
  [1] = {
    "waiting_output_coin",
    "list<int>"
  },
  [2] = {
    "item_count",
    "map<int,int>"
  },
  [3] = {
    "wishing_coin_list",
    "list<int>"
  },
  [4] = {
    "fish_tank_item_count",
    "map<int64,map<int,int>>"
  }
}
_class("MineData", Object)
MineData = MineData

function MineData:Constructor()
  self.mine_id = 0
  self.drop_times = 0
  self.next_refresh_time = 0
end

MineData._proto = {
  [1] = {"mine_id", "int"},
  [2] = {"drop_times", "int"},
  [3] = {
    "next_refresh_time",
    "time"
  }
}
_class("MiningInfo", Object)
MiningInfo = MiningInfo

function MiningInfo:Constructor()
  self.infos = {}
end

MiningInfo._proto = {
  [1] = {
    "infos",
    "list<MineData>"
  }
}
_class("homelandDairyInfo", Object)
homelandDairyInfo = homelandDairyInfo

function homelandDairyInfo:Constructor()
  self.is_readed_dairy = {}
end

homelandDairyInfo._proto = {
  [1] = {
    "is_readed_dairy",
    "list<int>"
  }
}
_class("HomelandSignInfo", Object)
HomelandSignInfo = HomelandSignInfo

function HomelandSignInfo:Constructor()
  self.unlock_time = 0
  self.last_sign_time = 0
  self.sign_exp = 0
  self.level_reward_list = {}
  self.gift_num = 0
  self.next_refresh_time = 0
  self.cumulative_rewards = {}
  self.cumulative_days = 0
end

HomelandSignInfo._proto = {
  [1] = {
    "unlock_time",
    "time"
  },
  [2] = {
    "last_sign_time",
    "time"
  },
  [3] = {"sign_exp", "int"},
  [4] = {
    "level_reward_list",
    "list<int>"
  },
  [5] = {"gift_num", "int"},
  [6] = {
    "next_refresh_time",
    "time"
  },
  [7] = {
    "cumulative_rewards",
    "list<RoleAsset>"
  },
  [8] = {
    "cumulative_days",
    "int"
  }
}
_class("homelandVisitLogOnce", Object)
homelandVisitLogOnce = homelandVisitLogOnce

function homelandVisitLogOnce:Constructor()
  self.visitor = 0
  self.masks = 0
  self.visit_time = 0
  self.item = RoleAsset:New()
  self.nick = ""
end

homelandVisitLogOnce._proto = {
  [1] = {"visitor", "int64"},
  [2] = {"masks", "int"},
  [3] = {"visit_time", "time"},
  [4] = {"item", "RoleAsset"},
  [5] = {"nick", "string"}
}
_class("homelandVisitLog", Object)
homelandVisitLog = homelandVisitLog

function homelandVisitLog:Constructor()
  self.log_list = {}
  self.curday_list = {}
  self.curday_time = 0
  self.db_version = 0
end

homelandVisitLog._proto = {
  [1] = {
    "log_list",
    "list<homelandVisitLogOnce>"
  },
  [2] = {
    "curday_list",
    "map<int64,homelandVisitLogOnce>"
  },
  [3] = {
    "curday_time",
    "time"
  },
  [4] = {"db_version", "int64"}
}
_class("homelandVisit", Object)
homelandVisit = homelandVisit

function homelandVisit:Constructor()
  self.forge_list = {}
  self.cultivation_list = {}
  self.item_list = {}
end

homelandVisit._proto = {
  [1] = {
    "forge_list",
    "list<int64>"
  },
  [2] = {
    "cultivation_list",
    "list<int64>"
  },
  [3] = {
    "item_list",
    "list<int64>"
  }
}
_class("homelandStoryTask", Object)
homelandStoryTask = homelandStoryTask

function homelandStoryTask:Constructor()
  self.cfg_id = 0
  self.refresh_time = -1
  self.id_list = {}
end

homelandStoryTask._proto = {
  [1] = {"cfg_id", "int"},
  [2] = {
    "refresh_time",
    "time"
  },
  [3] = {"id_list", "list<int>"}
}
_class("FatherArchitectureData", Object)
FatherArchitectureData = FatherArchitectureData

function FatherArchitectureData:Constructor()
  self.id = 0
  self.clean_hang_point = {}
end

FatherArchitectureData._proto = {
  [1] = {"id", "int"},
  [2] = {
    "clean_hang_point",
    "list<int>"
  }
}
_class("FatherAtchitectureInfo", Object)
FatherAtchitectureInfo = FatherAtchitectureInfo

function FatherAtchitectureInfo:Constructor()
  self.infos = {}
end

FatherAtchitectureInfo._proto = {
  [1] = {
    "infos",
    "map<int,FatherArchitectureData>"
  }
}
_class("MoviceRecord", Object)
MoviceRecord = MoviceRecord

function MoviceRecord:Constructor()
  self.pstid = 0
  self.chose_pets = {}
  self.chose_item = {}
  self.chose_option = {}
  self.random_chat = {}
  self.pet_score = 0
  self.item_score = 0
  self.option_score = 0
  self.name = ""
  self.date = 0
  self.movice_id = 0
end

MoviceRecord._proto = {
  [1] = {"pstid", "int64"},
  [2] = {
    "chose_pets",
    "map<int,int>"
  },
  [3] = {
    "chose_item",
    "map<int,int>"
  },
  [4] = {
    "chose_option",
    "map<int,int>"
  },
  [5] = {
    "random_chat",
    "list<int>"
  },
  [6] = {"pet_score", "int"},
  [7] = {"item_score", "int"},
  [8] = {
    "option_score",
    "int"
  },
  [9] = {"name", "string"},
  [10] = {"date", "time"},
  [11] = {"movice_id", "int"}
}
_class("MoviceData", Object)
MoviceData = MoviceData

function MoviceData:Constructor()
  self.movice_id = 0
  self.history_chose_pets = {}
  self.history_chose_item = {}
  self.history_chose_option = {}
  self.records = {}
  self.received_reward_id = {}
  self.max_score = 0
end

MoviceData._proto = {
  [1] = {"movice_id", "int"},
  [2] = {
    "history_chose_pets",
    "map<int,list<int>>"
  },
  [3] = {
    "history_chose_item",
    "map<int,list<int>>"
  },
  [4] = {
    "history_chose_option",
    "map<int,list<int>>"
  },
  [5] = {
    "records",
    "map<int64,MoviceRecord>"
  },
  [6] = {
    "received_reward_id",
    "list<int>"
  },
  [7] = {"max_score", "int"}
}
_class("MoviceInfo", Object)
MoviceInfo = MoviceInfo

function MoviceInfo:Constructor()
  self.movices = {}
  self.anonymous_letter_reward = {}
end

MoviceInfo._proto = {
  [1] = {
    "movices",
    "map<int,MoviceData>"
  },
  [2] = {
    "anonymous_letter_reward",
    "list<int>"
  }
}
local ArchitectureStatus = {AS_Shabby = 0, AS_Normal = 1}
_enum("ArchitectureStatus", ArchitectureStatus)
_class("VisitHelpTimeInfo", Object)
VisitHelpTimeInfo = VisitHelpTimeInfo

function VisitHelpTimeInfo:Constructor()
  self.help_surplus_time = 0
  self.help_once_time = 0
  self.offline_help_time = 0
end

VisitHelpTimeInfo._proto = {
  [1] = {
    "help_surplus_time",
    "time"
  },
  [2] = {
    "help_once_time",
    "time"
  },
  [3] = {
    "offline_help_time",
    "time"
  }
}
_class("homeland_visit_info", Object)
homeland_visit_info = homeland_visit_info

function homeland_visit_info:Constructor()
  self.pstid = 0
  self.forge_acc_map = {}
  self.cul_acc_map = {}
  self.item_map = {}
  self.visit_log = homelandVisitLog:New()
end

homeland_visit_info._proto = {
  [1] = {"pstid", "int64"},
  [2] = {
    "forge_acc_map",
    "map<int,VisitHelpTimeInfo>"
  },
  [3] = {
    "cul_acc_map",
    "map<int64,VisitHelpTimeInfo>"
  },
  [4] = {
    "item_map",
    "map<int,SpecItemAsset>"
  },
  [5] = {
    "visit_log",
    "homelandVisitLog"
  }
}
_class("TypeTraceInfo", Object)
TypeTraceInfo = TypeTraceInfo

function TypeTraceInfo:Constructor()
  self.trace_id = {}
end

TypeTraceInfo._proto = {
  [1] = {"trace_id", "list<int>"}
}
_class("ClientHomelandInfo", Object)
ClientHomelandInfo = ClientHomelandInfo

function ClientHomelandInfo:Constructor()
  self.pstid = 0
  self.level = 0
  self.forge_info = ForgeQueueInfo:New()
  self.architecture_list = SceneArchitecture:New()
  self.fell_info = FellInfo:New()
  self.shop_info = homelandShopInfo:New()
  self.trea_info = homelandTreasure:New()
  self.fishing_data = FishingData:New()
  self.dormitory_info = dormitoryInfo:New()
  self.event_info = homelandEventInfo:New()
  self.cultivation_info = CultivationInfo:New()
  self.wishing_pool_info = WishingPoolData:New()
  self.mining_info = MiningInfo:New()
  self.dairy_info = homelandDairyInfo:New()
  self.sign_info = HomelandSignInfo:New()
  self.visit_info = homelandVisit:New()
  self.exp = 0
  self.visit_int_info = homeland_visit_info:New()
  self.trace_info = {}
  self.unlock_functions = {}
  self.complate_chat_ids = {}
  self.story_task_info = homelandStoryTask:New()
  self.fater_arch_info = FatherAtchitectureInfo:New()
  self.movice_info = MoviceInfo:New()
end

ClientHomelandInfo._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"level", "int"},
  [3] = {
    "forge_info",
    "ForgeQueueInfo"
  },
  [4] = {
    "architecture_list",
    "SceneArchitecture"
  },
  [5] = {"fell_info", "FellInfo"},
  [6] = {
    "shop_info",
    "homelandShopInfo"
  },
  [7] = {
    "trea_info",
    "homelandTreasure"
  },
  [8] = {
    "fishing_data",
    "FishingData"
  },
  [9] = {
    "dormitory_info",
    "dormitoryInfo"
  },
  [10] = {
    "event_info",
    "homelandEventInfo"
  },
  [11] = {
    "cultivation_info",
    "CultivationInfo"
  },
  [12] = {
    "wishing_pool_info",
    "WishingPoolData"
  },
  [13] = {
    "mining_info",
    "MiningInfo"
  },
  [14] = {
    "dairy_info",
    "homelandDairyInfo"
  },
  [15] = {
    "sign_info",
    "HomelandSignInfo"
  },
  [16] = {
    "visit_info",
    "homelandVisit"
  },
  [17] = {"exp", "int64"},
  [18] = {
    "visit_int_info",
    "homeland_visit_info"
  },
  [19] = {
    "trace_info",
    "map<int,TypeTraceInfo>"
  },
  [20] = {
    "unlock_functions",
    "list<int64>"
  },
  [21] = {
    "complate_chat_ids",
    "map<int,list<int>>"
  },
  [22] = {
    "story_task_info",
    "homelandStoryTask"
  },
  [23] = {
    "fater_arch_info",
    "FatherAtchitectureInfo"
  },
  [24] = {
    "movice_info",
    "MoviceInfo"
  }
}
_class("visit_simple_info", Object)
visit_simple_info = visit_simple_info

function visit_simple_info:Constructor()
  self.pstid = 0
  self.mask = 0
  self.exp = 0
  self.livable = 0
end

visit_simple_info._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"mask", "int"},
  [3] = {"exp", "int64"},
  [4] = {"livable", "int64"}
}
_class("FriendHomelandInfo", Object)
FriendHomelandInfo = FriendHomelandInfo

function FriendHomelandInfo:Constructor()
  self.pstid = 0
  self.exp = 0
  self.architecture_list = SceneArchitecture:New()
  self.cultivation_info = CultivationInfo:New()
  self.forge_info = ForgeQueueInfo:New()
  self.item_list = {}
  self.pet_list = {}
  self.forge_time = {}
  self.cul_time = {}
  self.wishing_pool_info = WishingPoolData:New()
  self.father_arch_info = FatherAtchitectureInfo:New()
  self.medal_placement = medal_placement_info:New()
end

FriendHomelandInfo._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"exp", "int64"},
  [3] = {
    "architecture_list",
    "SceneArchitecture"
  },
  [4] = {
    "cultivation_info",
    "CultivationInfo"
  },
  [5] = {
    "forge_info",
    "ForgeQueueInfo"
  },
  [6] = {
    "item_list",
    "map<int,SpecItemAsset>"
  },
  [7] = {
    "pet_list",
    "list<role_help_pet_info>"
  },
  [8] = {
    "forge_time",
    "map<int,VisitHelpTimeInfo>"
  },
  [9] = {
    "cul_time",
    "map<int64,VisitHelpTimeInfo>"
  },
  [10] = {
    "wishing_pool_info",
    "WishingPoolData"
  },
  [11] = {
    "father_arch_info",
    "FatherAtchitectureInfo"
  },
  [12] = {
    "medal_placement",
    "medal_placement_info"
  }
}
