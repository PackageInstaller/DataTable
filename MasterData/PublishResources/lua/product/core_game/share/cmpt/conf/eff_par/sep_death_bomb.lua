require("skill_damage_effect_param")
_class("SkillEffectParamDeathBomb", SkillDamageEffectParam)
SkillEffectParamDeathBomb = SkillEffectParamDeathBomb

function SkillEffectParamDeathBomb:Constructor(t)
  self._bombScopeType = t.bombScopeType
  self._bombScopeParam = t.bombScopeParam
  self._buffID = t.buffID
end

function SkillEffectParamDeathBomb:GetEffectType()
  return SkillEffectType.DeathBomb
end

function SkillEffectParamDeathBomb:GetDeathBombScopeType()
  return self._bombScopeType
end

function SkillEffectParamDeathBomb:GetDeathBombScopeParam()
  return self._bombScopeParam
end

function SkillEffectParamDeathBomb:GetDeathBombBuffID()
  return self._buffID
end
