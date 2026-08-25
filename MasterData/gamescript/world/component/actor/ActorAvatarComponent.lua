local ActorAvatarComponent, Super = System.NewClass("ActorAvatarComponent", Component)

function ActorAvatarComponent:ctor()
  Super.ctor(self)
end

function ActorAvatarComponent:Awake()
  Super.Awake(self)
  self:InitAvatarPath()
end

function ActorAvatarComponent:AsyncLoadEnd()
  self:SetAvatarRot(0, 0, 0)
  self.transform = self.gameObject.transform
end

function ActorAvatarComponent:InitAvatarPath()
  self.path = "GameBasePrefab/Player.prefab"
  self.modeTid = 13
end

function ActorAvatarComponent:GetPosition()
  return self.pos
end

function ActorAvatarComponent:GetHead()
  return self.gameObject.transform.position + CS.UnityEngine.Vector3.up * 1.5
end

function ActorAvatarComponent:SetPosition(x, y, z)
  self.gameObject.transform.position = CS.UnityEngine.Vector3(x, y, z)
  self.pos = {
    x = x,
    y = y,
    z = z
  }
end

function ActorAvatarComponent:GetGameObject()
  return self.gameObject
end

function ActorAvatarComponent:FindGameObject(name)
  do return UIRootMgr.FindChild, self.gameObject.transform end
  return UIRootMgr.FindChild, self.gameObject.transform, name
end

function ActorAvatarComponent:GetBoneNode(boneName)
  do return UIRootMgr.FindChild, self.gameObject.transform end
  return UIRootMgr.FindChild, self.gameObject.transform, boneName
end

function ActorAvatarComponent:SetAvatarRot(x, y, z)
  self.gameObject.transform.localEulerAngles = CS.UnityEngine.Vector3(x, y, z)
end

function ActorAvatarComponent:GetAvatarRotY()
  return self.gameObject.transform.localEulerAngles.y
end

function ActorAvatarComponent:DestroyAll()
end

function ActorAvatarComponent:GetCameraTargetTransform()
  return nil
end

function ActorAvatarComponent:OnDestroy()
  Super.OnDestroy(self)
  self:DestroyAll()
  if self.gameObject then
    self.gameObject = nil
  end
end

return ActorAvatarComponent
