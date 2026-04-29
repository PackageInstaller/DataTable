require("skill_damage_effect_param")
_class("SkillEffectParam_StampDamage", SkillDamageEffectParam)
SkillEffectParam_StampDamage = SkillEffectParam_StampDamage

function SkillEffectParam_StampDamage:Constructor(t)
  self._addDamageByStamp = t.addDamageByStamp
  self._buffId = t.buffId
end

function SkillEffectParam_StampDamage:GetEffectType()
  return SkillEffectType.StampDamage
end

function SkillEffectParam_StampDamage:GetBuffID()
  return self._buffId
end

function SkillEffectParam_StampDamage:GetAddDamageByStamp()
  return self._addDamageByStamp
end
