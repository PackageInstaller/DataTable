_class("PopStarPieceRefreshSystem", MainStateSystem)
PopStarPieceRefreshSystem = PopStarPieceRefreshSystem

function PopStarPieceRefreshSystem:_GetMainStateID()
  return GameStateID.PopStarPieceRefresh
end

function PopStarPieceRefreshSystem:_OnMainStateEnter(TT)
  local result = self:_DoLogicFillPiece()
  self:_DoRenderFillPiece(TT, result)
  self:_DoLogicSyncPieceType()
  self:_DoLogicSwitchState()
end

function PopStarPieceRefreshSystem:_DoLogicSwitchState()
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarPieceRefreshFinish, 1)
end

function PopStarPieceRefreshSystem:_DoLogicFillPiece()
  local popStarSvc = self._world:GetService("PopStarLogic")
  local connectPieces = popStarSvc:GetPopConnectPieces()
  if not connectPieces then
    return
  end
  if #connectPieces == 0 then
    return
  end
  local result = popStarSvc:CalculatePopPieces(connectPieces)
  return result
end

function PopStarPieceRefreshSystem:_DoRenderFillPiece(TT, result)
end
