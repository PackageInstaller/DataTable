_class("BuffLogicChangeSkillFinal", BuffLogicBase)
BuffLogicChangeSkillFinal = BuffLogicChangeSkillFinal

function BuffLogicChangeSkillFinal:Constructor(buffInstance, logicParam)
  self._changeValue = logicParam.changeValue or 0
  self._buffInstance._effectList = logicParam.effectList
  self._entity = buffInstance._entity
  self._buffInstance.BuffLogicChangeSkillFinal_RunCount = 0
end

function BuffLogicChangeSkillFinal:DoLogic()
  self._buffInstance.BuffLogicChangeSkillFinal_RunCount = self._buffInstance.BuffLogicChangeSkillFinal_RunCount + 1
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:ChangeSkillFinalParam(self._entity, self:GetBuffSeq(), paramType, self._changeValue * self._buffInstance.BuffLogicChangeSkillFinal_RunCount)
  end
end

_class("BuffLogicRemoveSkillFinal", BuffLogicBase)
BuffLogicRemoveSkillFinal = BuffLogicRemoveSkillFinal

function BuffLogicRemoveSkillFinal:Constructor(buffInstance, logicParam)
  self._entity = buffInstance._entity
end

function BuffLogicRemoveSkillFinal:DoLogic()
  self._buffInstance.BuffLogicChangeSkillFinal_RunCount = 0
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), paramType)
  end
end
