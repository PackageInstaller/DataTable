require("ai_node_new")
_class("ActionCheckFlag", AINewNode)
ActionCheckFlag = ActionCheckFlag

function ActionCheckFlag:Constructor()
end

function ActionCheckFlag:OnUpdate()
  local flag = self:GetLogicData(-1)
  local aiComponent = self.m_entityOwn:AI()
  local flagState = aiComponent:GetRuntimeData(flag)
  if flagState then
    return AINewNodeStatus.Success
  else
    return AINewNodeStatus.Failure
  end
end
