_class("SeasonMazeCameraMobile", SeasonMazeCameraBase)
SeasonMazeCameraMobile = SeasonMazeCameraMobile

function SeasonMazeCameraMobile:Constructor(seasonID)
  self._cameraSizeChangeSpeed_Mobile = self._cameraSeasonCfg.CameraSizeChangeSpeed_Mobile
  self._curScaleValue = 0
  self._input.multiTouchEnabled = true
  self._camera.orthographicSize = self._cameraSize
  self._rtCamera.orthographicSize = self._cameraSize
end

function SeasonMazeCameraMobile:Update(deltaTime, inputMode)
  SeasonMazeCameraMobile.super.Update(self, deltaTime)
  if self._cameraTransform and inputMode == SeasonInputMode.Input then
    if self._input.touchCount == 1 then
      local touch0 = self._input.GetTouch(0)
      if touch0 then
        if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(touch0.fingerId) then
          return
        end
        if touch0.phase == TouchPhase.Began then
          self._startPosition = touch0.position
          self._cameraOriginPosition = self._cameraTransform.position
          self._draging = false
          self._touchFingerID = touch0.fingerId
        end
        if touch0.phase == TouchPhase.Moved and self._touchFingerID == touch0.fingerId and self._cameraOriginPosition then
          self._endPosition = touch0.position
          self._deltaPosition = self._endPosition - self._startPosition
          self._draging = self._deltaPosition.magnitude >= self._dragValue
          if self._draging or self._mode == SeasonCameraMode.Drag then
            self:SwitchMode(SeasonCameraMode.Drag)
            local dir = self._camera:ScreenToWorldPoint(self._endPosition) - self._camera:ScreenToWorldPoint(self._startPosition)
            self._targetPosition = self._cameraOriginPosition - dir
          end
        end
        if (touch0.phase == TouchPhase.Ended or touch0.phase == TouchPhase.Canceled) and self._touchFingerID == touch0.fingerId then
          self._touchFingerID = nil
        end
      end
    end
    if self._mode == SeasonCameraMode.Drag and self._targetPosition and self._targetPosition then
      self:SetPosition(self._targetPosition)
    end
    if self._input.touchCount >= 2 then
      self._touchFingerID = nil
    end
    if self._input.touchCount == 2 then
      self:_UpdateCameraSize()
    else
      self._curScaleValue = 0
    end
  end
end

function SeasonMazeCameraMobile:_UpdateCameraSize()
  local t0 = self._input.GetTouch(0)
  local t1 = self._input.GetTouch(1)
  if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(t0.fingerId) then
    return
  end
  if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(t1.fingerId) then
    return
  end
  local dis = Vector2.Distance(t0.position, t1.position)
  if self._curScaleValue == 0 then
    self._curScaleValue = dis
    return
  end
  local delta = dis - self._curScaleValue
  self._curScaleValue = dis
  if delta ~= 0 then
    local targetSize = self._camera.orthographicSize - delta * self._cameraSizeChangeSpeed_Mobile
    self._cameraSize = Mathf.Clamp(targetSize, self._cameraSizeMin, self._cameraSizeMax)
  end
end
