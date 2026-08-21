local DispatchTaskType = {
  DTT_Common = 1,
  DTT_Book = 2,
  DTT_Furniture = 3
}
_enum("DispatchTaskType", DispatchTaskType)
local DispatchAssignType = {
  DAT_Invalid = 0,
  DAT_Or = 1,
  DAT_And = 2
}
_enum("DispatchAssignType", DispatchAssignType)
local DispatchTaskStateType = {
  DTST_Invalid = 0,
  DTST_New = 1,
  DTST_Doing = 2,
  DTST_Complete = 3,
  DTST_End = 4
}
_enum("DispatchTaskStateType", DispatchTaskStateType)
local DispatchDBSize = {
  DDBS_TeamMemberMaxNum = 5,
  DDBS_SiteMaxNum = 8,
  DDBS_SeriesRuleMax = 3
}
_enum("DispatchDBSize", DispatchDBSize)
local DispatchRoomType = {DRT_RoomRule_Max = 4}
_enum("DispatchRoomType", DispatchRoomType)
local SmeltItemType = {SIT_Mission = 1, SIT_Lv = 2}
_enum("SmeltItemType", SmeltItemType)
local EStoryTriggerType = {
  Invalid = 0,
  TouchPet = 1,
  EnterAircraft = 2,
  LoginGame = 3,
  GiveGift = 4,
  PassMission = 5,
  UnlockRoom = 6,
  EnterAircraftSection = 7,
  AddPet = 8,
  EStoryTriggerType_End = 9
}
_enum("EStoryTriggerType", EStoryTriggerType)
local ETacticalDBThemeStateType = {
  ETDBTST_LOCK = 0,
  ETDBTST_UNLOCK = 1,
  ETDBTST_ACTIVE = 2,
  ETDBTST_TAKEN = 3
}
_enum("ETacticalDBThemeStateType", ETacticalDBThemeStateType)
local ECartridgeMatchDifficultType = {
  ECMDT_INVALID = 0,
  ECMDT_SIMPLE = 1,
  ECMDT_NORMAL = 2,
  ECMDT_HARD = 3
}
_enum("ECartridgeMatchDifficultType", ECartridgeMatchDifficultType)
local AirRoomType = {
  InvalidRoomType = -1,
  AisleRoom = 100,
  CentralRoom = 1,
  PowerRoom = 2,
  MazeRoom = 3,
  ResourceRoom = 4,
  PrismRoom = 5,
  TowerRoom = 6,
  EvilRoom = 7,
  PurifyRoom = 8,
  SmeltRoom = 9,
  DispatchRoom = 10,
  TacticRoom = 11,
  EmptySpace = 199,
  AmusementBegin = 201,
  RestRoom = 201,
  CoffeeRoom = 202,
  WaterBarRoom = 203,
  GameRoom = 204,
  AmusementEnd = 205
}
_enum("AirRoomType", AirRoomType)
local SpaceState = {
  SpaceStateLocked = 0,
  SpaceStateNeedClean = 1,
  SpaceStateCleaning = 2,
  SpaceStateEmpty = 3,
  SpaceStateBuilding = 4,
  SpaceStateFull = 5,
  SpaceStateUpgrading = 6,
  SpaceStateDegrading = 7
}
_enum("SpaceState", SpaceState)
local WorkSkillType = {
  WS_NONE = 0,
  WS_Central_AddAffinity = 1,
  WS_Power_FireflyRate = 2,
  WS_Prism_PhysicStorage = 3,
  WS_Prism_LocalRecover = 4,
  WS_Resource_RewardCardCD = 5,
  WS_Maze_LightRate = 6,
  WS_Tower_DrawCardCD = 7,
  WS_Tower_DrawCardLimit = 8,
  WS_Resource_RewardCardLimit = 9,
  WS_Purify_DropPetProb = 11,
  WS_Purify_PurifyTime = 12,
  WS_Evil_5StarProb = 13,
  WS_Evil_RedProb = 14,
  WS_Atom_Dis = 15,
  WS_Dispatch_Time = 16,
  WS_Furniture_Add_Ambient = 17,
  WS_Tower_HeartAmberAddSpeed = 18,
  WS_Tower_HeartAmberAddLimit = 19,
  WS_TATIC_CARTRIDGEPRODUCECD = 20
}
_enum("WorkSkillType", WorkSkillType)
local AirValueID = {
  InitStarPower = 1,
  CentralRoomID = 2,
  CentralRoomSpaceID = 3,
  PhysicToFireflyRate = 4,
  FireflyToTimeRate = 5,
  FireflyBaseRate = 6,
  FireflyMaxRate = 7,
  PhysicBaseRate = 8,
  PhysicMaxRate = 9,
  LightBaseRate = 10,
  LightMaxRate = 11,
  CalcInterval = 12,
  InitMazeLight = 13,
  LocalRecoverBase = 14,
  LocalRecoverMax = 15,
  TowerCollectAssetId = 16,
  FireflyToAtom = 17,
  Invalid_18 = 18,
  UnlockPresentPetAmbient = 19,
  PresentPetDecWeight = 20,
  UnlockVisitPetAmbient = 21,
  Pet1StarVisitWeight = 22,
  Pet2StarVisitWeight = 23,
  Pet3StarVisitWeight = 24,
  Pet4StarVisitWeight = 25,
  Pet5StarVisitWeight = 26,
  Pet6StarVisitWeight = 27,
  NonePetWeightMulNum = 28,
  MazeCoinConvertNum = 29,
  InitDispatchMax = 30,
  TowerMaxT = 31,
  TowerExDeltaT = 32,
  CartridgeRandomID = 33,
  WeekPassAward = 34,
  WeekPetFightNumLimit = 35,
  PeakScoreItemID = 36,
  InfoUnlockItemIDList = 37,
  TacticResetTime = 38,
  CartridgeGiftID = 39,
  ExtraAwardNumLimit = 40,
  WeekExtraAwardNumLimit = 41,
  ExtraAwardRandomRule = 42,
  ExtraAwards = 43,
  AirValueIDMax = 44
}
_enum("AirValueID", AirValueID)
_class("pet_story_struct", Object)
pet_story_struct = pet_story_struct

function pet_story_struct:Constructor()
  self.story_event_id_list = {}
end

pet_story_struct._proto = {
  [1] = {
    "story_event_id_list",
    "list<int>"
  }
}
_class("aircraft_present_pets_info", Object)
aircraft_present_pets_info = aircraft_present_pets_info

function aircraft_present_pets_info:Constructor()
  self.pet_array = {}
  self.trigger_ambient = 0
end

aircraft_present_pets_info._proto = {
  [1] = {
    "pet_array",
    "list<int64>"
  },
  [2] = {
    "trigger_ambient",
    "int"
  }
}
_class("aircraft_visit_pet", Object)
aircraft_visit_pet = aircraft_visit_pet

function aircraft_visit_pet:Constructor()
  self.owner_pstid = 0
  self.owner_nick = ""
  self.pet_info = role_help_pet_info:New()
  self.is_accpet_gift = false
end

aircraft_visit_pet._proto = {
  [1] = {
    "owner_pstid",
    "int64"
  },
  [2] = {"owner_nick", "string"},
  [3] = {
    "pet_info",
    "role_help_pet_info"
  },
  [4] = {
    "is_accpet_gift",
    "bool"
  }
}
_class("aircraft_visit_pets_info", Object)
aircraft_visit_pets_info = aircraft_visit_pets_info

function aircraft_visit_pets_info:Constructor()
  self.pet_array = {}
  self.trigger_ambient = 0
end

aircraft_visit_pets_info._proto = {
  [1] = {
    "pet_array",
    "list<aircraft_visit_pet>"
  },
  [2] = {
    "trigger_ambient",
    "int"
  }
}
_class("aircraft_info", Object)
aircraft_info = aircraft_info

function aircraft_info:Constructor()
  self.owner_pstid = 0
  self.update_time = 0
  self.last_enter_time = 0
  self.firefly_value = 0
  self.physic_storage = 0
  self.light_storage = 0
  self.res_card_count = 0
  self.draw_card_count = 0
  self.res_card_cd_time = 0
  self.draw_card_cd_time = 0
  self.smelt_cd_time = 0
  self.ambient_value = 0
  self.trigger_stroy_pet = {}
  self.amusement_ambient = {}
  self.present_pets = aircraft_present_pets_info:New()
  self.visit_pets = aircraft_visit_pets_info:New()
  self.heart_amber_count = 0
  self.heart_amber_cd_time = 0
end

aircraft_info._proto = {
  [1] = {
    "owner_pstid",
    "int64"
  },
  [2] = {
    "update_time",
    "time"
  },
  [3] = {
    "last_enter_time",
    "time"
  },
  [4] = {
    "firefly_value",
    "double"
  },
  [5] = {
    "physic_storage",
    "double"
  },
  [6] = {
    "light_storage",
    "double"
  },
  [7] = {
    "res_card_count",
    "int"
  },
  [8] = {
    "draw_card_count",
    "int"
  },
  [9] = {
    "res_card_cd_time",
    "time"
  },
  [10] = {
    "draw_card_cd_time",
    "time"
  },
  [11] = {
    "smelt_cd_time",
    "time"
  },
  [12] = {
    "ambient_value",
    "int"
  },
  [13] = {
    "trigger_stroy_pet",
    "map<int,map<int64,pet_story_struct>>"
  },
  [14] = {
    "amusement_ambient",
    "map<int,int>"
  },
  [15] = {
    "present_pets",
    "aircraft_present_pets_info"
  },
  [16] = {
    "visit_pets",
    "aircraft_visit_pets_info"
  },
  [17] = {
    "heart_amber_count",
    "int"
  },
  [18] = {
    "heart_amber_cd_time",
    "time"
  }
}
_class("aircraft_space_info", Object)
aircraft_space_info = aircraft_space_info

function aircraft_space_info:Constructor()
  self.owner_pstid = 0
  self.space_id = 0
  self.space_status = 0
  self.room_id = 0
  self.build_finish_time = 0
  self.pets = {}
  self.ext_data = ""
  self.client_data = {}
end

aircraft_space_info._proto = {
  [1] = {
    "owner_pstid",
    "int64"
  },
  [2] = {"space_id", "int"},
  [3] = {
    "space_status",
    "int"
  },
  [4] = {"room_id", "int"},
  [6] = {
    "build_finish_time",
    "time"
  },
  [7] = {
    "pets",
    "list<int64>"
  },
  [8] = {"ext_data", "buffer"},
  [9] = {
    "client_data",
    "list<double>"
  }
}
_class("CentralRoomExtData", Object)
CentralRoomExtData = CentralRoomExtData

function CentralRoomExtData:Constructor()
  self.end_time = 0
  self.start_room_id = 0
  self.total_time = 0
end

CentralRoomExtData._proto = {
  [1] = {"end_time", "time"},
  [2] = {
    "start_room_id",
    "int"
  },
  [3] = {"total_time", "int"}
}
_class("MobileFurnitureInfo", Object)
MobileFurnitureInfo = MobileFurnitureInfo

function MobileFurnitureInfo:Constructor()
  self.asset_id = 0
  self.area_id = 0
  self.surface = 0
  self.pos_x = 0
  self.pos_z = 0
  self.rot = 0
end

MobileFurnitureInfo._proto = {
  [1] = {"asset_id", "int"},
  [2] = {"area_id", "int"},
  [3] = {"surface", "int"},
  [4] = {"pos_x", "int"},
  [5] = {"pos_z", "int"},
  [6] = {"rot", "int"}
}
_class("PowerRoomExtData", Object)
PowerRoomExtData = PowerRoomExtData

function PowerRoomExtData:Constructor()
end

PowerRoomExtData._proto = {}
_class("PrismRoomExtData", Object)
PrismRoomExtData = PrismRoomExtData

function PrismRoomExtData:Constructor()
end

PrismRoomExtData._proto = {}
_class("MazeRoomExtData", Object)
MazeRoomExtData = MazeRoomExtData

function MazeRoomExtData:Constructor()
end

MazeRoomExtData._proto = {}
_class("ResourceRoomExtData", Object)
ResourceRoomExtData = ResourceRoomExtData

function ResourceRoomExtData:Constructor()
end

ResourceRoomExtData._proto = {}
_class("TowerRoomExtData", Object)
TowerRoomExtData = TowerRoomExtData

function TowerRoomExtData:Constructor()
  self.last_collect_time = 0
end

TowerRoomExtData._proto = {
  [1] = {
    "last_collect_time",
    "time"
  }
}
_class("DispatchSiteInfo", Object)
DispatchSiteInfo = DispatchSiteInfo

function DispatchSiteInfo:Constructor()
  self.task_refresh_id = 0
  self.task_doing_id = 0
  self.state = 0
  self.end_time = 0
  self.award_id = 0
  self.award_doing_id = 0
  self.curr_do = false
  self.team_member = {}
end

DispatchSiteInfo._proto = {
  [1] = {
    "task_refresh_id",
    "int"
  },
  [2] = {
    "task_doing_id",
    "int"
  },
  [3] = {"state", "int"},
  [4] = {"end_time", "time"},
  [5] = {"award_id", "int"},
  [6] = {
    "award_doing_id",
    "int"
  },
  [8] = {"curr_do", "bool"},
  [9] = {
    "team_member",
    "list<int64>"
  }
}
_class("DispatchRoomExtData", Object)
DispatchRoomExtData = DispatchRoomExtData

function DispatchRoomExtData:Constructor()
  self.start_time = 0
  self.do_count = 0
  self.team_count = 0
  self.site_list = {}
  self.is_look = true
  self.last_time = 0
  self.serier_rule = 0
  self.serier_id = 0
  self.serier_task_num = 0
  self.book_ids = {}
  self.furniture_ids = {}
end

DispatchRoomExtData._proto = {
  [1] = {"start_time", "time"},
  [2] = {"do_count", "int"},
  [3] = {"team_count", "int"},
  [4] = {
    "site_list",
    "map<int,DispatchSiteInfo>"
  },
  [5] = {"is_look", "bool"},
  [6] = {"last_time", "time"},
  [7] = {
    "serier_rule",
    "int"
  },
  [8] = {"serier_id", "int"},
  [9] = {
    "serier_task_num",
    "int"
  },
  [10] = {"book_ids", "list<int>"},
  [11] = {
    "furniture_ids",
    "list<int>"
  }
}
_class("TacticalDBThemeData", Object)
TacticalDBThemeData = TacticalDBThemeData

function TacticalDBThemeData:Constructor()
  self.rewarded = false
  self.unlock_info_list = {}
end

TacticalDBThemeData._proto = {
  [1] = {"rewarded", "bool"},
  [2] = {
    "unlock_info_list",
    "list<int>"
  }
}
_class("TacticFormationInfo", Object)
TacticFormationInfo = TacticFormationInfo

function TacticFormationInfo:Constructor()
  self.id = 0
  self.name = ""
  self.pet_list = {}
end

TacticFormationInfo._proto = {
  [1] = {"id", "int"},
  [2] = {"name", "string"},
  [3] = {
    "pet_list",
    "list<int64>"
  }
}
_class("TacticRoomExtData", Object)
TacticRoomExtData = TacticRoomExtData

function TacticRoomExtData:Constructor()
  self.cartridge_cd_time = 0
  self.next_reset_time = 0
  self.week_pass_num = 0
  self.received_week_award_list = {}
  self.pet_fight_list = {}
  self.received_peak_lv_list = {}
  self.theme_list = {}
  self.free_prod_times = 0
  self.remain_free_prod_times = 0
  self.cartridge_use_times = {}
  self.tactic_formation_list = {}
  self.open_cartridge_gift_num = 0
  self.cartridge_extra_award_list = {}
  self.weekly_cartridge_open_num = 0
  self.weekly_extra_cartridge_num = 0
end

TacticRoomExtData._proto = {
  [1] = {
    "cartridge_cd_time",
    "time"
  },
  [2] = {
    "next_reset_time",
    "time"
  },
  [3] = {
    "week_pass_num",
    "int"
  },
  [4] = {
    "received_week_award_list",
    "list<int>"
  },
  [5] = {
    "pet_fight_list",
    "map<int64,int>"
  },
  [6] = {
    "received_peak_lv_list",
    "list<int>"
  },
  [7] = {
    "theme_list",
    "map<int,TacticalDBThemeData>"
  },
  [8] = {
    "free_prod_times",
    "int"
  },
  [9] = {
    "remain_free_prod_times",
    "int"
  },
  [10] = {
    "cartridge_use_times",
    "map<int,int>"
  },
  [11] = {
    "tactic_formation_list",
    "list<TacticFormationInfo>"
  },
  [12] = {
    "open_cartridge_gift_num",
    "int"
  },
  [13] = {
    "cartridge_extra_award_list",
    "map<int64,list<RoleAsset>>"
  },
  [14] = {
    "weekly_cartridge_open_num",
    "int"
  },
  [15] = {
    "weekly_extra_cartridge_num",
    "int"
  }
}
local PurifyRoomStatus = {
  NO_EVIL = 1,
  EVIL_WITHOUT_PURIFY = 2,
  PURIFING = 3,
  WAITING_COLLECT_AWARD = 4
}
_enum("PurifyRoomStatus", PurifyRoomStatus)
local RefreshRegionStatus = {
  EMPTY = 1,
  EVIL_NOT_TRACED = 2,
  EVIL_TRACED = 3
}
_enum("RefreshRegionStatus", RefreshRegionStatus)
local EVIL_CONSTANT = {REFRESH_SPACE_VOLUME = 50}
_enum("EVIL_CONSTANT", EVIL_CONSTANT)
_class("refresh_region", Object)
refresh_region = refresh_region

function refresh_region:Constructor()
  self.evil_id = 0
  self.health_point = 0
  self.status = RefreshRegionStatus.EMPTY
end

refresh_region._proto = {
  [1] = {"evil_id", "int"},
  [2] = {
    "health_point",
    "int"
  },
  [3] = {"status", "int"}
}
_class("aircraft_ext_evil_room", Object)
aircraft_ext_evil_room = aircraft_ext_evil_room

function aircraft_ext_evil_room:Constructor()
  self.m_refresh_space = {}
  self.m_prison = {}
end

aircraft_ext_evil_room._proto = {
  [1] = {
    "m_refresh_space",
    "list<refresh_region>"
  },
  [2] = {"m_prison", "list<int>"}
}
_class("aircraft_ext_purify_room", Object)
aircraft_ext_purify_room = aircraft_ext_purify_room

function aircraft_ext_purify_room:Constructor()
  self.m_evil_id = 0
  self.m_purify_finish_time = 0
  self.m_status = PurifyRoomStatus.NO_EVIL
end

aircraft_ext_purify_room._proto = {
  [1] = {"m_evil_id", "int"},
  [2] = {
    "m_purify_finish_time",
    "time"
  },
  [3] = {"m_status", "int"}
}
_class("MobileCfgAircraftSpace", Object)
MobileCfgAircraftSpace = MobileCfgAircraftSpace

function MobileCfgAircraftSpace:Constructor()
  self.ID = 0
  self.BuildType = {}
  self.CleanCost = {}
  self.AddFirefly = 0
  self.CleanNeedTime = 0
end

MobileCfgAircraftSpace._proto = {
  [1] = {"ID", "int"},
  [2] = {"BuildType", "list<int>"},
  [3] = {
    "CleanCost",
    "list<RoleAsset>"
  },
  [4] = {"AddFirefly", "int"},
  [5] = {
    "CleanNeedTime",
    "int"
  }
}
_class("MobileNeedRoomCond", Object)
MobileNeedRoomCond = MobileNeedRoomCond

function MobileNeedRoomCond:Constructor()
  self.room_type = 0
  self.room_level = 0
  self.room_count = 0
end

MobileNeedRoomCond._proto = {
  [1] = {"room_type", "int"},
  [2] = {"room_level", "int"},
  [3] = {"room_count", "int"}
}
_class("MobileCfgAircraftRoom", Object)
MobileCfgAircraftRoom = MobileCfgAircraftRoom

function MobileCfgAircraftRoom:Constructor()
  self.ID = 0
  self.RoomType = 0
  self.Level = 0
  self.PrevLevelID = 0
  self.NextLevelID = 0
  self.NeedRoom = {}
  self.Need = {}
  self.Recycle = {}
  self.NeedPower = 0
  self.LevelUpTime = 0
  self.LevelDownTime = 0
  self.PetNum = 0
end

MobileCfgAircraftRoom._proto = {
  [1] = {"ID", "int"},
  [2] = {"RoomType", "int"},
  [3] = {"Level", "int"},
  [4] = {
    "PrevLevelID",
    "int"
  },
  [5] = {
    "NextLevelID",
    "int"
  },
  [6] = {
    "NeedRoom",
    "list<MobileNeedRoomCond>"
  },
  [7] = {
    "Need",
    "list<RoleAsset>"
  },
  [8] = {
    "Recycle",
    "list<RoleAsset>"
  },
  [9] = {"NeedPower", "int"},
  [10] = {
    "LevelUpTime",
    "int"
  },
  [11] = {
    "LevelDownTime",
    "int"
  },
  [12] = {"PetNum", "int"}
}
_class("MobileCfgAircraftCentralRoom", Object)
MobileCfgAircraftCentralRoom = MobileCfgAircraftCentralRoom

function MobileCfgAircraftCentralRoom:Constructor()
  self.ID = 0
  self.OpenSpaces = {}
end

MobileCfgAircraftCentralRoom._proto = {
  [1] = {"ID", "int"},
  [2] = {"OpenSpaces", "list<int>"}
}
