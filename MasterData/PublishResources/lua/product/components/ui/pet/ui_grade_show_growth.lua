_class("UIGradeShowGrowth", UICustomWidget)
UIGradeShowGrowth = UIGradeShowGrowth

function UIGradeShowGrowth:Constructor()
  self._element2Str = {
    [ElementType.ElementType_Blue] = "str_pet_filter_water_element",
    [ElementType.ElementType_Red] = "str_pet_filter_fire_element",
    [ElementType.ElementType_Green] = "str_pet_filter_sen_element",
    [ElementType.ElementType_Yellow] = "str_pet_filter_electricity_element",
    [ElementType.ElementType_AnyNone] = "str_tale_pet_att_none"
  }
  self._petModule = self:GetModule(PetModule)
  self._animPlaying = false
  local frameTime = 16.666666666666668
  self.maxLvTime_start = frameTime * 0
  self.maxLvTime_end = frameTime * 40
  self.maxLvTime_Gaps = self.maxLvTime_end - self.maxLvTime_start
  self.attackTime_start = frameTime * 10
  self.attackTime_end = frameTime * 60
  self.attackTime_Gaps = self.attackTime_end - self.attackTime_start
  self.defenceTime_start = frameTime * 20
  self.defenceTime_end = frameTime * 70
  self.defenceTime_Gaps = self.defenceTime_end - self.defenceTime_start
  self.hpTime_start = frameTime * 30
  self.hpTime_end = frameTime * 80
  self.hpTime_Gaps = self.hpTime_end - self.hpTime_start
  self.accTime = 0
  self:AttachEvent(GameEventType.OnPetUpGradeThird, self.PlayTexAnim)
end

function UIGradeShowGrowth:OnHide()
  self:DetachEvent(GameEventType.OnPetUpGradeThird, self.PlayTexAnim)
end

function UIGradeShowGrowth:SetData(pet, skillVaryInfos, lastMaxLv, lastAtk, lastDef, lastHp)
  self._petInfo = pet
  self.lastMaxLv = lastMaxLv
  self.lastAtk = lastAtk
  self.lastDef = lastDef
  self.lastHp = lastHp
  self._skillVaryInfos = skillVaryInfos
  local uiModule = self._petModule.uiModule
  self._skillVaryInfos = uiModule:RemoveNotShowSkill(self._petInfo:GetTemplateID(), self._petInfo:GetPetGrade(), self._petInfo:GetPetAwakening(), self._skillVaryInfos)
  self:GetComponents()
  self:OnValue()
end

function UIGradeShowGrowth:GetComponents(uiParams)
  self._atlasAwake = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._gradePrev = self:GetUIComponent("Image", "gradePrev")
  self._gradeCurr = self:GetUIComponent("Image", "gradeCurr")
  self._gradeCurrGlow = self:GetUIComponent("Image", "gradeCurrGlow")
  self._varyPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._firstIcon = self:GetUIComponent("Image", "firstIcon")
  self._secondIcon = self:GetUIComponent("Image", "secondIcon")
  self._firstGo = self:GetGameObject("firstGo")
  self._secondGo = self:GetGameObject("secondGo")
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._lvTex = self:GetUIComponent("UILocalizationText", "lvTex")
  self._lvTex2 = self:GetUIComponent("UILocalizationText", "lvTex2")
  self._atkTex = self:GetUIComponent("UILocalizationText", "atkValue")
  self._defTex = self:GetUIComponent("UILocalizationText", "defValue")
  self._hpTex = self:GetUIComponent("UILocalizationText", "hpValue")
  self._elementTex = self:GetUIComponent("UILocalizationText", "elementTex")
  self._atkArrow = self:GetGameObject("arrow_atk")
  self._defArrow = self:GetGameObject("arrow_def")
  self._hpArrow = self:GetGameObject("arrow_hp")
  self._onlyUnLockEquip = self:GetGameObject("onlyUnLock")
  self._equip = self:GetGameObject("equip")
  self._elem = self:GetGameObject("elem")
  self._gradeAnim = self:GetUIComponent("Animation", "rect")
  self._lizi = self:GetGameObject("lizi")
  self._unLockSecondElemOrEquipTips = self:GetUIComponent("UILocalizationText", "unLockTips")
  self._unLockSecondElemOrEquipTipsGo = self:GetGameObject("GradeSecondElemOrEquipTips")
end

function UIGradeShowGrowth:OnValue()
  self:ShowGrade()
  self._lvTex2:SetText(self.lastMaxLv)
  self.nowMaxLv = self._petInfo:GetMaxLevel()
  local atk = self._petInfo:GetPetAttack()
  local def = self._petInfo:GetPetDefence()
  local hp = self._petInfo:GetPetHealth()
  self._atkTex:SetText(self.lastAtk)
  self.nowAtk = atk
  self._defTex:SetText(self.lastDef)
  self.nowDef = def
  self._hpTex:SetText(self.lastHp)
  self.nowHp = hp
  self:ShowLv()
  self:ShowElement()
  self:ShowVarySkill()
  self:ShowAtt()
end

function UIGradeShowGrowth:PlayTexAnim()
  self._animPlaying = true
  self._gradeAnim:Play()
  self._lizi:SetActive(false)
  self._lizi:SetActive(true)
end

function UIGradeShowGrowth:OnUpdate(deltaTimeMS)
  if self._animPlaying then
    self.accTime = self.accTime + deltaTimeMS
    local percent_lv = (self.accTime - self.maxLvTime_start) / self.maxLvTime_Gaps
    if self.accTime >= self.maxLvTime_end then
      percent_lv = 1
    end
    if percent_lv <= 1 and 0 <= percent_lv then
      local lvRec = DG.Tweening.DOVirtual.EasedValue(self.lastMaxLv, self.nowMaxLv, percent_lv, DG.Tweening.Ease.OutQuad)
      self._lvTex2:SetText(math.floor(lvRec))
    end
    local percent_atk = (self.accTime - self.attackTime_start) / self.attackTime_Gaps
    if self.accTime >= self.attackTime_end then
      percent_atk = 1
    end
    if percent_atk <= 1 and 0 <= percent_atk then
      local atkRec = DG.Tweening.DOVirtual.EasedValue(self.lastAtk, self.nowAtk, percent_atk, DG.Tweening.Ease.OutQuad)
      self._atkTex:SetText(math.floor(atkRec))
    end
    local percent_def = (self.accTime - self.defenceTime_start) / self.defenceTime_Gaps
    if self.accTime >= self.defenceTime_end then
      percent_def = 1
    end
    if percent_def <= 1 or 0 <= percent_def then
      local defRec = DG.Tweening.DOVirtual.EasedValue(self.lastDef, self.nowDef, percent_def, DG.Tweening.Ease.OutQuad)
      self._defTex:SetText(math.floor(defRec))
    end
    local percent_hp = (self.accTime - self.hpTime_start) / self.hpTime_Gaps
    if self.accTime >= self.hpTime_end then
      percent_hp = 1
    end
    if percent_hp <= 1 or 0 <= percent_hp then
      local hpRec = DG.Tweening.DOVirtual.EasedValue(self.lastHp, self.nowHp, percent_hp, DG.Tweening.Ease.OutQuad)
      self._hpTex:SetText(math.floor(hpRec))
    end
    if self.accTime >= self.hpTime_end then
      self._animPlaying = false
    end
  end
end

function UIGradeShowGrowth:ShowLv()
  self._lvTex:SetText("Lv." .. self._petInfo:GetPetLevel() .. "/")
end

function UIGradeShowGrowth:ShowAtt()
  local atk = self._petInfo:GetPetAttack()
  local def = self._petInfo:GetPetDefence()
  local hp = self._petInfo:GetPetHealth()
  self._atkArrow:SetActive(atk > self.lastAtk)
  self._atkArrow:SetActive(def > self.lastDef)
  self._atkArrow:SetActive(hp > self.lastHp)
end

function UIGradeShowGrowth:ShowGrade()
  local petId = self._petInfo:GetTemplateID()
  local gradeCurr = self._petInfo:GetPetGrade()
  local gradePrev = gradeCurr - 1
  self._gradePrev.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(petId, gradePrev))
  self._gradeCurr.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(petId, gradeCurr))
  self._gradeCurrGlow.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteGlowName(petId, gradeCurr))
end

function UIGradeShowGrowth:ShowElement()
  local cfg_pet_element = Cfg.cfg_pet_element({})
  local f = self._petInfo:GetPetFirstElement()
  self._firstIcon.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[f].Icon))
  local str
  local s = self._petInfo:GetPetSecondElement()
  if s == nil or s == 0 then
    self._secondGo.gameObject:SetActive(false)
    str = StringTable.Get(self._element2Str[f])
  else
    self._secondGo.gameObject:SetActive(true)
    self._secondIcon.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[s].Icon))
    str = StringTable.Get("str_pet_detail_element_" .. f) .. "  " .. StringTable.Get("str_pet_detail_element_" .. s)
  end
  self._elementTex:SetText(str)
end

function UIGradeShowGrowth:ShowVarySkill()
  if self._skillVaryInfos then
    self._listDetailTotalRow = table.count(self._skillVaryInfos)
    local show = true
    local unLockEquip = false
    local unLockElem = false
    local unLockExtra = false
    if self._listDetailTotalRow > 0 then
      self._varyPool:SpawnObjects("UIGradeDetailItem", self._listDetailTotalRow)
      local rowList = self._varyPool:GetAllSpawnList()
      for i = 1, #rowList do
        local skillInfo = self._skillVaryInfos[i]
        if not unLockEquip and skillInfo.type == "passive" then
          local state = skillInfo.changeType
          if state == PetSkillChangeState.NewGain then
            unLockEquip = true
          end
        end
        if not unLockExtra and skillInfo.type == "extra" then
          local state = skillInfo.changeType
          if state == PetSkillChangeState.NewGain then
            unLockExtra = true
          end
        end
        local lastGrade = self._petInfo:GetPetGrade() - 1
        if lastGrade < 0 then
          lastGrade = 0
        end
        local nextGrade = self._petInfo:GetPetGrade()
        local _break = self._petInfo:GetPetAwakening()
        rowList[i]:SetData(self._petInfo, skillInfo, i, self._listDetailTotalRow, lastGrade, nextGrade, _break, _break)
      end
    end
    self._equip:SetActive(unLockEquip)
    if unLockEquip then
      if not self._refineItem then
        local refineItemPool = self:GetUIComponent("UISelectObjectPath", "equipInfo")
        self._refineItem = refineItemPool:SpawnObject("UIPetEquipLvIcon")
      end
      self._refineItem:SetData(self._petInfo)
    end
    if self._listDetailTotalRow > 0 then
      if self._listDetailTotalRow <= 1 then
        local state = self._skillVaryInfos[1].changeType
        if state == PetSkillChangeState.Improved then
          show = false
        end
      else
        show = false
      end
    end
    self._onlyUnLockEquip:SetActive(show)
    local petid = self._petInfo:GetTemplateID()
    local cfg_pet = Cfg.cfg_pet[petid]
    if cfg_pet then
      local grade = self._petInfo:GetPetGrade()
      if cfg_pet.Element2NeedGrade and grade == cfg_pet.Element2NeedGrade and 0 < cfg_pet.SecondElement then
        unLockElem = true
      end
    end
    self._elem:SetActive(unLockElem)
    if unLockElem or unLockEquip then
      self._unLockSecondElemOrEquipTipsGo:SetActive(true)
    else
      self._unLockSecondElemOrEquipTipsGo:SetActive(false)
    end
    if unLockElem then
      self._unLockSecondElemOrEquipTips:SetText(StringTable.Get("str_pet_config_second_element"))
    end
    if unLockEquip then
      self._unLockSecondElemOrEquipTips:SetText(StringTable.Get("str_pet_config_unlock_equip"))
    end
    if unLockExtra then
      self._unLockSecondElemOrEquipTips:SetText(StringTable.Get("str_pet_config_unlock_active_skill"))
    end
  end
end
