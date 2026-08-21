_class("UIWidgetHomelandMoveController", UICustomWidget)
UIWidgetHomelandMoveController = UIWidgetHomelandMoveController

function UIWidgetHomelandMoveController:OnShow(uiParams)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._uiHomelandModule = self._homelandModule:GetUIModule()
  self._homelandClient = self._uiHomelandModule:GetClient()
  self._HomelandInputControllerChar = self._homelandClient:InputManager():GetControllerChar()
  self._rb = self:GetGameObject("RightBottom")
  if self._homelandClient:InputManager():UseMobileController() then
    self:InitMobileController()
    
    function self.resetCallback()
      self:OnReset()
    end
    
    self._homelandClient:InputManager():AddResetCallback(self.resetCallback)
  else
    self:InitPCController()
  end
  self:AttachEvent(GameEventType.OnChangeUIHomelandButtonSprintShow, self.OnChangeUIHomelandButtonSprintShow)
  self:AttachEvent(GameEventType.FishMatchHideDash, self.OnFishMatchReadyHideUI)
  self:AttachEvent(GameEventType.FishMatchEnd, self.OnFishMatchEndShowUI)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  if characterController:IsSwimming() then
    self._rb:SetActive(false)
  end
  local dashBtn = self:GetGameObject("DashButton")
  local el = UICustomUIEventListener.Get(dashBtn)
  self:AddUICustomEventListener(el, UIEvent.Press, function()
    self:OnDashBtnDown()
  end)
  self:AddUICustomEventListener(el, UIEvent.Release, function()
    self:OnDashBtnUp()
  end)
  self._dashBtnHolding = false
end

function UIWidgetHomelandMoveController:OnHide()
  self._moveFingerID = nil
  self._rotateFingerID = nil
  self._scaleFingerID = nil
  self._homelandClient:InputManager():RemoveResetCallback(self.resetCallback)
end

function UIWidgetHomelandMoveController:OnReset()
  self._moveFingerID = nil
  self._rotateFingerID = nil
  self._scaleFingerID = nil
  self._TouchPointMoveTrans.anchoredPosition = Vector2.zero
end

function UIWidgetHomelandMoveController:HideExceptCameraRotation(hide)
  if self._homelandClient:InputManager():UseMobileController() then
    self._joystickArea:SetActive(not hide)
  end
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  if characterController:IsSwimming() then
    return
  end
  self._rb:SetActive(not hide)
end

function UIWidgetHomelandMoveController:InitMobileController()
  self._joystickArea = self:GetGameObject("JoystickArea")
  self._TouchPointMoveTrans = self:GetUIComponent("RectTransform", "JoystickPoint")
  self._uiCam = GameGlobal.UIStateManager():GetControllerCamera(self.uiOwner:GetName())
  self._input = GameGlobal.EngineInput()
  self._moveFingerID = nil
  self._rotateFingerID = nil
  self._scaleFingerID = nil
  self._rotateFingerPos = nil
  self._scaleFingerPos = nil
  self._scaleDistance = nil
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
  self._smallCircleRadius = 63
  self._smallCircleRadiusSQ = self._smallCircleRadius * self._smallCircleRadius
  self._bigCircleRadius = 186
  self._bigCircleRadiusSQ = self._bigCircleRadius * self._bigCircleRadius
  self._moveType = HomelandCharMoveType.Idle
  self._scaleFactor = 0.005
end

function UIWidgetHomelandMoveController:InitPCController()
  self._joystickArea = self:GetGameObject("JoystickArea")
  self._joystickArea:SetActive(false)
  self:GetGameObject():GetComponent(typeof(EmptyImage)).enabled = false
end

function UIWidgetHomelandMoveController:OnPressJoystick()
  if self._moveFingerID ~= nil then
    return
  end
  local pointerEventData = self._joystickEtl.CurrentPointerEventData
  self._moveFingerID = pointerEventData.pointerId
  local _, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._joystickAreaTrans, pointerEventData.position, pointerEventData.pressEventCamera, nil)
  local sqDis = pos:SqrMagnitude()
  if sqDis > self._smallCircleRadiusSQ then
    self._moveType = HomelandCharMoveType.Run
  else
    self._moveType = HomelandCharMoveType.Walk
  end
  if sqDis > self._bigCircleRadiusSQ then
    self._TouchPointMoveTrans.anchoredPosition = self._bigCircleRadius / math.sqrt(sqDis) * pos
  else
    self._TouchPointMoveTrans.anchoredPosition = pos
  end
  self._HomelandInputControllerChar:HandleMove(pos, self._moveType)
end

function UIWidgetHomelandMoveController:OnDragJoystick(pointerEventData)
  if self._moveFingerID == pointerEventData.pointerId then
    local _, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._joystickAreaTrans, pointerEventData.position, pointerEventData.pressEventCamera, nil)
    local sqDis = pos:SqrMagnitude()
    if self._moveType == HomelandCharMoveType.Walk and sqDis > self._smallCircleRadiusSQ then
      self._moveType = HomelandCharMoveType.Run
    elseif self._moveType == HomelandCharMoveType.Run and sqDis <= self._smallCircleRadiusSQ then
      self._moveType = HomelandCharMoveType.Walk
    end
    if sqDis > self._bigCircleRadiusSQ then
      self._TouchPointMoveTrans.anchoredPosition = self._bigCircleRadius / math.sqrt(sqDis) * pos
    else
      self._TouchPointMoveTrans.anchoredPosition = pos
    end
    self._HomelandInputControllerChar:HandleMove(pos, self._moveType)
  end
end

function UIWidgetHomelandMoveController:OnUpJoystick()
  if self._moveFingerID == nil then
    return
  end
  if not self._joystickEtl.CurrentPointerEventData then
    return
  end
  local pointerEventData = self._joystickEtl.CurrentPointerEventData
  if self._moveFingerID == pointerEventData.pointerId then
    self._moveFingerID = nil
    self._HomelandInputControllerChar:HandleMove(Vector2.zero, HomelandCharMoveType.Idle)
    self._TouchPointMoveTrans.anchoredPosition = Vector2.zero
  end
end

function UIWidgetHomelandMoveController:OnPressSlidingArea()
  if self._rotateFingerID ~= nil and self._scaleFingerID ~= nil then
    return
  end
  local pointerEventData = self._slidingAreaEtl.CurrentPointerEventData
  local fingerId = pointerEventData.pointerId
  if self._rotateFingerID == nil and self._scaleFingerID ~= fingerId then
    self._rotateFingerID = fingerId
    self._rotateFingerPos = pointerEventData.position
  elseif self._scaleFingerID == nil and self._rotateFingerID ~= fingerId then
    self._scaleFingerID = fingerId
    self._scaleFingerPos = pointerEventData.position
  end
  if self._rotateFingerID and self._scaleFingerID then
    self._scaleDistance = Vector2.Distance(self._rotateFingerPos, self._scaleFingerPos)
  end
end

function UIWidgetHomelandMoveController:OnDragSlidingArea(pointerEventData)
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
      local newDistance = Vector2.Distance(self._rotateFingerPos, self._scaleFingerPos)
      self._HomelandInputControllerChar:HandleScale((newDistance - self._scaleDistance) * self._scaleFactor)
      self._scaleDistance = newDistance
    end
  elseif self._rotateFingerID == pointerEventData.pointerId then
    self._HomelandInputControllerChar:HandleRotate(pointerEventData.delta)
  end
end

function UIWidgetHomelandMoveController:OnUpSlidingArea()
  if self._rotateFingerID == nil and self._scaleFingerID == nil then
    return
  end
  local pointerEventData = self._slidingAreaEtl.CurrentPointerEventData
  if self._rotateFingerID == pointerEventData.pointerId then
    self._rotateFingerID = nil
    self._rotateFingerPos = nil
  elseif self._scaleFingerID == pointerEventData.pointerId then
    self._scaleFingerID = nil
    self._scaleFingerPos = nil
  end
end

function UIWidgetHomelandMoveController:OnChangeUIHomelandButtonSprintShow(visible)
  self._rb:SetActive(visible)
  if not visible then
    self._HomelandInputControllerChar:DashRelease()
  end
end

function UIWidgetHomelandMoveController:OnFishMatchReadyHideUI()
  if self._homelandClient:InputManager():UseMobileController() then
    self._joystickArea:SetActive(false)
  end
  self._rb:SetActive(false)
end

function UIWidgetHomelandMoveController:OnFishMatchEndShowUI()
  if self._homelandClient:InputManager():UseMobileController() then
    self._joystickArea:SetActive(true)
  end
  self._rb:SetActive(true)
end

function UIWidgetHomelandMoveController:OnDashBtnDown()
  self._HomelandInputControllerChar:DashStart()
end

function UIWidgetHomelandMoveController:OnDashBtnUp()
  self._HomelandInputControllerChar:DashRelease()
end
