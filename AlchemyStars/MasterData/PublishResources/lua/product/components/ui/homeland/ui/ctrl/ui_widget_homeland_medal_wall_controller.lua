_class("UIWidgetHomelandMedalWallController", UICustomWidget)
UIWidgetHomelandMedalWallController = UIWidgetHomelandMedalWallController

function UIWidgetHomelandMedalWallController:OnShow(uiParams)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._uiHomelandModule = self._homelandModule:GetUIModule()
  self._homelandClient = self._uiHomelandModule:GetClient()
  self._homelandInputControllerMedalWall = self._homelandClient:InputManager():GetControllerMedalWall()
  self._isMobile = self._homelandClient:InputManager():UseMobileController()
  if self._isMobile then
    self:InitMobileController()
  else
    self:InitPCController()
  end
end

function UIWidgetHomelandMedalWallController:InitMobileController()
  self._uiCam = GameGlobal.UIStateManager():GetControllerCamera(self.uiOwner:GetName())
  self._input = GameGlobal.EngineInput()
  self._moveFingerID = nil
  self._scaleFingerID = nil
  self._moveFingerPos = nil
  self._scaleFingerPos = nil
  self._scaleDistance = nil
  self._moved = false
  self._touchTime = 0
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
  self._scaleFactor = MedalWallConfig.MobileWheelFactor
  self._clickInterval = 500
end

function UIWidgetHomelandMedalWallController:OnHide()
  self._moveFingerID = nil
  self._scaleFingerID = nil
end

function UIWidgetHomelandMedalWallController:InitPCController()
  self:GetGameObject():GetComponent(typeof(EmptyImage)).enabled = false
end

function UIWidgetHomelandMedalWallController:OnPressSlidingArea()
  if self._moveFingerID ~= nil and self._scaleFingerID ~= nil then
    return
  end
  local pointerEventData = self._slidingAreaEtl.CurrentPointerEventData
  local fingerId = pointerEventData.pointerId
  if self._moveFingerID == nil and self._scaleFingerID ~= fingerId then
    self._moveFingerID = fingerId
    self._moveFingerPos = pointerEventData.position
    if self._scaleFingerID == nil then
      self._moved = false
      self._touchTime = GameGlobal:GetInstance():GetCurrentTime()
    end
  elseif self._scaleFingerID == nil and self._moveFingerID ~= fingerId then
    self._scaleFingerID = fingerId
    self._scaleFingerPos = pointerEventData.position
  end
  if self._moveFingerID and self._scaleFingerID then
    self._scaleDistance = Vector2.Distance(self._moveFingerPos, self._scaleFingerPos)
  end
end

function UIWidgetHomelandMedalWallController:OnDragSlidingArea(pointerEventData)
  if self._moveFingerID and self._scaleFingerID then
    local scaled = false
    if self._moveFingerID == pointerEventData.pointerId then
      self._moveFingerPos = pointerEventData.position
      scaled = true
    elseif self._scaleFingerID == pointerEventData.pointerId then
      self._scaleFingerPos = pointerEventData.position
      scaled = true
    end
    if scaled then
      self._moved = true
      local newDistance = Vector2.Distance(self._moveFingerPos, self._scaleFingerPos)
      self._homelandInputControllerMedalWall:HandleScale((newDistance - self._scaleDistance) * self._scaleFactor)
      self._scaleDistance = newDistance
    end
  elseif self._moveFingerID == pointerEventData.pointerId then
    self._homelandInputControllerMedalWall:HandleMove(pointerEventData.delta)
    self._moved = true
  end
end

function UIWidgetHomelandMedalWallController:OnUpSlidingArea()
  if self._moveFingerID == nil and self._scaleFingerID == nil then
    return
  end
  local pointerEventData = self._slidingAreaEtl.CurrentPointerEventData
  if self._moveFingerID == pointerEventData.pointerId then
    if not self._moved then
      local interval = GameGlobal:GetInstance():GetCurrentTime() - self._touchTime
      if interval < self._clickInterval then
        self._homelandInputControllerMedalWall:HandleMedalClick(self._moveFingerPos)
      end
    end
    self._moveFingerID = nil
    self._moveFingerPos = nil
  elseif self._scaleFingerID == pointerEventData.pointerId then
    self._scaleFingerID = nil
    self._scaleFingerPos = nil
  end
end
