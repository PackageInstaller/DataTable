require("message_def")
local idipgameMessageDef = {CLSID_CEventNotifyIDIPBan = 28000, CLSID_CEventNotifyIDIPRelogin = 28001}
table.append(MessageDef, idipgameMessageDef)
_class("CEventNotifyIDIPBan", CSvrPushEvent)
CEventNotifyIDIPBan = CEventNotifyIDIPBan

function CEventNotifyIDIPBan:Constructor()
  self.info = idip_ban_msg:New()
end

CEventNotifyIDIPBan._proto = {
  [1] = {
    "info",
    "idip_ban_msg"
  }
}
_class("CEventNotifyIDIPRelogin", CSvrPushEvent)
CEventNotifyIDIPRelogin = CEventNotifyIDIPRelogin

function CEventNotifyIDIPRelogin:Constructor()
end

CEventNotifyIDIPRelogin._proto = {}
