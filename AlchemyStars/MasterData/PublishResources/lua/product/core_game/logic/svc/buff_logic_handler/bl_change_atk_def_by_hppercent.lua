_class("BuffLogicChangeAtkDefByHpPercent", BuffLogicBase)
BuffLogicChangeAtkDefByHpPercent = BuffLogicChangeAtkDefByHpPercent

function BuffLogicChangeAtkDefByHpPercent:Constructor(buffInstance, logicParam)
  self._maxPercent = logicParam.maxPercent or 0
  self._entity = buffInstance._entity
end

function BuffLogicChangeAtkDefByHpPercent:DoLogic()
  local e = self._buffInstance:Entity()
  local battleService = self._world:GetService("Battle")
  local hp, maxHP = battleService:GetCasterHP(e)
  local costHPPercent = (maxHP - hp) / maxHP
  local value = costHPPercent * self._maxPercent
  self._buffLogicService:ChangeBaseAttack(e, self._buffInstance:BuffSeq(), ModifyBaseAttackType.AttackPercentage, value)
  self._buffLogicService:ChangeBaseDefence(e, self._buffInstance:BuffSeq(), ModifyBaseDefenceType.DefencePercentage, value)
  local teamEntity = e:Pet():GetOwnerTeamEntity()
  self:UpdateTeamDefenceLogic(teamEntity)
end
