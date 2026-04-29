_class("BuffLogicChangeSkillFinalByTargetCount", BuffLogicBase)
BuffLogicChangeSkillFinalByTargetCount = BuffLogicChangeSkillFinalByTargetCount

function BuffLogicChangeSkillFinalByTargetCount:Constructor(buffInstance, logicParam)
  self._buffInstance._effectList = logicParam.effectList
  self._rates = logicParam.rates or {}
end

function BuffLogicChangeSkillFinalByTargetCount:DoLogic(notify)
  local targetCount = notify:GetTargetCount()
  if targetCount == 0 then
    return
  end
  local changeValue = self._rates[targetCount]
  changeValue = changeValue or self._rates[table.count(self._rates)]
  local casterEntity = self._entity
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:ChangeSkillFinalParam(casterEntity, self:GetBuffSeq(), paramType, changeValue)
  end
end

_class("BuffLogicRemoveSkillFinalByTargetCount", BuffLogicBase)
BuffLogicRemoveSkillFinalByTargetCount = BuffLogicRemoveSkillFinalByTargetCount

function BuffLogicRemoveSkillFinalByTargetCount:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveSkillFinalByTargetCount:DoLogic()
  local casterEntity = self._entity
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillFinalParam(casterEntity, self:GetBuffSeq(), paramType)
  end
end
