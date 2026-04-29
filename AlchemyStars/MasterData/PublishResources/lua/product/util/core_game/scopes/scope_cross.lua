require("scope_base")
_class("SkillScopeCalculator_Cross", SkillScopeCalculator_Base)
SkillScopeCalculator_Cross = SkillScopeCalculator_Cross

function SkillScopeCalculator_Cross:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local casterPos = centerPos
  local bodyAreaArray = bodyArea
  local size = scopeParam
  local startIndex = 1
  local selectBodyArea = 0
  if type(scopeParam) == "table" then
    size = scopeParam[1]
    if 1 < #scopeParam then
      startIndex = scopeParam[2]
    end
    selectBodyArea = scopeParam[3] or 0
    if scopeParam.bodyArea then
      local area = scopeParam.bodyArea
      local poslist = {}
      for i, v in ipairs(area) do
        poslist[i] = Vector2(v[1], v[2])
      end
      bodyAreaArray = poslist
    end
  end
  local target_area_grid = {}
  for i, p in ipairs(bodyAreaArray) do
    local targetPos = casterPos + p
    table.insert(target_area_grid, targetPos)
  end
  local cross_area = {}
  local wholeArea = {}
  for i, p in ipairs(target_area_grid) do
    local center_x = p.x
    local center_y = p.y
    if selectBodyArea == 1 then
      table.insert(cross_area, Vector2(center_x, center_y))
      table.insert(wholeArea, Vector2(center_x, center_y))
    end
    for index = startIndex, size do
      local upPos = Vector2(center_x, center_y + index)
      local downPos = Vector2(center_x, center_y - index)
      local leftPos = Vector2(center_x - index, center_y)
      local rightPos = Vector2(center_x + index, center_y)
      self:_InsertTargetGrid(cross_area, upPos, wholeArea)
      self:_InsertTargetGrid(cross_area, rightPos, wholeArea)
      self:_InsertTargetGrid(cross_area, downPos, wholeArea)
      self:_InsertTargetGrid(cross_area, leftPos, wholeArea)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.Cross, casterPos, cross_area, wholeArea)
  return result
end
