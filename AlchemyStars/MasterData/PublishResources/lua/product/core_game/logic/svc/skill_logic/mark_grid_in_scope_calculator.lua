_class("MarkGridInScopeCalculator", Object)
MarkGridInScopeCalculator = MarkGridInScopeCalculator

function MarkGridInScopeCalculator:Constructor(world)
  self._world = world
end

function MarkGridInScopeCalculator:Calculate(casterEntity, effectParam)
  if effectParam:IsClear() then
    self:DoClearMark(casterEntity, effectParam)
  else
    self:DoMarkGrid(casterEntity, effectParam)
  end
end

function MarkGridInScopeCalculator:DoMarkGrid(casterEntity, effectParam)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local tv2AttackPos = {}
  for _, v2 in ipairs(scopeResult:GetAttackRange()) do
    table.insert(v2)
  end
  local randomService = self._world:GetService("RandomLogic")
  if not casterEntity:HasMarkGrid() then
    casterEntity:AddMarkGrid()
  end
  local cMarkGrid = casterEntity:MarkGridComponent()
  local tv2Marked = {}
  local max = effectParam:GetMaxCount()
  for i = 1, max do
    local rand = randomService:LogicRand(1, #tv2AttackPos)
    local v2 = table.remove(tv2AttackPos, rand)
    local index = Vector2.Pos2Index(v2)
    cMarkGrid:MarkGrid(index)
    table.insert(tv2Marked, v2)
  end
  local result = SkillEffectResult_MarkGridInScope:New(tv2Marked)
  skillEffectResultContainer:AddEffectResult(result)
end

function MarkGridInScopeCalculator:DoClearMark(casterEntity, effectParam)
  if not casterEntity:HasMarkGridComponent() then
    return
  end
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local tv2 = casterEntity:MarkGridComponent():ClearMark()
  local result = SkillEffectResult_MarkGridInScope:New(nil, tv2)
  skillEffectResultContainer:AddEffectResult(result)
end
