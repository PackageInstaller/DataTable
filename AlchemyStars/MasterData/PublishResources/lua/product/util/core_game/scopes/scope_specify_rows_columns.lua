require("scope_base")
_class("SkillScopeCalculator_SpecifyRowsColumns", SkillScopeCalculator_Base)
SkillScopeCalculator_SpecifyRowsColumns = SkillScopeCalculator_SpecifyRowsColumns

function SkillScopeCalculator_SpecifyRowsColumns:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local specifyX = scopeParam.x or {}
  local specifyY = scopeParam.y or {}
  local target_area_grid = {}
  if self._gridFilter._world then
    local boardServiceLogic = self._gridFilter._world:GetService("BoardLogic")
    local board = self._gridFilter._world:GetBoardEntity():Board()
    local arr = board:GetBlockFlagArray()
    for x, col in pairs(arr) do
      for y, block in pairs(col) do
        local grid = Vector2(x, y)
        if not boardServiceLogic:IsPosBlock(grid, BlockFlag.SkillSkip) and self:_SpecifyIncludePos(grid, specifyX, specifyY) then
          table.insert(target_area_grid, grid)
        end
      end
    end
  else
    for x = 1, self._gridFilter:GetBoardMaxX() do
      for y = 1, self._gridFilter:GetBoardMaxY() do
        local pos = Vector2(x, y)
        if self._gridFilter:IsValidPiecePos(pos) and self:_SpecifyIncludePos(pos, specifyX, specifyY) then
          table.insert(target_area_grid, pos)
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.SpecifyRowsColumns, centerPos, target_area_grid, target_area_grid)
  return result
end

function SkillScopeCalculator_SpecifyRowsColumns:_SpecifyIncludePos(pos, specifyX, specifyY)
  if table.count(specifyX) > 0 and table.icontains(specifyX, pos.x) or table.count(specifyY) > 0 and table.icontains(specifyY, pos.y) then
    return true
  end
  return false
end
