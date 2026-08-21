require("scope_filter_base")
_class("SkillScopeFilter_PieceBlock", SkillScopeFilter_Base)
SkillScopeFilter_PieceBlock = SkillScopeFilter_PieceBlock

function SkillScopeFilter_PieceBlock:DoModifyRange(scopeResult, filterParam, passParam)
  local wholeGridRange = scopeResult:GetWholeGridRange()
  local world = passParam:GetWorld()
  local boardService = world:GetService("BoardLogic")
  local obstacledPosArray = {}
  for _, gridPos in ipairs(wholeGridRange) do
    local pieceBlock = boardService:FindBlockByPos(gridPos)
    if pieceBlock and self:TestPieceBlock(pieceBlock, world) then
      table.insert(obstacledPosArray, gridPos)
    end
  end
  local isInclude = filterParam:GetObstructingTrapFilter() == 1
  if isInclude then
    self:AddPosToScopeResult(scopeResult, obstacledPosArray)
  else
    self:RemovePosFromScopeResult(scopeResult, obstacledPosArray)
  end
end

function SkillScopeFilter_PieceBlock:TestPieceBlock(pieceBlockData, world)
  return true
end
