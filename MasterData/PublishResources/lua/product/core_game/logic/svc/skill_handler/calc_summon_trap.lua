_class("SkillEffectCalc_SummonTrap", Object)
SkillEffectCalc_SummonTrap = SkillEffectCalc_SummonTrap

function SkillEffectCalc_SummonTrap:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
end

function SkillEffectCalc_SummonTrap:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillRange = skillEffectCalcParam.skillRange
  if not skillRange or table.count(skillRange) == 0 then
    return
  end
  local skillSummonTrapEffectParam = skillEffectCalcParam.skillEffectParam
  if skillSummonTrapEffectParam:GetSummonType() == SummonTrapType.ByTargetUnderGrid then
    return self:SummonTrapByTargetUnderGrid(skillEffectCalcParam)
  end
  if skillSummonTrapEffectParam:GetSummonType() == SummonTrapType.Range then
    return self:SummonTrapByRange(skillEffectCalcParam)
  end
  if skillSummonTrapEffectParam:GetSummonType() == SummonTrapType.RandomRange then
    return self:SummonTrapByRandomRange(skillEffectCalcParam)
  end
  if skillSummonTrapEffectParam:GetSummonType() == SummonTrapType.RandomRangeWithBlock then
    return self:SummonTrapByRandomRangeWithBlock(skillEffectCalcParam)
  end
  if not self:CheckCanSummon(skillEffectCalcParam) then
    return
  end
  if not self:CheckCanSummonByCountLimit(skillEffectCalcParam) then
    return
  end
  local centerPos = skillEffectCalcParam.skillRange[1]
  local trapIdList = skillSummonTrapEffectParam:GetTrapID()
  local block = skillSummonTrapEffectParam:GetBlock()
  if type(trapIdList) == "number" then
    trapIdList = {trapIdList}
  end
  local len = table.count(trapIdList)
  local index = 1
  if 1 < len then
    local randomSvc = self._world:GetService("RandomLogic")
    index = randomSvc:LogicRand(1, len)
  end
  local trapId = trapIdList[index]
  local moveTrap = skillSummonTrapEffectParam:GetMoveTrap()
  if moveTrap then
    local result = self:MoveTrap(trapId, centerPos, skillEffectCalcParam:GetCasterEntityID())
    if result then
      return result
    end
  end
  local dir
  local isUsePickUpDir = skillSummonTrapEffectParam:IsUsePickUpDir()
  if isUsePickUpDir then
    local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
    local activeSkillPickUpCmpt = casterEntity:ActiveSkillPickUpComponent()
    if activeSkillPickUpCmpt then
      local firstPos = activeSkillPickUpCmpt:GetFirstValidPickUpGridPos()
      local secondPos = activeSkillPickUpCmpt:GetLastPickUpGridPos()
      dir = secondPos - firstPos
    end
  end
  local aiOrder = self:GetTrapAIOrder(skillEffectCalcParam)
  if trapId then
    if not self:CheckCanSummonByOverlapFlag(skillEffectCalcParam, centerPos, trapId) then
      return
    end
    if skillSummonTrapEffectParam:IsBlockByMonster() then
      local sUtilData = self._world:GetService("UtilData")
      local entity = sUtilData:GetMonsterAtPos(centerPos)
      if entity then
        local buffComponent = entity:BuffComponent()
        if buffComponent and buffComponent:HasBuffEffect(BuffEffectType.NotBeSelectedAsSkillTarget) then
        else
          return
        end
      end
    end
    local trapSvc = self._world:GetService("TrapLogic")
    if block == 0 or trapSvc:CanSummonTrapOnPos(centerPos, trapId) then
      return SkillSummonTrapEffectResult:New(trapId, centerPos, skillSummonTrapEffectParam:IsTransferDisabled(), skillSummonTrapEffectParam:GetSkillEffectDamageStageIndex(), dir, aiOrder)
    end
  end
end

function SkillEffectCalc_SummonTrap:CheckCanSummon(skillEffectCalcParam)
  local summonTrapParam = skillEffectCalcParam.skillEffectParam
  local absorbNum = summonTrapParam:GetAbsorbTrapNum()
  if absorbNum == 0 then
    return true
  end
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local result = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.AbsorbTrapsAndDamageByPickupTarget)
  if result then
    local trapEntityIDs = result:GetTrapEntityIDs()
    if absorbNum <= #trapEntityIDs then
      return true
    end
  end
  return false
end

function SkillEffectCalc_SummonTrap:CheckCanSummonByOverlapFlag(skillEffectCalcParam, centerPos, trapId)
  local summonTrapParam = skillEffectCalcParam:GetSkillEffectParam()
  if summonTrapParam:IsTrapOverlap() then
    return true
  end
  local boardCmpt = self._world:GetBoardEntity():Board()
  local repeatTraps = boardCmpt:GetPieceEntities(centerPos, function(e)
    local isOwner = false
    if e:HasSummoner() then
      local summoner = e:Summoner()
      if summoner:GetSummonerEntityID() == skillEffectCalcParam.casterEntityID then
        isOwner = true
      elseif summonTrapParam:IsTrapOverlapCheckSuper() then
        local summonEntity = e:GetSummonerEntity()
        if summonEntity and summonEntity:HasSuperEntity() and summonEntity:GetSuperEntity() then
          local summonEntityID = summonEntity:GetSuperEntity():GetID()
          if summonEntityID == skillEffectCalcParam.casterEntityID then
            isOwner = true
          end
        end
      end
    else
      isOwner = true
    end
    return isOwner and e:HasTrap() and e:Trap():GetTrapID() == trapId and not e:HasDeadMark()
  end)
  if 0 < #repeatTraps then
    return false
  end
  return true
end

function SkillEffectCalc_SummonTrap:CheckCanSummonByCountLimit(skillEffectCalcParam)
  local casterID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterID)
  local trapSvc = self._world:GetService("TrapLogic")
  if trapSvc:IsSummonCountLimit(casterEntity) then
    return false
  end
  return true
end

function SkillEffectCalc_SummonTrap:GetTrapAIOrder(skillEffectCalcParam)
  local skillParam = skillEffectCalcParam:GetSkillEffectParam()
  local aiOrder = skillParam:GetTrapAIOrder()
  if not aiOrder then
    return
  end
  local casterID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterID)
  local trapSvc = self._world:GetService("TrapLogic")
  local curCount = trapSvc:GetSummonTrapCount(casterEntity)
  return aiOrder + curCount
end

function SkillEffectCalc_SummonTrap:MoveTrap(trapID, movePos, casterEntityID)
  local trapEntityList = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() and e:TrapID():GetTrapID() == trapID and e:HasSummoner() and e:Summoner():GetSummonerEntityID() == casterEntityID then
      table.insert(trapEntityList, e)
    end
  end
  if #trapEntityList == 0 then
    return
  end
  local trapEntity = trapEntityList[1]
  local entityID = trapEntity:GetID()
  local posOld = trapEntity:GetGridPosition()
  local replaceTrapEntityID
  local needMove = true
  if posOld ~= movePos then
    needMove, replaceTrapEntityID = self:_GetReplaceTrapEntityID(trapID, movePos)
  end
  if not needMove then
    return
  end
  local resultArray = {}
  table.insert(resultArray, SkillEffectResultMoveTrap:New(entityID, posOld, movePos, replaceTrapEntityID))
  return resultArray
end

function SkillEffectCalc_SummonTrap:_GetReplaceTrapEntityID(trapID, movePos)
  local configSvc = self._world:GetService("Config")
  local trapConfigData = configSvc:GetTrapConfigData()
  local trapData = trapConfigData:GetTrapData(trapID)
  local utilSvc = self._world:GetService("UtilData")
  local samePosTraps = utilSvc:GetTrapsAtPos(movePos)
  local trapSvc = self._world:GetService("TrapLogic")
  if #samePosTraps == 0 then
    return true, nil
  end
  local onlyViewTrap = trapSvc:IsViewTrapLevel(trapData.TrapLevel)
  for _, e in ipairs(samePosTraps) do
    local trapCmpt = e:Trap()
    if trapCmpt:GetTrapLevel() == trapData.TrapLevel and not onlyViewTrap then
      if trapCmpt:GetReplaceLevel() <= trapData.ReplaceLevel then
        if not e:HasDeadMark() then
          e:Attributes():Modify("HP", 0)
          trapSvc:AddTrapDeadMark(e)
          return true, e:GetID()
        end
      else
        return false, nil
      end
    end
  end
  return true, nil
end

function SkillEffectCalc_SummonTrap:_RangeCanSummonTrap(trapID, range, stopSummonTrapType)
  local trapConfigData = self._configService:GetTrapConfigData()
  local trapData = trapConfigData:GetTrapData(trapID)
  local find = false
  local utilSvc = self._world:GetService("UtilData")
  local trapSvc = self._world:GetService("TrapLogic")
  local randomSvc = self._world:GetService("RandomLogic")
  while 0 < #range do
    local index = randomSvc:LogicRand(1, #range)
    local pos = range[index]
    table.remove(range, index)
    local bFind = self:IsPosCanSummonTrap(pos, trapID, stopSummonTrapType)
    if bFind then
      return pos
    end
  end
  return nil
end

function SkillEffectCalc_SummonTrap:IsPosCanSummonTrap(pos, trapID, stopSummonTrapType)
  local utilSvc = self._world:GetService("UtilData")
  local samePosTraps = utilSvc:GetTrapsAtPos(pos)
  local isValidPos = utilSvc:IsValidPiecePos(pos)
  if not isValidPos then
    return false
  end
  if #samePosTraps == 0 then
    return true
  end
  for _, e in ipairs(samePosTraps) do
    local trapCmpt = e:Trap()
    local type = trapCmpt:GetTrapType()
    local _trapID = trapCmpt:GetTrapID()
    if table.icontains(stopSummonTrapType, type) or _trapID == trapID then
      return false
    end
  end
  return true
end

function SkillEffectCalc_SummonTrap:SummonTrapByTargetUnderGrid(skillEffectCalcParam)
  local targetIDs = skillEffectCalcParam:GetTargetEntityIDs()
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local stopSummonTrapType = param:GetStopSummonTrapType()
  local trapID = param:GetTrapID()
  local gridList = {}
  if not targetIDs or targetIDs[1] == -1 then
    return
  end
  for i, id in ipairs(targetIDs) do
    local entity = self._world:GetEntityByID(id)
    local localPos = entity:GetGridPosition()
    local bodyAreaCpt = entity:BodyArea()
    local bodyArea = bodyAreaCpt:GetArea()
    local range = {}
    if 0 < #bodyArea then
      for i, v in ipairs(bodyArea) do
        local pos = Vector2(v.x + localPos.x, v.y + localPos.y)
        table.insert(range, pos)
      end
    else
      table.insert(range, localPos)
    end
    local canSummonPos = self:_RangeCanSummonTrap(trapID, range, stopSummonTrapType)
    if canSummonPos then
      table.insert(gridList, canSummonPos)
    end
  end
  local retList = {}
  for i, pos in ipairs(gridList) do
    local result = SkillSummonTrapEffectResult:New(trapID, pos, param:IsTransferDisabled(), param:GetSkillEffectDamageStageIndex())
    table.insert(retList, result)
  end
  return retList
end

function SkillEffectCalc_SummonTrap:SummonTrapByRange(skillEffectCalcParam)
  local targetIDs = skillEffectCalcParam:GetTargetEntityIDs()
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local range = skillEffectCalcParam:GetSkillRange()
  local stopSummonTrapType = param:GetStopSummonTrapType()
  local trapID = param:GetTrapID()
  local gridList = {}
  if not targetIDs or targetIDs[1] == -1 then
    return
  end
  for _, pos in ipairs(range) do
    local canSummon = self:IsPosCanSummonTrap(pos, trapID, stopSummonTrapType)
    if canSummon then
      table.insert(gridList, pos)
    end
  end
  local retList = {}
  for _, pos in ipairs(gridList) do
    local result = SkillSummonTrapEffectResult:New(trapID, pos, param:IsTransferDisabled(), param:GetSkillEffectDamageStageIndex())
    table.insert(retList, result)
  end
  return retList
end

function SkillEffectCalc_SummonTrap:SummonTrapByRandomRangeWithBlock(skillEffectCalcParam)
  local targetIDs = skillEffectCalcParam:GetTargetEntityIDs()
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local range = skillEffectCalcParam:GetSkillRange()
  local randomCount = param:GetRandomCount()
  if param:GetRangeM() then
    randomCount = math.floor(#range / param:GetRangeM())
  end
  local trapID = param:GetTrapID()
  local gridList = {}
  if not targetIDs or targetIDs[1] == -1 then
    return
  end
  local tmpRange = {}
  for index, pos in ipairs(range) do
    tmpRange[index] = pos
  end
  local block = param:GetBlock()
  local randomSvc = self._world:GetService("RandomLogic")
  while 0 < #tmpRange and randomCount ~= 0 do
    local index = randomSvc:LogicRand(1, #tmpRange)
    local pos = tmpRange[index]
    table.remove(tmpRange, index)
    local trapSvc = self._world:GetService("TrapLogic")
    if block == 0 or trapSvc:CanSummonTrapOnPos(pos, trapID) then
      table.insert(gridList, pos)
      randomCount = randomCount - 1
    end
  end
  local retList = {}
  for _, pos in ipairs(gridList) do
    local result = SkillSummonTrapEffectResult:New(trapID, pos, param:IsTransferDisabled(), param:GetSkillEffectDamageStageIndex())
    table.insert(retList, result)
  end
  return retList
end

function SkillEffectCalc_SummonTrap:SummonTrapByRandomRange(skillEffectCalcParam)
  local targetIDs = skillEffectCalcParam:GetTargetEntityIDs()
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local range = skillEffectCalcParam:GetSkillRange()
  local stopSummonTrapType = param:GetStopSummonTrapType()
  local randomCount = param:GetRandomCount()
  if param:GetRangeM() then
    randomCount = math.floor(#range / param:GetRangeM())
  end
  local trapID = param:GetTrapID()
  local gridList = {}
  if not targetIDs or targetIDs[1] == -1 then
    return
  end
  local tmpRange = {}
  for index, pos in ipairs(range) do
    tmpRange[index] = pos
  end
  local randomSvc = self._world:GetService("RandomLogic")
  while 0 < #tmpRange and randomCount ~= 0 do
    local index = randomSvc:LogicRand(1, #tmpRange)
    local pos = tmpRange[index]
    table.remove(tmpRange, index)
    local bCan = self:IsPosCanSummonTrap(pos, trapID, stopSummonTrapType)
    if bCan then
      table.insert(gridList, pos)
      randomCount = randomCount - 1
    end
  end
  local retList = {}
  for _, pos in ipairs(gridList) do
    local result = SkillSummonTrapEffectResult:New(trapID, pos, param:IsTransferDisabled(), param:GetSkillEffectDamageStageIndex())
    table.insert(retList, result)
  end
  return retList
end
