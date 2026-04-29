_class("UISeasonShowAwards", UIController)
UISeasonShowAwards = UISeasonShowAwards

function UISeasonShowAwards:GetComponents()
  self._trans = self:GetGameObject()
  self._listPerPageCount = 5
  self._curItemPage = 1
  self._curPageFirstIndex = 1
  self._listPageCount = 0
  self._listItemTotalCount = 0
  self._beforeTime = 200
  self._inited = false
  self._itemList = {}
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ItemList")
  self._bg = self:GetUIComponent("RectTransform", "canvasGroup")
  self._bg.localScale = Vector3(1, 1, 1)
  self._titleText = self:GetUIComponent("UILocalizationText", "txt_title")
  self._titleTextGo = self:GetGameObject("txt_title")
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
end

function UISeasonShowAwards:OnShow(uiParams)
  self._closeCallback = uiParams[2]
  self:GetComponents()
  if self._titleText then
    if uiParams[4] then
      local txt = uiParams[4]
      if txt == "" then
        self._titleText:SetText("")
      else
        self._titleText:SetText(txt)
      end
    else
      self._titleText:SetText(StringTable.Get("str_common_gift_get_item"))
    end
  end
  local item_module = GameGlobal.GetModule(ItemModule)
  local itemlist
  if uiParams[1] then
    if table.count(uiParams[1]) == 0 then
      Log.fatal("###[UISeasonShowAwards] table.count(uiParams[1]) == 0 !")
    end
  else
    Log.fatal("###[UISeasonShowAwards] uiParams[1] is nil !")
  end
  if uiParams[3] then
    itemlist = uiParams[1]
  else
    itemlist = item_module:SortRoleAsset(uiParams[1])
  end
  self:CreateData(itemlist)
  self._listItemTotalCount = table.count(self._itemList)
  self:CalcPage()
  self._selectItemIndex = -1
  if self._scrollView then
    self._scrollView:InitListView(1, function(scrollView, index)
      return self:_InitListView(scrollView, index)
    end)
    self._inited = true
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundGetItem)
end

function UISeasonShowAwards:CreateData(itemlist)
  for i = 1, table.count(itemlist) do
    local itemTempleate = Cfg.cfg_item[itemlist[i].assetid]
    if itemTempleate then
      self._itemList[i] = {
        item_id = itemlist[i].assetid,
        item_count = itemlist[i].count,
        item_des = itemlist[i].des,
        award_type = itemlist[i].type,
        icon = itemTempleate.Icon,
        item_name = itemTempleate.Name,
        simple_desc = itemTempleate.RpIntro,
        color = itemTempleate.Color
      }
    end
  end
end

function UISeasonShowAwards:DoAnimation()
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "canvasGroup")
  self._canvasGroup.alpha = 0
  self._tweener = self._canvasGroup:DOFade(1, 0.02)
end

function UISeasonShowAwards:ClosePanel()
  self:CloseDialog()
end

function UISeasonShowAwards:OnHide()
  if self._closeCallback then
    self._closeCallback()
  end
end

function UISeasonShowAwards:_InitListView(scrollView, index)
  if index < 0 then
    return nil
  end
  local count
  if table.count(self._itemList) > 5 then
    count = 5
  else
    count = table.count(self._itemList)
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISeasonShowAwardsItem", count)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, count do
    local giftItem = rowList[i]
    local itemIndex = self:_GetCurPageFirstIndex() + i - 1
    if itemIndex > self._listItemTotalCount then
      giftItem:GetGameObject():SetActive(false)
    else
      self:_ShowItem(giftItem, itemIndex, i)
    end
  end
  return item
end

function UISeasonShowAwards:_ShowItem(giftItem, index, tweenIdx)
  local beforeTime = 0
  if not self._inited then
    beforeTime = self._beforeTime
  end
  local item_data = self:_GetItemDataByIndex(index)
  if item_data then
    giftItem:SetData(item_data, index, function(id, count, go)
      self:OnItemSelect(id, count, go)
    end, Color(1, 1, 1, 1), tweenIdx, beforeTime)
    giftItem:GetGameObject():SetActive(true)
  else
    giftItem:GetGameObject():SetActive(false)
  end
end

function UISeasonShowAwards:OnItemSelect(id, count, go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, id, self._trans.transform.position)
end

function UISeasonShowAwards:NextOnClick(go)
  if self._selectItemIndex ~= -1 then
    self._selectItemIndex = -1
  elseif self:_GetNextPageIndex() ~= -1 then
    self._scrollView:RefreshAllShownItem()
    self._selectItemIndex = -1
  else
    self:ClosePanel()
  end
end

local modf = math.modf

function UISeasonShowAwards:CalcPage()
  local pageCount, mod = modf(self._listItemTotalCount / self._listPerPageCount)
  if mod ~= 0 then
    pageCount = pageCount + 1
  end
  self._listPageCount = pageCount
end

function UISeasonShowAwards:_GetNextPageIndex()
  local index = self._curItemPage * self._listPerPageCount + 1
  if index <= self._listItemTotalCount then
    self._curItemPage = self._curItemPage + 1
    self._curPageFirstIndex = index
    return index
  end
  return -1
end

function UISeasonShowAwards:_GetCurPageFirstIndex()
  return self._curPageFirstIndex
end

function UISeasonShowAwards:_GetItemDataByIndex(index)
  if index > #self._itemList then
    return nil
  end
  return self._itemList[index]
end

function UISeasonShowAwards:_FormatItemCount(itemCount)
  return HelperProxy:GetInstance():FormatItemCount(itemCount)
end

function UISeasonShowAwards:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end
