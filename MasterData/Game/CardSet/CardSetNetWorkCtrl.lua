local CardSetNetWorkCtrl = class("CardSetNetWorkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function CardSetNetWorkCtrl:ctor()
end

function CardSetNetWorkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_Card_Select, self, proto_csmsg.SC_BATTLE_Card_Select, self.SC_BATTLE_Card_Select)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_Card_Enter, self, proto_csmsg.SC_BATTLE_Card_Enter, self.SC_BATTLE_Card_Enter)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_Card_Round_Next, self, proto_csmsg.SC_BATTLE_Card_Round_Next, self.SC_BATTLE_Card_Round_Next)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_Card_Round_Select, self, proto_csmsg.SC_BATTLE_Card_Round_Select, self.SC_BATTLE_Card_Round_Select)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_Card_Round_Reset, self, proto_csmsg.SC_BATTLE_Card_Round_Reset, self.SC_BATTLE_Card_Round_Reset)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_Card_Round_Over, self, proto_csmsg.SC_BATTLE_Card_Round_Over, self.SC_BATTLE_Card_Round_Over)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Score_DelayUpdate, self, proto_csmsg.SC_Score_DelayUpdate, self.SC_Score_DelayUpdate)
end

function CardSetNetWorkCtrl:CS_BATTLE_Card_Select(activityFrameId, selectCardMsg, cardCat, roundId, callback)
  local msg = {
    actLongId = activityFrameId,
    data = selectCardMsg,
    cat = cardCat,
    roundId = roundId
  }
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Select, proto_csmsg.CS_BATTLE_Card_Select, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Select, callback, proto_csmsg_MSG_ID.MSG_SC_BATTLE_Card_Select)
end

function CardSetNetWorkCtrl:SC_BATTLE_Card_Select(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_BATTLE_Card_Select error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Select)
    return
  end
end

function CardSetNetWorkCtrl:CS_BATTLE_Card_Enter(activityFrameId, dungeonId, difficulty, formationData, cardCat, roundId, callback)
  local formInfo = {}
  formInfo.formationId = formationData.id
  formInfo.support = formationData:GetSupportHeroData()
  formInfo.fairyUid = formationData:GetFmtFairyUID()
  formInfo.officeAssit = formationData:GetFmtOfficeAssistData()
  local msg = {
    actLongId = activityFrameId,
    dungeonId = dungeonId,
    difficulty = difficulty,
    formInfo = formInfo,
    cat = cardCat,
    roundId = roundId
  }
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Enter, proto_csmsg.CS_BATTLE_Card_Enter, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Enter, callback, proto_csmsg_MSG_ID.MSG_SC_BATTLE_Card_Enter, proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfEnter)
end

function CardSetNetWorkCtrl:SC_BATTLE_Card_Enter(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_BATTLE_Card_Enter error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Enter)
    return
  end
end

function CardSetNetWorkCtrl:CS_BATTLE_Card_Round_Next(activityFrameId, cardCat, callback)
  self._Round_Next_Tab = self._Round_Next_Tab or {}
  self._Round_Next_Tab.actLongId = activityFrameId
  self._Round_Next_Tab.cat = cardCat
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Round_Next, proto_csmsg.CS_BATTLE_Card_Round_Next, self._Round_Next_Tab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Round_Next, callback, proto_csmsg_MSG_ID.MSG_SC_BATTLE_Card_Round_Next)
end

function CardSetNetWorkCtrl:SC_BATTLE_Card_Round_Next(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_BATTLE_Card_Round_Next error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Round_Next)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Round_Next, msg)
end

function CardSetNetWorkCtrl:CS_BATTLE_Card_Round_Select(activityFrameId, round, callback)
  self._Round_Select_Tab = self._Round_Select_Tab or {}
  self._Round_Select_Tab.actLongId = activityFrameId
  self._Round_Select_Tab.round = round
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Round_Select, proto_csmsg.CS_BATTLE_Card_Round_Select, self._Round_Select_Tab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Round_Select, callback, proto_csmsg_MSG_ID.MSG_SC_BATTLE_Card_Round_Select)
end

function CardSetNetWorkCtrl:SC_BATTLE_Card_Round_Select(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_BATTLE_Card_Round_Select error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Round_Select)
    return
  end
end

function CardSetNetWorkCtrl:CS_BATTLE_Card_Round_Reset(activityFrameId, cardCat, roundId, callback)
  self._RoundResetTab = self._RoundResetTab or {}
  self._RoundResetTab.actLongId = activityFrameId
  self._RoundResetTab.cat = cardCat
  self._RoundResetTab.roundId = roundId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Round_Reset, proto_csmsg.CS_BATTLE_Card_Round_Reset, self._RoundResetTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Round_Reset, callback, proto_csmsg_MSG_ID.MSG_SC_BATTLE_Card_Round_Reset)
end

function CardSetNetWorkCtrl:SC_BATTLE_Card_Round_Reset(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_BATTLE_Card_Round_Reset error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Round_Reset)
    return
  end
end

function CardSetNetWorkCtrl:CS_BATTLE_Card_Round_Over(activityFrameId, callback)
  self._RoundOverTab = self._RoundOverTab or {}
  self._RoundOverTab.actLongId = activityFrameId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Round_Over, proto_csmsg.CS_BATTLE_Card_Round_Over, self._RoundOverTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Round_Over, callback, proto_csmsg_MSG_ID.MSG_SC_BATTLE_Card_Round_Over)
end

function CardSetNetWorkCtrl:SC_BATTLE_Card_Round_Over(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_BATTLE_Card_Round_Over error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Round_Over)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Card_Round_Over, msg)
end

function CardSetNetWorkCtrl:SC_Score_DelayUpdate(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Score_DelayUpdate error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  MsgCenter:Broadcast(eMsgEventId.OnCardSetDelayUpd)
end

function CardSetNetWorkCtrl:Reset()
end

return CardSetNetWorkCtrl
