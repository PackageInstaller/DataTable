require("calc_damage")
_class("SkillEffectCalc_DynamicScopeChainDamage", SkillEffectCalc_Damage)
SkillEffectCalc_DynamicScopeChainDamage = SkillEffectCalc_DynamicScopeChainDamage

function SkillEffectCalc_DynamicScopeChainDamage:CalcChainReplaceScope(casterEntity, effectParam)
  local utilScope = self._world:GetService("UtilScopeCalc")
  return utilScope:CalcSkillEffectScopeResult(effectParam, casterEntity:GetGridPosition(), casterEntity)
end
