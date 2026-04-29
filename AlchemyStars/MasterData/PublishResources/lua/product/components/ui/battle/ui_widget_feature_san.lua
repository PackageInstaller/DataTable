_class("UIWidgetFeatureSan", UICustomWidget)
UIWidgetFeatureSan = UIWidgetFeatureSan

function UIWidgetFeatureSan:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetFeatureSan:InitWidget()
  self._imageNormalGo = self:GetGameObject("ImageNormal")
  self._imageWarningGo = self:GetGameObject("ImageWarning")
  self._imageNormal = self:GetUIComponent("Image", "ImageNormal")
  self._imageWarning = self:GetUIComponent("Image", "ImageWarning")
  self._sanValue = self:GetUIComponent("UILocalizationText", "SanValue")
  self._anim = self:GetUIComponent("Animation", "UIWidgetFeatureSan")
  self._imageWarningGo:SetActive(false)
  self._animName = {
    [1] = "uieffanim_N16_UIWidgetFeatureSan_01",
    [2] = "uieffanim_N16_UIWidgetFeatureSan_02"
  }
  self._curAnimLevel = 0
  self:RegisterEvent()
end

function UIWidgetFeatureSan:RegisterEvent()
  self:AttachEvent(GameEventType.FeatureSanValueChange, self._OnFeatureSanValueChange)
  self:AttachEvent(GameEventType.FeatureSanMaxValueChange, self._OnFeatureSanMaxValueChange)
end

function UIWidgetFeatureSan:SetData(sanInitInfo)
  self._sanInitData = sanInitInfo
  local sanityParam = self._sanInitData:GetSanityParam()
  self._sanEffTopVal = BattleConst.SanViewEffDefaultStartVal
  if sanityParam and sanityParam.viewEffStartVal then
    self._sanEffTopVal = sanityParam.viewEffStartVal
  end
  local enterValue = sanInitInfo:GetEnterSanValue()
  self._maxVal = sanInitInfo:GetMaxSanValue()
  self._minVal = sanInitInfo:GetMinSanValue()
  self:SetValue(enterValue)
end

function UIWidgetFeatureSan:UIWidgetFeatureSanOnClick(go)
  if InnerGameHelperRender.IsPuzzleState() or InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
    return
  end
  self:ShowDialog("UIFeatureSanInfo", self._sanInitData, self._curVal, self._maxVal)
end

function UIWidgetFeatureSan:SetValue(sanValue)
  self._curVal = sanValue
  self:_SetUiValue(self._curVal)
end

function UIWidgetFeatureSan:_SetUiValue(sanValue)
  if sanValue > self._maxVal then
    sanValue = self._maxVal
  end
  if sanValue < self._minVal then
    sanValue = self._minVal
  end
  sanValue = math.floor(sanValue + 0.5)
  self._sanValue:SetText(sanValue)
  local sanNormal = 0 < sanValue
  self._imageNormalGo:SetActive(sanNormal)
  self._imageWarningGo:SetActive(not sanNormal)
  if sanValue <= self._sanEffTopVal and 0 < sanValue then
    if self._curAnimLevel ~= 1 then
      self._curAnimLevel = 1
      self._anim:Play(self._animName[1])
    end
  elseif sanValue == 0 then
    if self._curAnimLevel ~= 2 then
      self._curAnimLevel = 2
      self._anim:Play(self._animName[2])
    end
  elseif self._curAnimLevel ~= 0 then
    self._curAnimLevel = 0
    self._anim:Stop()
  end
end

function UIWidgetFeatureSan:_OnFeatureSanValueChange(curValue, oldValue, modifyValue, forceRefresh)
  self._curVal = self._curVal + modifyValue
  self:SetValue(self._curVal)
  if forceRefresh == 1 then
    self._curVal = curValue
    self:SetValue(self._curVal)
  end
end

function UIWidgetFeatureSan:_OnFeatureSanMaxValueChange(curValue, oldValue, modifyValue, curMaxValue)
  self._maxVal = curMaxValue
  self._curVal = self._curVal + modifyValue
  self:SetValue(self._curVal)
end
