_class("SkillEffectCalcService", BaseService)
SkillEffectCalcService = SkillEffectCalcService

function SkillEffectCalcService:Constructor(world)
  self._world = world
  self:RegistSkillEffectCalculator()
end

function SkillEffectCalcService:Initialize()
  self._configService = self._world:GetService("Config")
  self._mathService = self._world:GetService("Math")
  self._calcDamageService = self._world:GetService("CalcDamage")
end

function SkillEffectCalcService:CalcSkillEffect_All(skillEffectCalcParam)
  local svcCfgDeco = self._world:GetService("ConfigDecoration")
  local skillEffectArray = svcCfgDeco:GetLatestEffectParamArray(skillEffectCalcParam.casterEntityID, skillEffectCalcParam.skillID)
  local skillEffectResult = {}
  for skillEffectIndex = 1, #skillEffectArray do
    skillEffectCalcParam.skillEffectParam = skillEffectArray[skillEffectIndex]
    self:_ChangeSkillTargetAndScopeForAddBlood(skillEffectCalcParam)
    local skillResult = self:CalcSkillEffectByType(skillEffectCalcParam)
    if skillResult ~= nil then
      if skillResult._className ~= nil then
        skillEffectResult[#skillEffectResult + 1] = skillResult
      else
        for _, v in ipairs(skillResult) do
          skillEffectResult[#skillEffectResult + 1] = v
        end
      end
    end
  end
  self:ResetSkillContext(skillEffectCalcParam.casterEntityID)
  return skillEffectResult
end

function SkillEffectCalcService:_ChangeSkillTargetAndScopeForAddBlood(skillEffectCalcParam)
  if skillEffectCalcParam.skillEffectParam:GetEffectType() ~= SkillEffectType.AddBlood then
    return
  end
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  skillEffectCalcParam:SetGridPos(teamPos)
  skillEffectCalcParam:SetTargetEntityIDs({
    teamEntity:GetID()
  })
end

function SkillEffectCalcService:CalcSkillEffectByType(skillEffectCalcParam)
  local effectType = skillEffectCalcParam.skillEffectParam:GetEffectType()
  local classType = self._skillEffectCalculatorDic[effectType]
  if classType == nil then
    Log.exception("SkillEffectCalcService cant find effectype ", effectType)
  end
  local skillID = skillEffectCalcParam:GetSkillID()
  self:LogNotice("CalcSkillEffectByType() ", effectType, GetEnumKey("SkillEffectType", effectType), " skillID:", skillID)
  local effectDataObj = classType:New(self._world)
  if effectDataObj then
    return effectDataObj:DoSkillEffectCalculator(skillEffectCalcParam)
  end
end

function SkillEffectCalcService:ComputeSkillDamage(attacker, attackPos, defender, damagePos, skillID, damageParam, effectType, damageStageIndex, ignoreShield, curSkillDamageIndex, damageGridPos)
  local percentList = damageParam:GetDamagePercent()
  local damageFormulaID = damageParam:GetDamageFormulaID()
  damageParam.attackPos = attackPos
  damageParam.damagePos = damagePos
  damageParam.formulaID = damageFormulaID
  damageParam.skillID = skillID
  damageParam.skillEffectType = effectType
  local totalDamage = 0
  local multiDamageInfo = {}
  for _, percent in ipairs(percentList) do
    damageParam.percent = percent
    self:NotifyDamageBegin(attacker, defender, attackPos, damagePos, skillID, effectType, damageStageIndex)
    local damageInfo = self._calcDamageService:DoCalcDamage(attacker, defender, damageParam, ignoreShield, damageGridPos)
    damageInfo:SetDamageStageIndex(damageStageIndex)
    damageInfo:SetCurSkillDamageIndex(curSkillDamageIndex)
    totalDamage = totalDamage + damageInfo:GetDamageValue()
    table.insert(multiDamageInfo, damageInfo)
    self:NotifyDamageEnd(attacker, defender, attackPos, damagePos, skillID, damageInfo, effectType, damageStageIndex)
  end
  return totalDamage, multiDamageInfo
end

function SkillEffectCalcService:NewSkillDamageEffectResult(gridPos, targetid, damage, damageArray, damageStageIndex)
  local skillResult = SkillDamageEffectResult:New(gridPos, targetid, damage, damageArray, damageStageIndex)
  return skillResult
end

function SkillEffectCalcService:CalcHitbackEffect(attackerPos, attackerDir, attackerBodyArea, targetID, dirType, pullType, distance, calcType, ignorePlayerBlock, excludeCasterPos, casterEntity, skillRange, notCalcBomb, ignorePathBlock, backupDirectionPlan, interactType, skillType, extraBlockPos)
  local defender = self._world:GetEntityByID(targetID)
  local defenderPos = defender:GetGridPosition()
  local defenderBodyArea = defender:BodyArea()
  local dir
  dir, distance = self:CalHitbackDir(attackerPos, attackerDir, attackerBodyArea, targetID, dirType, pullType, distance, casterEntity, skillRange, backupDirectionPlan)
  local excludePosList = {}
  if excludeCasterPos then
    local casterBodyArea = attackerBodyArea:GetArea()
    if casterBodyArea and attackerPos then
      for i = 1, #casterBodyArea do
        excludePosList[#excludePosList + 1] = casterBodyArea[i] + attackerPos
      end
    end
  end
  local targetPos, isBlocked, blockMonsterID, realHitBackDistance = self:CalHitbackPosByEntityDir(defenderPos, defenderBodyArea, dir, distance, excludePosList, ignorePlayerBlock, defender, ignorePathBlock, interactType, extraBlockPos)
  return targetPos, dir, isBlocked, blockMonsterID, realHitBackDistance
end

function SkillEffectCalcService:CheckHitbackDefender(targetID)
  local defender = self._world:GetEntityByID(targetID)
  if not defender then
    return false
  end
  if defender:HasTrap() then
    local trapCmp = defender:Trap()
    if TrapType.BombByHitBack ~= trapCmp:GetTrapType() then
      return false
    end
  end
  local defenderPos = defender:GetGridPosition()
  local defenderBodyArea = defender:BodyArea()
  local buffLogicSvc = self._world:GetService("BuffLogic")
  if not buffLogicSvc:CheckCanBeHitBack(defender) then
    return false, SkillHitBackEffectResult:New(targetID, defenderPos, defenderPos)
  end
  return true
end

function SkillEffectCalcService:CalcHitbackEffectResult(attackerPos, attackerDir, attackerBodyArea, targetID, dirType, pullType, distance, calcType, ignorePlayerBlock, excludeCasterPos, casterEntity, skillRange, notCalcBomb, ignorePathBlock, backupDirectionPlan, interactType, skillType, extraBlockPos)
  local checkFlag, ret = self:CheckHitbackDefender(targetID)
  if not checkFlag then
    return ret
  end
  local targetPos, dir, isBlocked, blockMonsterID, realHitBackDistance = self:CalcHitbackEffect(attackerPos, attackerDir, attackerBodyArea, targetID, dirType, pullType, distance, calcType, ignorePlayerBlock, excludeCasterPos, casterEntity, skillRange, notCalcBomb, ignorePathBlock, backupDirectionPlan, interactType, skillType, extraBlockPos)
  if not targetPos then
    return
  end
  local hitbackResult = self:CalcHitbackEffectResultProcess(targetID, calcType, casterEntity, dir, targetPos, SkillEffectType.HitBack, notCalcBomb, isBlocked, blockMonsterID, skillType, realHitBackDistance)
  return hitbackResult
end

function SkillEffectCalcService:CalcHitbackEffectResultProcess(targetID, calcType, casterEntity, dir, targetPos, convertSource, notCalcBomb, isBlocked, blockMonsterID, skillType, realHitBackDistance)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local triggerService = self._world:GetService("Trigger")
  local utilData = self._world:GetService("UtilData")
  local defender = self._world:GetEntityByID(targetID)
  local defenderPos = defender:GetGridPosition()
  local boardEntity = self._world:GetBoardEntity()
  local bodyArea, blockFlag = boardServiceLogic:RemoveEntityBlockFlag(defender, defenderPos)
  local tConvertInfo = {}
  local pieceChangeTable = self:_CalcHitbackPieceChangeTable(defenderPos, targetPos, defender)
  if pieceChangeTable ~= nil then
    for pos, pieceType in pairs(pieceChangeTable) do
      boardServiceLogic:SetPieceTypeLogic(pieceType, pos)
      local convertInfo = NTGridConvert_ConvertInfo:New(pos, PieceType.None, pieceType)
      table.insert(tConvertInfo, convertInfo)
    end
  end
  local ntGridConvert = NTGridConvert:New(boardEntity, tConvertInfo)
  ntGridConvert:SetConvertEffectType(convertSource)
  ntGridConvert:SetSkillType(skillType)
  self._world:GetService("Trigger"):Notify(ntGridConvert)
  defender:SetGridPosition(targetPos)
  Log.info("HitBackData Defender:", defender:GetID(), " NewPos:", targetPos)
  if defender:HasTeam() then
    local pets = defender:Team():GetTeamPetEntities()
    for i, petEntity in ipairs(pets) do
      petEntity:SetGridPosition(targetPos)
      petEntity:GridLocation():SetMoveLastPosition(targetPos)
    end
  end
  local trapIds = {}
  if targetPos ~= defenderPos then
    local triggerTraps = trapServiceLogic:TriggerTrapByEntity(defender, TrapTriggerOrigin.Hitback)
    for i, e in ipairs(triggerTraps) do
      trapIds[#trapIds + 1] = e:GetID()
    end
  end
  local colorNew = utilData:FindPieceElement(targetPos)
  if defender:HasTeam() and boardServiceLogic:GetCanConvertGridElementForTeamPos(targetPos) then
    colorNew = PieceType.None
  end
  boardServiceLogic:SetPieceTypeLogic(colorNew, defender:GetGridPosition())
  boardServiceLogic:SetEntityBlockFlag(defender, targetPos, blockFlag)
  local bombPos = targetPos
  if defender:HasTeam() or defender:HasMonsterID() then
    bombPos = targetPos + dir
  end
  local trapEntity
  if notCalcBomb == nil then
    trapEntity = trapServiceLogic:TriggerBomb(bombPos, defender)
  end
  if trapEntity then
    local trapCmpt = trapEntity:Trap()
    trapEntity:Attributes():Modify("HP", 0)
    trapServiceLogic:AddTrapDeadMark(trapEntity)
    local notifyTrapAction = NTTrapAction:New(nil, defenderPos)
    triggerService:Notify(notifyTrapAction)
  end
  local sTrigger = self._world:GetService("Trigger")
  sTrigger:Notify(NTHitBackEnd:New(casterEntity, defender, defenderPos, targetPos, dir))
  local hitbackResult = SkillHitBackEffectResult:New(targetID, defenderPos, targetPos, pieceChangeTable, calcType, dir, colorNew)
  hitbackResult:SetTriggerTrapIds(trapIds)
  if trapEntity then
    hitbackResult:SetBombTrapEntityID(trapEntity:GetID())
  end
  if isBlocked ~= nil then
    hitbackResult:SetIsBlocked(isBlocked)
  end
  if blockMonsterID then
    hitbackResult:SetBlockMonsterID(blockMonsterID)
  end
  return hitbackResult
end

function SkillEffectCalcService:CalHitbackDir(attackerPos, attackerDir, attackerBodyArea, targetID, dirType, pullType, distance, casterEntity, skillRange, backupDirectionPlan)
  local defender = self._world:GetEntityByID(targetID)
  local defenderPos = defender:GetGridPosition()
  local defenderBodyArea = defender:BodyArea()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local dir
  if dirType == HitBackDirectionType.Cross then
    dir = GameHelper.ComputeLogicDir(attackerDir)
  elseif dirType == HitBackDirectionType.SelectCanUseDir then
    dir, distance = utilCalcSvc:_CalCanUseHitBackDir(defender, distance)
  elseif dirType == HitBackDirectionType.SelectSquareRingFarest then
    dir = utilCalcSvc:_CalSelectSquareRingFarest(defender, casterEntity)
  elseif dirType == HitBackDirectionType.SelectCanUse8Dir then
    local tmpDir = GameHelper.ComputeLogicDir(attackerDir)
    dir, distance = utilCalcSvc:_CalCanUseHitBackDir8(tmpDir, defender, distance)
  elseif dirType == HitBackDirectionType.SelectNearestOutOfRange then
    dir, distance = utilCalcSvc:_CalcNearestPosOutOfRange(skillRange, defender)
  elseif dirType == HitBackDirectionType.SelectCanUseDirAndDis then
    dir, distance = utilCalcSvc:CalSelectCanUseDirAndDis(attackerDir, defender, distance)
  elseif dirType == HitBackDirectionType.CoffinMusume then
    dir, distance = utilCalcSvc:CalCoffinMusumeHitbackDirAndDis(attackerPos, attackerDir, defender, distance, casterEntity)
  elseif dirType == HitBackDirectionType.CasterDir2Edge then
    dir = attackerDir
  elseif dirType == HitBackDirectionType.Front3Dir then
    dir = utilCalcSvc:CalcHitBackFront3Dir(attackerPos, attackerDir, defender, distance, casterEntity)
  elseif dirType == HitBackDirectionType.AttackFront2Edge then
    dir = utilCalcSvc:CalcHitBackAttackFront2Edge(attackerPos, attackerBodyArea, defenderPos)
  elseif dirType == HitBackDirectionType.EightDirAndCasterAround then
    dir, distance = utilCalcSvc:CalEightDirAndCasterAround(casterEntity, defender, distance)
  elseif dirType == HitBackDirectionType.Butterfly then
    dir, distance = utilCalcSvc:CalButterflyHitBackDirAndDistance(casterEntity, defender)
  elseif dirType == HitBackDirectionType.BossCarrot then
    local casterCenterPos = casterEntity:GetGridPosition()
    local casterBodyArea = casterEntity:BodyArea():GetArea()
    local clockWiseRate = BattleConst.BossCarrotHitBackClockWiseRate
    dir, distance = utilCalcSvc:_CalcHitBackDirBossCarrot(casterCenterPos, casterBodyArea, defenderPos, casterEntity, defender, clockWiseRate)
  elseif dirType == HitBackDirectionType.Scorpion then
    dir, distance = utilCalcSvc:_CalcHitBackScorpion(casterEntity, defender, distance)
  else
    dir = utilCalcSvc:_CalcHitBackDir(dirType, attackerPos, defenderPos, attackerBodyArea, defenderBodyArea)
  end
  if dir == nil or dir == Vector2.zero then
    if backupDirectionPlan then
      if backupDirectionPlan == HitBackDirectionBackupPlan.AlwaysUp then
        dir = Vector2.up
      end
    else
      return Vector2.zero, 0
    end
  end
  if pullType == HitBackType.PullBack then
    dir = -dir
  end
  return dir, distance
end

function SkillEffectCalcService:CalHitbackPosByEntityDir(pos, bodyArea, dir, distance, exceptPosList, ignorePlayerBlock, entity, ignorePathBlock, interactType, extraBlockPos)
  extraBlockPos = extraBlockPos or {}
  local targetPos = pos:Clone()
  local isBlocked = false
  local blockMonsterID
  local defenderBodyArea = bodyArea
  local exceptPosList = exceptPosList or {}
  local bodyArea = defenderBodyArea:GetArea()
  for i = 1, #bodyArea do
    exceptPosList[#exceptPosList + 1] = pos + bodyArea[i]
  end
  local useCheckBlockFlag = BlockFlag.HitBack
  if entity:HasMonsterID() then
    local raceType = entity:MonsterID():GetMonsterRaceType()
    if MonsterRaceType.Fly == raceType then
      useCheckBlockFlag = BlockFlag.HitBackFly
    end
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local realHitBackDistance = 0
  for i = 1, distance do
    local tempPos = targetPos + dir
    local needBreak = false
    for j = 1, #bodyArea do
      local tempBodyPos = tempPos + bodyArea[j]
      if table.Vector2Include(extraBlockPos, tempBodyPos) then
        needBreak = true
        break
      elseif not table.icontains(exceptPosList, tempBodyPos) then
        if not utilDataSvc:IsValidPiecePos(tempBodyPos) then
          if interactType == HitBackInteractnWithBoardType.OutBoardEdge then
            targetPos = tempPos
            realHitBackDistance = i
          end
          needBreak = true
          break
        end
        if not ignorePathBlock then
          if utilDataSvc:IsPosBlock(tempBodyPos, useCheckBlockFlag) or utilDataSvc:IsPosBlockWithEntityRace(tempBodyPos, useCheckBlockFlag, entity) then
            local isHasMonster, monsterID = utilScopeSvc:IsPosHasMonster(tempBodyPos)
            if isHasMonster then
              blockMonsterID = monsterID
            end
            needBreak = true
            break
          end
          local checkTrapWallPosStart = tempBodyPos - dir
          local trapWallBlock = utilDataSvc:CalcHitbackForTrapWallBlock(checkTrapWallPosStart, tempBodyPos, useCheckBlockFlag)
          if trapWallBlock then
            needBreak = true
            break
          end
        end
      end
    end
    local trapWallBlock = utilDataSvc:CalcHitbackForTrapWallBlockMultiBodyArea(tempPos, bodyArea)
    if trapWallBlock then
      needBreak = true
      break
    end
    local extraBoardPosRange = utilDataSvc:GetExtraBoardPosList()
    if table.icontains(extraBoardPosRange, tempPos) then
      needBreak = true
      break
    end
    if needBreak then
      isBlocked = true
      break
    end
    targetPos = tempPos
    realHitBackDistance = i
  end
  local cmptTrap = entity:Trap()
  if cmptTrap and TrapType.BombByHitBack == cmptTrap:GetTrapType() then
    local posNext = targetPos + dir
    if utilDataSvc:IsHaveEntity(posNext, EnumTargetEntity.Pet | EnumTargetEntity.Monster) then
      targetPos = posNext
    end
  end
  return targetPos, isBlocked, blockMonsterID, realHitBackDistance
end

function SkillEffectCalcService:_CalcHitbackPieceChangeTable(pos, targetPos, defender)
  local pieceChangeTable = {}
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local utilData = self._world:GetService("UtilData")
  if pos ~= targetPos then
    local curPieceType = utilData:FindPieceElement(pos)
    if curPieceType == PieceType.None and defender:HasTeam() and pos == defender:GetGridPosition() then
      local supplyRes = boardServiceLogic:SupplyPieceList({pos})
      for i = 1, #supplyRes do
        local res = supplyRes[i]
        pieceChangeTable[Vector2(res.x, res.y)] = res.color
      end
    end
  end
  return pieceChangeTable
end

function SkillEffectCalcService:_DoCalcSkillConvertGridElementEffect(skillEffectParam, skillRangePos, casterEntity)
  local skillConvertEffectParam = skillEffectParam
  local sourceArray = skillConvertEffectParam:GetSourceGridElement()
  local targetElementType = skillConvertEffectParam:GetTargetGridElement()
  local useEntityElement = false
  local elementEntity
  if skillConvertEffectParam:IsConvertToCasterElement() then
    useEntityElement = true
    elementEntity = casterEntity
  elseif skillConvertEffectParam:IsConvertToTeamLeaderElement() then
    useEntityElement = true
    local teamEntity
    if casterEntity:HasPet() then
      teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
    elseif casterEntity:HasTeam() then
      teamEntity = casterEntity
    else
      teamEntity = self._world:Player():GetLocalTeamEntity()
    end
    elementEntity = teamEntity:GetTeamLeaderPetEntity()
  end
  if useEntityElement and elementEntity and elementEntity:Element() ~= nil and elementEntity:Element():GetPrimaryType() ~= nil then
    local tarElement = elementEntity:Element():GetPrimaryType()
    targetElementType = tarElement
    local newSource = {}
    for _, elementType in ipairs(sourceArray) do
      if targetElementType ~= elementType then
        table.insert(newSource, elementType)
      end
    end
    sourceArray = newSource
  end
  local targetMaxCount = skillConvertEffectParam:GetTargetGridElementCount()
  local forceConvert = skillConvertEffectParam:IsIgnoreBlock()
  local legendPowerCount = skillConvertEffectParam:GetLegendPowerCount()
  local targetGridDic = {}
  local hasEnoughTarget = false
  local currentTargetCount = 0
  local randomSvc = self._world:GetService("RandomLogic")
  local skillRangePosList = {}
  local boardServiceLogic = self._world:GetService("BoardLogic")
  for k, v in pairs(skillRangePos) do
    local canConverPos = boardServiceLogic:GetCanConvertGridElement(v)
    if canConverPos then
      table.insert(skillRangePosList, v)
    end
  end
  if legendPowerCount ~= 0 then
    local battleStatCmpt = self._world:BattleStat()
    local skillID = battleStatCmpt:GetLastActiveSkillID()
    local configService = self._world:GetService("Config")
    local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
    local costPower = skillConfigData:GetSkillTriggerParam()
    local count = math.floor(costPower / legendPowerCount)
    targetMaxCount = count
  end
  if skillConvertEffectParam:IsUseTeamElementCount() then
    local utilCalcSvc = self._world:GetService("UtilCalc")
    targetMaxCount = utilCalcSvc:GetTeamPrimaryTypeCount(casterEntity)
  end
  if skillConvertEffectParam:NeedRandom() then
    local cloneTargetGridList = {}
    for k, v in pairs(skillRangePosList) do
      local lv = v:Clone()
      table.insert(cloneTargetGridList, lv)
    end
    while currentTargetCount < targetMaxCount and #cloneTargetGridList ~= 0 do
      local randIndex = randomSvc:LogicRand(1, #cloneTargetGridList)
      local gridPos = cloneTargetGridList[randIndex]
      table.remove(cloneTargetGridList, randIndex)
      local isMatch = self:_IsGridElementMatch(gridPos, sourceArray)
      if isMatch then
        currentTargetCount = currentTargetCount + 1
        targetGridDic[#targetGridDic + 1] = Vector2(gridPos.x, gridPos.y)
      end
      if targetMaxCount <= currentTargetCount or #cloneTargetGridList == 0 then
        hasEnoughTarget = true
        break
      end
    end
  else
    for _, gridPos in ipairs(skillRangePosList) do
      local isMatch = self:_IsGridElementMatch(gridPos, sourceArray)
      if isMatch then
        targetGridDic[#targetGridDic + 1] = Vector2(gridPos.x, gridPos.y)
        currentTargetCount = currentTargetCount + 1
        if targetMaxCount <= currentTargetCount then
          hasEnoughTarget = true
          break
        end
      end
    end
  end
  local skillConvertEffectResult = SkillConvertGridElementEffectResult:New(targetGridDic, targetElementType)
  if skillConvertEffectParam:IsSaveTetrisIndex() then
    local featureSvcL = self._world:GetService("FeatureLogic")
    skillConvertEffectResult:SetSaveTetrisIndex(featureSvcL:GetTetrisIndex())
    skillConvertEffectResult:SetSaveTetrisDirType(featureSvcL:GetTetrisDir())
  end
  return skillConvertEffectResult
end

function SkillEffectCalcService:_IsGridElementMatch(checkPos, convertGridTypeArray)
  local utilData = self._world:GetService("UtilData")
  local checkPosType = utilData:FindPieceElement(checkPos)
  for k, v in ipairs(convertGridTypeArray) do
    local curGridType = tonumber(v)
    if curGridType == checkPosType then
      return true
    end
  end
  return false
end

function SkillEffectCalcService:_TransBlockByRaceType(nRaceType)
  if MonsterRaceType.Fly == nRaceType then
    return BlockFlag.MonsterFly
  end
  return BlockFlag.MonsterLand
end

function SkillEffectCalcService:_FindSummonPos(nSummonType, listPosPlan, nSummonID, listPosHaveDown, blockFlag, searchRing9, bCheckIgnoreBodyArea, noRandom)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local bodyArea
  if SkillEffectEnum_SummonType.Monster == nSummonType then
    local cfgService = self._world:GetService("Config")
    local monsterConfigData = cfgService:GetMonsterConfigData()
    if bCheckIgnoreBodyArea then
      bodyArea = {
        Vector2(0, 0)
      }
    else
      bodyArea = monsterConfigData:GetMonsterArea(nSummonID)
    end
    local raceType = monsterConfigData:GetMonsterRaceType(nSummonID)
    blockFlag = blockFlag or self:_TransBlockByRaceType(raceType)
  elseif SkillEffectEnum_SummonType.Trap == nSummonType then
    local cfgService = self._world:GetService("Config")
    local configTrap = cfgService:GetTrapConfigData()
    local configData = configTrap:GetTrapData(nSummonID)
    if bCheckIgnoreBodyArea then
      bodyArea = {
        Vector2(0, 0)
      }
    else
      bodyArea = configTrap:ExplainTrapArea(configData.Area)
    end
    blockFlag = blockFlag or BlockFlag.SummonTrap
  end
  if nil == bodyArea then
    return nil
  end
  local position = boardServiceLogic:GetValidSummonPos(listPosPlan, bodyArea, listPosHaveDown, blockFlag, searchRing9, noRandom)
  return position
end

function SkillEffectCalcService:CalcSkill_ResetGridElement(skillRangePos, casterEntity, skillEffectParam, isPreviewing)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local randomSvc = self._world:GetService("RandomLogic")
  local svcTrap = self._world:GetService("TrapLogic")
  local elementPool = {}
  local targetGridTypeList = {}
  for i, v in ipairs(skillEffectParam:GetTargetGridTypeList()) do
    targetGridTypeList[i] = v
  end
  if skillEffectParam:GetExcludeRangeColor() then
    local pieceType = boardServiceLogic:GetPieceType(skillRangePos[1])
    for k, v in pairs(targetGridTypeList) do
      if v == pieceType then
        table.remove(targetGridTypeList, k)
        table.sort(targetGridTypeList)
        break
      end
    end
  end
  if not isPreviewing then
    local tmpList = {}
    local count = #targetGridTypeList
    for i = 1, count do
      local index = randomSvc:BoardLogicRandSelectByMatchType(1, #targetGridTypeList)
      table.insert(tmpList, targetGridTypeList[index])
      table.remove(targetGridTypeList, index)
    end
    targetGridTypeList = tmpList
  end
  local convertGray = skillEffectParam:GetConvertGray()
  local canFlushTrap = skillEffectParam:GetCanFlushTrap()
  local protectElementTypeMap = skillEffectParam:GetProtectElementType()
  local ignoreBlock = skillEffectParam:GetIgnoreBlock()
  local ignoreLockSeed = skillEffectParam:GetIgnoreLockSeed()
  local rawUseBoardSeed = randomSvc:GetUseBoardSeed()
  if ignoreLockSeed then
    randomSvc:SetUseBoardSeed(false)
  end
  local utilData = self._world:GetService("UtilData")
  local validGridCount = 0
  for i = 1, #skillRangePos do
    local posWork = skillRangePos[i]
    local checkPosType = utilData:FindPieceElement(posWork)
    if (convertGray or checkPosType > PieceType.None and checkPosType <= PieceType.Any) and not protectElementTypeMap[checkPosType] then
      validGridCount = validGridCount + 1
    end
  end
  elementPool = self:_GetAssignElementPool(validGridCount, skillEffectParam, targetGridTypeList)
  local lenPool = table.count(elementPool)
  local listGridArray = {}
  local listGridArrayNew = {}
  local flushTraps = {}
  local traps = self._world:GetGroup(self._world.BW_WEMatchers.Trap):GetEntities()
  local excludeTrapIDList = skillEffectParam:GetExcludeTrapIDList()
  for i = 1, #skillRangePos do
    local posWork = skillRangePos[i]
    local checkPosType = utilData:FindPieceElement(posWork)
    if canFlushTrap and 0 < #traps then
      for _, trap in ipairs(traps) do
        if not trap:HasDeadMark() then
          local level = trap:Trap():GetTrapLevel()
          local pos = trap:GetGridPosition()
          local isFlushed = svcTrap:IsTrapFlushable(level)
          local trapID = trap:Trap():GetTrapID()
          if isFlushed and pos.x == posWork.x and pos.y == posWork.y and not table.icontains(excludeTrapIDList, trapID) then
            trap:Attributes():Modify("HP", 0)
            svcTrap:AddTrapDeadMark(trap, true)
            flushTraps[#flushTraps + 1] = trap
          end
        end
      end
    end
    if (not boardServiceLogic:IsPosBlock(posWork, BlockFlag.ChangeElement) or ignoreBlock) and (convertGray or checkPosType > PieceType.None and checkPosType <= PieceType.Any) then
      local nNewColor = checkPosType
      if not protectElementTypeMap[checkPosType] then
        nNewColor = self:_GetAssignNumber(elementPool, isPreviewing) + PieceType.None
      end
      local resetGridData = SkillEffectResult_ResetGridData:New(posWork.x, posWork.y, nNewColor)
      table.insert(listGridArray, resetGridData)
      if not listGridArrayNew[posWork.x] then
        listGridArrayNew[posWork.x] = {}
      end
      if not listGridArrayNew[posWork.x][posWork.y] then
        listGridArrayNew[posWork.x][posWork.y] = {}
      end
      listGridArrayNew[posWork.x][posWork.y] = nNewColor
    end
  end
  randomSvc:SetUseBoardSeed(rawUseBoardSeed)
  local skillResult = SkillEffectResult_ResetGridElement:New(listGridArray, flushTraps, listGridArrayNew)
  return skillResult
end

function SkillEffectCalcService:GetFlushTrap(posList, excludeTrapIDList)
  local traps = self._world:GetGroup(self._world.BW_WEMatchers.Trap):GetEntities()
  local flushTrapList = {}
  local svcTrap = self._world:GetService("TrapLogic")
  for _, trap in ipairs(traps) do
    local level = trap:Trap():GetTrapLevel()
    local pos = trap:GetGridPosition()
    local isFlushed = svcTrap:IsTrapFlushable(level)
    local trapID = trap:Trap():GetTrapID()
    if isFlushed and table.icontains(posList, pos) and not table.icontains(excludeTrapIDList, trapID) then
      flushTrapList[#flushTrapList + 1] = trap:GetID()
    end
  end
  return flushTrapList
end

function SkillEffectCalcService:_GetRandomElementPool(skillEffectParam)
  local elementPool = {}
  local element = skillEffectParam:GetElement()
  if element then
    local percent = skillEffectParam:GetPercent()
    local count = 100
    for elementIdx = 1, 4 do
      local num = 0
      if element == elementIdx then
        num = math.floor(percent * count)
      else
        num = math.floor((1 - percent) * count / 3)
      end
      for j = 1, num do
        table.insert(elementPool, elementIdx)
      end
    end
  else
    elementPool = {
      1,
      2,
      3,
      4
    }
  end
  return elementPool
end

function SkillEffectCalcService:_GetAssignElementPool(count, skillEffectParam, elementList)
  local elementPool = {}
  local element = skillEffectParam:GetElement()
  local elementCount = #elementList
  if element then
    local randomSvc = self._world:GetService("RandomLogic")
    local percentRange = skillEffectParam:GetPercent()
    local percent
    if #percentRange == 1 then
      percent = percentRange[1]
    elseif #percentRange == 2 then
      local sub = percentRange[2] - percentRange[1]
      local add = sub * randomSvc:BoardLogicRandSelectByMatchType(0, 10) / 10
      percent = percentRange[1] + add
    end
    local otherElementList = {}
    for _, elementIdx in ipairs(elementList) do
      local num = 0
      if element == elementIdx then
        num = math.floor(percent * count)
      else
        table.insert(otherElementList, elementIdx)
        num = math.floor((1 - percent) * count / (elementCount - 1))
      end
      for j = 1, num do
        table.insert(elementPool, elementIdx)
      end
    end
    while count > #elementPool do
      local randIndex = randomSvc:BoardLogicRandSelectByMatchType(1, #otherElementList)
      table.insert(elementPool, otherElementList[randIndex])
    end
    local logTabele = {}
    for i, v in ipairs(elementPool) do
      if not logTabele[v] then
        logTabele[v] = 0
      end
      logTabele[v] = logTabele[v] + 1
    end
    for type, count in pairs(logTabele) do
      self:LogNotice("ResetGrid PieceType:", type, " Count:", count)
    end
  else
    for elementIdx = 1, count do
      local mod = math.fmod(elementIdx, #elementList)
      table.insert(elementPool, elementList[mod + 1])
    end
  end
  return elementPool
end

function SkillEffectCalcService:_GetAssignNumber(elementPool, isPreviewing)
  local randomSvc = self._world:GetService("RandomLogic")
  local number, random
  local count = table.count(elementPool)
  if isPreviewing then
    random = math.random(1, count)
    number = elementPool[random]
  else
    random = randomSvc:BoardLogicRandSelectByMatchType(1, count)
    number = elementPool[random]
    table.remove(elementPool, random)
  end
  return number
end

function SkillEffectCalcService:NotifyDamageBegin(attacker, defender, attackPos, targetPos, skillID, effectType, damageStageIndex, randHalfDamageIndex)
  if not skillID then
    return
  end
  local triggerSvc = self._world:GetService("Trigger")
  local skillConfigData = self._configService:GetSkillConfigData(skillID, attacker)
  local skillType = skillConfigData:GetSkillType()
  if attacker:HasPetPstID() then
    if skillType == SkillType.Chain then
      local petAttackDataCmpt = attacker:SkillPetAttackData()
      local chainTimeIndex = petAttackDataCmpt:GetCurChainSkillTimeIndex()
      local chainStageIndex = petAttackDataCmpt:GetChainSkillStageIndexWithSkillIDAndTimeIndex(skillID, chainTimeIndex)
      local nt = NTChainSkillEachAttackStart:New(attacker, defender, attackPos, targetPos)
      nt:SetEffectType(effectType)
      nt:SetSkillID(skillID)
      nt:SetSkillType(SkillType.Chain)
      nt:SetChainSkillTimeIndex(chainTimeIndex)
      nt:SetChainSkillStageIndex(chainStageIndex)
      if randHalfDamageIndex then
        nt:SetRandHalfDamageIndex(randHalfDamageIndex)
      end
      triggerSvc:Notify(nt)
    end
    if skillType == SkillType.Active then
      local nt = NTActiveSkillEachAttackStart:New(attacker, defender, attackPos, targetPos)
      nt:SetEffectType(effectType)
      nt:SetSkillID(skillID)
      nt:SetSkillType(SkillType.Active)
      nt:SetSkillStageIndex(damageStageIndex)
      triggerSvc:Notify(nt)
    end
  elseif attacker:HasMonsterID() then
    local nt = NTMonsterEachAttackStart:New(attacker, defender, attackPos, targetPos)
    nt:SetSkillID(skillID)
    nt:SetSkillType(SkillType.MonsterSkill)
    triggerSvc:Notify(nt)
  elseif attacker:HasTrap() then
    local nt = NTTrapEachAttackStart:New(attacker, defender, attackPos, targetPos)
    nt:SetSkillID(skillID)
    nt:SetSkillType(SkillType.TrapSkill)
    triggerSvc:Notify(nt)
  elseif attacker:EntityType():IsSkillHolder() then
    local nt = NTBuffCastSkillEachAttackBegin:New(attacker, defender, attackPos, targetPos)
    nt:SetEffectType(effectType)
    nt:SetSkillID(skillID)
    nt:SetSkillType(skillType)
    triggerSvc:Notify(nt)
  end
  if skillType == SkillType.AutoBeadSkill then
    local nt = NTAutoBeadSkillEachAttackStart:New(attacker, defender, attackPos, targetPos)
    nt:SetEffectType(effectType)
    nt:SetSkillID(skillID)
    nt:SetSkillType(skillType)
    triggerSvc:Notify(nt)
  end
  if defender:HasMonsterID() then
    local nt = NTMonsterBeHitStart:New(attacker, defender, attackPos, targetPos)
    nt:SetSkillID(skillID)
    nt:SetSkillType(skillType)
    triggerSvc:Notify(nt)
  end
  if defender:HasPetPstID() or defender:HasTeam() then
    local nt = NTPlayerBeHitStart:New(attacker, defender, attackPos, targetPos)
    nt:SetSkillID(skillID)
    nt:SetSkillType(skillType)
    triggerSvc:Notify(nt)
  end
end

function SkillEffectCalcService:NotifyDamageEnd(attacker, defender, attackPos, targetPos, skillID, damageInfo, effectType, damageStageIndex)
  local triggerSvc = self._world:GetService("Trigger")
  local battleSvc = self._world:GetService("Battle")
  local battleStatComponent = self._world:BattleStat()
  local damage = damageInfo:GetDamageValue()
  local damageType = damageInfo:GetDamageType()
  local skillConfigData = self._configService:GetSkillConfigData(skillID, attacker)
  local skillType = skillConfigData:GetSkillType()
  if attacker:HasPetPstID() then
    if skillType == SkillType.Chain then
      local petAttackDataCmpt = attacker:SkillPetAttackData()
      local chainTimeIndex = petAttackDataCmpt:GetCurChainSkillTimeIndex()
      local chainStageIndex = petAttackDataCmpt:GetChainSkillStageIndexWithSkillIDAndTimeIndex(skillID, chainTimeIndex)
      local nt = NTChainSkillEachAttackEnd:New(attacker, defender, attackPos, targetPos)
      nt:SetEffectType(effectType)
      nt:SetSkillID(skillID)
      nt:SetSkillType(SkillType.Chain)
      nt:SetDamageValue(damage)
      nt:SetChainSkillTimeIndex(chainTimeIndex)
      nt:SetChainSkillStageIndex(chainStageIndex)
      if damageInfo.GetRandHalfDamageIndex then
        local randHalfDamageIndex = damageInfo:GetRandHalfDamageIndex()
        if randHalfDamageIndex then
          nt:SetRandHalfDamageIndex(randHalfDamageIndex)
        end
      end
      triggerSvc:Notify(nt)
    end
    if skillType == SkillType.Active then
      local nt = NTActiveSkillEachAttackEnd:New(attacker, defender, attackPos, targetPos)
      nt:SetSkillID(skillID)
      nt:SetSkillType(SkillType.Active)
      nt:SetEffectType(effectType)
      nt:SetDamageValue(damage)
      nt:SetDamageType(damageType)
      nt:SetSkillStageIndex(damageStageIndex)
      triggerSvc:Notify(nt)
    end
  elseif attacker:HasMonsterID() then
    if skillType == SkillType.Normal then
      local nt = NTMonsterEachAttackEnd:New(attacker, defender, attackPos, targetPos)
      nt:SetSkillID(skillID)
      nt:SetSkillType(SkillType.MonsterSkill)
      nt:SetDamageValue(damage)
      nt:SetDamageType(damageType)
      triggerSvc:Notify(nt)
    end
    local nt = NTMonsterEachDamageEnd:New(attacker, defender, attackPos, targetPos)
    nt:SetSkillID(skillID)
    nt:SetSkillType(SkillType.MonsterSkill)
    nt:SetDamageValue(damage)
    nt:SetDamageType(damageType)
    triggerSvc:Notify(nt)
  elseif attacker:HasTrap() then
    local nt = NTTrapEachAttackEnd:New(attacker, defender, attackPos, targetPos)
    nt:SetSkillID(skillID)
    nt:SetSkillType(SkillType.TrapSkill)
    nt:SetDamageValue(damage)
    nt:SetDamageType(damageType)
    triggerSvc:Notify(nt)
  elseif attacker:EntityType():IsSkillHolder() then
    local nt = NTBuffCastSkillEachAttackEnd:New(attacker, defender, attackPos, targetPos)
    nt:SetEffectType(effectType)
    nt:SetSkillID(skillID)
    nt:SetSkillType(skillType)
    nt:SetDamageValue(damage)
    nt:SetDamageType(damageType)
    triggerSvc:Notify(nt)
  end
  if skillType == SkillType.AutoBeadSkill then
    local autoBeadSkillIndex = 0
    if attacker:EntityType():IsAutoBeadSkillHolder() then
      local skillAutoBeadData = attacker:SkillAutoBeadAttackData()
      if skillAutoBeadData then
        local attackDataList = skillAutoBeadData:GetAutoBeadAttackDataList()
        if attackDataList then
          local attackData = attackDataList[#attackDataList]
          if attackData then
            autoBeadSkillIndex = attackData:GetAutoBeadSkillIndex()
          end
        end
      end
    end
    local nt = NTAutoBeadSkillEachAttackEnd:New(attacker, defender, attackPos, targetPos)
    nt:SetEffectType(effectType)
    nt:SetSkillID(skillID)
    nt:SetSkillType(skillType)
    nt:SetDamageValue(damage)
    nt:SetDamageType(damageType)
    nt:SetSkillStageIndex(damageStageIndex)
    nt:SetAutoBeadSkillIndex(autoBeadSkillIndex)
    triggerSvc:Notify(nt)
  end
  if defender:HasMonsterID() then
    local nt = NTMonsterBeHit:New(attacker, defender, attackPos, targetPos)
    nt:SetSkillID(skillID)
    nt:SetSkillType(skillType)
    nt:SetDamageValue(damage)
    nt:SetDamageType(damageType)
    nt:SetDamageStageIndex(damageInfo:GetDamageStageIndex())
    nt:SetCurSkillDamageIndex(damageInfo:GetCurSkillDamageIndex())
    triggerSvc:Notify(nt)
  end
  if defender:HasPetPstID() or defender:HasTeam() then
    local nt = NTPlayerBeHit:New(attacker, defender, attackPos, targetPos)
    nt:SetSkillID(skillID)
    nt:SetSkillType(skillType)
    nt:SetDamageValue(damage)
    nt:SetDamageType(damageType)
    nt:SetDamageIndex(damageStageIndex)
    triggerSvc:Notify(nt)
  end
  if defender:HasChessPet() then
    local nt = NTChessBeHit:New(attacker, defender, attackPos, targetPos)
    nt:SetSkillID(skillID)
    nt:SetSkillType(skillType)
    nt:SetDamageValue(damage)
    nt:SetDamageType(damageType)
    triggerSvc:Notify(nt)
  end
  Log.info("Skill Record NotifyDamageEnd, skillID=", skillID, " casterEntityID=", attacker:GetID(), " defenderEntityID=", defender:GetID())
  local uniqueBattleStat = self._world:BattleStat()
  uniqueBattleStat:AffixRecordSkillDamage(attacker:GetID(), skillID, defender:GetID())
end

function SkillEffectCalcService:ResetSkillContext(entityID)
  local entity = self._world:GetEntityByID(entityID)
  if not entity:HasSkillContext() then
    Log.fatal("该Entity没有SkillContext组件，直接宕机")
  end
  entity:ReplaceSkillContext()
end

function SkillEffectCalcService:TriggerTrap(casterEntity, result)
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local listTrapWork, listTrapResult = trapServiceLogic:TriggerTrapByEntity(casterEntity, TrapTriggerOrigin.Move)
  for i, e in ipairs(listTrapWork) do
    local trapEntity = e
    local skillEffectResultContainer = listTrapResult[i]
    local aiResult = AISkillResult:New()
    aiResult:SetResultContainer(skillEffectResultContainer)
    result:AddWalkTrap(trapEntity:GetID(), aiResult)
  end
end

function SkillEffectCalcService:FindSkillRangeFixed4(posCaster, skillRangePos)
  local spPos = skillRangePos[1]
  local range = {}
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local boardSvc = self._world:GetService("BoardLogic")
  local playerPos = teamEntity:GetGridPosition()
  local posWork, dis = nil, 10000
  for i, v in ipairs(Offset4) do
    local pos = Vector2(playerPos.x + v[1], playerPos.y + v[2])
    table.insert(range, pos)
    local disTemp = Vector2.Distance(pos, spPos)
    if dis > disTemp then
      dis = disTemp
      posWork = pos
    end
  end
  if posWork == posCaster then
    return posWork, 0
  end
  if not boardSvc:IsPosBlock(posWork, BlockFlag.MonsterLand) then
    return posWork, boardSvc:CalcPosRing(posCaster, posWork)
  end
  dis = 1000
  local maxX = boardSvc:GetCurBoardMaxX()
  local maxY = boardSvc:GetCurBoardMaxY()
  local len = math.max(maxX, maxY)
  posWork = nil
  for i = 1, len do
    for _, v in ipairs(Offset4) do
      local pos = Vector2(playerPos.x + v[1] * i, playerPos.y + v[2] * i)
      local disPos = playerPos
      if i == 1 then
        disPos = spPos
      end
      local disTemp = Vector2.Distance(pos, disPos)
      if dis > disTemp and (not boardSvc:IsPosBlock(pos, BlockFlag.MonsterLand) or pos == posCaster) then
        posWork = pos
        dis = disTemp
      end
    end
    if i == 1 and posWork then
      break
    end
  end
  return posWork, boardSvc:CalcPosRing(posCaster, posWork)
end
