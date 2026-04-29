require("skill_effect_result_base")
_class("SkillEffectResult_MarkGridInScope", SkillEffectResultBase)
SkillEffectResult_MarkGridInScope = SkillEffectResult_MarkGridInScope

function SkillEffectResult_MarkGridInScope:Constructor(tv2Mark, tv2Clear)
  self._tv2Mark = tv2Mark or {}
  self._tv2Clear = tv2Clear or {}
end

function SkillEffectResult_MarkGridInScope:GetEffectType()
  return SkillEffectType.MarkGridInScope
end

function SkillEffectResult_MarkGridInScope:GetMarkGrids()
  return self._tv2MarkResult
end

function SkillEffectResult_MarkGridInScope:GetClearGrids()
  return self._tv2Clear
end
