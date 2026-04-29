require("scope_base")
_class("SkillScopeCalculator_Trap2CasterLine", SkillScopeCalculator_Base)
SkillScopeCalculator_Trap2CasterLine = SkillScopeCalculator_Trap2CasterLine

function SkillScopeCalculator_Trap2CasterLine:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local params = scopeParam
  local trapID = params[1]
  local bNoExtend = params[2]
  local widthThreshold = params[3]
  local world = self._gridFilter._world
  local trapSvcLogic = world:GetService("TrapLogic")
  local trapPosList = trapSvcLogic:FindTrapPosByTrapID(trapID)
  local scopeAngleFreeLine = SkillScopeCalculator_AngleFreeLine:New(self._hub)
  local attackRange = {}
  local wholeRange = {}
  for i, trapPos in ipairs(trapPosList) do
    local scopeResult = scopeAngleFreeLine:CalcRange(nil, {noExtend = bNoExtend, widthThreshold = widthThreshold}, trapPos, bodyArea, casterDir, nTargetType, casterPos)
    table.Vector2Append(attackRange, scopeResult:GetAttackRange())
    table.Vector2Append(wholeRange, scopeResult:GetWholeGridRange())
  end
  local result = SkillScopeResult:New(SkillScopeType.Trap2CasterCenterLine, centerPos, attackRange, wholeRange)
  return result
end
