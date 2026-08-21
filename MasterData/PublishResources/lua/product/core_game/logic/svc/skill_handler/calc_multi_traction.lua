_class("SkillEffectCalc_MultiTraction_SingleTargetPossession", Object)
SkillEffectCalc_MultiTraction_SingleTargetPossession = SkillEffectCalc_MultiTraction_SingleTargetPossession

function SkillEffectCalc_MultiTraction_SingleTargetPossession:Constructor(entityID, path, finalPos, beginPos)
  self.entityID = entityID
  self.path = path
  self.finalPos = finalPos
  self.beginPos = beginPos
end

function SkillEffectCalc_MultiTraction_SingleTargetPossession:SetTriggerTraps(triggerTraps)
  self._triggerTraps = triggerTraps
end

function SkillEffectCalc_MultiTraction_SingleTargetPossession:GetTriggerTraps()
  return self._triggerTraps
end

function SkillEffectCalc_MultiTraction_SingleTargetPossession:GetTargetEntityID()
  return self.entityID
end

_class("SkillEffectCalc_MultiTraction_GridPossessorMap", Object)
SkillEffectCalc_MultiTraction_GridPossessorMap = SkillEffectCalc_MultiTraction_GridPossessorMap

function SkillEffectCalc_MultiTraction_GridPossessorMap:Constructor()
  self.all = {}
  self.array = {}
  self.dimensionMap = {}
end

function SkillEffectCalc_MultiTraction_GridPossessorMap:MarkPossessInfo(pos, entity, path)
  local entityID = entity:GetID()
  local bodyAreaComponent = entity:BodyArea()
  local dimensionMap = self.dimensionMap
  if bodyAreaComponent then
    local areaArray = bodyAreaComponent:GetArea()
    for i = 1, #areaArray do
      local absoluteAreaPos = areaArray[i] + pos
      local absX = absoluteAreaPos.x
      local absY = absoluteAreaPos.y
      if not dimensionMap[absX] then
        dimensionMap[absX] = {}
      end
      dimensionMap[absX][absY] = entityID
      table.insert(self.all, absoluteAreaPos)
    end
  else
    local absX = pos.x
    local absY = pos.y
    if not dimensionMap[absX] then
      dimensionMap[absX] = {}
    end
    dimensionMap[absX][absY] = entityID
    table.insert(self.all, pos)
  end
  table.insert(self.array, SkillEffectCalc_MultiTraction_SingleTargetPossession:New(entityID, path, pos, entity:GetGridPosition()))
end

_class("SkillEffectCalc_MultiTraction", Object)
SkillEffectCalc_MultiTraction = SkillEffectCalc_MultiTraction

function SkillEffectCalc_MultiTraction:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._logFlag = true
end

function SkillEffectCalc_MultiTraction:_Log(entity, ...)
  if not self._logFlag then
    return
  end
  local eid = entity and entity:GetID() or "nil"
  Log.notice(self._className, eid, ": ", ...)
end

function SkillEffectCalc_MultiTraction:_NewPieceBlockBlackboard(centerPos, targetIDs, canMoveToCenter)
  local utilData = self._world:GetService("UtilData")
  local blackboard = utilData:CreatePieceBlockBlackboard(targetIDs)
  if not canMoveToCenter then
    blackboard[centerPos.x][centerPos.y]:AddBlock(-1, BlockFlag.MonsterLand | BlockFlag.MonsterFly | BlockFlag.LinkLine)
  end
  return blackboard
end

function SkillEffectCalc_MultiTraction:DoSkillEffectCalculator(skillEffectCalcParam)
  local tractionParam = skillEffectCalcParam.skillEffectParam
  local enableByPickNum = tractionParam:GetEnableByPickNum()
  if enableByPickNum then
    local checkNum = tonumber(enableByPickNum)
    local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
    local component = attacker:ActiveSkillPickUpComponent()
    if component then
      local curPickNum = component:GetAllValidPickUpGridPosCount()
      if curPickNum ~= checkNum then
        return
      end
    end
  end
  self._gridPossessionMap = SkillEffectCalc_MultiTraction_GridPossessorMap:New()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local skipTractionCalc = false
  local skipTractionByPickNum = tractionParam:GetSkipTractionByPickNum()
  if skipTractionByPickNum then
    local checkNum = tonumber(skipTractionByPickNum)
    local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
    local component = attacker:ActiveSkillPickUpComponent()
    if component then
      local curPickNum = component:GetAllValidPickUpGridPosCount()
      if curPickNum == checkNum then
        skipTractionCalc = true
      end
    end
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local bossANaTuoLiTractionMonsterClassID = tractionParam:GetBossANaTuoLiTractionMonsterClassID()
  local bossANaTuoLiTractionMonster, bossANaTuoLiReplaceScopeCenterPos
  local includeCasterTeam = false
  local centerPos
  local tractionCenterType = tractionParam:GetTractionCenterType()
  if tractionCenterType == TractionCenterType.Normal then
    if tractionParam:IsCasterCentered() then
      centerPos = casterEntity:GetGridPosition()
    elseif casterEntity:HasPetPstID() then
      centerPos = skillEffectCalcParam.gridPos
      if not centerPos then
        centerPos = scopeResult:GetCenterPos()
      end
    else
      centerPos = scopeResult:GetCenterPos()
    end
  elseif tractionCenterType == TractionCenterType.PetANaTuoLi then
    local isCfgPreview = tractionParam:GetIsPreview()
    local scopeCenterPos
    if isCfgPreview then
      scopeCenterPos = skillEffectCalcParam.gridPos
    else
      scopeCenterPos = scopeResult:GetCenterPos()
    end
    if #scopeCenterPos < 2 then
      return
    end
    local mainPos = scopeCenterPos[1]
    local scopeRange
    if isCfgPreview then
      scopeRange = skillEffectCalcParam.skillRange
    else
      scopeRange = scopeResult:GetAttackRange()
    end
    centerPos = self:_PetANaTuoLiFindTractionCenter(scopeRange, mainPos)
    local petANaTuoLiCanTractionSelf = tractionParam:GetPetANaTuoLiCanTractionSelf()
    if petANaTuoLiCanTractionSelf then
      if isCfgPreview then
        local component = casterEntity:PreviewPickUpComponent()
        if component then
          local curPickNum = component:GetAllValidPickUpGridPosCount()
          if curPickNum == 1 then
            includeCasterTeam = true
          end
        end
      else
        local component = casterEntity:ActiveSkillPickUpComponent()
        if component then
          local curPickNum = component:GetAllValidPickUpGridPosCount()
          if curPickNum == 1 then
            includeCasterTeam = true
          end
        end
      end
    end
  elseif tractionCenterType == TractionCenterType.BossANaTuoLi then
    local teamEntity = self._world:Player():GetLocalTeamEntity()
    local teamPos = teamEntity:GetGridPosition()
    local teamBodyArea = teamEntity:BodyArea():GetArea()
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    for _, e in ipairs(monsterGroup:GetEntities()) do
      if not e:HasDeadMark() then
        local monsterClassID = e:MonsterID():GetMonsterClassID()
        if monsterClassID == bossANaTuoLiTractionMonsterClassID then
          bossANaTuoLiTractionMonster = e
          break
        end
      end
    end
    if not bossANaTuoLiTractionMonster then
      return
    end
    local targetMonsterPos = bossANaTuoLiTractionMonster:GetGridPosition()
    bossANaTuoLiReplaceScopeCenterPos = {teamPos, targetMonsterPos}
    local scopeCalc = SkillScopeCalculator:New(utilScopeSvc)
    local scopeResult = scopeCalc:ComputeScopeRange(SkillScopeType.PickupAngleFreeLine, {
      noExtend = 1,
      init = 1,
      dest = 2,
      useCenterPos = 1
    }, {teamPos, targetMonsterPos}, teamBodyArea)
    local scopeRange = scopeResult:GetAttackRange()
    centerPos = self:_PetANaTuoLiFindTractionCenter(scopeRange, teamPos)
    includeCasterTeam = true
  end
  self.rangeByQuadrant = utilScopeSvc:GetBoardQuadrantsByCenter(centerPos, casterEntity, true)
  self.rangeByQuadrant[BoardQuadrant.Center] = {centerPos}
  local attackPosArray = skillEffectCalcParam.skillRange
  local skillID = skillEffectCalcParam.skillID
  local configService = self._world:GetService("Config")
  local skillConfig = configService:GetSkillConfigData(skillID)
  local targetType = skillConfig and skillConfig:GetSkillTargetType() or SkillTargetType.Board
  local overrideTargetType = tractionParam:GetSkillEffectTargetType()
  if overrideTargetType then
    targetType = overrideTargetType
  end
  local utilData = self._world:GetService("UtilData")
  local canMoveToCenter = tractionParam:GetCanMoveToCenter()
  if not skipTractionCalc then
    if self._world:MatchType() == MatchType.MT_BlackFist then
      local teamEntity, enemyTeam
      if casterEntity:HasTrap() then
        teamEntity = self._world:Player():GetLocalTeamEntity()
      else
        teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
      end
      enemyTeam = teamEntity:Team():GetEnemyTeamEntity()
      local v2PosTL = enemyTeam:GetGridPosition()
      if table.icontains(attackPosArray, v2PosTL) then
        local targetIDs = {}
        table.insert(targetIDs, enemyTeam:GetID())
        local casterTeamEntity
        if includeCasterTeam then
          casterTeamEntity = casterEntity:Pet():GetOwnerTeamEntity()
          table.insert(targetIDs, casterTeamEntity:GetID())
        end
        self._pieceBlockBlackboard = self:_NewPieceBlockBlackboard(centerPos, targetIDs, canMoveToCenter)
        for _, targetID in ipairs(targetIDs) do
          local targetEntity = self._world:GetEntityByID(targetID)
          local gridPos = targetEntity:GetGridPosition()
          self:_DoSingleTraction(skillEffectCalcParam, centerPos, gridPos, targetEntity, casterEntity, includeCasterTeam)
        end
      end
    elseif targetType == SkillTargetType.Team then
      local teamEntity = self._world:Player():GetPreviewTeamEntity()
      local v2PosTL = teamEntity:GetGridPosition()
      if table.icontains(attackPosArray, v2PosTL) then
        self._pieceBlockBlackboard = self:_NewPieceBlockBlackboard(centerPos, {
          teamEntity:GetID()
        }, canMoveToCenter)
        self:_DoSingleTraction(skillEffectCalcParam, centerPos, v2PosTL, teamEntity, casterEntity)
      end
    elseif targetType == SkillTargetType.MonsterAndChessPet then
      local scope = SkillScopeResult:New(SkillScopeType.None, centerPos, attackPosArray, attackPosArray)
      local selector = SkillScopeTargetSelector:New(self._world)
      local targetIDs = selector:DoSelectSkillTarget(casterEntity, SkillTargetType.MonsterAndChessPet, scope, nil, {})
      self._pieceBlockBlackboard = self:_NewPieceBlockBlackboard(centerPos, targetIDs, canMoveToCenter)
      for _, targetID in ipairs(targetIDs) do
        local targetEntity = self._world:GetEntityByID(targetID)
        local gridPos = targetEntity:GetGridPosition()
        self:_DoSingleTraction(skillEffectCalcParam, centerPos, gridPos, targetEntity, casterEntity)
      end
    else
      local targetEntityIDMap = {}
      local scope = SkillScopeResult:New(SkillScopeType.None, centerPos, attackPosArray, attackPosArray)
      local selector = SkillScopeTargetSelector:New(self._world)
      local targetIDs = {}
      if bossANaTuoLiTractionMonsterClassID then
        targetIDs = {
          bossANaTuoLiTractionMonster:GetID()
        }
      else
        targetIDs = selector:DoSelectSkillTarget(casterEntity, SkillTargetType.Monster, scope, nil, {})
      end
      local casterTeamEntity
      if includeCasterTeam then
        if casterEntity:Pet() then
          casterTeamEntity = casterEntity:Pet():GetOwnerTeamEntity()
        end
        if casterEntity:HasMonsterID() then
          casterTeamEntity = self._world:Player():GetLocalTeamEntity()
        end
        table.insert(targetIDs, casterTeamEntity:GetID())
      end
      for _, id in ipairs(targetIDs) do
        targetEntityIDMap[id] = true
      end
      local monsterDisList = utilScopeSvc:SortMonstersByPos(centerPos, true)
      local validMonsterDisList = {}
      for _, monsterDisInfo in ipairs(monsterDisList) do
        if not targetEntityIDMap[monsterDisInfo.monster_e:GetID()] then
          self:_Log(monsterDisInfo.monster_e, " Outside of skill range, skipping. ")
          local gridPos = monsterDisInfo.monster_e:GetGridPosition()
          self._gridPossessionMap:MarkPossessInfo(gridPos, monsterDisInfo.monster_e, {})
        else
          table.insert(validMonsterDisList, monsterDisInfo)
        end
      end
      if includeCasterTeam then
        local casterPos = casterTeamEntity:GetGridPosition()
        local casterFakeInfo = {
          dis = 1000,
          monster_e = casterTeamEntity,
          pos = casterPos
        }
        table.insert(validMonsterDisList, casterFakeInfo)
      end
      self._pieceBlockBlackboard = self:_NewPieceBlockBlackboard(centerPos, targetIDs, canMoveToCenter)
      for _, monsterDisInfo in ipairs(validMonsterDisList) do
        local gridPos = monsterDisInfo.monster_e:GetGridPosition()
        self:_DoSingleTraction(skillEffectCalcParam, centerPos, gridPos, monsterDisInfo.monster_e, casterEntity, includeCasterTeam)
      end
    end
  end
  local result = SkillEffectMultiTractionResult:New(self._gridPossessionMap)
  local damageIncreaseRate = tractionParam:GetFinalDamageIncreaseRate()
  if damageIncreaseRate then
    result:SetDamageIncreaseRate(damageIncreaseRate)
  end
  if bossANaTuoLiReplaceScopeCenterPos then
    result:SetReplaceScopeCenterPos(bossANaTuoLiReplaceScopeCenterPos)
  end
  result:SetTractionCenterPos(centerPos)
  return result
end

function SkillEffectCalc_MultiTraction:_SaveTargetEntityTractionResult(targetEntity, finalPos, path)
  self._gridPossessionMap:MarkPossessInfo(finalPos, targetEntity, path)
  local areaArray = targetEntity:BodyArea():GetArea()
  for _, v2RelativeBody in ipairs(areaArray) do
    local v2 = finalPos + v2RelativeBody
    if self._pieceBlockBlackboard[v2.x] and self._pieceBlockBlackboard[v2.x][v2.y] then
      self._pieceBlockBlackboard[v2.x][v2.y]:AddBlock(targetEntity:GetID(), targetEntity:BlockFlag():GetBlockFlag())
    else
      Log.error(self._className, " out of board pos: ", tostring(v2))
    end
  end
end

function SkillEffectCalc_MultiTraction:_DoSingleTraction(skillEffectCalcParam, center, currentPos, entity, casterEntity, includeCasterTeam)
  local areaArray = entity:BodyArea():GetArea()
  local tractionParam = skillEffectCalcParam.skillEffectParam
  local canMoveToCenter = tractionParam:GetCanMoveToCenter()
  if not tractionParam:GetForceMove() then
    local bufflsvc = self._world:GetService("BuffLogic")
    if not bufflsvc:CheckCanBeHitBack(entity) then
      self:_Log(entity, "target cannot move: ", entity:GetID())
      self:_SaveTargetEntityTractionResult(entity, currentPos, {})
      return
    end
  else
    if entity:HasMonsterID() then
      local cfgsvc = self._world:GetService("Config")
      local monsterConfigData = cfgsvc:GetMonsterConfigData()
      local monsterID = entity:MonsterID():GetMonsterID()
      if monsterConfigData:IsBoss(monsterID) then
        self:_Log(entity, "target is boss, cannot move: ", entity:GetID())
        self:_SaveTargetEntityTractionResult(entity, currentPos, {})
        return
      end
    end
    local bufflsvc = self._world:GetService("BuffLogic")
    if bufflsvc:CheckForceMoveImmunity(entity) then
      self:_Log(entity, "target is ForceMoveImmunity, cannot move: ", entity:GetID())
      self:_SaveTargetEntityTractionResult(entity, currentPos, {})
      return
    end
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local currentRingNum, nearestPos, useOffV2 = utilCalcSvc:GetGridRingNumWithBodyArea(currentPos, center, areaArray)
  local bodyAreaByOff = {}
  for index, value in ipairs(areaArray) do
    local newPos = value - useOffV2
    table.insert(bodyAreaByOff, newPos)
  end
  if not canMoveToCenter and currentRingNum <= 1 then
    self:_Log(entity, "already in 1st ring, skipping. ")
    self:_SaveTargetEntityTractionResult(entity, currentPos, {})
    return
  end
  local monsterQuadrant = utilCalcSvc:GetPosQuadrant(center, nearestPos)
  self:_Log(entity, "target quadrant: ", monsterQuadrant)
  local acceptableRange = utilCalcSvc:GetGridsByRing(self.rangeByQuadrant[monsterQuadrant], center, currentRingNum - 1)
  if canMoveToCenter then
    table.insert(acceptableRange, center)
  end
  local tractionParam = skillEffectCalcParam.skillEffectParam
  local maxStep = tractionParam:GetMaxMoveStep()
  if 0 < maxStep then
    acceptableRange = self:CutOutMaxStepRangeForSingle(acceptableRange, maxStep, nearestPos, bodyAreaByOff)
  end
  local boardsvc = self._world:GetService("BoardLogic")
  local blockVal = boardsvc:GetEntityMoveBlockFlag(entity)
  if blockVal == BlockFlag.LinkLine and self._world:MatchType() == MatchType.MT_BlackFist then
    blockVal = BlockFlag.LinkLine | BlockFlag.MonsterLand
  end
  local relativeCurrentPos = nearestPos - center
  local candidates = {}
  for _, gridPos in ipairs(acceptableRange) do
    local fitFullBodyArea = self:IsPosFitFullBodyArea(gridPos, entity, blockVal, bodyAreaByOff, casterEntity, includeCasterTeam, tractionParam)
    if fitFullBodyArea then
      local candidateRelativePos = gridPos - center
      local candidateRingNum = utilCalcSvc:GetGridRingNum(gridPos, center)
      local isRelativeXLE = math.abs(relativeCurrentPos.x) >= math.abs(candidateRelativePos.x)
      local isRelativeYLE = math.abs(relativeCurrentPos.y) >= math.abs(candidateRelativePos.y)
      if isRelativeXLE and isRelativeYLE then
        table.insert(candidates, gridPos)
      end
    end
  end
  if not candidates or #candidates == 0 then
    self:_Log(entity, "no candidate in acceptable range, skipping")
    self:_SaveTargetEntityTractionResult(entity, currentPos, {})
    return
  end
  local sortedByDis = HelperProxy:SortPosByCenterPosDistance(nearestPos, candidates)
  local finalPos = candidates[1]
  local currentFinalPosRingNum = utilCalcSvc:GetGridRingNum(finalPos, center)
  local currentFinalPosDisIndex = table.ikey(sortedByDis, finalPos)
  self._Log(entity, "first target: ", finalPos, " ring: ", currentFinalPosRingNum, " disIndex: ", currentFinalPosDisIndex)
  for _, pos in ipairs(candidates) do
    local ringNum = utilCalcSvc:GetGridRingNum(pos, center)
    if currentFinalPosRingNum > ringNum then
      self._Log(entity, "new target: ", finalPos, " ring: ", currentFinalPosRingNum, " disIndex: ", currentFinalPosDisIndex)
      finalPos = pos
      currentFinalPosRingNum = ringNum
      currentFinalPosDisIndex = table.ikey(sortedByDis, pos)
    else
      local disIndex = table.ikey(sortedByDis, pos)
      if currentFinalPosRingNum > disIndex then
        finalPos = pos
        currentFinalPosRingNum = ringNum
        currentFinalPosDisIndex = disIndex
        self._Log(entity, "new target: ", finalPos, " ring: ", currentFinalPosRingNum, " disIndex: ", currentFinalPosDisIndex)
      end
    end
  end
  local approachPath = utilCalcSvc:GetGridPathByVectorLerp(nearestPos, finalPos)
  approachPath, finalPos = self:CheckApproachPathForMaxStep(approachPath, finalPos, maxStep)
  local obstacledPos, obstacleIndex = self:GetFirstObstacleInPath(approachPath, entity, blockVal, bodyAreaByOff, casterEntity, includeCasterTeam, tractionParam)
  local finalPath = {}
  if obstacledPos then
    local lastIndex = obstacleIndex - 1
    while 0 < lastIndex do
      local gridPos = approachPath[lastIndex]
      local fitFullBodyArea = self:IsPosFitFullBodyArea(gridPos, entity, blockVal, bodyAreaByOff, casterEntity, includeCasterTeam, tractionParam)
      if not fitFullBodyArea then
        lastIndex = lastIndex - 1
      else
        break
      end
    end
    finalPos = approachPath[lastIndex]
    for i = 1, lastIndex do
      table.insert(finalPath, approachPath[i])
    end
  else
    finalPath = approachPath
  end
  if #finalPath == 0 then
    self:_SaveTargetEntityTractionResult(entity, currentPos, {})
    return
  end
  local finalPathNoOff = {}
  for index, value in ipairs(finalPath) do
    local gridPos = value - useOffV2
    table.insert(finalPathNoOff, gridPos)
  end
  local finalPosNoOff = finalPos - useOffV2
  if 1 < #finalPathNoOff then
    local utilData = self._world:GetService("UtilData")
    local finalPathBlockForTrapWall = utilData:CalcMovePathBlockForTrapWallWithEntity(finalPathNoOff, entity)
    finalPathNoOff = finalPathBlockForTrapWall
    finalPosNoOff = finalPathNoOff[#finalPathNoOff]
  end
  self:_SaveTargetEntityTractionResult(entity, finalPosNoOff, finalPathNoOff)
end

function SkillEffectCalc_MultiTraction:IsPosFitFullBodyArea(gridPos, entity, testBlockVal, bodyAreaByOff, casterEntity, includeCasterTeam, tractionParam)
  local checkPos = gridPos
  local areaArray = entity:BodyArea():GetArea()
  if bodyAreaByOff then
    areaArray = bodyAreaByOff
  end
  local casterBodyAreaOff = casterEntity:BodyArea():GetArea()
  local casterBodyArea = {}
  local casterPos = casterEntity:GetGridPosition()
  for _, area in ipairs(casterBodyAreaOff) do
    local workPos = casterPos + area
    table.insert(casterBodyArea, workPos)
  end
  local bossANaTuoLiTractionMonsterClassID
  if tractionParam.GetBossANaTuoLiTractionMonsterClassID then
    bossANaTuoLiTractionMonsterClassID = tractionParam:GetBossANaTuoLiTractionMonsterClassID()
  end
  if bossANaTuoLiTractionMonsterClassID then
    local teamEntity = self._world:Player():GetLocalTeamEntity()
    local teamBodyAreaOff = teamEntity:BodyArea():GetArea()
    local teamPos = teamEntity:GetGridPosition()
    for _, area in ipairs(teamBodyAreaOff) do
      local workPos = teamPos + area
      table.insert(casterBodyArea, workPos)
    end
  end
  for _, v2RelativeBody in ipairs(areaArray) do
    local v2 = checkPos + v2RelativeBody
    if not self._pieceBlockBlackboard[v2.x] or not self._pieceBlockBlackboard[v2.x][v2.y] then
      return false
    end
    if self._pieceBlockBlackboard[v2.x][v2.y]:GetBlock() & testBlockVal ~= 0 then
      return false
    end
    local checkCasterBodyArea = true
    if includeCasterTeam then
      if casterEntity:HasPet() then
        local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
        if entity:GetID() == teamEntity:GetID() then
          checkCasterBodyArea = false
        end
      end
      if casterEntity:HasMonsterID() then
        local teamEntity = self._world:Player():GetLocalTeamEntity()
        if entity:GetID() == teamEntity:GetID() then
          checkCasterBodyArea = false
        end
      end
    end
    if checkCasterBodyArea and table.intable(casterBodyArea, checkPos) then
      return false
    end
    local utilData = entity:GetOwnerWorld():GetService("UtilData")
    if utilData:IsPosBlockWithEntityRace(v2, testBlockVal, entity) then
      return false
    end
  end
  return true
end

function SkillEffectCalc_MultiTraction:GetFirstObstacleInPath(approachPath, entity, testBlockVal, bodyAreaByOff, casterEntity, includeCasterTeam, tractionParam)
  for index, v2 in ipairs(approachPath) do
    if not self:IsPosFitFullBodyArea(v2, entity, testBlockVal, bodyAreaByOff, casterEntity, includeCasterTeam, tractionParam) then
      return v2, index
    end
  end
end

function SkillEffectCalc_MultiTraction:CutOutMaxStepRangeForSingle(gridList, maxStep, center, areaArry)
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local accpetRange = {}
  if 0 < maxStep then
    local maxRing = maxStep
    if 0 <= maxRing then
      for index, value in ipairs(gridList) do
        local gridRing = utilCalcSvc:GetGridRingNumWithBodyArea(center, value, areaArry)
        if maxRing >= gridRing then
          table.insert(accpetRange, value)
        end
      end
    end
  end
  return accpetRange
end

function SkillEffectCalc_MultiTraction:CheckApproachPathForMaxStep(approachPath, finalPos, maxStep)
  if 0 < maxStep then
    local validPath = {}
    for index, value in ipairs(approachPath) do
      if index <= maxStep + 1 then
        table.insert(validPath, value)
      else
        break
      end
    end
    approachPath = validPath
    finalPos = approachPath[#approachPath]
    return approachPath, finalPos
  else
    return approachPath, finalPos
  end
end

function SkillEffectCalc_MultiTraction:_PetANaTuoLiFindTractionCenter(skillRangePos, castPos)
  local sortPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
  sortPosList:AllowDuplicate()
  for i = 1, #skillRangePos do
    AINewNode.InsertSortedArray(sortPosList, castPos, skillRangePos[i], i)
  end
  local totalCount = sortPosList:Size()
  local centerIndex = math.floor((totalCount + 1) / 2)
  local centerElement = sortPosList:GetAt(centerIndex)
  local centerPos = centerElement:GetPosData()
  return centerPos
end
