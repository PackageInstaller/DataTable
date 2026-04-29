_class("StateDrawCardPoolTurn", State)
StateDrawCardPoolTurn = StateDrawCardPoolTurn

function StateDrawCardPoolTurn:Init()
  self._fsm = self:GetFsm()
  self._ui = self._fsm:GetData()
  self.lockKey = "StateDrawCardPoolTurn"
end

function StateDrawCardPoolTurn:OnEnter(TT, ...)
  self:Init()
  if self._ui then
    self._ui:Lock(self.lockKey)
  end
  local idx = table.unpack({
    ...
  })
  if self._ui then
    local tPet, len = self._ui:GetPetsByIndex(idx)
    local anim, animName = self._ui:GetAnimNameSwitchPool(len)
    anim:Play(animName)
    self._ui:DoIndexerTween(idx)
  end
  self.isPlaying = true
  GameGlobal.Timer():AddEventTimes(417, TimerTriggerCount.Once, function()
    self.isPlaying = false
  end)
  while self.isPlaying do
    if self._ui then
      self._ui:OnBGLogoMoving()
    end
    YIELD(TT)
  end
  if self._ui then
    self._ui:Refresh(idx)
  end
  if self._fsm then
    self._fsm:ChangeState(StateDrawCardPool.TurnNext)
  end
end

function StateDrawCardPoolTurn:OnExit(TT)
  if self._ui then
    self._ui:UnLock(self.lockKey)
  end
end

function StateDrawCardPoolTurn:Destroy()
  if self._ui == nil or self._fsm == nil then
    return
  end
  self._ui:UnLock(self.lockKey)
  self._fsm = nil
  self._ui = nil
end
