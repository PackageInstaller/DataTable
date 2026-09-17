local L_Net = {}
local Proto
local C_NetManager = CS.Azur.Gameplay.Core.Net.NetManager

function L_Net:initialize(proto)
  Proto = proto
  self.isOpenLog = C_NetManager.IsOpenLog
  self.listeners = {}
  self.onceListeners = {}
  self.heartReconnect = false
  self.specailSeqNoMsgIdDic = {
    [1001] = 1,
    [5001] = 1
  }
  self.receiveMessageFunc = handler(self, self._receiveMessage)
  self.clearOnceListenersFunc = handler(self, self._clearOnceListeners)
  local mainChannel = C_NetManager.GetChannel(C_NetChannel.Main)
  if mainChannel then
    local plugin = CS.Azur.Gameplay.Core.Net.NetLuaPlugin(self)
    mainChannel:AddPlugin(plugin)
  end
end

function L_Net:printNetLog(str, msgId, msgData, byteData)
  if self.isOpenLog then
    local msgDesc = ""
    str = str or ""
    msgId = msgId or ""
    if not string.isEmpty(msgId) then
      msgDesc = MsgGenCode.desc[msgId]
    end
    if msgData == nil and byteData ~= nil then
      msgData = Proto:decode(msgId, byteData)
    end
    printf(str .. msgId .. " " .. msgDesc, msgData)
  end
end

function L_Net:sendMessage(msgId, data, callback, channel, params)
  params = params or {}
  channel = channel or self:getDefaultChannel()
  if params.isMask == nil then
    params.isMask = true
  end
  if params.isLogin == nil then
    params.isLogin = false
  end
  self:printNetLog("=======[TRY MESSAGE SEND LUA]=======", msgId, data)
  local bytes = Proto:encode(msgId, data)
  local seqNo = C_NetManager.SendMessageLua(msgId, bytes, params.isMask == true, params.isLogin == true, channel)
  self:_setOnceListener(channel, msgId, seqNo, callback)
end

function L_Net:GetMessageKey(msgId, seqNo)
  return (msgId << 32) + (self.specailSeqNoMsgIdDic[msgId] or seqNo)
end

function L_Net:RegisterGameConnectEvent(status, callback)
  if not callback then
    return
  end
  C_NetManager.RegisterGameConnectEvent(status, callback)
end

function L_Net:UnregisterGameConnectEvent(status, callback)
  if not callback then
    return
  end
  C_NetManager.UnregisterGameConnectEvent(status, callback)
end

function L_Net:addListener(msgId, callback, channel)
  if not callback then
    return
  end
  channel = channel or self:getDefaultChannel()
  if not self.listeners[channel] then
    self.listeners[channel] = {}
  end
  if not self.listeners[channel][msgId] then
    self.listeners[channel][msgId] = {}
  end
  table.insert(self.listeners[channel][msgId], callback)
  C_NetManager.AddLuaProto(msgId)
end

function L_Net:removeListener(msgId, callback, channel)
  if not callback then
    return
  end
  channel = channel or self:getDefaultChannel()
  if self.listeners[channel] and self.listeners[channel][msgId] then
    table.removeBy(self.listeners[channel][msgId], callback, true)
    if #self.listeners[channel][msgId] == 0 then
      C_NetManager.RemoveLuaProto(msgId)
    end
  end
end

function L_Net:_receiveMessage(netMsgData)
  L_ProfilerUtil.BeginSample("lua net._receiveMessage")
  local channel = C_NetChannel.Main
  local msgId, seqNo, byteData, errorCode
  L_ProfilerUtil.BeginSample("lua net._receiveMessage.readFields")
  msgId = netMsgData.msgId
  seqNo = netMsgData.seqNo
  byteData = netMsgData.bytes
  errorCode = netMsgData.errorId
  L_ProfilerUtil.EndSample()
  if self.isOpenLog and errorCode ~= 0 then
    L_ProfilerUtil.BeginSample("lua net._receiveMessage.printNetLog")
    self:printNetLog(string.format("===MsgError=== MsgId:%s, ErrorCode:%s SeqNo:%s", msgId, errorCode, seqNo))
    L_ProfilerUtil.EndSample()
  end
  local netMsg, key, callback, listeners
  L_ProfilerUtil.BeginSample("lua net._receiveMessage.findListeners")
  key = self:GetMessageKey(msgId, seqNo)
  callback = self.onceListeners[channel] and self.onceListeners[channel][key]
  listeners = self.listeners[channel][msgId]
  L_ProfilerUtil.EndSample()
  if callback or listeners and 0 < #listeners then
    local error
    L_ProfilerUtil.BeginSample("lua net._receiveMessage.decode")
    netMsg, error = Proto:decode(msgId, byteData)
    L_ProfilerUtil.EndSample()
    if not netMsg then
      errorf("ProtoError:" .. (error or ""))
    end
    if callback then
      L_ProfilerUtil.BeginSample("lua net._receiveMessage.onceCallback")
      self.onceListeners[channel][key] = nil
      xpcall(callback, function(str)
        errorf(str, 2)
      end, netMsg, errorCode)
      L_ProfilerUtil.EndSample()
    end
    if listeners and 0 < #listeners then
      L_ProfilerUtil.BeginSample("lua net._receiveMessage.listeners")
      for _, listener in ipairs(listeners) do
        xpcall(listener, function(str)
          errorf(str, 2)
        end, netMsg, errorCode)
      end
      L_ProfilerUtil.EndSample()
    end
  end
  L_ProfilerUtil.BeginSample("lua net._receiveMessage.checkMissingRsp")
  if string.isEmpty(MsgGenCode.rsp[msgId]) and netMsgData.protoData == nil then
    if 0 < string.len(byteData) then
      errorf("客户端缺少协议 proto: " .. msgId)
    else
      warnf("协议 proto:" .. msgId .. " rsp 为空，不应收到回包")
    end
  end
  L_ProfilerUtil.EndSample()
  L_ProfilerUtil.EndSample()
end

function L_Net:getDefaultChannel()
  return C_NetChannel.Main
end

function L_Net:_setOnceListener(channel, msgId, seqNo, cb)
  if not cb then
    return
  end
  if not self.onceListeners[channel] then
    self.onceListeners[channel] = {}
  end
  local key = self:GetMessageKey(msgId, seqNo)
  self.onceListeners[channel][key] = cb
  C_NetManager.AddLuaProto(msgId)
end

function L_Net:_clearOnceListeners(channel)
  local listeners = self.onceListeners[channel]
  if listeners then
    self.onceListeners[channel] = {}
    local empty = {}
    for _, v in pairs(listeners) do
      xpcall(v, function(str)
        errorf(str, 2)
      end, empty, L_Const.localCallBackErrorCode)
    end
  end
end

return L_Net
