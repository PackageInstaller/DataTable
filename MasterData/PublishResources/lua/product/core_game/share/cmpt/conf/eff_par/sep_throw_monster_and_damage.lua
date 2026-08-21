require("skill_effect_param_base")
_class("SkillEffectThrowMonsterAndDamageParam", SkillEffectParamBase)
SkillEffectThrowMonsterAndDamageParam = SkillEffectThrowMonsterAndDamageParam

function SkillEffectThrowMonsterAndDamageParam:Constructor(t)
  self._monsterClassID = t.monsterClassID
  self._basePercent = t.basePercent
  self._addPercent = t.addPercent
  self._formulaID = t.formulaID
end

function SkillEffectThrowMonsterAndDamageParam:GetEffectType()
  return SkillEffectType.ThrowMonsterAndDamage
end

function SkillEffectThrowMonsterAndDamageParam:GetMonsterClassID()
  return self._monsterClassID
end

function SkillEffectThrowMonsterAndDamageParam:GetBasePercent()
  return self._basePercent
end

function SkillEffectThrowMonsterAndDamageParam:GetAddPercent()
  return self._addPercent
end

function SkillEffectThrowMonsterAndDamageParam:GetFormulaID()
  return self._formulaID
end
