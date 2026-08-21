_class("BuffLogicChangeDamagePercent", BuffLogicBase)
BuffLogicChangeDamagePercent = BuffLogicChangeDamagePercent

function BuffLogicChangeDamagePercent:Constructor(buffInstance, logicParam)
  self._buffInstance._effectList = logicParam.effectList
  self._value = logicParam.value or 0
end

function BuffLogicChangeDamagePercent:DoLogic()
  local casterEntity = self._entity
  if not casterEntity then
    return
  end
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:ChangeSkillParam(casterEntity, self:GetBuffSeq(), paramType, self._value)
  end
end

_class("BuffLogicRemoveDamagePercent", BuffLogicBase)
BuffLogicRemoveDamagePercent = BuffLogicRemoveDamagePercent

function BuffLogicRemoveDamagePercent:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveDamagePercent:DoLogic()
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local casterEntity = self._entity
  if not casterEntity then
    return
  end
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillParam(casterEntity, self:GetBuffSeq(), paramType)
  end
  return true
end
