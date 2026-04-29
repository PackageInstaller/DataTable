_class("UITestFuncBtn", UICustomWidget)
UITestFuncBtn = UITestFuncBtn

function UITestFuncBtn:SetData(params)
  self._params = params
  UIWidgetHelper.SetLocalizationText(self, "_title", params.title)
  self._callback = params.callback
  self:_SetToggle(self._params.toggleValueCallback)
end

function UITestFuncBtn:_SetToggle(toggleValueCallback)
  local isShow = toggleValueCallback ~= nil
  self:GetGameObject("Toggle"):SetActive(isShow)
  if isShow then
    local obj = self:GetUIComponent("Toggle", "Toggle")
    local value = toggleValueCallback()
    obj.isOn = value
  end
end

function UITestFuncBtn:BtnOnClick()
  if self._callback then
    self._callback()
  end
  self:_SetToggle(self._params.toggleValueCallback)
end
