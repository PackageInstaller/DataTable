require("scope_base")
_class("SkillScopeCalculator_FanShapeByPosCenterOffsetAndDir", SkillScopeCalculator_Base)
SkillScopeCalculator_FanShapeByPosCenterOffsetAndDir = SkillScopeCalculator_FanShapeByPosCenterOffsetAndDir

function SkillScopeCalculator_FanShapeByPosCenterOffsetAndDir:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local offsetX = scopeParam[1]
  local offsetY = scopeParam[2]
  if offsetX == nil or offsetY == nil then
    Log.debug("FanShapeByPosCenterOffsetAndDir offset is nil.")
    return
  end
  local startPos = Vector2(centerPos.x + offsetX, centerPos.y + offsetY)
  local index = 0
  local xStep = 0
  local wholePosList = {}
  for i = 1, startPos.y - 1 do
    index = index + 1
    for j = 0, xStep do
      local pos = Vector2(startPos.x + j, startPos.y - i)
      table.insert(wholePosList, pos)
      if 0 < j then
        local leftPos = Vector2(startPos.x - j, startPos.y - i)
        table.insert(wholePosList, leftPos)
      end
    end
    if index == 3 then
      index = 0
      xStep = xStep + 1
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.FanShapeByPosCenterOffsetAndDir, centerPos, wholePosList, wholePosList, nil)
  return result
end
