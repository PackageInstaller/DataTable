_class("UILostLandStageFilterItem", UICustomWidget)
UILostLandStageFilterItem = UILostLandStageFilterItem

function UILostLandStageFilterItem:OnShow(uiParams)
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
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._uiHeartItemAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  self:GetComponents()
end

function UILostLandStageFilterItem:SetData(recommendData)
  self._elementGo:SetActive(false)
  self._profGo:SetActive(false)
  self._campGo:SetActive(false)
  local recommendCondition = recommendData
  if recommendCondition.cond1 == PetFilterCondType.RFCT_Color then
    self._elementGo:SetActive(true)
    self._elementImg.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(Cfg.cfg_pet_element[recommendCondition.cond2].Icon))
    local elementTex = StringTable.Get("str_pet_detail_element_" .. recommendCondition.cond2) .. StringTable.Get("str_pet_detail_element_property")
    self._elementTex:SetText(elementTex)
  elseif recommendCondition.cond1 == PetFilterCondType.RFCT_Prof then
    self._profGo:SetActive(true)
    self._profImg.sprite = self._uiHeartItemAtlas:GetSprite(self._prof2Img[recommendCondition.cond2])
    self._profTex:SetText(StringTable.Get(self._prof2Tex[self._prof]))
  elseif recommendCondition.cond1 == PetFilterCondType.RFCT_Force then
    self._campGo:SetActive(true)
    local cfg = Cfg.cfg_pet_tags[recommendCondition.cond2]
    if cfg ~= nil then
      self._campTex:SetText(StringTable.Get(cfg.Name))
    end
  end
end

function UILostLandStageFilterItem:GetComponents()
  self._profGo = self:GetGameObject("profGo")
  self._profImg = self:GetUIComponent("Image", "profImg")
  self._profTex = self:GetUIComponent("UILocalizationText", "profTex")
  self._campGo = self:GetGameObject("campGo")
  self._campTex = self:GetUIComponent("UILocalizationText", "campTex")
  self._elementGo = self:GetGameObject("elementGo")
  self._elementImg = self:GetUIComponent("Image", "elementImg")
  self._elementTex = self:GetUIComponent("UILocalizationText", "elementTex")
end
