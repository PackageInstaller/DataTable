require("message_def")
local gmMessageDef = {CLSID_CEventMobileGM_SendCMD = 7000, CLSID_CEventMobileGM_SendCMDResult = 7001}
table.append(MessageDef, gmMessageDef)
local GM_ProxyErrorCode = {GM_PROXY_SUCC = 0, GM_PROXY_UNKNOW = 1}
_enum("GM_ProxyErrorCode", GM_ProxyErrorCode)
_class("CEventMobileGM_SendCMD", CCallRequestEvent)
CEventMobileGM_SendCMD = CEventMobileGM_SendCMD

function CEventMobileGM_SendCMD:Constructor()
  self.gm_cmd = ""
end

CEventMobileGM_SendCMD._proto = {
  [1] = {"gm_cmd", "string"}
}
_class("CEventMobileGM_SendCMDResult", CCallReplyEvent)
CEventMobileGM_SendCMDResult = CEventMobileGM_SendCMDResult

function CEventMobileGM_SendCMDResult:Constructor()
  self.err_code = 0
  self.err_msg = ""
end

CEventMobileGM_SendCMDResult._proto = {
  [1] = {"err_code", "int"},
  [2] = {"err_msg", "string"}
}
