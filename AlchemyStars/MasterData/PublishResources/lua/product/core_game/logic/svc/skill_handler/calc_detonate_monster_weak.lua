_class("SkillEffectCalc_DetonateMonsterWeak", SkillEffectCalc_Base)
SkillEffectCalc_DetonateMonsterWeak = SkillEffectCalc_DetonateMonsterWeak

function SkillEffectCalc_DetonateMonsterWeak:Constructor(world)
  self._world = world
end

function SkillEffectCalc_DetonateMonsterWeak:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.insert(results, result)
    end
  end
  return results
end

function SkillEffectCalc_DetonateMonsterWeak:_CalculateSingleTarget(skillEffectCalcParam, targetID)
  local targetEntity = self._world:GetEntityByID(targetID)
  if not targetEntity then
    return
  end
  local monsterWeakComponent = targetEntity:MonsterWeak()
  if not monsterWeakComponent then
    return
  end
  local activeWeakList = monsterWeakComponent:GetMonsterWeakDataList()
  if not activeWeakList or table.count(activeWeakList) == 0 then
    return
  end
  local targetBodyArea = targetEntity:BodyArea():GetArea()
  local targetDirection = targetEntity:GetGridDirection()
  local targetGridPos = targetEntity:GetGridPosition()
  local targetPosCenter = targetEntity:GridLocation():Center()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local casterPos = casterEntity:GetGridPosition()
  local skillParam = skillEffectCalcParam.skillEffectParam
  local detonateMonsterWeakType = skillParam:GetDetonateMonsterWeakType()
  local count = skillParam:GetDetonateMonsterWeakCount()
  local skillRange = skillEffectCalcParam.skillRange or {}
  local targetArray = {targetID}
  local attackRangeCenter = skillRange[#skillRange]
  local damageCenters = {}
  local weakResult = {}
  local damageResults = {}
  local utilData = self._world:GetService("UtilData")
  if detonateMonsterWeakType == DetonateMonsterWeakType.NormalAttack then
    local targetWeakKey
    local attakDir = Vector2(casterPos.x - attackRangeCenter.x, casterPos.y - attackRangeCenter.y)
    if attakDir == Vector2(0, 1) then
      targetWeakKey = WeakEdgeType.WeakUp
    elseif attakDir == Vector2(0, -1) then
      targetWeakKey = WeakEdgeType.WeakDown
    elseif attakDir == Vector2(1, 0) then
      targetWeakKey = WeakEdgeType.WeakRight
    elseif attakDir == Vector2(-1, 0) then
      targetWeakKey = WeakEdgeType.WeakLeft
    end
    local bodyAreaPos = attackRangeCenter - targetGridPos
    local targetWeakData = monsterWeakComponent:GetMonsterWeakDataByKeyAndBodyPos(targetWeakKey, bodyAreaPos)
    if targetWeakData then
      table.insert(weakResult, targetWeakData)
      table.insert(damageCenters, attackRangeCenter)
    end
  elseif detonateMonsterWeakType == DetonateMonsterWeakType.ChainInScope then
    if table.count(activeWeakList) == 0 then
      return
    end
    local filterWeakList = {}
    for k, v in pairs(activeWeakList) do
      filterWeakList[k] = v
    end
    local detonateDir = targetPosCenter - casterPos
    if 0 < detonateDir.y then
      filterWeakList[WeakEdgeType.WeakUp] = nil
    end
    if 0 > detonateDir.y then
      filterWeakList[WeakEdgeType.WeakDown] = nil
    end
    if 0 < detonateDir.x then
      filterWeakList[WeakEdgeType.WeakRight] = nil
    end
    if 0 > detonateDir.x then
      filterWeakList[WeakEdgeType.WeakLeft] = nil
    end
    if table.count(filterWeakList) == 0 then
      return
    end
    local bodyAreaInSkillRangePosList = {}
    for _, bodyPos in ipairs(targetBodyArea) do
      local posWork = targetGridPos + bodyPos
      if table.icontains(skillRange, posWork) then
        table.insert(bodyAreaInSkillRangePosList, posWork)
      end
    end
    table.sort(bodyAreaInSkillRangePosList, function(a, b)
      local disA = Vector2.Distance(casterPos, a)
      local disB = Vector2.Distance(casterPos, b)
      return disA < disB
    end)
    local hadDetonateWeakData = {}
    local hadDetonateWeakKey = {}
    for _, pos in ipairs(bodyAreaInSkillRangePosList) do
      for _, v in pairs(filterWeakList) do
        local monsterWeakData = v
        local key = monsterWeakData:GetKey()
        if not table.icontains(hadDetonateWeakKey, key) then
          local bodyPosList = monsterWeakData:GetBodyPosList()
          local bodtPosFinal = {}
          for _, body in ipairs(bodyPosList) do
            local posWork = targetGridPos + body
            table.insert(bodtPosFinal, posWork)
          end
          if table.icontains(bodtPosFinal, pos) then
            local disNearest = 99
            local nearestWeakEdgePos = monsterWeakData:GetEdgePosList()[1]
            local edgePosList = monsterWeakData:GetEdgePosList()
            for _, edgePos in ipairs(edgePosList) do
              local edgePosWithTarget = targetPosCenter + edgePos
              local disCur = Vector2.Distance(casterPos, edgePosWithTarget)
              if disNearest > disCur then
                disNearest = disCur
                nearestWeakEdgePos = edgePos
              end
            end
            table.insert(hadDetonateWeakKey, key)
            table.insert(hadDetonateWeakData, {
              pos = pos,
              key = key,
              disNearest = disNearest,
              nearestWeakEdgePos = nearestWeakEdgePos
            })
          end
        end
      end
    end
    if table.count(hadDetonateWeakData) == 0 then
      return
    end
    table.sort(hadDetonateWeakData, function(a, b)
      return a.disNearest < b.disNearest
    end)
    for i = 1, count do
      local WeakTable = hadDetonateWeakData[i]
      if WeakTable then
        local targetWeakData = monsterWeakComponent:GetMonsterWeakDataByKey(WeakTable.key)
        if targetWeakData then
          table.insert(weakResult, targetWeakData)
          table.insert(damageCenters, WeakTable.pos)
        end
      end
    end
  elseif detonateMonsterWeakType == DetonateMonsterWeakType.ActivePick then
  end
  for _, pos in ipairs(damageCenters) do
    local skillDamageEffectResults = self:_CalculateDamageResult(skillEffectCalcParam, pos, targetArray)
    table.appendArray(damageResults, skillDamageEffectResults)
  end
  local skillResult = SkillEffectResultDetonateMonsterWeak:New(targetID, weakResult, damageResults, damageCenters)
  return skillResult
end

function SkillEffectCalc_DetonateMonsterWeak:_CalculateDetonateEdge(skillEffectCalcParam, attackRange, targetArray)
end

function SkillEffectCalc_DetonateMonsterWeak:_CalculateDamageResult(skillEffectCalcParam, attackRangeCenter, targetArray)
  local resultArray = {}
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local attackerPos = casterEntity:GetGridPosition()
  local attackRange = {attackRangeCenter}
  local skillParam = skillEffectCalcParam.skillEffectParam
  local splashFormulaID = skillParam:GetSplashFormulaID()
  local splashPercent = skillParam:GetSplashPercent()
  local targetType = skillParam:GetSplashTargetType()
  if targetType then
    local scopeType = skillParam:GetSplashScopeType()
    local scopeParam = skillParam:GetSplashScopeParam()
    local parser = SkillScopeParamParser:New()
    scopeParam = parser:ParseScopeParam(scopeType, scopeParam)
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local calcScope = utilScopeSvc:GetSkillScopeCalc()
    local splashScopeResult = calcScope:ComputeScopeRange(scopeType, scopeParam, attackRangeCenter, {
      Vector2.zero
    })
    local targetSelector = self._world:GetSkillScopeTargetSelector()
    targetArray = targetSelector:DoSelectSkillTarget(casterEntity, targetType, splashScopeResult)
    attackRange = splashScopeResult:GetAttackRange()
  end
  local skillDamageParam = skillParam
  local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
  local effectCalcSvc = self._skillEffectService
  local targetGridAreaMap = self:_GetTargetAreaMap(targetArray)
  for _, damagePos in ipairs(attackRange) do
    if targetGridAreaMap[damagePos.x] and targetGridAreaMap[damagePos.x][damagePos.y] then
      local defenderEntityID = targetGridAreaMap[damagePos.x][damagePos.y]
      local defender = self._world:GetEntityByID(defenderEntityID)
      if damagePos ~= attackRangeCenter then
        skillDamageParam = SkillDamageEffectParam:New({percent = splashPercent, formulaID = splashFormulaID})
      end
      local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(casterEntity, attackerPos, defender, damagePos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.Damage, damageStageIndex)
      local skillResult = effectCalcSvc:NewSkillDamageEffectResult(damagePos, defenderEntityID, nTotalDamage, listDamageInfo, damageStageIndex)
      table.insert(resultArray, skillResult)
    end
  end
  return resultArray
end

function SkillEffectCalc_DetonateMonsterWeak:_GetTargetAreaMap(targetArray)
  local targetGridAreaMap = {}
  for _, targetEntityID in ipairs(targetArray) do
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity then
      local targetCenterPos = targetEntity:GetGridPosition()
      local bodyAreaComponent = targetEntity:BodyArea()
      if bodyAreaComponent then
        local bodyAreaArray = bodyAreaComponent:GetArea()
        for _, areaPos in ipairs(bodyAreaArray) do
          local absAreaPos = areaPos + targetCenterPos
          if not targetGridAreaMap[absAreaPos.x] then
            targetGridAreaMap[absAreaPos.x] = {}
          end
          targetGridAreaMap[absAreaPos.x][absAreaPos.y] = targetEntityID
        end
      else
        if not targetGridAreaMap[targetCenterPos.x] then
          targetGridAreaMap[targetCenterPos.x] = {}
        end
        targetGridAreaMap[targetCenterPos.x][targetCenterPos.y] = targetEntityID
      end
    end
  end
  return targetGridAreaMap
end
