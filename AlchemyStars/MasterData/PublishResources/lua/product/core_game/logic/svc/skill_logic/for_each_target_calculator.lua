_class("ForEachTargetCalculator", Object)
ForEachTargetCalculator = ForEachTargetCalculator

function ForEachTargetCalculator:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._skillEffectCalcService = self._world:GetService("SkillEffectCalc")
  self._canEffectSelectTargetByGrid = {
    [SkillEffectType.Damage] = true,
    [SkillEffectType.SplashDamage] = true,
    [SkillEffectType.DamageOnTargetCount] = true,
    [SkillEffectType.DamageByBuffLayer] = true
  }
end

function ForEachTargetCalculator:DoTargetEffectCalculate(casterEntity, scopeResult, targetIDArray, skillEffectParam, scopeFilterParam)
  local effectResultList = {}
  if targetIDArray == nil or #targetIDArray == 0 then
    local skillResult = self:_CalcNoTarget(casterEntity, scopeResult, skillEffectParam)
    if skillResult ~= nil then
      if skillResult._className ~= nil then
        effectResultList[#effectResultList + 1] = skillResult
      else
        for _, v in ipairs(skillResult) do
          effectResultList[#effectResultList + 1] = v
        end
      end
    end
  else
    for _, targetEntityID in ipairs(targetIDArray) do
      local skillResult = self:_CalcEachTarget(casterEntity, targetEntityID, scopeResult, skillEffectParam, scopeFilterParam, targetIDArray)
      if skillResult ~= nil then
        if skillResult._className ~= nil then
          effectResultList[#effectResultList + 1] = skillResult
        else
          for _, v in ipairs(skillResult) do
            effectResultList[#effectResultList + 1] = v
          end
        end
      end
    end
  end
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  for _, v in ipairs(effectResultList) do
    skillEffectResultContainer:AddEffectResult(v)
  end
  return effectResultList
end

function ForEachTargetCalculator:_CalcNoTarget(casterEntity, scopeResult, skillEffectParam)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  if skillEffectResultContainer == nil then
    Log.fatal("caster has no skill routine component")
  end
  local calcParam = SkillEffectCalcParam:New(casterEntity:GetID(), {-1}, skillEffectParam, skillEffectResultContainer:GetSkillID(), scopeResult:GetAttackRange(), nil, casterEntity:GetGridPosition(), scopeResult:GetCenterPos(), scopeResult:GetWholeGridRange())
  local skillResult = self._skillEffectCalcService:CalcSkillEffectByType(calcParam)
  return skillResult
end

function ForEachTargetCalculator:_CalcEachTarget(casterEntity, targetEntityID, scopeResult, skillEffectParam, scopeFilterParam, targetIDArray)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  if skillEffectResultContainer == nil then
    Log.fatal("caster has no skill routine component")
  end
  local skillID = skillEffectResultContainer:GetSkillID()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  if targetEntity == nil then
    Log.fatal("targetEntity is nil")
    return
  end
  local targetGridPos
  if targetEntity:GridLocation() then
    targetGridPos = targetEntity:GridLocation().Position
  end
  local skillRange = scopeResult:GetAttackRange()
  local wholeRange = scopeResult:GetWholeGridRange()
  local scopeCenter = scopeResult:GetCenterPos()
  local specialScopeResult = scopeResult:GetSpecialScopeResult()
  local effectType = skillEffectParam:GetEffectType()
  if effectType == SkillEffectType.SerialKiller then
    return
  end
  local targetSelectionMode = scopeFilterParam:GetTargetSelectionMode()
  local resultArray
  local bodyAreaComponent = targetEntity:BodyArea()
  local canSelectByGrid = self._canEffectSelectTargetByGrid[skillEffectParam:GetEffectType()]
  if canSelectByGrid and (not targetSelectionMode or targetSelectionMode == SkillTargetSelectionMode.Grid) and bodyAreaComponent then
    local bodyAreaArray = bodyAreaComponent:GetArea()
    local targetBodyAreaPosList = {}
    for _, areaPos in ipairs(bodyAreaArray) do
      local gridPos = areaPos + targetGridPos
      table.insert(targetBodyAreaPosList, gridPos)
    end
    local calcRange = {}
    for _, gridPos in ipairs(targetBodyAreaPosList) do
      if self:IsInSkillRange(skillRange, gridPos) then
        table.insert(calcRange, gridPos)
      end
    end
    if skillEffectParam.GetUseScopeOrder and skillEffectParam:GetUseScopeOrder() == 1 then
      calcRange = {}
      for _, gridPos in ipairs(skillRange) do
        if table.intable(targetBodyAreaPosList, gridPos) then
          table.insert(calcRange, gridPos)
        end
      end
    end
    for _, gridPos in ipairs(calcRange) do
      local calcParam = SkillEffectCalcParam:New(casterEntity:GetID(), {targetEntityID}, skillEffectParam, skillID, skillRange, casterEntity:GridLocation():GetGridPos(), gridPos, scopeCenter, wholeRange)
      calcParam:SetTotalTargetCount(#targetIDArray)
      if specialScopeResult then
        calcParam:SetSpecialScopeResult(specialScopeResult)
      end
      calcParam:SetDamageGridPos(gridPos)
      local skillResult = self._skillEffectCalcService:CalcSkillEffectByType(calcParam)
      if not resultArray and skillResult then
        resultArray = {}
      end
      table.appendArray(resultArray, skillResult)
    end
  else
    local calcParam = SkillEffectCalcParam:New(casterEntity:GetID(), {targetEntityID}, skillEffectParam, skillID, skillRange, casterEntity:GridLocation():GetGridPos(), targetGridPos, scopeCenter, wholeRange)
    calcParam:SetTotalTargetCount(#targetIDArray)
    if specialScopeResult then
      calcParam:SetSpecialScopeResult(specialScopeResult)
    end
    local skillResult = self._skillEffectCalcService:CalcSkillEffectByType(calcParam)
    if skillResult then
      resultArray = resultArray or {}
      if skillResult._className then
        table.insert(resultArray, skillResult)
      else
        table.appendArray(resultArray, skillResult)
      end
    end
  end
  return resultArray
end

function ForEachTargetCalculator:IsInSkillRange(skillRange, gridPos)
  for _, v in ipairs(skillRange) do
    if #v ~= 0 then
      for k, pos in ipairs(v) do
        if pos.x == gridPos.x and pos.y == gridPos.y then
          return true
        end
      end
    elseif v.x == gridPos.x and v.y == gridPos.y then
      return true
    end
  end
  return false
end
