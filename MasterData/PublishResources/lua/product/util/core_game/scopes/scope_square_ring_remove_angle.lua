require("scope_base")
_class("SkillScopeCalculator_SquareRingRemoveAngle", SkillScopeCalculator_Base)
SkillScopeCalculator_SquareRingRemoveAngle = SkillScopeCalculator_SquareRingRemoveAngle

function SkillScopeCalculator_SquareRingRemoveAngle:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local params = scopeParam
  local ringCount = params[1]
  local ringCountRemove = params[2] or 0
  local addCenterPos = params[3] or 0
  local removeAnglePosList = {}
  local nBodyOffset = math.sqrt(#bodyArea) - 1
  table.insert(removeAnglePosList, Vector2(centerPos.x - ringCount, centerPos.y - ringCount))
  table.insert(removeAnglePosList, Vector2(centerPos.x + ringCount + nBodyOffset, centerPos.y - ringCount))
  table.insert(removeAnglePosList, Vector2(centerPos.x - ringCount, centerPos.y + ringCount + nBodyOffset))
  table.insert(removeAnglePosList, Vector2(centerPos.x + ringCount + nBodyOffset, centerPos.y + ringCount + nBodyOffset))
  local listTotalData = ComputeScopeRange.ComputeRange_SquareRing(centerPos, #bodyArea, ringCount)
  local listTotalDataRemove = {}
  if 0 < ringCountRemove then
    listTotalDataRemove = ComputeScopeRange.ComputeRange_SquareRing(centerPos, #bodyArea, ringCountRemove)
  end
  local listAttackData = {}
  for key, value in ipairs(listTotalData) do
    local isValidGrid = self._gridFilter:IsValidPiecePos(value)
    if isValidGrid and not table.intable(listTotalDataRemove, value) and not table.intable(removeAnglePosList, value) then
      listAttackData[#listAttackData + 1] = value
    end
  end
  if addCenterPos == 1 then
    table.insert(listAttackData, centerPos)
  end
  local result = SkillScopeResult:New(SkillScopeType.SquareRingRemoveAngle, centerPos, listAttackData, listAttackData)
  return result
end
