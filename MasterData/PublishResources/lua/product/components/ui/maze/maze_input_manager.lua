_class("MazeInputManager", Object)
MazeInputManager = MazeInputManager

function MazeInputManager:Constructor(ignorePointerUI)
  self._enabled = true
  self._ignorePointerUI = ignorePointerUI
  self._mouseInput = GameGlobal.EngineInput().mousePresent
  self.mouseDown = false
  self.downPos = nil
  self.downOnUI = false
  self.lastMousePos = nil
  self._clicked = false
  self._clickPos = nil
  self._dragging = false
  self._dragStartPos = nil
  self._dragEndPos = nil
  self._up = false
  self._upPos = nil
  local pixels = Cfg.cfg_aircraft_camera.clickAndDragPixelLength.Value
  self.clickDragPixelLengthMag = pixels * pixels
end

function MazeInputManager:Dispose()
end

function MazeInputManager:Init(dragPixel)
  self._enabled = true
  if dragPixel then
    self.clickDragPixelLengthMag = dragPixel * dragPixel
  end
end

function MazeInputManager:SetEnable(enable)
  self._enabled = enable
  if not enable then
    self:_ResetInputData()
    self._clickPos = nil
    self.lastMousePos = nil
  end
end

function MazeInputManager:Update(deltaTime)
  if not self._enabled then
    return
  end
  if self._mouseInput then
    self:MouseInput(deltaTime)
  else
    self:TouchInput(deltaTime)
  end
end

function MazeInputManager:MouseInput(deltaTime)
  local down = GameGlobal.EngineInput().GetMouseButtonDown(0)
  local hold = GameGlobal.EngineInput().GetMouseButton(0)
  local up = GameGlobal.EngineInput().GetMouseButtonUp(0)
  local mousePos = GameGlobal.EngineInput().mousePosition
  local onUI = not self._ignorePointerUI and UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject()
  self._clicked = false
  self._clickPos = nil
  if up and self.mouseDown and not self.downOnUI and not onUI and not self._dragging then
    self._clicked = true
    self._clickPos = mousePos
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
  elseif hold and not onUI and self.mouseDown and self.lastMousePos and (mousePos - self.downPos).sqrMagnitude > self.clickDragPixelLengthMag then
    self._dragging = true
    self._dragStartPos = self.lastMousePos
    self._dragEndPos = mousePos
  end
  self._up = false
  self._upPos = nil
  if up then
    self._up = true
    self._upPos = mousePos
  end
  if down and not self.mouseDown then
    self.mouseDown = true
    self.downPos = mousePos
    self.downOnUI = onUI
  elseif up and self.mouseDown then
    self.mouseDown = false
    self.downPos = nil
    self.downOnUI = false
  end
  self.lastMousePos = mousePos
end

function MazeInputManager:TouchInput(deltaTime)
  local touchCount = GameGlobal.EngineInput().touchCount
  local touch0
  if 0 < touchCount then
    touch0 = GameGlobal.EngineInput().GetTouch(0)
  end
  local mousePos
  local touch0OnUI = false
  if touch0 then
    touch0OnUI = not self._ignorePointerUI and UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(touch0.fingerId)
    mousePos = touch0.position
  end
  local touch1
  if 1 < touchCount then
    touch1 = GameGlobal.EngineInput().GetTouch(1)
  end
  local touch1OnUI = false
  if touch1 then
    touch1OnUI = not self._ignorePointerUI and UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(touch1.fingerId)
  end
  self._clicked = false
  self._clickPos = nil
  if touch0 and touch0.phase == TouchPhase.Ended and self.mouseDown and not self.downOnUI and not touch0OnUI and not self._dragging then
    self._clicked = true
    self._clickPos = mousePos
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
    elseif (touch0.phase == TouchPhase.Moved or touch0.phase == TouchPhase.Stationary) and not touch0OnUI and self.mouseDown and (mousePos - self.downPos).sqrMagnitude > self.clickDragPixelLengthMag then
      self._dragging = true
      self._dragStartPos = Vector3(touch0.position.x - touch0.deltaPosition.x, touch0.position.y - touch0.deltaPosition.y, 0)
      self._dragEndPos = Vector3(touch0.position.x, touch0.position.y, 0)
    end
  end
  self._up = false
  self._upPos = nil
  if touch0 and touch0.phase == TouchPhase.Ended then
    self._up = true
    self._upPos = mousePos
  end
  if touch0 then
    if touch0.phase == TouchPhase.Began and not self.mouseDown then
      self.mouseDown = true
      self.downPos = touch0.position
      self.downOnUI = touch0OnUI
    elseif touch0.phase == TouchPhase.Ended and self.mouseDown then
      self.mouseDown = false
      self.downPos = nil
      self.downOnUI = false
    end
  end
  self.lastMousePos = mousePos
end

function MazeInputManager:_ResetInputData()
  self._clicked = false
  self._clickPos = nil
  self._dragging = false
  self._dragStartPos = nil
  self._dragEndPos = nil
  self.mouseDown = false
  self.downOnUI = false
  self.downPos = nil
  self.lastMousePos = nil
end

function MazeInputManager:GetClick()
  return self._clicked, self._clickPos
end

function MazeInputManager:GetDrag()
  return self._dragging, self._dragStartPos, self._dragEndPos
end

function MazeInputManager:GetMouseDown()
  return self.mouseDown, self.downPos
end

function MazeInputManager:GetMouseUp()
  return self._up, self._upPos
end
