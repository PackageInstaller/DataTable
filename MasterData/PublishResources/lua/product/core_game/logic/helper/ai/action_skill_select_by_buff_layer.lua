require("ai_node_new")
_class("ActionSkillSelectByBuffLayer", AINewNode)
ActionSkillSelectByBuffLayer = ActionSkillSelectByBuffLayer

function ActionSkillSelectByBuffLayer:Constructor()
  self._skillID = 0
end

function ActionSkillSelectByBuffLayer:InitializeNode(cfg, context, parentNode, configData)
  ActionSkillSelectByBuffLayer.super.InitializeNode(self, cfg, context, parentNode, configData)
  self._successSkillListIndex = 1
  self._failureSkillListIndex = 2
  self.m_nDefaultSkillIndex = 1
  self._buffID = configData[1]
  self._comparisonType = configData[2]
  self._comparisonParam = configData[3]
end

function ActionSkillSelectByBuffLayer:Update()
  self:_CalcSkillID()
  return AINewNodeStatus.Success
end

function ActionSkillSelectByBuffLayer:GetActionSkillID()
  self:_CalcSkillID()
  return self._skillID
end

function ActionSkillSelectByBuffLayer:_CalcSkillID()
  local vecSkillLists = self:GetConfigSkillList()
  local selectSkill
  local buffCmp = self.m_entityOwn:BuffComponent()
  local buffInstance = buffCmp:GetBuffById(self._buffID)
  if buffInstance then
    local layer = buffInstance:GetLayerCount()
    local satisfied = false
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
      selectSkill = vecSkillLists[self._successSkillListIndex][self.m_nDefaultSkillIndex]
    end
  end
  if selectSkill then
    self._skillID = selectSkill
  else
    self._skillID = vecSkillLists[self._failureSkillListIndex][self.m_nDefaultSkillIndex]
  end
end
