local DungeonSectorIINetworkCtrl = class("DungeonSectorIINetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function DungeonSectorIINetworkCtrl:ctor()
  self.sendEnterSectorIIDun = {
    formInfo = {}
  }
  self.dgVerifyEnterTab = {
    formInfo = {}
  }
  self.dgVerifySettleTab = {}
  self.dgVerifyPreviewScoreTab = {}
end

function DungeonSectorIINetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DUNGEONWINTER_Enter, self, proto_csmsg.SC_DUNGEONWINTER_Enter, self.SC_DUNGEONWINTER_Enter)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DUNGEONWinterVerify_Enter, self, proto_csmsg.SC_DUNGEONWinterVerify_Enter, self.SC_DUNGEONWinterVerify_Enter)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DUNGEONWinterVerify_Settle, self, proto_csmsg.SC_DUNGEONWinterVerify_Settle, self.SC_DUNGEONWinterVerify_Settle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DUNGEONWinterVerify_PreviewScore, self, proto_csmsg.SC_DUNGEONWinterVerify_PreviewScore, self.SC_DUNGEONWinterVerify_PreviewScore)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WINTERVerify_ScoreShow, self, proto_csmsg.SC_WINTERVerify_ScoreShow, self.SC_WINTERVerify_ScoreShow)
end

function DungeonSectorIINetworkCtrl:CS_DUNGEONWINTER_Enter(dungeonId, formationData, rewardRate, callback)
  self.sendEnterSectorIIDun.dungeonId = dungeonId
  self.sendEnterSectorIIDun.rewardRate = rewardRate
  self.sendEnterSectorIIDun.formInfo.formationId = formationData.id
  self.sendEnterSectorIIDun.formInfo.support = formationData:GetSupportHeroData()
  self.sendEnterSectorIIDun.formInfo.fairyUid = formationData:GetFmtFairyUID()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DUNGEONWINTER_Enter, proto_csmsg.CS_DUNGEONWINTER_Enter, self.sendEnterSectorIIDun)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONWINTER_Enter, callback, proto_csmsg_MSG_ID.MSG_SC_DUNGEONWINTER_Enter, proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfEnter)
end

function DungeonSectorIINetworkCtrl:SC_DUNGEONWINTER_Enter(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_DUNGEONWINTER_Enter error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONWINTER_Enter)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function DungeonSectorIINetworkCtrl:CS_DUNGEONWinterVerify_Enter(dungeonId, formationData, callback)
  self.dgVerifyEnterTab.dungeonId = dungeonId
  self.dgVerifyEnterTab.formInfo.formationId = formationData.id
  self.dgVerifyEnterTab.formInfo.fairyUid = formationData:GetFmtFairyUID()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DUNGEONWinterVerify_Enter, proto_csmsg.CS_DUNGEONWinterVerify_Enter, self.dgVerifyEnterTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONWinterVerify_Enter, callback, proto_csmsg_MSG_ID.MSG_SC_DUNGEONWinterVerify_Enter, proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfEnter)
end

function DungeonSectorIINetworkCtrl:SC_DUNGEONWinterVerify_Enter(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_DUNGEONWinterVerify_Enter error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONWinterVerify_Enter)
    return
  end
end

function DungeonSectorIINetworkCtrl:CS_DUNGEONWinterVerify_Settle(dungeonId, callback)
  self.dgVerifySettleTab.dungeonId = dungeonId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DUNGEONWinterVerify_Settle, proto_csmsg.CS_DUNGEONWinterVerify_Settle, self.dgVerifySettleTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONWinterVerify_Settle, callback, proto_csmsg_MSG_ID.MSG_SC_DUNGEONWinterVerify_Settle, proto_csmsg_MSG_ID.MSG_SC_WINTERVerify_ScoreShow)
end

function DungeonSectorIINetworkCtrl:SC_DUNGEONWinterVerify_Settle(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_DUNGEONWinterVerify_Settle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONWinterVerify_Settle)
    return
  end
  MsgCenter:Broadcast(eMsgEventId.WinterChallengeSettle)
end

function DungeonSectorIINetworkCtrl:MSG_CS_DUNGEONWinterVerify_PreviewScore(statDic, win, callback)
  self.dgVerifyPreviewScoreTab.stat = statDic
  self.dgVerifyPreviewScoreTab.win = win
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DUNGEONWinterVerify_PreviewScore, proto_csmsg.CS_DUNGEONWinterVerify_PreviewScore, self.dgVerifySettleTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONWinterVerify_PreviewScore, callback, proto_csmsg_MSG_ID.MSG_SC_DUNGEONWinterVerify_PreviewScore)
end

function DungeonSectorIINetworkCtrl:MSG_SC_DUNGEONWinterVerify_PreviewScore(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_DUNGEONWinterVerify_PreviewScore error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONWinterVerify_PreviewScore)
    return
  end
end

function DungeonSectorIINetworkCtrl:SC_ACTIVITYSCTORII_SyncDiff(msg)
  local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
  if sectorIICtrl ~= nil then
    sectorIICtrl:UpdSectorIIActivityByDiff(msg)
  end
end

function DungeonSectorIINetworkCtrl:SC_WINTERVerify_ScoreShow(msg)
  MsgCenter:Broadcast(eMsgEventId.WinterChallengeScoreShow, msg)
  if cs_WaitNetworkResponse:ContainWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONWinterVerify_Settle) then
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DUNGEONWinterVerify_Settle, msg)
  end
end

function DungeonSectorIINetworkCtrl:Reset()
end

return DungeonSectorIINetworkCtrl
