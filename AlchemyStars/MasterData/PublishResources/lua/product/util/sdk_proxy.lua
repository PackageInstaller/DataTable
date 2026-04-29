local GameVersionType = {
  INTL = "intl",
  USA = "usa",
  HMT = "hmt"
}
_enum("GameVersionType", GameVersionType)
_class("SDKProxy", Singleton)
SDKProxy = SDKProxy
local RuntimePlatform = UnityEngine.RuntimePlatform

function SDKProxy:GetStandardLangType()
  local type = Localization.GetCurLanguage()
  if LanguageType.zh == type then
    return "zh-Hans"
  elseif LanguageType.tw == type then
    return "zh-TW"
  elseif LanguageType.us == type then
    return "en"
  elseif LanguageType.kr == type then
    return "ko"
  elseif LanguageType.jp == type then
    return "ja"
  elseif LanguageType.pt == type then
    return "pt"
  elseif LanguageType.es == type then
    return "es"
  elseif LanguageType.idn == type then
    return "id"
  elseif LanguageType.th == type then
    return "th"
  else
    return "en"
  end
end

function SDKProxy:GetCustomerLangType()
  local type = Localization.GetCurLanguage()
  if LanguageType.zh == type then
    return "zh_CN"
  elseif LanguageType.tw == type then
    return "zh_TW"
  elseif LanguageType.us == type then
    return "en"
  elseif LanguageType.kr == type then
    return "ko"
  elseif LanguageType.jp == type then
    return "ja"
  elseif LanguageType.pt == type then
    return "pt"
  elseif LanguageType.es == type then
    return "es"
  elseif LanguageType.idn == type then
    return "id"
  elseif LanguageType.th == type then
    return "th"
  else
    return "en"
  end
end

function SDKProxy:GetIntlChannel(channelId)
  if channelId == MobileClientLoginChannel.MCLC_FACEBOOK then
    return INTL.INTLChannel.Facebook
  elseif channelId == MobileClientLoginChannel.MCLC_GOOGLE_PLAY then
    return INTL.INTLChannel.Google
  elseif channelId == MobileClientLoginChannel.MCLC_GUEST then
    return INTL.INTLChannel.Guest
  elseif channelId == MobileClientLoginChannel.MCLC_LINE then
    return INTL.INTLChannel.Line
  elseif channelId == MobileClientLoginChannel.MCLC_TWITTER then
    return INTL.INTLChannel.Twitter
  elseif channelId == MobileClientLoginChannel.MCLC_APPLE then
    return INTL.INTLChannel.Apple
  elseif channelId == MobileClientLoginChannel.MCLC_DMM then
    return INTL.INTLChannel.Dmm
  elseif channelId == EngineGameHelper.SAIchannelId() then
    return INTL.INTLChannel.IEGPassport
  else
    Log.fatal("[MSDK-INTL] 暂不支持该登录渠道：", channelId)
  end
  return nil
end

function SDKProxy:Constructor()
  self.universalLinked = false
end

function SDKProxy:IsInlandSDK()
  return H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_None
end

function SDKProxy:IsInternationalSDK()
  return H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International
end

function SDKProxy:IsEDITOR()
  if EDITOR or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_None then
    return true
  end
  return false
end

function SDKProxy:RegisterSDKModule(logic)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_None then
    logic:AddModule(LoginAuthorityModule, logic.CallCenter:GetCallerLua("game"))
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    logic:AddModule(AuthInternationalModule, logic.CallCenter:GetCallerLua("game"))
  end
end

function SDKProxy:ClearWakeup()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    GameGlobal.GetModule(LoginAuthorityModule):ClearWakeup()
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    Log.fatal("[SDKProxy] ClearWakeup no MS_International sdk")
  else
    Log.fatal("[SDKProxy] ClearWakeup no sdk")
  end
end

function SDKProxy:Logout()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    GameGlobal.GetModule(LoginAuthorityModule):Logout()
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International and not IsUnityEditor() then
    GameGlobal.GetModule(AuthInternationalModule):NotifyLogout()
  end
end

function SDKProxy:AddUrlParam(www)
  local mRole = GameGlobal.GetModule(RoleModule)
  local openId = GameGlobal.GameLogic():GetOpenId() or 0
  local userId = GameGlobal.GameLogic().msdkAuthorityInfo.user_id or 0
  local roleId = mRole:GetPstId() or 0
  local roleName = EngineGameHelper.UrlEncode(mRole:GetName()) or ""
  local areaId = GameGlobal.GameLogic():GetZoneID() or 0
  local platId = 0
  if IsAndroid() then
    platId = 1
  end
  local langType = SDKProxy:GetInstance():GetStandardLangType() or ""
  local url = www
  local l, q = string.find(url, "http://")
  local x, y = string.find(url, "https://")
  if l == nil and x == nil then
    url = "https://" .. url
  end
  local a, b = string.find(url, "?")
  if a == nil then
    url = url .. "?"
  else
    url = url .. "&"
  end
  url = url .. "openid=" .. openId .. "&role_id=" .. roleId .. "&role_name=" .. roleName .. "&area_id=" .. areaId .. "&zone_id=0&plat_id=" .. platId .. "&lang_type=" .. langType
  Log.debug("open url ", url)
  return url
end

function SDKProxy:ToLuaReflectionEnum(enum, field)
  require("tolua.reflection")
  tolua.loadassembly("Assembly-CSharp")
  local reflectionTest = typeof(enum)
  if not reflectionTest then
    return nil
  end
  local instance = tolua.createinstance(reflectionTest)
  local pubfield = tolua.getfield(reflectionTest, field)
  if not instance or not pubfield then
    return nil
  end
  local enum_value = pubfield:Get(instance)
  return enum_value
end

function SDKProxy:OpenUrl(url, withoutParam, extraJson)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    GCloud.MSDK.MSDKWebView.OpenUrl(url)
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    if not withoutParam then
      url = self:AddUrlParam(url)
    end
    if extraJson == nil then
      extraJson = "{}"
    end
    url = INTL.INTLAPI.GetEncryptUrl(url)
    local euao = self:ToLuaReflectionEnum("INTL.INTLWebViewOrientation", "Auto")
    INTL.INTLAPI.OpenUrl(url, euao, false, true, false, extraJson)
  else
    Log.fatal("[SDKProxy] OpenUrl no sdk")
  end
  Log.debug("[SDKProxy] OpenUrl:", url)
end

function SDKProxy:WebViewRetEvent(func, isAdd)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    if isAdd == true then
      GCloud.MSDK.MSDKWebView.WebViewRetEvent = GCloud.MSDK.MSDKWebView.WebViewRetEvent + func
    else
      GCloud.MSDK.MSDKWebView.WebViewRetEvent = GCloud.MSDK.MSDKWebView.WebViewRetEvent - func
    end
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    Log.debug("[SDKProxy] WebViewRetEvent no MS_International sdk")
  else
    Log.debug("[SDKProxy] WebViewRetEvent no sdk")
  end
end

function SDKProxy:NoticeRetEvent(func, isAdd)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    if isAdd == true then
      GCloud.MSDK.MSDKNotice.NoticeRetEvent = GCloud.MSDK.MSDKNotice.NoticeRetEvent + func
    else
      GCloud.MSDK.MSDKNotice.NoticeRetEvent = GCloud.MSDK.MSDKNotice.NoticeRetEvent - func
    end
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    if isAdd == true then
      INTL.INTLAPI.AddNoticeResultObserver(func)
      Log.debug("AddNoticeResultObserver MS_International sdk")
    else
      INTL.INTLAPI.RemoveNoticeResultObserver(func)
      Log.debug("RemoveNoticeResultObserver MS_International sdk")
    end
  else
    Log.fatal("[SDKProxy] NoticeRetEvent no sdk")
  end
end

function SDKProxy:SupportAppleId()
  if DeviceInfoHub.Platform == UnityEngine.RuntimePlatform.IPhonePlayer and DeviceInfoHub.OSVersion.Major >= 13 then
    return true
  end
end

function SDKProxy:ShowBtnWX()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    if GetPlatformOS() == ClientRuntimeOS.CRO_IOS then
      local isWXInstalled = GCloud.MSDK.MSDKTools.IsAppInstalled(GCloud.MSDK.MSDKChannel.WeChat)
      return isWXInstalled
    end
    return true
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    return false
  end
  return false
end

function SDKProxy:ShowBtnQQ()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return true
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    return false
  end
  return false
end

function SDKProxy:ShowBtnGuest()
  local isVerify = false
  local verifyBulletin = EngineGameHelper.GetVerifyBulletinInfo()
  if verifyBulletin ~= nil and verifyBulletin.host ~= "" and verifyBulletin.port > 0 then
    isVerify = true
  end
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    if GetPlatformOS() == ClientRuntimeOS.CRO_IOS and isVerify == true then
      return true
    end
    return false
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    if HelperProxy:GetInstance():GetConfig("ManualSelectServer", "false") == "true" then
      return true
    end
    if GetPlatformOS() == ClientRuntimeOS.CRO_IOS and isVerify == true then
      return true
    end
    return false
  end
  return false
end

function SDKProxy:ShowBtnFacebook()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return false
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    return false
  end
  return false
end

function SDKProxy:ShowBtnGoogle()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return false
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International and DeviceInfoHub.Platform == UnityEngine.RuntimePlatform.Android then
    return false
  end
  return false
end

function SDKProxy:ShowBtnApple()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return false
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International and self:SupportAppleId() then
    return false
  end
  return false
end

function SDKProxy:ShowBtnLine()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return false
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    return false
  end
  return false
end

function SDKProxy:ShowBtnTwitter()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return false
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    return false
  end
  return false
end

function SDKProxy:ShowBtnCusAcc()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return false
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    return true
  end
  return false
end

function SDKProxy:ShowBtnRegCus()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return false
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    return true
  end
  return false
end

function SDKProxy:InitAuthority()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_None then
    GameGlobal.GetModule(LoginAuthorityModule):InitLoginAuthorityInfo()
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    GameGlobal.GetModule(AuthInternationalModule):SyncAuthInfoToLogin()
  end
end

function SDKProxy:SetCustomAccountRetCB(retCB)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_None then
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    GameGlobal.GetModule(AuthInternationalModule):SetCustomAccountRetCallback(retCB)
  end
end

function SDKProxy:SetAuthRetCB(retCB)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_None then
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    GameGlobal.GetModule(AuthInternationalModule):SetAuthRetCallback(retCB)
  end
end

function SDKProxy:AutoAuthority()
  local loginModule = GameGlobal.GetModule(LoginModule)
  loginModule:SetLoginState(true)
  local issuc = false
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    local authModule = GameGlobal.GetModule(LoginAuthorityModule)
    local res, authorityResult = authModule:AutoLogin(TT)
    issuc = res:GetSucc()
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    local authModule = GameGlobal.GetModule(AuthInternationalModule)
    local authRes = authModule:AutoAuth(TT)
    issuc = authRes:IsAuthSuccess()
  end
  if issuc == true then
    self:InitAuthority()
    LocalDB.SetInt(LocalDBType.FirstLoginSucc, 1)
  end
  loginModule:SetLoginState(false)
  return issuc
end

function SDKProxy:LoginCallBack(authBC, logoutBC)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    local authModule = GameGlobal.GetModule(AuthInternationalModule)
    authModule:SetAuthRetCallback(authBC)
    authModule:SetLogoutRetCallback(logoutBC)
  end
end

function SDKProxy:Login(TT, loginChannel, customAuthInfo, noMessageBox)
  local loginModule = GameGlobal.GetModule(LoginModule)
  loginModule:SetLoginState(true)
  local tick = os.clock()
  local issuc = false
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_None then
    local res, authorityResult = GameGlobal.GetModule(LoginAuthorityModule):Login(TT, loginChannel)
    loginModule:SetLoginState(false)
    if res:GetSucc() then
      self:InitAuthority()
      issuc = true
    else
      issuc = false
      if authorityResult then
        local authRes = authorityResult.retCode
        if authRes == AuthorityRetCode.ARC_FAILED_USER_CANCLE then
          if loginChannel == MobileClientLoginChannel.MCLC_WX then
            PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_login_msdk_login_fail_title"), StringTable.Get("str_login_msdk_login_fail_cancle_wx_login"))
          else
            PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_login_msdk_login_fail_title"), StringTable.Get("str_login_msdk_login_fail_cancle_qq_login"))
          end
        elseif authRes == AuthorityRetCode.ARC_FAILED_QQ_NOT_INSTALL then
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_login_msdk_login_fail_title"), StringTable.Get("str_login_msdk_login_fail_qq_not_install"))
        elseif authRes == AuthorityRetCode.ARC_FAILED_WX_NOT_INSTALL then
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_login_msdk_login_fail_title"), StringTable.Get("str_login_msdk_login_fail_wx_not_install"))
        else
          ToastManager.ShowToast(StringTable.Get("str_login_msdk_login_fail"))
        end
      end
    end
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    if not IsUnityEditor() then
      local authRes
      if loginChannel == EngineGameHelper.SAIchannelId() then
        authRes = GameGlobal.GetModule(AuthInternationalModule):ManualAuthWithCustomAccount(TT, customAuthInfo)
      else
        authRes = GameGlobal.GetModule(AuthInternationalModule):ManualAuth(TT, loginChannel)
      end
      loginModule:SetLoginState(false)
      Log.debug("SDKProxy:Login waitetime:", os.clock() - tick)
      if authRes:IsAuthSuccess() then
        self:InitAuthority()
        issuc = true
      else
        issuc = false
        if noMessageBox == nil then
          if authRes.RetCode == INTL.INTLErrorCode.CANCEL then
            if loginChannel == MobileClientLoginChannel.MCLC_FACEBOOK then
              PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_login_msdk_login_fail_title"), StringTable.Get("str_login_msdk_intl_login_cancel_facebook"))
            elseif loginChannel == MobileClientLoginChannel.MCLC_GOOGLE_PLAY then
              PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_login_msdk_login_fail_title"), StringTable.Get("str_login_msdk_intl_login_cancel_google"))
            else
              Log.error("[SDKProxy] Login error  loginChannel:", loginChannel)
            end
          elseif authRes.RetCode == INTL.INTLErrorCode.NEED_INSTALL_APP then
            PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_login_msdk_login_fail_title"), StringTable.Get("str_login_msdk_intl_login_fail_not_install"))
          else
            PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_login_msdk_login_fail_title"), StringTable.Get("str_login_msdk_login_fail"))
            Log.error("[SDKProxy] Login error code:", authRes.RetCode)
          end
        end
      end
    else
      issuc = true
    end
  end
  if issuc then
    LocalDB.SetInt(LocalDBType.FirstLoginSucc, 1)
  end
  loginModule:SetLoginState(false)
  return issuc
end

function SDKProxy:ResetPasswordWithOldPassword(TT, account, oldPassword, phoneAreaCode, newPassword)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return nil
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    local authModule = GameGlobal.GetModule(AuthInternationalModule)
    return authModule:ResetPasswordWithOldPassword(TT, account, oldPassword, phoneAreaCode, newPassword)
  end
end

function SDKProxy:ResetPasswordWithVerifyCode(TT, account, verifyCode, phoneAreaCode, newPassword, extraJson)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return nil
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    local authModule = GameGlobal.GetModule(AuthInternationalModule)
    return authModule:ResetPasswordWithVerifyCode(TT, account, verifyCode, phoneAreaCode, newPassword, extraJson)
  end
end

function SDKProxy:IsAdult()
  return LoginLuaHelper.IsAdult()
end

function SDKProxy:IsEEA()
  return LoginLuaHelper.IsEEA()
end

function SDKProxy:CancleEEA()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    local openid = GameGlobal.GameLogic().msdkAuthorityInfo.open_id
    LocalDB.SetInt(LoginKeyName.EuAgree .. openid, 0)
    INTL.INTLAPI.ComplianceSetEUAgreeStatus(INTL.ComplianceAgreeStatus.Deny)
  end
end

function SDKProxy:CancelUserProto()
  LocalDB.SetInt(LoginKeyName.LoginUser, 0)
end

function SDKProxy:CancelPrivacyProto()
  LocalDB.SetInt(LoginKeyName.LoginPrivacy, 0)
end

function SDKProxy:EncodeSalt(_kf_params, _salt)
  local bytes = {}
  for i = 1, #_kf_params do
    local cur_unicode = string.byte(_kf_params, i) + _salt
    if 33 <= cur_unicode and cur_unicode <= 126 then
      bytes[i] = cur_unicode
    end
    if 126 < cur_unicode then
      bytes[i] = 32 + cur_unicode - 126
    end
    if cur_unicode < 33 then
      bytes[i] = 126 - (32 + cur_unicode)
    end
  end
  return bytes
end

function SDKProxy:DecodeSalt(_bytes)
  local result = ""
  for i = 1, #_bytes do
    local cur_str = string.char(_bytes[i])
    result = result .. cur_str
  end
  return result
end

function SDKProxy:UrlEncodeSalt(s)
  s = string.gsub(s, "([^%w%.%- ])", function(c)
    return string.format("%%%02X", string.byte(c))
  end)
  return string.gsub(s, " ", "+")
end

function SDKProxy:UrlDecodeSalt(s)
  s = string.gsub(s, "%%(%x%x)", function(h)
    return string.char(tonumber(h, 16))
  end)
  return s
end

function SDKProxy:GetAppGameID()
  require("tolua.reflection")
  tolua.loadassembly("Assembly-CSharp")
  local type = typeof("AppConfig")
  local instance = tolua.createinstance(type)
  local gameid_property = tolua.getproperty(type, "GameID")
  local GameID = gameid_property:Get(instance, nil)
  return GameID
end

function SDKProxy:LaunchCustomerUI(TT)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return nil
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    local url = "https://global.yzfchat.com/newgames/scene_product.html"
    local rm = GameGlobal.GetModule(RoleModule)
    local openid = tostring(GameGlobal.GameLogic().msdkAuthorityInfo.open_id)
    local uid = ""
    local intl_cluster = self:GetIntlCluster()
    local channelid = tostring(GameGlobal.GameLogic().ClientInfo.m_login_source)
    local area_id = tostring(GameGlobal.GameLogic():GetZoneID())
    local cn = ""
    local role = self:UrlEncodeSalt(rm:GetName())
    local kf_params = "openid=" .. openid .. "&intl_cluster=" .. intl_cluster .. "&uid=" .. uid .. "&channelid=" .. channelid .. "&area_id=" .. area_id .. "&cn=" .. cn .. "&role=" .. role
    local tm = os.time()
    local salt = tm % 10
    if salt <= 0 then
      salt = 1
    elseif 9 <= salt then
      salt = 8
    end
    local bytes = self:EncodeSalt(kf_params, salt)
    local str = self:DecodeSalt(bytes)
    local eStr = self:UrlEncodeSalt(str)
    Log.debug("url kf_params:", kf_params)
    local platId = "0"
    if IsAndroid() then
      platId = "1"
    elseif IsPc() then
      platId = "2"
    end
    local appid = ""
    if not IsPc() then
      appid = tostring(self:GetAppGameID())
    end
    local roleicon = ""
    local safe = "60"
    local lang_type = self:GetStandardLangType()
    local sCountry = "999"
    local lbs = LoginLuaHelper.GetLBSStateRegionInfo()
    if lbs ~= nil then
      sCountry = lbs.Numeric
    end
    url = url .. "?encryption=" .. eStr .. "&kftimestamp=" .. tm .. "&scene_id=1687767413404668&platid=" .. platId .. "&appid=" .. appid .. "&roleicon=" .. roleicon .. "&safe=" .. safe .. "&lang_type=" .. lang_type .. "&sCountry=" .. sCountry
    local exstr = "{\"notch_full_screen\":1}"
    Log.debug("url all:", url)
    self:OpenUrl(url, true, exstr)
  end
end

function SDKProxy:GetIntlCluster()
  if IsUnityEditor() then
    return ""
  end
  local gv = HelperProxy:GetInstance():GetGameVersion()
  local url
  if gv == GameVersionType.USA then
    url = "https://na.intlgame.com"
  else
    url = "https://sg.intlgame.com"
  end
  return string.trimend(Base64.Encode(url), "=")
end

function SDKProxy:LoadNoticeData(group, language, region, partition)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return GCloud.MSDK.MSDKNotice.LoadNoticeData(group, language, region, partition)
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    if IsUnityEditor() then
      return ""
    end
    Log.info("[SDKProxy] LoadNoticeData MS_International sdk")
    Log.info("region : ", region, "language : ", language)
    return INTL.INTLAPI.RequestNoticeData(tostring(region), language, "{}")
  end
  Log.fatal("[SDKProxy] LoadNoticeData no sdk")
  return ""
end

function SDKProxy:PushLocalTest()
  Log.error("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++", debug.traceback())
end

function SDKProxy:QueryUserInfo(TT)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return nil
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    if IsUnityEditor() then
      return nil
    end
    local authModule = GameGlobal.GetModule(AuthInternationalModule)
    return authModule:QueryUserInfo(TT)
  end
end

function SDKProxy:GetBindChannel(bindJson)
  local ccfg = EngineGameHelper.ChannelConfig()
  if ccfg == nil then
    return nil
  end
  local uilist = {}
  if GetPlatformOS() == ClientRuntimeOS.CRO_IOS then
    if ccfg.Apple_Facebook == true then
      uilist[MobileClientLoginChannel.MCLC_FACEBOOK] = true
    end
    if ccfg.Apple_Apple == true and self:SupportAppleId() == true then
      uilist[MobileClientLoginChannel.MCLC_APPLE] = true
    end
    if ccfg.Apple_Line == true then
      uilist[MobileClientLoginChannel.MCLC_LINE] = true
    end
    if ccfg.Apple_Twitter == true then
      uilist[MobileClientLoginChannel.MCLC_TWITTER] = true
    end
    if APPVER125 and ccfg.Apple_DMM == true then
      uilist[MobileClientLoginChannel.MCLC_DMM] = true
    end
    if ccfg.Apple_CustomAccount == true then
      uilist[EngineGameHelper.SAIchannelId()] = true
    end
  else
    if ccfg.Other_Facebook == true then
      uilist[MobileClientLoginChannel.MCLC_FACEBOOK] = true
    end
    if ccfg.Other_Google == true then
      uilist[MobileClientLoginChannel.MCLC_GOOGLE_PLAY] = true
    end
    if ccfg.Other_Line == true then
      uilist[MobileClientLoginChannel.MCLC_LINE] = true
    end
    if ccfg.Other_Twitter == true then
      uilist[MobileClientLoginChannel.MCLC_TWITTER] = true
    end
    if APPVER125 and ccfg.Other_DMM == true then
      uilist[MobileClientLoginChannel.MCLC_DMM] = true
    end
    if ccfg.Other_CustomAccount == true then
      uilist[EngineGameHelper.SAIchannelId()] = true
    end
  end
  uilist[GameGlobal.GameLogic().ClientInfo.m_login_source] = nil
  local clist = LoginLuaHelper.GetChannelByJson(bindJson)
  if clist.Count > 0 then
    for i = 0, clist.Count - 1 do
      local cid = clist[i]
      Log.debug("-------------------------cid", cid)
      uilist[cid] = nil
    end
  end
  return uilist
end

function SDKProxy:SerializeBindJson(account, password, verCode)
  local val = ""
  local accountType = INTL.INTLAPIUtils.GetAccountType(account)
  val = val .. "string," .. "account," .. account .. "|"
  val = val .. "int," .. "accountType," .. accountType .. "|"
  val = val .. "string," .. "phoneAreaCode," .. "|"
  val = val .. "string," .. "username," .. "|"
  val = val .. "string," .. "birthday," .. "|"
  val = val .. "string," .. "region," .. "|"
  val = val .. "string," .. "verifyCode," .. verCode .. "|"
  val = val .. "int," .. "isReceiveEmail,1" .. "|"
  val = val .. "string," .. "langType," .. "|"
  val = val .. "string," .. "type,loginWithCode"
  return LoginLuaHelper.GetJsonString(val)
end

function SDKProxy:BindChannel(TT, channel, extraJson)
  if channel == nil or channel == "" then
    return nil
  end
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return nil
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    local authModule = GameGlobal.GetModule(AuthInternationalModule)
    return authModule:BindChannel(TT, channel, extraJson)
  end
end

function SDKProxy:ResetGuest(TT)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return nil
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    local authModule = GameGlobal.GetModule(AuthInternationalModule)
    return authModule:ResetGuest(TT)
  end
end

function SDKProxy:RequestVerifyCode(TT, account, codeType, phoneAreaCode, extraJson)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return nil
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    local authModule = GameGlobal.GetModule(AuthInternationalModule)
    return authModule:RequestVerifyCode(TT, account, codeType, phoneAreaCode, extraJson)
  end
end

function SDKProxy:InitInternationalTssServerInfo()
  local CommQuery = 18
  local gv = HelperProxy:GetInstance():GetGameVersion()
  if gv == GameVersionType.INTL or gv == GameVersionType.HMT then
    local ip0 = "SetChannelBuiltinIp:0.0.0.0"
    GCloud.AnoSDK.AnoSDK.Ioctl(CommQuery, ip0)
    local ip1 = "SetChannelBuiltinIp:101.32.107.201"
    GCloud.AnoSDK.AnoSDK.Ioctl(CommQuery, ip1)
    local ip2 = "SetChannelBuiltinIp:101.32.107.230"
    GCloud.AnoSDK.AnoSDK.Ioctl(CommQuery, ip2)
    local host = "SetChannelHost:asia.csoversea.ace.iegcom.com"
    GCloud.AnoSDK.AnoSDK.Ioctl(CommQuery, host)
  else
    local ip0 = "SetChannelBuiltinIp:0.0.0.0"
    GCloud.AnoSDK.AnoSDK.Ioctl(CommQuery, ip0)
    local ip1 = "SetChannelBuiltinIp:20.83.81.41"
    GCloud.AnoSDK.AnoSDK.Ioctl(CommQuery, ip1)
    local ip2 = "SetChannelBuiltinIp:20.83.81.75"
    GCloud.AnoSDK.AnoSDK.Ioctl(CommQuery, ip2)
    local host = "SetChannelHost:us.mtp.iegcom.com"
    GCloud.AnoSDK.AnoSDK.Ioctl(CommQuery, host)
  end
end

function SDKProxy:GetUniversalLink()
  local paramsMap = {}
  if self.universalLinked then
    return paramsMap
  end
  self.universalLinked = true
  if APPVER130 == false then
    return paramsMap
  end
  local links = EngineGameHelper.GetActiveURL()
  if links ~= "" then
    local paramIndex = string.find(links, "?")
    if paramIndex ~= nil then
      local params = string.sub(links, paramIndex + 1) .. "&"
      for mstr in string.gmatch(params, "(.-)&") do
        if mstr ~= "" then
          local key, values = string.match(mstr, "(%w*)=(%w*)")
          if key ~= nil and values ~= nil then
            paramsMap[key] = values
          end
        end
      end
    end
  end
  return paramsMap
end

function SDKProxy:ClearUniversalLink()
  if APPVER130 == false then
    return
  end
  EngineGameHelper.ClearActiveURL()
end

function SDKProxy:GetStoreChannel()
  if PLATFORM == RuntimePlatform.IPhonePlayer or PLATFORM == RuntimePlatform.OSXPlayer then
    return StoreChannel.SC_APPSTORE
  elseif PLATFORM == RuntimePlatform.WindowsPlayer then
    return StoreChannel.SC_DMM
  elseif APPVER1142 then
    return INTL.INTLAPI.GetStoreChannel()
  else
    return StoreChannel.SC_GOOGLEPLAY
  end
end

function SDKProxy:OpenAccountCenter(UIRoot)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    Log.debug("[SDKProxy] OpenAccountCenter")
    INTL.LevelInfinite.LevelInfinite.SetUIRoot(UIRoot)
    INTL.LevelInfinite.LevelInfinite.OpenAccountCenter()
  end
end

function SDKProxy:SetBindRewardData()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    return nil
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    if HelperProxy:GetInstance():GetConfig("CloseSDKReward", "false") == "true" then
      Log.debug("[SDKProxy] SetBindRewardData Close!!!!!!!!!")
      return
    end
    local openId = GameGlobal.GameLogic():GetOpenId() or 0
    local areaId = GameGlobal.GameLogic():GetZoneID() or 0
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    local platId = 0
    if IsAndroid() then
      platId = 1
    end
    local exstr = "{\"area_id\":" .. areaId .. ",\"role_id\":\"" .. pstId .. "\"" .. ",\"openid\":\"" .. openId .. "\",\"plat_id\":" .. platId .. ",\"zone_id\":" .. areaId .. "}"
    Log.debug("[SDKProxy] SetBindRewardData:", exstr)
    INTL.INTLAPI.SetRewardExtraJson(exstr)
    INTL.INTLAPI.SendBindReward("110001", exstr)
  end
end
