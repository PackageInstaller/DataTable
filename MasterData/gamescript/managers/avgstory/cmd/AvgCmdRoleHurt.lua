local AvgCmdRoleHurt = System.NewClass("AvgCmdRoleHurt", AvgCmdBase)

function AvgCmdRoleHurt:Awake()
  for _, roleId in pairs(self.params) do
    roleId = tonumber(roleId)
    if roleId then
      local roleData = self.cmdComp.avgModel:GetRoleDataById(roleId)
      self.cmdComp.avgModel:SetRoleShake(roleData, {roleId})
    end
  end
end

return AvgCmdRoleHurt
