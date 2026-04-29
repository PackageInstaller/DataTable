_class("BuffLogicRide", BuffLogicBase)
BuffLogicRide = BuffLogicRide

function BuffLogicRide:Constructor(buffInstance, logicParam)
  self._trapID = logicParam.trapID
  self._trapHeight = logicParam.trapHeight
  self._monsterClassID = logicParam.monsterClassID
  self._monsterHeight = logicParam.monsterHeight
  self._monsterOffset = Vector2.zero
  if logicParam.offset and #logicParam.offset == 2 then
    self._monsterOffset = Vector2(logicParam.offset[1], logicParam.offset[2])
  end
  self._changeBodyArea = logicParam.changeBodyArea == nil and true or logicParam.changeBodyArea
  self._onlyRiderCanClick = logicParam.onlyRiderCanClick == nil and true or logicParam.onlyRiderCanClick
  self._targetType = logicParam.targetType
  self._targetTypeParam = logicParam._targetTypeParam
  self._scopeType = logicParam.scopeType
  self._scopeTypeParam = logicParam.scopeTypeParam
end

function BuffLogicRide:DoLogic(notify)
  local entity = self._buffInstance:Entity()
  if not entity then
    return
  end
  local pos = entity:GetGridPosition()
  local dir = entity:GetGridDirection()
  local bodyArea = entity:BodyArea():GetArea()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalc = utilScopeSvc:GetSkillScopeCalc()
  local skillScopeResult = skillCalc:ComputeScopeRange(self._scopeType, self._scopeTypeParam, pos, bodyArea, dir, self._targetType, pos, entity)
  local targetEntityIDList = utilScopeSvc:SelectSkillTarget(entity, self._targetType, skillScopeResult, nil, self._targetTypeParam)
  local entityID = self:IsMonsterInTargetList(targetEntityIDList)
  if entityID then
    return self:CalcRide(notify, entity, entityID, true)
  end
  entityID = self:IsTrapInTargetList(pos, targetEntityIDList)
  if entityID then
    return self:CalcRide(notify, entity, entityID, false)
  end
  local targetPos = self:CalcTargetPos(entity)
  if not targetPos then
    return
  end
  return self:CalcRide(notify, entity, nil, false, targetPos)
end

function BuffLogicRide:IsMonsterInTargetList(targetEntityIDList)
  for _, entityID in ipairs(targetEntityIDList) do
    local entity = self._world:GetEntityByID(entityID)
    if entity:HasMonsterID() and entity:MonsterID():GetMonsterClassID() == self._monsterClassID then
      local buffCmpt = entity:BuffComponent()
      if buffCmpt and not buffCmpt:HasBuffEffect(BuffEffectType.Palsy) then
        return entityID
      end
    end
  end
end

function BuffLogicRide:IsTrapInTargetList(casterPos, targetEntityIDList)
  local trapPosList = {}
  for _, trapID in ipairs(targetEntityIDList) do
    local entity = self._world:GetEntityByID(trapID)
    if entity:HasTrapID() and entity:TrapID():GetTrapID() == self._trapID and not entity:HasDeadMark() then
      local trapPos = entity:GetGridPosition()
      table.insert(trapPosList, trapPos)
    end
  end
  if #trapPosList == 0 then
    return
  end
  HelperProxy:SortPosByCenterPosDistance(casterPos, trapPosList)
  local trapPos = trapPosList[1]
  local boardCmpt = self._world:GetBoardEntity():Board()
  local es = boardCmpt:GetPieceEntities(trapPos, function(e)
    return e:HasTrapID() and e:TrapID():GetTrapID() == self._trapID
  end)
  if 0 < #es then
    local trapEntity = es[1]
    return trapEntity:GetID()
  end
end

function BuffLogicRide:CalcTargetPos(entity)
  if not entity:HasRide() then
    return
  end
  local rideCmpt = entity:Ride()
  local mountID = rideCmpt:GetMountID()
  local mountEntity = self._world:GetEntityByID(mountID)
  if not mountEntity then
    return
  end
  if mountEntity:HasTrap() then
    return mountEntity:GetGridPosition()
  end
  local pos = mountEntity:GetGridPosition()
  local bodyArea = mountEntity:BodyArea():GetArea()
  local utilData = self._world:GetService("UtilData")
  local validPosList = {}
  local crossList = ComputeScopeRange.ComputeRange_CrossScope(pos, #bodyArea, 1)
  for _, value in ipairs(crossList) do
    if not utilData:IsPosBlock(value, BlockFlag.MonsterLand) then
      table.insert(validPosList, value)
    end
  end
  local ringCount = 1
  while #validPosList == 0 and ringCount < 3 do
    local ringList = ComputeScopeRange.ComputeRange_SquareRing(pos, #bodyArea, ringCount)
    for _, value in ipairs(ringList) do
      if not utilData:IsPosBlock(value, BlockFlag.MonsterLand) then
        table.insert(validPosList, value)
      end
    end
    ringCount = ringCount + 1
  end
  if #validPosList == 0 then
    return
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  HelperProxy:SortPosByCenterPosDistance(teamPos, validPosList)
  return validPosList[#validPosList]
end

function BuffLogicRide:CalcRide(notify, entity, mountID, isMonster, targetPos)
  local rideSvc = self._world:GetService("RideLogic")
  local fromTrap = false
  if entity:HasRide() then
    local rideCmpt = entity:Ride()
    local oriMountID = rideCmpt:GetMountID()
    local oriMountEntity = self._world:GetEntityByID(oriMountID)
    if oriMountEntity:HasTrap() then
      fromTrap = true
    end
    rideSvc:RemoveRide(entity:GetID(), oriMountID)
  end
  rideSvc:ResetBodyArea(entity)
  if mountID then
    if isMonster then
      rideSvc:ReplaceRide(entity:GetID(), mountID, self._monsterHeight, self._monsterOffset, self._changeBodyArea, self._onlyRiderCanClick)
    else
      rideSvc:ReplaceRide(entity:GetID(), mountID, self._trapHeight)
    end
  else
    rideSvc:SetNoRidePos(entity:GetID(), targetPos, fromTrap)
  end
  local gridLocCmpt = entity:GridLocation()
  local gridLocRes = DataGridLocationResult:New()
  gridLocRes:SetGridLocResultBornPos(gridLocCmpt:GetGridPos())
  gridLocRes:SetGridLocResultBornDir(gridLocCmpt:GetGridDir())
  gridLocRes:SetGridLocResultBornHeight(gridLocCmpt:GetGridLocHeight())
  gridLocRes:SetGridLocResultBornOffset(gridLocCmpt:GetGridOffset())
  gridLocRes:SetGridLocResultDamageOffset(gridLocCmpt:GetDamageOffset())
  local buffResult = BuffResultRide:New(entity:GetID(), mountID, gridLocRes)
  if notify.GetNotifyEntity then
    buffResult:SetNotifyEntity(notify:GetNotifyEntity())
  end
  if notify.GetChainSkillTimeIndex then
    buffResult:SetNotifyChainSkillTimeIndex(notify:GetChainSkillTimeIndex())
  end
  if notify.GetChainSkillStageIndex then
    buffResult:SetNotifyChainSkillStageIndex(notify:GetChainSkillStageIndex())
  end
  if notify.GetAttackPos and notify.GetTargetPos then
    buffResult:SetNotifyPos(notify:GetAttackPos())
    buffResult:SetTargetPos(notify:GetTargetPos())
  end
  return buffResult
end
