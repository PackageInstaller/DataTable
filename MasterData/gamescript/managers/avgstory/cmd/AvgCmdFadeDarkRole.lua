local AvgCmdFadeDarkRole, Super = System.NewClass("AvgCmdFadeDarkRole", AvgCmdBase)

function AvgCmdFadeDarkRole:Awake()
  local darkRoleId = tonumber(self.params[1])
  local darkValue = tonumber(self.params[2] or 1)
  self.cmdComp.avgModel:FadeDarkTalkerRole(darkRoleId, darkValue)
end

return AvgCmdFadeDarkRole
