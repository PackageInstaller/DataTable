require("action_skill_target_in_skill_range")
_class("ActionMoveGroupSkillTargetInSkillRange", ActionSkillTargetInSkillRange)
ActionMoveGroupSkillTargetInSkillRange = ActionMoveGroupSkillTargetInSkillRange

function ActionMoveGroupSkillTargetInSkillRange:Constructor()
end

function ActionMoveGroupSkillTargetInSkillRange:Reset()
  ActionMoveGroupSkillTargetInSkillRange.super.Reset(self)
  self:GetAllGroupMonster()
end

function ActionMoveGroupSkillTargetInSkillRange:GetFakeBodyArea()
  local bodyArea = {
    Vector2(0, 0)
  }
  local posSelf = self.m_entityOwn:GridLocation().Position
  for i, monster in ipairs(self._sameGroupMonsterList) do
    if monster:GetID() ~= self.m_entityOwn:GetID() then
      local offset = monster:GetGridPosition() - posSelf
      table.insert(bodyArea, offset)
    end
  end
  return bodyArea
end

function ActionMoveGroupSkillTargetInSkillRange:OnUpdate()
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
