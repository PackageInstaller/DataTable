require("action_is_base")
_class("ActionCastState", ActionIsBase)
ActionCastState = ActionCastState

function ActionCastState:OnBegin()
  self.m_stActionName = "检查施法状态"
end

function ActionCastState:OnUpdate()
  local aiCmpt = self.m_entityOwn:AI()
  local curState = aiCmpt:GetCastState()
  self:PrintLog("检查施法状态：" .. curState)
  return AINewNodeStatus.Other + curState
end
