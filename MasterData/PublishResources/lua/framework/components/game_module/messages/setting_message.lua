require("message_def")
local settingMessageDef = {CLSID_CEventUpdateSetting = 25000, CLSID_CEventUpdateSettingResult = 25001}
table.append(MessageDef, settingMessageDef)
_class("CEventUpdateSetting", CCallRequestEvent)
CEventUpdateSetting = CEventUpdateSetting

function CEventUpdateSetting:Constructor()
  self.m_info = setting_info:New()
end

CEventUpdateSetting._proto = {
  [1] = {
    "m_info",
    "setting_info"
  }
}
_class("CEventUpdateSettingResult", CCallReplyEvent)
CEventUpdateSettingResult = CEventUpdateSettingResult

function CEventUpdateSettingResult:Constructor()
  self.m_ret = 0
end

CEventUpdateSettingResult._proto = {
  [1] = {"m_ret", "int"}
}
