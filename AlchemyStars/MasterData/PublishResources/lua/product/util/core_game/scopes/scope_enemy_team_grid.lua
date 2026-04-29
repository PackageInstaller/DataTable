require("scope_base")
_class("SkillScopeCalculator_EnemyTeamGrid", SkillScopeCalculator_Base)
SkillScopeCalculator_EnemyTeamGrid = SkillScopeCalculator_EnemyTeamGrid

function SkillScopeCalculator_EnemyTeamGrid:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local targetArea = {}
  local wholeArea = {}
  if casterEntity:HasSuperEntity() then
    casterEntity = casterEntity:SuperEntityComponent():GetSuperEntity()
  end
  local teamEntity
  if casterEntity:EntityType():IsPersonaSkillHolder() then
    teamEntity = casterEntity:GetOwnerWorld():Player():GetLocalTeamEntity()
  elseif casterEntity:EntityType():IsAutoBeadSkillHolder() then
    teamEntity = casterEntity:GetOwnerWorld():Player():GetCurrentTeamEntity()
  else
    teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  end
  local enemyEntity = teamEntity:Team():GetEnemyTeamEntity()
  local enemyPos = enemyEntity:GetGridPosition()
  local targetIds = {
    enemyEntity:GetID()
  }
  self:_InsertTargetGrid(targetArea, enemyPos, wholeArea)
  local result = SkillScopeResult:New(SkillScopeType.EnemyTeamGrid, enemyPos, targetArea, wholeArea, targetIds)
  return result
end
