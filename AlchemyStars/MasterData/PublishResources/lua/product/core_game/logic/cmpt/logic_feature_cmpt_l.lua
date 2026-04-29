require("match_message")
_class("LogicFeatureComponent", Object)
LogicFeatureComponent = LogicFeatureComponent

function LogicFeatureComponent:Constructor()
  self._featureDataDic = {}
  self._dayNightData = {}
  self._sanModifyTimes = 0
  self._personaInfo = {}
  self._cardInfo = {}
  self._featureSkillCommon = FeatureSkillCommonData:New()
  self._drawCardRecord = {}
  self._autoFightFirstRoundDrawCardEnough = {}
  self._drawCardWeight = {}
  self._summonTrapSkillID = nil
  self._forceMovementSkillID = nil
  self._summonScanTrapSkillID = nil
  self._skillConfigData = nil
  self._scanActiveSkillType = nil
  self._scanTrapID = nil
  self._shopSelectedList = {}
  self._shopRecentSelectedList = {}
  self._shopCoinCount = 0
  self._curStepPoint = 0
  self._maxStepPoint = 0
  self._recoverStepPoint = 0
  self._recordRecentMoveCostStepPoint = 0
  self._banPetSkillCastRoundList = {}
  self._banPetSkillCastLastRound = 0
  self._maxAUOverloadEnergy = 0
  self._alchemyAP = 0
  self._alchemyLevel = 0
  self._alchemyLevelMax = 5
  self._tetrisPower = 0
  self._tetrisType = 1
  self._tetrisIndex = 1
  self._tetrisDirIndex = 0
  self._tetrisLock = false
end

function LogicFeatureComponent:AddFeatureData(featureType, featureData)
  self._featureDataDic[featureType] = featureData
end

function LogicFeatureComponent:GetFeatureData(featureType)
  return self._featureDataDic[featureType]
end

function LogicFeatureComponent:GetFeatureTypeList()
  local typeList = {}
  for k, v in pairs(self._featureDataDic) do
    table.insert(typeList, k)
  end
  return typeList
end

function LogicFeatureComponent:RemoveFeatureData(featureType)
  for k, v in pairs(self._featureDataDic) do
    if k == featureType then
      self._featureDataDic[featureType] = nil
    end
  end
end

function LogicFeatureComponent:RecordModifySanTimes()
  self._sanModifyTimes = self._sanModifyTimes + 1
  return self._sanModifyTimes
end

function LogicFeatureComponent:GetModifySanTimes()
  return self._sanModifyTimes
end

function LogicFeatureComponent:SetDayNightData(state, restRound)
  self._dayNightData.state = state
  self._dayNightData.restRound = restRound
end

function LogicFeatureComponent:GetDayNightData()
  return self._dayNightData.state, self._dayNightData.restRound
end

function LogicFeatureComponent:SetDayNightIgnoreFirstRoundCheck(bIgnore)
  self._dayNightData.ignoreFirstRoundCheck = bIgnore
end

function LogicFeatureComponent:GetDayNightIgnoreFirstRoundCheck()
  return self._dayNightData.ignoreFirstRoundCheck
end

function LogicFeatureComponent:SetPersonaPetCount(petCount)
  self._personaInfo.petCount = petCount
end

function LogicFeatureComponent:GetPersonaPetCount()
  return self._personaInfo.petCount
end

function LogicFeatureComponent:SetCardSkillDic(skillDic)
  self._cardInfo.skillDic = skillDic
end

function LogicFeatureComponent:GetCardSkillDic()
  return self._cardInfo.SkillDic
end

function LogicFeatureComponent:GetCardSkillID(index)
  return self._cardInfo.SkillDic[index]
end

function LogicFeatureComponent:ClearCards()
  self._cardInfo.Cards = {}
end

function LogicFeatureComponent:SetCardMax(maxCount)
  self._cardInfo.MaxCount = maxCount or 0
end

function LogicFeatureComponent:GetCardMax()
  return self._cardInfo.MaxCount
end

function LogicFeatureComponent:GetCurCardCount()
  local total = 0
  if self._cardInfo.Cards then
    for k, v in pairs(self._cardInfo.Cards) do
      total = total + v
    end
  end
  return total
end

function LogicFeatureComponent:CanAddCard()
  local canDraw = self:GetCurCardCount() < self:GetCardMax()
  return canDraw
end

function LogicFeatureComponent:AddCard(cardType)
  if not self._cardInfo.Cards then
    self._cardInfo.Cards = {}
  end
  if not self:CanAddCard() then
    return
  end
  if not self._cardInfo.Cards[cardType] then
    self._cardInfo.Cards[cardType] = 0
  end
  self._cardInfo.Cards[cardType] = self._cardInfo.Cards[cardType] + 1
end

function LogicFeatureComponent:GetCards()
  if not self._cardInfo.Cards then
    self._cardInfo.Cards = {}
  end
  return self._cardInfo.Cards
end

function LogicFeatureComponent:CostCard(useCards)
  if not self._cardInfo.Cards then
    self._cardInfo.Cards = {}
  end
  if useCards and 0 < #useCards then
    for i, v in ipairs(useCards) do
      local old = self._cardInfo.Cards[v]
      local cur = old - 1
      if cur < 0 then
        cur = 0
      end
      self._cardInfo.Cards[v] = cur
    end
  end
end

function LogicFeatureComponent:RecordDrawCard(teamEntityID, curRound, cardType)
  if self._drawCardRecord then
    if not self._drawCardRecord[teamEntityID] then
      self._drawCardRecord[teamEntityID] = {}
    end
    local teamRecord = self._drawCardRecord[teamEntityID]
    if not teamRecord[curRound] then
      teamRecord[curRound] = {}
    end
    local defaultWeightNum = 5
    local weightIncreaseNum = 1
    local featureData = self:GetFeatureData(FeatureType.Card)
    if featureData then
      defaultWeightNum = featureData:GetDefaultWeightNum()
      weightIncreaseNum = featureData:GetWeightIncreaseNum()
    end
    local roundRecord = teamRecord[curRound]
    table.insert(roundRecord, cardType)
    if self._drawCardWeight then
      if not self._drawCardWeight[teamEntityID] then
        self._drawCardWeight[teamEntityID] = {
          defaultWeightNum,
          defaultWeightNum,
          defaultWeightNum
        }
      end
      local weightTb = self._drawCardWeight[teamEntityID]
      for weightCard, weight in ipairs(weightTb) do
        if cardType == weightCard then
          weightTb[weightCard] = defaultWeightNum
        else
          weightTb[weightCard] = weight + weightIncreaseNum
        end
      end
    end
  end
end

function LogicFeatureComponent:GetDrawCardTimes(teamEntityID, round)
  if not teamEntityID then
    return
  end
  if round then
    local teamRecord = self._drawCardRecord[teamEntityID]
    if teamRecord then
      local roundRecord = teamRecord[round]
      if roundRecord then
        return #roundRecord
      end
    end
  else
    local teamRecord = self._drawCardRecord[teamEntityID]
    if teamRecord then
      local totalTimes = 0
      for round, records in pairs(teamRecord) do
        totalTimes = totalTimes + #records
      end
      return totalTimes
    end
  end
  return 0
end

function LogicFeatureComponent:SetAutoFightFirstRoundDrawCardEnough(teamEntityID, bEnough)
  self._autoFightFirstRoundDrawCardEnough[teamEntityID] = bEnough
end

function LogicFeatureComponent:GetAutoFightFirstRoundDrawCardEnough(teamEntityID)
  return self._autoFightFirstRoundDrawCardEnough[teamEntityID]
end

function LogicFeatureComponent:GetRandomDrawCardWeight(teamEntityID)
  local defaultWeightNum = 5
  local featureData = self:GetFeatureData(FeatureType.Card)
  if featureData then
    defaultWeightNum = featureData:GetDefaultWeightNum()
  end
  if self._drawCardWeight then
    if not self._drawCardWeight[teamEntityID] then
      self._drawCardWeight[teamEntityID] = {
        defaultWeightNum,
        defaultWeightNum,
        defaultWeightNum
      }
    end
    return self._drawCardWeight[teamEntityID]
  end
  return {
    defaultWeightNum,
    defaultWeightNum,
    defaultWeightNum
  }
end

function LogicFeatureComponent:InitScanFeature(summonTrapSkillID, forceMovementSkillID, summonScanTrapSkillID, emptySkillID)
  self._summonTrapSkillID = summonTrapSkillID
  self._forceMovementSkillID = forceMovementSkillID
  self._summonScanTrapSkillID = summonScanTrapSkillID
  self._emptySkillID = emptySkillID
  self._scanActiveSkillType = ScanFeatureActiveSkillType.SummonTrap
end

function LogicFeatureComponent:GetScanSummonTrapSkillID()
  return self._summonTrapSkillID
end

function LogicFeatureComponent:GetScanForceMovementSkillID()
  return self._forceMovementSkillID
end

function LogicFeatureComponent:GetScanSummonScanTrapSkillID()
  return self._summonScanTrapSkillID
end

function LogicFeatureComponent:GetScanEmptySkillID()
  return self._summonScanTrapSkillID
end

function LogicFeatureComponent:ClearLastScan()
  self._skillConfigData = nil
  self._scanActiveSkillType = nil
  self._scanTrapID = nil
end

function LogicFeatureComponent:SetActiveSkillConfigData(data)
  self._skillConfigData = data
end

function LogicFeatureComponent:GetActiveSkillConfigData()
  return self._skillConfigData
end

function LogicFeatureComponent:SetScanResult(skillType, trapID)
  self._scanActiveSkillType = skillType
  self._scanTrapID = trapID
end

function LogicFeatureComponent:GetScanActiveSkillType()
  return self._scanActiveSkillType
end

function LogicFeatureComponent:GetScanTrapID()
  return self._scanTrapID
end

function LogicFeatureComponent:GetShopSelectedCellList()
  return self._shopSelectedList
end

function LogicFeatureComponent:AddShopSelectedCellList(cellList)
  if cellList then
    table.appendArray(self._shopSelectedList, cellList)
  end
end

function LogicFeatureComponent:GetShopRecentSelectedCellList()
  return self._shopRecentSelectedList
end

function LogicFeatureComponent:SetShopRecentSelectedCellList(cellList)
  self._shopRecentSelectedList = cellList
end

function LogicFeatureComponent:ClearShopRecentSelectedCellList()
  self._shopRecentSelectedList = {}
end

function LogicFeatureComponent:GetShopCoinCount()
  return self._shopCoinCount or 0
end

function LogicFeatureComponent:AddShopCoinCount(addVal)
  self._shopCoinCount = self._shopCoinCount + addVal
  self._shopCoinCount = math.max(0, self._shopCoinCount)
end

function LogicFeatureComponent:GetShopUIHadSeeUnlockCellList()
  return self._shopUIHadSeeUnlockCellList
end

function LogicFeatureComponent:SetShopUIHadSeeUnlockCellList(cellList)
  self._shopUIHadSeeUnlockCellList = cellList
end

function LogicFeatureComponent:InitStepPointParam(initStepPoint, maxStepPoint, recoverStepPoint)
  self._curStepPoint = initStepPoint
  self._maxStepPoint = maxStepPoint
  self._recoverStepPoint = recoverStepPoint
end

function LogicFeatureComponent:GetCurStepPoint()
  return self._curStepPoint or 0
end

function LogicFeatureComponent:ChangeCurStepPoint(addVal)
  self._curStepPoint = self._curStepPoint + addVal
  self._curStepPoint = math.max(0, self._curStepPoint)
  self._curStepPoint = math.min(self._curStepPoint, self._maxStepPoint)
end

function LogicFeatureComponent:GetMaxStepPoint()
  return self._maxStepPoint or 0
end

function LogicFeatureComponent:ChangeMaxStepPoint(addVal)
  self._maxStepPoint = self._maxStepPoint + addVal
  self._maxStepPoint = math.max(0, self._maxStepPoint)
  self._curStepPoint = math.min(self._curStepPoint, self._maxStepPoint)
end

function LogicFeatureComponent:GetRecoverStepPoint()
  return self._recoverStepPoint or 0
end

function LogicFeatureComponent:ChangeRecoverStepPoint(addVal)
  self._recoverStepPoint = self._recoverStepPoint + addVal
  self._recoverStepPoint = math.max(0, self._recoverStepPoint)
end

function LogicFeatureComponent:RecordRecentMoveCostStepPoint(costVal)
  self._recordRecentMoveCostStepPoint = costVal
end

function LogicFeatureComponent:GetRecentMoveCostStepPoint()
  return self._recordRecentMoveCostStepPoint
end

function LogicFeatureComponent:AddBanPetSkillCastRound(skillID, round)
  if not self._banPetSkillCastRoundList[skillID] then
    self._banPetSkillCastRoundList[skillID] = {}
  end
  table.insert(self._banPetSkillCastRoundList[skillID], round)
  self._banPetSkillCastLastRound = round
end

function LogicFeatureComponent:GetBanPetSkillCastRoundList()
  return self._banPetSkillCastRoundList
end

function LogicFeatureComponent:GetBanPetSkillCastLastRound()
  return self._banPetSkillCastLastRound
end

function LogicFeatureComponent:SetMaxAUOEValue(maxValue)
  self._maxAUOverloadEnergy = maxValue
end

function LogicFeatureComponent:GetMaxAUOEValue()
  return self._maxAUOverloadEnergy
end

function LogicFeatureComponent:InitTetris(tetrisDir, tetrisType, costPower)
  self._tetrisPower = 0
  self._tetrisType = tetrisType
  self._tetrisIndex = 1
  self._tetrisDirIndex = 1
  self._tetrisDir = tetrisDir
  self._tetrisLock = false
  self._tetrisCostPower = costPower
  self._tetrisMainColorCount = 0
end

function LogicFeatureComponent:SetTetrisMainColorCount(count)
  self._tetrisMainColorCount = count
end

function LogicFeatureComponent:GetTetrisMainColorCount()
  return self._tetrisMainColorCount
end

function LogicFeatureComponent:GetTetrisDirIndex()
  return self._tetrisDirIndex
end

function LogicFeatureComponent:SetTetrisDir(index, dir)
  self._tetrisDirIndex = index
  self._tetrisDir = dir
end

function LogicFeatureComponent:GetTetrisDir()
  return self._tetrisDir
end

function LogicFeatureComponent:GetTetrisPower()
  return self._tetrisPower
end

function LogicFeatureComponent:SetTetrisPower(power)
  self._tetrisPower = power
end

function LogicFeatureComponent:GetTetrisIndex()
  return self._tetrisIndex
end

function LogicFeatureComponent:SetTetrisType(index, tetrisType)
  self._tetrisIndex = index
  self._tetrisType = tetrisType
end

function LogicFeatureComponent:GetTetrisType()
  return self._tetrisType
end

function LogicFeatureComponent:SetTetrisLock(lock)
  self._tetrisLock = lock
end

function LogicFeatureComponent:GetTetrisLock()
  return self._tetrisLock
end

function LogicFeatureComponent:SetTetrisCostPower(costPower)
  self._tetrisCostPower = costPower
end

function LogicFeatureComponent:GetTetrisCostPower()
  return self._tetrisCostPower
end

_class("FeatureSkillCommonData", Object)
FeatureSkillCommonData = FeatureSkillCommonData

function FeatureSkillCommonData:Constructor()
  self.featureSkillID = {}
  self.skillHolderDic = {}
  self.powerInfo = {}
  self.lastRoundInfo = {}
  self.featureSkillCdOff = 0
  self.specificFeatureSkillCdOff = {}
end

_class("FeatureSkillCommonPowerData", Object)
FeatureSkillCommonPowerData = FeatureSkillCommonPowerData

function FeatureSkillCommonPowerData:Constructor()
  self.power = 0
  self.ready = 0
  self.delayModifyPowerValue = 0
  self.featureType = 0
end

function LogicFeatureComponent:SetFeatureSkillID(featureType, skillID)
  self._featureSkillCommon.featureSkillID[featureType] = skillID
end

function LogicFeatureComponent:GetFeatureSkillID(featureType)
  return self._featureSkillCommon.featureSkillID[featureType]
end

function LogicFeatureComponent:SetFeatureSkillHolderID(featureType, holderID)
  self._featureSkillCommon.skillHolderDic[featureType] = holderID
end

function LogicFeatureComponent:GetFeatureSkillHolderID(featureType)
  return self._featureSkillCommon.skillHolderDic[featureType]
end

function LogicFeatureComponent:SetFeatureSkillCurPower(featureType, power, ready)
  if not self._featureSkillCommon.powerInfo[featureType] then
    self._featureSkillCommon.powerInfo[featureType] = FeatureSkillCommonPowerData:New()
  end
  local featurePower = self._featureSkillCommon.powerInfo[featureType]
  featurePower.power = power
  if ready then
    featurePower.ready = ready
  end
end

function LogicFeatureComponent:GetFeatureSkillCurPower(featureType)
  if self._featureSkillCommon.powerInfo then
    local featurePower = self._featureSkillCommon.powerInfo[featureType]
    if featurePower then
      return featurePower.power, featurePower.ready
    end
  end
  return 5, 0
end

function LogicFeatureComponent:SetFeatureSkillDelayModifyPower(featureType, delayModifyPower)
  if not self._featureSkillCommon.powerInfo[featureType] then
    self._featureSkillCommon.powerInfo[featureType] = FeatureSkillCommonPowerData:New()
  end
  local featurePower = self._featureSkillCommon.powerInfo[featureType]
  featurePower.delayModifyPowerValue = delayModifyPower
end

function LogicFeatureComponent:GetFeatureSkillDelayModifyPower(featureType)
  if self._featureSkillCommon.powerInfo then
    local featurePower = self._featureSkillCommon.powerInfo[featureType]
    if featurePower then
      return featurePower.delayModifyPowerValue
    end
  end
  return 0
end

function LogicFeatureComponent:GetLastDoFeatureSkillRound(featureType)
  if not self._featureSkillCommon.lastRoundInfo then
    self._featureSkillCommon.lastRoundInfo = {}
  end
  return self._featureSkillCommon.lastRoundInfo[featureType]
end

function LogicFeatureComponent:SetLastDoFeatureSkillRound(featureType, round)
  if not self._featureSkillCommon.lastRoundInfo then
    self._featureSkillCommon.lastRoundInfo = {}
  end
  self._featureSkillCommon.lastRoundInfo[featureType] = round
end

function LogicFeatureComponent:SetAllFeatureSkillCdOff(cdOff)
  self._featureSkillCommon.featureSkillCdOff = cdOff
end

function LogicFeatureComponent:GetAllFeatureSkillCdOff()
  return self._featureSkillCommon.featureSkillCdOff
end

function LogicFeatureComponent:SetSpecificFeatureSkillCdOff(featureType, cdOff)
  self._featureSkillCommon.specificFeatureSkillCdOff[featureType] = cdOff
end

function LogicFeatureComponent:GetSpecificFeatureSkillCdOff(featureType)
  if self._featureSkillCommon.specificFeatureSkillCdOff[featureType] then
    return self._featureSkillCommon.specificFeatureSkillCdOff[featureType]
  end
  return 0
end

function LogicFeatureComponent:AddAlchemyAP(ap)
  self._alchemyAP = self._alchemyAP + ap
  return self._alchemyAP
end

function LogicFeatureComponent:GetAlchemyAP()
  return self._alchemyAP
end

function LogicFeatureComponent:SetAlchemyLevel(level)
  self._alchemyLevel = level
end

function LogicFeatureComponent:GetAlchemyLevel()
  return self._alchemyLevel
end

function LogicFeatureComponent:SetAlchemyLevelMax(levelMax)
  self._alchemyLevelMax = levelMax
end

function LogicFeatureComponent:GetAlchemyLevelMax()
  return self._alchemyLevelMax
end

function LogicFeatureComponent:WEC_PostInitialize(owner)
end

function LogicFeatureComponent:WEC_PostRemoved()
end

function Entity:LogicFeature()
  return self:GetComponent(self.WEComponentsEnum.LogicFeature)
end

function Entity:HasLogicFeature()
  return self:HasComponent(self.WEComponentsEnum.LogicFeature)
end

function Entity:AddLogicFeature()
  local index = self.WEComponentsEnum.LogicFeature
  local component = LogicFeatureComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceLogicFeature()
  local index = self.WEComponentsEnum.LogicFeature
  local component = LogicFeatureComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveLogicFeature()
  if self:HasLogicFeature() then
    self:RemoveComponent(self.WEComponentsEnum.LogicFeature)
  end
end
