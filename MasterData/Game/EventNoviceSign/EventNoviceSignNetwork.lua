local EventNoviceSignNetwork = class("EventNoviceSignNetwork", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function EventNoviceSignNetwork:ctor()
  self._sendRecive = {}
end

function EventNoviceSignNetwork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SIGNACTIVITY_Detail, self, proto_csmsg.SC_SIGNACTIVITY_Detail, self.SC_SIGNACTIVITY_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SIGNACTIVITY_Pick, self, proto_csmsg.SC_SIGNACTIVITY_Pick, self.SC_SIGNACTIVITY_Pick)
end

function EventNoviceSignNetwork:CS_SIGNACTIVITY_Detail()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SIGNACTIVITY_Detail, proto_csmsg.CS_SIGNACTIVITY_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_SIGNACTIVITY_Detail, proto_csmsg_MSG_ID.MSG_SC_SIGNACTIVITY_Detail)
end

function EventNoviceSignNetwork:SC_SIGNACTIVITY_Detail(msg)
  if msg.ret == 0 then
    PlayerDataCenter.eventNoviceSignData:InitNoviceSignData(msg.signAct)
  else
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_SIGNACTIVITY_Detail)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function EventNoviceSignNetwork:CS_SIGNACTIVITY_Pick(id, callback)
  self._sendRecive = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SIGNACTIVITY_Pick, proto_csmsg.CS_SIGNACTIVITY_Pick, self._sendRecive)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_SIGNACTIVITY_Pick, callback, proto_csmsg_MSG_ID.MSG_SC_SIGNACTIVITY_Pick)
end

function EventNoviceSignNetwork:SC_SIGNACTIVITY_Pick(msg)
  if msg.ret == 0 then
    PlayerDataCenter.eventNoviceSignData:UpdateNoviceSignData(msg.elem)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_SIGNACTIVITY_Pick, msg.rewards)
  else
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_SIGNACTIVITY_Pick)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

return EventNoviceSignNetwork
