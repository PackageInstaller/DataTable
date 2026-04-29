_class("UIHomelandBreedManualItem", UICustomWidget)
UIHomelandBreedManualItem = UIHomelandBreedManualItem

function UIHomelandBreedManualItem:Constructor()
end

function UIHomelandBreedManualItem:OnShow(uiParams)
  self:_GetComponent()
  self:_OnValue()
end

function UIHomelandBreedManualItem:_GetComponent()
  self._item = self:GetUIComponent("UISelectObjectPath", "Item")
  self._text = self:GetUIComponent("UILocalizationText", "Text")
end

function UIHomelandBreedManualItem:_OnValue()
  self._itemWidget = self._item:SpawnObject("UIHomelandBreedItem")
end

function UIHomelandBreedManualItem:SetData(data)
  self._data = data
  table.sort(self._data.st, function(a, b)
    return a.IsMutation > b.IsMutation
  end)
  local cfg = Cfg.cfg_item[self._data.st[1].ID]
  self._text:SetText(StringTable.Get(cfg.Name))
  self._itemWidget:SetData(cfg, Vector2(345, 345), Vector2(375, 375))
end

function UIHomelandBreedManualItem:DetailsBtnOnClick(go)
  self:ShowDialog("UIHomelandBreedManualInfo", self._name, self._data.st)
end
