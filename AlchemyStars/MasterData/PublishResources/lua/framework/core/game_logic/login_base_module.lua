local ModuleStateType = {
  Unset = "Unset",
  RetryResetDuring = "RetryResetDuring",
  ResetDuring = "ResetDuring"
}
_enum("ModuleStateType", ModuleStateType)
_class("LoginBaseModule", GameModule)
LoginBaseModule = LoginBaseModule

function LoginBaseModule:Constructor()
  self.svrId = 0
  self.isLogin = false
  self.curTaskId = 0
  self.retryTimer = nil
  self.retryDelayCD = 2000
  self.retryTimeout = 8000
  self.startRetryTime = 0
  self.lastRetryTime = 0
  self.stateType = ModuleStateType.Unset
  self.fastCheckTimer = nil
  self.fastCheckTimelong = self.retryTimeout / 2
  self.fastCheckTimeout = self.retryTimeout
  self.isBusy = false
  self.tempList = {}
end

function LoginBaseModule:Init()
  LoginBaseModule.super.Init(self)
  self.caller:RegisterPushHandler(CEventSvrPushLogout, self.HandleLogout, self)
  self.caller:RegisterPushHandler(CEventSvrPushNotification, self.HandleNotification, self)
  self:AttachEvent(GameEventType.ConnectDone, self.OnConnectDone)
  self:AttachEvent(GameEventType.ConnectFail, self.OnConnectFailed)
  self:AttachEvent(GameEventType.ConnectClose, self.OnConnectClosed)
  self:AttachEvent(GameEventType.CallBegin, self.OnCallBegin)
  self:AttachEvent(GameEventType.CallEnd, self.OnCallEnd)
  self:AttachEvent(GameEventType.CallTimelong, self.OnCallTimelong)
  self:AttachEvent(GameEventType.CallTimeout, self.OnCallTimeout)
  self.isLogin = false
end

function LoginBaseModule:Dispose()
  self.isLogin = false
  self:StopFastCheck()
  self:CancelRetryTimer()
  self.caller:UnRegisterPushHandler(CEventSvrPushLogout)
  self.caller:UnRegisterPushHandler(CEventSvrPushNotification)
  LoginBaseModule.super.Dispose(self)
end

function LoginBaseModule:Update(curTime)
  LoginBaseModule.super.Update(self, curTime)
end

function LoginBaseModule:Key()
  return self.caller and self.caller:Key() or "<disposed module>"
end

function LoginBaseModule:IsLogin()
  return self.isLogin
end

function LoginBaseModule:Reset(reason)
  Log.debug(self:Key(), " Reset, reason: ", reason, Log.traceback())
  self.stateType = ModuleStateType.Unset
  self.isLogin = false
  self:StopFastCheck()
  self:CancelRetryTimer()
  self:Logout(reason)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.LoginReset)
  self.caller:ResetCall(CallResultType.CallReset)
  self.caller:Disconnect(reason)
  GameGlobal.GameLogic():GoBack()
end

function LoginBaseModule:Retry(reason)
  Log.debug(self:Key(), " Retry, reason: ", reason, Log.traceback())
  self.stateType = ModuleStateType.Unset
  local delayTime = self.lastRetryTime + self.retryDelayCD - GameGlobal:GetInstance():GetCurrentRealTime()
  if self.caller:IsCallTimeout() then
    self.caller:ResetCallTimeout()
    delayTime = 40
  elseif self.caller:HasSyncCall() then
    delayTime = 40
  elseif self.caller:IsConnected() then
    delayTime = 40
  elseif delayTime <= 0 then
    delayTime = 40
  end
  self:StartRetryProc(delayTime, reason)
end

function LoginBaseModule:StartRetryProc(delayTime, reason)
  Log.debug(self:Key(), " Retry after: ", delayTime)
  self.retryTimer = GameGlobal.RealTimer():AddEvent(delayTime, self.RetryProc, self, "reason: " .. reason .. ", before: " .. tostring(delayTime))
end

function LoginBaseModule:CancelRetryTimer()
  if self.retryTimer == nil then
    return
  end
  Log.debug(self:Key(), " CancelRetryTimer", Log.traceback())
  GameGlobal.RealTimer():CancelEvent(self.retryTimer)
  self.retryTimer = nil
end

function LoginBaseModule:RetryProc(reason)
  Log.debug(self:Key(), " RetryProc, reason: ", reason, Log.traceback())
  self:CancelRetryTimer()
  if self.caller:HasAuth() then
    Log.warn(self:Key(), " has auth, need not retry")
    return
  end
  self.lastRetryTime = GameGlobal:GetInstance():GetCurrentRealTime()
  if self.curTaskId == 0 then
    local timeout = self.retryTimeout
    if self.fastCheckTimer then
      local elapsed = self.caller:LastRecvElapsedTick()
      if elapsed >= self.fastCheckTimeout then
        timeout = self.fastCheckTimelong
      elseif self.fastCheckTimelong >= self.fastCheckTimeout - elapsed then
        timeout = self.fastCheckTimeout - elapsed
      else
        timeout = self.fastCheckTimelong
      end
    end
    GameGlobal.TaskManager():StartTask(self.RetryTask, self, timeout)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.NetWorkRetryStart)
    self.caller:RetryCall(self.curTaskId)
  end
end

function LoginBaseModule:RetryTask(TT, timeout)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.NetWorkRetryStart)
  self.startRetryTime = self.lastRetryTime
  Log.debug(self:Key(), " RetryTask, timeout: ", timeout, Log.traceback())
  local res = self:Login(TT, self.svrId, true, timeout)
  self:CancelRetryTimer()
  if res:GetSucc() then
    Log.debug(self:Key(), " retry done")
  elseif res:GetCallSucc() then
    Log.fatal(self:Key(), " retry failed, msg: ", tostring(res:GetResult()))
  elseif self:IsLogin() then
    Log.fatal(self:Key(), " retry failed, call: ", tostring(res:GetCallErr()))
    GameGlobal.GameLogic().NetworkMonitor:CallRetryReset(self, "call login timeout")
  else
    self.caller:ResetCall(CallResultType.CallTimeout)
  end
  self.startRetryTime = 0
  GameGlobal.EventDispatcher():Dispatch(GameEventType.NetWorkRetryEnd)
end

function LoginBaseModule:Login(TT, svrId, silent, timeout)
  return AsyncRequestRes:New()
end

function LoginBaseModule:Logout(reason)
  if not self.caller:IsConnected() then
    return
  end
  Log.debug(self:Key(), " Logout, reason: ", reason, Log.traceback())
  local msg = NetMessageFactory:GetInstance():CreateMessage(CEventCliPushLogout)
  self:Push(msg)
end

function LoginBaseModule:HandleLogout(msg)
  Log.debug(self:Key(), " HandleLogout, err: ", tostring(msg.m_err), " reason: ", msg.m_reason, Log.traceback())
  GameGlobal.GameLogic():BackToLogin(false, self, "server logout, err: " .. tostring(msg.m_err) .. " reason: " .. msg.m_reason, self:IsLogin(), msg.m_err, Log.traceback())
end

function LoginBaseModule:HandleNotification(msg)
  Log.debug(self:Key(), " HandleNotification, notification_type: ", tostring(msg.m_notification_type), Log.traceback())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PushNotification, msg.m_notification_type, msg.m_hot_update_res_ver)
end

function LoginBaseModule:StartFastCheck(interval, timelong, timeout)
  if not self.caller:HasAuth() then
    return
  end
  self:StopFastCheck()
  self.fastCheckTimelong = timelong
  self.fastCheckTimeout = timeout
  local lastSendElapsedTick = self.caller:LastSendElapsedTick()
  local lastRecvElapsedTick = self.caller:LastRecvElapsedTick()
  Log.debug(self:Key(), " StartFastCheck, send elapsed: ", lastSendElapsedTick, ", recv elapsed: ", lastRecvElapsedTick, ", interval: ", interval, ", timelong: ", timelong, ", timeout: ", timeout, Log.traceback())
  if timelong <= lastRecvElapsedTick and timelong > lastSendElapsedTick then
    self.caller:DisconnectLink("fast check timelong")
    return
  end
  if interval <= lastSendElapsedTick then
    self.caller:Alive()
  end
  self.fastCheckTimer = GameGlobal.RealTimer():AddEvent(interval, self.StartFastCheck, self, interval, timelong, timeout)
end

function LoginBaseModule:StopFastCheck()
  if self.fastCheckTimer == nil then
    return
  end
  GameGlobal.RealTimer():CancelEvent(self.fastCheckTimer)
  self.fastCheckTimer = nil
  self.fastCheckTimelong = self.retryTimeout / 2
  self.fastCheckTimeout = self.retryTimeout
end

function LoginBaseModule:OnFastCheckFailed(reason)
  Log.debug(self:Key(), " OnFastCheckFailed, reason: ", reason, Log.traceback())
  if self.caller:LastRecvElapsedTick() < self.fastCheckTimeout then
    self:Retry(reason)
  else
    GameGlobal.GameLogic().NetworkMonitor:ConnectRetryReset(self, reason)
  end
end

function LoginBaseModule:OnConnectDone(caller)
  if caller ~= self.caller then
    return
  end
  self:Retry("connect done")
end

function LoginBaseModule:OnConnectFailed(caller, reason)
  if caller ~= self.caller then
    return
  end
  if self.caller:IsCallTimeout() then
  elseif not self:IsLogin() then
    self.caller:ResetCall(CallResultType.ConnectFailed)
  elseif self.fastCheckTimer then
    self:OnFastCheckFailed(reason)
  elseif self.caller:HasSyncCall() then
    self:Retry(reason)
  elseif self.startRetryTime == 0 or GameGlobal:GetInstance():GetCurrentRealTime() - self.startRetryTime < self.retryTimeout then
    self:Retry(reason)
  else
    GameGlobal.GameLogic().NetworkMonitor:ConnectRetryReset(self, reason)
  end
end

function LoginBaseModule:OnConnectClosed(caller, reason)
  if caller ~= self.caller then
    return
  end
  self.caller:LostAuth()
  if self.caller:IsCallTimeout() then
  elseif not self:IsLogin() then
    self.caller:ResetCall(CallResultType.ConnectClosed)
  elseif self.fastCheckTimer then
    self:OnFastCheckFailed(reason)
  elseif self.caller:HasSyncCall() then
    self:Retry(reason)
  elseif self.startRetryTime == 0 or GameGlobal:GetInstance():GetCurrentRealTime() - self.startRetryTime < self.retryTimeout then
    self:Retry(reason)
  else
    GameGlobal.GameLogic().NetworkMonitor:ConnectRetryReset(self, reason)
  end
end

function LoginBaseModule:OnCallBegin(caller, msg)
  if caller ~= self.caller then
    return
  end
end

function LoginBaseModule:OnCallEnd(caller, msg)
  if caller ~= self.caller then
    return
  end
  if self.isBusy then
    GameGlobal.UIStateManager():ShowBusy(false)
    self.isBusy = false
  end
end

function LoginBaseModule:OnCallTimelong(caller, msg)
  if caller ~= self.caller then
    return
  end
  if self.isBusy == false then
    self.isBusy = true
    GameGlobal.UIStateManager():ShowBusy(true)
  end
end

function LoginBaseModule:OnCallTimeout(caller)
  if caller ~= self.caller then
    return
  end
  self.isBusy = false
  GameGlobal.UIStateManager():ShowBusy(false)
  self.caller:DisconnectLink("call timeout")
  if not self:IsLogin() then
    self.caller:ResetCall(CallResultType.CallTimeout)
  else
    GameGlobal.GameLogic().NetworkMonitor:CallRetryReset(self, "call timeout")
  end
end
