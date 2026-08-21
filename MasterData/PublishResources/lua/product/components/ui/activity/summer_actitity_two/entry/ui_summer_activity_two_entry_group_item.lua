_class("UISummerActivityTwoEntryGroupItem", UICustomWidget)
UISummerActivityTwoEntryGroupItem = UISummerActivityTwoEntryGroupItem

function UISummerActivityTwoEntryGroupItem:OnShow()
  self._go = self:GetGameObject("Go")
  self._loader = self:GetUIComponent("UISelectObjectPath", "spawnobj")
  self._currentSelectedItem = nil
end

function UISummerActivityTwoEntryGroupItem:Refresh(groupData, selecteChangeCallback)
  if groupData == nil or #groupData <= 0 then
    self._go:SetActive(false)
    return
  end
  self._groupData = groupData
  self._selecteChangeCallback = selecteChangeCallback
  self._go:SetActive(true)
  self._loader:SpawnObjects("UISummerActivityTwoEntryItem", #groupData)
  self._list = self._loader:GetAllSpawnList()
  for i = 1, #self._list do
    self._list[i]:Refresh(self._groupData[i], true, function()
      self:OnItemClicked(self._list[i])
    end, #groupData <= 1)
  end
  for i = 1, #self._list do
    local entryData = self._list[i]:GetEntryData()
    if entryData:IsSelected() then
      self._list[i]:SelectedBtnOnClick()
      break
    end
  end
end

function UISummerActivityTwoEntryGroupItem:OnItemClicked(entryItem)
  if self._currentSelectedItem == entryItem then
    self._currentSelectedItem = nil
  else
    self._currentSelectedItem = entryItem
  end
  local isSelectedGroup = self._currentSelectedItem ~= nil
  for i = 1, #self._list do
    self._list[i]:SetSelectStatus(self._list[i] == self._currentSelectedItem, isSelectedGroup)
  end
  self._selecteChangeCallback()
end

function UISummerActivityTwoEntryGroupItem:ClearSelected()
  self._currentSelectedItem = nil
  for i = 1, #self._list do
    self._list[i]:SetSelectStatus(false, false)
  end
end

function UISummerActivityTwoEntryGroupItem:GetSelectedEntryItem()
  return self._currentSelectedItem
end
