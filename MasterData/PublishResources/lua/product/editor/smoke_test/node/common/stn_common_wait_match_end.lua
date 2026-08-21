require("stn_common_wait_game_event")
_class("Common_WaitMatchEnd", Common_WaitGameEvent)
Common_WaitMatchEnd = Common_WaitMatchEnd

function Common_WaitMatchEnd:Constructor(pManger, nEventType)
  self.m_nEventType = GameEventType.OnGameOver
end

function Common_WaitMatchEnd:_OnEvent(matchResult)
  local bVictory = matchResult.victory
  local runData = self.m_pManager:GetMissionRunData()
  runData:SetLastBattleResult(bVictory)
  if bVictory then
    self.m_nLogicResult = 1
    runData:ResetRetryCount()
  else
    self.m_nLogicResult = 0
    runData:AppendRetryCount()
  end
  return Common_WaitMatchEnd.super._OnEvent(self, matchResult)
end
