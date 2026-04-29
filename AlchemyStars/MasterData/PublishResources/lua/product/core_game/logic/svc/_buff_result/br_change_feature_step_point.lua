_class("BuffResultChangeFeatureStepPoint", BuffResultBase)
BuffResultChangeFeatureStepPoint = BuffResultChangeFeatureStepPoint

function BuffResultChangeFeatureStepPoint:Constructor(curCount, oldCount, modifyValue)
  self._curCount = curCount
  self._oldCount = oldCount
  self._modifyValue = modifyValue
end

function BuffResultChangeFeatureStepPoint:GetCurCount()
  return self._curCount
end

function BuffResultChangeFeatureStepPoint:GetOldCount()
  return self._oldCount
end

function BuffResultChangeFeatureStepPoint:GetModifyValue()
  return self._modifyValue
end

_class("BuffResultChangeFeatureMaxStepPoint", BuffResultBase)
BuffResultChangeFeatureMaxStepPoint = BuffResultChangeFeatureMaxStepPoint

function BuffResultChangeFeatureMaxStepPoint:Constructor(curCount, oldCount, modifyValue)
  self._curCount = curCount
  self._oldCount = oldCount
  self._modifyValue = modifyValue
end

function BuffResultChangeFeatureMaxStepPoint:GetCurCount()
  return self._curCount
end

function BuffResultChangeFeatureMaxStepPoint:GetOldCount()
  return self._oldCount
end

function BuffResultChangeFeatureMaxStepPoint:GetModifyValue()
  return self._modifyValue
end

_class("BuffResultChangeFeatureRecoverStepPoint", BuffResultBase)
BuffResultChangeFeatureRecoverStepPoint = BuffResultChangeFeatureRecoverStepPoint

function BuffResultChangeFeatureRecoverStepPoint:Constructor(curCount, oldCount, modifyValue)
  self._curCount = curCount
  self._oldCount = oldCount
  self._modifyValue = modifyValue
end

function BuffResultChangeFeatureRecoverStepPoint:GetCurCount()
  return self._curCount
end

function BuffResultChangeFeatureRecoverStepPoint:GetOldCount()
  return self._oldCount
end

function BuffResultChangeFeatureRecoverStepPoint:GetModifyValue()
  return self._modifyValue
end

_class("BuffResultChangeFeatureRecoverStepPointForLinkUI", BuffResultBase)
BuffResultChangeFeatureRecoverStepPointForLinkUI = BuffResultChangeFeatureRecoverStepPointForLinkUI

function BuffResultChangeFeatureRecoverStepPointForLinkUI:Constructor(flagID, isRevert, stepMin, stepMax, modifyValue)
  self._flagID = flagID
  self._isRevert = isRevert
  self._stepMin = stepMin
  self._stepMax = stepMax
  self._modifyValue = modifyValue
end

function BuffResultChangeFeatureRecoverStepPointForLinkUI:GetFlagID()
  return self._flagID
end

function BuffResultChangeFeatureRecoverStepPointForLinkUI:GetIsRevert()
  return self._isRevert
end

function BuffResultChangeFeatureRecoverStepPointForLinkUI:GetStepMin()
  return self._stepMin
end

function BuffResultChangeFeatureRecoverStepPointForLinkUI:GetStepMax()
  return self._stepMax
end

function BuffResultChangeFeatureRecoverStepPointForLinkUI:GetModifyValue()
  return self._modifyValue
end
