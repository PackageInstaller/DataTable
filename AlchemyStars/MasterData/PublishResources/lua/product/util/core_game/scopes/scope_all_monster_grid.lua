require("scope_base")
_class("SkillScopeCalculator_AllMonsterGrid", SkillScopeCalculator_Base)
SkillScopeCalculator_AllMonsterGrid = SkillScopeCalculator_AllMonsterGrid

function SkillScopeCalculator_AllMonsterGrid:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local monsterList, monsterPosList = self._gridFilter:SelectAllMonster(casterEntity)
  local world = self._gridFilter._world
  local utilSvc = world:GetService("UtilData")
  local scopePosList = {}
  for _, pos in ipairs(monsterPosList) do
    local traps = utilSvc:GetTrapsAtPos(pos)
    if traps then
      local hasBadGrid = false
      for index, e in ipairs(traps) do
        if e:Trap():GetTrapType() == TrapType.BadGrid then
          hasBadGrid = true
        end
      end
      if not hasBadGrid then
        table.insert(scopePosList, pos)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.AllMonsterGrid, casterPos, scopePosList, scopePosList)
  return result
end
