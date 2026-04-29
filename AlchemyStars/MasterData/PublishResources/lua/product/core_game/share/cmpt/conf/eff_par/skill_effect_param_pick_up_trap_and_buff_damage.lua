require("skill_effect_param_base")
_class("SkillEffectParamPickUpTrapAndBuffDamage", SkillEffectParamBase)
SkillEffectParamPickUpTrapAndBuffDamage = SkillEffectParamPickUpTrapAndBuffDamage

function SkillEffectParamPickUpTrapAndBuffDamage:Constructor(t)
  self._trapIDList = t.trapIDList
  self._buffID = t.buffID
  self._formulaID = t.formulaID
  self._percentList = t.percentList
  self._skillList = t.skillList
end

function SkillEffectParamPickUpTrapAndBuffDamage:GetEffectType()
  return SkillEffectType.PickUpTrapAndBuffDamage
end

function SkillEffectParamPickUpTrapAndBuffDamage:GetTrapIDList()
  return self._trapIDList
end

function SkillEffectParamPickUpTrapAndBuffDamage:GetBuffID()
  return self._buffID
end

function SkillEffectParamPickUpTrapAndBuffDamage:GetFormulaID()
  return self._formulaID
end

function SkillEffectParamPickUpTrapAndBuffDamage:GetPercentList()
  return self._percentList
end

function SkillEffectParamPickUpTrapAndBuffDamage:GetSkillList()
  return self._skillList
end
