require("buff_logic_base")
_class("BuffLogicRecoverFromGreyHP", BuffLogicBase)
BuffLogicRecoverFromGreyHP = BuffLogicRecoverFromGreyHP

function BuffLogicRecoverFromGreyHP:Constructor(_, logicParam)
  self._recoveryRate = logicParam.rate
end

function BuffLogicRecoverFromGreyHP:DoLogic(_)
  local e = self:GetEntity()
  if e:HasSuperEntity() then
    e = e:GetSuperEntity()
  end
  local damageInfo = self._buffLogicService:GetRecoverFromGreyHPDamageInfo(e, self._recoveryRate)
  if not damageInfo then
    return
  end
  local calcDamageSvc = self._world:GetService("CalcDamage")
  calcDamageSvc:AddTargetHP(e:GetID(), damageInfo)
  self._buffLogicService:ChangeGreyHP(e, damageInfo:GetChangeHP() * -1)
  local currentVal = e:BuffComponent():GetGreyHPValue(true)
  return BuffResultRecoverFromGreyHP:New(e:GetID(), damageInfo, currentVal)
end
