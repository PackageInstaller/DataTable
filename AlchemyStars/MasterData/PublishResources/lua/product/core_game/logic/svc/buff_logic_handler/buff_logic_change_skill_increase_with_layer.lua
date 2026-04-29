_class("BuffLogicChangeSkillIncreaseWithLayer", BuffLogicBase)
BuffLogicChangeSkillIncreaseWithLayer = BuffLogicChangeSkillIncreaseWithLayer

function BuffLogicChangeSkillIncreaseWithLayer:Constructor(buffInstance, logicParam)
  self._changeValue = logicParam.changeValue or 0
  self._effectList = logicParam.effectList
  self._runCount = 0
end

function BuffLogicChangeSkillIncreaseWithLayer:DoLogic()
  self._runCount = self._runCount + 1
  for _, paramType in ipairs(self._effectList) do
    self._buffLogicService:ChangeSkillIncrease(self._entity, self:GetBuffSeq(), paramType, self._changeValue * self._runCount)
  end
end

function BuffLogicChangeSkillIncreaseWithLayer:DoOverlap(logicParam)
  return self:DoLogic()
end

_class("BuffLogicRemoveSkillIncreaseWithLayer", BuffLogicBase)
BuffLogicRemoveSkillIncreaseWithLayer = BuffLogicRemoveSkillIncreaseWithLayer

function BuffLogicRemoveSkillIncreaseWithLayer:Constructor(buffInstance, logicParam)
  self._effectList = logicParam.effectList
end

function BuffLogicRemoveSkillIncreaseWithLayer:DoLogic()
  for _, paramType in ipairs(self._effectList) do
    self._buffLogicService:RemoveSkillIncrease(self._entity, self:GetBuffSeq(), paramType)
  end
  return true
end

function BuffLogicRemoveSkillIncreaseWithLayer:DoOverlap()
end
