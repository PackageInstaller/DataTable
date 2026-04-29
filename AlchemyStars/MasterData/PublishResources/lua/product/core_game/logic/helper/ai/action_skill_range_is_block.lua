require("action_is_base")
_class("ActionSkillRangeIsBlock", ActionIsBase)
ActionSkillRangeIsBlock = ActionSkillRangeIsBlock

function ActionSkillRangeIsBlock:Constructor()
end

function ActionSkillRangeIsBlock:OnUpdate()
  local entityCaster = self.m_entityOwn
  local aiComponent = entityCaster:AI()
  if nil == aiComponent then
    return AINewNodeStatus.Failure
  end
  local nSkillID = self:GetLogicData(1)
  local configSkillID = self:GetLogicSkillID()
  local blockType = GetBlockFlagByValue(self:GetLogicData(-3))
  if configSkillID then
    nSkillID = configSkillID
  end
  local id = entityCaster:GetID()
  local bSuccess = 0 < nSkillID and self:SkillRangeIsBlock(nSkillID, blockType)
  if bSuccess then
    self:PrintLog("判断技能范围阻挡 不可行动")
    self:PrintDebugLog("判断技能范围阻挡 不可行动")
    return AINewNodeStatus.Failure
  end
  self:PrintLog("判断技能范围阻挡 可行动")
  self:PrintDebugLog("判断技能范围阻挡 可行动")
  return AINewNodeStatus.Success
end
