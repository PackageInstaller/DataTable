require("scope_base")
_class("SkillScopeCalculator_CasterForwardByDir", SkillScopeCalculator_Base)
SkillScopeCalculator_CasterForwardByDir = SkillScopeCalculator_CasterForwardByDir

function SkillScopeCalculator_CasterForwardByDir:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local wholeArea = {}
  if #bodyArea == 1 then
    self:InsertTargetGrid(casterPos, casterDir, wholeArea)
  elseif #bodyArea == 4 then
    if casterDir == Vector2(0, 1) then
      self:InsertTargetGrid(casterPos, Vector2(0, 2), wholeArea)
      self:InsertTargetGrid(casterPos, Vector2(1, 2), wholeArea)
    elseif casterDir == Vector2(0, -1) then
      self:InsertTargetGrid(casterPos, Vector2(0, -1), wholeArea)
      self:InsertTargetGrid(casterPos, Vector2(1, -1), wholeArea)
    elseif casterDir == Vector2(1, 0) then
      self:InsertTargetGrid(casterPos, Vector2(2, 0), wholeArea)
      self:InsertTargetGrid(casterPos, Vector2(2, 1), wholeArea)
    elseif casterDir == Vector2(-1, 0) then
      self:InsertTargetGrid(casterPos, Vector2(-1, 0), wholeArea)
      self:InsertTargetGrid(casterPos, Vector2(-1, 1), wholeArea)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.ChooseCasterOffsetByDir, casterPos, wholeArea, wholeArea)
  return result
end

function SkillScopeCalculator_CasterForwardByDir:InsertTargetGrid(casterPos, offset, wholeArea)
  self:_InsertTargetGrid(wholeArea, Vector2(casterPos.x + offset.x, casterPos.y + offset.y), wholeArea)
end
