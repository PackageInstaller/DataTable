_class("BuffViewSetChainAcrossSelectMonster", BuffViewBase)
BuffViewSetChainAcrossSelectMonster = BuffViewSetChainAcrossSelectMonster

function BuffViewSetChainAcrossSelectMonster:PlayView(TT)
  local result = self._buffResult
  local remove = result:GetRemove()
  local entityID = result:GetEntityID()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderChainPathComponent = renderBoardEntity:RenderChainPath()
  renderChainPathComponent:SetChainAcrossSelectMonster(remove, entityID)
end

function BuffViewSetChainAcrossSelectMonster:IsNotifyMatch(notify)
  local result = self._buffResult
  return true
end
