_class("BuffLogicChangeRandomDamagePercent", BuffLogicBase)
BuffLogicChangeRandomDamagePercent = BuffLogicChangeRandomDamagePercent

function BuffLogicChangeRandomDamagePercent:Constructor(buffInstance, logicParam)
  self._buffInstance._effectList = logicParam.effectList
  self._min = logicParam.min or 0
  self._max = logicParam.max or 0
end

function BuffLogicChangeRandomDamagePercent:DoLogic()
  local casterEntity = self._entity
  if not casterEntity then
    return
  end
  local randomService = self._world:GetService("RandomLogic")
  local val = randomService:LogicRand(self._min, self._max)
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:ChangeSkillParam(casterEntity, self:GetBuffSeq(), paramType, val)
  end
end

_class("BuffLogicRemoveRandomDamagePercent", BuffLogicBase)
BuffLogicRemoveRandomDamagePercent = BuffLogicRemoveRandomDamagePercent

function BuffLogicRemoveRandomDamagePercent:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveRandomDamagePercent:DoLogic()
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
