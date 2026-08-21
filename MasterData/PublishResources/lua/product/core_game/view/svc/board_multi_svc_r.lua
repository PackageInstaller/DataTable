require("base_service")
_class("BoardMultiServiceRender", BaseService)
BoardMultiServiceRender = BoardMultiServiceRender

function BoardMultiServiceRender:Constructor(world)
end

function BoardMultiServiceRender:CreateGridEntity(boardIndex, pieceType, piecePos, isHide, boardRoot)
  local sEntity = self._world:GetService("RenderEntity")
  local gridEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.Grid)
  gridEntity:ReplaceOutsideRegion(boardIndex)
  self:_InitGridEntity(boardIndex, gridEntity, pieceType, piecePos, boardRoot)
  return gridEntity
end

function BoardMultiServiceRender:ReCreateGridEntity(boardIndex, pieceType, gridPos, isHide, needBirthEffect)
  local pieceServiceRender = self._world:GetService("Piece")
  local pieceMultiServiceRender = self._world:GetService("PieceMulti")
  local newGridEntity = pieceMultiServiceRender:FindPieceEntity(boardIndex, gridPos)
  if newGridEntity == nil then
    return
  end
  self:_InitGridEntity(boardIndex, newGridEntity, pieceType, gridPos)
  if needBirthEffect then
    pieceServiceRender:SetPieceEntityBirth(newGridEntity)
  end
  Log.debug("ReCreateGridEntity boardIndex=" .. boardIndex .. " gridPos=", Vector2.Pos2Index(gridPos), " pieceType=", pieceType)
  return newGridEntity
end

function BoardMultiServiceRender:_InitGridEntity(boardIndex, gridEntity, pieceType, piecePos, boardRoot)
  gridEntity:RemoveOutsideRegion()
  gridEntity:AddOutsideRegion(boardIndex)
  local pieceServiceRender = self._world:GetService("Piece")
  pieceServiceRender:SetPieceEntityPieceType(gridEntity, pieceType)
  if boardRoot and gridEntity:View() then
    gridEntity:View():GetGameObject().transform.parent = boardRoot.transform
  end
  gridEntity:SetGridPosition(piecePos)
  gridEntity:SetPosition(piecePos)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderMultiBoardCmpt = renderBoardEntity:RenderMultiBoard()
  renderMultiBoardCmpt:SetGridRenderEntityData(boardIndex, piecePos, gridEntity)
end
