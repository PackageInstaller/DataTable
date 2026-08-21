_class("StateAVGGraphHideNodeUnlock", StateAVGGraphBase)
StateAVGGraphHideNodeUnlock = StateAVGGraphHideNodeUnlock

function StateAVGGraphHideNodeUnlock:OnEnter(TT, ...)
  self.key = "StateAVGGraphHideNodeUnlockOnEnter"
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

function StateAVGGraphHideNodeUnlock:OnExit(TT)
  GameGlobal.UIStateManager():UnLock(self.key)
end
