require("scope_base")
_class("SkillScopeCalculator_RandomPosEmptyOrTrap", SkillScopeCalculator_Base)
SkillScopeCalculator_RandomPosEmptyOrTrap = SkillScopeCalculator_RandomPosEmptyOrTrap

function SkillScopeCalculator_RandomPosEmptyOrTrap:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local trapID = scopeParam
  local randPos = {}
  local pieces = self._gridFilter:GetEmptyPieces()
  if #pieces == 0 then
    pieces = self._gridFilter:GetTrapPiecesExceptTrapID(trapID)
  end
  if 0 < #pieces then
    local randomIndex = self._gridFilter:_GetRandomNumber(0, #pieces)
    table.insert(randPos, pieces[randomIndex])
  end
  local result = SkillScopeResult:New(SkillScopeType.RandomPosEmptyOrTrap, centerPos, randPos, randPos)
  return result
end
