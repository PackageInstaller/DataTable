_class("TeamComponent", Object)
TeamComponent = TeamComponent

function TeamComponent:Constructor()
  self._teamLeader = nil
  self._teamPetEntities = nil
  self._teamOrder = {}
  self._teamPetEntityDict = {}
  self._helpPetPstID = nil
  self._selectedTeamOrderPosition = 0
  self._cmdOldTeamOrder = {}
  self._cmdNewTeamOrder = {}
  self._autoBeadSkillHolderID = -1
end

function TeamComponent:GetTeamLeaderEntity()
  return self._teamLeader
end

function TeamComponent:GetTeamLeaderEntityID()
  return self._teamLeader:GetID()
end

function TeamComponent:GetTeamLeaderPetPstID()
  return self._teamLeader:PetPstID():GetPstID()
end

function TeamComponent:SetTeamLeader(entity)
  self._teamLeader = entity
end

function TeamComponent:SetOriginalTeamLeaderID(entityID)
  self._originalTeamLeaderID = entityID
end

function TeamComponent:GetOriginalTeamLeaderID()
  return self._originalTeamLeaderID
end

function TeamComponent:GetTeamPetEntities()
  return self._teamPetEntities
end

function TeamComponent:SetTeamPetEntities(pets)
  self._teamPetEntities = pets
  for _, e in ipairs(pets) do
    self._teamPetEntityDict[e:PetPstID():GetPstID()] = e
  end
end

function TeamComponent:ClearTeamPetEntities()
  self._teamPetEntities = {}
  self._teamPetEntityDict = {}
  self._teamOrder = {}
end

function TeamComponent:GetPetEntityByPetPstID(pstid)
  return self._teamPetEntityDict[pstid]
end

function TeamComponent:SetTeamOrder(teamOrder)
  self._teamOrder = teamOrder
end

function TeamComponent:GetTeamOrder()
  return self._teamOrder
end

function TeamComponent:GetTeamIndexByPetPstID(petPstID)
  for i, v in ipairs(self._teamOrder) do
    if v == petPstID then
      return i
    end
  end
end

function TeamComponent:GetPetEntityByTeamIndex(petIndex)
  local petPstID = self._teamOrder[petIndex]
  local petEntity = self:GetPetEntityByPetPstID(petPstID)
  return petEntity
end

function TeamComponent:ChangeTeamLeader(newLeaderPetPstID)
  local newLeaderIndex = self:GetTeamIndexByPetPstID(newLeaderPetPstID)
  self._teamOrder[1], self._teamOrder[newLeaderIndex] = self._teamOrder[newLeaderIndex], self._teamOrder[1]
end

function TeamComponent:GetEnemyTeamEntity()
  return self._enemyTeamEntity
end

function TeamComponent:SetEnemyTeamEntity(teamEntity)
  self._enemyTeamEntity = teamEntity
end

function TeamComponent:IsTeamLeaderByEntityId(entityId)
  return self:GetTeamLeaderEntityID() == entityId
end

function TeamComponent:SetHelpPetPstID(val)
  self._helpPetPstID = val
end

function TeamComponent:GetHelpPetPstID()
  return self._helpPetPstID
end

function TeamComponent:CloneTeamOrder()
  local t = {}
  for k, v in pairs(self._teamOrder) do
    t[k] = v
  end
  return t
end

function TeamComponent:SetSelectedTeamOrderPosition(v)
  self._selectedTeamOrderPosition = v
end

function TeamComponent:ClearSelectedTeamOrderPosition()
  self._selectedTeamOrderPosition = 0
end

function TeamComponent:GetSelectedTeamOrderPosition()
  return self._selectedTeamOrderPosition
end

function TeamComponent:SetChangeTeamLeaderCmdData(oldTeamOrder, newTeamOrder)
  self._cmdOldTeamOrder = oldTeamOrder
  self._cmdNewTeamOrder = newTeamOrder
end

function TeamComponent:GetChangeTeamLeaderCmdData()
  return self._cmdOldTeamOrder, self._cmdNewTeamOrder
end

function TeamComponent:SetAutoBeadSkillHolderID(entityID)
  self._autoBeadSkillHolderID = entityID
end

function TeamComponent:GetAutoBeadSkillHolderID()
  return self._autoBeadSkillHolderID
end

function Entity:Team()
  return self:GetComponent(self.WEComponentsEnum.Team)
end

function Entity:HasTeam()
  return self:HasComponent(self.WEComponentsEnum.Team)
end

function Entity:AddTeam()
  local index = self.WEComponentsEnum.Team
  local component = TeamComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceTeam()
  local index = self.WEComponentsEnum.Team
  local component = TeamComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveTeam()
  if self:HasTeam() then
    self:RemoveComponent(self.WEComponentsEnum.Team)
  end
end

function Entity:SetTeamLeaderPetEntity(petEntity)
  if not self:HasTeam() then
    local index = self.WEComponentsEnum.Team
    local component = TeamComponent:New()
    self:AddComponent(index, component)
  end
  local team = self:Team()
  local petPstID = petEntity:PetPstID():GetPstID()
  team:SetTeamLeader(petEntity)
  team:ChangeTeamLeader(petPstID)
  local element = petEntity:Element()
  self:ReplaceElement(element:GetPrimaryType(), element:GetSecondaryType())
end

function Entity:GetTeamLeaderPetEntity()
  if not self:HasTeam() then
    return nil
  end
  local team = self:Team()
  local teamLeaderPetEntity = team:GetTeamLeaderEntity()
  return teamLeaderPetEntity
end
