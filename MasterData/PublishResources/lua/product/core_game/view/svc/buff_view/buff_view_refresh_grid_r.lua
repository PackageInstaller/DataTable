_class("BuffViewRefreshGrid", BuffViewBase)
BuffViewRefreshGrid = BuffViewRefreshGrid

function BuffViewRefreshGrid:PlayView(TT, notify)
  local result = self._buffResult
  local boardServiceR = self._world:GetService("BoardRender")
  local pieceServiceR = self._world:GetService("Piece")
  for _, pos in pairs(result:GetRefreshList()) do
    boardServiceR:ReCreateGridEntity(result:GetTarget(), pos, false)
  end
end
