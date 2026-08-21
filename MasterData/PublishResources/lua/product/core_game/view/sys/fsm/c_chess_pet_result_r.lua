require("chess_pet_result_system")
_class("ClientChessPetResultSystem_Render", ChessPetResultSystem)
ClientChessPetResultSystem_Render = ClientChessPetResultSystem_Render

function ClientChessPetResultSystem_Render:_DoRenderHandleChessPetResult(TT, isAllChessPetTurnEnd, isWaveEnded)
  if isAllChessPetTurnEnd then
    self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.HideAll)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateBlockRaycast, not isWaveEnded)
end
