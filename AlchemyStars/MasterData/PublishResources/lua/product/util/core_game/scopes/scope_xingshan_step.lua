require("scope_base")
_class("SkillScopeCalculator_XingshanStep", SkillScopeCalculator_Base)
SkillScopeCalculator_XingshanStep = SkillScopeCalculator_XingshanStep

function SkillScopeCalculator_XingshanStep:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local v2Dir = centerPos - casterPos
  local attackRange = {}
  table.insert(attackRange, casterPos)
  if math.abs(v2Dir.x) <= 1 and 1 >= math.abs(v2Dir.y) then
    return SkillScopeResult:New(SkillScopeType.XingshanStep, casterPos, attackRange, attackRange)
  end
  local v2NormalizedGridDir = v2Dir:Clone()
  if v2NormalizedGridDir.x > 0 then
    v2NormalizedGridDir.x = 1
  elseif v2NormalizedGridDir.x < 0 then
    v2NormalizedGridDir.x = -1
  end
  if v2NormalizedGridDir.y > 0 then
    v2NormalizedGridDir.y = 1
  elseif v2NormalizedGridDir.y < 0 then
    v2NormalizedGridDir.y = -1
  end
  local oneStepPos = casterPos + v2NormalizedGridDir
  if self._gridFilter._world and self._gridFilter._world:MatchType() == MatchType.MT_BlackFist then
    local world = self._gridFilter._world
    local eLocalTeam = world:Player():GetLocalTeamEntity()
    local eRemoteTeam = world:Player():GetRemoteTeamEntity()
    if oneStepPos == eLocalTeam:GetGridPosition() or oneStepPos == eRemoteTeam:GetGridPosition() then
      oneStepPos = nil
    end
  end
  if oneStepPos then
    table.insert(attackRange, oneStepPos)
  end
  return SkillScopeResult:New(SkillScopeType.XingshanStep, casterPos, attackRange, attackRange)
end
