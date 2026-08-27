local ActivityBlackHoleNetworkCtrl = class("ActivityBlackHoleNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityBlackHoleNetworkCtrl:ctor()
  self._resetFloorTable = {}
  self._rewardTable = {}
end

function ActivityBlackHoleNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_BlackHole_Reset, self, proto_csmsg.SC_Activity_BlackHole_Reset, self.SC_Activity_BlackHole_Reset)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_BlackHole_Reward, self, proto_csmsg.SC_Activity_BlackHole_Reward, self.SC_Activity_BlackHole_Reward)
end

function ActivityBlackHoleNetworkCtrl:CS_Activity_BlackHole_Reset(actId, floorId, callback)
  self._resetFloorTable.actId = actId
  self._resetFloorTable.floorId = floorId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_BlackHole_Reset, proto_csmsg.CS_Activity_BlackHole_Reset, self._resetFloorTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_BlackHole_Reset, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_BlackHole_Reset)
end

function ActivityBlackHoleNetworkCtrl:SC_Activity_BlackHole_Reset(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "CS_Activity_BlackHole_Reset error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_BlackHole_Reset)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Activity_BlackHole_Reset, msg)
end

function ActivityBlackHoleNetworkCtrl:CS_Activity_BlackHole_Reward(actId, callback)
  self._rewardTable.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_BlackHole_Reward, proto_csmsg.CS_Activity_BlackHole_Reward, self._rewardTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_BlackHole_Reward, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_BlackHole_Reward)
end

function ActivityBlackHoleNetworkCtrl:SC_Activity_BlackHole_Reward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_BlackHole_Reward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_BlackHole_Reward)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Activity_BlackHole_Reward, msg)
end

return ActivityBlackHoleNetworkCtrl
