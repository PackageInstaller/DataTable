_class("PieceMultiServiceRender", Object)
PieceMultiServiceRender = PieceMultiServiceRender

function PieceMultiServiceRender:Constructor(world)
  self._world = world
  self._multiBoard = {}
  self._pieceService = self._world:GetService("Piece")
end

function PieceMultiServiceRender:GetCurBoard(boardIndex)
  if not self._multiBoard then
    self._multiBoard = {}
  end
  if not self._multiBoard[boardIndex] then
    self._multiBoard[boardIndex] = {}
  end
  local curBoard = self._multiBoard[boardIndex]
  return curBoard
end

function PieceMultiServiceRender:FindPieceEntity(boardIndex, pos)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderMultiBoardCmpt = renderBoardEntity:RenderMultiBoard()
  return renderMultiBoardCmpt:GetGridRenderEntity(boardIndex, pos)
end

function PieceMultiServiceRender:SetPieceRenderEffect(boardIndex, pos, effectType)
  local curPieceEffectType = self:GetPieceEffectType(boardIndex, pos)
  if curPieceEffectType == effectType then
    return
  end
  local pieceEntity = self:FindPieceEntity(boardIndex, pos)
  local pieceComponent = pieceEntity:Piece()
  pieceComponent:SetRenderPieceEffectType(effectType)
  self:ResetPieceAnimation(boardIndex, pos)
  local curPiecePrefabObj = pieceComponent:GetBaseLayerObj()
  if curPiecePrefabObj then
    curPiecePrefabObj.transform.localEulerAngles = Vector3(0, 0, 0)
  end
end

function PieceMultiServiceRender:GetPieceEffectType(boardIndex, pos)
  local pieceEntity = self:FindPieceEntity(boardIndex, pos)
  if not pieceEntity then
    return PieceEffectType.Normal
  end
  local pieceComponent = pieceEntity:Piece()
  local curPieceEffectType = pieceComponent:GetRenderPieceEffectType()
  return curPieceEffectType
end

function PieceMultiServiceRender:SetPieceAnimUp(boardIndex, pos)
  self:SetPieceAnimation(boardIndex, pos, "Up")
end

function PieceMultiServiceRender:SetPieceAnimDown(boardIndex, pos)
  self:SetPieceAnimation(boardIndex, pos, "Down")
end

function PieceMultiServiceRender:SetPieceAnimation(boardIndex, pos, anim, force, param)
  local pieceEntity = self:FindPieceEntity(boardIndex, pos)
  if not pieceEntity then
    return
  end
  local pieceComponent = pieceEntity:Piece()
  local curAnim = pieceComponent:GetPieceAnimName()
  if curAnim == anim and not force then
    return
  end
  self._pieceService:_OnHidePiecePrefabSameLayer(pieceEntity, curAnim, anim)
  self._pieceService:_OnCheckShowCurPieceTypePrefab(pieceEntity)
  pieceComponent:SetPieceAnimName(anim)
  local applyFunc = self._pieceService.applyPieceAnimation[anim]
  if applyFunc ~= nil then
    applyFunc(self._pieceService, pos, pieceEntity, anim, param)
  end
end

function PieceMultiServiceRender:ResetPieceAnimation(boardIndex, pos)
  local curAnim = self:GetPieceAnimation(boardIndex, pos)
  if curAnim then
    local forcePlay = true
    self:SetPieceAnimation(boardIndex, pos, curAnim, forcePlay)
  end
end

function PieceMultiServiceRender:GetPieceAnimation(boardIndex, pos)
  local pieceEntity = self:FindPieceEntity(boardIndex, pos)
  if not pieceEntity then
    return
  end
  local pieceComponent = pieceEntity:Piece()
  local curAnim = pieceComponent:GetPieceAnimName()
  return curAnim
end
