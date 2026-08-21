require("feature_svc_l")

function FeatureServiceLogic:_HandleInitFeature_AlgorithmUpgrade(featureData)
  local param = featureData
  local value = 0
  local smSvc = self:GetService("SeasonMaze")
  if smSvc then
    value = smSvc:GetInitAUOEValue()
  end
  local boardEntity = self._world:GetBoardEntity()
  local attComponent = boardEntity:Attributes()
  if attComponent then
    local enterValue = param:GetEnterValue() + value
    attComponent:Modify("OverloadEnergy", enterValue)
  end
end

function FeatureServiceLogic:GetAUOEValue()
  local value = 0
  local boardEntity = self._world:GetBoardEntity()
  local attComponent = boardEntity:Attributes()
  if attComponent then
    value = attComponent:GetAttribute("OverloadEnergy")
  end
  return value
end

function FeatureServiceLogic:SetAUOEValue(value)
  local final = value
  local max = self:GetMaxAUOEValue()
  local min = self:GetMinAUOEValue()
  if final > max then
    final = max
  end
  if min > final then
    final = min
  end
  local boardEntity = self._world:GetBoardEntity()
  local attComponent = boardEntity:Attributes()
  if attComponent then
    attComponent:Modify("OverloadEnergy", final)
  end
end

function FeatureServiceLogic:ModifyAUOEValue(modifyValue)
  if 0 <= modifyValue then
    return self:IncreaseAUOEValue(modifyValue)
  else
    return self:DecreaseAUOEValue(-modifyValue)
  end
end

function FeatureServiceLogic:IncreaseAUOEValue(increaseValue)
  local old = self:GetAUOEValue()
  local max = self:GetMaxAUOEValue()
  local realModifyValue = increaseValue
  local final = old + increaseValue
  if max < final then
    final = max
  end
  realModifyValue = final - old
  self:SetAUOEValue(final)
  return final, old, realModifyValue
end

function FeatureServiceLogic:DecreaseAUOEValue(decreaseValue)
  local old = self:GetAUOEValue()
  local min = self:GetMinAUOEValue()
  local realModifyValue = decreaseValue
  local final = old - decreaseValue
  if min > final then
    final = min
  end
  realModifyValue = final - old
  self:SetAUOEValue(final)
  return final, old, realModifyValue
end

function FeatureServiceLogic:GetMaxAUOEValue()
  local maxVal = 0
  local featureCmpt = self:GetLogicCmpt()
  if featureCmpt then
    maxVal = featureCmpt:GetMaxAUOEValue()
  end
  if 0 < maxVal then
    return maxVal
  end
  local featureData = self:GetFeatureData(FeatureType.AlgorithmUpgrade)
  if featureData then
    maxVal = featureData:GetMaxValue()
    return maxVal
  end
  return 100
end

function FeatureServiceLogic:GetMinAUOEValue()
  local featureData = self:GetFeatureData(FeatureType.AlgorithmUpgrade)
  if featureData then
    local minVal = featureData:GetMinValue()
    return minVal
  end
  return 0
end

function FeatureServiceLogic:SetMaxAUOEValue(maxValue)
  local featureCmpt = self:GetLogicCmpt()
  if featureCmpt then
    featureCmpt:SetMaxAUOEValue(maxValue)
  end
end

function FeatureServiceLogic:GetFeatureAUActiveRelics()
  local activeRelics = {}
  local featureData = self:GetFeatureData(FeatureType.AlgorithmUpgrade)
  if featureData then
    local cfgRelicIDList = featureData:GetRelicIDList()
    local smSvc = self:GetService("SeasonMaze")
    if not smSvc then
      return activeRelics
    end
    local curRelicIDList = smSvc:GetAllRelic()
    for _, relicID in ipairs(cfgRelicIDList) do
      if table.icontains(curRelicIDList, relicID) then
        table.insert(activeRelics, relicID)
      end
    end
  end
  return activeRelics
end

function FeatureServiceLogic:GetFeatureAUOverloadEnergyInfo()
  local maxValue = self:GetMaxAUOEValue()
  local curValue = self:GetAUOEValue()
  return maxValue, curValue
end
