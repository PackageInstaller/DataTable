require("ai_node_new")
_class("ActionAiBeginTrap", AINewNode)
ActionAiBeginTrap = ActionAiBeginTrap

function ActionAiBeginTrap:Constructor()
  self.m_bStartLogic = false
end

function ActionAiBeginTrap:OnBegin()
  local aiComponent = self.m_entityOwn:AI()
  if nil == aiComponent then
    return
  end
  local posSelf = self:GetSelfPos()
  local bEnableStart = false
  local stBeginReason = ""
  for i = 1, 1 do
    local nMobilityTotal = aiComponent:GetMobilityValid()
    if BattleConst.UseObsoleteAI and nMobilityTotal <= 0 then
      break
    end
    local isRoundEnd = aiComponent:IsAIRoundEnd()
    if isRoundEnd then
      stBeginReason = "AI逻辑<回合已经结束>"
      break
    end
    bEnableStart = true
    break
  end
  self.m_bStartLogic = bEnableStart
  aiComponent:SetMoveState(AIMoveState.MoveEnd)
  local runCount = self:GetRuntimeData("RunRoundCount") or 1
  self:SetRuntimeData("RunRoundCount", runCount + 1)
end

function ActionAiBeginTrap:OnUpdate()
  if self.m_bStartLogic then
    return AINewNodeStatus.Success
  else
    return AINewNodeStatus.Failure
  end
end
