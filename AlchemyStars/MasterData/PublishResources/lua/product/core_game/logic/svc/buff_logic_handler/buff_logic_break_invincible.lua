_class("BuffLogicSetBreakInvincible", BuffLogicBase)
BuffLogicSetBreakInvincible = BuffLogicSetBreakInvincible

function BuffLogicSetBreakInvincible:Constructor(buffInstance, logicParam)
end

function BuffLogicSetBreakInvincible:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetFlag(BuffFlags.BreakInvincible)
end

_class("BuffLogicResetBreakInvincible", BuffLogicBase)
BuffLogicResetBreakInvincible = BuffLogicResetBreakInvincible

function BuffLogicResetBreakInvincible:Constructor(buffInstance, logicParam)
end

function BuffLogicResetBreakInvincible:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():ResetFlag(BuffFlags.BreakInvincible)
end
