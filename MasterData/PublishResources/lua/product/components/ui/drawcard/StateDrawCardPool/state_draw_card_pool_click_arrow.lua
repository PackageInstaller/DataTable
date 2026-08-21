_class("StateDrawCardPoolClickArrow", State)
StateDrawCardPoolClickArrow = StateDrawCardPoolClickArrow

function StateDrawCardPoolClickArrow:Init()
  self._fsm = self:GetFsm()
  self._ui = self._fsm:GetData()
  self.lockKey = "StateDrawCardPoolClickArrow"
end

function StateDrawCardPoolClickArrow:OnEnter(TT, ...)
  self:Init()
  self._ui:Lock(self.lockKey)
  local isRight, idx, duration = table.unpack({
    ...
  })
  if self._ui then
    self._ui:InitLogoPos(isRight)
    self._ui:FlushLogos(idx)
  end
  if self._ui.uieff then
    self._ui.uieff:SetActive(true)
  end
  duration = duration or 0
  self:PlaySwitchAuto(isRight, idx, duration)
end

function StateDrawCardPoolClickArrow:OnExit(TT)
  self._ui:UnLock(self.lockKey)
end

function StateDrawCardPoolClickArrow:Destroy()
  self._fsm = nil
  self._ui = nil
end

function StateDrawCardPoolClickArrow:PlaySwitchAuto(isRight, idx, duration)
  self._ui.bgLogo:DOAnchorPosX(0, duration):OnUpdate(function()
    if self._ui then
      self._ui:OnBGLogoMoving()
    end
  end):OnComplete(function()
    self._fsm:ChangeState(StateDrawCardPool.Turn, idx)
  end)
end
