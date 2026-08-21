_class("UIS4TradeGameMainCrewWidget", UICustomWidget)
UIS4TradeGameMainCrewWidget = UIS4TradeGameMainCrewWidget

function UIS4TradeGameMainCrewWidget:Constructor()
  self._sliderWidth = 515
end

function UIS4TradeGameMainCrewWidget:OnShow(uiParams)
  self._atlas = self:GetAsset("UIS4TradeGame.spriteatlas", LoadType.SpriteAtlas)
  self:_GetComponents()
end

function UIS4TradeGameMainCrewWidget:_GetComponents()
  local comp1, comp2, comp3 = {}, {}, {}
  comp1.valueComp = self:GetUIComponent("UILocalizationText", "power1Value")
  comp1.sliderComp = self:GetUIComponent("Slider", "power1Slider")
  comp1.targetRect = self:GetUIComponent("RectTransform", "targetMark1")
  comp1.fill = self:GetUIComponent("Image", "Fill1")
  comp1.previewSlider = self:GetUIComponent("Slider", "power1PreviewSlider")
  comp2.valueComp = self:GetUIComponent("UILocalizationText", "power2Value")
  comp2.sliderComp = self:GetUIComponent("Slider", "power2Slider")
  comp2.targetRect = self:GetUIComponent("RectTransform", "targetMark2")
  comp2.fill = self:GetUIComponent("Image", "Fill2")
  comp2.previewSlider = self:GetUIComponent("Slider", "power2PreviewSlider")
  comp3.valueComp = self:GetUIComponent("UILocalizationText", "power3Value")
  comp3.sliderComp = self:GetUIComponent("Slider", "power3Slider")
  comp3.targetRect = self:GetUIComponent("RectTransform", "targetMark3")
  comp3.fill = self:GetUIComponent("Image", "Fill3")
  comp3.previewSlider = self:GetUIComponent("Slider", "power3PreviewSlider")
  self._compTb = {
    comp1,
    comp2,
    comp3
  }
  self._comp0 = {}
  self._comp0.valueComp = self:GetUIComponent("UILocalizationText", "power0Value")
  self._comp0.sliderComp = self:GetUIComponent("Slider", "power0Slider")
  self._comp0.previewSlider = self:GetUIComponent("Slider", "power0PreviewSlider")
end

function UIS4TradeGameMainCrewWidget:SetData(tradeData, selectID)
  self._tradeData = tradeData
  self._selectID = selectID
  self:_InitComponents()
end

function UIS4TradeGameMainCrewWidget:_InitComponents()
  self:Refresh()
end

function UIS4TradeGameMainCrewWidget:Refresh()
  local maxSpeed, maxLoad = self._tradeData:GetShipLoadValueByID(self._selectID)
  local nowSpeed, nowLoad = self._tradeData:GetNowSpeedAndLoad(self._selectID)
  local maxValue = self._tradeData:GetShipMaxValueByID(self._selectID)
  local curValue = self._tradeData:GetShipCurValueByID(self._selectID)
  local needValue = self._tradeData:GetShipNeedValueByID(self._selectID)
  for i, comp in pairs(self._compTb) do
    local value = ""
    if curValue[i] >= needValue[i] then
      value = "<color=#bb9246>" .. curValue[i] .. "</color>" .. "/" .. needValue[i]
      comp.fill.sprite = self._atlas:GetSprite("exp_s4_paoshang_zjm_jdt2")
    else
      value = "<color=#985542>" .. curValue[i] .. "</color>" .. "/" .. needValue[i]
      comp.fill.sprite = self._atlas:GetSprite("exp_s4_paoshang_zjm_jdt3")
    end
    comp.sliderComp.maxValue = maxValue[i]
    comp.sliderComp.value = curValue[i]
    comp.previewSlider.maxValue = maxValue[i]
    comp.previewSlider.value = curValue[i]
    comp.valueComp:SetText(value)
    comp.targetRect.anchoredPosition = Vector2(self._sliderWidth * needValue[i] / maxValue[i], 2)
  end
  self._comp0.valueComp:SetText("<color=#bb9246>" .. nowLoad .. "</color>")
  self._comp0.sliderComp.maxValue = maxLoad
  self._comp0.sliderComp.value = nowLoad
  self._comp0.previewSlider.maxValue = maxLoad
  self._comp0.previewSlider.value = nowLoad
end

function UIS4TradeGameMainCrewWidget:OptionRefresh(optionValue, previewOptionValue)
  previewOptionValue = previewOptionValue or {
    0,
    0,
    0,
    0
  }
  local needValue = self._tradeData:GetShipNeedValueByID(self._selectID)
  local optionValues = self._tradeData:GetShipOptionValue(self._selectID, optionValue)
  for i, comp in pairs(self._compTb) do
    local value = ""
    local changeValue = ""
    optionValues[i] = optionValues[i] < 0 and 0 or optionValues[i]
    if previewOptionValue[i + 1] ~= 0 then
      changeValue = 0 < previewOptionValue[i + 1] and "+" .. previewOptionValue[i + 1] or previewOptionValue[i + 1]
    end
    if optionValues[i] >= needValue[i] then
      value = "<color=#bb9246>" .. optionValues[i] .. changeValue .. "</color>" .. "/" .. needValue[i]
      comp.fill.sprite = self._atlas:GetSprite("exp_s4_paoshang_zjm_jdt2")
    else
      value = "<color=#985542>" .. optionValues[i] .. changeValue .. "</color>" .. "/" .. needValue[i]
      comp.fill.sprite = self._atlas:GetSprite("exp_s4_paoshang_zjm_jdt3")
    end
    comp.sliderComp.value = optionValues[i]
    comp.previewSlider.value = optionValues[i] + previewOptionValue[i + 1]
    comp.valueComp:SetText(value)
  end
  local loadChangeValue = ""
  if previewOptionValue[1] ~= 0 then
    loadChangeValue = 0 < previewOptionValue[1] and "+" .. previewOptionValue[1] or previewOptionValue[1]
  end
  self._comp0.valueComp:SetText("<color=#bb9246>" .. optionValues[4] .. loadChangeValue .. "</color>")
  self._comp0.sliderComp.value = optionValues[4]
  self._comp0.previewSlider.value = optionValues[4] + previewOptionValue[1]
end

function UIS4TradeGameMainCrewWidget:GetCompByType(type)
  return self._compTb[type + 1]
end
