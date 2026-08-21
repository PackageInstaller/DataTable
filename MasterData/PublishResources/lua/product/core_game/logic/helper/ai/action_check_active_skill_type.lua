require("ai_node_new")
_class("ActionCheckActiveSkillType", AINewNode)
ActionCheckActiveSkillType = ActionCheckActiveSkillType

function ActionCheckActiveSkillType:OnUpdate()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local activeSkillCmpt = teamEntity:ActiveSkill()
  local activeSkillID = activeSkillCmpt:GetActiveSkillID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local skillTags = skillConfigData:GetSkillTag()
  local attributeCmpt = self.m_entityOwn:Attributes()
  local checkActiveSkillType = attributeCmpt:GetAttribute("AntiActiveSkillType")
  if not checkActiveSkillType then
    return AINewNodeStatus.Success
  end
  for i, v in ipairs(checkActiveSkillType) do
    if v == -1 then
      return AINewNodeStatus.Success
    end
    if table.icontains(skillTags, v) then
      return AINewNodeStatus.Success
    end
  end
  return AINewNodeStatus.Failure
end
