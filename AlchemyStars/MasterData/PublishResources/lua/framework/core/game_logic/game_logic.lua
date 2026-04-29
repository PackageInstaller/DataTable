_class("GameLogic", Object)
GameLogic = GameLogic

function GameLogic:Constructor()
  self.CallCenter = NetCallCenter.GetInstance()
  self.ClientInfo = MobileClientInfo:New()
  self.msdkAuthorityInfo = MSDKAuthInfo:New()
  self.NetworkMonitor = NetworkMonitor:New()
  self.onLoadSceneBegin = nil
  self.onLoadSceneEnd = nil
  self.modules = {}
  self.ZoneId = 0
  self.last_time = 0
end

function GameLogic:Dispose()
  self.NetworkMonitor:Dispose()
  self:Reset("GameLogic:Dispose")
  self.NetworkMonitor = nil
  self.CallCenter = nil
end

function GameLogic:BackToLogin(bAutoAuthority, moudle, reason, popup, errcode, ...)
  if bAutoAuthority == true then
    LoginLuaHelper.CancelChannel()
  end
  TSSSDKProxy:GetInstance():LogOff()
  self.NetworkMonitor:LogoutReset(self:GetModule(moudle), reason, popup, errcode, ...)
end

function GameLogic:GoBack()
  if HelperProxy:GetInstance():GetConfig("TMPLoginSwitch", "false") == "true" then
    GameGlobal.GameLogic().NetworkMonitor:GoBack(UIStateType.LoginEmpty)
  else
    GameGlobal.GameLogic().NetworkMonitor:GoBack(UIStateType.Login)
  end
end

function GameLogic:Reset(reason)
  Log.debug("GameLogic:Reset")
  if not self.inited then
    return
  end
  self.inited = false
  self:ClearAllModule()
  self.CallCenter:Reset(reason)
end

function GameLogic:Inited()
  return self.inited
end

function GameLogic:Init(reason)
  reason = reason or "GameLogic:Init"
  self:Reset(reason)
  self.CallCenter:Init()
  NetMessageFactory:GetInstance():RegisterEvents()
  NetCallerRegister:RegCallers(self.CallCenter)
  self.CallCenter:InitCallers()
  GameModuleRegister:RegisterModules(self)
  self:InitAllModule()
  if APPVERNETSTAT then
    self.CallCenter:GetCallerLua("game"):RegisterPushHandler(CEventSvrNetworkCfgPush, self.HandleNetworkCfg, self)
  end
  UIModuleRegister:RegisterUIModules(self)
  Log.debug("GameLogic:Init")
  self.inited = true
end

function GameLogic:Update(curTick)
  if not self.inited then
    return
  end
  self:UpdateAllModule(curTick)
  if APPVERNETSTAT then
    self:NetStat(curTick)
  end
end

local SCENE_LOADER_SUFFIX = ".unity"

function GameLogic:LoadScene(TT, sceneName)
  if self.onLoadSceneBegin then
    self.onLoadSceneBegin(sceneName)
  end
  Log.sys("GameLogic:LoadScene start: ", sceneName)
  local scene = ResourceManager:GetInstance():AsyncLoadAsset(TT, sceneName .. SCENE_LOADER_SUFFIX, LoadType.Unity)
  if not scene and Log.loglevel < ELogLevel.None then
    Log.exception("找不到场景资源：", sceneName)
  end
  if self.scene then
    self.scene:Dispose()
  end
  self.scene = scene
  if self.onLoadSceneEnd then
    self.onLoadSceneEnd(sceneName)
  end
  Log.sys("GameLogic:LoadScene end: ", sceneName)
  return scene
end

function GameLogic:AddModule(type, caller)
  local module = type:New()
  module.logic = self
  module.caller = caller
  self.modules[type._className] = module
end

function GameLogic:AddUIModule(gameModuleType, uiModuleType)
  local uiModule = uiModuleType:New()
  local gameModule = self:GetModule(gameModuleType)
  if gameModule then
    gameModule.uiModule = uiModule
  else
    Log.fatal("GameLogic:AddUIModule Fail, no game module ", gameModuleType._className, Log.traceback())
  end
end

function GameLogic:GetModule(type)
  return self.modules[type._className]
end

function GameLogic:ForModules(cb)
  for _, v in pairs(self.modules) do
    if v then
      cb(v)
    end
  end
end

function GameLogic:ClearAllModule()
  for _, v in pairs(self.modules) do
    if v then
      v:DetachAllEvents()
      v:Dispose()
      if v.uiModule then
        v.uiModule:DetachAllEvents()
        v.uiModule:Dispose()
      end
    end
  end
  table.clear(self.modules)
end

function GameLogic:InitAllModule()
  for _, v in pairs(self.modules) do
    v:Init()
  end
end

function GameLogic:UpdateAllModule(curTick)
  for _, v in pairs(self.modules) do
    v:Update(curTick)
  end
end

function GameLogic:GetReadStrByIdx(idx)
  local str = UnityEngine.PlayerPrefs.GetString("SingleUserData")
  local strList = string.split(str, "|")
  if idx > #strList then
    return ""
  end
  if idx == 4 then
    return GetQR_Local.UnicodeToString(strList[idx])
  end
  return strList[idx]
end

function GameLogic:GetOpenId()
  if GameSingle then
    local singleUserData = UnityEngine.PlayerPrefs.GetString("SingleUserData")
    local qr_openid = ""
    if not string.isnullorempty(singleUserData) then
      qr_openid = self:GetReadStrByIdx(3)
    end
    return qr_openid
  end
  return self.msdkAuthorityInfo.open_id
end

function GameLogic:GetZoneID()
  return self.ZoneId
end

function GameLogic:SetZoneID(zId)
  self.ZoneId = zId
end

function GameLogic:HandleNetworkCfg(msg)
  self.CallCenter:GetCallerLua("bulletin"):UpdateNetworkCfgInfo(msg.m_net_cfg_info)
end

function GameLogic:NetStat(curTick)
  if self.CallCenter:GetCallerLua("bulletin") == nil then
    return
  end
  if curTick - self.last_time < self.CallCenter:GetCallerLua("bulletin").wait_tick4_report then
    return
  end
  Log.debug("wait_tick4_report:", tostring(self.CallCenter:GetCallerLua("bulletin").wait_tick4_report))
  self.last_time = curTick
  local reportData = self.CallCenter:GetCallerLua("bulletin"):GetReportData()
  if reportData == nil then
    Log.error("reportData == nil")
    return
  end
  local avgDelay = reportData.avgDelay
  local maxDelay = reportData.maxDelay
  local minDelay = reportData.minDelay
  local totalSize = reportData.totalSize / 1024
  local sendSize = reportData.sendSize / 1024
  local recvSize = reportData.recvSize / 1024
  local totalCount = reportData.totalCount
  local sendCount = reportData.sendCount
  local recvCount = reportData.recvCount
  local resendCount = reportData.resendCount
  local maxResendWaitTick = reportData.maxResendWaitTick
  local repeatCount = reportData.repeatCount
  local lostCount = reportData.lostCount
  local rangeCount = reportData.rangeCount
  local conflictCount = reportData.conflictCount
  local connFailedCount = reportData.connFailedCount
  local rto = reportData.aliveRto
  local connectTimeoutCount = reportData.connectTimeoutCount
  local callTimeoutCount = reportData.callTimeoutCount
  local recvTimeoutCount = reportData.recvTimeoutCount
  Log.debug("NetworkStatDelay:", tostring(avgDelay), tostring(maxDelay), tostring(minDelay), tostring(rto), tostring(totalSize), tostring(sendSize), tostring(recvSize), tostring(totalCount), tostring(sendCount), tostring(recvCount), tostring(resendCount), tostring(maxResendWaitTick), tostring(repeatCount), tostring(callTimeoutCount), tostring(recvTimeoutCount), tostring(connectTimeoutCount), tostring(lostCount), tostring(rangeCount), tostring(conflictCount), tostring(connFailedCount))
  GameGlobal.ReportCustomEvent("NetStat", "NetworkStatDelay", {
    avgDelay,
    minDelay,
    maxDelay,
    callTimeoutCount,
    sendSize,
    recvSize,
    math.ceil(rto),
    sendCount,
    sendCount,
    resendCount,
    recvTimeoutCount,
    repeatCount,
    lostCount,
    connectTimeoutCount,
    rangeCount,
    conflictCount
  })
end
