_class("UISailingLevelTeamItem", UICustomWidget)
UISailingLevelTeamItem = UISailingLevelTeamItem

function UISailingLevelTeamItem:OnShow(uiParam)
  self:GetComponents()
end

function UISailingLevelTeamItem:GetComponents()
  self._elem1 = self:GetUIComponent("Image", "elem1")
  self._elem2 = self:GetUIComponent("Image", "elem2")
  self._head = self:GetUIComponent("RawImageLoader", "head")
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._rectGo = self:GetGameObject("rect")
  self._mask = self:GetGameObject("mask")
  self._atlas = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UISailingLevelTeamItem:OnValue()
  self._rect.localScale = Vector3(self._scale, self._scale, self._scale)
  local module = GameGlobal.GetModule(PetModule)
  if self._isPstId then
    if self._pstid and self._pstid > 0 then
      self:Active(true)
      local pet = module:GetPet(self._pstid)
      local head = pet:GetPetTeamBody(PetSkinEffectPath.CARD_TEAM)
      self._head:LoadImage(head)
      local cfg_pet_element = Cfg.cfg_pet_element({})
      local firstElem = pet:GetPetFirstElement()
      self._elem1.gameObject:SetActive(true)
      self._elem1.sprite = self._atlas:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[firstElem].Icon))
      local secondElem = pet:GetPetSecondElement()
      if secondElem and 0 < secondElem then
        self._elem2.gameObject:SetActive(true)
        self._elem2.sprite = self._atlas:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[secondElem].Icon))
      else
        self._elem2.gameObject:SetActive(false)
      end
    else
      self:Active(false)
    end
  elseif self._pstid then
    self:Active(true)
    local grad = self._pstid[4]
    local head = HelperProxy:GetInstance():GetPetTeamBody(self._pstid[1], grad, 1, PetSkinEffectPath.CARD_TEAM)
    self._head:LoadImage(head)
    local cfg_pet_element = Cfg.cfg_pet_element({})
    local cfg_pet = Cfg.cfg_pet[self._pstid[1]]
    local firstElem = cfg_pet.FirstElement
    self._elem1.gameObject:SetActive(true)
    self._elem1.sprite = self._atlas:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[firstElem].Icon))
    if grad >= cfg_pet.Element2NeedGrade then
      if 0 < cfg_pet.SecondElement then
        local secondElem = cfg_pet.SecondElement
        if secondElem and 0 < secondElem then
          self._elem2.gameObject:SetActive(true)
          self._elem2.sprite = self._atlas:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[secondElem].Icon))
        else
          self._elem2.gameObject:SetActive(false)
        end
      end
    else
      self._elem2.gameObject:SetActive(false)
    end
  else
    self:Active(false)
  end
end

function UISailingLevelTeamItem:Active(active)
  self._mask:SetActive(active)
  self._elem2.gameObject:SetActive(active)
  self._elem1.gameObject:SetActive(active)
end

function UISailingLevelTeamItem:SetData(pstid, scale, ispstid)
  self._isPstId = ispstid
  self._pstid = pstid
  self._scale = scale or 1
  self:OnValue()
end

function UISailingLevelTeamItem:OnHide()
end
