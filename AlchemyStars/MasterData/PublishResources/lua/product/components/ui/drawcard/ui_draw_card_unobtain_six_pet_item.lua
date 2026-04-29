_class("UIUnObtainSixPetItem", UICustomWidget)
UIUnObtainSixPetItem = UIUnObtainSixPetItem

function UIUnObtainSixPetItem:OnShow()
  self:InitWidget()
end

function UIUnObtainSixPetItem:InitWidget()
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self.drawIcon = self:GetUIComponent("RawImageLoader", "drawIcon")
  self.diLayer = self:GetUIComponent("Image", "diLayer")
  self.elementIcon = self:GetUIComponent("Image", "elementIcon")
  self.stars = self:GetGameObject("stars")
  self.logo = self:GetUIComponent("RawImageLoader", "logo")
end

function UIUnObtainSixPetItem:SetData(tmpID)
  self.petTempId = tmpID
  local cfg = Cfg.cfg_pet[tmpID]
  local star = cfg.Star
  local teamBody = HelperProxy:GetInstance():GetPetTeamBody(tmpID, 0, 0, PetSkinEffectPath.CARD_DRAW_MULTI)
  self.drawIcon:LoadImage(teamBody)
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
end

function UIUnObtainSixPetItem:ItemBtnOnClick(go)
  GameGlobal.UIStateManager():ShowDialog("UIShopPetDetailController", self.petTempId)
end
