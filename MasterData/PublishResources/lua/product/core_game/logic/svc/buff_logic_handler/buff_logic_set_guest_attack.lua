_class("BuffLogicSetGuestAttack", BuffLogicBase)
BuffLogicSetGuestAttack = BuffLogicSetGuestAttack

function BuffLogicSetGuestAttack:Constructor(buffInstance, logicParam)
  self._rate = logicParam.rate or 1
end

function BuffLogicSetGuestAttack:DoLogic()
  local guestAttack = self._entity:BuffComponent():GetBuffValue("GuestAttack")
  if guestAttack == nil then
    Log.notice("Haven't guestAttack, SetGuestAttack Error!")
    return
  end
  self._buffLogicService:ChangeBaseAttack(self._entity, self:GetBuffSeq(), ModifyBaseAttackType.Attack, guestAttack * self._rate)
end

_class("BuffLogicResetGuestAttack", BuffLogicBase)
BuffLogicResetGuestAttack = BuffLogicResetGuestAttack

function BuffLogicResetGuestAttack:Constructor(buffInstance, logicParam)
end

function BuffLogicResetGuestAttack:DoLogic()
  Log.notice("BuffLogicResetGuestAttack")
  self._buffLogicService:RemoveBaseAttack(self._entity, self:GetBuffSeq(), ModifyBaseAttackType.Attack)
end
