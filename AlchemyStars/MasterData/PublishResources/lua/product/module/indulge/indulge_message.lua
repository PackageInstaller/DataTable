require("message_def")
local indulgeMessageDef = {CLSID_CEventNotifyIndulgeState = 8000}
table.append(MessageDef, indulgeMessageDef)
_class("CEventNotifyIndulgeState", CSvrPushEvent)
CEventNotifyIndulgeState = CEventNotifyIndulgeState

function CEventNotifyIndulgeState:Constructor()
  self.info = MobileindulgeInfo:New()
end

CEventNotifyIndulgeState._proto = {
  [1] = {
    "info",
    "MobileindulgeInfo"
  }
}
