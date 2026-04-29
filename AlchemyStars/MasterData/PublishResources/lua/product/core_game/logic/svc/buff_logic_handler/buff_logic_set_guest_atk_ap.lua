_class("BuffLogicSetGuestAttackAppointChain", BuffLogicBase)
BuffLogicSetGuestAttackAppointChain = BuffLogicSetGuestAttackAppointChain

function BuffLogicSetGuestAttackAppointChain:Constructor(buffInstance, logicParam)
  self._rate = logicParam.rate or 1
end

function BuffLogicSetGuestAttackAppointChain:DoLogic()
  local guestAttack = self._entity:BuffComponent():GetBuffValue("GuestAttackAppointChain")
  if guestAttack == nil then
    Log.notice("Haven't guestAttack, SetGuestAttack Error!")
    return
  end
  self._buffLogicService:ChangeBaseAttack(self._entity, self:GetBuffSeq(), ModifyBaseAttackType.Attack, guestAttack * self._rate)
end

_class("BuffLogicResetGuestAttackAppointChain", BuffLogicBase)
BuffLogicResetGuestAttackAppointChain = BuffLogicResetGuestAttackAppointChain

function BuffLogicResetGuestAttackAppointChain:Constructor(buffInstance, logicParam)
end

function BuffLogicResetGuestAttackAppointChain:DoLogic()
  Log.notice("BuffLogicResetGuestAttackAppointChain")
  self._buffLogicService:RemoveBaseAttack(self._entity, self:GetBuffSeq(), ModifyBaseAttackType.Attack)
end
