_class("UISeasonS3CollageCollectionItem", UICustomWidget)
UISeasonS3CollageCollectionItem = UISeasonS3CollageCollectionItem

function UISeasonS3CollageCollectionItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonS3CollageCollectionItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.unlockIcon = self:GetGameObject("unlockIcon")
  self.new = self:GetGameObject("new")
  self.iconImage = self:GetUIComponent("RawImage", "icon")
  self.select = self:GetGameObject("select")
  self.bg = self:GetUIComponent("Image", "bg")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self._atlas = self:GetAsset("UIS3Collages.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonS3CollageCollectionItem:SetData(data, onClick)
  self._data = data
  self._onClick = onClick
  self:SetNew(data:IsNew())
  local cfg = Cfg.cfg_item_season_collection[data:ID()]
  self.icon:LoadImage(cfg.HdImage)
  if data:IsGot() then
    self.icon:SetColor(Color.white)
    self.unlockIcon:SetActive(false)
    if data:IsComposeUsed() then
      self.icon:SetColor(Color(0.32941176470588235, 0.20784313725490197, 0.12549019607843137, 0.7))
    end
  else
    self.icon:SetColor(Color(0, 0, 0, 0.8))
    self.unlockIcon:SetActive(true)
  end
  self:SetSelect(false)
end

function UISeasonS3CollageCollectionItem:RootOnClick(go)
  self._onClick(self._data)
end

function UISeasonS3CollageCollectionItem:SetNew(new)
  self._isNew = new
  self.new:SetActive(new)
end

function UISeasonS3CollageCollectionItem:SetSelect(select)
  self._anim:Stop()
  if select then
    self.select:SetActive(true)
    self._anim:Play("uieffanim_UISeasonS3CollageCollectionItem_in")
    if self._data:IsGot() then
      self.bg.sprite = self._atlas:GetSprite("exp_s3_book_daoju1")
    else
      self.bg.sprite = self._atlas:GetSprite("exp_s3_book_daoju3")
    end
  else
    self.select:SetActive(false)
    self._anim:Play("uieffanim_UISeasonS3CollageCollectionItem_out")
    if self._data:IsGot() then
      self.bg.sprite = self._atlas:GetSprite("exp_s3_book_daoju2")
    else
      self.bg.sprite = self._atlas:GetSprite("exp_s3_book_daoju3")
    end
  end
end

function UISeasonS3CollageCollectionItem:PlayExitAnim()
end
