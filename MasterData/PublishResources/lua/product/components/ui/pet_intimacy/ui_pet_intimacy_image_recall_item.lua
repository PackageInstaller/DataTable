_class("UIPetIntimacyImageRecallItem", UICustomWidget)
UIPetIntimacyImageRecallItem = UIPetIntimacyImageRecallItem

function UIPetIntimacyImageRecallItem:OnShow(uiParams)
  self._titleLabel = self:GetUIComponent("UILocalizationText", "Title")
  self._conditionLabel = self:GetUIComponent("UILocalizationText", "Condition")
  self._conditionRollingText = self:GetUIComponent("RollingText", "Condition")
  self._petNameLabel = self:GetUIComponent("UILocalizationText", "PetName")
  self._indexLabel = self:GetUIComponent("UILocalizationText", "Index")
  self._memoryPicLoader = self:GetUIComponent("RawImageLoader", "MemoryPic")
  self._selectedFrameGo = self:GetGameObject("SelectedFrame")
  self._titleGo = self:GetGameObject("Title")
  self._conditionGo = self:GetGameObject("Condition")
  self._unSelectedGo = self:GetGameObject("UnSelected")
  self._memoryPicGo = self:GetGameObject("MemoryPic")
  self._collectGo = self:GetGameObject("collectGo")
  self._collect = false
end

function UIPetIntimacyImageRecallItem:Refresh(intimacyMainController, intimacyImageRecall, petData, data)
  if GameSingle then
    data.collect = true
    data.isOpen = true
  end
  self._intimacyMainController = intimacyMainController
  self._intimacyImageRecall = intimacyImageRecall
  self._petData = petData
  self._data = data
  self._collect = data.collect
  self._memoryPicLoader:LoadImage(self._data.icon)
  self._indexLabel:SetText(self._data.index)
  self._petNameLabel:SetText(StringTable.Get(self._petData:GetPetName()))
  self._titleLabel:SetText(StringTable.Get(self._data.title))
  self._collectGo:SetActive(self._collect)
  self:RefreshSelectedStatus()
end

function UIPetIntimacyImageRecallItem:RefreshSelectedStatus()
  if self._data.isOpen then
    self._conditionGo:SetActive(false)
    self._memoryPicGo:SetActive(true)
    self._titleGo:SetActive(true)
    if self._data.isSelected then
      self._selectedFrameGo:SetActive(true)
      self._unSelectedGo:SetActive(false)
    else
      self._selectedFrameGo:SetActive(false)
      self._unSelectedGo:SetActive(true)
    end
  else
    self._conditionGo:SetActive(true)
    self._memoryPicGo:SetActive(false)
    self._selectedFrameGo:SetActive(false)
    self._unSelectedGo:SetActive(false)
    self._titleGo:SetActive(false)
    local conditionStr = ""
    if self._data.condition then
      local condition = Cfg.pet_intimacy_condition[self._data.condition]
      conditionStr = StringTable.Get(condition.Des)
    end
    self._conditionLabel.text = conditionStr
    self._conditionRollingText:RefreshText(conditionStr)
  end
end

function UIPetIntimacyImageRecallItem:ButtonImageRecallOnClick(go)
  if not self._data.isOpen then
    return
  end
  self._intimacyImageRecall:OnItemClicked(self, self._data)
  self:ShowDialog("UIPetIntimacyImageRecallController", self._data, self._petData)
end
