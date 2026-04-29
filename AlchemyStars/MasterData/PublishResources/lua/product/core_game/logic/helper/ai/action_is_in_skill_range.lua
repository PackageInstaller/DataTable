require("action_is_base")
_class("ActionIsInSkillRange", ActionIsBase)
ActionIsInSkillRange = ActionIsInSkillRange

function ActionIsInSkillRange:Constructor()
end

function ActionIsInSkillRange:OnUpdate()
  if AINewNode.IsEntityDead(self.m_entityOwn) then
    return AINewNodeStatus.Failure
  end
  local entityCaster = self.m_entityOwn
  local aiComponent = entityCaster:AI()
  if nil == aiComponent then
    return AINewNodeStatus.Failure
  end
  local nSkillID = self:GetLogicData(1)
  local cSkillID = self:GetLogicData(-1)
  if cSkillID then
    nSkillID = cSkillID
  end
  local entityTarget = aiComponent:GetTargetEntity()
  local isTargetInSkillRange = false
  if 0 < nSkillID then
    isTargetInSkillRange = self:IsEntityInSkillRange(nSkillID, entityTarget)
  end
  local bSuccess = 0 < nSkillID and isTargetInSkillRange
  if bSuccess then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end
