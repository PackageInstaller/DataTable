local EventDrawLotteryNetCtrl = class("EventDrawLotteryNetCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function EventDrawLotteryNetCtrl:ctor()
  self._msg = {}
end

function EventDrawLotteryNetCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_DrawLottery_Pick, self, proto_csmsg.SC_Activity_DrawLottery_Pick, self.SC_Activity_DrawLottery_Pick)
end

function EventDrawLotteryNetCtrl:CS_Activity_DrawLottery_Pick(actId, stageId, callback)
  self._msg.actId = actId
  self._msg.stage = stageId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_DrawLottery_Pick, proto_csmsg.CS_Activity_DrawLottery_Pick, self._msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_DrawLottery_Pick, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_DrawLottery_Pick)
end

function EventDrawLotteryNetCtrl:SC_Activity_DrawLottery_Pick(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_DrawLottery_Pick error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_DrawLottery_Pick)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Activity_DrawLottery_Pick, msg)
end

return EventDrawLotteryNetCtrl
