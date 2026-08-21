require("buff_logic_base")
_class("BuffLogicGuideLockPlayerHPPercent", BuffLogicBase)
BuffLogicGuideLockPlayerHPPercent = BuffLogicGuideLockPlayerHPPercent

function BuffLogicGuideLockPlayerHPPercent:Constructor(buffInstance, logicParam)
  self._lockHPPercent = logicParam.lockHPPercent
end

function BuffLogicGuideLockPlayerHPPercent:DoLogic(notify)
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("GuideLockHPPercent", self._lockHPPercent)
  return true
end
