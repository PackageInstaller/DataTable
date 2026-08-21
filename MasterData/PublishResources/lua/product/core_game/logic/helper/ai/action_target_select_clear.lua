require("ai_node_new")
_class("ActionTargetSelectClear", AINewNode)
ActionTargetSelectClear = ActionTargetSelectClear

function ActionTargetSelectClear:Constructor()
end

function ActionTargetSelectClear:Reset()
  ActionTargetSelectClear.super.Reset(self)
end

function ActionTargetSelectClear:OnBegin()
  local aiCmpt = self.m_entityOwn:AI()
  self:ResetTarget()
end

function ActionTargetSelectClear:OnUpdate()
  local aiCmpt = self.m_entityOwn:AI()
  local entityPlayer = aiCmpt:GetTargetDefault()
  self:ResetTarget()
  self:PrintDebugLog("目标清空，玩家ID = ", entityPlayer:GetID())
  return AINewNodeStatus.Success
end

function ActionTargetSelectClear:OnEnd()
end

function ActionTargetSelectClear:ResetTarget()
  self:SetRuntimeData("Target", nil)
end
