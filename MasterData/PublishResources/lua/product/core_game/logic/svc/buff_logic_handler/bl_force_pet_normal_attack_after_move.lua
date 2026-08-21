require("buff_logic_base")
_class("BuffLogicForcePetNormalAttackAfterMove", BuffLogicBase)
BuffLogicForcePetNormalAttackAfterMove = BuffLogicForcePetNormalAttackAfterMove

function BuffLogicForcePetNormalAttackAfterMove:Constructor(buffInstance, logicParam)
  self._state = logicParam.state == 1
end

function BuffLogicForcePetNormalAttackAfterMove:DoLogic(notify)
  self:GetEntity():BuffComponent():SetBuffValue("ForcePetNormalAttackAfterMove", self._state)
  return {
    state = self._state
  }
end
