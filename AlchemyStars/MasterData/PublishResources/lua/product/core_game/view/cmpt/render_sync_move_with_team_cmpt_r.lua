_class("RenderSyncMoveWithTeamComponent", Object)
RenderSyncMoveWithTeamComponent = RenderSyncMoveWithTeamComponent

function RenderSyncMoveWithTeamComponent:Constructor(teamEntity)
  self._targetTeamEntity = teamEntity
  self._syncMovePath = {}
end

function RenderSyncMoveWithTeamComponent:RecordSyncMovePath(syncMovePath)
  self._syncMovePath = syncMovePath
end

function RenderSyncMoveWithTeamComponent:GetSyncMovePath()
  return self._syncMovePath
end

function RenderSyncMoveWithTeamComponent:SetGhostEntityID(ghostEntityID)
  self._ghostEntityID = ghostEntityID
end

function RenderSyncMoveWithTeamComponent:GetGhostEntityID()
  return self._ghostEntityID
end

function Entity:RenderSyncMoveWithTeam()
  return self:GetComponent(self.WEComponentsEnum.RenderSyncMoveWithTeam)
end

function Entity:HasRenderSyncMoveWithTeam()
  return self:HasComponent(self.WEComponentsEnum.RenderSyncMoveWithTeam)
end

function Entity:AddRenderSyncMoveWithTeam(teamEntity)
  local index = self.WEComponentsEnum.RenderSyncMoveWithTeam
  local component = RenderSyncMoveWithTeamComponent:New(teamEntity)
  self:AddComponent(index, component)
end

function Entity:RemoveRenderSyncMoveWithTeam()
  if self:HasRenderSyncMoveWithTeam() then
    self:RemoveComponent(self.WEComponentsEnum.RenderSyncMoveWithTeam)
  end
end
