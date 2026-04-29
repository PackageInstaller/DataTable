_class("SkillEffectCalc_SummonOnHitbackPosition", Object)
SkillEffectCalc_SummonOnHitbackPosition = SkillEffectCalc_SummonOnHitbackPosition

function SkillEffectCalc_SummonOnHitbackPosition:Constructor(world)
  self._world = world
end

function SkillEffectCalc_SummonOnHitbackPosition:DoSkillEffectCalculator(skillEffectCalcParam)
  local trapID = skillEffectCalcParam.skillEffectParam:GetTrapID()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local routineComponent = casterEntity:SkillContext():GetResultContainer()
  local resultsArray = routineComponent:GetEffectResultsAsArray(SkillEffectType.HitBack)
  if not resultsArray then
    return {}
  end
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local summonTrapResultArray = {}
  for _, hitbackResult in ipairs(resultsArray) do
    local hitbackStartPos = hitbackResult:GetStartPos()
    local hitbackTargetPos = hitbackResult:GetGridPos()
    if hitbackStartPos ~= hitbackTargetPos then
      local direction = hitbackStartPos - hitbackTargetPos
      if direction.x > 1 then
        direction.x = 1
      elseif direction.x < -1 then
        direction.x = -1
      end
      if 1 < direction.y then
        direction.y = 1
      elseif -1 > direction.y then
        direction.y = -1
      end
      local trapPos = hitbackTargetPos + direction
      if trapServiceLogic:CanSummonTrapOnPos(trapPos, trapID) then
        table.insert(summonTrapResultArray, SkillSummonTrapEffectResult:New(trapID, trapPos))
      end
      if skillEffectCalcParam.skillEffectParam:IsSummonOnSides() then
        local reverseDir = Vector2.New(direction.y, direction.x)
        local posAlpha = hitbackTargetPos + reverseDir
        if trapServiceLogic:CanSummonTrapOnPos(posAlpha, trapID) then
          table.insert(summonTrapResultArray, SkillSummonTrapEffectResult:New(trapID, posAlpha))
        end
        local posBeta = hitbackTargetPos - reverseDir
        if trapServiceLogic:CanSummonTrapOnPos(posBeta, trapID) then
          table.insert(summonTrapResultArray, SkillSummonTrapEffectResult:New(trapID, posBeta))
        end
      end
    end
  end
  return summonTrapResultArray
end
