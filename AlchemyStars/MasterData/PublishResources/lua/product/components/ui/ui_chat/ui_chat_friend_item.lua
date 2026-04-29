_class("UIChatFriendItem", UICustomWidget)
UIChatFriendItem = UIChatFriendItem

function UIChatFriendItem:OnShow(uiParam)
  self._headBg = self:GetUIComponent("UICircleMaskLoader", "headBg")
  self._head = self:GetUIComponent("RawImageLoader", "head")
  self._headRect = self:GetUIComponent("RectTransform", "head")
  self._headBgMaskRect = self:GetUIComponent("RectTransform", "headBgMask")
  self._headBgRect = self:GetUIComponent("RectTransform", "headBg")
  self._headRoot = self:GetUIComponent("RectTransform", "headRoot")
  self._frame = self:GetUIComponent("RawImageLoader", "frame")
  self._frameRect = self:GetUIComponent("RectTransform", "frame")
  self._hasMessageGo = self:GetGameObject("HasMessage")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._level = self:GetUIComponent("UILocalizationText", "Level")
  self._onlineStatusLabel = self:GetUIComponent("UILocalizationText", "OnLineStatus")
  self._onLineIconGo = self:GetGameObject("OnLineIcon")
  self._offLineIconGo = self:GetGameObject("OffLineIcon")
  self._petPanel = self:GetUIComponent("UISelectObjectPath", "PetPanel")
  self._petList = {}
  self._maxPetCount = 4
  self._petPanel:SpawnObjects("UIChatPetItem", self._maxPetCount, self._petList)
  self._danBadgeGen = self:GetUIComponent("UISelectObjectPath", "DanBadgeSimpleGen")
  self._danBadgeGenGo = self:GetGameObject("DanBadgeSimpleGen")
  self._danBadgeGenRect = self:GetUIComponent("RectTransform", "DanBadgeSimpleGen")
end

function UIChatFriendItem:Refresh(friendData, panelType, chatFriendManager, uiChatController)
  self._chatFriendManager = chatFriendManager
  self._friendData = friendData
  self._uiChatController = uiChatController
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
  self._hasMessageGo:SetActive(false)
  self._onlineStatusLabel.text = self._friendData:GetLastOnlineStatusStr()
  if self._friendData:IsOnline() then
    self._onLineIconGo:SetActive(true)
    self._offLineIconGo:SetActive(false)
  else
    self._onLineIconGo:SetActive(false)
    self._offLineIconGo:SetActive(true)
  end
  local petList = self._friendData:GetPetDataList()
  for i = 1, self._maxPetCount do
    if petList and petList[i] then
      self._petList[i]:Refresh(petList[i])
    else
      self._petList[i]:Refresh(nil)
    end
  end
end

function UIChatFriendItem:HeadBtnOnClick(go)
  self:ShowDialog("UIPlayerInfoController", PlayerInfoFrom.Chat, self._friendData:GetFriendId(), self._chatFriendManager)
end

function UIChatFriendItem:ChatBtnOnClick(go)
  self._chatFriendManager:CacheCurrentSelectRecentFriend(self._friendData:GetFriendId())
  self._uiChatController:RecentBtnOnClick()
end
