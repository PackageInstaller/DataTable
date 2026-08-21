function CustomNodeConfigStatic.Check_FsmTransitionNode(cfg)
  if cfg.TrueState and cfg.Condition then
    return true
  end
  return false
end

CustomNodeConfigStatic.AddChecker("FsmTransitionNode", CustomNodeConfigStatic.Check_FsmTransitionNode)
_class("FsmTransitionNode", CustomNode)
FsmTransitionNode = FsmTransitionNode

function FsmTransitionNode:Constructor()
  self.TrueState = nil
  self.FalseState = nil
  self.Condition = nil
end

function FsmTransitionNode:InitializeNode(cfg, context)
  FsmTransitionNode.super.InitializeNode(self, cfg, context)
  self.TrueState = cfg.TrueState
  self.FalseState = cfg.FalseState
  self.CheckInterval = self:Parse(cfg.CheckInterval)
  self.LastCheckTime = nil
  local cnd_node = cfg.Condition
  local logic = context.Logic
  self.Condition = logic:CreateNode(cnd_node, context)
  self.Condition:Deactivate()
end

function FsmTransitionNode:Destroy()
  self.Condition:Destroy()
  FsmTransitionNode.super.Destroy(self)
end

function FsmTransitionNode:Reset()
  self.Condition:Reset()
end

function FsmTransitionNode:Activate()
  FsmTransitionNode.super.Activate(self)
  self.Condition:Activate()
end

function FsmTransitionNode:Deactivate()
  FsmTransitionNode.super.Deactivate(self)
  self.Condition:Deactivate()
end

function FsmTransitionNode:CheckTransitions()
  if not self.CheckInterval then
    return self:_InnerCheckTransition()
  else
    local now = TimeService:GetInstance().CurTime
    if not self.LastCheckTime or now - self.LastCheckTime >= self.CheckInterval then
      self.LastCheckTime = now
      return self:_InnerCheckTransition()
    else
      return nil
    end
  end
end

function FsmTransitionNode:_InnerCheckTransition()
  local next_state
  if self.Condition:IsConditionReached() then
    next_state = self.TrueState
  else
    next_state = self.FalseState
  end
  if next_state then
    Log.debug("Condition Reached :", self.Condition._className)
  end
  return next_state
end

function FsmTransitionNode:Update(dt)
  self.Condition:Update(dt)
end

function FsmTransitionNode:CollectInterfaceInChildren(interfaceList, funcName)
  CustomNodeStatic.TraverseCollectInterface(interfaceList, funcName, self.Condition)
end
