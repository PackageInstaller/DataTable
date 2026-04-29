_class("BuffLogicChangeAdditionalCritProbBySan", BuffLogicBase)
BuffLogicChangeAdditionalCritProbBySan = BuffLogicChangeAdditionalCritProbBySan

function BuffLogicChangeAdditionalCritProbBySan:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._baseSan = logicParam.baseSan or 100
  self._minValue = logicParam.minValue
  self._maxValue = logicParam.maxValue
end

function BuffLogicChangeAdditionalCritProbBySan:DoLogic()
  local featureLogicSvc = self._world:GetService("FeatureLogic")
  if not featureLogicSvc then
    return
  end
  if not featureLogicSvc:HasFeatureType(FeatureType.Sanity) then
    return
  end
  local curSanValue = featureLogicSvc:GetSanValue()
  local changeSan = curSanValue - self._baseSan
  local newChangeValue = changeSan * self._mulValue
  if self._minValue then
    newChangeValue = math.max(newChangeValue, self._minValue)
  end
  if self._maxValue then
    newChangeValue = math.min(newChangeValue, self._maxValue)
  end
  self._buffLogicService:ChangeAdditionalCritProb(self._entity, self:GetBuffSeq(), newChangeValue)
end

_class("BuffLogicRevertAdditionalCritProbBySan", BuffLogicBase)
BuffLogicRevertAdditionalCritProbBySan = BuffLogicRevertAdditionalCritProbBySan

function BuffLogicRevertAdditionalCritProbBySan:DoLogic()
  self._buffLogicService:RemoveAdditionalCritProb(self._entity, self:GetBuffSeq())
end
