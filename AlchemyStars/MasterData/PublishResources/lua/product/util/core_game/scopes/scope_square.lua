require("scope_base")
_class("SkillScopeCalculator_Square", SkillScopeCalculator_Base)
SkillScopeCalculator_Square = SkillScopeCalculator_Square

function SkillScopeCalculator_Square:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
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
    local left = curCenterPos.x + BodyAreaHelper.GetBodyAreaLeft(bodyArea)
    local right = curCenterPos.x + BodyAreaHelper.GetBodyAreaRight(bodyArea)
    local up = curCenterPos.y + BodyAreaHelper.GetBodyAreaUp(bodyArea)
    local down = curCenterPos.y + BodyAreaHelper.GetBodyAreaDown(bodyArea)
    for i = left - squareBorder, right + squareBorder do
      for j = down - squareBorder, up + squareBorder do
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
  local result = SkillScopeResult:New(SkillScopeType.Square, centerPos, range, wholeArea)
  return result
end
