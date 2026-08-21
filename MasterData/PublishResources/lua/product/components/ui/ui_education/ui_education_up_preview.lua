_class("UIEducationUpPreview", UIController)
UIEducationUpPreview = UIEducationUpPreview

function UIEducationUpPreview:Constructor()
end

function UIEducationUpPreview:LoadDataOnEnter(TT, res, uiParams)
  self._btnParent = uiParams[1]
  self._element = uiParams[2]
end

function UIEducationUpPreview:OnShow(uiParams)
  self:UIWidget()
  self._btnParent:SetActive(false)
  self:Flush()
  self:FlushHeight()
end

function UIEducationUpPreview:OnHide()
end

function UIEducationUpPreview:BtnAnywhereOnClick(go)
  self._btnParent:SetActive(true)
  self:CloseDialog()
end

function UIEducationUpPreview:BtnCloseOnClick(go)
  self._btnParent:SetActive(true)
  self:CloseDialog()
end

function UIEducationUpPreview:UIWidget()
  self._uiUpgrade = self:GetUIComponent("RectTransform", "uiUpgrade")
  self._stageCur = self:GetUIComponent("UILocalizationText", "stageCur")
  self._stageNxt = self:GetUIComponent("UILocalizationText", "stageNxt")
  self._txtUpgrade = self:GetUIComponent("UILocalizationText", "txtUpgrade")
  self._txtUpgrade2 = self:GetUIComponent("UILocalizationText", "txtUpgrade2")
  self._svUpgrade2 = self:GetUIComponent("RectTransform", "svUpgrade2")
  self._levelCur = self:GetUIComponent("UILocalizationText", "levelCur")
  self._levelNxt = self:GetUIComponent("UILocalizationText", "levelNxt")
  self._conditions = {
    self:GetUIComponent("UILocalizationText", "txtCondition1"),
    self:GetUIComponent("UILocalizationText", "txtCondition2"),
    self:GetUIComponent("UILocalizationText", "txtCondition3")
  }
end

function UIEducationUpPreview:Flush()
  local currentStage = self._element:GetCurrentStage()
  self._stageCur:SetText(StringTable.Get("str_education_stage_name", currentStage))
  self._stageNxt:SetText(StringTable.Get("str_education_stage_name", currentStage + 1))
  local curDataLevel = self._element:GetCurrentDataLevel()
  local nxtDataLevel = curDataLevel
  local luaIndex = self._element:GetCurrentLuaIndex()
  local levelCount = self._element:GetDataLevelCount()
  for i = luaIndex + 1, levelCount do
    local dataLevel = self._element:GetDataLevel(i)
    if currentStage < dataLevel:GetStage() then
      nxtDataLevel = dataLevel
      break
    end
  end
  local nxtPropertyRestraint = nxtDataLevel:GetCfg().PropertyRestraint
  local curPropertyRestraint = curDataLevel:GetCfg().PropertyRestraint
  local nxtMainSkillDamage = nxtDataLevel:GetCfg().MainSkillDamage
  local curMainSkillDamage = curDataLevel:GetCfg().MainSkillDamage
  self._levelCur.gameObject:SetActive(false)
  self._levelNxt.gameObject:SetActive(false)
  self._txtUpgrade.gameObject:SetActive(false)
  self._svUpgrade2.gameObject:SetActive(false)
  if 0 < nxtPropertyRestraint - curPropertyRestraint then
    self._levelCur.gameObject:SetActive(true)
    self._levelNxt.gameObject:SetActive(true)
    self._txtUpgrade.gameObject:SetActive(true)
    self._txtUpgrade:SetText(StringTable.Get("str_education_preview_restrain", self._element:GetElementName()))
    self._levelCur:SetText(string.format("+%.1f%%", curPropertyRestraint))
    self._levelNxt:SetText(string.format("+%.1f%%", nxtPropertyRestraint))
  elseif 0 < nxtMainSkillDamage - curMainSkillDamage then
    self._levelCur.gameObject:SetActive(true)
    self._levelNxt.gameObject:SetActive(true)
    self._txtUpgrade.gameObject:SetActive(true)
    self._txtUpgrade:SetText(StringTable.Get("str_education_preview_positive_skill", self._element:GetElementName()))
    self._levelCur:SetText(string.format("+%.1f%%", curMainSkillDamage))
    self._levelNxt:SetText(string.format("+%.1f%%", nxtMainSkillDamage))
  else
    self._svUpgrade2.gameObject:SetActive(true)
    self._txtUpgrade2:SetText(StringTable.Get("str_education_up_cell_rate", self._element:GetElementName()))
  end
  self:FlushCondition(self._conditions, nxtDataLevel)
end

function UIEducationUpPreview:FlushCondition(conditions, dataLevel, hideMetCondition, inClrMet, inClrUnmet)
  local clrMet = Color(1.0, 0.7411764705882353, 0.12549019607843137, 1)
  local clrUnmet = Color(1.0, 1.0, 1.0, 1)
  if inClrMet ~= nil then
    clrMet = inClrMet
  end
  if inClrUnmet ~= nil then
    clrUnmet = inClrUnmet
  end
  local lstData = dataLevel:GetCondition()
  for k, v in pairs(conditions) do
    local data = lstData[k]
    if data == nil then
      v.gameObject:SetActive(false)
    elseif hideMetCondition and data:IsMet() then
      v.gameObject:SetActive(false)
    else
      v.gameObject:SetActive(true)
      local imgLock = self:GetChildComponent(v, "RectTransform", "imgLock")
      local imgPass = self:GetChildComponent(v, "RectTransform", "imgPass")
      if imgLock ~= nil then
        imgLock.gameObject:SetActive(not data:IsMet())
      end
      if imgPass ~= nil then
        imgPass.gameObject:SetActive(data:IsMet())
      end
      local value
      if data:IsMet() then
        v.color = clrMet
        value = string.format("%d/%d", data:GetCompleted(), data:GetQuantity())
      else
        v.color = clrUnmet
        value = string.format("<color=#F73636>%d</color>/%d", data:GetCompleted(), data:GetQuantity())
      end
      if data:Type() == ConditionType.CT_TowerType then
        local towerType = data:GetTowerType()
        if towerType == ElementType.ElementType_None then
          v:SetText(StringTable.Get("str_education_upstage_condition_tower", data:GetTowerLevel(), value))
        else
          local elementName = UIEducationData:GetPetElementName(towerType)
          v:SetText(StringTable.Get("str_education_upstage_condition_tower2", elementName, data:GetTowerLevel(), value))
        end
      elseif data:Type() == ConditionType.CT_PetGradeY then
        v:SetText(StringTable.Get("str_education_upstage_condition_awaken", data:GetQuantity(), data:GetGradeLevel(), value))
      elseif data:Type() == ConditionType.CT_PetYElementZLevel then
        local elementName = UIEducationData:GetPetElementName(data:GetElementType())
        v:SetText(StringTable.Get("str_education_upstage_condition_grade", data:GetQuantity(), data:GetLimitGrade(), elementName, value))
      end
    end
  end
end

function UIEducationUpPreview:FlushHeight()
  local preferredHeight = 0
  for k, v in pairs(self._conditions) do
    if v.gameObject.activeSelf then
      preferredHeight = preferredHeight + v.preferredHeight
    end
  end
  preferredHeight = math.max(200, preferredHeight + 100)
  self._uiUpgrade.sizeDelta = Vector2(self._uiUpgrade.sizeDelta.x, preferredHeight)
end
