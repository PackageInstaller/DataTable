_class("BuffLogicChangeSkillIncreaseByTargetCount", BuffLogicBase)
BuffLogicChangeSkillIncreaseByTargetCount = BuffLogicChangeSkillIncreaseByTargetCount

function BuffLogicChangeSkillIncreaseByTargetCount:Constructor(buffInstance, logicParam)
  self._buffInstance._effectList = logicParam.effectList
  self._rates = logicParam.rates or {}
end

function BuffLogicChangeSkillIncreaseByTargetCount:DoLogic(notify)
  local targetCount = notify:GetTargetCount()
  if targetCount == 0 then
    return
  end
  local changeValue = self._rates[targetCount]
  changeValue = changeValue or self._rates[table.count(self._rates)]
  local casterEntity = self._entity
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:ChangeSkillIncrease(casterEntity, self:GetBuffSeq(), paramType, changeValue)
  end
end

_class("BuffLogicRemoveSkillIncreaseByTargetCount", BuffLogicBase)
BuffLogicRemoveSkillIncreaseByTargetCount = BuffLogicRemoveSkillIncreaseByTargetCount

function BuffLogicRemoveSkillIncreaseByTargetCount:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveSkillIncreaseByTargetCount:DoLogic()
  local casterEntity = self._entity
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillIncrease(casterEntity, self:GetBuffSeq(), paramType)
  end
end
