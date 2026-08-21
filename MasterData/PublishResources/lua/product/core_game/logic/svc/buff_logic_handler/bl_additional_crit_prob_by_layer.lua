_class("BuffLogicChangeAdditionalCritProbByLayer", BuffLogicBase)
BuffLogicChangeAdditionalCritProbByLayer = BuffLogicChangeAdditionalCritProbByLayer

function BuffLogicChangeAdditionalCritProbByLayer:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._unitVal = logicParam.unitVal
end

function BuffLogicChangeAdditionalCritProbByLayer:DoLogic()
  local curMarkLayer = self._buffLogicService:GetBuffLayer(self._entity, self._layerType)
  local val = self._unitVal * curMarkLayer
  self._buffLogicService:ChangeAdditionalCritProb(self._entity, self:GetBuffSeq(), val)
end

_class("BuffLogicRevertAdditionalCritProbByLayer", BuffLogicBase)
BuffLogicRevertAdditionalCritProbByLayer = BuffLogicRevertAdditionalCritProbByLayer

function BuffLogicRevertAdditionalCritProbByLayer:DoLogic()
  self._buffLogicService:RemoveAdditionalCritProb(self._entity, self:GetBuffSeq())
end
