local TimingProductNetwork = class("TimingProductNetwork", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function TimingProductNetwork:ctor()
  self.send_PickFixedReward = {}
  self.send_TimingProduct_PickAll = {}
  self.send_TimingProduct_Detail = {}
end

function TimingProductNetwork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TimingProduct_Pick, self, proto_csmsg.SC_TimingProduct_Pick, self.SC_TimingProduct_Pick)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TimingProduct_PickAll, self, proto_csmsg.SC_TimingProduct_PickAll, self.SC_TimingProduct_PickAll)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TimingProduct_Detail, self, proto_csmsg.SC_TimingProduct_Detail, self.SC_TimingProduct_Detail)
end

function TimingProductNetwork:CS_TimingProduct_Pick(moduleId, rewardId, callBack)
  self.send_PickFixedReward.moduleId = moduleId
  self.send_PickFixedReward.id = rewardId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_Pick, proto_csmsg.CS_TimingProduct_Pick, self.send_PickFixedReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_Pick, callBack, proto_csmsg_MSG_ID.MSG_SC_TimingProduct_Pick)
end

function TimingProductNetwork:SC_TimingProduct_Pick(msg)
  local addItemDic = self:_GenAddItemNumDic(msg.syncUpdateDiff)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "TimingProductNetwork:SC_TimingProduct_Pick erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_Pick)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_Pick, addItemDic)
end

function TimingProductNetwork:CS_TimingProduct_PickAll(moduleId, callBack)
  self.send_TimingProduct_PickAll.moduleId = moduleId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_PickAll, proto_csmsg.CS_TimingProduct_PickAll, self.send_TimingProduct_PickAll)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_PickAll, callBack, proto_csmsg_MSG_ID.MSG_SC_TimingProduct_PickAll)
end

function TimingProductNetwork:SC_TimingProduct_PickAll(msg)
  local addItemDic = self:_GenAddItemNumDic(msg.syncUpdateDiff)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "TimingProductNetwork:SC_TimingProduct_PickAll erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_PickAll)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_PickAll, addItemDic)
end

function TimingProductNetwork:_GenAddItemNumDic(syncUpdateDiff)
  if syncUpdateDiff == nil or syncUpdateDiff.resource == nil or syncUpdateDiff.resource.backpack == nil then
    return table.emptytable
  end
  local addItemDic = {}
  for resId, v in pairs(syncUpdateDiff.resource.backpack.updates) do
    local lastNum = PlayerDataCenter:GetItemCount(resId)
    local addNum = v.count - lastNum
    addItemDic[resId] = addNum
  end
  return addItemDic
end

function TimingProductNetwork:CS_TimingProduct_Detail(moduleId, callBack)
  self.send_TimingProduct_Detail.moduleId = moduleId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_Detail, proto_csmsg.CS_TimingProduct_Detail, self.send_TimingProduct_Detail)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_Detail, callBack, proto_csmsg_MSG_ID.MSG_SC_TimingProduct_Detail)
end

function TimingProductNetwork:SC_TimingProduct_Detail(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "TimingProductNetwork:SC_TimingProduct_Detail erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_TimingProduct_Detail)
  end
end

function TimingProductNetwork:SC_TimingProduct_SyncUpdateDiff(msg)
  PlayerDataCenter.allTimingProduct:UpdAllTimingProduct(msg)
end

return TimingProductNetwork
