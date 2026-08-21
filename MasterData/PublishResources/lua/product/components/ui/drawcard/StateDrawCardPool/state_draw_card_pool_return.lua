_class("StateDrawCardPoolReturn", State)
StateDrawCardPoolReturn = StateDrawCardPoolReturn

function StateDrawCardPoolReturn:Init()
  self._fsm = self:GetFsm()
  self._ui = self._fsm:GetData()
  self.lockKey = "StateDrawCardPoolReturn"
end

function StateDrawCardPoolReturn:OnEnter(TT, ...)
  self:Init()
  self._ui:Lock(self.lockKey)
  self:Return(TT)
end

function StateDrawCardPoolReturn:OnExit(TT)
  if self._ui then
    self._ui:InitLogoPos(true)
  end
  if self._ui.uieff then
    self._ui.uieff:SetActive(false)
  end
  self._ui:UnLock(self.lockKey)
end

function StateDrawCardPoolReturn:Destroy()
  self._fsm = nil
  self._ui = nil
end

function StateDrawCardPoolReturn:Return(TT)
  local half = self._ui:GetWidthHalf()
  local maxDuration = 0.5
  local duration = self._ui.bgLogo.anchoredPosition.x / half * maxDuration
  duration = maxDuration - Mathf.Clamp(duration, 0, maxDuration)
  self._ui.bgLogo:DOAnchorPosX(half, duration):OnUpdate(function()
    if self._ui then
      self._ui:OnBGLogoMoving()
    end
  end):OnComplete(function()
    if self._fsm then
      self._fsm:ChangeState(StateDrawCardPool.Init)
    end
  end)
end
