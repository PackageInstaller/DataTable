local RoleRotMoveState, Super = System.NewClass("RoleRotMoveState", RoleState)

function RoleRotMoveState:ctor(role)
  Super.ctor(self, role)
end

function RoleRotMoveState:Enter()
  Super.Enter(self)
  self.spineCp = self.role:GetComponent(ActorSpineComponent)
  self.phyCp = self.role:GetComponent(ActorPhyComponent)
  self.ctl = self.phyCp.ctl
  self.avatarCp = self.role:GetComponent(RotPlayerAvatarComponent)
  self.aimName = ""
end

function RoleRotMoveState:Move(x, y)
  if self.ctl ~= nil then
    self.speed = math.abs(x) > math.abs(y) and math.abs(x) or math.abs(y)
    local dir = CS.UnityEngine.Vector3(-x, 0, -y).normalized
    if 0 ~= x then
      local delta = x > 0 and 1 or -1
      self.avatarCp:MoveRotate(self.speed * delta * 18 * CS.UnityEngine.Time.deltaTime)
    end
    local name1 = ""
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

function RoleRotMoveState:Exit()
  Super.Exit(self)
  self.aimName = ""
end

return RoleRotMoveState
