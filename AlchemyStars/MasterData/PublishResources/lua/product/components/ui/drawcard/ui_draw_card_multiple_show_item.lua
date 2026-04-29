_class("UIDrawCardMultipleShowItem", Object)
UIDrawCardMultipleShowItem = UIDrawCardMultipleShowItem

function UIDrawCardMultipleShowItem:InitWidget()
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self.drawIcon = self:GetUIComponent("RawImageLoader", "drawIcon")
  self.diLayer = self:GetUIComponent("Image", "diLayer")
  self.elementIcon = self:GetUIComponent("Image", "elementIcon")
  self.stars = self:GetGameObject("stars")
  self._new = self:GetGameObject("new")
  self.logo = self:GetUIComponent("RawImageLoader", "logo")
end

function UIDrawCardMultipleShowItem:GetUIComponent(component, name)
  return self._view:GetUIComponent(component, name)
end

function UIDrawCardMultipleShowItem:GetGameObject(name)
  return self._view:GetGameObject(name)
end

function UIDrawCardMultipleShowItem:GetAsset(name, loadType)
  return UIResourceManager.GetAsset(name, loadType, self.name2Assets)
end

function UIDrawCardMultipleShowItem:SetData(idx, tmpID, view, checkNew, hideEff)
  self.name2Assets = {}
  self._view = view
  self:InitWidget()
  local cfg = Cfg.cfg_pet[tmpID]
  local star = cfg.Star
  local teamBody = HelperProxy:GetInstance():GetPetTeamBody(tmpID, 0, 0, PetSkinEffectPath.CARD_DRAW_MULTI)
  self.drawIcon:LoadImage(teamBody)
  self._checkNew = checkNew
  if 4 < star then
    self.diLayer.sprite = self:GetAsset("UIDrawCard.spriteatlas", LoadType.SpriteAtlas):GetSprite("obtain_donghua_ka" .. star - 3)
  else
    self.diLayer.sprite = self:GetAsset("UIDrawCard.spriteatlas", LoadType.SpriteAtlas):GetSprite("obtain_donghua_ka1")
  end
  self.elementIcon.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(Cfg.cfg_pet_element[cfg.FirstElement].Icon))
  local parent = self.stars.transform
  for i = 1, 6 do
    parent:GetChild(i - 1).gameObject:SetActive(star >= i)
  end
  self.logo:LoadImage(cfg.Logo)
  if self._checkNew(idx) then
    self._new:SetActive(true)
  else
    self._new:SetActive(false)
  end
  if 3 < star and not hideEff then
    local eftLoader = self:GetUIComponent("EffectLoader", "Eft")
    eftLoader:LoadEffect("uieff_Card_Mask_" .. star)
  end
end

function UIDrawCardMultipleShowItem:OnHide()
  UIResourceManager.DisposeAllAssets(self.name2Assets)
  self.name2Assets = nil
end
