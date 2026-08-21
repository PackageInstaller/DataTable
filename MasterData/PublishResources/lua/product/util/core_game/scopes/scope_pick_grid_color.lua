require("scope_base")
_class("SkillScopeCalculatorPickGridColor", SkillScopeCalculator_Base)
SkillScopeCalculatorPickGridColor = SkillScopeCalculatorPickGridColor

function SkillScopeCalculatorPickGridColor:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local pickGridPos = centerPos
  if pickGridPos ~= table then
    pickGridPos = {pickGridPos}
  end
  local world = self._gridFilter._world
  local boardServiceLogic = world:GetService("BoardLogic")
  local pickGirdColorList = {}
  for _, pos in pairs(pickGridPos) do
    local pieceType = boardServiceLogic:GetPieceType(pos)
    if not table.icontains(pickGirdColorList, pieceType) then
      table.insert(pickGirdColorList, pieceType)
    end
  end
  local girdPosList = boardServiceLogic:GetGridPosByPieceType(pickGirdColorList)
  return SkillScopeResult:New(SkillScopeType.PickGridColor, casterPos, girdPosList, girdPosList)
end
