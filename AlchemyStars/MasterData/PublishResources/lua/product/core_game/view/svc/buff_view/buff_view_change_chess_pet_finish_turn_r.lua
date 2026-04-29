_class("BuffViewChangeChessPetFinishTurn", BuffViewBase)
BuffViewChangeChessPetFinishTurn = BuffViewChangeChessPetFinishTurn

function BuffViewChangeChessPetFinishTurn:PlayView(TT)
  local result = self:GetBuffResult()
  local chessSvcRender = self._world:GetService("ChessRender")
  chessSvcRender:RefreshChessPetFinishStateRender(result:GetEntityID(), result:GetFinish())
end
