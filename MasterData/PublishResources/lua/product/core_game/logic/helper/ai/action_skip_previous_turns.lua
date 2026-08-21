require("ai_node_new")
_class("ActionSkipPreviousTurns", AINewNode)
ActionSkipPreviousTurns = ActionSkipPreviousTurns

function ActionSkipPreviousTurns:Constructor()
  self._skipTurns = 0
  self._curSkipTurns = 0
  self._SaveRound = 0
end

function ActionSkipPreviousTurns:InitializeNode(cfg, context, logicOwn, configData)
  ActionSkipPreviousTurns.super.InitializeNode(self, cfg, context)
end

function ActionSkipPreviousTurns:OnBegin()
  self._skipTurns = self:GetLogicData(-1)
  local nGameRound = self:_GetGameRountNow()
  if self._SaveRound ~= nGameRound then
    self._curSkipTurns = self._curSkipTurns + 1
    self._SaveRound = nGameRound
  end
end

function ActionSkipPreviousTurns:OnUpdate()
  if self._curSkipTurns <= self._skipTurns then
    return AINewNodeStatus.Success
  else
    return AINewNodeStatus.Failure
  end
end

function ActionSkipPreviousTurns:_GetGameRountNow()
  local boardEntity = self._world:GetBoardEntity()
  local battleStatCmpt = self._world:BattleStat()
  local round = battleStatCmpt:GetCurWaveTotalRoundCount()
  return round
end
