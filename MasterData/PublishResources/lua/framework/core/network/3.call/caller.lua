_class("ReplyInfo", Object)

function ReplyInfo:Constructor()
  self.res = CallResultType.OtherErr
  self.msg = nil
end

function ReplyInfo:Succ()
  return self.res == CallResultType.Normal
end

_class("NetCaller", Object)
local unpack = table.unpack

function NetCaller.CreateMessage(clsid)
  return NetMessageFactory:GetInstance():CreateMessageWithId(clsid)
end

function NetCaller:Constructor(host)
  self.replies = {}
  self.pushHandlerMap = {}
  self.host = host
  self.host:Bind(self)
  self._serverTokenName = ""
  self.wait_tick4_report = 60000
end

function NetCaller:Key()
  if self.host == nil then
    return
  end
  return self.host:GetKey()
end

function NetCaller:Dispose()
  if self.host == nil then
    return
  end
  self.host:Bind()
  self.host = nil
end

function NetCaller:Reset(reason)
  self:ClearPushHandlers()
  if self.host == nil then
    return
  end
  self.host:Base_Reset(reason)
end

function NetCaller:Init()
  if self.host == nil then
    return
  end
  self.host:Base_Init()
end

function NetCaller:SetLinkConn(desAddr)
  if self.host == nil then
    return nil
  end
  return self.host:SetLinkConn(desAddr)
end

function NetCaller:SetLink2Conn(desAddr, srcToken)
  if self.host == nil then
    return nil
  end
  self._serverTokenName = srcToken:TokenDesc()
  return self.host:SetLink2Conn(desAddr, srcToken)
end

function NetCaller:SetPipe2Conn(desToken, proxyKey)
  if self.host == nil then
    return
  end
  proxyKey = proxyKey or "gateway"
  self._serverTokenName = desToken:TokenDesc()
  return self.host:SetPipe2Conn(desToken, proxyKey)
end

function NetCaller:GetPipeProxyKey()
  if self.host == nil then
    return
  end
  return self.host:GetPipeProxyKey()
end

function NetCaller:GetConnInfo()
  if self.host == nil then
    return nil
  end
  return self.host:GetConnInfo()
end

function NetCaller:Connect()
  if self.host == nil then
    return
  end
  self.host:Connect()
end

function NetCaller:Disconnect(reason)
  if self.host == nil then
    return
  end
  self.host:Disconnect(reason)
end

function NetCaller:DisconnectLink(reason)
  if self.host == nil then
    return
  end
  local callerProxy = GameGlobal.GameLogic().CallCenter:GetCallerLua(self:GetPipeProxyKey())
  if callerProxy then
    callerProxy:Disconnect(self:Key() .. " " .. reason)
  end
  self:Disconnect(reason)
end

function NetCaller:IsConnected()
  if self.host == nil then
    return
  end
  return self.host:IsConnected()
end

function NetCaller:LastSendElapsedTick()
  if self.host == nil then
    return 0
  end
  return self.host:LastSendElapsedTick()
end

function NetCaller:LastRecvElapsedTick()
  if self.host == nil then
    return 0
  end
  return self.host:LastRecvElapsedTick()
end

function NetCaller:HasAuth()
  if self.host == nil then
    return nil
  end
  return self.host:HasAuth()
end

function NetCaller:GainAuth()
  if self.host == nil then
    return nil
  end
  self.host:GainAuth()
end

function NetCaller:LostAuth()
  if self.host == nil then
    return
  end
  self.host:LostAuth()
end

function NetCaller:Alive()
  if self.host == nil then
    return
  end
  self.host:Alive()
end

function NetCaller:GetAvgDelay()
  if self.host == nil then
    return 0.0
  end
  return self.host:GetAvgDelay()
end

function NetCaller:Push(msg)
  if self.host == nil then
    return
  end
  Log.debug("[net] NetCaller: Send", msg._className, self._serverTokenName)
  self.host:Push(msg)
end

function NetCaller:HandlePush(msg)
  local type = msg:GetType()
  local handle = self.pushHandlerMap[type]
  if handle then
    handle.func(unpack(handle.args, 1, table.maxn(handle.args)), msg)
    Log.debug("[net] NetCaller: recv", msg._className, self._serverTokenName)
  else
    Log.warn("can not find pushHandle for " .. type._className .. " in caller " .. self:Key())
  end
end

function NetCaller:OnDispatch(eventType, clsid, result)
  local event = GetEnumKey("GameEventType", eventType)
  if not event then
    Log.fatal("unknown EventType", eventType)
    return
  end
  local id = GetEnumKey("MessageDef", clsid)
  if not id then
    Log.fatal("unknown MessageDef", clsid)
    return
  end
  if result then
    Log.debug("[net] NetCaller: " .. event .. " clsid " .. id .. " result " .. result, self._serverTokenName)
  else
    Log.debug("[net] NetCaller: " .. event .. " clsid " .. id, self._serverTokenName)
  end
  GameGlobal.EventDispatcher():Dispatch(eventType, clsid, result)
end

function NetCaller:RegisterPushHandler(type, cb, ...)
  if cb ~= nil then
    self.pushHandlerMap[type] = {
      func = cb,
      args = {
        ...
      }
    }
  else
    self.pushHandlerMap[type] = nil
  end
end

function NetCaller:UnRegisterPushHandler(type)
  self.pushHandlerMap[type] = nil
end

function NetCaller:HasRegisterPushHandler(type)
  return self.pushHandlerMap[type] ~= nil
end

function NetCaller:ClearPushHandlers()
  table.clear(self.pushHandlerMap)
end

function NetCaller:Call(TT, request, sync, timeout)
  if GameSingle then
    return nil
  end
  if self.host == nil then
    return nil
  end
  Log.debug("[net] NetCaller: Send", request._className, self._serverTokenName)
  local id = GetCurTaskId()
  local reply = ReplyInfo:New()
  self.replies[id] = reply
  self.host:Call(request, id, sync, timeout)
  SUSPEND(TT)
  self.host:CallRecovered()
  self.replies[id] = nil
  return reply
end

function NetCaller:RetryCall(id)
  if self.host == nil then
    return nil
  end
  return self.host:RetryCall(id)
end

function NetCaller:ResetCallTimeout()
  if self.host == nil then
    return nil
  end
  return self.host:ResetCallTimeout()
end

function NetCaller:ResetCall(reason)
  if self.host == nil then
    return nil
  end
  self.host:ResetCall(reason)
end

function NetCaller:HandleCallDone(id, resultType, replyMessage)
  if replyMessage ~= nil then
    Log.debug("[net] NetCaller: Recv ", replyMessage._className, self._serverTokenName)
  end
  local reply = self.replies[id]
  if reply then
    reply.res = resultType
    reply.msg = replyMessage
  end
  if TaskManager:GetInstance():FindTask(id) == nil then
    Log.error("not find task ", id)
  elseif RESUME(TT, id) then
    if self.host == nil then
      return nil
    end
    self.host:CallRecovering()
  end
end

function NetCaller:IsCallTimeout()
  if self.host == nil then
    return nil
  end
  return self.host:IsCallTimeout()
end

function NetCaller:IsCallTimelong()
  if self.host == nil then
    return nil
  end
  return self.host:IsCallTimelong()
end

function NetCaller:HasSyncCall()
  if self.host == nil then
    return nil
  end
  return self.host:HasSyncCall()
end

function NetCaller:HandleConnectDone()
  if self.host == nil then
    return nil
  end
  self.host:Base_HandleConnectDone()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ConnectDone, self)
end

function NetCaller:HandleConnectFailed(reason)
  if self.host == nil then
    return nil
  end
  self.host:Base_HandleConnectFailed(reason)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ConnectFail, self, reason)
end

function NetCaller:HandleConnectClosed(reason)
  if self.host == nil then
    return nil
  end
  self.host:Base_HandleConnectClosed(reason)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ConnectClose, self, reason)
end

function NetCaller:HandleReceiveDone(msg)
  if self.host == nil then
    return nil
  end
  self.host:Base_HandleReceiveDone(msg)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ReceiveMessage, self, msg)
end

function NetCaller:HandleCallBegin(msg)
  if self.host == nil then
    return nil
  end
  self.host:Base_HandleCallBegin(msg)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CallBegin, self, msg)
end

function NetCaller:HandleCallEnd(msg)
  if self.host == nil then
    return nil
  end
  self.host:Base_HandleCallEnd(msg)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CallEnd, self, msg)
end

function NetCaller:HandleCallTimelong(msg)
  if self.host == nil then
    return nil
  end
  self.host:Base_HandleCallTimelong(msg)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CallTimelong, self, msg)
end

function NetCaller:HandleCallTimeout()
  if self.host == nil then
    return nil
  end
  self.host:Base_HandleCallTimeout()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CallTimeout, self)
end

NetCallerLua.BindStaticFunc(NetCaller)

function NetCaller:GetReportData()
  if self.host == nil then
    return nil
  end
  return self.host:GetReportData()
end

function NetCaller:UpdateNetworkCfgInfo(cfg)
  if self.host == nil then
    return
  end
  Log.debug("CEventSvrNetworkCfgPush:", tostring(cfg.max_wait_tick4_send), tostring(cfg.max_wait_tick4_recv), tostring(cfg.max_wait_tick4_connect), tostring(cfg.max_wait_tick4_calltimelong), tostring(cfg.resend_delay_cd), tostring(cfg.wait_tick4_report), cfg.network_cfg_ver)
  local infoDc = BaseUtil.NetworkCfgInfoDc:New()
  infoDc.network_cfg_ver = cfg.network_cfg_ver
  infoDc.max_wait_tick4_send = cfg.max_wait_tick4_send
  infoDc.max_wait_tick4_recv = cfg.max_wait_tick4_recv
  infoDc.max_wait_tick4_connect = cfg.max_wait_tick4_connect
  infoDc.max_wait_tick4_calltimelong = cfg.max_wait_tick4_calltimelong
  infoDc.resend_delay_cd = cfg.resend_delay_cd
  infoDc.wait_tick4_report = cfg.wait_tick4_report
  self.wait_tick4_report = cfg.wait_tick4_report
  self.host:UpdateNetworkCfgInfo(infoDc)
end
