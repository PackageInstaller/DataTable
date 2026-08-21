require("pop_star_pro_piece_refresh_system")
_class("PopStarProPieceRefreshSystem_Render", PopStarProPieceRefreshSystem)
PopStarProPieceRefreshSystem_Render = PopStarProPieceRefreshSystem_Render

function PopStarProPieceRefreshSystem_Render:_DoRenderFillPiece(TT, result)
  if not result then
    return
  end
  local popStarRSvc = self._world:GetService("PopStarProRender")
  popStarRSvc:PlayPopStarResult(TT, result)
end
