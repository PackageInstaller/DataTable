_class("SeasonMapExpressFocus", SeasonMapExpressBase)
SeasonMapExpressFocus = SeasonMapExpressFocus

function SeasonMapExpressFocus:Constructor(cfg, eventPoint)
  self._content = self._cfg.Focus
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  self._seasonCamera = self._seasonManager:SeasonCameraManager():SeasonCamera()
  self._focusType = SeasonExpressFocusType.Center
end

function SeasonMapExpressFocus:Update(deltaTime)
  if self._state == SeasonExpressState.Playing and self._targetPosition then
    if self._focusType == SeasonExpressFocusType.Left then
      self._targetPosition.x = self._rawTargetPositionX - self:GetFocusOffsetX()
    elseif self._focusType == SeasonExpressFocusType.Right then
      self._targetPosition.x = self._rawTargetPositionX + self:GetFocusOffsetX()
    end
    self._seasonCamera:SetPosition(self._targetPosition)
    if self._seasonCamera:FocusDone() and (not self._sizeScale or self._sizeScale and self._seasonCamera:SizeDone()) then
      self._targetPosition = nil
      self:Next()
      self._seasonManager:UnLock("focus")
    end
  end
end

function SeasonMapExpressFocus:OnPlay()
  if self._content then
    local focusObjType = self._content.type
    local value = self._content.value
    self._focusType = self._content.focusType or SeasonExpressFocusType.Center
    self._sizeScale = self._content.sizeScale
    self._targetPosition = nil
    if focusObjType == SeasonExpressFocusObjType.Player then
      local player = self._seasonManager:SeasonPlayerManager():GetPlayer()
      self._targetPosition = Vector3(player:Position().x, 0, player:Position().z)
    elseif focusObjType == SeasonExpressFocusObjType.EventPoint then
      local eventPoint = self._seasonManager:SeasonMapManager():GetEventPoint(value)
      if eventPoint then
        self._targetPosition = Vector3(eventPoint:Position().x, 0, eventPoint:Position().z)
      end
    elseif focusObjType == SeasonExpressFocusObjType.Position then
      self._targetPosition = Vector3(value.x, 0, value.z)
    end
    if self._targetPosition then
      self._rawTargetPositionX = self._targetPosition.x
      self._seasonCamera:Focus(self._targetPosition)
      if self._sizeScale then
        self._seasonCamera:SetRecordSize(self._seasonCamera:Size())
        self._seasonCamera:SetSize(self._seasonCamera:MinSize())
        self._scaleStartTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime()
      end
      self._state = SeasonExpressState.Playing
      self._seasonManager:Lock("focus")
    else
      self:Next()
    end
  end
end

function SeasonMapExpressFocus:GetFocusOffsetX()
  local camera = self._seasonCamera:Camera()
  local aspect = camera.aspect
  local size = camera.orthographicSize
  local cameraWidth = size * aspect
  local bangWidth = ResolutionManager.BangWidth()
  local blackWidth = ResolutionManager.BlackWidth()
  local width = bangWidth + blackWidth
  width = UnityEngine.Screen.width - width * 2
  local percent = (width / 2 - (width - 694) / 2) / width
  return percent * cameraWidth * 2
end
