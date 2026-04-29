_class("UISeasonS2CollageCollectionItem", UICustomWidget)
UISeasonS2CollageCollectionItem = UISeasonS2CollageCollectionItem

function UISeasonS2CollageCollectionItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonS2CollageCollectionItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.unlockIcon = self:GetGameObject("unlockIcon")
  self.new = self:GetGameObject("new")
  self.iconImage = self:GetUIComponent("RawImage", "icon")
  self.select = self:GetGameObject("select")
  self.bg = self:GetUIComponent("Image", "bg")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self._atlas = self:GetAsset("UIS2Collages.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonS2CollageCollectionItem:SetData(data, onClick)
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

function UISeasonS2CollageCollectionItem:RootOnClick(go)
  self._onClick(self._data)
end

function UISeasonS2CollageCollectionItem:SetNew(new)
  self._isNew = new
  self.new:SetActive(new)
end

function UISeasonS2CollageCollectionItem:SetSelect(select)
  self._anim:Stop()
  if select then
    self.select:SetActive(true)
    if self._data:IsGot() then
      self.bg.sprite = self._atlas:GetSprite("exp_s2_book_daoju1")
    else
      self.bg.sprite = self._atlas:GetSprite("exp_s2_book_daoju3")
    end
  else
    self.select:SetActive(false)
    if self._data:IsGot() then
      self.bg.sprite = self._atlas:GetSprite("exp_s2_book_daoju2")
    else
      self.bg.sprite = self._atlas:GetSprite("exp_s2_book_daoju3")
    end
  end
end

function UISeasonS2CollageCollectionItem:PlayExitAnim()
  self._anim:Play("uieffanim_UISeasonS1CollageCollectionItem_out")
end
