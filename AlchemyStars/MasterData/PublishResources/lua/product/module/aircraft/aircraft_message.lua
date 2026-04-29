require("message_def")
local aircraftMessageDef = {
  CLSID_CEventAircraftCheckClickPetTriggerStory = 1000,
  CLSID_CEventAircraftCheckClickPetTriggerStoryResult = 1001,
  CLSID_CEventPushAircraftInfo = 1002,
  CLSID_CEventPushAircraftSpaceInfos = 1003,
  CLSID_CEventAircraftLeave = 1004,
  CLSID_CEventAircraftUpdate = 1005,
  CLSID_CEventAircraftUpdateResult = 1006,
  CLSID_CEventPushViewNewFurniture = 1007,
  CLSID_CEventAircraftFurnitureInfoReq = 1008,
  CLSID_CEventAircraftFurnitureInfoResult = 1009,
  CLSID_CEventAircraftFurnitureInfoUpReq = 1010,
  CLSID_CEventAircraftFurnitureInfoUpResult = 1011,
  CLSID_CEventPushAircraftAreaFurniture = 1012,
  CLSID_CEventAircraftRoomOperate = 1013,
  CLSID_CEventAircraftRoomOperateResult = 1014,
  CLSID_CEventAircraftRedeemFirfly = 1015,
  CLSID_CEventAircraftRedeemFirflyResult = 1016,
  CLSID_CEventAircraftPeriodAffinity = 1017,
  CLSID_CEventAircraftPeriodAffinityResult = 1018,
  CLSID_CEventItemSmelt = 1019,
  CLSID_CEventItemSmeltResult = 1020,
  CLSID_CEventMultItemSmelt = 1021,
  CLSID_CEventMultItemSmeltResult = 1022,
  CLSID_CEventFireflyToAtom = 1023,
  CLSID_CEventFireflyToAtomResult = 1024,
  CLSID_CEventDispatchSite = 1025,
  CLSID_CEventDispatchSiteResult = 1026,
  CLSID_CEventDispatchLook = 1027,
  CLSID_CEventDispatchLookResult = 1028,
  CLSID_CEventDispatchAcceptTask = 1029,
  CLSID_CEventDispatchAcceptTaskResult = 1030,
  CLSID_CEventDispatchCancelTask = 1031,
  CLSID_CEventDispatchCancelTaskResult = 1032,
  CLSID_CEventDispatchTaskAward = 1033,
  CLSID_CEventDispatchTaskAwardResult = 1034,
  CLSID_CEventAcceptPresent = 1035,
  CLSID_CEventAcceptPresentResult = 1036,
  CLSID_CEventAcceptVisitPet = 1037,
  CLSID_CEventAcceptVisitPetResult = 1038,
  CLSID_CEventSearchEvil = 1039,
  CLSID_CEventSearchEvilResult = 1040,
  CLSID_CEventCaptureEvil = 1041,
  CLSID_CEventCaptureEvilResult = 1042,
  CLSID_CEventQuickCaptureEvil = 1043,
  CLSID_CEventQuickCaptureEvilResult = 1044,
  CLSID_CEventTraceEvil = 1045,
  CLSID_CEventTraceEvilResult = 1046,
  CLSID_CEventEvilOperate = 1047,
  CLSID_CEventEvilOperateResult = 1048,
  CLSID_CEventPurifyEvil = 1049,
  CLSID_CEventPurifyEvilResult = 1050,
  CLSID_CEventGetConfigRequest = 1051,
  CLSID_CEventGetConfigRequestResult = 1052,
  CLSID_CEventAddAircraftGetSpaceData = 1053,
  CLSID_CEventAddAircraftGetSpaceDataResult = 1054,
  CLSID_CEventPushClickPet = 1055,
  CLSID_CEventAircraftCleanAndBuild = 1056,
  CLSID_CEventAircraftCleanAndBuildResult = 1057,
  CLSID_CEventRequestTacticRoomData = 1058,
  CLSID_CEventRequestTacticRoomDataResult = 1059,
  CLSID_CEventCartridgeFreeProduce = 1060,
  CLSID_CEventCartridgeFreeProduceResult = 1061,
  CLSID_CEventCartridgeProSpeedUp = 1062,
  CLSID_CEventCartridgeProSpeedUpResult = 1063,
  CLSID_CEventTacticWeekReset = 1064,
  CLSID_CEventTacticWeekResetResult = 1065,
  CLSID_CEventGetTacticFormationInfo = 1066,
  CLSID_CEventGetTacticFormationInfoResult = 1067,
  CLSID_CEventChangeTacticFormationInfo = 1068,
  CLSID_CEventChangeTacticFormationInfoResult = 1069,
  CLSID_CEventTakeWeeklyAward = 1070,
  CLSID_CEventTakeWeeklyAwardResult = 1071,
  CLSID_CEventTacticPeakReward = 1072,
  CLSID_CEventTacticPeakRewardResult = 1073,
  CLSID_CEventTacticUnlockTheme = 1074,
  CLSID_CEventTacticUnlockThemeResult = 1075,
  CLSID_CEventTacticGetInformation = 1076,
  CLSID_CEventTacticGetInformationResult = 1077,
  CLSID_CEventDelCartridge = 1078,
  CLSID_CEventDelCartridgeResult = 1079,
  CLSID_CEventAIMultItemSmelt = 1080,
  CLSID_CEventAIMultItemSmeltResult = 1081,
  CLSID_CEventCollectPrism = 1082,
  CLSID_CEventCollectPrismResult = 1083
}
table.append(MessageDef, aircraftMessageDef)
local AircraftEventResult = {
  AircraftEventResult_INVALID = -1,
  AircraftEventResult_Succ = 0,
  INVALID_SPACE_OPERATION = 1,
  INVALID_ROOM_OPERATION = 2,
  SPACE_NOT_FOUND = 3,
  AIRCRAFT_ROOM_NOT_FOUND = 4,
  PET_NOT_FOUND = 5,
  AIRCRAFT_ROOM_LEVEL_MAX = 6,
  ASSET_NOT_ENOUGH = 7,
  STAR_POWER_NOT_ENOUGH = 8,
  SPACE_NOT_CONNECTED = 9,
  AIRCRAFT_ROOM_BUILDING = 10,
  INVALID_OPERATION = 11,
  LEVEL_LIMIT = 12,
  COUNT_LIMIT = 13,
  BUILD_TYPE_ERROR = 14,
  ROOM_LEVEL_NOT_ZERO = 15,
  SPACE_NOT_AVAILABLE = 16,
  COLLECT_ASSET_EMPTY = 17,
  COLLECT_ASSET_ROOM_BUSY = 18,
  CENTRAL_ROOM_LEVEL_LIMIT = 19,
  DESTROY_WILL_CREATE_ISLAND = 20,
  PREVLEVEL_CANNOT_CONTAIN_EVIL = 21,
  CANNOT_DESTROY_EVILROOM = 22,
  PREVLEVEL_POWER_NOT_ENOUGH = 23,
  CENTRALROOM_CANNOT_DEGRADE = 24,
  ROOM_NEED_NOT_ENOUGH = 25,
  COLLECT_ASSET_ERROR_PHY = 30,
  PET_NOT_IN_ROOM = 60,
  PET_COUNT_EXCEED_LIMIT = 61,
  PET_DO_DISPATCH = 62,
  PURIFY_ROOM_FULL = 80,
  PURIFY_ROOM_EMPTY = 81,
  EVIL_IS_PURIFIED = 82,
  PURIFY_ROOM_NO_AWARD = 83,
  CELL_INDEX_ERROR = 84,
  REFRESH_INDEX_ERROR = 85,
  ROOM_NOT_PURIFYROOM = 86,
  ROOM_NOT_EVILROOM = 87,
  CANNOT_TRACE_MORE_EVIL = 88,
  EVIL_IS_TRACING = 89,
  NO_EVIL_TRACING = 90,
  FIREFLY_NOT_ENOUGH = 98,
  BUILD_NO_NEED_SPEEDUP = 100,
  SPACE_STATE_CANNOT_CLEAN = 101,
  ADJACENT_SPACE_NOT_STATEFULL = 102,
  SAME_PET_ID_REPEAT = 103,
  STORY_EVENT_CLICK_PET_HAVE_STROY = 104,
  AIRCRAFT_SAME_BINDER = 105,
  AIRCRAFT_PET_ERROR_BINDER = 106,
  ROOM_UNKOWN_ERROR = 120,
  ROOM_STATE_ERROR = 121,
  SMELTROOM_OPERATE_NUM = 122,
  SMELTROOM_CFG_NOT = 123,
  SMELTROOM_ITEM_NOT_ENOUGH = 124,
  SMELTROOM_ITEM_NOT_CONDITION = 125,
  SMELTROOM_INPUT_ITEM_ERROR = 126,
  FIREFLYTOATOM_OPERATE_NUM = 130,
  FIREFLYTOATOM_ITEM_NOT_ENOUGH = 131,
  FIREFLYTOATOM_MAX_ENOUGH = 132,
  AIRCRAFT_FURNITURE_ITEM_NO_ENOUGH = 150,
  AIRCRAFT_FURNITURE_AREA_INVALID = 151,
  AIRCRAFT_FURNITURE_AREA_NOT_SAME = 152,
  AIRCRAFT_FURNITURE_ITEM_IDINVALID = 153,
  AIRCRAFT_PRESENT_PET_ID_INVALID = 154,
  AIRCRAFT_PRESENT_AMBIENT_INVALID = 155,
  AIRCRAFT_VISIT_PET_ID_INVALID = 156,
  AIRCRAFT_VISIT_AMBIENT_INVALID = 157,
  AIRCRAFT_PRESENT_DROP_ERROR = 158,
  AIRCRAFT_VISIT_DROP_ERROR = 159,
  AIRCRAFT_IS_ACCEPT_GIFT = 160,
  AIRCRAFT_DISPATCH_UNKOWN_ERROR = 200,
  AIRCRAFT_DISPATCH_ERROR = 201,
  AIRCRAFT_DISPATCH_SITE_INDEX = 202,
  AIRCRAFT_DISPATCH_PET_NOT = 203,
  AIRCRAFT_DISPATCH_PET_STATE = 204,
  AIRCRAFT_DISPATCH_TIME_COUNT = 205,
  AIRCRAFT_DISPATCH_TEAM_COUNT = 206,
  AIRCRAFT_DISPATCH_TASK_STATE = 207,
  AIRCRAFT_DISPATCH_TASK_ID = 208,
  AIRCRAFT_DISPATCH_TEAM_SIZE = 209,
  AIRCRAFT_DISPATCH_PET_REPEAT = 210,
  TACTIC_FREE_TIMES_NOT_ENOUGH = 231,
  TACTIC_CARTRIDGE_NUM_LIMIT = 232,
  TACTIC_SPEEDUP_FIREFLY_NUM_ERR = 233,
  TACTIC_PET_FIGHT_LIMIT = 234,
  TACTIC_WEEK_PASS_NOT_ENOUGH = 235,
  TACTIC_WEEK_AWARD_RECEIVED = 236,
  TACTIC_WEEK_PASS_NUM_ERR = 237,
  TACTIC_CARTRIDGE_DELETE_ERR = 238,
  AIRCRAFT_TACTIC_PEAKREWARD_RECEIVED = 300,
  AIRCRAFT_TACTIC_INVALID_PEAKLEVEL = 301,
  AIRCRAFT_TACTIC_UNREACH_LEVEL = 302,
  AIRCRAFT_TACTIC_INFO_UNLOCK_MISS_COND = 310,
  AIRCRAFT_TACTIC_INFO_UNLOCKED = 311,
  AIRCRAFT_TACTIC_INFO_INVALID_ID = 312,
  AIRCRAFT_TACTIC_THEME_UNLOCKABLE_FALSE = 313,
  AIRCRAFT_TACTIC_THEME_ASSET_LACK = 314,
  AIRCRAFT_TACTIC_THEME_INFO_ALREADY_GET = 315
}
_enum("AircraftEventResult", AircraftEventResult)
_class("CEventAircraftCheckClickPetTriggerStory", CCallRequestEvent)
CEventAircraftCheckClickPetTriggerStory = CEventAircraftCheckClickPetTriggerStory

function CEventAircraftCheckClickPetTriggerStory:Constructor()
  self.pet_pstid = 0
end

CEventAircraftCheckClickPetTriggerStory._proto = {
  [1] = {"pet_pstid", "int64"}
}
_class("CEventAircraftCheckClickPetTriggerStoryResult", CCallReplyEvent)
CEventAircraftCheckClickPetTriggerStoryResult = CEventAircraftCheckClickPetTriggerStoryResult

function CEventAircraftCheckClickPetTriggerStoryResult:Constructor()
  self.ret = 0
  self.trigger_click_story_id = 0
end

CEventAircraftCheckClickPetTriggerStoryResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "trigger_click_story_id",
    "int"
  }
}
_class("CEventPushAircraftInfo", CSvrPushEvent)
CEventPushAircraftInfo = CEventPushAircraftInfo

function CEventPushAircraftInfo:Constructor()
  self.info = aircraft_info:New()
end

CEventPushAircraftInfo._proto = {
  [1] = {
    "info",
    "aircraft_info"
  }
}
_class("CEventPushAircraftSpaceInfos", CSvrPushEvent)
CEventPushAircraftSpaceInfos = CEventPushAircraftSpaceInfos

function CEventPushAircraftSpaceInfos:Constructor()
  self.infos = {}
end

CEventPushAircraftSpaceInfos._proto = {
  [1] = {
    "infos",
    "map<int,aircraft_space_info>"
  }
}
_class("CEventAircraftLeave", CCliPushEvent)
CEventAircraftLeave = CEventAircraftLeave

function CEventAircraftLeave:Constructor()
end

CEventAircraftLeave._proto = {}
_class("CEventAircraftUpdate", CCallRequestEvent)
CEventAircraftUpdate = CEventAircraftUpdate

function CEventAircraftUpdate:Constructor()
  self.enter = 0
end

CEventAircraftUpdate._proto = {
  [1] = {"enter", "int"}
}
_class("CEventAircraftUpdateResult", CCallReplyEvent)
CEventAircraftUpdateResult = CEventAircraftUpdateResult

function CEventAircraftUpdateResult:Constructor()
  self.ret = 0
end

CEventAircraftUpdateResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventPushViewNewFurniture", CCliPushEvent)
CEventPushViewNewFurniture = CEventPushViewNewFurniture

function CEventPushViewNewFurniture:Constructor()
  self.furniture_item_id = 0
end

CEventPushViewNewFurniture._proto = {
  [1] = {
    "furniture_item_id",
    "int"
  }
}
_class("CEventAircraftFurnitureInfoReq", CCallRequestEvent)
CEventAircraftFurnitureInfoReq = CEventAircraftFurnitureInfoReq

function CEventAircraftFurnitureInfoReq:Constructor()
end

CEventAircraftFurnitureInfoReq._proto = {}
_class("CEventAircraftFurnitureInfoResult", CCallReplyEvent)
CEventAircraftFurnitureInfoResult = CEventAircraftFurnitureInfoResult

function CEventAircraftFurnitureInfoResult:Constructor()
  self.mobile_furniture_info = {}
end

CEventAircraftFurnitureInfoResult._proto = {
  [1] = {
    "mobile_furniture_info",
    "list<MobileFurnitureInfo>"
  }
}
_class("CEventAircraftFurnitureInfoUpReq", CCallRequestEvent)
CEventAircraftFurnitureInfoUpReq = CEventAircraftFurnitureInfoUpReq

function CEventAircraftFurnitureInfoUpReq:Constructor()
  self.area_id = 0
  self.update_furniture_info = {}
end

CEventAircraftFurnitureInfoUpReq._proto = {
  [1] = {"area_id", "int"},
  [2] = {
    "update_furniture_info",
    "list<MobileFurnitureInfo>"
  }
}
_class("CEventAircraftFurnitureInfoUpResult", CCallReplyEvent)
CEventAircraftFurnitureInfoUpResult = CEventAircraftFurnitureInfoUpResult

function CEventAircraftFurnitureInfoUpResult:Constructor()
  self.ret = 0
end

CEventAircraftFurnitureInfoUpResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventPushAircraftAreaFurniture", CSvrPushEvent)
CEventPushAircraftAreaFurniture = CEventPushAircraftAreaFurniture

function CEventPushAircraftAreaFurniture:Constructor()
  self.area_id = 0
  self.update_furniture_info = {}
end

CEventPushAircraftAreaFurniture._proto = {
  [1] = {"area_id", "int"},
  [2] = {
    "update_furniture_info",
    "list<MobileFurnitureInfo>"
  }
}
local AircraftRoomOperation = {
  CleanSpace = 0,
  BuildRoom = 1,
  Upgrade = 2,
  Degrade = 3,
  ReplacePets = 4,
  CollectAsset = 5,
  BuildSpeedUp = 6,
  UpgradeSpeedUp = 7,
  PurifySpeedUp = 8,
  CleanSpeedUp = 9,
  DegradeSpeedUp = 10,
  CheckInOnePet = 11,
  OneKeyCollectAsset = 12
}
_enum("AircraftRoomOperation", AircraftRoomOperation)
_class("CEventAircraftRoomOperate", CCallRequestEvent)
CEventAircraftRoomOperate = CEventAircraftRoomOperate

function CEventAircraftRoomOperate:Constructor()
  self.space_id = 0
  self.option = 0
  self.operate_params = {}
end

CEventAircraftRoomOperate._proto = {
  [1] = {"space_id", "int"},
  [2] = {"option", "int"},
  [3] = {
    "operate_params",
    "list<int64>"
  }
}
_class("CEventAircraftRoomOperateResult", CCallReplyEvent)
CEventAircraftRoomOperateResult = CEventAircraftRoomOperateResult

function CEventAircraftRoomOperateResult:Constructor()
  self.ret = 0
  self.asset = {}
end

CEventAircraftRoomOperateResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "asset",
    "list<RoleAsset>"
  }
}
_class("CEventAircraftRedeemFirfly", CCallRequestEvent)
CEventAircraftRedeemFirfly = CEventAircraftRedeemFirfly

function CEventAircraftRedeemFirfly:Constructor()
  self.physic_point = 0
end

CEventAircraftRedeemFirfly._proto = {
  [1] = {
    "physic_point",
    "int"
  }
}
_class("CEventAircraftRedeemFirflyResult", CCallReplyEvent)
CEventAircraftRedeemFirflyResult = CEventAircraftRedeemFirflyResult

function CEventAircraftRedeemFirflyResult:Constructor()
  self.ret = 0
end

CEventAircraftRedeemFirflyResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventAircraftPeriodAffinity", CCallRequestEvent)
CEventAircraftPeriodAffinity = CEventAircraftPeriodAffinity

function CEventAircraftPeriodAffinity:Constructor()
end

CEventAircraftPeriodAffinity._proto = {}
_class("CEventAircraftPeriodAffinityResult", CCallReplyEvent)
CEventAircraftPeriodAffinityResult = CEventAircraftPeriodAffinityResult

function CEventAircraftPeriodAffinityResult:Constructor()
  self.ret = 0
  self.exData = CentralRoomExtData:New()
end

CEventAircraftPeriodAffinityResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "exData",
    "CentralRoomExtData"
  }
}
_class("CEventItemSmelt", CCallRequestEvent)
CEventItemSmelt = CEventItemSmelt

function CEventItemSmelt:Constructor()
  self.id = 0
  self.num = 0
  self.ids = {}
end

CEventItemSmelt._proto = {
  [1] = {"id", "int"},
  [2] = {"num", "int"},
  [3] = {"ids", "list<int>"}
}
_class("CEventItemSmeltResult", CCallReplyEvent)
CEventItemSmeltResult = CEventItemSmeltResult

function CEventItemSmeltResult:Constructor()
  self.ret = 0
  self.id = 0
  self.num = 0
end

CEventItemSmeltResult._proto = {
  [1] = {"ret", "int"},
  [2] = {"id", "int"},
  [3] = {"num", "int64"}
}
_class("CEventMultItemSmelt", CCallRequestEvent)
CEventMultItemSmelt = CEventMultItemSmelt

function CEventMultItemSmelt:Constructor()
  self.id_num_list = {}
end

CEventMultItemSmelt._proto = {
  [1] = {
    "id_num_list",
    "list<RoleAsset>"
  }
}
_class("CEventMultItemSmeltResult", CCallReplyEvent)
CEventMultItemSmeltResult = CEventMultItemSmeltResult

function CEventMultItemSmeltResult:Constructor()
  self.ret = 0
  self.item_list = {}
end

CEventMultItemSmeltResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "item_list",
    "list<RoleAsset>"
  }
}
_class("CEventFireflyToAtom", CCallRequestEvent)
CEventFireflyToAtom = CEventFireflyToAtom

function CEventFireflyToAtom:Constructor()
  self.num = 0
end

CEventFireflyToAtom._proto = {
  [1] = {"num", "int"}
}
_class("CEventFireflyToAtomResult", CCallReplyEvent)
CEventFireflyToAtomResult = CEventFireflyToAtomResult

function CEventFireflyToAtomResult:Constructor()
  self.ret = 0
  self.num = 0
end

CEventFireflyToAtomResult._proto = {
  [1] = {"ret", "int"},
  [3] = {"num", "int64"}
}
_class("CEventDispatchSite", CCallRequestEvent)
CEventDispatchSite = CEventDispatchSite

function CEventDispatchSite:Constructor()
end

CEventDispatchSite._proto = {}
_class("CEventDispatchSiteResult", CCallReplyEvent)
CEventDispatchSiteResult = CEventDispatchSiteResult

function CEventDispatchSiteResult:Constructor()
  self.ret = 0
end

CEventDispatchSiteResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventDispatchLook", CCallRequestEvent)
CEventDispatchLook = CEventDispatchLook

function CEventDispatchLook:Constructor()
end

CEventDispatchLook._proto = {}
_class("CEventDispatchLookResult", CCallReplyEvent)
CEventDispatchLookResult = CEventDispatchLookResult

function CEventDispatchLookResult:Constructor()
  self.ret = 0
end

CEventDispatchLookResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventDispatchAcceptTask", CCallRequestEvent)
CEventDispatchAcceptTask = CEventDispatchAcceptTask

function CEventDispatchAcceptTask:Constructor()
  self.site_id = 0
  self.team_member = {}
end

CEventDispatchAcceptTask._proto = {
  [1] = {"site_id", "int"},
  [2] = {
    "team_member",
    "list<int64>"
  }
}
_class("CEventDispatchAcceptTaskResult", CCallReplyEvent)
CEventDispatchAcceptTaskResult = CEventDispatchAcceptTaskResult

function CEventDispatchAcceptTaskResult:Constructor()
  self.ret = 0
end

CEventDispatchAcceptTaskResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventDispatchCancelTask", CCallRequestEvent)
CEventDispatchCancelTask = CEventDispatchCancelTask

function CEventDispatchCancelTask:Constructor()
  self.site_id = 0
end

CEventDispatchCancelTask._proto = {
  [1] = {"site_id", "int"}
}
_class("CEventDispatchCancelTaskResult", CCallReplyEvent)
CEventDispatchCancelTaskResult = CEventDispatchCancelTaskResult

function CEventDispatchCancelTaskResult:Constructor()
  self.ret = 0
end

CEventDispatchCancelTaskResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventDispatchTaskAward", CCallRequestEvent)
CEventDispatchTaskAward = CEventDispatchTaskAward

function CEventDispatchTaskAward:Constructor()
  self.site_id = 0
end

CEventDispatchTaskAward._proto = {
  [1] = {"site_id", "int"}
}
_class("CEventDispatchTaskAwardResult", CCallReplyEvent)
CEventDispatchTaskAwardResult = CEventDispatchTaskAwardResult

function CEventDispatchTaskAwardResult:Constructor()
  self.ret = 0
  self.is_assign = false
end

CEventDispatchTaskAwardResult._proto = {
  [1] = {"ret", "int"},
  [2] = {"is_assign", "bool"}
}
_class("CEventAcceptPresent", CCallRequestEvent)
CEventAcceptPresent = CEventAcceptPresent

function CEventAcceptPresent:Constructor()
  self.pet_pstid = 0
end

CEventAcceptPresent._proto = {
  [1] = {"pet_pstid", "int64"}
}
_class("CEventAcceptPresentResult", CCallReplyEvent)
CEventAcceptPresentResult = CEventAcceptPresentResult

function CEventAcceptPresentResult:Constructor()
  self.ret = 0
  self.drop_item_list = {}
end

CEventAcceptPresentResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "drop_item_list",
    "list<RoleAsset>"
  }
}
_class("CEventAcceptVisitPet", CCallRequestEvent)
CEventAcceptVisitPet = CEventAcceptVisitPet

function CEventAcceptVisitPet:Constructor()
  self.pet_pstid = 0
end

CEventAcceptVisitPet._proto = {
  [1] = {"pet_pstid", "int64"}
}
_class("CEventAcceptVisitPetResult", CCallReplyEvent)
CEventAcceptVisitPetResult = CEventAcceptVisitPetResult

function CEventAcceptVisitPetResult:Constructor()
  self.ret = 0
  self.drop_item_list = {}
end

CEventAcceptVisitPetResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "drop_item_list",
    "list<RoleAsset>"
  }
}
_class("CEventSearchEvil", CCallRequestEvent)
CEventSearchEvil = CEventSearchEvil

function CEventSearchEvil:Constructor()
  self.space_id = 0
end

CEventSearchEvil._proto = {
  [1] = {"space_id", "int"}
}
_class("CEventSearchEvilResult", CCallReplyEvent)
CEventSearchEvilResult = CEventSearchEvilResult

function CEventSearchEvilResult:Constructor()
  self.ret = 0
  self.m_refresh_space = {}
end

CEventSearchEvilResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventCaptureEvil", CCallRequestEvent)
CEventCaptureEvil = CEventCaptureEvil

function CEventCaptureEvil:Constructor()
  self.space_id = 0
  self.evil_id = 0
end

CEventCaptureEvil._proto = {
  [1] = {"space_id", "int"},
  [2] = {"evil_id", "int"}
}
_class("CEventCaptureEvilResult", CCallReplyEvent)
CEventCaptureEvilResult = CEventCaptureEvilResult

function CEventCaptureEvilResult:Constructor()
  self.ret = 0
end

CEventCaptureEvilResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventQuickCaptureEvil", CCallRequestEvent)
CEventQuickCaptureEvil = CEventQuickCaptureEvil

function CEventQuickCaptureEvil:Constructor()
  self.space_id = 0
end

CEventQuickCaptureEvil._proto = {
  [1] = {"space_id", "int"}
}
_class("CEventQuickCaptureEvilResult", CCallReplyEvent)
CEventQuickCaptureEvilResult = CEventQuickCaptureEvilResult

function CEventQuickCaptureEvilResult:Constructor()
  self.ret = 0
end

CEventQuickCaptureEvilResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventTraceEvil", CCallRequestEvent)
CEventTraceEvil = CEventTraceEvil

function CEventTraceEvil:Constructor()
  self.space_id = 0
  self.refresh_index = 0
end

CEventTraceEvil._proto = {
  [1] = {"space_id", "int"},
  [2] = {
    "refresh_index",
    "int"
  }
}
_class("CEventTraceEvilResult", CCallReplyEvent)
CEventTraceEvilResult = CEventTraceEvilResult

function CEventTraceEvilResult:Constructor()
  self.ret = 0
end

CEventTraceEvilResult._proto = {
  [1] = {"ret", "int"}
}
local EvilOperation = {
  Storage = 0,
  Release = 1,
  Transfer = 2
}
_enum("EvilOperation", EvilOperation)
_class("CEventEvilOperate", CCallRequestEvent)
CEventEvilOperate = CEventEvilOperate

function CEventEvilOperate:Constructor()
  self.evil_space_id = 0
  self.purify_space_id = 0
  self.usage = 0
  self.evil_id = 0
  self.cell_index = 0
end

CEventEvilOperate._proto = {
  [1] = {
    "evil_space_id",
    "int"
  },
  [2] = {
    "purify_space_id",
    "int"
  },
  [3] = {"usage", "int"},
  [4] = {"evil_id", "int"},
  [5] = {"cell_index", "int"}
}
_class("CEventEvilOperateResult", CCallReplyEvent)
CEventEvilOperateResult = CEventEvilOperateResult

function CEventEvilOperateResult:Constructor()
  self.ret = 0
end

CEventEvilOperateResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventPurifyEvil", CCallRequestEvent)
CEventPurifyEvil = CEventPurifyEvil

function CEventPurifyEvil:Constructor()
  self.space_id = 0
  self.evil_id = 0
end

CEventPurifyEvil._proto = {
  [1] = {"space_id", "int"},
  [2] = {"evil_id", "int"}
}
_class("CEventPurifyEvilResult", CCallReplyEvent)
CEventPurifyEvilResult = CEventPurifyEvilResult

function CEventPurifyEvilResult:Constructor()
  self.ret = 0
end

CEventPurifyEvilResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventGetConfigRequest", CCallRequestEvent)
CEventGetConfigRequest = CEventGetConfigRequest

function CEventGetConfigRequest:Constructor()
end

CEventGetConfigRequest._proto = {}
_class("CEventGetConfigRequestResult", CCallReplyEvent)
CEventGetConfigRequestResult = CEventGetConfigRequestResult

function CEventGetConfigRequestResult:Constructor()
  self.aircraft_space_config = {}
  self.aircraft_room_config = {}
  self.aircraft_Central_room_config = {}
end

CEventGetConfigRequestResult._proto = {
  [1] = {
    "aircraft_space_config",
    "map<int,MobileCfgAircraftSpace>"
  },
  [2] = {
    "aircraft_room_config",
    "map<int,MobileCfgAircraftRoom>"
  },
  [3] = {
    "aircraft_Central_room_config",
    "map<int,MobileCfgAircraftCentralRoom>"
  }
}
_class("CEventAddAircraftGetSpaceData", CCallRequestEvent)
CEventAddAircraftGetSpaceData = CEventAddAircraftGetSpaceData

function CEventAddAircraftGetSpaceData:Constructor()
end

CEventAddAircraftGetSpaceData._proto = {}
_class("CEventAddAircraftGetSpaceDataResult", CCallReplyEvent)
CEventAddAircraftGetSpaceDataResult = CEventAddAircraftGetSpaceDataResult

function CEventAddAircraftGetSpaceDataResult:Constructor()
  self.infos = {}
  self.s_aircraft_info = aircraft_info:New()
end

CEventAddAircraftGetSpaceDataResult._proto = {
  [1] = {
    "infos",
    "map<int,aircraft_space_info>"
  },
  [2] = {
    "s_aircraft_info",
    "aircraft_info"
  }
}
_class("CEventPushClickPet", CCliPushEvent)
CEventPushClickPet = CEventPushClickPet

function CEventPushClickPet:Constructor()
  self.pet_pstid = 0
end

CEventPushClickPet._proto = {
  [1] = {"pet_pstid", "int64"}
}
_class("CEventAircraftCleanAndBuild", CCallRequestEvent)
CEventAircraftCleanAndBuild = CEventAircraftCleanAndBuild

function CEventAircraftCleanAndBuild:Constructor()
  self.space_id = 0
  self.room_id = 0
end

CEventAircraftCleanAndBuild._proto = {
  [1] = {"space_id", "int"},
  [2] = {"room_id", "int"}
}
_class("CEventAircraftCleanAndBuildResult", CCallReplyEvent)
CEventAircraftCleanAndBuildResult = CEventAircraftCleanAndBuildResult

function CEventAircraftCleanAndBuildResult:Constructor()
  self.ret = 0
  self.asset = {}
end

CEventAircraftCleanAndBuildResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "asset",
    "list<RoleAsset>"
  }
}
_class("CEventRequestTacticRoomData", CCallRequestEvent)
CEventRequestTacticRoomData = CEventRequestTacticRoomData

function CEventRequestTacticRoomData:Constructor()
end

CEventRequestTacticRoomData._proto = {}
_class("CEventRequestTacticRoomDataResult", CCallReplyEvent)
CEventRequestTacticRoomDataResult = CEventRequestTacticRoomDataResult

function CEventRequestTacticRoomDataResult:Constructor()
  self.ret = 0
  self.room_data = TacticRoomExtData:New()
end

CEventRequestTacticRoomDataResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "room_data",
    "TacticRoomExtData"
  }
}
_class("CEventCartridgeFreeProduce", CCallRequestEvent)
CEventCartridgeFreeProduce = CEventCartridgeFreeProduce

function CEventCartridgeFreeProduce:Constructor()
end

CEventCartridgeFreeProduce._proto = {}
_class("CEventCartridgeFreeProduceResult", CCallReplyEvent)
CEventCartridgeFreeProduceResult = CEventCartridgeFreeProduceResult

function CEventCartridgeFreeProduceResult:Constructor()
  self.ret = 0
end

CEventCartridgeFreeProduceResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventCartridgeProSpeedUp", CCallRequestEvent)
CEventCartridgeProSpeedUp = CEventCartridgeProSpeedUp

function CEventCartridgeProSpeedUp:Constructor()
  self.firefly_count = 0
end

CEventCartridgeProSpeedUp._proto = {
  [1] = {
    "firefly_count",
    "int64"
  }
}
_class("CEventCartridgeProSpeedUpResult", CCallReplyEvent)
CEventCartridgeProSpeedUpResult = CEventCartridgeProSpeedUpResult

function CEventCartridgeProSpeedUpResult:Constructor()
  self.ret = 0
end

CEventCartridgeProSpeedUpResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventTacticWeekReset", CCallRequestEvent)
CEventTacticWeekReset = CEventTacticWeekReset

function CEventTacticWeekReset:Constructor()
end

CEventTacticWeekReset._proto = {}
_class("CEventTacticWeekResetResult", CCallReplyEvent)
CEventTacticWeekResetResult = CEventTacticWeekResetResult

function CEventTacticWeekResetResult:Constructor()
  self.ret = 0
  self.next_reset_time = 0
  self.free_pro_count = 0
  self.remain_free_count = 0
end

CEventTacticWeekResetResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "next_reset_time",
    "time"
  },
  [3] = {
    "free_pro_count",
    "int"
  },
  [4] = {
    "remain_free_count",
    "int"
  }
}
_class("CEventGetTacticFormationInfo", CCallRequestEvent)
CEventGetTacticFormationInfo = CEventGetTacticFormationInfo

function CEventGetTacticFormationInfo:Constructor()
end

CEventGetTacticFormationInfo._proto = {}
_class("CEventGetTacticFormationInfoResult", CCallReplyEvent)
CEventGetTacticFormationInfoResult = CEventGetTacticFormationInfoResult

function CEventGetTacticFormationInfoResult:Constructor()
  self.tactic_formation_list = {}
end

CEventGetTacticFormationInfoResult._proto = {
  [1] = {
    "tactic_formation_list",
    "list<TacticFormationInfo>"
  }
}
_class("CEventChangeTacticFormationInfo", CCallRequestEvent)
CEventChangeTacticFormationInfo = CEventChangeTacticFormationInfo

function CEventChangeTacticFormationInfo:Constructor()
  self.id = 0
  self.name = ""
  self.pet_list = {}
end

CEventChangeTacticFormationInfo._proto = {
  [1] = {"id", "int"},
  [2] = {"name", "string"},
  [3] = {
    "pet_list",
    "list<int64>"
  }
}
_class("CEventChangeTacticFormationInfoResult", CCallReplyEvent)
CEventChangeTacticFormationInfoResult = CEventChangeTacticFormationInfoResult

function CEventChangeTacticFormationInfoResult:Constructor()
  self.ret = 0
  self.tactic_formation_list = {}
end

CEventChangeTacticFormationInfoResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "tactic_formation_list",
    "list<TacticFormationInfo>"
  }
}
_class("CEventTakeWeeklyAward", CCallRequestEvent)
CEventTakeWeeklyAward = CEventTakeWeeklyAward

function CEventTakeWeeklyAward:Constructor()
  self.pass_num = 0
end

CEventTakeWeeklyAward._proto = {
  [1] = {"pass_num", "int"}
}
_class("CEventTakeWeeklyAwardResult", CCallReplyEvent)
CEventTakeWeeklyAwardResult = CEventTakeWeeklyAwardResult

function CEventTakeWeeklyAwardResult:Constructor()
  self.ret = 0
  self.award_list = {}
end

CEventTakeWeeklyAwardResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "award_list",
    "list<RoleAsset>"
  }
}
_class("CEventTacticPeakReward", CCallRequestEvent)
CEventTacticPeakReward = CEventTacticPeakReward

function CEventTacticPeakReward:Constructor()
  self.level = {}
end

CEventTacticPeakReward._proto = {
  [1] = {"level", "list<int>"}
}
_class("CEventTacticPeakRewardResult", CCallReplyEvent)
CEventTacticPeakRewardResult = CEventTacticPeakRewardResult

function CEventTacticPeakRewardResult:Constructor()
  self.ret = 0
  self.received_peak_lv_list = {}
  self.award_list = {}
end

CEventTacticPeakRewardResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "received_peak_lv_list",
    "list<int>"
  },
  [3] = {
    "award_list",
    "list<RoleAsset>"
  }
}
_class("CEventTacticUnlockTheme", CCallRequestEvent)
CEventTacticUnlockTheme = CEventTacticUnlockTheme

function CEventTacticUnlockTheme:Constructor()
  self.themeid = 0
end

CEventTacticUnlockTheme._proto = {
  [1] = {"themeid", "int"}
}
_class("CEventTacticUnlockThemeResult", CCallReplyEvent)
CEventTacticUnlockThemeResult = CEventTacticUnlockThemeResult

function CEventTacticUnlockThemeResult:Constructor()
  self.ret = 0
  self.theme_list = {}
end

CEventTacticUnlockThemeResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "theme_list",
    "map<int,TacticalDBThemeData>"
  }
}
_class("CEventTacticGetInformation", CCallRequestEvent)
CEventTacticGetInformation = CEventTacticGetInformation

function CEventTacticGetInformation:Constructor()
  self.themeid = 0
  self.infoid = 0
end

CEventTacticGetInformation._proto = {
  [1] = {"themeid", "int"},
  [2] = {"infoid", "int"}
}
_class("CEventTacticGetInformationResult", CCallReplyEvent)
CEventTacticGetInformationResult = CEventTacticGetInformationResult

function CEventTacticGetInformationResult:Constructor()
  self.ret = 0
  self.theme_list = {}
end

CEventTacticGetInformationResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "theme_list",
    "map<int,TacticalDBThemeData>"
  }
}
_class("CEventDelCartridge", CCallRequestEvent)
CEventDelCartridge = CEventDelCartridge

function CEventDelCartridge:Constructor()
  self.pstid = 0
end

CEventDelCartridge._proto = {
  [1] = {"pstid", "int64"}
}
_class("CEventDelCartridgeResult", CCallReplyEvent)
CEventDelCartridgeResult = CEventDelCartridgeResult

function CEventDelCartridgeResult:Constructor()
  self.ret = 0
end

CEventDelCartridgeResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventAIMultItemSmelt", CCallRequestEvent)
CEventAIMultItemSmelt = CEventAIMultItemSmelt

function CEventAIMultItemSmelt:Constructor()
  self.id_num_list = {}
end

CEventAIMultItemSmelt._proto = {
  [1] = {
    "id_num_list",
    "list<RoleAsset>"
  }
}
_class("CEventAIMultItemSmeltResult", CCallReplyEvent)
CEventAIMultItemSmeltResult = CEventAIMultItemSmeltResult

function CEventAIMultItemSmeltResult:Constructor()
  self.ret = 0
  self.item_list = {}
end

CEventAIMultItemSmeltResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "item_list",
    "list<RoleAsset>"
  }
}
_class("CEventCollectPrism", CCallRequestEvent)
CEventCollectPrism = CEventCollectPrism

function CEventCollectPrism:Constructor()
  self.prism_count = 0
end

CEventCollectPrism._proto = {
  [1] = {
    "prism_count",
    "int"
  }
}
_class("CEventCollectPrismResult", CCallReplyEvent)
CEventCollectPrismResult = CEventCollectPrismResult

function CEventCollectPrismResult:Constructor()
  self.ret = 0
end

CEventCollectPrismResult._proto = {
  [1] = {"ret", "int"}
}
