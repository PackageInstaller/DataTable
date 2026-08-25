local PvPTeamBuildMainOnlyEditPanel, Super = System.NewClass("PvPTeamBuildMainOnlyEditPanel", PvPTeamBuildMainPanel)

function PvPTeamBuildMainOnlyEditPanel:OnBindBottomBtn()
  Super.OnBindBottomBtn(self)
  self.binder:SetActive(self.ui.Btn_Challenge, false)
end

return PvPTeamBuildMainOnlyEditPanel
