_class("UIHauteCoutureDuplicateItem", UICustomWidget)
UIHauteCoutureDuplicateItem = UIHauteCoutureDuplicateItem

function UIHauteCoutureDuplicateItem:OnShow(uiParams)
  self:InitWidget()
end

function UIHauteCoutureDuplicateItem:InitWidget()
  self.s1 = self:GetUIComponent("RawImageLoader", "s1")
  self.s2 = self:GetUIComponent("RawImageLoader", "s2")
  self.t1 = self:GetUIComponent("RawImageLoader", "t1")
  self.t2 = self:GetUIComponent("RawImageLoader", "t2")
  self.title = self:GetUIComponent("UILocalizationText", "title")
  self.source2 = self:GetGameObject("Source2")
  self.target2 = self:GetGameObject("Target2")
  self.s1Count = self:GetUIComponent("UILocalizationText", "s1Count")
  self.s2Count = self:GetUIComponent("UILocalizationText", "s2Count")
  self.t1Count = self:GetUIComponent("UILocalizationText", "t1Count")
  self.t2Count = self:GetUIComponent("UILocalizationText", "t2Count")
  self.bg = self:GetUIComponent("RawImageLoader", "bg")
end

function UIHauteCoutureDuplicateItem:SetData(cfg, onClick)
  self:SetBg(cfg)
  local twoAwards = cfg.AppendGlow > 0
  self.source2:SetActive(twoAwards)
  self.target2:SetActive(twoAwards)
  if twoAwards then
    self.s1:LoadImage(Cfg.cfg_item[RoleAssetID.RoleAssetGlow].Icon)
    self.s1Count:SetText(cfg.AppendGlow)
    self.t1:LoadImage(Cfg.cfg_item[RoleAssetID.RoleAssetGlow].Icon)
    self.t1Count:SetText(cfg.AppendGlow)
    self.s2:LoadImage(Cfg.cfg_item[cfg.RewardID].Icon)
    self.s2Count:SetText(cfg.RewardCount)
    self.t2:LoadImage(Cfg.cfg_item[cfg.ReplaceRewardID].Icon)
    self.t2Count:SetText(cfg.ReplaceRewardCount)
    self._s1ID = RoleAssetID.RoleAssetGlow
    self._s1Count = cfg.AppendGlow
    self._s2ID = cfg.RewardID
    self._s2Count = cfg.RewardCount
    self._t1ID = RoleAssetID.RoleAssetGlow
    self._t1Count = cfg.AppendGlow
    self._t2ID = cfg.ReplaceRewardID
    self._t2Count = cfg.ReplaceRewardCount
  else
    self.s1:LoadImage(Cfg.cfg_item[cfg.RewardID].Icon)
    self.s1Count:SetText(cfg.RewardCount)
    self.t1:LoadImage(Cfg.cfg_item[cfg.ReplaceRewardID].Icon)
    self.t1Count:SetText(cfg.ReplaceRewardCount)
    self._s1ID = cfg.RewardID
    self._s1Count = cfg.RewardCount
    self._t1ID = cfg.ReplaceRewardID
    self._t1Count = cfg.ReplaceRewardCount
  end
  self.title:SetText(StringTable.Get("str_senior_skin_draw_gifttype" .. cfg.RewardSortOrder))
  self._onClick = onClick
end

function UIHauteCoutureDuplicateItem:SetBg(cfg)
end

function UIHauteCoutureDuplicateItem:S1OnClick(go)
  self._onClick(self._s1ID, go.transform.position, self._s1Count)
end

function UIHauteCoutureDuplicateItem:S2OnClick(go)
  self._onClick(self._s2ID, go.transform.position, self._s2Count)
end

function UIHauteCoutureDuplicateItem:T1OnClick(go)
  self._onClick(self._t1ID, go.transform.position, self._t1Count)
end

function UIHauteCoutureDuplicateItem:T2OnClick(go)
  self._onClick(self._t2ID, go.transform.position, self._t2Count)
end
