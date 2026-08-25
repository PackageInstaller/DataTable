local AvgCmdDarkRole, Super = System.NewClass("AvgCmdDarkRole", AvgCmdBase)

function AvgCmdDarkRole:Awake()
  local darkRoleId = tonumber(self.params[1])
  local darkValue = tonumber(self.params[2] or 1)
  self.cmdComp.avgModel:DarkTalkerRole(darkRoleId, darkValue)
end

return AvgCmdDarkRole
