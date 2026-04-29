_class("SkillViewConditionHelper", Object)
SkillViewConditionHelper = SkillViewConditionHelper

function SkillViewConditionHelper:Constructor(world)
  self._world = world
  self._conditionDic = {}
  self._conditionDic.CheckDamageIndexValid = self.CheckDamageIndexValid
  self._conditionDic.CheckDamageInfoIndexValid = self.CheckDamageInfoIndexValid
  self._conditionDic.CheckDamageIndex2Valid = self.CheckDamageIndex2Valid
  self._conditionDic.CheckBuffIndexValid = self.CheckBuffIndexValid
  self._conditionDic.CheckIsLastDamage = self.CheckIsLastDamage
  self._conditionDic.CheckPickUpIndexValid = self.CheckPickUpIndexValid
  self._conditionDic.CheckCurrentScopeGridRangeIndexValid = self.CheckCurrentScopeGridRangeIndexValid
  self._conditionDic.CheckAbsortPieceCountLessThan = self.CheckAbsortPieceCountLessThan
  self._conditionDic.CheckAbsortPieceCountMoreThan = self.CheckAbsortPieceCountMoreThan
  self._conditionDic.CheckTrue = self.CheckTrue
  self._conditionDic.CheckBuffRefreshValid = self._CheckBuffRefreshValid
  self._conditionDic.CheckSummonThingValid = self._CheckSummonThingValid
  self._conditionDic.CheckTargetCountInScope = self._CheckTargetCountInScope
  self._conditionDic.CheckEffectResultIndex = self._CheckEffectResultIndex
  self._conditionDic.CheckEffectMultiResultIndex = self._CheckEffectMultiResultIndex
  self._conditionDic.CheckContainCurrentScopeGrid = self._CheckContainCurrentScopeGrid
  self._conditionDic.IsAddBloodValueGreaterThan = self._IsAddBloodValueGreaterThan
  self._conditionDic.CheckMiyaPhase2 = self.CheckMiyaPhase2
  self._conditionDic.CheckDamageIndexLast = self.CheckDamageIndexLast
  self._conditionDic.CheckTargetIsCanMove = self._CheckTargetIsCanMove
  self._conditionDic.CheckDamageSkillResultTargetCount = self.CheckDamageSkillResultTargetCount
  self._conditionDic.CheckCasterHasBuff = self.CheckCasterHasBuff
  self._conditionDic.CheckDeadTarget = self.CheckDeadTarget
  self._conditionDic.CheckHasTeleport = self._CheckHasTeleport
  self._conditionDic.CheckOnAbyss = self._CheckOnAbyss
  self._conditionDic.CheckCurScopeRangeOnCrossLine = self._CheckCurScopeRangeOnCrossLine
  self._conditionDic.CheckSummonOnFixPosValid = self._CheckSummonOnFixPosValid
  self._conditionDic.CheckIsFirstP5PetInTeam = self._CheckIsFirstP5PetInTeam
  self._conditionDic.CheckIsAllWeak = self._CheckIsAllWeak
  self._conditionDic.CheckTrapOpenStateChangeByResult = self._CheckTrapOpenStateChangeByResult
  self._conditionDic.CheckTrapSummonMonsterByResult = self._CheckTrapSummonMonster
  self._conditionDic.CheckTrapOpenStateChange = self._CheckTrapOpenStateChange
  self._conditionDic.CheckCasterIsDead = self._CheckCasterIsDead
  self._conditionDic.CheckHasRotate = self._CheckHasRotate
  self._conditionDic.CheckCurrentRoundCount = self._CheckCurrentRoundCount
  self._conditionDic.CheckTargetHPAndSceneState = self._CheckTargetHPAndSceneState
end

function SkillViewConditionHelper:CheckCondition(conditionName, casterEntity, phaseContext, conditionParam)
  local conditionFunc = self._conditionDic[conditionName]
  if conditionFunc then
    return conditionFunc(self, casterEntity, phaseContext, conditionParam)
  else
    Log.fatal("Can not find condition function:", conditionName)
  end
end

function SkillViewConditionHelper:CheckDamageIndexValid(casterEntity, phaseContext, conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, damageStageIndex)
  if not damageResultArray or #damageResultArray == 0 then
    return false
  end
  if damageResultArray[1]._targetID == -1 then
    return false
  end
  local damageIndex = phaseContext:GetCurDamageResultIndex()
  if 0 < damageIndex and damageIndex <= #damageResultArray then
    return true
  end
  return false
end

function SkillViewConditionHelper:CheckDamageInfoIndexValid(casterEntity, phaseContext, conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, damageStageIndex)
  if not damageResultArray then
    return false
  end
  if damageResultArray[1]._targetID == -1 then
    return false
  end
  local damageIndex = phaseContext:GetCurDamageResultIndex()
  local damageResult = damageResultArray[damageIndex]
  if not damageResult then
    return false
  end
  local damageInfoIndex = phaseContext:GetCurDamageInfoIndex()
  local damageInfo = damageResult:GetDamageInfo(damageInfoIndex)
  if not damageInfo then
    return false
  end
  return true
end

function SkillViewConditionHelper:CheckDamageIndex2Valid(casterEntity, phaseContext, conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, damageStageIndex)
  if not damageResultArray then
    return false
  end
  local damageIndex = phaseContext:GetCurDamageIndex()
  for i, damageResult in ipairs(damageResultArray) do
    if damageResult:GetDamageIndex() == damageIndex then
      local damageInfoIndex = phaseContext:GetCurDamageInfoIndex()
      local damageInfo = damageResult:GetDamageInfo(damageInfoIndex)
      if damageInfo then
        return true
      end
    end
  end
  return false
end

function SkillViewConditionHelper:CheckBuffIndexValid(casterEntity, phaseContext, conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBuff)
  if not damageResultArray then
    return false
  end
  local damageIndex = phaseContext:GetCurBuffResultIndex()
  if 0 < damageIndex and damageIndex <= #damageResultArray then
    return true
  end
  return false
end

function SkillViewConditionHelper:CheckIsLastDamage(casterEntity, phaseContext, conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  local damageIndex = phaseContext:GetCurDamageResultIndex()
  if 0 < damageIndex and damageIndex < #damageResultArray then
    return false
  end
  return true
end

function SkillViewConditionHelper:CheckCurrentScopeGridRangeIndexValid(casterEntity, phaseContext, conditionParam)
  local scopeGridRange = phaseContext:GetScopeGridRange()
  if not scopeGridRange then
    return false
  end
  local maxScopeRangeCount = phaseContext:GetMaxRangeCount()
  if not maxScopeRangeCount then
    return false
  end
  local curScopeGridRangeIndex = phaseContext:GetCurScopeGridRangeIndex()
  if maxScopeRangeCount < curScopeGridRangeIndex then
    return false
  end
  return true
end

function SkillViewConditionHelper:CheckAbsortPieceCountLessThan(casterEntity, phaseContext, conditionParam)
  local count = 0
  if conditionParam then
    count = tonumber(conditionParam)
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local absorbResult = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AbsorbPiece)
  local absorbCount = 0
  if absorbResult then
    for _, v in pairs(absorbResult) do
      local list = v:GetAbsorbPieceList()
      if list then
        for _, p in pairs(list) do
          absorbCount = absorbCount + 1
        end
      end
    end
  end
  if count > absorbCount then
    return true
  end
  return false
end

function SkillViewConditionHelper:CheckAbsortPieceCountMoreThan(casterEntity, phaseContext, conditionParam)
  local count = 0
  if conditionParam then
    count = tonumber(conditionParam)
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local absorbResult = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AbsorbPiece)
  local absorbCount = 0
  if absorbResult then
    for _, v in pairs(absorbResult) do
      local list = v:GetAbsorbPieceList()
      if list then
        for _, p in pairs(list) do
          absorbCount = absorbCount + 1
        end
      end
    end
  end
  if count < absorbCount then
    return true
  end
  return false
end

function SkillViewConditionHelper:CheckTrue(casterEntity, phaseContext, conditionParam)
  return true
end

function SkillViewConditionHelper:_CheckBuffRefreshValid(casterEntity, phaseContext, conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local ResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ModifyBuffValue)
  local damageIndex = phaseContext:GetCurBuffResultIndex()
  if 0 < damageIndex and damageIndex <= #ResultArray then
    return true
  end
  return false
end

function SkillViewConditionHelper:_CheckSummonThingValid(casterEntity, phaseContext, conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if skillEffectResultContainer == nil then
    Log.fatal("_CheckSummonThingValid skillEffectResultContainer is nil")
    return false
  end
  local summonEverythingResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonEverything)
  if not summonEverythingResultArray then
    return false
  end
  local idx = phaseContext:GetCurSummonInEverythingIndex()
  if summonEverythingResultArray[idx] then
    return true
  end
  return false
end

function SkillViewConditionHelper:_CheckTargetCountInScope(casterEntity, phaseContext, conditionParam)
  local count = tonumber(conditionParam) or 0
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  if not scopeResult then
    return false
  end
  local targetIDs = scopeResult:GetTargetIDs()
  return count == #targetIDs
end

function SkillViewConditionHelper:_CheckEffectResultIndex(casterEntity, phaseContext, rawParam)
  assert(type(rawParam) == "string", "Jump: CheckEffectResultIndex需要配置参数")
  local splitParam = string.split(rawParam, "|")
  local conditionParam = {
    effectType = splitParam[1],
    isTargetRequired = splitParam[2]
  }
  local effectType = tonumber(conditionParam.effectType)
  assert(effectType, "Jump: CheckEffectResultIndex需要配置effectType")
  local isTargetRequired = conditionParam.isTargetRequired == "true"
  local resultEffectType = effectType
  local overrideEffectType = SkillEffectResultTypeOverride[effectType]
  if overrideEffectType then
    Log.notice(self._className, "override effectType for results: ", effectType, "=>", overrideEffectType)
    resultEffectType = overrideEffectType
  end
  local routineCmpt = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = routineCmpt:GetEffectResultsAsArray(resultEffectType)
  if not resultArray then
    Log.warn(self._className, "No results for type", effectType, "=>", overrideEffectType)
    return false
  end
  local index = phaseContext:GetCurResultIndexByType(effectType)
  local result = resultArray[index]
  if not result then
    return false
  end
  if isTargetRequired and result:GetTargetID() == -1 then
    Log.notice(self._className, "Index ", index, "is invalid. ")
    return false
  end
  return true
end

function SkillViewConditionHelper:_CheckEffectMultiResultIndex(casterEntity, phaseContext, rawParam)
  assert(type(rawParam) == "string", "Jump: _CheckEffectMultiResultIndex需要配置参数")
  local splitParam = string.split(rawParam, "|")
  local routineCmpt = casterEntity:SkillRoutine():GetResultContainer()
  local hasResultCount = 0
  for _, value in ipairs(splitParam) do
    local effectType = tonumber(value)
    local resultArray = routineCmpt:GetEffectResultsAsArray(effectType)
    if resultArray then
      for _, result in ipairs(resultArray) do
        if not result or effectType == SkillEffectType.Damage and result:GetTargetID() == -1 then
        else
          hasResultCount = hasResultCount + 1
          break
        end
      end
    end
  end
  return 0 < hasResultCount
end

function SkillViewConditionHelper:_CheckContainCurrentScopeGrid(casterEntity, phaseContext, rawParam)
  local arrStr = string.split(rawParam, "|")
  local posList = {}
  for _, str in ipairs(arrStr) do
    local arrStrPos = string.split(str, "_")
    local v = Vector2(tonumber(arrStrPos[1]), tonumber(arrStrPos[2])) + casterEntity:GetGridPosition()
    table.insert(posList, v)
  end
  local scopeGridRange = phaseContext:GetScopeGridRange()
  local curScopeGridRangeIndex = phaseContext:GetCurScopeGridRangeIndex()
  local gridList = scopeGridRange[curScopeGridRangeIndex]
  for _, range in pairs(scopeGridRange) do
    if range then
      local posList2 = range[curScopeGridRangeIndex]
      if posList2 then
        for _, pos2 in ipairs(posList2) do
          if table.icontains(posList, pos2) then
            return true
          end
        end
      end
    end
  end
  return false
end

function SkillViewConditionHelper:_IsAddBloodValueGreaterThan(casterEntity, phaseContext, conditionParam)
  local valCompare = 0
  if conditionParam then
    valCompare = tonumber(conditionParam)
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local addHpResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBlood)
  if addHpResultArray then
    for _, result in ipairs(addHpResultArray) do
      local addValue = result:GetAddValue()
      if valCompare < addValue then
        return true
      end
    end
  end
  local eachTrapAddBloodResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.EachTrapAddBlood)
  if eachTrapAddBloodResultArray then
    for _, result in ipairs(eachTrapAddBloodResultArray) do
      local addValue = result:GetAddValue()
      if valCompare < addValue then
        return true
      end
    end
  end
  return false
end

function SkillViewConditionHelper:CheckSoul(casterEntity, phaseContext, conditionParam)
  local buffView = casterEntity:BuffView()
  local soulCount = buffView:GetBuffValue("SoulCount") or 0
  return 0 < soulCount
end

function SkillViewConditionHelper:CheckMonsterDeath(casterEntity, phaseContext, conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.RandAttack)
  local cnt = results:GetListDeadCount()
  return 0 < cnt
end

function SkillViewConditionHelper:CheckMonsterAlive(casterEntity, phaseContext, conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.RandAttack)
  local cnt = results:GetListAliveCount()
  return 0 < cnt
end

function SkillViewConditionHelper:CheckMiyaPhase2(casterEntity, phaseContext, conditionParam)
  return self:CheckSoul(casterEntity, phaseContext, conditionParam) and self:CheckMonsterAlive(casterEntity, phaseContext, conditionParam)
end

function SkillViewConditionHelper:CheckDamageIndexLast(casterEntity, phaseContext, conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, damageStageIndex)
  if not damageResultArray or #damageResultArray == 0 then
    return false
  end
  if damageResultArray[1]._targetID == -1 then
    return false
  end
  local damageIndex = phaseContext:GetCurDamageResultIndex()
  if 0 < damageIndex and damageIndex == #damageResultArray - 1 then
    return true
  end
  return false
end

function SkillViewConditionHelper:_CheckTargetIsCanMove(casterEntity, phaseContext, conditionParam)
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  if not targetEntity then
    return false
  end
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local bodyAreaCmpt = targetEntity:BodyArea()
  return not env:IsImmuneHitback(targetEntity) and #bodyAreaCmpt:GetArea() == 1
end

function SkillViewConditionHelper:CheckDamageSkillResultTargetCount(casterEntity, phaseContext, conditionParam)
  local splitParam = string.split(conditionParam, "|")
  local cmpType = tonumber(splitParam[1])
  local count = tonumber(splitParam[2])
  local skillEffectType = tonumber(splitParam[3]) or SkillEffectType.Damage
  local targetEntityIDsList = {}
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageStageIndex = phaseContext:GetCurDamageResultStageIndex()
  if skillEffectType == SkillEffectType.Damage then
    local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, damageStageIndex)
    if not damageResultArray or #damageResultArray == 0 then
      return false
    end
    for _, v in ipairs(damageResultArray) do
      local damageResult = v
      local targetEntityID = damageResult:GetTargetID()
      local targetEntity = self._world:GetEntityByID(targetEntityID)
      if targetEntity and not targetEntity:HasTrapID() and not table.intable(targetEntityIDsList, targetEntityID) then
        table.insert(targetEntityIDsList, targetEntityID)
      end
    end
  elseif skillEffectType == SkillEffectType.AddBuff then
    local buffResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBuff, damageStageIndex)
    if not buffResultArray or #buffResultArray == 0 then
      return false
    end
    for _, v in ipairs(buffResultArray) do
      local buffResult = v
      local targetEntityID = buffResult:GetEntityID()
      local targetEntity = self._world:GetEntityByID(targetEntityID)
      if targetEntity and not table.intable(targetEntityIDsList, targetEntityID) then
        table.insert(targetEntityIDsList, targetEntityID)
      end
    end
  end
  local isMatch = Algorithm.CmpByOperator(#targetEntityIDsList, count, cmpType)
  return isMatch
end

function SkillViewConditionHelper:CheckCasterHasBuff(casterEntity, phaseContext, conditionParam)
  local splitParam = string.split(conditionParam, "|")
  local targetBuffEffectType = tonumber(splitParam[1])
  local targetBuffCount = tonumber(splitParam[2])
  local curBuffCount = 0
  local buffViewComponent = casterEntity:BuffView()
  if buffViewComponent then
    local viewIns = buffViewComponent:GetBuffViewInstanceArray()
    for _, inst in ipairs(viewIns) do
      local buffEffectType = inst:GetBuffEffectType()
      if targetBuffEffectType == buffEffectType then
        curBuffCount = curBuffCount + 1
      end
    end
  end
  local isMatch = targetBuffCount == curBuffCount
  return isMatch
end

function SkillViewConditionHelper:CheckDeadTarget(casterEntity, phaseContext, conditionParam)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, damageStageIndex)
  if not damageResultArray or #damageResultArray == 0 then
    return false
  end
  local targetEntityList = {}
  for _, v in ipairs(damageResultArray) do
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = world:GetEntityByID(targetEntityID)
    if targetEntity and not table.intable(targetEntityList, targetEntity) then
      table.insert(targetEntityList, targetEntity)
    end
  end
  local deadMonsterIDList = {}
  for _, entity in ipairs(targetEntityList) do
    local view = entity:View()
    local renderCurHP = entity:HP():GetRedHP()
    if view and renderCurHP == 0 then
      table.insert(deadMonsterIDList, entity:GetID())
    end
  end
  local damageIndex = phaseContext:GetCurDamageResultIndex()
  if 0 < damageIndex and damageIndex <= #deadMonsterIDList then
    return true
  end
  return false
end

function SkillViewConditionHelper:_CheckHasTeleport(casterEntity, phaseContext, conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local teleportEffectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport, damageStageIndex)
  local hasTeleport = 0
  if conditionParam then
    hasTeleport = tonumber(conditionParam)
  end
  if not teleportEffectResult and hasTeleport == 0 then
    return true
  end
  local oldPos = teleportEffectResult:GetPosOld()
  local newPos = teleportEffectResult:GetPosNew()
  local hasMove = oldPos.x ~= newPos.x or oldPos.y ~= newPos.y
  local result = false
  if hasTeleport == 0 then
    result = not hasMove
  else
    result = hasMove
  end
  return result
end

function SkillViewConditionHelper:_CheckOnAbyss(casterEntity, phaseContext, conditionParam)
  local pos = casterEntity:GetGridPosition()
  local world = casterEntity:GetOwnerWorld()
  local env = world:GetPreviewEntity():PreviewEnv()
  local es = env:GetEntitiesAtPos(pos, function(e)
    return e:TrapRender() and e:TrapRender():GetTrapType() == TrapType.TerrainAbyss
  end)
  local onAbyss = 0 < #es
  if tonumber(conditionParam) == 1 then
    return onAbyss
  end
  return not onAbyss
end

function SkillViewConditionHelper:_CheckCurScopeRangeOnCrossLine(casterEntity, phaseContext, conditionParam)
  local scopeGridRange = phaseContext:GetScopeGridRange()
  local curScopeGridRangeIndex = phaseContext:GetCurScopeGridRangeIndex()
  local curRange = scopeGridRange[curScopeGridRangeIndex]
  if not curRange then
    return false
  end
  local gridList = curRange[1]
  if not gridList then
    return false
  end
  if #gridList <= 1 then
    return false
  end
  local xIsLine = true
  local yIsLine = true
  local lastX = gridList[1].x
  local lastY = gridList[1].y
  for index, value in ipairs(gridList) do
    if xIsLine and lastX ~= value.x then
      xIsLine = false
    end
    if yIsLine and lastY ~= value.y then
      yIsLine = false
    end
    if not (xIsLine or yIsLine) then
      break
    end
  end
  return xIsLine or yIsLine
end

function SkillViewConditionHelper:_CheckSummonOnFixPosValid(casterEntity, phaseContext, conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if skillEffectResultContainer == nil then
    Log.fatal("_CheckSummonOnFixPosValid skillEffectResultContainer is nil")
    return false
  end
  local summonResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonOnFixPosLimit)
  if not summonResultArray then
    return false
  end
  local summonResult = summonResultArray[1]
  local trapIDList = summonResult:GetTrapIDList()
  local idx = phaseContext:GetCurSummonOnFixPosIndex()
  if trapIDList[idx] then
    return true
  end
  return false
end

function SkillViewConditionHelper:_CheckIsFirstP5PetInTeam(casterEntity, phaseContext, conditionParam)
  local checkPetID = 0
  if conditionParam then
    checkPetID = tonumber(conditionParam)
  end
  if 0 < checkPetID then
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    if teamEntity then
      local teamCmpt = teamEntity:Team()
      local teamOrder = teamCmpt:GetTeamOrder()
      for order, petPstID in ipairs(teamOrder) do
        local petEntity = teamCmpt:GetPetEntityByPetPstID(petPstID)
        local matchPet = petEntity:MatchPet():GetMatchPet()
        local petFeatureList = matchPet:GetFeatureList()
        if petFeatureList then
          local petFeatures = petFeatureList.feature
          if petFeatures and petFeatures[FeatureType.PersonaSkill] then
            if matchPet:GetTemplateID() == checkPetID then
              return true
            else
              return false
            end
          end
        end
      end
    end
  end
  return false
end

function SkillViewConditionHelper:_CheckIsAllWeak(casterEntity, phaseContext, conditionParam)
  local utilDataSvc = self._world:GetService("UtilData")
  local allWeak = utilDataSvc:GetEntityAttributeByName(casterEntity, "AllEnemyWeak") or 0
  if allWeak == 1 then
    return true
  end
  return false
end

function SkillViewConditionHelper:_CheckTrapOpenStateChangeByResult(casterEntity, phaseContext, conditionParam)
  local checkState = tonumber(conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.TrapSummonMonster)
  if not resultArray or not casterEntity:HasTrapRender() then
    return false
  end
  local result = resultArray[1]
  local renderAttrCmpt = casterEntity:RenderAttributes()
  local change = result:GetTrapOpenStateChange()
  local state = result:GetTrapOpenState()
  if not change then
    return false
  end
  if state == checkState then
    return true
  end
  return false
end

function SkillViewConditionHelper:_CheckTrapSummonMonster(casterEntity, phaseContext, conditionParam)
  local checkState = tonumber(conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.TrapSummonMonster)
  if not resultArray or not casterEntity:HasTrapRender() then
    return false
  end
  local result = resultArray[1]
  local entityID = result:GetSummonEntityID()
  if checkState == 1 and entityID ~= nil then
    return true
  elseif checkState == 0 and entityID == nil then
    return true
  end
  return false
end

function SkillViewConditionHelper:_CheckTrapOpenStateChange(casterEntity, phaseContext, conditionParam)
  local checkState = tonumber(conditionParam)
  local renderAttrCmpt = casterEntity:RenderAttributes()
  if renderAttrCmpt:GetAttribute("OpenState") and renderAttrCmpt:GetAttribute("OpenState") == checkState then
    return true
  end
  return false
end

function SkillViewConditionHelper:_CheckCasterIsDead(casterEntity, phaseContext, conditionParam)
  local utilDataSvc = self._world:GetService("UtilData")
  return utilDataSvc:IsEntityLogicDead(casterEntity)
end

function SkillViewConditionHelper:_CheckHasRotate(casterEntity, phaseContext, conditionParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local skillRotateEffectResult = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Rotate)
  if skillRotateEffectResult and table.count(skillRotateEffectResult) > 0 then
    return true
  end
  return false
end

function SkillViewConditionHelper:_CheckCurrentRoundCount(casterEntity, phaseContext, conditionParam)
  assert(type(conditionParam) == "string", "Jump: _CheckCurrentRoundCount需要配置参数")
  local splitParam = string.split(conditionParam, "|")
  local roundList = {}
  for _, value in ipairs(splitParam) do
    roundList[#roundList + 1] = tonumber(value)
  end
  local curRoundCount = BattleStatHelper.GetLevelTotalRoundCount()
  if table.icontains(roundList, curRoundCount) then
    return true
  end
  return false
end

function SkillViewConditionHelper:_CheckTargetHPAndSceneState(casterEntity, phaseContext, conditionParam)
  assert(type(conditionParam) == "string", "Jump: _CheckTargetHPAndSceneState需要配置参数")
  local splitParam = string.split(conditionParam, "|")
  local sceneState = tonumber(splitParam[1])
  local trapID = tonumber(splitParam[2])
  local trapHPPercent = tonumber(splitParam[3])
  local buffView = casterEntity:BuffView()
  local curSceneState = buffView:GetBuffValue(BattleConst.N34BossSceneState) or 1
  if curSceneState ~= sceneState then
    return false
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local curHPPercent = utilDataSvc:GetTrapHPPercentByTrapID(trapID)
  if trapHPPercent < curHPPercent then
    return false
  end
  buffView:SetBuffValue(BattleConst.N34BossSceneState, curSceneState + 1)
  return true
end
