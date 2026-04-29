_class("UIChatBlackListItem", UICustomWidget)
UIChatBlackListItem = UIChatBlackListItem

function UIChatBlackListItem:OnShow(uiParam)
  self._headBg = self:GetUIComponent("UICircleMaskLoader", "headBg")
  self._head_bg_rect = self:GetUIComponent("RectTransform", "headBg")
  self._head_bg_mask_rect = self:GetUIComponent("RectTransform", "headBgMask")
  self._head = self:GetUIComponent("RawImageLoader", "head")
  self._headRect = self:GetUIComponent("RectTransform", "head")
  self._frame = self:GetUIComponent("RawImageLoader", "frame")
  self._frameRect = self:GetUIComponent("RectTransform", "frame")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._level = self:GetUIComponent("UILocalizationText", "Level")
  self._id = self:GetUIComponent("UILocalizationText", "Id")
  self._head_root_rect = self:GetUIComponent("RectTransform", "headRoot")
  self._danBadgeGen = self:GetUIComponent("UISelectObjectPath", "DanBadgeSimpleGen")
  self._danBadgeGenGo = self:GetGameObject("DanBadgeSimpleGen")
  self._danBadgeGenRect = self:GetUIComponent("RectTransform", "DanBadgeSimpleGen")
end

function UIChatBlackListItem:Refresh(friendData, chatFriendManager)
  self._chatFriendManager = chatFriendManager
  self._friendData = friendData
  self._headBg:LoadImage(self._friendData:GetHeadBgName())
  local iconName, iconTag = self._friendData:GetHeadIconName()
  self._head:LoadImage(iconName)
  if not string.isnullorempty(iconTag) then
    HelperProxy:GetInstance():GetHeadIconSizeWithTag(self._headRect, iconTag)
  end
  self._frame:LoadImage(self._friendData:GetHeadFrameName())
  UIWorldBossHelper.InitOtherDanBadgeSimple(self._danBadgeGen, self._danBadgeGenGo, self._danBadgeGenRect, self._friendData:GetWorldBossInfo())
  HelperProxy:GetInstance():GetHeadBgSizeWithTag(self._head_bg_rect)
  HelperProxy:GetInstance():GetHeadBgMaskSizeWithTag(self._head_bg_mask_rect)
  HelperProxy:GetInstance():GetHeadFrameSizeWithTag(self._frameRect)
  HelperProxy:GetInstance():GetHeadRootSizeWithTag(self._head_root_rect, RoleHeadFrameSizeType.Size3)
  self._name.text = self._friendData:GetName()
  self._level.text = StringTable.Get("str_chat_level", tostring(self._friendData:GetLevel()))
  self._id.text = self._friendData:GetShowFriendId()
end

function UIChatBlackListItem:HeadBtnOnClick(go)
  self:ShowDialog("UIPlayerInfoController", PlayerInfoFrom.Chat, self._friendData:GetFriendId(), self._chatFriendManager)
end

function UIChatBlackListItem:RemoveBtnOnClick(go)
  self:ShowDialog("UIChatRemoveBlacklistController", self._friendData, self._chatFriendManager)
end
