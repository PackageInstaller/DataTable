_class("BuffLogicAddHPShieldLock", BuffLogicBase)
BuffLogicAddHPShieldLock = BuffLogicAddHPShieldLock

function BuffLogicAddHPShieldLock:Constructor()
end

function BuffLogicAddHPShieldLock:DoLogic(notify)
  local buff = self._entity:BuffComponent()
  buff:SetBuffValue("HPShieldLockHP", true)
end

_class("BuffLogicRemoveHPShieldLock", BuffLogicBase)
BuffLogicRemoveHPShieldLock = BuffLogicRemoveHPShieldLock

function BuffLogicRemoveHPShieldLock:Constructor()
end

function BuffLogicRemoveHPShieldLock:DoLogic(notify)
  local buff = self._entity:BuffComponent()
  buff:SetBuffValue("HPShieldLockHP", nil)
end
