local Time = CS.UnityEngine.Time
local ReconnectMgr, Super = System.NewClass("ReconnectMgr", Manager)
local ReconnectState = ReconnectDefine.State
local ReconnectRet = ReconnectDefine.Ret
local SendHeartBeatInterval = 2.0
local MaxNoHeartBeatTime = 10.0
local MaxForceTownSceneTime = 120.0
local MaxReconnectTimes = 2
local MaxRepeatTimes = 1
local RECONNECT_LOG_EVENT = "Reconnect: {type} {result} {detail}"

function ReconnectMgr:ctor()
  Super.ctor(self)
  self.reconnectCount = 0
  self.repeatCount = 0
  self.sendHeartbeatTime = nil
  self.recvHeartbeatTime = nil
  self._freezeTime = nil
  self.state = ReconnectState.Stop
  if ApplicationUtils.is_editor_mode() then
    Logger.Debug("PC编辑器上，特殊设置断线重连的无心跳时长，避免影响调试")
    MaxNoHeartBeatTime = 240.0
  end
  RpcMgr.Instance:SetRpcRequestReconnectCb(function(ret)
    DataCenter.loginData.rpcRequest = ret
    if ret then
      self:CloseWeakReconnect()
    end
  end)
end

function ReconnectMgr:Awake()
  Super.Awake(self)
  self.updateTimer = TimerManager.Instance:CreateTimer(1.0, -1, System.fn(self, self.Update))
end

function ReconnectMgr:OnDestroy()
  if self.updateTimer then
    TimerManager.Instance:StopTimer(self.updateTimer)
  end
  self.reconnectCount = 0
  self.repeatCount = 0
  self:ClearHeartbeat()
  self:SetState(ReconnectState.Stop, "destroy")
  Super.OnDestroy(self)
end

function ReconnectMgr:GetNetworkState(success, status)
  if self.networkState ~= success or self.networkErr ~= status then
    Logger.Info("[ReconnectMgr] NetworkState change:", success, status)
  end
  if success then
    self:_ClosePopupUI()
  end
  self.networkState = success
  self.networkErr = status
  if self.networkErr == "dispatch error" then
    self.forceHandlePolicy = ReconnectPolicy.FailedReconnect
  end
end

function ReconnectMgr:Update()
  if not DataCenter.playerData.DRole or DataCenter.gameData.IsReplaceRole or self.state == ReconnectState.Stop then
    return
  end
  self:CalcNetTime()
  if self.state == ReconnectState.WaitConnectRet then
    self.waitConnectCount = (self.waitConnectCount or 0) + 1
    if self.waitConnectCount >= 10 then
      self:StartReconnect("connect_timeout")
      self.waitConnectCount = 0
    end
    return
  end
  if self.networkState and RpcMgr.Instance:is_connect() and self.state == ReconnectState.StartUp then
    self:UpdateHeartbeat()
    return
  end
  if self.state == ReconnectState.WaitResCheckRet then
    return
  end
  if DataCenter.gameData.DelayReconnectTime and DataCenter.gameData.DelayReconnectTime > 0 then
    DataCenter.gameData.DelayReconnectTime = DataCenter.gameData.DelayReconnectTime - 1
    if DataCenter.gameData.DelayReconnectTime > 0 then
      return
    end
  end
  if not self.networkState then
    RpcMgr.Instance:CloseSocket("reconnect")
    self:DoReconnect()
  end
end

function ReconnectMgr:Enable()
  self.networkState = true
  self.forceHandlePolicy = nil
  self:SetState(ReconnectState.StartUp, "Start Update")
  RpcMgr.Instance:SetUpdateCallback(System.fn(self, self.GetNetworkState))
  self:ClearHeartbeat()
  self.reconnectCount = 0
  self.repeatCount = 0
  self:Heartbeat()
  Logger.Info("ReconnectMgr : Enable reconnt mgr")
end

function ReconnectMgr:Disable()
  self:SetState(ReconnectState.Stop, "Stop Update")
  RpcMgr.Instance:SetUpdateCallback()
  self:ClearHeartbeat()
  self.reconnectCount = 0
  self.repeatCount = 0
  self.forceHandlePolicy = nil
  Logger.Info("ReconnectMgr : Disable reconnt mgr")
end

function ReconnectMgr:ClearHeartbeat()
  self.recvHeartbeatTime = nil
  self.sendHeartbeatTime = nil
end

function ReconnectMgr:SetState(state, reason)
  if self.state == state then
    return
  end
  local oldstate = self.state
  self.state = state
  Logger.Info("[ReconnectMgr] State=%s->%s. reason=[%s]", oldstate, state, reason or "")
end

function ReconnectMgr:GetState()
  return self.state
end

function ReconnectMgr:CalcNetTime()
  if Time.deltaTime > 0.1 then
    self._freezeTime = TimeUtils.GetRealTime() + 0.5
    DataCenter.playerData.netDelayTime = 0
    return
  end
  if self._freezeTime and self._freezeTime > TimeUtils.GetRealTime() then
    DataCenter.playerData.netDelayTime = 0
    return
  end
  local sendTime, recvTime = self:GetSendHeartbeatTime(), self:GetRecvHeartbeatTime()
  if not sendTime then
    DataCenter.playerData.netDelayTime = 0
    return
  end
  if recvTime and sendTime < recvTime then
    DataCenter.playerData.netDelayTime = math.modf((recvTime - sendTime) * 1000)
  else
    DataCenter.playerData.netDelayTime = math.modf((TimeUtils.GetRealTime() - sendTime) * 1000)
  end
end

function ReconnectMgr:GetSendHeartbeatTime()
  return self.sendHeartbeatTime
end

function ReconnectMgr:GetRecvHeartbeatTime()
  return self.recvHeartbeatTime
end

function ReconnectMgr:UpdateHeartbeat()
  local curRealTime = TimeUtils.GetRealTime()
  if self.recvHeartbeatTime == nil then
    self.recvHeartbeatTime = curRealTime
  end
  local notRecvHeartbeatTime = curRealTime - self.recvHeartbeatTime
  if notRecvHeartbeatTime >= 120 then
    Logger.Info("[ReconnectMgr] network: 网络卡太久了：%s", notRecvHeartbeatTime)
    self:StartReconnect("heartbeat_timeout")
    return
  end
  if curRealTime - (self.sendHeartbeatTime or curRealTime) >= 30 then
    self.sendHeartbeatTime = curRealTime
    self.recvHeartbeatTime = curRealTime - 2
    self:Heartbeat()
    return
  end
  if self.recvHeartbeatTime and self.recvHeartbeatTime > 0 and notRecvHeartbeatTime >= MaxNoHeartBeatTime then
    Logger.Info("[ReconnectMgr] network: 网络心跳超时：%s", notRecvHeartbeatTime)
    self:StartReconnect("heartbeat_timeout")
    return
  end
  if nil == self.sendHeartbeatTime or curRealTime - self.sendHeartbeatTime >= SendHeartBeatInterval then
    self.sendHeartbeatTime = curRealTime
    self:Heartbeat()
  end
end

function ReconnectMgr:Heartbeat()
  TaskMgr.Instance.Fork(function()
    local sendHeartbeatTime = self.sendHeartbeatTime or TimeUtils.GetRealTime()
    local data = NetworkMgr.Instance.Login:Heartbeat()
    local ts = type(data) == "table" and data.ts or data
    local tz = type(data) == "table" and data.tz
    if ts and type(ts) == "number" and ts > 0 then
      EventMgr.Instance.OnHeartbeatResponse:Dispatch(ts, SendHeartBeatInterval)
      self.recvHeartbeatTime = TimeUtils.GetRealTime()
      local delay = self.recvHeartbeatTime - sendHeartbeatTime
      TimeUtils.SetServerTime(ts, delay, tz)
    end
    self:CalcNetTime()
  end)
end

function ReconnectMgr:DoReconnect()
  Logger.Info("[ReconnectMgr] DoReconnect")
  self:SetState(ReconnectState.WaitResCheckRet)
  self.recvHeartbeatTime = nil
  GameEssentialDataRequestor.Instance:Stop()
  PlayerDataRequestor.Instance:Stop()
  self:SetState(ReconnectState.Reconnect)
  if self.customDoReconnectFunc then
    self.customDoReconnectFunc()
    return
  end
  self:_AutoReconnect()
end

function ReconnectMgr:SetCustomDoReconnectFunc(customDoReconnectFunc)
  self.customDoReconnectFunc = customDoReconnectFunc
end

function ReconnectMgr:_AutoReconnect()
  EventMgr.Instance.CloseReqMask:Dispatch()
  self.reconnectCount = self.reconnectCount + 1
  Logger.Info("[ReconnectMgr] _AutoReconnect", self.reconnectCount, self.repeatCount)
  local handlePolicyFunc = self.forceHandlePolicy
  self.forceHandlePolicy = nil
  if not handlePolicyFunc then
    if self.reconnectCount <= MaxReconnectTimes then
      handlePolicyFunc = ReconnectPolicy.GosconReconnect
      if not WaitingView.Instance:ContainsFlag(WaitingView.Flag_Reconnected) then
        WaitingView.Instance:Show(self, WaitingView.Flag_Reconnected)
      end
      self:ReportReconnectApusInfo("reconnect", "start")
    elseif self.repeatCount >= MaxRepeatTimes then
      self:ReportReconnectApusInfo("seamless relogin", "start")
      handlePolicyFunc = ReconnectPolicy.SeamlessReLogin
    else
      local recoverData = WorldRecoveryManager.Instance and WorldRecoveryManager.Instance:GetRecoverData()
      if recoverData and WorldRecoveryManager.Instance:IsStageExpiredByServer() then
        Logger.Info("[ReconnectMgr] _AutoReconnect: abyss stage expired by server, skip manual reconnect alert")
        self:SetState(ReconnectState.Stop, "abyss season expired")
        self.reconnectCount = 0
        self.repeatCount = 0
        self:_ClosePopupUI()
        local stageCfg = DT.Stage[recoverData.copiesTid]
        local stageGroupId = stageCfg and stageCfg.BelongGroup or recoverData.copiesTid
        WorldRecoveryManager.Instance:ShowAbyssResetTipsByStageGroupId(stageGroupId)
        return
      end
      handlePolicyFunc = ReconnectPolicy.MannulReconnect
      self:_ClosePopupUI()
      self:ReportReconnectApusInfo("reconnect", "fail")
    end
  else
    self:_ClosePopupUI()
  end
  self:SetState(ReconnectState.WaitConnectRet, "Wait Reconecting")
  
  local function handleRetFunc(ret)
    Logger.Info("[ReconnectMgr] handleRetFunc result:", ret)
    if ret == ReconnectRet.Reconnect then
      self:SetState(ReconnectState.Reconnect, "Reconecting")
      self:ReportReconnectApusInfo("reconnect", "fail")
      Logger.Info("[ReconnectMgr] handleRetFunc, gosconn failed, try again, count:", self.reconnectCount, self.repeatCount)
    elseif ret == ReconnectRet.Success then
      self:_ClosePopupUI()
      self:ReconnectSuccess()
      self:ReportReconnectApusInfo("reconnect", "success")
      Logger.Info("[ReconnectMgr]自动重连结束: 重连成功")
      EventMgr.Instance.ReconnectSuccess:Dispatch()
      if handlePolicyFunc == ReconnectPolicy.GosconReconnect then
        Logger.ReportApusInfo("BattleSceneLoader {reconnect}", "true")
        if WorldRecoveryManager.Instance:OnRecovery(false) then
          if WorldRecoveryManager.Instance:IsWaitingAbyssResetConfirm() then
            Logger.Info("[ReconnectMgr] goscon reconnect: abyss reset tips showing, skip TryReqStartBattle")
          else
            LoginMgr.Instance:TryReqStartBattle()
          end
        end
      end
    elseif ret == ReconnectRet.LoginSuccess then
      self:_ClosePopupUI()
      self:ReportReconnectApusInfo("relogin", "success")
      Logger.Info("[ReconnectMgr]自动重连结束: 重登成功")
    elseif ret == ReconnectRet.ChooseConnect then
      self.reconnectCount = 0
      self.repeatCount = self.repeatCount + 1
      self:SetState(ReconnectState.Reconnect, "choose reconnect")
      Logger.Warn("[ReconnectMgr]自动重连结束: 断线重连失败")
      self:ReportReconnectApusInfo("choose connect", "fail")
    else
      self.reconnectCount = 0
      self.repeatCount = 0
      self:SetState(ReconnectState.Stop, "reconnect failed")
      Logger.Warn("[ReconnectMgr]自动重连结束: 无感重登失败")
      if ret == ReconnectRet.ReturnLogin then
        self:_ClosePopupUI()
        self:ReportReconnectApusInfo("relogin", "fail")
        ReconnectPolicy.ServerConnectBreak()
      end
    end
  end
  
  handlePolicyFunc(handleRetFunc)
end

function ReconnectMgr:ReportReconnectApusInfo(type, result)
  local detail = self:GetDetailInfo()
  Logger.ReportApusInfo(RECONNECT_LOG_EVENT, type, result, detail)
end

function ReconnectMgr:GetDetailInfo()
  local detail = "time : %s; inStage : %s, %s; inBattle : %s, %s; curPanel ：%s"
  local strTime = TimeUtils.GetServerTime()
  local time = TimeUtils.ServerTimestampToString(math.floor(strTime), TimeUtils.TimeExactType.Minute)
  local curPanel = UIAudioManager.Instance:GetTopUIElementUI()
  local inStage = SceneMgr.Instance:IsInCopies()
  local inBattle = SceneMgr.Instance:IsInBattle()
  local stageData = WorldStageManager.Instance:GetCurStageData()
  local stageId = 0
  if nil ~= stageData then
    stageId = stageData.stageId
  end
  local battleId = 0
  if inBattle and bg.battleRender then
    battleId = bg.battleRender:GetBattleId()
  end
  detail = string.format(detail, time, inStage, stageId, inBattle, battleId, curPanel)
  return detail
end

function ReconnectMgr:StartReconnect(reason)
  Logger.Info("StartReconnect {reason}", reason)
  RpcMgr.Instance:CloseSocket("reconnect")
  RpcMgr.Instance:EnableNetworkUpdate(false)
  self.networkState = false
  self:DoReconnect()
end

function ReconnectMgr:ReconnectSuccess()
  self:SetState(ReconnectState.StartUp, "Reconnect Success")
  local curTime = TimeUtils.GetRealTime()
  local lastTime = self.sendHeartbeatTime
  local inBattle = SceneMgr.Instance:IsInBattle()
  local inCopy = SceneMgr.Instance:IsInCopies()
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if SceneMgr.Instance:IsInTown() and not inBattle and not inCopy and nil == stageData and lastTime and curTime - lastTime > MaxForceTownSceneTime then
    Logger.Info("[ReconnectMgr] 断网超过一定时间, 但重连成功了。时间信息：%s, %s, %s", curTime, lastTime, MaxForceTownSceneTime)
  end
  self.reconnectCount = 0
  self.repeatCount = 0
  self:ClearHeartbeat()
  DataCenter.gameData.DelayReconnectTime = 0
  Logger.Info("[ReconnectMgr] 网络重连成功 发送遗留的协议数据")
  ProtoManager.Instance:RpcReconnectAfter()
end

function ReconnectMgr:CloseWeakReconnect()
  if self.reconnectCount > 0 then
    self.reconnectCount = 0
  end
end

function ReconnectMgr:_ClosePopupUI()
  WaitingView.Instance:Hide(self, WaitingView.Flag_Reconnected)
end

function ReconnectMgr:GetHeartBeatStopTime()
  return MaxNoHeartBeatTime
end

return ReconnectMgr
