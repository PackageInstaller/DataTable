local StoreRoomNetworkCtrl = class("StoreRoomNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function StoreRoomNetworkCtrl:ctor()
  self.__sendPosition = {}
  self.__sendItem = {}
end

function StoreRoomNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Purchase, self, proto_csmsg.SC_EXPLORATION_STORE_Purchase, self.SC_EXPLORATION_STORE_Purchase)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Quit, self, proto_csmsg.SC_EXPLORATION_STORE_Quit, self.SC_EXPLORATION_STORE_Quit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Sold, self, proto_csmsg.SC_EXPLORATION_STORE_Sold, self.SC_EXPLORATION_STORE_Sold)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Refresh, self, proto_csmsg.SC_EXPLORATION_STORE_Refresh, self.SC_EXPLORATION_STORE_Refresh)
end

function StoreRoomNetworkCtrl:CS_EXPLORATION_STORE_Purchase(idx, position, action)
  self.__sendItem = {}
  self.__sendItem.position = position
  self.__sendItem.idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Purchase, proto_csmsg.CS_EXPLORATION_STORE_Purchase, self.__sendItem)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Purchase, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Purchase)
end

function StoreRoomNetworkCtrl:SC_EXPLORATION_STORE_Purchase(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Purchase)
    local err = "StoreRoomNetworkCtrl:SC_EXPLORATION_STORE_Purchase error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function StoreRoomNetworkCtrl:CS_EXPLORATION_STORE_Sold(position, itemId, action)
  self.__sendItem = {}
  self.__sendItem.position = position
  self.__sendItem.algId = itemId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Sold, proto_csmsg.CS_EXPLORATION_STORE_Sold, self.__sendItem)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Sold, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Sold)
end

function StoreRoomNetworkCtrl:SC_EXPLORATION_STORE_Sold(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Sold)
    local err = "StoreRoomNetworkCtrl:SC_EXPLORATION_STORE_Sold error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function StoreRoomNetworkCtrl:CS_EXPLORATION_STORE_Refresh(position, callBack)
  self.__sendPosition.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Refresh, proto_csmsg.CS_EXPLORATION_STORE_Refresh, self.__sendPosition)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Refresh, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Refresh)
end

function StoreRoomNetworkCtrl:SC_EXPLORATION_STORE_Refresh(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Refresh)
    local err = "StoreRoomNetworkCtrl:SC_EXPLORATION_STORE_Refresh error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function StoreRoomNetworkCtrl:CS_EXPLORATION_STORE_Quit(position)
  self.__sendPosition.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Quit, proto_csmsg.CS_EXPLORATION_STORE_Quit, self.__sendPosition)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Quit, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_STORE_Quit)
end

function StoreRoomNetworkCtrl:SC_EXPLORATION_STORE_Quit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_STORE_Quit)
    local err = "StoreRoomNetworkCtrl:SC_EXPLORATION_STORE_Quit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  if ExplorationManager.epCtrl == nil then
    return
  end
  ExplorationManager.epCtrl.storeCtrl:OnStoreQuit()
end

function StoreRoomNetworkCtrl:Reset()
end

return StoreRoomNetworkCtrl
