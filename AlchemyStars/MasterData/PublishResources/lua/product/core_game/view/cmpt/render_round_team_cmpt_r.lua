_class("RenderRoundTeamComponent", Object)

function RenderRoundTeamComponent:Constructor(roundTeam)
  self._roundTeam = roundTeam
end

function RenderRoundTeamComponent:GetRoundTeam()
  return self._roundTeam
end

function Entity:RenderRoundTeam()
  return self:GetComponent(self.WEComponentsEnum.RenderRoundTeam)
end

function Entity:HasRenderRoundTeam()
  return self:HasComponent(self.WEComponentsEnum.RenderRoundTeam)
end

function Entity:AddRenderRoundTeam()
  local index = self.WEComponentsEnum.RenderRoundTeam
  local component = RenderRoundTeamComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceRenderRoundTeam(roundTeam)
  local index = self.WEComponentsEnum.RenderRoundTeam
  local component = RenderRoundTeamComponent:New(roundTeam)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveRenderRoundTeam()
  if self:HasRenderRoundTeam() then
    self:RemoveComponent(self.WEComponentsEnum.RenderRoundTeam)
  end
end
