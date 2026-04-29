_class("UIGradeSkillPanelController", UIController)
UIGradeSkillPanelController = UIGradeSkillPanelController

function UIGradeSkillPanelController:Constructor()
  self._controllerName = "UIGradeSkillPanelController"
  self._element2Str = {
    [ElementType.ElementType_Blue] = "str_pet_filter_water_element",
    [ElementType.ElementType_Red] = "str_pet_filter_fire_element",
    [ElementType.ElementType_Green] = "str_pet_filter_sen_element",
    [ElementType.ElementType_Yellow] = "str_pet_filter_electricity_element",
    [ElementType.ElementType_AnyNone] = "str_tale_pet_att_none"
  }
end

function UIGradeSkillPanelController:OnShow(uiParams)
  local pstid = uiParams[1]
  self._petModule = GameGlobal.GetModule(PetModule)
  self._petInfo = self._petModule:GetPet(pstid)
  local petUiModule = self._petModule.uiModule
  self._body, self._skillVaryInfos = petUiModule:GetDiffWithGrade(self._petInfo, true)
  self._skillVaryInfos = petUiModule:RemoveNotShowSkill(self._petInfo:GetTemplateID(), self._petInfo:GetPetGrade() + 1, self._petInfo:GetPetAwakening(), self._skillVaryInfos)
  self._atlas = self:GetAsset("UIPetGrade.spriteatlas", LoadType.SpriteAtlas)
  self._atlasAwake = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self:GetComponents()
  self:OnValue()
end

function UIGradeSkillPanelController:GetComponents()
  self._detailScrollView = self:GetUIComponent("UISelectObjectPath", "DetailScrollView")
  self.rightGrade = self:GetUIComponent("Image", "rightGrade")
  self.leftGrade = self:GetUIComponent("Image", "leftGrade")
  self.leftGradeTex = self:GetUIComponent("UILocalizationText", "leftGradeTex")
  self.rightGradeTex = self:GetUIComponent("UILocalizationText", "rightGradeTex")
  self.leftElementTex = self:GetUIComponent("UILocalizationText", "leftElementTex")
  self.rightElementTex = self:GetUIComponent("UILocalizationText", "rightElementTex")
  self.left_second_go = self:GetGameObject("left_second_go")
  self.right_second_go = self:GetGameObject("right_second_go")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self.left_second = self:GetUIComponent("Image", "left_second")
  self.left_first = self:GetUIComponent("Image", "left_first")
  self.right_first = self:GetUIComponent("Image", "right_first")
  self.right_second = self:GetUIComponent("Image", "right_second")
  self.lvleft = self:GetUIComponent("UILocalizationText", "lvleft")
  self.lvright = self:GetUIComponent("UILocalizationText", "lvright")
  self.attackFrom = self:GetUIComponent("UILocalizationText", "attackFrom")
  self.attackTo = self:GetUIComponent("UILocalizationText", "attackTo")
  self.atkTo = self:GetGameObject("atkTo")
  self.defenceFrom = self:GetUIComponent("UILocalizationText", "defenceFrom")
  self.defenceTo = self:GetUIComponent("UILocalizationText", "defenceTo")
  self.defTo = self:GetGameObject("defTo")
  self.healthFrom = self:GetUIComponent("UILocalizationText", "healthFrom")
  self.healthTo = self:GetUIComponent("UILocalizationText", "healthTo")
  self.hpTo = self:GetGameObject("hpTo")
  self._cgImgGo = self:GetGameObject("cgImg")
  self._equipImgGo = self:GetGameObject("equipImg")
  self._cgImg = self:GetUIComponent("RawImageLoader", "cgImg")
  self._equipImg = self:GetUIComponent("RawImageLoader", "equipImg")
  self._cgTipGo = self:GetGameObject("cg")
  self._equipTipGo = self:GetGameObject("equip")
  self._elementGo = self:GetGameObject("element")
  self._unLockEquipOrCg = self:GetGameObject("unLockEquipOrCg")
end

function UIGradeSkillPanelController:OnValue()
  if table.count(self._skillVaryInfos) > 0 then
    self:_InitDetailSrollView()
  end
  self:CheckEquipAndCgChanged()
  local gradeNow = self._petInfo:GetPetGrade()
  local gradeMax = self._petInfo:GetMaxGrade()
  local gradeNext = gradeNow + 1
  if gradeMax < gradeNext then
    gradeNext = gradeMax
  end
  local f_l = self._petInfo:GetPetFirstElement()
  local cfg_element = Cfg.cfg_pet_element({})
  self.left_first.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_element[f_l].Icon))
  self.right_first.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_element[f_l].Icon))
  local s_l = self._petInfo:GetPetSecondElement()
  local hasSecondNow = true
  if s_l == nil or s_l == 0 then
    hasSecondNow = false
  end
  local cgf_pet = Cfg.cfg_pet[self._petInfo:GetTemplateID()]
  if cgf_pet == nil then
    Log.fatal("###cfg_pet is nil ! id --> ", self._petInfo:GetTemplateID())
    return
  end
  local s_r = 0
  if gradeNext >= cgf_pet.Element2NeedGrade then
    s_r = cgf_pet.SecondElement
  end
  local hasSecondNext = true
  if s_r == nil or s_r == 0 then
    hasSecondNext = false
  end
  self.left_second_go:SetActive(hasSecondNow)
  self.right_second_go:SetActive(hasSecondNext)
  if hasSecondNow == hasSecondNext then
    self._elementGo:SetActive(false)
  else
    self._elementGo:SetActive(true)
    local leftElementStr = ""
    local rightElementStr = ""
    if hasSecondNow then
      self.left_second.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_element[s_l].Icon))
      leftElementStr = StringTable.Get("str_pet_detail_element_" .. f_l) .. "  " .. StringTable.Get("str_pet_detail_element_" .. s_l)
    else
      leftElementStr = StringTable.Get(self._element2Str[f_l])
    end
    if hasSecondNext then
      self.right_second.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_element[s_r].Icon))
      rightElementStr = StringTable.Get("str_pet_detail_element_" .. f_l) .. "  " .. StringTable.Get("str_pet_detail_element_" .. s_r)
    else
      rightElementStr = StringTable.Get(self._element2Str[f_l])
    end
    self.leftElementTex:SetText(leftElementStr)
    self.rightElementTex:SetText(rightElementStr)
  end
  local petId = self._petInfo:GetTemplateID()
  self.leftGrade.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(petId, gradeNow))
  self.rightGrade.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(petId, gradeNext))
  self.leftGradeTex:SetText(string.format(StringTable.Get("str_pet_config_grade_number"), gradeNow))
  self.rightGradeTex:SetText(string.format(StringTable.Get("str_pet_config_grade_number"), gradeNext))
  local lv_now_left = self._petInfo:GetPetLevel()
  local lv_max_left = self._petInfo:GetMaxLevel()
  local lv_now_right = 1
  local cfg_pet_level = Cfg["cfg_pet_level_" .. self._petInfo:GetTemplateID() .. "_" .. gradeNext]()
  local lv_max_right = table.count(cfg_pet_level)
  self.lvleft:SetText("LV. " .. lv_now_left .. "/" .. lv_max_left)
  self.lvright:SetText("LV. " .. lv_now_right .. "<color=#00F2FF>/" .. lv_max_right .. "</color>")
  local attackFrom = self._petInfo:GetPetAttack()
  local defenceFrom = self._petInfo:GetPetDefence()
  local healthFrom = self._petInfo:GetPetHealth()
  local tempData = pet_data:New()
  tempData.template_id = self._petInfo:GetTemplateID()
  local pet = Pet:New(tempData)
  tempData.grade = self._petInfo:GetPetGrade() + 1
  tempData.level = 1
  tempData.awakening = self._petInfo:GetPetAwakening()
  local nowEquipLv = self._petInfo:GetEquipLv()
  if nowEquipLv and 0 < nowEquipLv then
    tempData.equip_lv = nowEquipLv
  elseif 1 <= self._petInfo:GetPetGrade() + 1 then
    tempData.equip_lv = 1
  else
    tempData.equip_lv = 0
  end
  tempData.affinity_level = self._petInfo:GetPetAffinityLevel()
  pet:SetData(tempData)
  pet:CalAttr()
  local attackTo = pet:GetPetAttack()
  local defenceTo = pet:GetPetDefence()
  local healthTo = pet:GetPetHealth()
  local atkUp = true
  if attackTo == attackFrom then
    atkUp = false
  end
  local defUp = true
  if defenceTo == defenceFrom then
    defUp = false
  end
  local hpUp = true
  if healthTo == healthFrom then
    hpUp = false
  end
  self.atkTo:SetActive(atkUp)
  if atkUp then
    self.attackTo:SetText(attackTo)
  end
  self.defTo:SetActive(atkUp)
  if atkUp then
    self.defenceTo:SetText(defenceTo)
  end
  self.hpTo:SetActive(atkUp)
  if atkUp then
    self.healthTo:SetText(healthTo)
  end
  self.attackFrom:SetText(attackFrom)
  self.defenceFrom:SetText(defenceFrom)
  self.healthFrom:SetText(healthFrom)
end

function UIGradeSkillPanelController:_InitDetailSrollView()
  if self._detailScrollView then
    self._listDetailTotalRow = table.count(self._skillVaryInfos)
    self._detailScrollView:SpawnObjects("UIGradeDetailItem", self._listDetailTotalRow)
    local rowList = self._detailScrollView:GetAllSpawnList()
    for i = 1, #rowList do
      local lastGrade = self._petInfo:GetPetGrade()
      local nextGrade = self._petInfo:GetPetGrade() + 1
      if nextGrade > self._petInfo:GetMaxGrade() then
        nextGrade = self._petInfo:GetMaxGrade()
      end
      local lastBreak = self._petInfo:GetPetAwakening()
      local nextBreak = self._petInfo:GetPetAwakening()
      rowList[i]:SetData(self._petInfo, self._skillVaryInfos[i], i, #rowList, lastGrade, nextGrade, lastBreak, nextBreak)
    end
  end
end

function UIGradeSkillPanelController:CheckEquipAndCgChanged()
  local cgUnLock = false
  if self._body.changeType ~= PetSkillChangeState.NoChange then
    cgUnLock = true
  end
  self._cgImgGo:SetActive(cgUnLock)
  self._cgTipGo:SetActive(cgUnLock)
  if cgUnLock then
    local newCg = self._body.to[1]
    self._cgImg:LoadImage(newCg)
    UICG.SetTransform(self._cgImgGo.transform, self._controllerName, newCg)
  end
  local equipUnLock = false
  if self._skillVaryInfos ~= nil and table.count(self._skillVaryInfos) > 0 then
    for key, value in pairs(self._skillVaryInfos) do
      if value.type == "passive" and value.changeType == PetSkillChangeState.NewGain then
        equipUnLock = true
        break
      end
    end
  end
  self._equipImgGo:SetActive(equipUnLock)
  self._equipTipGo:SetActive(equipUnLock)
  if equipUnLock then
    local petTempleteID = self._petInfo:GetTemplateID()
    local equipCfg = Cfg.cfg_pet_equip_view[petTempleteID]
    if equipCfg then
      local equipIconName = equipCfg.Icon
      self._equipImg:LoadImage(equipIconName)
    end
  end
  if not equipUnLock and not cgUnLock then
    self._unLockEquipOrCg:SetActive(false)
  else
    self._unLockEquipOrCg:SetActive(true)
  end
end

function UIGradeSkillPanelController:bgOnClick()
  self:CloseDialog()
end
