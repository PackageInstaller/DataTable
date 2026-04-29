require("skill_effect_param_base")
_class("SkillEffectParamEnhanceOccupiedGrid", SkillEffectParamBase)
SkillEffectParamEnhanceOccupiedGrid = SkillEffectParamEnhanceOccupiedGrid

function SkillEffectParamEnhanceOccupiedGrid:Constructor(t)
  self._trapID = tonumber(t.trapID) or BattleConst.DefaultEnhanceGridTrapID
  self._maxCountPerTarget = tonumber(t.maxCountPerTarget)
  assert(self._maxCountPerTarget, "EnhanceOccupiedGrid requires [maxCountPerTarget]")
end

function SkillEffectParamEnhanceOccupiedGrid:GetEffectType()
  return SkillEffectType.EnhanceOccupiedGrid
end

function SkillEffectParamEnhanceOccupiedGrid:GetTrapID()
  return self._trapID
end

function SkillEffectParamEnhanceOccupiedGrid:GetMaxCountPerTarget()
  return self._maxCountPerTarget
end
