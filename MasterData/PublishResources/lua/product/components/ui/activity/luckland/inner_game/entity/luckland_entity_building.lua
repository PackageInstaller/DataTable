_class("LLEntityBuilding", LuckLandEntity)
LLEntityBuilding = LLEntityBuilding

function LLEntityBuilding:InitData(templateID)
  self._entityType = LuckLandEntityType.Building
  local cfgData = self._configMng:GetBuildingConfigData(templateID)
  self._cfg = cfgData
  self._type = cfgData:GetBuildingType()
  self._countDown = cfgData:GetCountDown()
  self:_InitBuildingBaseData(self._cfg)
end

function LLEntityBuilding:_InitBuildingBaseData(cfgData)
  self._level = cfgData:GetBuildingLevel()
  self._maxLevel = cfgData:GetMaxLevel()
  self._upgradeCost = cfgData:GetUpgradeCost()
  self._cardPool = cfgData:GetCardPool()
  if self._type == LuckLandBuildingType.CampFire then
    self._posList = table.shallowcopy(LuckLandConst.MorningPosList)
    table.appendArray(self._posList, LuckLandConst.MiddayPosList)
    local unlockPosList = cfgData:GetPosList()
    if unlockPosList then
      table.appendArray(self._posList, unlockPosList)
    end
  end
  self._defRate = cfgData:GetDefRate()
  self._maxHPIncreaseParam = cfgData:GetMaxHPIncreaseParam()
end

function LLEntityBuilding:GetBuildingType()
  return self._type
end

function LLEntityBuilding:GetCardPool()
  return self._cardPool
end

function LLEntityBuilding:GetPosCount()
  if not self._posList then
    return
  end
  return #self._posList
end

function LLEntityBuilding:GetPosList()
  return self._posList or {}
end

function LLEntityBuilding:GetDefRate()
  return self._defRate
end

function LLEntityBuilding:GetMaxHPIncreaseParam()
  return self._maxHPIncreaseParam
end

function LLEntityBuilding:GetUpgradeCost()
  return self._upgradeCost
end

function LLEntityBuilding:Upgrade()
  local templateID = self:GetTemplateID() + 1
  local cfgData = self._configMng:GetBuildingConfigData(templateID)
  self._cfg = cfgData
  self:_InitBuildingBaseData(self._cfg)
  self:SetTemplateID(templateID)
end
