_class("UIPetFilterCards", UICustomWidget)
UIPetFilterCards = UIPetFilterCards

function UIPetFilterCards:OnShow(uiParams)
  self:InitWidget()
end

function UIPetFilterCards:InitWidget()
  self.scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self.content = self:GetGameObject("Content")
  self._emptyTip = self:GetGameObject("EmptyTip")
  self._itemCountPerRow = 6
  self._listShowItemCount = 0
  local param = UIDynamicScrollViewInitParam:New()
  param.mItemDefaultWithPaddingSize = 333
  self.scrollView:InitListView(self._listShowItemCount, function(scrollView, index)
    return self:InitRaw(scrollView, index)
  end, param)
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:IsGuideProcessKey("guide_dormitory_in") then
    self.scrollView.ScrollRect.vertical = false
  else
    self.scrollView.ScrollRect.vertical = true
  end
end

function UIPetFilterCards:SetData(name, removeOne, onSelect)
  self._scriptName = name
  self._removeOne = removeOne
  self._onSelect = onSelect
end

function UIPetFilterCards:Refresh(pets)
  self._petCount = #pets
  self._pets = pets
  if self._petCount == 0 then
    self.scrollView:SetListItemCount(0)
    self.scrollView:MovePanelToItemIndex(0, 0)
    self._emptyTip:SetActive(true)
    return
  end
  self._emptyTip:SetActive(false)
  self.scrollView:SetListItemCount(math.ceil(self._petCount / self._itemCountPerRow))
  self.scrollView:MovePanelToItemIndex(0, 0)
end

function UIPetFilterCards:InitRaw(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
  end
  rowPool.dynamicInfoOfEngine:SetObjectName(self._scriptName .. ".prefab")
  local rowList = rowPool:SpawnObjects(self._scriptName, self._itemCountPerRow)
  for i = 1, self._itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._petCount then
      heartItem:GetGameObject():SetActive(false)
    else
      heartItem:GetGameObject():SetActive(true)
      heartItem:SetData(self._pets[itemIndex], self._removeOne, self._onSelect)
    end
  end
  return item
end

function UIPetFilterCards:GetFirstPet()
  local itemRow = self.scrollView:GetShownItemByIndex(0)
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", itemRow.gameObject)
  local rowList = rowPool:GetAllSpawnList()
  return rowList[1]:GetGameObject("bg")
end
