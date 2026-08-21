require("action_is_base")
_class("ActionTargetInRange", ActionIsBase)
ActionTargetInRange = ActionTargetInRange

function ActionTargetInRange:Constructor()
end

function ActionTargetInRange:OnUpdate()
  local entityCaster = self.m_entityOwn
  local aiComponent = entityCaster:AI()
  if nil == aiComponent then
    return AINewNodeStatus.Failure
  end
  local targetType = self:GetLogicData(-1)
  local targetTypeParam = self:GetLogicData(-2)
  local scopeCenterType = self:GetLogicData(-3)
  local scopeType = self:GetLogicData(-4)
  local scopeTypeParam = self:GetLogicData(-5)
  self:PrintDebugLog("TargetType=", targetType, "TargetTypeParam=", targetTypeParam, "ScopeCenterType=", scopeCenterType, "ScopeType=", scopeType, "ScopeTypeParam=", scopeTypeParam)
  local bSuccess = self:IsTargetInRange(entityCaster, targetType, targetTypeParam, scopeCenterType, scopeType, scopeTypeParam)
  if bSuccess then
    self:PrintLog("判断目标在技能范围内成功")
    return AINewNodeStatus.Success
  end
  self:PrintLog("判断技能目标在技能范围内失败")
  return AINewNodeStatus.Failure
end
