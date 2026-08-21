require("scope_base")
_class("SkillScopeCalculator_PickUpDoubleCrossWithDistance", SkillScopeCalculator_Base)
SkillScopeCalculator_PickUpDoubleCrossWithDistance = SkillScopeCalculator_PickUpDoubleCrossWithDistance

function SkillScopeCalculator_PickUpDoubleCrossWithDistance:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local distance = scopeParam[1] or 1
  local calcBlock = scopeParam[2]
  local world = self._hub._gridFilter._world
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local pickUpDir = centerPos - casterPos
  if 1 < pickUpDir.x then
    pickUpDir.x = 1
  elseif pickUpDir.x < -1 then
    pickUpDir.x = -1
  end
  if 1 < pickUpDir.y then
    pickUpDir.y = 1
  elseif -1 > pickUpDir.y then
    pickUpDir.y = -1
  end
  local moveDisPos = Vector2(casterPos.x + distance * pickUpDir.x, casterPos.y + distance * pickUpDir.y)
  if calcBlock == 1 then
    local utilDataSvc = world:GetService("UtilData")
    local isBlock = utilDataSvc:IsPosBlock(moveDisPos, BlockFlag.MonsterLand)
    if isBlock then
      moveDisPos = casterPos
    end
  end
  local resultPosList = {moveDisPos}
  if centerPos.x == moveDisPos.x and centerPos.y == moveDisPos.y then
    resultPosList = {casterPos}
  end
  local result = SkillScopeResult:New(SkillScopeType.PickUpDoubleCrossWithDistance, casterPos, resultPosList, resultPosList)
  return result
end
