_class("UIEducationOneElement", UICustomWidget)
UIEducationOneElement = UIEducationOneElement

function UIEducationOneElement:Constructor()
  self._padding = {
    l = 10,
    r = 10,
    t = 0,
    b = 15
  }
end

function UIEducationOneElement:OnShow(uiParams)
  self:UIWidget()
end

function UIEducationOneElement:OnHide()
end

function UIEducationOneElement:UIWidget()
  self._uiLayout = self:GetGameObject():GetComponent("LayoutElement")
  self._uiStage = self:GetUIComponent("UIView", "uiStage")
  self._uiUpgrade = self:GetUIComponent("UIView", "uiUpgrade")
  self._uiCondition = self:GetUIComponent("UIView", "uiCondition")
  self._uiFailTips = self:GetUIComponent("UIView", "uiFailTips")
  self._animation = self:GetUIComponent("Animation", "animation")
  local uiStage = {
    root = self._uiStage,
    petElement = self._uiStage:GetUIComponent("Image", "petElement"),
    elementName = self._uiStage:GetUIComponent("UILocalizationText", "elementName"),
    upgrade = self._uiStage:GetUIComponent("RectTransform", "upgrade"),
    stageCur = self._uiStage:GetUIComponent("UILocalizationText", "stageCur"),
    stageNxt = self._uiStage:GetUIComponent("UILocalizationText", "stageNxt"),
    levelCur = self._uiStage:GetUIComponent("UILocalizationText", "levelCur"),
    levelNxt = self._uiStage:GetUIComponent("UILocalizationText", "levelNxt")
  }
  local uiUpgrade = {
    root = self._uiUpgrade,
    imgAttack = self._uiUpgrade:GetUIComponent("Image", "imgAttack"),
    valueAttack = self._uiUpgrade:GetUIComponent("UILocalizationText", "valueAttack"),
    valueDefence = self._uiUpgrade:GetUIComponent("UILocalizationText", "valueDefence"),
    valueHealth = self._uiUpgrade:GetUIComponent("UILocalizationText", "valueHealth"),
    descLayout = self._uiUpgrade:GetUIComponent("VerticalLayoutGroup", "desc"),
    txtRestrain = self._uiUpgrade:GetUIComponent("UILocalizationText", "txtRestrain"),
    txtPositiveSkill = self._uiUpgrade:GetUIComponent("UILocalizationText", "txtPositiveSkill"),
    txtCellRate = self._uiUpgrade:GetUIComponent("UILocalizationText", "txtCellRate")
  }
  local uiCondition = {
    root = self._uiCondition,
    txtTitle = self._uiCondition:GetUIComponent("UILocalizationText", "txtTitle"),
    conditions = {
      self._uiCondition:GetUIComponent("UILocalizationText", "txtCondition1"),
      self._uiCondition:GetUIComponent("UILocalizationText", "txtCondition2"),
      self._uiCondition:GetUIComponent("UILocalizationText", "txtCondition3")
    }
  }
  local uiFailTips = {
    root = self._uiFailTips,
    txtTitle = self._uiFailTips:GetUIComponent("UILocalizationText", "txtTitle")
  }
  self._uiStage = uiStage
  self._uiUpgrade = uiUpgrade
  self._uiCondition = uiCondition
  self._uiFailTips = uiFailTips
end

function UIEducationOneElement:SetData(element, atlasProperty)
  self._element = element
  self._atlasProperty = atlasProperty
end

function UIEducationOneElement:Flush(result)
  self._result = result
  self:FlushStage()
  self:FlushUpgrade()
  self:FlushCondition()
  self:FlushFailTips()
  self._preferredHeight = nil
  self:PreferredHeight()
end

function UIEducationOneElement:GetElementSpriteName()
  if self._nameElementSprite == nil then
    UIEducationOneElement._nameElementSprite = {
      [ElementType.ElementType_Blue] = "enlighten_zjm_bingbig",
      [ElementType.ElementType_Red] = "enlighten_zjm_huobig",
      [ElementType.ElementType_Green] = "enlighten_zjm_senbig",
      [ElementType.ElementType_Yellow] = "enlighten_zjm_leibig"
    }
  end
  return self._nameElementSprite[self._element:ElementType()]
end

function UIEducationOneElement:FlushStage()
  self._uiStage.petElement.sprite = self._atlasProperty:GetSprite(self:GetElementSpriteName())
  self._uiStage.elementName:SetText(self._element:GetName())
  local posElementName = Vector2.zero
  local stageCur, stageNxt, levelCur, levelNxt
  local cur = self._element:GetCurrentLuaIndex()
  local nxt = self._result:GetIndex()
  if cur == nxt then
    posElementName = Vector2(82, 0)
  else
    posElementName = Vector2(82, 53)
    local cur = self._element:GetCurrent()
    local nxt = self._result
    local curMax = self._element:GetCurrentMaxLevel()
    local nxtMax = self._element:GetStageMaxLevel(nxt:GetStage())
    stageCur = StringTable.Get("str_education_stage_name", cur:GetStage())
    stageNxt = StringTable.Get("str_education_stage_name", nxt:GetStage())
    levelCur = string.format("Lv.%d", cur:GetLevel(), curMax)
    levelNxt = string.format("Lv.%d", nxt:GetLevel(), nxtMax)
  end
  self._uiStage.elementName.transform.anchoredPosition = posElementName
  self._uiStage.upgrade.gameObject:SetActive(cur ~= nxt)
  self._uiStage.stageCur:SetText(stageCur and stageCur or "")
  self._uiStage.stageNxt:SetText(stageNxt and stageNxt or "")
  self._uiStage.levelCur:SetText(levelCur and levelCur or "")
  self._uiStage.levelNxt:SetText(levelNxt and levelNxt or "")
end

function UIEducationOneElement:FlushUpgrade()
  local cur = self._element:GetCurrentLuaIndex()
  local nxt = self._result:GetIndex()
  local isVisible = false
  if cur == nxt then
    isVisible = false
  else
    isVisible = true
    local nxtLevel = self._element:GetDataLevel(nxt)
    self._uiUpgrade.valueAttack:SetText(string.format("+%d", nxtLevel:GetCfg().Attack))
    self._uiUpgrade.valueDefence:SetText(string.format("+%d", nxtLevel:GetCfg().Defence))
    self._uiUpgrade.valueHealth:SetText(string.format("+%d", nxtLevel:GetCfg().Health))
    local propertyFormat = "<color=#46CC5A>+%.1f%%%%</color>"
    local propertyRestraint = nxtLevel:GetCfg().PropertyRestraint
    local propertyStr = string.format(propertyFormat, propertyRestraint)
    self._uiUpgrade.txtRestrain.gameObject:SetActive(propertyRestraint ~= 0)
    self._uiUpgrade.txtRestrain:SetText(StringTable.Get("str_education_up_restrain", self._element:GetElementName(), propertyStr))
    local mainSkillDamage = nxtLevel:GetCfg().MainSkillDamage
    local propertyStr = string.format(propertyFormat, mainSkillDamage)
    self._uiUpgrade.txtPositiveSkill.gameObject:SetActive(mainSkillDamage ~= 0)
    self._uiUpgrade.txtPositiveSkill:SetText(StringTable.Get("str_education_up_positive_skill", self._element:GetElementName(), propertyStr))
    local dataLevel = self._element:GetCurrentDataLevel()
    local curWeight = dataLevel:GetCfg().SupplyPieceWeight
    local nxtWeight = nxtLevel:GetCfg().SupplyPieceWeight
    local supplyPieceWeightChanged = self._element:IsSupplyPieceWeightChanged(curWeight, nxtWeight)
    self._uiUpgrade.txtCellRate.gameObject:SetActive(supplyPieceWeightChanged)
    self._uiUpgrade.txtCellRate:SetText(StringTable.Get("str_education_up_cell_rate", self._element:GetElementName(), propertyStr))
  end
  self._uiUpgrade.root.gameObject:SetActive(isVisible)
end

function UIEducationOneElement:FlushCondition()
  local cur = self._element:GetCurrentLuaIndex()
  local nxt = self._result:GetIndex()
  local isVisible = false
  if cur ~= nxt then
    isVisible = false
  elseif self._result:GetReason() == UIEducationDataEnum.Reason_Condition then
    isVisible = true
    local dataLevel = self._element:GetCurrentDataLevel()
    local nxtDataLevel = dataLevel
    local currentStage = self._element:GetCurrentStage()
    local levelCount = self._element:GetDataLevelCount()
    for i = cur + 1, levelCount do
      local dataLevel = self._element:GetDataLevel(i)
      if currentStage < dataLevel:GetStage() then
        nxtDataLevel = dataLevel
        break
      end
    end
    local clrUnmet = Color(0.2980392156862745, 0.29411764705882354, 0.29411764705882354, 1)
    UIEducationUpPreview:FlushCondition(self._uiCondition.conditions, nxtDataLevel, true, nil, clrUnmet)
  end
  self._uiCondition.root.gameObject:SetActive(isVisible)
end

function UIEducationOneElement:FlushConditionEx(conditions, dataLevel)
  local dicCondition = dataLevel:GetCondition()
  local towerData = dicCondition[ConditionType.CT_TowerType]
  local gradeData = dicCondition[ConditionType.CT_PetGradeY]
  if towerData == nil then
    conditionTower.gameObject:SetActive(false)
  else
    local value = string.format("%d/%d", towerData:GetCompleted(), towerData:GetQuantity())
    conditionTower.gameObject:SetActive(true)
    local towerType = towerData:GetTowerType()
    if towerType == ElementType.ElementType_None then
      conditionTower:SetText(StringTable.Get("str_education_upstage_condition_tower", towerData:GetTowerLevel(), value))
    else
      local elementName = UIEducationData:GetPetElementName(towerType)
      conditionTower:SetText(StringTable.Get("str_education_upstage_condition_tower2", elementName, towerData:GetTowerLevel(), value))
    end
  end
  if gradeData == nil then
    conditionAwaken.gameObject:SetActive(false)
  else
    local value = string.format("%d/%d", gradeData:GetCompleted(), gradeData:GetQuantity())
    conditionAwaken.gameObject:SetActive(true)
    conditionAwaken:SetText(StringTable.Get("str_education_upstage_condition_awaken", gradeData:GetQuantity(), gradeData:GetGradeLevel(), value))
  end
end

function UIEducationOneElement:FlushFailTips()
  local cur = self._element:GetCurrentLuaIndex()
  local nxt = self._result:GetIndex()
  local isVisible = false
  if cur ~= nxt then
    isVisible = false
  elseif self._result:GetReason() == UIEducationDataEnum.Reason_Asset then
    isVisible = true
    self._uiFailTips.txtTitle:SetText(StringTable.Get("str_education_one_notenough"))
  elseif self._result:GetReason() == UIEducationDataEnum.Reason_Full then
    isVisible = true
    self._uiFailTips.txtTitle:SetText(StringTable.Get("str_education_one_fulllevel"))
  end
  self._uiFailTips.root.gameObject:SetActive(isVisible)
end

function UIEducationOneElement:PreferredHeight()
  if self._preferredHeight ~= nil then
    return self._preferredHeight
  end
  local spacing = self._uiUpgrade.descLayout.spacing
  local padding = self._uiUpgrade.descLayout.padding
  local preferredHeight = 0
  preferredHeight = preferredHeight + self._uiUpgrade.imgAttack.transform.rect.height
  preferredHeight = preferredHeight + spacing * 2 + padding.top + padding.bottom
  preferredHeight = preferredHeight + self._uiUpgrade.txtRestrain.preferredHeight
  preferredHeight = preferredHeight + self._uiUpgrade.txtPositiveSkill.preferredHeight
  preferredHeight = preferredHeight + self._uiUpgrade.txtCellRate.preferredHeight
  preferredHeight = preferredHeight + self._padding.t + self._padding.b
  self._preferredHeight = math.max(preferredHeight, self._uiLayout.preferredHeight)
  return self._preferredHeight
end
