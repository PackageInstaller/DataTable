require("skill_effect_param_base")
require("skill_damage_effect_param")
_class("SkillEffectDamageByBuffLayerParam", SkillDamageEffectParam)
SkillEffectDamageByBuffLayerParam = SkillEffectDamageByBuffLayerParam

function SkillEffectDamageByBuffLayerParam:Constructor(t)
  self._maxAddPercent = t.maxAddPercent
  self._buffEffectType = t.buffEffectType
  self._maxLayerCount = t.maxLayerCount
  self._power = t.power or 1
end

function SkillEffectDamageByBuffLayerParam:GetEffectType()
  return SkillEffectType.DamageByBuffLayer
end

function SkillEffectDamageByBuffLayerParam:GetMaxAddPercent()
  return self._maxAddPercent
end

function SkillEffectDamageByBuffLayerParam:GetAddPercentBuffEffectType()
  return self._buffEffectType
end

function SkillEffectDamageByBuffLayerParam:GetMaxLayerCount()
  return self._maxLayerCount
end

function SkillEffectDamageByBuffLayerParam:GetDamagePower()
  return self._power
end
