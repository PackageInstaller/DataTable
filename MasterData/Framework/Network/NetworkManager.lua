local NetworkManager = class("NetworkManager")
local pb = require("pb")
pb.option("int64_as_number")
pb.option("enum_as_value")
local cs_NetworkManager = CS.NetworkManager.Instance
local cs_NetMsgData = CS.NetMsgData
local cs_ResLoader = CS.ResLoader
local cs_Resources = CS.UnityEngine.Resources
local LuaNetworkAgent = require("Framework.Network.LuaNetworkAgent")

local function UpdateHandle(self)
end

function NetworkManager:ctor()
  self.luaNetworkAgent = LuaNetworkAgent.New()
  cs_NetworkManager.luaNetworkAgent = self.luaNetworkAgent
  self.__msgEventTable = {}
  self.__update_handle = UpdateBeat:CreateListener(UpdateHandle, self)
  UpdateBeat:AddListener(self.__update_handle)
  self.__packet_recv_handle = BindCallback(self, self._OnPacketRecv)
  cs_NetworkManager:onTcpPacket("+", self.__packet_recv_handle)
  self.__network_ctrls = {}
end

function NetworkManager:InitNetwork()
  local resloader = cs_ResLoader.Create()
  for k, v in ipairs(NetworkProtoFiles) do
    local pbTextAsset = resloader:LoadABAsset(PathConsts.PbFilePath .. v)
    pb.load(pbTextAsset.bytes)
    cs_Resources.UnloadAsset(pbTextAsset)
  end
  resloader:Put2Pool()
  for k, v in pairs(NetworkTypeID) do
    local config = NetworkGlobalConfig[v]
    local network = config.NetworkClass.New()
    self.__network_ctrls[v] = network
    network:InitNetwork()
  end
  local NetworkDiffDeliver = require("Framework.Network.NetworkDiffDeliver")
  self.networkDiffDeliver = NetworkDiffDeliver
end

function NetworkManager:HandleDiff(syncUpdateDiff)
  self.networkDiffDeliver:HandleDiff(syncUpdateDiff)
end

function NetworkManager:GetNetwork(networkId)
  local network = self.__network_ctrls[networkId]
  return network
end

function NetworkManager:_OnPacketRecv(msgData)
  if msgData == nil then
    return
  end
  local cmdId = msgData.CmdID
  if self.__msgEventTable[cmdId] ~= nil then
    self.__msgEventTable[cmdId](msgData)
  end
end

function NetworkManager:SendMsg(cmdId, msgContent)
  local msgData = cs_NetMsgData.Get()
  msgData.CmdID = cmdId
  msgData:Encode(msgContent)
  cs_NetworkManager:SendTcpMsg(msgData)
end

function NetworkManager:RegisterListener(cmdId, func)
  if self.__msgEventTable[cmdId] ~= nil then
    error("消息ID：" .. tostring(cmdId) .. " 已经注册！！")
    return
  end
  if cmdId == nil then
    print(cmdId)
  end
  self.__msgEventTable[cmdId] = func
end

function NetworkManager:UnRegisterListener(cmdId)
  self.__msgEventTable[cmdId] = nil
end

function NetworkManager:ResetAllNetwork()
  for k, v in pairs(self.__network_ctrls) do
    v:Reset()
  end
end

function NetworkManager:Delete()
  for k, v in pairs(self.__network_ctrls) do
    v:OnDelete()
  end
  UpdateBeat:RemoveListener(self.__update_handle)
  cs_NetworkManager:onTcpPacket("-", self.__packet_recv_handle)
end

return NetworkManager
