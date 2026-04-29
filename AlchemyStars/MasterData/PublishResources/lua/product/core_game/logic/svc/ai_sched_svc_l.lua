require("base_service")
_class("AISchedulerService", BaseService)
AISchedulerService = AISchedulerService

function AISchedulerService:Initialize()
  self.m_aiService = self._world:GetService("AI")
  self.m_battleService = self._world:GetService("Battle")
  self._boardService = self._world:GetService("BoardLogic")
  self.group = self._world:GetGroup(self._world.BW_WEMatchers.AI)
  self:_InitListScan()
  self.m_bRebuildScan = true
end

function AISchedulerService:_InitListScan()
  if self._world:MatchType() == MatchType.MT_Chess then
    self.m_listScan = SortedArray:New(Algorithm.COMPARE_CUSTOM, AISchedulerService._ChessModeComparer)
  else
    self.m_listScan = SortedArray:New(Algorithm.COMPARE_CUSTOM, AISchedulerService._LessComparer)
  end
  self.m_listScan:AllowDuplicate()
end

function AISchedulerService:GetAIList()
  return self.m_listScan
end

function AISchedulerService:SetAIList(elist)
  self.m_listScan:Clear()
  for i, e in ipairs(elist) do
    if not e:AI():IsLogicEnd() then
      self.m_listScan:Insert(e)
    end
  end
end

function AISchedulerService:DoScheduleAILogic()
  return self:_UpdateWorkList()
end

function AISchedulerService:DoUpdateAIList()
  for i = 1, self.m_listScan:Size() do
    local e = self.m_listScan:GetAt(i)
    self:UpdateAI(e)
  end
end

function AISchedulerService:UpdateAI(e)
  if nil == e then
    return
  end
  local pos = e:GridLocation().Position
  local aiComponent = e:AI()
  if aiComponent:IsLogicEnd() or e:HasDeadMark() then
    return
  end
  local timeService = self._world:GetService("Time")
  local deltaTimeMS = timeService:GetDeltaTimeMs()
  aiComponent:Update(deltaTimeMS)
  aiComponent:ResetLogic()
end

function AISchedulerService:_UpdateWorkList()
  local listWork = self.m_listScan
  local nMaxCount = listWork:Size()
  if nMaxCount <= 0 then
    return true
  end
  local nCountHaveDown = 0
  for i = 1, nMaxCount do
    local entityWork = listWork:GetAt(i)
    local bUpdate = false
    local aiComponent
    if entityWork and not entityWork:HasDeadMark() then
      aiComponent = entityWork:AI()
      if false == aiComponent:IsLogicEnd() then
        self:UpdateAI(entityWork)
        aiComponent:OutLog("扫描队列<退出>")
      end
    else
      Log.fatal("EntityIsDead:", entityWork:GetID())
    end
    if entityWork:HasDeadMark() or aiComponent:IsAIRoundEnd() then
      nCountHaveDown = nCountHaveDown + 1
    end
  end
  return nCountHaveDown == nMaxCount
end

function AISchedulerService._LessComparer(entityA, entityB)
  local nDistanceA = entityA:AI():GetDistance()
  local nDistanceB = entityB:AI():GetDistance()
  local aiLogicOrderWeightA = entityA:AI():GetAIOrderWeight()
  local aiLogicOrderWeightB = entityB:AI():GetAIOrderWeight()
  if aiLogicOrderWeightA ~= aiLogicOrderWeightB then
    if aiLogicOrderWeightA > aiLogicOrderWeightB then
      return -1
    elseif aiLogicOrderWeightA < aiLogicOrderWeightB then
      return 1
    end
  elseif nDistanceA < nDistanceB then
    return 1
  elseif nDistanceA > nDistanceB then
    return -1
  else
    local center = entityA:AI():GetTargetPos()
    local a = entityA:GridLocation().Position
    local b = entityA:GridLocation().Position
    if a.x - center.x >= 0 and b.x - center.x < 0 then
      return 1
    end
    if a.x - center.x < 0 and b.x - center.x >= 0 then
      return -1
    end
    local nReturn = 0
    if a.x - center.x == 0 and b.x - center.x == 0 then
      if 0 <= a.y - center.y or 0 <= b.y - center.y then
        nReturn = a.y - b.y
      else
        nReturn = b.y - a.y
      end
    end
    if 0 == nReturn then
      local det = (a.x - center.x) * (b.y - center.y) - (b.x - center.x) * (a.y - center.y)
      if det < 0 then
        nReturn = 1
      elseif 0 < det then
        nReturn = -1
      end
    end
    if 0 == nReturn then
      local nIDA = entityA:GetID()
      local nIDB = entityB:GetID()
      nReturn = nIDA - nIDB
    end
    if 0 < nReturn then
      return 1
    elseif nReturn < 0 then
      return -1
    else
      return 0
    end
  end
  return 0
end

function AISchedulerService._ChessModeComparer(entityA, entityB)
  if entityA == nil or not entityA:MonsterID() then
    return 0
  end
  if entityB == nil or not entityB:MonsterID() then
    return 0
  end
  local mstIDA = entityA:MonsterID():GetMonsterID()
  local mstIDB = entityB:MonsterID():GetMonsterID()
  if entityA:HasMonsterID() and entityB:HasMonsterID() and mstIDA ~= mstIDB then
    return mstIDA < mstIDB and 1 or -1
  end
  local eidA = entityA:GetID()
  local eidB = entityB:GetID()
  if eidA == eidB then
    return 0
  else
    return eidA < eidB and 1 or -1
  end
end
