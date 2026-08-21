_class("AircraftInputManager", Object)
AircraftInputManager = AircraftInputManager
local unityInput, currentEvent, scrollAxis

function AircraftInputManager:Constructor()
  unityInput = GameGlobal.EngineInput()
  currentEvent = UnityEngine.EventSystems.EventSystem.current
  scrollAxis = "Mouse ScrollWheel"
  self._enabled = true
  self._mousePresent = nil
  self.mouseDown = false
  self.downPos = nil
  self.downOnUI = false
  self.lastMousePos = nil
  self._clicked = false
  self._clickPos = nil
  self._dragging = false
  self._dragStartPos = nil
  self._dragEndPos = nil
  self._scaling = false
  self._scaleLength = 0
  self._scaleCenterPos = Vector2.zero
  self._longPressing = false
  self.longPressTime = 0
  self.longPresingPos = nil
  self._touchScaleRatio = Cfg.cfg_aircraft_camera.scaleRatio.Value
  self.longPressCheckTime = Cfg.cfg_aircraft_camera.longPressCheckTime.Value
  local pixels = Cfg.cfg_aircraft_camera.clickAndDragPixelLength.Value
  pixels = 10
  self.clickDragPixelLengthMag = pixels * pixels
  self.longPressTimer = 0
end

function AircraftInputManager:Init()
  self._mousePresent = unityInput.mousePresent
  UnityEngine.Input.multiTouchEnabled = true
  return true
end

function AircraftInputManager:Dispose()
  UnityEngine.Input.multiTouchEnabled = false
  unityInput = nil
  currentEvent = nil
  scrollAxis = nil
end

function AircraftInputManager:SetEnable(enable)
  self._enabled = enable
  if not enable then
    self:_ResetInputData()
    self._clickPos = nil
    self.lastMousePos = nil
  end
end

function AircraftInputManager:MouseInput(deltaTime)
  local down = unityInput.GetMouseButtonDown(0)
  local hold = unityInput.GetMouseButton(0)
  local up = unityInput.GetMouseButtonUp(0)
  local mousePos = unityInput.mousePosition
  local onUI = currentEvent:IsPointerOverGameObject()
  self._clicked = false
  self._clickPos = nil
  if up and self.mouseDown and not self.downOnUI and not onUI and not self._dragging and not self._longPressing and not self._scaling then
    self._clicked = true
    self._clickPos = mousePos
  end
  self._longPressing = false
  self.longPressTime = 0
  self.longPresingPos = nil
  if not self._dragging and hold and not onUI then
    if self.mouseDown then
      if (mousePos - self.downPos).sqrMagnitude < self.clickDragPixelLengthMag then
        self.longPressTimer = self.longPressTimer + deltaTime
        if self.longPressTimer > self.longPressCheckTime then
          self._longPressing = true
          self.longPressTime = self.longPressTimer - self.longPressCheckTime
          self.longPresingPos = mousePos
        end
      else
        self._longPressing = false
        self.longPressTime = 0
        self.longPressTimer = 0
        self.longPresingPos = nil
      end
    end
  elseif down then
    self.longPressTimer = 0
  elseif up then
    self._longPressing = false
    self.longPressTime = 0
    self.longPressTimer = 0
    self.longPresingPos = nil
  end
  if self._dragging then
    if onUI or up then
      self._dragging = false
      self._dragStartPos = nil
      self._dragEndPos = nil
    else
      self._dragStartPos = self.lastMousePos
      self._dragEndPos = mousePos
    end
  elseif hold and not onUI and self.mouseDown and self.lastMousePos and not self.downOnUI and (mousePos - self.downPos).sqrMagnitude > self.clickDragPixelLengthMag then
    self._dragging = true
    self._dragStartPos = self.lastMousePos
    self._dragEndPos = mousePos
  end
  self._scaleLength = 0
  self._scaling = false
  self._scaleCenterPos = nil
  if down or up or hold or onUI then
  else
    self._scaleLength = unityInput.GetAxis(scrollAxis)
    self._scaling = self._scaleLength ~= 0
    self._scaleCenterPos = mousePos
  end
  if down and not up and not self.mouseDown then
    self.mouseDown = true
    self.downPos = mousePos
    self.downOnUI = onUI
  elseif up and not down and self.mouseDown then
    self.mouseDown = false
    self.downPos = nil
    self.downOnUI = false
  end
  self._down = down and not onUI and not up
  self._up = up and not down
  if up then
    self._upPos = mousePos
  end
  self.lastMousePos = mousePos
end

function AircraftInputManager:TouchInput(deltaTime)
  local touchCount = unityInput.touchCount
  local touch0
  if 0 < touchCount then
    touch0 = unityInput.GetTouch(0)
  end
  local mousePos
  local touch0OnUI = false
  if touch0 then
    touch0OnUI = currentEvent:IsPointerOverGameObject(touch0.fingerId)
    mousePos = touch0.position
  end
  local touch1
  if 1 < touchCount then
    touch1 = unityInput.GetTouch(1)
  end
  local touch1OnUI = false
  if touch1 then
    touch1OnUI = currentEvent:IsPointerOverGameObject(touch1.fingerId)
  end
  self._clicked = false
  self._clickPos = nil
  if touch0 and touch0.phase == TouchPhase.Ended and self.mouseDown and not self.downOnUI and not touch0OnUI and not touch1 and not self._dragging and not self._longPressing and not self._scaling then
    self._clicked = true
    self._clickPos = mousePos
  end
  self._longPressing = false
  self.longPressTime = 0
  self.longPresingPos = nil
  if touch0 then
    if touch0OnUI or touch1 then
      self._longPressing = false
      self.longPressTimer = 0
      self.longPressTime = 0
      self.longPresingPos = nil
    elseif (touch0.phase == TouchPhase.Moved or touch0.phase == TouchPhase.Stationary) and self.mouseDown then
      if (self.downPos - touch0.position).sqrMagnitude < self.clickDragPixelLengthMag then
        self.longPressTimer = self.longPressTimer + deltaTime
        if self.longPressTimer > self.longPressCheckTime then
          self._longPressing = true
          self.longPressTime = self.longPressTimer - self.longPressCheckTime
          self.longPresingPos = Vector3(touch0.position.x, touch0.position.y, 0)
        end
      else
        self._longPressing = false
        self.longPressTime = 0
        self.longPressTimer = 0
        self.longPresingPos = nil
      end
    elseif touch0.phase == TouchPhase.Ended then
      self._longPressing = false
      self.longPressTime = 0
      self.longPressTimer = 0
      self.longPresingPos = nil
    end
  end
  if touch0 then
    if touch1 then
      self._dragging = false
      self._dragStartPos = nil
      self._dragEndPos = nil
    elseif self._dragging then
      if touch0OnUI or touch0.phase == TouchPhase.Ended then
        self._dragging = false
        self._dragStartPos = nil
        self._dragEndPos = nil
      else
        self._dragStartPos = Vector3(touch0.position.x - touch0.deltaPosition.x, touch0.position.y - touch0.deltaPosition.y, 0)
        self._dragEndPos = Vector3(touch0.position.x, touch0.position.y, 0)
      end
    elseif (touch0.phase == TouchPhase.Moved or touch0.phase == TouchPhase.Stationary) and not touch0OnUI and self.mouseDown and not self.downOnUI and (mousePos - self.downPos).sqrMagnitude > self.clickDragPixelLengthMag then
      self._dragging = true
      self._dragStartPos = Vector3(touch0.position.x - touch0.deltaPosition.x, touch0.position.y - touch0.deltaPosition.y, 0)
      self._dragEndPos = Vector3(touch0.position.x, touch0.position.y, 0)
    end
  end
  self._scaleLength = 0
  self._scaling = false
  self._scaleCenterPos = nil
  local onui = touch0OnUI or touch1OnUI
  if touch0 and touch1 and not onui and (touch0.phase == TouchPhase.Moved or touch1.phase == TouchPhase.Moved) then
    local lastLength = Vector2.Distance(touch0.position - touch0.deltaPosition, touch1.position - touch1.deltaPosition)
    local length = Vector2.Distance(touch0.position, touch1.position)
    self._scaleLength = (length - lastLength) * self._touchScaleRatio
    local centerPos = (touch0.position + touch1.position) / 2
    self._scaleCenterPos = Vector3(centerPos.x, centerPos.y, 0)
    self._scaling = true
  end
  if touch0 then
    if touch0.phase == TouchPhase.Began and not self.mouseDown then
      self.mouseDown = true
      self.downPos = touch0.position
      self.downOnUI = touch0OnUI
    elseif (touch0.phase == TouchPhase.Ended or touch0.phase == TouchPhase.Canceled) and self.mouseDown then
      self.mouseDown = false
      self.downPos = nil
      self.downOnUI = false
    end
  end
  self._down = touch0 and touch0.phase == TouchPhase.Began and not touch0OnUI
  self._up = touch0 and touch0.phase == TouchPhase.Ended
  if self._up then
    self._upPos = touch0.position
  end
  self.lastMousePos = mousePos
end

function AircraftInputManager:Update(deltaTimeMS)
  if not self._enabled then
    return
  end
  if self._mousePresent then
    self:MouseInput(deltaTimeMS / 1000)
  else
    self:TouchInput(deltaTimeMS / 1000)
  end
end

function AircraftInputManager:_ResetInputData()
  self._clicked = false
  self._clickPos = nil
  self._dragging = false
  self._dragStartPos = nil
  self._dragEndPos = nil
  self._scaling = false
  self._scaleLength = 0
  self._scaleCenterPos = nil
  self._longPressing = false
  self.longPressTime = 0
  self.longPresingPos = nil
  self.longPressTimer = 0
  self.mouseDown = false
  self.downOnUI = false
  self.downPos = nil
  self.lastMousePos = nil
end

function AircraftInputManager:GetClick()
  return self._clicked, self._clickPos
end

function AircraftInputManager:GetDrag()
  return self._dragging, self._dragStartPos, self._dragEndPos
end

function AircraftInputManager:GetScale()
  return self._scaling, self._scaleLength, self._scaleCenterPos
end

function AircraftInputManager:GetLongPress()
  return self._longPressing, self.longPressTime, self.longPresingPos
end

function AircraftInputManager:GetMouseDown()
  return self._down, self.downPos
end

function AircraftInputManager:GetMouseUp()
  return self._up, self._upPos
end
