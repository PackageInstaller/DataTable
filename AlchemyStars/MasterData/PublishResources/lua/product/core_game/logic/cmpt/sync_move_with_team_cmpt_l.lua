_class("SyncMoveWithTeamComponent", Object)
SyncMoveWithTeamComponent = SyncMoveWithTeamComponent

function SyncMoveWithTeamComponent:Constructor(entity)
  self._tarTeamEntity = entity
end

function SyncMoveWithTeamComponent:GetTeamEntity()
  return self._tarTeamEntity
end

function SyncMoveWithTeamComponent:RecordTeamMovePath(chainPath)
  self._teamMovePath = chainPath
end

function SyncMoveWithTeamComponent:GetTeamMovePath()
  return self._teamMovePath
end

function SyncMoveWithTeamComponent:RecordSyncMovePath(syncMovePath)
  self._syncMovePath = syncMovePath
end

function SyncMoveWithTeamComponent:GetSyncMovePath()
  return self._syncMovePath
end

function Entity:SyncMoveWithTeam()
  return self:GetComponent(self.WEComponentsEnum.SyncMoveWithTeam)
end

function Entity:AddSyncMoveWithTeam(entity)
  local index = self.WEComponentsEnum.SyncMoveWithTeam
  local component = SyncMoveWithTeamComponent:New(entity)
  self:AddComponent(index, component)
end

function Entity:HasSyncMoveWithTeam()
  local index = self.WEComponentsEnum.SyncMoveWithTeam
  return self:HasComponent(index)
end
