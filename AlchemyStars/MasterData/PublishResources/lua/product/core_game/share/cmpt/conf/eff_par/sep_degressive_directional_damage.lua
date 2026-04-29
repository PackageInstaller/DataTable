require("skill_damage_effect_param")
local DegressiveDamageDirection = {
  PICKUP_POS = 1,
  PICKUP_LEFT_CORNER = 2,
  PICKUP_RIGHT_CORNER = 3,
  PICKUP_FRONT_LEFT = 4,
  PICKUP_FRONT_RIGHT = 5
}
_enum("DegressiveDamageDirection", DegressiveDamageDirection)
_class("SkillEffectParam_DegressiveDirectionalDamage", SkillDamageEffectParam)
SkillEffectParam_DegressiveDirectionalDamage = SkillEffectParam_DegressiveDirectionalDamage

function SkillEffectParam_DegressiveDirectionalDamage:Constructor(t)
  self._degressiveRates = t.degressiveRates
  self._directionType = t.directionType or DegressiveDamageDirection.PICKUP_POS
  self._formulaID = 115
end

function SkillEffectParam_DegressiveDirectionalDamage:GetEffectType()
  return SkillEffectType.DegressiveDirectionalDamage
end

function SkillEffectParam_DegressiveDirectionalDamage:GetDegressiveRates()
  return self._degressiveRates
end

function SkillEffectParam_DegressiveDirectionalDamage:GetDirection()
  return self._directionType
end
