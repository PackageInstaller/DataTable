require("scope_base")
_class("SkillScopeCalculator_CustomizableAllMonsterGrid", SkillScopeCalculator_Base)
SkillScopeCalculator_CustomizableAllMonsterGrid = SkillScopeCalculator_CustomizableAllMonsterGrid

function SkillScopeCalculator_CustomizableAllMonsterGrid:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local monsterPosList = {}
  local filterType = scopeParam[1]
  local world = self._gridFilter._world
  local utilSvc = world:GetService("UtilData")
  if world:MatchType() == MatchType.MT_BlackFist then
    if casterEntity then
      if casterEntity:HasSuperEntity() then
        casterEntity = casterEntity:GetSuperEntity()
      elseif casterEntity:HasSummoner() then
        casterEntity = casterEntity:GetSummonerEntity()
      end
      if casterEntity:HasPet() then
        local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
        local enemyEntity = teamEntity:Team():GetEnemyTeamEntity()
        monsterPosList[1] = enemyEntity:GetGridPosition()
      end
    end
  else
    local globalMonsterGroupEntities = world:GetGroupEntities(world.BW_WEMatchers.MonsterID)
    for _, e in ipairs(globalMonsterGroupEntities) do
      if self:_IsMonsterTarget(e, filterType) then
        local monster_grid_location_cmpt = e:GridLocation()
        local bodyAreaList = e:BodyArea():GetArea()
        for _, v2Body in ipairs(bodyAreaList) do
          local pos = monster_grid_location_cmpt.Position + v2Body
          table.insert(monsterPosList, pos)
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.CustomizableAllMonsterGrid, casterPos, monsterPosList, monsterPosList)
  return result
end

function SkillScopeCalculator_CustomizableAllMonsterGrid:_IsMonsterTarget(e, filterType)
  if e:HasDeadMark() then
    return false
  end
  if e.HasGhost and e:HasGhost() then
    return false
  end
  local buffComponent = e:BuffComponent()
  if buffComponent and buffComponent:HasBuffEffect(BuffEffectType.NotBeSelectedAsSkillTarget) then
    return false
  end
  local world = e:GetOwnerWorld()
  if filterType == CustomizableAllMonsterGridFilter.ForceMovement then
    local utilData = world:GetService("UtilData")
    if not utilData:IsEntityForceMovementTarget(e) then
      return false
    end
  elseif filterType == CustomizableAllMonsterGridFilter.ForceMovementIncludeMultiSize then
    local utilData = world:GetService("UtilData")
    if not utilData:IsEntityForceMovementTarget(e, true) then
      return false
    end
  end
  return true
end
