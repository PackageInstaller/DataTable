require("scope_base")
_class("SkillScopeCalculator_TShapeByPosCenterAndDir", SkillScopeCalculator_Base)
SkillScopeCalculator_TShapeByPosCenterAndDir = SkillScopeCalculator_TShapeByPosCenterAndDir

function SkillScopeCalculator_TShapeByPosCenterAndDir:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local tShapeScopeList = {
    Vector2(-1, -1),
    Vector2(0, -1),
    Vector2(0, -2),
    Vector2(1, -1)
  }
  local wholePosList = {}
  for _, offset in ipairs(tShapeScopeList) do
    local pos = Vector2(offset.x + centerPos.x, offset.y + centerPos.y)
    table.insert(wholePosList, pos)
  end
  local result = SkillScopeResult:New(SkillScopeType.TShapeByPosCenterAndDir, centerPos, wholePosList, wholePosList, nil)
  return result
end
