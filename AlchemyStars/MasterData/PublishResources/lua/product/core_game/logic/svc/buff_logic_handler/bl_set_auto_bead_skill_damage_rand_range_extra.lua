_class("BuffLogicSetAutoBeadSkillDamageRandRangeExtra", BuffLogicBase)
BuffLogicSetAutoBeadSkillDamageRandRangeExtra = BuffLogicSetAutoBeadSkillDamageRandRangeExtra

function BuffLogicSetAutoBeadSkillDamageRandRangeExtra:Constructor(buffInstance, logicParam)
  self._rangeExtra = logicParam.rangeExtra or 0
end

function BuffLogicSetAutoBeadSkillDamageRandRangeExtra:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  buffComponent:SetBuffValue("AutoBeadDamageRandRangeExtra", self._rangeExtra)
end

_class("BuffLogicResetAutoBeadSkillDamageRandRangeExtra", BuffLogicBase)
BuffLogicResetAutoBeadSkillDamageRandRangeExtra = BuffLogicResetAutoBeadSkillDamageRandRangeExtra

function BuffLogicResetAutoBeadSkillDamageRandRangeExtra:Constructor(buffInstance, logicParam)
end

function BuffLogicResetAutoBeadSkillDamageRandRangeExtra:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  buffComponent:SetBuffValue("AutoBeadDamageRandRangeExtra", nil)
end
