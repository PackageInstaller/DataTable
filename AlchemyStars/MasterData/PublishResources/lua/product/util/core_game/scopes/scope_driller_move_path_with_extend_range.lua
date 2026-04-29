require("scope_base")
_class("SkillScopeCalculator_DrillerMovePathWithExtendRange", SkillScopeCalculator_Base)
SkillScopeCalculator_DrillerMovePathWithExtendRange = SkillScopeCalculator_DrillerMovePathWithExtendRange

function SkillScopeCalculator_DrillerMovePathWithExtendRange:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._hub._gridFilter._world
  self._world = world
  self.casterEntity = casterEntity
  self.m_entityOwn = casterEntity
  local moveStep = scopeParam.moveStep or 4
  self._trapIDList = scopeParam.trapIDList
  local posWalkList = {}
  posWalkList = self:CalMoveResultList(casterEntity, moveStep)
  local totalPosList = {}
  table.appendArray(totalPosList, posWalkList)
  local calc = SkillScopeCalculator:New(self._hub._gridFilter)
  local extendScopeParam = scopeParam.extendScope or {
    scopeType = 1,
    scopeParam = {
      1,
      1,
      0
    }
  }
  if extendScopeParam then
    local scopeType = extendScopeParam.scopeType
    local scpoeParam = extendScopeParam.scopeParam
    for index, walkPos in ipairs(posWalkList) do
      local transCenterPos = walkPos
      local result = calc:ComputeScopeRange(scopeType, scpoeParam, transCenterPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
      local extendRange = result:GetAttackRange()
      for extendIndex, extendPos in ipairs(extendRange) do
        if not table.icontains(totalPosList, extendPos) then
          table.insert(totalPosList, extendPos)
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.DrillerMovePathWithExtendRange, centerPos, posWalkList, totalPosList)
  return result
end

function SkillScopeCalculator_DrillerMovePathWithExtendRange:CalMoveResultList(casterEntity, moveStep)
  local casterPos = casterEntity:GetGridPosition()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local sBoard = self._world:GetService("BoardLogic")
  self._tarPos = self:FindNewTargetPos(casterPos)
  self._lastPos = casterPos
  local posWalkList = {}
  table.insert(posWalkList, casterPos)
  for i = 1, moveStep do
    local posWalk = self:_CalcMovePos(casterEntity, moveStep - i + 1, self._lastPos)
    local aiRecorderCmpt = self._world:GetBoardEntity():AIRecorder()
    if posWalk ~= nil then
      self._lastPos = posWalk
      table.insert(posWalkList, posWalk)
    end
  end
  return posWalkList
end

function SkillScopeCalculator_DrillerMovePathWithExtendRange:_CalcMovePos(entityWork, nWalkTotal, curPos)
  local posSelf = curPos
  local posTarget = self._tarPos
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

function SkillScopeCalculator_DrillerMovePathWithExtendRange:FindNewTargetPos(curPos)
  local tarTrapIDList = self._trapIDList
  local posSelf = curPos
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local blockFlag = boardServiceLogic:GetEntityMoveBlockFlag(self.m_entityOwn)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  local scopeCalc = SkillScopeCalculator_DrillerMoveTargetPos:New(skillCalculater)
  local scopeResult = scopeCalc:CalcRange(SkillScopeType.DrillerMoveTargetPos, {trapIDList = tarTrapIDList}, posSelf, self.m_entityOwn:BodyArea():GetArea(), self.m_entityOwn:GetGridDirection(), SkillTargetType.Board, posSelf, self.m_entityOwn)
  local tarPos = posSelf
  local range = scopeResult:GetAttackRange()
  if range and 0 < #range then
    tarPos = range[1]
  end
  return tarPos
end

function SkillScopeCalculator_DrillerMovePathWithExtendRange:ComputeWalkRange(centerPos, nWalkStep, bFilter)
  bFilter = bFilter or false
  local cbFilter
  if bFilter then
    cbFilter = Callback:New(1, self.IsPosAccessible, self)
  end
  return ComputeScopeRange.ComputeRange_WalkMathPos(centerPos, 1, nWalkStep, cbFilter)
end

function SkillScopeCalculator_DrillerMovePathWithExtendRange:FindNewWalkPos(walkRange, posCenter, posDef)
  return self:FindPosByNearCenter(walkRange, posCenter, posDef, 1)
end

function SkillScopeCalculator_DrillerMovePathWithExtendRange:FindPosByNearCenter(listPlanPos, posCenter, posDef, nCheckStep)
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

function SkillScopeCalculator_DrillerMovePathWithExtendRange:FindPosValid(planPosList, defPos)
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

function SkillScopeCalculator_DrillerMovePathWithExtendRange:IsPosAccessible(pos)
  if false == self.casterEntity:HasBodyArea() then
    return true
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local monsterIDCmpt = self.casterEntity:MonsterID()
  local nMonsterBlockData = monsterIDCmpt:GetMonsterBlockData()
  local coverList = self.casterEntity:GetCoverAreaList(pos)
  local coverListSelf = self.casterEntity:GetCoverAreaList(self.casterEntity:GetGridPosition())
  for i = 1, #coverList do
    local posWork = coverList[i]
    if not table.icontains(coverListSelf, posWork) and boardServiceLogic:IsPosBlock(posWork, nMonsterBlockData) then
      return false
    end
  end
  return true
end
