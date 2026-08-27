local ActivityFlipCardNetwork = class("ActivityFlipCardNetwork", NetworkCtrlBase)
local base = NetworkCtrlBase
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityFlipCardNetwork:ctor()
  self._drawTable = {}
  self._nextRoundTable = {}
  self._multiDrawTable = {}
end

function ActivityFlipCardNetwork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_FlipCards_Draw, self, proto_csmsg.SC_Activity_FlipCards_Draw, self.SC_Activity_FlipCards_Draw)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_FlipCards_Next_Round, self, proto_csmsg.SC_Activity_FlipCards_Next_Round, self.SC_Activity_FlipCards_Next_Round)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_FlipCards_Draw_Multi, self, proto_csmsg.SC_Activity_FlipCards_Draw_Multi, self.SC_Activity_FlipCards_Draw_Multi)
end

function ActivityFlipCardNetwork:CS_Activity_FlipCards_Draw(actId, idx, callback)
  self._drawTable.actId = actId
  self._drawTable.idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_FlipCards_Draw, proto_csmsg.CS_Activity_FlipCards_Draw, self._drawTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_FlipCards_Draw, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_FlipCards_Draw)
end

function ActivityFlipCardNetwork:SC_Activity_FlipCards_Draw(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_FlipCards_Draw error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_FlipCards_Draw)
    return
  end
  local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
  if flipCardCtrl == nil then
    return
  end
  local flipCardData = flipCardCtrl:GetFlipCardDataByActId(self._drawTable.actId)
  if flipCardData == nil then
    return
  end
  flipCardData:SetFlipCardDraw(msg.record)
end

function ActivityFlipCardNetwork:CS_Activity_FlipCards_Next_Round(actId, callback)
  self._nextRoundTable.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_FlipCards_Next_Round, proto_csmsg.CS_Activity_FlipCards_Next_Round, self._nextRoundTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_FlipCards_Next_Round, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_FlipCards_Next_Round)
end

function ActivityFlipCardNetwork:SC_Activity_FlipCards_Next_Round(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_FlipCards_Next_Round error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_FlipCards_Next_Round)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
  if flipCardCtrl == nil then
    return
  end
  local flipCardData = flipCardCtrl:GetFlipCardDataByActId(self._nextRoundTable.actId)
  if flipCardData == nil then
    return
  end
  flipCardData:SetFlipChooseNewRound(msg.round)
end

function ActivityFlipCardNetwork:CS_Activity_FlipCards_Draw_Multi(actId, idx, freeNum, callback)
  self._multiDrawTable.actId = actId
  self._multiDrawTable.idx = idx
  self._multiDrawTable.freeNum = freeNum
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_FlipCards_Draw_Multi, proto_csmsg.CS_Activity_FlipCards_Draw_Multi, self._multiDrawTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_FlipCards_Draw_Multi, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_FlipCards_Draw_Multi)
end

function ActivityFlipCardNetwork:SC_Activity_FlipCards_Draw_Multi(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_FlipCards_Draw_Multi error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_FlipCards_Draw_Multi)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
  if flipCardCtrl == nil then
    return
  end
  local flipCardData = flipCardCtrl:GetFlipCardDataByActId(self._multiDrawTable.actId)
  if flipCardData == nil then
    return
  end
  flipCardData:SetFlipCardDrawMulti(msg.record)
end

return ActivityFlipCardNetwork
