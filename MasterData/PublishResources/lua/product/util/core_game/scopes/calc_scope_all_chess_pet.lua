require("scope_base")
_class("CalcScopeAllChessPet", SkillScopeCalculator_Base)
CalcScopeAllChessPet = CalcScopeAllChessPet

function CalcScopeAllChessPet:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local chessPetEntityList, chessPetPosList = self._gridFilter:SelectAllChessPet(casterEntity)
  local world = self._gridFilter._world
  local utilSvc = world:GetService("UtilData")
  local scopePosList = {}
  for _, pos in ipairs(chessPetPosList) do
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
  local result = SkillScopeResult:New(SkillScopeType.AllChessPet, casterPos, scopePosList, scopePosList)
  return result
end
