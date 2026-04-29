_class("UISeasonBuildRewardItemS3", UICustomWidget)
UISeasonBuildRewardItemS3 = UISeasonBuildRewardItemS3

function UISeasonBuildRewardItemS3:OnShow(uiParams)
  self:InitWidget()
  self._atlas = self:RootUIOwner():GetAsset("UIS3Build.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonBuildRewardItemS3:InitWidget()
  self.item = self:GetUIComponent("RawImageLoader", "item")
  self.imgColor = self:GetUIComponent("Image", "imgColor")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.maskGo = self:GetGameObject("mask")
end

function UISeasonBuildRewardItemS3:SetData(itemId, itemCount, clickCb)
  self._clickCb = clickCb
  self._itemId = itemId
  self.txtCount:SetText("x" .. itemCount)
  local cfg = Cfg.cfg_item[itemId]
  if cfg then
    self.item:LoadImage(cfg.Icon)
    local color = cfg.Color
    self.imgColor.sprite = self._atlas:GetSprite("exp_s3_map_gq_se0" .. color)
  end
  self.maskGo:SetActive(false)
end

function UISeasonBuildRewardItemS3:ItemBtnOnClick(go)
  if self._clickCb then
    self._clickCb(self._itemId, go.transform.position)
  end
end

function UISeasonBuildRewardItemS3:ShowMask(bMask)
  self.maskGo:SetActive(bMask)
end
