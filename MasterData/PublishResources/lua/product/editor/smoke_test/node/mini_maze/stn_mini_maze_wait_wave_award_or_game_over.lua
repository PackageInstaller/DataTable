require("base_state_node")
_class("MiniMazeWaitWaveAwardOrGameOver", CTestRobot_Base)
MiniMazeWaitWaveAwardOrGameOver = MiniMazeWaitWaveAwardOrGameOver

function MiniMazeWaitWaveAwardOrGameOver:Constructor(pManger, nEventType1, nEventType2, timeout)
  self.m_nEventType1 = nEventType1
  self.m_nEventType2 = nEventType2
  self.m_callback1 = nil
  self.m_callback2 = nil
  self.m_bEventTrigger = false
  if timeout then
    self._maxTimeoutMS = timeout * 0.001
  end
end

function MiniMazeWaitWaveAwardOrGameOver:OnBegin(...)
  self.m_nWaitStart = os.clock()
  self.m_bEventTrigger = false
  self:_AddListener()
  return MiniMazeWaitWaveAwardOrGameOver.super.OnBegin(self, ...)
end

function MiniMazeWaitWaveAwardOrGameOver:OnWorking()
  local isTimeout = self._maxTimeoutMS and os.clock() - self.m_nWaitStart > self._maxTimeoutMS or false
  if not self.m_bEventTrigger and not isTimeout then
    return false
  end
  return MiniMazeWaitWaveAwardOrGameOver.super.OnWorking(self)
end

function MiniMazeWaitWaveAwardOrGameOver:OnEnd(...)
  self:_RemoveListener()
  return MiniMazeWaitWaveAwardOrGameOver.super.OnEnd(self, ...)
end

function MiniMazeWaitWaveAwardOrGameOver:_AddListener()
  self.m_callback1 = GameHelper:GetInstance():CreateCallback(self._OnEvent1, self)
  self.m_pGameCenter.EventDispatcher():AddCallbackListener(self.m_nEventType1, self.m_callback1)
  self.m_callback2 = GameHelper:GetInstance():CreateCallback(self._OnEvent2, self)
  self.m_pGameCenter.EventDispatcher():AddCallbackListener(self.m_nEventType2, self.m_callback2)
end

function MiniMazeWaitWaveAwardOrGameOver:_RemoveListener()
  self.m_pGameCenter.EventDispatcher():RemoveCallbackListener(self.m_nEventType1, self.m_callback1)
  self.m_pGameCenter.EventDispatcher():RemoveCallbackListener(self.m_nEventType2, self.m_callback2)
end

function MiniMazeWaitWaveAwardOrGameOver:_OnEvent1(...)
  self.m_bEventTrigger = true
  self.m_nLogicResult = 0
  self:Log(self, "WaitEvent Trigger Event = ", self.m_nEventType1)
end

function MiniMazeWaitWaveAwardOrGameOver:_OnEvent2(matchResult)
  self.m_bEventTrigger = true
  local bVictory = matchResult.victory
  local runData = self.m_pManager:GetMissionRunData()
  runData:SetLastBattleResult(bVictory)
  if bVictory then
    self.m_nLogicResult = 2
    runData:ResetRetryCount()
  else
    self.m_nLogicResult = 1
    runData:AppendRetryCount()
  end
  self:Log(self, "WaitEvent Trigger Event = ", self.m_nEventType2)
end
