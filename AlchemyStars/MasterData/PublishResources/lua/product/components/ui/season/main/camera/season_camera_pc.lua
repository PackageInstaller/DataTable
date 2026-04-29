_class("SeasonCameraPc", SeasonCameraBase)
SeasonCameraPc = SeasonCameraPc

function SeasonCameraPc:Constructor(seasonID)
  self._cameraSizeChangeSpeed_PC = self._cameraSeasonCfg.CameraSizeChangeSpeed_PC
  self._camera.orthographicSize = self._cameraSize
  if self._rtCamera then
    self._rtCamera.orthographicSize = self._cameraSize
  end
end

function SeasonCameraPc:Update(deltaTime, inputMode)
  SeasonCameraPc.super.Update(self, deltaTime)
  if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject() then
    return
  end
  if self._cameraTransform and inputMode == SeasonInputMode.Input then
    if self._input.GetMouseButtonDown(0) then
      self._startPosition = self._input.mousePosition
      self._cameraOriginPosition = self._cameraTransform.position
      self._draging = false
      self._inputPhase = SeasonInputPhase.Down
    end
    if self._input.GetMouseButton(0) and self._inputPhase == SeasonInputPhase.Down and self._cameraOriginPosition then
      self._endPosition = self._input.mousePosition
      self._deltaPosition = self._endPosition - self._startPosition
      self._draging = self._deltaPosition.magnitude >= self._dragValue
      if self._draging or self._mode == SeasonCameraMode.Drag then
        self:SwitchMode(SeasonCameraMode.Drag)
        local dir = self._camera:ScreenToWorldPoint(self._endPosition) - self._camera:ScreenToWorldPoint(self._startPosition)
        self._targetPosition = self._cameraOriginPosition - dir
      end
    end
    if self._input.GetMouseButtonUp(0) then
      self._inputPhase = SeasonInputPhase.Up
    end
    if self._mode == SeasonCameraMode.Drag and self._targetPosition then
      self:SetPosition(self._targetPosition)
    end
    self:_UpdateCameraSize()
  end
end

function SeasonCameraPc:_UpdateCameraSize()
  local mouseWheel = self._input.GetAxis("Mouse ScrollWheel")
  if mouseWheel ~= 0 then
    local targetSize = self._camera.orthographicSize - mouseWheel * self._cameraSizeChangeSpeed_PC
    self._cameraSize = Mathf.Clamp(targetSize, self._cameraSizeMin, self._cameraSizeMax)
  end
end
