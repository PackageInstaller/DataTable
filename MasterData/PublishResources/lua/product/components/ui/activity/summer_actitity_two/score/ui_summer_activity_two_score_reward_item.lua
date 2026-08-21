_class("UISummerActivityTwoScoreRewardItem", UICustomWidget)
UISummerActivityTwoScoreRewardItem = UISummerActivityTwoScoreRewardItem

function UISummerActivityTwoScoreRewardItem:OnShow()
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._qualityImg = self:GetUIComponent("Image", "quality")
  self._qualityGo = self:GetGameObject("quality")
  self._uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UISummerActivityTwoScoreRewardItem:OnHide()
  self._uiCommonAtlas = nil
end

function UISummerActivityTwoScoreRewardItem:Refresh(rewardData, callback)
  self._rewardData = rewardData
  self._countLabel.text = rewardData.count
  local ItemTempleate = Cfg.cfg_item[rewardData.assetid]
  self._iconImg:LoadImage(ItemTempleate.Icon)
  self:SetQuality(ItemTempleate.Color)
  self._callback = callback
  self._go = self:GetGameObject()
end

function UISummerActivityTwoScoreRewardItem:SetQuality(quality)
  if quality <= 0 then
    self._qualityGo:SetActive(false)
    return
  end
  local qualityName = UIEnum.ItemColorFrame(quality)
  if qualityName ~= "" then
    self._qualityGo:SetActive(true)
    self._qualityImg.sprite = self._uiCommonAtlas:GetSprite(qualityName)
  else
    self._qualityGo:SetActive(false)
  end
end

function UISummerActivityTwoScoreRewardItem:btnOnClick()
  if self._callback then
    self._callback(self._rewardData.assetid, self._go.transform.position)
  end
end
