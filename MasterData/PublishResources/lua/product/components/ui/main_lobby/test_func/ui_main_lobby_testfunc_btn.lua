_class("UIMainLobbyTestFuncBtn", UICustomWidget)
UIMainLobbyTestFuncBtn = UIMainLobbyTestFuncBtn

function UIMainLobbyTestFuncBtn:OnShow(uiParams)
end

function UIMainLobbyTestFuncBtn:OnHide()
end

function UIMainLobbyTestFuncBtn:SetData(title, params)
  local _params = params
  local callback = _params[1]
  local isToggle = _params[2]
  local getValueCallback = _params[3]
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._txtGo = self:GetGameObject("txtTitle")
  self._toggle = self:GetUIComponent("Toggle", "Toggle")
  self._toggleGo = self:GetGameObject("Toggle")
  self._toggleTex = self:GetUIComponent("UILocalizationText", "Label")
  local txtOrToggle = true
  if isToggle then
    txtOrToggle = false
  end
  self._txtGo:SetActive(txtOrToggle)
  self._toggleGo:SetActive(not txtOrToggle)
  if isToggle then
    self._toggleTex:SetText(title)
    local value = false
    if getValueCallback then
      value = getValueCallback()
    end
    self._toggle.isOn = value
    self._toggle.onValueChanged:AddListener(function(value)
      if callback then
        callback(value)
      end
    end)
  else
    self._txtTitle:SetText(title)
  end
  self._callback = callback
end

function UIMainLobbyTestFuncBtn:BtnOnClick()
  if self._callback then
    self._callback()
  end
end
