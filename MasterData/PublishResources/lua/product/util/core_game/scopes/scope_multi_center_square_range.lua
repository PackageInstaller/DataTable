require("scope_base")
_class("SkillScopeCalculator_MultiCenterSquare", SkillScopeCalculator_Base)
SkillScopeCalculator_MultiCenterSquare = SkillScopeCalculator_MultiCenterSquare

function SkillScopeCalculator_MultiCenterSquare:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local fixedAreaType = scopeParam
  local squareBorder = scopeParam
  if #centerPos == 0 then
    centerPos = {centerPos}
  end
  local range = {}
  local wholeArea = {}
  local v = centerPos
  for _, v in ipairs(centerPos) do
    local select_piece = {}
    local left = v.x + BodyAreaHelper.GetBodyAreaLeft(bodyArea)
    local right = v.x + BodyAreaHelper.GetBodyAreaRight(bodyArea)
    local up = v.y + BodyAreaHelper.GetBodyAreaUp(bodyArea)
    local down = v.y + BodyAreaHelper.GetBodyAreaDown(bodyArea)
    for i = left - squareBorder, right + squareBorder do
      for j = down - squareBorder, up + squareBorder do
        select_piece[#select_piece + 1] = Vector2(i, j)
      end
    end
    for _, pos in ipairs(select_piece) do
      self:_InsertTargetGrid(range, pos, wholeArea)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.MultiCenterSquare, centerPos, range, wholeArea)
  return result
end
