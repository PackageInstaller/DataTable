require("skill_effect_param_base")
_class("SkillEffectParamFrontExtendDegressiveDamage", SkillEffectParamBase)
SkillEffectParamFrontExtendDegressiveDamage = SkillEffectParamFrontExtendDegressiveDamage

function SkillEffectParamFrontExtendDegressiveDamage:Constructor(t)
  self._percent = t.percent
  self._formulaID = t.formulaID
  self._effectParam = t.effectParam
end

function SkillEffectParamFrontExtendDegressiveDamage:GetEffectType()
  return SkillEffectType.FrontExtendDegressiveDamage
end

function SkillEffectParamFrontExtendDegressiveDamage:GetDamageFormulaID()
  return self._formulaID
end

function SkillEffectParamFrontExtendDegressiveDamage:GetBaseDamagePercent()
  return self._percent[1]
end

function SkillEffectParamFrontExtendDegressiveDamage:GetDamagePercent()
  return self._damagePercent or self._percent
end

function SkillEffectParamFrontExtendDegressiveDamage:SetDamagePercent(damagePercent)
  self._damagePercent = damagePercent
end

function SkillEffectParamFrontExtendDegressiveDamage:GetEffectParam()
  return self._effectParam
end
