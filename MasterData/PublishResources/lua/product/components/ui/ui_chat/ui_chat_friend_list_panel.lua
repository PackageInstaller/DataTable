_class("UIChatFriendListPanel", UICustomWidget)
UIChatFriendListPanel = UIChatFriendListPanel

function UIChatFriendListPanel:OnShow(uiParams)
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "FriendList")
  self._friendPanel = self:GetGameObject("LeftStretchAnchor")
  self._noFriendPanel = self:GetGameObject("CenterAnchor")
  self._tipsLabel = self:GetUIComponent("UILocalizationText", "TipsCH")
  self._friendCountLabel = self:GetUIComponent("UILocalizationText", "FriendCount")
  self._blackListBtnGo = self:GetGameObject("BlackListBtn")
  self._blackListBtnGo:SetActive(false)
  self._blackListBtnGo:SetActive(true)
  self._isInited = false
  self:AttachEvent(GameEventType.DeleteFriendUI, self._Refresh)
  self:AttachEvent(GameEventType.UpdateFriendInfo, self._Refresh)
  self:_HidePanel()
end

function UIChatFriendListPanel:OnHide()
  self:DetachEvent(GameEventType.DeleteFriendUI, self._Refresh)
  self:DetachEvent(GameEventType.UpdateFriendInfo, self._Refresh)
end

function UIChatFriendListPanel:Init(uiChatController)
  if self._isInited == false then
    self._uiChatController = uiChatController
    self._chatFriendManager = self._uiChatController:GetChatFriendManager()
    self._panelType = self._uiChatController:GetCurrentPanelType()
  end
  self:_HidePanel()
  self:_RefreshDatas(function()
    self:_RefreshPanelStatus()
    if self._isInited == false then
      self:_InitScrollView()
    else
      self._scrollView:SetListItemCount(self._friendCount, false)
      self._scrollView:RefreshAllShownItem()
    end
    self._isInited = true
  end)
end

function UIChatFriendListPanel:Exist()
  if not self:_IsPanelActive() then
    return
  end
end

function UIChatFriendListPanel:_HidePanel()
  self._friendPanel:SetActive(false)
  self._noFriendPanel:SetActive(false)
end

function UIChatFriendListPanel:_Refresh()
  if not self:_IsPanelActive() then
    return
  end
  self:_RefreshDatas(function()
    self._scrollView:SetListItemCount(self._friendCount, false)
    self:_RefreshPanelStatus()
    self._scrollView:RefreshAllShownItem()
  end)
end

function UIChatFriendListPanel:_RefreshPanelStatus()
  if self._friendCount <= 0 then
    self._friendPanel:SetActive(false)
    self._noFriendPanel:SetActive(true)
    self._tipsLabel.text = StringTable.Get("str_chat_no_friend_tips_ch")
  else
    self._friendPanel:SetActive(true)
    self._noFriendPanel:SetActive(false)
  end
  local str = self._friendCount .. "/" .. self._chatFriendManager:GetMaxFriendCount()
  self._friendCountLabel.text = str
end

function UIChatFriendListPanel:_RefreshDatas(callback)
  GameGlobal.TaskManager():StartTask(self._RequestDatas, self, callback)
end

function UIChatFriendListPanel:_RequestDatas(TT, callback)
  self:Lock("_RequestDatas")
  self._chatFriendManager:RequestFriendList(TT)
  self._friendList = self._chatFriendManager:GetFriendList(true)
  self._friendCount = table.count(self._friendList)
  if callback then
    callback()
  end
  self:UnLock("_RequestDatas")
end

function UIChatFriendListPanel:_IsPanelActive()
  if not self._isInited then
    return false
  end
  if not self._uiChatController then
    return false
  end
  if self._panelType ~= self._uiChatController:GetCurrentPanelType() then
    return false
  end
  return true
end

function UIChatFriendListPanel:_InitScrollView()
  self._scrollView:InitListView(self._friendCount, function(scrollview, index)
    return self:_OnGetFriendItem(scrollview, index)
  end)
end

function UIChatFriendListPanel:_OnGetFriendItem(scrollView, index)
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIChatFriendItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._friendCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      self:_RefreshFriendItemInfo(itemWidget, itemIndex)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIChatFriendListPanel:_RefreshFriendItemInfo(itemWidget, index)
  itemWidget:Refresh(self._friendList[index], self._panelType, self._chatFriendManager, self._uiChatController)
end

function UIChatFriendListPanel:BlackListBtnOnClick(go)
  self:ShowDialog("UIChatBlackListController", self._chatFriendManager)
end
