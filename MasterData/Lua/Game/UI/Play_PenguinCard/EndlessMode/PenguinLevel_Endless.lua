local PenguinLevel = require("Game.UI.Play_PenguinCard.PenguinLevel")
local PenguinLevel_Endless = class("PenguinLevel_Endless", PenguinLevel)
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")
local PenguinCardAide = require("Game.UI.Play_PenguinCard.EndlessMode.PenguinCardAide")
local RapidJson = require("rapidjson")
local mapEventConfig = {
  PenguinCard_ChangeScore = "OnEvent_ChangeScore"
}

function PenguinLevel_Endless:Init(nFloorId, nLevelId, nActId, tbStarScore, sData)
  self:ParseServerData(nFloorId, nLevelId, nActId, tbStarScore)
  self:ParseConfigData()
  self:ParseLocalData()
  self:BindEvent()
  local sAll = NovaAPIHotfix.DecompressString(sData or "")
  self.mapLevelData = RapidJson.decode(sAll)
  EventManager.Hit(EventId.OpenPanel, PanelId.PenguinCardEndless, self)
end

function PenguinLevel_Endless:Exit()
  self:UnBindEvent()
end

function PenguinLevel_Endless:ParseModeConfigData()
  self.nMaxRound = ConfigTable.GetConfigNumber("PenguinCardEndlessMaxRound")
  self.nMaxAide = ConfigTable.GetConfigNumber("PenguinCardEndlessMaxAide")
  self.tbAdditionScore = ConfigTable.GetConfigNumberArray("PenguinCardEndlessInitialAdditionScore")
  self.tbRoundUpgradeCost = ConfigTable.GetConfigNumberArray("PenguinCardEndlessRoundUpgradeCost")
  self.tbAideUpgradeCost = ConfigTable.GetConfigNumberArray("PenguinCardEndlessAideUpgradeCost")
  self.tbScoreUpgradeCost = ConfigTable.GetConfigNumberArray("PenguinCardEndlessScoreUpgradeCost")
  self.nMaxAdditionScore = #self.tbAdditionScore
  self.nAideRollCount = ConfigTable.GetConfigNumber("PenguinCardAideRollCount")
  self.nMaxEndlessLevel = 0
  local mapLevelCfg = ConfigTable.GetData("PenguinCardFloor", self.nFloorId)
  if mapLevelCfg then
    local function func_ForEach_Level(mapData)
      if mapData.GroupId == mapLevelCfg.EndlessGroup and self.nMaxEndlessLevel < mapData.Level then
        self.nMaxEndlessLevel = mapData.Level
      end
    end
    
    ForEachTableLine(DataTable.PenguinCardEndlessLevel, func_ForEach_Level)
  end
end

function PenguinLevel_Endless:ParseModeLevelData(mapLevelCfg)
  self:RestoreLevelData(self.mapLevelData)
  local mapEndlessCfg = ConfigTable.GetData("PenguinCardEndlessLevel", mapLevelCfg.EndlessGroup * 100 + self.nEndlessLevel)
  if not mapEndlessCfg then
    return
  end
  self.sEndlessDesc = mapEndlessCfg.Desc
  self.nAimScore = mapEndlessCfg.AimScore
  self.tbEndlessLevelBuffId = mapEndlessCfg.BuffId
  self.nAidePool = mapEndlessCfg.AidePool
  self.tbInitialCard = mapEndlessCfg.InitialCard
end

function PenguinLevel_Endless:GetModeAuraFieldMap()
  return {
    [GameEnum.PenguinCardEffectType.AimScoreAura] = "nAimScoreAura",
    [GameEnum.PenguinCardEffectType.AideScoreAura] = "nAideScoreAura"
  }
end

function PenguinLevel_Endless:ClearModeLevelData()
  self.nEndlessLevel = 1
  self.nAideLimit = ConfigTable.GetConfigNumber("PenguinCardEndlessInitialAide")
  self.nAdditionScoreLevel = 0
  self.nAdditionScore = 0
  self.bNewLevel = true
  self.bRetryLimit = false
  if self.tbAidePool == nil then
    self.tbAidePool = {}
  end
  if self.tbAide == nil then
    self.tbAide = {}
    for i = 1, 3 do
      self.tbAide[i] = 0
    end
  elseif next(self.tbAide) ~= nil then
    for i = 1, 3 do
      local mapAide = self.tbAide[i]
      if mapAide ~= 0 then
        self:RecycleAide(mapAide)
        self.tbAide[i] = 0
      end
    end
  end
  self.mapAideLevel = {}
  self.mapFirstRoundSnapshot = nil
end

function PenguinLevel_Endless:SaveLevelData()
  local mapLevelData = {
    nHp = self.nHp,
    nEndlessLevel = self.nEndlessLevel,
    nAideLimit = self.nAideLimit,
    nRoundLimit = self.nRoundLimit,
    nAdditionScoreLevel = self.nAdditionScoreLevel,
    nAdditionScore = self.nAdditionScore,
    mapAideLevel = clone(self.mapAideLevel),
    nCacheScore = self.nScore,
    nCacheStar = self:GetStar()
  }
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
  local tbAideSnap = {}
  local tbAide = self.tbAide or {}
  for i = 1, 3 do
    local v = tbAide[i]
    if v == 0 or v == nil then
      tbAideSnap[i] = 0
    else
      tbAideSnap[i] = v:Serialize()
    end
  end
  mapLevelData.tbAide = tbAideSnap
  return mapLevelData
end

function PenguinLevel_Endless:RestoreLevelData(mapLevelData)
  if not mapLevelData then
    return
  end
  if mapLevelData.nHp then
    self.nHp = mapLevelData.nHp
  end
  if mapLevelData.nEndlessLevel then
    self.nEndlessLevel = mapLevelData.nEndlessLevel
  end
  if mapLevelData.nAideLimit then
    self.nAideLimit = mapLevelData.nAideLimit
  end
  if mapLevelData.nRoundLimit then
    self.nRoundLimit = mapLevelData.nRoundLimit
  end
  if mapLevelData.nAdditionScoreLevel then
    self.nAdditionScoreLevel = mapLevelData.nAdditionScoreLevel
  end
  if mapLevelData.nAdditionScore then
    self.nAdditionScore = mapLevelData.nAdditionScore
  end
  if mapLevelData.mapAideLevel then
    self.mapAideLevel = clone(mapLevelData.mapAideLevel)
  end
  if mapLevelData.tbPenguinCard then
    for i = 1, 6 do
      local v = self.tbPenguinCard[i]
      if v ~= 0 and v ~= nil then
        self:RecyclePenguinCard(v)
      end
      local mapData = mapLevelData.tbPenguinCard[i]
      if mapData == 0 then
        self.tbPenguinCard[i] = 0
      else
        local mapCard = self:CreatePenguinCard(mapData.nId)
        mapCard:Deserialize(mapData)
        self.tbPenguinCard[i] = mapCard
      end
    end
  end
  if mapLevelData.tbAide then
    for i = 1, 3 do
      local v = self.tbAide[i]
      if v ~= 0 and v ~= nil then
        self:RecycleAide(v)
      end
      local mapData = mapLevelData.tbAide[i]
      if mapData == 0 then
        self.tbAide[i] = 0
      else
        local mapAide = self:CreateAide(mapData.nId)
        mapAide:Deserialize(mapData)
        self.tbAide[i] = mapAide
      end
    end
  end
end

function PenguinLevel_Endless:EnterNextLevel()
  if self:GetAimScore() > self.nScore then
    return
  end
  if self.nEndlessLevel == self.nMaxEndlessLevel then
    local nNextState = PenguinCardUtils.GameState.Complete
    self:SwitchNextGameState(nNextState)
    return
  end
  self.nEndlessLevel = self.nEndlessLevel + 1
  self.mapLevelData = self:SaveLevelData()
  if self.nActId then
    local actData = PlayerData.Activity:GetActivityDataById(self.nActId)
    if actData then
      local bOpen = actData:CheckActivityOpen()
      if bOpen then
        local sJson = RapidJson.encode(self.mapLevelData)
        local sCompress = NovaAPIHotfix.CompressString(sJson)
        local nScore = math.floor(self.nScore)
        
        local function callback()
          self:RestartGame()
        end
        
        actData:SendActivityPenguinCardEndlessLevelSaveReq(self.nLevelId, nScore, sCompress, callback)
        return
      else
        EventManager.Hit(EventId.OpenMessageBox, {
          nType = AllEnum.MessageBox.Alert,
          sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_3")
        })
      end
    end
  end
  self:RestartGame()
end

function PenguinLevel_Endless:CheckNextGameState()
  if self.nGameState == nil then
    return PenguinCardUtils.GameState.Start
  elseif self.nGameState == PenguinCardUtils.GameState.Start then
    return PenguinCardUtils.GameState.Prepare
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
      return PenguinCardUtils.GameState.EndlessCheck
    end
    return PenguinCardUtils.GameState.Prepare
  elseif self.nGameState == PenguinCardUtils.GameState.EndlessCheck then
    return PenguinCardUtils.GameState.Complete
  end
end

function PenguinLevel_Endless:RunState_Start()
  EventManager.Hit("PenguinCard_RunState_Start")
end

function PenguinLevel_Endless:QuitState_Start(nNextState)
  EventManager.Hit("PenguinCard_QuitState_Start", nNextState)
  local nWaitTime = 0.167
  return nWaitTime
end

function PenguinLevel_Endless:FreeRollAide()
  local tbId = self:GetRollAideResult()
  if next(tbId) == nil then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_Error_EmptyAide")
    })
    return
  end
  self:ClearSelectableAide()
  for _, nId in ipairs(tbId) do
    local mapAide = self:CreateAide(nId)
    table.insert(self.tbSelectableAide, mapAide)
  end
  self.bSelectedAide = false
end

function PenguinLevel_Endless:SelectAide(nIndex)
  if self:GetOwnAideCount() >= self.nAideLimit then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PenguinCard_AideMax"))
    return
  end
  local mapSelectAide = self.tbSelectableAide[nIndex]
  local nAimIndex = 0
  for i, v in ipairs(self.tbAide) do
    if v == 0 then
      nAimIndex = i
      break
    end
  end
  local mapAide = self:CreateAide(mapSelectAide.nId)
  self.tbAide[nAimIndex] = mapAide
  self.tbAide[nAimIndex]:SetSlotIndex(nAimIndex)
  self.tbAide[nAimIndex]:ResetAllTrigger()
  self.bSelectedAide = true
  local nAdd = self.tbAide[nAimIndex]:GetScore()
  nAdd = self:GetAideScore(nAdd)
  self:ChangeScore(nAdd)
  self:RefreshAura()
  PlayerData.Voice:PlayCharVoice("swap", mapAide.nCharId)
  EventManager.Hit("PenguinCard_SelectAide", nAimIndex)
end

function PenguinLevel_Endless:UpgradeAide(nIndex, nGroup)
  local mapAide = self.tbAide[nIndex]
  if mapAide == 0 then
    return
  end
  local bUpgrade = mapAide:SetUpgradeGroup(nGroup)
  self.mapAideLevel[tostring(mapAide.nId)] = {
    nLevel = mapAide.nLevel,
    mapUpgradeCount = clone(mapAide.mapUpgradeCount)
  }
  self.bSelectedPenguinCard = true
  self:RefreshAura()
  if bUpgrade then
    PlayerData.Voice:PlayCharVoice("charUp", mapAide.nCharId)
  else
    PlayerData.Voice:PlayCharVoice("thankSmall", mapAide.nCharId)
  end
  EventManager.Hit("PenguinCard_UpgradeAide", nIndex, bUpgrade)
end

function PenguinLevel_Endless:CheckAideUpgrade(nGroup)
  for i, v in ipairs(self.tbAide) do
    if v ~= 0 then
      local bAble = v:CheckUpgradeGroup(nGroup)
      if bAble then
        return i
      end
    end
  end
end

function PenguinLevel_Endless:GetOwnAideCount()
  local nCount = 0
  for i = 1, 3 do
    if self.tbAide[i] ~= 0 then
      nCount = nCount + 1
    end
  end
  return nCount
end

function PenguinLevel_Endless:SaleAide(nIndex)
  local mapAide = self.tbAide[nIndex]
  local nCharId = mapAide.nCharId
  self:RecycleAide(mapAide)
  self.tbAide[nIndex] = 0
  self:RefreshAura()
  PlayerData.Voice:PlayCharVoice("question", nCharId)
  EventManager.Hit("PenguinCard_SaleAide", nIndex)
end

function PenguinLevel_Endless:ClearSelectableAide()
  if next(self.tbSelectableAide) ~= nil then
    for i = #self.tbSelectableAide, 1, -1 do
      local mapAide = table.remove(self.tbSelectableAide, i)
      self:RecycleAide(mapAide)
    end
  end
end

function PenguinLevel_Endless:GetRollAideResult()
  local mapWeightCfg = ConfigTable.GetData("PenguinCardAidePool", self.nAidePool)
  if not mapWeightCfg then
    return {}
  end
  local tbWeight = clone(mapWeightCfg.Weight)
  local tbHas = {}
  for i = 1, 3 do
    if self.tbAide[i] ~= 0 then
      table.insert(tbHas, self.tbAide[i].nId)
    end
  end
  local nRoll = self.nAideRollCount
  local tbId = PenguinCardUtils.WeightedRandom(mapWeightCfg.AideId, tbWeight, nRoll, tbHas, false, true)
  return tbId
end

function PenguinLevel_Endless:RecycleAide(mapAide)
  mapAide:Clear()
  table.insert(self.tbAidePool, mapAide)
end

function PenguinLevel_Endless:CreateAide(nId)
  local mapAide
  if next(self.tbAidePool) == nil then
    mapAide = PenguinCardAide.new(nId, self.mapAideLevel[tostring(nId)])
  else
    mapAide = table.remove(self.tbAidePool, 1)
    mapAide:Init(nId, self.mapAideLevel[tostring(nId)])
  end
  return mapAide
end

function PenguinLevel_Endless:RunState_Prepare()
  self.nCurTurn = self.nCurTurn + 1
  self.nCurRound = 0
  self:ClearStateData_Prepare()
  self:ClearTurnData()
  self.tbSelectableAide = {}
  self.bSelectedAide = false
  for _, v in ipairs(self.tbBuff) do
    v:ResetTurnTrigger()
  end
  for _, v in ipairs(self.tbPenguinCard) do
    if v ~= 0 then
      v:ResetTurnTrigger()
    end
  end
  for _, v in ipairs(self.tbAide) do
    if v ~= 0 then
      v:ResetTurnTrigger()
    end
  end
  local nPrepareInTime = 0.8
  local nInitialCardInTime = 0.9
  local nAuraInTime = 0.3
  EventManager.Hit(EventId.BlockInput, true)
  local sequence = DOTween.Sequence()
  sequence:AppendInterval(nPrepareInTime)
  if next(self.tbInitialCard) ~= nil then
    sequence:AppendCallback(function()
      self:AddInitialCard()
    end)
    sequence:AppendInterval(nInitialCardInTime)
  end
  sequence:AppendCallback(function()
    self:RefreshAura()
    EventManager.Hit("PenguinCard_AuraTriggered")
    for _, nBuffId in ipairs(self.tbEndlessLevelBuffId) do
      local mapData = self:CreateBuff(nBuffId)
      mapData:ResetAllTrigger()
      self:AddBuff(mapData)
    end
  end)
  sequence:AppendInterval(nAuraInTime)
  sequence:SetUpdate(true)
  local callback = dotween_callback_handler(self, function()
    self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.NextLevel)
    self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.Prepare)
    self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.BeforeUpgrade)
    EventManager.Hit(EventId.BlockInput, false)
  end)
  sequence:OnComplete(callback)
  self:ChangeScore(self.nAdditionScore)
  for _, v in ipairs(self.tbAide) do
    if v ~= 0 then
      local nAdd = v:GetScore()
      nAdd = self:GetAideScore(nAdd)
      self:ChangeScore(nAdd)
    end
  end
  self:FreeRollAide()
  self:FreeRollPenguinCard()
  EventManager.Hit("PenguinCard_RunState_Prepare")
end

function PenguinLevel_Endless:QuitState_Prepare(nNextState)
  self:ClearSelectablePenguinCard()
  self:ClearStateData_Prepare()
  self:ClearSelectableAide()
  self.tbSelectableAide = {}
  self.bSelectedAide = false
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

function PenguinLevel_Endless:AddRound()
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

function PenguinLevel_Endless:AddAide()
  if self.nAideLimit == self.nMaxAide then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_AddBtnMaxLevel")
    })
    return
  end
  local nCost = self.tbAideUpgradeCost[self.nAideLimit + 1] * self:GetUpgradeDiscount()
  if nCost > self.nScore then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_NotEnoughScoreUpgrade")
    })
    return
  end
  self.nAideLimit = self.nAideLimit + 1
  self:ChangeScore(-1 * nCost)
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Tips,
    sSound = "Mode_Card_buy",
    sContent = orderedFormat(ConfigTable.GetUIText("PenguinCard_AddAideSuccess"), self.nAideLimit)
  })
  self:AfterUpgrade(nCost)
  EventManager.Hit("PenguinCard_AddAide")
end

function PenguinLevel_Endless:AddAdditionScore()
  if self.nAdditionScoreLevel == self.nMaxAdditionScore then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_AddBtnMaxLevel")
    })
    return
  end
  local nCost = self.tbScoreUpgradeCost[self.nAdditionScoreLevel + 1] * self:GetUpgradeDiscount()
  if nCost > self.nScore then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_NotEnoughScoreUpgrade")
    })
    return
  end
  self.nAdditionScoreLevel = self.nAdditionScoreLevel + 1
  self:ChangeAdditionScore()
  self:ChangeScore(-1 * nCost)
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Tips,
    sSound = "Mode_Card_buy",
    sContent = orderedFormat(ConfigTable.GetUIText("PenguinCard_AddAdditionScoreSuccess"), self.nAdditionScore)
  })
  self:AfterUpgrade(nCost)
  EventManager.Hit("PenguinCard_AddAdditionScore")
end

function PenguinLevel_Endless:AddInitialCard()
  if next(self.tbInitialCard) == nil then
    return
  end
  
  local function add(nId)
    local mapCfg = ConfigTable.GetData("PenguinCard", nId)
    if not mapCfg then
      return
    end
    local bUpgrade, nAimIndex = self:CheckUpgradePenguinCardByGroup(mapCfg.GroupId)
    if not bUpgrade and self:GetOwnPenguinCardCount() >= self.nSlotCount then
      return
    end
    if bUpgrade then
      self.tbPenguinCard[nAimIndex]:Upgrade(mapCfg.Level)
    else
      local mapCard = self:CreatePenguinCard(nId)
      self.tbPenguinCard[nAimIndex] = mapCard
    end
    self.tbPenguinCard[nAimIndex]:SetSlotIndex(nAimIndex)
    self.tbPenguinCard[nAimIndex]:ResetAllTrigger()
    self.nGetPenguinCardCount = self.nGetPenguinCardCount + 1
    self:AfterChangePenguinCard()
    EventManager.Hit("PenguinCard_AddInitialCard", nAimIndex, bUpgrade)
  end
  
  for _, nId in ipairs(self.tbInitialCard) do
    add(nId)
  end
end

function PenguinLevel_Endless:GetPenguinCardWeightLevel()
  return self.nEndlessLevel
end

function PenguinLevel_Endless:ChangeAdditionScore()
  local nScore = 0
  if 0 < self.nAdditionScoreLevel then
    for i = 1, self.nAdditionScoreLevel do
      nScore = nScore + self.tbAdditionScore[i]
    end
  end
  self.nAdditionScore = nScore
end

function PenguinLevel_Endless:GetMaxLevelPenguinCard()
  return {}
end

function PenguinLevel_Endless:GetRollPenguinCardCost()
  local tbCost = ConfigTable.GetConfigNumberArray("PenguinCardEndlessRollCardCost")
  local nCost = tbCost[self.nTurnBuyCount + 1]
  return nCost
end

function PenguinLevel_Endless:CheckMaxLevelPenguinCard(nGroupId)
  for _, v in ipairs(self.tbPenguinCard) do
    if v ~= 0 and v.nGroupId == nGroupId and v.nLevel == v.nMaxLevel then
      return true
    end
  end
  return false
end

function PenguinLevel_Endless:GetAimScore()
  local nAura = self.nAimScoreAura or 0
  local nP = (100 + nAura) / 100
  nP = clearFloat(nP)
  return self.nAimScore * nP
end

function PenguinLevel_Endless:GetAideScore(nScore)
  local nAura = self.nAideScoreAura or 0
  local nP = (100 + nAura) / 100
  nP = clearFloat(nP)
  return nScore * nP
end

function PenguinLevel_Endless:ChangeAimScore(nAura)
  local nBeforeScore = self:GetAimScore()
  self.nAimScoreAura = self.nAimScoreAura + nAura
  EventManager.Hit("PenguinCard_ChangeAimScore", nBeforeScore)
end

function PenguinLevel_Endless:ChangeAideScore(nAura)
  self.nAideScoreAura = self.nAideScoreAura + nAura
  EventManager.Hit("PenguinCard_ChangeAideScore")
end

function PenguinLevel_Endless:RunState_Dealing()
  self:SaveSnapshot()
  self:SaveFirstRoundSnapshot()
  self.bCheckRound = self:GetSnapshotState()
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
  for _, v in ipairs(self.tbAide) do
    if v ~= 0 then
      v:ResetRoundTrigger()
    end
  end
  self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.Dealing)
  self.tbBaseCardId = PenguinCardUtils.WeightedRandom(self.mapCalBaseCardPool.tbId, self.mapCalBaseCardPool.tbWeight, self.nBaseCardCount, {}, true)
  self.tbShowedCard = {}
  for i = 1, self.nBaseCardCount do
    self.tbShowedCard[i] = false
  end
  EventManager.Hit("PenguinCard_RunState_Dealing")
  self:SwitchGameState()
end

function PenguinLevel_Endless:QuitState_Dealing(nNextState)
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

function PenguinLevel_Endless:SaveFirstRoundSnapshot()
  if self.nCurRound ~= 0 then
    return
  end
  self.mapFirstRoundSnapshot = clone(self.mapSnapshot)
end

function PenguinLevel_Endless:RunState_Flip()
  EventManager.Hit("PenguinCard_RunState_Flip")
  self:PlayAuto()
end

function PenguinLevel_Endless:QuitState_Flip(nNextState)
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

function PenguinLevel_Endless:AfterShowBaseCard(mapCfg)
end

function PenguinLevel_Endless:AfterCheckHandRank()
end

function PenguinLevel_Endless:RunState_Settlement()
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

function PenguinLevel_Endless:QuitState_Settlement(nNextState)
  self:StopAuto()
  if not self.bRestoreSnapshot then
    self:ChangeScore(self.nRoundScore)
    self:EndRound()
    if self:GetRoundLimitInTurn() == self.nCurRound then
      self:EndTurn()
    end
  end
  self.bCheckRound = false
  self:ClearRoundData()
  EventManager.Hit("PenguinCard_QuitState_Settlement", nNextState)
  local nWaitTime = 0
  if nNextState == PenguinCardUtils.GameState.Start then
    nWaitTime = 0.6
  elseif nNextState == PenguinCardUtils.GameState.Dealing then
    nWaitTime = self.bRestoreSnapshot and 0.57 or 1.22
  elseif nNextState == PenguinCardUtils.GameState.Prepare then
    nWaitTime = 0.57
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    nWaitTime = 0.6
  elseif nNextState == PenguinCardUtils.GameState.EndlessCheck then
    nWaitTime = 0.65
  end
  return nWaitTime
end

function PenguinLevel_Endless:NextRound()
  self:StopAuto()
  self:SwitchGameState()
end

function PenguinLevel_Endless:CheckAllRound()
  self:RestoreFirstRoundSnapshot()
  self.bNewLevel = false
  self.nCheckRoundCount = 0
  local nBuffId = ConfigTable.GetConfigNumber("PenguinCardEndlessRetryBuffId")
  local mapData = self:CreateBuff(nBuffId)
  mapData:ResetAllTrigger()
  self:AddBuff(mapData)
  local nNextState = PenguinCardUtils.GameState.Dealing
  self:SwitchNextGameState(nNextState)
end

function PenguinLevel_Endless:RestoreFirstRoundSnapshot()
  self.mapSnapshot = clone(self.mapFirstRoundSnapshot)
  self:RestoreSnapshot()
  self.mapFirstRoundSnapshot = nil
  self.bRestoreSnapshot = false
end

function PenguinLevel_Endless:RunState_EndlessCheck()
  self.nCheckHp = self.nHp
  if self.nScore < self:GetAimScore() then
    self:ChangeHp(-1)
  end
  EventManager.Hit("PenguinCard_RunState_EndlessCheck")
end

function PenguinLevel_Endless:QuitState_EndlessCheck(nNextState)
  EventManager.Hit("PenguinCard_QuitState_EndlessCheck", nNextState)
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

function PenguinLevel_Endless:RunState_Complete(mapParam)
  self.nStar = self:GetStar()
  EventManager.Hit("PenguinCard_RunState_Complete")
  if self.nActId then
    local tab = {}
    local mapLevelCfg = ConfigTable.GetData("PenguinCardFloor", self.nFloorId)
    local nEndlessId = mapLevelCfg.EndlessGroup * 100 + self.nEndlessLevel
    table.insert(tab, {
      "endless_level",
      tostring(nEndlessId)
    })
    local sAssist = ""
    for i = 1, 3 do
      if self.tbAide[i] ~= 0 then
        if sAssist == "" then
          sAssist = sAssist .. self.tbAide[i].nId .. ":" .. self.tbAide[i].nLevel
        else
          sAssist = sAssist .. "," .. self.tbAide[i].nId .. ":" .. self.tbAide[i].nLevel
        end
      end
    end
    table.insert(tab, {
      "assist_list",
      sAssist
    })
    table.insert(tab, {
      "hp",
      tostring(self.nHp)
    })
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
      tostring(0 >= self.nHp and 2 or 1)
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
      tostring(self.nAideLimit)
    })
    table.insert(tab, {
      "skill_3",
      tostring(self.nAdditionScore)
    })
    NovaAPI.UserEventUpload("minigame_PenguinCard", tab)
  end
end

function PenguinLevel_Endless:QuitState_Complete()
  self.nStar = 0
  EventManager.Hit("PenguinCard_QuitState_Complete")
  return 0
end

function PenguinLevel_Endless:PlayAuto(bClick)
  if not self.bAuto or self.bPause then
    return
  end
  if self.nGameState == PenguinCardUtils.GameState.Flip then
    self.sequence = DOTween.Sequence()
    for j = 1, self.nBaseCardCount do
      if self.tbShowedCard[j] == false then
        self.sequence:AppendCallback(function()
          self:ShowBaseCard(j)
        end)
        self.sequence:AppendInterval(0.2 / self.nSpeed)
      end
    end
    self.sequence:SetUpdate(true)
  elseif self.nGameState == PenguinCardUtils.GameState.Settlement then
    local bKeep = not PlayerData.Guide:CheckGuideFinishById(302)
    if EditorSettings and EditorSettings.bJumpGuide then
      bKeep = false
    end
    if bKeep then
      return
    end
    self.sequence = DOTween.Sequence()
    if not bClick then
      self.sequence:AppendInterval((self.nRoundValue >= self.nFireScore and 7 or 5) / self.nSpeed)
    end
    self.sequence:AppendCallback(function()
      EventManager.Hit("PenguinCard_QuitScoreAni")
      self:SwitchGameState()
    end)
    self.sequence:SetUpdate(true)
  end
end

function PenguinLevel_Endless:ExecuteModeEffect(nEffectType, mapEffectValue, mapTriggerSource)
  if nEffectType == GameEnum.PenguinCardEffectType.AimScoreAura then
    self:ChangeAimScore(mapEffectValue)
  elseif nEffectType == GameEnum.PenguinCardEffectType.AideScoreAura then
    self:ChangeAideScore(mapEffectValue)
  elseif nEffectType == GameEnum.PenguinCardEffectType.RetryLimit then
    self.bRetryLimit = true
  end
end

function PenguinLevel_Endless:TriggerModeEffect(nTriggerPhase, mapTriggerSource, callback)
  for _, v in ipairs(self.tbAide) do
    if v ~= 0 then
      v:Trigger(nTriggerPhase, mapTriggerSource, callback)
      v:Growth(nTriggerPhase, mapTriggerSource)
    end
  end
end

function PenguinLevel_Endless:OnEvent_ChangeScore(nBefore)
  local nBeforeStar, nStar = 0, 0
  for i, v in ipairs(self.tbStarScore) do
    if v <= nBefore then
      nBeforeStar = i
    end
    if v <= self.nScore then
      nStar = i
    end
  end
  EventManager.Hit("PenguinCard_ChangeStar", nBeforeStar, nStar)
end

function PenguinLevel_Endless:BindEvent()
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

function PenguinLevel_Endless:UnBindEvent()
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

function PenguinLevel_Endless:SaveModeSnapshot(mapSnapshot)
  local tbAideSnap = {}
  local tbAide = self.tbAide or {}
  for i = 1, 3 do
    local v = tbAide[i]
    if v == 0 or v == nil then
      tbAideSnap[i] = 0
    else
      tbAideSnap[i] = v:Serialize()
    end
  end
  mapSnapshot.tbAide = tbAideSnap
end

function PenguinLevel_Endless:RestoreModeSnapshot(mapSnapshot)
  for i = 1, 3 do
    local v = self.tbAide[i]
    if v ~= 0 and v ~= nil then
      self:RecycleAide(v)
    end
    local mapData = mapSnapshot.tbAide[i]
    if mapData == 0 then
      self.tbAide[i] = 0
    else
      local mapAide = self:CreateAide(mapData.nId)
      mapAide:Deserialize(mapData)
      self.tbAide[i] = mapAide
    end
  end
end

return PenguinLevel_Endless
