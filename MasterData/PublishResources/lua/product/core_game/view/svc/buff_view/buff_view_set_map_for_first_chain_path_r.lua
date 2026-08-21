_class("BuffViewSetMapForFirstChainPath", BuffViewBase)
BuffViewSetMapForFirstChainPath = BuffViewSetMapForFirstChainPath

function BuffViewSetMapForFirstChainPath:PlayView(TT)
  local result = self._buffResult
  local effectID = result:GetEffectID()
  local effectOutAnim = result:GetEffectOutAnim()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  renderBoardCmpt:SetMapPieceFirstChainPathEffectID(effectID)
  renderBoardCmpt:SetMapPieceFirstChainPathEffectOutAnim(effectOutAnim)
end

function BuffViewSetMapForFirstChainPath:IsNotifyMatch(notify)
  return true
end
