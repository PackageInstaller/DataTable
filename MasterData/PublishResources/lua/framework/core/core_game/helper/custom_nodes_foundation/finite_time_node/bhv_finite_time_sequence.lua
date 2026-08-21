require("abstract_bhv_finite_time")

function CustomNodeConfigStatic.Check_FTBhvSequence(nodeCfg)
  if nodeCfg.Nodes then
    return true
  end
  return false
end

CustomNodeConfigStatic.AddChecker("FTBhvSequence", CustomNodeConfigStatic.Check_FTBhvSequence)
_class("FTBhvSequence", FiniteTimeBhv)
FTBhvSequence = FTBhvSequence

function FTBhvSequence:Constructor()
  self.mBehaviorSeq = ArrayList:New()
  self.mCurBhvIndex = 1
end

function FTBhvSequence:InitializeNode(cfg, context)
  FTBhvSequence.super.InitializeNode(self, cfg, context)
  self.mCurBhvIndex = 1
  self.mBehaviorSeq:Clear()
  local nodeCfgList = cfg.Nodes
  local logic = context.Logic
  for i = 1, #nodeCfgList do
    local nodeCfg = nodeCfgList[i]
    local subbhv = logic:CreateNode(nodeCfg, context)
    CLHelper.Assert(subbhv)
    subbhv:Deactivate()
    self.mBehaviorSeq:PushBack(subbhv)
  end
end

function FTBhvSequence:Activate()
  FTBhvSequence.super.Activate(self)
  self:ActivateCurBhv()
end

function FTBhvSequence:Deactivate()
  FTBhvSequence.super.Deactivate(self)
  self:DeactivateCurBhv()
end

function FTBhvSequence:Destroy()
  local nodes = self.mBehaviorSeq
  for i = 1, nodes:Size() do
    nodes:GetAt(i):Destroy()
  end
  self.mBehaviorSeq:Clear()
  FTBhvSequence.super.Destroy(self)
end

function FTBhvSequence:Reset()
  FTBhvSequence.super.Reset(self)
  self.mCurBhvIndex = 1
  local totalDuration = 0
  local nodes = self.mBehaviorSeq
  for i = 1, nodes:Size() do
    local node = nodes:GetAt(i)
    node:Reset()
    if node.GetDuration then
      totalDuration = totalDuration + node:GetDuration()
    end
  end
  self:InitDuration(totalDuration)
end

function FTBhvSequence:IsDurationEnd()
  if self.mCurBhvIndex >= self.mBehaviorSeq:Size() then
    return true
  end
  return false
end

function FTBhvSequence:Update(dt)
  FTBhvSequence.super.Update(self, dt)
  local nodes = self.mBehaviorSeq
  local nodesSize = nodes:Size()
  if nodesSize == 0 then
    return
  end
  local dt_overplus = dt
  for i = 1, nodesSize do
    local curIndex = self.mCurBhvIndex
    if nodesSize < curIndex or dt_overplus <= 0 then
      break
    end
    local curBhv = nodes:GetAt(curIndex)
    local curDur = curBhv:GetDuration()
    curBhv:Update(dt_overplus)
    if not self:IsActive() then
      break
    end
    dt_overplus = dt_overplus - curDur
    if curBhv:IsDurationEnd() then
      self:DeactivateCurBhv()
      self.mCurBhvIndex = curIndex + 1
      self:ActivateCurBhv()
    end
  end
end

function FTBhvSequence:CollectInterfaceInChildren(interfaceList, funcName)
  local nodes = self.mBehaviorSeq
  for i = 1, nodes:Size() do
    local node = nodes:GetAt(i)
    CustomNodeStatic.TraverseCollectInterface(interfaceList, funcName, node)
  end
end

function FTBhvSequence:ActivateCurBhv()
  local curIndex = self.mCurBhvIndex
  local nodes = self.mBehaviorSeq
  if 1 <= curIndex and curIndex <= nodes:Size() then
    nodes:GetAt(curIndex):Activate()
  end
end

function FTBhvSequence:DeactivateCurBhv()
  local curIndex = self.mCurBhvIndex
  local nodes = self.mBehaviorSeq
  if 1 <= curIndex and curIndex <= nodes:Size() then
    nodes:GetAt(curIndex):Deactivate()
  end
end
