local CShellconn = {}

function CShellconn:Init(netType)
  if string.lower(netType) == "kcp" then
    self.netManager = CS.Z1Client.Network.KcpSocketMgr.Instance
  else
    self.netManager = CS.Z1Client.Network.TcpSocketMgr.Instance
  end
  self.netType = netType
  self.out = {}
  self.connState = {
    Initiate = {
      CS.Z1Client.Network.SocketStatus.__CastFrom("Initiate"),
      "newconnect"
    },
    Handshaking = {
      CS.Z1Client.Network.SocketStatus.__CastFrom("Handshaking"),
      "connect"
    },
    Connected = {
      CS.Z1Client.Network.SocketStatus.__CastFrom("Connected"),
      "forward"
    },
    Disconnected = {
      CS.Z1Client.Network.SocketStatus.__CastFrom("Disconnected"),
      "connect_break"
    },
    Reconnecting = {
      CS.Z1Client.Network.SocketStatus.__CastFrom("Reconnecting"),
      "reconnect"
    },
    Terminate = {
      CS.Z1Client.Network.SocketStatus.__CastFrom("Terminate"),
      "close"
    }
  }
end

function CShellconn:ConnectServer(_ip, _port, svrType, isNative, cb)
  self.svrType = svrType or 0
  self.isNative = isNative or 0
  self.ip = _ip
  self.port = tonumber(_port)
  self.connect_cb = cb
  if type(cb) == "table" then
    self.connect_cb = cb.connCallback
    self.disconn_cb = cb.disconnCallback
  end
  self.netManager:SetLuaHandler(self.svrType, self.OnRecvdataCallback, self.OnConnectCallback, self.OnDisConnectCallback, self)
  do return self.netManager.Connect, self.netManager, self.ip, self.port, self.svrType end
  return self.netManager.Connect, self.netManager, self.ip, self.port, self.svrType, self.isNative, self
end

function CShellconn:ReConnectServer(cb)
  if not self:IsConnect() then
    self.connect_cb = cb
    local ret = self.netManager:Reconnect(self.svrType)
    Logger.Debug("-----ReConnect：", ret)
    return ret
  end
end

function CShellconn:GetSockName()
  return self.ip .. ":" .. self.port
end

function CShellconn:Send(msg)
  self.netManager:SendMsg(msg, self.svrType)
end

function CShellconn:IsConnect()
  do return self.netManager.IsConnected, self.netManager end
  return self.netManager.IsConnected, self.netManager, self.svrType
end

function CShellconn:GetSocketState()
  local state = self.netManager:GetConnectState(self.svrType)
  for _, v in pairs(self.connState) do
    if v[1] == state then
      self.luaState = v[2]
    end
  end
  if -1 == state then
    return false, "not find network, not connect.", self.connState.Initiate
  end
  if state ~= self.connState.Connected[1] then
    return false, "Not Connect", self.luaState
  end
  return true, nil, self.luaState
end

function CShellconn:DisConnect()
  self.netManager:DisConnect(self.svrType)
end

function CShellconn:Close()
  self.netManager:Close(self.svrType)
end

function CShellconn:Recv()
  if 0 == #self.out then
    return {}
  end
  local recvData = self.out
  self.out = {}
  return recvData
end

function CShellconn:Update(ms)
  Logger.Info("----------------- conn update")
  self.netManager:Update()
end

function CShellconn:OnDisConnectCallback(svrType, ret, msg)
  Logger.Debug("OnDisConnectCallback Server Ret=", ret, self.ip, self.port, self.svrType == svrType, msg)
  if self.disconn_cb and type(self.disconn_cb) == "function" then
    self.disconn_cb()
  end
end

function CShellconn:OnConnectCallback(svrType, ret, msg)
  Logger.Debug("OnConnectCallback Server Ret=", ret, self.ip, self.port, svrType, msg)
  if self.connect_cb and type(self.connect_cb) == "function" then
    self.connect_cb(ret, tonumber(msg))
  end
end

function CShellconn:OnRecvdataCallback(msg)
  table.insert(self.out, msg)
end

local function connect(network, addr, port, cb)
  local s = setmetatable({}, {__index = CShellconn})
  s:Init(network)
  if not s:ConnectServer(addr, port, 0, 0, cb) then
    Logger.Debug("Connect Server Faild", network, addr, port)
    return
  end
  return s
end

return {connect = connect}
