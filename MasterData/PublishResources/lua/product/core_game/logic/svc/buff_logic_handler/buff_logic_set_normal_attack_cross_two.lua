_class("BuffLogicSetNormalAttackCrossTwo", BuffLogicBase)
BuffLogicSetNormalAttackCrossTwo = BuffLogicSetNormalAttackCrossTwo

function BuffLogicSetNormalAttackCrossTwo:Constructor(buffInstance, logicParam)
  self._count = logicParam.count
end

function BuffLogicSetNormalAttackCrossTwo:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  buffComponent:SetBuffValue("NormalAttackCrossTwoCount", self._count)
  buffComponent:SetBuffValue("ChangeNormalSkillCount", self._count)
  local enable = 1
  if self._count == 0 then
    enable = 0
  end
  buffComponent:SetBuffValue("NormalAttackRemoveSameTarget", enable)
  buffComponent:SetBuffValue("ChangeNormalSkillExcludeOriPos", enable)
  buffComponent:SetBuffValue("ChangeNormalSkillUseAttackPosAsCenter", enable)
  buffComponent:SetBuffValue("NormalAttackOneDamageOneCombo", enable)
end
