require("skill_effect_param_base")
require("skill_damage_effect_param")
_class("SkillEffectHitBackAndDamageParam", SkillDamageEffectParam)
SkillEffectHitBackAndDamageParam = SkillEffectHitBackAndDamageParam

function SkillEffectHitBackAndDamageParam:Constructor(t)
  self._excludeCasterPos = t.excludeCasterPos
  self._ignorePlayerBlock = t.ignorePlayerBlock or false
end

function SkillEffectHitBackAndDamageParam:GetIgnorePlayerBlock()
  return self._ignorePlayerBlock
end

function SkillEffectHitBackAndDamageParam:ExcludeCasterPos()
  return self._excludeCasterPos
end

function SkillEffectHitBackAndDamageParam:GetEffectType()
  return SkillEffectType.HitBackAndDamage
end
