_class("LoginWakeUpResult", Object)
LoginWakeUpResult = LoginWakeUpResult
local MSDKError
if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
  MSDKError = GCloud.MSDK.MSDKError
end

function LoginWakeUpResult:Constructor()
  self.wakeupChannel = nil
  self.retCode = MSDKError.INVALID
  self.openid = nil
end

function LoginWakeUpResult:Reset()
  self.wakeupChannel = nil
  self.retCode = MSDKError.INVALID
  self.openid = nil
end

function LoginWakeUpResult:CopyFromMsdk(src)
  if src then
    self.wakeupChannel = src.Channel
    self.retCode = src.RetCode
    self.openid = src.OpenId
  end
end
