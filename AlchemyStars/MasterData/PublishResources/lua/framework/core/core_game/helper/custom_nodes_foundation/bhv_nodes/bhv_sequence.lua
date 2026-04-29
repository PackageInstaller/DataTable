function CustomNodeConfigStatic.Check_BhvSequence(nodeCfg)
  if nodeCfg.Nodes then
    return true
  end
  return false
end

CustomNodeConfigStatic.AddChecker("BhvSequence", CustomNodeConfigStatic.Check_BhvSequence)
_class("BhvSequence", CustomNode)
BhvSequence = BhvSequence

function BhvSequence:Constructor()
  self.mBehaviorSeq = ArrayList:New()
  self.mCurBhvIndex = 1
  self.mIsFinished = false
end

function BhvSequence:InitializeNode(cfg, context)
  BhvSequence.super.InitializeNode(self, cfg, context)
  self.mCurBhvIndex = 1
  self.mBehaviorSeq:Clear()
  local nodeCfgList = cfg.Nodes
  local logic = context.Logic
  for i = 1, #nodeCfgList do
    local nodeCfg = nodeCfgList[i]
    local subbhv = logic:CreateNode(nodeCfg, context)
    CLHelper.Assert(subbhv and subbhv.Update)
    subbhv:Deactivate()
    self.mBehaviorSeq:PushBack(subbhv)
  end
end

function BhvSequence:Activate()
  BhvSequence.super.Activate(self)
  self:ActivateCurBhv()
end

function BhvSequence:Deactivate()
  BhvSequence.super.Deactivate(self)
  self:DeactivateCurBhv()
end

function BhvSequence:Destroy()
  local nodes = self.mBehaviorSeq
  for i = 1, nodes:Size() do
    nodes:GetAt(i):Destroy()
  end
  self.mBehaviorSeq:Clear()
  BhvSequence.super.Destroy(self)
end

function BhvSequence:Reset()
  self.mCurBhvIndex = 1
  self.mIsFinished = false
  local nodes = self.mBehaviorSeq
  for i = 1, nodes:Size() do
    local node = nodes:GetAt(i)
    node:Reset()
  end
end

function BhvSequence:Update(dt)
  local nodes = self.mBehaviorSeq
  local nodesSize = nodes:Size()
  if nodesSize == 0 then
    return
  end
  for i = 1, nodesSize do
    local curIndex = self.mCurBhvIndex
    if nodesSize < curIndex then
      break
    end
    local curBhv = nodes:GetAt(curIndex)
    curBhv:Update(dt)
    if curBhv.CanStop and curBhv:CanStop() == false then
      return
    end
    self:DeactivateCurBhv()
    self.mCurBhvIndex = curIndex + 1
    self:ActivateCurBhv()
  end
  self.mIsFinished = true
end

function BhvSequence:CanStop()
  return self.mIsFinished
end

function BhvSequence:CollectInterfaceInChildren(interfaceList, funcName)
  local nodes = self.mBehaviorSeq
  for i = 1, nodes:Size() do
    local node = nodes:GetAt(i)
    CustomNodeStatic.TraverseCollectInterface(interfaceList, funcName, node)
  end
end

function BhvSequence:ActivateCurBhv()
  local curIndex = self.mCurBhvIndex
  local nodes = self.mBehaviorSeq
  if 1 <= curIndex and curIndex <= nodes:Size() then
    nodes:GetAt(curIndex):Activate()
  end
end

function BhvSequence:DeactivateCurBhv()
  local curIndex = self.mCurBhvIndex
  local nodes = self.mBehaviorSeq
  if 1 <= curIndex and curIndex <= nodes:Size() then
    nodes:GetAt(curIndex):Deactivate()
  end
end
