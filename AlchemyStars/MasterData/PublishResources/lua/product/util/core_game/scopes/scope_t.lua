require("scope_base")
_class("SkillScopeCalculator_T", SkillScopeCalculator_Base)
SkillScopeCalculator_T = SkillScopeCalculator_T

function SkillScopeCalculator_T:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local cross_area = {}
  local wholeArea = {}
  self:_InsertTargetGrid(cross_area, casterPos + casterDir)
  if casterDir == Vector2(0, 1) then
    self:_InsertTargetGrid(cross_area, casterPos + Vector2(0, 2))
    self:_InsertTargetGrid(cross_area, casterPos + Vector2(1, 2))
    self:_InsertTargetGrid(cross_area, casterPos + Vector2(-1, 2))
  elseif casterDir == Vector2(0, -1) then
    self:_InsertTargetGrid(cross_area, casterPos + Vector2(0, -2))
    self:_InsertTargetGrid(cross_area, casterPos + Vector2(1, -2))
    self:_InsertTargetGrid(cross_area, casterPos + Vector2(-1, -2))
  elseif casterDir == Vector2(1, 0) then
    self:_InsertTargetGrid(cross_area, casterPos + Vector2(2, 0))
    self:_InsertTargetGrid(cross_area, casterPos + Vector2(2, 1))
    self:_InsertTargetGrid(cross_area, casterPos + Vector2(2, -1))
  elseif casterDir == Vector2(-1, 0) then
    self:_InsertTargetGrid(cross_area, casterPos + Vector2(-2, 0))
    self:_InsertTargetGrid(cross_area, casterPos + Vector2(-2, 1))
    self:_InsertTargetGrid(cross_area, casterPos + Vector2(-2, -1))
  end
  local result = SkillScopeResult:New(SkillScopeType.ColOrRowByPickUpCount, casterPos, cross_area, cross_area)
  return result
end
