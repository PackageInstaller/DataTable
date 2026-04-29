_class("SkillPullAroundEffectResult", SkillEffectResultBase)
SkillPullAroundEffectResult = SkillPullAroundEffectResult

function SkillPullAroundEffectResult:Constructor(targetId, targetPos, gridElementChangeTable)
  self._effectType = SkillEffectType.PullAround
  self._targetId = targetId
  self._targetPos = targetPos
  self._gridElementChangeTable = gridElementChangeTable
end

function SkillPullAroundEffectResult:GetEffectType()
  return SkillEffectType.PullAround
end

function SkillPullAroundEffectResult:GetGridPos()
  return self._targetPos
end

function SkillPullAroundEffectResult:GetGridElementChangeTable()
  return self._gridElementChangeTable
end

function SkillPullAroundEffectResult:GetTargetID()
  return self._targetId
end
