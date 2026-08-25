local JSON = require("ejoysdk_lua.ejoysdk_json")
local LoginPVDataUtils = require("GameScript.Data.LoginPVDataUtils")
local LoginStep = LoginConstDefine.LoginStep
local SdkFuncListener = SdkConstDefine.SdkFuncListener
local LoginMgr, Super = System.NewClass("LoginMgr", Manager, IUpdater)

function LoginMgr:ctor()
  Super.ctor(self)
end

function LoginMgr:Awake(binder)
  Super.Awake(self)
  self.binder = binder
  self.model = binder:createModel(LoginModel)
end

local LOGIN_LOG_EVENT = "Login {step}: {msg}"

local function ReportStepLog(...)
  pcall(Logger.Info, LOGIN_LOG_EVENT, ...)
  pcall(Logger.ReportApusInfo, LOGIN_LOG_EVENT, ...)
end

local function AlertLoginErrorTips(_, code, _)
  code = tonumber(code) or 0
  if 10411 == code or 10532 == code then
    Alert.Show(10608)
  elseif 9990 == code or 413 == code or 10413 == code then
    UIManager.Instance:Reopen(Urls.KeyMaskView, LT.Text("WaitResponseTips"), 5, function()
      Alert.Show(10722)
    end)
  elseif table.contains({
    -1001,
    -1002,
    -1004,
    -1005,
    -1200
  }, code) then
    Alert.ShowWithParams(1056601, {code})
  elseif 7002015 == code then
    if SteamSdk.Instance:IsSteam() then
      Alert.Show("SteamRestartTips")
    end
  else
    local content = SdkMgr.Instance:GetCodeContent(code)
    if content then
      Alert.ShowStr(content)
    else
      Alert.ShowWithParams(10566, {code})
    end
  end
end

local function DisconnectCallback(loginFaild)
  if loginFaild then
    ErrorMsg.ShowErrCodeTipsByDisconnect()
  end
end

function LoginMgr:ResetAllData()
  self:_StopSeamlessReLoginTimer()
  StageFsmBeforeBattle.isSkipRecoverBattle = false
  WorldStageComp.isSkipRecoverWorldStage = false
  ResUpdateUtil.Instance:StopAutoCheckResUpdate()
  ExtensionMgr.Instance:ResetAllExtensions()
  PlayerDataUtils.RestAll()
  DBGMainCopyDataUtils.ResetAll()
  CardDataUtils.ResetAll()
  ItemDataUtils.ResetAll()
  RedPointDataUtils.ResetAll()
  TeamDataUtils.ResetAll()
  TownDataUtils.ResetAll()
  UIPopTipsDataUtils.ResetAll()
  AwakerDataUtils.ResetAll()
  MainShopDataUtils.ResetAll()
  DiamondShopDataUtils.ResetAll()
  MainInterfaceDataUtils.ResetAll()
  ShopDataUtils.ResetAll()
  RankModel.Instance:ResetAllRankData()
  ResonanceDataUtils.ResetAll()
  ActivityDataUtils.ResetAll()
  AlchemyDataUtils.ResetAll()
  BarrierDataUtils.ResetAll()
  BattlePassDataUtils.ResetData()
  DailyChallengeDataUtils.ResetAll()
  DailyDungeonUtils.ResetAll()
  DBGTeamDataUtils.ResetAll()
  MainCopyDataUtils.ResetAll()
  MapDataUtils.ResetAll()
  PlayerDataUtils.RestAll()
  PvPSettleDataUtils.Reset()
  PvPSeasonDataUtils.ClearOpenPvpCache()
  RelicDataUtils.ResetAll()
  SchoolTowerDataUtils.ResetAll()
  SocialDataUtils.ResetAll()
  FriendMatchMgr.Instance:ResetAll()
  StateDataUtils.Reset()
  TurntableDataUtils.Reset()
  TaskDataUtils.ResetAll()
  ClientDataUtils.ResetAll()
  AwakerChatDataUtils.ResetAll()
  StageExitPanelManager.Instance:Clear()
  PopupQueManager.Instance:Clear()
  NewbieGuideManager.Instance:ClearGuides()
  AttrUtils.InitAttrTypeMap()
  DBGMainCopyDataUtils.InitMainCopyData()
  PlayerDataUtils.InitFeatureUnlockData()
  PlayerDataUtils.ClearUnlockShowQueue()
  AwakerDataUtils.InitAwakerMap()
  SummonDataUtils.Init()
  IntroductionDataUtils.Init()
  MailDataUtils.Init()
  if ActivityManager and ActivityManager.Instance then
    ActivityManager.Instance:ResetData()
  end
  AvgStoryManager.Instance:Reset()
  NetBlockMgr.Instance:ClearBlockedMsgs()
  WaitingView.Instance:CancelAll()
end

function LoginMgr:_OnStepLoginPlatform(succ, ...)
  if succ then
    local token, body = ...
    self.model:SetPlatformToken(token)
    local pid = body.pinfo and body.pinfo.pid
    local uid = body.uid
    SdkMgr.Instance.model:SetPid(pid)
    SdkMgr.Instance.model:SetUid(uid)
    SdkMgr.Instance.model:SetUserInfoState(body.hasEmail, body.hasMobile)
    SdkMgr.Instance:GetNoticeEntranceRed("Normal", nil, nil, AnnouncementRedUtils.SetEntranceRed)
    ReportStepLog(LoginStep.StepLoginPlatform, string.format("_OnStepLoginPlatform success, body: %s", table.tostring(body)))
  else
    local code, message, body = ...
    AlertLoginErrorTips(LoginStep.StepLoginPlatform, code)
    local logMsg = string.format("ErrorCode: %s, Message: %s, body: %s", code, message, table.tostring(body))
    ReportStepLog(LoginStep.StepLoginPlatform, logMsg)
  end
end

function LoginMgr:_OnStepAuthPlatformServer(succ, ...)
  if succ then
    local gameToken, _, _ = ...
    self.model:SetGameToken(gameToken)
  else
    local code, message, body = ...
    if 401 == code then
      self.model:ResetPlatformToken()
      Alert.Show(10593)
    elseif 10415 == code then
      Alert.Show(10592)
    else
      AlertLoginErrorTips(LoginStep.StepAuthPlatformServer, code)
    end
    local logMsg = string.format("ErrorCode: %s, Message: %s, body: %s", code, message, table.tostring(body))
    ReportStepLog(LoginStep.StepAuthPlatformServer, logMsg)
  end
end

function LoginMgr:_AutoSetServer(succ, ...)
  if succ then
    local ret = (...)
    local serverList = ret.server_list
    local playerList = ret.players_list
    local chooseServerRet = self:_ChooseServer(playerList, serverList)
    if not chooseServerRet then
      Alert.Show(10608)
    end
    ReportStepLog(LoginStep.StepGetServerList, string.format("Set server result:%s", tostring(chooseServerRet)))
  else
    local code, message, body = ...
    local logMsg = string.format("ErrorCode: %s, Message: %s, body: %s", code, message, table.tostring(body))
    ReportStepLog(LoginStep.StepGetServerList, logMsg)
  end
end

function LoginMgr:_SetServerList(succ, ...)
  if succ then
    local ret = (...)
    local server_list = ret.server_list
    ReportStepLog(LoginStep.StepGetServerList, string.format("set serverlist succ:", table.tostring(server_list)))
    self.model:SetServerDataByResponse(server_list)
  else
    local code, message, body = ...
    AlertLoginErrorTips(LoginStep.StepGetServerList, code)
    local logMsg = string.format("ErrorCode: %s, Message: %s, body: %s", code, message, table.tostring(body))
    ReportStepLog(LoginStep.StepGetServerList, logMsg)
  end
end

function LoginMgr:_OnLoginSuccess(data, errCode)
  if not data then
    ErrorMsg.ShowErrCodeTips(errCode)
  end
  self.model:SetIsActorLogin(true)
  HandleLoginData(data)
  local loginUid = DataCenter.playerData.DRole and DataCenter.playerData.DRole.uid
  if loginUid and "" ~= loginUid then
    MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.LastLoginAccount, tostring(loginUid))
    MobileFileDataManager.Instance:OnSaveCommInfo()
  end
  if LoginPVDataUtils.deferredTryClearPlayedVideo then
    LoginPVDataUtils.TryClearAutoLoginPVAfterPlayed(LoginPVDataUtils.deferredTryClearPlayedVideo)
    LoginPVDataUtils.deferredTryClearPlayedVideo = nil
  end
  if not SdkMgr.Instance:IsSdkLogin() and data.playerProfile.serverId then
    local serverNode = data.playerProfile.serverId
    MobileFileDataManager.Instance:OnSaveCommInfo()
    self.model:SetGameServerNode(serverNode)
  end
  Logger.Info("#[LoginRequest] User用户ID:%s ServerId:%s", DataCenter.playerData.DRole.uid, data.playerProfile.serverId)
  ReconnectMgr.Instance:Enable()
  GameTimeEventManager.Instance:Enable()
  EventMgr.Instance.GameEvent:Dispatch(CommonDefine.GameEvent.EnterGame)
  self:_BindToSetPlayerInfo()
  AudioManager.Instance:PostSoundEvent("LOGIN")
  MobileFileDataManager.Instance:OpenPlayerFile(self.model.serverId, self:GetAccount())
  EventMgr.Instance.OnOpenPlayerLocalFile:Dispatch()
  GameEssentialDataRequestor.Instance:Start()
end

function LoginMgr:EnterGame()
  self:_StopSeamlessReLoginTimer()
  LoginStepTracker.Instance:Dispose()
  ResUpdateUtil.Instance:StartAutoCheckResUpdate()
  ReconnectMgr.Instance:SetCustomDoReconnectFunc(nil)
  local isRecovering = WorldRecoveryManager.Instance:OnRecovery()
  if WorldRecoveryManager.Instance:IsWaitingAbyssResetConfirm() then
    Logger.Info("[LoginMgr] EnterGame: abyss reset tips showing, skip EnterTown")
  elseif not isRecovering then
    if IntroductionDataUtils.IsFinish() then
      SceneMgr.Instance:EnterTown()
    else
      SceneMgr.Instance:EnterIntroduction({
        step = IntroductionDataUtils.GetStep()
      })
    end
  else
    GroupDownloadMgr.Instance:TryInGameDownload()
  end
end

function LoginMgr:_CheckUtdid(retData)
  if not retData or type(retData) ~= "table" or not retData.playerProfile then
    return false
  end
  local playerProfileData = retData.playerProfile
  if playerProfileData.misc then
    local lastUtdid = playerProfileData.misc.lastUtdid
    local envInfo = SdkMgr.Instance:GetJfEnvInfo()
    if envInfo.devInfo.utdid ~= lastUtdid then
      return false
    end
  end
  return true
end

function LoginMgr:_OnLoginSuccessSeamless(data, errCode)
  Logger.Info("_OnLoginSuccessSeamless", self.worldTid)
  if not data then
    ErrorMsg.ShowErrCodeTips(errCode)
  end
  self.model:SetIsActorLogin(true)
  HandleLoginData(data)
  local loginUidSeamless = DataCenter.playerData.DRole and DataCenter.playerData.DRole.uid
  if loginUidSeamless and "" ~= loginUidSeamless then
    MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.LastLoginAccount, tostring(loginUidSeamless))
    MobileFileDataManager.Instance:OnSaveCommInfo()
  end
  if LoginPVDataUtils.deferredTryClearPlayedVideo then
    LoginPVDataUtils.TryClearAutoLoginPVAfterPlayed(LoginPVDataUtils.deferredTryClearPlayedVideo)
    LoginPVDataUtils.deferredTryClearPlayedVideo = nil
  end
  GameEssentialDataRequestor.Instance:Start(true)
  if not SdkMgr.Instance:IsSdkLogin() and data.playerProfile.serverId then
    local serverNode = data.playerProfile.serverId
    MobileFileDataManager.Instance:OnSaveCommInfo()
    self.model:SetGameServerNode(serverNode)
  end
  self:_BindToSetPlayerInfo()
  local playerProfileData = data.playerProfile
  local baseServerData = playerProfileData.base
  if baseServerData.serverRestart then
    DataCenter.gameData.serverRestart = nil
    return false
  end
  WorldRecoveryManager.Instance.notHandleRecover = true
  local isRecovering = WorldRecoveryManager.Instance:OnRecovery(false)
  if WorldRecoveryManager.Instance:IsWaitingAbyssResetConfirm() then
    WorldRecoveryManager.Instance.notHandleRecover = false
    Logger.Info("[LoginMgr] _OnLoginSuccessSeamless: abyss reset tips showing, skip EnterTown")
  elseif not isRecovering then
    WorldRecoveryManager.Instance.notHandleRecover = false
    ResUpdateUtil.Instance:StartAutoCheckResUpdate()
    if IntroductionDataUtils.IsFinish() then
      SceneMgr.Instance:EnterTown()
    else
      SceneMgr.Instance:EnterIntroduction({
        step = IntroductionDataUtils.GetStep()
      })
    end
  else
    local tryRet = self:TryReqStartBattle()
    if not tryRet then
      Logger.Warn("[LoginMgr] _OnLoginSuccessSeamless: TryReqStartBattle failed, fallback to town")
      WorldRecoveryManager.Instance:ClearRecoverData(true)
      DataCenter.barrierData.InBattle = false
      SceneMgr.Instance:EnterTown()
    end
  end
  return true
end

function LoginMgr:TryReqStartBattle()
  if GroupDownloadMgr.Instance:TryInGameDownload() then
    return false
  end
  if WorldRecoveryManager.Instance:IsWaitingAbyssResetConfirm() or WorldRecoveryManager.Instance:IsStageExpiredByServer() then
    Logger.Info("[LoginMgr] TryReqStartBattle: abyss reset in progress, skip StartBattle")
    return true
  end
  WorldRecoveryManager.Instance.notHandleRecover = false
  if DataCenter.barrierData.InBattle then
    local recoverData = WorldRecoveryManager.Instance:GetRecoverData()
    if nil == recoverData then
      Logger.Info("[LoginMgr] TryReqStartBattle: no recoverData, skip recovery")
      return false
    end
    if nil == recoverData.gearTriggerData and AbyssDataUtils.IsAbyssStageTid(recoverData.copiesTid) and WorldRecoveryManager.Instance:IsStageExpiredByServer() then
      Logger.Info("[LoginMgr] TryReqStartBattle: abyss battle proxy lost, skip recovery and enter town")
      WorldRecoveryManager.Instance:ClearRecoverData(true)
      DataCenter.barrierData.InBattle = false
      SceneMgr.Instance:EnterTown()
      return true
    end
    local curBattleuUid = bg.battleRender:GetBattleuUid()
    local dataBattleuUid = recoverData.gearTriggerData and recoverData.gearTriggerData.data.battleUuid
    if dataBattleuUid and dataBattleuUid ~= curBattleuUid then
      Logger.Warn("_OnLoginSeamless battleUid not the same")
      return false
    end
  end
  local battleManager = BattleManager.Instance
  if battleManager.battleEngine and battleManager.battleSceneLoader and not battleManager.initMsgData and (not bg.battleDataCenter or not bg.battleDataCenter.isInit) and battleManager.isRunInServer and battleManager.battleEngine.StartBattle then
    BattleManager.Instance:ReqStartBattle()
  end
  return true
end

function LoginMgr:_OnLogout(succ)
  if succ then
    self.model:ResetPlatformToken()
    self.model:ResetGameToken()
  end
end

function LoginMgr:_RequestSdkFuncByCo(requestFunc, sdkFuncListener, ...)
  local result, waiting
  local co = coroutine.running()
  
  local function OnWakeUp(...)
    local ret = table.pack(...)
    local wakeUpLogStr = string.format("OnWakeUp, waiting:%s, co:%s, result:%s", waiting, tostring(co), table.tostring(ret))
    pcall(ReportStepLog, "OnWakeUp", wakeUpLogStr)
    if waiting then
      Coroutine.Resume(co, ret)
    else
      result = table.pack(ret)
    end
  end
  
  ReportStepLog("DelegateEvent", string.format("delegate callback, co:%s, result:%s", tostring(co), table.tostring(result)))
  SdkMgr.Instance:DelegateEventOnce(sdkFuncListener, OnWakeUp)
  requestFunc(...)
  ReportStepLog("RequestSdkFunc_End", string.format("request sdk func, co:%s, result:%s", tostring(co), table.tostring(result)))
  if result then
    do return table.unpack end
    return table.unpack, result, string.format("request sdk func, co:%s, result:%s", tostring(co), table.tostring(result))
  end
  ReportStepLog("ReadyToYeild", string.format("request sdk func, co:%s", tostring(co)))
  waiting = true
  do return end
  return Coroutine.Yield, "ReadyToYeild", string.format("request sdk func, co:%s", tostring(co))
end

function LoginMgr:_LoginPlatform()
  if not SdkMgr.Instance:HasInitSuccess() then
    ReportStepLog(LoginStep.StepCheckSdkInit, "SDK未初始化成功")
    return
  end
  if SteamSdk.Instance:IsNativeSteamSdk() and not SteamSdk.Instance:GetSteamID() then
    Alert.Show(10620)
    return
  end
  local sdkFunc = System.fn(SdkMgr.Instance, SdkMgr.Instance.AcquireToken)
  local result = self:_RequestSdkFuncByCo(sdkFunc, SdkFuncListener.AcquireListener)
  self:_OnStepLoginPlatform(table.unpack(result))
  local succ = result and result[1]
  return succ
end

function LoginMgr:AcquireToken()
  local sdkFunc = System.fn(SdkMgr.Instance, SdkMgr.Instance.AcquireToken)
  local result = self:_RequestSdkFuncByCo(sdkFunc, SdkFuncListener.AcquireListener)
  self:_OnStepLoginPlatform(table.unpack(result))
end

function LoginMgr:_AuthPlatformServer()
  if not self.model.platformToken or self.model.platformToken == "" then
    ReportStepLog(LoginStep.StepAuthPlatformServer, "平台token值为空")
    return
  end
  if not self.model.serverId or "" == self.model.serverId then
    ReportStepLog(LoginStep.StepAuthPlatformServer, "serverId为空")
    return
  end
  local serverId = self.model.serverId
  local platformToken = self.model.platformToken
  local sdkFunc = System.fn(SdkMgr.Instance, SdkMgr.Instance.LoginWithToken)
  local result = self:_RequestSdkFuncByCo(sdkFunc, SdkFuncListener.AuthListener, serverId, platformToken)
  self:_OnStepAuthPlatformServer(table.unpack(result))
  local succ = result and result[1]
  return succ
end

function LoginMgr:_GetServerList(autoSetServerId)
  if not SdkMgr.Instance:HasInitSuccess() then
    ReportStepLog(LoginStep.StepGetServerList, "SDK未初始化成功")
    return
  end
  local sdkFunc = System.fn(SdkMgr.Instance, SdkMgr.Instance.GetServerList)
  local result = self:_RequestSdkFuncByCo(sdkFunc, SdkFuncListener.GetServerList)
  local succ = result and result[1]
  self:_SetServerList(table.unpack(result))
  if autoSetServerId then
    self:_AutoSetServer(table.unpack(result))
  end
  return succ
end

local CheckSdkInitMaxCount = 30
local CheckSdkInitWaitTime = 1

function LoginMgr:_CheckSdkInit()
  local checkCount = 0
  while not SdkMgr.Instance:HasInitSuccess() do
    checkCount = checkCount + 1
    Logger.Info("[Sdk] LoginMgr 第%s次, 检测Sdk初始化失败, %s秒后重试", checkCount, CheckSdkInitWaitTime)
    if checkCount > CheckSdkInitMaxCount then
      return false
    end
    TaskMgr.Instance:WaitForUpdate()
  end
  return true
end

function LoginMgr:_PreLogin()
  Logger.Info("[PreLogin] PreLogin 开始检查Sdk初始化")
  WaitingView.Instance:Show(self, WaitingView.Flag_Logining)
  if not self:_CheckSdkInit() then
    WaitingView.Instance:Hide(self, WaitingView.Flag_Logining)
    ReportStepLog(LoginStep.StepCheckSdkInit, "[PreLogin] SDK尚未初始化")
    return
  end
  Logger.Info("[PreLogin] PreLogin 开始获取服务器列表")
  if not self:_GetServerList(true) then
    WaitingView.Instance:Hide(self, WaitingView.Flag_Logining)
    return
  end
  if not SdkMgr.Instance:IsSdkLogin() then
    WaitingView.Instance:Hide(self, WaitingView.Flag_Logining)
    local account = self.model:GetLocalCacheAccount()
    Logger.Info("[PreLogin] PreLogin 开始设置开发期缓存账号")
    self.model:SetAccount(account)
    return
  end
  Logger.Info("[PreLogin] PreLogin 开始登录平台账号")
  self:_LoginPlatform()
  WaitingView.Instance:Hide(self, WaitingView.Flag_Logining)
end

function LoginMgr:ReqGetServerList()
  TaskMgr.Instance.Fork(function()
    self:_GetServerList()
  end)
end

function LoginMgr:PreLogin()
  TaskMgr.Instance.Fork(function()
    self:_PreLogin()
  end)
end

function LoginMgr:_DebugLogin()
  TaskMgr.Instance.Fork(function()
    self.model:ResetIsLogin()
    if not self:HasServerList() and SdkMgr.Instance:IsSdkLogin() then
      Logger.Info("[DebugLogin] Login 开始获取服务器列表(没有服务器列表数据)")
      if not self:_GetServerList(true) then
        EventMgr.Instance.LoginErrorEvent:Dispatch()
        return
      end
    end
    if not self.model.serverId then
      Alert.Show(10568)
      EventMgr.Instance.LoginErrorEvent:Dispatch()
      return
    end
    if SdkMgr.Instance:IsSdkLogin() then
      if not self.model.isPlatformLogin then
        Logger.Info("[DebugLogin] Login 开始登录平台账号(找不到platformToken)")
        EventMgr.Instance.LoginErrorEvent:Dispatch()
        self:_LoginPlatform()
        return
      end
      Logger.Info("[DebugLogin] Login 开始申请游戏服gameToken")
      if not self:_AuthPlatformServer() then
        EventMgr.Instance.LoginErrorEvent:Dispatch()
        return
      end
    end
    NetworkMgr.Instance:Close()
    DataCenter.gameData.IsReplaceRole = false
    WorldRecoveryManager.Instance:ClearRecoverData(true)
    Logger.Info("[DebugLogin] Login 开始连接游戏服务器")
    local ret, conn = self:_ConnectServer()
    if not ret then
      EventMgr.Instance.LoginErrorEvent:Dispatch()
      return ret, conn
    end
    if not SdkMgr.Instance:IsSdkLogin() then
      Logger.Info("[DebugLogin] Login 开始非SDK登录时生成gameToken")
      local success, genRet = ProtoManager.Instance.LoginRequest:GenToken(conn, self.model.account)
      if not success then
        DisconnectCallback(true)
        EventMgr.Instance.LoginErrorEvent:Dispatch()
        return false, genRet and genRet.code or 0
      end
      self.model:SetGameToken(genRet.token)
    end
    Logger.Info("[DebugLogin] Login 开始登录游戏服")
    local success, retData, code = self:_LoginServer(conn, self.model.gameToken)
    if success and retData then
      self:_OnLoginSuccess(retData, code)
    else
      EventMgr.Instance.LoginErrorEvent:Dispatch()
    end
  end)
end

function LoginMgr:StartLogin(account)
  print("StartLogin IsSdkLogin", SdkMgr.Instance:IsSdkLogin())
  Utils:CheckResUpdate(function(succ, has_update)
    ReconnectMgr.Instance:Disable()
    ReportStepLog(LoginStep.StepCheckRes, string.format("CheckResUpdate End, succ:%s, has_update:%s", tostring(succ), tostring(has_update)))
    if succ and has_update then
      ResUpdateUtil.Instance.existResNeedUpdate = true
      ResUpdateUtil.Instance:TryPopResUpdateDialog()
      return
    end
    if SdkMgr.Instance:IsSdkLogin() then
      self:_Login()
    else
      self.model:SetAccount(account)
      local serverId = LoginMgr.Instance.model.serverId
      MobileFileDataManager.Instance:SetCommFileValue(CommonDefine.LocalSaveKeyCommon.ServerId, serverId)
      MobileFileDataManager.Instance:SetCommFileValue(CommonDefine.LocalSaveKeyCommon.Account, account)
      MobileFileDataManager.Instance:OnSaveCommInfo()
      local isAccountEmpty = not account or "" == account
      if isAccountEmpty then
        Alert.Show(10570)
        return
      end
      self:_DebugLogin()
    end
  end)
end

function LoginMgr:SeamlessReLogin(callback)
  self:_StopSeamlessReLoginTimer()
  ReconnectMgr.Instance:Disable()
  GameEssentialDataRequestor.Instance:Stop()
  PlayerDataRequestor.Instance:Stop()
  RpcMgr.Instance:Close()
  DataCenter.playerData.netDelayTime = 0
  local ReconnectRet = ReconnectDefine.Ret
  
  local function successCall()
    self:_StopSeamlessReLoginTimer()
    ReconnectMgr.Instance:Enable()
    callback(ReconnectRet.LoginSuccess)
    GlobalDispatcher:Dispatch(NotifyId.OnSeamlessReconnect)
    EventMgr.Instance.OnSeamlessReconnect:Dispatch()
  end
  
  local function failCall()
    self:_StopSeamlessReLoginTimer()
    callback(ReconnectRet.ReturnLogin)
  end
  
  self._seamlessReLoginTimer = TimerManager.Instance:CreateTimer(10, 0, nil, failCall)
  if SdkMgr.Instance:IsSdkLogin() then
    self:_SeamlessLogin(successCall, failCall)
  else
    self:_SeamlessDebugLogin(successCall, failCall)
  end
end

function LoginMgr:_StopSeamlessReLoginTimer()
  if self._seamlessReLoginTimer then
    TimerManager.Instance:StopTimer(self._seamlessReLoginTimer)
    self._seamlessReLoginTimer = nil
  end
end

function LoginMgr:_SeamlessLogin(loginSuccessCallBack, failCallBack)
  TaskMgr.Instance.Fork(function()
    local result = false
    
    local function tempCall()
      self.model:ResetIsLogin()
      if not self:HasServerList() or not self.model.serverId then
        Logger.Info("[Login] Login 开始获取服务器列表(没有服务器列表数据)")
        if not self:_GetServerList(true) then
          return
        end
      end
      if not self.model.isPlatformLogin then
        Logger.Info("[Login] Login 开始登录平台账号(找不到platformToken)")
        local ret = self:_LoginPlatform()
        Logger.Info("[Login] try acquire_token ret:", ret)
        return
      end
      Logger.Info("[Login] Login 开始申请游戏服gameToken")
      if not self:_AuthPlatformServer() then
        return
      end
      NetworkMgr.Instance:Close()
      DataCenter.gameData.IsReplaceRole = false
      WorldRecoveryManager.Instance:ClearRecoverData(true)
      Logger.Info("[Login] Login 开始连接游戏服务器")
      local notShowPop = true
      local ret, conn = self:_ConnectServer(notShowPop)
      if not ret then
        return ret, conn
      end
      Logger.Info("[Login] Login 开始登录游戏服")
      local success, retData, code = self:_LoginServer(conn, self.model.gameToken)
      Logger.Info("[Login] Login 登录游戏服结果:", success)
      if false == self:_CheckUtdid(retData) then
        success = false
      end
      if success and retData then
        result = self:_OnLoginSuccessSeamless(retData, code)
      end
    end
    
    local ret = pcall(tempCall)
    if ret and result then
      loginSuccessCallBack()
    else
      failCallBack()
    end
  end)
end

function LoginMgr:_SeamlessDebugLogin(loginSuccessCallBack, failCallBack)
  TaskMgr.Instance.Fork(function()
    local result = false
    
    local function tempCall()
      self.model:ResetIsLogin()
      if not self:HasServerList() and SdkMgr.Instance:IsSdkLogin() then
        Logger.Info("[DebugLogin] Login 开始获取服务器列表(没有服务器列表数据)")
        if not self:_GetServerList(true) then
          return
        end
      end
      if not self.model.serverId then
        return
      end
      if SdkMgr.Instance:IsSdkLogin() then
        if not self.model.isPlatformLogin then
          Logger.Info("[DebugLogin] Login 开始登录平台账号(找不到platformToken)")
          self:_LoginPlatform()
          return
        end
        Logger.Info("[DebugLogin] Login 开始申请游戏服gameToken")
        if not self:_AuthPlatformServer() then
          return
        end
      end
      NetworkMgr.Instance:Close()
      DataCenter.gameData.IsReplaceRole = false
      WorldRecoveryManager.Instance:ClearRecoverData(true)
      Logger.Info("[DebugLogin] Login 开始连接游戏服务器")
      local notShowPop = true
      local ret, conn = self:_ConnectServer(notShowPop)
      if not ret then
        return ret, conn
      end
      if not SdkMgr.Instance:IsSdkLogin() then
        Logger.Info("[DebugLogin] Login 开始非SDK登录时生成gameToken")
        local success, genRet = ProtoManager.Instance.LoginRequest:GenToken(conn, self.model.account)
        if not success then
          DisconnectCallback(true)
          return false, genRet and genRet.code or 0
        end
        self.model:SetGameToken(genRet.token)
      end
      Logger.Info("[DebugLogin] Login 开始登录游戏服")
      local success, retData, code = self:_LoginServer(conn, self.model.gameToken)
      if false == self:_CheckUtdid(retData) then
        success = false
      end
      if success and retData then
        result = self:_OnLoginSuccessSeamless(retData, code)
      end
    end
    
    local ret = pcall(tempCall)
    if ret and result then
      loginSuccessCallBack()
    else
      failCallBack()
    end
  end)
end

function LoginMgr:_Login(cb)
  TaskMgr.Instance.Fork(function()
    self:_StopSeamlessReLoginTimer()
    WaitingView.Instance:Show(self, WaitingView.Flag_Logining)
    self.model:ResetIsLogin()
    ReportStepLog(LoginStep.StepGetServerList, "Check ServerList and ServerId")
    if not self:HasServerList() or not self.model.serverId then
      ReportStepLog(LoginStep.StepGetServerList, "no serverlist, start to get serverlist.")
      if not self:_GetServerList(true) then
        ReportStepLog(LoginStep.StepGetServerList, "try get server list failed")
        EventMgr.Instance.LoginErrorEvent:Dispatch()
        WaitingView.Instance:Hide(self, WaitingView.Flag_Logining)
        return
      end
    end
    ReportStepLog(LoginStep.StepLoginPlatform, string.format("Check IsPlatformLogin:%s, serverId:%s", tostring(self.model.isPlatformLogin), tostring(self.model.serverId)))
    if not self.model.isPlatformLogin then
      ReportStepLog(LoginStep.StepLoginPlatform, "start to get platform token")
      local ret = self:_LoginPlatform()
      ReportStepLog(LoginStep.StepLoginPlatform, string.format("get platformtoken ret:%s", table.tostring(ret)))
      if not ret then
        EventMgr.Instance.LoginErrorEvent:Dispatch()
      end
      WaitingView.Instance:Hide(self, WaitingView.Flag_Logining)
      return
    end
    self:SetExistHistoryLogin(true)
    ReportStepLog(LoginStep.StepAuthPlatformServer, "Start to get gameToken")
    if not self:_AuthPlatformServer() then
      EventMgr.Instance.LoginErrorEvent:Dispatch()
      WaitingView.Instance:Hide(self, WaitingView.Flag_Logining)
      return
    end
    if cb then
      EventMgr.Instance.LoginErrorEvent:Dispatch()
      WaitingView.Instance:Hide(self, WaitingView.Flag_Logining)
      cb()
      return
    end
    NetworkMgr.Instance:Close()
    DataCenter.gameData.IsReplaceRole = false
    WorldRecoveryManager.Instance:ClearRecoverData(true)
    ReportStepLog(LoginStep.StepConnectServer, "Start to connect game server")
    local ret, conn = self:_ConnectServer()
    if not ret then
      WaitingView.Instance:Hide(self, WaitingView.Flag_Logining)
      EventMgr.Instance.LoginErrorEvent:Dispatch()
      return ret, conn
    end
    ReportStepLog(LoginStep.StepLoginGameServer, string.format("Start to login game server:%s", tostring(self.model.gameToken)))
    local success, retData, code = self:_LoginServer(conn, self.model.gameToken)
    ReportStepLog(LoginStep.StepLoginGameServer, string.format("Login game server success:%s, retData:%s", success, table.tostring(retData)))
    if success and retData then
      WaitingView.Instance:Hide(self, WaitingView.Flag_Logining)
      self:_OnLoginSuccess(retData, code)
    else
      WaitingView.Instance:Hide(self, WaitingView.Flag_Logining)
      EventMgr.Instance.LoginErrorEvent:Dispatch()
    end
  end)
end

function LoginMgr:Logout()
  self:SetExistHistoryLogin(false)
  WaitingView.Instance:Hide(self, WaitingView.Flag_Logining)
  SdkMgr.Instance:DelegateEventOnce(SdkFuncListener.Logout, System.fn(self, self._OnLogout))
  SdkMgr.Instance:Logout()
end

function LoginMgr:Reconnect(uid)
  local playerToken = PlayerDataUtils.GetPlayerToken()
  DataCenter.gameData.IsReplaceRole = false
  local inBattle = DataCenter.barrierData.InBattle
  if not inBattle then
    WorldRecoveryManager.Instance:ClearRecoverData(false)
  end
  local data, errcode = NetworkMgr.Instance.Login:Reconnect(playerToken)
  local resultMsgKey = "Reconnect Finish, uid:%s, playerToken:%s, errcode:%s, data:%s"
  Logger.Info(string.format(resultMsgKey, uid, playerToken, table.tostring(errcode), table.tostring(data)))
  if errcode.code == ErrorMsg.SUCCESS and data and data.roleId then
    HandleReconnectData(data)
    return LoginConstDefine.LOGIN_SUCCESSS_CODE, errcode.code
  end
  return LoginConstDefine.LOGIN_FAILED_CODE, errcode.code
end

function LoginMgr:_ConnectServer(notShowPop, serverParam)
  EventMgr.Instance.OnStartLoginServer:Dispatch()
  local connected
  
  local function WaitConnect(c)
    connected = c
  end
  
  local ip = self.model.ipAddr
  local port = tonumber(self.model.port)
  serverParam = serverParam or self.model.serverId .. "-game"
  local conn, errCode = NetworkMgr.Instance:Connect(ip, port, WaitConnect, serverParam)
  local resultMsgKey = "[_ConnectServer] _ConnectServer, ip:%s, port:%s, serverParam:%s, errCode:%s, traceback:%s"
  ReportStepLog(LoginStep.StepConnectServer, string.format(resultMsgKey, ip, port, serverParam, table.tostring(errCode), debug.traceback()))
  if not conn then
    local logMsg = string.format("connect server failed, erroCode: %s", errCode)
    ReportStepLog(LoginStep.StepConnectServer, logMsg)
    DisconnectCallback(not notShowPop)
    NetworkMgr.Instance:Close()
    return false, errCode
  end
  local timerId = self.binder:BindTimer(5, 0, nil, function()
    WaitConnect(false)
  end)
  while nil == connected do
    TaskMgr.Instance:WaitForUpdate()
  end
  self.binder:StopTimer(timerId)
  if not connected then
    DisconnectCallback(not notShowPop)
    local logMsg = string.format("not connected, erroCode: %s", errCode)
    ReportStepLog(LoginStep.StepConnectServer, logMsg)
    NetworkMgr.Instance:Close()
    return false, nil
  end
  Logger.UpdateLogFileName(self.model.account)
  return true, conn
end

function LoginMgr:_LoginServer(conn, token, uid)
  local success, hallLoginRet = ProtoManager.Instance.LoginRequest:UserLogin(conn, token, uid)
  ReportStepLog(LoginStep.StepLoginGameServer, string.format("[_LoginServer] UserLogin, success:%s, data:%s", success, table.tostring(hallLoginRet)))
  if not success then
    return false, hallLoginRet.code
  end
  local envInfo, sdkUserInfo = SdkMgr.Instance:GetEnvInfo(), ""
  if envInfo then
    local tblData = JSON.decode(envInfo)
    if tblData and tblData.gmInfo then
      tblData.gmInfo.ptid = SdkMgr.GetPtid()
    end
    if tblData and tblData.devInfo then
      tblData.devInfo.ip = self.model.ipAddr
    end
    if tblData and tblData.publish_area then
      SdkMgr.Instance.model:SetPackageChannel(tblData.publish_area)
    end
    if SteamSdk.Instance:IsNativeSteamSdk() then
      local steam = {}
      steam.ticket = SteamSdk.Instance:GetSteamWebTicket(coroutine.running())
      tblData.steam = steam
    end
    SdkMgr.Instance:ResetCountryCode()
    envInfo = JSON.encode(tblData)
  end
  local data, errCode = ProtoManager.Instance.LoginRequest:ActorLogin(conn, envInfo, sdkUserInfo)
  ReportStepLog(LoginStep.StepActorLogin, string.format("[_LoginServer] ActorLogin, errcode:%s, data:%s", table.tostring(errCode), table.tostring(data)))
  if errCode.code == LoginConstDefine.LOGIN_SUCCESSS_CODE and data then
    return true, data, LoginConstDefine.LOGIN_SUCCESSS_CODE
  elseif errCode.code == LoginConstDefine.LOGIN_BANNING_CODE and data then
    local tipsId = 10598
    if data.punishment and data.punishment.end_ts then
      local y, m, d, h, M = TimeUtils.GetTimestampYmdHMS(data.punishment.end_ts)
      local desc = LT.Textf(DT.TipsType[tipsId].Desc, LT.Textf("TimeFormatYMDHm", y, m, d, h, M))
      Alert.Show(tipsId, nil, nil, nil, desc)
    end
    return false, errCode.code
  elseif errCode.code == LoginConstDefine.LOGIN_RISK_CODE and data and data.message then
    local msg = LT.Text("risk_error_msg_" .. data.message)
    Alert.ShowStr(msg)
    return false, errCode.code
  else
    if not self.model.isLogin then
      if not SdkMgr.Instance:IsSdkLogin() and data and data.uid and data.address then
        NetworkMgr.Instance:Close()
        local ret, newConn = self:_ConnectServer(true, data.address.node_instance or data.address.node)
        if not ret then
          return ret, conn
        end
        do return self._LoginServer, self, newConn, token end
        return self._LoginServer, self, newConn, token, data.uid, Alert.Show, tipsId, nil, nil, nil, desc, LT.Textf("TimeFormatYMDHm", y, m, d, h, M)
      end
      self.model:SetIsLogin(true)
      if data and data.uid and data.address then
        NetworkMgr.Instance:Close()
        local ret, newConn = self:_ConnectServer(true, data.address.node_instance or data.address.node)
        if not ret then
          return ret, conn
        end
        do return self._LoginServer, self, newConn, token end
        return self._LoginServer, self, newConn, token, data.uid, Alert.Show, tipsId, nil, nil, nil, desc, LT.Textf("TimeFormatYMDHm", y, m, d, h, M)
      else
        ErrorMsg.ShowErrCodeTips(errCode, data)
      end
    end
    ReportStepLog(LoginStep.StepActorLogin, string.format("[_LoginServer] unknown ActorLogin failed, errcode:%s, data:%s", table.tostring(errCode), table.tostring(data)))
  end
  return false, errCode.code
end

function LoginMgr:_GetHistoryServerId(playerServerList)
  if not playerServerList or #playerServerList <= 0 then
    return
  end
  local serverId
  local createTime = 0
  for _, accountInfo in pairs(playerServerList) do
    if not (0 ~= createTime and accountInfo.create_time) or createTime > accountInfo.create_time then
      createTime = accountInfo.create_time
      serverId = accountInfo.server_id
    end
  end
  return serverId
end

function LoginMgr:_MatchServerAddr(serverInfo)
  if not serverInfo then
    ReportStepLog(LoginStep.StepGetServerList, "_MatchServerAddr not serverInfo")
    return false
  end
  local serverDomain = SdkMgr.Instance:GetServerDomain()
  local addrs = serverInfo and serverInfo.data and serverInfo.data.addrs
  if addrs then
    if serverDomain then
      for idx, _addr in ipairs(addrs) do
        if _addr and string.contains(_addr.ip, serverDomain) then
          local info = string.format("_MatchServerAddr found server domain:%s, server_id:%s, idx:%s", serverDomain, serverInfo.server_id, idx)
          ReportStepLog(LoginStep.StepGetServerList, info)
          return {
            ip = _addr.ip,
            port = _addr.port
          }
        end
      end
    end
    ReportStepLog(LoginStep.StepGetServerList, "_MatchServerAddr not serverDomain, get first server addr data. --" .. serverInfo.server_id)
    return {
      ip = addrs[1].ip,
      port = addrs[1].port
    }
  end
end

function LoginMgr:_ChooseServer(playerServerList, serverList)
  local logMsg = string.format("Try to choose server, is sdk login:%s, serverList:%s, playerServerList:%s", tostring(SdkMgr.Instance:IsSdkLogin()), table.tostring(serverList), table.tostring(playerServerList))
  ReportStepLog(LoginStep.StepGetServerList, logMsg)
  if not SdkMgr.Instance:IsSdkLogin() then
    local serverId = MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.ServerId)
    if serverId and serverList then
      for _, serverInfo in ipairs(serverList) do
        if serverInfo.server_id == serverId then
          return self:_SetChooseServerInfo(serverInfo)
        end
      end
    end
    return true
  end
  local notCrowdedServerInfo = self:_GetNotCrowdedServerInfo(serverList)
  do return self._SetChooseServerInfo, self end
  return self._SetChooseServerInfo, self, notCrowdedServerInfo, ipairs(serverList)
end

function LoginMgr:_GetNotCrowdedServerInfo(serverList)
  local specific_server_id = Utils.__get_specific_server_id() or CS.FrameWork.Z1Const.GetSpecificServerId()
  if serverList and #serverList > 0 then
    if "" ~= specific_server_id then
      for _, serverInfo in pairs(serverList) do
        if serverInfo and serverInfo.server_id == specific_server_id then
          return serverInfo
        end
      end
    end
    table.sort(serverList, function(v1, v2)
      local v1_sort = v1.data and v1.data.desc or 0
      local v2_sort = v2.data and v2.data.desc or 0
      if v1_sort == v2_sort then
        local v1_id_sort = v1.server_id or 0
        local v2_id_sort = v2.server_id or 0
        return v1_id_sort < v2_id_sort
      end
      return v1_sort < v2_sort
    end)
    return serverList[1]
  else
    Logger.Error("服务器列表为空")
    ReportStepLog(LoginStep.StepGetServerList, "[error]服务器列表为空!")
  end
end

function LoginMgr:_SetChooseServerInfo(serverInfo)
  if not serverInfo then
    ReportStepLog(LoginStep.StepGetServerList, "not serverInfo")
    return false
  end
  local addr = self:_MatchServerAddr(serverInfo)
  if addr and addr.ip and addr.port then
    self.model:SetIpAddr(addr.ip)
    self.model:SetPort(addr.port)
  else
    ReportStepLog(LoginStep.StepGetServerList, "invalid addr data! server_id:" .. (serverInfo and serverInfo.server_id))
    return false
  end
  ReportStepLog(LoginStep.StepGetServerList, string.format("Set server port, addr:%s, set serverId:%s ", table.tostring(addr), tostring(serverInfo.server_id)))
  self.model:SetServerId(serverInfo.server_id)
  return true
end

function LoginMgr:HasServerList()
  return self.model.serverList and #self.model.serverList > 0
end

function LoginMgr:GetServerId()
  return self.model.serverId
end

function LoginMgr:GetAccount()
  return self.model.account or SdkMgr.Instance:GetPid()
end

function LoginMgr:_BindToSetPlayerInfo()
  if not self.binder or not SdkMgr.Instance:IsSdkLogin() then
    return
  end
  self.binder:BindToRaw(function(_, valueTable, _)
    if not valueTable then
      return
    end
    local playerName = valueTable[1]
    if playerName and IntroductionDataUtils.IsFinishSetNameStep() then
      local roleId = PlayerDataUtils.GetPlayerUid()
      SdkMgr.Instance:SetPlayerInfo(roleId, self.model.serverId, playerName, CommonDefine.SdkPlayerInfoType.ENTERGAME)
    end
  end, function()
    local playerName = DataCenter.playerData.DRole.name
    return {playerName}
  end)
end

function LoginMgr:OnDestroy()
  Super.OnDestroy(self)
end

function LoginMgr:ExistHistoryLogin()
  if not ApplicationUtils.IsWindows() or SteamSdk.Instance:IsNativeSteamSdk() then
    return
  end
  local key = "Morimens_ExistHistoryLogin"
  local val = CS.UnityEngine.PlayerPrefs.GetInt(key, 0)
  return 1 == val
end

function LoginMgr:SetExistHistoryLogin(existed)
  if not ApplicationUtils.IsWindows() or SteamSdk.Instance:IsNativeSteamSdk() then
    return
  end
  local key = "Morimens_ExistHistoryLogin"
  CS.UnityEngine.PlayerPrefs.SetInt(key, existed and 1 or 0)
end

return LoginMgr
