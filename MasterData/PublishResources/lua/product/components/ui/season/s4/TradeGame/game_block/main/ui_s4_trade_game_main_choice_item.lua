_class("UIS4TradeGameMainChoiceItem", UICustomWidget)
UIS4TradeGameMainChoiceItem = UIS4TradeGameMainChoiceItem

function UIS4TradeGameMainChoiceItem:Constructor()
  self._isSelect = false
end

function UIS4TradeGameMainChoiceItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIS4TradeGameMainChoiceItem:_GetComponents()
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._infoGroup = self:GetUIComponent("UISelectObjectPath", "infoGroup")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._selectMark = self:GetUIComponent("Image", "selectMark")
end

function UIS4TradeGameMainChoiceItem:SetData(tradeData, group, selectCB)
  self._tradeData = tradeData
  self._group = group
  self._selectCB = selectCB
  self:_InitComponents()
end

function UIS4TradeGameMainChoiceItem:_InitComponents()
  self._infos = self._infoGroup:SpawnObjects("UIS4TradeGameMainChoiceInfoItem", table.count(self._group))
  for i, infoItem in pairs(self._infos) do
    infoItem:SetData(self._group[i], i == table.count(self._infos))
  end
  self._title:SetText(StringTable.Get(Cfg.cfg_component_business_option[self._group[1].optionID].OptionName))
end

function UIS4TradeGameMainChoiceItem:SetSelect(isSelect)
  if self._isSelect == isSelect then
    return
  end
  self._isSelect = isSelect
  for _, info in pairs(self._infos) do
    info:SetSelect(isSelect)
  end
  if isSelect then
    self._title.color = Color(0.8901960784313725, 0.8627450980392157, 0.7843137254901961)
    self._selectMark:DOFade(1, 0.3)
  else
    self._title.color = Color(0.34509803921568627, 0.2784313725490196, 0.2549019607843137)
    self._selectMark:DOFade(0, 0.3)
  end
end

function UIS4TradeGameMainChoiceItem:GetOptionDataTb()
  return self._group
end

function UIS4TradeGameMainChoiceItem:BtnOnClick()
  if self._selectCB then
    self._selectCB(self)
  end
end
