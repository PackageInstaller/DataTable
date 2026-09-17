local this = class("modulePhotoEdit_base", G_UIModuleBase)

function this:open()
end

function this:initParam(params)
  if self.isInit then
    return
  end
  self.isInit = true
  self.rt = params.rt
  self.maskRect = params.maskRect
  self.bgFrame = params.bgFrame
  self.imgRoot = params.imgRoot
  self.photoRect = params.photoRect
  self.photoMask = params.photoMask
  self.onSaveHandler = handler(self, self.onSave)
  L_PhotoManager:addListener(L_PhotoManager.event.photoEditSave, self.onSaveHandler)
end

function this:toBind(uiBinding)
  if self.isShow == nil then
    this.super.toBind(self, uiBinding)
  else
    self:toShow()
  end
end

function this:unBind(uiBinding)
  if self.isShow == nil then
    this.super.unBind(self, uiBinding)
  else
    self:toHide()
  end
end

function this:syncPhotoMask()
  if self.maskRect ~= nil then
    self.maskRect.gameObject:SetActive(false)
  end
  if self.photoMask ~= nil then
    self.photoMask.enabled = true
    local photoMaskRect = self.photoMask.gameObject:GetComponent(typeof(C_RectTransform))
    local maskSize = self.maskRect.sizeDelta
    local maskPos = self.maskRect.anchoredPosition
    local parentSize = self.imgRoot.sizeDelta
    photoMaskRect.sizeDelta = parentSize
    local upPadding = parentSize.y / 2 - maskSize.y / 2 - maskPos.y
    local downPadding = parentSize.y / 2 - maskSize.y / 2 + maskPos.y
    local leftPadding = parentSize.x / 2 - maskSize.x / 2 + maskPos.x
    local rightPadding = parentSize.x / 2 - maskSize.x / 2 - maskPos.x
    local padding = C_Vector4(leftPadding, downPadding, rightPadding, upPadding)
    self.photoMask.padding = padding
  end
  if self.maskRect ~= nil then
    self:syncBgFrame()
  end
end

function this:syncBgFrame()
  local rect = self.bgFrame
  local maskSize = self.maskRect.sizeDelta
  local maskPos = self.maskRect.position
  rect.position = maskPos
  rect.sizeDelta = maskSize + C_Vector2(36, 36)
end

function this:onSave()
end

function this:refresh()
end

function this:close()
  L_PhotoManager:removeListener(L_PhotoManager.event.photoEditSave, self.onSaveHandler)
end

return this
