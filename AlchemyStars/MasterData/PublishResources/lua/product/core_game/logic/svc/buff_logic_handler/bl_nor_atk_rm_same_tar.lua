_class("BuffLogicSetNormalAttackRemoveSameTarget", BuffLogicBase)
BuffLogicSetNormalAttackRemoveSameTarget = BuffLogicSetNormalAttackRemoveSameTarget

function BuffLogicSetNormalAttackRemoveSameTarget:Constructor(buffInstance, logicParam)
end

function BuffLogicSetNormalAttackRemoveSameTarget:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  buffComponent:SetBuffValue("NormalAttackRemoveSameTarget", 1)
end

_class("BuffLogicResetNormalAttackRemoveSameTarget", BuffLogicBase)
BuffLogicResetNormalAttackRemoveSameTarget = BuffLogicResetNormalAttackRemoveSameTarget

function BuffLogicResetNormalAttackRemoveSameTarget:Constructor(buffInstance, logicParam)
end

function BuffLogicResetNormalAttackRemoveSameTarget:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  buffComponent:SetBuffValue("NormalAttackRemoveSameTarget", nil)
end
