local ActivitySpringNetwork = class("ActivitySpringNetwork", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivitySpringNetwork:ctor()
  self._interactTable = {}
end

function ActivitySpringNetwork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Spring_Interact, self, proto_csmsg.SC_ACTIVITY_Spring_Interact, self.SC_ACTIVITY_Spring_Interact)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Spring_SyncDiff, self, proto_csmsg.SC_ACTIVITY_Spring_SyncDiff, self.SC_ACTIVITY_Spring_SyncDiff)
end

function ActivitySpringNetwork:CS_ACTIVITY_Spring_Interact(actId, interactId, callback)
  self._interactTable.actId = actId
  self._interactTable.interactId = interactId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Spring_Interact, proto_csmsg.CS_ACTIVITY_Spring_Interact, self._interactTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Spring_Interact, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Spring_Interact)
end

function ActivitySpringNetwork:SC_ACTIVITY_Spring_Interact(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Spring_Interact error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Spring_Interact)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Spring_Interact, msg)
end

function ActivitySpringNetwork:SC_ACTIVITY_Spring_SyncDiff(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

return ActivitySpringNetwork
