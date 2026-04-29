require("ai_node_new")
_class("ActionCheckBuffValue", AINewNode)
ActionCheckBuffValue = ActionCheckBuffValue

function ActionCheckBuffValue:InitializeNode(cfg, context, parentNode, configData)
  ActionCheckBuffValue.super.InitializeNode(self, cfg, context, parentNode, configData)
  self._buffValueKey = configData[1]
  self._comparisonType = configData[2]
  self._buffValue = configData[3]
end

function ActionCheckBuffValue:OnUpdate()
  local buffCmp = self.m_entityOwn:BuffComponent()
  local value = buffCmp:GetBuffValue(self._buffValueKey)
  if value then
    local satisfied
    if self._comparisonType == ComparisonOperator.EQ then
      satisfied = value == self._buffValue
    elseif self._comparisonType == ComparisonOperator.NE then
      satisfied = value ~= self._buffValue
    elseif self._comparisonType == ComparisonOperator.GT then
      satisfied = value > self._buffValue
    elseif self._comparisonType == ComparisonOperator.GE then
      satisfied = value >= self._buffValue
    elseif self._comparisonType == ComparisonOperator.LT then
      satisfied = value < self._buffValue
    elseif self._comparisonType == ComparisonOperator.LE then
      satisfied = value <= self._buffValue
    end
    if satisfied then
      return AINewNodeStatus.Success
    else
      return AINewNodeStatus.Failure
    end
  end
  return AINewNodeStatus.Failure
end
