_class("UIWorldBossPet", UICustomWidget)
UIWorldBossPet = UIWorldBossPet

function UIWorldBossPet:Constructor()
  self._petModule = self:GetModule(PetModule)
  self._atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._cfg = Cfg.cfg_pet_element({})
end

function UIWorldBossPet:OnShow(uiParams)
  self:_GetComponents()
end

function UIWorldBossPet:_GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._element1 = self:GetUIComponent("Image", "e1")
  self._element2 = self:GetUIComponent("Image", "e2")
end

function UIWorldBossPet:SetData(pstId)
  self._pstId = pstId
  self:_SetUIInfo()
end

function UIWorldBossPet:_SetUIInfo()
  self._data = self._petModule:GetPet(self._pstId)
  if self._data then
    local icon = self._data:GetPetTeamBody(PetSkinEffectPath.CARD_TEAM)
    if icon then
      self._icon:LoadImage(icon)
      self._icon.gameObject:SetActive(true)
    end
    local element1 = self._data:GetPetFirstElement()
    local element2 = self._data:GetPetSecondElement()
    self._element1.gameObject:SetActive(true)
    self._element1.sprite = self._atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(self._cfg[element1].Icon))
    local haveElement2 = element2 and 0 < element2
    if haveElement2 then
      self._element2.sprite = self._atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(self._cfg[element2].Icon))
    end
    self._element2.gameObject:SetActive(haveElement2)
  else
    self._icon.gameObject:SetActive(false)
    self._element1.gameObject:SetActive(false)
    self._element2.gameObject:SetActive(false)
  end
end
