require("message_def")
local match_queueMessageDef = {
  CLSID_CEventRequestQuickJoinMatch = 12000,
  CLSID_CEventReplyQuickJoinMatch = 12001,
  CLSID_CEventRequestCancelQuickJoinMatch = 12002,
  CLSID_CEventReplyCancelQuickJoinMatch = 12003,
  CLSID_CEventPushMatchingSuccess = 12004
}
table.append(MessageDef, match_queueMessageDef)
_class("CEventRequestQuickJoinMatch", CCallRequestEvent)
CEventRequestQuickJoinMatch = CEventRequestQuickJoinMatch

function CEventRequestQuickJoinMatch:Constructor()
  self.m_match_type = 0
  self.m_level_id = 0
end

CEventRequestQuickJoinMatch._proto = {
  [1] = {
    "m_match_type",
    "int"
  },
  [2] = {"m_level_id", "int"}
}
_class("CEventReplyQuickJoinMatch", CCallReplyEvent)
CEventReplyQuickJoinMatch = CEventReplyQuickJoinMatch

function CEventReplyQuickJoinMatch:Constructor()
  self.m_ret = 0
end

CEventReplyQuickJoinMatch._proto = {
  [1] = {"m_ret", "int"}
}
_class("CEventRequestCancelQuickJoinMatch", CCallRequestEvent)
CEventRequestCancelQuickJoinMatch = CEventRequestCancelQuickJoinMatch

function CEventRequestCancelQuickJoinMatch:Constructor()
end

CEventRequestCancelQuickJoinMatch._proto = {}
_class("CEventReplyCancelQuickJoinMatch", CCallReplyEvent)
CEventReplyCancelQuickJoinMatch = CEventReplyCancelQuickJoinMatch

function CEventReplyCancelQuickJoinMatch:Constructor()
  self.m_ret = 0
end

CEventReplyCancelQuickJoinMatch._proto = {
  [1] = {"m_ret", "int"}
}
_class("CEventPushMatchingSuccess", CSvrPushEvent)
CEventPushMatchingSuccess = CEventPushMatchingSuccess

function CEventPushMatchingSuccess:Constructor()
  self.m_match_to_enter = GroupToken:New()
  self.m_vkey = 0
  self.m_server_ip = ""
  self.m_server_port = 0
end

CEventPushMatchingSuccess._proto = {
  [1] = {
    "m_match_to_enter",
    "GroupToken"
  },
  [2] = {"m_vkey", "int"},
  [3] = {
    "m_server_ip",
    "string"
  },
  [4] = {
    "m_server_port",
    "short"
  }
}
