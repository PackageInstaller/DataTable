require("ai_node_new")
_class("ActionCWOrCCWByRound", AINewNode)
ActionCWOrCCWByRound = ActionCWOrCCWByRound

function ActionCWOrCCWByRound:OnUpdate()
  local attrCmpt = self.m_entityOwn:Attributes()
  local totalRound = attrCmpt:GetAttribute("TotalRound")
  local nGameRound = self:GetGameRountNow()
  if nGameRound % totalRound == 0 then
    if nGameRound / totalRound % 2 == 0 then
      return AINewNodeStatus.Success
    else
      return AINewNodeStatus.Failure
    end
  end
  return AINewNodeStatus.Other + 1
end
