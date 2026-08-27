local WarehouseNetwork = class("WarehouseNetwork", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function WarehouseNetwork:ctor()
  self._sendUse = {}
  self._sendSelect = {}
  self._sendGroup = {}
end

function WarehouseNetwork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BACKPACK_UseItem, self, proto_csmsg.SC_BACKPACK_UseItem, self.SC_BACKPACK_UseItem)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BACKPACK_SelectItem, self, proto_csmsg.SC_BACKPACK_SelectItem, self.SC_BACKPACK_SelectItem)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BACKPACK_UseItemGroup, self, proto_csmsg.SC_BACKPACK_UseItemGroup, self.SC_BACKPACK_UseItemGroup)
end

function WarehouseNetwork:CS_BACKPACK_UseItem(itemId, num, callback)
  self._sendUse.id = itemId
  self._sendUse.num = num
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_UseItem, proto_csmsg.CS_BACKPACK_UseItem, self._sendUse)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_UseItem, callback, proto_csmsg_MSG_ID.MSG_SC_BACKPACK_UseItem)
end

function WarehouseNetwork:SC_BACKPACK_UseItem(msg)
  if msg.ret ~= 0 then
    local err = "SC_BACKPACK_UseItem:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_UseItem)
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  else
    local rewardDic = GameGlobalUtil.CollectDiffReward(msg.syncUpdateDiff)
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_UseItem, rewardDic)
  end
end

function WarehouseNetwork:CS_BACKPACK_SelectItem(itemId, num, selectItemIdList, callback)
  self._sendSelect.id = itemId
  self._sendSelect.num = num
  self._sendSelect.selected = {}
  for _, id in ipairs(selectItemIdList) do
    self._sendSelect.selected[id] = true
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_SelectItem, proto_csmsg.CS_BACKPACK_SelectItem, self._sendSelect)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_SelectItem, callback, proto_csmsg_MSG_ID.MSG_SC_BACKPACK_SelectItem)
end

function WarehouseNetwork:SC_BACKPACK_SelectItem(msg)
  if msg.ret ~= 0 then
    local err = "SC_BACKPACK_SelectItem:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_SelectItem)
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  else
    local rewardDic = GameGlobalUtil.CollectDiffReward(msg.syncUpdateDiff)
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_SelectItem, rewardDic)
  end
end

function WarehouseNetwork:CS_BACKPACK_UseItemGroup(group, callback)
  self._sendGroup.group = group
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_UseItemGroup, proto_csmsg.CS_BACKPACK_UseItemGroup, self._sendGroup)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_UseItemGroup, callback, proto_csmsg_MSG_ID.MSG_SC_BACKPACK_UseItemGroup)
end

function WarehouseNetwork:SC_BACKPACK_UseItemGroup(msg)
  if msg.ret ~= 0 then
    local err = "SC_BACKPACK_UseItemGroup:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BACKPACK_UseItem)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

return WarehouseNetwork
