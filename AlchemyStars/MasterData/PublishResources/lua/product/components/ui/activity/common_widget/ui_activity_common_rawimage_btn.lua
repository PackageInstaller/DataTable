_class("UIActivityCommonRawImageBtn", UICustomWidget)
UIActivityCommonRawImageBtn = UIActivityCommonRawImageBtn

function UIActivityCommonRawImageBtn:OnShow()
  self._root = self:GetGameObject("_root")
  self._normal = self:GetGameObject("_normal")
  self._click = self:GetGameObject("_click")
  self._normal:SetActive(true)
  self._click:SetActive(false)
  self:_AddUIEvent(self._root)
end

function UIActivityCommonRawImageBtn:SetData(size, urlNormal, urlClick, callback)
  self:_SetSize(size)
  self:_SetRawImage("_normal", urlNormal)
  self:_SetRawImage("_click", urlClick)
  self._callback = callback
end

function UIActivityCommonRawImageBtn:_SetSize(size)
  local obj = self:GetUIComponent("RectTransform", "_root")
  obj.transform.sizeDelta = size
end

function UIActivityCommonRawImageBtn:_SetRawImage(widgetName, url)
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(url)
end

function UIActivityCommonRawImageBtn:_AddUIEvent(btn)
  UIEventTriggerListener.Get(btn).onDown = function(go)
    self._normal:SetActive(false)
    self._click:SetActive(true)
  end
  UIEventTriggerListener.Get(btn).onUp = function(go)
    self._normal:SetActive(true)
    self._click:SetActive(false)
    if self._callback then
      self._callback()
    end
  end
end
