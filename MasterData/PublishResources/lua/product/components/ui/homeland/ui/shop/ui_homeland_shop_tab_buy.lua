_class("UIHomelandShopTabBuy", UICustomWidget)
UIHomelandShopTabBuy = UIHomelandShopTabBuy

function UIHomelandShopTabBuy:OnShow(uiParams)
  self._isOpen = true
end

function UIHomelandShopTabBuy:OnHide()
  self._isOpen = false
end

function UIHomelandShopTabBuy:SetData(shop_info)
  self._shop_info = shop_info
  self:_SetDynamicList()
end

function UIHomelandShopTabBuy:_GetDynamicListData(first)
  local map = self._shop_info.chs_map
  local cfg = Cfg.cfg_homeland_shop({})
  local tb_normal = {}
  local tb_limit = {}
  for i, v in pairs(cfg) do
    local id = v.ID
    local flag_show = true
    local flag_soldout = false
    local soldCount = map[id] or 0
    if v.Type ~= 0 then
      flag_soldout = soldCount >= v.Limit
      if v.Type == 2 and flag_soldout and first then
        self._limit_soldout[v.ID] = true
      end
    end
    if not self._limit_soldout[v.ID] then
      local tb = v.Type == 0 and tb_normal or tb_limit
      table.insert(tb, {
        id = id,
        soldout = flag_soldout,
        soldCount = soldCount,
        week_time = self._shop_info.goods_week_time,
        moth_time = self._shop_info.goods_moth_time,
        cfg = v
      })
    end
  end
  table.sort(tb_normal, function(a, b)
    if a.cfg.SortValue ~= b.cfg.SortValue then
      return a.cfg.SortValue < b.cfg.SortValue
    else
      return a.id < b.id
    end
  end)
  table.sort(tb_limit, function(a, b)
    if a.soldout and not b.soldout then
      return false
    elseif not a.soldout and b.soldout then
      return true
    elseif a.cfg.SortValue ~= b.cfg.SortValue then
      return a.cfg.SortValue < b.cfg.SortValue
    else
      return a.id < b.id
    end
  end)
  return tb_normal, tb_limit
end

function UIHomelandShopTabBuy:_SetDynamicListData()
  self._first_flag = self._first_flag and self._first_flag + 1 or 1
  self._limit_soldout = self._limit_soldout or {}
  self._list_normal, self._list_limit = self:_GetDynamicListData(self._first_flag == 1)
  self._itemCountPerRow = 5
  self._size_normal = math.floor((table.count(self._list_normal) - 1) / self._itemCountPerRow + 1)
  self._size_limit = #self._list_limit > 0 and 1 or 0
  self._dynamicListSize = self._size_normal + self._size_limit
end

function UIHomelandShopTabBuy:_SetDynamicList()
  self:_SetDynamicListData()
  if not self._isDynamicInited then
    self._isDynamicInited = true
    self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "_dynamicList")
    self._dynamicList:InitListView(self._dynamicListSize, function(scrollView, index)
      return self:_SpawnListItem(scrollView, index)
    end)
  else
    self:_RefreshList(self._dynamicListSize, self._dynamicList)
  end
end

function UIHomelandShopTabBuy:_RefreshList(count, list)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  list.ScrollRect.content.localPosition = contentPos
end

function UIHomelandShopTabBuy:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  if self._size_limit == 1 and index == 0 then
    return self:_SpawnListItem_Limit(scrollView, index)
  end
  return self:_SpawnListItem_Normal(scrollView, index)
end

function UIHomelandShopTabBuy:_SpawnListItem_Limit(scrollView, index)
  local _className = "UIHomelandShopTabBuyListItem"
  local item = scrollView:NewListViewItem("RowItem2")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects(_className, #self._list_limit)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, #rowList do
    local listItem = rowList[i]
    listItem:GetGameObject():SetActive(false)
    if i <= #self._list_limit then
      listItem:GetGameObject():SetActive(true)
      local info = self._list_limit[i]
      listItem:SetData(i, info)
      if not self.firstBuyBtn then
        self.firstBuyBtn = listItem:GetBuyBtn()
      end
    end
  end
  local rect = item.gameObject:GetComponent("RectTransform")
  self:_ReCalcSize(rect)
  return item
end

function UIHomelandShopTabBuy:_SpawnListItem_Normal(scrollView, index)
  local _className = "UIHomelandShopTabBuyListItem"
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects(_className, self._itemCountPerRow)
  end
  local _index = index - self._size_limit
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local listItem = rowList[i]
    local itemIndex = _index * self._itemCountPerRow + i
    if itemIndex > #self._list_normal then
      listItem:GetGameObject():SetActive(false)
    else
      listItem:GetGameObject():SetActive(true)
      local info = self._list_normal[itemIndex]
      listItem:SetData(itemIndex, info)
      if not self.firstBuyBtn then
        self.firstBuyBtn = listItem:GetBuyBtn()
      end
    end
  end
  return item
end

function UIHomelandShopTabBuy:_ReCalcSize(rect)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
  self._dynamicList:OnItemSizeChanged(0)
end

function UIHomelandShopTabBuy:GetBuyBtn()
  return self.firstBuyBtn
end

function UIHomelandShopTabBuy:GetMask()
  return self:GetGameObject("Mask")
end
