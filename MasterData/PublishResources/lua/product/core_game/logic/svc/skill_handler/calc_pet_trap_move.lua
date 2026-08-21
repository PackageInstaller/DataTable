_class("SkillEffectCalc_PetTrapMove", SkillEffectCalc_Base)
SkillEffectCalc_PetTrapMove = SkillEffectCalc_PetTrapMove

function SkillEffectCalc_PetTrapMove:Constructor(world)
  self._world = world
  self.m_nextPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
  self.m_nextPosList:AllowDuplicate()
end

function SkillEffectCalc_PetTrapMove:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  self.casterEntity = casterEntity
  local casterPos = casterEntity:GetGridPosition()
  local targetIDList = skillEffectCalcParam:GetTargetEntityIDs()
  local targetID
  if table.count(targetIDList) >= 1 then
    targetID = targetIDList[1]
  end
  local targetEntity = self._world:GetEntityByID(targetID)
  local skillParam = skillEffectCalcParam.skillEffectParam
  local moveStep = skillParam:GetMoveStep()
  local moveType = skillParam:GetMoveType()
  local moveParam = skillParam:GetMoveParam()
  local canMoveTrapLevel = skillParam:GetCanMoveTrapLevel()
  local targetCenterPos = targetEntity:GetGridPosition()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local boardServiceLogic = self._world:GetService("BoardLogic")
  self._needBypassPosList = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for _, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() then
      local trapCmpt = e:Trap()
      local level = trapCmpt:GetTrapLevel()
      if not table.intable(canMoveTrapLevel, level) and e:GetID() ~= casterEntityID then
        local bodyArea = e:BodyArea():GetArea()
        local gridPos = e:GetGridPosition()
        for _, v in ipairs(bodyArea) do
          table.insert(self._needBypassPosList, gridPos + v)
        end
      end
    end
  end
  local posWalkResultList = {}
  local isCasterDead = false
  self.m_nextPosList:Clear()
  local resultList = {}
  self._lastPos = casterPos
  if moveType == PetTrapMoveType.CloseToTeam then
    local previewRange = self:_CalcPreviewRange(casterPos, moveStep)
    table.removev(previewRange, casterPos)
    for i = 1, #previewRange do
      local posWork = previewRange[i]
      AINewNode.InsertSortedArray(self.m_nextPosList, teamPos, posWork, i)
    end
    for i = 1, moveStep do
      local posWalk = self:_CalcMovePos(casterEntity, moveStep - i + 1)
      if posWalk == nil and table.count(resultList) == 0 then
        posWalk = self._lastPos
      end
      if posWalk ~= nil then
        local posOld = self._lastPos:Clone()
        local dirNew = posWalk - posOld
        local result = SkillEffectResultPetTrapMove:New(casterEntityID, posOld, posWalk, dirNew, moveType)
        result:SetPreviewRange(previewRange)
        self._lastPos = posWalk
        table.insert(resultList, result)
      end
    end
  elseif moveType == PetTrapMoveType.AwayFromTeam then
    local previewRange = self:_CalcPreviewRange(casterPos, moveStep)
    table.removev(previewRange, casterPos)
    local bExcludeSelf = moveParam or 0
    self.m_nextPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByFar)
    self.m_nextPosList:AllowDuplicate()
    for i = 1, moveStep do
      local walkRange = self:ComputeWalkRange(self._lastPos, 1, true)
      if bExcludeSelf == 0 then
        AINewNode.InsertSortedArray(self.m_nextPosList, teamPos, self._lastPos, 0)
      end
      for i = 1, #walkRange do
        local posData = walkRange[i]
        local posWalk = posData:GetPos()
        if self:IsPosAccessible(posWalk) and (0 == bExcludeSelf or 0 < bExcludeSelf and posWalk ~= casterPos) then
          AINewNode.InsertSortedArray(self.m_nextPosList, teamPos, posWalk, i)
        end
      end
      local posFind = self:FindPosValid(self.m_nextPosList, self._lastPos)
      local posOld = self._lastPos:Clone()
      local dirNew = posFind - posOld
      local result = SkillEffectResultPetTrapMove:New(casterEntityID, posOld, posFind, dirNew, moveType)
      result:SetPreviewRange(previewRange)
      self._lastPos = posFind
      table.insert(resultList, result)
    end
  elseif moveType == PetTrapMoveType.FixedPos then
    local targetPos = Vector2(moveParam[1][1], moveParam[1][2])
    if targetPos == casterPos then
      return
    end
    for i = 1, moveStep do
      local walkRange = self:ComputeWalkRange(self._lastPos, 1, true)
      AINewNode.InsertSortedArray(self.m_nextPosList, targetPos, self._lastPos, 0)
      for i = 1, #walkRange do
        local posData = walkRange[i]
        local posWalk = posData:GetPos()
        if self:IsPosAccessible(posWalk) then
          AINewNode.InsertSortedArray(self.m_nextPosList, targetPos, posWalk, i)
        end
      end
      local posFind = self:FindPosValid(self.m_nextPosList, self._lastPos)
      local posOld = self._lastPos:Clone()
      local dirNew = posFind - posOld
      local result = SkillEffectResultPetTrapMove:New(casterEntityID, posOld, posFind, dirNew, moveType)
      result:SetPreviewRange(posFind)
      self._lastPos = posFind
      table.insert(resultList, result)
    end
  elseif moveType == PetTrapMoveType.SkillPos then
    local previewRange = self:_CalcPreviewRange(casterPos, moveStep)
    table.removev(previewRange, casterPos)
    local skillID = moveParam
    local bodyAreaCmpt = targetEntity:BodyArea()
    local walkRange = self:_ComputeSkillRange(skillID, targetCenterPos, bodyAreaCmpt:GetArea())
    for i = 1, #walkRange do
      local posWork = walkRange[i]
      if self:IsPosAccessible(posWork) then
        AINewNode.InsertSortedArray(self.m_nextPosList, casterPos, posWork, i)
      end
    end
    self._lastPos = casterPos
    local isCasterDead = false
    local posWalkResultList = {}
    for i = 1, moveStep do
      local posWalk = self:_CalcMovePos(casterEntity, moveStep - i + 1)
      if posWalk == nil and table.count(resultList) == 0 then
        posWalk = self._lastPos
      end
      if posWalk ~= nil then
        local posOld = self._lastPos:Clone()
        local dirNew = posWalk - posOld
        local result = SkillEffectResultPetTrapMove:New(casterEntityID, posOld, posWalk, dirNew, moveType)
        result:SetPreviewRange(previewRange)
        self._lastPos = posWalk
        table.insert(resultList, result)
      end
    end
  elseif moveType == PetTrapMoveType.Loop then
    local posList = {}
    for _, param in ipairs(moveParam) do
      local pos = Vector2(param[1], param[2])
      table.insert(posList, pos)
    end
    local canMoveSetp = 0
    for i = 1, moveStep do
      local addPos = posList[i]
      table.insert(posList, addPos)
    end
    local calcPosList = {}
    for _, pos in ipairs(posList) do
      if 0 < canMoveSetp then
        canMoveSetp = canMoveSetp - 1
        table.insert(calcPosList, pos)
        if canMoveSetp == 0 then
          break
        end
      end
      if pos == casterPos then
        canMoveSetp = moveStep
      end
    end
    for _, pos in ipairs(calcPosList) do
      if boardServiceLogic:IsPosBlock(pos, BlockFlag.MonsterLand) or table.intable(self._needBypassPosList, pos) then
        break
      end
      local posOld = self._lastPos:Clone()
      local dirNew = pos - posOld
      local result = SkillEffectResultPetTrapMove:New(casterEntityID, posOld, pos, dirNew, moveType)
      result:SetPreviewRange(pos)
      self._lastPos = pos
      table.insert(resultList, result)
    end
  end
  return resultList
end

function SkillEffectCalc_PetTrapMove:_CalcPreviewRange(casterPos, moveStep)
  local previewRange = {}
  local walkRange = self:ComputeWalkRange(casterPos, moveStep, true)
  for i = 1, #walkRange do
    local posData = walkRange[i]
    local posWalk = posData:GetPos()
    table.insert(previewRange, posWalk)
  end
  return previewRange
end

function SkillEffectCalc_PetTrapMove:_OnArrivePos(casterPos, moveStep)
  local previewRange = {}
  local walkRange = self:ComputeWalkRange(casterPos, moveStep, true)
  for i = 1, #walkRange do
    local posData = walkRange[i]
    local posWalk = posData:GetPos()
    table.insert(previewRange, posWalk)
  end
  return previewRange
end

function SkillEffectCalc_PetTrapMove:_OnArrivePos(casterEntity, walkRes, skillParam)
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local listTrapWork, listTrapResult = trapServiceLogic:TriggerTrapByEntity(casterEntity, TrapTriggerOrigin.Move)
  for i, e in ipairs(listTrapWork) do
    local trapEntity = e
    local skillEffectResultContainer = listTrapResult[i]
    local aiResult = AISkillResult:New()
    aiResult:SetResultContainer(skillEffectResultContainer)
    walkRes:AddWalkTrap(trapEntity:GetID(), aiResult)
  end
end

function SkillEffectCalc_PetTrapMove:CalMoveResultList(casterEntity, targetEntity, skillParam)
  local moveStep = skillParam:GetMoveStep()
  local moveType = skillParam:GetMoveType()
  local moveParam = skillParam:GetMoveParam()
  local skillID = moveParam
  local targetCenterPos = targetEntity:GetGridPosition()
  local casterPos = casterEntity:GetGridPosition()
  local bodyAreaCmpt = targetEntity:BodyArea()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local sBoard = self._world:GetService("BoardLogic")
  local listPosTarget = {targetCenterPos}
  self.m_nextPosList:Clear()
  local walkRange = self:_ComputeSkillRange(skillID, targetCenterPos, bodyAreaCmpt:GetArea())
  for i = 1, #walkRange do
    local posWork = walkRange[i]
    if self:IsPosAccessible(posWork) then
      AINewNode.InsertSortedArray(self.m_nextPosList, casterPos, posWork, i)
    end
  end
  self._lastPos = casterPos
  local isCasterDead = false
  local posWalkResultList = {}
  for i = 1, moveStep do
    local posWalk = self:_CalcMovePos(casterEntity, moveStep - i + 1)
    if posWalk ~= nil then
      local posSelf = casterEntity:GetGridPosition()
      self._lastPos = posWalk
      table.insert(posWalkResultList, posWalk)
    end
  end
  return posWalkResultList
end

function SkillEffectCalc_PetTrapMove:_CalcMovePos(entityWork, nWalkTotal)
  local posSelf = self._lastPos
  local posTarget = self:FindNewTargetPos(posSelf)
  if posSelf == posTarget then
    return nil
  end
  local posWalkList = self:ComputeWalkRange(posSelf, nWalkTotal, true)
  local posWalk = self:FindNewWalkPos(posWalkList, posTarget, posSelf)
  if posWalk and posWalk == posSelf then
    return nil
  end
  return posWalk
end

function SkillEffectCalc_PetTrapMove:FindNewTargetPos(posDefault)
  return self:FindPosValid(self.m_nextPosList, posDefault)
end

function SkillEffectCalc_PetTrapMove:FindPosValid(planPosList, defPos)
  if nil == planPosList or planPosList:Size() <= 0 then
    return defPos
  end
  local posSelf = defPos
  local posReturn = posSelf
  local nPosCount = planPosList:Size()
  for i = 1, nPosCount do
    local posWork = planPosList:GetAt(i)
    local bAccessible = self:IsPosAccessible(posWork.data)
    if true == bAccessible then
      posReturn = posWork.data
      break
    end
  end
  return posReturn
end

function SkillEffectCalc_PetTrapMove:IsPosAccessible(pos)
  if false == self.casterEntity:HasBodyArea() then
    return true
  end
  if table.intable(self._needBypassPosList, pos) then
    return false
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local blockFlag = BlockFlag.MonsterLand
  local coverList = self.casterEntity:GetCoverAreaList(pos)
  local coverListSelf = self.casterEntity:GetCoverAreaList(self._lastPos)
  for i = 1, #coverList do
    local posWork = coverList[i]
    if not table.icontains(coverListSelf, posWork) and boardServiceLogic:IsPosBlock(posWork, blockFlag) then
      return false
    end
  end
  return true
end

function SkillEffectCalc_PetTrapMove:ComputeWalkRange(centerPos, nWalkStep, bFilter)
  bFilter = bFilter or false
  local cbFilter
  if bFilter then
    cbFilter = Callback:New(1, self.IsPosAccessible, self)
  end
  return ComputeScopeRange.ComputeRange_WalkMathPos(centerPos, 1, nWalkStep, cbFilter)
end

function SkillEffectCalc_PetTrapMove:FindNewWalkPos(walkRange, posCenter, posDef)
  return self:FindPosByNearCenter(walkRange, posCenter, posDef, 1)
end

function SkillEffectCalc_PetTrapMove:FindPosByNearCenter(listPlanPos, posCenter, posDef, nCheckStep)
  if nil == listPlanPos or table.count(listPlanPos) <= 0 then
    return posDef
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local listWalk = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
  listWalk:AllowDuplicate()
  local lastMovePos = self._lastPos
  for i = 1, #listPlanPos do
    local posData = listPlanPos[i]
    local posWalk = posData:GetPos()
    if posWalk ~= posDef and (nil == nCheckStep or nCheckStep == posData:GetStep()) then
      local isBlockMoveWithTrapWall = utilDataSvc:IsBlockMoveWithTrapWall(posDef, posWalk, self.casterEntity)
      if posWalk ~= lastMovePos and isBlockMoveWithTrapWall == false then
        AINewNode.InsertSortedArray(listWalk, posCenter, posWalk, i)
      else
      end
    end
  end
  return self:FindPosValid(listWalk, posDef)
end

function SkillEffectCalc_PetTrapMove:ComputeSkillRange(skillID, centerPos, bodyArea, dir)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local scopeType = skillConfigData:GetSkillScopeType()
  if scopeType == SkillScopeType.DirectLineExpand then
    local ret1 = self:_ComputeSkillRange(skillID, centerPos, bodyArea, Vector2(0, 1))
    local ret2 = self:_ComputeSkillRange(skillID, centerPos, bodyArea, Vector2(0, -1))
    local ret3 = self:_ComputeSkillRange(skillID, centerPos, bodyArea, Vector2(1, 0))
    local ret4 = self:_ComputeSkillRange(skillID, centerPos, bodyArea, Vector2(-1, 0))
    local ret = {}
    table.appendArray(ret, ret1)
    table.appendArray(ret, ret2)
    table.appendArray(ret, ret3)
    table.appendArray(ret, ret4)
    return ret
  else
    return self:_ComputeSkillRange(skillID, centerPos, bodyArea, dir)
  end
end

function SkillEffectCalc_PetTrapMove:_ComputeSkillRange(nSkillID, posCenter, bodyArea, dir)
  if nSkillID == 0 then
    return {}
  end
  local workCenter = posCenter
  if 4 == #bodyArea then
    workCenter = workCenter + Vector2(-1, -1)
  elseif 9 == #bodyArea then
    workCenter = workCenter + Vector2(-2, -2)
  end
  return self:CalculateSkillRange(nSkillID, workCenter, dir, bodyArea)
end

function SkillEffectCalc_PetTrapMove:CalculateSkillRange(skillID, centerPos, dir, bodyAreaList)
  local skillResult = self:_CalculateSkillScope(skillID, centerPos, dir, bodyAreaList)
  if not skillResult then
    return {}
  end
  local skillRange = skillResult:GetAttackRange()
  local listReturn = {}
  for i = 1, #skillRange do
    local posWork = skillRange[i]
    if false == table.icontains(listReturn, posWork) then
      table.insert(listReturn, posWork)
    end
  end
  return listReturn
end

function SkillEffectCalc_PetTrapMove:_CalculateSkillScope(skillID, centerPos, dir, bodyAreaList, entityCaster)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = utilScopeSvc:GetSkillScopeCalc()
  dir = dir or Vector2(0, 1)
  local skillResult = skillCalculater:CalcSkillScope(skillConfigData, centerPos, dir, bodyAreaList, entityCaster)
  return skillResult
end
