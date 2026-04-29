_class("LogicRoundTeamComponent", Object)

function LogicRoundTeamComponent:Constructor()
  self._roundTeam = {}
end

function LogicRoundTeamComponent:GetPetRoundTeam()
  return self._roundTeam
end

function LogicRoundTeamComponent:AddPetToRoundTeam(entityID)
  if not table.icontains(self._roundTeam, entityID) then
    self._roundTeam[#self._roundTeam + 1] = entityID
  end
end

function LogicRoundTeamComponent:ClearLogicRoundTeam()
  self._roundTeam = {}
end

function Entity:LogicRoundTeam()
  return self:GetComponent(self.WEComponentsEnum.LogicRoundTeam)
end

function Entity:HasLogicRoundTeam()
  return self:HasComponent(self.WEComponentsEnum.LogicRoundTeam)
end

function Entity:AddLogicRoundTeam()
  local index = self.WEComponentsEnum.LogicRoundTeam
  local component = LogicRoundTeamComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceLogicRoundTeam()
  local index = self.WEComponentsEnum.LogicRoundTeam
  local component = LogicRoundTeamComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveLogicRoundTeam()
  if self:HasLogicRoundTeam() then
    self:RemoveComponent(self.WEComponentsEnum.LogicRoundTeam)
  end
end
