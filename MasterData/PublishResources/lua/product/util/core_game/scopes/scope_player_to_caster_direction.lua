require("scope_base")
_class("SkillScopeCalculatorPlayerToCasterDirection", SkillScopeCalculator_Base)
SkillScopeCalculatorPlayerToCasterDirection = SkillScopeCalculatorPlayerToCasterDirection

function SkillScopeCalculatorPlayerToCasterDirection:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if not scopeParam then
    Log.fatal("### scopeParam is nil. centerPos=", centerPos)
    return
  end
  local world = self._gridFilter._world
  local direction = scopeParam[1]
  local noRepeat = scopeParam[2] and scopeParam[2] == 1 or false
  local resultScope = {}
  if noRepeat then
    local workPosX = casterPos.x + casterDir.x * direction
    local workPosY = casterPos.y + casterDir.y * direction
    local workPos = Vector2(workPosX, workPosY)
    table.insert(resultScope, workPos)
  else
    for i = 1, direction do
      local workPosX = casterPos.x + casterDir.x * direction
      local workPosY = casterPos.y + casterDir.y * direction
      local workPos = Vector2(workPosX, workPosY)
      table.insert(resultScope, workPos)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.PlayerToCasterDirection, centerPos, resultScope, resultScope)
  return result
end
