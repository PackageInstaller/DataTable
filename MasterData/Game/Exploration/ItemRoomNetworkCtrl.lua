local ItemRoomNetworkCtrl = class("TreasureRoomNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ItemRoomNetworkCtrl:ctor()
  self.__sendItem = {}
  self.__sendPosition = {}
end

function ItemRoomNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Select, self, proto_csmsg.SC_EXPLORATION_ITEM_Select, self.SC_EXPLORATION_ITEM_Select)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Quit, self, proto_csmsg.SC_EXPLORATION_ITEM_Quit, self.SC_EXPLORATION_ITEM_Quit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_LockUnlock, self, proto_csmsg.SC_EXPLORATION_ITEM_LockUnlock, self.SC_EXPLORATION_ITEM_LockUnlock)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Fresh, self, proto_csmsg.SC_EXPLORATION_ITEM_Fresh, self.SC_EXPLORATION_ITEM_Fresh)
end

function ItemRoomNetworkCtrl:CS_EXPLORATION_ITEM_Select(position, idx, action)
  if position == nil or idx == nil then
    return
  end
  self.__sendItem.position = position
  self.__sendItem.idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Select, proto_csmsg.CS_EXPLORATION_ITEM_Select, self.__sendItem)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Select, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Select)
end

function ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_Select(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Select)
    local err = "ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_Select error:" .. tostring(msg.ret)
    error(err)
    self:ShowSCErrorMsg(err)
    return
  end
end

function ItemRoomNetworkCtrl:CS_EXPLORATION_ITEM_Quit(position)
  if position == nil then
    return
  end
  self.__sendPosition.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Quit, proto_csmsg.CS_EXPLORATION_ITEM_Quit, self.__sendPosition)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Quit, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Quit)
end

function ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_Quit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Quit)
    local err = "ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_Quit error:" .. tostring(msg.ret)
    error(err)
    self:ShowSCErrorMsg(err)
    return
  end
  if ExplorationManager.epCtrl == nil then
    return
  end
  ExplorationManager.epCtrl.treasureCtrl:OnTreasureRoomQuit()
end

function ItemRoomNetworkCtrl:CS_EXPLORATION_ITEM_LockUnlock(position, idx)
  if position == nil or idx == nil then
    return
  end
  self.__sendItem.position = position
  self.__sendItem.idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_LockUnlock, proto_csmsg.CS_EXPLORATION_ITEM_LockUnlock, self.__sendItem)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_LockUnlock, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_LockUnlock)
end

function ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_LockUnlock(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_LockUnlock)
    local err = "ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_LockUnlock error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  if ExplorationManager.epCtrl == nil then
    return
  end
  ExplorationManager.epCtrl.treasureCtrl:OnItemLockOrUnlock()
end

function ItemRoomNetworkCtrl:CS_EXPLORATION_ITEM_Fresh(position)
  if position == nil then
    return
  end
  self.__sendPosition.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Fresh, proto_csmsg.CS_EXPLORATION_ITEM_Fresh, self.__sendPosition)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Fresh, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_ITEM_Fresh)
  if ExplorationManager.epCtrl ~= nil then
    ExplorationManager.epCtrl.treasureCtrl:OnRefreshTreasureRoom(true)
  end
end

function ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_Fresh(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_ITEM_Fresh)
    local err = "ItemRoomNetworkCtrl:SC_EXPLORATION_ITEM_Fresh error:" .. tostring(msg.ret)
    error(err)
    if ExplorationManager.epCtrl ~= nil then
      ExplorationManager.epCtrl.treasureCtrl:OnRefreshTreasureRoom(false)
    end
    return
  end
end

function ItemRoomNetworkCtrl:Reset()
end

return ItemRoomNetworkCtrl
