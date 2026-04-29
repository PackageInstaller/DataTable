local BuffChangeFeatureStepPointType = {Value = 1, ByLayer = 2}
_enum("BuffChangeFeatureStepPointType", BuffChangeFeatureStepPointType)
_class("BuffLogicChangeFeatureStepPoint", BuffLogicBase)
BuffLogicChangeFeatureStepPoint = BuffLogicChangeFeatureStepPoint

function BuffLogicChangeFeatureStepPoint:Constructor(buffInstance, logicParam)
  self._modifyValue = logicParam.modifyValue or 0
  self._modifyType = logicParam.modifyType or BuffChangeFeatureStepPointType.Value
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
end

function BuffLogicChangeFeatureStepPoint:DoLogic(notify)
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if not lsvcFeature:HasFeatureType(FeatureType.StepPoint) then
    return
  end
  local modifyValue = self._modifyValue
  if self._modifyType == BuffChangeFeatureStepPointType.Value then
    modifyValue = self._modifyValue
  elseif self._modifyType == BuffChangeFeatureStepPointType.ByLayer then
    local layerEntity = self._entity
    local curMarkLayer = self._buffLogicService:GetBuffLayer(layerEntity, self._layerType)
    if curMarkLayer then
      modifyValue = modifyValue * curMarkLayer
    else
      modifyValue = 0
    end
  end
  local oldCount = lsvcFeature:GetCurStepPoint()
  lsvcFeature:ChangeCurStepPoint(modifyValue)
  local curCount = lsvcFeature:GetCurStepPoint()
  local buffResult = BuffResultChangeFeatureStepPoint:New(curCount, oldCount, modifyValue)
  return buffResult
end

function BuffLogicChangeFeatureStepPoint:DoOverlap()
  return self:DoLogic()
end

_class("BuffLogicChangeFeatureMaxStepPoint", BuffLogicBase)
BuffLogicChangeFeatureMaxStepPoint = BuffLogicChangeFeatureMaxStepPoint

function BuffLogicChangeFeatureMaxStepPoint:Constructor(buffInstance, logicParam)
  self._modifyValue = logicParam.modifyValue or 0
end

function BuffLogicChangeFeatureMaxStepPoint:DoLogic(notify)
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if not lsvcFeature:HasFeatureType(FeatureType.StepPoint) then
    return
  end
  local modifyValue = self._modifyValue
  local oldCount = lsvcFeature:GetMaxStepPoint()
  lsvcFeature:ChangeMaxStepPoint(modifyValue)
  local curCount = lsvcFeature:GetMaxStepPoint()
  local buffResult = BuffResultChangeFeatureMaxStepPoint:New(curCount, oldCount, modifyValue)
  return buffResult
end

function BuffLogicChangeFeatureMaxStepPoint:DoOverlap()
  return self:DoLogic()
end

_class("BuffLogicChangeFeatureRecoverStepPoint", BuffLogicBase)
BuffLogicChangeFeatureRecoverStepPoint = BuffLogicChangeFeatureRecoverStepPoint

function BuffLogicChangeFeatureRecoverStepPoint:Constructor(buffInstance, logicParam)
  self._modifyValue = logicParam.modifyValue or 0
end

function BuffLogicChangeFeatureRecoverStepPoint:DoLogic(notify)
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if not lsvcFeature:HasFeatureType(FeatureType.StepPoint) then
    return
  end
  local modifyValue = self._modifyValue
  local oldCount = lsvcFeature:GetRecoverStepPoint()
  lsvcFeature:ChangeRecoverStepPoint(modifyValue)
  local curCount = lsvcFeature:GetRecoverStepPoint()
  local buffResult = BuffResultChangeFeatureRecoverStepPoint:New(curCount, oldCount, modifyValue)
  return buffResult
end

function BuffLogicChangeFeatureRecoverStepPoint:DoOverlap()
  return self:DoLogic()
end

_class("BuffLogicChangeFeatureRecoverStepPointForLinkUI", BuffLogicBase)
BuffLogicChangeFeatureRecoverStepPointForLinkUI = BuffLogicChangeFeatureRecoverStepPointForLinkUI

function BuffLogicChangeFeatureRecoverStepPointForLinkUI:Constructor(buffInstance, logicParam)
  self._isRevert = logicParam.isRevert or 0
  self._modifyValue = logicParam.modifyValue or 0
  self._stepMin = logicParam.stepMin or 0
  self._stepMax = logicParam.stepMax or 0
end

function BuffLogicChangeFeatureRecoverStepPointForLinkUI:DoLogic(notify)
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if not lsvcFeature:HasFeatureType(FeatureType.StepPoint) then
    return
  end
  local buffSeqID = self:GetBuffSeq()
  local modifyValue = self._modifyValue
  local buffResult = BuffResultChangeFeatureRecoverStepPointForLinkUI:New(buffSeqID, self._isRevert, self._stepMin, self._stepMax, modifyValue)
  return buffResult
end

function BuffLogicChangeFeatureRecoverStepPointForLinkUI:DoOverlap()
  return self:DoLogic()
end
