require("message_def")
local h3dmobileMessageDef = {
  CLSID_CEventRequestLoginVerify = 15000,
  CLSID_CEventReplyLoginVerify = 15001,
  CLSID_CEventCliPushLogout = 15002,
  CLSID_CEventSvrPushLogout = 15003,
  CLSID_CEventSvrPushNotification = 15004
}
table.append(MessageDef, h3dmobileMessageDef)
_class("CEventRequestLoginVerify", CCallRequestEvent)
CEventRequestLoginVerify = CEventRequestLoginVerify

function CEventRequestLoginVerify:Constructor()
  self.m_is_login = false
  self.m_login_info = MSDKAuthInfo:New()
  self.m_client_info = MobileClientInfo:New()
  self.m_group_auth = GroupAuthInfo:New()
  self.m_is_international = false
end

function CEventRequestLoginVerify:Reliable()
  return false
end

CEventRequestLoginVerify._proto = {
  [1] = {"m_is_login", "bool"},
  [2] = {
    "m_login_info",
    "MSDKAuthInfo"
  },
  [3] = {
    "m_client_info",
    "MobileClientInfo"
  },
  [4] = {
    "m_group_auth",
    "GroupAuthInfo"
  },
  [5] = {
    "m_is_international",
    "bool"
  }
}
_class("CEventReplyLoginVerify", CCallReplyEvent)
CEventReplyLoginVerify = CEventReplyLoginVerify

function CEventReplyLoginVerify:Constructor()
  self.m_ret = 0
  self.m_server_time = 0
  self.m_version_status = ""
  self.m_update_type = 0
  self.info = MobileindulgeInfo:New()
  self.ban_info = idip_ban_msg:New()
end

function CEventReplyLoginVerify:Reliable()
  return false
end

CEventReplyLoginVerify._proto = {
  [1] = {"m_ret", "int"},
  [2] = {
    "m_server_time",
    "time"
  },
  [3] = {
    "m_version_status",
    "string"
  },
  [4] = {
    "m_update_type",
    "int"
  },
  [5] = {
    "info",
    "MobileindulgeInfo"
  },
  [6] = {
    "ban_info",
    "idip_ban_msg"
  }
}
_class("CEventCliPushLogout", CCliPushEvent)
CEventCliPushLogout = CEventCliPushLogout

function CEventCliPushLogout:Constructor()
end

CEventCliPushLogout._proto = {}
_class("CEventSvrPushLogout", CSvrPushEvent)
CEventSvrPushLogout = CEventSvrPushLogout

function CEventSvrPushLogout:Constructor()
  self.m_err = 0
  self.m_reason = ""
end

CEventSvrPushLogout._proto = {
  [1] = {"m_err", "int"},
  [2] = {"m_reason", "string"}
}
_class("CEventSvrPushNotification", CSvrPushEvent)
CEventSvrPushNotification = CEventSvrPushNotification

function CEventSvrPushNotification:Constructor()
  self.m_notification_type = 0
  self.m_hot_update_res_ver = ""
end

CEventSvrPushNotification._proto = {
  [1] = {
    "m_notification_type",
    "int"
  },
  [2] = {
    "m_hot_update_res_ver",
    "string"
  }
}
