local this = class("moduleSituationDragHandler", G_UIModuleBase)
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle

function this.bind()
  return {activeCancel = true}
end

function this.methods()
  return {
    onDrag = function(self, screenPos)
      self:updatePos(screenPos)
    end,
    onBeginDrag = function(self, screenPos)
      self:beginRecordPos()
    end,
    onEndDrag = function(self, screenPos)
      self:endRecordPos()
      self:syncUIPos()
    end,
    onClickCancel = function(self)
      self:emit("onClickCancel")
    end,
    onClickConfirm = function(self)
      self:emit("onClickConfirm")
    end,
    onSliderValueChanged = function(self, value)
      self:updateRot(value)
    end,
    onBeginSlider = function(self)
      self:beginRecordRot()
    end,
    onEndSlider = function(self)
      self:endRecordRot()
    end,
    onClickLeft = function(self)
      self:clickRotate(1)
    end,
    onClickRight = function(self)
      self:clickRotate(-1)
    end,
    onLongPressLeft = function(self)
      self:longPressRotate(1)
    end,
    onLongPressRight = function(self)
      self:longPressRotate(-1)
    end,
    onLongClickLeftBegin = function(self)
      self:beginClick(1)
    end,
    onLongClickLeftEnd = function(self)
      self:endClick()
    end,
    onLongClickRightBegin = function(self)
      self:beginClick(-1)
    end,
    onLongClickRightEnd = function(self)
      self:endClick()
    end
  }
end

function this:open()
  L_SituationStore:listenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndo, self)
  if not self.timer then
    self.timer = Timer.repeated(0, function()
      self:syncUIPos()
    end, self, self.gameObject)
  end
end

function this:close()
  L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndo, self)
  if self.timer then
    Timer.remove(self.timer)
  end
end

function this:onUndo()
  if L_CommonUtil.isValid(self.gameObject) and self.gameObject.activeSelf and self.targetObj then
    self:syncUIPos()
    self:syncUIRot()
  end
end

function this:bindObj(obj)
  self.targetObj = obj
  if obj then
    self:syncUIPos()
    self:syncUIRot()
  end
  self.limitCheck = nil
end

function this:syncUIPos()
  if self.targetObj then
    local worldPos = self.targetObj.transform.position
    local screenPos = C_CameraManager.mainCamera:WorldToScreenPoint(worldPos)
    local v2 = C_Vector2(screenPos.x, screenPos.y)
    local _, pos = _screenPosToUI(self.gameObject.transform.parent, v2, C_CameraManager.uiCamera)
    L_Vector3.setAnchored(self.gameObject.transform, pos)
  end
end

function this:syncUIRot()
  if self.targetObj then
    local rot = self.targetObj.transform.rotation
    self.bindComponents.slider:SetValueWithoutNotify(rot.eulerAngles.y)
  end
end

function this:updatePos(screenPos)
  local ray = C_CameraManager.mainCamera:ScreenPointToRay(C_Vector3(screenPos.x, screenPos.y, 0))
  local groundPlane = Unity.Plane(C_Vector3.up, C_Vector3.zero)
  local succ, distance = groundPlane:Raycast(ray)
  if succ then
    local point = ray:GetPoint(distance)
    local localPos = L_SituationManager:toSolutionLocalPos(point)
    local inLimit = L_SituationManager:checkPosInLimit(localPos)
    if not inLimit and self.limitCheck then
      return
    end
    self.limitCheck = not inLimit
    localPos = L_SituationManager:limitPos(localPos)
    localPos.y = 0
    L_Vector3.setLocalPos(self.targetObj.transform, localPos)
  end
end

function this:updateRot(y)
  if self.targetObj then
    local rot = self.targetObj.transform.rotation.eulerAngles
    local newRot = L_Vector3.new(rot.x, y, rot.z)
    L_Vector3.setRot(self.targetObj.transform, newRot)
  end
end

function this:clickRotate(dir)
  if self.longPressing then
    return
  end
  local v = self.bindComponents.slider.value + dir
  if 0 <= v and v <= 359 then
    self:emit("onRotChanged", self.bindComponents.slider.value, v)
  end
end

function this:beginClick(dir)
  if self.clickDir ~= nil and dir ~= self.clickDir then
    return
  end
  self.longPressing = false
  self.clickDir = dir
  self:beginRecordRot()
end

function this:endClick()
  self.clickDir = nil
  if self.longPressing then
    self:endRecordRot()
  else
    self.beginRot = nil
  end
end

function this:longPressRotate(dir)
  if self.clickDir ~= nil and dir ~= self.clickDir then
    return
  end
  self.longPressing = true
  local v = self.bindComponents.slider.value + dir
  if 0 <= v and v <= 359 and self.targetObj then
    local rot = self.targetObj.transform.rotation.eulerAngles
    local newRot = L_Vector3.new(rot.x, v, rot.z)
    L_Vector3.setRot(self.targetObj.transform, newRot)
    self:syncUIRot()
  end
end

function this:beginRecordRot()
  if not self.targetObj then
    return
  end
  self.beginRot = self.targetObj.transform.rotation.eulerAngles.y
end

function this:endRecordRot()
  if not self.targetObj or not self.beginRot then
    return
  end
  self.endRot = self.targetObj.transform.rotation.eulerAngles.y
  if self.beginRot ~= self.endRot then
    self:emit("onRotChanged", self.beginRot, self.endRot)
  end
  self.beginRot = nil
  self.endRot = nil
end

function this:beginRecordPos()
  if not self.targetObj then
    return
  end
  self.beginPos = self.targetObj.transform.localPosition
end

function this:endRecordPos()
  if not self.targetObj or not self.beginPos then
    return
  end
  self.endPos = self.targetObj.transform.localPosition
  if self.beginPos ~= self.endPos then
    self:emit("onPosChanged", self.beginPos, self.endPos)
  end
  self.beginPos = nil
  self.endPos = nil
end

function this:onCameraPosChanged()
  if self.gameObject.activeSelf then
    self:syncUIPos()
  end
end

return this
