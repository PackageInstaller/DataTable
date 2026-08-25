local RpcDispatch = System.RpcDispatch
local cmsgpack = require("cmsgpack")
local msg_pack = cmsgpack.pack
local msg_unpack = cmsgpack.unpack
local emptyTable = {}
local NetworkProfiler = require("Foundation.Network.NetworkProfiler")
local RpcMgr, Super = System.NewClass("RpcMgr", Manager, IUpdater)
local cmd_common_call = "Base.CommonCall"
local cmd_common_send = "Base.CommonSend"
local cmd_battle_call = "Base.BattleCall"
local cmd_battle_send = "Base.BattleSend"
local cmd_block_data = "Base.BlockDataSend"

function RpcMgr:ctor()
  Super.ctor(self)
  self.network = nil
  self.update_network = false
  self.request_cb = {}
  if ApplicationUtils.is_editor_mode() then
    self.timeout = 60
  else
    self.timeout = 5
  end
  self.session_index = nil
  self.isLz4 = true
  self.block_datas = {}
end

function RpcMgr:SetTimeout(timeout)
  if ApplicationUtils.is_editor_mode() then
    self.timeout = 60
  else
    self.timeout = timeout
  end
end

function RpcMgr:SetRpcDispatchTarget(target)
  self.rpc_dispatch_target = target
end

function RpcMgr:SetUpdateCallback(func)
  self.update_callback = func
end

function RpcMgr:EnableNetworkUpdate(enable)
  self.update_network = enable
  Logger.Info("EnableNetworkUpdate", enable)
end

function RpcMgr:Update()
  if self.network then
    if self.update_network then
      local success, err, status = self.network:update()
      if self.update_callback then
        self.update_callback(success, status, err)
      end
      if not success then
        self:EnableNetworkUpdate(false)
      end
    end
  elseif self.update_callback then
    self.update_callback(false)
  end
end

function RpcMgr:GosconReconnect(cb)
  Logger.Info("RpcMgr.GosconReconnect", self.network, cb)
  if self.network and self.network.v_conn then
    self:EnableNetworkUpdate(false)
    local success, err = self.network.v_conn:reconnect(cb)
    Logger.Info("GosconReconnect.network:reconnect:", success, err)
    if not success then
      cb(false)
    else
      self:EnableNetworkUpdate(true)
    end
  else
    cb(false)
  end
end

function RpcMgr:NewReconnect(cb)
  if self.network then
    self:EnableNetworkUpdate(false)
    local success, err = self:Connect(self.connectionInfo.protocol, self.connectionInfo.host, self.connectionInfo.port, cb)
    if not success then
      cb(false)
    else
      self:EnableNetworkUpdate(true)
    end
  else
    cb(false)
  end
end

local function key_dispatch(key, args)
  local info = RpcDispatch.get_func_info_by_key(key)
  if not info then
    Logger.Error("key_dispatch error，找不到key %s", key)
    return
  end
  local model = ProtoManager.Instance.Protos[info.mod_name]
  if not model then
    Logger.Error("key_dispatch(%s)时在ProtoManager中找不到模块%s", key, info.mod_name)
    return
  end
  local ok, err_msg = RpcDispatch.key_dispatch(model, key, args)
  if not ok then
    Logger.Error("key_dispatch error %s, %s, %s", key, args, err_msg)
  end
end

local function cmd_dispatch(cmd, args)
  local info = RpcDispatch.get_func_info_by_cmd(cmd)
  if not info then
    Logger.Error("cmd_dispatch error，找不到cmd %s", cmd)
    return
  end
  local model = ProtoManager.Instance.Protos[info.mod_name]
  if not model then
    Logger.Error("cmd_dispatch(%s)时在ProtoManager中找不到模块%s", cmd, info.mod_name)
    return
  end
  local ok, err_msg = RpcDispatch.cmd_dispatch(nil, cmd, args)
  if not ok then
    Logger.Error("cmd_dispatch error %s, %s, %s", cmd, args, err_msg)
  end
end

function RpcMgr:Connect(protocol, host, port, cb, targetserver, flag)
  Logger.Debug("connect ", host, port, targetserver)
  self.block_datas = {}
  self.request_cb = {}
  self.connectionInfo = {
    protocol = protocol,
    host = host,
    port = port
  }
  local accept_encodings = ">lz4"
  self.network = self.network or network()
  if self.session_index then
    self.network.v_session_index = self.session_index
  end
  self:EnableNetworkUpdate(false)
  local obj, errcode = self.network:connect(protocol, host, port, targetserver, flag, accept_encodings, cb)
  if not obj then
    Logger.Error("Connect error %s, %s", obj, errcode)
    return false, errcode
  end
  self:EnableNetworkUpdate(true)
  self.network:set_default_request_handle(function(cmd, t)
    self:on_request(cmd, t)
  end)
  return true
end

function RpcMgr:Disconnect(isReconn)
  if self.network then
    self.session_index = self.network.v_session_index
    self.network.v_conn:close()
    if self.update_callback and isReconn then
      self.update_callback(false, "connect_break")
    end
  end
end

function RpcMgr:Close()
  if self.network then
    self.session_index = self.network.v_session_index
    if self.network.v_conn then
      self.network.v_conn:close()
    end
    if self.update_callback then
      self.update_callback(false, "close")
    end
    self:EnableNetworkUpdate(false)
  end
  self.request_cb = {}
end

function RpcMgr:CloseSocket(reason)
  if self.network and self.network.v_conn and self.network.v_conn.v_sock then
    Logger.Info("CloseSocket reason:", reason)
    if self.network.v_conn.v_sock.v_fd then
      self.network.v_conn.v_sock.v_fd.v_fd:close()
    end
  end
end

function RpcMgr:is_connect()
  if self.network and self.network.v_conn then
    do return self.network.v_conn.is_connect end
    return self.network.v_conn.is_connect, self.network.v_conn
  end
end

function RpcMgr:on_request(cmd, t)
  local profilerEnabled = NetworkProfiler.enabled
  local startTime = profilerEnabled and os.clock() or nil
  if cmd == cmd_common_send then
    t.args = self:MaybeBlockData(t.data_session, t.args)
    local unzipStart = profilerEnabled and os.clock() or nil
    local args = self:UnpackParma(t.args)
    if unzipStart then
      local unzipElapsed = os.clock() - unzipStart
      NetworkProfiler.Record(NetworkProfiler.NetworkProfilerType.Unzip, t.key, unzipElapsed)
    end
    key_dispatch(t.key, args)
    if startTime then
      local elapsed = os.clock() - startTime
      NetworkProfiler.Record(NetworkProfiler.NetworkProfilerType.Notify, t.key, elapsed)
    end
  elseif cmd == cmd_block_data then
    self:HandleBlockData(t)
    if startTime then
      local elapsed = os.clock() - startTime
      NetworkProfiler.Record(NetworkProfiler.NetworkProfilerType.Notify, "BlockData", elapsed)
    end
  elseif cmd == cmd_common_call then
    Logger.Error("client should not receive common_call")
  else
    cmd_dispatch(cmd, t)
    if startTime then
      local elapsed = os.clock() - startTime
      NetworkProfiler.Record(NetworkProfiler.NetworkProfilerType.Notify, cmd, elapsed)
    end
  end
end

function RpcMgr:HandleBlockData(request)
  local session = request.session
  local block_datas = self.block_datas
  if not block_datas[session] then
    assert(1 == request.idx, string.format("block data idx not correct session:%s idx:%s", session, request.idx))
    block_datas[session] = {request}
  else
    table.insert(block_datas[session], request)
    assert(request.idx == #block_datas[session], string.format("block data order not correct idx:%s len:%s", request.idx, #block_datas[session]))
  end
end

function RpcMgr:GetMergedBlockData(session)
  local block_datas = self.block_datas
  local requests = block_datas[session]
  block_datas[session] = nil
  if not requests or 0 == #requests then
    Logger.Error("GetMergedBlockData cannot find block data session:%s", session)
    return
  end
  local first_req = requests[1]
  if first_req.tn ~= #requests then
    Logger.Error("GetMergedBlockData block data tn not correct tn:%s n:%s", first_req.tn, #requests)
    return
  end
  local datas = {}
  for _, request in ipairs(requests) do
    table.insert(datas, request.data)
  end
  local datapack = table.concat(datas)
  if string.len(datapack) ~= first_req.tlen then
    Logger.Error("GetMergedBlockData block data tlen not correct tlen:%s len:%s", first_req.tlen, string.len(datapack))
  end
  Logger.Debug("GetMergedBlockData session:%s tlen:%s tn:%s", session, first_req.tlen, first_req.tn)
  return datapack
end

function RpcMgr:MaybeBlockData(session, ori_data)
  if session and session > 0 then
    return self:GetMergedBlockData(session) or ori_data
  else
    return ori_data
  end
end

function RpcMgr:CallResponse(response, session)
  local cb = self.request_cb[session]
  if cb then
    self.request_cb[session] = nil
    if cb[1] then
      TimerManager.Instance:StopTimer(cb[1])
    end
    local cbFunc = cb[4]
    local cbStartTime = cb[5]
    if cbStartTime and not cb.timedOut and NetworkProfiler.enabled then
      local elapsed = os.clock() - cbStartTime
      NetworkProfiler.Record(NetworkProfiler.NetworkProfilerType.Request, cbFunc or "", elapsed)
    end
    cb[2](cb[3], response)
  else
    Logger.Warn("CallResponse: no callback")
  end
end

function RpcMgr:Call(cmd, params, callback, callback_param)
  if "heart_beat" ~= cmd then
    Logger.Debug("RpcMgr:Call %s,%s,%s ", cmd, tostring(params), tostring(callback))
  end
  if callback then
    local session = self.network:call(cmd, params, self.CallResponse, self)
    assert(self.request_cb[session] == nil)
    local timerFinish = false
    local timer = TimerManager.Instance:CreateTimer(self.timeout, 0, nil, function()
      timerFinish = true
      local cb = self.request_cb[session]
      self.request_cb[session] = nil
      self:RpcTimeout(cb, cmd)
    end)
    if not timerFinish then
      local startTime = NetworkProfiler.enabled and os.clock() or nil
      self.request_cb[session] = {
        timer,
        callback,
        callback_param,
        cmd,
        startTime
      }
    end
  else
    self.network:invoke(cmd, params)
  end
end

function RpcMgr:CallCommonRpc(func, args, callback, obj, ...)
  if self:CanSend() then
    local params = {
      key = func,
      args = msg_pack(args)
    }
    if callback then
      local session = self.network:call(cmd_common_call, params, self.RpcResponse, self)
      assert(self.request_cb[session] == nil)
      local timerFinish = false
      local timer = TimerManager.Instance:CreateTimer(self.timeout, 0, nil, function()
        timerFinish = true
        Logger.Warn("call game timeout session=%s, func=%s", session, func)
        local cb = self.request_cb[session]
        if cb then
          cb.timedOut = true
        end
        self:RpcTimeout(nil, func)
      end)
      if not timerFinish then
        local startTime = NetworkProfiler.enabled and os.clock() or nil
        self.request_cb[session] = {
          timer,
          callback,
          obj,
          func,
          startTime,
          ...
        }
        self.timeoutCount = 0
      end
    else
      self.network:invoke(cmd_common_send, params)
    end
  end
end

function RpcMgr:CallBattleRpc(func, args, callback, obj, ...)
  if tostring(func) ~= "Move.OnMove" then
    Logger.Debug("RpcMgr:CallByRpc %s", tostring(func))
  end
  if self:CanSend() then
    local params = {
      key = func,
      args = msg_pack(args)
    }
    if callback then
      local session = self.network:call(cmd_battle_call, params, self.RpcResponse, self)
      assert(self.request_cb[session] == nil)
      local timerFinish = false
      local timer = TimerManager.Instance:CreateTimer(self.timeout, 0, nil, function()
        timerFinish = true
        Logger.Warn("call battlerpc timeout session=%s", session, func)
        local cb = self.request_cb[session]
        if cb then
          cb.timedOut = true
        end
        self:RpcTimeout(nil, func)
      end)
      if not timerFinish then
        local startTime = NetworkProfiler.enabled and os.clock() or nil
        self.request_cb[session] = {
          timer,
          callback,
          obj,
          func,
          startTime,
          ...
        }
        self.timeoutCount = 0
      end
    else
      self.network:invoke(cmd_battle_send, params)
    end
  end
end

function RpcMgr:CreateRpcClient(module, ...)
  do return require("Foundation.Network.RpcClient"), module, ... end
  return require("Foundation.Network.RpcClient"), module, ...
end

function RpcMgr:CreateRpcBattle(module, ...)
  do return require("Foundation.Network.RpcBattle"), module, ... end
  return require("Foundation.Network.RpcBattle"), module, ...
end

local Lz4 = require("lz4")

function RpcMgr:UnpackParma(param)
  local tmp = param or ""
  if self.isLz4 then
    tmp = Lz4.decompress(tmp)
  end
  do return msg_unpack end
  return msg_unpack, tmp
end

function RpcMgr:RpcResponse(response, session)
  response.result = self:MaybeBlockData(response.data_session, response.result)
  local cb = self.request_cb[session]
  if cb then
    self.request_cb[session] = nil
    local cbFunc = cb[4]
    local cbStartTime = cb[5]
    if 0 == response.ret then
      local unzipStart = NetworkProfiler.enabled and os.clock() or nil
      local param = self:UnpackParma(response.result)
      if unzipStart then
        local unzipElapsed = os.clock() - unzipStart
        NetworkProfiler.Record(NetworkProfiler.NetworkProfilerType.Unzip, cbFunc or "", unzipElapsed)
      end
      table.insert(cb, param)
      if cb[1] then
        TimerManager.Instance:StopTimer(cb[1])
      end
      if cbStartTime and not cb.timedOut and NetworkProfiler.enabled then
        local elapsed = os.clock() - cbStartTime
        NetworkProfiler.Record(NetworkProfiler.NetworkProfilerType.Request, cbFunc or "", elapsed)
      end
      cb[2](cb[3], param, table.unpack(cb, 6))
    else
      cb[2](cb[3], {
        response.result,
        -1
      })
      WaitingView.Instance:CancelAll()
      Logger.Error("response.ret is no 0, session=%s , RpcResponse: %s", session, table.tostring(response))
    end
  else
    local info = debug.getinfo(4, "Sl")
    Logger.Warn("RpcResponse: no callback session=%s , %s, %s", session, table.tostring(response), table.tostring(info))
  end
end

function RpcMgr:RpcTimeout(cb, cmd)
  if cb then
    cb[2](cb[3], {
      nil,
      {code = 0, msg = "超时"}
    })
  end
  if "Login.Heartbeat" == cmd or "World.OnRecover" == cmd or "Login.Login" == cmd then
    return
  end
  self.timeoutCount = (self.timeoutCount or 0) + 1
  if self.timeoutCount >= 1 then
    Logger.Warn("RpcResponse: RpcTimeout Count >= 1")
    self.timeoutCount = 0
  end
end

function RpcMgr:RegisterNotify(cmd, cb, param)
  if not self.network then
    Logger.Error("no network")
    return
  end
  self.network:register(cmd, cb, param)
end

function RpcMgr:UnRegisterNotify(cmd, cb)
  if not self.network then
    return
  end
  self.network:unregister(cmd, cb)
end

function RpcMgr:GetLocalAddress()
  do return self.network.get_local_address end
  return self.network.get_local_address, self.network
end

function RpcMgr:SetRpcRequestReconnectCb(cb)
  self.rpcRequestReconnectCb = cb
end

function RpcMgr:SetRpcRequest(ret)
  if self.rpcRequestReconnectCb then
    self.rpcRequestReconnectCb(ret)
  end
end

function RpcMgr:CanSend()
  return self.network and self.network.v_conn
end

return RpcMgr
