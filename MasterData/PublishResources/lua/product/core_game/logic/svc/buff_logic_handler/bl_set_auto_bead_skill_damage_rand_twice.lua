_class("BuffLogicSetAutoBeadSkillDamageRandTwice", BuffLogicBase)
BuffLogicSetAutoBeadSkillDamageRandTwice = BuffLogicSetAutoBeadSkillDamageRandTwice

function BuffLogicSetAutoBeadSkillDamageRandTwice:Constructor(buffInstance, logicParam)
end

function BuffLogicSetAutoBeadSkillDamageRandTwice:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  buffComponent:SetBuffValue("AutoBeadDamageRandTwice", 1)
end

_class("BuffLogicResetAutoBeadSkillDamageRandTwice", BuffLogicBase)
BuffLogicResetAutoBeadSkillDamageRandTwice = BuffLogicResetAutoBeadSkillDamageRandTwice

function BuffLogicResetAutoBeadSkillDamageRandTwice:Constructor(buffInstance, logicParam)
end

function BuffLogicResetAutoBeadSkillDamageRandTwice:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  buffComponent:SetBuffValue("AutoBeadDamageRandTwice", nil)
end
