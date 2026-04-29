_class("UISetControllerToggleSlider", UICustomWidget)
UISetControllerToggleSlider = UISetControllerToggleSlider

function UISetControllerToggleSlider:OnShow()
  self._isInitOver = false
  self.toggle = self:GetUIComponent("Toggle", "Toggle")
  self.describeText = self:GetUIComponent("UILocalizationText", "LocalizationText")
  self.slider = self:GetUIComponent("Slider", "Slider")
  self.textSlider = self:GetUIComponent("Text", "TextSlider")
  self.backgroundOff = self:GetGameObject("BackgroundOff")
  self.backgroundOn = self:GetGameObject("BackgroundOn")
  self.fillOff = self:GetGameObject("FillOff")
  self.fillOn = self:GetGameObject("FillOn")
  self.imageOff = self:GetGameObject("ImageOff")
  self.imageOn = self:GetGameObject("ImageOn")
  self.toggleBG = self:GetGameObject("ToggleBG")
  
  function self.OnSliderValueChange(value)
    local floorValue = Mathf.Floor(value)
    self.sliderValue = floorValue
    self:OnRefreshSliderValue(false)
  end
  
  self.slider.onValueChanged:AddListener(self.OnSliderValueChange)
  
  function self.OnToggleValueChanged(isOn)
    if self._isInitOver then
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
    end
    self.toggleValue = isOn and 1 or 0
    self:OnRefreshSliderValue(false)
  end
  
  self.toggle.onValueChanged:AddListener(self.OnToggleValueChanged)
end

function UISetControllerToggleSlider:Init(index, describeText, sliderLocalDBKey, toggleLocalDBKey, callBack, param)
  self.index = index
  self.describeText.text = StringTable.Get(describeText)
  self.callBack = callBack
  self.sliderLocalDBKey = sliderLocalDBKey
  self.toggleLocalDBKey = toggleLocalDBKey
  self.param = param
  if sliderLocalDBKey then
    self.sliderValue = LocalDB.GetInt(sliderLocalDBKey, 100)
  end
  if toggleLocalDBKey then
    self.toggleValue = LocalDB.GetInt(toggleLocalDBKey, 1)
  end
  self:OnRefreshSliderValue(true)
  self._isInitOver = true
end

function UISetControllerToggleSlider:OnRefreshSliderValue(first)
  self.slider.value = self.sliderValue
  self.textSlider.text = self.sliderValue
  local isOn = self.toggleValue > 0
  self.backgroundOn:SetActive(isOn)
  self.backgroundOff:SetActive(not isOn)
  self.fillOn:SetActive(isOn)
  self.fillOff:SetActive(not isOn)
  self.imageOn:SetActive(isOn)
  self.imageOff:SetActive(not isOn)
  self.toggleBG:SetActive(not isOn)
  self.toggle.isOn = isOn
  self.slider.enabled = isOn
  if self.callBack and not first then
    self.callBack(self.param, self.index, self.sliderValue, self.toggleValue)
  end
  self:OnSetLocalDB()
end

function UISetControllerToggleSlider:OnHide()
  self.slider.onValueChanged:RemoveListener(self.OnSliderValueChange)
  self.toggle.onValueChanged:RemoveListener(self.OnToggleValueChanged)
  self:OnSetLocalDB()
end

function UISetControllerToggleSlider:OnSetLocalDB()
  if self.sliderLocalDBKey then
    LocalDB.SetInt(self.sliderLocalDBKey, self.sliderValue)
  end
  if self.toggleLocalDBKey then
    LocalDB.SetInt(self.toggleLocalDBKey, self.toggleValue)
  end
end
