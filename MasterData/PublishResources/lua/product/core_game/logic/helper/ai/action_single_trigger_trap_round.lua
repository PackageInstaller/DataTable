require("ai_node_new")
_class("ActionSingleTriggerTrapRound", AINewNode)
ActionSingleTriggerTrapRound = ActionSingleTriggerTrapRound

function ActionSingleTriggerTrapRound:Constructor()
  self.m_nWorkIndexX = 1
  self._skillID = 0
end

function ActionSingleTriggerTrapRound:InitializeNode(cfg, context, parentNode, configData)
  ActionSingleTriggerTrapRound.super.InitializeNode(self, cfg, context, parentNode, configData)
  if configData then
    if type(configData) == "table" then
      self.m_nWorkIndexX = configData[1]
    else
      self.m_nWorkIndexX = configData or 1
    end
  end
end

function ActionSingleTriggerTrapRound:Update()
  local vecSkillLists = self:GetConfigSkillList()
  if vecSkillLists then
    local nGameRound = self:GetGameRountNow() or 1
    local useRound = nGameRound % #vecSkillLists
    if useRound == 0 then
      useRound = #vecSkillLists
    end
    self._skillID = vecSkillLists[useRound]
  end
  return AINewNodeStatus.Success
end

function ActionSingleTriggerTrapRound:GetActionSkillID()
  if self.m_entityOwn:BuffComponent():HasFlag(BuffFlags.Benumb) then
    return 0
  end
  return self._skillID
end
