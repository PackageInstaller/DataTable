local PvPTeamRenamePanel, Super = System.NewClass("DBGTeamRenamePanel", DBGTeamRenamePanel)
PvPTeamRenamePanel.uiResCls = UI_Team_Popup_Tip_ChangeNameResource

function PvPTeamRenamePanel:ctor(index)
  Super.ctor(self, nil, index)
end

function PvPTeamRenamePanel:BindOldName()
  self.binder:BindToText(self.ui.Text_Old_Name, function()
    local teamName = PvPTeamBuildDataUtils.GetTeamNameByIdx(self.index)
    do return string.format, "%s%s", (LT.Text("Formation_RenameTeam_CurrentTeam_String")) end
    return string.format, "%s%s", LT.Text("Formation_RenameTeam_CurrentTeam_String"), teamName
  end)
end

function PvPTeamRenamePanel:SaveNewTeamName(newName)
  PvPTeamBuildDataUtils.ReqTeamRename(self.index, newName, function()
    self:Close()
  end)
end

return PvPTeamRenamePanel
