_class("AIComponentNew", Object)
AIComponentNew = AIComponentNew
AIMoveState = {
  NotMove = 1,
  Moving = 2,
  MoveEnd = 3
}

function AIComponentNew:Constructor()
  self.m_logicList = {}
  self.m_rootLogic = nil
  self.m_logicPreview = nil
  self.m_nMonsterID = 0
  self.m_nMobilityConfig = 0
  self.m_nMobilityTotal = 0
  self.m_listMoveTarget = ArrayList:New()
  self._targetEntity = nil
  self.m_world = nil
  self.m_nStatus = AINewNodeStatus.Ready
  self._runtimeData = {}
  self.canMove = true
  self.canTurn = true
  self.m_cutLogic = nil
  self.m_lastMovePos = nil
  self._ownerEntity = nil
  self._skillScopeResult = {}
  self.m_nCreateRound = 0
  self.m_nSelectSkillID = 0
  self._moveState = AIMoveState.NotMove
  self._treeState = 1
  self._isAIRoundEnd = false
  self._targetTeamEntity = nil
  self._aiTargetType = AITargetType.Normal
  self._aiRunCount = {}
  self._treeContext = {}
  self._hasAntiSkill = false
end

function AIComponentNew:AddAIRoundRunCount(aiConfigID)
  if not self._aiRunCount[aiConfigID] then
    self._aiRunCount[aiConfigID] = 0
  end
  self._aiRunCount[aiConfigID] = self._aiRunCount[aiConfigID] + 1
end

function AIComponentNew:ClearAIRoundRunCount()
  self._aiRunCount = {}
end

function AIComponentNew:GetAIRoundRunCount(aiConfigID)
  return self._aiRunCount[aiConfigID] or 0
end

function AIComponentNew:GetMoveState()
  return self._moveState
end

function AIComponentNew:SetMoveState(st)
  if self._moveState == st then
    return
  end
  self._moveState = st
end

function AIComponentNew:GetSelectSkillID()
  return self.m_nSelectSkillID
end

function AIComponentNew:SetSelectSkillID(nSkillID)
  local _id = tonumber(nSkillID)
  if not _id then
    Log.exception(self._className, "Cannot select a non-number skill id: ", nSkillID)
    return
  end
  self.m_nSelectSkillID = nSkillID
end

function AIComponentNew:GetCutLogic()
  return self.m_cutLogic
end

function AIComponentNew:SetCutLogic(pLogic)
  self.m_cutLogic = pLogic
end

function AIComponentNew:ExchangeOnceLogic(nLogicType)
  local pLogicOld = self.m_logicList[nLogicType]
  self.m_logicList[nLogicType] = self.m_cutLogic
  self.m_cutLogic = pLogicOld
  if nLogicType == AILogicPeriodType.Main then
    self:SetPreviewLogic(nLogicType, AILogicOrderType.BaseOrder)
  end
end

function AIComponentNew:AddLogic(aiLogicPeriodType, logic, order)
  local periodAIList = self.m_logicList[aiLogicPeriodType]
  if periodAIList == nil then
    self.m_logicList[aiLogicPeriodType] = {}
    periodAIList = self.m_logicList[aiLogicPeriodType]
  end
  local logicOrder = order or AILogicOrderType.BaseOrder
  periodAIList[logicOrder] = logic
  if logic then
    logic:SetMyOrder(logicOrder)
    logic:SetActive(false)
    self._treeContext[logic.InstanceID] = {}
  end
end

function AIComponentNew:GetAILogicOrders(aiLogicPeriodType)
  local periodAIList = self.m_logicList[aiLogicPeriodType]
  local orderList = {}
  if periodAIList then
    for key, _ in pairs(periodAIList) do
      orderList[#orderList + 1] = key
    end
  end
  return orderList
end

function AIComponentNew:GetAILogic(aiLogicPeriodType)
  return self.m_logicList[aiLogicPeriodType] or {}
end

function AIComponentNew:SelectLogic(logicType, order)
  order = order or AILogicOrderType.BaseOrder
  local aiLogic = self:_FindLogic(logicType, order)
  if aiLogic then
    self.m_rootLogic = aiLogic
    self:SetRunningSign(logicType, order)
  end
end

function AIComponentNew:_FindLogic(nLogicType, nOrder)
  local periodLogic = self.m_logicList[nLogicType]
  if not periodLogic then
    return
  end
  local logic = periodLogic[nOrder]
  return logic
end

function AIComponentNew:_SetActive(bActive)
  if self.m_rootLogic then
    self.m_rootLogic:SetActive(bActive)
  end
end

function AIComponentNew:OnEvent_EnableAiLogic(entityWork, nLogicType, order)
  self:InitAiLogic(AINewNodeStatus.Ready, entityWork, nLogicType, order)
end

function AIComponentNew:OnEvent_DisableAiLogic(entityWork)
  self:_SetActive(false)
  self.m_rootLogic = nil
end

function AIComponentNew:GetRootLogicID()
  local nLogicID = 0
  if self.m_rootLogic then
    nLogicID = self.m_rootLogic:GetAILogicID()
  end
  return nLogicID
end

function AIComponentNew:ResetLogic()
  self.m_nStatus = AINewNodeStatus.Ready
  if self.m_rootLogic then
    self.m_rootLogic:Reset()
  end
end

function AIComponentNew:InitAiLogic(nStatus, monsterEntity, nLogicType, order)
  self.m_nStatus = nStatus
  self:SelectLogic(nLogicType, order)
  if self.m_rootLogic then
    self.m_rootLogic:Reset()
  end
  if self:IsLogicEnd() then
    self.m_nMobilityTotal = 0
  else
    self.m_nMobilityTotal = monsterEntity:Attributes():GetAIMobility()
  end
  self:OutLog("初始化行动力", " m_nMobilityTotal = ", self.m_nMobilityTotal)
  if self.m_nMobilityTotal <= 0 then
    self.m_nStatus = AINewNodeStatus.Success
    return
  end
  self._targetTeamEntity = self.m_world:Player():GetLocalTeamEntity()
  self._targetEntity = self._targetTeamEntity
  if self._aiTargetType == AITargetType.Normal then
    local trapGroup = self.m_world:GetGroup(self.m_world.BW_WEMatchers.Trap)
    for _, e in ipairs(trapGroup:GetEntities()) do
      local trapCmpt = e:Trap()
      local trapType = trapCmpt:GetTrapType()
      if trapType == TrapType.Protected then
        self._targetEntity = e
        break
      end
    end
  elseif self._aiTargetType == AITargetType.Team then
    self._targetEntity = self._targetTeamEntity
  end
  self:_SetActive(true)
  self:SetLastMovePos(nil)
  if self.m_world:MatchType() == MatchType.MT_Chess then
    self:SetMoveState(AIMoveState.MoveEnd)
  elseif monsterEntity:HasTrap() then
    self:SetMoveState(AIMoveState.MoveEnd)
  else
    self:SetMoveState(AIMoveState.NotMove)
  end
  self:SetAITreeState(1)
  self:SetAIRoundEnd(false)
end

function AIComponentNew:CalcBuffedMobility(mobility, e)
  if not e then
    return mobility
  end
  if e:BuffComponent():HasFlag(BuffFlags.Benumb) then
    return 1
  end
  local m = mobility
  local exMobility = e:Attributes():GetAttribute("ExAIMobility") or 0
  local accelerateRate = e:BuffComponent():GetBuffValue("AccelerateRate") or 0
  m = math.ceil(self.m_nMobilityConfig * (1 + accelerateRate)) + exMobility
  m = math.max(m, 0)
  return m
end

function AIComponentNew:Update(dt)
  if self:IsLogicEnd() then
    return
  end
  if self.m_rootLogic then
    self.m_nStatus = AINewNodeStatus.Running
    if self.m_rootLogic:IsEnableStart() then
      self.m_world:GetSyncLogger():Trace({
        key = "AIUpdateBegin",
        entityID = self._ownerEntity:GetID()
      })
      local aiConfigID = self.m_rootLogic:GetConfigAIID()
      self:AddAIRoundRunCount(aiConfigID)
      self.m_rootLogic:Update(dt)
      self.m_world:GetSyncLogger():Trace({
        key = "AIUpdateEnd",
        entityID = self._ownerEntity:GetID()
      })
    end
  end
end

function AIComponentNew:ReSelectWorkSkill()
  if self.m_rootLogic then
    self.m_rootLogic:ReSelectWorkSkill()
  end
end

function AIComponentNew:GetRootLogic()
  return self.m_rootLogic
end

function AIComponentNew:IsLogicEnd()
  if nil == self.m_rootLogic then
    return true
  end
  if self.m_nStatus == AINewNodeStatus.Success or self.m_nStatus == AINewNodeStatus.Failure then
    return true
  end
  return false
end

function AIComponentNew:SetComponentStatus(nStatus)
  self.m_nStatus = nStatus
end

function AIComponentNew:OutLog(stMsg)
  if not self.m_world then
    return
  end
  if not self.m_world:IsDevelopEnv() then
    return
  end
  local nType = 0
  local nID = 0
  if self.m_rootLogic then
    nID = self._entity:GetID()
    local cMonsterID = self._entity:MonsterID()
    if cMonsterID then
      nType = cMonsterID:GetMonsterID()
    end
  end
  local stMonster = ": Monster = [" .. nType .. "." .. nID .. "]"
  local stLogicID = ", AI_Config = " .. self:GetRootLogicID()
  local stMobility = ", nMobility  = " .. self.m_nMobilityTotal
  Log.debug("[AI], " .. stMsg .. stMonster .. stLogicID .. stMobility .. "|")
end

function AIComponentNew:OutErrorLog(stMsg)
  local nType = 0
  local nID = 0
  if self.m_rootLogic then
    nID = self._entity:GetID()
    local cMonsterID = self._entity:MonsterID()
    if cMonsterID then
      nType = cMonsterID:GetMonsterID()
    end
  end
  local stMonster = ": Monster = [" .. nType .. "." .. nID .. "]"
  local stLogicID = ", AI_Config = " .. self:GetRootLogicID()
  local posSelf = self._entity:GridLocation().Position
  local stMonsterPos = ", MonsterPosition = (" .. posSelf.x .. "," .. posSelf.y .. ")"
  Log.error("[AI], " .. stMsg .. stMonster .. stLogicID .. stMonsterPos)
end

function AIComponentNew:CostMobility(n)
  self.m_nMobilityTotal = self.m_nMobilityTotal - n
  return self.m_nMobilityTotal
end

function AIComponentNew:ClearMobilityTotal()
  self.m_nMobilityTotal = 0
end

function AIComponentNew:GetMobilityValid()
  return self.m_nMobilityTotal
end

function AIComponentNew:GetMobilityConfig()
  local m = self._ownerEntity:Attributes():GetAIMobility()
  return m
end

function AIComponentNew:SetMobilityTotal(mobility)
  self.m_nMobilityTotal = mobility
end

function AIComponentNew:GetAIOrderWeight()
  if nil == self.m_rootLogic then
    return 0
  end
  return self.m_rootLogic:GetOrderWeight()
end

function AIComponentNew:GetDistance()
  if nil == self.m_rootLogic then
    return 0
  end
  local posSlef = self.m_rootLogic:GetSelfPos()
  local posTarget = self:GetTargetPosCenter()
  local nDistance = (posSlef.x - posTarget.x) * (posSlef.x - posTarget.x) + (posSlef.y - posTarget.y) * (posSlef.y - posTarget.y)
  return nDistance
end

function AIComponentNew:GetTargetPosCenter()
  local entityWork = self:GetTargetEntity()
  return entityWork:GridLocation():Center()
end

function AIComponentNew:GetTargetPos()
  local entityWork = self:GetTargetEntity()
  local curPosCenter = self._entity:GridLocation():Center()
  if entityWork then
    local targetPos = entityWork:GetGridPosition()
    local gridPos = entityWork:GridLocation():GetGridPos()
    local bodyArea = entityWork:BodyArea():GetArea()
    local lastDistance = 9
    for i, area in ipairs(bodyArea) do
      local posWork = gridPos + area
      local distance = Vector2.Distance(curPosCenter, posWork)
      if lastDistance > distance then
        lastDistance = distance
        targetPos = posWork
      end
    end
    return targetPos
  end
  return nil
end

function AIComponentNew:GetTargetEntity()
  local nTargetID = self:GetRuntimeData("Target")
  if nTargetID then
    local entityTarget = self.m_world:GetEntityByID(nTargetID)
    if entityTarget then
      return entityTarget
    end
  end
  return self._targetEntity
end

function AIComponentNew:GetTargetDefault()
  return self._targetEntity
end

function AIComponentNew:GetTargetTeamEntity()
  return self._targetTeamEntity
end

function AIComponentNew:GetAITargetType()
  return self._aiTargetType
end

function AIComponentNew:InitPreviewLogic(logicType)
  local configService = self.m_world:GetService("Config")
  local configMonster = configService:GetMonsterConfigData()
  local nPrevOrder = configMonster:GetMonsterPreviewAIOrder(self.m_nMonsterID) or AILogicOrderType.BaseOrder
  return self:SetPreviewLogic(logicType, nPrevOrder)
end

function AIComponentNew:SetPreviewLogic(logicType, nOrder)
  local periodLogic = self.m_logicList[logicType]
  if not periodLogic then
    self.m_logicPreview = nil
    return
  end
  local logic = periodLogic[nOrder]
  if nil == logic then
    local listOrder = self:GetAILogicOrders(logicType)
    if 0 < #listOrder then
      logic = periodLogic[listOrder[1]]
    end
  end
  if logic then
    self.m_logicPreview = logic
    self.m_logicPreview:UpdateSkillAction()
  end
end

function AIComponentNew:SetReplacePreviewSkillID(skillID)
  self._replacePreviewSkillID = skillID
end

function AIComponentNew:ResetReplacePreviewSkillID()
  self._replacePreviewSkillID = nil
end

function AIComponentNew:IsReplacePreviewSkill()
  if self._replacePreviewSkillID then
    return true
  else
    return false
  end
end

function AIComponentNew:GetPreviewSkillID()
  if nil == self.m_logicPreview then
    return 0
  end
  if self._replacePreviewSkillID then
    return self._replacePreviewSkillID
  end
  self.m_logicPreview:UpdateSkillAction()
  return self.m_logicPreview:GetActionSkillID(true)
end

function AIComponentNew:SetCurSkillScopeResult(addRoundCount, nSkillID)
  local battleStatCmpt = self.m_world:BattleStat()
  local round = battleStatCmpt:GetLevelTotalRoundCount()
  local setRound = round + addRoundCount
  local skillID = nSkillID
  skillID = skillID or self:GetPreviewSkillID()
  local bodyArea = self._ownerEntity:BodyArea():GetArea()
  local posSelf = self._ownerEntity:GridLocation().Position
  local configService = self.m_world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self.m_world:GetService("UtilScopeCalc")
  local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  local skillResult = skillCalculater:CalcSkillScope(skillConfigData, posSelf, Vector2(0, 1), bodyArea)
  self._skillScopeResult[setRound] = skillResult
end

function AIComponentNew:GetSkillScopeResult(nextRound)
  local battleStatCmpt = self.m_world:BattleStat()
  local round = battleStatCmpt:GetLevelTotalRoundCount()
  if nextRound then
    round = round + 1
  end
  return self._skillScopeResult[round]
end

function AIComponentNew:SetRuntimeData(key, value)
  self._runtimeData[key] = value
end

function AIComponentNew:SetRuntimeDataAll(data)
  if data and type(data) == "table" then
    table.append(self._runtimeData, data)
  end
end

function AIComponentNew:GetRuntimeData(key)
  if not key then
    return self._runtimeData
  end
  return self._runtimeData[key]
end

function AIComponentNew:CanMove()
  return self.canMove
end

function AIComponentNew:CanTurn()
  return self.canTurn
end

function AIComponentNew:SetCanTurn(canTurn)
  self.canTurn = canTurn
end

function AIComponentNew:SetRunningSign(nLogicType, nOrder)
  self.m_nRunningAiType = nLogicType
  self.m_nRunningAiOrder = nOrder
end

function AIComponentNew:GetLastMovePos()
  return self.m_lastMovePos
end

function AIComponentNew:SetLastMovePos(pos)
  self.m_lastMovePos = pos
end

function AIComponentNew:CancelLogic()
  if self.m_rootLogic then
    self.m_rootLogic:CancelLogic()
  end
  self:SetComponentStatus(AINewNodeStatus.Failure)
end

function AIComponentNew:InitCreateRound()
  local battleStatCmpt = self.m_world:BattleStat()
  self.m_nCreateRound = battleStatCmpt:GetCurWaveTotalRoundCount()
end

function AIComponentNew:GetCreateRound()
  return self.m_nCreateRound
end

function AIComponentNew:GetAITreeState()
  return self._treeState
end

function AIComponentNew:SetAITreeState(st)
  self._treeState = st
end

function AIComponentNew:SetAIRoundEnd(isEnd)
  self._isAIRoundEnd = isEnd
end

function AIComponentNew:IsAIRoundEnd()
  return self._isAIRoundEnd
end

function AIComponentNew:IsAttachState(curRound, waveIndex)
  if self:GetRuntimeData("AttachMonsterID") then
    return true
  elseif self:GetRuntimeData("DetachBeginRunRound") then
    local detachWaveIndex = self:GetRuntimeData("DetachBeginWaveIndex")
    if waveIndex > detachWaveIndex then
      return false
    elseif curRound >= self:GetRuntimeData("DetachBeginRunRound") then
      return false
    else
      return true
    end
  else
    return false
  end
end

function AIComponentNew:GetAIMovePath_Test()
  return self._aiMovePathTest
end

function AIComponentNew:SetAIMovePath_Test(path)
  self._aiMovePathTest = path
end

function AIComponentNew:GetAntiSkill()
  return self._hasAntiSkill
end

function AIComponentNew:SetAntiSkill(hasAntiSkill)
  self._hasAntiSkill = hasAntiSkill
end

function AIComponentNew:GetContextByTreeInstanceID(instanceID, key)
  local context = self._treeContext[instanceID]
  if not context then
    return nil
  end
  return context[key]
end

function AIComponentNew:SetContextByTreeInstanceID(instanceID, key, value)
  local context = self._treeContext[instanceID]
  if not context then
    context = {}
    self._treeContext[instanceID] = context
  end
  context[key] = value
end

function Entity:AI()
  return self:GetComponent(self.WEComponentsEnum.AI)
end

function Entity:HasAI()
  return self:HasComponent(self.WEComponentsEnum.AI)
end

function Entity:HasNewAI()
  return self:HasComponent(self.WEComponentsEnum.AI)
end

function Entity:InitAI(world, nMonsterID, nMobility, aiTargetType)
  local aiComponent = self:AI()
  if aiComponent == nil then
    local index = self.WEComponentsEnum.AI
    aiComponent = AIComponentNew:New()
  end
  aiComponent.m_world = world
  aiComponent.m_nMonsterID = nMonsterID or 0
  aiComponent.m_nMobilityConfig = nMobility or 0
  aiComponent._ownerEntity = self
  if aiTargetType then
    aiComponent._aiTargetType = aiTargetType
  end
  aiComponent:InitCreateRound()
  self:ReplaceComponent(self.WEComponentsEnum.AI, aiComponent)
end

function Entity:AddNewAI(nMonsterID, aiLogicType, listAiID)
  if nil == listAiID or #listAiID <= 0 then
    return
  end
  local aiComponent = self:AI()
  if aiComponent == nil then
    local index = self.WEComponentsEnum.AI
    aiComponent = AIComponentNew:New()
    aiComponent.m_nMonsterID = nMonsterID or 0
    aiComponent._ownerEntity = self
  end
  for i = 1, #listAiID do
    local aiIDAndOrder = listAiID[i]
    local aiGenInfo = AIGenInfo:New(aiComponent.m_world, self, aiIDAndOrder[1], nMonsterID, aiLogicType)
    local aiLogic = CustomLogicFactory.Static_CreateLogic(aiGenInfo)
    if aiIDAndOrder[3] then
      aiLogic._parallelID = aiIDAndOrder[3]
    end
    aiComponent:AddLogic(aiLogicType, aiLogic, aiIDAndOrder[2])
  end
  self:ReplaceComponent(self.WEComponentsEnum.AI, aiComponent)
end

function Entity:AddNewAIByConfig(nMonsterID, listConfigAiID, aiOrder)
  if nil == listConfigAiID or #listConfigAiID <= 0 then
    return
  end
  local aiComponent = self:AI()
  if aiComponent == nil then
    local index = self.WEComponentsEnum.AI
    aiComponent = AIComponentNew:New()
    aiComponent.m_nMonsterID = nMonsterID or 0
    aiComponent._ownerEntity = self
  end
  for i = 1, #listConfigAiID do
    local nConfigAiID = listConfigAiID[i]
    local aiGenInfo = AIGenInfoByConfig:New(aiComponent.m_world, self, nConfigAiID)
    local aiLogic = CustomLogicFactory.Static_CreateLogic(aiGenInfo)
    local aiLogicPeriodType = aiGenInfo:GetLogicType()
    aiLogicPeriodType = self._world:ReplaceAILogicPeriodType(aiLogicPeriodType)
    local aiLogicOrder = aiOrder or aiGenInfo:GetLogicOrder()
    aiComponent:AddLogic(aiLogicPeriodType, aiLogic, aiLogicOrder)
    if aiGenInfo:IsPreview() then
      aiComponent:SetPreviewLogic(aiLogicPeriodType, aiLogicOrder)
    end
  end
  self:ReplaceComponent(self.WEComponentsEnum.AI, aiComponent)
end

function Entity:ReplaceAI(nLogicType, listAiID, orderIndex, enforce)
  local aiComponent = self:AI()
  if aiComponent == nil then
    return false
  end
  if aiComponent:GetCutLogic() and not enforce then
    return true
  end
  if nil == listAiID or #listAiID <= 0 then
    return false
  end
  local nOrderIndex = orderIndex and orderIndex or AILogicOrderType.BaseOrder
  local pLogicList = {}
  for i = 1, #listAiID do
    local aiGenInfo = AIGenInfo:New(aiComponent.m_world, self, listAiID[i], nil, nLogicType)
    local aiLogic = CustomLogicFactory.Static_CreateLogic(aiGenInfo)
    pLogicList[nOrderIndex] = aiLogic
    nOrderIndex = nOrderIndex + 1
  end
  aiComponent:SetCutLogic(pLogicList)
  aiComponent:ExchangeOnceLogic(nLogicType)
  return true
end

function Entity:ResumeAI(nLogicType)
  local aiComponent = self:AI()
  if aiComponent == nil then
    return
  end
  aiComponent:ExchangeOnceLogic(nLogicType)
  aiComponent:SetCutLogic(nil)
end

function Entity:ClearAI(nLogicType)
  local aiComponent = self:AI()
  if aiComponent == nil then
    return
  end
  aiComponent:SetCutLogic(nil)
  aiComponent:ExchangeOnceLogic(nLogicType)
end

function Entity:GetCoverAreaList(pos, fakeBodyArea)
  local posList = {}
  if nil == pos then
    pos = self:GridLocation().Position
  end
  if self:HasBodyArea() then
    local area = self:BodyArea():GetArea()
    if fakeBodyArea then
      area = fakeBodyArea
    end
    if 1 < #area then
      for i = 1, #area do
        posList[#posList + 1] = Vector2(pos.x + area[i].x, pos.y + area[i].y)
      end
    else
      posList[#posList + 1] = Vector2(pos.x + area[1].x, pos.y + area[1].y)
    end
  else
    posList[#posList + 1] = pos
  end
  return posList
end

function Entity:SetAICanMoveTurn(monsterID, canMove, canTurn)
  local aiComponent = self:AI()
  if aiComponent == nil then
    return
  end
  aiComponent.canMove = canMove or false
  aiComponent.canTurn = canTurn or false
end

function Entity:InitPreviewLogic(nLogicType)
  local aiComponent = self:AI()
  if aiComponent == nil then
    return
  end
  aiComponent:InitPreviewLogic(nLogicType)
end
