local ActivitySpring24NetCtrl = class("ActivitySpring24NetCtrl", NetworkCtrlBase)
local base = NetworkCtrlBase
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local cs_MessageCommon = CS.MessageCommon

function ActivitySpring24NetCtrl:ctor()
  self.digRewardMsg = {}
end

function ActivitySpring24NetCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActTreasureHunt_Dig, self, proto_csmsg.SC_ActTreasureHunt_Dig, self.SC_ActTreasureHunt_Dig)
end

function ActivitySpring24NetCtrl:CS_ActTreasureHunt_Dig(actId, seq, callback)
  self.digRewardMsg.actId = actId
  self.digRewardMsg.seq = seq
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActTreasureHunt_Dig, proto_csmsg.CS_ActTreasureHunt_Dig, self.digRewardMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActTreasureHunt_Dig, callback, proto_csmsg_MSG_ID.MSG_SC_ActTreasureHunt_Dig)
end

function ActivitySpring24NetCtrl:SC_ActTreasureHunt_Dig(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.err ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ActTreasureHunt_Dig error:" .. tostring(msg.err)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ActTreasureHunt_Dig)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ActTreasureHunt_Dig, msg)
end

return ActivitySpring24NetCtrl
