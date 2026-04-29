_class("UIHomelandBreedPreviewItem", UICustomWidget)
UIHomelandBreedPreviewItem = UIHomelandBreedPreviewItem

function UIHomelandBreedPreviewItem:Constructor()
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._itemWidget = nil
end

function UIHomelandBreedPreviewItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIHomelandBreedPreviewItem:_GetComponents()
  self._item = self:GetUIComponent("UISelectObjectPath", "Item")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._probability = self:GetUIComponent("UILocalizationText", "Probability")
  self._probabilityBg = self:GetGameObject("ProbabilityBg")
  self._got = self:GetGameObject("Got")
end

function UIHomelandBreedPreviewItem:SetData(previewType, seed, data)
  self._seed = seed
  self._data = data
  self._itemWidget = self._item:SpawnObject("UIHomelandBreedItem")
  local cfg = Cfg.cfg_item[self._data.cfg.ID]
  self._itemWidget:SetData(cfg)
  self._name:SetText(StringTable.Get(cfg.Name))
  self._got:SetActive(not self:_Got(self._data.cfg.ID))
  if previewType == HomelandBreedPreviewType.Mutation then
    self._probabilityBg:SetActive(true)
    local probabilityStr = self:_GetProbability()
    self._probability:SetText(probabilityStr)
  else
    self._probabilityBg:SetActive(false)
  end
end

function UIHomelandBreedPreviewItem:_GetProbability()
  local probability = self._data.getProbalilityFunc(self._data.cfg)
  local cfgs = Cfg.cfg_homeland_breed_const({})
  for i = 1, #cfgs do
    local cfg = cfgs[i]
    if probability <= cfg.Probability then
      return StringTable.Get(cfg.Desc)
    end
  end
  local cfg = cfgs[#cfgs]
  return StringTable.Get(cfg.Desc)
end

function UIHomelandBreedPreviewItem:_Got(id)
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
