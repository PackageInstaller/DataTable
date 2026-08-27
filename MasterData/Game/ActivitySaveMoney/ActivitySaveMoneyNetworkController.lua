local ActivitySaveMoneyNetworkController = class("ActivitySaveMoneyNetworkController", NetworkCtrlBase)
local base = NetworkCtrlBase
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivitySaveMoneyNetworkController:ctor()
  self._msg = {}
end

function ActivitySaveMoneyNetworkController:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_SaveMoney_Save, self, proto_csmsg.SC_ACTIVITY_SaveMoney_Save, self.SC_ACTIVITY_SaveMoney_Save)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_SaveMoney_GetReward, self, proto_csmsg.SC_ACTIVITY_SaveMoney_GetReward, self.SC_ACTIVITY_SaveMoney_GetReward)
end

function ActivitySaveMoneyNetworkController:CS_ACTIVITY_SaveMoney_Save(actId, saveLevel, callback)
  self._msg.actId = actId
  self._msg.saveLevel = saveLevel
  self._msg.stage = nil
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_SaveMoney_Save, proto_csmsg.CS_ACTIVITY_SaveMoney_Save, self._msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Season_PickLevelReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_SaveMoney_Save)
end

function ActivitySaveMoneyNetworkController:SC_ACTIVITY_SaveMoney_Save(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_SaveMoney_Save error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_SaveMoney_Save)
    return
  end
  UIUtil.ShowCommonReward(msg.rewards)
end

function ActivitySaveMoneyNetworkController:CS_ACTIVITY_SaveMoney_GetReward(actId, stage, callback)
  self._msg.actId = actId
  self._msg.saveLevel = nil
  self._msg.stage = stage
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_SaveMoney_GetReward, proto_csmsg.CS_ACTIVITY_SaveMoney_GetReward, self._msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_SaveMoney_GetReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_SaveMoney_GetReward)
end

function ActivitySaveMoneyNetworkController:SC_ACTIVITY_SaveMoney_GetReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_SaveMoney_GetReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_SaveMoney_GetReward)
    return
  end
  UIUtil.ShowCommonReward(msg.rewards)
end

return ActivitySaveMoneyNetworkController
