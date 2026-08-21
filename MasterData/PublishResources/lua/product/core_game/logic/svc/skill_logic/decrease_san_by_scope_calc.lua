_class("DecreaseSanByScopeCalculator", Object)
DecreaseSanByScopeCalculator = DecreaseSanByScopeCalculator

function DecreaseSanByScopeCalculator:Constructor(world)
  self._world = world
end

function DecreaseSanByScopeCalculator:Calculate(casterEntity, skillEffectParam, finalScopeFilterParam)
  local generalCalc = GeneralEffectCalculator:New(self._world)
  local skillScopeResult = generalCalc:_CalcSkillEffectScopeResult(casterEntity, skillEffectParam, finalScopeFilterParam)
  local attackRange = skillScopeResult:GetAttackRange()
  local sanPerGrid = skillEffectParam:GetSanPerGrid()
  local decreaseSan = sanPerGrid * #attackRange
  local range = {}
  for _, v in ipairs(attackRange) do
    table.insert(range, v)
  end
  local result = SkillEffectResult_DecreaseSanByScope:New(casterEntity:GetID(), range, decreaseSan)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  skillEffectResultContainer:AddEffectResult(result)
  return {result}
end
