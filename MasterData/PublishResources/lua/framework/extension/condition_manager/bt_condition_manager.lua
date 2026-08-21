_class("BTConditionManager", Singleton)
BTConditionManager = BTConditionManager

function BTConditionManager:Constructor()
end

function BTConditionManager:NewBehaviourTree(node)
  local bt = BehaviourTree:New(node)
  return bt
end

function BTConditionManager:BuildBTSingle(conbditionNode)
  local bt = self:NewBehaviourTree(conbditionNode)
  return bt
end

function BTConditionManager:BuildBTAnd(conbditionNodes)
  local sNode = SequenceNode:New(conbditionNodes)
  local bt = self:NewBehaviourTree(sNode)
  return bt
end

function BTConditionManager:BuildBTOr(conbditionNodes)
  local sNode = SelectorNode:New(conbditionNodes)
  local bt = self:NewBehaviourTree(sNode)
  return bt
end

function BTConditionManager:IsSatisfy(bt)
  if self:IsBTSuccess(bt) then
    return true
  end
  return false
end

function BTConditionManager:IsBTSuccess(bt)
  local root = bt.root
  root:Visit()
  local b = false
  if root.status == BTState.SUCCESS then
    b = true
  end
  root:Reset()
  return b
end
