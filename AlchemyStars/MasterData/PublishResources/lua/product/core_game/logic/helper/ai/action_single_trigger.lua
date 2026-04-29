require("ai_node_new")
_class("ActionSingleTrigger", AINewNode)
ActionSingleTrigger = ActionSingleTrigger

function ActionSingleTrigger:Constructor()
  self.m_nWorkIndexX = 1
  self.m_nWorkSkillID = 0
end

function ActionSingleTrigger:InitializeNode(cfg, context, parentNode, configData)
  ActionSingleTrigger.super.InitializeNode(self, cfg, context, parentNode, configData)
  if configData then
    if type(configData) == "table" then
      self.m_nWorkIndexX = configData[1]
    else
      self.m_nWorkIndexX = configData or 1
    end
  end
end

function ActionSingleTrigger:Update()
  self.m_nWorkSkillID = self:_GetConfigSkillID()
  return AINewNodeStatus.Success
end

function ActionSingleTrigger:GetActionSkillID()
  if self.m_entityOwn:BuffComponent():HasFlag(BuffFlags.Benumb) then
    return 0
  end
  return self.m_nWorkSkillID
end

function ActionSingleTrigger:_GetConfigSkillID()
  local vecSkillList = self:GetConfigSkillList()
  if vecSkillList then
    return vecSkillList[self.m_nWorkIndexX]
  end
end
