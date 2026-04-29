_class("SkillEffectCalc_MonsterMoveGridToSkillRangeFar", Object)
SkillEffectCalc_MonsterMoveGridToSkillRangeFar = SkillEffectCalc_MonsterMoveGridToSkillRangeFar

function SkillEffectCalc_MonsterMoveGridToSkillRangeFar:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_MonsterMoveGridToSkillRangeFar:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillParam = skillEffectCalcParam:GetSkillEffectParam()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local targetIDList = skillEffectCalcParam:GetTargetEntityIDs()
  local targetID = false
  if table.count(targetIDList) >= 1 then
    targetID = targetIDList[1]
  end
  if not targetID or targetID == -1 then
    Log.fatal("Need Target SkillID", skillEffectCalcParam:GetSkillID())
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local sBoard = self._world:GetService("BoardLogic")
  local preferElement = skillParam:GetPreferElement()
  local checkSkillID = skillParam:GetCheckSkillID()
  local targetEntity = self._world:GetEntityByID(targetID)
  local movePath = {}
  if not targetEntity:HasDeadMark() then
    movePath = self:CalMovPath(casterEntity, targetEntity, preferElement, checkSkillID)
  end
  local isCasterDead = false
  local posWalkResultList = {}
  if #movePath ~= 0 then
    local oldPosList = {}
    for i, pos in ipairs(movePath) do
      local posSelf = casterEntity:GetGridPosition()
      local walkRes = MonsterMoveSkillRangeFarResult:New()
      sBoard:UpdateEntityBlockFlag(casterEntity, posSelf, pos)
      casterEntity:SetGridPosition(pos)
      casterEntity:SetGridDirection(pos - posSelf)
      local entityID = casterEntity:GetID()
      table.insert(posWalkResultList, walkRes)
      walkRes:SetWalkPos(pos)
      self:_OnArrivePos(casterEntity, walkRes, skillParam)
      table.insert(oldPosList, pos)
      if casterEntity:HasDeadMark() then
        isCasterDead = true
        break
      end
    end
  end
  local result = SkillEffectMonsterMoveGridToSkillRangeFarResult:New(posWalkResultList, isCasterDead)
  return {result}
end

function SkillEffectCalc_MonsterMoveGridToSkillRangeFar:_OnArrivePos(casterEntity, walkRes, skillParam)
  local skillLogicSvc = self._world:GetService("SkillLogic")
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local pos = casterEntity:GetGridPosition()
  local listTrapWork, listTrapResult = trapServiceLogic:TriggerTrapByEntity(casterEntity, TrapTriggerOrigin.Move)
  for i, e in ipairs(listTrapWork) do
    local trapEntity = e
    local skillEffectResultContainer = listTrapResult[i]
    local aiResult = AISkillResult:New()
    aiResult:SetResultContainer(skillEffectResultContainer)
    walkRes:AddWalkTrap(trapEntity:GetID(), aiResult)
  end
  local flushTrapIDs = skillParam:GetFlushTrapIDs()
  local utilSvc = self._world:GetService("UtilData")
  local array = utilSvc:GetTrapsAtPos(pos)
  for _, eTrap in ipairs(array) do
    if eTrap then
      local trapIDCmpt = eTrap:TrapID()
      if flushTrapIDs[trapIDCmpt:GetTrapID()] then
        eTrap:Attributes():Modify("HP", 0)
        trapServiceLogic:AddTrapDeadMark(eTrap, skillParam:GetDisableDieSkill())
        walkRes:SetFlushTrapID(eTrap:GetID())
      end
    end
  end
end

function SkillEffectCalc_MonsterMoveGridToSkillRangeFar:CalMovPath(casterEntity, targetEntity, preferElement, checkSkillID)
  local targetCenterPos = targetEntity:GetGridPosition()
  local casterPos = casterEntity:GetGridPosition()
  local bodyAreaCmpt = targetEntity:BodyArea()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local posCanLink = utilCalcSvc:MonsterFindAllPosCanLink(casterPos)
  local skillRange = self:ComputeSkillRange(checkSkillID, targetCenterPos, bodyAreaCmpt:GetArea())
  local validSkillRange = self:FilterSkillRangePos(skillRange, posCanLink)
  local tarMovePos
  if 0 < #validSkillRange then
    tarMovePos = self:FindFarestPosToTarget(targetCenterPos, validSkillRange, preferElement)
  else
    tarMovePos = self:FindNearestPosToTarget(targetCenterPos, posCanLink, preferElement)
  end
  local movPath = {}
  if tarMovePos then
    local utilCalcSvc = self._world:GetService("UtilCalc")
    local board = self._world:GetBoardEntity():Board()
    local pieceType = board:GetPieceType(tarMovePos)
    if pieceType == PieceType.Any then
      movPath = utilCalcSvc:GetMonster2PosByLink(casterPos, tarMovePos, preferElement)
      if movPath and 0 < #movPath then
      else
        for checkPieceType = PieceType.Blue, PieceType.Yellow do
          if checkPieceType ~= preferElement then
            movPath = utilCalcSvc:GetMonster2PosByLink(casterPos, tarMovePos, preferElement)
            if movPath and 0 < #movPath then
              break
            end
          end
        end
      end
    else
      movPath = utilCalcSvc:GetMonster2PosByLink(casterPos, tarMovePos, pieceType)
    end
  end
  return movPath
end

function SkillEffectCalc_MonsterMoveGridToSkillRangeFar:ComputeSkillRange(skillID, centerPos, bodyArea, dir)
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

function SkillEffectCalc_MonsterMoveGridToSkillRangeFar:_ComputeSkillRange(nSkillID, posCenter, bodyArea, dir)
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

function SkillEffectCalc_MonsterMoveGridToSkillRangeFar:CalculateSkillRange(skillID, centerPos, dir, bodyAreaList)
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

function SkillEffectCalc_MonsterMoveGridToSkillRangeFar:_CalculateSkillScope(skillID, centerPos, dir, bodyAreaList, entityCaster)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = utilScopeSvc:GetSkillScopeCalc()
  dir = dir or Vector2(0, 1)
  local skillResult = skillCalculater:CalcSkillScope(skillConfigData, centerPos, dir, bodyAreaList, entityCaster)
  return skillResult
end

function SkillEffectCalc_MonsterMoveGridToSkillRangeFar:FilterSkillRangePos(skillRange, posCanLink)
  local retRange = {}
  for _, pos in ipairs(skillRange) do
    local posIndex = Vector2.Pos2Index(pos)
    if posCanLink[posIndex] then
      table.insert(retRange, pos)
    end
  end
  return retRange
end

function SkillEffectCalc_MonsterMoveGridToSkillRangeFar:FindFarestPosToTarget(targetCenterPos, validRange, preferElement)
  local posReturn
  local board = self._world:GetBoardEntity():Board()
  local posListFarTarget = SortedArray:New(Algorithm.COMPARE_CUSTOM, SortByDistanceAndPreferElement._ComparerByFarWithElement)
  posListFarTarget:AllowDuplicate()
  posListFarTarget:Clear()
  for index, validPos in ipairs(validRange) do
    local pieceType = board:GetPieceType(validPos)
    local elementVal = 0
    if pieceType and pieceType == preferElement then
      elementVal = 1
    end
    self:InsertSortedArray(posListFarTarget, targetCenterPos, validPos, index, elementVal)
  end
  if posListFarTarget and 0 < posListFarTarget:Size() then
    local sortData = posListFarTarget:GetAt(1)
    posReturn = sortData.data
  end
  return posReturn
end

function SkillEffectCalc_MonsterMoveGridToSkillRangeFar:FindNearestPosToTarget(targetCenterPos, validRange, preferElement)
  local posReturn
  local board = self._world:GetBoardEntity():Board()
  local posListFarTarget = SortedArray:New(Algorithm.COMPARE_CUSTOM, SortByDistanceAndPreferElement._ComparerByNearWithElement)
  posListFarTarget:AllowDuplicate()
  posListFarTarget:Clear()
  for index, validPos in ipairs(validRange) do
    local pieceType = board:GetPieceType(validPos)
    local elementVal = 0
    if pieceType and pieceType == preferElement then
      elementVal = 1
    end
    self:InsertSortedArray(posListFarTarget, targetCenterPos, validPos, index, elementVal)
  end
  if posListFarTarget and 0 < posListFarTarget:Size() then
    local sortData = posListFarTarget:GetAt(1)
    posReturn = sortData.data
  end
  return posReturn
end

function SkillEffectCalc_MonsterMoveGridToSkillRangeFar:InsertSortedArray(sortedArray, centerPos, workPos, nIndex, elementVal)
  local posData = SortByDistanceAndPreferElement:New(centerPos, workPos, nIndex, elementVal)
  sortedArray:Insert(posData)
end

_class("SortByDistanceAndPreferElement", Object)
SortByDistanceAndPreferElement = SortByDistanceAndPreferElement

function SortByDistanceAndPreferElement:Constructor(centrePos, dataPos, nIndex, elementVal)
  self.centre = centrePos
  self.data = dataPos
  self.m_nIndex = nIndex or 0
  self.m_elementVal = elementVal or 0
  self.m_nDistance = self:Distance()
end

function SortByDistanceAndPreferElement:GetDistance()
  return self.m_nDistance
end

function SortByDistanceAndPreferElement:GetElementVal()
  return self.m_elementVal
end

function SortByDistanceAndPreferElement:GetPosData()
  return self.data
end

function SortByDistanceAndPreferElement:Distance()
  return GameHelper.ComputeLogicDistance(self.centre, self.data)
end

function SortByDistanceAndPreferElement._ComparerByFarWithElement(dataA, dataB)
  local nDistanceA = dataA:GetDistance()
  local nDistanceB = dataB:GetDistance()
  if nDistanceA > nDistanceB then
    return 1
  elseif nDistanceA < nDistanceB then
    return -1
  else
    local nEleValA = dataA:GetElementVal()
    local nEleValB = dataB:GetElementVal()
    if nEleValA > nEleValB then
      return 1
    elseif nEleValA < nEleValB then
      return -1
    else
      return dataB.m_nIndex - dataA.m_nIndex
    end
  end
end

function SortByDistanceAndPreferElement._ComparerByNearWithElement(dataA, dataB)
  local nDistanceA = dataA:GetDistance()
  local nDistanceB = dataB:GetDistance()
  if nDistanceA > nDistanceB then
    return -1
  elseif nDistanceA < nDistanceB then
    return 1
  else
    local nEleValA = dataA:GetElementVal()
    local nEleValB = dataB:GetElementVal()
    if nEleValA > nEleValB then
      return 1
    elseif nEleValA < nEleValB then
      return -1
    else
      return dataB.m_nIndex - dataA.m_nIndex
    end
  end
end
