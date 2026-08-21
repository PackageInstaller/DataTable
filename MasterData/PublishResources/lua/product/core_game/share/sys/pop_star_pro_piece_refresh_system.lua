_class("PopStarProPieceRefreshSystem", MainStateSystem)
PopStarProPieceRefreshSystem = PopStarProPieceRefreshSystem

function PopStarProPieceRefreshSystem:_GetMainStateID()
  return GameStateID.PieceRefresh
end

function PopStarProPieceRefreshSystem:_OnMainStateEnter(TT)
  local result = self:_DoLogicFillPiece()
  self:_DoRenderFillPiece(TT, result)
  self:_DoLogicSyncPieceType()
  self:_DoLogicSwitchState()
end

function PopStarProPieceRefreshSystem:_DoLogicSwitchState()
  self._world:EventDispatcher():Dispatch(GameEventType.PieceRefreshFinish, 1)
end

function PopStarProPieceRefreshSystem:_DoLogicFillPiece()
  local popStarProSvc = self._world:GetService("PopStarProLogic")
  local connectPieces = popStarProSvc:GetPopConnectPieces()
  if not connectPieces then
    return
  end
  if #connectPieces == 0 then
    return
  end
  local result = popStarProSvc:CalculatePopPieces(connectPieces)
  return result
end

function PopStarProPieceRefreshSystem:_DoRenderFillPiece(TT, result)
end
