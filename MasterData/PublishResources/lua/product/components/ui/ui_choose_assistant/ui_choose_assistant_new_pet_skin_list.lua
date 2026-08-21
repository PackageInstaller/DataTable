_class("UIChooseAssistantNewPetSkinList", UICustomWidget)
UIChooseAssistantNewPetSkinList = UIChooseAssistantNewPetSkinList

function UIChooseAssistantNewPetSkinList:Constructor()
  self._itemCountPerRow = 1
  self._spawnBtnList = {}
end

function UIChooseAssistantNewPetSkinList:OnShow(uiParams)
  self._checkIsCurSkinCallBack = nil
  self._refreshUiCallBack = nil
  self:InitWidget()
end

function UIChooseAssistantNewPetSkinList:InitWidget()
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "scrollView")
  self.descScroll = self:GetUIComponent("ScrollRect", "scrollView")
end

function UIChooseAssistantNewPetSkinList:SetRefreshUiCallBack(callBack)
  self._refreshUiCallBack = callBack
end

function UIChooseAssistantNewPetSkinList:SetCheckIsCurSkinCallBack(callBack)
  self._checkIsCurSkinCallBack = callBack
end

function UIChooseAssistantNewPetSkinList:_RefreshUiByCurSkinIndex(idx)
  if idx and idx == self._curSelSkinIndex then
    return
  end
  self._curSelSkinIndex = idx
  if self._refreshUiCallBack then
    local data = self._datas[self._curSelSkinIndex]
    self._refreshUiCallBack(data.petid, data.grade, data.skinid, data.asid)
  end
end

function UIChooseAssistantNewPetSkinList:_InitScrollView()
  self._spawnBtnList = {}
  if self._scrollView then
    self._initScrollViewFlag = true
    self._scrollView:InitListView(self._skinsCellCount, function(scrollView, index)
      return self:_InitListView(scrollView, index)
    end)
  end
end

function UIChooseAssistantNewPetSkinList:_InitListView(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIChooseAssistantNewPetSkinCard", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local rowitem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > table.count(self._datas) then
      rowitem:GetGameObject():SetActive(false)
    else
      self:_ShowItem(rowitem, itemIndex)
    end
    table.insert(self._spawnBtnList, rowitem)
  end
  return item
end

function UIChooseAssistantNewPetSkinList:_ResetListView()
  self._scrollView:SetListItemCount(table.count(self._datas), true)
  self._spawnBtnList = {}
  self._scrollView:RefreshAllShownItem()
end

function UIChooseAssistantNewPetSkinList:_ShowItem(item, index)
  local data = self._datas[index]
  item:GetGameObject():SetActive(true)
  if data then
    item:SetCheckIsCurSkinCallBack(self._checkIsCurSkinCallBack)
    item:SetData(data, index, function(idx)
      if self._count <= 1 then
        return
      end
      self:_RefreshUiByCurSkinIndex(idx)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeAssistantNewPetSkinCard, idx)
    end)
  end
end

function UIChooseAssistantNewPetSkinList:RefreshData(data)
  self._data = data
  local skinsCellCount = #self._data.skinList
  local asCellCount = #self._data.aslist
  self._skinsCellCount = skinsCellCount + asCellCount
  self._count = self._skinsCellCount
  self._curSelSkinIndex = nil
  self:_SetItemDatas()
  if self._initScrollViewFlag then
    self:_ResetListView()
  else
    self:_InitScrollView()
  end
  local chooseId = 1
  self:_RefreshUiByCurSkinIndex(chooseId)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeAssistantNewPetSkinCard, chooseId)
end

function UIChooseAssistantNewPetSkinList:_SetItemDatas()
  self._datas = {}
  local datas2 = {}
  for i = 1, #self._data.skinList do
    local data = self._data.skinList[i]
    table.insert(datas2, data)
  end
  for i = 1, #self._data.aslist do
    local data = self._data.aslist[i]
    table.insert(datas2, data)
  end
  local insertNewIdx = 0
  local igCount = 0
  for i = 1, #datas2 do
    local data = datas2[i]
    local cur = self._checkIsCurSkinCallBack(data.petid, data.grade, data.skinid, data.asid)
    local new = self:CheckIsNew(data.asid)
    if new then
      igCount = igCount + 1
    end
    if cur then
      insertNewIdx = i
      break
    end
  end
  if insertNewIdx ~= 0 then
    local curData = datas2[insertNewIdx]
    table.remove(datas2, insertNewIdx)
    table.insert(datas2, 1, curData)
  end
  for i = 1, #datas2 do
    local data = datas2[i]
    table.insert(self._datas, data)
  end
end

function UIChooseAssistantNewPetSkinList:CheckIsNew(asid)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local itemDatas = itemModule:GetItemByTempId(asid)
  if itemDatas and table.count(itemDatas) > 0 then
    local item_data
    for key, value in pairs(itemDatas) do
      item_data = value
      break
    end
    local isNew = item_data:IsNewOverlay()
    local pstid = item_data:GetID()
    return isNew, pstid
  end
  return false
end
