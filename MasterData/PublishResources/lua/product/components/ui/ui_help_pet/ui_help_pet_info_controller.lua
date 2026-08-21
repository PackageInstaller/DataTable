_class("UIHelpPetInfoController", UIController)
UIHelpPetInfoController = UIHelpPetInfoController

function UIHelpPetInfoController:Constructor()
  self._maxStarLevel = 6
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
  self._element2Str = {
    [ElementType.ElementType_Blue] = "str_pet_filter_water_element",
    [ElementType.ElementType_Red] = "str_pet_filter_fire_element",
    [ElementType.ElementType_Green] = "str_pet_filter_sen_element",
    [ElementType.ElementType_Yellow] = "str_pet_filter_electricity_element",
    [ElementType.ElementType_AnyNone] = "str_tale_pet_att_none"
  }
  self._atlasAwake = self:GetAsset("UIPetDetail.spriteatlas", LoadType.SpriteAtlas)
  self._uiHeartItemAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  self._atlasAwake1 = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._petModule = GameGlobal.GetModule(PetModule)
end

function UIHelpPetInfoController:GetComponents()
  self._skillsPools = self:GetUIComponent("UISelectObjectPath", "skills")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._firstElement = self:GetUIComponent("Image", "first")
  self._secondElement = self:GetUIComponent("Image", "second")
  self._secondBg = self:GetGameObject("secondBg")
  self._elementTex = self:GetUIComponent("UILocalizationText", "elementText")
  self._nameText = self:GetUIComponent("UILocalizationText", "name")
  self._englishNameText = self:GetUIComponent("UILocalizationText", "EnglishName")
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self._attackText = self:GetUIComponent("UILocalizationText", "attackText")
  self._defenceText = self:GetUIComponent("UILocalizationText", "defenceText")
  self._healthText = self:GetUIComponent("UILocalizationText", "healthText")
  self._levelText = self:GetUIComponent("UILocalizationText", "levelValue")
  self._profTex = self:GetUIComponent("UILocalizationText", "profTex")
  self._profImg = self:GetUIComponent("Image", "profImg")
  self._stars = self:GetUIComponent("UISelectObjectPath", "stars")
  self.cgNormal = self:GetUIComponent("MultiplyImageLoader", "cgNormal")
  self.cgRect = self:GetUIComponent("RectTransform", "cgNormal")
  self._awakeCount = self:GetUIComponent("Image", "awakenImgLeft")
  self.inp1 = self:GetUIComponent("InputField", "InputField1")
  self.inp2 = self:GetUIComponent("InputField", "InputField2")
  local inp1 = self:GetGameObject("InputField1")
  local inp2 = self:GetGameObject("InputField2")
  local button = self:GetGameObject("Button")
  if EDITOR then
    button:SetActive(false)
    inp1:SetActive(false)
    inp2:SetActive(false)
  else
    button:SetActive(false)
    inp1:SetActive(false)
    inp2:SetActive(false)
  end
end

function UIHelpPetInfoController:OnShow(uiParams)
  self:GetComponents()
  self._petInfo = uiParams[1]
  self:OnValue()
end

function UIHelpPetInfoController:OnValue()
  self:RefreshInfo()
  self:ShowStarLevel()
  self:ShowProf()
  self:RefreshLevelInfo()
  self:_SetEquipLv()
end

function UIHelpPetInfoController:ShowStarLevel()
  local petStar = self.pet:GetPetStar()
  local awakenStep = self.pet:GetPetAwakening()
  local awakenLock = self.pet:GetAwakeMatch()
  self._stars:SpawnObjects("UIPetIntimacyStar", petStar)
  local stars = self._stars:GetAllSpawnList()
  for i = 1, #stars do
    local isBackBreak = i > awakenLock and i <= awakenStep
    stars[i]:Refresh(i <= awakenStep, isBackBreak)
  end
  local pet = self.pet
  local petId = pet:GetTemplateID()
  local awaken = pet:GetPetGrade()
  local spriteName = UIPetModule.GetAwakeSpriteName(petId, awaken)
  self._awakeCount.sprite = self._atlasAwake1:GetSprite(spriteName)
end

function UIHelpPetInfoController:RefreshInfo()
  local tempData = pet_data:New()
  tempData.template_id = self._petInfo.m_nTemplateID
  tempData.current_skin = self._petInfo.m_nSkinID
  local oriPet = Pet:New(tempData)
  tempData.grade = self._petInfo.m_nGrade
  tempData.level = self._petInfo.m_nLevel
  tempData.awakening = self._petInfo.m_nAwake
  tempData.equip_lv = self._petInfo.m_nEquipLevel
  tempData.awake_lock = self._petInfo.m_nAwakeLock
  tempData.equip_refine_lv = self._petInfo.m_nEquipRefineLevel
  oriPet:SetData(tempData)
  oriPet:CalAttr()
  local pet, isEnhanced = UIPetModule.ProcessSinglePetEnhance(oriPet)
  self:RefreshEnhanceFlagArea(isEnhanced)
  self.pet = pet
  if self.pet then
    local petId = self.pet:GetTemplateID()
    local helpIcon = HelperProxy:GetInstance():GetPetStaticBody(self.pet:GetTemplateID(), self.pet:GetPetGrade(), self.pet:GetSkinId(), PetSkinEffectPath.BODY_HELP)
    if helpIcon then
      UICG.SetTransform(self.cgRect, "UIHelpPetInfoController", helpIcon)
      self.cgNormal:Load(helpIcon)
    else
      Log.fatal("### [error] pet [", petId, "] no helpIcon")
    end
    local uiModule = self._petModule.uiModule
    self._skillDetailInfos = uiModule:GetSkillDetailInfoBySkillTypeHideExtra(self.pet)
    local creatCount = table.count(self._skillDetailInfos)
    self._skillsPools:SpawnObjects("UIFightSkillItem", creatCount)
    self._skillsSpawns = self._skillsPools:GetAllSpawnList()
    if self._skillsSpawns then
      for index, value in ipairs(self._skillsSpawns) do
        if creatCount < index then
          value:Enable(false)
        else
          value:Enable(true)
        end
      end
      for index = 1, creatCount do
        self._skillsSpawns[index]:SetData(self._skillDetailInfos[index], self.pet, index)
      end
    end
  end
  local itemIcon = self.pet:GetPetItemIcon(PetSkinEffectPath.ITEM_ICON_HELP)
  self.uiItem:SetData({
    icon = itemIcon,
    itemId = self.pet:GetTemplateID()
  })
  self:ShowElement()
  self:ShowName()
  self:RefreshAtt()
end

function UIHelpPetInfoController:ButtonOnClick(go)
  local id = tonumber(self.inp1.text)
  local grade = tonumber(self.inp2.text)
  local skinId = 0
  local helpIcon = HelperProxy:GetInstance():GetPetStaticBody(id, grade, skinId, PetSkinEffectPath.BODY_HELP)
  if helpIcon then
    UICG.SetTransform(self.cgRect, "UIHelpPetInfoController", helpIcon)
    self.cgNormal:Load(helpIcon)
  else
    Log.exception("输入一头问题 id--> ", id, "| grade--> ", grade)
  end
end

function UIHelpPetInfoController:ShowElement()
  local cfg_pet_element = Cfg.cfg_pet_element({})
  local elementTex = ""
  if cfg_pet_element then
    local f = self.pet:GetPetFirstElement()
    local s = self.pet:GetPetSecondElement()
    self._firstElement.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[f].Icon))
    if s and 0 < s then
      self._secondBg:SetActive(true)
      self._secondElement.gameObject:SetActive(true)
      self._secondElement.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[s].Icon))
      elementTex = StringTable.Get("str_pet_detail_element_" .. f) .. "  " .. StringTable.Get("str_pet_detail_element_" .. s)
    else
      elementTex = StringTable.Get(self._element2Str[f])
      self._secondElement.gameObject:SetActive(false)
      self._secondBg:SetActive(false)
    end
  end
  self._elementTex:SetText(elementTex)
end

function UIHelpPetInfoController:RefreshAtt()
  local _attackValue = self.pet:GetPetAttack()
  local _defenceValue = self.pet:GetPetDefence()
  local _healthValue = self.pet:GetPetHealth()
  self._attackText:SetText(_attackValue)
  self._defenceText:SetText(_defenceValue)
  self._healthText:SetText(_healthValue)
end

function UIHelpPetInfoController:ShowName()
  local name = self.pet:GetPetName()
  self._nameText:SetText(StringTable.Get(name))
end

function UIHelpPetInfoController:RefreshStar()
  local petStar = self.pet:GetPetStar()
  local awakenStep = self.pet:GetPetAwakening()
  for starLevel = 1, self._maxStarLevel do
    local _itemIcon = self:GetUIComponent("Image", "star" .. starLevel)
    local starGo = self:GetGameObject("star" .. starLevel)
    if starLevel <= petStar then
      if starLevel <= awakenStep then
        _itemIcon.sprite = self._atlasAwake:GetSprite("spirit_xiangqing_icon22")
      else
        _itemIcon.sprite = self._atlasAwake:GetSprite("spirit_xiangqing_icon21")
      end
      starGo:SetActive(true)
    else
      starGo:SetActive(false)
    end
  end
end

function UIHelpPetInfoController:OnHide()
end

function UIHelpPetInfoController:ShowProf()
  local prof = self.pet:GetProf()
  self._profTex:SetText(StringTable.Get(self._prof2Tex[prof]))
  self._profImg.sprite = self._uiHeartItemAtlas:GetSprite(self._prof2Img[prof])
end

function UIHelpPetInfoController:ExpSlider(curGrateMaxLevel, curLevel)
  local rate = 0
  if curGrateMaxLevel <= curLevel then
    rate = 1
  else
    local curLevelExp = self.pet:GetPetExp()
    local upLevelAllExp = self.pet:GetLevelUpNeedExp()
    rate = curLevelExp / upLevelAllExp
  end
  if self._firstIn == 0 then
    self._leveExpSlider.value = rate
  else
    if self._expTweener then
      self._expTweener:Kill()
    end
    self._expTweener = self._leveExpSlider:DOValue(0, 0.2):OnComplete(function()
      self._expTweener = self._leveExpSlider:DOValue(rate, 0.2)
    end)
  end
end

function UIHelpPetInfoController:RefreshLevelInfo()
  local curGrateMaxLevel = self.pet:GetMaxLevel()
  local curLevel = self.pet:GetPetLevel()
  self._levelText:SetText(curLevel .. "<size=45><color=#acacac>/</color><color=#f96601>" .. curGrateMaxLevel .. "</color></size>")
  local cfg_pet = Cfg.cfg_pet[self.pet:GetTemplateID()]
  if cfg_pet then
  else
    Log.fatal("###pet_detail -- cfg_pet is nil ! id -- " .. self.pet:GetTemplateID())
  end
  local itemIcon = self.pet:GetPetItemIcon(PetSkinEffectPath.ITEM_ICON_HELP)
  self.uiItem:SetData({
    icon = itemIcon,
    itemId = self.pet:GetTemplateID()
  })
end

function UIHelpPetInfoController:bgOnClick()
  self:CloseDialog()
end

function UIHelpPetInfoController:_SetEquipLv()
  local obj = UIWidgetHelper.SpawnObject(self, "_equipLv", "UIPetEquipLvIcon")
  obj:SetData(self.pet, true)
end

function UIHelpPetInfoController:RefreshEnhanceFlagArea(isEnhanced)
  local flagGo = self:GetGameObject("EnhanceFlagArea")
  local flagSop = self:GetUIComponent("UISelectObjectPath", "EnhanceFlagArea")
  if not flagGo then
    return
  end
  flagGo:SetActive(isEnhanced)
  if isEnhanced then
    local flagWidget = flagSop:SpawnObject("UIPetEnhancedFlag")
  else
  end
end
