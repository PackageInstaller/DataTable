_class("ActionNode", BehaviourNode)
ActionNode = ActionNode

function ActionNode:Constructor(action)
  ActionNode.super.Constructor(self, nil)
  self.action = action
end

function ActionNode:Visit()
  self:action()
  self.status = BTState.SUCCESS
end

_class("ConditionNode", BehaviourNode)
ConditionNode = ConditionNode

function ConditionNode:Constructor(children, func)
  ConditionNode.super.Constructor(self, children)
  self.fn = func
end

function ConditionNode:Visit()
  if self.fn() then
    self.status = BTState.SUCCESS
  else
    self.status = BTState.FAILED
  end
end

_class("ComparisonOperationNode", BehaviourNode)
ComparisonOperationNode = ComparisonOperationNode

function ComparisonOperationNode:Constructor(children, comparisonOperationType, lNumberCalcFunction, rNumberCalcFunction)
  ComparisonOperationNode.super.Constructor(self, children)
  self.comparisonOperationType = comparisonOperationType
  self.lNumberCalcFunction = lNumberCalcFunction
  self.rNumberCalcFunction = rNumberCalcFunction
end

function ComparisonOperationNode:Visit()
  local lNumber = self.lNumberCalcFunction and self.lNumberCalcFunction() or 0
  local rNumber = self.rNumberCalcFunction and self.rNumberCalcFunction() or 0
  local map = {
    [ComparisonOperationType.EQ] = lNumber == rNumber,
    [ComparisonOperationType.NE] = lNumber ~= rNumber,
    [ComparisonOperationType.LT] = lNumber > rNumber,
    [ComparisonOperationType.LE] = lNumber >= rNumber,
    [ComparisonOperationType.ST] = lNumber < rNumber,
    [ComparisonOperationType.SE] = lNumber <= rNumber
  }
  local b = map[self.comparisonOperationType]
  if b == nil then
    Log.warn("### invalid ComparisonOperationType:", self.comparisonOperationType)
  end
  if b then
    self.status = BTState.SUCCESS
  else
    self.status = BTState.FAILED
  end
end

ComparisonOperationType = {
  EQ = 1,
  NE = 2,
  LT = 3,
  LE = 4,
  ST = 5,
  SE = 6
}
_enum("ComparisonOperationType", ComparisonOperationType)
