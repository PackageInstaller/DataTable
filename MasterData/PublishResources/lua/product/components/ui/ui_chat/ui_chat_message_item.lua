_class("UIChatMessageItem", UICustomWidget)
UIChatMessageItem = UIChatMessageItem

function UIChatMessageItem:OnShow(uiParam)
  self._friendPanel = self:GetGameObject("FriendPanel")
  self._friendPanelRectTran = self:GetUIComponent("RectTransform", "FriendPanel")
  self._selfPanel = self:GetGameObject("SelfPanel")
  self._selfPanelRectTran = self:GetUIComponent("RectTransform", "SelfPanel")
  self._friendHeadBg = self:GetUIComponent("UICircleMaskLoader", "FriendHeadBg")
  self._friendHead = self:GetUIComponent("RawImageLoader", "FriendHead")
  self._friendHeadRect = self:GetUIComponent("RectTransform", "FriendHead")
  self._friendHeadBgRect = self:GetUIComponent("RectTransform", "FriendHeadBg")
  self._friendHeadBgMaskRect = self:GetUIComponent("RectTransform", "FriendHeadBgMask")
  self._friendHeadRoot = self:GetUIComponent("RectTransform", "FriendHeadRoot")
  self._friendHeadFrame = self:GetUIComponent("RawImageLoader", "FriendHeadFrame")
  self._friendHeadFrameRect = self:GetUIComponent("RectTransform", "FriendHeadFrame")
  self._friendName = self:GetUIComponent("UILocalizationText", "FriendName")
  self._friendMessage = self:GetUIComponent("UILocalizationText", "FriendMessage")
  self._friendTime = self:GetUIComponent("UILocalizationText", "FriendTime")
  self._selfHeadBg = self:GetUIComponent("UICircleMaskLoader", "SelfHeadBg")
  self._selfHead = self:GetUIComponent("RawImageLoader", "SelfHead")
  self._selfHeadRect = self:GetUIComponent("RectTransform", "SelfHead")
  self._selfHeadFrame = self:GetUIComponent("RawImageLoader", "SelfHeadFrame")
  self._selfHeadFrameRect = self:GetUIComponent("RectTransform", "SelfHeadFrame")
  self._selfHeadBgRect = self:GetUIComponent("RectTransform", "SelfHeadBg")
  self._selfHeadBgMaskRect = self:GetUIComponent("RectTransform", "SelfHeadBgMask")
  self._selfHeadRoot = self:GetUIComponent("RectTransform", "SelfHeadRoot")
  self._selfMessage = self:GetUIComponent("UILocalizationText", "SelfMessage")
  self._selfTime = self:GetUIComponent("UILocalizationText", "SelfTime")
  self._friendTimeGo = self:GetGameObject("FriendTimePanel")
  self._selfTimeGo = self:GetGameObject("SelfTimePanel")
  self._friendMessageBgGo = self:GetGameObject("FriendMessageBg")
  self._friendEmojiMessageBgGo = self:GetGameObject("FriendEmojiMessageBg")
  self._friendEmojiMessageImg = self:GetUIComponent("RawImageLoader", "FriendEmojiMessage")
  self._selfMessageBgGo = self:GetGameObject("SelfMessageBg")
  self._selfEmojiMessageBgGo = self:GetGameObject("SelfEmojiMessageBg")
  self._selfEmojiMessageImg = self:GetUIComponent("RawImageLoader", "SelfEmojiMessage")
  self._friendParentVerticalLayout = self:GetUIComponent("RectTransform", "FriendParent")
  self._selfParentVerticalLayout = self:GetUIComponent("RectTransform", "SelfParent")
  self._friendMsgBgWidth = 789.74
  self._friendMsgWidth = 768.21
  self._selfMsgBgWidth = 787.23
  self._selfMsgWidth = 768.21
  local friendMessageParent = self._friendMessage.transform.parent
  self._friendMsgContentSizeFilter = friendMessageParent:GetComponent("ContentSizeFitter")
  self._friendMsgVerticalLayoutGroup = friendMessageParent:GetComponent("VerticalLayoutGroup")
  self._friendMsgParentRectTran = friendMessageParent:GetComponent("RectTransform")
  self._friendMsgRectTran = self._friendMessage.transform:GetComponent("RectTransform")
  local selfMessageParent = self._selfMessage.transform.parent
  self._selfMsgContentSizeFilter = selfMessageParent:GetComponent("ContentSizeFitter")
  self._selfMsgVerticalLayoutGroup = selfMessageParent:GetComponent("VerticalLayoutGroup")
  self._selfMsgParentRectTran = selfMessageParent:GetComponent("RectTransform")
  self._selfMsgRectTran = self._selfMessage.transform:GetComponent("RectTransform")
  self._selfDanBadgeGen = self:GetUIComponent("UISelectObjectPath", "SelfDanBadgeSimpleGen")
  self._selfDanBadgeGenGo = self:GetGameObject("SelfDanBadgeSimpleGen")
  self._selfDanBadgeGenRect = self:GetUIComponent("RectTransform", "SelfDanBadgeSimpleGen")
  self._otherDanBadgeGen = self:GetUIComponent("UISelectObjectPath", "FriendDanBadgeSimpleGen")
  self._otherDanBadgeGenGo = self:GetGameObject("FriendDanBadgeSimpleGen")
  self._otherDanBadgeGenRect = self:GetUIComponent("RectTransform", "FriendDanBadgeSimpleGen")
end

function UIChatMessageItem:Refresh(chatData, friendData, chatFriendManager, parentRectTransform)
  if not chatData then
    return
  end
  self._chatData = chatData
  self._friendData = friendData
  self._chatFriendManager = chatFriendManager
  if self._chatData:IsSelf() then
    self._friendPanel:SetActive(false)
    self._selfPanel:SetActive(true)
    self._selfTime.text = self._chatData:GetDateStr()
    local messageType = self._chatData:GetMessageType()
    local isEmojiMsg = messageType == FRIEND_CHAT_MSG_TYPE.FRIEND_CHAT_MSG_TYPE_EMOJI
    self._selfMessageBgGo:SetActive(not isEmojiMsg)
    self._selfEmojiMessageBgGo:SetActive(isEmojiMsg)
    if isEmojiMsg then
      local emojiId = self._chatData:GetEmojiId()
      if emojiId and 0 < emojiId then
        local emojiCfg = Cfg.cfg_chat_emoji[emojiId]
        if emojiCfg then
          self._selfEmojiMessageImg:LoadImage(emojiCfg.TextureName)
        end
      end
    else
      self._selfMessage.text = self._chatData:GetMessage()
    end
    local roleModule = self:GetModule(RoleModule)
    local playerInfo = roleModule:UI_GetPlayerInfo()
    local headIcon = playerInfo.m_nHeadImageID
    local cfg_header = Cfg.cfg_role_head_image[headIcon]
    if cfg_header then
      HelperProxy:GetInstance():GetHeadIconSizeWithTag(self._selfHeadRect, cfg_header.Tag)
      self._selfHead:LoadImage(cfg_header.Icon)
    else
      Log.fatal("###main - cfg_header is nil ! id - ", headIcon)
    end
    local headBg = playerInfo.m_nHeadColorID
    local cfg_head_bg = Cfg.cfg_player_head_bg[headBg]
    if not cfg_head_bg then
      local bid = HelperProxy:GetInstance():GetHeadBgDefaultID()
      cfg_head_bg = Cfg.cfg_player_head_bg[bid]
    end
    self._selfHeadBg:LoadImage(cfg_head_bg.Icon)
    local headFrame = playerInfo.m_nHeadFrameID
    local cfg_head_frame = Cfg.cfg_role_head_frame[headFrame]
    if not cfg_head_frame then
      local fid = HelperProxy:GetInstance():GetHeadFrameDefaultID()
      cfg_head_frame = Cfg.cfg_role_head_frame[fid]
    end
    self._selfHeadFrame:LoadImage(cfg_head_frame.Icon)
    UIWorldBossHelper.InitSelfDanBadgeSimple(self._selfDanBadgeGen, self._selfDanBadgeGenGo, self._selfDanBadgeGenRect)
    HelperProxy:GetInstance():GetHeadBgSizeWithTag(self._selfHeadBgRect)
    HelperProxy:GetInstance():GetHeadBgMaskSizeWithTag(self._selfHeadBgMaskRect)
    HelperProxy:GetInstance():GetHeadFrameSizeWithTag(self._selfHeadFrameRect)
    HelperProxy:GetInstance():GetHeadRootSizeWithTag(self._selfHeadRoot, RoleHeadFrameSizeType.Size3)
  else
    self._friendPanel:SetActive(true)
    self._selfPanel:SetActive(false)
    self._friendTime.text = self._chatData:GetDateStr()
    self._friendName.text = self._friendData:GetName()
    self._friendHeadBg:LoadImage(self._friendData:GetHeadBgName())
    local messageType = self._chatData:GetMessageType()
    local isEmojiMsg = messageType == FRIEND_CHAT_MSG_TYPE.FRIEND_CHAT_MSG_TYPE_EMOJI
    self._friendMessageBgGo:SetActive(not isEmojiMsg)
    self._friendEmojiMessageBgGo:SetActive(isEmojiMsg)
    if isEmojiMsg then
      local emojiId = self._chatData:GetEmojiId()
      if emojiId and 0 < emojiId then
        local emojiCfg = Cfg.cfg_chat_emoji[emojiId]
        if emojiCfg then
          self._friendEmojiMessageImg:LoadImage(emojiCfg.TextureName)
        end
      end
    else
      self._friendMessage.text = self._chatData:GetMessage()
    end
    local iconName, iconTag = self._friendData:GetHeadIconName()
    self._friendHead:LoadImage(iconName)
    if not string.isnullorempty(iconTag) then
      HelperProxy:GetInstance():GetHeadIconSizeWithTag(self._friendHeadRect, iconTag)
    end
    self._friendHeadFrame:LoadImage(self._friendData:GetHeadFrameName())
    UIWorldBossHelper.InitOtherDanBadgeSimple(self._otherDanBadgeGen, self._otherDanBadgeGenGo, self._otherDanBadgeGenRect, self._friendData:GetWorldBossInfo())
    HelperProxy:GetInstance():GetHeadBgSizeWithTag(self._friendHeadBgRect)
    HelperProxy:GetInstance():GetHeadBgMaskSizeWithTag(self._friendHeadBgMaskRect)
    HelperProxy:GetInstance():GetHeadFrameSizeWithTag(self._friendHeadFrameRect)
    HelperProxy:GetInstance():GetHeadRootSizeWithTag(self._friendHeadRoot, RoleHeadFrameSizeType.Size3)
  end
  if self._chatData:IsShowTime() then
    self._friendTimeGo:SetActive(true)
    self._selfTimeGo:SetActive(true)
  else
    self._friendTimeGo:SetActive(false)
    self._selfTimeGo:SetActive(false)
  end
  self:_ResetContentSize()
  if self._chatData:IsSelf() then
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._selfMsgParentRectTran)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._selfParentVerticalLayout)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._selfPanelRectTran)
    local sizeDelta = parentRectTransform.sizeDelta
    parentRectTransform.sizeDelta = Vector2(sizeDelta.x, self._selfPanelRectTran.rect.height + 45)
  else
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._friendMsgParentRectTran)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._friendParentVerticalLayout)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._friendPanelRectTran)
    local sizeDelta = parentRectTransform.sizeDelta
    parentRectTransform.sizeDelta = Vector2(sizeDelta.x, self._friendPanelRectTran.rect.height + 45)
  end
end

function UIChatMessageItem:_ResetContentSize()
  if self._chatData:IsSelf() then
    self._selfMsgContentSizeFilter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
    self._selfMsgVerticalLayoutGroup.childControlWidth = true
    if self._selfMessage.preferredWidth > self._selfMsgWidth then
      self._selfMsgContentSizeFilter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.Unconstrained
      self._selfMsgVerticalLayoutGroup.childControlWidth = false
      self._selfMsgParentRectTran.sizeDelta = Vector2(self._selfMsgBgWidth, self._selfMsgParentRectTran.sizeDelta.y)
      self._selfMsgRectTran.sizeDelta = Vector2(self._selfMsgWidth, self._selfMsgRectTran.sizeDelta.y)
    else
      self._selfMsgContentSizeFilter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
      self._selfMsgVerticalLayoutGroup.childControlWidth = true
    end
  else
    self._friendMsgContentSizeFilter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
    self._friendMsgVerticalLayoutGroup.childControlWidth = true
    if self._friendMessage.preferredWidth > self._friendMsgWidth then
      self._friendMsgContentSizeFilter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.Unconstrained
      self._friendMsgVerticalLayoutGroup.childControlWidth = false
      self._friendMsgParentRectTran.sizeDelta = Vector2(self._friendMsgBgWidth, self._friendMsgParentRectTran.sizeDelta.y)
      self._friendMsgRectTran.sizeDelta = Vector2(self._friendMsgWidth, self._friendMsgRectTran.sizeDelta.y)
    else
      self._friendMsgContentSizeFilter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
      self._friendMsgVerticalLayoutGroup.childControlWidth = true
    end
  end
end

function UIChatMessageItem:FriendHeadBtnOnClick(go)
  self:ShowDialog("UIPlayerInfoController", PlayerInfoFrom.Chat, self._friendData:GetFriendId(), self._chatFriendManager)
end

function UIChatMessageItem:SelfHeadBtnOnClick(go)
  local roleModule = GameGlobal.GetModule(RoleModule)
  self:ShowDialog("UIPlayerInfoController", PlayerInfoFrom.Chat, roleModule:GetPstId(), self._chatFriendManager)
end
