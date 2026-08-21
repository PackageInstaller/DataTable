_class("SkillEffectCalc_MonsterMoveFrontAttack", Object)
SkillEffectCalc_MonsterMoveFrontAttack = SkillEffectCalc_MonsterMoveFrontAttack

function SkillEffectCalc_MonsterMoveFrontAttack:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self.m_nextPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
  self.m_nextPosList:AllowDuplicate()
end

function SkillEffectCalc_MonsterMoveFrontAttack:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillParam = skillEffectCalcParam:GetSkillEffectParam()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  self.casterEntity = casterEntity
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
  local checkSkillID = skillParam:GetCheckSkillID()
  local moveStep = skillParam:GetMoveStep()
  local asAIMove = skillParam:IsAIMove()
  local targetEntity = self._world:GetEntityByID(targetID)
  local posWalkResultList = {}
  local isCasterDead = false
  if not targetEntity:HasDeadMark() then
    posWalkResultList, isCasterDead = self:CalMoveResultList(casterEntity, targetEntity, checkSkillID, moveStep, asAIMove)
  end
  local result = SkillEffectMonsterMoveFrontAttackResult:New(posWalkResultList, isCasterDead)
  return {result}
end

function SkillEffectCalc_MonsterMoveFrontAttack:_OnArrivePos(casterEntity, walkRes, skillParam)
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

function SkillEffectCalc_MonsterMoveFrontAttack:CalMoveResultList(casterEntity, targetEntity, checkSkillID, moveStep, asAIMove)
  local targetCenterPos = targetEntity:GetGridPosition()
  local casterPos = casterEntity:GetGridPosition()
  local bodyAreaCmpt = targetEntity:BodyArea()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local sBoard = self._world:GetService("BoardLogic")
  local listPosTarget = {targetCenterPos}
  self.m_nextPosList:Clear()
  for _, targetPos in ipairs(listPosTarget) do
    local walkRange = self:_ComputeSkillRange(checkSkillID, targetPos, bodyAreaCmpt:GetArea())
    for i = 1, #walkRange do
      local posWork = walkRange[i]
      if self:IsPosAccessible(posWork) then
        AINewNode.InsertSortedArray(self.m_nextPosList, casterPos, posWork, i)
      end
    end
  end
  self._lastPos = casterPos
  local isCasterDead = false
  local posWalkResultList = {}
  for i = 1, moveStep do
    local posWalk = self:_CalcMovePos(casterEntity, moveStep - i + 1)
    local aiRecorderCmpt = self._world:GetBoardEntity():AIRecorder()
    local walkRes = MonsterMoveFrontAttackResult:New()
    if posWalk ~= nil then
      local posSelf = casterEntity:GetGridPosition()
      sBoard:UpdateEntityBlockFlag(casterEntity, posSelf, posWalk)
      casterEntity:SetGridPosition(posWalk)
      casterEntity:SetGridDirection(posWalk - posSelf)
      local nt = NTMonsterSkillMoved:New(casterEntity, posWalk, self._lastPos)
      self._world:GetService("Trigger"):Notify(nt)
      self._lastPos = posWalk
      local entityID = casterEntity:GetID()
      table.insert(posWalkResultList, walkRes)
      walkRes:SetWalkPos(posWalk)
      if asAIMove then
        aiRecorderCmpt:AddWalkResult(entityID, walkRes)
      end
      self:_OnArrivePos(casterEntity, walkRes)
      if casterEntity:HasDeadMark() then
        isCasterDead = true
        break
      end
    end
  end
  return posWalkResultList, isCasterDead
end

function SkillEffectCalc_MonsterMoveFrontAttack:_CalcMovePos(entityWork, nWalkTotal)
  local posSelf = entityWork:GridLocation().Position
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

function SkillEffectCalc_MonsterMoveFrontAttack:FindNewTargetPos(posDefault)
  return self:FindPosValid(self.m_nextPosList, posDefault)
end

function SkillEffectCalc_MonsterMoveFrontAttack:FindPosValid(planPosList, defPos)
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

function SkillEffectCalc_MonsterMoveFrontAttack:IsPosAccessible(pos)
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

function SkillEffectCalc_MonsterMoveFrontAttack:ComputeWalkRange(centerPos, nWalkStep, bFilter)
  bFilter = bFilter or false
  local cbFilter
  if bFilter then
    cbFilter = Callback:New(1, self.IsPosAccessible, self)
  end
  return ComputeScopeRange.ComputeRange_WalkMathPos(centerPos, 1, nWalkStep, cbFilter)
end

function SkillEffectCalc_MonsterMoveFrontAttack:FindNewWalkPos(walkRange, posCenter, posDef)
  return self:FindPosByNearCenter(walkRange, posCenter, posDef, 1)
end

function SkillEffectCalc_MonsterMoveFrontAttack:FindPosByNearCenter(listPlanPos, posCenter, posDef, nCheckStep)
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

function SkillEffectCalc_MonsterMoveFrontAttack:ComputeSkillRange(skillID, centerPos, bodyArea, dir)
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

function SkillEffectCalc_MonsterMoveFrontAttack:_ComputeSkillRange(nSkillID, posCenter, bodyArea, dir)
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

function SkillEffectCalc_MonsterMoveFrontAttack:CalculateSkillRange(skillID, centerPos, dir, bodyAreaList)
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

function SkillEffectCalc_MonsterMoveFrontAttack:_CalculateSkillScope(skillID, centerPos, dir, bodyAreaList, entityCaster)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = utilScopeSvc:GetSkillScopeCalc()
  dir = dir or Vector2(0, 1)
  local skillResult = skillCalculater:CalcSkillScope(skillConfigData, centerPos, dir, bodyAreaList, entityCaster)
  return skillResult
end
