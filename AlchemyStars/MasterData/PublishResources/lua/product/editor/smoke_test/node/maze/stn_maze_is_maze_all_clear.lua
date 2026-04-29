require("stn_common_wait_game_event")
_class("CTestRobot_WaitMatchEnd", Common_WaitGameEvent)
CTestRobot_WaitMatchEnd = CTestRobot_WaitMatchEnd

function CTestRobot_WaitMatchEnd:Constructor(pManger, nEventType)
  self.m_nEventType = GameEventType.BattleResultFinish
end

function CTestRobot_WaitMatchEnd:_OnEvent(bVictory)
  if bVictory then
    local mazeModule = self.m_pGameCenter.GetModule(MazeModule)
    local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
    local mazeCreateInfo = matchEnterData:GetMazeCreateInfo()
    if mazeModule:IsLastLayerRoom(mazeCreateInfo.maze_version, mazeCreateInfo.maze_layer, mazeCreateInfo.maze_room_index) then
      self.m_nLogicResult = 2
    else
      self.m_nLogicResult = 1
    end
  else
    self.m_nLogicResult = 0
  end
  return CTestRobot_WaitMatchEnd.super._OnEvent(self, bVictory)
end
