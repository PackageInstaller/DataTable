require("ai_node_new")
_class("ActionSelectEndReason", AINewNode)
ActionSelectEndReason = ActionSelectEndReason

function ActionSelectEndReason:Constructor()
end

function ActionSelectEndReason:OnUpdate()
  local aiComponent = self.m_entityOwn:AI()
  local endReason = AIEndReasonType.NoMobility
  for i = 1, 1 do
    local nMobilityTotal = aiComponent:GetMobilityValid()
    if BattleConst.UseObsoleteAI and nMobilityTotal <= 0 then
      endReason = AIEndReasonType.NoMobility
      break
    end
    local bMineDead = AINewNode.IsEntityDead(self.m_entityOwn)
    if bMineDead then
      endReason = AIEndReasonType.SelfDead
      break
    end
    local bTargetDead = AINewNode.IsEntityDead(aiComponent:GetTargetEntity())
    if bTargetDead then
      endReason = AIEndReasonType.TargetDead
      break
    end
    local buffCmpt = self.m_entityOwn:BuffComponent()
    if buffCmpt then
      local isStun = buffCmpt:HasFlag(BuffFlags.SkipTurn)
      if isStun then
        endReason = AIEndReasonType.SkipTurn
        break
      end
    end
    local isRoundEnd = aiComponent:IsAIRoundEnd()
    if isRoundEnd then
      endReason = AIEndReasonType.RoundEnd
      break
    end
  end
  return AINewNodeStatus.Other + endReason
end
