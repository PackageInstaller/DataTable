_class("UIHelpPetManageCell", UICustomWidget)
UIHelpPetManageCell = UIHelpPetManageCell

function UIHelpPetManageCell:OnShow()
  self.petModule = self:GetModule(PetModule)
  self.haveGO = self:GetGameObject("have")
  self.haveTopGO = self:GetGameObject("havetop")
  self.addGO = self:GetGameObject("add")
  self.addTopGO = self:GetGameObject("addtop")
  self.cgNormal = self:GetUIComponent("MultiplyImageLoader", "cgNormal")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self.secondGO = self:GetGameObject("second")
  self.imgElement1 = self:GetUIComponent("Image", "Attribute1")
  self.imgElement2 = self:GetUIComponent("Image", "Attribute2")
  self.defaultElement = self:GetUIComponent("Image", "defaultAttr")
  self._rootAlpha = self:GetUIComponent("CanvasGroup", "root")
  self._rootAlpha.alpha = 0
  self._rootRect = self:GetUIComponent("RectTransform", "root")
end

function UIHelpPetManageCell:OnHide()
  if self._aTween then
    self._aTween:Kill()
  end
  if self._pTween then
    self._pTween:Kill()
  end
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end

function UIHelpPetManageCell:InitData(elementType, callBack, idx)
  self.elementType = elementType
  if self.elementType then
    self.defaultElement.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(Cfg.cfg_pet_element[self.elementType].Icon))
  end
  self.callBack = callBack
  if idx then
    self:PlayAnim(idx)
  end
end

function UIHelpPetManageCell:PlayAnim(idx)
  local x = -150 - (idx - 1) * 20
  self._rootRect.anchoredPosition = Vector2(x, 0)
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
  end
  self._event = GameGlobal.Timer():AddEvent(idx * 67, function()
    self._aTween = self._rootAlpha:DOFade(1, 0.5)
    self._pTween = self._rootRect:DOAnchorPosX(0, 0.5):SetEase(DG.Tweening.Ease.OutQuint)
  end)
end

function UIHelpPetManageCell:GetElementType()
  return self.elementType
end

function UIHelpPetManageCell:SetData(petTempId, elem)
  local have = true
  if not petTempId or petTempId == 0 then
    have = false
  else
    have = true
  end
  self.haveGO:SetActive(have)
  self.haveTopGO:SetActive(have)
  self.addGO:SetActive(not have)
  self.addTopGO:SetActive(not have)
  if have then
    local pet = self.petModule:GetPetByTemplateId(petTempId)
    self.pet = pet
    self:SetHaveState()
  else
    self:SetAddState(elem)
  end
end

function UIHelpPetManageCell:SetHaveState()
  if not self.pet then
    return
  end
  local petId = self.pet:GetTemplateID()
  local grade = self.pet:GetPetGrade()
  local skinId = self.pet:GetSkinId()
  local helpIcon = HelperProxy:GetInstance():GetPetVideo(petId, grade, skinId, PetSkinEffectPath.CARD_HELP_MANAGER)
  if helpIcon then
    self.cgNormal:Load(helpIcon)
  else
    Log.fatal("### [error] pet [", petId, "] no helpIcon")
  end
  if self.pet then
    local firstAttr = self.pet:GetPetFirstElement()
    local secondAttr = self.pet:GetPetSecondElement()
    self:LoadElement(firstAttr, secondAttr)
  end
end

function UIHelpPetManageCell:LoadElement(fstElement, secondElement)
  local cfg_pet_element = Cfg.cfg_pet_element({})
  if not cfg_pet_element then
    return
  end
  if fstElement then
    self.imgElement1.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[fstElement].Icon))
  end
  if secondElement then
    self.secondGO:SetActive(true)
    self.imgElement2.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[secondElement].Icon))
  else
    self.secondGO:SetActive(false)
  end
end

function UIHelpPetManageCell:SetAddState(elem)
end

function UIHelpPetManageCell:btngoOnClick()
  if self.callBack then
    self.petModule:ClearAllPetSortInfo()
    self.callBack(self.elementType)
  end
end
