_class("UIAircraftFurnitureTip", Object)
UIAircraftFurnitureTip = UIAircraftFurnitureTip

function UIAircraftFurnitureTip:Constructor(onCancle, onRotate, onConfirm, uiView, sceneCam)
  self._uiView = uiView
  self._sceneCamera = sceneCam
  uiView:GetUIComponent("UIEventTriggerListener", "cancel").onClick = onCancle
  uiView:GetUIComponent("UIEventTriggerListener", "rotate").onClick = function()
    onRotate(self._rectTransform.anchoredPosition)
  end
  uiView:GetUIComponent("UIEventTriggerListener", "confirm").onClick = onConfirm
  self._images = {
    uiView:GetUIComponent("Image", "cancel"),
    uiView:GetUIComponent("Image", "rotate"),
    uiView:GetUIComponent("Image", "confirm")
  }
  self._cancleBtn = uiView:GetUIComponent("Button", "cancel")
  self._shown = false
  self._root = uiView:GetGameObject("root")
  self._rectTransform = uiView:GetUIComponent("RectTransform", "root")
  self._parent = self._rectTransform.parent
end

function UIAircraftFurnitureTip:OnDragStart()
  for _, image in ipairs(self._images) do
    image.raycastTarget = false
  end
end

function UIAircraftFurnitureTip:OnDragEnd()
  for _, image in ipairs(self._images) do
    image.raycastTarget = true
  end
end

function UIAircraftFurnitureTip:Update()
  if self._shown then
    local screenPos = self._sceneCamera:WorldToScreenPoint(self._fur:WorldPosition() + self._offset)
    local uiCam = GameGlobal.UIStateManager():GetControllerCamera("UIAircraftDecorateController")
    local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._parent, screenPos, uiCam, nil)
    self._rectTransform.anchoredPosition = pos
  end
end

function UIAircraftFurnitureTip:Show(fur)
  if self._shown then
    return
  end
  self._shown = true
  self._fur = fur
  local pos = self:_getPos(fur)
  self._offset = pos
  local canRemove = self._fur:OprateType() == FurnitureOpration.Free
  self._cancleBtn.interactable = canRemove
  self._root:SetActive(true)
end

function UIAircraftFurnitureTip:Hide()
  if not self._shown then
    return
  end
  self._shown = false
  self._fur = nil
  self._root:SetActive(false)
end

function UIAircraftFurnitureTip:Dispose()
end

function UIAircraftFurnitureTip:_getPos(fur)
  local type = fur:LocationType()
  local pos
  if type == LocationType.Floor then
    pos = Vector3(0, 1.5, 0)
  elseif type == LocationType.Wall then
    local up = Vector3.up * fur:WorldRotation()
    pos = up * 0.5
  elseif type == LocationType.Ceiling then
    pos = Vector3(0, -1, 0)
  end
  return pos
end
