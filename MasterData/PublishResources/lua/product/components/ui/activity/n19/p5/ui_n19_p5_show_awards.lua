_class("UIN19P5ShowAwards", UIController)
UIN19P5ShowAwards = UIN19P5ShowAwards

function UIN19P5ShowAwards:OnShow(uiParams)
  self._closeCallback = uiParams[2]
  self._listPerPageCount = 5
  self._curItemPage = 1
  self._curPageFirstIndex = 1
  self._listPageCount = 0
  self._listItemTotalCount = 0
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ItemList")
  self._bg = self:GetUIComponent("RectTransform", "canvasGroup")
  self._bg.localScale = Vector3(1, 1, 1)
  self._beforeTime = 200
  self._inited = false
  if uiParams[1] then
    if table.count(uiParams[1]) == 0 then
      Log.fatal("###[UIN19P5ShowAwards] table.count(uiParams[1]) == 0 !")
    end
  else
    Log.fatal("###[UIN19P5ShowAwards] uiParams[1] is nil !")
  end
  self._itemList = uiParams[1] or {}
  self._listItemTotalCount = table.count(self._itemList)
  self:CalcPage()
  self._selectItemIndex = -1
  if self._scrollView then
    self._scrollView:InitListView(1, function(scrollView, index)
      return self:_InitListView(scrollView, index)
    end)
    self._inited = true
  end
  local bgCanvas = self:GetUIComponent("Canvas", "BGCanvas")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundGetItem)
end

function UIN19P5ShowAwards:DoAnimation()
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "canvasGroup")
  self._canvasGroup.alpha = 0
  self._tweener = self._canvasGroup:DOFade(1, 0.02)
end

function UIN19P5ShowAwards:ClosePanel()
  self:CloseDialog()
  Log.debug("关闭获取物品界面")
  if self._closeCallback then
    Log.debug("关闭回调调用")
    self._closeCallback()
  end
end

function UIN19P5ShowAwards:OnHide()
end

function UIN19P5ShowAwards:_InitListView(scrollView, index)
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
    rowPool:SpawnObjects("UIN19P5ShowAwardsItem", count)
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

function UIN19P5ShowAwards:_ShowItem(giftItem, index, tweenIdx)
  local item_data = self:_GetItemDataByIndex(index)
  if item_data then
    giftItem:SetData(item_data, function(award)
      self:OnItemSelect(award)
    end)
    giftItem:GetGameObject():SetActive(true)
  else
    giftItem:GetGameObject():SetActive(false)
  end
end

function UIN19P5ShowAwards:OnItemSelect(award)
  self:ShowDialog("UIN19P5Tip", award, true)
end

function UIN19P5ShowAwards:NextOnClick(go)
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

function UIN19P5ShowAwards:CalcPage()
  local pageCount, mod = modf(self._listItemTotalCount / self._listPerPageCount)
  if mod ~= 0 then
    pageCount = pageCount + 1
  end
  self._listPageCount = pageCount
end

function UIN19P5ShowAwards:_GetNextPageIndex()
  local index = self._curItemPage * self._listPerPageCount + 1
  if index <= self._listItemTotalCount then
    self._curItemPage = self._curItemPage + 1
    self._curPageFirstIndex = index
    return index
  end
  return -1
end

function UIN19P5ShowAwards:_GetCurPageFirstIndex()
  return self._curPageFirstIndex
end

function UIN19P5ShowAwards:_GetItemDataByIndex(index)
  if index > #self._itemList then
    return nil
  end
  return self._itemList[index]
end

function UIN19P5ShowAwards:_FormatItemCount(itemCount)
  return HelperProxy:GetInstance():FormatItemCount(itemCount)
end

_class("UIN19P5ShowAwardsItem", UIN19P5AwardItem)
UIN19P5ShowAwardsItem = UIN19P5ShowAwardsItem

function UIN19P5ShowAwardsItem:SetData(LotteryAward, callback)
  self.award = LotteryAward
  self.callback = callback
  self:OnValue()
end

function UIN19P5ShowAwardsItem:OnValue()
  self.Mask:SetActive(false)
  self.hide:SetActive(true)
  local id = self.award.m_item_id
  local cfg = Cfg.cfg_item[id]
  if not cfg then
    Log.error("###[UIN19P5AwardItem] cfg is nil ! id --> ", id)
  end
  local color = self.color2color[cfg.Color]
  self.Color.sprite = self.atlas:GetSprite(color)
  local icon = cfg.Icon
  self.Icon:LoadImage(icon)
  local count = self.award.m_count
  self.ItemCount:SetText(count)
  local bgSprite
  if self.award.m_is_big_reward then
    self.BigImg:SetActive(true)
    bgSprite = "n19p5_choujiang_di14"
  elseif self.award.m_reward_type == ECampaignLRType.E_CLRT_rare then
    self.BigImg:SetActive(false)
    bgSprite = "n19p5_choujiang_di15"
  else
    self.BigImg:SetActive(false)
    bgSprite = "n19p5_choujiang_di16"
  end
  self.BgImg.sprite = self.atlas:GetSprite(bgSprite)
  self.timeGo:SetActive(false)
end
