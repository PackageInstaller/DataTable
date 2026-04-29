_class("BuffViewSetChainAcrossMonster", BuffViewBase)
BuffViewSetChainAcrossMonster = BuffViewSetChainAcrossMonster

function BuffViewSetChainAcrossMonster:PlayView(TT)
  local result = self._buffResult
  local remove = result:GetRemove()
  local moveEffect = result:GetMoveEffect()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderChainPathComponent = renderBoardEntity:RenderChainPath()
  renderChainPathComponent:SetChainAcrossMonster(remove == 0)
  renderChainPathComponent:SetChainAcrossMonsterMoveEffect(moveEffect)
end

function BuffViewSetChainAcrossMonster:IsNotifyMatch(notify)
  local result = self._buffResult
  return true
end
