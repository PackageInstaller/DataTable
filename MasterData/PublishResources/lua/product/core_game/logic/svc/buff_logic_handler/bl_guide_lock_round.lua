require("buff_logic_base")
_class("BuffLogicGuideLockRoundCount", BuffLogicBase)
BuffLogicGuideLockRoundCount = BuffLogicGuideLockRoundCount

function BuffLogicGuideLockRoundCount:Constructor(buffInstance, logicParam)
  self._lockRound = logicParam.lockRound
end

function BuffLogicGuideLockRoundCount:DoLogic(notify)
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("GuideLockRoundCount", self._lockRound)
  return true
end
