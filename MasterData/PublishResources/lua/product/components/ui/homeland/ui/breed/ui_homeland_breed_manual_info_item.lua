_class("UIHomelandBreedManualInfoItem", UICustomWidget)
UIHomelandBreedManualInfoItem = UIHomelandBreedManualInfoItem

function UIHomelandBreedManualInfoItem:Constructor()
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._itemModule = GameGlobal.GetModule(ItemModule)
end

function UIHomelandBreedManualInfoItem:OnShow(uiParams)
  self:_GetComponents()
  self:_OnValue()
end

function UIHomelandBreedManualInfoItem:_GetComponents()
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._item = self:GetUIComponent("UISelectObjectPath", "Item")
  self._possess = self:GetUIComponent("UILocalizationText", "Possess")
  self._description = self:GetUIComponent("UILocalizationText", "Description")
  self._descriptionObj = self:GetGameObject("Description")
  self._line = self:GetGameObject("Line")
end

function UIHomelandBreedManualInfoItem:_OnValue()
  self._itemWidget = self._item:SpawnObject("UIHomelandBreedItem")
end

function UIHomelandBreedManualInfoItem:SetData(data)
  self._data = data
  local cfg = Cfg.cfg_item[self._data.ID]
  local cfgTree = Cfg.cfg_item_tree_attribute[self._data.ID]
  self._name:SetText(StringTable.Get(cfg.Name))
  self._itemWidget:SetData(cfg, Vector2(345, 345), Vector2(325, 325))
  local count = self._itemModule:GetItemCount(self._data.ID)
  local str = ""
  if 0 < count then
    str = StringTable.Get("str_homeland_breed_tree_count", count)
  else
    str = StringTable.Get("str_homeland_not_got")
  end
  self._possess:SetText(str)
  self._description:SetText(StringTable.Get(cfgTree.Description))
  local settings = self._description:GetGenerationSettings(self._description.rectTransform.rect.size)
  local textGenerator = self._description.cachedTextGenerator
  textGenerator:Invalidate()
  textGenerator:Populate(self._description.text, settings)
  UnityEngine.Canvas.ForceUpdateCanvases()
  if textGenerator.lineCount > 1 then
    for i = 1, textGenerator.lineCount - 1 do
      local line = UnityEngine.GameObject.Instantiate(self._line, self._descriptionObj.transform)
      line:SetActive(true)
      line.transform.localPosition = Vector3(0, -45 - 52 * i, 0)
    end
  end
end

function UIHomelandBreedManualInfoItem:_Got(id)
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
