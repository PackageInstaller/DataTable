local ActSigninLiveStreamNetWork = class("ActSigninLiveStreamNetWork", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActSigninLiveStreamNetWork:ctor()
end

function ActSigninLiveStreamNetWork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityOrder_Commit, self, proto_csmsg.SC_ActivityOrder_Commit, self.SC_ActivityOrder_Commit)
end

function ActSigninLiveStreamNetWork:CS_ActivityOrder_Commit(actLongId, callback)
  local msg = {}
  msg.actLongId = actLongId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityOrder_Commit, proto_csmsg.CS_ActivityOrder_Commit, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityOrder_Commit, callback, proto_csmsg_MSG_ID.MSG_SC_ActivityOrder_Commit)
end

function ActSigninLiveStreamNetWork:SC_ActivityOrder_Commit(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ActivityOrder_Commit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ActivityOrder_Commit)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ActivityOrder_Commit, msg.rewards)
end

return ActSigninLiveStreamNetWork
