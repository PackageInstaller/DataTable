local AvgCmdHideRole, Super = System.NewClass("AvgCmdHideRole", AvgCmdBase)

function AvgCmdHideRole:Awake()
  local roleData = self.cmdComp.avgModel:GetRoleDataById(self.params[1])
  roleData.isHide = true
end

return AvgCmdHideRole
