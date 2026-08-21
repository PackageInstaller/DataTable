_class("UIHomeVisitFriendItem", UICustomWidget)
UIHomeVisitFriendItem = UIHomeVisitFriendItem

function UIHomeVisitFriendItem:OnShow(uiParams)
  self:InitWidget()
  local atlas = self:GetAsset("UIHomelandVisit.spriteatlas", LoadType.SpriteAtlas)
end

function UIHomeVisitFriendItem:InitWidget()
  self.nickName = self:GetUIComponent("UILocalizationText", "nickName")
  self.level = self:GetUIComponent("UILocalizationText", "level")
  self.time = self:GetUIComponent("UILocalizationText", "time")
  self.gift = self:GetGameObject("gift")
  self.speedup = self:GetGameObject("speedup")
  self.water = self:GetGameObject("water")
  self.line = self:GetUIComponent("Image", "line")
  self._ambient = self:GetUIComponent("UILocalizationText", "ambient")
  self._head = self:GetUIComponent("RawImageLoader", "head")
  self._headRoot = self:GetUIComponent("Transform", "headIcon")
  self._headBg = self:GetUIComponent("UICircleMaskLoader", "headbg")
  self._headBox = self:GetUIComponent("RawImageLoader", "headBox")
  self._headRect = self:GetUIComponent("RectTransform", "headIcon")
  self._headBgRect = self:GetUIComponent("RectTransform", "headbg")
  self._headBgMaskRect = self:GetUIComponent("RectTransform", "mask")
  self.headBoxRect = self:GetUIComponent("RectTransform", "headBox")
  self.empty = self:GetGameObject("empty")
end

function UIHomeVisitFriendItem:SetData(data)
  self.nickName:SetText(data:Name())
  self.level:SetText("Lv." .. data:Level())
  self.time:SetText(data:OnlineInfo())
  self._ambient:SetText(data:LivableValue())
  local head, headbg, headbox = data:HeadIcon()
  local headCfg = Cfg.cfg_role_head_image[head]
  self._head:LoadImage(headCfg.Icon)
  local head_bg_cfg = Cfg.cfg_player_head_bg[headbg]
  head_bg_cfg = head_bg_cfg or Cfg.cfg_player_head_bg[HelperProxy:GetInstance():GetHeadBgDefaultID()]
  self._headBg:LoadImage(head_bg_cfg.Icon)
  local head_frame_cfg = Cfg.cfg_role_head_frame[headbox]
  head_frame_cfg = head_frame_cfg or Cfg.cfg_role_head_frame[HelperProxy:GetInstance():GetHeadFrameDefaultID()]
  self._headBox:LoadImage(head_frame_cfg.Icon)
  if not string.isnullorempty(headCfg.Tag) then
    HelperProxy:GetInstance():GetHeadIconSizeWithTag(self._headRect, headCfg.Tag)
  end
  HelperProxy:GetInstance():GetHeadBgSizeWithTag(self._headBgRect)
  HelperProxy:GetInstance():GetHeadBgMaskSizeWithTag(self._headBgMaskRect)
  HelperProxy:GetInstance():GetHeadFrameSizeWithTag(self.headBoxRect)
  HelperProxy:GetInstance():GetHeadRootSizeWithTag(self._headRoot, RoleHeadFrameSizeType.Size7)
  self.gift:SetActive(data:CanGetGift())
  self.speedup:SetActive(data:CanSpeedup())
  self.water:SetActive(data:CanWater())
  self.empty:SetActive(not data:CanGetGift() and not data:CanSpeedup() and not data:CanWater())
  self._pstID = data:PstID()
end

function UIHomeVisitFriendItem:VisitOnClick(go)
  local uiModule = GameGlobal.GetUIModule(HomelandModule)
  local isVisit = uiModule:GetClient():IsVisit()
  if isVisit then
    if uiModule:GetVisitInfo().pstid == self._pstID then
      ToastManager.ShowHomeToast(StringTable.Get("str_homeland_visit_already_in"))
    else
      HomeLoading.VisitToVisit(self._pstID)
    end
  else
    HomeLoading.SelfToVisit(self._pstID)
  end
end
