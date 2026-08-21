_class("UIS4TradeCrewWidget", UICustomWidget)
UIS4TradeCrewWidget = UIS4TradeCrewWidget

function UIS4TradeCrewWidget:Constructor()
  self._sliderWidth = 515
end

function UIS4TradeCrewWidget:OnShow(uiParams)
  self._atlas = self:GetAsset("UIS4TradeGame.spriteatlas", LoadType.SpriteAtlas)
  self:_GetComponents()
end

function UIS4TradeCrewWidget:_GetComponents()
  local comp1, comp2, comp3 = {}, {}, {}
  comp1.valueComp = self:GetUIComponent("UILocalizationText", "power1Value")
  comp1.sliderComp = self:GetUIComponent("Slider", "power1Slider")
  comp1.targetRect = self:GetUIComponent("RectTransform", "targetMark1")
  comp1.levelUpRect = self:GetUIComponent("RectTransform", "levelUpMark1")
  comp1.fill = self:GetUIComponent("Image", "Fill1")
  comp1.fillAreaObj = self:GetGameObject("FillArea1")
  comp1.powerNextSlider = self:GetUIComponent("Slider", "power1NextSlider")
  comp2.valueComp = self:GetUIComponent("UILocalizationText", "power2Value")
  comp2.sliderComp = self:GetUIComponent("Slider", "power2Slider")
  comp2.targetRect = self:GetUIComponent("RectTransform", "targetMark2")
  comp2.levelUpRect = self:GetUIComponent("RectTransform", "levelUpMark2")
  comp2.fill = self:GetUIComponent("Image", "Fill2")
  comp2.fillAreaObj = self:GetGameObject("FillArea2")
  comp2.powerNextSlider = self:GetUIComponent("Slider", "power2NextSlider")
  comp3.valueComp = self:GetUIComponent("UILocalizationText", "power3Value")
  comp3.sliderComp = self:GetUIComponent("Slider", "power3Slider")
  comp3.targetRect = self:GetUIComponent("RectTransform", "targetMark3")
  comp3.levelUpRect = self:GetUIComponent("RectTransform", "levelUpMark3")
  comp3.fill = self:GetUIComponent("Image", "Fill3")
  comp3.fillAreaObj = self:GetGameObject("FillArea3")
  comp3.powerNextSlider = self:GetUIComponent("Slider", "power3NextSlider")
  self._compTb = {
    comp1,
    comp2,
    comp3
  }
end

function UIS4TradeCrewWidget:SetData(tradeData, selectID)
  self._tradeData = tradeData
  self._selectID = selectID
  self:_InitComponents()
end

function UIS4TradeCrewWidget:_InitComponents()
  self:Refresh(false)
end

function UIS4TradeCrewWidget:Refresh(isShowNext)
  local maxValue = self._tradeData:GetShipMaxValueByID(self._selectID)
  local curValue = self._tradeData:GetShipCurValueByID(self._selectID)
  local needValue = self._tradeData:GetShipNeedValueByID(self._selectID)
  local nextValue = self._tradeData:GetShipNextValueByID(self._selectID)
  local nextNeedValue = self._tradeData:GetShipNextNeedValueByID(self._selectID)
  for i, comp in pairs(self._compTb) do
    local value = ""
    local addValue = ""
    local tempValue = nextValue[i] - curValue[i]
    if tempValue ~= 0 then
      addValue = 0 < tempValue and "+" .. tempValue or tempValue
    end
    if curValue[i] >= needValue[i] then
      value = "<color=#bb9246>" .. curValue[i] .. "</color>" .. "/" .. needValue[i]
      if isShowNext then
        value = "<color=#bb9246>" .. curValue[i] .. addValue .. "</color>" .. "/" .. needValue[i]
      end
      comp.fill.sprite = self._atlas:GetSprite("exp_s4_paoshang_zjm_jdt2")
    else
      value = "<color=#985542>" .. curValue[i] .. "</color>" .. "/" .. needValue[i]
      if isShowNext then
        value = "<color=#985542>" .. curValue[i] .. addValue .. "</color>" .. "/" .. needValue[i]
      end
      comp.fill.sprite = self._atlas:GetSprite("exp_s4_paoshang_zjm_jdt3")
    end
    comp.sliderComp.maxValue = maxValue[i]
    comp.sliderComp.value = curValue[i]
    comp.valueComp:SetText(value)
    comp.levelUpRect.gameObject:SetActive(isShowNext)
    comp.fillAreaObj:SetActive(isShowNext)
    comp.targetRect.anchoredPosition = Vector2(self._sliderWidth * needValue[i] / maxValue[i], 2)
    comp.levelUpRect.anchoredPosition = Vector2(self._sliderWidth * nextNeedValue[i] / maxValue[i], 3)
    comp.powerNextSlider.maxValue = maxValue[i]
    comp.powerNextSlider.value = nextValue[i]
  end
end

function UIS4TradeCrewWidget:OptionRefresh(optionValue)
  local optionValue = self._tradeData:GetShipOptionValue(self._selectID, optionValue)
  local maxValue = self._tradeData:GetShipMaxValueByID(self._selectID)
  for i, comp in pairs(self._compTb) do
    local value = optionValue[i] .. "/" .. maxValue[i]
    comp.sliderComp.maxValue = maxValue[i]
    comp.sliderComp.value = optionValue[i]
    comp.valueComp:SetText(value)
    comp.levelUpRect.gameObject:SetActive(false)
  end
end

function UIS4TradeCrewWidget:GetCompByType(type)
  return self._compTb[type + 1]
end
