_class("UIChatRecentFriendItem", UICustomWidget)
UIChatRecentFriendItem = UIChatRecentFriendItem

function UIChatRecentFriendItem:OnShow(uiParam)
  self._headBg = self:GetUIComponent("UICircleMaskLoader", "headBg")
  self._head = self:GetUIComponent("RawImageLoader", "head")
  self._headRect = self:GetUIComponent("RectTransform", "head")
  self._headBgRect = self:GetUIComponent("RectTransform", "headBg")
  self._headBgMaskRect = self:GetUIComponent("RectTransform", "headBgMask")
  self._headRoot = self:GetUIComponent("RectTransform", "headRoot")
  self._frame = self:GetUIComponent("RawImageLoader", "frame")
  self._frameRect = self:GetUIComponent("RectTransform", "frame")
  self._hasMessageGo = self:GetGameObject("HasMessage")
  self._selectedFrameGo = self:GetGameObject("SelectedFrame")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._level = self:GetUIComponent("UILocalizationText", "Level")
  self._onlineStatusLabel = self:GetUIComponent("UILocalizationText", "OnlineStatus")
  self._onLineIconGo = self:GetGameObject("OnLineIcon")
  self._offLineIconGo = self:GetGameObject("OffLineIcon")
  self._danBadgeGen = self:GetUIComponent("UISelectObjectPath", "DanBadgeSimpleGen")
  self._danBadgeGenGo = self:GetGameObject("DanBadgeSimpleGen")
  self._danBadgeGenRect = self:GetUIComponent("RectTransform", "DanBadgeSimpleGen")
  self:AttachEvent(GameEventType.SelectRecentFriend, self._RefreshSelectedStatus)
end

function UIChatRecentFriendItem:OnHide()
  self:DetachEvent(GameEventType.SelectRecentFriend, self._RefreshSelectedStatus)
end

function UIChatRecentFriendItem:Refresh(friendData, panelType, chatFriendManager)
  self._chatFriendManager = chatFriendManager
  self._panelType = panelType
  self._friendData = friendData
  self._headBg:LoadImage(self._friendData:GetHeadBgName())
  local iconName, iconTag = self._friendData:GetHeadIconName()
  self._head:LoadImage(iconName)
  if not string.isnullorempty(iconTag) then
    HelperProxy:GetInstance():GetHeadIconSizeWithTag(self._headRect, iconTag)
  end
  self._frame:LoadImage(self._friendData:GetHeadFrameName())
  UIWorldBossHelper.InitOtherDanBadgeSimple(self._danBadgeGen, self._danBadgeGenGo, self._danBadgeGenRect, self._friendData:GetWorldBossInfo())
  HelperProxy:GetInstance():GetHeadBgSizeWithTag(self._headBgRect)
  HelperProxy:GetInstance():GetHeadBgMaskSizeWithTag(self._headBgMaskRect)
  HelperProxy:GetInstance():GetHeadFrameSizeWithTag(self._frameRect)
  HelperProxy:GetInstance():GetHeadRootSizeWithTag(self._headRoot, RoleHeadFrameSizeType.Size3)
  self._name.text = self._friendData:GetName()
  self._level.text = StringTable.Get("str_chat_level", tostring(self._friendData:GetLevel()))
  self._onlineStatusLabel.text = self._friendData:GetLastOnlineStatusStr()
  if self._friendData:IsOnline() then
    self._onLineIconGo:SetActive(true)
    self._offLineIconGo:SetActive(false)
  else
    self._onLineIconGo:SetActive(false)
    self._offLineIconGo:SetActive(true)
  end
  self._hasMessageGo:SetActive(self._friendData:HasNewMessage())
  self:_RefreshSelectedStatus()
end

function UIChatRecentFriendItem:_RefreshSelectedStatus()
  self._selectedFrameGo:SetActive(self._friendData:IsSelected())
end

function UIChatRecentFriendItem:HeadBtnOnClick(go)
  self:ShowDialog("UIPlayerInfoController", PlayerInfoFrom.Chat, self._friendData:GetFriendId(), self._chatFriendManager)
end

function UIChatRecentFriendItem:ItemBtnOnClick(go)
  local curFriendId = self._chatFriendManager:GetSelectRecentFriend()
  if curFriendId == self._friendData:GetFriendId() then
    return
  end
  self._chatFriendManager:SelectRecentFriend(self._friendData:GetFriendId())
  local preFriendId
  if curFriendId then
    preFriendId = curFriendId
  end
  local newFriendId = self._friendData:GetFriendId()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SelectRecentFriend, newFriendId, preFriendId)
end
