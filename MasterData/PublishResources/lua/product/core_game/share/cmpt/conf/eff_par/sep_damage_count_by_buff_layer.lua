require("skill_effect_param_base")
require("skill_damage_effect_param")
_class("SkillEffectDamageCountByBuffLayerParam", SkillDamageEffectParam)
SkillEffectDamageCountByBuffLayerParam = SkillEffectDamageCountByBuffLayerParam

function SkillEffectDamageCountByBuffLayerParam:Constructor(t)
  self._buffEffectType = t.buffEffectType
  self._buffPreCount = t.buffPreCount or 1
end

function SkillEffectDamageCountByBuffLayerParam:GetBuffPreCount()
  return self._buffPreCount
end

function SkillEffectDamageCountByBuffLayerParam:GetEffectType()
  return SkillEffectType.DamageCountByBuffLayer
end

function SkillEffectDamageCountByBuffLayerParam:GetAddPercentBuffEffectType()
  return self._buffEffectType
end
