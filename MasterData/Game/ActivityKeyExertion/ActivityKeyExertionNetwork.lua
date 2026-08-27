local ActivityKeyExertionNetwork = class("ActivityKeyExertionNetwork", NetworkCtrlBase)
local base = NetworkCtrlBase
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityKeyExertionNetwork:ctor()
  self._taskRef = {}
end

function ActivityKeyExertionNetwork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_KeyExertion_PickAllReward, self, proto_csmsg.SC_ACTIVITY_KeyExertion_PickAllReward, self.SC_ACTIVITY_KeyExertion_PickAllReward)
end

function ActivityKeyExertionNetwork:CS_ACTIVITY_KeyExertion_PickAllReward(actId, callback)
  self._taskRef.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_KeyExertion_PickAllReward, proto_csmsg.CS_ACTIVITY_KeyExertion_PickAllReward, self._taskRef)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_KeyExertion_PickAllReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_KeyExertion_PickAllReward)
end

function ActivityKeyExertionNetwork:SC_ACTIVITY_KeyExertion_PickAllReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_KeyExertion_PickAllReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_KeyExertion_PickAllReward)
    return
  end
  UIUtil.ShowCommonReward(msg.rewards)
end

return ActivityKeyExertionNetwork
