require("scope_base")
_class("SkillScopeCalculator_EmptyRandGrid", SkillScopeCalculator_Base)
SkillScopeCalculator_EmptyRandGrid = SkillScopeCalculator_EmptyRandGrid

function SkillScopeCalculator_EmptyRandGrid:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local casterPos = centerPos
  local count = scopeParam
  local randPos = {}
  local pieces = self._gridFilter:GetEmptyPieces()
  if count > #pieces then
    count = #pieces
  end
  repeat
    local randomIndex = -1
    if self._gridFilter then
      randomIndex = self._gridFilter:_GetRandomNumber(0, #pieces)
    else
      randomIndex = math.random(0, #pieces)
    end
    local pos = pieces[randomIndex]
    if not table.icontains(randPos, pos) then
      table.insert(randPos, pos)
    end
  until #randPos == count
  local result = SkillScopeResult:New(SkillScopeType.EmptyRandGrid, casterPos, randPos, randPos)
  return result
end
