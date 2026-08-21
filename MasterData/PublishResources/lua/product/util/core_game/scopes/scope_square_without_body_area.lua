require("scope_base")
_class("SkillScopeCalculator_SquareWithoutBodyArea", SkillScopeCalculator_Base)
SkillScopeCalculator_SquareWithoutBodyArea = SkillScopeCalculator_SquareWithoutBodyArea

function SkillScopeCalculator_SquareWithoutBodyArea:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local squareBorder = scopeParam
  local includeCenter = 1
  if type(scopeParam) == "table" then
    squareBorder = scopeParam[1] or 1
    includeCenter = scopeParam[2] or 1
  end
  local range = {}
  local wholeArea = {}
  local select_piece = {}
  local centerPosVec = centerPos
  if #centerPos == 0 then
    centerPosVec = {centerPos}
  end
  for _, curCenterPos in ipairs(centerPosVec) do
    local x = curCenterPos.x
    local y = curCenterPos.y
    for i = x - squareBorder, x + squareBorder do
      for j = y - squareBorder, y + squareBorder do
        if includeCenter ~= 1 and i == curCenterPos.x and j == curCenterPos.y then
        else
          select_piece[#select_piece + 1] = Vector2(i, j)
        end
      end
    end
    for _, pos in ipairs(select_piece) do
      self:_InsertTargetGrid(range, pos, wholeArea)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.SquareWithoutBodyArea, centerPos, range, wholeArea)
  return result
end
