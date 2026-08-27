local ActivityShortTheatreNetorkCtrl = class("ActivityShortTheatreNetorkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityShortTheatreNetorkCtrl:ctor()
  self._msg = {}
end

function ActivityShortTheatreNetorkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivitySignTheater_SyncDiff, self, proto_csmsg.SC_ActivitySignTheater_SyncDiff, self.SC_ActivitySignTheater_SyncDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivitySignTheater_PickFinalReward, self, proto_csmsg.SC_ActivitySignTheater_PickFinalReward, self.SC_ActivitySignTheater_PickFinalReward)
end

function ActivityShortTheatreNetorkCtrl:SC_ActivitySignTheater_SyncDiff(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ActivitySignTheater_SyncDiff error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ActivitySignTheater_SyncDiff)
  end
end

function ActivityShortTheatreNetorkCtrl:CS_ActivitySignTheater_PickFinalReward(actId, callback)
  self._msg.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivitySignTheater_PickFinalReward, proto_csmsg.CS_ActivitySignTheater_PickFinalReward, self._msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivitySignTheater_PickFinalReward, callback, proto_csmsg_MSG_ID.MSG_SC_ActivitySignTheater_PickFinalReward)
end

function ActivityShortTheatreNetorkCtrl:SC_ActivitySignTheater_PickFinalReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ActivitySignTheater_PickFinalReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ActivitySignTheater_PickFinalReward)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ActivitySignTheater_PickFinalReward, msg)
end

return ActivityShortTheatreNetorkCtrl
