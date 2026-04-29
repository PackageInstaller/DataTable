require("skill_damage_effect_param")
_class("SkillEffectParamNightKingTeleportPathDamage", SkillDamageEffectParam)
SkillEffectParamNightKingTeleportPathDamage = SkillEffectParamNightKingTeleportPathDamage

function SkillEffectParamNightKingTeleportPathDamage:Constructor(t)
  self._pathDamageScopeType = t.pathDamageScopeType
  self._pathDamageScopeParam = t.pathDamageScopeParam
  self._pathDamageTargetType = t.pathDamageTargetType
  self._finalDamageScopeType = t.finalDamageScopeType
  self._finalDamageScopeParam = t.finalDamageScopeParam
  self._finalDamageTargetType = t.finalDamageTargetType
end

function SkillEffectParamNightKingTeleportPathDamage:GetEffectType()
  return SkillEffectType.NightKingTeleportPathDamage
end

function SkillEffectParamNightKingTeleportPathDamage:GetPathDamageScopeType()
  return self._pathDamageScopeType
end

function SkillEffectParamNightKingTeleportPathDamage:GetPathDamageScopeParam()
  return self._pathDamageScopeParam
end

function SkillEffectParamNightKingTeleportPathDamage:GetPathDamageTargetType()
  return self._pathDamageTargetType
end

function SkillEffectParamNightKingTeleportPathDamage:GetFinalDamageScopeType()
  return self._finalDamageScopeType
end

function SkillEffectParamNightKingTeleportPathDamage:GetFinalDamageScopeParam()
  return self._finalDamageScopeParam
end

function SkillEffectParamNightKingTeleportPathDamage:GetFinalDamageTargetType()
  return self._finalDamageTargetType
end
