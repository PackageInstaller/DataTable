require("message_def")
local resdungeonMessageDef = {
  CLSID_CEventPushResDungeonData = 19000,
  CLSID_CEventPushAlreadyReturnPowerDungeon = 19001,
  CLSID_CEventApplyDungeonStatus = 19002,
  CLSID_CEventApplyDungeonStatusResult = 19003,
  CLSID_CEventApplyDungeonData = 19004,
  CLSID_CEventApplyDungeonDataResult = 19005,
  CLSID_CEventSetDoubleResStatus = 19006,
  CLSID_CEventSetDoubleResStatusResult = 19007,
  CLSID_CEventCheckPassedReq = 19008,
  CLSID_CEventCheckPassedResult = 19009
}
table.append(MessageDef, resdungeonMessageDef)
local RES_DUNGEON_CODE = {
  RES_DUNGEON_SUCCEED = 0,
  RES_DUNGEON_FAIL = 1,
  RES_DUNGEON_ID_ERROR = -2,
  RES_DUNGEON_CONFIG_ERROR = -3,
  RES_DUNGEON_STAR_COUNT_ERROR = -4,
  RES_DUNGEON_HAVENT_PASS_MISSION_CONDITION = -5,
  RES_DUNGEON_PREV_LEVEL_LOCKED = -11,
  RES_DUNGEON_CENTRALROOM_LEVEL_NOT_ENOUGH = -12,
  RES_DUNGEON_HAVENT_CONFIG_THIS_LEVEL = -13,
  RES_DUNGEON_DOUBLE_RES_NOT_ENOUGH = -14,
  RES_DUNGEON_DOUBLE_RES_INVALID = -15,
  RES_DUNGEON_AIRCRAFT_RESOURCE_ROOM_UNOPEN = -16,
  RES_DUNGEON_CLOSED = -17
}
_enum("RES_DUNGEON_CODE", RES_DUNGEON_CODE)
_class("CEventPushResDungeonData", CSvrPushEvent)
CEventPushResDungeonData = CEventPushResDungeonData

function CEventPushResDungeonData:Constructor()
  self.all_instance = {}
  self.open_status = {}
  self.passed_instance = {}
  self.double_res_state = false
end

CEventPushResDungeonData._proto = {
  [1] = {
    "all_instance",
    "map<int,list<int>>"
  },
  [2] = {
    "open_status",
    "map<int,int>"
  },
  [3] = {
    "passed_instance",
    "list<int>"
  },
  [4] = {
    "double_res_state",
    "bool"
  }
}
_class("CEventPushAlreadyReturnPowerDungeon", CSvrPushEvent)
CEventPushAlreadyReturnPowerDungeon = CEventPushAlreadyReturnPowerDungeon

function CEventPushAlreadyReturnPowerDungeon:Constructor()
  self.ids = {}
end

CEventPushAlreadyReturnPowerDungeon._proto = {
  [1] = {"ids", "list<int>"}
}
_class("CEventApplyDungeonStatus", CCallRequestEvent)
CEventApplyDungeonStatus = CEventApplyDungeonStatus

function CEventApplyDungeonStatus:Constructor()
end

CEventApplyDungeonStatus._proto = {}
_class("CEventApplyDungeonStatusResult", CCallReplyEvent)
CEventApplyDungeonStatusResult = CEventApplyDungeonStatusResult

function CEventApplyDungeonStatusResult:Constructor()
  self.open_status = {}
  self.double_res_state = false
end

CEventApplyDungeonStatusResult._proto = {
  [1] = {
    "open_status",
    "map<int,int>"
  },
  [2] = {
    "double_res_state",
    "bool"
  }
}
_class("CEventApplyDungeonData", CCallRequestEvent)
CEventApplyDungeonData = CEventApplyDungeonData

function CEventApplyDungeonData:Constructor()
end

CEventApplyDungeonData._proto = {}
_class("CEventApplyDungeonDataResult", CCallReplyEvent)
CEventApplyDungeonDataResult = CEventApplyDungeonDataResult

function CEventApplyDungeonDataResult:Constructor()
  self.all_instance = {}
  self.open_status = {}
  self.passed_instance = {}
  self.double_res_state = false
end

CEventApplyDungeonDataResult._proto = {
  [1] = {
    "all_instance",
    "map<int,list<int>>"
  },
  [2] = {
    "open_status",
    "map<int,int>"
  },
  [3] = {
    "passed_instance",
    "list<int>"
  },
  [4] = {
    "double_res_state",
    "bool"
  }
}
_class("CEventSetDoubleResStatus", CCallRequestEvent)
CEventSetDoubleResStatus = CEventSetDoubleResStatus

function CEventSetDoubleResStatus:Constructor()
  self.open_switch_on = false
end

CEventSetDoubleResStatus._proto = {
  [1] = {
    "open_switch_on",
    "bool"
  }
}
_class("CEventSetDoubleResStatusResult", CCallReplyEvent)
CEventSetDoubleResStatusResult = CEventSetDoubleResStatusResult

function CEventSetDoubleResStatusResult:Constructor()
  self.ret = 0
end

CEventSetDoubleResStatusResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventCheckPassedReq", CCallRequestEvent)
CEventCheckPassedReq = CEventCheckPassedReq

function CEventCheckPassedReq:Constructor()
  self.level_id = 0
end

CEventCheckPassedReq._proto = {
  [1] = {"level_id", "int"}
}
_class("CEventCheckPassedResult", CCallReplyEvent)
CEventCheckPassedResult = CEventCheckPassedResult

function CEventCheckPassedResult:Constructor()
  self.is_passed = false
end

CEventCheckPassedResult._proto = {
  [1] = {"is_passed", "bool"}
}
