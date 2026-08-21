_class("SequenceNode", BehaviourNode)
SequenceNode = SequenceNode

function SequenceNode:Constructor(children)
  SequenceNode.super.Constructor(self, children)
  self.idx = 1
end

function SequenceNode:DBString()
  return tostring(self.idx)
end

function SequenceNode:Reset()
  if self.status ~= BTState.READY then
    self.status = BTState.READY
    if self.children then
      for idx, child in ipairs(self.children) do
        child:Reset()
      end
    end
  end
  self.idx = 1
end

function SequenceNode:Visit()
  if self.status ~= BTState.RUNNING then
    self.idx = 1
  end
  local done = false
  while self.idx <= #self.children do
    local child = self.children[self.idx]
    child:Visit()
    if child.status == BTState.RUNNING or child.status == BTState.FAILED then
      self.status = child.status
      return
    end
    self.idx = self.idx + 1
  end
  self.status = BTState.SUCCESS
end

_class("SelectorNode", BehaviourNode)
SelectorNode = SelectorNode

function SelectorNode:Constructor(children)
  SelectorNode.super.Constructor(self, children)
  self.idx = 1
end

function SelectorNode:DBString()
  return tostring(self.idx)
end

function SelectorNode:Reset()
  if self.status ~= BTState.READY then
    self.status = BTState.READY
    if self.children then
      for idx, child in ipairs(self.children) do
        child:Reset()
      end
    end
  end
  self.idx = 1
end

function SelectorNode:Visit()
  if self.status ~= BTState.RUNNING then
    self.idx = 1
  end
  local done = false
  while self.idx <= #self.children do
    local child = self.children[self.idx]
    child:Visit()
    if child.status == BTState.RUNNING or child.status == BTState.SUCCESS then
      self.status = child.status
      return
    end
    self.idx = self.idx + 1
  end
  self.status = BTState.FAILED
end

_class("ParallelNode", BehaviourNode)
ParallelNode = ParallelNode

function ParallelNode:Step()
  if self.status ~= BTState.RUNNING then
    self:Reset()
  elseif self.children then
    for k, v in ipairs(self.children) do
      if v.status == BTState.SUCCESS and BT.iskindof(v, "ConditionNode") then
        v:Reset()
      end
    end
  end
end

function ParallelNode:Visit()
  local done = true
  local any_done = false
  for idx, child in ipairs(self.children) do
    if BT.iskindof(child, "ConditionNode") or BT.iskindof(child, "NotDecorator") then
      child:Reset()
    end
    if child.status ~= BTState.SUCCESS then
      child:Visit()
      if child.status == BTState.FAILED then
        self.status = BTState.FAILED
        return
      end
    end
    if child.status == BTState.RUNNING then
      done = false
    else
      any_done = true
    end
  end
  if done or self.stoponanycomplete and any_done then
    self.status = BTState.SUCCESS
  else
    self.status = BTState.RUNNING
  end
end

function ParallelNode:GetSleepTime()
  return 0
end

function ParallelNode:GetTreeSleepTime()
  return 0
end

_class("DecoratorNode", BehaviourNode)
DecoratorNode = DecoratorNode

function DecoratorNode:Constructor(child)
  DecoratorNode.super.Constructor(self, {child})
end
