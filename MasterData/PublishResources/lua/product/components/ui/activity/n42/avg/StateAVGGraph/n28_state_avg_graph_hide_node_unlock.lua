_class("N28StateAVGGraphHideNodeUnlock", N28StateAVGGraphBase)
N28StateAVGGraphHideNodeUnlock = N28StateAVGGraphHideNodeUnlock

function N28StateAVGGraphHideNodeUnlock:OnEnter(TT, ...)
  self.key = "N28StateAVGGraphHideNodeUnlockOnEnter"
  GameGlobal.UIStateManager():Lock(self.key)
  self:Init()
  local nodeId = table.unpack({
    ...
  })
  if nodeId then
    local ui = self.ui:GetWidgetHdie(nodeId)
    if ui then
      ui:PlayAnim(TT)
    end
  end
  self:ChangeState(StateAVGGraph.Init)
end

function N28StateAVGGraphHideNodeUnlock:OnExit(TT)
  GameGlobal.UIStateManager():UnLock(self.key)
end
