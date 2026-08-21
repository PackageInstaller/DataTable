require("scope_filter_base")
_class("SkillScopeFilter_MonsterOccupied", SkillScopeFilter_Base)
SkillScopeFilter_MonsterOccupied = SkillScopeFilter_MonsterOccupied

function SkillScopeFilter_MonsterOccupied:DoModifyRange(scopeResult, filterParam, passParam)
  local isFilter = filterParam:GetMonsterOccupiedPosFilter() == 1
  if isFilter then
    local wholeGridRange = scopeResult:GetWholeGridRange()
    local world = passParam:GetWorld()
    local utilScopeService = world:GetService("UtilScopeCalc")
    if not self._selector then
      self._selector = SkillScopeTargetSelector:New(world)
    end
    local retPosList = {}
    if world:MatchType() == MatchType.MT_BlackFist then
      local enemyTeam = world:Player():GetCurrentEnemyTeamEntity()
      local enemyPos = enemyTeam:GetGridPosition()
      if table.icontains(wholeGridRange, enemyPos) then
        retPosList[#retPosList + 1] = enemyPos
      end
    else
      for _, gridPos in ipairs(wholeGridRange) do
        local hasMonster, monsterEntityID = utilScopeService:IsPosHasMonster(gridPos)
        local monsterEntity = world:GetEntityByID(monsterEntityID)
        if hasMonster and self._selector:SelectConditionFilter(monsterEntity) then
          table.insert(retPosList, gridPos)
        end
      end
    end
    scopeResult:SetAttackRange(retPosList)
  end
end

function SkillScopeFilter_MonsterOccupied:TestPieceBlock(pieceBlockData, world)
  return true
end
