require("scope_base")
_class("SkillScopeCalculator_CasterAroundFarestTeam", SkillScopeCalculator_Base)
SkillScopeCalculator_CasterAroundFarestTeam = SkillScopeCalculator_CasterAroundFarestTeam

function SkillScopeCalculator_CasterAroundFarestTeam:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  scopeParam = scopeParam or {}
  local ringCount = scopeParam[1] or 1
  local posCount = scopeParam[2] or 1
  local world = self._hub._gridFilter._world
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local casterBodyArea = casterEntity:BodyArea():GetArea()
  local squareRingRange = ComputeScopeRange.ComputeRange_SquareRing(casterPos, #casterBodyArea, ringCount)
  table.sort(squareRingRange, function(a, b)
    local disA = Vector2.Distance(teamPos, a)
    local disB = Vector2.Distance(teamPos, b)
    return disA > disB
  end)
  local wholeRange = {}
  local boardSvc = world:GetService("BoardLogic")
  for i, pos in ipairs(squareRingRange) do
    if not boardSvc:IsPosBlock(pos, BlockFlag.MonsterLand) then
      table.insert(wholeRange, pos)
      if posCount <= table.count(wholeRange) then
        break
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.CasterAroundFarestTeam, casterPos, wholeRange, wholeRange)
  return result
end
