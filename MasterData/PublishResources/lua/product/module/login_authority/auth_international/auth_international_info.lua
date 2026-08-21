if H3DGCloudLuaHelper.MsdkStatus ~= MSDKStatus.MS_International then
  return
end
_class("AuthInternationalResult", Object)
AuthInternationalResult = AuthInternationalResult
local retCodeDefine = INTL.INTLErrorCode

function AuthInternationalResult:Constructor()
  self.retCode = retCodeDefine.UNKNOWN
  self.channelID = MobileClientLoginChannel.MCLC_NONE
  self.openID = ""
  self.token = ""
end

function AuthInternationalResult:SyncAndFillResult(authRet)
  self.retCode = authRet.RetCode
  self.channelID = authRet.ChannelID
  self.openID = authRet.OpenId
  self.token = authRet.Token
end

function AuthInternationalResult:IsAuthSuccess()
  return self.retCode == retCodeDefine.SUCCESS
end

function AuthInternationalResult:MakeInvalid()
  self.retCode = retCodeDefine.UNKNOWN
end

function AuthInternationalResult:CopyFrom(srcRes)
  self.retCode = srcRes.retCode
  self.channelID = srcRes.channelID
  self.openID = srcRes.openID
  self.token = srcRes.token
end

function AuthInternationalResult:CloneSelf()
  local authRes = AuthInternationalResult:New()
  authRes:CopyFrom(self)
  return authRes
end

local AuthINTLCustomAccountType = {
  UNKNOWN = 0,
  REG_THEN_AUTH = 1,
  AUTH_WITH_PASS = 2,
  AUTH_WITH_VERIFYCODE = 3
}
_enum("AuthINTLCustomAccountType", AuthINTLCustomAccountType)
_class("AuthINTLCustomAccountInfo", Object)
AuthINTLCustomAccountInfo = AuthINTLCustomAccountInfo
local retCodeDefine = INTL.INTLErrorCode

function AuthINTLCustomAccountInfo:Constructor()
  self.authType = AuthINTLCustomAccountType.UNKNOWN
  self.account = "11111111111"
  self.password = "1"
  self.verifyCode = "12345"
  self.phoneAreaCode = "86"
  self.accountProfile = INTL.AccountProfile:New()
  self.accountProfile.UserName = "h3dcustomaccount"
  self.accountProfile.IsReceiveEmail = 1
  self.accountProfile.Region = 392
  self.extraJson = ""
end
