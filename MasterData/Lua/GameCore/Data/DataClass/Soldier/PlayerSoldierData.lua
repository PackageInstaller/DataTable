local PlayerSoldierData = class("PlayerSoldierData")
local PlayerSoldierRecommendData = require("GameCore.Data.DataClass.Soldier.PlayerSoldierRecommendData")
local PlayerSoldierTechnologyData = require("GameCore.Data.DataClass.Soldier.PlayerSoldierTechnologyData")

function PlayerSoldierData:Init()
  self.recommendData = PlayerSoldierRecommendData.new()
  self.technologyData = PlayerSoldierTechnologyData.new()
  self.recommendData:InitData()
  self.technologyData:InitData()
  self.nCurSelectSeasonId = 0
  self.nSeasonType = 0
  self.nRewardLv = 0
  self.nReceivedRewardLv = 0
  self.nRewardExp = 0
  self.nHighestChallengeId = 0
  self.nGradeChallengeExp = 0
  self.curChallengeData = {
    nGradeChallengeId = 0,
    nStage = 0,
    nNodeIndex = 0
  }
  self.curLevel = nil
  self.nRewardExp = 0
  self.tbGuideData = {}
  self:InitConfig()
end

function PlayerSoldierData:UnInit()
  if self.curLevel ~= nil then
    self.curLevel:Exit()
    self.curLevel = nil
  end
end

function PlayerSoldierData:InitConfig()
  local function func_ForEach_SoldierPartner(mapLine)
    CacheTable.SetField("_SoldierPartner", mapLine.PartnerType, mapLine.Level, mapLine)
  end
  
  ForEachTableLine(ConfigTable.Get("SoldierPartner"), func_ForEach_SoldierPartner)
  
  local function func_ForEach_SoldierPositionEffect(mapLine)
    CacheTable.SetField("_SoldierPositionEffect", mapLine.PositionType, mapLine.Index, mapLine)
  end
  
  ForEachTableLine(ConfigTable.Get("SoldierPositionEffect"), func_ForEach_SoldierPositionEffect)
  
  local function func_ForEach_SoldierPartnerGroup(mapLine)
    CacheTable.SetData("_SoldierPartnerGroup", mapLine.PartnerType, mapLine)
  end
  
  ForEachTableLine(ConfigTable.Get("SoldierPartnerGroup"), func_ForEach_SoldierPartnerGroup)
  local _mapSoldierNodePlan = {}
  
  local function func_ForEach_SoldierNodePlan(mapLine)
    if _mapSoldierNodePlan[mapLine.NodeGroupId] == nil then
      _mapSoldierNodePlan[mapLine.NodeGroupId] = {}
    end
    table.insert(_mapSoldierNodePlan[mapLine.NodeGroupId], mapLine)
  end
  
  ForEachTableLine(ConfigTable.Get("SoldierNodePlan"), func_ForEach_SoldierNodePlan)
  for nGroupId, list in pairs(_mapSoldierNodePlan) do
    table.sort(list, function(a, b)
      return a.Index < b.Index
    end)
    CacheTable.SetData("_SoldierNodePlan", nGroupId, list)
  end
  
  local function func_ForEach_SoldierChessType(mapLine)
    CacheTable.SetData("_SoldierChessType", mapLine.ChessType, mapLine)
  end
  
  ForEachTableLine(ConfigTable.Get("SoldierChessType"), func_ForEach_SoldierChessType)
  
  local function func_ForEach_SoldierCheckStageAddScore(mapLine)
    if nil == CacheTable.GetData("_SoldierCheckStageAddScore", mapLine.Group) then
      CacheTable.SetData("_SoldierCheckStageAddScore", mapLine.Group, {})
    end
    CacheTable.InsertData("_SoldierCheckStageAddScore", mapLine.Group, mapLine)
  end
  
  ForEachTableLine(ConfigTable.Get("SoldierCheckStageAddScore"), func_ForEach_SoldierCheckStageAddScore)
end

function PlayerSoldierData:UpdateSoldierState(mapMsgData)
  self.nCurSelectSeasonId = mapMsgData.CurSeasonId
  self:SetCurGradeChallengeData(mapMsgData.CurGradeChallengeId, mapMsgData.Stage, mapMsgData.NodeIndex)
end

function PlayerSoldierData:SetCurSelectSeasonId(nSeasonId)
  self.nCurSelectSeasonId = nSeasonId or 0
  local mapData = ConfigTable.GetData("SoldierSeason", nSeasonId) or {} or {}
  if mapData ~= nil then
    self.nSeasonType = mapData.Season
  end
end

function PlayerSoldierData:GetCurSelectSeasonId()
  return self.nCurSelectSeasonId or 0
end

function PlayerSoldierData:GetCurLevelData()
  return self.curLevel
end

function PlayerSoldierData:CheckInSoldierLevel()
  return self:GetCurGradeChallengeId() ~= 0
end

function PlayerSoldierData:RefreshRewardRedDot()
  RedDotManager.SetValid(RedDotDefine.Soldier_TotalReward, nil, self.nReceivedRewardLv < self.nRewardLv)
end

function PlayerSoldierData:RequestSoldierSeasonInfo(callback)
  local function cb(_, netMsg)
    self.nRewardLv = netMsg.RewardLv
    
    self.nReceivedRewardLv = netMsg.CurRewardLv
    self.nRewardExp = netMsg.RewardExp
    self.nHighestChallengeId = netMsg.CurGradeChallengeId
    self.nGradeChallengeExp = netMsg.CurGradeExp
    if self.nHighestChallengeId == nil or self.nHighestChallengeId == 0 then
      local nMinId = math.huge
      ForEachTableLine(ConfigTable.Get("SoldierGradeChallenge"), function(mapLine)
        if mapLine.Id < nMinId and mapLine.Season == self.nCurSelectSeasonId then
          nMinId = mapLine.Id
        end
      end)
      self.nHighestChallengeId = nMinId
    end
    PlayerData.Guide:SetGuideNewbie(netMsg.Newbies)
    self:RefreshRewardRedDot()
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.soldier_season_info_req, {
    Value = self.nCurSelectSeasonId
  }, nil, cb)
end

function PlayerSoldierData:EnterSoldier(nGradeChallengeId, callback)
  if self:GetCurGradeChallengeId() == 0 then
    self:SendApply(self.nCurSelectSeasonId, nGradeChallengeId, callback)
  else
    self:SendInfo(callback)
  end
end

function PlayerSoldierData:SoldierLevelEnd(bClear)
  if self.curLevel ~= nil then
    self.curLevel:Exit()
    self.curLevel = nil
  end
  if bClear then
    self:SetCurGradeChallengeData(0, 0, 0)
    self:ClearInSoldierRecommendData()
  end
end

function PlayerSoldierData:SendApply(nSeasonId, nGradeChallengeId, callback)
  local function netCallback(_, netMsg)
    self:SetCurGradeChallengeData(nGradeChallengeId, 0, 0)
    
    self:ClearInSoldierRecommendData()
    if self.curLevel == nil then
      self.curLevel = require("Game.Adventure.Soldier.SoldierLevelData").new()
    end
    self.curLevel:Init(self, netMsg.Info, netMsg.Change, true)
    if callback ~= nil then
      callback()
    end
  end
  
  local sendMsg = {SeasonId = nSeasonId, GradeChallengeId = nGradeChallengeId}
  HttpNetHandler.SendMsg(NetMsgId.Id.soldier_apply_req, sendMsg, nil, netCallback)
end

function PlayerSoldierData:SendInfo(callback)
  local function netCallback(_, netMsg)
    if self.curLevel == nil then
      self.curLevel = require("Game.Adventure.Soldier.SoldierLevelData").new()
    end
    self.curLevel:Init(self, netMsg)
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.soldier_info_req, {}, nil, netCallback)
end

function PlayerSoldierData:SendStepOut(callback)
  local function netCallback(_, netMsg)
    if self.curLevel ~= nil then
      self.curLevel:StepOut()
    end
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.soldier_step_out_req, {}, nil, netCallback)
end

function PlayerSoldierData:SendGiveUp(callback)
  local function netCallback(_, netMsg)
    self:SetCurGradeChallengeData(0, 0, 0)
    
    self:ClearInSoldierRecommendData()
    if netMsg.Change ~= nil then
      local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(netMsg.Change)
      HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    end
    if self.curLevel ~= nil then
      self.curLevel:GiveUp(netMsg)
    else
      local tbSettle = {
        nPassedNode = netMsg.PassedNode,
        nRemainingHp = netMsg.RemainingHp,
        nCheckStageDps = netMsg.CheckStageDps,
        nCheckStageTime = netMsg.CheckStageTime,
        nChessTotalCost = netMsg.ChessTotalCost,
        nGetSchedule = netMsg.GetSchedule,
        nGetTechPoint = netMsg.GetTechPoint,
        nGetGradeExp = netMsg.GetGradeExp,
        nCurGradeChallengeId = netMsg.CurGradeChallengeId,
        nCurGradeExp = netMsg.CurGradeExp,
        nEndingId = netMsg.EndingId,
        nTotalCoinQty = netMsg.TotalCoinQty
      }
    end
    self.technologyData:RefreshRedDot(self.nCurSelectSeasonId)
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.soldier_give_up_req, {}, nil, netCallback)
end

function PlayerSoldierData:SetHighestChallengeId(nHighestChallengeId)
  self.nHighestChallengeId = math.max(self.nHighestChallengeId, nHighestChallengeId)
end

function PlayerSoldierData:GetHighestChallengeId()
  return self.nHighestChallengeId
end

function PlayerSoldierData:GetChallengeExp()
  return self.nGradeChallengeExp
end

function PlayerSoldierData:SetCurGradeChallengeData(nGradeChallengeId, nStage, nNodeIndex)
  self.curChallengeData = {
    nGradeChallengeId = nGradeChallengeId,
    nStage = nStage,
    nNodeIndex = nNodeIndex
  }
end

function PlayerSoldierData:GetCurChallengeData()
  return self.curChallengeData
end

function PlayerSoldierData:GetCurGradeChallengeId()
  return self.curChallengeData and self.curChallengeData.nGradeChallengeId or 0
end

function PlayerSoldierData:GetCheckStageAddScoreId(nDamage, nTime)
  local nGradeChallengeId = self.curChallengeData and self.curChallengeData.nGradeChallengeId or 0
  local mapChallenge = ConfigTable.GetData("SoldierGradeChallenge", nGradeChallengeId)
  if mapChallenge == nil then
    return 0, 0
  end
  local tbList = CacheTable.GetData("_SoldierCheckStageAddScore", mapChallenge.CheckStageGroupId)
  if tbList == nil then
    return 0, 0
  end
  nDamage = nDamage or 0
  nTime = nTime or 0
  local nDamageId, nTimeId = 0, 0
  for _, v in ipairs(tbList) do
    if nDamage >= v.DPS then
      nDamageId = v.Id
    end
    if nTime >= v.Duration then
      nTimeId = v.Id
    end
  end
  return nDamageId, nTimeId
end

function PlayerSoldierData:CheckChallengeUnlocked(nGradeChallengeId)
  local config = ConfigTable.GetData("SoldierGradeChallenge", nGradeChallengeId)
  if config == nil then
    return false
  end
  if config.UnlockGradeLevel == 0 then
    return true
  end
  if self.nHighestChallengeId == 0 then
    return false
  end
  local highestChallengeConfig = ConfigTable.GetData("SoldierGradeChallenge", self.nHighestChallengeId)
  if highestChallengeConfig == nil then
    return true
  end
  return config.UnlockGradeLevel <= highestChallengeConfig.Id
end

function PlayerSoldierData:GetTotalRewardLevel()
  local nPrevLevelExp = 0
  local nNextLevelExp = 0
  local nNextLevelTotalReward
  ForEachTableLine(ConfigTable.Get("SoldierTotalReward"), function(mapData)
    if mapData.Level == self.nRewardLv and self.nCurSelectSeasonId == mapData.SeasonId then
      nPrevLevelExp = mapData.NeedExp
    elseif self.nCurSelectSeasonId == mapData.SeasonId and mapData.Level == self.nRewardLv + 1 then
      nNextLevelExp = mapData.NeedExp
      nNextLevelTotalReward = {
        Tid = mapData.RewardId,
        Qty = mapData.RewardQty
      }
    end
  end)
  return self.nRewardLv, self.nRewardExp, nNextLevelExp, nNextLevelTotalReward
end

function PlayerSoldierData:GetReceivedTotalRewardLevel()
  return self.nReceivedRewardLv
end

function PlayerSoldierData:GetCurRewardLv()
  return self.nRewardLv or 0
end

function PlayerSoldierData:RequestGetTotalReward(callback)
  local function cb(_, msg)
    if callback ~= nil then
      callback()
    end
    UTILS.OpenReceiveByChangeInfo(msg.Change)
    self.nReceivedRewardLv = msg.CurRewardLv
    self:RefreshRewardRedDot()
    EventManager.Hit(EventId.Soldier_Level_GetReward)
  end
  
  local cfg = ConfigTable.GetData("SoldierSeason", self.nCurSelectSeasonId)
  if cfg == nil then
    return
  end
  HttpNetHandler.SendMsg(NetMsgId.Id.soldier_season_reward_receive_req, {
    Value = cfg.Season
  }, nil, cb)
end

function PlayerSoldierData:SendFavoriteRecommend(sCode, callback)
  self.recommendData:SendFavoriteRecommend(sCode, callback)
end

function PlayerSoldierData:SendUnfavoriteRecommend(sCode, callback)
  self.recommendData:SendUnfavoriteRecommend(sCode, callback)
end

function PlayerSoldierData:RequestRecommendList(callback)
  self.recommendData:RequestRecommendList(callback)
end

function PlayerSoldierData:GetCurRecommendList()
  return self.recommendData:GetCurRecommendList()
end

function PlayerSoldierData:GetSystemRecommendList()
  return self.recommendData:GetSystemRecommendList()
end

function PlayerSoldierData:GetCollectRecommendList()
  return self.recommendData:GetCollectRecommendList()
end

function PlayerSoldierData:SetRecommendData(nRecommendId, bInSoldier)
  self.recommendData:SetRecommendData(nRecommendId, bInSoldier)
end

function PlayerSoldierData:GetRecommendData(bInSoldier)
  return self.recommendData:GetRecommendData(bInSoldier)
end

function PlayerSoldierData:GetAllRecommendData()
  return self.recommendData:GetAllRecommendData()
end

function PlayerSoldierData:GetSoldierPositionEffectDataId(nIndex)
  return self.recommendData:GetSoldierPositionEffectDataId(nIndex)
end

function PlayerSoldierData:ClearInSoldierRecommendData()
  self.recommendData:ClearInSoldierRecommendData()
end

function PlayerSoldierData:CheckChessRecommendState(nChessId)
  return self.recommendData:CheckChessRecommendState(nChessId)
end

function PlayerSoldierData:CheckPartnerRecommendState(nPartnerType)
  return self.recommendData:CheckPartnerRecommendState(nPartnerType)
end

function PlayerSoldierData:GetTechActiveClientEffect()
  if self.nCurSelectSeasonId == 0 then
    return
  end
  return self.technologyData:GetActiveClientEffect(self.nCurSelectSeasonId)
end

function PlayerSoldierData:CheckTechNodeActiveById(nTechNodeId)
  if self.nCurSelectSeasonId == 0 then
    return
  end
  return self.technologyData:CheckTechNodeActiveById(self.nCurSelectSeasonId, nTechNodeId)
end

function PlayerSoldierData:GetClientBattleBuffList()
  if self.nCurSelectSeasonId == 0 then
    return
  end
  return self.technologyData:GetClientBattleBuffList(self.nCurSelectSeasonId)
end

function PlayerSoldierData:GetTechNodes()
  if self.nCurSelectSeasonId == 0 then
    return
  end
  return self.technologyData:GetTechNodesBySeason(self.nCurSelectSeasonId)
end

function PlayerSoldierData:GetTechNode(nId)
  if self.nCurSelectSeasonId == 0 then
    return
  end
  return self.technologyData:GetTechNode(nId, self.nCurSelectSeasonId)
end

function PlayerSoldierData:GetTechActiveNodeCount()
  if self.nCurSelectSeasonId == 0 then
    return 0, 0
  end
  return self.technologyData:GetActiveNodeCount(self.nCurSelectSeasonId)
end

function PlayerSoldierData:GetActiveNodePreview()
  if self.nCurSelectSeasonId == 0 then
    return
  end
  return self.technologyData:GetActiveNodePreview(self.nCurSelectSeasonId)
end

function PlayerSoldierData:SendSoldierTechDetailReq(callback)
  if self.nCurSelectSeasonId == 0 then
    return
  end
  self.technologyData:SendSoldierTechDetailReq(self.nCurSelectSeasonId, callback)
end

function PlayerSoldierData:SendSoldierTechNodeUnlockReq(nId, callback)
  return self.technologyData:SendSoldierTechNodeUnlockReq(nId, callback)
end

function PlayerSoldierData:CheckBossTemplateUnlocked(nId)
  local mapCfg = ConfigTable.GetData("SoldierBossTemplate", nId)
  if mapCfg ~= nil then
    if mapCfg.IsUnlock == true then
      return true
    end
    local nTechNodeId = mapCfg.TechNodeId
    if nTechNodeId ~= 0 then
      return self:CheckTechNodeActiveById(nTechNodeId)
    end
  end
  return false
end

function PlayerSoldierData:GetAllBossTemplates()
  local tbList = {}
  
  local function collect(mapCfg)
    table.insert(tbList, {
      nId = mapCfg.Id,
      nUnlock = self:CheckBossTemplateUnlocked(mapCfg.Id) and 1 or 0
    })
  end
  
  ForEachTableLine(ConfigTable.Get("SoldierBossTemplate"), collect)
  table.sort(tbList, function(a, b)
    if a.nUnlock == b.nUnlock then
      return a.nId < b.nId
    end
    return a.nUnlock > b.nUnlock
  end)
  return tbList
end

function PlayerSoldierData:GetCurChallengeState()
  if self.curChallengeData == nil then
    return 0, 0
  end
  if self.curChallengeData.nGradeChallengeId == 0 then
    return 0, 0
  end
  local curChallengeCfg = ConfigTable.GetData("SoldierGradeChallenge", self.curChallengeData.nGradeChallengeId)
  if not curChallengeCfg then
    return 0, 0
  end
  local tbAllNodeList = {}
  
  local function func_ForEach_SoldierNodePlan(mapLine)
    if curChallengeCfg.NodeGroupId == mapLine.NodeGroupId then
      table.insert(tbAllNodeList, mapLine)
    end
  end
  
  ForEachTableLine(DataTable.SoldierNodePlan, func_ForEach_SoldierNodePlan)
  table.sort(tbAllNodeList, function(a, b)
    return a.Index < b.Index
  end)
  local nNodexIndex = self.curChallengeData.nNodeIndex
  local nStage = self.curChallengeData.nStage
  if nStage == 0 then
    return 1, 1
  end
  for i = 1, #tbAllNodeList do
    local nodeCfg = tbAllNodeList[i]
    if nStage > nodeCfg.Stage then
      nNodexIndex = nNodexIndex - 1
    end
  end
  return nStage, nNodexIndex
end

function PlayerSoldierData:CheckGMSkipNodeRefreshAllowed()
  if self.curLevel == nil then
    printWarn("[Soldier] receive sd_soldier_info_notify, but curLevel is nil")
    return false
  end
  if self.curLevel.curBattle ~= nil then
    printWarn("[Soldier] sdSkipNode is ignored during soldier battle")
    return false
  end
  if not PanelManager.CheckPanelOpen(PanelId.SoldierSandtable) then
    printWarn("[Soldier] sdSkipNode is ignored outside soldier sandtable")
    return false
  end
  local tbBlockPanels = {
    PanelId.SoldierBattlePanel,
    PanelId.SoldierBattleEventPanel,
    PanelId.SoldierBattleResult
  }
  for _, nPanelId in ipairs(tbBlockPanels) do
    if PanelManager.CheckPanelOpen(nPanelId) then
      printWarn("[Soldier] sdSkipNode is ignored because soldier flow panel is open: " .. tostring(nPanelId))
      return false
    end
  end
  return true
end

function PlayerSoldierData:OnSoldierInfoNotify(mapSoldierInfo)
  if mapSoldierInfo == nil or mapSoldierInfo.Meta == nil or mapSoldierInfo.Node == nil then
    printWarn("[Soldier] receive invalid sd_soldier_info_notify")
    return
  end
  if not self:CheckGMSkipNodeRefreshAllowed() then
    return
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierPartnerTips)
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierCharCardTips)
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierCharSkillDetail)
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierCharPontentialDetailPanel)
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierShopProbabilityPanel)
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierSandtable)
  self.curLevel:Exit()
  self.curLevel = require("Game.Adventure.Soldier.SoldierLevelData").new()
  self.curLevel:Init(self, mapSoldierInfo)
end

function PlayerSoldierData:OnBuffAddNotify(mapBuffData)
  if mapBuffData == nil then
    return
  end
  if self.curLevel == nil then
    printWarn("[Soldier] receive buff add notify, but curLevel is nil")
    return
  end
  self.curLevel:UpdateBuff(mapBuffData)
end

function PlayerSoldierData:OnItemChangeNotify(mapChangeInfo)
  if mapChangeInfo == nil then
    return
  end
  if self.curLevel == nil then
    printWarn("[Soldier] receive item change notify, but curLevel is nil")
    return
  end
  local tbChange = {}
  self.curLevel:UpdateChangeInfo(mapChangeInfo, tbChange)
  if tbChange.tbChessChangeStep ~= nil and #tbChange.tbChessChangeStep > 0 then
    EventManager.Hit("SoldierGMRefresh", tbChange.tbChessChangeStep)
  end
end

function PlayerSoldierData:OnSoldierEffectNotify(mapMsgData)
  if mapMsgData == nil then
    return
  end
  if self.curLevel == nil then
    printWarn("[Soldier] receive soldier effect notify, but curLevel is nil")
    return
  end
  self.curLevel:UpdateSoldierEffectNotify(mapMsgData)
end

function PlayerSoldierData:OnShopDataNotify(mapShopData)
  if mapShopData == nil then
    return
  end
  if self.curLevel == nil then
    printWarn("[Soldier] receive shop data notify, but curLevel is nil")
    return
  end
  self.curLevel:UpdateShopDataNotify(mapShopData)
end

function PlayerSoldierData:ApplyGMSoldierHp(nHp)
  if nHp == nil then
    return
  end
  if self.curLevel == nil then
    printWarn("[Soldier] apply gm soldier hp, but curLevel is nil")
    return
  end
  self.curLevel:UpdateGMSoldierHp(nHp)
end

function PlayerSoldierData:RefreshRedDot()
  if self.nCurSelectSeasonId == 0 then
    return
  end
  self.technologyData:RefreshRedDot(self.nCurSelectSeasonId)
end

function PlayerSoldierData:SetGuideData(nGuideId, param)
  self.tbGuideData[nGuideId] = param
end

function PlayerSoldierData:GetGuideData(nGuideId)
  return self.tbGuideData[nGuideId]
end

function PlayerSoldierData:GMEnterSoldier(tbDeploy)
  if self.curLevel == nil then
    self.curLevel = require("Game.Adventure.Soldier.SoldierLevelData").new()
  end
  self.curLevel:Init(self)
  self.curLevel:GMEnterBattle(tbDeploy)
end

return PlayerSoldierData
