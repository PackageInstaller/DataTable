_class("UIHomelandMinimapIconTrace", UIHomelandMinimapIconBase)
UIHomelandMinimapIconTrace = UIHomelandMinimapIconTrace

function UIHomelandMinimapIconTrace:OnShow(uiParams)
  self._selectGO = self:GetGameObject("Selected")
  self._tracePointGO = self:GetGameObject("tracePoint")
  self._arrivalGO = self:GetGameObject("arrival")
  self._arrowPoint = self:GetGameObject("arrowPoint")
  self._roundGO = self:GetGameObject("round")
  self._bgGo = self:GetGameObject("bg")
  self._pointGo = self:GetGameObject("point")
  self:AttachEvent(GameEventType.OnGetTracePoint, self.OnEnter)
  self:AttachEvent(GameEventType.OnLeaveTracePoint, self.OnLeave)
  self:AttachEvent(GameEventType.TracePointInOutMiniMap, self.ShowMiniMapAni)
  self._fx = self:GetGameObject("AnimFx")
  self._fxAnim = self:GetUIComponent("Animation", "AnimFx")
  self.screenOffset = Vector2(UnityEngine.Screen.width / 2, UnityEngine.Screen.height / 2)
  self._isInView = true
  self._showOnceOnEnter = false
  self._showOnceOnLeave = false
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIHomelandMinimapIconTrace:OnInitDone()
  self.birthId = self:GetIconData():GetIndex()
  self.info = self:GetIconData()
  if not self.info._params.isNpc then
    self._maxSize = HomelandMinimapConst.GetMapSize()
    local len = HomelandMinimapConst.RealMapMaxPosition() - HomelandMinimapConst.RealMapMinPosition()
    local sc = math.abs(len.x)
    sc = 4000 / sc
    self._radius = self.info._params.radius
    self._scale = self._radius / sc * 1.4
  end
end

function UIHomelandMinimapIconTrace:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:DetachEvent(GameEventType.OnGetTracePoint, self.OnEnter)
  self:DetachEvent(GameEventType.OnLeaveTracePoint, self.OnLeave)
  self:DetachEvent(GameEventType.TracePointInOutMiniMap, self.ShowMiniMapAni)
end

function UIHomelandMinimapIconTrace:OnSelected()
  self._selectGO:SetActive(true)
end

function UIHomelandMinimapIconTrace:OnUnSelected()
  self._selectGO:SetActive(false)
end

function UIHomelandMinimapIconTrace:GetShowIconOffset()
  return Vector2(0, 0)
end

function UIHomelandMinimapIconTrace:GetShowName()
  return ""
end

function UIHomelandMinimapIconTrace:OnEnter(index)
  if self.info._id == HomelandMapIconType.TracePoint and self.info._index == index and not self._showOnceOnEnter then
    self._roundGO:SetActive(not self.info._params.isNpc)
    self._roundGO.transform.localScale = Vector3(self._scale, self._scale, 0)
    self:ShowAni(false)
    self._showOnceOnEnter = true
    self._showOnceOnLeave = false
  end
end

function UIHomelandMinimapIconTrace:OnLeave(index)
  if self.info._id == HomelandMapIconType.TracePoint and self.info._index == index and not self._showOnceOnLeave then
    self._roundGO:SetActive(false)
    self:ShowAni(true)
    self._showOnceOnLeave = true
    self._showOnceOnEnter = false
  end
end

function UIHomelandMinimapIconTrace:Update(dirInfo)
  self._arrivalGO:SetActive(self._isInView)
  self._bgGo:SetActive(not self._isInView)
  self._arrowPoint:SetActive(not self._isInView)
  self:SetTracePointDir(dirInfo)
end

function UIHomelandMinimapIconTrace:SetTracePointDir(dirInfo)
  self._arrowPoint:SetActive(dirInfo[2] > 1)
  local dir = dirInfo[1] - self.screenOffset
  local vec3 = Vector3(dir.x, dir.y, 0)
  local angle = Vector3.Angle(vec3, Vector3.right)
  if dirInfo[1].y < self.screenOffset.y then
    angle = -angle
  end
  local rot = Quaternion.AngleAxis(angle - 90, Vector3.forward)
  self._arrowPoint.transform.localRotation = rot
end

function UIHomelandMinimapIconTrace:ShowAni(isIn)
  if isIn then
    self.anim:Play("UIHomelandMinimapIconTrace_in")
    self:FlashAniTimer()
    self._showAni = false
  else
    self.anim:Play("UIHomelandMinimapIconTrace_out")
    self._fx:SetActive(false)
    self._showAni = true
  end
end

function UIHomelandMinimapIconTrace:ShowMiniMapAni(isIn)
  if isIn then
    if self._roundGO.activeSelf then
      self.anim:Play("UIHomelandMinimapIconTrace_round_in")
    end
    if self._showAni then
      return
    end
    self.anim:Play("UIHomelandMinimapIconTrace_in")
    self:FlashAniTimer()
  else
    if self._roundGO.activeSelf then
      self.anim:Play("UIHomelandMinimapIconTrace_round_out")
    end
    if self._showAni then
      return
    end
    self.anim:Play("UIHomelandMinimapIconTrace_out")
    self._fx:SetActive(false)
  end
end

function UIHomelandMinimapIconTrace:FlashAniTimer(TT)
  self._timerHandler = GameGlobal.Timer():AddEventTimes(600, TimerTriggerCount.Once, function()
    self._fxAnim:Stop()
    self._fx:SetActive(true)
    self._fxAnim:Play("UIHomelandMinimapIconTrace_expansion")
  end)
end
