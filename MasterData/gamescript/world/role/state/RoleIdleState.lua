local RoleIdleState, Super = System.NewClass("RoleIdleState", RoleState)

function RoleIdleState:ctor(role)
  Super.ctor(self, role)
end

function RoleIdleState:Enter()
  Super.Enter(self)
  self:PlayIdle()
end

function RoleIdleState:ChangeDir()
  self:PlayIdle()
end

function RoleIdleState:PlayIdle()
  local spineCp = self.role:GetComponent(ActorSpineComponent)
  local phyCp = self.role:GetComponent(ActorPhyComponent)
  spineCp:PlayAnim("Idle_" .. phyCp:GetDirType(), true)
end

return RoleIdleState
