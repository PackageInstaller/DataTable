_class("UICollectCardFriendItem", UICustomWidget)
UICollectCardFriendItem = UICollectCardFriendItem

function UICollectCardFriendItem:OnShow(uiParam)
  self._nameTex = self:GetUIComponent("UILocalizationText", "NameTex")
  self._nameTex2 = self:GetUIComponent("UILocalizationText", "NameTex2")
  self._lvTex = self:GetUIComponent("UILocalizationText", "Lv")
  self._selectGo = self:GetGameObject("SelectGo")
  self._noSelect = self:GetGameObject("NoSelect")
  self._btnGo = self:GetGameObject("Btn")
  self._headBgRect = self:GetUIComponent("RectTransform", "headbg")
  self._headRoot = self:GetUIComponent("RectTransform", "headRoot")
  self._headBgMaskRect = self:GetUIComponent("RectTransform", "mask")
  self._headRect = self:GetUIComponent("RectTransform", "head")
  self._head = self:GetUIComponent("RawImageLoader", "head")
  self._frame = self:GetUIComponent("RawImageLoader", "headFrame")
  self._headBg = self:GetUIComponent("UICircleMaskLoader", "headbg")
  self._frameRect = self:GetUIComponent("RectTransform", "headFrame")
  self._selectGo:SetActive(false)
  self._noSelect:SetActive(true)
  self._nameTex.gameObject:SetActive(false)
  self._nameTex2.gameObject:SetActive(true)
  self:AttachEvent(GameEventType.OnCollectCardSelectFriend, self.Select)
end

function UICollectCardFriendItem:SetData(idx, info, callback, currentSelectIdx)
  self._idx = idx
  self._info = info
  self._callback = callback
  self:SetLv()
  self:SetFriendName()
  self:SetHead()
  self:Select(currentSelectIdx)
end

function UICollectCardFriendItem:SetLv()
  self._lvTex:SetText(StringTable.Get("str_collect_card_friend_tips3", self._info.level))
end

function UICollectCardFriendItem:SetFriendName()
  local showName
  if string.isnullorempty(self._info.remark_name) then
    showName = self._info.nick
  else
    showName = self._info.remark_name
  end
  self._nameTex:SetText(showName)
  self._nameTex2:SetText(showName)
end

function UICollectCardFriendItem:GetHeadBgName()
  local cfg_head_bg = Cfg.cfg_player_head_bg[self._info.head_bg]
  if not cfg_head_bg then
    local bid = HelperProxy:GetInstance():GetHeadBgDefaultID()
    cfg_head_bg = Cfg.cfg_player_head_bg[bid]
  end
  return cfg_head_bg.Icon
end

function UICollectCardFriendItem:GetHeadIconName()
  local cfg_head = Cfg.cfg_role_head_image[self._info.head]
  if not cfg_head then
    local id = HelperProxy:GetInstance():GetHeadIconDefaultID()
    cfg_head = Cfg.cfg_role_head_image[id]
  end
  if not cfg_head then
    return "", ""
  end
  return cfg_head.Icon, cfg_head.Tag
end

function UICollectCardFriendItem:GetHeadFrameName()
  local cfg_head_frame = Cfg.cfg_role_head_frame[self._info.frame_id]
  if not cfg_head_frame then
    local id = HelperProxy:GetInstance():GetHeadFrameDefaultID()
    cfg_head_frame = Cfg.cfg_role_head_frame[id]
  end
  return cfg_head_frame.Icon
end

function UICollectCardFriendItem:GetHeadBgName()
  local cfg_head_bg = Cfg.cfg_player_head_bg[self._info.head_bg]
  if not cfg_head_bg then
    local bid = HelperProxy:GetInstance():GetHeadBgDefaultID()
    cfg_head_bg = Cfg.cfg_player_head_bg[bid]
  end
  return cfg_head_bg.Icon
end

function UICollectCardFriendItem:SetHead()
  local iconName, iconTag = self:GetHeadIconName()
  self._headBg:LoadImage(self:GetHeadBgName())
  self._head:LoadImage(iconName)
  if not string.isnullorempty(iconTag) then
    HelperProxy:GetInstance():GetHeadIconSizeWithTag(self._headRect, iconTag)
  end
  self._frame:LoadImage(self:GetHeadFrameName())
  HelperProxy:GetInstance():GetHeadBgSizeWithTag(self._headBgRect)
  HelperProxy:GetInstance():GetHeadBgMaskSizeWithTag(self._headBgMaskRect)
  HelperProxy:GetInstance():GetHeadFrameSizeWithTag(self._frameRect)
  HelperProxy:GetInstance():GetHeadRootSizeWithTag(self._headRoot, RoleHeadFrameSizeType.Size4)
end

function UICollectCardFriendItem:Select(idx)
  self._selectGo:SetActive(idx == self._idx)
  self._noSelect:SetActive(idx ~= self._idx)
  self._nameTex.gameObject:SetActive(idx == self._idx)
  self._nameTex2.gameObject:SetActive(idx ~= self._idx)
end

function UICollectCardFriendItem:BtnOnClick(go)
  if self._callback then
    self._callback(self._idx)
  end
end
