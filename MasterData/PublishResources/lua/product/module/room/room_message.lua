require("message_def")
local roomMessageDef = {
  CLSID_CEventRequestCreateRoom = 21000,
  CLSID_CEventReplyCreateRoom = 21001,
  CLSID_CEventRequestJoinRoom = 21002,
  CLSID_CEventReplyJoinRoom = 21003,
  CLSID_CEventRequestEnterRoom = 21004,
  CLSID_CEventReplyEnterRoom = 21005,
  CLSID_CEventRequestLeaveRoom = 21006,
  CLSID_CEventReplyLeaveRoom = 21007,
  CLSID_CEventPushRoomClose = 21008,
  CLSID_CEventPushLeaveRoom = 21009,
  CLSID_CEventRequestStartMatch = 21010,
  CLSID_CEventReplyStartMatch = 21011,
  CLSID_CEventPushEnterMatch = 21012
}
table.append(MessageDef, roomMessageDef)
_class("CEventRequestCreateRoom", CCallRequestEvent)
CEventRequestCreateRoom = CEventRequestCreateRoom

function CEventRequestCreateRoom:Constructor()
  self.m_room_type = 0
end

CEventRequestCreateRoom._proto = {
  [1] = {
    "m_room_type",
    "int"
  }
}
_class("CEventReplyCreateRoom", CCallReplyEvent)
CEventReplyCreateRoom = CEventReplyCreateRoom

function CEventReplyCreateRoom:Constructor()
  self.m_ret = 0
  self.m_room_created = GroupToken:New()
  self.m_vkey = 0
  self.m_server_ip = ""
  self.m_server_port = 0
end

CEventReplyCreateRoom._proto = {
  [1] = {"m_ret", "int"},
  [2] = {
    "m_room_created",
    "GroupToken"
  },
  [3] = {"m_vkey", "int"},
  [4] = {
    "m_server_ip",
    "string"
  },
  [5] = {
    "m_server_port",
    "short"
  }
}
_class("CEventRequestJoinRoom", CCallRequestEvent)
CEventRequestJoinRoom = CEventRequestJoinRoom

function CEventRequestJoinRoom:Constructor()
  self.m_room_to_join = GroupToken:New()
end

CEventRequestJoinRoom._proto = {
  [1] = {
    "m_room_to_join",
    "GroupToken"
  }
}
_class("CEventReplyJoinRoom", CCallReplyEvent)
CEventReplyJoinRoom = CEventReplyJoinRoom

function CEventReplyJoinRoom:Constructor()
  self.m_ret = 0
  self.m_room_to_join = GroupToken:New()
  self.m_vkey = 0
  self.m_server_ip = ""
  self.m_server_port = 0
end

CEventReplyJoinRoom._proto = {
  [1] = {"m_ret", "int"},
  [2] = {
    "m_room_to_join",
    "GroupToken"
  },
  [3] = {"m_vkey", "int"},
  [4] = {
    "m_server_ip",
    "string"
  },
  [5] = {
    "m_server_port",
    "short"
  }
}
_class("CEventRequestEnterRoom", CCallRequestEvent)
CEventRequestEnterRoom = CEventRequestEnterRoom

function CEventRequestEnterRoom:Constructor()
  self.m_room_to_enter = GroupToken:New()
end

CEventRequestEnterRoom._proto = {
  [1] = {
    "m_room_to_enter",
    "GroupToken"
  }
}
_class("CEventReplyEnterRoom", CCallReplyEvent)
CEventReplyEnterRoom = CEventReplyEnterRoom

function CEventReplyEnterRoom:Constructor()
  self.m_ret = 0
  self.m_time = 0
end

CEventReplyEnterRoom._proto = {
  [1] = {"m_ret", "int"},
  [2] = {"m_time", "time"}
}
_class("CEventRequestLeaveRoom", CCallRequestEvent)
CEventRequestLeaveRoom = CEventRequestLeaveRoom

function CEventRequestLeaveRoom:Constructor()
end

CEventRequestLeaveRoom._proto = {}
_class("CEventReplyLeaveRoom", CCallReplyEvent)
CEventReplyLeaveRoom = CEventReplyLeaveRoom

function CEventReplyLeaveRoom:Constructor()
  self.m_ret = 0
end

CEventReplyLeaveRoom._proto = {
  [1] = {"m_ret", "int"}
}
_class("CEventPushRoomClose", CSvrPushEvent)
CEventPushRoomClose = CEventPushRoomClose

function CEventPushRoomClose:Constructor()
  self.m_room_to_close = GroupToken:New()
end

CEventPushRoomClose._proto = {
  [1] = {
    "m_room_to_close",
    "GroupToken"
  }
}
_class("CEventPushLeaveRoom", CSvrPushEvent)
CEventPushLeaveRoom = CEventPushLeaveRoom

function CEventPushLeaveRoom:Constructor()
end

CEventPushLeaveRoom._proto = {}
_class("CEventRequestStartMatch", CCallRequestEvent)
CEventRequestStartMatch = CEventRequestStartMatch

function CEventRequestStartMatch:Constructor()
  self.m_match_type = 0
  self.m_level_id = 0
end

CEventRequestStartMatch._proto = {
  [1] = {
    "m_match_type",
    "int"
  },
  [2] = {"m_level_id", "int"}
}
_class("CEventReplyStartMatch", CCallReplyEvent)
CEventReplyStartMatch = CEventReplyStartMatch

function CEventReplyStartMatch:Constructor()
  self.m_ret = 0
end

CEventReplyStartMatch._proto = {
  [1] = {"m_ret", "int"}
}
_class("CEventPushEnterMatch", CSvrPushEvent)
CEventPushEnterMatch = CEventPushEnterMatch

function CEventPushEnterMatch:Constructor()
  self.m_match_to_enter = GroupToken:New()
  self.m_vkey = 0
end

CEventPushEnterMatch._proto = {
  [1] = {
    "m_match_to_enter",
    "GroupToken"
  },
  [2] = {"m_vkey", "int"}
}
