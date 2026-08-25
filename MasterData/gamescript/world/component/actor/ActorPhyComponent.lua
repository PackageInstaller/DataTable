local ActorPhyComponent, Super = System.NewClass("ActorPhyComponent", Component)

function ActorPhyComponent:ctor(needBox)
  Super.ctor(self)
  self.dirType = CommonDefine.RoleDirType.E
  self.needBox = needBox
end

function ActorPhyComponent:Awake()
  Super.Awake(self)
  self.avatar = self.parent:GetComponent(ActorAvatarComponent)
  if self.needBox then
    CS.Framework.GameObjectUtil.AddComponentOnce(self.avatar.gameObject, typeof(CS.UnityEngine.BoxCollider))
    self.box = self.avatar.gameObject:GetComponent(typeof(CS.UnityEngine.BoxCollider))
    self.box.enabled = true
    self.box.size = CS.UnityEngine.Vector3(2, 3, 2)
    self.box.center = CS.UnityEngine.Vector3(0, 1.5, 0)
  end
  CS.Framework.GameObjectUtil.AddComponentOnce(self.avatar.gameObject, typeof(CS.UnityEngine.CharacterController))
  self.ctl = self.avatar.gameObject:GetComponent(typeof(CS.UnityEngine.CharacterController))
  self.ctl.enabled = true
  self.ctl.slopeLimit = 70
  self.ctl.stepOffset = 1.3
  self.ctl.radius = 1
  self.ctl.height = 3
  self.ctl.skinWidth = 0.001
  self.ctl.center = CS.UnityEngine.Vector3(0, 1.44, 0)
  self:SetDirType(CommonDefine.RoleDirType.E)
end

function ActorPhyComponent:SetDirType(dir)
  self.dirType = dir
  local stateCp = self.parent:GetComponent(ActorStateComponent)
  if stateCp then
    stateCp:ChangeDir()
  end
end

function ActorPhyComponent:GetDirType()
  return self.dirType
end

function ActorPhyComponent:OnDestroy()
  Super.OnDestroy(self)
  if self.ctl then
    self.ctl.enabled = false
  end
  if self.box then
    self.box.enabled = false
  end
end

return ActorPhyComponent
