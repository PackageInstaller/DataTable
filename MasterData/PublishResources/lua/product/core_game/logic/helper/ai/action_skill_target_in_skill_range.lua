require("action_is_base")
_class("ActionSkillTargetInSkillRange", ActionIsBase)
ActionSkillTargetInSkillRange = ActionSkillTargetInSkillRange

function ActionSkillTargetInSkillRange:Constructor()
end

function ActionSkillTargetInSkillRange:OnUpdate()
  local entityCaster = self.m_entityOwn
  local aiComponent = entityCaster:AI()
  if nil == aiComponent then
    return AINewNodeStatus.Failure
  end
  local nSkillID = self:GetLogicData(1)
  local configSkillID = self:GetLogicSkillID()
  if configSkillID then
    nSkillID = configSkillID
  end
  local id = entityCaster:GetID()
  local bSuccess = 0 < nSkillID and self:IsSkillTargetInSkillRange(nSkillID)
  if bSuccess then
    self:PrintLog("判断技能目标在技能范围内成功")
    return AINewNodeStatus.Success
  end
  self:PrintLog("判断技能目标在技能范围内失败")
  return AINewNodeStatus.Failure
end
