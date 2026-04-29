_class("UIActivityN8PersonProgressListItem", UICustomWidget)
UIActivityN8PersonProgressListItem = UIActivityN8PersonProgressListItem

function UIActivityN8PersonProgressListItem:_GetComponents()
  self._anim = self:GetUIComponent("Animation", "ani")
  self._root = self:GetGameObject("root")
  self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "dynamicList")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._desTex = self:GetUIComponent("UILocalizationText", "desTex")
  self._stateObj = {
    {
      self:GetGameObject("state_Accepted"),
      self:GetGameObject("state_Accepted_bg")
    },
    {
      self:GetGameObject("state_Completed"),
      self:GetGameObject("state_Completed_bg")
    },
    {
      self:GetGameObject("state_Taken"),
      self:GetGameObject("state_Taken_bg")
    }
  }
  self._stateCountTxt = {
    self:GetUIComponent("UILocalizationText", "text_count_Accepted"),
    self:GetUIComponent("UILocalizationText", "text_count_Completed"),
    self:GetUIComponent("UILocalizationText", "text_count_Taken")
  }
end

function UIActivityN8PersonProgressListItem:OnShow(uiParams)
end

function UIActivityN8PersonProgressListItem:SetData(campaign, progress, callback, tipsCallback)
  self:_GetComponents()
  self._campaign = campaign
  self._progress = progress
  self._callback = callback
  self._tipsCallback = tipsCallback
  self._component = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_PERSON_PROGESS, 1)
  self._state = self._component:CheckItemStatus(self._progress)
  self:_Refresh()
  local trans = self:GetUIComponent("RectTransform", "root")
  trans.anchoredPosition = Vector2(0, trans.anchoredPosition.y)
end

function UIActivityN8PersonProgressListItem:OnHide(stamp)
  self._root = nil
end

function UIActivityN8PersonProgressListItem:_Refresh()
  self:_SetIcon()
  self:_SetState(self._state)
  self:_SetStateCount(self._state)
  self:_SetDynamicList()
end

function UIActivityN8PersonProgressListItem:_SetIcon()
  local url = self._component:GetItemIcon()
  self._icon:LoadImage(url)
end

function UIActivityN8PersonProgressListItem:_SetState(state)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIActivityN8PersonProgressListItem:_SetStateCount(state)
  self._stateCountTxt[state]:SetText(self._progress)
end

function UIActivityN8PersonProgressListItem:_SetDynamicListData()
  self._dynamicListInfo = self._component:GetProgressRewards(self._progress)
  self._itemCountPerRow = 1
  self._dynamicListSize = math.floor((table.count(self._dynamicListInfo) - 1) / self._itemCountPerRow + 1)
end

function UIActivityN8PersonProgressListItem:_SetDynamicList()
  self:_SetDynamicListData()
  if not self._isDynamicInited then
    self._isDynamicInited = true
    self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "dynamicList")
    self._dynamicList:InitListView(self._dynamicListSize, function(scrollView, index)
      return self:_SpawnListItem(scrollView, index)
    end)
  else
    self:_RefreshList(self._dynamicListSize, self._dynamicList)
  end
end

function UIActivityN8PersonProgressListItem:_RefreshList(count, list)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  list.ScrollRect.content.localPosition = contentPos
end

function UIActivityN8PersonProgressListItem:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIActivityN8PersonProgressItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local listItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._dynamicListSize then
      listItem:GetGameObject():SetActive(false)
    else
      listItem:GetGameObject():SetActive(true)
      self:_SetListItemData(listItem, itemIndex)
    end
  end
  return item
end

function UIActivityN8PersonProgressListItem:_SetListItemData(listItem, index)
  local info = self._dynamicListInfo[index]
  local gray = self._state == CampaignPersonProgressStatus.CPPS_Taken and 1 or 0
  listItem:SetData(index, info, self._tipsCallback, gray)
end

function UIActivityN8PersonProgressListItem:state_AcceptedOnClick()
end

function UIActivityN8PersonProgressListItem:state_CompletedOnClick()
  if self._callback then
    self._callback(self._progress)
  end
end
