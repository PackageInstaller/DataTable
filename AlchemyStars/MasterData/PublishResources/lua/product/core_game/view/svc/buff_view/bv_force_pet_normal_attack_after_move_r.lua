_class("BuffViewForcePetNormalAttackAfterMove", BuffViewBase)
BuffViewForcePetNormalAttackAfterMove = BuffViewForcePetNormalAttackAfterMove

function BuffViewForcePetNormalAttackAfterMove:PlayView(TT)
  local result = self:GetBuffResult()
  self._entity:BuffView():SetBuffValue("ForcePetNormalAttackAfterMove", result.state)
end
