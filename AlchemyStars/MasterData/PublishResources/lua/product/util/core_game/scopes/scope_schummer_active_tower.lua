require("scope_base")
_class("SkillScopeCalculator_SchummerActiveTower", SkillScopeCalculator_Base)
SkillScopeCalculator_SchummerActiveTower = SkillScopeCalculator_SchummerActiveTower
local __TowerLogicPos = {
  LT = Vector2.New(1, 8),
  LB = Vector2.New(1, 1),
  RT = Vector2.New(8, 8),
  RB = Vector2.New(8, 1)
}
local __TowerRealm = {
  LT = {
    minX = 1,
    maxX = 4,
    minY = 6,
    maxY = 9
  },
  LB = {
    minX = 1,
    maxX = 4,
    minY = 1,
    maxY = 4
  },
  RT = {
    minX = 6,
    maxX = 9,
    minY = 6,
    maxY = 9
  },
  RB = {
    minX = 6,
    maxX = 9,
    minY = 1,
    maxY = 4
  }
}

function SkillScopeCalculator_SchummerActiveTower:GenerateTowerRealm(v2TowerLogicPos)
  local attackRange = {}
  local wholeRange = {}
  local gridFilter = self._gridFilter
  local realmEdge = {}
  if v2TowerLogicPos == __TowerLogicPos.LT then
    realmEdge = __TowerRealm.LT
  elseif v2TowerLogicPos == __TowerLogicPos.LB then
    realmEdge = __TowerRealm.LB
  elseif v2TowerLogicPos == __TowerLogicPos.RT then
    realmEdge = __TowerRealm.RT
  elseif v2TowerLogicPos == __TowerLogicPos.RB then
    realmEdge = __TowerRealm.RB
  end
  for x = realmEdge.minX, realmEdge.maxX do
    for y = realmEdge.minY, realmEdge.maxY do
      local v2 = Vector2.New(x, y)
      table.insert(wholeRange, v2)
      if gridFilter:IsValidPiecePos(v2) then
        table.insert(attackRange, v2)
      end
    end
  end
  return attackRange, wholeRange
end

function SkillScopeCalculator_SchummerActiveTower:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if not self._gridFilter or not self._gridFilter._world then
    return SkillScopeResult:New(SkillScopeType.SchummerActiveTower, centerPos, {}, {})
  end
  local world = self._gridFilter._world
  local curseTowerGroupEntities = world:GetGroupEntities(world.BW_WEMatchers.CurseTower)
  if not curseTowerGroupEntities or #curseTowerGroupEntities <= 0 then
    return SkillScopeResult:New(SkillScopeType.SchummerActiveTower, centerPos, {}, {})
  end
  local attackRange = {}
  local wholeArea = {}
  for _, eTower in ipairs(curseTowerGroupEntities) do
    if eTower:CurseTower():GetTowerState() ~= CurseTowerState.Deactive then
      local v2LogicPos = eTower:GetGridPosition()
      local a, w = self:GenerateTowerRealm(v2LogicPos)
      table.appendArray(attackRange, a)
      table.appendArray(wholeArea, w)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.SchummerActiveTower, centerPos, attackRange, wholeArea)
  return result
end
