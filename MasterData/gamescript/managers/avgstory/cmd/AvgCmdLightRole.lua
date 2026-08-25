local AvgCmdLightRole, Super = System.NewClass("AvgCmdLightRole", AvgCmdBase)

function AvgCmdLightRole:Awake()
  local lightRoleId = tonumber(self.params[1])
  local lightValue = tonumber(self.params[2] or 1)
  self.cmdComp.avgModel:LightTalkerRole(lightRoleId, lightValue)
end

return AvgCmdLightRole
