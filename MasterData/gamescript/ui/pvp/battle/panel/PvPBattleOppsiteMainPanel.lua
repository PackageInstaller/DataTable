local PvPBattleOppsiteMainPanel, Super = System.NewClass("PvPBattleOppsiteMainPanel", PvPBattleMainPanel)

function PvPBattleOppsiteMainPanel:InitCamp()
  self.myCamp = bg.battleDataCenter:GetEnemyCamp()
  self.enemyCamp = bg.battleDataCenter:GetMyCamp()
end

function PvPBattleOppsiteMainPanel:OnBind(binder)
  Super.OnBind(self, binder)
  UIBasePanel.SetRendered(self, false)
end

return PvPBattleOppsiteMainPanel
