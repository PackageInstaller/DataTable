function CustomNodeConfigStatic.Check_CustomBehaviorStateNode(cfg)
  if cfg.CustomBehavior and cfg.GoalState then
    return true
  end
  if cfg.Transitions then
    return false
  end
  return false
end

CustomNodeConfigStatic.AddChecker("CustomBehaviorStateNode", CustomNodeConfigStatic.Check_CustomBehaviorStateNode)
_class("CustomBehaviorStateNode", StateNode)
CustomBehaviorStateNode = CustomBehaviorStateNode

function CustomBehaviorStateNode:Constructor()
  self.CustomBehavior = nil
end

function CustomBehaviorStateNode:InitializeNode(cfg, context)
  CustomBehaviorStateNode.super.InitializeNode(self, cfg, context)
  self.GoalState = self:Parse(cfg.GoalState)
  local logic = context.Logic
  local nodeCfg = cfg.CustomBehavior
  self.CustomBehavior = logic:CreateNode(nodeCfg, context)
  self.CustomBehavior:Deactivate()
end

function CustomBehaviorStateNode:Destroy()
  self.CustomBehavior:Destroy()
  CustomBehaviorStateNode.super.Destroy(self)
end

function CustomBehaviorStateNode:Activate()
  CustomBehaviorStateNode.super.Activate(self)
  if self.CustomBehavior then
    self.CustomBehavior:Activate()
  end
end

function CustomBehaviorStateNode:Deactivate()
  CustomBehaviorStateNode.super.Deactivate(self)
  if self.CustomBehavior then
    self.CustomBehavior:Deactivate()
  end
end

function CustomBehaviorStateNode:Enter()
  CustomBehaviorStateNode.super.Enter(self)
end

function CustomBehaviorStateNode:Exit()
  CustomBehaviorStateNode.super.Exit(self)
  self.CustomBehavior:Reset()
end

function CustomBehaviorStateNode:CheckTransitions()
  if self.CustomBehavior:CanStop() then
    return self.GoalState
  end
  return nil
end

function CustomBehaviorStateNode:Update(dt)
  self.CustomBehavior:Update(dt)
end

function CustomBehaviorStateNode:CollectInterfaceInChildren(interfaceList, funcName)
  CustomNodeStatic.TraverseCollectInterface(interfaceList, funcName, self.CustomBehavior)
end
