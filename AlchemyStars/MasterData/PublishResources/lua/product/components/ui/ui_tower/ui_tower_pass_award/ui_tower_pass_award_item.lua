_class("UITowerPassAwardItem", UICustomWidget)
UITowerPassAwardItem = UITowerPassAwardItem

function UITowerPassAwardItem:OnShow(uiParams)
  self:_GetComponents()
end

function UITowerPassAwardItem:_GetComponents()
  self._uIItem = self:GetUIComponent("UISelectObjectPath", "UIItem")
end

function UITowerPassAwardItem:SetData(data, callBack)
  if data == nil then
    return
  end
  self._data = data
  self._callBack = callBack
  local cfg = Cfg.cfg_item[self._data.assetid]
  if cfg then
    local widget = self._uIItem:SpawnObject("UIItem")
    widget:SetForm(UIItemForm.Base, UIItemScale.Level1)
    widget:SetData({
      icon = cfg.Icon,
      text1 = self._data.count,
      text2 = StringTable.Get(cfg.Name),
      quality = cfg.Color,
      itemId = cfg.ID
    })
  end
end

function UITowerPassAwardItem:TipBtnOnClick(go)
  if self._callBack then
    self._callBack(self._data.assetid, go.transform.position)
  end
end
