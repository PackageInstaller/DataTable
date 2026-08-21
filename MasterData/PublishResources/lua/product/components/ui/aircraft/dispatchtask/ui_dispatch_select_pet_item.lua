_class("UIDispatchSelectPetItem", UICustomWidget)
UIDispatchSelectPetItem = UIDispatchSelectPetItem

function UIDispatchSelectPetItem:Constructor()
  self._uiPetItemAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  self._atlasAwake = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._dispatchTaskAtlas = self:GetAsset("UIDispatchTask.spriteatlas", LoadType.SpriteAtlas)
  self._tagId2Name = {
    [1001] = "paiqian_map_logo1001",
    [1002] = "paiqian_map_logo1002",
    [1003] = "paiqian_map_logo1003",
    [1004] = "paiqian_map_logo1004",
    [1005] = "paiqian_map_logo1005",
    [1006] = "paiqian_map_logo1006"
  }
  self._prof2Img = {
    [2001] = "spirit_prof_5",
    [2002] = "spirit_prof_1",
    [2003] = "spirit_prof_3",
    [2004] = "spirit_prof_7"
  }
  self._prof2Tex = {
    [2001] = "str_pet_tag_job_name_color_change",
    [2002] = "str_pet_tag_job_name_return_blood",
    [2003] = "str_pet_tag_job_name_attack",
    [2004] = "str_pet_tag_job_name_function"
  }
  self.Element2ImageName = {
    [ElementType.ElementType_Blue] = "str_shop_pet_shui",
    [ElementType.ElementType_Red] = "str_shop_pet_huo",
    [ElementType.ElementType_Green] = "str_shop_pet_sen",
    [ElementType.ElementType_Yellow] = "str_shop_pet_lei"
  }
end

function UIDispatchSelectPetItem:OnShow(uiParam)
  self:_GetComponents()
end

function UIDispatchSelectPetItem:OnHide()
  self._uiPetItemAtlas = nil
  self._atlasAwake = nil
  self._dispatchTaskAtlas = nil
end

function UIDispatchSelectPetItem:_GetComponents()
  self._nameText = self:GetUIComponent("UILocalizationText", "name")
  self._gradeIcon = self:GetUIComponent("Image", "grade")
  self._rawimage = self:GetUIComponent("RawImageLoader", "drawIcon")
  self._qualityIcon = self:GetUIComponent("Image", "qualityIcon")
  self._removePanelGo = self:GetGameObject("RemovePanel")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._elementGo = self:GetGameObject("element")
  self._elementIcon = self:GetUIComponent("Image", "element")
  self._elementNameLabel = self:GetUIComponent("UILocalizationText", "elementName")
  self._profNameLabel = self:GetUIComponent("UILocalizationText", "profName")
  self.profGo = self:GetGameObject("prof")
  self._profIcon = self:GetUIComponent("Image", "prof")
  self._workingRoom = self:GetUIComponent("UILocalizationText", "workingRoom")
  self._work = self:GetGameObject("work")
end

function UIDispatchSelectPetItem:Refresh(pet, isSelected, isSuggestPetIsElement, workingSpace, callback)
  self._pet = pet
  local petId = self._pet:GetTemplateID()
  local petGradeLevel = self._pet:GetPetGrade()
  local petStar = self._pet:GetPetStar()
  self._nameText:SetText(StringTable.Get(self._pet:GetPetName()))
  self._gradeIcon.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(petId, petGradeLevel))
  self._rawimage:LoadImage(self._pet:GetPetBody(PetSkinEffectPath.CARD_DISPATCH))
  self._qualityIcon.sprite = self._uiPetItemAtlas:GetSprite("map_biandui_pin" .. petStar)
  local cfg_pet_element = Cfg.cfg_pet_element({})
  self._elementIcon.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[self._pet:GetPetFirstElement()].Icon))
  self._elementNameLabel.text = StringTable.Get(self.Element2ImageName[self._pet:GetPetFirstElement()])
  local prof = self._pet:GetProf()
  self._profIcon.sprite = self._uiPetItemAtlas:GetSprite(self._prof2Img[prof])
  self._profNameLabel.text = StringTable.Get(self._prof2Tex[prof])
  self._removePanelGo:SetActive(isSelected)
  self._callback = callback
  self._isSelected = isSelected
  if workingSpace then
    local room = self:GetModule(AircraftModule):GetRoom(workingSpace)
    local name = room:GetRoomName()
    self._workingRoomName = StringTable.Get(name)
    self._workingRoom:SetText(StringTable.Get("str_aircraft_settled_in", self._workingRoomName))
  end
  self._work:SetActive(workingSpace ~= nil)
end

function UIDispatchSelectPetItem:SelectBtnOnClick(go)
  if self._workingRoomName and not self._isSelected then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_aircraft_dispatch_tip1", self._workingRoomName), self._callback, nil, function(param)
    end, nil)
    return
  end
  self._callback()
end
