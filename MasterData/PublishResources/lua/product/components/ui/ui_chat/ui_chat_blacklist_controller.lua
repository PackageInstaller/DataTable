_class("UIChatBlackListController", UIController)
UIChatBlackListController = UIChatBlackListController

function UIChatBlackListController:LoadDataOnEnter(TT, res, uiParams)
  self._chatFriendManager = uiParams[1]
  self:_RequestData(TT)
end

function UIChatBlackListController:_RequestData(TT)
  self._maxBlackListCount = self._chatFriendManager:GetMaxBlackListCount()
  self._blackListData = self._chatFriendManager:GetBlackListData(TT)
  self._blackListCount = table.count(self._blackListData)
end

function UIChatBlackListController:OnShow(uiParams)
  self._blackList = self:GetUIComponent("UIDynamicScrollView", "BlackList")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self:AttachEvent(GameEventType.UpdateChatBlackList, self._Refresh)
  self:_Init()
end

function UIChatBlackListController:OnHide()
  self:DetachEvent(GameEventType.UpdateChatBlackList, self._Refresh)
end

function UIChatBlackListController:_Init()
  self._countLabel.text = self._blackListCount .. "/" .. self._maxBlackListCount
  self:_InitScrollView()
end

function UIChatBlackListController:_InitScrollView()
  self._blackList:InitListView(self._blackListCount, function(scrollview, index)
    return self:_OnGetBlackListItem(scrollview, index)
  end)
end

function UIChatBlackListController:_Refresh()
  self:Lock("_Refresh")
  GameGlobal.TaskManager():StartTask(self._RefreshCoro, self)
end

function UIChatBlackListController:_RefreshCoro(TT)
  self:_RequestData(TT)
  self._countLabel.text = self._blackListCount .. "/" .. self._maxBlackListCount
  self._blackList:SetListItemCount(self._blackListCount, false)
  self._blackList:RefreshAllShownItem()
  self:UnLock("_Refresh")
end

function UIChatBlackListController:_OnGetBlackListItem(scrollView, index)
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIChatBlackListItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._blackListCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      self:_RefreshBlackListItemInfo(itemWidget, itemIndex)
      itemWidget:GetGameObject():SetActive(true)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIChatBlackListController:_RefreshBlackListItemInfo(itemWidget, index)
  itemWidget:Refresh(self._blackListData[index], self._chatFriendManager)
end

function UIChatBlackListController:MaskOnClick(go)
  self:CloseDialog()
end
