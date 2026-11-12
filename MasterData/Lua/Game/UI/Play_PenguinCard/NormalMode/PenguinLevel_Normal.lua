local PenguinLevel = require("Game.UI.Play_PenguinCard.PenguinLevel")
local PenguinLevel_Normal = class("PenguinLevel_Normal", PenguinLevel)
local PenguinCardQuest = require("Game.UI.Play_PenguinCard.NormalMode.PenguinCardQuest")
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")
local mapEventConfig = {
  PenguinCard_ChangeScore = "OnEvent_ChangeScore"
}

function PenguinLevel_Normal:Init(nFloorId, nLevelId, nActId, tbStarScore)
  self:ParseServerData(nFloorId, nLevelId, nActId, tbStarScore)
  self:ParseConfigData()
  self:ParseLocalData()
  self:BindEvent()
  EventManager.Hit(EventId.OpenPanel, PanelId.PenguinCard, self)
end

function PenguinLevel_Normal:Exit()
  self:UnBindEvent()
end

function PenguinLevel_Normal:ParseModeConfigData()
  self.nMaxRound = ConfigTable.GetConfigNumber("PenguinCardMaxRound")
  self.nMaxSlot = ConfigTable.GetConfigNumber("PenguinCardMaxSlot")
  self.nMaxBuyLimit = ConfigTable.GetConfigNumber("PenguinCardMaxBuyLimit")
  self.nMaxCheckRound = ConfigTable.GetConfigNumber("PenguinCardMaxCheckRound")
  self.tbRoundUpgradeCost = ConfigTable.GetConfigNumberArray("PenguinCardRoundUpgradeCost")
  self.tbSlotUpgradeCost = ConfigTable.GetConfigNumberArray("PenguinCardSlotUpgradeCost")
  self.tbBuyLimitUpgradeCost = ConfigTable.GetConfigNumberArray("PenguinCardBuyLimitUpgradeCost")
  self.tbCheckRoundUpgradeCost = ConfigTable.GetConfigNumberArray("PenguinCardCheckRoundUpgradeCost")
end

function PenguinLevel_Normal:ParseModeLevelData(mapLevelCfg)
  self.nFixedTurnGroupId = mapLevelCfg.FixedTurn
  self.bShowWin = mapLevelCfg.ShowWin
  self.nQuestTurn = mapLevelCfg.QuestTurn
  self.nQuestGroup = mapLevelCfg.QuestGroup
end

function PenguinLevel_Normal:ClearModeLevelData()
  self.bPreTurnWin = false
  if self.tbQuestPool == nil then
    self.tbQuestPool = {}
  end
  self.mapQuest = nil
end

function PenguinLevel_Normal:SaveLevelData()
  local mapLevelData = {}
  mapLevelData.nHp = self.nHp
  local tbPenguinCardSnap = {}
  local tbPenguinCard = self.tbPenguinCard or {}
  for i = 1, 6 do
    local v = tbPenguinCard[i]
    if v == 0 or v == nil then
      tbPenguinCardSnap[i] = 0
    else
      tbPenguinCardSnap[i] = v:Serialize()
    end
  end
  mapLevelData.tbPenguinCard = tbPenguinCardSnap
  return mapLevelData
end

function PenguinLevel_Normal:CheckNextGameState()
  if self.nGameState == nil then
    return PenguinCardUtils.GameState.Start
  elseif self.nGameState == PenguinCardUtils.GameState.Start then
    if self.nQuestTurn >= 0 and self.nCurTurn >= self.nQuestTurn then
      return PenguinCardUtils.GameState.Quest
    else
      return PenguinCardUtils.GameState.Prepare
    end
  elseif self.nGameState == PenguinCardUtils.GameState.Prepare then
    return PenguinCardUtils.GameState.Dealing
  elseif self.nGameState == PenguinCardUtils.GameState.Dealing then
    return PenguinCardUtils.GameState.Flip
  elseif self.nGameState == PenguinCardUtils.GameState.Flip then
    return PenguinCardUtils.GameState.Settlement
  elseif self.nGameState == PenguinCardUtils.GameState.Settlement then
    if self.nCurRound < self:GetRoundLimitInTurn() then
      return PenguinCardUtils.GameState.Dealing
    end
    if self.nCurTurn >= self.nMaxTurn then
      return PenguinCardUtils.GameState.Complete
    end
    if self.mapQuest ~= nil then
      return PenguinCardUtils.GameState.Quest
    elseif self.nQuestTurn >= 0 and self.nCurTurn >= self.nQuestTurn then
      return PenguinCardUtils.GameState.Quest
    else
      return PenguinCardUtils.GameState.Prepare
    end
  elseif self.nGameState == PenguinCardUtils.GameState.Quest then
    if self.nCurTurn >= self.nMaxTurn or 0 >= self.nHp then
      return PenguinCardUtils.GameState.Complete
    else
      return PenguinCardUtils.GameState.Prepare
    end
  end
end

function PenguinLevel_Normal:RunState_Start()
  EventManager.Hit("PenguinCard_RunState_Start")
end

function PenguinLevel_Normal:QuitState_Start(nNextState)
  EventManager.Hit("PenguinCard_QuitState_Start", nNextState)
  local nWaitTime = 0.167
  return nWaitTime
end

function PenguinLevel_Normal:RunState_Quest()
  self.tbSelectableQuest = {}
  self.bSkipQuestShow = false
  self.mapQuestForShow = nil
  if self.mapQuest ~= nil then
    self.mapQuestForShow = clone(self.mapQuest)
    local bComplete = self.mapQuest:CheckComplete()
    if bComplete then
      self:CompleteQuest()
      self:RollQuest()
    else
      local bExpired = self.mapQuest:CheckExpired()
      if bExpired then
        self:ChangeHp(-1)
        if self.nHp > 0 then
          self:RollQuest()
        end
      else
        self.bSkipQuestShow = true
      end
    end
  else
    self:RollQuest()
    if next(self.tbSelectableQuest) == nil then
      self.bSkipQuestShow = true
    end
  end
  EventManager.Hit("PenguinCard_RunState_Quest", self.bSkipQuestShow)
  if self.bSkipQuestShow then
    self:SwitchGameState()
  end
end

function PenguinLevel_Normal:QuitState_Quest(nNextState)
  self.tbSelectableQuest = {}
  self.bSkipQuestShow = false
  self.mapQuestForShow = nil
  EventManager.Hit("PenguinCard_QuitState_Quest", nNextState)
  local nWaitTime = 0
  if nNextState == PenguinCardUtils.GameState.Start then
    nWaitTime = 0.6
  elseif nNextState == PenguinCardUtils.GameState.Prepare then
    nWaitTime = 0.57
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    nWaitTime = 0.6
  end
  return nWaitTime
end

function PenguinLevel_Normal:RollQuest()
  local tbId = self:GetRollQuestResult()
  self:ClearSelectableQuest()
  for _, nId in ipairs(tbId) do
    local mapCard = self:CreateQuest(nId)
    table.insert(self.tbSelectableQuest, mapCard)
  end
  self.mapQuest = nil
end

function PenguinLevel_Normal:GetRollQuestResult()
  local mapWeightCfg = ConfigTable.GetData("PenguinCardQuestWeight", self.nQuestGroup * 100 + self.nCurTurn)
  if not mapWeightCfg then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_Error_EmptyQuest")
    })
    return {}
  end
  local tbId = PenguinCardUtils.WeightedRandom(mapWeightCfg.QuestList, mapWeightCfg.Weight, 3)
  return tbId
end

function PenguinLevel_Normal:ClearSelectableQuest()
  if next(self.tbSelectableQuest) ~= nil then
    for i = #self.tbSelectableQuest, 1, -1 do
      local mapCard = table.remove(self.tbSelectableQuest, i)
      self:RecycleQuest(mapCard)
    end
  end
end

function PenguinLevel_Normal:SelectQuest(nIndex)
  self.mapQuest = nil
  self.mapQuest = self.tbSelectableQuest[nIndex]
  table.remove(self.tbSelectableQuest, nIndex)
  self:ClearSelectableQuest()
  EventManager.Hit("PenguinCard_SelectQuest")
  if NovaAPI.IsEditorPlatform() then
    printLog("领取任务：" .. "  " .. self.mapQuest.nId)
  end
end

function PenguinLevel_Normal:CompleteQuest()
  local mapData = self:CreateBuff(self.mapQuest.nBuffId)
  mapData:ResetAllTrigger()
  self:AddBuff(mapData, true)
end

function PenguinLevel_Normal:RecycleQuest(mapQuest)
  mapQuest:Clear()
  table.insert(self.tbQuestPool, mapQuest)
end

function PenguinLevel_Normal:CreateQuest(nId)
  local mapQuest
  if next(self.tbQuestPool) == nil then
    mapQuest = PenguinCardQuest.new(nId)
  else
    mapQuest = table.remove(self.tbQuestPool, 1)
    mapQuest:Init(nId)
  end
  return mapQuest
end

function PenguinLevel_Normal:RunState_Prepare()
  self.nCurTurn = self.nCurTurn + 1
  self.nCurRound = 0
  self:ClearStateData_Prepare()
  self:ClearTurnData()
  for _, v in ipairs(self.tbBuff) do
    v:ResetTurnTrigger()
  end
  for _, v in ipairs(self.tbPenguinCard) do
    if v ~= 0 then
      v:ResetTurnTrigger()
    end
  end
  self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.Prepare)
  self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.BeforeUpgrade)
  self:FreeRollPenguinCard()
  EventManager.Hit("PenguinCard_RunState_Prepare")
end

function PenguinLevel_Normal:QuitState_Prepare(nNextState)
  self:ClearSelectablePenguinCard()
  self:ClearStateData_Prepare()
  self.bPreTurnWin = false
  EventManager.Hit("PenguinCard_QuitState_Prepare", nNextState)
  local nWaitTime = 0
  if nNextState == PenguinCardUtils.GameState.Start then
    nWaitTime = 0.6
  elseif nNextState == PenguinCardUtils.GameState.Dealing then
    nWaitTime = 0.45
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    nWaitTime = 0.6
  end
  return nWaitTime
end

function PenguinLevel_Normal:AddRound()
  if self.nRoundLimit == self.nMaxRound then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_AddBtnMaxLevel")
    })
    return
  end
  local nCost = self.tbRoundUpgradeCost[self.nRoundLimit + 1] * self:GetUpgradeDiscount()
  if nCost > self.nScore then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_NotEnoughScoreUpgrade")
    })
    return
  end
  self.nRoundLimit = self.nRoundLimit + 1
  self:ChangeScore(-1 * nCost)
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Tips,
    sSound = "Mode_Card_buy",
    sContent = orderedFormat(ConfigTable.GetUIText("PenguinCard_AddRoundSuccess"), self.nRoundLimit)
  })
  self:AfterUpgrade(nCost)
  EventManager.Hit("PenguinCard_AddRound")
end

function PenguinLevel_Normal:AddSlot()
  if self.nSlotCount == self.nMaxSlot then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_AddBtnMaxLevel")
    })
    return
  end
  local nCost = self.tbSlotUpgradeCost[self.nSlotCount + 1] * self:GetUpgradeDiscount()
  if nCost > self.nScore then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_NotEnoughScoreUpgrade")
    })
    return
  end
  self.nSlotCount = self.nSlotCount + 1
  self:ChangeScore(-1 * nCost)
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Tips,
    sSound = "Mode_Card_buy",
    sContent = orderedFormat(ConfigTable.GetUIText("PenguinCard_AddSlotSuccess"), self.nSlotCount)
  })
  self:AfterUpgrade(nCost)
  EventManager.Hit("PenguinCard_AddSlot")
end

function PenguinLevel_Normal:AddRoll()
  if self.nBuyLimit == self.nMaxBuyLimit then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_AddBtnMaxLevel")
    })
    return
  end
  local nCost = self.tbBuyLimitUpgradeCost[self.nBuyLimit + 1] * self:GetUpgradeDiscount()
  if nCost > self.nScore then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_NotEnoughScoreUpgrade")
    })
    return
  end
  self.nBuyLimit = self.nBuyLimit + 1
  self:ChangeScore(-1 * nCost)
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Tips,
    sSound = "Mode_Card_buy",
    sContent = orderedFormat(ConfigTable.GetUIText("PenguinCard_AddRollSuccess"), self.nBuyLimit)
  })
  self:AfterUpgrade(nCost)
  EventManager.Hit("PenguinCard_AddRoll")
end

function PenguinLevel_Normal:GetPenguinCardWeightLevel()
  return self.nCurTurn
end

function PenguinLevel_Normal:RunState_Dealing()
  self:SaveSnapshot()
  self.bCheckRound = self:GetSnapshotState()
  self:AddCheckRoundBuff()
  self.nCurRound = self.nCurRound + 1
  self.nTotalRound = self.nTotalRound + 1
  self:ClearRoundData()
  self.mapCalBaseCardPool = clone(self.mapBaseCardPool)
  for _, v in ipairs(self.tbBuff) do
    v:ResetRoundTrigger()
  end
  for _, v in ipairs(self.tbPenguinCard) do
    if v ~= 0 then
      v:ResetRoundTrigger()
    end
  end
  self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.Dealing)
  self.tbBaseCardId = PenguinCardUtils.WeightedRandom(self.mapCalBaseCardPool.tbId, self.mapCalBaseCardPool.tbWeight, self.nBaseCardCount, {}, true)
  if 0 < self.nFixedTurnGroupId then
    local nFixedId = self.nFixedTurnGroupId * 10000 + self.nCurTurn * 100 + self.nCurRound
    local mapFixedCfg = ConfigTable.GetData("PenguinCardFixedTurn", nFixedId, true)
    if mapFixedCfg then
      self.tbBaseCardId = clone(mapFixedCfg.BaseCardId)
    end
  end
  self.tbShowedCard = {}
  for i = 1, self.nBaseCardCount do
    self.tbShowedCard[i] = false
  end
  EventManager.Hit("PenguinCard_RunState_Dealing")
  self:SwitchGameState()
end

function PenguinLevel_Normal:QuitState_Dealing(nNextState)
  EventManager.Hit("PenguinCard_QuitState_Dealing", nNextState)
  local nWaitTime = 0
  if nNextState == PenguinCardUtils.GameState.Start then
    nWaitTime = 0.6
  elseif nNextState == PenguinCardUtils.GameState.Flip then
    nWaitTime = self.bCheckRound and 1.87 or 0.85
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    nWaitTime = 0.6
  end
  return nWaitTime
end

function PenguinLevel_Normal:AddCheckRoundBuff()
  if not self.bCheckRound then
    return
  end
  local nBuffId = ConfigTable.GetConfigNumber("PenguinCardCheckRoundBuffId")
  local mapData = self:CreateBuff(nBuffId)
  mapData:ResetAllTrigger()
  self:AddBuff(mapData)
end

function PenguinLevel_Normal:RunState_Flip()
  EventManager.Hit("PenguinCard_RunState_Flip")
  self:PlayAuto()
end

function PenguinLevel_Normal:QuitState_Flip(nNextState)
  self:StopAuto()
  EventManager.Hit("PenguinCard_QuitState_Flip", nNextState)
  local nWaitTime = 0
  if nNextState == PenguinCardUtils.GameState.Start then
    nWaitTime = 0.6
  elseif nNextState == PenguinCardUtils.GameState.Settlement then
    nWaitTime = 1
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    nWaitTime = 0.6
  end
  return nWaitTime
end

function PenguinLevel_Normal:AfterShowBaseCard(mapCfg)
  if self.mapQuest ~= nil then
    for j = 1, 3 do
      local nSuit = mapCfg["Suit" .. j]
      local nCount = mapCfg["SuitCount" .. j]
      if 0 < nSuit and 0 < nCount then
        self.mapQuest:AddProgress(GameEnum.PenguinCardQuestType.SuitCount, {nId = nSuit, nCount = nCount})
      end
    end
  end
end

function PenguinLevel_Normal:AfterCheckHandRank()
  if self.mapQuest ~= nil then
    self.mapQuest:AddProgress(GameEnum.PenguinCardQuestType.HandRank, {
      nId = self.nHandRankId,
      nCount = 1
    })
  end
end

function PenguinLevel_Normal:RunState_Settlement()
  local HandRankSuitCount = self:AddSettlementHistory()
  self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.Settlement, {
    HandRankSuitCount = HandRankSuitCount,
    SuitCount = self.mapAllSuit,
    HandRank = self.nHandRankId,
    HandRankCount = self.tbHandRankCount
  })
  self:AddLog()
  EventManager.Hit("PenguinCard_RunState_Settlement")
  self:PlayAuto()
end

function PenguinLevel_Normal:QuitState_Settlement(nNextState)
  self:StopAuto()
  if not self.bRestoreSnapshot then
    self:ChangeScore(self.nRoundScore)
    if self.mapQuest ~= nil then
      self.mapQuest:AddProgress(GameEnum.PenguinCardQuestType.Score, {
        nCount = self.nRoundScore
      })
    end
    self:EndRound()
    if self:GetRoundLimitInTurn() == self.nCurRound then
      self:EndTurn()
      if self.mapQuest ~= nil then
        self.mapQuest:AddTurnCount()
      end
    end
  end
  self.bCheckRound = false
  self:ClearRoundData()
  EventManager.Hit("PenguinCard_QuitState_Settlement", nNextState)
  local nWaitTime = 0
  if nNextState == PenguinCardUtils.GameState.Start then
    nWaitTime = 0.6
  elseif nNextState == PenguinCardUtils.GameState.Dealing then
    nWaitTime = 0.57
  elseif nNextState == PenguinCardUtils.GameState.Prepare then
    nWaitTime = 0.57
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    nWaitTime = 0.6
  end
  return nWaitTime
end

function PenguinLevel_Normal:RunState_Complete(mapParam)
  self.nStar = self:GetStar()
  EventManager.Hit("PenguinCard_RunState_Complete")
  if self.nActId then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {
      "activity_id",
      tostring(self.nActId)
    })
    table.insert(tab, {
      "battle_id",
      tostring(self.nLevelId)
    })
    table.insert(tab, {
      "round",
      tostring(self.nCurTurn)
    })
    table.insert(tab, {
      "result",
      tostring(self.nStar == 0 and 2 or 1)
    })
    local nEnd = mapParam and mapParam.bManual == true and 2 or 1
    table.insert(tab, {
      "end_type",
      tostring(nEnd)
    })
    table.insert(tab, {
      "score",
      tostring(self.nScore)
    })
    table.insert(tab, {
      "star",
      tostring(self.nStar)
    })
    local sId = ""
    for i = 1, 6 do
      if self.tbPenguinCard[i] ~= 0 then
        if sId == "" then
          sId = sId .. self.tbPenguinCard[i].nId
        else
          sId = sId .. "," .. self.tbPenguinCard[i].nId
        end
      end
    end
    table.insert(tab, {"card_list", sId})
    table.insert(tab, {
      "skill_1",
      tostring(self.nRoundLimit)
    })
    table.insert(tab, {
      "skill_2",
      tostring(self.nSlotCount)
    })
    table.insert(tab, {
      "skill_3",
      tostring(self.nBuyLimit)
    })
    NovaAPI.UserEventUpload("minigame_PenguinCard", tab)
  end
end

function PenguinLevel_Normal:QuitState_Complete()
  self.nStar = 0
  EventManager.Hit("PenguinCard_QuitState_Complete")
  return 0
end

function PenguinLevel_Normal:OnEvent_ChangeScore(nBefore)
  local nBeforeStar, nStar = 0, 0
  for i, v in ipairs(self.tbStarScore) do
    if v <= nBefore then
      nBeforeStar = i
    end
    if v <= self.nScore then
      nStar = i
    end
  end
  if nBeforeStar == 0 and nStar == 1 and self.nGameState == PenguinCardUtils.GameState.Settlement then
    self.bPreTurnWin = true
  end
  EventManager.Hit("PenguinCard_ChangeStar", nBeforeStar, nStar)
end

function PenguinLevel_Normal:BindEvent()
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

function PenguinLevel_Normal:UnBindEvent()
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

function PenguinLevel_Normal:SaveModeSnapshot(mapSnapshot)
  mapSnapshot.bPreTurnWin = self.bPreTurnWin
  local mapQuest = self.mapQuest
  if mapQuest ~= nil then
    mapSnapshot.mapQuest = mapQuest:Serialize()
  end
end

function PenguinLevel_Normal:RestoreModeSnapshot(mapSnapshot)
  self.bPreTurnWin = mapSnapshot.bPreTurnWin
  self.mapQuest = nil
  if mapSnapshot.mapQuest ~= nil then
    local mapQuest = self:CreateQuest(mapSnapshot.mapQuest.nId)
    mapQuest:Deserialize(mapSnapshot.mapQuest)
    self.mapQuest = mapQuest
  end
end

return PenguinLevel_Normal
