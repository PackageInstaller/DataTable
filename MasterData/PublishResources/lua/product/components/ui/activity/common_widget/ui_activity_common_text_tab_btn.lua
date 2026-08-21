_class("UIActivityCommonTextTabBtn", UICustomWidget)
UIActivityCommonTextTabBtn = UIActivityCommonTextTabBtn

function UIActivityCommonTextTabBtn:OnShow()
end

function UIActivityCommonTextTabBtn:SetData(index, onoffWidgets, indexWidgets, titleWidgets, titleText, callback)
  self._index = index
  self._onoffGroup = UIWidgetHelper.GetObjGroupByWidgetName(self, onoffWidgets)
  self._indexGroup = UIWidgetHelper.GetObjGroupByWidgetName(self, indexWidgets)
  UIWidgetHelper.SetObjGroupShow(self._indexGroup, index)
  self:_SetText(titleWidgets, titleText)
  self._callback = callback
  self:SetSelected(false)
end

function UIActivityCommonTextTabBtn:SetData(index, params)
  self._index = index
  self:_SetText(params.titleWidgets or {}, params.titleText or "")
  self._indexGroup = UIWidgetHelper.GetObjGroupByWidgetName(self, params.indexWidgets or {})
  UIWidgetHelper.SetObjGroupShow(self._indexGroup, index)
  self._onoffGroup = UIWidgetHelper.GetObjGroupByWidgetName(self, params.onoffWidgets or {})
  self:SetSelected(false)
  self._lockGroup = UIWidgetHelper.GetObjGroupByWidgetName(self, params.lockWidgets or {})
  self:SetLock(false)
  self._callback = params.callback
  self._lockCallback = params.lockCallback
end

function UIActivityCommonTextTabBtn:SetSelected(isOn)
  UIWidgetHelper.SetObjGroupShow(self._onoffGroup, isOn and 1 or 2)
end

function UIActivityCommonTextTabBtn:SetLock(isLock)
  self._isLock = isLock
  UIWidgetHelper.SetObjGroupShow(self._lockGroup, isLock and 1 or 2)
end

function UIActivityCommonTextTabBtn:_SetText(group, titleText)
  for _, v in ipairs(group) do
    local text = self:GetUIComponent("UILocalizationText", v)
    text:SetText(titleText)
  end
end

function UIActivityCommonTextTabBtn:BtnOnClick(go)
  self:OffBtnOnClick(go)
end

function UIActivityCommonTextTabBtn:OffBtnOnClick(go)
  if self._isLock then
    if self._lockCallback then
      self._lockCallback(self._index)
    end
    return
  end
  if self._callback then
    self._callback(self._index, true)
  end
end

function UIActivityCommonTextTabBtn:OnBtnOnClick(go)
  if self._callback then
    self._callback(self._index, false)
  end
end
