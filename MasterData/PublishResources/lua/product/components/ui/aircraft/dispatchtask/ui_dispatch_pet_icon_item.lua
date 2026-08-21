_class("UIDispatchPetIconItem", UICustomWidget)
UIDispatchPetIconItem = UIDispatchPetIconItem

function UIDispatchPetIconItem:OnShow(uiParams)
  self._prof2Img = {
    [2001] = "spirit_prof_5",
    [2002] = "spirit_prof_1",
    [2003] = "spirit_prof_3",
    [2004] = "spirit_prof_7"
  }
  self._uiPetItemAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  self._atlasAwake = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._petIconImg = self:GetUIComponent("RawImageLoader", "PetIcon")
  self._petIconGo = self:GetGameObject("PetIcon")
  self._forceIconLoader = self:GetUIComponent("RawImageLoader", "ForceIcon")
  self._forceIconGo = self:GetGameObject("ForceIcon")
  self._profIconLeftImg = self:GetUIComponent("Image", "ProfIconLeft")
  self._profIconLeftGo = self:GetGameObject("ProfIconLeft")
  self._forceIconImg = self:GetUIComponent("RawImage", "ForceIcon")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._elementIconLoader = self:GetUIComponent("Image", "ElementIcon")
  self._elementIconImg = self:GetUIComponent("Image", "ElementIcon")
  self._elementIconGo = self:GetGameObject("ElementIcon")
  self._profIconImg = self:GetUIComponent("Image", "ProfIcon")
  self._profIconGo = self:GetGameObject("ProfIcon")
  self._gradeImg = self:GetUIComponent("Image", "Grade")
  self._addGo = self:GetGameObject("Add")
end

function UIDispatchPetIconItem:OnHide()
  self._uiPetItemAtlas = nil
  self._atlasAwake = nil
end

function UIDispatchPetIconItem:Refresh(index, detailItem)
  self._index = index
  self._detailItem = detailItem
  self._pet = self._detailItem:GetDispatchPetByIndex(index)
  self:RefreshUI()
end

function UIDispatchPetIconItem:RefreshUI()
  if not self._pet then
    self._petIconGo:SetActive(false)
    self._addGo:SetActive(true)
  else
    self._petIconGo:SetActive(true)
    self._addGo:SetActive(false)
    self._petIconImg:LoadImage(HelperProxy:GetInstance():GetPetHead(self._pet:GetTemplateID(), self._pet:GetPetGrade(), self._pet:GetSkinId(), PetSkinEffectPath.HEAD_ICON_DISPATCH))
    local extraForce, extraElement, extraJop = self._detailItem:GetSuggestCfg()
    if extraForce and 0 < extraForce then
      self._forceIconGo:SetActive(true)
      self._profIconLeftGo:SetActive(false)
      local tags = self._pet:GetPetTags()
      local tag = tags[1]
      local tagCfg = Cfg.cfg_pet_tags[tag]
      if not string.isnullorempty(tagCfg.Icon) then
        self._forceIconGo:SetActive(true)
        self._forceIconLoader:LoadImage(tagCfg.Icon)
        if tag == extraForce then
          self._forceIconImg.color = Color(1, 1, 1, 1)
        else
          self._forceIconImg.color = Color(1, 1, 1, 0.6)
        end
      else
        self._forceIconGo:SetActive(false)
      end
    elseif extraJop and 0 < extraJop then
      self._forceIconGo:SetActive(false)
      self._profIconLeftGo:SetActive(true)
      local prof = self._pet:GetProf()
      self._profIconLeftImg.sprite = self._uiPetItemAtlas:GetSprite(self._prof2Img[prof])
      if extraJop == prof then
        self._profIconLeftImg.color = Color(1, 1, 1, 1)
      else
        self._profIconLeftImg.color = Color(1, 1, 1, 0.6)
      end
    end
    if extraElement and 0 < extraElement then
      self._elementIconGo:SetActive(true)
      self._profIconGo:SetActive(false)
      local element = self._pet:GetPetFirstElement()
      local cfg_pet_element = Cfg.cfg_pet_element({})
      self._elementIconLoader.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[element].Icon))
      if element == extraElement then
        self._elementIconImg.color = Color(1, 1, 1, 1)
      else
        self._elementIconImg.color = Color(1, 1, 1, 0.6)
      end
    elseif extraJop and 0 < extraJop then
      local prof = self._pet:GetProf()
      self._elementIconGo:SetActive(false)
      self._profIconGo:SetActive(true)
      self._profIconImg.sprite = self._uiPetItemAtlas:GetSprite(self._prof2Img[prof])
      if extraJop == prof then
        self._profIconImg.color = Color(1, 1, 1, 1)
      else
        self._profIconImg.color = Color(1, 1, 1, 0.6)
      end
    end
    local petId = self._pet:GetTemplateID()
    local petGradeLevel = self._pet:GetPetGrade()
    self._gradeImg.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(petId, petGradeLevel))
  end
end

function UIDispatchPetIconItem:HeadOnClick(go)
  if self._detailItem:GetTaskState() == DispatchTaskStateType.DTST_Doing then
    return
  end
  self:ShowDialog("UIDispatchSelectPetController", self._index, self._detailItem, self._detailItem:GetExcludePets())
end

function UIDispatchPetIconItem:AddOnClick(go)
  if self._detailItem:GetTaskState() == DispatchTaskStateType.DTST_Doing then
    return
  end
  self:ShowDialog("UIDispatchSelectPetController", self._index, self._detailItem, self._detailItem:GetExcludePets())
end
