require("skill_damage_effect_param")
_class("SkillEffectParamDamageSamePosReduce", SkillDamageEffectParam)
SkillEffectParamDamageSamePosReduce = SkillEffectParamDamageSamePosReduce

function SkillEffectParamDamageSamePosReduce:Constructor(t)
  self._finalEffectType = t.finalEffectType
  self._dampPer = t.dampPer
  self._req = t.req or 20
end

function SkillEffectParamDamageSamePosReduce:GetEffectType()
  return SkillEffectType.DamageSamePosReduce
end

function SkillEffectParamDamageSamePosReduce:GetFinalEffectType()
  return self._finalEffectType
end

function SkillEffectParamDamageSamePosReduce:GetDampPercent()
  return self._dampPer
end
