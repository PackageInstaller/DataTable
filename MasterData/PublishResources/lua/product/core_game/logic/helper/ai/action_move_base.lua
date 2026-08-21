require("ai_node_new")
_class("ActionMoveBase", AINewNode)
ActionMoveBase = ActionMoveBase

function ActionMoveBase:Constructor()
  self.m_posMoveTarget = nil
  self.m_posTarget = Vector2.New(0, 0)
end

function ActionMoveBase:InitializeNode(cfg, context, parentNode, configData)
  ActionMoveBase.super.InitializeNode(self, cfg, context, parentNode, configData)
end

function ActionMoveBase:Reset()
  ActionMoveBase.super.Reset(self)
  self.m_posTarget = Vector2.New(0, 0)
end

function ActionMoveBase:CheckCanMove()
  local aiCmpt = self.m_entityOwn:AI()
  return aiCmpt:CanMove()
end

function ActionMoveBase:OnBegin()
  local aiCmpt = self.m_entityOwn:AI()
  if AIMoveState.MoveEnd == aiCmpt:GetMoveState() then
    self:PrintLog("移动结束等待中")
    return
  end
  if false == self:CheckCanMove() then
    aiCmpt:SetMoveState(AIMoveState.MoveEnd)
    self:PrintLog("启动移动<不允许>")
    return
  end
  local trapCmpt = self.m_entityOwn:Trap()
  if trapCmpt then
    aiCmpt:SetMoveState(AIMoveState.MoveEnd)
    self:PrintLog("机关不能以AI移动")
    return
  end
  aiCmpt:SetMoveState(AIMoveState.Moving)
  local targetEntity = aiCmpt:GetTargetEntity()
  if targetEntity and targetEntity:HasGridLocation() then
    local listPosTarget = targetEntity:GetCoverAreaList()
    local targetEntityPosCenter = targetEntity:GridLocation():Center()
    local posSelf = self.m_entityOwn:GetGridPosition()
    self:InitTargetPosList(listPosTarget, targetEntityPosCenter)
  else
    self:PrintLog("没有找到目标")
  end
end

function ActionMoveBase:BeforeCalcMovePos()
end

function ActionMoveBase:AfterCalcMovePos()
end

function ActionMoveBase:OnUpdate()
  local entityWork = self.m_entityOwn
  local aiComponent = entityWork:AI()
  if AIMoveState.MoveEnd == aiComponent:GetMoveState() then
    self:PrintLog("移动结束等待中")
    return AINewNodeStatus.Success
  end
  if false == self:CheckCanMove() then
    return AINewNodeStatus.Success
  end
  if AINewNode.IsEntityDead(self.m_entityOwn) then
    return AINewNodeStatus.Success
  end
  local sBoard = self._world:GetService("BoardLogic")
  self:BeforeCalcMovePos()
  local posWalk = self:_CalcMovePos(entityWork)
  self:AfterCalcMovePos()
  local aiRecorderCmpt = self._world:GetBoardEntity():AIRecorder()
  local walkRes = MonsterWalkResult:New()
  if posWalk ~= nil then
    local posSelf = entityWork:GetGridPosition()
    aiComponent:SetLastMovePos(posSelf)
    sBoard:UpdateEntityBlockFlag(entityWork, posSelf, posWalk)
    entityWork:SetGridPosition(posWalk)
    entityWork:SetGridDirection(posWalk - posSelf)
    local entityID = entityWork:GetID()
    walkRes:SetWalkPos(posWalk)
    aiRecorderCmpt:AddWalkResult(entityID, walkRes)
    self:_OnArrivePos(walkRes)
    self._world:GetSyncLogger():Trace({
      key = "AIMove",
      aiNode = self._className,
      entityID = entityWork:GetID(),
      fromTo = tostring(posSelf) .. "->" .. tostring(posWalk),
      target = tostring(self.m_posTarget)
    })
    self:PrintLog("移动位置 " .. self:_MakePosString(posSelf) .. "=>", self:_MakePosString(posWalk), ", 选择目标", self:_MakePosString(self.m_posTarget))
    self:PrintDebugLog("移动位置 " .. self:_MakePosString(posSelf) .. "=>", self:_MakePosString(posWalk), ", 选择目标", self:_MakePosString(self.m_posTarget))
  end
  local nMobilityToalRemain = aiComponent:GetMobilityValid()
  if AINewNode.IsEntityDead(self.m_entityOwn) then
    aiComponent:SetMoveState(AIMoveState.MoveEnd)
    return AINewNodeStatus.Success
  elseif 1 < nMobilityToalRemain then
    return AINewNodeStatus.Failure
  else
    aiComponent:SetMoveState(AIMoveState.MoveEnd)
    return AINewNodeStatus.Success
  end
end

function ActionMoveBase:_CalcMovePos(entityWork)
  local aiComponent = entityWork:AI()
  local posSelf = entityWork:GridLocation().Position
  local posTarget = self:FindNewTargetPos()
  self.m_posTarget = posTarget
  if posSelf == posTarget then
    self:PrintLog("不需要移动，当前就是目标坐标", self:_MakePosString(posSelf))
    self:PrintDebugLog("不需要移动，当前就是目标坐标", self:_MakePosString(posSelf))
    return nil
  end
  local nWalkTotal = aiComponent:GetMobilityValid()
  local posWalkList = self:ComputeWalkRange(posSelf, nWalkTotal, true)
  local posWalk = self:FindNewWalkPos(posWalkList, posTarget, posSelf)
  if posWalk and posWalk == posSelf then
    self:PrintLog("不需要移动 ", self:_MakePosString(posSelf), ">===>", self:_MakePosString(posWalk))
    self:PrintDebugLog("不需要移动 ", self:_MakePosString(posSelf), ">===>", self:_MakePosString(posWalk))
    return nil
  end
  self:PrintDebugLog("移动到", self:_MakePosString(posWalk))
  return posWalk
end

function ActionMoveBase:OnEnd()
end

function ActionMoveBase:_ComputeSkillRange(nSkillID, posCenter, bodyArea, dir)
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

function ActionMoveBase:InitTargetPosList(listPosTarget)
end

function ActionMoveBase:FindNewTargetPos()
  local posDefault = self.m_entityOwn:GetGridPosition()
  return posDefault
end

function ActionMoveBase:FindNewWalkPos(walkRange, posCenter, posDef)
  return self:FindPosByNearCenter(walkRange, posCenter, posDef, 1)
end

function ActionMoveBase:FindPosByNearCenter(listPlanPos, posCenter, posDef, nCheckStep)
  if nil == listPlanPos or table.count(listPlanPos) <= 0 then
    return posDef
  end
  local listWalk = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
  listWalk:AllowDuplicate()
  local aiCmpt = self.m_entityOwn:AI()
  local lastMovePos = aiCmpt:GetLastMovePos()
  local utilDataSvc = self._world:GetService("UtilData")
  for i = 1, #listPlanPos do
    local posData = listPlanPos[i]
    local posWalk = posData:GetPos()
    if posWalk ~= posDef and (nil == nCheckStep or nCheckStep == posData:GetStep()) then
      local isBlockMoveWithTrapWall = utilDataSvc:IsBlockMoveWithTrapWall(posDef, posWalk, self.m_entityOwn)
      if posWalk ~= lastMovePos and isBlockMoveWithTrapWall == false then
        AINewNode.InsertSortedArray(listWalk, posCenter, posWalk, i)
      else
      end
    end
  end
  return self:FindPosValid(listWalk, posDef)
end

function ActionMoveBase:_OnArrivePos(walkRes)
  local world = self.m_entityOwn:GetOwnerWorld()
  local skillLogicSvc = self._world:GetService("SkillLogic")
  local trapServiceLogic = world:GetService("TrapLogic")
  local pos = self.m_entityOwn:GetGridPosition()
  local listTrapWork, listTrapResult = trapServiceLogic:TriggerTrapByEntity(self.m_entityOwn, TrapTriggerOrigin.Move)
  for i, e in ipairs(listTrapWork) do
    local trapEntity = e
    local skillEffectResultContainer = listTrapResult[i]
    local aiResult = AISkillResult:New()
    aiResult:SetResultContainer(skillEffectResultContainer)
    local scopeRes = skillEffectResultContainer:GetScopeResult()
    Log.debug("[AIMove] OnArrivePos() monster=", self.m_entityOwn:GetID(), " pos=", pos, " trigger trapid=", trapEntity:GetID(), " defender=", scopeRes:GetTargetIDs()[1])
    walkRes:AddWalkTrap(trapEntity:GetID(), aiResult)
  end
  local nTrapCount = table.count(listTrapWork)
  local passGrids = {}
  local bodyArea = self.m_entityOwn:BodyArea():GetArea()
  local dir = self.m_entityOwn:GridLocation():GetGridDir()
  local curPos = self.m_entityOwn:GetGridPosition()
  for _, value in ipairs(bodyArea) do
    local pos = curPos + value - dir
    if not table.Vector2Include(passGrids, pos) then
      passGrids[#passGrids + 1] = pos
    end
  end
  local aiCmpt = self.m_entityOwn:AI()
  local lastMovePos = aiCmpt:GetLastMovePos()
  local nt = NTMonsterMoveOneFinish:New(self.m_entityOwn, passGrids, walkRes:GetWalkPos(), lastMovePos)
  world:GetService("Trigger"):Notify(nt)
  walkRes:SetWalkPassedGrid(passGrids)
end

function ActionMoveBase:isDuplicate(pos, passGrids)
  for _, value in ipairs(passGrids) do
    if value.x == pos.x and value.y == pos.y then
      return true
    end
  end
  return false
end
