local PVEReplayBattlePanel, Super = System.NewClass("PVEReplayBattlePanel", PVPReplayBattlePanel)

function PVEReplayBattlePanel:OnBind(binder)
  self.binder = binder
  Super.OnBind(self, binder)
end

return PVEReplayBattlePanel
