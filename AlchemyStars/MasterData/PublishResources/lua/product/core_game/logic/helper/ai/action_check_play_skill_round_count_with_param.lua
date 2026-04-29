require("ai_node_new")
_class("ActionCheckPlaySkillRoundCountWithParam", AINewNode)
ActionCheckPlaySkillRoundCountWithParam = ActionCheckPlaySkillRoundCountWithParam

function ActionCheckPlaySkillRoundCountWithParam:OnUpdate()
  local attrCmpt = self.m_entityOwn:Attributes()
  local useGameRound = self:GetLogicData(-2) or 0
  local curRound = attrCmpt:GetAttribute("CurrentRound")
  if 0 < useGameRound then
    curRound = self:GetGameRountNow() % useGameRound
    if curRound == 0 then
      curRound = useGameRound
    end
  end
  local str = self:GetLogicData(-1)
  if str then
    local ss = string.split(str, ",")
    local rounds = {}
    for i, s in ipairs(ss) do
      rounds[#rounds + 1] = tonumber(s)
    end
    if table.intable(rounds, curRound) then
      return AINewNodeStatus.Success
    end
  else
    local totalRound = attrCmpt:GetAttribute("TotalRound")
    if totalRound == curRound then
      return AINewNodeStatus.Success
    end
  end
  return AINewNodeStatus.Failure
end
