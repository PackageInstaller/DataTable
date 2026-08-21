_class("BuffLogicSetGuestDefence", BuffLogicBase)
BuffLogicSetGuestDefence = BuffLogicSetGuestDefence

function BuffLogicSetGuestDefence:Constructor(buffInstance, logicParam)
end

function BuffLogicSetGuestDefence:DoLogic()
  local guestValue = self._entity:BuffComponent():GetBuffValue("GuestDefence")
  if guestValue == nil then
    Log.notice("Haven't guest, SetGuestDefence Error!")
    return
  end
  self._buffLogicService:ChangeBaseDefence(self._entity, self:GetBuffSeq(), ModifyBaseDefenceType.Defense, guestValue)
end

_class("BuffLogicResetGuestDefence", BuffLogicBase)
BuffLogicResetGuestDefence = BuffLogicResetGuestDefence

function BuffLogicResetGuestDefence:Constructor(buffInstance, logicParam)
end

function BuffLogicResetGuestDefence:DoLogic()
  Log.notice("BuffLogicResetGuestDefence")
  self._buffLogicService:RemoveBaseDefence(self._entity, self:GetBuffSeq(), ModifyBaseDefenceType.Defense)
end
