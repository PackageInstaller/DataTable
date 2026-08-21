_class("UISendPetCard", UICustomWidget)
UISendPetCard = UISendPetCard

function UISendPetCard:OnShow(uiParam)
  self._cgLoader = self:GetUIComponent("RawImageLoader", "Cg")
  self._elemFirstImg = self:GetUIComponent("Image", "FirstElement")
  self._elemSecondImg = self:GetUIComponent("Image", "SecondElement")
  self._elemFirstImgGO = self:GetGameObject("SecondElement")
  self._notHaveGo = self:GetGameObject("notHave")
  self._petNameTex = self:GetUIComponent("UILocalizationText", "petName")
  self._stars = self:GetUIComponent("Transform", "stars")
  self._starList = {}
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  for i = 1, self._stars.childCount do
    local star = self._stars:GetChild(i - 1).gameObject
    self._starList[i] = star
  end
  self._atlas = self:GetAsset("SendCard.spriteatlas", LoadType.SpriteAtlas)
end

function UISendPetCard:SetStarSp(starSp1, starSp2, atlasProperty)
  self._sp1 = starSp1
  self._sp2 = starSp2
  self.atlasProperty = atlasProperty
end

function UISendPetCard:SetData(id)
  self._petid = id
  local cfg_pet = Cfg.cfg_pet[self._petid]
  self._petNameTex:SetText(StringTable.Get(cfg_pet.Name))
  local star = cfg_pet.Star
  local petInfo = GameGlobal.GetModule(PetModule):GetPetByTemplateId(self._petid)
  self._notHaveGo:SetActive(not petInfo)
  local curBreak = 0
  if petInfo then
    curBreak = petInfo:GetPetAwakening()
  end
  for i, v in ipairs(self._starList) do
    v:SetActive(i <= star)
    local sp
    if i <= curBreak then
      sp = self._atlas:GetSprite("cn15_glzx_star01")
    else
      sp = self._atlas:GetSprite("cn15_glzx_star02")
    end
    v:GetComponent("Image").sprite = sp
  end
  local cfg_pet_skin = Cfg.cfg_pet_skin[cfg_pet.SkinId]
  self._cgLoader:LoadImage(cfg_pet_skin.Body)
  local elemtFirst = cfg_pet.FirstElement
  local elemSecond = cfg_pet.SecondElement
  self._elemFirstImgGO:SetActive(not elemSecond == 0)
  self._elemFirstImg.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(Cfg.cfg_pet_element[elemtFirst].Icon))
  if elemSecond ~= 0 then
    self._elemSecondImg.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(Cfg.cfg_pet_element[elemSecond].Icon))
  end
end

function UISendPetCard:BtnOnClick(go)
  self:ShowDialog("UIShopPetDetailController", self._petid)
end
