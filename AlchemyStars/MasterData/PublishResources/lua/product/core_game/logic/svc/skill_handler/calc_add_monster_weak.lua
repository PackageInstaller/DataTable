_class("SkillEffectCalc_AddMonsterWeak", SkillEffectCalc_Base)
SkillEffectCalc_AddMonsterWeak = SkillEffectCalc_AddMonsterWeak

function SkillEffectCalc_AddMonsterWeak:Constructor(world)
  self._world = world
end

function SkillEffectCalc_AddMonsterWeak:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  local skillParam = skillEffectCalcParam.skillEffectParam
  local addMonsterWeakType = skillParam:GetAddMonsterWeakType()
  local count = skillParam:GetAddMonsterWeakCount()
  local extraProb = skillParam:GetExtraProb()
  local randomSvc = self._world:GetService("RandomLogic")
  local r = randomSvc:LogicRand()
  if extraProb > r and addMonsterWeakType == AddMonsterWeakType.AllMonster then
    count = count + 1
  end
  self._normalAttackHasAddWeakData = {}
  for i = 1, count do
    for _, targetID in ipairs(targets) do
      local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID, results)
      if result then
        table.insert(results, result)
      end
    end
  end
  return results
end

function SkillEffectCalc_AddMonsterWeak:_CalculateSingleTarget(skillEffectCalcParam, entityID, results)
  local targetEntity = self._world:GetEntityByID(entityID)
  if not targetEntity then
    return
  end
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local centerPos = casterEntity:GridLocation():GetGridPos()
  local skillParam = skillEffectCalcParam.skillEffectParam
  local addMonsterWeakType = skillParam:GetAddMonsterWeakType()
  local count = skillParam:GetAddMonsterWeakCount()
  local utilData = self._world:GetService("UtilData")
  local resultEntityID = entityID
  local weakResult = {}
  local damageResult = {}
  if addMonsterWeakType == AddMonsterWeakType.AllMonster then
    local skillID = skillEffectCalcParam:GetSkillID()
    local skillTargetTypeParam = {99}
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
    local fullScreenCalc = SkillScopeCalculator_FullScreen:New(skillCalculater)
    local scopeResult = fullScreenCalc:CalcRange(SkillScopeType.FullScreen, 1, centerPos, casterEntity:BodyArea():GetArea(), casterEntity:GetGridDirection(), SkillTargetType.Board, centerPos)
    local targetSelector = self._world:GetSkillScopeTargetSelector()
    local targetIDArray = targetSelector:DoSelectSkillTarget(casterEntity, SkillTargetType.HighestHPMonster, scopeResult, skillID, skillTargetTypeParam)
    for _, targetID in ipairs(targetIDArray) do
      if utilData:OnCheckTargetCanAddWeak(targetID) then
        resultEntityID = targetID
        local monsterWeakData = self:_OnGetTargetNearestWeakEdge(resultEntityID, centerPos, nil, self._normalAttackHasAddWeakData)
        if monsterWeakData then
          local hadAdd = self:_OnCheckWeakEdgeHadAdd(targetID, monsterWeakData, results)
          if hadAdd == false then
            table.insert(weakResult, monsterWeakData)
            self._normalAttackHasAddWeakData[monsterWeakData:GetKey()] = monsterWeakData
            break
          end
        end
      end
    end
    if table.count(weakResult) == 0 then
      local damageSkillResult = self:_CantAddWeakDoDamage(skillEffectCalcParam, targetIDArray[1])
      if damageSkillResult then
        table.insert(damageResult, damageSkillResult)
      end
    end
  elseif addMonsterWeakType == AddMonsterWeakType.SelectMonster then
    local skillRange = skillEffectCalcParam.skillRange
    local hasAddWeakData = {}
    for i = 1, count do
      local monsterWeakData
      if utilData:OnCheckTargetCanAddWeak(entityID) then
        local needCheckDir = true
        monsterWeakData = self:_OnGetTargetNearestWeakEdge(entityID, centerPos, skillRange, hasAddWeakData, needCheckDir)
        if monsterWeakData then
          table.insert(weakResult, monsterWeakData)
          hasAddWeakData[monsterWeakData:GetKey()] = monsterWeakData
        end
      else
        local damageSkillResult = self:_CantAddWeakDoDamage(skillEffectCalcParam, entityID)
        table.insert(damageResult, damageSkillResult)
      end
    end
  end
  local skillResult = SkillEffectResultAddMonsterWeak:New(resultEntityID, weakResult, damageResult)
  return skillResult
end

function SkillEffectCalc_AddMonsterWeak:_OnCheckWeakEdgeHadAdd(targetID, monsterWeakData, results)
  local curWeakKey = monsterWeakData:GetKey()
  for _, v in ipairs(results) do
    local result = v
    local hadAddMonsterWeakDataEntityID = result:GetEntityID()
    local hadAddMonsterWeakDataList = result:GetWeakResult()
    if hadAddMonsterWeakDataEntityID == targetID then
      for _, weak in ipairs(hadAddMonsterWeakDataList) do
        local monsterWeakData = weak
        local key = monsterWeakData:GetKey()
        if curWeakKey == key then
          return true
        end
      end
    end
  end
  return false
end

function SkillEffectCalc_AddMonsterWeak:_OnGetTargetNearestWeakEdge(entityID, casterPos, skillRange, hasAddWeakData, needCheckDir)
  local targetEntity = self._world:GetEntityByID(entityID)
  local targetGridPos = targetEntity:GetGridPosition()
  local targetPosCenter = targetEntity:GridLocation():Center()
  local monsterWeakComponent = targetEntity:MonsterWeak()
  if not monsterWeakComponent then
    targetEntity:AddMonsterWeak()
    monsterWeakComponent = targetEntity:MonsterWeak()
  end
  local utilData = self._world:GetService("UtilData")
  local allMonsterWeakDataList = utilData:OnGetEntityWeakEdgeDataList(entityID)
  if not allMonsterWeakDataList then
    return
  end
  local activeWeakList = monsterWeakComponent:GetMonsterWeakDataList()
  local inactiveList = {}
  for _, v in ipairs(allMonsterWeakDataList) do
    local monsterWeakData = v
    local key = monsterWeakData:GetKey()
    local targetWeakData = monsterWeakComponent:GetMonsterWeakDataByKey(key)
    local checkEdgeInSkillRange = true
    if not targetWeakData and skillRange then
      local bodyPosList = monsterWeakData:GetBodyPosList()
      local isInSkillRange = false
      for _, bodyPos in ipairs(bodyPosList) do
        local posWork = targetGridPos + bodyPos
        if table.icontains(skillRange, posWork) then
          isInSkillRange = true
          break
        end
      end
      if isInSkillRange == false then
        checkEdgeInSkillRange = false
      end
    end
    local checkDir = true
    if needCheckDir == true then
      local detonateDir = targetPosCenter - casterPos
      local cantAddKeyList = {}
      if detonateDir.y > 0 then
        table.insert(cantAddKeyList, WeakEdgeType.WeakUp)
      end
      if detonateDir.y < 0 then
        table.insert(cantAddKeyList, WeakEdgeType.WeakDown)
      end
      if 0 < detonateDir.x then
        table.insert(cantAddKeyList, WeakEdgeType.WeakRight)
      end
      if 0 > detonateDir.x then
        table.insert(cantAddKeyList, WeakEdgeType.WeakLeft)
      end
      if table.icontains(cantAddKeyList, key) then
        checkDir = false
      end
    end
    local checkHadAdd = true
    if hasAddWeakData and hasAddWeakData[key] then
      checkHadAdd = false
    end
    if not targetWeakData and checkEdgeInSkillRange and checkHadAdd and checkDir then
      table.insert(inactiveList, v)
    end
  end
  if table.count(inactiveList) == 0 then
    return nil
  end
  local nearestWeakEdgeData = inactiveList[1]
  local nearestWeakEdgePos = nearestWeakEdgeData:GetEdgePosList()[1]
  for _, v in ipairs(inactiveList) do
    local monsterWeakData = v
    local edgePosList = monsterWeakData:GetEdgePosList()
    for i, edgePos in ipairs(edgePosList) do
      local edgePosWithTarget = targetPosCenter + edgePos
      local disCur = Vector2.Distance(casterPos, edgePosWithTarget)
      local nearestWeakEdgePosWithTarget = targetPosCenter + nearestWeakEdgePos
      local disNearest = Vector2.Distance(casterPos, nearestWeakEdgePosWithTarget)
      if disCur < disNearest then
        nearestWeakEdgeData = v
        nearestWeakEdgePos = edgePos
      end
    end
  end
  return nearestWeakEdgeData
end

function SkillEffectCalc_AddMonsterWeak:_CantAddWeakDoDamage(skillEffectCalcParam, entityID)
  local defender = self._world:GetEntityByID(entityID)
  if not defender then
    return
  end
  local effectCalcSvc = self._skillEffectService
  local skillParam = skillEffectCalcParam.skillEffectParam
  local skillDamageParam = skillParam
  local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local attackerPos = casterEntity:GetGridPosition()
  local defenderPos = defender:GetGridPosition()
  local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(casterEntity, attackerPos, defender, defenderPos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.Damage, damageStageIndex)
  local skillResult = effectCalcSvc:NewSkillDamageEffectResult(defenderPos, entityID, nTotalDamage, listDamageInfo, damageStageIndex)
  return skillResult
end
