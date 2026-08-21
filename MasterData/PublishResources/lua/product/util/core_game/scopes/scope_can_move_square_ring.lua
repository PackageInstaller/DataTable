require("scope_base")
_class("SkillScopeCalculator_CanMoveSquareRing", SkillScopeCalculator_Base)
SkillScopeCalculator_CanMoveSquareRing = SkillScopeCalculator_CanMoveSquareRing

function SkillScopeCalculator_CanMoveSquareRing:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local invalidPos
  local world = self._gridFilter._world
  if world and world:MatchType() == MatchType.MT_BlackFist and casterEntity:HasPet() then
    local enemy = casterEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    invalidPos = enemy:GetGridPosition()
  end
  local ringCount = scopeParam[1]
  local listTotalData = ComputeScopeRange.ComputeRange_SquareRing(casterPos, #bodyArea, ringCount)
  local listAttackData = {}
  for key, value in pairs(listTotalData) do
    local isValidGrid = not self._gridFilter:IsPosBlock(value, BlockFlag.LinkLine) and value ~= invalidPos
    if isValidGrid == true then
      listAttackData[#listAttackData + 1] = value
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.CanMoveSquareRing, casterPos, listAttackData, listTotalData)
  return result
end
