require("ai_node_new")
_class("ActionCheckBuffLayer", AINewNode)
ActionCheckBuffLayer = ActionCheckBuffLayer

function ActionCheckBuffLayer:InitializeNode(cfg, context, parentNode, configData)
  ActionCheckBuffLayer.super.InitializeNode(self, cfg, context, parentNode, configData)
  self._buffID = configData[1]
  self._comparisonType = configData[2]
  self._comparisonParam = configData[3]
end

function ActionCheckBuffLayer:OnUpdate()
  local buffCmp = self.m_entityOwn:BuffComponent()
  local buffInstance = buffCmp:GetBuffById(self._buffID)
  if buffInstance then
    local satisfied
    local layer = buffInstance:GetLayerCount()
    if self._comparisonType == ComparisonOperator.EQ then
      satisfied = layer == self._comparisonParam
    elseif self._comparisonType == ComparisonOperator.NE then
      satisfied = layer ~= self._comparisonParam
    elseif self._comparisonType == ComparisonOperator.GT then
      satisfied = layer > self._comparisonParam
    elseif self._comparisonType == ComparisonOperator.GE then
      satisfied = layer >= self._comparisonParam
    elseif self._comparisonType == ComparisonOperator.LT then
      satisfied = layer < self._comparisonParam
    elseif self._comparisonType == ComparisonOperator.LE then
      satisfied = layer <= self._comparisonParam
    end
    if satisfied then
      return AINewNodeStatus.Success
    else
      return AINewNodeStatus.Failure
    end
  end
  return AINewNodeStatus.Failure
end
