_class("UIHomelandBreedDirectiveItem", UICustomWidget)
UIHomelandBreedDirectiveItem = UIHomelandBreedDirectiveItem

function UIHomelandBreedDirectiveItem:Constructor()
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._itemWidget = nil
end

function UIHomelandBreedDirectiveItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIHomelandBreedDirectiveItem:_GetComponents()
  self._item = self:GetUIComponent("UISelectObjectPath", "Item")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._got = self:GetGameObject("Got")
end

function UIHomelandBreedDirectiveItem:SetData(data, index, callBack)
  self._data = data
  self._index = index
  self._callback = callBack
  self._itemWidget = self._item:SpawnObject("UIHomelandBreedItem")
  local cfg = Cfg.cfg_item[self._data.ID]
  self._itemWidget:SetData(cfg)
  self._name:SetText(cfg.Name)
  self._got:SetActive(not self:_Got(self._data.ID))
end

function UIHomelandBreedDirectiveItem:ClickBtnOnClick(go)
  if self._callback then
    self._callback(self._data.ID, self._index)
  end
end

function UIHomelandBreedDirectiveItem:_Got(id)
  local ids = self._homelandModule:GetHomelandInfo().cultivation_info.already_cultivation_list
  if not ids or table.count(ids) <= 0 then
    return false
  end
  for _, _id in pairs(ids) do
    if _id == id then
      return true
    end
  end
  return false
end
