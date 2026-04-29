_class("UISummerActivityTwoEntryLevelGroup", UICustomWidget)
UISummerActivityTwoEntryLevelGroup = UISummerActivityTwoEntryLevelGroup

function UISummerActivityTwoEntryLevelGroup:OnShow()
  self._go = self:GetGameObject("Go")
  self._loader = self:GetUIComponent("UISelectObjectPath", "spawnobj")
  self._currentSelectedItem = nil
end

function UISummerActivityTwoEntryLevelGroup:Refresh(entryGroupData, selecteChangeCallback)
  if entryGroupData == nil then
    self._go:SetActive(false)
    return
  end
  self._entryGroupData = entryGroupData
  self._selecteChangeCallback = selecteChangeCallback
  self._go:SetActive(true)
  local entryLevelDatas = self._entryGroupData:GetEntryLevelDatas()
  self._loader:SpawnObjects("UISummerActivityTwoEntryLevelItem", #entryLevelDatas)
  self._list = self._loader:GetAllSpawnList()
  for i = 1, #self._list do
    self._list[i]:Refresh(entryLevelDatas[i], true, function()
      self:OnItemClicked(self._list[i])
    end)
  end
  for i = 1, #self._list do
    local entryLevelData = self._list[i]:GetEntryLevelData()
    if entryLevelData:IsSelected() then
      self._list[i]:SelectedBtnOnClick()
      break
    end
  end
end

function UISummerActivityTwoEntryLevelGroup:OnItemClicked(entryItem)
  if self._currentSelectedItem == entryItem then
    self._currentSelectedItem = nil
  else
    self._currentSelectedItem = entryItem
  end
  for i = 1, #self._list do
    self._list[i]:SetSelectStatus(self._list[i] == self._currentSelectedItem)
  end
  self._selecteChangeCallback()
end

function UISummerActivityTwoEntryLevelGroup:GetSelectedEntryLevelItem()
  return self._currentSelectedItem
end
