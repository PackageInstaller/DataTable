require("skill_effect_result_base")
_class("SkillAddGridEffectResult", SkillEffectResultBase)
SkillAddGridEffectResult = SkillAddGridEffectResult

function SkillAddGridEffectResult:Constructor(gridArray, gridConvertTypes, traps)
  self._gridArray = gridArray
  self._gridConvertTypes = gridConvertTypes
  self._traps = traps
end

function SkillAddGridEffectResult:GetEffectType()
  return SkillEffectType.AddGridEffect
end

function SkillAddGridEffectResult:GetTargetGridArray()
  return self._gridArray
end

function SkillAddGridEffectResult:GetGridConvertType(pos)
  local posIndex = Vector2.Pos2Index(pos)
  return self._gridConvertTypes[posIndex]
end

function SkillAddGridEffectResult:GetGridConvertTypes()
  return self._gridConvertTypes
end

function SkillAddGridEffectResult:GetSummontTrapEntityID(pos)
  local posidx = Vector2.Pos2Index(pos)
  return self._traps[posidx]
end

function SkillAddGridEffectResult:GetSummonTraps()
  return self._traps
end
