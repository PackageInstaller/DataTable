_class("UIShopPetDetailController", UIController)
UIShopPetDetailController = UIShopPetDetailController

function UIShopPetDetailController:Constructor()
  self._element2Str = {
    [ElementType.ElementType_Blue] = "str_pet_filter_water_element",
    [ElementType.ElementType_Red] = "str_pet_filter_fire_element",
    [ElementType.ElementType_Green] = "str_pet_filter_sen_element",
    [ElementType.ElementType_Yellow] = "str_pet_filter_electricity_element",
    [ElementType.ElementType_AnyNone] = "str_tale_pet_att_none"
  }
  self._maxStarLevel = 6
end

function UIShopPetDetailController:OnShow(uiParams)
  self.petId = uiParams[1]
  local param2 = uiParams[2] or 0
  self._showMaxAwake = param2 == 0
  local param3 = uiParams[3] or 0
  self._isActivityShow = param3 == 0
  local param4 = uiParams[4] or 0
  self._showBreadInfo = param4 == 0
  self._customData = uiParams[5]
  self:_AttachEvents()
  local topButton = self:GetUIComponent("UISelectObjectPath", "topbtn")
  self.topButton = topButton:SpawnObject("UICommonTopButton")
  self.topButton:SetData(self.OnClickBack)
  local a = self:GetUIComponent("UISelectObjectPath", "cg")
  a:SpawnObjects("UISpineContainer", 1)
  self.spineContainer = a:GetAllSpawnList()[1]
  self.skillsPools = self:GetUIComponent("UISelectObjectPath", "skills")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._firstElement = self:GetUIComponent("Image", "first")
  self._secondElement = self:GetUIComponent("Image", "second")
  self._secondBg = self:GetGameObject("secondBg")
  self._elementTex = self:GetUIComponent("UILocalizationText", "elementText")
  self._content = self:GetUIComponent("RectTransform", "Content")
  self._nameText = self:GetUIComponent("UILocalizationText", "name")
  self._englishNameText = self:GetUIComponent("UILocalizationText", "EnglishName")
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self._attackText = self:GetUIComponent("UILocalizationText", "attackText")
  self._defenceText = self:GetUIComponent("UILocalizationText", "defenceText")
  self._healthText = self:GetUIComponent("UILocalizationText", "healthText")
  self._atlasAwake = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._goGradeMax = self:GetGameObject("gradeMax")
  self._maxGrade = self:GetUIComponent("Image", "maxGrade")
  self._gradeTex = self:GetUIComponent("UILocalizationText", "GradeTex")
  self._scrollViewRect = self:GetUIComponent("RectTransform", "scrollView")
  self._convene = self:GetGameObject("convene")
  self._conveneRect = self:GetUIComponent("RectTransform", "convene")
  self._btnState = self:GetUIComponent("Button", "btnState")
  self.btnStateObj = self:GetGameObject("btnState")
  self.convening = self:GetGameObject("convening")
  self._txtState = self:GetUIComponent("UILocalizationText", "txtState")
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self._txtTotalPro = self:GetUIComponent("UILocalizationText", "txtTotalPro")
  self._txtCurPro = self:GetUIComponent("UILocalizationText", "txtCurPro")
  self._selectRed = self:GetGameObject("selectRed")
  self.txtInfo = self:GetUIComponent("UILocalizationText", "txtInfo")
  self.infoObj = self:GetGameObject("infoObj")
  self.effShadow = self:GetGameObject("effShadow")
  self.shadow = self:GetUIComponent("RawImageLoader", "shadow")
  self.anim = self:GetUIComponent("Animation", "Anim")
  self.effc = self:GetGameObject("effC")
  self._centerView = self:GetUIComponent("UIView", "rectCenter")
  self.rightAnchor = self:GetGameObject("rightAnchor")
  self.rightAnchorBreak = self:GetGameObject("rightAnchorBreak")
  self.leftDown = self:GetGameObject("leftDown")
  self.promotionDes = self:GetUIComponent("UILocalizedTMP", "promotionDes")
  
  function self.promotionDes.onHrefClick(hrefName)
    GameGlobal.UIStateManager():ShowDialog("UISkillHrefInfo", hrefName)
  end
  
  self.showAllBtn = self:GetGameObject("showAllBtn")
  self.breakInfoBtn = self:GetGameObject("breakInfoBtn")
  self.showAllText = self:GetUIComponent("UILocalizationText", "showAllText")
  self.breakInfoText = self:GetUIComponent("UILocalizationText", "breakInfoText")
  self.tabbtn = self:GetGameObject("tabbtn")
  self.tabbtn:SetActive(self._showBreadInfo)
  self.btnInfoObj = self:GetGameObject("BtnInfo")
  self.btnInfoObj:SetActive(self._customData and self._customData:IsShowBtnInfo())
  self._scrollViewGO = self:GetGameObject("scrollView")
  self._attackPoolGO = self:GetGameObject("AttackPool")
  self.jobIcon = self:GetUIComponent("Image", "jobIcon")
  self.jobSrt = self:GetUIComponent("UILocalizationText", "jobSrt")
  self.jobAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  self._prof2Img = {
    [2001] = "spirit_prof_5",
    [2002] = "spirit_prof_1",
    [2003] = "spirit_prof_3",
    [2004] = "spirit_prof_7"
  }
  self._prof2Name = {
    [2001] = "str_pet_tag_job_name_color_change",
    [2002] = "str_pet_tag_job_name_return_blood",
    [2003] = "str_pet_tag_job_name_attack",
    [2004] = "str_pet_tag_job_name_function"
  }
  self._txtDesc:SetText(StringTable.Get("str_tale_pet_txt_convene_desc"))
  if self._showMaxAwake then
    self._scrollViewRect.anchoredPosition = Vector2(self._scrollViewRect.anchoredPosition.x, 0)
  else
    self._scrollViewRect.anchoredPosition = Vector2(self._scrollViewRect.anchoredPosition.x, -23)
  end
  self._restrictionTextGO = self:GetGameObject("restrictionText")
  self._newTalePetInfo = self:GetGameObject("NewTalePetInfo")
  self._talePetName = self:GetUIComponent("UILocalizationText", "talePetName")
  self._talePetIntroDesc = self:GetUIComponent("UILocalizationText", "talePetIntroDesc")
  self._talePetBg = self:GetGameObject("talePetInfo")
  self._heidiceng = self:GetGameObject("heidiceng")
  self:RefreshInfo()
  self:RefreshStar()
  local imageLoader = self:GetUIComponent("RawImageLoader", "BgLoader")
  UICommonHelper:GetInstance():ChangePetTagBackground(self.petId, imageLoader, true)
  if self._showMaxAwake then
    self:InitWorkSkill()
  end
  self:ReBuildScrollView()
  if not self._isActivityShow then
    self:RefreshTalePetPro()
  else
    self._convene:SetActive(false)
    self.infoObj:SetActive(false)
  end
end

function UIShopPetDetailController:ReBuildScrollView()
  local scrollView = self:GetUIComponent("ScrollRect", "scrollView")
  if self._showMaxAwake then
    scrollView.enabled = true
  else
    scrollView.enabled = false
  end
end

function UIShopPetDetailController:RefreshInfo()
  if self._customData then
    local tempData = _G.pet_data:New()
    tempData.template_id = self.petId
    tempData.current_skin = 0
    local pet = Pet:New(tempData)
    tempData.grade = self._customData:GetGrade()
    tempData.level = pet:GetMaxLevel()
    if self._customData:GetCustomLevel() then
      tempData.level = self._customData:GetCustomLevel()
    end
    tempData.awakening = self._customData:GetAwakening()
    tempData.equip_lv = self._customData:GetEquip()
    tempData.affinity_level = pet:GetPetAffinityMaxLevel()
    if self._customData:GetAffinityLevel() then
      tempData.affinity_level = self._customData:GetAffinityLevel()
    end
    tempData.equip_refine_lv = pet:GetEquipRefineMaxLv()
    if self._customData:GetEquipRefineLevel() then
      tempData.equip_refine_lv = self._customData:GetEquipRefineLevel()
    end
    pet:SetData(tempData)
    self.pet = pet
    self._goGradeMax:SetActive(true)
    local awakeSpriteName = UIPetModule.GetAwakeSpriteName(self.petId, self._customData:GetGrade())
    if not string.isnullorempty(awakeSpriteName) then
      self._maxGrade.sprite = self._atlasAwake:GetSprite(awakeSpriteName)
    end
    local titleStr = self._customData:GetDetailTitleText()
    if titleStr then
      self._gradeTex:SetText(StringTable.Get(titleStr))
    end
    self.tabbtn:SetActive(false)
  elseif self._showMaxAwake then
    local tempData = _G.pet_data:New()
    tempData.template_id = self.petId
    tempData.current_skin = 0
    local pet = Pet:New(tempData)
    local maxGrade = pet:GetMaxGrade()
    tempData.grade = maxGrade
    tempData.level = pet:GetMaxLevel()
    tempData.awakening = pet:GetMaxAwakening()
    tempData.equip_lv = ResourceHelper:GetInstance():GetPetEquip():GetMaxLv(pet:GetTemplateID())
    tempData.affinity_level = pet:GetPetAffinityMaxLevel()
    pet:SetData(tempData)
    self.pet = pet
    self._goGradeMax:SetActive(true)
    local awakeSpriteName = UIPetModule.GetAwakeSpriteName(self.petId, maxGrade)
    if not string.isnullorempty(awakeSpriteName) then
      self._maxGrade.sprite = self._atlasAwake:GetSprite(awakeSpriteName)
    end
  else
    local petModule = self:GetModule(PetModule)
    self.pet = petModule:GetPetByTemplateId(self.petId)
    self._goGradeMax:SetActive(false)
  end
  local str = StringTable.Get("str_shop_grade_max_title")
  local gradeMaxValue = self.pet:GetMaxGrade()
  self._gradeTex:SetText(str)
  if self.pet then
    self.spineContainer:SetData(self.pet)
    local petModule = GameGlobal.GetModule(PetModule)
    local uiModule = petModule.uiModule
    local skillDetailInfos = uiModule:GetSkillDetailInfoBySkillTypeHideExtra(self.pet)
    local skillCount = table.count(skillDetailInfos)
    self.skillsPools:SpawnObjects("UIShopPetSkillItem", skillCount)
    self._skillsSpawns = self.skillsPools:GetAllSpawnList()
    if self._skillsSpawns then
      for i = 1, skillCount do
        local item = self._skillsSpawns[i]
        local skill_info = skillDetailInfos[i]
        local skill_list = skill_info.skillList
        item:Flush(i, self.pet, skill_list)
      end
      self.skillItemTask = self:StartTask(self.SkillItemAni, self)
    end
  end
  local itemIcon = self.pet:GetPetItemIcon(PetSkinEffectPath.NO_EFFECT)
  self.uiItem:SetData({
    icon = itemIcon,
    itemId = self.pet:GetTemplateID()
  })
  self:ShowElement()
  self:ShowName()
  self:RefreshAtt()
  self:RefreshBreakInfo()
end

function UIShopPetDetailController:ShowElement()
  local cfg_pet_element = Cfg.cfg_pet_element({})
  local elementTex = ""
  if cfg_pet_element then
    local f = self.pet:GetPetFirstElement()
    local s = self.pet:GetPetSecondElement()
    local job = self.pet:GetJob()
    self.jobIcon.sprite = self.jobAtlas:GetSprite(self._prof2Img[job])
    self.jobSrt:SetText(StringTable.Get(self._prof2Name[job]))
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

function UIShopPetDetailController:RefreshAtt()
  local attackValue, defenceValue, healthValue
  if self._customData then
    attackValue = self._customData:GetAttacke()
    defenceValue = self._customData:GetDef()
    healthValue = self._customData:GetHP()
  else
    attackValue = self.pet:GetPetAttack()
    defenceValue = self.pet:GetPetDefence()
    healthValue = self.pet:GetPetHealth()
  end
  self._attackText:SetText(attackValue)
  self._defenceText:SetText(defenceValue)
  self._healthText:SetText(healthValue)
end

function UIShopPetDetailController:CheckStringLen(nameEn)
  self._englishNameText:SetText(nameEn)
  local scale = GameObjectHelper.GetTextScale(self._englishNameText, nameEn, 437)
  self._englishNameText:GetComponent("Transform").localScale = Vector3(scale, 1, 1)
end

function UIShopPetDetailController:ShowName()
  local name = self.pet:GetPetName()
  self._nameText:SetText(StringTable.Get(name))
  local nameEn = StringTable.Get(self.pet:GetPetEnglishName())
  self:CheckStringLen(nameEn)
end

function UIShopPetDetailController:RefreshStar()
  local petStar = self.pet:GetPetStar()
  for starLevel = 1, self._maxStarLevel do
    local _itemIcon = self:GetUIComponent("Image", "star" .. starLevel)
    local starGo = self:GetGameObject("star" .. starLevel)
    if starLevel <= petStar then
      starGo:SetActive(true)
    else
      starGo:SetActive(false)
    end
  end
end

function UIShopPetDetailController:InitWorkSkill()
  self._skillState = {}
  self._grade = self.pet:GetPetGrade()
  local tab = self.pet:PetGradeNewSkill()
  for i = 1, table.count(tab) do
    self._skillState[i] = {}
    self._skillState[i].ID = tab[i].NewSkill
    self._skillState[i].grade = tab[i].Grade
    self._skillState[i].isLock = false
  end
  self._workSkillPool = self:GetUIComponent("UISelectObjectPath", "workskills")
  local _skillState = self._skillState
  local skillCount = table.count(_skillState)
  self._workSkillPool:SpawnObjects("UIShopPetWorkSkill", skillCount)
  self._workSkillSpawns = self._workSkillPool:GetAllSpawnList()
  for i = 1, skillCount do
    local cfg_work_skill = Cfg.cfg_work_skill[_skillState[i].ID]
    self._workSkillSpawns[i]:SetData(i, _skillState[i], cfg_work_skill and cfg_work_skill.RoomType or 1)
  end
end

function UIShopPetDetailController:OnHide()
  self:_DetachEvents()
  if self.skillItemTask then
    GameGlobal.TaskManager():KillTask(self.skillItemTask)
    self.skillItemTask = nil
  end
  if self.SelectPetEffTask then
    GameGlobal.TaskManager():KillTask(self.SelectPetEffTask)
    self.SelectPetEffTask = nil
  end
  if self.breakInfoLua then
    self.breakInfoLua:Dispose()
  end
end

function UIShopPetDetailController.OnClickBack()
  GameGlobal.UIStateManager():CloseDialog("UIShopPetDetailController")
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TalePetDetailReturnList)
end

function UIShopPetDetailController:RefreshTalePetPro()
  self.talePetModule = GameGlobal.GetModule(TalePetModule)
  local info = self.talePetModule:GetPetInfo(self.petId)
  self._noRestriction = not self.talePetModule:HaveCallRestriction(self.petId)
  self._restrictionIsUnlock = self.talePetModule:RestrictionIsUnlock(self.petId)
  self:_RefreshTalePetInfo()
  self:RectChange()
  self:RefreshByInfo(info)
  self:SelectRedController()
  local cfg = Cfg.cfg_pet({
    ID = self.petId
  })[1]
  self.infoObj:SetActive(true)
  self.txtInfo:SetText(StringTable.Get(cfg.Desc))
  local cg = HelperProxy:GetInstance():GetPetStaticBody(self.petId, 0, 0, PetSkinEffectPath.NO_EFFECT)
  self.shadow:LoadImage(cg)
end

function UIShopPetDetailController:_RefreshTalePetInfo()
  self.tabbtn:SetActive(self._noRestriction and self._showBreadInfo)
  self.leftDown:SetActive(self._noRestriction)
  self._scrollViewGO:SetActive(self._noRestriction)
  self._restrictionTextGO:SetActive(not self._restrictionIsUnlock)
  self._newTalePetInfo:SetActive(not self._noRestriction)
  self._talePetBg:SetActive(not self._noRestriction)
  self._heidiceng:SetActive(self._noRestriction)
  if not self._noRestriction then
    local cfg = Cfg.cfg_pet[self.petId]
    self._talePetName:SetText(StringTable.Get(cfg.Name))
    self._talePetIntroDesc:SetText(StringTable.Get(cfg.Desc))
  end
end

function UIShopPetDetailController:RectChange()
  local height = self._conveneRect.sizeDelta.y
  self._scrollViewRect.sizeDelta = Vector2(self._scrollViewRect.sizeDelta.x, self._scrollViewRect.sizeDelta.y - height)
  self._scrollViewRect.anchoredPosition = Vector2(self._scrollViewRect.anchoredPosition.x, self._scrollViewRect.anchoredPosition.y + height / 2)
  self._convene:SetActive(self._restrictionIsUnlock)
end

function UIShopPetDetailController:RefreshByInfo(info)
  self.btnStateObj:SetActive(true)
  self.convening:SetActive(false)
  if info == nil then
    self._txtState:SetText(StringTable.Get("str_tale_pet__btn_select"))
    self._btnState.interactable = true
    self._txtCurPro:SetText(0)
    local totalPro = self.talePetModule:GetTaskPhase(self.petId)
    self._txtTotalPro:SetText(totalPro)
    self._txtDesc:SetText(StringTable.Get("str_tale_pet_txt_convene_desc") .. "<color=#ffffff>" .. "0/" .. totalPro .. "</color>")
    return
  end
  local state = info.pet_status
  local id = self.talePetModule:SelectPetCfgId()
  if state == TalePetCallType.TPCT_Doing then
    self._txtState:SetText(StringTable.Get("str_tale_pet_btn_convening"))
    self._btnState.interactable = false
    self.btnStateObj:SetActive(false)
    self.convening:SetActive(true)
  elseif state == TalePetCallType.TPCT_Done then
    self._txtState:SetText(StringTable.Get("str_tale_pet_btn_view"))
    self._btnState.interactable = true
  else
    self._txtState:SetText(StringTable.Get("str_tale_pet__btn_select"))
    self._btnState.interactable = true
  end
  self._txtCurPro:SetText(info.task_phase)
  local totalPro = self.talePetModule:GetTaskPhase(self.petId)
  self._txtDesc:SetText(StringTable.Get("str_tale_pet_txt_convene_desc") .. "<color=#ffffff>" .. info.task_phase .. "/" .. totalPro .. "</color>")
  self._txtTotalPro:SetText(totalPro)
  if state == TalePetCallType.TPCT_Can_Do or state == TalePetCallType.TPCT_Done then
    self._txtCurPro:SetText(totalPro)
    self._txtTotalPro:SetText(totalPro)
    self._txtDesc:SetText(StringTable.Get("str_tale_pet_txt_convene_desc") .. "<color=#ffffff>" .. totalPro .. "/" .. totalPro .. "</color>")
  end
end

function UIShopPetDetailController:btnStateOnClick()
  local info = self.talePetModule:GetPetInfo(self.petId)
  local state = self.talePetModule:SelectPetCfgId()
  if state == 0 then
    self.anim:Play("uieff_UIShopPetDetailController_conversion")
    self.effc:SetActive(true)
    self.effShadow:SetActive(true)
    GameGlobal.TaskManager():StartTask(self.SwitchPetCall, self)
  elseif self.petId == state then
    ToastManager.ShowToast(StringTable.Get("str_tale_pet_is_convene"))
    return
  else
    local lastInfo = self.talePetModule:GetPetInfo(state)
    local isSwi = false
    for key, value in pairs(lastInfo.datas) do
      if value.cur ~= 0 then
        isSwi = true
      end
    end
    if isSwi then
      self:ShowSwitchTips(state, function()
        self.anim:Play("uieff_UIShopPetDetailController_conversion")
        self.effc:SetActive(true)
        self.effShadow:SetActive(true)
        GameGlobal.TaskManager():StartTask(self.SwitchPetCall, self)
      end)
    else
      self.anim:Play("uieff_UIShopPetDetailController_conversion")
      self.effc:SetActive(true)
      self.effShadow:SetActive(true)
      GameGlobal.TaskManager():StartTask(self.SwitchPetCall, self)
    end
  end
end

function UIShopPetDetailController:ShowSwitchTips(state, callback)
  local curCfg = Cfg.cfg_pet[state]
  local curName = curCfg.Name
  local curTask = self.talePetModule:GetPetInfo(state).task_phase + 1
  local str = StringTable.Get("str_tale_pet_txt_switch_pet_tips", StringTable.Get(curName), curTask, StringTable.Get(curName), curTask)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", str, function()
    if callback then
      callback()
    end
  end, nil, function()
  end, nil)
end

function UIShopPetDetailController:SelectPetEff(TT)
  local delayTime = 666.6666666666666
  YIELD(TT, delayTime)
  self:SwitchState(UIStateType.UITalePetCollect, self.petId)
end

function UIShopPetDetailController:SwitchPetCall(TT)
  self:Lock("UIShopPetDetailController:SwitchPetCall")
  local res = self.talePetModule:ReqTaleChoose(TT, self.petId)
  if res:GetSucc() then
    local name = Cfg.cfg_pet[self.petId].Name
    ToastManager.ShowToast(StringTable.Get("str_tale_pet_txt_start_convene_pet", StringTable.Get(name)))
    self.SelectPetEffTask = self:StartTask(self.SelectPetEff, self)
  else
    ToastManager.ShowToast(res.m_result)
  end
  self:UnLock("UIShopPetDetailController:SwitchPetCall")
end

function UIShopPetDetailController:_AttachEvents()
  self:AttachEvent(GameEventType.TalePetInfoDataChange, self._SelectTalePetCall)
  self:AttachEvent(GameEventType.OnAwakenSelectPointChange, self.OnAwakenSelectPointChange)
end

function UIShopPetDetailController:_DetachEvents()
  self:DetachEvent(GameEventType.TalePetInfoDataChange)
  self:DetachEvent(GameEventType.OnAwakenSelectPointChange)
end

function UIShopPetDetailController:_SelectTalePetCall()
  local info = self.talePetModule:GetPetInfo()
  self:RefreshByInfo(info)
end

function UIShopPetDetailController:btnHelperOnClick()
  self:ShowDialog("UIHelpController", "UIShopPetDetailController")
end

function UIShopPetDetailController:SelectRedController()
  if self.ID == self.talePetModule:SelectPetCfgId() then
    return
  end
  local state1 = self.talePetModule:IsCanCallPet(self.petId)
  local state2 = self.talePetModule:IsGetReward(self.petId)
  if state1 or state2 then
    self._selectRed:SetActive(true)
  else
    self._selectRed:SetActive(false)
  end
end

function UIShopPetDetailController:SkillItemAni(TT)
  if self._skillsSpawns then
    for index, value in ipairs(self._skillsSpawns) do
      value:ShowInAnim()
      YIELD(TT)
      YIELD(TT)
    end
  end
  if self._workSkillSpawns then
    for index, value in ipairs(self._workSkillSpawns) do
      value:ShowInAnim()
      YIELD(TT)
      YIELD(TT)
    end
  end
end

function UIShopPetDetailController:SkillItemHideAni()
  if self._skillsSpawns then
    for index, value in ipairs(self._skillsSpawns) do
      value:HideAnim()
    end
  end
  if self._workSkillSpawns then
    for index, value in ipairs(self._workSkillSpawns) do
      value:HideAnim()
    end
  end
end

function UIShopPetDetailController:BtnInfoOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIN25VampireTips")
end

function UIShopPetDetailController:RefreshBreakInfo()
  self.attributeCfg = self.pet:GetAwakeningConfig()
  self.levelCfg = self.pet:GetCurrentLevelConfig()
  self.promoteDes = {}
  for i = 1, #self.attributeCfg do
    local des = self:GetBreakData(i)
    self.promoteDes[i] = des
  end
  self.breakInfoLua = UIBreakInfoItem:New()
  self.breakInfoLua:SetView(self._centerView)
  self.breakInfoLua:SetShowBreifDes()
  self.breakInfoLua:OnShowItem()
  self.breakInfoLua:SetData(0, self.pet)
end

function UIShopPetDetailController:GetBreakData(idx)
  local select = self.attributeCfg[idx]
  local attack, attackValue, attackPercent = self:_GetPromoteAttack(idx)
  local defence, defenceValue, defencePercent = self:_GetPromoteDefence(idx)
  local hp, hpValue, hpPercent = self:_GetPromoteHP(idx)
  if 0 < attack or 0 < defence or 0 < hp then
    return self:_GetPromoteDes(idx)
  end
  return StringTable.Get(select.PromoteDes)
end

function UIShopPetDetailController:_GetPromoteDes(idx)
  local attack, attackValue, attackPercent = self:_GetPromoteAttack(idx)
  local defence, defenceValue, defencePercent = self:_GetPromoteDefence(idx)
  local hp, hpValue, hpPercent = self:_GetPromoteHP(idx)
  local temp = {
    {
      value = attackValue,
      percent = attackPercent,
      name = StringTable.Get("str_pet_config_break_att_attack"),
      suffix = StringTable.Get("str_pet_config_break_att_base_attack")
    },
    {
      value = defenceValue,
      percent = defencePercent,
      name = StringTable.Get("str_pet_config_break_att_defense"),
      suffix = StringTable.Get("str_pet_config_break_att_base_defence")
    },
    {
      value = hpValue,
      percent = hpPercent,
      name = StringTable.Get("str_pet_config_break_att_hp"),
      suffix = StringTable.Get("str_pet_config_break_att_base_hp")
    }
  }
  local des = ""
  for _, attribute in ipairs(temp) do
    local text = ""
    local valid = false
    if attribute.value > 0 then
      if attribute.percent > 0 then
        text = StringTable.Get("str_pet_config_break_att_promote_both", attribute.value, attribute.percent, attribute.suffix)
      else
        text = StringTable.Get("str_pet_config_break_att_promote_value", attribute.name, attribute.value)
      end
      valid = true
    elseif attribute.percent > 0 then
      text = StringTable.Get("str_pet_config_break_att_promote_percent", attribute.percent, attribute.suffix)
      valid = true
    end
    if valid then
      des = des .. text .. "\n"
    end
  end
  return des
end

function UIShopPetDetailController:_GetPromoteAttack(level)
  local total, value, percent = 0
  local cfg = self.attributeCfg[level]
  if 1 < level then
    value = cfg.Attack - self.attributeCfg[level - 1].Attack
    percent = cfg.AttackPercent - self.attributeCfg[level - 1].AttackPercent
  else
    value = cfg.Attack
    percent = cfg.AttackPercent
  end
  value = math.floor(value)
  local percentValue = 0
  if 0 < percent then
    percentValue = math.floor(self.levelCfg.Attack * percent / 100)
  end
  total = value + percentValue
  return total, value, percent
end

function UIShopPetDetailController:_GetPromoteDefence(level)
  local total, value, percent = 0
  local cfg = self.attributeCfg[level]
  if 1 < level then
    value = cfg.Defence - self.attributeCfg[level - 1].Defence
    percent = cfg.DefencePercent - self.attributeCfg[level - 1].DefencePercent
  else
    value = cfg.Defence
    percent = cfg.DefencePercent
  end
  value = math.floor(value)
  local percentValue = 0
  if 0 < percent then
    percentValue = math.floor(self.levelCfg.Defence * percent / 100)
  end
  total = value + percentValue
  return total, value, percent
end

function UIShopPetDetailController:_GetPromoteHP(level)
  local total, value, percent = 0
  local cfg = self.attributeCfg[level]
  if 1 < level then
    value = cfg.Health - self.attributeCfg[level - 1].Health
    percent = cfg.HealthPercent - self.attributeCfg[level - 1].HealthPercent
  else
    value = cfg.Health
    percent = cfg.HealthPercent
  end
  value = math.floor(value)
  local percentValue = 0
  if 0 < percent then
    percentValue = math.floor(self.levelCfg.Health * percent / 100)
  end
  total = value + percentValue
  return total, value, percent
end

function UIShopPetDetailController:ShowAllBtnOnClick()
  UIWidgetHelper.PlayAnimation(self, "Anim", "uieff_UIShopPetDetailController_switch_02", 533)
  self.skillItemTask = self:StartTask(self.SkillItemAni, self)
  self.showAllBtn:SetActive(false)
  self.breakInfoBtn:SetActive(true)
  self.showAllText.color = Color(0, 0, 0, 1)
  self.breakInfoText.color = Color(0.5176470588235295, 0.5176470588235295, 0.5176470588235295, 1)
end

function UIShopPetDetailController:OnAwakenSelectPointChange(idx, selectIdx)
  self.promotionDes:SetText(self.promoteDes[selectIdx])
end

function UIShopPetDetailController:BreakInfoBtnOnClick()
  UIWidgetHelper.PlayAnimation(self, "Anim", "uieff_UIShopPetDetailController_switch_01", 533)
  self:SkillItemHideAni()
  self.showAllBtn:SetActive(true)
  self.breakInfoBtn:SetActive(false)
  self.showAllText.color = Color(0.5176470588235295, 0.5176470588235295, 0.5176470588235295, 1)
  self.breakInfoText.color = Color(0, 0, 0, 1)
end

function UIShopPetDetailController.ShowCustomPetDetail(customPetData)
  GameGlobal.UIStateManager():ShowDialog("UIShopPetDetailController", customPetData:GetPetId(), 0, 0, 0, customPetData)
end
