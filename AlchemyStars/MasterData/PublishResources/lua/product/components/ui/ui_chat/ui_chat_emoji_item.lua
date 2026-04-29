_class("UIChatEmojiItem", UICustomWidget)
UIChatEmojiItem = UIChatEmojiItem

function UIChatEmojiItem:OnShow(uiParam)
  self._emojiIconImg = self:GetUIComponent("RawImageLoader", "EmojiIcon")
  self._emojiIconGo = self:GetGameObject("EmojiIcon")
  self._emojiPressGo = self:GetGameObject("EmojiIconPress")
  self._emojiPressGo:SetActive(false)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._emojiIconGo), UIEvent.Press, function(go)
    self._emojiPressGo:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._emojiIconGo), UIEvent.Release, function(go)
    self._emojiPressGo:SetActive(false)
  end)
end

function UIChatEmojiItem:Refresh(emojiData, uiChatRecentFriendListPanel)
  self._emojiId = emojiData.id
  self._emojiTexture = emojiData.textureName
  self._emojiIconImg:LoadImage(self._emojiTexture)
  self._uiChatRecentFriendListPanel = uiChatRecentFriendListPanel
end

function UIChatEmojiItem:EmojiIconOnClick(go)
  self._uiChatRecentFriendListPanel:SendImageMessage(self._emojiId)
end
