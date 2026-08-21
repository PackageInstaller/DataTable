require("scope_base")
_class("SkillScopeCalculator_AlGoreActiveSkill", SkillScopeCalculator_Base)
SkillScopeCalculator_AlGoreActiveSkill = SkillScopeCalculator_AlGoreActiveSkill

function SkillScopeCalculator_AlGoreActiveSkill:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local calcPos
  if centerPos then
    if #centerPos == 0 then
      calcPos = centerPos
    else
      calcPos = centerPos[1]
    end
  end
  local ret = {}
  self:_InsertTargetGrid(ret, Vector2(calcPos.x, calcPos.y))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x - 1, calcPos.y))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x, calcPos.y + 1))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x - 1, calcPos.y + 1))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x, calcPos.y))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x + 1, calcPos.y))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x, calcPos.y + 1))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x + 1, calcPos.y + 1))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x, calcPos.y))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x - 1, calcPos.y))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x, calcPos.y - 1))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x - 1, calcPos.y - 1))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x, calcPos.y))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x + 1, calcPos.y))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x, calcPos.y - 1))
  self:_InsertTargetGrid(ret, Vector2(calcPos.x + 1, calcPos.y - 1))
  local result = SkillScopeResult:New(SkillScopeType.AlGoreActiveScope, centerPos, ret, ret)
  return result
end

function SkillScopeCalculator_AlGoreActiveSkill:_InsertTargetGrid(targetArea, newGridPos)
  local isValid = self._gridFilter:IsValidPiecePos(newGridPos)
  if isValid then
    table.insert(targetArea, newGridPos)
  end
end
