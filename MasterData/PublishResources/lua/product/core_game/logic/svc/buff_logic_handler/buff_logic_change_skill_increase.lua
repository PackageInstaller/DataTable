_class("BuffLogicChangeSkillIncrease", BuffLogicBase)
BuffLogicChangeSkillIncrease = BuffLogicChangeSkillIncrease

function BuffLogicChangeSkillIncrease:Constructor(buffInstance, logicParam)
  self._changeValue = logicParam.changeValue or 0
  self._buffInstance._effectList = logicParam.effectList
  self._layer = logicParam.layer or 0
  self._entity = buffInstance._entity
  self._light = logicParam.light
  self._buffInstance.BuffLogicChangeSkillIncrease_RunCount = 0
end

function BuffLogicChangeSkillIncrease:DoLogic()
  self._buffInstance.BuffLogicChangeSkillIncrease_RunCount = self._buffInstance.BuffLogicChangeSkillIncrease_RunCount + 1
  if self._layer > 0 then
    self._buffInstance:AddLayerCount(self._layer)
  end
  local newChangeValue = self._buffInstance.BuffLogicChangeSkillIncrease_RunCount * self._changeValue
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:ChangeSkillIncrease(self._entity, self:GetBuffSeq(), paramType, newChangeValue)
  end
  if not self._light then
    return
  end
  local ret = BuffResultChangeSkillIncrease:New(self._light)
  return ret
end

function BuffLogicChangeSkillIncrease:DoOverlap()
  return self:DoLogic()
end

_class("BuffLogicRemoveSkillIncrease", BuffLogicBase)
BuffLogicRemoveSkillIncrease = BuffLogicRemoveSkillIncrease

function BuffLogicRemoveSkillIncrease:Constructor(buffInstance, logicParam)
  self._entity = buffInstance._entity
  self._black = logicParam.black ~= nil
end

function BuffLogicRemoveSkillIncrease:DoLogic()
  self._buffInstance.BuffLogicChangeSkillIncrease_RunCount = 0
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillIncrease(self._entity, self:GetBuffSeq(), paramType)
  end
  if not self._black then
    return
  end
  local ret = BuffResultRemoveSkillIncrease:New(self._black)
  return ret
end

function BuffLogicRemoveSkillIncrease:DoOverlap()
end
