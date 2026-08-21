require("action_cast_skill_base")
_class("ActionExchangeAITemplate", AINewNode)
ActionExchangeAITemplate = ActionExchangeAITemplate

function ActionExchangeAITemplate:OnBegin()
  local entity = self.m_entityOwn
  local newAIID = self:GetLogicData(-1)
  local aiids = {newAIID}
  entity:ReplaceAI(AILogicPeriodType.Main, aiids)
end
