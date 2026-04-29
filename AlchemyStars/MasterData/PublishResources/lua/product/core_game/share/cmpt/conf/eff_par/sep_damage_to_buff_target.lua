_class("SkillEffectParam_DamageToBufferTarget", SkillDamageEffectParam)
SkillEffectParam_DamageToBufferTarget = SkillEffectParam_DamageToBufferTarget

function SkillEffectParam_DamageToBufferTarget:Constructor(t)
  self._specificBuffEffectType = t.specificBuffEffectType
  Log.assert(self._specificBuffEffectType ~= nil, self._className, "Field 'specificBuffEffectType' is required. ")
end

function SkillEffectParam_DamageToBufferTarget:GetEffectType()
  return SkillEffectType.DamageToBuffTarget
end

function SkillEffectParam_DamageToBufferTarget:GetSpecificBuffEffectType()
  return self._specificBuffEffectType
end
