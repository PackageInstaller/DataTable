require("skill_effect_param_base")
_class("SkillEffectAlphaThrowTrapParam", SkillEffectParamBase)
SkillEffectAlphaThrowTrapParam = SkillEffectAlphaThrowTrapParam

function SkillEffectAlphaThrowTrapParam:Constructor(t)
  self._trapID = t.trapID
  self._monsterClassID = t.monsterClassID
  self._basePercent = t.basePercent
  self._afterPercent = t.afterPercent
  self._formulaID = t.formulaID
  self._buffID = t.buffID
end

function SkillEffectAlphaThrowTrapParam:GetEffectType()
  return SkillEffectType.AlphaThrowTrap
end

function SkillEffectAlphaThrowTrapParam:GetTrapID()
  return self._trapID
end

function SkillEffectAlphaThrowTrapParam:GetMonsterClassID()
  return self._monsterClassID
end

function SkillEffectAlphaThrowTrapParam:GetBasePercent()
  return self._basePercent
end

function SkillEffectAlphaThrowTrapParam:GetAfterPercent()
  return self._afterPercent
end

function SkillEffectAlphaThrowTrapParam:GetFormulaID()
  return self._formulaID
end

function SkillEffectAlphaThrowTrapParam:GetBuffID()
  return self._buffID
end
