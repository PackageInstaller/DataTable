_class("GeneralEffectCalculator", Object)
GeneralEffectCalculator = GeneralEffectCalculator

function GeneralEffectCalculator:Constructor(world)
  self._world = world
  self._foreachTargetCalculator = ForEachTargetCalculator:New(world)
  self._skillEffectTargetSorter = SkillEffectTargetSorter:New(world)
end

function GeneralEffectCalculator:DoGeneralEffectCalc(casterEntity, skillEffectParam, scopeFilterParam)
  local skillScopeResult = self:_CalcSkillEffectScopeResult(casterEntity, skillEffectParam)
  local targetIDList = self:_CalcSkillEffectTargetList(casterEntity, skillScopeResult, skillEffectParam)
  targetIDList = self._skillEffectTargetSorter:DoSortTargetList(casterEntity, targetIDList, skillEffectParam, skillScopeResult)
  local resultList = self._foreachTargetCalculator:DoTargetEffectCalculate(casterEntity, skillScopeResult, targetIDList, skillEffectParam, scopeFilterParam)
  for _, v in ipairs(resultList) do
    local skillResult = v
    skillResult:SetSkillEffectScopeResult(skillScopeResult)
  end
  return resultList
end

function GeneralEffectCalculator:_CalcSkillEffectScopeResult(casterEntity, skillEffectParam)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeType = skillEffectParam:GetSkillEffectScopeType()
  if scopeType ~= nil then
    local casterPos = casterEntity:GridLocation().Position
    scopeResult = utilScopeSvc:CalcSkillEffectScopeResult(skillEffectParam, casterPos, casterEntity)
  end
  return scopeResult
end

function GeneralEffectCalculator:_CalcSkillEffectTargetList(casterEntity, scopeResult, skillEffectParam)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local targetEntityIDArray = scopeResult:GetTargetIDs()
  local skillID = skillEffectResultContainer:GetSkillID()
  local filterParam = skillEffectParam:GetScopeFilterParam()
  local targetSelectionMode = filterParam:GetTargetSelectionMode()
  local skillEffectTargetType = skillEffectParam:GetSkillEffectTargetType()
  if skillEffectTargetType ~= nil then
    local skillEffectTargetTypeParam = skillEffectParam:GetSkillEffectTargetTypeParam()
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    targetEntityIDArray = utilScopeSvc:SelectSkillTarget(casterEntity, skillEffectTargetType, scopeResult, nil, skillEffectTargetTypeParam)
    local fitterTargetIDs = {}
    for _, id in ipairs(targetEntityIDArray) do
      if not table.icontains(fitterTargetIDs, id) then
        table.insert(fitterTargetIDs, id)
      end
    end
    targetEntityIDArray = fitterTargetIDs
  end
  return targetEntityIDArray
end
