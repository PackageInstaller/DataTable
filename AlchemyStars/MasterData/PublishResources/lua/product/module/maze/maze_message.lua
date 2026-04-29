require("message_def")
local mazeMessageDef = {
  CLSID_CEventRequestMazeVersion = 13000,
  CLSID_CEventReplyMazeVersion = 13001,
  CLSID_CEventRequestMazeEnterRoom = 13002,
  CLSID_CEventReplyMazeEnterRoom = 13003,
  CLSID_CEventRequestMazeUseDice = 13004,
  CLSID_CEventReplyMazeUseDice = 13005,
  CLSID_CEventRequestMazeSelectRelic = 13006,
  CLSID_CEventReplyMazeSelectRelic = 13007,
  CLSID_CEventNotifyMazeInfo = 13008,
  CLSID_CEventApplyMazeFormationReq = 13009,
  CLSID_CEventApplyMazeFormationRes = 13010,
  CLSID_CEventApplyChangeMazeFormationReq = 13011,
  CLSID_CEventApplyChangeMazeFormationRes = 13012,
  CLSID_CEventSweepMazeReq = 13013,
  CLSID_CEventSweepMazeRes = 13014
}
table.append(MessageDef, mazeMessageDef)
local MazeOpResCode = {
  MAZE_SUCCESS = 0,
  MAZE_FAIL = 1,
  MAZE_INVALID_ROOM = 2,
  MAZE_VERSION_ERROR = 3,
  MAZE_NEED_LIGHT = 4,
  MAZE_NO_DICE = 5,
  MAZE_RAND_DEAD_PET_NOT_EXIST = 6,
  MAZE_RELIFE_PET_ERROR = 7
}
_enum("MazeOpResCode", MazeOpResCode)
_class("CEventRequestMazeVersion", CCallRequestEvent)
CEventRequestMazeVersion = CEventRequestMazeVersion

function CEventRequestMazeVersion:Constructor()
  self.maze_version = 0
  self.show_version = false
  self.show_layer = false
end

CEventRequestMazeVersion._proto = {
  [1] = {
    "maze_version",
    "int"
  },
  [2] = {
    "show_version",
    "bool"
  },
  [3] = {"show_layer", "bool"}
}
_class("CEventReplyMazeVersion", CCallReplyEvent)
CEventReplyMazeVersion = CEventReplyMazeVersion

function CEventReplyMazeVersion:Constructor()
  self.m_ret = 0
end

CEventReplyMazeVersion._proto = {
  [1] = {"m_ret", "int"}
}
_class("CEventRequestMazeEnterRoom", CCallRequestEvent)
CEventRequestMazeEnterRoom = CEventRequestMazeEnterRoom

function CEventRequestMazeEnterRoom:Constructor()
  self.room_index = 0
  self.is_random_relife_pet = false
end

CEventRequestMazeEnterRoom._proto = {
  [1] = {"room_index", "int"},
  [2] = {
    "is_random_relife_pet",
    "bool"
  }
}
_class("CEventReplyMazeEnterRoom", CCallReplyEvent)
CEventReplyMazeEnterRoom = CEventReplyMazeEnterRoom

function CEventReplyMazeEnterRoom:Constructor()
  self.m_ret = 0
  self.add_blood = 0
  self.add_light = 0
  self.effect_pstid = {}
end

CEventReplyMazeEnterRoom._proto = {
  [1] = {"m_ret", "int"},
  [2] = {"add_blood", "int"},
  [3] = {"add_light", "int"},
  [4] = {
    "effect_pstid",
    "list<int64>"
  }
}
_class("CEventRequestMazeUseDice", CCallRequestEvent)
CEventRequestMazeUseDice = CEventRequestMazeUseDice

function CEventRequestMazeUseDice:Constructor()
  self.relic_id = 0
end

CEventRequestMazeUseDice._proto = {
  [1] = {"relic_id", "int"}
}
_class("CEventReplyMazeUseDice", CCallReplyEvent)
CEventReplyMazeUseDice = CEventReplyMazeUseDice

function CEventReplyMazeUseDice:Constructor()
  self.m_ret = 0
  self.relic_id = 0
end

CEventReplyMazeUseDice._proto = {
  [1] = {"m_ret", "int"},
  [2] = {"relic_id", "int"}
}
_class("CEventRequestMazeSelectRelic", CCallRequestEvent)
CEventRequestMazeSelectRelic = CEventRequestMazeSelectRelic

function CEventRequestMazeSelectRelic:Constructor()
  self.relic_id = 0
end

CEventRequestMazeSelectRelic._proto = {
  [1] = {"relic_id", "int"}
}
_class("CEventReplyMazeSelectRelic", CCallReplyEvent)
CEventReplyMazeSelectRelic = CEventReplyMazeSelectRelic

function CEventReplyMazeSelectRelic:Constructor()
  self.m_ret = 0
end

CEventReplyMazeSelectRelic._proto = {
  [1] = {"m_ret", "int"}
}
_class("CEventNotifyMazeInfo", CSvrPushEvent)
CEventNotifyMazeInfo = CEventNotifyMazeInfo

function CEventNotifyMazeInfo:Constructor()
  self.data = maze_info:New()
  self.max_layer = 0
end

CEventNotifyMazeInfo._proto = {
  [1] = {"data", "maze_info"},
  [2] = {"max_layer", "int"}
}
_class("CEventApplyMazeFormationReq", CCallRequestEvent)
CEventApplyMazeFormationReq = CEventApplyMazeFormationReq

function CEventApplyMazeFormationReq:Constructor()
  self.nId = 1
end

CEventApplyMazeFormationReq._proto = {
  [1] = {"nId", "int"}
}
_class("CEventApplyMazeFormationRes", CCallReplyEvent)
CEventApplyMazeFormationRes = CEventApplyMazeFormationRes

function CEventApplyMazeFormationRes:Constructor()
  self.formation_info = maze_formation_info:New()
end

CEventApplyMazeFormationRes._proto = {
  [1] = {
    "formation_info",
    "maze_formation_info"
  }
}
_class("CEventApplyChangeMazeFormationReq", CCallRequestEvent)
CEventApplyChangeMazeFormationReq = CEventApplyChangeMazeFormationReq

function CEventApplyChangeMazeFormationReq:Constructor()
  self.m_formation_id = 0
  self.m_formation_name = ""
  self.m_formation_pet_list = {}
end

CEventApplyChangeMazeFormationReq._proto = {
  [1] = {
    "m_formation_id",
    "int"
  },
  [2] = {
    "m_formation_name",
    "string"
  },
  [3] = {
    "m_formation_pet_list",
    "list<int64>"
  }
}
_class("CEventApplyChangeMazeFormationRes", CCallReplyEvent)
CEventApplyChangeMazeFormationRes = CEventApplyChangeMazeFormationRes

function CEventApplyChangeMazeFormationRes:Constructor()
  self.m_result = 0
  self.m_formation_info = maze_formation_info:New()
end

CEventApplyChangeMazeFormationRes._proto = {
  [1] = {"m_result", "int"},
  [2] = {
    "m_formation_info",
    "maze_formation_info"
  }
}
_class("CEventSweepMazeReq", CCallRequestEvent)
CEventSweepMazeReq = CEventSweepMazeReq

function CEventSweepMazeReq:Constructor()
  self.maze_room_index = 0
end

CEventSweepMazeReq._proto = {
  [1] = {
    "maze_room_index",
    "int"
  }
}
_class("CEventSweepMazeRes", CCallReplyEvent)
CEventSweepMazeRes = CEventSweepMazeRes

function CEventSweepMazeRes:Constructor()
  self.m_result = 0
  self.awards = {}
end

CEventSweepMazeRes._proto = {
  [1] = {"m_result", "int"},
  [2] = {
    "awards",
    "list<RoleAsset>"
  }
}
