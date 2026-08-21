require("ai_node_new")
_class("ActionCompareLayerCount", AINewNode)
ActionCompareLayerCount = ActionCompareLayerCount

function ActionCompareLayerCount:OnUpdate()
  local buffID = self:GetLogicData(-1)
  local compareFlag = self:GetLogicData(-2)
  local count = self:GetLogicData(-3)
  local layerCount = 0
  local cBuff = self.m_entityOwn:BuffComponent()
  if cBuff then
    local instanbce = cBuff:GetBuffById(buffID)
    if instanbce then
      local layerName = instanbce:GetBuffLayerName()
      layerCount = cBuff:GetBuffValue(layerName) or 0
    end
  end
  local satisfied = false
  if compareFlag == ComparisonOperator.EQ then
    satisfied = layerCount == count
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = layerCount ~= count
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = count < layerCount
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = count <= layerCount
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = count > layerCount
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = count >= layerCount
  end
  if satisfied then
    return AINewNodeStatus.Success
  else
    return AINewNodeStatus.Failure
  end
end
