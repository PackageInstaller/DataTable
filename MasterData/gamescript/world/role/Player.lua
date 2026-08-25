local Player, Super = System.NewClass("Player", ActorEntity)

function Player:ctor(uid, tid)
  Super.ctor(self, uid, tid)
end

function Player:Awake()
  self.avatarCp = self:AddComponent(PlayerAvatarComponent)
  self.sightCp = self:AddComponent(PlayerSightComponent)
end

function Player:AsyncLoadEnd()
  self:AddComponent(PlayerCameraComponent)
  self:AddComponent(ActorPhyComponent)
  self.animCp = self:AddComponent(ActorSpineComponent)
  self:AddComponent(PlayerStateComponent)
  Super.AsyncLoadEnd(self)
end

function Player:InitError()
  if not self.avatarCp then
    self.avatarCp = self:GetComponent(PlayerAvatarComponent)
  end
end

function Player:OpenNevAgent()
  self:InitError()
  self.avatarCp:OpenNevAgent()
end

function Player:CloseNevAgent()
  self:InitError()
  self.avatarCp:CloseNevAgent()
end

function Player:GetNevAgentEnabled()
  self:InitError()
  do return self.avatarCp.GetNevAgentEnabled end
  return self.avatarCp.GetNevAgentEnabled, self.avatarCp
end

function Player:GetPosition()
  self:InitError()
  do return self.avatarCp.GetPosition end
  return self.avatarCp.GetPosition, self.avatarCp
end

function Player:SetPosition(x, y, z)
  self:InitError()
  self.avatarCp:SetPosition(x, y, z)
end

function Player:GetGameObject()
  self:InitError()
  do return self.avatarCp.GetGameObject end
  return self.avatarCp.GetGameObject, self.avatarCp
end

function Player:GetSightRadius()
  if self.sightCp then
    do return self.sightCp.GetSightRadius end
    return self.sightCp.GetSightRadius, self.sightCp
  end
end

function Player:GetHead()
  self:InitError()
  do return self.avatarCp.FindGameObject, self.avatarCp end
  return self.avatarCp.FindGameObject, self.avatarCp, "Head"
end

function Player:SetSightRadius(radius)
  if tonumber(radius) == nil then
    return
  end
  if self.sightCp then
    self.sightCp:SetSightRadius(tonumber(radius))
  end
end

return Player
