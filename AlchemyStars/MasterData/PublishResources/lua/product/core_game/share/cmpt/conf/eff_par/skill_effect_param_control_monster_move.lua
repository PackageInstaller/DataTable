require("skill_effect_param_base")
_class("SkillEffectParamControlMonsterMove", SkillEffectParamBase)
SkillEffectParamControlMonsterMove = SkillEffectParamControlMonsterMove

function SkillEffectParamControlMonsterMove:Constructor(t)
  self._monsterClassID = t.monsterClassID
  self._trapID = t.trapID
  self._percent = t.percent
  self._formulaID = t.formulaID
end

function SkillEffectParamControlMonsterMove:GetEffectType()
  return SkillEffectType.ControlMonsterMove
end

function SkillEffectParamControlMonsterMove:GetMonsterClassID()
  return self._monsterClassID
end

function SkillEffectParamControlMonsterMove:GetTrapID()
  return self._trapID
end

function SkillEffectParamControlMonsterMove:GetDamageFormulaID()
  return self._formulaID
end

function SkillEffectParamControlMonsterMove:GetDamagePercent()
  return self._percent
end
