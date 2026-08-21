local AuthorityRetCode = {
  ARC_UNKNOWN = -1,
  ARC_SUCCESS = 0,
  ARC_FAILED = 1,
  ARC_FAILED_QQ_NOT_INSTALL = 2,
  ARC_FAILED_WX_NOT_INSTALL = 3,
  ARC_FAILED_USER_CANCLE = 4,
  ARC_FAILED_GUEST_PLATFORM_NOT_IOS = 5,
  ARC_FAILED_NOT_REAL_NAME = 6
}
_enum("AuthorityRetCode", AuthorityRetCode)
_class("LoginAuthorityResult", Object)
LoginAuthorityResult = LoginAuthorityResult
local MSDKChannel, MSDKError
if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
  MSDKChannel = GCloud.MSDK.MSDKChannel
  MSDKError = GCloud.MSDK.MSDKError
end

function LoginAuthorityResult:Constructor()
  self.retCode = AuthorityRetCode.ARC_UNKNOWN
  self.loginChannelID = MobileClientLoginChannel.MCLC_NONE
  self.openId = nil
  self.token = nil
end

function LoginAuthorityResult:Reset()
  self.retCode = AuthorityRetCode.ARC_UNKNOWN
  self.loginChannelID = MobileClientLoginChannel.MCLC_NONE
  self.openId = nil
  self.token = nil
end

function LoginAuthorityResult:Copy(src)
  self.retCode = src.retCode
  self.loginChannelID = src.loginChannelID
  self.openId = src.openId
  self.token = src.token
end

function LoginAuthorityResult:IsAuth()
  return self.retCode == AuthorityRetCode.ARC_SUCCESS
end

function LoginAuthorityResult:SetRetCode(loginRet)
  self.openId = ""
  self.token = ""
  local res = loginRet.RetCode
  if res == MSDKError.SUCCESS then
    Log.debug("[MSDK]LoginAuthorityResult:SetRetCode Success , channel=", loginRet.Channel, ",openid=", loginRet.OpenId)
    self.loginChannelID = loginRet.ChannelId
    self.retCode = AuthorityRetCode.ARC_SUCCESS
    self.openId = loginRet.OpenId
    self.token = loginRet.Token
    H3DGCloudLuaHelper.ReportEvent("login_auth_success", {
      retCode = self.retCode,
      retMsg = loginRet.RetMsg
    })
    return
  elseif res == MSDKError.NEED_REALNAME then
    self.loginChannelID = loginRet.ChannelId
    self.retCode = AuthorityRetCode.ARC_FAILED_NOT_REAL_NAME
  elseif res == MSDKError.CANCEL then
    self.loginChannelID = loginRet.ChannelId
    self.retCode = AuthorityRetCode.ARC_FAILED_USER_CANCLE
  elseif res == MSDKError.INITIALIZE_FAILED then
    self.loginChannelID = loginRet.ChannelId
    self.retCode = AuthorityRetCode.ARC_FAILED
  elseif res == MSDKError.NEED_INSTALL_APP then
    if self.loginChannelID == MobileClientLoginChannel.MCLC_WX then
      self.retCode = AuthorityRetCode.ARC_FAILED_WX_NOT_INSTALL
    elseif self.loginChannelID == MobileClientLoginChannel.MCLC_QQ then
      self.retCode = AuthorityRetCode.ARC_FAILED_QQ_NOT_INSTALL
    end
  else
    self.loginChannelID = loginRet.ChannelId
    self.retCode = AuthorityRetCode.ARC_FAILED
  end
  Log.error("[MSDK]LoginAuthorityResult:SetRetCode Fail, msdkRetCode=", res, ",self.retCode=", self.retCode, ",RetMsg=", loginRet.RetMsg)
  H3DGCloudLuaHelper.ReportEvent("login_auth_failed", {
    retCode = self.retCode,
    retMsg = loginRet.RetMsg
  })
end
