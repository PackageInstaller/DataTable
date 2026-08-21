_class("UIN33EightPetsStageReward", UICustomWidget)
UIN33EightPetsStageReward = UIN33EightPetsStageReward

function UIN33EightPetsStageReward:OnShow(uiParams)
  self:InitWidget()
end

function UIN33EightPetsStageReward:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.count = self:GetUIComponent("UILocalizationText", "count")
  self.awardText = self:GetUIComponent("UILocalizationText", "awardText")
  self.uiFirst = self:GetGameObject("uiFirst")
  self.uiNormal = self:GetGameObject("uiNormal")
  self.ui3Star = self:GetGameObject("ui3Star")
  self.uiLimit = self:GetGameObject("uiLimit")
  self.uiLimit:SetActive(false)
  self.animation = self:GetGameObject("animation")
end

function UIN33EightPetsStageReward:SetData(award, rewardType, clickCb)
  self.clickCb = clickCb
  self.uiNormal:SetActive(false)
  self.uiFirst:SetActive(rewardType == AwardType.ThreeStar)
  self.ui3Star:SetActive(rewardType == AwardType.First)
  if rewardType == AwardType.ThreeStar then
    self.awardText:SetText(StringTable.Get("str_n33_level_3star_award"))
  elseif rewardType == AwardType.First then
    self.awardText:SetText(StringTable.Get("str_n33_level_firstpass_ward"))
  end
  self.rewardItemId = award.ItemID
  local cfg = Cfg.cfg_item[award.ItemID]
  if cfg then
    self.icon:LoadImage(cfg.Icon)
  end
  self.count:SetText(award.Count)
end

function UIN33EightPetsStageReward:BtnOnClick(go)
  if self.clickCb then
    self.clickCb(self.rewardItemId, go)
  end
end
