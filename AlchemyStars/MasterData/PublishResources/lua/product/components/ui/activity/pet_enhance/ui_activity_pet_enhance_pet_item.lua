_class("UIActivityPetEnhancePetItem", UICustomWidget)
UIActivityPetEnhancePetItem = UIActivityPetEnhancePetItem

function UIActivityPetEnhancePetItem:Constructor()
  self._pet_pstid = 0
  self._atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UIActivityPetEnhancePetItem:OnShow()
  self._headImage = self:GetUIComponent("RawImageLoader", "headImage")
  self._attribute1 = self:GetUIComponent("Image", "attribute1")
  self._attribute2 = self:GetUIComponent("Image", "attribute2")
  self._petAreaGo = self:GetGameObject("PetArea")
  self._emptyAreaGo = self:GetGameObject("EmptyArea")
  self._petAreaGo:SetActive(false)
  self._emptyAreaGo:SetActive(true)
end

function UIActivityPetEnhancePetItem:OnHide()
end

function UIActivityPetEnhancePetItem:HeadBgOnClick()
  if not self._cfgCorrect then
    return
  end
  local petId = self._cfgCorrect.PetId
  local petInfo = MatchPetInfo:New()
  petInfo.pet_pstid = 0
  petInfo.pet_power = -1
  petInfo.template_id = self._cfgCorrect.PetId
  petInfo.level = self._cfgCorrect.Level
  petInfo.grade = self._cfgCorrect.GradeLv
  petInfo.awakening = self._cfgCorrect.AwakeningLv
  petInfo.equip_lv = self._cfgCorrect.EquipLv
  petInfo.equip_refine_lv = self._cfgCorrect.EquipRefineLv
  petInfo.affinity_level = 1
  petInfo.m_nHelpPetKey = 0
  self._matchPet = Pet:New(petInfo)
  self._matchPet:CalAttr()
  local customPetData = UICustomPetData:New()
  customPetData:SetPetId(petId)
  customPetData:SetAttack(self._matchPet:GetPetAttack())
  customPetData:SetHP(self._matchPet:GetPetHealth())
  customPetData:SetDef(self._matchPet:GetPetDefence())
  customPetData:SetAwakeing(self._matchPet:GetPetAwakening())
  customPetData:SetGrade(self._matchPet:GetPetGrade())
  customPetData:SetEquip(self._matchPet:GetEquipLv())
  customPetData:SetDetailTitleText("str_activity_pet_enhance_detail_titile")
  customPetData:SetShowLevelArea(true)
  customPetData:SetCustomLevel(self._cfgCorrect.Level)
  customPetData:SetAffinityLevel(1)
  customPetData:SetEquipRefineLevel(self._matchPet:GetEquipRefineLv())
  GameGlobal.UIStateManager():ShowDialog("UIShopPetDetailController", customPetData:GetPetId(), 1, 0, customPetData, 0, 1)
end

function UIActivityPetEnhancePetItem:InitByCfg(cfgCorrect)
  local petData
  self._cfgCorrect = cfgCorrect
  if cfgCorrect ~= nil then
    local pet_data = _G.pet_data
    local petIndo = pet_data:New()
    petIndo.template_id = cfgCorrect.PetId
    petIndo.level = cfgCorrect.Level
    petIndo.grade = cfgCorrect.GradeLv
    petIndo.awakening = cfgCorrect.AwakeningLv
    petIndo.affinity_level = 1
    petIndo.equip_lv = cfgCorrect.EquipLv
    petIndo.equip_refine_lv = cfgCorrect.EquipRefineLv
    petIndo.current_skin = 0
    petData = Pet:New(petIndo)
  end
  self:UpdatePetItem(petData)
end

function UIActivityPetEnhancePetItem:UpdatePetItem(petData)
  self._petAreaGo:SetActive(petData ~= nil)
  self._emptyAreaGo:SetActive(petData == nil)
  self._headImage.gameObject:SetActive(petData ~= nil)
  self._attribute1.gameObject:SetActive(petData ~= nil)
  self._attribute2.gameObject:SetActive(petData ~= nil)
  if petData ~= nil then
    self._headImage:LoadImage(petData:GetPetTeamBody(PetSkinEffectPath.CARD_TEAM))
    self:SetAtlasProperty(self._attribute1, petData:GetPetFirstElement())
    self:SetAtlasProperty(self._attribute2, petData:GetPetSecondElement())
  end
end

function UIActivityPetEnhancePetItem:SetAtlasProperty(img, idProperty)
  local cfgSingle
  local cfg_pet_element = Cfg.cfg_pet_element({})
  if cfg_pet_element then
    cfgSingle = cfg_pet_element[idProperty]
  end
  if cfgSingle then
    img.gameObject:SetActive(true)
    img.sprite = self._atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfgSingle.Icon))
  else
    img.gameObject:SetActive(false)
  end
end
