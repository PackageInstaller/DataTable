_class("UIChooseSortFilterItem", UICustomWidget)
UIChooseSortFilterItem = UIChooseSortFilterItem

function UIChooseSortFilterItem:Constructor()
  self.MaxCol = 4
  self._rowSortBtnPos = {
    [1] = 82,
    [2] = 266,
    [3] = 451,
    [4] = 635
  }
end

function UIChooseSortFilterItem:OnShow(uiParams)
  self:GetComponents()
  self._petModule = GameGlobal.GetModule(PetModule)
end

function UIChooseSortFilterItem:GetComponents()
  self._sortsPool = self:GetUIComponent("UISelectObjectPath", "sortRowItem")
  self._propertiesPool = self:GetUIComponent("UISelectObjectPath", "attributeRowItem")
  self._typePool = self:GetUIComponent("UISelectObjectPath", "tagRowItem")
  self._powerPool = self:GetUIComponent("UISelectObjectPath", "influenceRowItem")
  self._scrollView = self:GetUIComponent("ScrollRect", "Scroll View")
  self._content = self:GetUIComponent("RectTransform", "Content")
  self._secondAttributeSelcetMark = self:GetGameObject("selectMarkImage")
  self._sortLayerPool = self:GetUIComponent("UISelectObjectPath", "sortLayerRoot")
  self._sortsPoolTrans = self:GetUIComponent("RectTransform", "sortRowItem")
end

function UIChooseSortFilterItem:SetData(sortType, sortOrder, filterParams, sortCfg, filterCfg, onChange, onClose)
  self._sortType = sortType
  self._sortOrder = sortOrder
  self._filterTable = filterParams
  self._sortListCfg = sortCfg
  self._filterCfg = filterCfg
  self._onChanged = onChange
  self._closeCallBack = onClose
  self:OnValue()
end

function UIChooseSortFilterItem:SortBtnBySize()
  local c = table.count(self._sortPool)
  local totalCol = 1
  local currentCalCol = 1
  for i = 1, c do
    if 4 < currentCalCol then
      totalCol = totalCol + 1
      currentCalCol = 1
    end
    if self._sortPool[i].Type == PetSortType.Element then
      currentCalCol = currentCalCol + 2
    else
      currentCalCol = currentCalCol + 1
    end
  end
  self.sortLayer_All = self._sortLayerPool:SpawnObjects("UiSortRowLayer", totalCol)
  local currentCol = 1
  local groupIndex = 1
  self:SetBtnGroupSizeInfo(self.sortLayer_All[groupIndex].view.gameObject)
  for i = 1, c do
    if 4 < currentCol then
      currentCol = 1
      groupIndex = groupIndex + 1
      self:SetBtnGroupSizeInfo(self.sortLayer_All[groupIndex].view.gameObject)
    end
    self:SetSortBtnItemTrans(self._sortBtns_all[i].view.gameObject, self.sortLayer_All[groupIndex].view.gameObject.transform, currentCol)
    if self._sortPool[i].Type == PetSortType.Element then
      currentCol = currentCol + 2
    else
      currentCol = currentCol + 1
    end
  end
end

function UIChooseSortFilterItem:SetSortBtnItemTrans(obj, parent, index)
  obj.transform.parent = parent
  local rect = obj.transform:GetComponent("RectTransform")
  rect.anchorMax = Vector2(0, 1)
  rect.anchorMin = Vector2(0, 1)
  rect.pivot = Vector2(0.5, 0.5)
  local pos = Vector3(self._rowSortBtnPos[index], 0, 0)
  obj.transform.localPosition = pos
end

function UIChooseSortFilterItem:SetBtnGroupSizeInfo(obj)
  local trans = obj:GetComponent("RectTransform")
  trans.transform.parent = self._sortsPoolTrans.transform
end

function UIChooseSortFilterItem:OnValue()
  self._sortPool = {}
  self._secondAttributeSelectStatus = self._petModule.PetSortChooseSecondAttribute
  self._secondAttributeSelcetMark:SetActive(self._secondAttributeSelectStatus)
  for key, value in HelperProxy:GetInstance():pairsByKeys(self._sortListCfg) do
    table.insert(self._sortPool, value)
  end
  local c = table.count(self._sortPool)
  self._sortsPool:SpawnObjects("UIChooseSortBtnItem1", c)
  self._sortBtns_all = self._sortsPool:GetAllSpawnList()
  for i = 1, c do
    self._sortBtns_all[i]:SetData(i, self._sortPool[i], self._sortType, self._sortOrder, function(idx)
      self:SortClick(idx)
    end, self._petModule.PetSortElementIndex)
  end
  self:SortBtnBySize()
  local filters = {
    [PetFilterTag.ShuXing] = {
      pool = self._propertiesPool,
      title = self:GetGameObject("att"),
      items = self._filterCfg[PetFilterTag.ShuXing]
    },
    [PetFilterTag.LeiXing] = {
      pool = self._typePool,
      title = self:GetGameObject("tag"),
      items = self._filterCfg[PetFilterTag.LeiXing]
    },
    [PetFilterTag.ShiLi] = {
      pool = self._powerPool,
      title = self:GetGameObject("influence"),
      items = self._filterCfg[PetFilterTag.ShiLi]
    }
  }
  self._filterBtns = {}
  
  local function onBtnClick(type, tag)
    self:OnFilterBtnClick(type, tag)
  end
  
  for tag, value in pairs(filters) do
    if value.items and #value.items > 0 then
      local count = #value.items
      value.pool:SpawnObjects("UIChooseSortFilterBtnItem", count)
      local btns = value.pool:GetAllSpawnList()
      for i = 1, count do
        local btn = btns[i]
        local idx = #self._filterBtns + 1
        btn:SetData(value.items[i], self._filterTable, onBtnClick)
        self._filterBtns[idx] = btn
      end
      value.pool.dynamicInfoOfEngine.gameObject:SetActive(true)
      value.title:SetActive(true)
    else
      value.pool.dynamicInfoOfEngine.gameObject:SetActive(false)
      value.title:SetActive(false)
    end
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._content)
  self._isOpen = true
  if self._content.rect.size.y > self._scrollView:GetComponent("RectTransform").rect.size.y then
    self._scrollView.enabled = true
  else
    self._scrollView.enabled = false
  end
end

function UIChooseSortFilterItem:SortClick(idx)
  local tp = self._sortListCfg[idx].Type
  self:OnSortChanged(tp)
  self:FlushSortBtns()
end

function UIChooseSortFilterItem:FlushSortBtns()
  for i = 1, table.count(self._sortBtns_all) do
    self._sortBtns_all[i]:Flush(self._sortType, self._sortOrder, self._petModule.PetSortElementIndex)
  end
end

function UIChooseSortFilterItem:FlushFilterBtns()
  for _, btn in ipairs(self._filterBtns) do
    btn:Flush(self._filterTable)
  end
end

function UIChooseSortFilterItem:OnFilterBtnClick(type, tag)
  self:OnFilterChanged(type, tag)
  self:FlushFilterBtns()
end

function UIChooseSortFilterItem:OnSortChanged(type)
  if self._sortType == type then
    if self._sortOrder == PetSortOrder.Ascending then
      self._sortOrder = PetSortOrder.Descending
    elseif self._sortOrder == PetSortOrder.Descending then
      self._sortOrder = PetSortOrder.Ascending
    end
  else
    self._sortType = type
    self._sortOrder = PetSortOrder.Descending
  end
  self:NotifyChange()
end

function UIChooseSortFilterItem:OnFilterChanged(type, tag)
  for i = 1, #self._filterTable do
    if self._filterTable[i]._filter_type == type then
      table.remove(self._filterTable, i)
      self:NotifyChange()
      return
    end
  end
  local filterParam
  if tag then
    filterParam = PetFilterParam:New(type, tag)
  else
    filterParam = PetFilterParam:New(type)
  end
  table.insert(self._filterTable, filterParam)
  self:NotifyChange()
end

function UIChooseSortFilterItem:NotifyChange()
  self._onChanged(self._sortType, self._sortOrder, self._filterTable)
end

function UIChooseSortFilterItem:bgOnClick()
  self:GetGameObject():SetActive(false)
  if self._closeCallBack then
    self._closeCallBack()
  end
end

function UIChooseSortFilterItem:selectMarkImageOnClick()
  if self._secondAttributeSelectStatus then
    self._secondAttributeSelectStatus = false
  else
    self._secondAttributeSelectStatus = true
  end
  self._petModule:SavePetSecondAttributeFilterParam(self._secondAttributeSelectStatus)
  self:NotifyChange()
  self._secondAttributeSelcetMark:SetActive(self._secondAttributeSelectStatus)
end

function UIChooseSortFilterItem:ClearFilters()
  self._filterTable = {}
  self:FlushFilterBtns()
end
