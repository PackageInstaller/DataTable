_class("SkillEffectCalc_SummonEverything", Object)
SkillEffectCalc_SummonEverything = SkillEffectCalc_SummonEverything

function SkillEffectCalc_SummonEverything:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._mathService = self._world:GetService("Math")
  if nil == self.m_listFuncCalSummonID then
    self.m_listFuncCalSummonID = {}
    self.m_listFuncCalSummonID[SkillEffectEnum_SummonBehavior.Random] = self._CalSummonID_Random
    self.m_listFuncCalSummonID[SkillEffectEnum_SummonBehavior.RandomDifferent] = self._CalSummonID_RandomDifferent
    self.m_listFuncCalSummonID[SkillEffectEnum_SummonBehavior.OutOfGridRange] = self._CalSummonID_OutOfRangeTrap
    self.m_listFuncCalSummonID[SkillEffectEnum_SummonBehavior.MirrorImage] = self._CalSummonID_MirrorImage
  end
end

function SkillEffectCalc_SummonEverything:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local posCaster = casterEntity:GetGridPosition()
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local summonResArray = {}
  local nSummonType = skillEffectParam:GetSummonType()
  local nSummonList = skillEffectParam:GetSummonList()
  local nSummonBehavior = skillEffectParam:GetSummonBehavior()
  local nSummonNumber = skillEffectParam:GetSummonNumber()
  local tSummonNumberRange = skillEffectParam:GetSummonNumberRange()
  local nSummonMonsterLimitCount = skillEffectParam:GetSummonMonsterLimitCount()
  local tLimitCheckID = skillEffectParam:GetLimitCheckID()
  local bIgnoreBlock = skillEffectParam:IsIgnoreBlock()
  local exceptionType = skillEffectParam:GetSummonExceptionType()
  local bCheckIgnoreBodyArea = skillEffectParam:GetSummonCheckIgnoreBodyArea()
  local cageSumOffPosList = skillEffectParam:GetCageSumOffPosList()
  local useBuffLayerAsTimes = skillEffectParam:GetUseBuffLayerAsTimes()
  local summonTimesForEachID = skillEffectParam:GetSummonTimesForEachID()
  local bUseRecordIDAsSummonID = skillEffectParam:IsUseRecordIDAsSummonID()
  if bUseRecordIDAsSummonID then
    local cBuff = casterEntity:BuffComponent()
    if cBuff then
      local recordID = tonumber(cBuff:GetBuffValue("RecordSummonerCfgID")) or 0
      if 0 < recordID then
        nSummonList = {recordID}
      end
    end
  end
  local blockType
  if bIgnoreBlock then
    blockType = BlockFlag.None
  end
  if tSummonNumberRange then
    local randomSvc = self._world:GetService("RandomLogic")
    local random = randomSvc:LogicRand(tSummonNumberRange.min, tSummonNumberRange.max)
    nSummonNumber = random
  end
  local listSummonID = self:_CalSummonID(nSummonBehavior, nSummonNumber, nSummonList)
  local nSummonTimes = 1
  if nSummonBehavior == SkillEffectEnum_SummonBehavior.Nonrandom then
    nSummonTimes = nSummonNumber
  end
  if summonTimesForEachID then
    nSummonTimes = summonTimesForEachID
  end
  if useBuffLayerAsTimes then
    local buffHolderEntity = casterEntity
    if casterEntity:HasSuperEntity() then
      buffHolderEntity = casterEntity:GetSuperEntity()
    end
    local buffEffectType = tonumber(useBuffLayerAsTimes)
    local buffSvc = self._world:GetService("BuffLogic")
    local layer = buffSvc:GetBuffLayer(buffHolderEntity, buffEffectType)
    nSummonTimes = layer
  end
  local searchRing9 = false
  if exceptionType == SkillEffectEnum_SummonExceptionType.Ring9 then
    searchRing9 = true
  end
  local listPosHaveDown = {}
  for key, v in ipairs(listSummonID) do
    for i = 1, nSummonTimes do
      local canSummon = self:_CheckSummonEverythingLimitCount(casterEntity, #summonResArray, nSummonType, listSummonID, nSummonMonsterLimitCount, tLimitCheckID)
      if canSummon then
        local curSummonID = v
        local posSummon
        if nSummonBehavior == SkillEffectEnum_SummonBehavior.OutOfGridRange then
          posSummon = skillEffectCalcParam.skillRange[key]
        elseif nSummonBehavior == SkillEffectEnum_SummonBehavior.Cage then
          posSummon = skillEffectCalcParam.skillRange[key]
          if cageSumOffPosList then
            local offPos = cageSumOffPosList[key]
            if offPos then
              posSummon = posCaster + offPos
            end
          end
        elseif nSummonBehavior == SkillEffectEnum_SummonBehavior.MirrorImage then
          posSummon = self:MirrorImagePos(skillEffectParam:GetTrapID())
        else
          local range = skillEffectCalcParam.skillRange
          if searchRing9 then
            range = skillEffectCalcParam.wholeRange
          end
          posSummon = self._skillEffectService:_FindSummonPos(nSummonType, range, curSummonID, listPosHaveDown, blockType, searchRing9, bCheckIgnoreBodyArea)
        end
        if not posSummon then
          if exceptionType == SkillEffectEnum_SummonExceptionType.Around4 then
            posSummon = self:ExceptionAround4(self._world, nSummonType, skillEffectCalcParam.skillRange, curSummonID, listPosHaveDown, blockType)
          elseif exceptionType == SkillEffectEnum_SummonExceptionType.Around4AndNearToFar then
            posSummon = self:ExceptionAround4(self._world, nSummonType, skillEffectCalcParam.skillRange, curSummonID, listPosHaveDown, blockType)
            if not posSummon then
              posSummon = self:ExceptionAroundSquareRing(self._world, nSummonType, skillEffectCalcParam.skillRange, curSummonID, listPosHaveDown, blockType)
            end
          elseif exceptionType == SkillEffectEnum_SummonExceptionType.Around4AndNearToFarNoRandom then
            local range = skillEffectCalcParam.skillRange
            if range and #range < 1 then
              range = skillEffectCalcParam.wholeRange
            end
            posSummon = self:Around4AndNearToFarNoRandom(self._world, nSummonType, range, curSummonID, listPosHaveDown, blockType, true)
          end
          if not posSummon then
            Log.info("[SkillEffectCalcService] SummonEverything: not enough space at [", key, "], skipping. ")
            break
          end
        end
        if posSummon then
          local summonResult = SkillEffectResult_SummonEverything:New(nSummonType, curSummonID, posCaster, posSummon)
          summonResArray[#summonResArray + 1] = summonResult
        end
      end
    end
  end
  return summonResArray
end

function SkillEffectCalc_SummonEverything:_CheckSummonEverythingLimitCount(casterEntity, hadSummonCount, nSummonType, nSummonID, nSummonMonsterLimitCount, tLimitCheckID)
  local canSummon = true
  if nSummonMonsterLimitCount == 0 then
    return canSummon
  end
  local checkIDs = nSummonID
  if tLimitCheckID and 0 < #tLimitCheckID then
    checkIDs = tLimitCheckID
  end
  if SkillEffectEnum_SummonType.Monster == nSummonType then
    local hadCount = 0
    hadCount = hadSummonCount
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    if monsterGroup then
      for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
        if not monsterEntity:HasDeadMark() then
          local monsterID = monsterEntity:MonsterID():GetMonsterID()
          if table.intable(checkIDs, monsterID) then
            hadCount = hadCount + 1
          end
          if nSummonMonsterLimitCount <= hadCount then
            return false
          end
        end
      end
    end
  elseif SkillEffectEnum_SummonType.Trap == nSummonType then
    local hadCount = 0
    hadCount = hadSummonCount
    local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
    if trapGroup then
      for _, trapEntity in ipairs(trapGroup:GetEntities()) do
        if not trapEntity:HasDeadMark() then
          local trapID = trapEntity:Trap():GetTrapID()
          if table.intable(checkIDs, trapID) then
            hadCount = hadCount + 1
          end
          if nSummonMonsterLimitCount <= hadCount then
            return false
          end
        end
      end
    end
  end
  return canSummon
end

function SkillEffectCalc_SummonEverything:_CalSummonID(nSummonBehavior, nSummonNumber, nSummonList)
  local pFunction = self.m_listFuncCalSummonID[nSummonBehavior]
  if nil == pFunction then
    return nSummonList
  end
  return pFunction(self, nSummonNumber, nSummonList)
end

function SkillEffectCalc_SummonEverything:_CalSummonID_Random(nSummonNumber, nSummonList)
  local randomSvc = self._world:GetService("RandomLogic")
  local listSummonID = {}
  local nSummonTableNum = table.count(nSummonList)
  if 1 < nSummonTableNum then
    for i = 1, nSummonNumber do
      local nRandomIndex = randomSvc:LogicRand(1, nSummonTableNum)
      listSummonID[#listSummonID + 1] = nSummonList[nRandomIndex]
    end
  end
  return listSummonID
end

function SkillEffectCalc_SummonEverything:_CalSummonID_RandomDifferent(nSummonNumber, nSummonList)
  local randomSvc = self._world:GetService("RandomLogic")
  local listSummonID = {}
  local nSummonTableNum = table.count(nSummonList)
  if 1 < nSummonTableNum then
    while nSummonNumber > table.count(listSummonID) do
      local nRandomIndex = randomSvc:LogicRand(1, nSummonTableNum)
      local monsterID = nSummonList[nRandomIndex]
      if not table.icontains(listSummonID, monsterID) then
        listSummonID[#listSummonID + 1] = nSummonList[nRandomIndex]
      end
    end
  end
  return listSummonID
end

function SkillEffectCalc_SummonEverything:_CalSummonID_OutOfRangeTrap(nSummonNumber, nSummonList)
  return nSummonList
end

function SkillEffectCalc_SummonEverything:_CalSummonID_MirrorImage(nSummonNumber, nSummonList)
  return nSummonList
end

function SkillEffectCalc_SummonEverything:_CalTrapSommonPos(boardServiceLogic, nTrapID, listPosPlan)
  local posSummon
  local cfgTrap = Cfg.cfg_trap[nTrapID]
  local trapBodyArea = {}
  if cfgTrap then
    for key, value in ipairs(cfgTrap.Area) do
      local posTemp = Vector2(tonumber(value[1]), tonumber(value[2]))
      table.insert(trapBodyArea, posTemp)
    end
  end
  for i = 1, #listPosPlan do
    local posTemp = Vector2.New(listPosPlan[i].x, listPosPlan[i].y)
    local bIsBlock = false
    if 0 < #trapBodyArea then
      bIsBlock = boardServiceLogic:IsPosBlockByArea(posTemp, BlockFlag.SummonTrap, trapBodyArea, nil)
    else
      bIsBlock = boardServiceLogic:IsPosBlock(posTemp, BlockFlag.SummonTrap)
    end
    if not bIsBlock then
      posSummon = posTemp
      break
    end
  end
  return posSummon
end

function SkillEffectCalc_SummonEverything:ExceptionAround4(world, nSummonType, skillRange, curSummonID, listPosHaveDown, blockType, noRandom)
  local exceptionRange = {}
  local boardSvc = world:GetService("BoardLogic")
  for _, pos in ipairs(skillRange) do
    local up = Vector2(pos.x, pos.y + 1)
    local down = Vector2(pos.x, pos.y - 1)
    local left = Vector2(pos.x + 1, pos.y)
    local right = Vector2(pos.x - 1, pos.y)
    if boardSvc:IsValidPiecePos(up) and not table.Vector2Include(exceptionRange, up) then
      table.insert(exceptionRange, up)
    end
    if boardSvc:IsValidPiecePos(down) and not table.Vector2Include(exceptionRange, down) then
      table.insert(exceptionRange, down)
    end
    if boardSvc:IsValidPiecePos(left) and not table.Vector2Include(exceptionRange, left) then
      table.insert(exceptionRange, left)
    end
    if boardSvc:IsValidPiecePos(right) and not table.Vector2Include(exceptionRange, right) then
      table.insert(exceptionRange, right)
    end
  end
  return self._skillEffectService:_FindSummonPos(nSummonType, exceptionRange, curSummonID, listPosHaveDown, blockType, nil, nil, noRandom)
end

function SkillEffectCalc_SummonEverything:ExceptionAroundSquareRing(world, nSummonType, skillRange, curSummonID, listPosHaveDown, blockType, noRandom)
  local boardSvc = world:GetService("BoardLogic")
  local maxLen = boardSvc:GetCurBoardMaxLen()
  local posSummon
  local utilDataService = self._world:GetService("UtilData")
  for i = 1, maxLen do
    local posList = ComputeScopeRange.ComputeRange_SquareRing(skillRange[1], 1, i, true)
    posSummon = self._skillEffectService:_FindSummonPos(nSummonType, posList, curSummonID, listPosHaveDown, blockType, nil, nil, noRandom)
    if posSummon then
      return posSummon
    end
  end
  return posSummon
end

function SkillEffectCalc_SummonEverything:Around4AndNearToFarNoRandom(world, nSummonType, skillRange, curSummonID, listPosHaveDown, blockType, noRandom)
  local posSummon = self:ExceptionAround4(world, nSummonType, skillRange, curSummonID, listPosHaveDown, blockType, noRandom)
  posSummon = posSummon or self:ExceptionAroundSquareRing(world, nSummonType, skillRange, curSummonID, listPosHaveDown, blockType, noRandom)
  return posSummon
end

function SkillEffectCalc_SummonEverything:MirrorImagePos(trapID)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local utilDataSvc = self._world:GetService("UtilData")
  local trapEntities = utilDataSvc:GetTrapByID(trapID)
  if trapEntities and trapEntities[1] then
    local trapEntity = trapEntities[1]
    local mirrorPos = trapEntity:GetGridPosition()
    return mirrorPos + mirrorPos - playerPos
  end
  return playerPos
end
