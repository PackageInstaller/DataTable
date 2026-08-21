_class("UIEliminateFettersItem", UICustomWidget)
UIEliminateFettersItem = UIEliminateFettersItem

function UIEliminateFettersItem:Constructor()
  self.ElementSpriteName = {
    [ElementType.ElementType_Blue] = "bing_color",
    [ElementType.ElementType_Red] = "huo_color",
    [ElementType.ElementType_Green] = "sen_color",
    [ElementType.ElementType_Yellow] = "lei_color"
  }
end

function UIEliminateFettersItem:OnShow(uiParams)
  self._cg1 = self:GetUIComponent("RawImageLoader", "CG1")
  self._logo1 = self:GetUIComponent("RawImageLoader", "Logo1")
  self._mask1 = self:GetGameObject("Mask1")
  self._attr1 = self:GetUIComponent("Image", "Attr1")
  self._name1 = self:GetUIComponent("UILocalizationText", "Name1")
  self._cg2 = self:GetUIComponent("RawImageLoader", "CG2")
  self._logo2 = self:GetUIComponent("RawImageLoader", "Logo2")
  self._mask2 = self:GetGameObject("Mask2")
  self._attr2 = self:GetUIComponent("Image", "Attr2")
  self._name2 = self:GetUIComponent("UILocalizationText", "Name2")
  self._pets = {
    {
      CG = self._cg1,
      logo = self._logo1,
      mask = self._mask1,
      attr = self._attr1,
      name = self._name1
    },
    {
      CG = self._cg2,
      logo = self._logo2,
      mask = self._mask2,
      attr = self._attr2,
      name = self._name2
    }
  }
  self._petModule = self:GetModule(PetModule)
  self._atlasProperty = self.uiOwner:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UIEliminateFettersItem:SetData(fettersCfg)
  self:SetPetData(fettersCfg.PetAID, 1)
  self:SetPetData(fettersCfg.PetBID, 2)
end

function UIEliminateFettersItem:SetPetData(petTempID, index)
  local cfg = Cfg.cfg_pet[petTempID]
  local petData = self._petModule:GetPetByTemplateId(petTempID)
  local body
  if petData then
    local grade = petData:GetPetGrade()
    body = HelperProxy:GetInstance():GetPetTeamBody(petTempID, grade, petData:GetSkinId(), PetSkinEffectPath.CARD_ROLE_RELATION)
  else
    body = HelperProxy:GetInstance():GetPetTeamBody(petTempID, 0, 0, PetSkinEffectPath.CARD_ROLE_RELATION)
  end
  self._pets[index].CG:LoadImage(body)
  self._pets[index].logo:LoadImage(cfg.Logo)
  self._pets[index].name:SetText(StringTable.Get(cfg.Name))
  self._pets[index].attr.sprite = self._atlasProperty:GetSprite(self.ElementSpriteName[cfg.FirstElement])
  local petModule = GameGlobal.GetModule(PetModule)
  if petModule:GetPetByTemplateId(petTempID) then
    self._pets[index].mask:SetActive(false)
  else
    self._pets[index].mask:SetActive(true)
  end
end
