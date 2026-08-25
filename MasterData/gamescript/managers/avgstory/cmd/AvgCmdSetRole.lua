local AvgCmdSetRole, Super = System.NewClass("AvgCmdSetRole", AvgCmdBase)

function AvgCmdSetRole:Awake()
  local roleId = tonumber(self.params[1])
  local rolePos = tonumber(self.params[2]) or tonumber(self.params[3])
  local roleType = CommonDefine.AvgRoleType.Normal
  local expression
  if self.params[2] and not tonumber(self.params[2]) then
    if table.contains(table.values(CommonDefine.AvgRoleType), self.params[2]) then
      roleType = self.params[2]
    else
      expression = self.params[2]
    end
  end
  if self.params[3] and not tonumber(self.params[3]) then
    if table.contains(table.values(CommonDefine.AvgRoleType), self.params[3]) then
      roleType = self.params[3]
    else
      expression = self.params[3]
    end
  end
  local roleData = {}
  roleData.roleId = roleId
  roleData.rolePos = rolePos
  roleData.roleType = roleType
  if expression and "" ~= expression then
    roleData.expression = expression
  end
  roleData.isNew = not self.cmdComp.avgModel:GetRoleDataById(roleId)
  self.cmdComp.avgModel:AddRoleData(roleData)
end

return AvgCmdSetRole
