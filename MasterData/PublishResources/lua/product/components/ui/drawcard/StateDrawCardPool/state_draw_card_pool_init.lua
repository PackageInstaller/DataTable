_class("StateDrawCardPoolInit", State)
StateDrawCardPoolInit = StateDrawCardPoolInit

function StateDrawCardPoolInit:Init()
  self._fsm = self:GetFsm()
  self._ui = self._fsm:GetData()
  self._maskSpeedTimes = 4
  self:InitDragField()
  self.selfRect = self._ui.selfRect
  self.bgLogo = self._ui.bgLogo
  self.layer1Rect = self._ui.layer1Rect
  self._half = self._ui:GetWidthHalf()
  self._len = table.count(self._ui._poolDataList)
  if self._len <= 0 then
    Log.fatal("### not data in _poolDataList")
  end
  self._flipRatio = Cfg.cfg_global.ui_draw_card_flip_ratio.FloatValue
  self._flipRatio = Mathf.Clamp01(self._flipRatio)
  self._flipX = self._half * self._flipRatio
end

function StateDrawCardPoolInit:OnEnter(TT, ...)
  self:Init()
  if self._ui then
    self._ui:InitLogoPos(true)
    self._ui:FlushLogos(self._ui:GetIndex() + 1)
  end
  self:ShowHideUIEff(false)
  self._ui:RegUIEventTriggerListener(function(ped)
    self:OnBeginDrag(ped)
  end, function(ped)
    self:OnDrag(ped)
  end, function(ped)
    self:OnEndDrag(ped)
  end)
  self._ui:DOLock(false)
end

function StateDrawCardPoolInit:OnExit(TT)
  self._ui:RegUIEventTriggerListener(function(ped)
  end, function(ped)
  end, function(ped)
  end)
  self._ui:DOLock(true)
end

function StateDrawCardPoolInit:Destroy()
  self._fsm = nil
  self._ui = nil
end

function StateDrawCardPoolInit:InitDragField()
  self._xBegainDrag = nil
  self._xCurDrag = nil
  self._posBGLogo = Vector2.zero
end

function StateDrawCardPoolInit:OnUpdate()
  if not self._ui or not self._ui.etl.IsDragging then
    return
  end
  if not self._xBegainDrag or not self._xCurDrag then
    return
  end
  local deltaX = self._xCurDrag - self._xBegainDrag
  if deltaX == 0 then
    return
  end
  if self:IsEdge(deltaX) then
    return
  end
  self:UpdateLogoByDelta(deltaX)
  self._posBGLogo.x = self:ClampBGLogo(self._half - Mathf.Abs(deltaX) * self._maskSpeedTimes, deltaX)
  self.bgLogo.anchoredPosition = self._posBGLogo
  self._ui:OnBGLogoMoving()
  if self.bgLogo.anchoredPosition.x <= self._flipX then
    self:OnEndDrag()
  end
end

function StateDrawCardPoolInit:UpdateLogoByDelta(deltaX)
  if 0 < deltaX then
    if not self._ui:IsFlip() then
      self._ui:InitLogoPos(false)
      self._ui:FlushLogos(self._ui:GetIndex() - 1)
    end
  else
    if deltaX < 0 and self._ui:IsFlip() then
      self._ui:InitLogoPos(true)
      self._ui:FlushLogos(self._ui:GetIndex() + 1)
    else
    end
  end
end

function StateDrawCardPoolInit:IsEdge(deltaX)
  if 0 < deltaX and self._ui:GetIndex() == 1 then
    return true
  end
  if deltaX < 0 and self._ui:GetIndex() == self._len then
    return true
  end
  return false
end

function StateDrawCardPoolInit:ClampBGLogo(x, deltaX)
  if self:IsEdge(deltaX) then
    return self._half
  end
  return x
end

function StateDrawCardPoolInit:ShowHideUIEff(isShow)
  if self._ui.uieff then
    self._ui.uieff:SetActive(isShow)
  end
end

function StateDrawCardPoolInit:OnBeginDrag(ped)
  local deltaX = ped.delta.x
  if self:IsEdge(deltaX) then
    return
  end
  self:ShowHideUIEff(true)
  self:UpdateLogoByDelta(deltaX)
  local pos = StateDrawCardPoolInit.ScreenPointToLocalPointInRectangle(self.selfRect, ped)
  self._xBegainDrag = pos.x
end

function StateDrawCardPoolInit:OnDrag(ped)
  local pos = StateDrawCardPoolInit.ScreenPointToLocalPointInRectangle(self.selfRect, ped)
  self._xCurDrag = pos.x
end

function StateDrawCardPoolInit:OnEndDrag(ped)
  self:InitDragField()
  if self.bgLogo.anchoredPosition.x <= self._flipX then
    local idx = 0
    local isRight = false
    if self._ui:IsFlip() then
      idx = self._ui:GetIndex() - 1
      isRight = false
    else
      idx = self._ui:GetIndex() + 1
      isRight = true
    end
    if 0 < idx and idx <= self._len then
      local duration = self._ui:GetClickArrowDuration()
      self._fsm:ChangeState(StateDrawCardPool.ClickArrow, isRight, idx, duration * self._flipRatio)
    end
    if ped == nil then
      self._ui:HideCtrlVedioWidetAndHeart()
    end
  else
    self._fsm:ChangeState(StateDrawCardPool.Return)
  end
end

function StateDrawCardPoolInit.ScreenPointToLocalPointInRectangle(rect, ped)
  local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, ped.position, ped.pressEventCamera, nil)
  return pos
end
