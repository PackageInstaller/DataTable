require("skill_effect_param_base")
_class("SkillEffectTrapMoveAndDamageParam", SkillDamageEffectParam)
SkillEffectTrapMoveAndDamageParam = SkillEffectTrapMoveAndDamageParam

function SkillEffectTrapMoveAndDamageParam:Constructor(t)
  self._mobility = t.mobility
end

function SkillEffectTrapMoveAndDamageParam:GetEffectType()
  return SkillEffectType.TrapMoveAndDamage
end

function SkillEffectTrapMoveAndDamageParam:GetMobility()
  return self._mobility
end
