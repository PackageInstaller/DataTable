_class("BuffLogicAddAdditionalCritParam", BuffLogicBase)
BuffLogicAddAdditionalCritParam = BuffLogicAddAdditionalCritParam

function BuffLogicAddAdditionalCritParam:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
end

function BuffLogicAddAdditionalCritParam:DoLogic()
  self._buffLogicService:ChangeAdditionalCritParam(self._entity, self:GetBuffSeq(), self._mulValue)
end

_class("BuffLogicRevertAdditionalCritParam", BuffLogicBase)
BuffLogicRevertAdditionalCritParam = BuffLogicRevertAdditionalCritParam

function BuffLogicRevertAdditionalCritParam:DoLogic()
  self._buffLogicService:RemoveAdditionalCritParam(self._entity, self:GetBuffSeq())
end
