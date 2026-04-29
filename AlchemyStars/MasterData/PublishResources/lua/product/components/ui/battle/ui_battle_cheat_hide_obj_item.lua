_class("UIBattleCheatHideObjItem", UICustomWidget)
UIBattleCheatHideObjItem = UIBattleCheatHideObjItem

function UIBattleCheatHideObjItem:OnShow(uiparam)
  self._uiLocalizationText = self:GetUIComponent("UILocalizationText", "describe")
  self._tgl = self:GetUIComponent("Toggle", "HideObjItem")
  self._hide = false
end

function UIBattleCheatHideObjItem:OnHide()
end

function UIBattleCheatHideObjItem:SetData(index, text, hide, getCallback)
  self._index = index
  self._str = text
  self._hide = hide
  self:OnRefresh()
  self._getCallback = getCallback
end

function UIBattleCheatHideObjItem:OnRefresh()
  self._uiLocalizationText:SetText(self._str)
  self._tgl.isOn = self._hide
end

function UIBattleCheatHideObjItem:HideObjItemOnClick()
  if self._hide == true then
    self._hide = false
  else
    self._hide = true
  end
  self:OnRefresh()
  if self._getCallback then
    self._getCallback(self._index, self._str, self._hide)
  end
end
