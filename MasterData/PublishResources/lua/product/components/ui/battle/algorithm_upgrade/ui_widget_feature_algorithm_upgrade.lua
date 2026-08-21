_class("UIWidgetFeatureAlgorithmUpgrade", UICustomWidget)
UIWidgetFeatureAlgorithmUpgrade = UIWidgetFeatureAlgorithmUpgrade

function UIWidgetFeatureAlgorithmUpgrade:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetFeatureAlgorithmUpgrade:InitWidget()
  self._imageNormalGo = self:GetGameObject("ImageNormal")
  self._imageWarningGo = self:GetGameObject("ImageWarning")
  self._imageNormal = self:GetUIComponent("Image", "ImageNormal")
  self._imageWarning = self:GetUIComponent("Image", "ImageWarning")
  self._txtOEValue = self:GetUIComponent("UILocalizationText", "OverloadEnergy")
  self._imageWarningGo:SetActive(false)
  self:RegisterEvent()
end

function UIWidgetFeatureAlgorithmUpgrade:RegisterEvent()
  self:AttachEvent(GameEventType.FeatureAUOEValueChange, self._OnFeatureAUOEValueChange)
end

function UIWidgetFeatureAlgorithmUpgrade:SetData(initData)
  self._initData = initData
  local maxValue, enterValue = InnerGameHelperRender.GetFeatureAUOverloadEnergyInfo()
  self._maxValue = maxValue
  self:SetValue(enterValue)
end

function UIWidgetFeatureAlgorithmUpgrade:UIWidgetFeatureAlgorithmUpgradeOnClick(go)
  if InnerGameHelperRender.IsPuzzleState() then
    return
  end
  if InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
    return
  end
  self:ShowDialog("UIFeatureAlgorithmUpgradeInfo", self._initData)
end

function UIWidgetFeatureAlgorithmUpgrade:SetValue(oeValue)
  self._curVal = oeValue
  self._txtOEValue:SetText(oeValue)
  local isNormal = oeValue < self._maxValue
  self._imageNormalGo:SetActive(isNormal)
  self._imageWarningGo:SetActive(not isNormal)
end

function UIWidgetFeatureAlgorithmUpgrade:_OnFeatureAUOEValueChange(curValue)
  self:SetValue(curValue)
end
