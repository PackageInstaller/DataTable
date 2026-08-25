local RoleSmoothMoveState, Super = System.NewClass("RoleSmoothMoveState", RoleState)

function RoleSmoothMoveState:ctor(role)
  Super.ctor(self, role)
end

function RoleSmoothMoveState:Enter()
  Super.Enter(self)
  self.spineCp = self.role:GetComponent(ActorSpineComponent)
  self.phyCp = self.role:GetComponent(ActorPhyComponent)
  self.stateCp = self.role:GetComponent(NpcStateComponent)
  self.ctl = self.phyCp.ctl
  self.avatar = self.phyCp.avatar.gameObject
  self.navMeshAgent = self.avatar:GetComponent(typeof(CS.UnityEngine.AI.NavMeshAgent))
  self.actorAvatarCp = self.role:GetComponent(ActorAvatarComponent)
  self.rotY = self.actorAvatarCp:GetAvatarRotY()
  self.aimName = ""
end

function RoleSmoothMoveState:Update()
  if self.ctl ~= nil and self.navMeshAgent and self.pos and not self.isExit then
    local offset = self.pos - self.actorAvatarCp:GetPosition()
    if offset.sqrMagnitude > 0.1 then
      local normalizeOffset = offset.normalized
      local dir = CS.UnityEngine.Vector3(normalizeOffset.x, 0, normalizeOffset.z)
      CS.Framework.PhysicsUtil.NavMeshMove(self.ctl, self.navMeshAgent, dir, DataCenter.mapData.MoveSpeed * 0.2)
    else
      self:Exit()
    end
  end
end

function RoleSmoothMoveState:Move(x, y, z)
  if self.ctl ~= nil then
    self.pos = CS.UnityEngine.Vector3(x, y, z)
    self.stateCp:FaceTo(x, y, z)
  end
end

function RoleSmoothMoveState:Exit()
  Super.Exit(self)
  self.aimName = ""
end

return RoleSmoothMoveState
