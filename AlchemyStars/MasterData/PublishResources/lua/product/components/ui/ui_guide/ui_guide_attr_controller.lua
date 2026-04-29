_class("UIGuideAttrController", UIController)
UIGuideAttrController = UIGuideAttrController

function UIGuideAttrController:Constructor()
end

function UIGuideAttrController:OnShow(uiParams)
  self.kuang1 = self:GetGameObject("kuang1")
  self.kuang2 = self:GetGameObject("kuang2")
  self.kuang3 = self:GetGameObject("kuang3")
  self.headIcon1 = self:GetUIComponent("RawImageLoader", "HeadIcon1")
  self.headIcon2 = self:GetUIComponent("RawImageLoader", "HeadIcon2")
  self.headIcon3 = self:GetUIComponent("RawImageLoader", "HeadIcon3")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self.attrMain1 = self:GetUIComponent("Image", "Attribute1")
  self.attrMain2 = self:GetUIComponent("Image", "Attribute2")
  self.attrMain3 = self:GetUIComponent("Image", "Attribute3")
  local petIds = Cfg.cfg_guide_const.guide_attr_pet_id.ArrayValue
  local cfg1 = Cfg.cfg_pet[petIds[1]]
  local cfg2 = Cfg.cfg_pet[petIds[2]]
  local cfg3 = Cfg.cfg_pet[petIds[3]]
  self.headIcon1:LoadImage(HelperProxy:GetInstance():GetPetHead(petIds[1], 0, 0))
  self.headIcon2:LoadImage(HelperProxy:GetInstance():GetPetHead(petIds[2], 0, 0))
  self.headIcon3:LoadImage(HelperProxy:GetInstance():GetPetHead(petIds[3], 0, 0))
  self.attrMain1.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(Cfg.cfg_pet_element[cfg1.FirstElement].Icon .. "_battle"))
  self.attrMain2.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(Cfg.cfg_pet_element[cfg2.FirstElement].Icon .. "_battle"))
  self.attrMain3.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(Cfg.cfg_pet_element[cfg3.FirstElement].Icon .. "_battle"))
  self:StartTask(function(TT)
    self.kuang1:SetActive(true)
    self.kuang2:SetActive(true)
    self.kuang3:SetActive(true)
    YIELD(TT, 2000)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.InnerAttrIcon)
    self:CloseDialog()
  end)
end
