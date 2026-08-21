_class("UIWidgetHomelandBuildController", UICustomWidget)
UIWidgetHomelandBuildController = UIWidgetHomelandBuildController

function UIWidgetHomelandBuildController:OnShow(uiParams)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._uiHomelandModule = self._homelandModule:GetUIModule()
  self._homelandClient = self._uiHomelandModule:GetClient()
  self._homelandInputControllerBuild = self._homelandClient:InputManager():GetControllerBuild()
  self._isMobile = self._homelandClient:InputManager():UseMobileController()
  if self._isMobile then
    self:InitMobileController()
  else
    self:InitPCController()
  end
end

function UIWidgetHomelandBuildController:InitMobileController()
  self._joystickArea = self:GetGameObject("JoystickArea")
  self._TouchPointMoveTrans = self:GetUIComponent("RectTransform", "JoystickPoint")
  self._JoystickBGImage = self:GetUIComponent("Image", "JoystickBG")
  self._uiCam = GameGlobal.UIStateManager():GetControllerCamera(self.uiOwner:GetName())
  self._input = GameGlobal.EngineInput()
  self._moveFingerID = nil
  self._rotateFingerID = nil
  self._scaleFingerID = nil
  self._dragInFingerID = nil
  self._rotateFingerPos = nil
  self._scaleFingerPos = nil
  self._scaleDistance = nil
  self._rotated = false
  self._touchTime = 0
  self._joystickAreaTrans = self._joystickArea.transform
  self._joystickEtl = UICustomUIEventListener.Get(self._joystickArea)
  self:AddUICustomEventListener(self._joystickEtl, UIEvent.Press, function(go)
    self:OnPressJoystick()
  end)
  self:AddUICustomEventListener(self._joystickEtl, UIEvent.Drag, function(pointerEventData)
    self:OnDragJoystick(pointerEventData)
  end)
  self:AddUICustomEventListener(self._joystickEtl, UIEvent.Release, function(go)
    self:OnUpJoystick()
  end)
  self._goTrans = self:GetGameObject().transform
  self._slidingAreaEtl = UICustomUIEventListener.Get(self:GetGameObject())
  self:AddUICustomEventListener(self._slidingAreaEtl, UIEvent.Press, function(go)
    self:OnPressSlidingArea()
  end)
  self:AddUICustomEventListener(self._slidingAreaEtl, UIEvent.Drag, function(pointerEventData)
    self:OnDragSlidingArea(pointerEventData)
  end)
  self:AddUICustomEventListener(self._slidingAreaEtl, UIEvent.Release, function(go)
    self:OnUpSlidingArea()
  end)
  self._circleRadius = 186
  self._circleRadiusSQ = self._circleRadius * self._circleRadius
  self._scaleFactor = 0.01
  self._clickInterval = 500
end

function UIWidgetHomelandBuildController:OnHide()
  self._dragInFingerID = nil
  self._moveFingerID = nil
  self._rotateFingerID = nil
  self._scaleFingerID = nil
end

function UIWidgetHomelandBuildController:InitPCController()
  self._joystickArea = self:GetGameObject("JoystickArea")
  self._joystickArea:SetActive(false)
  self:GetGameObject():GetComponent(typeof(EmptyImage)).enabled = false
end

function UIWidgetHomelandBuildController:DragBuildingIntoScene(buildingID, touchID)
  self._homelandInputControllerBuild:HandleDragIn(buildingID)
  if self._isMobile then
    self._dragInFingerID = touchID
    self:StartTask(self.HandleDragIn, self)
  end
end

function UIWidgetHomelandBuildController:HandleDragIn(TT)
  while true do
    if not self._dragInFingerID then
      return
    end
    local dragFingerExist = false
    for i = 0, self._input.touchCount - 1 do
      local touch = self._input.GetTouch(i)
      if self._dragInFingerID == touch.fingerId then
        if touch.phase == TouchPhase.Ended or touch.phase == TouchPhase.Canceled then
          self._dragInFingerID = nil
          if self._homelandInputControllerBuild:TouchBuilding() then
            self._homelandInputControllerBuild:ReleaseTouch()
          end
          return
        end
        dragFingerExist = true
        if touch.phase == TouchPhase.Moved then
          self._homelandInputControllerBuild:MoveDragInFinger(touch.position)
        end
      end
    end
    if not dragFingerExist then
      return
    end
    YIELD(TT)
  end
end

function UIWidgetHomelandBuildController:OnPressJoystick()
  if self._moveFingerID ~= nil then
    return
  end
  local pointerEventData = self._joystickEtl.CurrentPointerEventData
  self._moveFingerID = pointerEventData.pointerId
  local _, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._joystickAreaTrans, pointerEventData.position, pointerEventData.pressEventCamera, nil)
  local sqDis = pos:SqrMagnitude()
  if sqDis > self._circleRadiusSQ then
    self._TouchPointMoveTrans.anchoredPosition = self._circleRadius / math.sqrt(sqDis) * pos
  else
    self._TouchPointMoveTrans.anchoredPosition = pos
  end
  self._homelandInputControllerBuild:HandleMove(pos)
end

function UIWidgetHomelandBuildController:OnDragJoystick(pointerEventData)
  if self._moveFingerID == pointerEventData.pointerId then
    local _, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._joystickAreaTrans, pointerEventData.position, pointerEventData.pressEventCamera, nil)
    local sqDis = pos:SqrMagnitude()
    if sqDis > self._circleRadiusSQ then
      self._TouchPointMoveTrans.anchoredPosition = self._circleRadius / math.sqrt(sqDis) * pos
    else
      self._TouchPointMoveTrans.anchoredPosition = pos
    end
    self._homelandInputControllerBuild:HandleMove(pos)
  end
end

function UIWidgetHomelandBuildController:OnUpJoystick()
  if self._moveFingerID == nil then
    return
  end
  local pointerEventData = self._joystickEtl.CurrentPointerEventData
  if self._moveFingerID == pointerEventData.pointerId then
    self._moveFingerID = nil
    self._homelandInputControllerBuild:HandleMove(Vector2.zero)
    self._TouchPointMoveTrans.anchoredPosition = Vector2.zero
  end
end

function UIWidgetHomelandBuildController:OnPressSlidingArea()
  if self._rotateFingerID ~= nil and self._scaleFingerID ~= nil then
    return
  end
  local pointerEventData = self._slidingAreaEtl.CurrentPointerEventData
  local fingerId = pointerEventData.pointerId
  if self._rotateFingerID == nil and self._scaleFingerID ~= fingerId then
    self._rotateFingerID = fingerId
    self._rotateFingerPos = pointerEventData.position
    if self._homelandInputControllerBuild:HandleBuildAreaDown(pointerEventData.position) then
      return
    end
    if self._scaleFingerID == nil then
      self._rotated = false
      self._touchTime = GameGlobal:GetInstance():GetCurrentTime()
    end
  elseif self._scaleFingerID == nil and self._rotateFingerID ~= fingerId then
    self._scaleFingerID = fingerId
    self._scaleFingerPos = pointerEventData.position
  end
  if self._rotateFingerID and self._scaleFingerID then
    self._scaleDistance = Vector2.Distance(self._rotateFingerPos, self._scaleFingerPos)
  end
end

function UIWidgetHomelandBuildController:OnDragSlidingArea(pointerEventData)
  if self._rotateFingerID and self._scaleFingerID then
    local scaled = false
    if self._rotateFingerID == pointerEventData.pointerId then
      self._rotateFingerPos = pointerEventData.position
      scaled = true
    elseif self._scaleFingerID == pointerEventData.pointerId then
      self._scaleFingerPos = pointerEventData.position
      scaled = true
    end
    if scaled then
      self._rotated = true
      local newDistance = Vector2.Distance(self._rotateFingerPos, self._scaleFingerPos)
      self._homelandInputControllerBuild:HandleScale((newDistance - self._scaleDistance) * self._scaleFactor)
      self._scaleDistance = newDistance
    end
  elseif self._rotateFingerID == pointerEventData.pointerId then
    if self._homelandInputControllerBuild:TouchBuilding() then
      self._homelandInputControllerBuild:HandleBuildAreaMove(pointerEventData.position)
    else
      self._homelandInputControllerBuild:HandleRotate(pointerEventData.delta)
      self._rotated = true
    end
  end
end

function UIWidgetHomelandBuildController:OnUpSlidingArea()
  if self._rotateFingerID == nil and self._scaleFingerID == nil then
    return
  end
  local pointerEventData = self._slidingAreaEtl.CurrentPointerEventData
  if self._rotateFingerID == pointerEventData.pointerId then
    if self._homelandInputControllerBuild:TouchBuilding() then
      self._homelandInputControllerBuild:ReleaseTouch()
    elseif not self._rotated then
      local interval = GameGlobal:GetInstance():GetCurrentTime() - self._touchTime
      if interval < self._clickInterval then
        self._homelandInputControllerBuild:HandleBuildAreaClick(self._rotateFingerPos)
      end
    end
    self._rotateFingerID = nil
    self._rotateFingerPos = nil
  elseif self._scaleFingerID == pointerEventData.pointerId then
    self._scaleFingerID = nil
    self._scaleFingerPos = nil
  end
end
