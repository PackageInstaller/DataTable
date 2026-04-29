_class("LLBuildingConfigData", Object)
LLBuildingConfigData = LLBuildingConfigData

function LLBuildingConfigData:Constructor(ID)
  self._cfg = Cfg.cfg_luckland_client_build[ID]
  if not self._cfg then
    Log.fatal("LLBuildingConfigData not find building, ID:", ID)
  end
end

function LLBuildingConfigData:GetBuildingID()
  return self._cfg.ID
end

function LLBuildingConfigData:GetBuildingLevel()
  local buildingID = self:GetBuildingID()
  local level = buildingID % 100
  return level
end

function LLBuildingConfigData:GetBuildingType()
  return self._cfg.BuildType
end

function LLBuildingConfigData:GetMaxLevel()
  return self._cfg.MaxLevel
end

function LLBuildingConfigData:GetUpgradeCost()
  return self._cfg.UpgradeCost
end

function LLBuildingConfigData:GetBuffIDList()
  return self._cfg.BuffIDList
end

function LLBuildingConfigData:GetCountDown()
  return self._cfg.CountDown
end

function LLBuildingConfigData:GetCardPool()
  return self._cfg.CardPool
end

function LLBuildingConfigData:GetPosList()
  return self._cfg.PosList
end

function LLBuildingConfigData:GetDefRate()
  return self._cfg.DefRate
end

function LLBuildingConfigData:GetMaxHPIncreaseParam()
  return self._cfg.MaxHPIncreaseParam
end
