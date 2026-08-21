require("action_is_base")
_class("ActionIsAttachPosValid", ActionIsBase)
ActionIsAttachPosValid = ActionIsAttachPosValid

function ActionIsAttachPosValid:Constructor()
end

function ActionIsAttachPosValid:OnUpdate()
  if AINewNode.IsEntityDead(self.m_entityOwn) then
    return AINewNodeStatus.Failure
  end
  local aiComponent = self.m_entityOwn:AI()
  local nSkillID = self:GetLogicData(1)
  local selfPos = self.m_entityOwn:GetGridPosition()
  local dir = self.m_entityOwn:GridLocation().Direction
  local selfBodyArea = self.m_entityOwn:BodyArea():GetArea()
  local skillRangeData = self:CalculateSkillRange(nSkillID, selfPos, dir, selfBodyArea)
  local entityTarget = aiComponent:GetTargetEntity()
  if not entityTarget or #skillRangeData == 0 then
    return AINewNodeStatus.Failure
  end
  local bSuccess = self:_IsTargetInSkillRange(entityTarget, skillRangeData)
  if bSuccess then
    local targetPos = entityTarget:GetGridPosition()
    local bodyArea = entityTarget:GetCoverAreaList(targetPos)
    local bConnected = false
    for key, posWork in ipairs(bodyArea) do
      if self:IsPosConnected(selfPos, posWork) then
        bConnected = true
        break
      end
    end
    bSuccess = bConnected
  end
  if true == bSuccess then
    self:PrintLog("攻击位置<有效>: skillID = ", nSkillID)
    return AINewNodeStatus.Success
  else
    local configService = self._world:GetService("Config")
    local skillConfigData = configService:GetSkillConfigData(nSkillID)
    if SkillTargetType.Monster == skillConfigData:GetSkillTargetType() then
      self:PrintLog("skillID = ", nSkillID, ", 同组范围攻击位置<有效>")
      return AINewNodeStatus.Success
    end
    self:PrintLog("攻击位置<无效>: skillID = ", nSkillID)
    return AINewNodeStatus.Failure
  end
  return AINewNodeStatus.Failure
end
