local RoleState, Super = System.NewClass("RoleState")

function RoleState:ctor(role)
  Super.ctor(self)
  self.role = role
  self.isExit = false
end

function RoleState:Enter()
  self.isExit = false
end

function RoleState:Update()
end

function RoleState:Exit()
  self.isExit = true
end

function RoleState:IsEnd()
  return self.isExit
end

return RoleState
