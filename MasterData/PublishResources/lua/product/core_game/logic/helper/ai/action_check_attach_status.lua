require("ai_node_new")
_class("ActionCheckAttachStatus", AINewNode)
ActionCheckAttachStatus = ActionCheckAttachStatus

function ActionCheckAttachStatus:Constructor()
end

function ActionCheckAttachStatus:OnUpdate()
  local aiCmpt = self.m_entityOwn:AI()
  if aiCmpt:GetRuntimeData("AttachMonsterID") then
    return AINewNodeStatus.Success
  elseif aiCmpt:GetRuntimeData("DetachBeginRunRound") then
    local detachWaveIndex = self:GetRuntimeData("DetachBeginWaveIndex")
    local waveIndex = self:GetWaveIndexNow()
    if detachWaveIndex < waveIndex then
      aiCmpt:SetRuntimeData("DetachBeginRunRound", nil)
      return AINewNodeStatus.Failure
    elseif aiCmpt:GetRuntimeData("DetachBeginRunRound") <= self:GetGameRountNow() then
      aiCmpt:SetRuntimeData("DetachBeginRunRound", nil)
      return AINewNodeStatus.Failure
    else
      return AINewNodeStatus.Success
    end
  else
    return AINewNodeStatus.Failure
  end
end
