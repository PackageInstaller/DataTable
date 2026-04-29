_class("BuffLogicDamageByAddBlood", BuffLogicBase)
BuffLogicDamageByAddBlood = BuffLogicDamageByAddBlood

function BuffLogicDamageByAddBlood:Constructor(buffInstance, logicParam)
  self._percent = logicParam.percent or 1
  self._formulaID = logicParam.formulaID or 155
  self._useHPSpilled = logicParam.useHPSpilled or false
end

function BuffLogicDamageByAddBlood:DoLogic(notify)
  if not NTPlayerHPChange:IsInstanceOfType(notify) then
    return
  end
  local attacker = notify:GetNotifyEntity()
  if attacker:HasPetPstID() then
    attacker = attacker:Pet():GetOwnerTeamEntity()
  end
  local defender = self._buffInstance:Entity()
  local changeHP = notify:GetChangeHP()
  if not changeHP or changeHP <= 0 then
    return
  end
  if not self._useHPSpilled then
    changeHP = changeHP - notify:GetHPSpilled()
  end
  local buffSvc = self._world:GetService("BuffLogic")
  local damageParam = {
    percent = self._percent,
    formulaID = self._formulaID,
    changeHP = changeHP
  }
  local damageInfo = buffSvc:DoBuffDamage(self._buffInstance:BuffID(), attacker, defender, damageParam)
  local buffResult = BuffResultDamage:New(damageInfo)
  return buffResult
end
