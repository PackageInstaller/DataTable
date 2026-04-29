_class("UISeasonMaze_Campsites_RecruitPetItem", UICustomWidget)
UISeasonMaze_Campsites_RecruitPetItem = UISeasonMaze_Campsites_RecruitPetItem

function UISeasonMaze_Campsites_RecruitPetItem:Constructor()
  self._heartItemInfo = nil
  self._maxStarLevel = 6
  self._slotId = 0
  self._height = 0
  self._callBack = nil
end

function UISeasonMaze_Campsites_RecruitPetItem:OnShow()
  self._rawimage = self:GetUIComponent("RawImageLoader", "drawIcon")
  self._lvValueText = self:GetUIComponent("UILocalizationText", "lvValue")
  self._nameText = self:GetUIComponent("UILocalizationText", "name")
  self._imgLogo = self:GetUIComponent("RawImageLoader", "imgLogo")
  self._attrMain = self:GetUIComponent("Image", "attrMain")
  self._attrVice = self:GetUIComponent("Image", "attrVice")
  self._imgGrade = self:GetUIComponent("Image", "imgGrade")
  self._uiAtlas = self:RootUIOwner():GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._petModule = GameGlobal.GameLogic():GetModule(PetModule)
  self.selfRect = self:GetGameObject().transform:GetComponent("RectTransform")
  self._elementBg = self:GetUIComponent("RectTransform", "element")
  self._elementPos = self:GetUIComponent("RectTransform", "elementPos")
  self._detailBtnRect = self:GetGameObject("detailBtnRect")
  self.atlasProperty = self:RootUIOwner():GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonMaze_Campsites_RecruitPetItem:OnHide()
  self._hide = true
  self._heartItemInfo = nil
  self._callBack = nil
  self._rawimage = nil
  self._lvValueText = nil
  self._nameText = nil
  self._attrMain = nil
  self._attrVice = nil
  self._imgGrade = nil
  self._uiAtlas = nil
end

function UISeasonMaze_Campsites_RecruitPetItem:SetData(pet, petInfoList)
  local petInfo = pet
  if petInfo == nil then
    return
  end
  self._heartItemInfo = petInfo
  self._petInfoList = petInfoList
  self._rawimage:LoadImage(petInfo:GetPetTeamBody(PetSkinEffectPath.CARD_TEAM))
  self:ShowName()
  self:ShowLevel()
  self:ShowLogo()
  self:ShowElement()
  self:_SetStars()
  self:_SetEquipLv()
  self:_SetJobIcon()
  self:ShowGrade()
  self:ShowPetDetailBtn()
end

function UISeasonMaze_Campsites_RecruitPetItem:ShowPetDetailBtn()
  self._detailBtnRect:SetActive(true)
end

function UISeasonMaze_Campsites_RecruitPetItem:ShowName()
  if self._heartItemInfo == nil then
    return
  end
  self._nameText:SetText(StringTable.Get(self._heartItemInfo:GetPetName()))
end

function UISeasonMaze_Campsites_RecruitPetItem:ShowLevel()
  local petLevel = self._heartItemInfo:GetPetLevel()
  self._lvValueText:SetText(petLevel)
end

function UISeasonMaze_Campsites_RecruitPetItem:ShowLogo()
  if self._heartItemInfo == nil then
    return
  end
  self._imgLogo:LoadImage(self._heartItemInfo:GetPetLogo())
end

function UISeasonMaze_Campsites_RecruitPetItem:ShowElement()
  if self._heartItemInfo == nil then
    return
  end
  local cfg_pet_element = Cfg.cfg_pet_element({})
  if cfg_pet_element then
    local firstElement = self._heartItemInfo:GetPetFirstElement()
    if firstElement then
      self._attrMain.gameObject:SetActive(true)
      self._attrMain.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[firstElement].Icon))
    else
      self._attrMain.gameObject:SetActive(false)
    end
    local secondElement = self._heartItemInfo:GetPetSecondElement()
    if secondElement then
      self._attrVice.gameObject:SetActive(true)
      self._attrVice.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[secondElement].Icon))
    else
      self._attrVice.gameObject:SetActive(false)
    end
  end
end

function UISeasonMaze_Campsites_RecruitPetItem:_SetStars()
  local obj = UIWidgetHelper.SpawnObject(self, "_stars", "UIPetIntimacyStarGroup")
  obj:SetData(self._heartItemInfo, 0.8, -5)
end

function UISeasonMaze_Campsites_RecruitPetItem:_SetEquipLv()
  local obj = UIWidgetHelper.SpawnObject(self, "_equipLv", "UIPetEquipLvIcon")
  obj:SetData(self._heartItemInfo, true)
end

function UISeasonMaze_Campsites_RecruitPetItem:_SetJobIcon()
  local obj = UIWidgetHelper.SpawnObject(self, "_jobIcon", "UIPetJobIcon")
  obj:SetData(self._heartItemInfo, 1)
end

function UISeasonMaze_Campsites_RecruitPetItem:ShowGrade()
  local petId = self._heartItemInfo:GetTemplateID()
  local petGradeLevel = self._heartItemInfo:GetPetGrade()
  self._imgGrade.sprite = self._uiAtlas:GetSprite(UIPetModule.GetAwakeSpriteName(petId, petGradeLevel))
end

function UISeasonMaze_Campsites_RecruitPetItem:BtnDetailOnClick()
  local petModule = self:GetModule(PetModule)
  petModule.uiModule:SetTeamCustomPets(self._petInfoList)
  local petId = self._heartItemInfo:GetTemplateID()
  self:ShowDialog("UISpiritDetailGroupController", petId, false, nil, nil, true)
end
