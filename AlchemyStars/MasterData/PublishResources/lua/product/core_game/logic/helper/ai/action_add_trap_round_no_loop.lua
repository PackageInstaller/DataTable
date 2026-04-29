require("ai_node_new")
_class("ActionAddTrapRoundNoLoop", AINewNode)
ActionAddTrapRoundNoLoop = ActionAddTrapRoundNoLoop

function ActionAddTrapRoundNoLoop:OnUpdate()
  local attributeCmpt = self.m_entityOwn:Attributes()
  if attributeCmpt then
    local round = attributeCmpt:GetAttribute("CurrentRound")
    local total = attributeCmpt:GetAttribute("TotalRound")
    if round and total then
      round = round + 1
      attributeCmpt:Modify("CurrentRound", round)
    end
    local res = DataAttributeResult:New(self.m_entityOwn:GetID(), "CurrentRound", round)
    self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
  end
  return AINewNodeStatus.Success
end
