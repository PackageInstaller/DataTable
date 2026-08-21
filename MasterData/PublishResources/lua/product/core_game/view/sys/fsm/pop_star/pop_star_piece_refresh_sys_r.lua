require("pop_star_piece_refresh_system")
_class("PopStarPieceRefreshSystem_Render", PopStarPieceRefreshSystem)
PopStarPieceRefreshSystem_Render = PopStarPieceRefreshSystem_Render

function PopStarPieceRefreshSystem_Render:_DoRenderFillPiece(TT, result)
  if not result then
    return
  end
  local popStarRSvc = self._world:GetService("PopStarRender")
  popStarRSvc:PlayPopStarResult(TT, result)
end
