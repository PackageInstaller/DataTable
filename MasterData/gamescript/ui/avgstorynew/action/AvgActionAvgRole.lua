local AvgActionAvgRole = System.NewClass("AvgActionAvgRole", AvgActionBase)

function AvgActionAvgRole:DoAction(_, _, finishCb)
  self.avgPanel.roleComp:SetRoleList()
  self.avgPanel.roleComp:DoEnterDialog()
  finishCb()
end

return AvgActionAvgRole
