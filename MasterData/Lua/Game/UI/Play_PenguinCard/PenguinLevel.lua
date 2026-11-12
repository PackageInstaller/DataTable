local PenguinLevel = class("PenguinLevel")
local PenguinCard = require("Game.UI.Play_PenguinCard.PenguinCard")
local PenguinCardBuff = require("Game.UI.Play_PenguinCard.PenguinCardBuff")
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalData = require("GameCore.Data.LocalData")
local ConfigData = require("GameCore.Data.ConfigData")
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")

function PenguinLevel:ParseConfigData()
  self.nBaseCardCount = ConfigTable.GetConfigNumber("PenguinCardHandCardCount")
  self.nFireScore = ConfigTable.GetConfigNumber("PenguinCardFeverScore")
  self.nPenguinCardRollCount = ConfigTable.GetConfigNumber("PenguinCardRollCount")
  self.nMaxHp = ConfigTable.GetConfigNumber("PenguinCardMaxHP")
  self.mapBuyCost = {}
  
  local function func_ForEach_Line(mapData)
    self.mapBuyCost[mapData.Count] = {
      Turn = mapData.Turn,
      Cost = mapData.Cost
    }
  end
  
  ForEachTableLine(DataTable.PenguinCardCost, func_ForEach_Line)
  self.mapHandRankRule = {}
  
  local function func_ForEach_Rank(mapData)
    self.mapHandRankRule[mapData.Order] = {
      Id = mapData.Id,
      SuitCount = mapData.SuitCount,
      Value = mapData.Value,
      Ratio = mapData.Ratio * ConfigData.IntFloatPrecision
    }
  end
  
  ForEachTableLine(DataTable.PenguinCardHandRank, func_ForEach_Rank)
  self.mapTendencyScore = {}
  
  local function func_ForEach_Tendency(mapData)
    if not self.mapTendencyScore[mapData.GroupId] then
      self.mapTendencyScore[mapData.GroupId] = {}
    end
    table.insert(self.mapTendencyScore[mapData.GroupId], mapData.Score)
  end
  
  ForEachTableLine(DataTable.PenguinCardTendency, func_ForEach_Tendency)
  for _, v in pairs(self.mapTendencyScore) do
    table.sort(v)
  end
  if type(self.ParseModeConfigData) == "function" then
    self:ParseModeConfigData()
  end
end

function PenguinLevel:ParseServerData(nFloorId, nLevelId, nActId, tbStarScore)
  self.nFloorId = nFloorId
  self.nLevelId = nLevelId
  self.nActId = nActId
  self.tbStarScore = tbStarScore or {
    0,
    0,
    0
  }
end

function PenguinLevel:ParseLocalData()
  local bAuto = LocalData.GetPlayerLocalData("PenguinCardAuto")
  self.bAuto = bAuto == true
  local nSpeed = LocalData.GetPlayerLocalData("PenguinCardSpeed")
  self.nSpeed = nSpeed or 1
end

function PenguinLevel:ParseLevelData(nFloorId)
  local mapLevelCfg = ConfigTable.GetData("PenguinCardFloor", nFloorId)
  if not mapLevelCfg then
    return
  end
  self.nMaxTurn = mapLevelCfg.MaxTurn
  self.nScore = mapLevelCfg.InitialScore
  self.nTotalScore = mapLevelCfg.InitialScore
  self.nSlotCount = mapLevelCfg.InitialSlot
  self.nRoundLimit = mapLevelCfg.InitialRound
  self.nCheckRoundLimit = mapLevelCfg.InitialCheckRound
  self.nBuyLimit = mapLevelCfg.InitialBuyLimit
  self.nWeightGroupId = mapLevelCfg.WeightGroup
  self.sLevelDesc = mapLevelCfg.Floortips
  self.sSubLevelDesc = mapLevelCfg.FloorDesc
  self.mapBaseCardPool = {
    tbId = {},
    tbWeight = {}
  }
  local mapPoolCfg = ConfigTable.GetData("PenguinBaseCardPool", mapLevelCfg.PoolId)
  if mapPoolCfg then
    self.mapBaseCardPool = {
      tbId = mapPoolCfg.BaseCardId,
      tbWeight = mapPoolCfg.Weight
    }
  end
  if type(self.ParseModeLevelData) == "function" then
    self:ParseModeLevelData(mapLevelCfg)
  end
end

function PenguinLevel:ClearLevelData()
  self.nGameState = nil
  self.nCurTurn = 0
  self.nCurRound = 0
  self.nHp = self.nMaxHp
  if self.tbBuffPool == nil then
    self.tbBuffPool = {}
  end
  if self.tbBuff == nil then
    self.tbBuff = {}
  elseif next(self.tbBuff) ~= nil then
    local nCount = #self.tbBuff
    for i = nCount, 1, -1 do
      self:RecycleBuff(self.tbBuff[i])
      table.remove(self.tbBuff, i)
    end
  end
  if self.tbPenguinCardPool == nil then
    self.tbPenguinCardPool = {}
  end
  if self.tbPenguinCard == nil then
    self.tbPenguinCard = {}
    for i = 1, 6 do
      self.tbPenguinCard[i] = 0
    end
  elseif next(self.tbPenguinCard) ~= nil then
    for i = 1, 6 do
      local mapCard = self.tbPenguinCard[i]
      if mapCard ~= 0 then
        self:RecyclePenguinCard(mapCard)
        self.tbPenguinCard[i] = 0
      end
    end
  end
  self.mapLog = {}
  self.nTotalRound = 0
  self.nBestTurnScore = 0
  self.nBestRoundScore = 0
  self.mapHandRankHistory = {}
  self.mapSuitHistory = {}
  self.nGetPenguinCardCount = 0
  self.mapSnapshot = nil
  self.bRestoreSnapshot = false
  local mapFieldMap = self:GetAuraFieldMap()
  for _, sField in pairs(mapFieldMap) do
    self[sField] = 0
  end
  if type(self.ClearModeLevelData) == "function" then
    self:ClearModeLevelData()
  end
end

function PenguinLevel:StartGame()
  math.randomseed(os.time())
  self:ClearLevelData()
  self:ParseLevelData(self.nFloorId)
  self:SwitchGameState()
end

function PenguinLevel:CompleteGame()
  local nNextState = PenguinCardUtils.GameState.Complete
  self:SwitchNextGameState(nNextState, {bManual = true})
end

function PenguinLevel:RestartGame()
  local nNextState = PenguinCardUtils.GameState.Start
  local nWaitTime = self:QuitGameState(nNextState)
  if nWaitTime == 0 then
    self:StartGame()
  else
    EventManager.Hit("PenguinCard_Block", true)
    TimerManager.Add(1, nWaitTime, self, function()
      EventManager.Hit("PenguinCard_Block", false)
      self:StartGame()
    end, true, true, true)
  end
end

function PenguinLevel:QuitGame(callback)
  local bAct = false
  if self.nActId then
    local actData = PlayerData.Activity:GetActivityDataById(self.nActId)
    if actData then
      local bOpen = actData:CheckActivityOpen()
      if bOpen then
        bAct = true
        local nScore = math.floor(self.nScore)
        actData:SendActivityPenguinCardSettleReq(self.nLevelId, self.nStar or 1, nScore, self.nEndlessLevel or 0, callback)
      else
        EventManager.Hit(EventId.OpenMessageBox, {
          nType = AllEnum.MessageBox.Alert,
          sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_3")
        })
      end
    end
  end
  if not bAct then
    callback(true)
  end
  self:QuitGameState()
  self:ClearLevelData()
  if type(self.Exit) == "function" then
    self:Exit()
  end
end

function PenguinLevel:SwitchGameState()
  local nNextState = PenguinCardUtils.GameState.Start
  if type(self.CheckNextGameState) == "function" then
    nNextState = self:CheckNextGameState()
  end
  self:SwitchNextGameState(nNextState)
end

function PenguinLevel:RunGameState(mapParam)
  if self.nGameState == PenguinCardUtils.GameState.Start then
    if type(self.RunState_Start) == "function" then
      self:RunState_Start()
    end
  elseif self.nGameState == PenguinCardUtils.GameState.Prepare then
    if type(self.RunState_Prepare) == "function" then
      self:RunState_Prepare()
    end
  elseif self.nGameState == PenguinCardUtils.GameState.Dealing then
    if type(self.RunState_Dealing) == "function" then
      self:RunState_Dealing()
    end
  elseif self.nGameState == PenguinCardUtils.GameState.Flip then
    if type(self.RunState_Flip) == "function" then
      self:RunState_Flip()
    end
  elseif self.nGameState == PenguinCardUtils.GameState.Settlement then
    if type(self.RunState_Settlement) == "function" then
      self:RunState_Settlement()
    end
  elseif self.nGameState == PenguinCardUtils.GameState.Complete then
    if type(self.RunState_Complete) == "function" then
      self:RunState_Complete(mapParam)
    end
  elseif self.nGameState == PenguinCardUtils.GameState.Quest then
    if type(self.RunState_Quest) == "function" then
      self:RunState_Quest()
    end
  elseif self.nGameState == PenguinCardUtils.GameState.EndlessCheck and type(self.RunState_EndlessCheck) == "function" then
    self:RunState_EndlessCheck()
  end
end

function PenguinLevel:QuitGameState(nNextState)
  local nWaitTime = 0
  if self.nGameState == PenguinCardUtils.GameState.Start then
    if type(self.QuitState_Start) == "function" then
      nWaitTime = self:QuitState_Start(nNextState)
    end
  elseif self.nGameState == PenguinCardUtils.GameState.Prepare then
    if type(self.QuitState_Prepare) == "function" then
      nWaitTime = self:QuitState_Prepare(nNextState)
    end
  elseif self.nGameState == PenguinCardUtils.GameState.Dealing then
    if type(self.QuitState_Dealing) == "function" then
      nWaitTime = self:QuitState_Dealing(nNextState)
    end
  elseif self.nGameState == PenguinCardUtils.GameState.Flip then
    if type(self.QuitState_Flip) == "function" then
      nWaitTime = self:QuitState_Flip(nNextState)
    end
  elseif self.nGameState == PenguinCardUtils.GameState.Settlement then
    if type(self.QuitState_Settlement) == "function" then
      nWaitTime = self:QuitState_Settlement(nNextState)
    end
  elseif self.nGameState == PenguinCardUtils.GameState.Complete then
    if type(self.QuitState_Complete) == "function" then
      nWaitTime = self:QuitState_Complete()
    end
  elseif self.nGameState == PenguinCardUtils.GameState.Quest then
    if type(self.QuitState_Quest) == "function" then
      nWaitTime = self:QuitState_Quest(nNextState)
    end
  elseif self.nGameState == PenguinCardUtils.GameState.EndlessCheck and type(self.QuitState_EndlessCheck) == "function" then
    nWaitTime = self:QuitState_EndlessCheck(nNextState)
  end
  return nWaitTime
end

function PenguinLevel:SwitchNextGameState(nNextState, mapParam)
  local nWaitTime = self:QuitGameState(nNextState)
  if nWaitTime == 0 then
    self.nGameState = nNextState
    self:RunGameState(mapParam)
  else
    EventManager.Hit("PenguinCard_Block", true)
    TimerManager.Add(1, nWaitTime, self, function()
      EventManager.Hit("PenguinCard_Block", false)
      self.nGameState = nNextState
      self:RunGameState(mapParam)
    end, true, true, true)
  end
end

function PenguinLevel:ChangeHp(nChange)
  self.nHp = self.nHp + nChange
  if self.nHp >= self.nMaxHp then
    self.nHp = self.nMaxHp
  end
  if NovaAPI.IsEditorPlatform() then
    printLog("Hp变化：" .. "  " .. nChange .. "  当前：" .. self.nHp)
  end
  EventManager.Hit("PenguinCard_ChangeHp", nChange)
  if self.nHp <= 0 then
    self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.FatalDamage, {nHpChange = nChange})
  end
end

function PenguinLevel:AddBuff(mapBuff, bWaitShow)
  if mapBuff.bOnly then
    local nBuffCount = #self.tbBuff
    for i = nBuffCount, 1, -1 do
      if mapBuff.nId == self.tbBuff[i].nId then
        self:DeleteBuff(i)
      end
    end
    table.insert(self.tbBuff, mapBuff)
    EventManager.Hit("PenguinCard_AddBuff", mapBuff, bWaitShow)
  else
    local nHasKey = 0
    for k, v in pairs(self.tbBuff) do
      if v.nId == mapBuff.nId then
        nHasKey = k
        break
      end
    end
    if 0 < nHasKey then
      self.tbBuff[nHasKey]:AddGrowthLayer()
    else
      table.insert(self.tbBuff, mapBuff)
      EventManager.Hit("PenguinCard_AddBuff", mapBuff, bWaitShow)
    end
  end
  self:RefreshAura()
  if NovaAPI.IsEditorPlatform() then
    printLog("获得buff：" .. "  " .. mapBuff.nId)
  end
end

function PenguinLevel:DeleteBuff(i, nDelayTime, bSkipAni)
  self:RecycleBuff(self.tbBuff[i])
  table.remove(self.tbBuff, i)
  self:RefreshAura()
  EventManager.Hit("PenguinCard_DeleteBuff", i, nDelayTime, bSkipAni)
end

function PenguinLevel:RecycleBuff(mapBuff)
  mapBuff:Clear()
  table.insert(self.tbBuffPool, mapBuff)
end

function PenguinLevel:CreateBuff(nId)
  local mapBuff
  if next(self.tbBuffPool) == nil then
    mapBuff = PenguinCardBuff.new(nId)
  else
    mapBuff = table.remove(self.tbBuffPool, 1)
    mapBuff:Init(nId)
  end
  return mapBuff
end

function PenguinLevel:ClearTurnData()
  self.nTurnScore = 0
  self.tbHandRankCount = {}
  self.nCheckRoundCount = 0
  self.nTempUpgradeDiscount = 0
  self.nTempAddRound = 0
  self.nTempAddRollCount = 0
end

function PenguinLevel:ClearStateData_Prepare()
  self.nTurnBuyCount = 0
  self.tbSelectablePenguinCard = {}
  self.bSelectedPenguinCard = false
end

function PenguinLevel:ChangeRoundLimitInTurn(nTemp, nAura)
  if self.nTempAddRound ~= nil then
    self.nTempAddRound = self.nTempAddRound + nTemp
  end
  self.nRoundLimitAura = self.nRoundLimitAura + nAura
  EventManager.Hit("PenguinCard_ChangeRoundLimitInTurn")
end

function PenguinLevel:GetRoundLimitInTurn()
  local nAdd = 0
  if self.nTempAddRound ~= nil then
    nAdd = nAdd + self.nTempAddRound
  end
  nAdd = nAdd + self.nRoundLimitAura
  local nLimit = self.nRoundLimit + nAdd
  if nLimit < 1 then
    nLimit = 1
  end
  return nLimit
end

function PenguinLevel:ChangeUpgradeDiscount(nTemp, nAura)
  local nBeforeDiscount = self:GetUpgradeDiscount()
  if self.nTempUpgradeDiscount ~= nil then
    self.nTempUpgradeDiscount = self.nTempUpgradeDiscount + nTemp
  end
  self.nUpgradeDiscountAura = self.nUpgradeDiscountAura + nAura
  EventManager.Hit("PenguinCard_ChangeUpgradeDiscount", nBeforeDiscount)
end

function PenguinLevel:GetUpgradeDiscount()
  local nAura = self.nUpgradeDiscountAura or 0
  local nTemp = self.nTempUpgradeDiscount or 0
  local nValue = (100 + nAura + nTemp) / 100
  return clearFloat(nValue)
end

function PenguinLevel:AfterUpgrade(nUpgradeCost)
  self.nTempUpgradeDiscount = 0
  self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.AfterUpgrade, {nUpgradeCost = nUpgradeCost})
  self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.BeforeUpgrade)
end

function PenguinLevel:FreeRollPenguinCard()
  local tbId = self:GetRollPenguinCardResult()
  if next(tbId) == nil then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_Error_EmptyPenguinCard")
    })
    return
  end
  self:ClearSelectablePenguinCard()
  for _, nId in ipairs(tbId) do
    local mapCard = self:CreatePenguinCard(nId)
    table.insert(self.tbSelectablePenguinCard, mapCard)
  end
  self.bSelectedPenguinCard = false
end

function PenguinLevel:RollPenguinCard()
  if self.nTurnBuyCount >= self.nBuyLimit then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_RollMax")
    })
    return
  end
  local nCost = self:GetRollPenguinCardCost()
  if nCost > self.nScore then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_NotEnoughScoreRoll")
    })
    return
  end
  local tbId = self:GetRollPenguinCardResult()
  if next(tbId) == nil then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_Error_EmptyPenguinCard")
    })
    return
  end
  self.nTurnBuyCount = self.nTurnBuyCount + 1
  self:ChangeScore(-1 * nCost)
  self:ClearSelectablePenguinCard()
  for _, nId in ipairs(tbId) do
    local mapCard = self:CreatePenguinCard(nId)
    table.insert(self.tbSelectablePenguinCard, mapCard)
  end
  self.bSelectedPenguinCard = false
  self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.ManualRoll)
  EventManager.Hit("PenguinCard_RollPenguinCard")
end

function PenguinLevel:SelectPenguinCard(nIndex)
  local mapSelectCard = self.tbSelectablePenguinCard[nIndex]
  if mapSelectCard == nil then
    if nIndex ~= nil then
      printError("企鹅牌：可选择列表没有当前卡" .. nIndex)
    end
    return
  end
  local bUpgrade, nAimIndex = self:CheckUpgradePenguinCard(mapSelectCard)
  if not bUpgrade and self:GetOwnPenguinCardCount() >= self.nSlotCount then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PenguinCard_SlotMax"))
    return
  end
  if bUpgrade then
    local nAddLevel = mapSelectCard.nLevel
    self.tbPenguinCard[nAimIndex]:Upgrade(nAddLevel)
  else
    local mapCard = self:CreatePenguinCard(mapSelectCard.nId)
    self.tbPenguinCard[nAimIndex] = mapCard
  end
  self.tbPenguinCard[nAimIndex]:SetSlotIndex(nAimIndex)
  self.tbPenguinCard[nAimIndex]:ResetAllTrigger()
  self.bSelectedPenguinCard = true
  self.nGetPenguinCardCount = self.nGetPenguinCardCount + 1
  self:AfterChangePenguinCard()
  EventManager.Hit("PenguinCard_SelectPenguinCard", nAimIndex, bUpgrade)
end

function PenguinLevel:AfterChangePenguinCard()
  local nAllLevel = 0
  for _, v in ipairs(self.tbPenguinCard) do
    if v ~= 0 then
      nAllLevel = nAllLevel + v.nLevel
    end
  end
  self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.PenguinCardChange, {PenguinCardLevel = nAllLevel})
  self:RefreshAura()
end

function PenguinLevel:CheckUpgradePenguinCard(mapSelectCard)
  local bUpgrade = false
  local nFirstEmpty = 0
  local nAimIndex = 0
  for i, v in ipairs(self.tbPenguinCard) do
    if v == 0 and nFirstEmpty == 0 then
      nFirstEmpty = i
    end
    if v ~= 0 and v.nLevel < v.nMaxLevel and v.nGroupId == mapSelectCard.nGroupId then
      bUpgrade = true
      nAimIndex = i
      break
    end
  end
  if not bUpgrade then
    nAimIndex = nFirstEmpty
  end
  return bUpgrade, nAimIndex
end

function PenguinLevel:CheckUpgradePenguinCardByGroup(nGroupId)
  local bUpgrade = false
  local nFirstEmpty = 0
  local nAimIndex = 0
  for i, v in ipairs(self.tbPenguinCard) do
    if v == 0 and nFirstEmpty == 0 then
      nFirstEmpty = i
    end
    if v ~= 0 and v.nLevel < v.nMaxLevel and v.nGroupId == nGroupId then
      bUpgrade = true
      nAimIndex = i
      break
    end
  end
  if not bUpgrade then
    nAimIndex = nFirstEmpty
  end
  return bUpgrade, nAimIndex
end

function PenguinLevel:SalePenguinCard(nIndex)
  self:ChangeScore(self.tbPenguinCard[nIndex].nSoldPrice)
  local mapCard = self.tbPenguinCard[nIndex]
  local nGroupId = mapCard.nGroupId
  self:RecyclePenguinCard(mapCard)
  self.tbPenguinCard[nIndex] = 0
  self:AfterChangePenguinCard()
  EventManager.Hit("PenguinCard_SalePenguinCard", nIndex, nGroupId)
end

function PenguinLevel:GetRollPenguinCardCost()
  local function findIntervalIndex(x, starts)
    if not starts or #starts == 0 or x < starts[1] then
      return 1
    end
    local low, high = 1, #starts
    local best = 1
    while low <= high do
      local mid = math.floor((low + high) / 2)
      if x >= starts[mid] then
        best = mid
        low = mid + 1
      else
        high = mid - 1
      end
    end
    return best
  end
  
  local mapData = self.mapBuyCost[self.nTurnBuyCount + 1]
  local nIndex = findIntervalIndex(self.nCurTurn, mapData.Turn)
  local nCost = mapData.Cost[nIndex]
  return nCost
end

function PenguinLevel:ClearSelectablePenguinCard()
  if next(self.tbSelectablePenguinCard) ~= nil then
    for i = #self.tbSelectablePenguinCard, 1, -1 do
      local mapCard = table.remove(self.tbSelectablePenguinCard, i)
      self:RecyclePenguinCard(mapCard)
    end
  end
end

function PenguinLevel:GetRollPenguinCardResult()
  local nLevel = self.nCurTurn
  if type(self.GetPenguinCardWeightLevel) == "function" then
    nLevel = self:GetPenguinCardWeightLevel()
  end
  local mapWeightCfg = ConfigTable.GetData("PenguinCardWeight", self.nWeightGroupId * 100 + nLevel)
  if not mapWeightCfg then
    return {}
  end
  local tbWeight = clone(mapWeightCfg.Weight)
  self:AddPenguinCardWeightByTendency(tbWeight, mapWeightCfg.CardList)
  local tbMaxGroupId = self:GetMaxLevelPenguinCard()
  local nRoll = self.nPenguinCardRollCount + self.nTempAddRollCount
  local tbId = PenguinCardUtils.WeightedRandom(mapWeightCfg.CardList, tbWeight, nRoll, tbMaxGroupId)
  return tbId
end

function PenguinLevel:AddPenguinCardWeightByTendency(tbWeight, tbCardList)
  local tbCardAdd = {}
  local tbTendencyId = self:GetRollPenguinCardTendency()
  for _, nTendencyId in pairs(tbTendencyId) do
    local mapTendencyCfg = ConfigTable.GetData("PenguinCardTendency", nTendencyId)
    if mapTendencyCfg then
      local mapAddWeight = {}
      for i, v in ipairs(mapTendencyCfg.CardGroup) do
        mapAddWeight[v] = mapTendencyCfg.AddWeight[i]
      end
      for i, v in ipairs(tbCardList) do
        local mapCardCfg = ConfigTable.GetData("PenguinCard", v)
        if mapCardCfg and mapAddWeight[mapCardCfg.GroupId] then
          tbWeight[i] = tbWeight[i] + mapAddWeight[mapCardCfg.GroupId]
          if not tbCardAdd[v] then
            tbCardAdd[v] = 0
          end
          tbCardAdd[v] = tbCardAdd[v] + mapAddWeight[mapCardCfg.GroupId]
        end
      end
    end
  end
  return tbCardAdd
end

function PenguinLevel:GetRollPenguinCardTendency()
  local mapTendency = {}
  for _, v in ipairs(self.tbPenguinCard) do
    if v ~= 0 and 0 < v.nTendencyGroup then
      if not mapTendency[v.nTendencyGroup] then
        mapTendency[v.nTendencyGroup] = 0
      end
      mapTendency[v.nTendencyGroup] = mapTendency[v.nTendencyGroup] + v.nTendencyScore
    end
  end
  local tbTendencyId = {}
  for nGroup, nScore in pairs(mapTendency) do
    local tbScore = self.mapTendencyScore[nGroup]
    local nLevel = 0
    for k, v in ipairs(tbScore) do
      if v <= nScore then
        nLevel = k
      end
    end
    if 0 < nLevel then
      local nTendencyId = nGroup * 100 + nLevel
      table.insert(tbTendencyId, nTendencyId)
    end
  end
  return tbTendencyId
end

function PenguinLevel:GetMaxLevelPenguinCard()
  local tbGroupId = {}
  for _, v in ipairs(self.tbPenguinCard) do
    if v ~= 0 and v.nLevel == v.nMaxLevel then
      table.insert(tbGroupId, v.nGroupId)
    end
  end
  return tbGroupId
end

function PenguinLevel:ChangeSpecificCard(tbAimId)
  if next(self.tbSelectablePenguinCard) == nil then
    return
  end
  local tbMaxGroupId = self:GetMaxLevelPenguinCard()
  for i = #tbAimId, 1, -1 do
    local mapCardCfg = ConfigTable.GetData("PenguinCard", tbAimId[i])
    if mapCardCfg and table.indexof(tbMaxGroupId, mapCardCfg.GroupId) > 0 then
      table.remove(tbAimId, i)
    end
  end
  if next(tbAimId) == nil then
    return
  end
  local nHasIndex = 0
  for i, v in ipairs(self.tbSelectablePenguinCard) do
    if 0 < table.indexof(tbAimId, v.nId) then
      nHasIndex = i
      v:SetHighLight(true)
      break
    end
  end
  if nHasIndex == 0 then
    local nAimId = tbAimId[math.random(#tbAimId)]
    local tbAimIndex = {}
    for i, v in ipairs(self.tbSelectablePenguinCard) do
      if not v.bHighLight then
        table.insert(tbAimIndex, i)
      end
    end
    if next(tbAimIndex) == nil then
      return
    end
    local nAimIndex = tbAimIndex[math.random(#tbAimIndex)]
    self.tbSelectablePenguinCard[nAimIndex]:Init(nAimId)
    self.tbSelectablePenguinCard[nAimIndex]:SetHighLight(true)
  end
end

function PenguinLevel:ChangeCardLevel(nCount, nChange)
  local function shuffle(arr)
    for i = #arr, 2, -1 do
      local j = math.random(i)
      
      arr[i], arr[j] = arr[j], arr[i]
    end
    return arr
  end
  
  local tbSlot = {
    1,
    2,
    3,
    4,
    5,
    6
  }
  shuffle(tbSlot)
  for i = 1, 6 do
    local nSlot = tbSlot[i]
    local mapCard = self.tbPenguinCard[nSlot]
    if mapCard ~= 0 and 0 < nCount then
      local bAddAble = 0 < nChange and mapCard.nLevel < mapCard.nMaxLevel
      local bReduceAble = nChange < 0 and 1 < mapCard.nLevel
      if bAddAble or bReduceAble then
        mapCard:Upgrade(nChange)
        mapCard:SetSlotIndex(nSlot)
        mapCard:ResetAllTrigger()
        nCount = nCount - 1
        EventManager.Hit("PenguinCard_ChangeCardLevel", nSlot, nChange, clone(mapCard))
        self:AfterChangePenguinCard()
      end
    end
  end
end

function PenguinLevel:RecyclePenguinCard(mapCard)
  mapCard:Clear()
  table.insert(self.tbPenguinCardPool, mapCard)
end

function PenguinLevel:CreatePenguinCard(nId)
  local mapCard
  if next(self.tbPenguinCardPool) == nil then
    mapCard = PenguinCard.new(nId)
  else
    mapCard = table.remove(self.tbPenguinCardPool, 1)
    mapCard:Init(nId)
  end
  return mapCard
end

function PenguinLevel:ClearRoundData()
  self.tbHandRank = {}
  self.nHandRankId = 0
  self.mapAllSuit = {}
  self.nRoundScore = 0
  self.nRoundValue = 0
  self.nRoundRatio = 1
  self.nRoundMultiRatio = 0
  self.mapCalBaseCardPool = {}
end

function PenguinLevel:ChangeBaseCardWeight(tbChangeWeight)
  for k, v in pairs(tbChangeWeight) do
    local nIndex = table.indexof(self.mapCalBaseCardPool.tbId, tonumber(k))
    self.mapCalBaseCardPool.tbWeight[nIndex] = self.mapCalBaseCardPool.tbWeight[nIndex] + v
  end
end

function PenguinLevel:ShowBaseCard(nIndex)
  local function add(i)
    if self.tbShowedCard[i] == false then
      self.tbShowedCard[i] = true
      
      local nId = self.tbBaseCardId[i]
      local mapCfg = ConfigTable.GetData("PenguinBaseCard", nId)
      if mapCfg then
        local SuitCards = {}
        local SuitCount = {}
        for j = 1, 3 do
          local nSuit = mapCfg["Suit" .. j]
          local nCount = mapCfg["SuitCount" .. j]
          if 0 < nSuit and 0 < nCount then
            if not self.mapAllSuit[nSuit] then
              self.mapAllSuit[nSuit] = 0
            end
            self.mapAllSuit[nSuit] = self.mapAllSuit[nSuit] + nCount
            table.insert(SuitCards, nSuit)
            SuitCount[nSuit] = nCount
          end
        end
        self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.Flip, {
          SuitCards = SuitCards,
          SuitCount = SuitCount,
          BaseCard = {
            nId = nId,
            nIndex = i,
            bReplaced = false
          }
        })
      end
      local mapAfterCfg = ConfigTable.GetData("PenguinBaseCard", self.tbBaseCardId[i])
      if mapAfterCfg then
        self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.FlipEnd, {
          BaseCard = {
            nId = self.tbBaseCardId[i],
            nIndex = i
          }
        })
        if type(self.AfterShowBaseCard) == "function" then
          self:AfterShowBaseCard(mapAfterCfg)
        end
      end
    end
  end
  
  local bAll = nIndex == nil
  if bAll then
    for i = 1, self.nBaseCardCount do
      add(i)
    end
  else
    add(nIndex)
  end
  local nShowed = self:GetShowedCardCount()
  if nShowed == self.nBaseCardCount then
    self:CheckHandRank()
    self:SwitchGameState()
  end
  EventManager.Hit("PenguinCard_ShowBaseCard", nIndex)
end

function PenguinLevel:CheckHandRank()
  local tbAllSuit = {}
  for k, v in pairs(self.mapAllSuit) do
    table.insert(tbAllSuit, {nSuit = k, nCount = v})
  end
  local mapTendency = {}
  for i = 1, 3 do
    mapTendency[i] = 0
  end
  for _, v in ipairs(self.tbPenguinCard) do
    if v ~= 0 and 0 < v.nTendencyGroup then
      mapTendency[v.nTendencyGroup] = mapTendency[v.nTendencyGroup] + v.nTendencyScore
    end
  end
  table.sort(tbAllSuit, function(a, b)
    if a.nCount ~= b.nCount then
      return a.nCount > b.nCount
    elseif mapTendency[a.nSuit] ~= mapTendency[b.nSuit] then
      return mapTendency[a.nSuit] > mapTendency[b.nSuit]
    else
      return a.nSuit < b.nSuit
    end
  end)
  for _, v in ipairs(self.mapHandRankRule) do
    self.tbHandRank = {}
    local tbCount = v.SuitCount
    local nType = #tbCount
    local nHasType = #tbAllSuit
    local nAble = 0
    if nType <= nHasType then
      for i = 1, nType do
        if tbAllSuit[i].nCount >= tbCount[i] then
          nAble = nAble + 1
          for _ = 1, tbCount[i] do
            table.insert(self.tbHandRank, tbAllSuit[i].nSuit)
          end
        end
      end
    end
    if nAble == nType then
      if next(self.tbHandRank) == nil then
        for kk, vv in pairs(self.mapAllSuit) do
          for _ = 1, vv do
            table.insert(self.tbHandRank, kk)
          end
        end
      end
      self.nHandRankId = v.Id
      if not self.tbHandRankCount[self.nHandRankId] then
        self.tbHandRankCount[self.nHandRankId] = 0
      end
      self.tbHandRankCount[self.nHandRankId] = self.tbHandRankCount[self.nHandRankId] + 1
      self:ChangeRoundScore(v.Value, v.Ratio, 0, true)
      if type(self.AfterCheckHandRank) == "function" then
        self:AfterCheckHandRank()
      end
      break
    end
  end
end

function PenguinLevel:ChangeRoundScore(nAddValue, nAddRatio, nAddMultiRatio, bFromHandRank)
  local nBeforeScore = self.nRoundScore
  local nBeforeBase = self.nRoundValue
  local nBeforeMultiRatio = self.nRoundMultiRatio
  local nBeforeRatio = self.nRoundRatio
  self.nRoundValue = self.nRoundValue + nAddValue
  if 0 < nAddMultiRatio then
    if self.nRoundMultiRatio == 0 then
      self.nRoundMultiRatio = 1
    end
    self.nRoundMultiRatio = self.nRoundMultiRatio + (nAddMultiRatio - 1)
  end
  self.nRoundRatio = self.nRoundRatio + nAddRatio
  local nBeforeAllRatio = 0 < nBeforeMultiRatio and nBeforeMultiRatio * nBeforeRatio or nBeforeRatio
  local nAfterAllRatio = self.nRoundMultiRatio > 0 and self.nRoundRatio * self.nRoundMultiRatio or self.nRoundRatio
  nBeforeAllRatio = math.floor(nBeforeAllRatio * 100) / 100
  nAfterAllRatio = math.floor(nAfterAllRatio * 100) / 100
  self.nRoundScore = self.nRoundValue * nAfterAllRatio
  local nAddScore = self.nRoundScore - nBeforeScore
  self.nTurnScore = self.nTurnScore + nAddScore
  if self.nTurnScore > self.nBestTurnScore then
    self.nBestTurnScore = self.nTurnScore
  end
  if self.nRoundScore > self.nBestRoundScore then
    self.nBestRoundScore = self.nRoundScore
  end
  EventManager.Hit("PenguinCard_ChangeRoundScore", nBeforeBase, nBeforeAllRatio, nBeforeScore, bFromHandRank)
  if NovaAPI.IsEditorPlatform() then
    printLog("轮积分变化：" .. nAddScore .. "  (" .. nBeforeScore .. " -> " .. self.nRoundScore .. ")")
    printLog("基础变化：" .. nAddValue .. "  (" .. nBeforeBase .. " -> " .. self.nRoundValue .. ")")
    printLog("倍率变化：" .. nAfterAllRatio - nBeforeAllRatio .. "  (" .. nBeforeAllRatio .. " -> " .. nAfterAllRatio .. ")")
  end
end

function PenguinLevel:GetShowedCardCount()
  local nShowed = 0
  for _, v in pairs(self.tbShowedCard) do
    if v then
      nShowed = nShowed + 1
    end
  end
  return nShowed
end

function PenguinLevel:ReplaceBaseCard(nIndex, nBeforeId, mapAfter)
  local tbId, tbWeight = {}, {}
  for k, v in pairs(mapAfter) do
    table.insert(tbId, tonumber(k))
    table.insert(tbWeight, tonumber(v))
  end
  local tbAfter = PenguinCardUtils.WeightedRandom(tbId, tbWeight, 1)
  local nAfterId = tbAfter[1]
  local mapBeforeCfg = ConfigTable.GetData("PenguinBaseCard", nBeforeId)
  local mapAfterCfg = ConfigTable.GetData("PenguinBaseCard", nAfterId)
  if not mapBeforeCfg or not mapAfterCfg then
    return
  end
  for i = 1, 3 do
    local nSuit = mapBeforeCfg["Suit" .. i]
    local nCount = mapBeforeCfg["SuitCount" .. i]
    if 0 < nSuit and 0 < nCount then
      self.mapAllSuit[nSuit] = self.mapAllSuit[nSuit] - nCount
    end
  end
  for i = 1, 3 do
    local nSuit = mapAfterCfg["Suit" .. i]
    local nCount = mapAfterCfg["SuitCount" .. i]
    if 0 < nSuit and 0 < nCount then
      if not self.mapAllSuit[nSuit] then
        self.mapAllSuit[nSuit] = 0
      end
      self.mapAllSuit[nSuit] = self.mapAllSuit[nSuit] + nCount
    end
  end
  local bStone = true
  for i = 1, 3 do
    if mapAfterCfg["Suit" .. i] > 0 and mapAfterCfg["SuitCount" .. i] > 0 then
      bStone = false
      break
    end
  end
  self.tbBaseCardId[nIndex] = nAfterId
  EventManager.Hit("PenguinCard_ReplaceBaseCard", nIndex, bStone)
end

function PenguinLevel:AddSettlementHistory()
  if not self.mapHandRankHistory[self.nHandRankId] then
    self.mapHandRankHistory[self.nHandRankId] = 0
  end
  self.mapHandRankHistory[self.nHandRankId] = self.mapHandRankHistory[self.nHandRankId] + 1
  local HandRankSuitCount = {}
  for _, v in ipairs(self.tbHandRank) do
    if not HandRankSuitCount[v] then
      HandRankSuitCount[v] = 0
    end
    HandRankSuitCount[v] = HandRankSuitCount[v] + 1
    if not self.mapSuitHistory[v] then
      self.mapSuitHistory[v] = 0
    end
    self.mapSuitHistory[v] = self.mapSuitHistory[v] + 1
  end
  return HandRankSuitCount
end

function PenguinLevel:EndTurn()
  local nBuffCount = #self.tbBuff
  for i = nBuffCount, 1, -1 do
    local bAble = self.tbBuff[i]:AddDuration_Turn()
    if not bAble then
      self:DeleteBuff(i)
    end
  end
end

function PenguinLevel:EndRound()
  local nBuffCount = #self.tbBuff
  for i = nBuffCount, 1, -1 do
    local bAble = self.tbBuff[i]:AddDuration_Round()
    if not bAble then
      self:DeleteBuff(i)
    end
  end
end

function PenguinLevel:AddLog()
  if not self.mapLog[self.nCurTurn] then
    self.mapLog[self.nCurTurn] = {
      nTurnScore = 0,
      tbRound = {}
    }
  end
  self.mapLog[self.nCurTurn].nTurnScore = self.nTurnScore
  if not self.mapLog[self.nCurTurn].tbRound[self.nCurRound] then
    self.mapLog[self.nCurTurn].tbRound[self.nCurRound] = {
      nRoundScore = 0,
      tbHandRank = {}
    }
  end
  self.mapLog[self.nCurTurn].tbRound[self.nCurRound].nRoundScore = self.nRoundScore
  self.mapLog[self.nCurTurn].tbRound[self.nCurRound].tbHandRank = clone(self.tbHandRank)
  self.mapLog[self.nCurTurn].tbRound[self.nCurRound].nHandRankId = self.nHandRankId
end

function PenguinLevel:NextRound()
  self:StopAuto()
  if self:GetRoundLimitInTurn() == self.nCurRound and self.nCurTurn < self.nMaxTurn then
    local function callback()
      self:SwitchGameState()
    end
    
    EventManager.Hit("PenguinCard_OpenLog", self.nCurTurn, false, callback)
  else
    self:SwitchGameState()
  end
end

function PenguinLevel:CheckRound()
  if self.nCheckRoundCount >= self:GetCheckRoundLimit() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PenguinCard_CheckRound_TurnFail"))
    return false
  end
  if self.bCheckRound then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PenguinCard_CheckRound_RoundFail"))
    return false
  end
  self.nCheckRoundCount = self.nCheckRoundCount + 1
  self:StopAuto()
  self:RestoreSnapshot()
  self:SwitchGameState()
  return true
end

function PenguinLevel:ChangeCheckRoundLimit(nAura)
  self.nCheckRoundLimitAura = self.nCheckRoundLimitAura + nAura
  EventManager.Hit("PenguinCard_ChangeCheckRoundLimit")
end

function PenguinLevel:GetCheckRoundLimit()
  return self.nCheckRoundLimit + self.nCheckRoundLimitAura
end

function PenguinLevel:GetMostHandRank()
  local nCount = 0
  local nId = 0
  for k, v in pairs(self.mapHandRankHistory) do
    if v > nCount then
      nCount = v
      nId = k
    end
  end
  return nId, nCount
end

function PenguinLevel:GetMostSuit()
  local nCount = 0
  local nId = 0
  for k, v in pairs(self.mapSuitHistory) do
    if v > nCount then
      nCount = v
      nId = k
    end
  end
  return nId, nCount
end

function PenguinLevel:GetBestPenguinCard()
  local nCount = 0
  local mapCard
  for _, v in ipairs(self.tbPenguinCard) do
    if v ~= 0 and nCount < v.nLevel then
      nCount = v.nLevel
      mapCard = v
    end
  end
  return mapCard
end

function PenguinLevel:SetAutoState(bAuto)
  self.bAuto = bAuto
  LocalData.SetPlayerLocalData("PenguinCardAuto", self.bAuto)
end

function PenguinLevel:SetAutoSpeed(nSpeed)
  self.nSpeed = nSpeed
  LocalData.SetPlayerLocalData("PenguinCardSpeed", self.nSpeed)
  if self.sequence then
    self:StopAuto()
    self:PlayAuto()
  end
end

function PenguinLevel:PlayAuto(bClick)
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
      if self:GetRoundLimitInTurn() == self.nCurRound and self.nCurTurn < self.nMaxTurn then
        local function callback()
          self:SwitchGameState()
        end
        
        EventManager.Hit("PenguinCard_OpenLog", self.nCurTurn, false, callback)
      else
        self:SwitchGameState()
      end
    end)
    self.sequence:SetUpdate(true)
  end
end

function PenguinLevel:StopAuto()
  if self.sequence then
    self.sequence:Kill()
    self.sequence = nil
  end
end

function PenguinLevel:Pause()
  self.bPause = true
  if self.sequence then
    self.sequence:Pause()
  end
  EventManager.Hit("PenguinCard_Pause")
end

function PenguinLevel:Resume()
  self.bPause = false
  if self.sequence then
    self.sequence:Play()
  else
    self:PlayAuto()
  end
  EventManager.Hit("PenguinCard_Resume")
end

function PenguinLevel:ChangeScore(nChange)
  if not nChange or nChange == 0 then
    return
  end
  local nBefore = self.nScore
  self.nScore = self.nScore + nChange
  EventManager.Hit("PenguinCard_ChangeScore", nBefore)
  if NovaAPI.IsEditorPlatform() then
    printLog("总积分变化：" .. nChange .. "  (" .. nBefore .. " -> " .. self.nScore .. ")")
  end
end

function PenguinLevel:GetStar()
  local nStar = 0
  for i, v in ipairs(self.tbStarScore) do
    if v <= self.nScore then
      nStar = i
    end
  end
  return nStar
end

function PenguinLevel:GetOwnPenguinCardCount()
  local nCount = 0
  for i = 1, 6 do
    if self.tbPenguinCard[i] ~= 0 then
      nCount = nCount + 1
    end
  end
  return nCount
end

function PenguinLevel:ExecuteEffect(nEffectType, mapEffectValue, mapTriggerSource)
  if nEffectType == GameEnum.PenguinCardEffectType.AddBaseCardWeight then
    self:ChangeBaseCardWeight(mapEffectValue)
  elseif nEffectType == GameEnum.PenguinCardEffectType.ReplaceBaseCard then
    self:ReplaceBaseCard(mapTriggerSource.BaseCard.nIndex, mapTriggerSource.BaseCard.nId, mapEffectValue)
  elseif nEffectType == GameEnum.PenguinCardEffectType.IncreaseBasicChips then
    self:ChangeRoundScore(mapEffectValue, 0, 0)
  elseif nEffectType == GameEnum.PenguinCardEffectType.IncreaseMultiplier then
    self:ChangeRoundScore(0, mapEffectValue, 0)
  elseif nEffectType == GameEnum.PenguinCardEffectType.MultiMultiplier then
    self:ChangeRoundScore(0, 0, mapEffectValue)
  elseif nEffectType == GameEnum.PenguinCardEffectType.UpgradeDiscount then
    self:ChangeUpgradeDiscount(mapEffectValue, 0)
  elseif nEffectType == GameEnum.PenguinCardEffectType.AddRound then
    self:ChangeRoundLimitInTurn(mapEffectValue, 0)
  elseif nEffectType == GameEnum.PenguinCardEffectType.AddCardRollCount then
    self.nTempAddRollCount = self.nTempAddRollCount + mapEffectValue
  elseif nEffectType == GameEnum.PenguinCardEffectType.BlockFatalDamage then
    self:ChangeHp(-1 * mapTriggerSource.nHpChange)
    EventManager.Hit("PenguinCard_BlockFatalDamage")
  elseif nEffectType == GameEnum.PenguinCardEffectType.UpgradeRebate then
    self:ChangeScore(mapTriggerSource.nUpgradeCost * mapEffectValue / 100)
  elseif nEffectType == GameEnum.PenguinCardEffectType.RollSpecificCard then
    self:ChangeSpecificCard(mapEffectValue)
  elseif nEffectType == GameEnum.PenguinCardEffectType.UpgradeDiscountAura then
    self:ChangeUpgradeDiscount(0, mapEffectValue)
  elseif nEffectType == GameEnum.PenguinCardEffectType.CheckRoundAura then
    self:ChangeCheckRoundLimit(mapEffectValue)
  elseif nEffectType == GameEnum.PenguinCardEffectType.AddRoundAura then
    self:ChangeRoundLimitInTurn(0, mapEffectValue)
  elseif nEffectType == GameEnum.PenguinCardEffectType.CardLevel then
    self:ChangeCardLevel(mapEffectValue[1], mapEffectValue[2])
  elseif nEffectType == GameEnum.PenguinCardEffectType.ChangeHp then
    self:ChangeHp(mapEffectValue)
  end
  if type(self.ExecuteModeEffect) == "function" then
    self:ExecuteModeEffect(nEffectType, mapEffectValue, mapTriggerSource)
  end
end

function PenguinLevel:GetAuraFieldMap()
  local mapField = {
    [GameEnum.PenguinCardEffectType.UpgradeDiscountAura] = "nUpgradeDiscountAura",
    [GameEnum.PenguinCardEffectType.CheckRoundAura] = "nCheckRoundLimitAura",
    [GameEnum.PenguinCardEffectType.AddRoundAura] = "nRoundLimitAura"
  }
  if type(self.GetModeAuraFieldMap) == "function" then
    for nEffectType, sField in pairs(self:GetModeAuraFieldMap()) do
      mapField[nEffectType] = sField
    end
  end
  return mapField
end

function PenguinLevel:RefreshAura()
  if self.bRefreshingAura then
    return
  end
  self.bRefreshingAura = true
  local mapFieldMap = self:GetAuraFieldMap()
  local mapCollect = {}
  
  local function collector(nEffectType, mapEffectValue)
    if mapFieldMap[nEffectType] and type(mapEffectValue) == "number" then
      mapCollect[nEffectType] = (mapCollect[nEffectType] or 0) + mapEffectValue
      return true
    end
    return false
  end
  
  self:TriggerEffect(GameEnum.PenguinCardTriggerPhase.Aura, nil, collector)
  for nEffectType, sField in pairs(mapFieldMap) do
    local nNew = mapCollect[nEffectType] or 0
    local nCur = self[sField] or 0
    local nDelta = nNew - nCur
    if nDelta ~= 0 then
      self:ExecuteEffect(nEffectType, nDelta)
    end
  end
  self.bRefreshingAura = false
end

function PenguinLevel:TriggerEffect(nTriggerPhase, mapTriggerSource, fCollector)
  local function callback(nEffectType, mapEffectValue)
    if fCollector and fCollector(nEffectType, mapEffectValue) then
      return
    end
    self:ExecuteEffect(nEffectType, mapEffectValue, mapTriggerSource)
  end
  
  local nBuffCount = #self.tbBuff
  for i = nBuffCount, 1, -1 do
    local bTriggered = self.tbBuff[i]:Trigger(nTriggerPhase, mapTriggerSource, callback)
    if bTriggered then
      local bAble = self.tbBuff[i]:AddDuration_Count()
      if not bAble then
        local nDelayTime = self.tbBuff[i]:GetDelayTime()
        self:DeleteBuff(i, nDelayTime)
      end
    end
  end
  for _, v in ipairs(self.tbPenguinCard) do
    if v ~= 0 then
      v:Trigger(nTriggerPhase, mapTriggerSource, callback)
      v:Growth(nTriggerPhase, mapTriggerSource)
    end
  end
  if type(self.TriggerModeEffect) == "function" then
    self:TriggerModeEffect(nTriggerPhase, mapTriggerSource, callback)
  end
end

function PenguinLevel:SaveSnapshot()
  local mapSnapshot = {
    nCurTurn = self.nCurTurn,
    nCurRound = self.nCurRound,
    nScore = self.nScore,
    nTurnScore = self.nTurnScore,
    tbHandRankCount = clone(self.tbHandRankCount),
    mapLog = clone(self.mapLog),
    nTotalRound = self.nTotalRound,
    nBestTurnScore = self.nBestTurnScore,
    nBestRoundScore = self.nBestRoundScore,
    mapHandRankHistory = clone(self.mapHandRankHistory),
    mapSuitHistory = clone(self.mapSuitHistory),
    nGetPenguinCardCount = self.nGetPenguinCardCount
  }
  local tbBuffSnap = {}
  local tbBuff = self.tbBuff or {}
  for i = 1, #tbBuff do
    tbBuffSnap[i] = tbBuff[i]:Serialize()
  end
  mapSnapshot.tbBuff = tbBuffSnap
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
  mapSnapshot.tbPenguinCard = tbPenguinCardSnap
  if type(self.SaveModeSnapshot) == "function" then
    self:SaveModeSnapshot(mapSnapshot)
  end
  self.mapSnapshot = mapSnapshot
  if self.bRestoreSnapshot == nil then
    self.bRestoreSnapshot = false
  end
end

function PenguinLevel:GetSnapshotState()
  local bRestoreSnapshot = self.bRestoreSnapshot
  self.bRestoreSnapshot = false
  return bRestoreSnapshot == true
end

function PenguinLevel:RestoreSnapshot()
  local mapSnapshot = self.mapSnapshot
  if not mapSnapshot then
    return
  end
  self.nCurTurn = mapSnapshot.nCurTurn
  self.nCurRound = mapSnapshot.nCurRound
  self.nScore = mapSnapshot.nScore
  self.nTurnScore = mapSnapshot.nTurnScore
  self.tbHandRankCount = clone(mapSnapshot.tbHandRankCount)
  self.mapLog = clone(mapSnapshot.mapLog)
  self.nTotalRound = mapSnapshot.nTotalRound
  self.nBestTurnScore = mapSnapshot.nBestTurnScore
  self.nBestRoundScore = mapSnapshot.nBestRoundScore
  self.mapHandRankHistory = clone(mapSnapshot.mapHandRankHistory)
  self.mapSuitHistory = clone(mapSnapshot.mapSuitHistory)
  self.nGetPenguinCardCount = mapSnapshot.nGetPenguinCardCount
  self:ClearRoundData()
  local nBuffCount = #self.tbBuff
  for i = nBuffCount, 1, -1 do
    self:DeleteBuff(i, 0, true)
  end
  for _, mapData in ipairs(mapSnapshot.tbBuff) do
    local mapBuff = self:CreateBuff(mapData.nId)
    mapBuff:Deserialize(mapData)
    self:AddBuff(mapBuff)
  end
  for i = 1, 6 do
    local v = self.tbPenguinCard[i]
    if v ~= 0 and v ~= nil then
      self:RecyclePenguinCard(v)
    end
    local mapData = mapSnapshot.tbPenguinCard[i]
    if mapData == 0 then
      self.tbPenguinCard[i] = 0
    else
      local mapCard = self:CreatePenguinCard(mapData.nId)
      mapCard:Deserialize(mapData)
      self.tbPenguinCard[i] = mapCard
    end
  end
  if type(self.RestoreModeSnapshot) == "function" then
    self:RestoreModeSnapshot(mapSnapshot)
  end
  self.mapSnapshot = nil
  self.bRestoreSnapshot = true
end

return PenguinLevel
