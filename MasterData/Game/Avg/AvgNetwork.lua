local AvgNetwork = class("AvgNetwork", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function AvgNetwork:ctor()
  self.__avgCompleteTab = {}
  self.__avgCompleteMultiTab = {}
end

function AvgNetwork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_AVG_Complete, self, proto_csmsg.SC_AVG_Complete, self.SC_AVG_Complete)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_AVG_Complete_Multi, self, proto_csmsg.SC_AVG_Complete_Multi, self.SC_AVG_Complete_Multi)
end

function AvgNetwork:CS_AVG_Complete(avgId, op, callback)
  self.__avgCompleteTab.avgId = avgId
  self.__avgCompleteTab.op = op or 0
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete, proto_csmsg.CS_AVG_Complete, self.__avgCompleteTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete, callback, proto_csmsg_MSG_ID.MSG_SC_AVG_Complete)
end

function AvgNetwork:SC_AVG_Complete(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_AVG_Complete error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete, false)
    cs_WaitNetworkResponse:WaitComplete(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete, true)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete, msg.rewards)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function AvgNetwork:CS_AVG_Complete_Multi(avgIds, op, callback)
  self.__avgCompleteMultiTab.avgIds = avgIds
  self.__avgCompleteMultiTab.op = op or 0
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete_Multi, proto_csmsg.CS_AVG_Complete_Multi, self.__avgCompleteMultiTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete_Multi, callback, proto_csmsg_MSG_ID.MSG_SC_AVG_Complete_Multi)
end

function AvgNetwork:SC_AVG_Complete_Multi(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_AVG_Complete_Multi error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete_Multi, false)
    cs_WaitNetworkResponse:WaitComplete(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete_Multi)
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  if self.__avgCompleteMultiTab.op == 0 then
    for index, avgId in ipairs(self.__avgCompleteMultiTab.avgIds) do
      avgPlayCtrl:RecordAvgPlayed(avgId)
    end
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete_Multi, true)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_AVG_Complete_Multi, msg.rewards)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function AvgNetwork:Reset()
end

return AvgNetwork
