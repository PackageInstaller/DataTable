require("scope_base")
_class("SkillScopeCalculator_RandomGrids", SkillScopeCalculator_Base)
SkillScopeCalculator_RandomGrids = SkillScopeCalculator_RandomGrids

function SkillScopeCalculator_RandomGrids:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local function GetRandomPoints(rdmPoints)
    if not rdmPoints then
      return
    end
    local filtered = {}
    local blockGrids = self._gridFilter:GetBlockGridTrapPosList()
    for i, v in ipairs(rdmPoints) do
      local tbl = {}
      for j, vj in ipairs(v) do
        if not table.icontains(blockGrids, vj) and not self._gridFilter:IsPosHaveMonsterOrPet(vj) then
          table.insert(tbl, vj)
        end
      end
      table.insert(filtered, tbl)
    end
    local randomPeices = {}
    for i, v in ipairs(filtered) do
      local len = table.count(v)
      local idx = 1
      if 0 < len then
        idx = self._gridFilter:_GetRandomNumber(1, len)
      end
      table.insert(randomPeices, v[idx])
    end
    return randomPeices
  end
  
  local grids = GetRandomPoints(scopeParam)
  local result = SkillScopeResult:New(SkillScopeType.RandomGrids, centerPos, grids, grids)
  return result
end
