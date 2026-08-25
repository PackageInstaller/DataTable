local RoleMoveState, Super = System.NewClass("RoleMoveState", RoleState)

function RoleMoveState:ctor(role)
  Super.ctor(self, role)
  self.dir = CS.UnityEngine.Vector3(0, 0, 0)
end

function RoleMoveState:Enter()
  Super.Enter(self)
  self.spineCp = self.role:GetComponent(ActorSpineComponent)
  self.phyCp = self.role:GetComponent(ActorPhyComponent)
  self.ctl = self.phyCp.ctl
  self.avatar = self.phyCp.avatar.gameObject
  self.navMeshAgent = self.avatar:GetComponent(typeof(CS.UnityEngine.AI.NavMeshAgent))
  self.actorAvatarCp = self.role:GetComponent(ActorAvatarComponent)
  self.rotY = self.actorAvatarCp:GetAvatarRotY()
  self.aimName = ""
  self.WwiseCount = 0
  self.player = RoleManager.Instance:GetRole(DataCenter.playerData.DRole.uid)
  self.footStepCom = self.player.avatarCp:GetGameObject():GetComponent(typeof(CS.ActorFootStepSoundTown))
end

function RoleMoveState:Move(x, y)
  if self.ctl ~= nil then
    self.speed = math.abs(x) > math.abs(y) and math.abs(x) or math.abs(y)
    self.dir.x = x
    self.dir.z = y
    self.dir:Normalize()
    self.dir = CS.UnityEngine.Quaternion.Euler(0, self.rotY, 0) * self.dir
    self.moveDir = self.dir
    local name1 = y > 0 and "N" or "S"
    if 0 == y then
      name1 = ""
    end
    local name2 = x > 0 and "E" or "W"
    if 0 == x then
      name2 = ""
    end
    if self.aimName and self.aimName == "Run_" .. name1 .. name2 then
      return
    end
    self.aimName = "Run_" .. name1 .. name2
    if self.aimName == "Run_" then
      return
    end
    self.phyCp:SetDirType(name1 .. name2)
    self.spineCp:PlayAnim(self.aimName, true)
  end
end

function RoleMoveState:Update()
  if self.ctl and self.moveDir and self.navMeshAgent then
    CS.Framework.PhysicsUtil.NavMeshMove(self.ctl, self.navMeshAgent, self.moveDir, self.speed * DataCenter.mapData.MoveSpeed)
  end
end

function RoleMoveState:WwiseFootStepVoice()
  if 0 == self.WwiseCount % 20 and self.footStepCom ~= nil then
    self.footStepCom:PlayFootstepSound()
  end
  self.WwiseCount = self.WwiseCount + 1
end

function RoleMoveState:Exit()
  Super.Exit(self)
  self.aimName = ""
end

return RoleMoveState
