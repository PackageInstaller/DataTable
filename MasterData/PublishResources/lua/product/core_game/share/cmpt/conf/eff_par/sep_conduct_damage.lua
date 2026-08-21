require("skill_damage_effect_param")
_class("SkillEffectParam_ConductDamage", SkillEffectParamBase)
SkillEffectParam_ConductDamage = SkillEffectParam_ConductDamage

function SkillEffectParam_ConductDamage:Constructor(paramList)
  self._conductScopeType = paramList.conductScopeType
  self._conductScopeParam = paramList.conductScopeParam
  self._conductTargetType = paramList.conductTargetType or SkillTargetType.MonsterTrap
  self._formulaID = paramList.formulaID or 110
  self._conductRate = paramList.conductRate
end

function SkillEffectParam_ConductDamage:GetEffectType()
  return SkillEffectType.ConductDamage
end

function SkillEffectParam_ConductDamage:GetConductScopeType()
  return self._conductScopeType
end

function SkillEffectParam_ConductDamage:GetConductScopeParam()
  return self._conductScopeParam
end

function SkillEffectParam_ConductDamage:GetConductTargetType()
  return self._conductTargetType
end

function SkillEffectParam_ConductDamage:GetFormulaID()
  return self._formulaID
end

function SkillEffectParam_ConductDamage:GetConductRateList()
  return self._conductRate
end
