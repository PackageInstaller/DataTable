local SoldierLevelData = class("SoldierLevelData")
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
local FightPos = GameEnum.SoldierPositionType.FightPosition
local SupPos = GameEnum.SoldierPositionType.SupportPosition
local SPT = AllEnum.SoldierPositionType

local function SlotToPosIndex(nSlot)
  if nSlot == nil or nSlot == 0 then
    return SPT.Other, 0
  end
  if 1 <= nSlot and nSlot <= 3 then
    return SPT.Fight, nSlot
  end
  if 4 <= nSlot and nSlot <= 9 then
    return SPT.Support, nSlot - 3
  end
  if 10 <= nSlot and nSlot <= 18 then
    return SPT.Waiting, nSlot - 9
  end
  return SPT.Other, 0
end

local function PosIndexToSlot(nPosType, nIndex)
  if nPosType == SPT.Fight then
    return nIndex
  elseif nPosType == SPT.Support then
    return nIndex + 3
  elseif nPosType == SPT.Waiting then
    return nIndex + 9
  end
  return 0
end

local SoldierEffectStatus = {InActive = "InActive", Active = "Active"}
local SoldierBuffAction = {
  Sync = "Sync",
  Add = "Add",
  Remove = "Remove"
}
local SoldierBuffType = {
  UnknownBuff = "UnknownBuff",
  CardBuff = "CardBuff",
  PartnerBuff = "PartnerBuff",
  TechNodeBuff = "TechNodeBuff",
  AbilityBuff = "AbilityBuff"
}
local SoldierBuffProgressType = {
  UnknownProgress = "UnknownProgress",
  StateProgress = "StateProgress",
  CondProgress = "CondProgress"
}
local PRINT_CHESS_LOG = true
local CaseEnum = {
  SelectCard = 1,
  Shop = 2,
  Fight = 3,
  Battle = 4,
  EventSettlementOfDispute = 6,
  EventSettlementOfDisputeBattle = 7,
  SelectBossAbility = 8,
  CheckStage = 9,
  StoryEventOfPersonality = 10,
  StoryEventOfCostly = 11,
  DeployOpt = 14,
  ClientEvent = 15
}
local ClientCase = {
  BattleResult = 1,
  Settle = 2,
  StageChange = 3,
  CheckStagePanel = 4,
  Ending = 5,
  DiceResult = 6
}
local OpenSandTableServerCase = {
  CaseEnum.SelectCard,
  CaseEnum.Battle,
  CaseEnum.EventSettlementOfDispute,
  CaseEnum.EventSettlementOfDisputeBattle,
  CaseEnum.SelectBossAbility,
  CaseEnum.StoryEventOfCostly,
  CaseEnum.StoryEventOfPersonality
}
local OpenSandTableClientCase = {
  ClientCase.DiceResult
}
local mapEventConfig = {}
local SANDTABLE_SCENES = {
  [1] = "Soldier_Sandtable_UI_01",
  [2] = "Soldier_Sandtable_UI_02",
  [3] = "Soldier_Sandtable_UI_03"
}

function SoldierLevelData:ctor()
  self:BindEvent()
  self:Clear()
end

function SoldierLevelData:Clear()
  self.parent = nil
  self.mapCases = {}
  self.mapClientCases = {}
  self.tbPendingRewards = {}
  self.nLevelId = 0
  self.nHp = 0
  self.nBossTemplateId = 0
  self.nGradeChallengeId = 0
  self.nStageId = 0
  self.nNodeId = 0
  self.nNodeType = 0
  self.tbNodeList = {}
  self.tbDeployChess = {}
  self.tbWaitingChess = {}
  self.tbOtherChess = {}
  self.nDeployVersion = 0
  self.mapChessByUid = {}
  self.mapSlotToUid = {}
  self.tbOtherUids = {}
  self.mapItems = {}
  self.mapAllChess = {}
  self.mapBuffs = {}
  self.mapBuffProgress = {}
  self.tbStrategyCards = nil
  self.nLevel = 0
  self.nMaxLevel = 0
  self.nExp = 0
  self.curBattle = nil
  self.nWiningStreak = 0
  self.nLosingStreak = 0
  self.tbPartnerTrace = {}
  self.tbServerPartner = {}
  self.tbActivePartner = {}
  self.mapExtraPartnerTag = {}
  self.mapEffects = {}
  self.tbClientEffects = {}
  self.mapExtraEffectState = {
    nHarvest = 0,
    nInterestLimit = 0,
    nCardReRoll = 0
  }
  self.tbDiscAddEffect = {}
  self.bOpenSandTable = true
  self.sSandtableSceneName = nil
  self.bSuppressEnterAnim = false
  self.bReconnectInBattle = false
  self.fnPanelReadyOnce = nil
  self.sLastTimelineScene = nil
end

function SoldierLevelData:BindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Add(nEventId, self, callback)
    end
  end
end

function SoldierLevelData:UnBindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Remove(nEventId, self, callback)
    end
  end
end

function SoldierLevelData:_RebuildFromNewDeploy(deploy)
  self.mapChessByUid = {}
  self.mapSlotToUid = {}
  self.tbOtherUids = {}
  if deploy == nil then
    self.nDeployVersion = 0
    return
  end
  self.nDeployVersion = deploy.Version or 0
  if deploy.Chess == nil then
    return
  end
  for _, chess in ipairs(deploy.Chess) do
    local nUid = chess.UID
    local nSlot = chess.Slot or 0
    self.mapChessByUid[nUid] = {
      nTid = chess.Tid,
      nStar = chess.Star,
      nSlot = nSlot
    }
    if nSlot == 0 then
      table.insert(self.tbOtherUids, nUid)
    else
      self.mapSlotToUid[nSlot] = nUid
    end
  end
end

function SoldierLevelData:_DeriveDeployView()
  local tbView = {}
  for nSlot = 1, 9 do
    local nPosType, nIndex = SlotToPosIndex(nSlot)
    local nUid = self.mapSlotToUid[nSlot]
    local entry = {
      nPositionType = nPosType,
      nIndex = nIndex,
      nUid = 0,
      nId = 0,
      nStar = 0
    }
    if nUid ~= nil then
      local chess = self.mapChessByUid[nUid]
      if chess ~= nil then
        entry.nUid = nUid
        entry.nId = chess.nTid
        entry.nStar = chess.nStar
      end
    end
    table.insert(tbView, entry)
  end
  return tbView
end

function SoldierLevelData:_DeriveWaitingView()
  local tbView = {}
  for nSlot = 10, 18 do
    local _, nIndex = SlotToPosIndex(nSlot)
    local nUid = self.mapSlotToUid[nSlot]
    local entry = {
      nIndex = nIndex,
      nUid = 0,
      nId = 0,
      nStar = 0
    }
    if nUid ~= nil then
      local chess = self.mapChessByUid[nUid]
      if chess ~= nil then
        entry.nUid = nUid
        entry.nId = chess.nTid
        entry.nStar = chess.nStar
      end
    end
    table.insert(tbView, entry)
  end
  return tbView
end

function SoldierLevelData:_DeriveOtherView()
  local tbView = {}
  local mapAgg = {}
  for _, nUid in ipairs(self.tbOtherUids) do
    local chess = self.mapChessByUid[nUid]
    if chess ~= nil then
      local sKey = tostring(chess.nTid) .. "_" .. tostring(chess.nStar)
      local agg = mapAgg[sKey]
      if agg == nil then
        agg = {
          nId = chess.nTid,
          nStar = chess.nStar,
          nCount = 0
        }
        mapAgg[sKey] = agg
        table.insert(tbView, agg)
      end
      agg.nCount = agg.nCount + 1
    end
  end
  return tbView
end

function SoldierLevelData:_DeriveAllChessView()
  local tbView = {}
  local mapAgg = {}
  for _, chess in pairs(self.mapChessByUid) do
    local sKey = tostring(chess.nTid) .. "_" .. tostring(chess.nStar)
    local agg = mapAgg[sKey]
    if agg == nil then
      agg = {
        nId = chess.nTid,
        nStar = chess.nStar,
        nCount = 0
      }
      mapAgg[sKey] = agg
      table.insert(tbView, agg)
    end
    agg.nCount = agg.nCount + 1
  end
  return tbView
end

function SoldierLevelData:_BuildHarvestEvent(nHarvest)
  local tbEvents = {}
  if 0 < nHarvest then
    tbEvents = {
      List = {
        {
          Id = GameEnum.soldierBuffEffect.ClientEffectHarvest,
          Data = {nHarvest}
        }
      }
    }
  end
  return tbEvents
end

function SoldierLevelData:Init(parent, mapSoldierInfo, mapChange, bFreshStart)
  self:Clear()
  self.parent = parent
  if mapSoldierInfo == nil or mapSoldierInfo.Meta == nil then
    printError("[Soldier] 服务器下发的SoldierInfo为空！！！")
    return
  end
  self.nLevelId = mapSoldierInfo.Meta.Id
  self.nHp = mapSoldierInfo.Meta.Hp
  self.nWiningStreak = mapSoldierInfo.Meta.WinningStreak
  self.nLosingStreak = mapSoldierInfo.Meta.LosingStreak
  self.nLevel = mapSoldierInfo.Meta.ShopLevel
  self.nExp = mapSoldierInfo.Meta.ShopExp
  self.tbPartnerTrace = mapSoldierInfo.Meta.TracePartnerTypes
  self.nBossTemplateId = 0
  if mapSoldierInfo.Node == nil then
    printError("[Soldier] 服务器下发的 SoldierNode 为空！！！")
    return
  end
  local mapData = self.parent:GetCurChallengeData()
  if mapData ~= nil then
    self.nGradeChallengeId = mapData.nGradeChallengeId
  end
  if self.nMaxLevel == 0 then
    local function foreachShopLevel(mapData)
      if self.nMaxLevel < mapData.Level then
        self.nMaxLevel = mapData.Level
      end
    end
    
    ForEachTableLine(ConfigTable.Get("SoldierShopLevel"), foreachShopLevel)
  end
  self:UpdateNodeInfo(mapSoldierInfo.Node.Data, nil, not bFreshStart)
  self:ClearServerCase()
  if mapSoldierInfo.Cases ~= nil then
    for _, v in ipairs(mapSoldierInfo.Cases) do
      self:DispatchServerCase(v)
    end
  end
  local tbChange = {}
  if mapChange ~= nil then
    self:UpdateChangeInfo(mapChange, tbChange, nil)
  end
  local tbSteps = tbChange.tbChessChangeStep
  local nCoin = tbChange.itemChange and tbChange.itemChange[AllEnum.CoinItemId.SoldierCurrency] or nil
  local bHasSteps = tbSteps ~= nil and 0 < #tbSteps
  local bHasCoin = nCoin ~= nil and nCoin ~= 0
  if mapChange == nil and mapSoldierInfo.Node.Data.NodeId == 0 then
    local tbObtain = {}
    local mapBag = mapSoldierInfo.Bag
    if mapBag ~= nil and mapBag.Deploy ~= nil and mapBag.Deploy.Chess ~= nil then
      for _, ch in ipairs(mapBag.Deploy.Chess) do
        local nSlot = ch.Slot or 0
        local nPos, nIndex = SlotToPosIndex(nSlot)
        table.insert(tbObtain, {
          nUid = ch.UID,
          nSlot = nSlot,
          nTid = ch.Tid,
          nStar = ch.Star,
          nId = ch.Tid,
          nTargetType = nPos,
          nIndex = nIndex
        })
      end
    end
    if 0 < #tbObtain then
      tbSteps = {
        {
          tbConsume = {},
          tbObtain = tbObtain,
          tbUpdate = {}
        }
      }
      bHasSteps = true
    end
    if mapBag ~= nil and mapBag.Res ~= nil then
      for _, v in ipairs(mapBag.Res) do
        if v.Tid == AllEnum.CoinItemId.SoldierCurrency and v.Qty ~= nil and v.Qty ~= 0 then
          nCoin = v.Qty
          bHasCoin = true
          break
        end
      end
    end
  end
  if (bHasSteps or bHasCoin) and self.mapCases[CaseEnum.Fight] == nil then
    if bHasSteps then
      tbSteps = self:_MergeApplyObtainSteps(tbSteps)
    end
    table.insert(self.tbPendingRewards, {
      nType = AllEnum.SoldierRewardSource.Apply,
      data = bHasCoin and {nCoin = nCoin} or {},
      tbSteps = bHasSteps and tbSteps or {}
    })
  end
  self:_RebuildFromNewDeploy(mapSoldierInfo.Bag.Deploy)
  self.tbDeployChess = self:_DeriveDeployView()
  self.tbWaitingChess = self:_DeriveWaitingView()
  self.tbOtherChess = self:_DeriveOtherView()
  self.mapAllChess = self:_DeriveAllChessView()
  self:UpdatePartner(true)
  self.mapItems = {}
  if mapSoldierInfo.Bag.Res ~= nil then
    for k, v in ipairs(mapSoldierInfo.Bag.Res) do
      self.mapItems[v.Tid] = v.Qty
    end
  end
  if mapSoldierInfo.Bag.Buffs ~= nil then
    for _, v in ipairs(mapSoldierInfo.Bag.Buffs) do
      self:UpdateBuff(v)
    end
  end
  local bInitNodeList = false
  if mapSoldierInfo.Effects ~= nil then
    for _, v in ipairs(mapSoldierInfo.Effects) do
      self:EffectPartnerAdditional(v.PartnerAdditional)
      self:EffectPartnerActivateAdditional(v.PartnerActivateAdditional)
      self:EffectNodeTypeModify(v.NodeTypeModify)
      self:EffectClientAttr(v.ClientAttr)
      self:EffectClientHarvest(v.ClientHarvest)
      self:EffectInterest(v.Interest)
      self:EffectCardReRoll(v.CardReRoll)
      self:EffectDiceAddPoint(v.DiceAddPoint)
      self:EffectTempFree(v.TempFree)
      if v.NodeTypeModify ~= nil then
        bInitNodeList = true
      end
    end
  end
  if not bInitNodeList then
    self:UpdateNodeList()
  end
  if mapSoldierInfo.Progress ~= nil then
    self:UpdateBuffProgress(mapSoldierInfo.Progress)
  end
  self.mapClientData = {
    nLen = mapSoldierInfo.Meta.DataLen,
    sData = mapSoldierInfo.Meta.ClientData,
    nVersion = mapSoldierInfo.Meta.DataVersion
  }
  self:EnterSoldier()
  return tbChange
end

function SoldierLevelData:GetSandtableSceneName()
  return self.sSandtableSceneName
end

function SoldierLevelData:PreloadSandtableScene(callback)
  local nStage = PlayerData.SoldierData:GetCurChallengeState()
  local sScene = SANDTABLE_SCENES[nStage]
  if sScene == nil then
    printError("自走棋沙盘场景找不到！！！stage = " .. tostring(nStage))
    self.sSandtableSceneName = nil
    self.bSandtableSceneLoaded = false
    if callback ~= nil then
      callback()
    end
    return
  end
  if self.sSandtableSceneName == sScene and self.bSandtableSceneLoaded then
    if callback ~= nil then
      callback(true)
    end
    return
  end
  if self.sSandtableSceneName == sScene and not self.bSandtableSceneLoaded then
    if callback ~= nil then
      self.tbSandtableLoadCallbacks = self.tbSandtableLoadCallbacks or {}
      table.insert(self.tbSandtableLoadCallbacks, callback)
    end
    return
  end
  self.sSandtableSceneName = sScene
  self.bSandtableSceneLoaded = false
  self.tbSandtableLoadCallbacks = {}
  if callback ~= nil then
    table.insert(self.tbSandtableLoadCallbacks, callback)
  end
  CS.MainMenuModuleHelper.GetActiveScene(sScene, function(bSuccess)
    if self.sSandtableSceneName ~= sScene then
      return
    end
    self.bSandtableSceneLoaded = true
    local tbCbs = self.tbSandtableLoadCallbacks or {}
    self.tbSandtableLoadCallbacks = {}
    for _, cb in ipairs(tbCbs) do
      cb(bSuccess)
    end
  end)
end

function SoldierLevelData:IsSandtableSceneLoaded()
  return self.bSandtableSceneLoaded == true
end

function SoldierLevelData:UnloadSandtableScene()
  if self.sSandtableSceneName == nil then
    return
  end
  local sScene = self.sSandtableSceneName
  self.sSandtableSceneName = nil
  self.bSandtableSceneLoaded = false
  self.tbSandtableLoadCallbacks = {}
  CS.MainMenuModuleHelper.DeActiveScene(sScene, function()
  end)
end

function SoldierLevelData:EnterSoldier()
  local bFirstIn = self.nNodeId == 0
  local bEnterBattle = self.mapCases[CaseEnum.Battle] ~= nil or self.mapCases[CaseEnum.EventSettlementOfDisputeBattle] ~= nil
  if not bEnterBattle then
    local function func()
      self:PreloadSandtableScene(function()
        function self.fnPanelReadyOnce()
          self:StartSoldierLevel()
        end
        
        EventManager.Hit(EventId.OpenPanel, PanelId.SoldierSandtable, bFirstIn)
      end)
    end
    
    EventManager.Hit(EventId.SetTransition, 54, func, self.nGradeChallengeId)
  else
    self:PreloadSandtableScene(function()
      function self.fnPanelReadyOnce()
        self:StartSoldierLevel()
      end
      
      EventManager.Hit(EventId.OpenPanel, PanelId.SoldierSandtable, bFirstIn)
    end)
  end
end

function SoldierLevelData:Exit()
  self:UnBindEvent()
  if self.curBattle then
    self.curBattle:Exit()
  end
  self:UnloadSandtableScene()
  self:Clear()
end

function SoldierLevelData:ClearServerCase()
  self.mapCases = {}
end

function SoldierLevelData:DispatchServerCase(case)
  if case == nil then
    return
  end
  if case.SelectCard then
    self.mapCases[CaseEnum.SelectCard] = {}
    self.mapCases[CaseEnum.SelectCard].nId = case.Id
    self.mapCases[CaseEnum.SelectCard].tbCards = case.SelectCard.Ids
    self.mapCases[CaseEnum.SelectCard].nRoll = case.SelectCard.ReRoll
  elseif case.ShopCase then
    self.mapCases[CaseEnum.Shop] = {}
    self.mapCases[CaseEnum.Shop].nId = case.Id
    self:_UpdateShopCaseData(case.ShopCase)
  elseif case.FightCase then
    self.mapCases[CaseEnum.Fight] = {}
    self.mapCases[CaseEnum.Fight].nId = case.Id
  elseif case.BattleCase then
    self.mapCases[CaseEnum.Battle] = {}
    self.mapCases[CaseEnum.Battle].nId = case.Id
    self.mapCases[CaseEnum.Battle].nFloorId = case.BattleCase.FloorId
  elseif case.EventSettlementOfDispute then
    self.mapCases[CaseEnum.EventSettlementOfDispute] = {}
    self.mapCases[CaseEnum.EventSettlementOfDispute].nId = case.Id
    self.mapCases[CaseEnum.EventSettlementOfDispute].tbIds = case.EventSettlementOfDispute.Ids
  elseif case.EventSettlementOfDisputeBattle then
    self.mapCases[CaseEnum.EventSettlementOfDisputeBattle] = {}
    self.mapCases[CaseEnum.EventSettlementOfDisputeBattle].nId = case.Id
    self.mapCases[CaseEnum.EventSettlementOfDisputeBattle].nFloorId = case.EventSettlementOfDisputeBattle.FloorId
    self.mapCases[CaseEnum.EventSettlementOfDisputeBattle].nEventId = case.EventSettlementOfDisputeBattle.BattleId
  elseif case.SelectBossAbilityCase then
    self.mapCases[CaseEnum.SelectBossAbility] = {}
    self.mapCases[CaseEnum.SelectBossAbility].nId = case.Id
  elseif case.CheckStageCase then
    self.mapCases[CaseEnum.CheckStage] = {}
    self.mapCases[CaseEnum.CheckStage].nId = case.Id
    self.mapCases[CaseEnum.CheckStage].nFloorId = case.CheckStageCase.FloorId
    self.mapClientCases[ClientCase.CheckStagePanel] = {}
  elseif case.StoryEventOfPersonalityCase then
    local mapCase = case.StoryEventOfPersonalityCase
    local tbOptions = mapCase.Options and mapCase.Options.Options or {}
    self.mapCases[CaseEnum.StoryEventOfPersonality] = {
      nId = case.Id,
      nPersonalityStoryId = mapCase.PersonalityStoryId,
      tbOptions = tbOptions,
      nIndex = mapCase.Index or 0,
      nDicePoint = mapCase.DicePoint or 0,
      bTwoDice = mapCase.TwoDice or false,
      nPreOptionId = mapCase.PreOptionId or 0
    }
  elseif case.StoryEventOfCostlyCase then
    local mapCase = case.StoryEventOfCostlyCase
    local tbOptions = mapCase.Options and mapCase.Options.Options or {}
    self.mapCases[CaseEnum.StoryEventOfCostly] = {
      nId = case.Id,
      nPersonalityStoryId = mapCase.PersonalityStoryId,
      tbOptions = tbOptions,
      nPreOptionId = mapCase.PreOptionId or 0
    }
  elseif case.DeployOptCase then
    self.mapCases[CaseEnum.DeployOpt] = {}
    self.mapCases[CaseEnum.DeployOpt].nId = case.Id
  elseif case.ClientEventCase then
    self.mapCases[CaseEnum.ClientEvent] = {}
    self.mapCases[CaseEnum.ClientEvent].nId = case.Id
  end
end

function SoldierLevelData:UpdatePartnerTrace(nPartnerType, bTrace)
  local nIndex = table.indexof(self.tbPartnerTrace, nPartnerType)
  if bTrace then
    if nIndex == 0 then
      table.insert(self.tbPartnerTrace, nPartnerType)
    end
  elseif 0 < nIndex then
    table.remove(self.tbPartnerTrace, nIndex)
  end
  EventManager.Hit("SoldierPartnerTrace")
end

function SoldierLevelData:UpdateNodeList(nFromNodeType, nToNodeType)
  nFromNodeType = nFromNodeType or 0
  nToNodeType = nToNodeType or 0
  local nStageId = self.nStageId == 0 and 1 or self.nStageId
  self.tbNodeList = {}
  local mapChallengeCfg = ConfigTable.GetData("SoldierGradeChallenge", self.nGradeChallengeId)
  if mapChallengeCfg ~= nil then
    local tbAllNodeList = CacheTable.GetData("_SoldierNodePlan", mapChallengeCfg.NodeGroupId)
    if tbAllNodeList ~= nil then
      for _, v in ipairs(tbAllNodeList) do
        if v.Stage == nStageId then
          local nNodeType = v.NodeType
          local bNodeChange = false
          if nNodeType == nFromNodeType then
            bNodeChange = true
            nNodeType = nToNodeType
          end
          table.insert(self.tbNodeList, {
            nNodeId = v.Id,
            nIndex = v.Index,
            nNodeType = nNodeType,
            bTypeChange = bNodeChange
          })
        end
      end
      table.sort(self.tbNodeList, function(a, b)
        return a.nIndex < b.nIndex
      end)
    end
  end
end

function SoldierLevelData:UpdateBuff(mapBuff)
  if mapBuff == nil then
    return
  end
  local nAction = mapBuff.Action
  local nType = mapBuff.Type
  local nBindId = mapBuff.BindId or 0
  local nEffectGroup = mapBuff.EffectGroup or 0
  local tbBuffUids = mapBuff.BuffIds or {}
  if nAction == SoldierBuffAction.Add or nAction == SoldierBuffAction.Sync then
    for nIdx, nBuffUid in ipairs(tbBuffUids) do
      self.mapBuffs[nBuffUid] = {
        nType = nType,
        nBindId = nBindId,
        nEffectGroup = nEffectGroup
      }
    end
    if nType == SoldierBuffType.AbilityBuff then
      self.nBossTemplateId = nBindId
    end
  elseif nAction == SoldierBuffAction.Remove then
    for _, nBuffUid in ipairs(tbBuffUids) do
      self.mapBuffs[nBuffUid] = nil
      self.mapBuffProgress[nBuffUid] = nil
      for nEid, info in pairs(self.mapEffects) do
        if info.nBuffUid == nBuffUid then
          self.mapEffects[nEid] = nil
          self.tbClientEffects[nEid] = nil
        end
      end
    end
    if nType == SoldierBuffType.AbilityBuff then
      self.nBossTemplateId = 0
    end
  end
  if nType == SoldierBuffType.CardBuff then
    self.tbStrategyCards = nil
    EventManager.Hit("SoldierBuffCardChange")
  end
end

function SoldierLevelData:UpdateBuffProgress(tbProgress)
  if tbProgress == nil or #tbProgress == 0 then
    return
  end
  for _, v in ipairs(tbProgress) do
    local nBuffUid = v.BuffId
    if v.Removed then
      self.mapBuffProgress[nBuffUid] = nil
    else
      self.mapBuffProgress[nBuffUid] = {
        nType = v.Type,
        nCur = v.Cur or 0,
        nMax = v.Max or 0
      }
    end
  end
  EventManager.Hit("SoldierBuffProgressUpdate")
end

function SoldierLevelData:GetShopWeight(tbRarityUp)
  local tbWeightList = {}
  local mapShopCfg = ConfigTable.GetData("SoldierShopLevel", self.nLevel)
  if mapShopCfg ~= nil then
    for i = 1, 5 do
      local nWeight = mapShopCfg["Rarity" .. i]
      local bDouble = false
      if tbRarityUp ~= nil and 0 < tbRarityUp[i] then
        nWeight = nWeight * 2
        bDouble = true
      end
      table.insert(tbWeightList, {nWeight = nWeight, bDouble = bDouble})
    end
  end
  return tbWeightList
end

function SoldierLevelData:_UpdateShopCaseData(mapShopData)
  if mapShopData == nil then
    return
  end
  self.nLevel = mapShopData.Level
  self.nExp = mapShopData.Exp
  if self.mapCases[CaseEnum.Shop] ~= nil then
    local mapShop = {}
    mapShop.tbGoods = mapShopData.Goods
    mapShop.tbWeightList = self:GetShopWeight(mapShopData.RarityUp)
    mapShop.bLock = mapShopData.Lock
    mapShop.nFreeCount = mapShopData.Free + mapShopData.TempFree
    mapShop.nReRollPrice = mapShopData.ReRollPrice
    mapShop.bDisableRefresh = mapShopData.DisableRefresh
    mapShop.bDisablePurchase = mapShopData.DisablePurchase
    mapShop.nPurchaseExpPrice = mapShopData.PurchaseExpPrice
    self.mapCases[CaseEnum.Shop].mapShop = mapShop
  end
end

function SoldierLevelData:_UpdateServerPartnerLevel(nStatus, nType, nLevel)
  if nStatus == SoldierEffectStatus.InActive then
    if self.tbServerPartner[nType] ~= nil then
      self.tbServerPartner[nType] = self.tbServerPartner[nType] - nLevel
    end
  elseif nStatus == SoldierEffectStatus.Active then
    if self.tbServerPartner[nType] == nil then
      self.tbServerPartner[nType] = 0
    end
    self.tbServerPartner[nType] = self.tbServerPartner[nType] + nLevel
  end
  if self.tbServerPartner[nType] ~= nil and self.tbServerPartner[nType] <= 0 then
    self.tbServerPartner[nType] = nil
  end
  EventManager.Hit("SoldierPartnerUpdate")
end

function SoldierLevelData:EffectPartnerAdditional(mapMsgData)
  if mapMsgData == nil then
    return
  end
  self:_UpdateServerPartnerLevel(mapMsgData.Status, mapMsgData.PartnerType, mapMsgData.Additional)
end

function SoldierLevelData:EffectPartnerActivateAdditional(mapMsgData)
  if mapMsgData == nil then
    return
  end
  local tbAllPartner = SoldierAttrData.CalcActivePartners(self.tbDeployChess)
  for _, info in ipairs(tbAllPartner) do
    local mapCfg = ConfigTable.GetData("SoldierPartner", info.nId)
    if mapCfg ~= nil then
      local nPartnerType = mapCfg.PartnerType
      self:_UpdateServerPartnerLevel(mapMsgData.Status, nPartnerType, mapMsgData.Additional)
    end
  end
end

function SoldierLevelData:EffectNodeTypeModify(mapMsgData)
  if mapMsgData == nil then
    return
  end
  local nFromNodeType = mapMsgData.FromNodeType
  local nToNodeType = mapMsgData.ToNodeType
  self:UpdateNodeList(nFromNodeType, nToNodeType)
end

function SoldierLevelData:EffectClientAttr(mapMsgData)
  if mapMsgData == nil then
    return
  end
  if mapMsgData.Status == SoldierEffectStatus.Active then
    self.tbClientEffects[mapMsgData.Source.Id] = {
      nTid = mapMsgData.Source.Tid,
      nBuffUId = mapMsgData.Source.BuffId,
      tbValues = mapMsgData.Values
    }
  elseif mapMsgData.Status == SoldierEffectStatus.InActive then
    self.tbClientEffects[mapMsgData.Source.Id] = nil
  end
end

function SoldierLevelData:EffectClientHarvest(mapMsgData)
  if mapMsgData == nil then
    return
  end
  local nDelta = mapMsgData.Count or 0
  if mapMsgData.Status == SoldierEffectStatus.Active then
    self.mapExtraEffectState.nHarvest = self.mapExtraEffectState.nHarvest + nDelta
  elseif mapMsgData.Status == SoldierEffectStatus.InActive then
    self.mapExtraEffectState.nHarvest = self.mapExtraEffectState.nHarvest - nDelta
  end
end

function SoldierLevelData:EffectInterest(mapMsgData)
  if mapMsgData == nil then
    return
  end
  local nDelta = mapMsgData.Limit or 0
  if mapMsgData.Status == SoldierEffectStatus.Active then
    self.mapExtraEffectState.nInterestLimit = self.mapExtraEffectState.nInterestLimit + nDelta
  elseif mapMsgData.Status == SoldierEffectStatus.InActive then
    self.mapExtraEffectState.nInterestLimit = self.mapExtraEffectState.nInterestLimit - nDelta
  end
end

function SoldierLevelData:EffectCardReRoll(mapMsgData)
  if mapMsgData == nil then
    return
  end
  local nDelta = mapMsgData.Count or 0
  if mapMsgData.Status == SoldierEffectStatus.Active then
    self.mapExtraEffectState.nCardReRoll = self.mapExtraEffectState.nCardReRoll + nDelta
  elseif mapMsgData.Status == SoldierEffectStatus.InActive then
    self.mapExtraEffectState.nCardReRoll = self.mapExtraEffectState.nCardReRoll - nDelta
  end
end

function SoldierLevelData:EffectDiceAddPoint(mapMsgData)
  if mapMsgData == nil then
    return
  end
  if mapMsgData.Status == SoldierEffectStatus.Active then
    self.tbDiscAddEffect[mapMsgData.Source.Id] = {
      nTid = mapMsgData.Source.Tid,
      nBuffUId = mapMsgData.Source.BuffId,
      nPoint = mapMsgData.Point
    }
  elseif mapMsgData.Status == SoldierEffectStatus.InActive then
    self.tbDiscAddEffect[mapMsgData.Source.Id] = nil
  end
end

function SoldierLevelData:EffectTempFree(mapMsgData)
  if mapMsgData == nil then
    return
  end
  if self.mapCases[CaseEnum.Shop] ~= nil then
    if mapMsgData.Status == SoldierEffectStatus.InActive then
      self.mapCases[CaseEnum.Shop].mapShop.nFreeCount = self.mapCases[CaseEnum.Shop].mapShop.nFreeCount - mapMsgData.Free
    elseif mapMsgData.Status == SoldierEffectStatus.Active then
      self.mapCases[CaseEnum.Shop].mapShop.nFreeCount = self.mapCases[CaseEnum.Shop].mapShop.nFreeCount + mapMsgData.Free
    end
  end
end

function SoldierLevelData:EffectShopRefreshState(mapMsgData)
  if mapMsgData == nil then
    return
  end
  if self.mapCases[CaseEnum.Shop] ~= nil then
    self.mapCases[CaseEnum.Shop].mapShop.bDisableRefresh = mapMsgData.DisableRefresh
  end
end

function SoldierLevelData:EffectShopPurchaseState(mapMsgData)
  if mapMsgData == nil then
    return
  end
  if self.mapCases[CaseEnum.Shop] ~= nil then
    self.mapCases[CaseEnum.Shop].mapShop.bDisablePurchase = mapMsgData.DisablePurchase
  end
end

function SoldierLevelData:EffectShopFreeState(mapMsgData)
  if mapMsgData == nil then
    return
  end
  if self.mapCases[CaseEnum.Shop] ~= nil then
    if mapMsgData.Status == SoldierEffectStatus.InActive then
      self.mapCases[CaseEnum.Shop].mapShop.nFreeCount = self.mapCases[CaseEnum.Shop].mapShop.nFreeCount - mapMsgData.Free
    elseif mapMsgData.Status == SoldierEffectStatus.Active then
      self.mapCases[CaseEnum.Shop].mapShop.nFreeCount = self.mapCases[CaseEnum.Shop].mapShop.nFreeCount + mapMsgData.Free
    end
  end
end

function SoldierLevelData:EffectShopRarity(mapMsgData)
  if mapMsgData == nil then
    return
  end
  if self.mapCases[CaseEnum.Shop] ~= nil then
    local tbWeightList = self.mapCases[CaseEnum.Shop].mapShop.tbWeightList
    for k, v in ipairs(tbWeightList) do
      if k == mapMsgData.Rarity then
        if mapMsgData.Status == SoldierEffectStatus.Active then
          if not v.bDouble then
            v.bDouble = true
            v.nWeight = v.nWeight * 2
          end
        elseif mapMsgData.Status == SoldierEffectStatus.InActive and v.bDouble then
          v.bDouble = false
          v.nWeight = v.nWeight * 0.5
        end
      end
    end
  end
end

function SoldierLevelData:EffectShopPurchaseExpDiscount(mapMsgData)
  if mapMsgData == nil then
    return
  end
  if self.mapCases[CaseEnum.Shop] ~= nil then
    if mapMsgData.Status == SoldierEffectStatus.InActive then
      self.mapCases[CaseEnum.Shop].mapShop.nPurchaseExpPrice = self.mapCases[CaseEnum.Shop].mapShop.nPurchaseExpPrice - mapMsgData.Discount
    elseif mapMsgData.Status == SoldierEffectStatus.Active then
      self.mapCases[CaseEnum.Shop].mapShop.nPurchaseExpPrice = self.mapCases[CaseEnum.Shop].mapShop.nPurchaseExpPrice + mapMsgData.Discount
    end
  end
end

function SoldierLevelData:EffectShowChess(mapMsgData)
  if mapMsgData == nil then
    return
  end
  if mapMsgData.Chess ~= nil and #mapMsgData.Chess > 0 then
    self:CacheReward(AllEnum.SoldierRewardSource.EventBattle, {
      tbChess = mapMsgData.Chess
    })
  end
end

function SoldierLevelData:EffectLeftmostChange(mapMsgData, tbChange)
  if mapMsgData == nil then
    return
  end
  local cached = self.mapChessByUid[mapMsgData.UID]
  local nPosType = SPT.Other
  if cached ~= nil then
    nPosType = SlotToPosIndex(cached.nSlot)
  end
  local tbChess = {}
  table.insert(tbChess, mapMsgData.Chess)
  self:CacheReward(AllEnum.SoldierRewardSource.EventBattle, {tbChess = tbChess})
  EventManager.Hit("SoldierLeftmostWaitingChessChange", nPosType, mapMsgData.Chess)
end

function SoldierLevelData:EffectBecomeAnother(mapMsgData, tbChange)
  if mapMsgData == nil then
    return
  end
  local nGoodsIndex = mapMsgData.GoodsIdx
  local mapGoods = mapMsgData.Goods
  if tbChange ~= nil then
    tbChange.shopBecomeAnother = {nGoodsIndex = nGoodsIndex, mapGoods = mapGoods}
  end
end

function SoldierLevelData:DisposalChessDeploy(mapTrans, param)
  if mapTrans == nil then
    return {}
  end
  local step = {
    tbConsume = {},
    tbObtain = {},
    tbUpdate = {}
  }
  if mapTrans.Consume ~= nil then
    for _, ch in ipairs(mapTrans.Consume) do
      local nUid = ch.UID
      local cached = self.mapChessByUid[nUid]
      if cached ~= nil then
        local nSlot = cached.nSlot
        self.mapChessByUid[nUid] = nil
        if nSlot == 0 then
          for i, uid in ipairs(self.tbOtherUids) do
            if uid == nUid then
              table.remove(self.tbOtherUids, i)
              break
            end
          end
        else
          self.mapSlotToUid[nSlot] = nil
        end
        local nPos, nIndex = SlotToPosIndex(nSlot)
        table.insert(step.tbConsume, {
          nUid = nUid,
          nSlot = nSlot,
          nTid = ch.Tid,
          nStar = ch.Star,
          nId = ch.Tid,
          nSourceType = nPos,
          nIndex = nIndex
        })
      else
        self:PrintSoldier(string.format("[Soldier][Warn] Consume UID=%s 本地无记录", tostring(nUid)))
      end
    end
  end
  if mapTrans.Obtain ~= nil then
    for _, ch in ipairs(mapTrans.Obtain) do
      local nUid = ch.UID
      local nSlot = ch.Slot or 0
      self.mapChessByUid[nUid] = {
        nTid = ch.Tid,
        nStar = ch.Star,
        nSlot = nSlot
      }
      if nSlot == 0 then
        table.insert(self.tbOtherUids, nUid)
      else
        self.mapSlotToUid[nSlot] = nUid
      end
      local nPos, nIndex = SlotToPosIndex(nSlot)
      table.insert(step.tbObtain, {
        nUid = nUid,
        nSlot = nSlot,
        nTid = ch.Tid,
        nStar = ch.Star,
        nId = ch.Tid,
        nTargetType = nPos,
        nIndex = nIndex
      })
    end
  end
  if mapTrans.Update ~= nil then
    for _, ch in ipairs(mapTrans.Update) do
      local nUid = ch.UID
      local nToSlot = ch.Slot or 0
      local cached = self.mapChessByUid[nUid]
      if cached ~= nil then
        local nFromSlot = cached.nSlot
        if nFromSlot == 0 then
          for i, uid in ipairs(self.tbOtherUids) do
            if uid == nUid then
              table.remove(self.tbOtherUids, i)
              break
            end
          end
        elseif self.mapSlotToUid[nFromSlot] == nUid then
          self.mapSlotToUid[nFromSlot] = nil
        end
        cached.nSlot = nToSlot
        cached.nStar = ch.Star or cached.nStar
        cached.nTid = ch.Tid or cached.nTid
        if nToSlot == 0 then
          table.insert(self.tbOtherUids, nUid)
        else
          self.mapSlotToUid[nToSlot] = nUid
        end
        local nFromPos, nFromIdx = SlotToPosIndex(nFromSlot)
        local nToPos, nToIdx = SlotToPosIndex(nToSlot)
        table.insert(step.tbUpdate, {
          nUid = nUid,
          nFromSlot = nFromSlot,
          nToSlot = nToSlot,
          nTid = cached.nTid,
          nStar = cached.nStar,
          nId = cached.nTid,
          nSourceType = nFromPos,
          nSourceIndex = nFromIdx,
          nTargetType = nToPos,
          nTargetIndex = nToIdx
        })
      else
        self:PrintSoldier(string.format("[Soldier][Warn] Update UID=%s 本地无记录", tostring(nUid)))
      end
    end
  end
  return {step}
end

function SoldierLevelData:UpdatePartner(bInit)
  local tbChangePartnerType = {}
  local tbActivePartner = {}
  local tbAllPartner = SoldierAttrData.CalcActivePartners(self.tbDeployChess, nil, self.tbServerPartner)
  for _, info in ipairs(tbAllPartner) do
    local nId = info.nId
    local mapCfg = ConfigTable.GetData("SoldierPartner", nId)
    if mapCfg ~= nil then
      local nType = mapCfg.PartnerType
      tbActivePartner[nType] = {
        nId = nId,
        nLevel = mapCfg.Level,
        tbSoldiers = info.tbSoldiers or {}
      }
      if not bInit and (self.tbActivePartner[nType] == nil or self.tbActivePartner[nType] ~= nil and self.tbActivePartner[nType].nLevel < mapCfg.Level) then
        tbChangePartnerType[nType] = {
          nId = nId,
          nLevel = mapCfg.Level
        }
      end
    end
  end
  local bSetChanged = next(tbChangePartnerType) ~= nil
  if not bInit and not bSetChanged and self.tbActivePartner ~= nil then
    for nType, prevInfo in pairs(self.tbActivePartner) do
      local curInfo = tbActivePartner[nType]
      if curInfo == nil or curInfo.nId ~= prevInfo.nId or curInfo.nLevel ~= prevInfo.nLevel then
        bSetChanged = true
        break
      end
    end
  end
  self.tbActivePartner = tbActivePartner
  if next(tbChangePartnerType) ~= nil then
    self._tbPendingNewPartner = tbChangePartnerType
    EventManager.Hit("SoldierPartnerNewActive", tbChangePartnerType)
  end
  if bSetChanged then
    self._bPartnerSetChanged = true
  end
  self:UpdateExtraPartnerTag(tbAllPartner)
end

function SoldierLevelData:GetPendingNewPartner()
  return self._tbPendingNewPartner
end

function SoldierLevelData:ClearPendingNewPartner()
  self._tbPendingNewPartner = nil
end

function SoldierLevelData:HasPartnerSetChanged()
  return self._bPartnerSetChanged == true
end

function SoldierLevelData:ClearPartnerSetChangedFlag()
  self._bPartnerSetChanged = nil
end

function SoldierLevelData:UpdateExtraPartnerTag(tbAllPartner)
  if tbAllPartner == nil then
    tbAllPartner = {}
    for _, info in pairs(self.tbActivePartner or {}) do
      if info and info.nId then
        table.insert(tbAllPartner, {
          nId = info.nId,
          tbSoldiers = info.tbSoldiers or {}
        })
      end
    end
  end
  local mapByTid = SoldierAttrData.CalcExtraPartnerTags(self.tbDeployChess, tbAllPartner) or {}
  local mapNew = {}
  for _, entry in ipairs(self.tbDeployChess) do
    if entry.nUid ~= 0 then
      local tagInfo = mapByTid[entry.nId]
      if tagInfo ~= nil and tagInfo.nPositionType == entry.nPositionType and tagInfo.nIndex == entry.nIndex then
        mapNew[entry.nUid] = tagInfo
      end
    end
  end
  local bChanged = false
  local mapOld = self.mapExtraPartnerTag or {}
  for nUid, tbNew in pairs(mapNew) do
    local tbOld = mapOld[nUid]
    local tbNewTypes = tbNew.tbTypes or {}
    if tbOld == nil or tbOld.nPositionType ~= tbNew.nPositionType or tbOld.nIndex ~= tbNew.nIndex or #(tbOld.tbTypes or {}) ~= #tbNewTypes then
      bChanged = true
      break
    end
    for i, nType in ipairs(tbNewTypes) do
      if tbOld.tbTypes[i] ~= nType then
        bChanged = true
        break
      end
    end
    if bChanged then
      break
    end
  end
  if not bChanged then
    for nUid in pairs(mapOld) do
      if mapNew[nUid] == nil then
        bChanged = true
        break
      end
    end
  end
  self.mapExtraPartnerTag = mapNew
  if bChanged then
    EventManager.Hit("SoldierExtraPartnerTagChange")
  end
end

function SoldierLevelData:GetExtraPartnerTags(nUid)
  if self.mapExtraPartnerTag == nil then
    return nil
  end
  local info = self.mapExtraPartnerTag[nUid]
  if info == nil then
    return nil
  end
  return info.tbTypes
end

function SoldierLevelData:PrintSoldier(str)
  if not NovaAPI.IsEditorPlatform() then
    return
  end
  if not PRINT_CHESS_LOG then
    return
  end
  if str then
    print(str)
  end
end

function SoldierLevelData:PrintChess(sTag)
  if not NovaAPI.IsEditorPlatform() then
    return
  end
  if not PRINT_CHESS_LOG then
    return
  end
  sTag = sTag or ""
  local COLOR_TITLE = "#FFFFFF"
  local COLOR_ALL = "#FFD700"
  local COLOR_DEPLOY = "#00FFFF"
  local COLOR_WAITING = "#7CFC00"
  local COLOR_OTHER = "#FF66FF"
  
  local function colorLine(sColor, sText)
    return string.format("<color=%s>%s</color>", sColor, sText)
  end
  
  local function getName(nId)
    if nId == nil or nId == 0 then
      return ""
    end
    local cfg = ConfigTable.GetData("SoldierCharacter", nId)
    return cfg ~= nil and cfg.Name or "?"
  end
  
  local function fmtSlot(nId, nStar)
    if nId == 0 then
      return "_"
    end
    return string.format("%s-%s星[%s]", tostring(nId), tostring(nStar), getName(nId))
  end
  
  local function fmtStack(nId, nStar, nCount)
    return string.format("%s-%s星[%s]-%s", tostring(nId), tostring(nStar), getName(nId), tostring(nCount))
  end
  
  print(colorLine(COLOR_TITLE, string.format("[Soldier][%s] ===== 棋子阵容 =====", sTag)))
  local nFightCount = 0
  for _, v in ipairs(self.tbDeployChess) do
    if v.nPositionType == FightPos then
      if 0 < v.nId then
        nFightCount = nFightCount + 1
      end
      print(colorLine(COLOR_DEPLOY, string.format("[Soldier] 出战席-主控位[%s]: %s", tostring(v.nIndex), fmtSlot(v.nId, v.nStar))))
    end
  end
  print(colorLine(COLOR_DEPLOY, string.format("[Soldier] 出战席-主控位 (总数=%d)", nFightCount)))
  local nSupCount = 0
  for _, v in ipairs(self.tbDeployChess) do
    if v.nPositionType == SupPos then
      if 0 < v.nId then
        nSupCount = nSupCount + 1
      end
      print(colorLine(COLOR_DEPLOY, string.format("[Soldier] 出战席-支援位[%s]: %s", tostring(v.nIndex), fmtSlot(v.nId, v.nStar))))
    end
  end
  print(colorLine(COLOR_DEPLOY, string.format("[Soldier] 出战席-支援位 (总数=%d)", nSupCount)))
  local nWaitingCount = 0
  for _, v in ipairs(self.tbWaitingChess) do
    if 0 < v.nId then
      nWaitingCount = nWaitingCount + 1
    end
    print(colorLine(COLOR_WAITING, string.format("[Soldier] 备战席[%s]: %s", tostring(v.nIndex), fmtSlot(v.nId, v.nStar))))
  end
  print(colorLine(COLOR_WAITING, string.format("[Soldier] 备战席 (总数=%d)", nWaitingCount)))
  local nAllCount = 0
  for i, v in ipairs(self.mapAllChess) do
    nAllCount = nAllCount + v.nCount
    print(colorLine(COLOR_ALL, string.format("[Soldier] 背包[%d]: %s", i, fmtStack(v.nId, v.nStar, v.nCount))))
  end
  print(colorLine(COLOR_ALL, string.format("[Soldier] 背包 (总数=%d)", nAllCount)))
  local nOtherCount = 0
  for i, v in ipairs(self.tbOtherChess) do
    nOtherCount = nOtherCount + v.nCount
    print(colorLine(COLOR_OTHER, string.format("[Soldier] Other[%d]: %s", i, fmtStack(v.nId, v.nStar, v.nCount))))
  end
  print(colorLine(COLOR_OTHER, string.format("[Soldier] Other (总数=%d)", nOtherCount)))
end

function SoldierLevelData:HandleCase()
  for _, v in ipairs(OpenSandTableServerCase) do
    if self.mapCases[v] ~= nil then
      self.bOpenSandTable = true
      break
    end
  end
  for _, v in ipairs(OpenSandTableClientCase) do
    if self.mapClientCases[v] ~= nil then
      self.bOpenSandTable = true
      break
    end
  end
  if self.mapClientCases[ClientCase.DiceResult] ~= nil then
    self:OpenDiceResult()
    return
  end
  if self.mapClientCases[ClientCase.BattleResult] ~= nil then
    self:BattleResult()
    self.mapClientCases[ClientCase.BattleResult] = nil
    return
  end
  if self.mapClientCases[ClientCase.Ending] ~= nil then
    self:OpenSoldierEnding()
    return
  end
  if self.mapClientCases[ClientCase.Settle] ~= nil then
    self:SoldierSettle()
    return
  end
  if self.mapClientCases[ClientCase.StageChange] ~= nil then
    self:OpenStageChange()
    return
  end
  if self.mapClientCases[ClientCase.CheckStagePanel] ~= nil then
    self:OpenCheckStage()
    return
  end
  if self.mapCases[CaseEnum.CheckStage] ~= nil then
    self:EnterCheckStageCase()
    return
  end
  if self.mapCases[CaseEnum.SelectBossAbility] ~= nil then
    self:OpenBossAbilitySelect()
    return
  end
  if self.mapCases[CaseEnum.SelectCard] ~= nil then
    self:OpenStrategyCardSelect()
    return
  end
  if self.mapCases[CaseEnum.Fight] ~= nil then
    self:OpenSandTable()
    return
  end
  if self.mapCases[CaseEnum.Battle] ~= nil then
    self:EnterBattleCase()
    return
  end
  if self.mapCases[CaseEnum.EventSettlementOfDispute] ~= nil then
    self:OpenEventSelect()
    return
  end
  if self.mapCases[CaseEnum.EventSettlementOfDisputeBattle] ~= nil then
    self:EventSettlementOfDispute()
    return
  end
  if self.mapCases[CaseEnum.StoryEventOfPersonality] ~= nil then
    self:OpenStoryEventOfPersonality()
    return
  end
  if self.mapCases[CaseEnum.StoryEventOfCostly] ~= nil then
    self:OpenStoryEventOfCostly()
    return
  end
  if self.mapCases[CaseEnum.ClientEvent] ~= nil then
    return
  end
end

function SoldierLevelData:StartSoldierLevel()
  EventManager.Hit(EventId.SetTransition)
  EventManager.Hit(EventId.BlockInput, true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit(EventId.BlockInput, false)
    self:HandleCase()
  end
  
  cs_coroutine.start(wait)
end

function SoldierLevelData:OpenStrategyCardSelect()
  self:PreloadSandtableScene(function()
    EventManager.Hit("SoldierSandtableSceneReady")
  end)
  local mapCase = self:_GetCaseDataByType(CaseEnum.SelectCard)
  if mapCase ~= nil then
    if not PanelManager.CheckPanelOpen(PanelId.SoldierBattleEventPanel) then
      EventManager.Hit(EventId.OpenPanel, PanelId.SoldierBattleEventPanel, true)
    end
    EventManager.Hit("EnterCardSelect")
  end
end

function SoldierLevelData:OpenEventSelect()
  self:PreloadSandtableScene(function()
    EventManager.Hit("SoldierSandtableSceneReady")
  end)
  local mapCase = self:_GetCaseDataByType(CaseEnum.EventSettlementOfDispute)
  if mapCase ~= nil then
    if not PanelManager.CheckPanelOpen(PanelId.SoldierBattleEventPanel) then
      EventManager.Hit(EventId.OpenPanel, PanelId.SoldierBattleEventPanel)
    end
    EventManager.Hit("EnterEventSelect")
  end
end

function SoldierLevelData:_OpenSoldierStagePanel(bIsChallenge, data)
  self:PreloadSandtableScene(function()
    EventManager.Hit("SoldierSandtableSceneReady")
  end)
  
  local function callback()
    self:HandleCase()
  end
  
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierStagePanel, bIsChallenge, data.nStageId, data.nCurNodeId, callback)
end

function SoldierLevelData:OpenStageChange()
  local data = self.mapClientCases[ClientCase.StageChange]
  self.mapClientCases[ClientCase.StageChange] = nil
  self:_OpenSoldierStagePanel(false, data)
end

function SoldierLevelData:OpenDiceResult()
  local data = self.mapClientCases[ClientCase.DiceResult]
  self.mapClientCases[ClientCase.DiceResult] = nil
  
  local function fnOnClose()
    self:HandleCase()
  end
  
  EventManager.Hit("SoldierPlayDiceResult", data, fnOnClose)
end

function SoldierLevelData:OpenCheckStage()
  self.mapClientCases[ClientCase.CheckStagePanel] = nil
  local data = {
    nStageId = self.nStageId,
    nCurNodeId = self.nNodeId
  }
  self:_OpenSoldierStagePanel(true, data)
end

function SoldierLevelData:EnterCheckStageCase()
  local mapCase = self:_GetCaseDataByType(CaseEnum.CheckStage)
  if mapCase == nil then
    return
  end
  self:_EnterBattle(mapCase.nFloorId)
end

function SoldierLevelData:OpenBossAbilitySelect()
  local function fnConfirm(nAbilityId)
    self:SendSelectBossAbility(nAbilityId)
  end
  
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierBossTemplateSelect, fnConfirm)
end

function SoldierLevelData:OpenSandTable()
  if self.bOpenSandTable then
    self:PreloadSandtableScene(function()
      EventManager.Hit("EnterStandTable")
    end)
  end
  self.bOpenSandTable = false
end

function SoldierLevelData:BattleResult()
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierPartnerTips)
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierCharCardTips)
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierCharSkillDetail)
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierCharPontentialDetailPanel)
  local nType = self.mapClientCases[ClientCase.BattleResult].nType
  local tbDamage = self.mapClientCases[ClientCase.BattleResult].tbDamage
  local tbChange = self.mapClientCases[ClientCase.BattleResult].tbChange
  local tbCoinReward = self.mapClientCases[ClientCase.BattleResult].tbCoinReward
  local bEventBattle = self.mapClientCases[ClientCase.BattleResult].bEventBattle
  local mapData = {
    tbDamage = tbDamage,
    tbChange = tbChange,
    tbCoinReward = tbCoinReward,
    bEventBattle = bEventBattle
  }
  
  local function callback()
    EventManager.Hit(EventId.BlockInput, true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit(EventId.BlockInput, false)
      self:HandleCase()
    end
    
    cs_coroutine.start(wait)
  end
  
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierBattleResult, nType, mapData, callback)
  if self.curBattle ~= nil then
    self.curBattle:Exit()
    self.curBattle = nil
  end
end

function SoldierLevelData:OpenSoldierEnding()
  local endingData = self.mapClientCases[ClientCase.Ending].data
  self.mapClientCases[ClientCase.Ending] = nil
  
  local function callback()
    EventManager.Hit(EventId.BlockInput, true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit(EventId.BlockInput, false)
      self:HandleCase()
    end
    
    cs_coroutine.start(wait)
  end
  
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierBattleEnding, endingData, callback)
end

function SoldierLevelData:SoldierSettle()
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierPartnerTips)
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierCharCardTips)
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierCharSkillDetail)
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierCharPontentialDetailPanel)
  local settleData = self.mapClientCases[ClientCase.Settle]
  local nType = settleData.nType
  local mapData = {
    tbSettle = settleData.tbSettle,
    tbChess = settleData.tbChess,
    tbDamage = settleData.tbDamage,
    nBossTemplateId = settleData.nBossTemplateId,
    nHp = settleData.nHp,
    nCoin = settleData.nCoin,
    tbCard = settleData.tbCard,
    nGradeChallengeId = settleData.nGradeChallengeId
  }
  if PanelManager.CheckPanelOpen(PanelId.SoldierBattleResult) then
    EventManager.Hit("SoldierChallengeEnd", nType, mapData)
  else
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierBattleResult, nType, mapData)
  end
  EventManager.Hit(EventId.BlockInput, true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit(EventId.ClosePanel, PanelId.SoldierSandtable)
    EventManager.Hit(EventId.ClosePanel, PanelId.SoldierBattleEventPanel)
    EventManager.Hit(EventId.BlockInput, false)
  end
  
  cs_coroutine.start(wait)
  if self.curBattle ~= nil then
    self.curBattle:Exit()
    self.curBattle = nil
  end
  if nType == AllEnum.SoldierResultType.ChallengeSuccess then
    PlayerData.SoldierData:SetHighestChallengeId(self.nGradeChallengeId)
  end
  self.parent:SoldierLevelEnd(true)
end

function SoldierLevelData:GiveUp(netMsgData)
  self.mapClientCases[ClientCase.Settle] = {
    nType = AllEnum.SoldierResultType.ChallengeFail,
    tbSettle = {
      nPassedNode = netMsgData.PassedNode,
      nRemainingHp = netMsgData.RemainingHp,
      nCheckStageDps = netMsgData.CheckStageDps,
      nCheckStageTime = netMsgData.CheckStageTime,
      nChessTotalCost = netMsgData.ChessTotalCost,
      nGetSchedule = netMsgData.GetSchedule,
      nGetTechPoint = netMsgData.GetTechPoint,
      nGetGradeExp = netMsgData.GetGradeExp,
      nCurGradeChallengeId = netMsgData.CurGradeChallengeId,
      nCurGradeExp = netMsgData.CurGradeExp,
      nEndingId = netMsgData.EndingId,
      nTotalCoinQty = netMsgData.TotalCoinQty
    },
    tbChess = self.tbDeployChess or {},
    tbDamage = self.tbLastBattleDamage or {},
    nBossTemplateId = self.nBossTemplateId or 0,
    nHp = self:GetHp() or 0,
    nCoin = self:GetItem(AllEnum.CoinItemId.SoldierCurrency) or 0,
    tbCard = self:GetCardData() or {},
    nGradeChallengeId = self.nGradeChallengeId or 0
  }
  self:HandleCase()
end

function SoldierLevelData:StepOut()
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierSandtable)
  if self.curBattle ~= nil then
    self.curBattle:Exit()
    self.curBattle = nil
  end
  self.parent:SoldierLevelEnd(false)
end

function SoldierLevelData:_EnterBattle(nFloorId, nEventId)
  self:UnloadSandtableScene()
  if self.curBattle == nil then
    self.curBattle = require("Game.Adventure.Soldier.SoldierBattle").new()
  end
  local nTemplateId = 0
  local nAdjustmentGrade = 0
  local mapChallengeCfg = ConfigTable.GetData("SoldierGradeChallenge", self.nGradeChallengeId)
  if mapChallengeCfg ~= nil then
    nTemplateId = nTemplateId + mapChallengeCfg.DiffcultyTemplateLv
    nAdjustmentGrade = mapChallengeCfg.AdjustmentGrade
  end
  local tbCards = self:GetCardData()
  local tbAddition = {}
  local sConfig = ConfigTable.GetConfigValue("SoldierCardQualityAdjustGradeAdd")
  if sConfig ~= nil then
    local tbConfig = decodeJson(sConfig)
    for k, v in pairs(tbConfig) do
      tbAddition[tonumber(k)] = tonumber(v)
    end
  end
  for _, v in ipairs(tbCards) do
    local cfg = ConfigTable.GetData("SoldierStrategyCard", v.nId)
    if cfg ~= nil and tbAddition[cfg.Rarity] ~= nil then
      nAdjustmentGrade = nAdjustmentGrade + tbAddition[cfg.Rarity]
    end
  end
  local mapNodeCfg = ConfigTable.GetData("SoldierNodePlan", self.nNodeId)
  if mapNodeCfg ~= nil then
    nTemplateId = nTemplateId + mapNodeCfg.DifficultyLevelAdd
  end
  if nEventId ~= nil and nEventId ~= 0 then
    local mapEventPoolCfg = ConfigTable.GetData("SoldierEventBattlePool", nEventId)
    if mapEventPoolCfg ~= nil then
      nTemplateId = nTemplateId + mapEventPoolCfg.AddDifficult
    end
  end
  self.curBattle:Init(self, self.tbDeployChess, nFloorId, self.nStageId, nTemplateId, nAdjustmentGrade, self.nBossTemplateId)
end

function SoldierLevelData:EnterBattleCase()
  local mapBattleCase = self:_GetCaseDataByType(CaseEnum.Battle)
  if mapBattleCase == nil then
    return
  end
  self:_EnterBattle(mapBattleCase.nFloorId)
end

function SoldierLevelData:EventSettlementOfDispute()
  local mapBattleCase = self:_GetCaseDataByType(CaseEnum.EventSettlementOfDisputeBattle)
  if mapBattleCase == nil then
    return
  end
  self:_EnterBattle(mapBattleCase.nFloorId, mapBattleCase.nEventId)
end

function SoldierLevelData:OpenStoryEventOfPersonality()
  local mapCase = self:_GetCaseDataByType(CaseEnum.StoryEventOfPersonality)
  if mapCase == nil then
    return
  end
  self:PreloadSandtableScene(function()
    EventManager.Hit("SoldierSandtableSceneReady")
  end)
  if mapCase.nIndex == 0 then
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierEventPanel)
  else
    local nIndex = mapCase.nIndex
    local tbOptions = mapCase.tbOptions
    local nSelectOptionId = tbOptions[nIndex].PersonalityOptionId
    local mapPersonalityOption = ConfigTable.GetData("SoldierStoryPersonalityOption", nSelectOptionId)
    if mapPersonalityOption ~= nil and mapPersonalityOption.CheckDimension ~= nil and 0 < mapPersonalityOption.CheckDimension and mapPersonalityOption.CheckDifficulty ~= nil and 0 < mapPersonalityOption.CheckDifficulty then
      local nCheckDimension = mapPersonalityOption.CheckDimension
      local nCheckDifficulty = mapPersonalityOption.CheckDifficulty
      local mapBossCfg = ConfigTable.GetData("SoldierBossTemplate", self.nBossTemplateId or 0)
      local tbPersonalityGrade = {}
      if mapBossCfg ~= nil then
        tbPersonalityGrade[GameEnum.SoldierRolePersonality.Personality_Intuition] = mapBossCfg.Personality_Intuition
        tbPersonalityGrade[GameEnum.SoldierRolePersonality.Personality_Analysis] = mapBossCfg.Personality_Analysis
        tbPersonalityGrade[GameEnum.SoldierRolePersonality.Personality_Chaos] = mapBossCfg.Personality_Chaos
      end
      local sPersonalityGrade = tbPersonalityGrade[nCheckDimension]
      local nDimensionDifficulty = mapPersonalityOption.CheckDifficulty
      local pram = {
        nPersonalityType = nCheckDimension,
        nDimensionLevel = nCheckDifficulty,
        sPersonalityGrade = sPersonalityGrade,
        nDimensionDifficulty = nDimensionDifficulty
      }
      EventManager.Hit(EventId.OpenPanel, PanelId.SoldierResolveadisputePanel, pram)
    end
  end
  EventManager.Hit("EnterEventSelect")
end

function SoldierLevelData:OpenStoryEventOfCostly()
  local mapCase = self:_GetCaseDataByType(CaseEnum.StoryEventOfCostly)
  if mapCase == nil then
    return
  end
  self:PreloadSandtableScene(function()
    EventManager.Hit("SoldierSandtableSceneReady")
  end)
  if PanelManager.CheckPanelOpen(PanelId.SoldierEventPanel) then
    EventManager.Hit("RefreshStoryEventOfCostly")
  else
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierEventPanel)
  end
  EventManager.Hit("EnterEventSelect")
end

function SoldierLevelData:BattleEnd(bResult, tbParam)
  if self.mapCases[CaseEnum.Battle] == nil and self.mapCases[CaseEnum.EventSettlementOfDisputeBattle] == nil and self.mapCases[CaseEnum.CheckStage] == nil then
    local nType = bResult and AllEnum.SoldierResultType.NodeSuccess or AllEnum.SoldierResultType.NodeFail
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierBattleResult, nType, {
      tbChange = {nHpChange = 0, nLevelChange = 0},
      bEventBattle = false
    })
    self.curBattle:Exit()
    self:Exit()
    return
  end
  local nBattleTime = tbParam.nTime or 0
  local tbDamage = tbParam.tbDamage or {}
  local nCoin = tbParam.nCoin or 0
  local nHarvest = tbParam.nHarvest or 0
  local nAllDamage = tbParam.nAllDamage or 0
  self.tbLastBattleDamage = tbDamage
  if self.mapCases[CaseEnum.Battle] ~= nil then
    if bResult then
      self:SendBattleVictory(nBattleTime, tbDamage, nCoin, nHarvest)
    else
      self:SendBattleDefeat(tbDamage, nCoin, nHarvest)
    end
  elseif self.mapCases[CaseEnum.EventSettlementOfDisputeBattle] ~= nil then
    if bResult then
      self:SendEventSettlementOfDisputeBattleVictory(nBattleTime, tbDamage, nCoin, nHarvest)
    else
      self:SendEventSettlementOfDisputeBattleDefeat(tbDamage, nCoin, nHarvest)
    end
  elseif self.mapCases[CaseEnum.CheckStage] ~= nil then
    local nDpsId, nTimeId = self.parent:GetCheckStageAddScoreId(nAllDamage, nBattleTime)
    self:SendCheckStageSettle(nDpsId, nTimeId)
  end
end

function SoldierLevelData:_MergeApplyObtainSteps(tbSteps)
  if tbSteps == nil or #tbSteps <= 1 then
    return tbSteps
  end
  local tbMerged = {}
  local curMerge
  
  local function isPureObtain(step)
    return (step.tbConsume == nil or #step.tbConsume == 0) and (step.tbUpdate == nil or #step.tbUpdate == 0) and step.tbObtain ~= nil and 0 < #step.tbObtain
  end
  
  for _, step in ipairs(tbSteps) do
    if isPureObtain(step) then
      if curMerge == nil then
        curMerge = {
          tbConsume = {},
          tbObtain = {},
          tbUpdate = {}
        }
      end
      for _, ch in ipairs(step.tbObtain) do
        table.insert(curMerge.tbObtain, ch)
      end
    else
      if curMerge ~= nil then
        table.insert(tbMerged, curMerge)
        curMerge = nil
      end
      table.insert(tbMerged, step)
    end
  end
  if curMerge ~= nil then
    table.insert(tbMerged, curMerge)
  end
  return tbMerged
end

function SoldierLevelData:CacheReward(nType, data)
  if data == nil or next(data) == nil then
    return
  end
  if self.mapCases[CaseEnum.Fight] ~= nil then
    return
  end
  local nTargetIdx
  for i, v in ipairs(self.tbPendingRewards) do
    if v.nType == nType then
      v.data = v.data or {}
      if data.tbChess ~= nil then
        v.data.tbChess = v.data.tbChess or {}
        for _, c in ipairs(data.tbChess) do
          table.insert(v.data.tbChess, c)
        end
      end
      if data.nCoin ~= nil then
        v.data.nCoin = (v.data.nCoin or 0) + data.nCoin
      end
      nTargetIdx = i
      break
    end
  end
  if nTargetIdx == nil then
    local newData = {}
    if data.tbChess ~= nil and #data.tbChess > 0 then
      newData.tbChess = {}
      for _, c in ipairs(data.tbChess) do
        table.insert(newData.tbChess, c)
      end
    end
    if data.nCoin ~= nil then
      newData.nCoin = data.nCoin
    end
    if next(newData) ~= nil then
      table.insert(self.tbPendingRewards, {
        nType = nType,
        data = newData,
        tbSteps = {}
      })
      nTargetIdx = #self.tbPendingRewards
    end
  end
  if nTargetIdx ~= nil and self._tbTouchedRewardIdxes ~= nil then
    local bExist = false
    for _, idx in ipairs(self._tbTouchedRewardIdxes) do
      if idx == nTargetIdx then
        bExist = true
        break
      end
    end
    if not bExist then
      table.insert(self._tbTouchedRewardIdxes, nTargetIdx)
    end
  end
  return nTargetIdx
end

function SoldierLevelData:GetPendingReward()
  local cache = clone(self.tbPendingRewards)
  self.tbPendingRewards = {}
  for _, entry in ipairs(cache) do
    if entry.tbSteps ~= nil and #entry.tbSteps > 1 then
      entry.tbSteps = self:_MergeApplyObtainSteps(entry.tbSteps)
    end
  end
  return cache
end

function SoldierLevelData:_CheckBatchWipeContext(param, tbTransforms)
  if tbTransforms == nil or #tbTransforms == 0 then
    return false
  end
  if type(param) ~= "table" or not param.bFromCardSelect then
    return false
  end
  for _, mapTrans in ipairs(tbTransforms) do
    if mapTrans.Obtain ~= nil and 0 < #mapTrans.Obtain then
      return false
    end
  end
  return true
end

function SoldierLevelData:_NetOutPendingRewards(tbBatchConsume)
  if tbBatchConsume == nil or #tbBatchConsume == 0 then
    return
  end
  for _, c in ipairs(tbBatchConsume) do
    local nUid = c.nUid
    for i = #self.tbPendingRewards, 1, -1 do
      local entry = self.tbPendingRewards[i]
      local bRemoved = false
      if entry.data ~= nil and entry.data.tbChess ~= nil then
        for j, ch in ipairs(entry.data.tbChess) do
          if ch.UID == nUid then
            table.remove(entry.data.tbChess, j)
            bRemoved = true
            break
          end
        end
      end
      if bRemoved and entry.tbSteps ~= nil then
        for stepIdx = #entry.tbSteps, 1, -1 do
          local step = entry.tbSteps[stepIdx]
          local bStepHit = false
          if step.tbObtain ~= nil then
            for k, o in ipairs(step.tbObtain) do
              if o.nUid == nUid then
                table.remove(step.tbObtain, k)
                bStepHit = true
                break
              end
            end
          end
          if bStepHit and (step.tbConsume == nil or #step.tbConsume == 0) and (step.tbObtain == nil or #step.tbObtain == 0) and (step.tbUpdate == nil or #step.tbUpdate == 0) then
            table.remove(entry.tbSteps, stepIdx)
          end
          if bStepHit then
            break
          end
        end
      end
      if bRemoved then
        break
      end
    end
  end
  for i = #self.tbPendingRewards, 1, -1 do
    local entry = self.tbPendingRewards[i]
    local bDataEmpty = entry.data == nil or (entry.data.tbChess == nil or #entry.data.tbChess == 0) and (entry.data.nCoin == nil or entry.data.nCoin == 0)
    local bNoSteps = entry.tbSteps == nil or #entry.tbSteps == 0
    if bDataEmpty and bNoSteps then
      table.remove(self.tbPendingRewards, i)
    end
  end
end

function SoldierLevelData:_GetCaseIdByType(nCaseType)
  local mapCase = self:_GetCaseDataByType(nCaseType)
  if mapCase ~= nil then
    return mapCase.nId
  end
end

function SoldierLevelData:_GetCaseDataByType(nCaseType)
  local mapCase = self.mapCases[nCaseType]
  if mapCase == nil then
    traceback("[Soldier] Case为空！！！ caseType = " .. tostring(nCaseType))
    return nil
  end
  return mapCase
end

function SoldierLevelData:_SendInteract(mapMsgData, param, callback)
  if mapMsgData == nil then
    printError("[Soldier] _SendInteract 缺少 mapMsgData")
    return
  end
  if mapMsgData.Id == nil or mapMsgData.Id == 0 then
    printError("[Soldier] _SendInteract 缺少有效 Case Id")
    return
  end
  
  local function netCallback(_, netMsgData)
    self:_OnInteract(netMsgData, param, callback)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.soldier_interact_req, mapMsgData, nil, netCallback)
end

function SoldierLevelData:SendMove(nUid, nSlot, callback)
  if nUid == nil or self.mapChessByUid[nUid] == nil then
    printError("[Soldier] SendMove 无效 UID: " .. tostring(nUid))
    return
  end
  self:PrintSoldier(string.format("[Soldier]移动棋子 UID=%s -> Slot=%s", nUid, nSlot))
  local nCaseId = self:_GetCaseIdByType(CaseEnum.DeployOpt)
  self:_SendInteract({
    Id = nCaseId,
    DeploySyncReq = {
      DeployVersion = self.nDeployVersion,
      Move = {UID = nUid, Slot = nSlot}
    }
  }, nil, callback)
end

function SoldierLevelData:SendShopPurchase(nGoodsIndex, callback)
  self:PrintSoldier("[Soldier]购买商品  --  " .. nGoodsIndex)
  local nCaseId = self:_GetCaseIdByType(CaseEnum.Shop)
  self:_SendInteract({
    Id = nCaseId,
    ShopReq = {Purchase = nGoodsIndex}
  }, nil, callback)
end

function SoldierLevelData:SendShopSell(chessData, callback)
  if chessData == nil then
    return
  end
  local nUid = chessData.nUid
  if (nUid == nil or nUid == 0) and chessData.nId ~= nil then
    for _, nOtherUid in ipairs(self.tbOtherUids) do
      local chess = self.mapChessByUid[nOtherUid]
      if chess ~= nil and chess.nTid == chessData.nId and chess.nStar == chessData.nStar then
        nUid = nOtherUid
        break
      end
    end
  end
  if nUid == nil or nUid == 0 then
    printError("[Soldier] SendShopSell 找不到棋子 UID")
    return
  end
  local chess = self.mapChessByUid[nUid]
  if chess == nil then
    printError("[Soldier] SendShopSell UID 无对应棋子: " .. tostring(nUid))
    return
  end
  self:PrintSoldier(string.format("[Soldier]出售棋子 -- UID=%s Tid=%s Star=%s Slot=%s", nUid, chess.nTid, chess.nStar, chess.nSlot))
  local nCaseId = self:_GetCaseIdByType(CaseEnum.Shop)
  local mapChess = {
    UID = nUid,
    Tid = chess.nTid,
    Star = chess.nStar,
    Slot = chess.nSlot
  }
  self:_SendInteract({
    Id = nCaseId,
    ShopReq = {Sell = mapChess}
  }, {nUid = nUid}, callback)
end

function SoldierLevelData:SendShopRefresh(callback)
  self:PrintSoldier("[Soldier]商店刷新")
  local nCaseId = self:_GetCaseIdByType(CaseEnum.Shop)
  self:_SendInteract({
    Id = nCaseId,
    ShopReq = {Refresh = true}
  }, nil, callback)
end

function SoldierLevelData:SendShopBuyExp(callback)
  self:PrintSoldier("[Soldier]购买经验")
  local nCaseId = self:_GetCaseIdByType(CaseEnum.Shop)
  self:_SendInteract({
    Id = nCaseId,
    ShopReq = {Upgrade = true}
  }, nil, callback)
end

function SoldierLevelData:SendShopLock(bLock, callback)
  self:PrintSoldier("[Soldier]商店锁定")
  local nCaseId = self:_GetCaseIdByType(CaseEnum.Shop)
  self:_SendInteract({
    Id = nCaseId,
    ShopReq = {Lock = bLock}
  }, nil, callback)
end

function SoldierLevelData:SendFight(callback)
  self:PrintSoldier("[Soldier]备战界面点出发")
  local nCaseId = self:_GetCaseIdByType(CaseEnum.Fight)
  self:_SendInteract({
    Id = nCaseId,
    FightReq = {}
  }, nil, callback)
end

function SoldierLevelData:SendBattleVictory(nBattleTime, tbDamage, nCoin, nHarvest, callback)
  self:PrintSoldier("[Soldier]节点胜利结算, 本场战斗获得金币数：" .. nCoin)
  local nCaseId = self:_GetCaseIdByType(CaseEnum.Battle)
  local tbEvents = self:_BuildHarvestEvent(nHarvest)
  local tbVictoryData = {
    DataLen = 1,
    ClientData = "",
    DataVersion = 1,
    ChessSkillAddGold = nCoin,
    Events = tbEvents,
    Victory = {Time = nBattleTime}
  }
  local tbParam = {
    nResultType = AllEnum.SoldierResultType.NodeSuccess,
    tbDamage = tbDamage
  }
  self:_SendInteract({Id = nCaseId, BattleReq = tbVictoryData}, tbParam, callback)
end

function SoldierLevelData:SendBattleDefeat(tbDamage, nCoin, nHarvest, callback)
  self:PrintSoldier("[Soldier]节点失败结算, 本场战斗获得金币数：" .. nCoin)
  local nCaseId = self:_GetCaseIdByType(CaseEnum.Battle)
  local tbEvents = self:_BuildHarvestEvent(nHarvest)
  local tbDefeatData = {
    DataLen = 1,
    ClientData = "",
    DataVersion = 1,
    ChessSkillAddGold = nCoin,
    Events = tbEvents,
    Defeat = true
  }
  local tbParam = {
    nResultType = AllEnum.SoldierResultType.NodeFail,
    tbDamage = tbDamage
  }
  self:_SendInteract({Id = nCaseId, BattleReq = tbDefeatData}, tbParam, callback)
end

function SoldierLevelData:SendEventBattleChoose(nIndex, callback)
  self:PrintSoldier("[Soldier]事件争端选择奖励  --  " .. nIndex)
  local nCaseId = self:_GetCaseIdByType(CaseEnum.EventSettlementOfDispute)
  self:_SendInteract({
    Id = nCaseId,
    EventSettlementOfDisputeReq = {Index = nIndex}
  }, nil, callback)
end

function SoldierLevelData:SendEventSettlementOfDisputeBattleVictory(nBattleTime, tbDamage, nCoin, nHarvest, callback)
  self:PrintSoldier("[Soldier]事件争端战斗胜利, 本场战斗获得金币数：" .. nCoin)
  local nCaseId = self:_GetCaseIdByType(CaseEnum.EventSettlementOfDisputeBattle)
  local tbEvents = self:_BuildHarvestEvent(nHarvest)
  local tbVictoryData = {
    DataLen = 1,
    ClientData = "",
    DataVersion = 1,
    ChessSkillAddGold = nCoin,
    Events = tbEvents,
    Victory = {Time = nBattleTime}
  }
  local tbParam = {
    nResultType = AllEnum.SoldierResultType.NodeSuccess,
    tbDamage = tbDamage
  }
  self:_SendInteract({Id = nCaseId, EventSettlementOfDisputeBattleReq = tbVictoryData}, tbParam, callback)
end

function SoldierLevelData:SendEventSettlementOfDisputeBattleDefeat(tbDamage, nCoin, nHarvest, callback)
  self:PrintSoldier("[Soldier]事件争端战斗失败, 本场战斗获得金币数：" .. nCoin)
  local nCaseId = self:_GetCaseIdByType(CaseEnum.EventSettlementOfDisputeBattle)
  local tbEvents = self:_BuildHarvestEvent(nHarvest)
  local tbDefeatData = {
    DataLen = 1,
    ClientData = "",
    DataVersion = 1,
    ChessSkillAddGold = nCoin,
    Events = tbEvents,
    Defeat = true
  }
  local tbParam = {
    nResultType = AllEnum.SoldierResultType.NodeFail,
    tbDamage = tbDamage
  }
  self:_SendInteract({Id = nCaseId, EventSettlementOfDisputeBattleReq = tbDefeatData}, tbParam, callback)
end

function SoldierLevelData:SendCardSelect(nIndex, callback)
  local mapCase = self.mapCases[CaseEnum.SelectCard]
  if mapCase ~= nil then
    local nCaseId = mapCase.nId
    self:PrintSoldier("[Soldier]buff卡三选一  -- " .. nIndex)
    self:_SendInteract({
      Id = nCaseId,
      SelectReq = {Index = nIndex}
    }, {bFromCardSelect = true}, callback)
    return
  end
  mapCase = self.mapCases[CaseEnum.StoryEventOfCostly]
  if mapCase ~= nil then
    local nCaseId = mapCase.nId
    self:PrintSoldier("[Soldier]代价剧情三选一  -- " .. nIndex)
    self:_SendInteract({
      Id = nCaseId,
      SelectReq = {Index = nIndex}
    }, nil, callback)
  end
end

function SoldierLevelData:SendCardSelectReRoll(callback)
  self:PrintSoldier("[Soldier]开局buff卡重随")
  local nCaseId = self:_GetCaseIdByType(CaseEnum.SelectCard)
  self:_SendInteract({
    Id = nCaseId,
    SelectReq = {ReRoll = true}
  }, nil, callback)
end

function SoldierLevelData:SendClientEvent(sClientData, nDataVersion)
  local nCaseId = self:_GetCaseIdByType(CaseEnum.ClientEvent)
  self:_SendInteract({
    Id = nCaseId,
    ClientEventReq = {
      DataLen = #sClientData,
      ClientData = sClientData,
      DataVersion = nDataVersion
    }
  })
end

function SoldierLevelData:SendSelectBossAbility(nAbilityId, callback)
  self:PrintSoldier("[Soldier]选择魔王能力  --  " .. tostring(nAbilityId))
  local nCaseId = self:_GetCaseIdByType(CaseEnum.SelectBossAbility)
  self:_SendInteract({
    Id = nCaseId,
    SelectBossAbilityReq = {AbilityId = nAbilityId}
  }, nil, function(tbChange)
    self.nBossTemplateId = nAbilityId
    if callback then
      callback(tbChange)
    end
  end)
end

function SoldierLevelData:SendCheckStageSettle(nDpsId, nTimeId, callback)
  self:PrintSoldier(string.format("[Soldier]木桩关结算 DpsId=%s TimeId=%s", tostring(nDpsId), tostring(nTimeId)))
  local nCaseId = self:_GetCaseIdByType(CaseEnum.CheckStage)
  self:_SendInteract({
    Id = nCaseId,
    CheckStageSettleReq = {DpsId = nDpsId, TimeId = nTimeId}
  }, nil, callback)
end

function SoldierLevelData:SendPartnerTrace(nPartnerType, bTrace, callback)
  local function netCallback(_, netMsgData)
    self:UpdatePartnerTrace(nPartnerType, bTrace)
    
    if callback then
      callback()
    end
  end
  
  local mapMsgData = {PartnerType = nPartnerType, Trace = bTrace}
  HttpNetHandler.SendMsg(NetMsgId.Id.soldier_partner_trace_req, mapMsgData, nil, netCallback)
end

function SoldierLevelData:SendStoryEventSelect(nIndex, callback)
  if self.mapCases[CaseEnum.StoryEventOfPersonality] ~= nil then
    self:SendStoryEventOfPersonalityIndex(nIndex, callback)
    return
  end
  if self.mapCases[CaseEnum.StoryEventOfCostly] ~= nil then
    self:SendCardSelect(nIndex, callback)
    return
  end
end

function SoldierLevelData:SendStoryEventOfPersonalityIndex(nIndex, callback)
  self:PrintSoldier("[Soldier]性格剧情选择选项 -- " .. tostring(nIndex))
  local nCaseId = self:_GetCaseIdByType(CaseEnum.StoryEventOfPersonality)
  self:_SendInteract({
    Id = nCaseId,
    StoryEventOfPersonalitySelectReq = {Index = nIndex}
  }, nil, callback)
end

function SoldierLevelData:SendStoryEventOfPersonalityThrowDice(callback)
  self:PrintSoldier("[Soldier]性格剧情掷骰子")
  local nCaseId = self:_GetCaseIdByType(CaseEnum.StoryEventOfPersonality)
  self:_SendInteract({
    Id = nCaseId,
    StoryEventOfPersonalitySelectReq = {ThrowDice = true}
  }, nil, callback)
end

function SoldierLevelData:UpdateNodeInfo(nodeData, tbChange, bSuppressStageChangeCase)
  if nodeData == nil then
    return
  end
  local tbNodeChange = {}
  local bNodeChange = false
  local bStageChange = false
  if nodeData.NodeId ~= self.nNodeId then
    bNodeChange = true
  end
  if nodeData.StageId ~= self.nStageId then
    bStageChange = true
  end
  tbNodeChange.bNodeChange = bNodeChange
  tbNodeChange.nLastStageId = self.nStageId
  tbNodeChange.nLastNodeId = self.nNodeId
  tbNodeChange.nLastNodeType = self.nNodeType
  self.nStageId = nodeData.StageId
  self.nNodeType = nodeData.Type
  self.nNodeId = nodeData.NodeId
  if self.nNodeId ~= 0 then
    local mapCfg = ConfigTable.GetData("SoldierNodePlan", self.nNodeId)
    if mapCfg ~= nil then
      self.parent:SetCurGradeChallengeData(self.nGradeChallengeId, self.nStageId, mapCfg.Index)
    end
  end
  if tbChange then
    tbChange.tbNodeChange = tbNodeChange
  end
  if bStageChange then
    self:UpdateNodeList()
    if not bSuppressStageChangeCase then
      self.mapClientCases[ClientCase.StageChange] = {
        nStageId = self.nStageId,
        nCurNodeId = self.nNodeId
      }
    end
  end
end

function SoldierLevelData:UpdateBaseInfo(baseData, tbChange)
  if baseData == nil then
    return
  end
  if tbChange ~= nil then
    tbChange.nHpChange = baseData.Hp - self.nHp
    tbChange.nLevelChange = baseData.Level - self.nLevel
  end
  self.nHp = baseData.Hp
  self.nLevel = baseData.Level
  self.nExp = baseData.Exp
  self.nWiningStreak = baseData.WinningStreak
  self.nLosingStreak = baseData.LosingStreak
  EventManager.Hit("SoldierHpChange")
end

function SoldierLevelData:UpdateGMSoldierHp(nHp)
  if nHp == nil then
    return
  end
  self.nHp = nHp
  EventManager.Hit("SoldierHpChange")
end

function SoldierLevelData:UpdateChangeInfo(mapChangeInfo, tbChange, param)
  local tbSteps = {}
  local mapDecodeInfo = UTILS.DecodeChangeInfo(mapChangeInfo)
  if mapDecodeInfo["proto.SoldierRes"] ~= nil then
    local itemChange = {}
    for _, mapItemInfo in ipairs(mapDecodeInfo["proto.SoldierRes"]) do
      if self.mapItems[mapItemInfo.Tid] == nil then
        self.mapItems[mapItemInfo.Tid] = 0
      end
      itemChange[mapItemInfo.Tid] = mapItemInfo.Qty
      self.mapItems[mapItemInfo.Tid] = self.mapItems[mapItemInfo.Tid] + mapItemInfo.Qty
    end
    if tbChange ~= nil then
      tbChange.itemChange = itemChange
    end
    EventManager.Hit("SoldierItemChange", itemChange)
  end
  if mapDecodeInfo["proto.SoldierChessChange"] ~= nil then
    for _, change in ipairs(mapDecodeInfo["proto.SoldierChessChange"]) do
      if change.BaseVersion ~= self.nDeployVersion then
        printError(string.format("[Soldier] SoldierChessChange 版本号不匹配 base=%s local=%s next=%s, 丢弃; 等 DeploySyncResp.Deploy 兜底", tostring(change.BaseVersion), tostring(self.nDeployVersion), tostring(change.NextVersion)))
      else
        local tbTransforms = change.Transforms or {}
        local bBatchWipeContext = self:_CheckBatchWipeContext(param, tbTransforms)
        local tbBatchConsume = bBatchWipeContext and {} or nil
        for _, mapTrans in ipairs(tbTransforms) do
          if PRINT_CHESS_LOG then
            if mapTrans.Consume ~= nil and 0 < #mapTrans.Consume then
              for _, consume in ipairs(mapTrans.Consume) do
                local sName = ""
                local mapCfg = ConfigTable.GetData("SoldierCharacter", consume.Tid)
                if mapCfg ~= nil then
                  sName = mapCfg.Name
                end
                self:PrintSoldier(string.format("<color='#CF584E'>[[Soldier]失去棋子 UID=%s %s-%s星[%s]</color>", consume.UID, consume.Tid, consume.Star, sName))
              end
            end
            if mapTrans.Obtain ~= nil and 0 < #mapTrans.Obtain then
              for _, obtain in ipairs(mapTrans.Obtain) do
                local sName = ""
                local mapCfg = ConfigTable.GetData("SoldierCharacter", obtain.Tid)
                if mapCfg ~= nil then
                  sName = mapCfg.Name
                end
                self:PrintSoldier(string.format("<color='#4DC382'>[[Soldier]获得棋子 UID=%s %s-%s星[%s] Slot=%s</color>", obtain.UID, obtain.Tid, obtain.Star, sName, obtain.Slot or 0))
              end
            end
            if mapTrans.Update ~= nil and 0 < #mapTrans.Update then
              for _, upd in ipairs(mapTrans.Update) do
                self:PrintSoldier(string.format("[Soldier]移动棋子 UID=%s -> Slot=%s", upd.UID, upd.Slot or 0))
              end
            end
          end
          local steps = self:DisposalChessDeploy(mapTrans, param)
          if steps ~= nil then
            if tbBatchConsume ~= nil then
              for _, s in ipairs(steps) do
                if s.tbConsume ~= nil then
                  for _, c in ipairs(s.tbConsume) do
                    table.insert(tbBatchConsume, c)
                  end
                end
              end
            else
              for _, s in ipairs(steps) do
                table.insert(tbSteps, s)
              end
            end
          end
        end
        self.nDeployVersion = change.NextVersion or self.nDeployVersion
        self.tbDeployChess = self:_DeriveDeployView()
        self.tbWaitingChess = self:_DeriveWaitingView()
        self.tbOtherChess = self:_DeriveOtherView()
        self.mapAllChess = self:_DeriveAllChessView()
        self:UpdatePartner()
        if tbBatchConsume ~= nil and 0 < #tbBatchConsume then
          self:_NetOutPendingRewards(tbBatchConsume)
          local atomicStep = {
            tbConsume = tbBatchConsume,
            tbObtain = {},
            tbUpdate = {},
            sSpecial = "CardWipeAll"
          }
          local wipeSteps = {atomicStep}
          for _, s in ipairs(tbSteps) do
            table.insert(wipeSteps, s)
          end
          local wipeEntry = {
            nType = AllEnum.SoldierRewardSource.CardWipe,
            data = {},
            tbSteps = wipeSteps
          }
          table.insert(self.tbPendingRewards, wipeEntry)
        elseif tbChange ~= nil and 0 < #tbSteps then
          tbChange.tbChessChangeStep = tbSteps
        end
      end
    end
  end
  if mapDecodeInfo["proto.SoldierBuff"] ~= nil then
    for _, mapBuff in ipairs(mapDecodeInfo["proto.SoldierBuff"]) do
      self:UpdateBuff(mapBuff)
    end
  end
  EventManager.Hit("RefreshSoldierRes")
end

function SoldierLevelData:UpdateSoldierEffectNotify(mapMsgData)
  if mapMsgData == nil or mapMsgData.Effects == nil then
    return
  end
  self:UpdateEffect(mapMsgData.Effects)
  EventManager.Hit("SoldierEffectChange")
end

function SoldierLevelData:UpdateShopDataNotify(mapShopData)
  if mapShopData == nil then
    return
  end
  self:_UpdateShopCaseData(mapShopData)
  EventManager.Hit("SoldierShopLevelChange")
end

function SoldierLevelData:UpdateEffect(mapEffect, tbChange)
  if mapEffect == nil or #mapEffect == 0 then
    return
  end
  for _, v in ipairs(mapEffect) do
    local nBuffUid = v.BuffId or 0
    if v.Id ~= nil and v.Id ~= 0 and nBuffUid ~= 0 and self.mapBuffs[nBuffUid] ~= nil then
      self.mapEffects[v.Id] = {
        nBuffUid = nBuffUid,
        nTid = v.Tid
      }
    end
    self:EffectLeftmostChange(v.LeftmostChange, tbChange)
    self:EffectBecomeAnother(v.BecomeAnother, tbChange)
    self:EffectPartnerAdditional(v.PartnerAdditional)
    self:EffectPartnerActivateAdditional(v.PartnerActivateAdditional)
    self:EffectNodeTypeModify(v.NodeTypeModify)
    self:EffectClientAttr(v.ClientAttr)
    self:EffectShopRefreshState(v.RefreshState)
    self:EffectShopPurchaseState(v.PurchaseState)
    self:EffectShopFreeState(v.FreeState)
    self:EffectShopRarity(v.Rarity)
    self:EffectShopPurchaseExpDiscount(v.PurchaseExpDiscount)
    self:EffectShowChess(v.ShowChess)
    self:EffectClientHarvest(v.ClientHarvest)
    self:EffectInterest(v.Interest)
    self:EffectCardReRoll(v.CardReRoll)
    self:EffectDiceAddPoint(v.DiceAddPoint)
  end
end

function SoldierLevelData:InteractShop(shopMsg)
  if shopMsg == nil then
    return
  end
  if shopMsg.Goods ~= nil then
  elseif shopMsg.ShopData ~= nil then
    self:_UpdateShopCaseData(shopMsg.ShopData)
    EventManager.Hit("SoldierShopLevelChange")
  elseif shopMsg.Upgrade ~= nil then
    self.nLevel = shopMsg.Upgrade.Level
    self.nExp = shopMsg.Upgrade.Exp
    if self.mapCases[CaseEnum.Shop] ~= nil and self.mapCases[CaseEnum.Shop].mapShop ~= nil then
      self.mapCases[CaseEnum.Shop].mapShop.tbWeightList = self:GetShopWeight(shopMsg.Upgrade.RarityUp)
    end
    EventManager.Hit("SoldierShopLevelChange")
  elseif shopMsg.Res ~= nil then
    EventManager.Hit("SoldierShopSell", shopMsg.Res)
  elseif shopMsg.Succeed ~= nil then
    local bLock = shopMsg.Succeed
    if self.mapCases[CaseEnum.Shop] ~= nil and self.mapCases[CaseEnum.Shop].mapShop ~= nil then
      self.mapCases[CaseEnum.Shop].mapShop.bLock = shopMsg.Succeed
    end
    EventManager.Hit("SoldierShopLock", bLock)
  end
end

function SoldierLevelData:InteractBattle(battleMsg, param, tbChange)
  if battleMsg == nil then
    return
  end
  local nAllCoinChange = 0
  local tbItemChange = tbChange.itemChange
  if tbItemChange ~= nil then
    nAllCoinChange = tbItemChange[AllEnum.CoinItemId.SoldierCurrency]
  end
  local tbCoinReward = {
    base = battleMsg.BaseReward,
    interest = battleMsg.Interest,
    winningStreak = battleMsg.WinningStreak,
    losingStreak = battleMsg.LosingStreak,
    other = nAllCoinChange - battleMsg.BaseReward - battleMsg.Interest - battleMsg.WinningStreak - battleMsg.LosingStreak
  }
  if type(param) == "table" then
    local nType = param.nResultType
    local tbDamage = param.tbDamage
    self.mapClientCases[ClientCase.BattleResult] = {}
    self.mapClientCases[ClientCase.BattleResult].nType = nType
    self.mapClientCases[ClientCase.BattleResult].tbDamage = tbDamage
    self.mapClientCases[ClientCase.BattleResult].tbChange = tbChange
    self.mapClientCases[ClientCase.BattleResult].tbCoinReward = tbCoinReward
    self.mapClientCases[ClientCase.BattleResult].bEventBattle = false
  end
end

function SoldierLevelData:InteractEventSettlementOfDisputeBattle(battleMsg, param, tbChange)
  if battleMsg == nil then
    return
  end
  local nAllCoinChange = 0
  local tbItemChange = tbChange.itemChange
  if tbItemChange ~= nil then
    nAllCoinChange = tbItemChange[AllEnum.CoinItemId.SoldierCurrency]
  end
  local tbCoinReward = {
    base = battleMsg.BaseReward,
    interest = battleMsg.Interest,
    winningStreak = 0,
    losingStreak = 0,
    other = nAllCoinChange - battleMsg.BaseReward - battleMsg.Interest
  }
  if type(param) == "table" then
    local nType = param.nResultType
    local tbDamage = param.tbDamage
    self.mapClientCases[ClientCase.BattleResult] = {}
    self.mapClientCases[ClientCase.BattleResult].nType = nType
    self.mapClientCases[ClientCase.BattleResult].tbDamage = tbDamage
    self.mapClientCases[ClientCase.BattleResult].tbChange = tbChange
    self.mapClientCases[ClientCase.BattleResult].tbCoinReward = tbCoinReward
    self.mapClientCases[ClientCase.BattleResult].bEventBattle = true
  end
  self:CacheReward(AllEnum.SoldierRewardSource.EventBattle, {
    tbChess = battleMsg.Chess,
    nCoin = battleMsg.Coin
  })
end

function SoldierLevelData:InteractCheckStageSettle(settleMsg)
  if settleMsg == nil then
    return
  end
  self:CacheReward(AllEnum.SoldierRewardSource.Battle, {
    nCheckStageDps = settleMsg.DpsScore,
    nCheckStageTime = settleMsg.TimeScore
  })
end

function SoldierLevelData:InteractSelect(selectMsg)
  if selectMsg == nil then
    return
  end
  if selectMsg.Resp ~= nil then
  elseif selectMsg.SelectCard ~= nil and self.mapCases[CaseEnum.SelectCard] ~= nil then
    self.mapCases[CaseEnum.SelectCard].tbCards = selectMsg.SelectCard.Ids
    self.mapCases[CaseEnum.SelectCard].nRoll = selectMsg.SelectCard.ReRoll
  end
end

function SoldierLevelData:_ParseStoryEventRewards(tbRewards)
  if tbRewards == nil or #tbRewards == 0 then
    return nil
  end
  local RT = AllEnum.SoldierEventEffectRewardType
  local data = {}
  for _, r in ipairs(tbRewards) do
    local eType = r.RewardType
    if eType == RT.Chess then
      if r.ChessList ~= nil and r.ChessList.ChessList ~= nil then
        data.tbChess = data.tbChess or {}
        for _, ch in ipairs(r.ChessList.ChessList) do
          table.insert(data.tbChess, ch)
        end
      end
    elseif (eType == RT.GainCoin or eType == RT.LossCoin) and r.Res ~= nil and r.Res.ResRewards ~= nil then
      for _, res in ipairs(r.Res.ResRewards) do
        if res.Tid == AllEnum.CoinItemId.SoldierCurrency then
          data.nCoin = (data.nCoin or 0) + (res.Qty or 0)
        end
      end
    end
  end
  if next(data) == nil then
    return nil
  end
  return data
end

function SoldierLevelData:InteractStoryEventOfPersonalitySelect(respMsg)
  if respMsg == nil then
    return
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierEventPanel)
  if respMsg.Success ~= nil then
    return
  end
  if respMsg.Reward == nil then
    return
  end
  local data = self:_ParseStoryEventRewards(respMsg.Reward.Rewards)
  if data ~= nil then
    self:CacheReward(AllEnum.SoldierRewardSource.EventBattle, data)
  end
  if respMsg.Reward.Point > 0 then
    self.mapClientCases[ClientCase.DiceResult] = {
      bSuccess = respMsg.Reward.Result,
      nPoint = respMsg.Reward.Point,
      tbTwoDicePoint = respMsg.Reward.TwoDicePoint
    }
  end
end

function SoldierLevelData:InteractStoryEventOfCostlySelect(respMsg)
  if respMsg == nil then
    return
  end
  local data = self:_ParseStoryEventRewards(respMsg.Rewards)
  if data ~= nil then
    self:CacheReward(AllEnum.SoldierRewardSource.EventBattle, data)
  end
  local bHaveNext = false
  for _, v in ipairs(respMsg.Rewards) do
    if v.RewardType == AllEnum.SoldierEventEffectRewardType.Next then
      bHaveNext = true
      break
    end
  end
  if not bHaveNext then
    EventManager.Hit(EventId.ClosePanel, PanelId.SoldierEventPanel)
  end
end

function SoldierLevelData:InteractSettle(settleMsg)
  if settleMsg == nil then
    return
  end
  local nType = AllEnum.SoldierResultType.ChallengeFail
  if settleMsg.Result == 1 then
    nType = AllEnum.SoldierResultType.ChallengeSuccess
  end
  if settleMsg.EndingId ~= nil and settleMsg.EndingId ~= 0 then
    self.mapClientCases[ClientCase.Ending] = {
      data = settleMsg.EndingId
    }
  end
  self.mapClientCases[ClientCase.Settle] = {
    nType = nType,
    tbSettle = {
      nPassedNode = settleMsg.PassedNode,
      nRemainingHp = settleMsg.RemainingHp,
      nCheckStageDps = settleMsg.CheckStageDps,
      nCheckStageTime = settleMsg.CheckStageTime,
      nChessTotalCost = settleMsg.ChessTotalCost,
      nGetSchedule = settleMsg.GetSchedule,
      nGetTechPoint = settleMsg.GetTechPoint,
      nGetGradeExp = settleMsg.GetGradeExp,
      nCurGradeChallengeId = settleMsg.CurGradeChallengeId,
      nCurGradeExp = settleMsg.CurGradeExp,
      nEndingId = settleMsg.EndingId,
      nTotalCoinQty = settleMsg.TotalCoinQty
    },
    tbChess = self.tbDeployChess or {},
    tbDamage = self.tbLastBattleDamage or {},
    nBossTemplateId = self.nBossTemplateId or 0,
    nHp = self:GetHp() or 0,
    nCoin = self:GetItem(AllEnum.CoinItemId.SoldierCurrency) or 0,
    tbCard = self:GetCardData() or {},
    nGradeChallengeId = self.nGradeChallengeId or 0
  }
  if settleMsg.Change ~= nil then
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(settleMsg.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  end
  self.parent:RefreshRedDot()
end

function SoldierLevelData:InteractDeploySync(deploySyncResp)
  if deploySyncResp == nil then
    return
  end
  if deploySyncResp.Deploy ~= nil then
    self:_RebuildFromNewDeploy(deploySyncResp.Deploy)
    self.tbDeployChess = self:_DeriveDeployView()
    self.tbWaitingChess = self:_DeriveWaitingView()
    self.tbOtherChess = self:_DeriveOtherView()
    self.mapAllChess = self:_DeriveAllChessView()
    self:UpdatePartner()
    EventManager.Hit("SoldierDeployFullRebuild")
  end
end

function SoldierLevelData:_OnInteract(netMsgData, param, callback)
  if netMsgData == nil then
    return
  end
  self._tbTouchedRewardIdxes = {}
  self._tbPendingNewPartner = nil
  self._bPartnerSetChanged = nil
  local tbChange = {}
  self:UpdateNodeInfo(netMsgData.Node, tbChange)
  self:UpdateBaseInfo(netMsgData.SyncData, tbChange)
  self:UpdateChangeInfo(netMsgData.Change, tbChange, param)
  self:UpdateEffect(netMsgData.Effects, tbChange)
  self:UpdateBuffProgress(netMsgData.Progress)
  self:InteractShop(netMsgData.ShopResp)
  self:InteractBattle(netMsgData.BattleResp, param, tbChange)
  self:InteractEventSettlementOfDisputeBattle(netMsgData.EventSettlementOfDisputeBattleResp, param, tbChange)
  self:InteractSelect(netMsgData.SelectResp)
  self:InteractStoryEventOfPersonalitySelect(netMsgData.StoryEventOfPersonalitySelectResp)
  self:InteractStoryEventOfCostlySelect(netMsgData.StoryEventOfCostlySelectResp)
  self:InteractCheckStageSettle(netMsgData.CheckStageSettleResp)
  self:InteractSettle(netMsgData.Settle)
  self:InteractDeploySync(netMsgData.DeploySyncResp)
  self:ClearServerCase()
  for _, v in ipairs(netMsgData.Cases) do
    self:DispatchServerCase(v)
  end
  if #self._tbTouchedRewardIdxes > 0 and tbChange.tbChessChangeStep ~= nil and 0 < #tbChange.tbChessChangeStep then
    local nIdx = self._tbTouchedRewardIdxes[1]
    self.tbPendingRewards[nIdx].tbSteps = self.tbPendingRewards[nIdx].tbSteps or {}
    for _, s in ipairs(tbChange.tbChessChangeStep) do
      table.insert(self.tbPendingRewards[nIdx].tbSteps, s)
    end
  end
  self._tbTouchedRewardIdxes = nil
  if tbChange.tbNodeChange ~= nil and tbChange.tbNodeChange.bNodeChange then
    EventManager.Hit("SoldierNodeChange")
  end
  EventManager.Hit(EventId.BlockInput, true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit(EventId.BlockInput, false)
    self:HandleCase()
    if callback ~= nil then
      callback(tbChange)
    end
  end
  
  cs_coroutine.start(wait)
end

function SoldierLevelData:GetBossTemplateId()
  return self.nBossTemplateId
end

function SoldierLevelData:GetNodeId()
  return self.nNodeId
end

function SoldierLevelData:GetNodeList()
  return self.tbNodeList
end

function SoldierLevelData:GetNodeIndex()
  for _, v in ipairs(self.tbNodeList) do
    if v.nNodeId == self.nNodeId then
      return v.nIndex
    end
  end
  return 0
end

function SoldierLevelData:IsFirstStageFirstNode()
  if self.nStageId ~= 1 then
    return false
  end
  if self.tbNodeList == nil or self.tbNodeList[1] == nil then
    return false
  end
  return self.tbNodeList[1].nNodeId == self.nNodeId
end

function SoldierLevelData:GetHp()
  return self.nHp
end

function SoldierLevelData:GetShopLevel()
  return self.nLevel, self.nMaxLevel
end

function SoldierLevelData:GetExp()
  return self.nExp
end

function SoldierLevelData:GetStreakCount()
  return self.nWiningStreak, self.nLosingStreak
end

function SoldierLevelData:GetItem(nItemId)
  return self.mapItems[nItemId] or 0
end

function SoldierLevelData:GetDeploy()
  return self.tbDeployChess, self.tbWaitingChess, self.tbOtherChess
end

function SoldierLevelData:GetAllChess()
  return self.mapAllChess
end

function SoldierLevelData:PosIndexToSlot(nPosType, nIndex)
  return PosIndexToSlot(nPosType, nIndex)
end

function SoldierLevelData:GetShopData()
  local mapShopCase = self.mapCases[CaseEnum.Shop]
  if mapShopCase ~= nil then
    return mapShopCase.mapShop
  end
end

function SoldierLevelData:GetEventBattleData()
  return self:_GetCaseDataByType(CaseEnum.EventSettlementOfDispute)
end

function SoldierLevelData:CheckInSelectCard()
  return self.mapCases[CaseEnum.SelectCard] ~= nil
end

function SoldierLevelData:GetSelectCardData()
  local mapCase = self:_GetCaseDataByType(CaseEnum.SelectCard)
  if mapCase ~= nil then
    return mapCase.tbCards, mapCase.nRoll
  end
end

function SoldierLevelData:GetCardData()
  if self.tbStrategyCards == nil then
    local tb = {}
    for k, buffInfo in pairs(self.mapBuffs) do
      if buffInfo.nType == SoldierBuffType.CardBuff and tb[buffInfo.nBindId] == nil then
        tb[buffInfo.nBindId] = k
      end
    end
    self.tbStrategyCards = {}
    for nId, nIndex in pairs(tb) do
      table.insert(self.tbStrategyCards, {nId = nId, nIndex = nIndex})
    end
    table.sort(self.tbStrategyCards, function(a, b)
      return a.nIndex < b.nIndex
    end)
  end
  return self.tbStrategyCards
end

function SoldierLevelData:CheckSandTableDisable()
  local bDisable = false
  if self.mapCases[CaseEnum.SelectCard] ~= nil then
    bDisable = true
  elseif self.mapCases[CaseEnum.EventSettlementOfDispute] ~= nil then
    bDisable = true
  elseif self.mapCases[CaseEnum.StoryEventOfPersonality] ~= nil then
    bDisable = true
  elseif self.mapCases[CaseEnum.StoryEventOfCostly] ~= nil then
    bDisable = true
  end
  return bDisable
end

function SoldierLevelData:CheckSoldierCombine(nId, nStar)
  local COMBINE_NEED = 3
  local nMaxStar = 0
  local cfgChess = ConfigTable.GetData("SoldierCharacter", nId)
  if cfgChess ~= nil and cfgChess.MaxStar ~= nil and 0 < cfgChess.MaxStar then
    nMaxStar = cfgChess.MaxStar
  end
  
  local function _getCount(nQueryStar)
    local n = 0
    for _, v in ipairs(self.mapAllChess) do
      if v.nId == nId and v.nStar == nQueryStar then
        n = n + (v.nCount or 0)
      end
    end
    return n
  end
  
  local mapSimCount = {}
  
  local function _simGet(s)
    if mapSimCount[s] == nil then
      mapSimCount[s] = _getCount(s)
    end
    return mapSimCount[s]
  end
  
  mapSimCount[nStar] = _simGet(nStar) + 1
  local nNextStar = nStar
  local bCombine = false
  while nMaxStar > nNextStar and COMBINE_NEED <= _simGet(nNextStar) do
    mapSimCount[nNextStar] = mapSimCount[nNextStar] - COMBINE_NEED
    nNextStar = nNextStar + 1
    mapSimCount[nNextStar] = _simGet(nNextStar) + 1
    bCombine = true
  end
  if not bCombine then
    nNextStar = 0
  end
  return bCombine, nNextStar
end

function SoldierLevelData:SetPartnerTrace(nPartnerType, bTrace, callback)
  self:SendPartnerTrace(nPartnerType, bTrace, callback)
end

function SoldierLevelData:CheckPartnerTrace(nPartnerType)
  return table.indexof(self.tbPartnerTrace, nPartnerType) > 0
end

function SoldierLevelData:CheckChessTrace(nId)
  local bTrace = false
  local mapCharCfg = ConfigTable.GetData("SoldierCharacter", nId)
  if mapCharCfg ~= nil then
    local tbPartner = mapCharCfg.PartnerType
    for _, v in ipairs(tbPartner) do
      if table.indexof(self.tbPartnerTrace, v) > 0 then
        bTrace = true
        break
      end
    end
  end
  return bTrace
end

function SoldierLevelData:GetServerPartner()
  return self.tbServerPartner
end

function SoldierLevelData:CheckInBattle()
  return self.curBattle ~= nil
end

function SoldierLevelData:GetClientBuffList()
  local tbBuffList = {}
  for nEffectId, v in pairs(self.tbClientEffects) do
    local buffList = v.tbValues
    if buffList ~= nil then
      for _, buffId in ipairs(buffList) do
        table.insert(tbBuffList, tonumber(buffId))
      end
    end
  end
  return tbBuffList
end

function SoldierLevelData:GetCheckStage()
  local mapCase = self:_GetCaseDataByType(CaseEnum.CheckStage)
  if mapCase ~= nil then
    return true
  end
  return false
end

function SoldierLevelData:GetClientHarvestCount()
  if self.mapExtraEffectState ~= nil then
    return self.mapExtraEffectState.nHarvest or 0
  end
end

function SoldierLevelData:GetStoryEventData()
  local mapCaseData = self.mapCases[CaseEnum.StoryEventOfPersonality]
  if mapCaseData ~= nil then
    return mapCaseData
  end
  mapCaseData = self.mapCases[CaseEnum.StoryEventOfCostly]
  if mapCaseData ~= nil then
    return mapCaseData
  end
end

function SoldierLevelData:CheckInSandtable()
  return self.mapCases[CaseEnum.Fight] ~= nil
end

function SoldierLevelData:GetDiceAddPointList()
  local tbDiscAdd = {}
  for nEUId, v in pairs(self.tbDiscAddEffect) do
    local buff = self.mapBuffs[v.nBuffUId]
    if buff ~= nil then
      local nType = 0
      if buff.nType == SoldierBuffType.CardBuff then
        nType = AllEnum.SoldierDiscAddType.BuffCard
      elseif buff.nType == SoldierBuffType.TechNodeBuff then
        nType = AllEnum.SoldierDiscAddType.TechNode
      end
      table.insert(tbDiscAdd, {
        nType = nType,
        nId = buff.nBindId,
        nPoint = v.nPoint
      })
    end
  end
  return tbDiscAdd
end

function SoldierLevelData:GetInterestLimit()
  if self.mapExtraEffectState ~= nil then
    return self.mapExtraEffectState.nInterestLimit
  end
  return 0
end

function SoldierLevelData:GMEnterBattle(tbDeployChess)
  if self.curBattle == nil then
    self.curBattle = require("Game.Adventure.Soldier.SoldierBattle").new()
  end
  self.curBattle:Init(self, tbDeployChess, 1, 1, 1, 1, 101)
end

return SoldierLevelData
