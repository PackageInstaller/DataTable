require("skill_effect_result_base")
_class("SkillEffectResultCrabMoveAndAttack", SkillEffectResultBase)
SkillEffectResultCrabMoveAndAttack = SkillEffectResultCrabMoveAndAttack

function SkillEffectResultCrabMoveAndAttack:Constructor(attackMoveStep)
  self._attackMoveStep = attackMoveStep
end

function SkillEffectResultCrabMoveAndAttack:GetEffectType()
  return SkillEffectType.CrabMoveAndAttack
end

function SkillEffectResultCrabMoveAndAttack:GetAttackMoveStep()
  return self._attackMoveStep
end
