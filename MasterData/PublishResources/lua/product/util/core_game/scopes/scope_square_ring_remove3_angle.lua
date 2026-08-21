require("scope_base")
_class("SkillScopeCalculator_3SquareRingRemove3Angle", SkillScopeCalculator_Base)
SkillScopeCalculator_3SquareRingRemove3Angle = SkillScopeCalculator_3SquareRingRemove3Angle

function SkillScopeCalculator_3SquareRingRemove3Angle:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local params = scopeParam
  local ringCount = params[1]
  local ringCountRemove = params[2] or 0
  local listTotalData = ComputeScopeRange.ComputeRange_SquareRing(centerPos, #bodyArea, ringCount)
  local listTotalDataRemove = {}
  local removeAnglePosList = {}
  table.insert(removeAnglePosList, Vector2(centerPos.x - ringCount, centerPos.y - ringCount))
  table.insert(removeAnglePosList, Vector2(centerPos.x - ringCount + 1, centerPos.y - ringCount))
  table.insert(removeAnglePosList, Vector2(centerPos.x - ringCount, centerPos.y - ringCount + 1))
  table.insert(removeAnglePosList, Vector2(centerPos.x + ringCount, centerPos.y - ringCount))
  table.insert(removeAnglePosList, Vector2(centerPos.x + ringCount - 1, centerPos.y - ringCount))
  table.insert(removeAnglePosList, Vector2(centerPos.x + ringCount, centerPos.y - ringCount + 1))
  table.insert(removeAnglePosList, Vector2(centerPos.x - ringCount, centerPos.y + ringCount))
  table.insert(removeAnglePosList, Vector2(centerPos.x - ringCount, centerPos.y + ringCount - 1))
  table.insert(removeAnglePosList, Vector2(centerPos.x - ringCount + 1, centerPos.y + ringCount))
  table.insert(removeAnglePosList, Vector2(centerPos.x + ringCount, centerPos.y + ringCount))
  table.insert(removeAnglePosList, Vector2(centerPos.x + ringCount - 1, centerPos.y + ringCount))
  table.insert(removeAnglePosList, Vector2(centerPos.x + ringCount, centerPos.y + ringCount - 1))
  local listAttackData = {}
  for key, value in ipairs(listTotalData) do
    local isValidGrid = self._gridFilter:IsValidPiecePos(value)
    if isValidGrid and not table.intable(listTotalDataRemove, value) and not table.intable(removeAnglePosList, value) then
      listAttackData[#listAttackData + 1] = value
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.SquareRingRemove3Angle, centerPos, listAttackData, listAttackData)
  return result
end
