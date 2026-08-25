local E = require("ejoysdk_lua.ejoysdk")
local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
local ejoysdk_init = require("ejoysdk_lua.ejoysdk_init")
local Version = require("Share.Version.version")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local SdkMgr, Super = System.NewClass("SdkMgr", Manager, IUpdater)
local publishRegion2GameLangMap = {
  CN = "zh-Hans",
  TW = "zh-Hant",
  EN = "en",
  KR = "ko"
}
ejoysdk_init.config(Utils.GetGamePlatform(), {})
local ES = require("ejoysdk_lua.survey.ejoysdk_survey")
local EF = require("ejoysdk_lua.friend.ejoysdk_friend")
local ELF = require("ejoysdk_lua.ejoysdk_log_file")
local ejoysdk_chat = require("ejoysdk_lua.chat.ejoysdk_chat")
local AGREE = require("ejoysdk_lua.agreement.ejoysdk_agreement")
local ELE = require("ejoysdk_lua.ejoysdk_launcher_ext")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EST = require("ejoysdk_lua.vendors.appsflyer")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local MD5 = require("ejoysdk_lua.libs.md5")
local FB = require("ejoysdk_lua.vendors.firebase")
local AM = require("ejoysdk_lua.age_mark.age_mark")
local ejoysdk = require("ejoysdk_lua.ejoysdk")
local SdkFuncListener = SdkConstDefine.SdkFuncListener
local SDK_LOG_EVENT = "Sdk Func {funcType}: {msg}"

local function ReportSdkLog(...)
  Logger.Info(SDK_LOG_EVENT, ...)
  Logger.ReportApusInfo(SDK_LOG_EVENT, ...)
end

local function IsOverSeaEnv()
  local EnvStr = Utils.GetGamePlatform()
  do return table.contains, (ApplicationUtils.get_oversea_platform_code()) end
  return table.contains, ApplicationUtils.get_oversea_platform_code(), EnvStr
end

function SdkMgr:ctor()
  Super.ctor(self)
  self:_InitSdkLogin()
  self._isInitSuccess = false
  self._acquireCallback = nil
  self._authCallback = nil
  self._setPlayerInfoCallback = nil
  self._logoutCallback = nil
  self._loginToken = nil
  self._rootEntity = Entity()
end

function SdkMgr:Awake(binder)
  Super.Awake(self)
  self.model = binder:createModel(SdkModel)
  self:InitAPUS()
  self:InitWPK()
  self:InitJfData()
  self:InitChat()
  self:InitPushMsg()
  self:InitNotice()
  self:InitShare()
  self:InitSdk(binder)
  print("IsSimulator===", SdkMgr.Instance:IsSimulator())
end

function SdkMgr:OnDestroy()
  Super.OnDestroy(self)
  if self._rootEntity then
    self._rootEntity:Destroy()
    self._rootEntity = nil
  end
end

function SdkMgr:Update(deltaTime)
  if not SdkMgr.Instance then
    return
  end
  E.tick()
  ejoysdk_chat.tick()
  if not SdkMgr.Instance or not SdkMgr.Instance:IsSdkLogin() then
    return
  end
  if self._rootEntity then
    self._rootEntity:Update(deltaTime)
  end
end

local function _CreateListener(binder, eventName)
  return function(...)
    ReportSdkLog("[Sdk_Add_Listener]", string.format("add listener eventName: %s", eventName))
    binder:emit(eventName, ...)
  end
end

function SdkMgr:DelegateEventOnce(eventName, func)
  ReportSdkLog("[Sdk_Delegate]", string.format("DelegateEventOnce, eventName:%s, func:%s", eventName, tostring(func)))
  if not eventName or "" == eventName or not func then
    return
  end
  self.binder:once(eventName, func)
  ReportSdkLog("[Sdk_Delegate]", string.format("DelegateEventOnce end, eventName:%s, func:%s", eventName, tostring(func)))
end

function SdkMgr:IsReview()
  return true
end

function SdkMgr:InitSdk(binder)
  local log_config = {is_console = false, is_save = true}
  local log_level, show_ejoysdk_log
  if ApplicationUtils.is_debug_mode() or Utils.__get_mode_from_debug_file() then
    log_level = E.LOG_LEVEL.debug
    show_ejoysdk_log = true
    log_config.is_console = true
  else
    log_level = E.LOG_LEVEL.info
    show_ejoysdk_log = false
  end
  E.set_log_level(log_level)
  E.LOG.enable_sdk_struct_log(show_ejoysdk_log)
  E.open_log_with_config(log_config)
  Logger.Info("SDK stdout日志已初始化, log_level=%s, enable_sdk_struct_log=%s, is_console=%s", log_level, show_ejoysdk_log, log_config.is_console)
  self:_SetGameVersion()
  local listeners = {
    acquire_listener = _CreateListener(binder, SdkFuncListener.AcquireListener),
    auth_listener = _CreateListener(binder, SdkFuncListener.AuthListener),
    logout_listener = System.fn(self, self.OnAccountLogout),
    pay_listener = System.fn(self, self._PayListener)
  }
  local vendors = {
    ALIGAMES = {},
    FIREBASE = {},
    APPSFLYER = {},
    JF = {
      white_privacy_fields = {
        "imei",
        "brand",
        "model",
        "mac",
        "country",
        "lang",
        "ramSize",
        " availRamSize",
        "hwf",
        "fr",
        "cpu"
      },
      open_pre_order = true
    }
  }
  if ApplicationUtils.IsWindows() then
    vendors.SECURITY = {open_check = true}
  end
  local push_handlers
  if CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.Android then
    vendors.PUSH = {}
    push_handlers = self._rootEntity:GetComponent(PushMsgComp):GetPushHandlers()
  end
  if self:IsXiao7() then
    E.CONFIG.set_config("pay_tags", {
      "usd_test_xiaoqi"
    })
  end
  
  local function GangplankInit()
    Logger.Info("====== 调用gangplank初始化")
    ejoysdk_init.gangplank(vendors, listeners).holo().launcher().chat(self.chat_listener).push(push_handlers).age().init()
  end
  
  ejoysdk_init.subscribe(ejoysdk_init.SUBSCRIBE_GANGPLANK_INITED, function(succ, ...)
    print("ejoysdk gangplank 初始化成功:", succ, debug.traceback())
    if succ then
      if SteamSdk.Instance:IsNativeSteamSdk() then
        local steamUserId = SteamSdk.Instance:GetSteamID()
        print("[steam]steam user id", steamUserId or nil, type(steamUserId))
        if steamUserId then
          local noone = require("ejoysdk_lua.vendors.noone")
          noone.set_uid(tostring(steamUserId))
        end
      end
      self._isInitSuccess = true
      self:GetMachineLevel()
      EventMgr.Instance.OnSdkInitSuccess:Dispatch()
      Logger.Info("EventMgr.Instance.OnSdkInitSuccess 事件派发完成")
      return
    end
    local msg = (...)
    Logger.Info("ejoysdk gangplank 初始化失败: ", msg)
    Logger.Info("====== 重新调用gangplank初始化")
    GangplankInit()
  end)
  GangplankInit()
  self:GetAgeMarkInfo()
  SdkMgr.Instance:GetNoticeEntranceRed("Normal", nil, nil, AnnouncementRedUtils.SetEntranceRed)
  ejoysdk_init.subscribe(ejoysdk_init.SUBSCRIBE_GANGPLANK_INITSTART, function(succ, ...)
    print("ejoysdk SUBSCRIBE_GANGPLANK_INITSTART初始化回调", succ, debug.traceback())
  end)
  ejoysdk_init.subscribe(ejoysdk_init.SUBSCRIBE_HOLO_INITED, function(succ, ...)
    print("ejoysdk SUBSCRIBE_HOLO_INITED初始化回调", succ, debug.traceback())
  end)
  ejoysdk_init.subscribe(ejoysdk_init.SUBSCRIBE_LAUNCHER_INITED, function(succ, ...)
    print("ejoysdk SUBSCRIBE_LAUNCHER_INITED初始化回调", succ, debug.traceback())
  end)
  ejoysdk_init.subscribe(ejoysdk_init.SUBSCRIBE_FRIEND_INITED, function(succ, ...)
    print("ejoysdk SUBSCRIBE_FRIEND_INITED初始化回调", succ, debug.traceback())
  end)
  ejoysdk_init.subscribe(ejoysdk_init.SUBSCRIBE_FAVOR_INITED, function(succ, ...)
    print("ejoysdk SUBSCRIBE_FAVOR_INITED初始化回调", succ, debug.traceback())
  end)
  ejoysdk_init.subscribe(ejoysdk_init.SUBSCRIBE_CHAT_INITED, function(succ, ...)
    print("ejoysdk SUBSCRIBE_CHAT_INITED初始化回调", succ, debug.traceback())
  end)
  ejoysdk_init.subscribe(ejoysdk_init.SUBSCRIBE_PUSH_INITED, function(succ, ...)
    print("ejoysdk SUBSCRIBE_PUSH_INITED初始化回调", succ, debug.traceback())
  end)
  ejoysdk_init.subscribe(ejoysdk_init.SUBSCRIBE_BLOCK_INITED, function(succ, ...)
    print("ejoysdk SUBSCRIBE_BLOCK_INITED初始化回调", succ, debug.traceback())
  end)
  ejoysdk_init.subscribe(ejoysdk_init.SUBSCRIBE_EJOYSDK_CONFIG_CHANGED, function(succ, ...)
    print("ejoysdk SUBSCRIBE_EJOYSDK_CONFIG_CHANGED初始化回调", succ, debug.traceback())
  end)
  ejoysdk_init.subscribe(ejoysdk_init.SUBSCRIBE_AGE_INITED, function(succ, ...)
    print("ejoysdk SUBSCRIBE_AGE_INITED初始化回调", succ, debug.traceback())
  end)
end

function SdkMgr:_InitSdkLogin()
  local LoginWay = CommonDefine.LoginWay
  local upper = string.upper
  local sdk_login = upper(ApplicationUtils.get_login_way()) == upper(LoginWay.UseSdk)
  if SteamSdk.Instance:IsNativeSteamSdk() then
    sdk_login = true
  elseif not ApplicationUtils.is_debug_mode() then
    sdk_login = true
  elseif ApplicationUtils.is_debug_mode() then
    local key = CommonDefine.LocalSaveKeyCommon.SDKLoginType
    local record = MobileFileDataManager.Instance:GetCommFileValue(key, sdk_login)
    if nil ~= record then
      sdk_login = record
    end
  end
  self._isSdkLogin = Vue.ref(sdk_login)
  ReportSdkLog("[Sdk_Ctor]", "Is sdk login  ->" .. tostring(sdk_login))
end

function SdkMgr:_SetGameVersion()
  local gameVersion = Utils.GetQZCurResVersion()
  ejoysdk.CONFIG.set_config("game_version", gameVersion)
end

function SdkMgr:SetSdkLogin(isDebug)
  if ApplicationUtils.is_debug_mode() then
    self._isSdkLogin.value = isDebug
  else
    self._isSdkLogin.value = true
  end
  Logger.Warn("=============SetSdkLogin", isDebug, self._isSdkLogin.value)
end

function SdkMgr:IsSdkLogin()
  return self._isSdkLogin.value
end

function SdkMgr:HasInitSuccess()
  return self._isInitSuccess
end

function SdkMgr:IsTestPay()
  if not self:IsSdkLogin() and ApplicationUtils.is_debug_mode() then
    return true
  end
end

function SdkMgr:IsXiao7()
  local pkg_info = E.get_pkg_info()
  local pkgName = pkg_info.pkg_name or ""
  do return string.contains, pkgName end
  return string.contains, pkgName, "com.qookkagames.z1.x7sy"
end

function SdkMgr:IsKrPackage()
  local pkg_info = E.get_pkg_info()
  local pkgName = pkg_info.pkg_name or ""
  return string.contains(pkgName, "com.qookkagames.z1.onestore") or string.contains(pkgName, "com.qookkagames.z1.samsung")
end

function SdkMgr:AcquireToken()
  Logger.Info("调用acquire_token, hasInit:", tostring(self:HasInitSuccess()), debug.traceback())
  if not self:HasInitSuccess() then
    return
  end
  gangplank.acquire_token()
  Logger.Info("调用acquire_token")
end

function SdkMgr:LoginWithToken(serverId, platformToken)
  if not self:HasInitSuccess() then
    return
  end
  if not (serverId and "" ~= serverId and platformToken) or "" == platformToken then
    return
  end
  gangplank.login_with_token(serverId, platformToken)
  Logger.Info("LoginWithToken to server:", serverId)
end

function SdkMgr:Logout()
  if not self:HasInitSuccess() then
    return
  end
  gangplank.logout()
end

function SdkMgr:SetAcquireCallback(cb)
  if cb then
    self._acquireCallback = cb
  end
end

function SdkMgr:SetAuthCallback(cb)
  if cb then
    self._authCallback = cb
  end
end

function SdkMgr:SetLogoutCallback(cb)
  self._logoutCallback = cb
end

function SdkMgr:_AcquireListener(succ, ...)
  local retData = {}
  if succ then
    local token, body = ...
    retData.body = body
    Logger.Info("login token: " .. token)
    print("login body: " .. table.tostring(body))
  else
    local code, message, body = ...
    retData.code = code
    retData.message = message
    if 421 == code then
      AGREE.show_agreement()
    end
    Logger.Info("code: " .. code .. " ,message: " .. message)
    print("body: " .. table.tostring(body))
    Alert.ShowStr("登录失败, Message:" .. message)
  end
  print("body.uid =" .. (retData.body and retData.body.uid or "nil") .. ";")
  if self._acquireCallback then
    self._acquireCallback(succ, retData)
  end
end

function SdkMgr:_AuthListener(succ, ...)
  if succ then
    local game_token, secret, pid = ...
    Logger.Info("gangplank login1 successed, game_token: " .. game_token)
    Logger.Info("gangplank login2 successed, pid " .. pid)
    Logger.Info("gangplank login3 successed, secret " .. secret)
    if self._authCallback then
      self._authCallback(game_token, pid)
    end
  else
    local code, message, body = ...
    Logger.Info("gangplank login failed, code: " .. code .. " ,message: " .. message)
    print("body: " .. table.tostring(body))
    Alert.ShowStr("登录游戏服失败, Message:" .. message)
  end
end

function SdkMgr:_LogoutListener()
  self.binder:emit(SdkFuncListener.Logout, true)
end

function SdkMgr:SetPlayerInfo(playerId, serverId, playerName, playerInfoType)
  if not self:IsSdkLogin() then
    Logger.Info("not SdkLogin pass SetPlayerInfo")
    return
  end
  local player_info = {
    player_id = tostring(playerId),
    player_name = playerName,
    server_id = serverId
  }
  if self:IsXiao7() then
    player_info.roleGuild = -1
    player_info.roleGuildId = -1
    player_info.roleCE = -1
  end
  Logger.Info("[set player info] playerId=%s, serverId=%s, playerName=%s, playerInfoType=%s", playerId, serverId, playerName, playerInfoType)
  print("[set player info] stack=", debug.traceback())
  gangplank.set_player_info(player_info, playerInfoType, function(success, ext)
    if success then
      Logger.Info("set_player_info success ")
      if self._setPlayerInfoCallback then
        self._setPlayerInfoCallback(success)
      end
    end
  end)
end

function SdkMgr:SetPlayerInfoCallback(cb)
  self._setPlayerInfoCallback = cb
end

function SdkMgr:GetPid()
  return self.model.pid
end

function SdkMgr:ShowPopUpWithConfig(config)
  print("[Sdk] 防沉迷服务器下发数据: ", table.tostring(config))
  local ejoysdk_popup_handler = require("ejoysdk_lua.realname.ejoysdk_popup_handler")
  ejoysdk_popup_handler.show_popup_with_config(config, function(succ)
    Logger.Info("[Sdk] 防沉迷弹出结果: ", succ)
  end)
end

function SdkMgr:OpenSdkAgeView()
  AM.open_age_mark_page(function(succ, ...)
    if succ then
      print("打开适龄说明页面 成功", table.tostring(...))
    else
      local code, msg = ...
      print("打开适龄说明页面 失败, code: " .. code .. " ,msg: " .. msg)
    end
  end)
end

function SdkMgr:GetAgeMarkInfo()
  AM.get_age_mark({}, function(succ, ...)
    if succ then
      Logger.Info("获取适龄说明数据 成功", table.tostring(...))
      local body = (...)
      local ageInfoText = StrUtils.UrlDecode(body.ageInfo.ageInfoText)
      self.model:SetTipAgeText(ageInfoText)
      self.model:SetTipAgeIconUrl(body.ageInfo.icon)
    else
      local code, msg = ...
      Logger.Info("获取适龄说明数据 失败, code: " .. code .. " ,msg: " .. msg)
    end
  end)
end

function SdkMgr:GetEnvInfo()
  local envInfo = {}
  local jfEnvInfo = self:GetJfEnvInfo()
  envInfo.devInfo = jfEnvInfo.devInfo
  if self:IsSdkLogin() then
    envInfo = jfEnvInfo
  end
  local svnAppVersion = Utils.GetQZCurResVersion()
  envInfo.clientVersion = svnAppVersion
  envInfo.version = Version()
  local isInUnityEditor = ApplicationUtils.is_editor_mode()
  if not svnAppVersion then
    if isInUnityEditor then
      envInfo.clientVersion = "UnityClient.1"
    else
      Logger.Warn("获取appSvn版本号失败:", svnAppVersion)
    end
  end
  local pkg_info = E.get_pkg_info()
  if pkg_info then
    envInfo.game_lang = pkg_info.game_lang
    envInfo.publish_area = pkg_info.publish_area
  end
  local curLang = DataCenter.gameData.CurrTextLanguage
  if curLang and publishRegion2GameLangMap[curLang] then
    envInfo.game_lang = publishRegion2GameLangMap[curLang]
  end
  local clientVersion = envInfo and envInfo.clientVersion or "nil"
  Logger.Debug("svnAppVersion:%s, envInfo.clientVersion:%s", svnAppVersion, clientVersion)
  local envInfoJsonStr = JSON.encode(envInfo)
  Logger.Debug("envInfoJsonStr:%s", envInfoJsonStr)
  return envInfoJsonStr
end

function SdkMgr:GetPkgInfo()
  do return end
  return E.get_pkg_info
end

function SdkMgr:IsSimulator()
  local pkg_info = E.get_pkg_info()
  if pkg_info then
    return pkg_info.is_simulator
  end
end

function SdkMgr:ResetCountryCode()
  local pkgInfo = self:GetPkgInfo()
  if pkgInfo and pkgInfo.country then
    SdkMgr.Instance.model:SetCountryCode(pkgInfo.country)
  end
end

function SdkMgr:GetChargeChannel()
  return self.model.packageChannel
end

function SdkMgr:GetServerDomain()
  local meta_data = E.CONFIG.get_config("unisdk_meta")
  local domain = meta_data[E.META_CONFIG_KEY.SERVER_DOMAIN] or E.CONFIG.get_domain()
  local pkgInfo = self:GetPkgInfo()
  local publish_area = pkgInfo and string.lower(pkgInfo.publish_area)
  if domain and "" ~= domain then
    if "tw" == publish_area then
      return "sialiagamesinc.com.tw"
    end
    if ".sialiagames.com.tw" == domain then
      return "sialiagamesinc.com.tw"
    end
    return domain
  end
  if "hk" == publish_area then
    return "qookkagames.com"
  elseif "tw" == publish_area then
    return "sialiagamesinc.com.tw"
  end
end

function SdkMgr:GetPublishArea()
  local pkgInfo = self:GetPkgInfo()
  local publish_area = pkgInfo and string.lower(pkgInfo.publish_area)
  return publish_area
end

function SdkMgr:GetServerList()
  Logger.Info("[Sdk] 请求服务器列表!")
  local params = {}
  ELE.get_server_info_list(params, function(succ, serverList, ...)
    Logger.Info("[Sdk] 请求服务器列表平台响应!", succ, table.tostring(serverList), ...)
    self.binder:emit(SdkFuncListener.GetServerList, succ, serverList, ...)
  end)
end

function SdkMgr:OverSeaCommitEvent(eventName)
  if not SdkMgr.Instance:IsSdkLogin() then
    return
  end
  local pkg_info = E.get_pkg_info()
  local utdId = pkg_info.utdid
  Logger.Info("OverSeaCommitEvent eventName " .. eventName .. "utdId" .. utdId .. "accountId" .. tostring(self.model.uid) .. "roleId" .. tostring(DataCenter.playerData.DRole.uid) .. "serverId" .. tostring(LoginMgr.Instance.model.serverId) .. "timeStamp" .. tostring(TimeUtils.GetServerTime()))
  FB.commit_event(eventName, {
    utdId = tostring(utdId),
    accountId = tostring(self.model.uid) or "",
    roleId = tostring(DataCenter.playerData.DRole.uid),
    serverId = tostring(LoginMgr.Instance.model.serverId),
    timeStamp = tostring(TimeUtils.GetServerTime())
  })
  EST.commit_event(eventName, {
    utdId = tostring(utdId),
    accountId = tostring(self.model.uid) or "",
    roleId = tostring(DataCenter.playerData.DRole.uid),
    serverId = tostring(LoginMgr.Instance.model.serverId),
    timeStamp = tostring(TimeUtils.GetServerTime())
  })
end

function SdkMgr:InitJfData()
  self._rootEntity:AddComponent(JfDataComp)
end

function SdkMgr:GetJfEnvInfo(encodeToJson)
  local envInfo = self._rootEntity:GetComponent(JfDataComp):GetJfEnvInfo()
  if encodeToJson then
    envInfo = JSON.encode(envInfo)
  end
  return envInfo
end

function SdkMgr:JfCommitEvent(eventName, params, options)
  if not SdkMgr.Instance:IsSdkLogin() then
    return
  end
  local sendParams = {
    accountId = tostring(self.model.uid) or "",
    roleId = tostring(DataCenter.playerData.DRole.uid),
    serverId = tostring(LoginMgr.Instance.model.serverId),
    roleLevel = tostring(DataCenter.playerData.DRole.level)
  }
  for key, value in pairs(params) do
    sendParams[key] = tostring(value)
  end
  local uuStr = ""
  for _, value in pairs(params) do
    uuStr = uuStr .. value
  end
  local logUuid = MD5.sumhexa(uuStr)
  sendParams.logUUID = tostring(logUuid)
  local sendOptions = options or {}
  Logger.Info("JfCommitEvent eventName " .. eventName .. " sendParams " .. table.tostring(sendParams) .. " sendOptions " .. table.tostring(sendOptions))
  self._rootEntity:GetComponent(JfDataComp):CommitEvent(eventName, sendParams, sendOptions)
end

function SdkMgr:InitAPUS()
  self._rootEntity:AddComponent(ApusComp)
end

function SdkMgr:InitWPK()
  self._rootEntity:AddComponent(WpkComp)
end

function SdkMgr:WPKCreateCustomLog(content, traceBack, type)
  self._rootEntity:GetComponent(WpkComp):CreateCustomLog(content, traceBack, type)
end

function SdkMgr:WPKAddHeaderInfo(key, value)
  self._rootEntity:GetComponent(WpkComp):AddHeaderInfo(key, value)
end

function SdkMgr:InitNotice()
  self._rootEntity:AddComponent(NoticeComp)
end

function SdkMgr:GetNotice(noticeType, tags, serverId, callback)
  local noticeComp = self._rootEntity:GetComponent(NoticeComp)
  noticeComp:GetNotice(noticeType, tags, serverId, callback)
end

function SdkMgr:GetNoticeEntranceRed(noticeType, tags, serverId, callback)
  local noticeComp = self._rootEntity:GetComponent(NoticeComp)
  noticeComp:GetEntranceRed(noticeType, tags, serverId, callback)
end

function SdkMgr:RemoveNoticeRed(noticeType, noticeUid, callback)
  local noticeComp = self._rootEntity:GetComponent(NoticeComp)
  noticeComp:ReadNotice(noticeType, noticeUid, callback)
end

function SdkMgr:InitShare()
  self._rootEntity:AddComponent(ShareComp)
end

function SdkMgr:GetShare()
  do return self._rootEntity.GetComponent, self._rootEntity end
  return self._rootEntity.GetComponent, self._rootEntity, ShareComp
end

function SdkMgr:InitPushMsg()
  if CS.UnityEngine.Application.platform ~= CS.UnityEngine.RuntimePlatform.Android then
    return
  end
  self._rootEntity:AddComponent(PushMsgComp)
end

function SdkMgr.ShowUserAgreement(page)
  if not SdkMgr.Instance:IsSdkLogin() then
    Alert.ShowWithParams(10237, {""})
    return
  end
  local channelId = tonumber(E.get_channel())
  Logger.Info("Cur channelId ", channelId)
  if channelId == CommonDefine.SdkChannelId.TapTap then
    local url = "https://www.taptap.cn/doc/privacy-policy/"
    ApplicationUtils.OpenURL(url)
  elseif page then
    AGREE.show_agreement("landscape", {page = page})
  else
    AGREE.show_agreement()
  end
end

function SdkMgr.Rating()
  Logger.Info("Rating!!")
  if not SdkMgr.Instance:IsSdkLogin() then
    Alert.ShowWithParams(10237, {""})
    return
  end
  if E.support_app_reviews() then
    E.app_reviews(function(ret)
      if ret and 1 == ret.code then
        Logger.Info("Open Success")
      else
        Logger.Info("Open Fail")
      end
    end)
  else
    Logger.Info("Rating Can't Use")
  end
end

function SdkMgr:CanRating()
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  do return end
  return E.support_app_reviews, "没有启用SDK,接口无效"
end

function SdkMgr.GetCustomerService()
  if ZoneFeatureUtils.IsZoneFeatureOpen(cd.ZoneFeature.GoogleCustomerUrl) then
    SdkMgr.GotoGoogleDoc()
    return
  end
  if not SdkMgr.Instance:IsSdkLogin() then
    Alert.ShowWithParams(10237, {""})
    return
  end
  local ESC = require("ejoysdk_lua.custom.ejoysdk_custom_service")
  local params = {orientation = "sensor"}
  ESC.show_custom_service(params, function(succ, ...)
    if succ then
      Logger.Info("显示客服成功")
    else
      local error_code, error_msg = ...
      Logger.Info("显示客服失败 error_code:" .. error_code .. "error_msg" .. table.tostring(error_msg))
    end
  end)
end

function SdkMgr.Report(typeId, desc, scene, playerId, content, extendData)
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  local API = require("ejoysdk_lua.server_api.ejoysdk_report_mailbox")
  local suspectInfo = {player_id = playerId}
  local contents = {
    [1] = {
      text = content,
      content_type = "text",
      extend_data = extendData
    }
  }
  API.report(typeId, desc, scene, suspectInfo, contents, function(succ, ...)
    Logger.Info("举报结果 result: " .. tostring(succ))
    if succ then
      local result = (...)
      Logger.Info("result", table.tostring(result))
    else
      local error_code, error_msg = ...
      E.log("error_code: " .. table.tostring(error_code) .. " ,error_msg: " .. table.tostring(error_msg))
      if 429 == error_code then
        Alert.ShowStr(LT.Text("ReportTimeLimited"))
      end
    end
  end)
end

function SdkMgr:GetReportType()
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  local API = require("ejoysdk_lua.server_api.ejoysdk_report_mailbox")
  API.get_report_types(function(succ, ...)
    E.log("获取举报类型 result: " .. tostring(succ))
    if succ then
      local result = (...)
      Logger.Debug("获取举报数据成功", table.tostring(result))
      self.model.SetReportData(result.report_types)
    else
      local error_code, error_msg = ...
      E.log("error_code: " .. tostring(error_code) .. " ,error_msg: " .. tostring(error_msg))
    end
  end)
end

function SdkMgr:GetOfficialWebsite()
  local pkg_info = E.get_pkg_info()
  local pkgName = pkg_info.pkg_name or ""
  do return require("Share.Version.version").GetOfficialWebsite end
  return require("Share.Version.version").GetOfficialWebsite, pkgName
end

function SdkMgr:OpenUserCenter()
  if not self:IsSdkLogin() then
    Alert.ShowWithParams(10237, {""})
    return
  end
  gangplank.open_user_center()
end

function SdkMgr:OnAccountLogout(isLogout)
  LoginMgr.Instance.model:ResetLoginTokens()
  UIManager.Instance:ClearAllSceneOpenUIQueue()
  if not SceneMgr.Instance:IsLoginScene() then
    SceneMgr.Instance:EnterLogin()
  end
end

function SdkMgr.GetPtid()
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  local ptid = E.get_ptid()
  if not ptid or "" == ptid then
    return nil
  end
  do return tonumber end
  return tonumber, ptid
end

function SdkMgr:ReqProductList()
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  local channel = IsOverSeaEnv() and "OFFICIAL" or "ALIGAMES"
  gangplank.get_product_list(channel, function(succ, ...)
    if succ then
      local product_list = (...)
      self.model.SetPayProducts(product_list)
      Logger.Info("get product success, data: " .. table.tostring(product_list))
    else
      local error_code = (...)
      Logger.Info("get product list fail, error code: " .. table.tostring(error_code))
    end
  end)
end

function SdkMgr:GetProductList()
  return self.model.payProducts
end

function SdkMgr:OpenChargePanel()
  if ZoneFeatureUtils.IsJPCBTTestThenAlert() then
    return
  end
  UIManager.Instance:Reopen(Urls.ChargeMainPanel)
end

function SdkMgr:Pay(productId, chargeTid, cb, onlyOnce)
  if SdkMgr.Instance:IsTestPay() then
    ProtoManager.Instance.GmRequest:OnGmCommandBySend("Recharge", {payId = chargeTid, amount = 1})
    if cb then
      cb(productId, chargeTid, true)
    end
    return
  end
  if not SdkMgr.Instance:IsSdkLogin() then
    Alert.ShowWithParams(10237, {""})
    return
  end
  if SteamSdk.Instance:IsSteam() and CS.SteamSdkSupprt and CS.SteamSdkSupprt.IsOverlayEnabled then
    local isOverlayEnabled = CS.SteamSdkSupprt.IsOverlayEnabled()
    if not isOverlayEnabled then
      Alert.Show("SteamOverlayEnabledTips")
      return
    end
  end
  local chargeCfg = DT.Charge[chargeTid]
  
  local function _DoPay()
    self:_DoPay(productId, chargeTid, cb, onlyOnce, chargeCfg)
  end
  
  if ChargeCfgUtils.CheckUsePlayCoin(chargeTid) then
    local costData = ChargeCfgUtils.GetPlayCoinCostData(chargeTid)
    local tipTypeId = 20098
    local desc = LT.Textf(DT.TipsType[tipTypeId].Desc, costData.num)
    Alert.SetMaskClickClose(true)
    Alert.SetShowCloseBtn(true)
    Alert.Show(tipTypeId, _DoPay, function()
      ProtoManager.Instance:ReqServer("GameRequest", "ChargeByItem", function(data)
        if cb then
          cb(productId, chargeTid, true)
        end
      end, nil, chargeTid)
    end, nil, desc)
    return
  end
  if ChargeCfgUtils.CheckUseVoucher(chargeTid) then
    local voucherData = ChargeCfgUtils.GetVoucherCostData(chargeTid)
    if voucherData then
      local data = {
        voucherData = voucherData,
        leftBtnFunc = _DoPay,
        rightBtnFunc = function()
          ProtoManager.Instance:ReqServer("GameRequest", "ChargeByItem", function(d)
            if cb then
              cb(productId, chargeTid, true)
            end
          end, nil, chargeTid)
        end
      }
      UIManager.Instance:Reopen(Urls.ChargeVoucherCostConfirmPanel, data)
      return
    end
  end
  _DoPay()
end

function SdkMgr:_DoPay(productId, chargeTid, cb, onlyOnce, chargeCfg)
  onlyOnce = onlyOnce or chargeCfg and (1 == chargeCfg.GroupLimit or 1 == chargeCfg.ActivityLimit)
  
  function self._payCallback(success)
    if cb then
      cb(productId, chargeTid, success)
    end
    if onlyOnce and self._onlyOnceChargeIds and not success then
      self._onlyOnceChargeIds[chargeTid] = nil
    end
  end
  
  local ext = {
    attach_params = tostring(chargeTid)
  }
  if onlyOnce then
    if self._onlyOnceChargeIds and self._onlyOnceChargeIds[chargeTid] then
      Alert.Show("InCharging")
      return
    end
    self._onlyOnceChargeIds = self._onlyOnceChargeIds or {}
    self._onlyOnceChargeIds[chargeTid] = true
  end
  
  function ext.pay_limit_age_cb(rules, input)
    UIManager.Instance:Reopen(Urls.AgeVerificationView, function(birthDayStr)
      input({area = "jp", birthday = birthDayStr})
    end)
  end
  
  ext.pay_limit_custom_err = true
  local channel = IsOverSeaEnv() and "OFFICIALPAY" or "ALIGAMES"
  self:OverSeaCommitEvent(CommonDefine.SdkCommitEventName.click_purchase)
  Logger.Info("Start Pay productId " .. productId .. " chargeTid " .. chargeTid .. " channel " .. channel)
  gangplank.pay(channel, productId, 1, ext)
end

function SdkMgr:_PayListener(isSuccess, order_id, ...)
  if isSuccess then
    local ext = (...)
    Logger.Info("------------ gangplank Pay Success ------------")
    Logger.Info("orderId:%s, ext:%s", order_id, table.tostring(ext))
  else
    local errorCode, msg, ext = ...
    Logger.Info("------------ gangplank Pay Failure ------------")
    Logger.Info("orderId:%s, errorCode:%s, msg:%s, ext:%s", order_id, errorCode, msg, table.tostring(ext))
  end
  if self._payCallback then
    self._payCallback(isSuccess)
    self._payCallback = nil
  end
end

function SdkMgr.OpenUrl(url)
  if not SdkMgr.Instance:IsSdkLogin() then
    Alert.ShowWithParams(10237, {""})
    return
  end
  E.Sysinfo.open_url(url)
end

function SdkMgr.DetectPermission(permission)
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  if not SdkMgr.PermissionSuppoertCheck() then
    return
  end
  E.Permission.detect_permission(permission, function(succ, resp)
    if not succ then
      local status = resp.status
      local show_rationale = resp.show_rationale
      Logger.Info("Permission Rationale ", show_rationale)
      if 0 == status then
        Logger.Info("Permission Fail or Refuse")
      elseif -1 == status then
        Logger.Info("Permission Refuse Forever")
      end
    else
      Logger.Info("Permission Success")
    end
  end)
end

function SdkMgr.ShowUsageDialog()
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  if not SdkMgr.PermissionSuppoertCheck() then
    return
  end
  local permissions_android = {
    ["android.permission.WRITE_EXTERNAL_STORAGE"] = {
      "写文件",
      "写入文件"
    },
    ["android.permission.CAMERA"] = {
      "相机",
      "使用相机"
    }
  }
  local permissions_ios = {
    NSCameraUsageDescription = {
      "相机",
      "用于扫码登录的场景"
    },
    NSPhotoLibraryUsageDescription = {
      "访问相册",
      "用于分享和扫码登录的场景"
    }
  }
  local permissions = permissions_android
  if E.Sysinfo.os() == "ios" then
    permissions = permissions_ios
  end
  local options = {
    style = "lingxi",
    buttons = {"确定"},
    permissions = permissions
  }
  E.Permission.show_usage_dialog(options, function()
    Logger.Info("Show Usage Dialog Success")
  end)
end

function SdkMgr.OpenPermissionSetting()
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  if not SdkMgr.PermissionSuppoertCheck() then
    return
  end
  E.Permission.openSetting()
end

function SdkMgr.CheckPermission(permission)
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  if not SdkMgr.PermissionSuppoertCheck() then
    return
  end
  E.Permission.check_permission_v2(permission, function(succ, _)
    if not succ then
      Logger.Info("Permission Fail")
    else
      Logger.Info("Permission Success")
    end
  end)
end

function SdkMgr.CheckPermissionUnification()
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  if not SdkMgr.PermissionSuppoertCheck() then
    return
  end
  local permissions_android = {
    ["android.permission.WRITE_EXTERNAL_STORAGE"] = {
      "权限名字",
      "权限的用途"
    },
    ["android.permission.CAMERA"] = {
      "权限名字2",
      "权限的用途"
    },
    notification = {
      "通知",
      "允许推送通知"
    }
  }
  local permissions_ios = {
    NSCameraUsageDescription = {
      "相机",
      "用于扫码登录的场景"
    },
    NSPhotoLibraryUsageDescription = {
      "访问相册",
      "用于分享和扫码登录的场景"
    },
    notification = {
      "通知",
      "允许推送通知"
    }
  }
  local permissions = permissions_android
  if E.Sysinfo.os() == "ios" then
    permissions = permissions_ios
  end
  local options = {permissions = permissions}
  E.Permission.check_permission_v3(options, function(succ)
    if not succ then
      Logger.Info("Permission Fail")
    else
      Logger.Info("Permission Success")
    end
  end)
end

function SdkMgr.ShowSettingDialog()
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  if not SdkMgr.PermissionSuppoertCheck() then
    return
  end
  local title = "权限设置"
  local permissions_android = {
    ["android.permission.WRITE_EXTERNAL_STORAGE"] = {
      "权限名字",
      "权限的用途"
    },
    ["android.permission.CAMERA"] = {
      "权限名字2",
      "权限的用途"
    },
    ["android.permission.READ_PHONE_STATE"] = {}
  }
  local permissions_ios = {
    NSCameraUsageDescription = {
      "相机",
      "用于扫码登录的场景"
    },
    NSPhotoLibraryUsageDescription = {
      "访问相册",
      "用于分享和扫码登录的场景"
    },
    NSMicrophoneUsageDescription = {
      "麦克风",
      "用于语音聊天的场景"
    },
    NSUserTrackingUsageDescription = {
      "广告标识符",
      "允许访问广告标识符(IDFA)"
    }
  }
  local permissions = permissions_android
  if E.Sysinfo.os() == "ios" then
    permissions = permissions_ios
  end
  local options = {style = "setting", permissions = permissions}
  E.Permission.setting_dialog(title, options)
end

function SdkMgr.PermissionSuppoertCheck()
  if E.Permission.support_compliance_check() then
    Logger.Info("Permission Can Support")
    return true
  end
  Logger.Info("Permission Can't Support")
  return false
end

function SdkMgr.ApplyFriend(playerId, applyContent, rType)
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  EF.add_friend_apply_v2(playerId, applyContent, rType, {}, function(succ, ...)
    if succ then
      print("提交添加申请 成功")
    else
      local code, message = ...
      print("提交添加申请 失败, code: " .. tostring(code) .. " ,msg: " .. message)
    end
  end)
end

function SdkMgr.GetFriendIdGroup(rType, extTbl)
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  local ext = extTbl or {}
  EF.get_friend_id_list(rType, ext, function(succ, ...)
    if succ then
      print("获取好友 id 列表 成功")
    else
      local code, msg = ...
      print("获取好友 id 列表 失败, code: " .. code .. " ,msg: " .. msg)
    end
  end)
end

function SdkMgr.GetFriendInfoGroup(playerIdGroup)
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  EF.get_friend_info_list_v2(playerIdGroup, function(succ, ...)
    if succ then
      print("获取玩家信息列表 成功")
      local player_list = (...)
      for _, player in pairs(player_list) do
      end
    else
      print("获取玩家信息列表 失败")
    end
  end)
end

function SdkMgr.GetFriendRoleInfoGroup(rType, extTbl)
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  local ext = extTbl or {}
  EF.get_my_friend_info_list_v2(rType, ext, function(succ, ...)
    if succ then
      print("获取好友玩家信息列表 成功")
      local player_list = (...)
      for _, player in pairs(player_list) do
      end
    else
      print("获取好友玩家信息列表 失败")
    end
  end)
end

function SdkMgr.GetFriendRequestGroup(stateTbl)
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  EF.get_friend_apply_list(stateTbl, function(succ, ...)
    if succ then
      print("获取发来的好友申请列表 成功")
      local apply_list = (...)
      for _, apply_info in pairs(apply_list) do
        Logger.Info("apply_info", table.tostring(apply_info))
      end
    else
      print("获取发来的好友申请列表 失败")
    end
  end)
end

function SdkMgr.GetFriendSendGroup(stateTbl)
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  EF.get_friend_to_apply_list(stateTbl, function(succ, ...)
    if succ then
      print("获取发出的申请列表 成功", ...)
    else
      print("获取发出的申请列表 失败")
    end
  end)
end

function SdkMgr.DeleteFriend(playerId, rType, extTbl)
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  local ext = extTbl or {}
  EF.del_friend_v2(playerId, rType, ext, function(succ, ...)
    if succ then
      print("删除好友 成功")
    else
      local code, message = ...
      print("删除好友 失败, code: " .. tostring(code) .. " ,msg: " .. message)
    end
  end)
end

function SdkMgr.AcceptFriendReq(playerId, rType, extTbl)
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  local ext = extTbl or {}
  EF.accept_friend_apply_v2(playerId, rType, ext, function(succ, ...)
    if succ then
      print("同意好友申请 成功")
    else
      local code, message = ...
      print("同意好友申请 失败, code: " .. code .. " ,msg: " .. message)
    end
  end)
end

function SdkMgr.RefuseFriendReq(playerId, rType, extTbl)
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  local ext = extTbl or {}
  EF.refuse_friend_apply_v2(playerId, rType, ext, function(succ, ...)
    if succ then
      print("拒绝好友申请 成功")
    else
      local code, message = ...
      print("拒绝好友申请 失败, code: " .. code .. " ,msg: " .. message)
    end
  end)
end

function SdkMgr.DeleteFriendReq(playerId, rType, extTbl)
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  local ext = extTbl or {}
  EF.del_friend_apply_v2(playerId, rType, ext, function(succ, ...)
    if succ then
      print("删除好友申请 成功")
    else
      local code, message = ...
      print("删除好友申请 失败, code: " .. code .. " ,msg: " .. message)
    end
  end)
end

function SdkMgr:InitChat()
  self.chat_listener = {}
  
  function self.chat_listener.on_login(succ, _)
    if succ then
      Logger.Info("聊天登录成功")
    else
      Logger.Info("聊天登录失败")
    end
  end
  
  function self.chat_listener.info_chat_msg(_)
  end
  
  function self.chat_listener.info_system_msg(msgs)
    EventMgr.Instance.ShowMarquee:Dispatch(msgs)
  end
  
  function self.chat_listener.info_friend_apply(_)
  end
  
  ET.subscribe(ET.friend.INITED, function(succ, _)
    if succ then
      print("-------friend init success-------")
    else
      print("-------friend init failure-------")
    end
  end)
end

function SdkMgr.UploadLog()
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return
  end
  Logger.Info("UploadLog")
  ELF.upload_all_logs(function(suc, ...)
    Logger.Info("Upload Result ", suc)
    if suc then
      local sucCount, finishCount = ...
      Logger.Info("Upload sucCount ", sucCount)
      Logger.Info("Upload finishCount ", finishCount)
    end
  end)
end

function SdkMgr:GetSurveyList(onResponse)
  ES.get_survey_list(function(succ, ...)
    print("[mail] get survey:", succ, table.tostring(...))
    if succ then
      local surveyList = (...)
      local filteredSurveyList = {}
      for _, survey in ipairs(surveyList) do
        if not self.model.finishSurveyMap[survey.resource_id] then
          table.insert(filteredSurveyList, survey)
        else
          Logger.Debug("问卷已经填过 " .. survey.name)
        end
      end
      Logger.Debug("获取问卷列表 成功 success" .. table.tostring(filteredSurveyList))
      if onResponse then
        onResponse(true, filteredSurveyList)
      end
    else
      local code, msg = ...
      if onResponse then
        onResponse(false)
      end
      Logger.Debug("获取问卷列 失败 success, code: " .. code .. " ,msg: " .. msg)
    end
  end)
end

function SdkMgr:ShowSurvey(surveyId, onCompleted)
  local screen_orientation = "landscape"
  if self.model:IsSurveyFinish(surveyId) then
    Alert.ShowStr("问卷已完成")
    return
  end
  ES.show_survey(surveyId, function(succ, ...)
    if succ then
      local succ_msg = (...)
      Logger.Debug("问卷 填写成功, " .. succ_msg)
      self.model:AddToFinishSurvey(surveyId)
      if onCompleted then
        onCompleted()
      end
    else
      local code, msg = ...
      Logger.Debug("问卷 填写失败, code: " .. code .. " ,msg: " .. msg)
    end
  end, screen_orientation)
end

function SdkMgr:GetMachineLevel()
  Logger.Info("get_device_score")
  EH.get_device_score(function(succ, info)
    if succ then
      Logger.Info("Machine Score", table.tostring(info))
      Logger.Info("Machine info.cpu", info.cpu)
      Logger.Info("Machine info.gpu", info.gpu)
      self.model:SetMachineCPUScore(info.cpu)
      self.model:SetMachineGPUScore(info.gpu)
    end
  end)
end

function SdkMgr.GetNotchInfo()
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("没有启用SDK,接口无效")
    return nil
  end
  do return end
  return E.Sysinfo.cutout, "没有启用SDK,接口无效"
end

function SdkMgr.MD5Sumhexa(str)
  if not SdkMgr.Instance:IsSdkLogin() then
    return ""
  end
  do return MD5.sumhexa end
  return MD5.sumhexa, str
end

function SdkMgr:SetGameLangByLangCode(langCode)
  local gameLang = publishRegion2GameLangMap[langCode]
  if gameLang then
    Logger.Info("ejoysdk.CONFIG.set_config('lang', gameLang) ", gameLang)
    ejoysdk.CONFIG.set_config("lang", gameLang)
  end
  Logger.Info("ejoysdk.CONFIG.set_config NewPkgInfo", table.tostring(self:GetPkgInfo()))
end

function SdkMgr:GetPackageName()
  Logger.Info("SdkMgr:GetPackageName()", E.Sysinfo.package_name())
  do return end
  return E.Sysinfo.package_name, "SdkMgr:GetPackageName()", E.Sysinfo.package_name()
end

function SdkMgr:OpenUserinfo(cb)
  Logger.Info("调用OpenUserinfo")
  gangplank.open_userinfo_completion(nil, function(succ)
    if cb then
      cb(succ)
    end
  end)
end

function SdkMgr:OpenBindPhoneOrEmail(cb)
  gangplank.open_userinfo_completion(nil, function(succ)
    if succ then
      Logger.Info("========== 绑定账号成功 ==========\n", succ)
      ProtoManager.Instance:ReqServer("SettingRequest", "ReqRefreshBindPhoneOrEmailState", function()
        Logger.Info("========== 刷新绑定状态成功 ==========\n")
        if cb then
          cb(succ)
        end
      end, function()
        Logger.Info("========== 刷新绑定状态失败 ==========\n")
      end)
    else
      Logger.Info("========== 绑定账号失败 ==========\n", succ)
    end
  end)
end

function SdkMgr:CheckIsGWPackage()
  local packageName = self:GetPackageName()
  if not packageName or type(packageName) ~= "string" then
    return false
  end
  do return string.find, packageName end
  return string.find, packageName, "gw"
end

function SdkMgr:GetCodeContent(code)
  local osType = DT.CommonID.PC.ID
  if ApplicationUtils.IsAndroid() then
    osType = DT.CommonID.Android.ID
  elseif ApplicationUtils.IsIOS() then
    osType = DT.CommonID.Apple.ID
  end
  local noOsTypeCfg
  for _, cfg in pairs(DT.SdkErrorCode) do
    if cfg.Code == code then
      if cfg.OSType == osType then
        if cfg.Content then
          return string.format("%s(%s)", LT.Text(cfg.Content), code)
        end
      elseif not cfg.OSType then
        noOsTypeCfg = cfg
      end
    end
  end
  if noOsTypeCfg and noOsTypeCfg.Content then
    do return string.format, "%s(%s)", (LT.Text(noOsTypeCfg.Content)) end
    return string.format, "%s(%s)", LT.Text(noOsTypeCfg.Content), code, nil, nil, cfg.OSType, string.format("%s(%s)", LT.Text(cfg.Content), code)
  end
  local tipsId = 10566
  local tipsCfg = DT.TipsType[tipsId]
  if tipsCfg and tipsCfg.Content then
    local content = DT.TipsType[tipsId].Content
    do return LT.Textf, content end
    return LT.Textf, content, code, cfg.OSType, string.format("%s(%s)", LT.Text(cfg.Content), code)
  end
end

return SdkMgr
