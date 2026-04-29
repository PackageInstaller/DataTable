_class("PlayerComponent", Object)
PlayerComponent = PlayerComponent

function PlayerComponent:Constructor(world)
  self._world = world
  self._localTeamEntity = nil
  self._remoteTeamEntity = nil
  self._previewTeamEntity = nil
  self._networkEntity = nil
end

function PlayerComponent:GetCurrentTeamEntity()
  if self._world:GetGameTurn() == GameTurnType.RemotePlayerTurn then
    return self._remoteTeamEntity
  end
  return self._localTeamEntity
end

function PlayerComponent:GetCurrentEnemyTeamEntity()
  if self._world:GetGameTurn() == GameTurnType.RemotePlayerTurn then
    return self._localTeamEntity
  end
  return self._remoteTeamEntity
end

function PlayerComponent:GetLocalTeamEntity()
  return self._localTeamEntity
end

function PlayerComponent:SetLocalTeamEntity(entity)
  self._localTeamEntity = entity
end

function PlayerComponent:IsLocalTeamEntity(entity)
  return self._localTeamEntity == entity
end

function PlayerComponent:GetRemoteTeamEntity()
  return self._remoteTeamEntity
end

function PlayerComponent:SetRemoteTeamEntity(entity)
  self._remoteTeamEntity = entity
end

function PlayerComponent:GetPreviewTeamEntity()
  return self._previewTeamEntity or self:GetCurrentTeamEntity()
end

function PlayerComponent:SetPreviewTeamEntity(entity)
  self._previewTeamEntity = entity
end

function PlayerComponent:GetPetEntityByPetPstID(pstid)
  local group = self._world:GetGroup(self._world.BW_WEMatchers.PetPstID)
  for i, e in ipairs(group:GetEntities()) do
    if e:PetPstID():GetPstID() == pstid then
      return e
    end
  end
end

function PlayerComponent:GetAllTeamEntities()
  return {
    self._localTeamEntity,
    self._remoteTeamEntity
  }
end

function PlayerComponent:SetAddPartnerTempTeam(tempTeamEntity)
  self._addPartnerTempTeam = tempTeamEntity
end

function PlayerComponent:GetAddPartnerTempTeam()
  return self._addPartnerTempTeam
end

function PlayerComponent:IsAddingPartner()
  return self._addPartnerTempTeam ~= nil
end

function PlayerComponent:SendCommand(cmd)
  self._networkEntity:PushCommand(cmd)
end

function PlayerComponent:SetNetworkEntity(networkEntity)
  self._networkEntity = networkEntity
end

function PlayerComponent:GetNetworkEntity()
  return self._networkEntity
end

function BaseWorld:Player()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.Player)
end

function BaseWorld:HasPlayer()
  return self:HasUniqueComponent(self.BW_UniqueComponentsEnum.Player)
end

function BaseWorld:AddPlayer()
  local component = PlayerComponent:New(self)
  local index = self.BW_UniqueComponentsEnum.Player
  self:SetUniqueComponent(index, component)
  return component
end

function BaseWorld:RemovePlayer()
  if self:HasPlayer() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.Player, nil)
  end
end
