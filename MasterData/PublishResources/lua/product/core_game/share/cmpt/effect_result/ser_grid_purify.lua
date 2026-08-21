require("skill_effect_result_base")
_class("SkillEffectResult_GridPurify", SkillEffectResultBase)
SkillEffectResult_GridPurify = SkillEffectResult_GridPurify

function SkillEffectResult_GridPurify:Constructor(v2GridPos, trapIDArray)
  self._gridPos = v2GridPos
  self._trapIDArray = trapIDArray
end

function SkillEffectResult_GridPurify:GetEffectType()
  return SkillEffectType.GridPurify
end

function SkillEffectResult_GridPurify:GetGridPos()
  return self._gridPos
end

function SkillEffectResult_GridPurify:GetPurifiedTrapIDs()
  return self._trapIDArray
end
