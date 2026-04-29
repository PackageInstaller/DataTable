require("scope_base")
_class("SkillScopeCalculator_FriendTeamGrid", SkillScopeCalculator_Base)
SkillScopeCalculator_FriendTeamGrid = SkillScopeCalculator_FriendTeamGrid

function SkillScopeCalculator_FriendTeamGrid:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local targetArea = {}
  local wholeArea = {}
  if casterEntity:HasSuperEntity() then
    casterEntity = casterEntity:SuperEntityComponent():GetSuperEntity()
  end
  local teamEntity
  if casterEntity:HasTeam() then
    teamEntity = casterEntity
  elseif casterEntity:HasPet() then
    teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  else
    local world = self._gridFilter._world
    teamEntity = world:Player():GetCurrentTeamEntity()
  end
  local teamPos = teamEntity:GetGridPosition()
  local targetIds = {
    teamEntity:GetID()
  }
  self:_InsertTargetGrid(targetArea, teamPos, wholeArea)
  local result = SkillScopeResult:New(SkillScopeType.FriendTeamGrid, teamPos, targetArea, wholeArea, targetIds)
  return result
end
