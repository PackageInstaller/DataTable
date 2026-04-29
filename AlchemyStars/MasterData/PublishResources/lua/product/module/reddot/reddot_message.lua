require("message_def")
local reddotMessageDef = {
  CLSID_CEventGetRedDotStatusReq = 37000,
  CLSID_CEventGetRedDotStatusRes = 37001,
  CLSID_CEventListenRedDotStatus = 37002,
  CLSID_CEventUnListenRedDotStatus = 37003,
  CLSID_CEventNotifyLightRedDot = 37004
}
table.append(MessageDef, reddotMessageDef)
_class("CEventGetRedDotStatusReq", CCallRequestEvent)
CEventGetRedDotStatusReq = CEventGetRedDotStatusReq

function CEventGetRedDotStatusReq:Constructor()
  self.check_list = {}
end

CEventGetRedDotStatusReq._proto = {
  [1] = {"check_list", "list<int>"}
}
_class("CEventGetRedDotStatusRes", CCallReplyEvent)
CEventGetRedDotStatusRes = CEventGetRedDotStatusRes

function CEventGetRedDotStatusRes:Constructor()
  self.red_dot_list = {}
end

CEventGetRedDotStatusRes._proto = {
  [1] = {
    "red_dot_list",
    "list<int>"
  }
}
_class("CEventListenRedDotStatus", CCliPushEvent)
CEventListenRedDotStatus = CEventListenRedDotStatus

function CEventListenRedDotStatus:Constructor()
  self.red_dot_list = {}
end

CEventListenRedDotStatus._proto = {
  [1] = {
    "red_dot_list",
    "list<int>"
  }
}
_class("CEventUnListenRedDotStatus", CCliPushEvent)
CEventUnListenRedDotStatus = CEventUnListenRedDotStatus

function CEventUnListenRedDotStatus:Constructor()
  self.red_dot_list = {}
end

CEventUnListenRedDotStatus._proto = {
  [1] = {
    "red_dot_list",
    "list<int>"
  }
}
_class("CEventNotifyLightRedDot", CSvrPushEvent)
CEventNotifyLightRedDot = CEventNotifyLightRedDot

function CEventNotifyLightRedDot:Constructor()
  self.red_dot_status = {}
end

CEventNotifyLightRedDot._proto = {
  [1] = {
    "red_dot_status",
    "map<int,bool>"
  }
}
