_class("UIWidgetFeatureList", UICustomWidget)
UIWidgetFeatureList = UIWidgetFeatureList

function UIWidgetFeatureList:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetFeatureList:InitWidget()
  self._defaultShowCount = 2
  self._inited = false
  self._grd = self:GetGameObject("grd")
  self._showHideArea = self:GetGameObject("ShowHideArea")
  self._imgHide = self:GetUIComponent("Image", "ImgHide")
  self._imgHideGo = self:GetGameObject("ImgHide")
  self._imgShow = self:GetUIComponent("Image", "ImgShow")
  self._imgShowGo = self:GetGameObject("ImgShow")
  self:RegisterEvent()
  self._featureGenDic = {}
  self._featureGoDic = {}
  self._featureWidgetNameDic = {}
  self._featureWidgetDic = {}
  self._featureGenDic[FeatureType.Sanity] = self:GetUIComponent("UISelectObjectPath", "FeatureSan")
  self._featureGoDic[FeatureType.Sanity] = self:GetGameObject("FeatureSan")
  self._featureWidgetNameDic[FeatureType.Sanity] = "UIWidgetFeatureSan"
  self._featureGenDic[FeatureType.PersonaSkill] = self:GetUIComponent("UISelectObjectPath", "FeaturePersonaSkill")
  self._featureGoDic[FeatureType.PersonaSkill] = self:GetGameObject("FeaturePersonaSkill")
  self._featureWidgetNameDic[FeatureType.PersonaSkill] = "UIWidgetFeaturePersonaSkill"
  self._featureGenDic[FeatureType.Card] = self:GetUIComponent("UISelectObjectPath", "FeatureCard")
  self._featureGoDic[FeatureType.Card] = self:GetGameObject("FeatureCard")
  self._featureWidgetNameDic[FeatureType.Card] = "UIWidgetFeatureCard"
  self._featureGenDic[FeatureType.MasterSkill] = self:GetUIComponent("UISelectObjectPath", "FeatureMasterSkill")
  self._featureGoDic[FeatureType.MasterSkill] = self:GetGameObject("FeatureMasterSkill")
  self._featureWidgetNameDic[FeatureType.MasterSkill] = "UIWidgetFeatureMasterSkill"
  self._featureGenDic[FeatureType.Scan] = self:GetUIComponent("UISelectObjectPath", "FeatureScan")
  self._featureGoDic[FeatureType.Scan] = self:GetGameObject("FeatureScan")
  self._featureWidgetNameDic[FeatureType.Scan] = "UIWidgetFeatureScan"
  self._featureGenDic[FeatureType.MasterSkillRecover] = self:GetUIComponent("UISelectObjectPath", "FeatureMasterSkillRecover")
  self._featureGoDic[FeatureType.MasterSkillRecover] = self:GetGameObject("FeatureMasterSkillRecover")
  self._featureWidgetNameDic[FeatureType.MasterSkillRecover] = "UIWidgetFeatureMasterSkillRecover"
  self._featureGenDic[FeatureType.MasterSkillTeleport] = self:GetUIComponent("UISelectObjectPath", "FeatureMasterSkillTeleport")
  self._featureGoDic[FeatureType.MasterSkillTeleport] = self:GetGameObject("FeatureMasterSkillTeleport")
  self._featureWidgetNameDic[FeatureType.MasterSkillTeleport] = "UIWidgetFeatureMasterSkillTeleport"
  self._featureGenDic[FeatureType.PopStar] = self:GetUIComponent("UISelectObjectPath", "FeaturePopStar")
  self._featureGoDic[FeatureType.PopStar] = self:GetGameObject("FeaturePopStar")
  self._featureWidgetNameDic[FeatureType.PopStar] = "UIWidgetFeaturePopStar"
  self._featureGenDic[FeatureType.TrapDefence] = self:GetUIComponent("UISelectObjectPath", "FeatureTrapDefence")
  self._featureGoDic[FeatureType.TrapDefence] = self:GetGameObject("FeatureTrapDefence")
  self._featureWidgetNameDic[FeatureType.TrapDefence] = "UIWidgetFeatureTrapDefence"
  self:_InitDicForPopStarSkills()
  self:_InitDicForTalentSkills()
  self._featureGenDic[FeatureType.AlgorithmUpgrade] = self:GetUIComponent("UISelectObjectPath", "FeatureAlgorithmUpgrade")
  self._featureGoDic[FeatureType.AlgorithmUpgrade] = self:GetGameObject("FeatureAlgorithmUpgrade")
  self._featureWidgetNameDic[FeatureType.AlgorithmUpgrade] = "UIWidgetFeatureAlgorithmUpgrade"
  self._featureGenDic[FeatureType.Shop] = self:GetUIComponent("UISelectObjectPath", "FeatureShop")
  self._featureGoDic[FeatureType.Shop] = self:GetGameObject("FeatureShop")
  self._featureWidgetNameDic[FeatureType.Shop] = "UIWidgetFeatureShop"
  self._featureGenDic[FeatureType.BanPetSkill] = self:GetUIComponent("UISelectObjectPath", "FeatureBanPetSkill")
  self._featureGoDic[FeatureType.BanPetSkill] = self:GetGameObject("FeatureBanPetSkill")
  self._featureWidgetNameDic[FeatureType.BanPetSkill] = "UIWidgetFeatureBanPetSkill"
  self._featureBanPetSkillLayout = self:GetGameObject("FeatureBanPetSkillLayout")
  if self._featureBanPetSkillLayout then
    self._featureBanPetSkillLayout:SetActive(false)
  end
  self._featureGenDic[FeatureType.AutoBeadPowerInfo] = self:GetUIComponent("UISelectObjectPath", "FeatureAutoBeadPowerInfo")
  self._featureGoDic[FeatureType.AutoBeadPowerInfo] = self:GetGameObject("FeatureAutoBeadPowerInfo")
  self._featureWidgetNameDic[FeatureType.AutoBeadPowerInfo] = "UIWidgetFeatureAutoBeadPowerInfo"
  self._featureGenDic[FeatureType.Alchemy] = self:GetUIComponent("UISelectObjectPath", "FeatureAlchemyInfo")
  self._featureGoDic[FeatureType.Alchemy] = self:GetGameObject("FeatureAlchemyInfo")
  self._featureWidgetNameDic[FeatureType.Alchemy] = "UIWidgetFeatureAlchemyInfo"
  self._featureGenDic[FeatureType.TetrisGame] = self:GetUIComponent("UISelectObjectPath", "FeatureTetrisInfo")
  self._featureGoDic[FeatureType.TetrisGame] = self:GetGameObject("FeatureTetrisInfo")
  self._featureWidgetNameDic[FeatureType.TetrisGame] = "UIWidgetFeatureTetris"
end

function UIWidgetFeatureList:RegisterEvent()
  self:AttachEvent(GameEventType.FeatureListInit, self._OnFeatureListInit)
  self:AttachEvent(GameEventType.UIFeatureSkillInfoShow, self._OnUIFeatureSkillInfoShow)
  self:AttachEvent(GameEventType.UISwitchActiveSkillUI, self.OnSwitchActiveSkillUI)
  self:AttachEvent(GameEventType.UIPetClickToSwitch, self.OnSwitchActiveSkillUI)
  self:AttachEvent(GameEventType.RemoveFeature, self.OnRemoveFeature)
  self:AttachEvent(GameEventType.FeatureShowBanPetSkill, self._OnFeatureShowBanPetSkill)
end

function UIWidgetFeatureList:_InitDicForPopStarSkills()
  local popStarFeatureTypes = {
    FeatureType.PopStar1,
    FeatureType.PopStar2,
    FeatureType.PopStar3,
    FeatureType.PopStar4,
    FeatureType.PopStar5,
    FeatureType.PopStar6,
    FeatureType.PopStar7,
    FeatureType.PopStar8,
    FeatureType.PopStar9,
    FeatureType.PopStar10
  }
  for index, featureType in ipairs(popStarFeatureTypes) do
    local goName = "FeaturePopStar" .. tostring(index)
    self._featureGenDic[featureType] = self:GetUIComponent("UISelectObjectPath", goName)
    self._featureGoDic[featureType] = self:GetGameObject(goName)
    self._featureWidgetNameDic[featureType] = "UIWidgetFeaturePopStar"
  end
end

function UIWidgetFeatureList:_InitDicForTalentSkills()
  local talentSkillFeatureTypes = {
    FeatureType.TalentSkill1,
    FeatureType.TalentSkill2,
    FeatureType.TalentSkill3,
    FeatureType.TalentSkill4,
    FeatureType.TalentSkill5
  }
  for index, featureType in ipairs(talentSkillFeatureTypes) do
    local goName = "FeatureMasterSkillTalent" .. tostring(index)
    self._featureGenDic[featureType] = self:GetUIComponent("UISelectObjectPath", goName)
    self._featureGoDic[featureType] = self:GetGameObject(goName)
    self._featureWidgetNameDic[featureType] = "UIWidgetFeatureMasterSkill"
  end
end

function UIWidgetFeatureList:_OnFeatureListInit(featureListInfo)
  if featureListInfo then
    self:SetData(featureListInfo)
  end
end

function UIWidgetFeatureList:_OnUIFeatureSkillInfoShow(show, featureType)
  local needShowToFirst = true
  if featureType == FeatureType.Card or featureType == FeatureType.Shop then
    needShowToFirst = false
  end
  if show then
    if needShowToFirst then
      self._imgShowGo:SetActive(false)
      self._imgHideGo:SetActive(false)
      for key, featureGo in pairs(self._featureGoDic) do
        if key ~= featureType then
          featureGo:SetActive(false)
        end
      end
    end
  else
    self:_RefreshArrowState()
    self:_RefreshFeatureGoState()
  end
end

function UIWidgetFeatureList:SetUIBattle(uiBattle)
  self._uiBattle = uiBattle
end

function UIWidgetFeatureList:GetUIBattle()
  return self._uiBattle
end

function UIWidgetFeatureList:GetFeatureEnterCustomPrefab(featureType, featureData)
  if featureType == FeatureType.Card then
    if featureData then
      local uiType = featureData:GetUiType()
      if uiType and uiType == FeatureCardUiType.Skin1 then
        return "UIWidgetFeatureCard_l.prefab"
      end
    end
  elseif featureType == FeatureType.MasterSkill and featureData then
    local uiType = featureData:GetUiType()
    if uiType and uiType == FeatureMasterSkillUiType.TypeSeason then
      return "UIWidgetFeatureMasterSkillSeason.prefab"
    end
  end
  return
end

function UIWidgetFeatureList:GetFeatureEnterCustomWidgetName(featureType, featureData)
  if featureType == FeatureType.Card and featureData then
    local uiType = featureData:GetUiType()
    if uiType and uiType == FeatureCardUiType.Skin1 then
      return "UIWidgetFeatureCard_L"
    end
  end
  return
end

function UIWidgetFeatureList:SetData(featureListInfo)
  if featureListInfo then
    local featureCount = 0
    local featureGoList = {}
    local layoutList = {}
    for i, v in ipairs(featureListInfo) do
      local featureType = v:GetFeatureType()
      if self._featureGoDic[featureType] and self._featureGenDic[featureType] then
        if not self._featureWidgetDic[featureType] then
          local sop = self._featureGenDic[featureType]
          local customPrefabPath = self:GetFeatureEnterCustomPrefab(featureType, v)
          if customPrefabPath then
            sop:Engine():SetObjectName(customPrefabPath)
          end
          local widgetName = self._featureWidgetNameDic[featureType]
          local customWidgetName = self:GetFeatureEnterCustomWidgetName(featureType, v)
          if customWidgetName then
            widgetName = customWidgetName
          end
          local widget = sop:SpawnObject(widgetName)
          self._featureWidgetDic[featureType] = widget
          if widget.SetUIBattle then
            widget:SetUIBattle(self:GetUIBattle())
          end
          if widget.SetFeatureType then
            widget:SetFeatureType(featureType)
          end
          widget:SetData(v)
        end
        if featureType ~= FeatureType.DayNight and featureType ~= FeatureType.TrapCount and featureType ~= FeatureType.StepPoint and featureType ~= FeatureType.BanPetSkill then
          featureCount = featureCount + 1
        end
        local featureConfigGroup = Cfg.cfg_feature({FeatureType = featureType})
        if featureConfigGroup and 0 < #featureConfigGroup then
          local featureCfg = featureConfigGroup[1]
          local layoutOrder = featureCfg.LayoutOrder
          if layoutOrder then
            table.insert(layoutList, {type = featureType, order = layoutOrder})
          end
        end
      end
    end
    
    local function cmptFunc(a, b)
      return a.order < b.order
    end
    
    table.sort(layoutList, cmptFunc)
    local siblingIndex = 1
    for i, v in ipairs(layoutList) do
      self._featureGoDic[v.type].transform:SetSiblingIndex(siblingIndex)
      siblingIndex = siblingIndex + 1
      if v.type ~= FeatureType.BanPetSkill then
        table.insert(featureGoList, self._featureGoDic[v.type])
      end
    end
    for index, featureGo in ipairs(featureGoList) do
      if self._bOpenList or index <= self._defaultShowCount then
        featureGo:SetActive(true)
      end
    end
    self._featureGoList = featureGoList
    if not self._inited or not self._bOpenList then
      local bShowArrow = featureCount > self._defaultShowCount
      self._showHideArea:SetActive(bShowArrow)
      self._bOpenList = false
      if bShowArrow then
        self:_RefreshArrowState()
      end
    end
    self._inited = true
  end
end

function UIWidgetFeatureList:_RefreshArrowState()
  self._imgShowGo:SetActive(not self._bOpenList)
  self._imgHideGo:SetActive(self._bOpenList)
end

function UIWidgetFeatureList:ImgHideOnClick(go)
  self._bOpenList = false
  self:_RefreshArrowState()
  self:_RefreshFeatureGoState()
end

function UIWidgetFeatureList:ImgShowOnClick(go)
  self._bOpenList = true
  self:_RefreshArrowState()
  self:_RefreshFeatureGoState()
end

function UIWidgetFeatureList:_RefreshFeatureGoState()
  if self._featureGoList then
    for i, go in ipairs(self._featureGoList) do
      if self._bOpenList then
        go:SetActive(true)
      elseif i <= self._defaultShowCount then
        go:SetActive(true)
      else
        go:SetActive(false)
      end
    end
  end
end

function UIWidgetFeatureList:OnSwitchActiveSkillUI()
  if self._featureWidgetDic then
    for k, widget in pairs(self._featureWidgetDic) do
      if widget.OnSwitchActiveSkillUI then
        widget:OnSwitchActiveSkillUI()
      end
    end
  end
end

function UIWidgetFeatureList:OnChooseTargetConfirm()
  if self._featureWidgetDic then
    for k, widget in pairs(self._featureWidgetDic) do
      if widget.OnChooseTargetConfirm then
        widget:OnChooseTargetConfirm()
      end
    end
  end
end

function UIWidgetFeatureList:OnRemoveFeature(featureType)
  local widget = self._featureWidgetDic[featureType]
  if widget and widget.RemoveFeature then
    widget:RemoveFeature(featureType)
    for k, v in pairs(self._featureWidgetDic) do
      if k == featureType then
        self._featureWidgetDic[featureType] = nil
      end
    end
  end
  local featureGo = self._featureGoDic[featureType]
  if featureGo then
    featureGo:SetActive(false)
    table.removev(self._featureGoList, featureGo)
  end
  self:_RefreshArrowState()
  self:_RefreshFeatureGoState()
end

function UIWidgetFeatureList:_OnFeatureShowBanPetSkill(show)
  local uiWidgetFeatureBanPetSkill = self._featureWidgetDic[FeatureType.BanPetSkill]
  if not uiWidgetFeatureBanPetSkill then
    return
  end
  local featureBanPetSkillGo = self._featureGoDic[FeatureType.BanPetSkill]
  if not featureBanPetSkillGo then
    return
  end
  if not self._featureBanPetSkillLayout then
    return
  end
  featureBanPetSkillGo:SetActive(show)
  for i, go in ipairs(self._featureGoList) do
    go:SetActive(show == false)
  end
  local uiBattle = self:GetUIBattle()
  local featureBanPetSkillPartent = uiBattle._featureBanPetSkillPartent
  featureBanPetSkillPartent:SetActive(show)
  self._featureBanPetSkillLayout:SetActive(show)
  if show then
    featureBanPetSkillGo.transform.parent = featureBanPetSkillPartent.transform
    uiWidgetFeatureBanPetSkill:OnRefreshUI()
  else
    featureBanPetSkillGo.transform.parent = self._grd.transform
    self:_RefreshArrowState()
    self:_RefreshFeatureGoState()
  end
end
