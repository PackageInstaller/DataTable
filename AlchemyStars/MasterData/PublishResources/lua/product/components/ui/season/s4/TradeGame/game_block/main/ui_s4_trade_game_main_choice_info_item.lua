_class("UIS4TradeGameMainChoiceInfoItem", UICustomWidget)
UIS4TradeGameMainChoiceInfoItem = UIS4TradeGameMainChoiceInfoItem

function UIS4TradeGameMainChoiceInfoItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIS4TradeGameMainChoiceInfoItem:_GetComponents()
  self._value = self:GetUIComponent("UILocalizationText", "value")
  self._percent = self:GetUIComponent("UILocalizationText", "percent")
  self._targetTxt = self:GetUIComponent("UILocalizationText", "targetTxt")
  self._lineObj = self:GetGameObject("Line")
end

function UIS4TradeGameMainChoiceInfoItem:SetData(data, isEnd)
  self._data = data
  self._lineObj:SetActive(not isEnd)
  self:_InitComponents()
end

function UIS4TradeGameMainChoiceInfoItem:_InitComponents()
  local str = "str_season_s4_trade_game_choice" .. self._data.valueType
  local txt = StringTable.Get(str)
  self._targetTxt:SetText(txt)
  local valueTxt = self._data.value > 0 and "+" .. self._data.value or self._data.value
  self._value:SetText(valueTxt)
  local tempTxt = self._data.percent .. "%"
  local percentTxt = StringTable.Get("str_season_s4_trade_chance")
  self._percent:SetText(tempTxt .. percentTxt)
  self:SetSelect(false)
end

function UIS4TradeGameMainChoiceInfoItem:SetSelect(isSelect)
  if isSelect then
    self._value.color = Color(0.8901960784313725, 0.8627450980392157, 0.7843137254901961)
    self._percent.color = Color(0.8901960784313725, 0.8627450980392157, 0.7843137254901961)
    self._targetTxt.color = Color(0.8901960784313725, 0.8627450980392157, 0.7843137254901961)
  else
    self._value.color = Color(0.34509803921568627, 0.2784313725490196, 0.2549019607843137)
    self._percent.color = Color(0.596078431372549, 0.3333333333333333, 0.25882352941176473)
    self._targetTxt.color = Color(0.34509803921568627, 0.2784313725490196, 0.2549019607843137)
  end
  if self._data.value < 0 then
    self._value.color = Color(0.8392156862745098, 0.43529411764705883, 0.3254901960784314)
  end
end
