_class("BuffLogicChangeDefenceByDamage", BuffLogicBase)
BuffLogicChangeDefenceByDamage = BuffLogicChangeDefenceByDamage

function BuffLogicChangeDefenceByDamage:Constructor(buffInstance, logicParam)
  self._factor = logicParam.factor or 0
end

function BuffLogicChangeDefenceByDamage:DoLogic(notify)
  local damage = notify:GetDamageValue()
  local maxHP = self._entity:Attributes():CalcMaxHp()
  local rate = damage / maxHP
  local val = rate * self._factor
  self._buffLogicService:ChangeBaseDefence(self._entity, self:GetBuffSeq(), ModifyBaseDefenceType.DefencePercentage, val)
end

_class("BuffLogicChangeDefenceByDamageUndo", BuffLogicBase)
BuffLogicChangeDefenceByDamageUndo = BuffLogicChangeDefenceByDamageUndo

function BuffLogicChangeDefenceByDamageUndo:Constructor(buffInstance, logicParam)
end

function BuffLogicChangeDefenceByDamageUndo:DoLogic()
  self._buffLogicService:RemoveBaseDefence(self._entity, self:GetBuffSeq(), ModifyBaseDefenceType.DefencePercentage)
end
