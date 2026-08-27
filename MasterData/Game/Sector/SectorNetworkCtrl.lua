local SectorNetworkCtrl = class("SectorNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local SectorAchievementData = require("Game.Sector.Data.SectorAchievementData")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function SectorNetworkCtrl:ctor()
  self._Resident_Unlock_Tab = {}
end

function SectorNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SECTOR_Achievement, self, proto_csmsg.SC_SECTOR_Achievement, self.OnRecvAchievement)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SECTOR_ChipSet, self, proto_csmsg.SC_SECTOR_ChipSet, self.OnRecvChipSet)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SECTOR_PickReward, self, proto_csmsg.SC_SECTOR_PickReward, self.OnRecvPickReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SECTOR_Detail, self, proto_csmsg.SC_SECTOR_Detail, self.SC_SECTOR_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SECTOR_SyncUpdateDiff, self, proto_csmsg.SC_SECTOR_SyncUpdateDiff, self.SC_SECTOR_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SECTOR_BattleFirstRewardPick, self, proto_csmsg.SC_SECTOR_BattleFirstRewardPick, self.On_SECTOR_BattleFirstRewardPick)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ENDLESS_Detail, self, proto_csmsg.SC_ENDLESS_Detail, self.SC_ENDLESS_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ENDLESS_SyncUpdateDiff, self, proto_csmsg.SC_ENDLESS_SyncUpdateDiff, self.SC_ENDLESS_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DAILYCHALLENGE_Detail, self, proto_csmsg.SC_DAILYCHALLENGE_Detail, self.SC_DAILYCHALLENGE_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_Detail, self, proto_csmsg.SC_WEEKLYCHALLENGE_Detail, self.SC_WEEKLYCHALLENGE_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_RankPage, self, proto_csmsg.SC_WEEKLYCHALLENGE_RankPage, self.SC_WEEKLYCHALLENGE_RankPage)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_SECTOR_Resident_Unlock, self, proto_csmsg.SC_SECTOR_Resident_Unlock, self.SC_SECTOR_Resident_Unlock)
end

function SectorNetworkCtrl:SendAchievement()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Achievement, proto_csmsg.CS_SECTOR_Achievement, table.emptytable)
  cs_WaitNetworkResponse:StartOrAddWait(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Achievement, proto_csmsg_MSG_ID.MSG_SC_SECTOR_Achievement)
end

function SectorNetworkCtrl:OnRecvAchievement(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    PlayerDataCenter.sectorAchievementDatas = SectorAchievementData.CreateAchivSectorData(msg.sectorData)
    PlayerDataCenter.sectorStage:InitSectorCostBuy(msg.sectorData)
  else
    local err = "SectorNetworkCtrl:OnRecvAchievement error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Achievement)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function SectorNetworkCtrl:SendChipSet()
  local tabMsg = {}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SECTOR_ChipSet, proto_csmsg.CS_SECTOR_ChipSet, tabMsg)
end

function SectorNetworkCtrl:OnRecvChipSet(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    local chipSet = {}
    if msg.data ~= nil then
      for sectorId, chipDic in pairs(msg.data) do
        for chipId, v in pairs(chipDic.chipData) do
          chipSet[chipId] = v
        end
      end
    end
    MsgCenter:Broadcast(eMsgEventId.SectorChipSet, chipSet)
  else
    local err = "SectorNetworkCtrl:OnRecvChipSet error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function SectorNetworkCtrl:SendPickReward(sectorId, id, callback)
  local tabMsg = {sectorId = sectorId, id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SECTOR_PickReward, proto_csmsg.CS_SECTOR_PickReward, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_SECTOR_PickReward, callback, proto_csmsg_MSG_ID.MSG_SC_SECTOR_PickReward)
end

function SectorNetworkCtrl:OnRecvPickReward(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    PlayerDataCenter.sectorAchievementDatas:UpdateAchivData(msg)
    MsgCenter:Broadcast(eMsgEventId.SectorPickReward, msg.sectorId, msg.id)
  else
    local err = "SectorNetworkCtrl:OnRecvPickReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_SECTOR_PickReward)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function SectorNetworkCtrl:CS_SECTOR_Detail()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Detail, proto_csmsg.CS_SECTOR_Detail, table.emptytable)
end

function SectorNetworkCtrl:SC_SECTOR_Detail(msg)
  PlayerDataCenter.sectorStage:UpdateStageData(msg.data, true)
  PlayerDataCenter.sectorStage:UpdateSectorPassTm(msg.records)
  MsgCenter:Broadcast(eMsgEventId.OnSectorStageStateChange, msg.data)
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.CompleteStage)
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.CompleteAvg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function SectorNetworkCtrl:SC_SECTOR_SyncUpdateDiff(msg)
  PlayerDataCenter.sectorStage:UpdateStageData(msg.update, false)
  PlayerDataCenter.sectorStage:UpdateSectorPassTmDiff(msg.updateStageRecord)
  MsgCenter:Broadcast(eMsgEventId.OnSectorStageStateChange, msg.update)
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.CompleteStage)
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.CompleteAvg)
  MsgCenter:Broadcast(eMsgEventId.SectorStateUpdate)
  PlayerDataCenter.sectorAchievementDatas:UpdAllStageChallengeQuest(msg.challengeQuest)
end

function SectorNetworkCtrl:Send_SECTOR_BattleFirstRewardPick(id)
  local tabMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SECTOR_BattleFirstRewardPick, proto_csmsg.CS_SECTOR_BattleFirstRewardPick, tabMsg)
end

function SectorNetworkCtrl:On_SECTOR_BattleFirstRewardPick(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    MsgCenter:Broadcast(eMsgEventId.PickFirstReward, msg.rewards)
  else
    local err = "On_SECTOR_BattleFirstRewardPick error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function SectorNetworkCtrl:CS_ENDLESS_Detail()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ENDLESS_Detail, proto_csmsg.CS_ENDLESS_Detail, table.emptytable)
end

function SectorNetworkCtrl:SC_ENDLESS_Detail(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    if msg.data == nil then
      return
    end
    PlayerDataCenter.infinityData:InitInfinityData(msg.data.highest, msg.data.processing)
  else
    local err = "SC_ENDLESS_Detail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function SectorNetworkCtrl:SC_ENDLESS_SyncUpdateDiff(msg)
  PlayerDataCenter.infinityData:UpdateInfinityData(msg.completed, msg.processingUpdate)
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.InfinityDungeon)
end

function SectorNetworkCtrl:CS_DAILYCHALLENGE_Detail(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Detail, proto_csmsg.CS_DAILYCHALLENGE_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_DAILYCHALLENGE_Detail)
end

function SectorNetworkCtrl:SC_DAILYCHALLENGE_Detail(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    PlayerDataCenter.periodicChallengeData:UpdateFromDailyChallengeMsg(msg)
  else
    local err = "SC_DAILYCHALLENGE_Detail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Detail)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function SectorNetworkCtrl:CS_WEEKLYCHALLENGE_Detail(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_Detail, proto_csmsg.CS_WEEKLYCHALLENGE_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_Detail)
end

function SectorNetworkCtrl:SC_WEEKLYCHALLENGE_Detail(msg)
  if msg ~= nil then
    PlayerDataCenter.allWeeklyChallengeData:UpdateByMsg(msg)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function SectorNetworkCtrl:CS_WEEKLYCHALLENGE_RankPage(isHistory, pageId, rankCat, callback)
  local msg = {
    history = isHistory or false,
    pageId = pageId or 1,
    rankCat = rankCat or 1
  }
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_RankPage, proto_csmsg.CS_WEEKLYCHALLENGE_RankPage, msg)
  if callback ~= nil then
    cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_RankPage, callback, proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_RankPage)
  end
end

function SectorNetworkCtrl:SC_WEEKLYCHALLENGE_RankPage(msg)
  local weeklyRankWin = UIManager:GetWindow(UIWindowTypeID.WeeklyChallengeRank)
  if weeklyRankWin ~= nil then
    weeklyRankWin:OnReceiveRankMsg(msg)
  end
end

function SectorNetworkCtrl:CS_SECTOR_Resident_Unlock(sectorId, callback)
  self._Resident_Unlock_Tab.sectorId = sectorId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Resident_Unlock, proto_csmsg.CS_SECTOR_Resident_Unlock, self._Resident_Unlock_Tab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Resident_Unlock, callback, proto_csmsg_MSG_ID.MSG_SC_SECTOR_Resident_Unlock)
end

function SectorNetworkCtrl:SC_SECTOR_Resident_Unlock(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_SECTOR_Resident_Unlock error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Resident_Unlock)
    return
  end
  PlayerDataCenter.sectorStage:SetSectorCostBuy(self._Resident_Unlock_Tab.sectorId)
end

function SectorNetworkCtrl:Reset()
end

return SectorNetworkCtrl
