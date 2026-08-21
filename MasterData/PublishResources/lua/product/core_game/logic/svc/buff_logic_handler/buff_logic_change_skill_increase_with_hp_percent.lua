_class("BuffLogicChangeSkillIncreaseWithHpPercent", BuffLogicBase)
BuffLogicChangeSkillIncreaseWithHpPercent = BuffLogicChangeSkillIncreaseWithHpPercent

function BuffLogicChangeSkillIncreaseWithHpPercent:Constructor(buffInstance, logicParam)
  self._changeValue = logicParam.changeValue or 0
  self._buffInstance._effectList = logicParam.effectList
  self._entity = buffInstance._entity
end

function BuffLogicChangeSkillIncreaseWithHpPercent:DoLogic()
  local e = self._buffInstance:Entity()
  local attrCmpt = e:Attributes()
  local max_hp = attrCmpt:CalcMaxHp()
  local cur_hp = e:Attributes():GetCurrentHP()
  local losePercent = 1 - cur_hp / max_hp
  local changeValue = 0
  if losePercent ~= 0 then
    changeValue = changeValue + losePercent * self._changeValue
  end
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillIncrease(self._entity, self._buffInstance._buffSeq, paramType)
    if changeValue ~= 0 then
      self._buffLogicService:ChangeSkillIncrease(self._entity, self._buffInstance._buffSeq, paramType, changeValue)
    end
  end
end

_class("BuffLogicRemoveSkillIncreaseWithHpPercent", BuffLogicBase)
BuffLogicRemoveSkillIncreaseWithHpPercent = BuffLogicRemoveSkillIncreaseWithHpPercent

function BuffLogicRemoveSkillIncreaseWithHpPercent:Constructor(buffInstance, logicParam)
  self._entity = buffInstance._entity
end

function BuffLogicRemoveSkillIncreaseWithHpPercent:DoLogic()
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillIncrease(self._entity, self._buffInstance:BuffSeq(), paramType)
  end
end
