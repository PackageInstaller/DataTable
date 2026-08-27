local DungeonTowerNetworkCtrl = class("DungeonTowerNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function DungeonTowerNetworkCtrl:ctor()
  self.sendEnterTower = {
    formInfo = {}
  }
  self.sendRacingPick = {}
  self.sendHeroPass = {}
end

function DungeonTowerNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DUNGEONTOWER_Detail, self, proto_csmsg.SC_DUNGEONTOWER_Detail, self.SC_DUNGEONTOWER_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DUNGEONTOWER_Enter, self, proto_csmsg.SC_DUNGEONTOWER_Enter, self.SC_DUNGEONTOWER_Enter)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DUNGEONTOWER_Pick, self, proto_csmsg.SC_DUNGEONTOWER_Pick, self.SC_DUNGEONTOWER_Pick)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DUNGEONTOWER_RacingRankSelfDetail, self, proto_csmsg.SC_DUNGEONTOWER_RacingRankSelfDetail, self.SC_DUNGEONTOWER_RacingRankSelfDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DUNGEONTOWER_HeroPassDetail, self, proto_csmsg.SC_DUNGEONTOWER_HeroPassDetail, self.SC_DUNGEONTOWER_HeroPassDetail)
end

function DungeonTowerNetworkCtrl:CS_DUNGEONTOWER_Detail()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_Detail, proto_csmsg.CS_DUNGEONTOWER_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_Detail, proto_csmsg_MSG_ID.MSG_SC_DUNGEONTOWER_Detail)
end

function DungeonTowerNetworkCtrl:SC_DUNGEONTOWER_Detail(msg)
  PlayerDataCenter.dungeonTowerSData:InitTowerServerData(msg.towerData)
end

function DungeonTowerNetworkCtrl:CS_DUNGEONTOWER_Enter(towerId, floorId, formationData, callBack, starting, substitute)
  self.sendEnterTower.towerId = towerId
  self.sendEnterTower.floorId = floorId
  self.sendEnterTower.formInfo.formationId = formationData.id
  self.sendEnterTower.formInfo.fairyUid = formationData:GetFmtFairyUID()
  self.sendEnterTower.starting = starting
  self.sendEnterTower.substitute = substitute
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_Enter, proto_csmsg.CS_DUNGEONTOWER_Enter, self.sendEnterTower)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_Enter, callBack, proto_csmsg_MSG_ID.MSG_SC_DUNGEONTOWER_Enter, proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfEnter)
end

function DungeonTowerNetworkCtrl:SC_DUNGEONTOWER_Enter(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "DungeonTowerNetworkCtrl:SC_DUNGEONTOWER_Enter error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_Enter)
  end
end

function DungeonTowerNetworkCtrl:CS_DUNGEONTOWER_Pick(towerId, rewardId, callBack)
  self.sendRacingPick.towerId = towerId
  self.sendRacingPick.rewardId = rewardId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_Pick, proto_csmsg.CS_DUNGEONTOWER_Pick, self.sendRacingPick)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_Pick, callBack, proto_csmsg_MSG_ID.MSG_SC_DUNGEONTOWER_Pick)
end

function DungeonTowerNetworkCtrl:SC_DUNGEONTOWER_Pick(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "DungeonTowerNetworkCtrl:SC_DUNGEONTOWER_Pick error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_Pick)
  end
end

function DungeonTowerNetworkCtrl:CS_DUNGEONTOWER_RacingRankSelfDetail(callBack)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_RacingRankSelfDetail, proto_csmsg.CS_DUNGEONTOWER_RacingRankSelfDetail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_RacingRankSelfDetail, callBack, proto_csmsg_MSG_ID.MSG_SC_DUNGEONTOWER_RacingRankSelfDetail)
end

function DungeonTowerNetworkCtrl:SC_DUNGEONTOWER_RacingRankSelfDetail(msg)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_RacingRankSelfDetail, msg)
end

function DungeonTowerNetworkCtrl:CS_DUNGEONTOWER_HeroPassDetail(towerId, floorId, callBack)
  self.sendHeroPass.towerId = towerId
  self.sendHeroPass.floorId = floorId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_HeroPassDetail, proto_csmsg.CS_DUNGEONTOWER_HeroPassDetail, self.sendHeroPass)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_HeroPassDetail, callBack, proto_csmsg_MSG_ID.MSG_SC_DUNGEONTOWER_HeroPassDetail)
end

function DungeonTowerNetworkCtrl:SC_DUNGEONTOWER_HeroPassDetail(msg)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DUNGEONTOWER_HeroPassDetail, msg)
end

function DungeonTowerNetworkCtrl:Reset()
end

return DungeonTowerNetworkCtrl
