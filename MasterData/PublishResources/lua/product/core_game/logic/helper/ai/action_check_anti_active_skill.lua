require("ai_node_new")
_class("ActionCheckAntiActiveSkill", AINewNode)
ActionCheckAntiActiveSkill = ActionCheckAntiActiveSkill

function ActionCheckAntiActiveSkill:OnUpdate()
  local attributeCmpt = self.m_entityOwn:Attributes()
  local aiCmpt = self.m_entityOwn:AI()
  aiCmpt:SetAntiSkill(false)
  local antiSkillEnabled = attributeCmpt:GetAttribute("AntiSkillEnabled")
  if antiSkillEnabled == 0 then
    return AINewNodeStatus.Failure
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local activeSkillCmpt = teamEntity:ActiveSkill()
  local activeSkillID = activeSkillCmpt:GetActiveSkillID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local skillTags = skillConfigData:GetSkillTag()
  local checkActiveSkillType = attributeCmpt:GetAttribute("AntiActiveSkillType")
  if checkActiveSkillType then
    local hasTag = false
    for i, v in ipairs(checkActiveSkillType) do
      if v == -1 then
        hasTag = true
        break
      end
      if table.icontains(skillTags, v) then
        hasTag = true
        break
      end
    end
    if hasTag == false then
      return AINewNodeStatus.Failure
    end
  end
  local activeSkillCount = attributeCmpt:GetAttribute("WaitActiveSkillCount") or 1
  local newActiveSkillCount = activeSkillCount - 1
  if newActiveSkillCount < 0 then
    newActiveSkillCount = 0
  end
  attributeCmpt:Modify("WaitActiveSkillCount", newActiveSkillCount)
  if newActiveSkillCount ~= 0 then
    return AINewNodeStatus.Failure
  end
  local curRoundAntiCount = attributeCmpt:GetAttribute("MaxAntiSkillCountPerRound") or 1
  if curRoundAntiCount < 1 then
    return AINewNodeStatus.Failure
  end
  aiCmpt:SetAntiSkill(true)
  return AINewNodeStatus.Success
end
