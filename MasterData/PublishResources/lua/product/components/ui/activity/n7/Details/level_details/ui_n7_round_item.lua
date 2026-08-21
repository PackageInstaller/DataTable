_class("UIN7RoundItem", UICustomWidget)
UIN7RoundItem = UIN7RoundItem

function UIN7RoundItem:Constructor()
  self._callback = nil
  self._index = 0
  self._myCfg = nil
  self._selectState = false
  self._isLast = false
end

function UIN7RoundItem:OnShow(uiParams)
  self:_GetComponent()
end

function UIN7RoundItem:_GetComponent()
  self.lock = self:GetGameObject("lock")
  self.unlock = self:GetGameObject("unlock")
  self.select = self:GetGameObject("select")
  self.arrowsLock = self:GetGameObject("arrowsLock")
  self.arrowsUnlock = self:GetGameObject("arrowsUnlock")
  self.roundNumberLockText = self:GetUIComponent("UILocalizationText", "roundNumberLockText")
  self.roundNumberUnlockText = self:GetUIComponent("UILocalizationText", "roundNumberUnlockText")
end

function UIN7RoundItem:SetData(i, myCfg, callback)
  self._index = i
  self._myCfg = myCfg
  self._callback = callback
  local state = N7RoundState.Lock
  if self.myCfg and self.myCfg.NeedMissionId == 0 then
    state = N7RoundState.UnLock
  end
  self:_SetState(state)
end

function UIN7RoundItem:_SetState(state)
  self.state = state
  if self.state == N7RoundState.Lock then
    self.lock:SetActive(true)
    self.unlock:SetActive(false)
    if self._isLast == false then
      self.arrowsUnlock:SetActive(false)
      self.arrowsLock:SetActive(true)
    end
  elseif self.state == N7RoundState.UnLock then
    self.lock:SetActive(false)
    self.unlock:SetActive(true)
    if self._isLast == false then
      self.arrowsUnlock:SetActive(true)
      self.arrowsLock:SetActive(false)
    end
  end
end

function UIN7RoundItem:_OnClickHandel()
  self:SetSelectState(true)
  if self._callback then
    self._callback(self._index)
  end
end

function UIN7RoundItem:SetSelectState(selectState)
  self._selectState = selectState
  self.select:SetActive(self._selectState)
end

function UIN7RoundItem:CloseArrows()
  self._isLast = true
  self.arrowsLock:SetActive(false)
  self.arrowsUnlock:SetActive(false)
end

function UIN7RoundItem:GetState()
  return self.state
end

function UIN7RoundItem:GetMissionID()
  return self._myCfg.MissionID
end

function UIN7RoundItem:btnLockOnClick(go)
  self:_OnClickHandel()
end

function UIN7RoundItem:btnUnlockOnClick(go)
  self:_OnClickHandel()
end
