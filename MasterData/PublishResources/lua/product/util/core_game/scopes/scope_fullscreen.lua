require("scope_base")
_class("SkillScopeCalculator_FullScreen", SkillScopeCalculator_Base)
SkillScopeCalculator_FullScreen = SkillScopeCalculator_FullScreen

function SkillScopeCalculator_FullScreen:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local bExcludeSelf = scopeParam
  local casterPos = centerPos
  local target_area_grid = {}
  if self._gridFilter._world then
    local boardServiceLogic = self._gridFilter._world:GetService("BoardLogic")
    local board = self._gridFilter._world:GetBoardEntity():Board()
    local arr = board:GetBlockFlagArray()
    for x, col in pairs(arr) do
      for y, block in pairs(col) do
        local grid = Vector2(x, y)
        if not boardServiceLogic:IsPosBlock(grid, BlockFlag.SkillSkip) then
          table.insert(target_area_grid, grid)
        end
      end
    end
  else
    for x = 1, self._gridFilter:GetBoardMaxX() do
      for y = 1, self._gridFilter:GetBoardMaxY() do
        local pos = Vector2(x, y)
        if self._gridFilter:IsValidPiecePos(pos) then
          table.insert(target_area_grid, pos)
        end
      end
    end
  end
  if bExcludeSelf == 1 then
    table.removev(target_area_grid, casterPos)
  end
  local result = SkillScopeResult:New(SkillScopeType.FullScreen, casterPos, target_area_grid, target_area_grid)
  return result
end
