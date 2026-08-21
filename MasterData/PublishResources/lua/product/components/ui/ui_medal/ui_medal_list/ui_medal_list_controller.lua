_class("UIMedalListController", UIController)
UIMedalListController = UIMedalListController

function UIMedalListController:Constructor()
  self.medalModule = GameGlobal.GetModule(MedalModule)
  self.data = UIMedalListData.New()
  self.data:Init(self.medalModule.client_medal_info)
  self.curFilterItem = nil
  self.curSelectMedalItem = nil
  self.curSelectMedalData = nil
  self.isDynamicSvInited = nil
  self.curMedalList = nil
  self._itemCountPerRow = 4
  self._dynamicListSize = 0
end

function UIMedalListController:OnShow(uiParams)
  self:InitWidget()
  self:StartTask(function(TT)
    self:InitFilters(TT)
  end, self)
end

function UIMedalListController:OnHide()
end

function UIMedalListController:InitWidget()
  self.txtProgress = self:GetUIComponent("UILocalizationText", "txtProgress")
  self.tabsList = self:GetUIComponent("UISelectObjectPath", "tabsList")
  self.emptyList = self:GetGameObject("emptyList")
  self.dynamicSv = self:GetUIComponent("UIDynamicScrollView", "dynamicSv")
  local itemDetailPool = self:GetUIComponent("UISelectObjectPath", "itemDetail")
  self.itemDetail = itemDetailPool:SpawnObject("UIMedalListItemDetail")
  self._ani = self:GetUIComponent("Animation", "_ani")
end

function UIMedalListController:InitFilters(TT)
  local filters = self.data:GetFilterIds()
  self.filters = filters
  local len = #filters
  self.tabsList:SpawnObjects("UIMedalListTab", len)
  local tabs = self.tabsList:GetAllSpawnList()
  self.tabItems = tabs
  for i = 1, #tabs do
    local item = tabs[i]
    local filterInfo = self.data:GetFilterInfoById(filters[i])
    if i == 1 then
      self.curFilterItem = item
    end
    item:SetData(filterInfo, i == 1, function(item)
      self:OnFilterClicked(item)
    end)
    item:GetGameObject():SetActive(i == 1)
  end
  self:RefreshFiltersNew()
  self:RefreshItemList()
  for i = 2, #tabs do
    YIELD(TT, 50)
    local item = tabs[i]
    item:GetGameObject():SetActive(true)
  end
end

function UIMedalListController:RefreshFiltersNew()
  local tabs = self.tabItems
  for i = 1, #tabs do
    local item = tabs[i]
    local bNew = self.data:IsFilterNew(self.filters[i])
    item:SetNew(bNew)
  end
end

function UIMedalListController:OnFilterClicked(item)
  if self.curFilterItem == item then
    return
  end
  self._ani:Play("uieff_UIMedalListController_in2")
  if self.curFilterItem then
    self.curFilterItem:SetSelect(false, true)
  end
  self.curFilterItem = item
  self.curFilterItem:SetSelect(true, true)
  self:RefreshItemList()
end

function UIMedalListController:RefreshItemList()
  if not self.curFilterItem then
    return
  end
  self.curSelectMedalItem = nil
  self.curSelectMedalData = nil
  local filter = self.curFilterItem:GetFilterID()
  self.curMedalList = self.data:GetItemsByFilter(filter)
  local len = #self.curMedalList
  self.emptyList:SetActive(len == 0)
  if 0 < len then
    self.curSelectMedalData = self.curMedalList[1]
    self._itemCountPerRow = 4
    self._dynamicListSize = math.floor((len - 1) / self._itemCountPerRow + 1)
    if not self.isDynamicSvInited then
      self.isDynamicSvInited = true
      self.dynamicSv:InitListView(self._dynamicListSize, function(scrollView, index)
        return self:_SpawnListItem(scrollView, index)
      end)
    else
      self:_RefreshItemScroll(self._dynamicListSize, self.dynamicSv)
    end
  end
  self:RefreshMedalDetail()
  self.txtProgress:SetText("<color=#f3d39b>" .. self.data.receiveMedalCount .. "</color>/" .. self.data.allMedalCount)
end

function UIMedalListController:_SpawnListItem(scrollView, rowIndex)
  if rowIndex < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIMedalListItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local subItem = rowList[i]
    local itemIndex = rowIndex * self._itemCountPerRow + i
    if itemIndex > #self.curMedalList then
      subItem:GetGameObject():SetActive(false)
    else
      subItem:GetGameObject():SetActive(true)
      self:_RefreshMedalItem(subItem, itemIndex)
    end
  end
  return item
end

function UIMedalListController:_RefreshItemScroll(count, list)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  list.ScrollRect.content.localPosition = contentPos
end

function UIMedalListController:_RefreshMedalItem(item, index)
  local medalData
  if self.curMedalList then
    medalData = self.curMedalList[index]
  end
  if medalData then
    local isSelect = medalData:GetTemplID() == self.curSelectMedalData:GetTemplID()
    item:SetData(medalData, isSelect, function(item)
      self:OnMedalItemClicked(item)
    end)
    if isSelect then
      self.curSelectMedalItem = item
    end
  end
end

function UIMedalListController:OnMedalItemClicked(item)
  local itemId = item:GetID()
  if self.curSelectMedalData:GetTemplID() == itemId then
    self:CancleNew()
    return
  end
  if self.curSelectMedalItem then
    self.curSelectMedalItem:SetSelect(false)
  end
  self.curSelectMedalItem = item
  self.curSelectMedalData = item:GetData()
  self.curSelectMedalItem:SetSelect(true)
  self:RefreshMedalDetail()
  self:CancleNew()
end

function UIMedalListController:CancleNew()
  if self.curSelectMedalData:IsNew() then
    local pstId = self.curSelectMedalData:GetPstId()
    local tmpId = self.curSelectMedalData:GetID()
    if pstId then
      self:StartTask(function(TT)
        self:Lock("UIMedalList:MedalItemSelect")
        local itemModule = self:GetModule(ItemModule)
        itemModule:SetItemUnnew(TT, pstId)
        self.curSelectMedalItem:SetNewReviewed()
        self.data:SetUnNew(tmpId)
        self:RefreshFiltersNew()
        self:UnLock("UIMedalList:MedalItemSelect")
      end)
    end
  end
end

function UIMedalListController:RefreshMedalDetail()
  if self.curSelectMedalData then
    self.itemDetail:SetData(self.curSelectMedalData)
  end
end

function UIMedalListController:BtnBackOnClick(go)
  local newIds = self.data:GetAllNewPstId()
  if #newIds < 1 then
    self:CloseWithAni()
  else
    self:StartTask(function(TT)
      self:Lock("UIMedalList:MedalItemCancelAllNew")
      local itemModule = self:GetModule(ItemModule)
      itemModule:SetItemListUnnew(TT, newIds)
      self:UnLock("UIMedalList:MedalItemCancelAllNew")
      self:CloseWithAni()
    end)
  end
end

function UIMedalListController:CloseWithAni()
  self:StartTask(function(TT)
    local lockName = "UIMedalListController_PlayAnimOut()"
    self:Lock(lockName)
    self._ani:Play("uieff_UIMedalListController_out")
    YIELD(TT, 450)
    self:UnLock(lockName)
    self:CloseDialog()
  end, self)
end
