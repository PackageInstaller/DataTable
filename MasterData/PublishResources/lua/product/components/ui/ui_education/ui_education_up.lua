_class("UIEducationUp", UIController)
UIEducationUp = UIEducationUp

function UIEducationUp:Constructor()
  self._enableEducationChanged = true
  self._selElementType = ElementType.ElementType_Blue
end

function UIEducationUp:LoadDataOnEnter(TT, res, uiParams)
  self._selElementType = uiParams[1]
  self._inAnimationCB = uiParams[2]
  self._outAnimationCB = uiParams[3]
  if self._selElementType == nil then
    self._selElementType = ElementType.ElementType_Blue
  end
  self._data = UIEducationMain:GetData()
  self._atlasPropertySel = self:GetAsset("UIEducation.spriteatlas", LoadType.SpriteAtlas)
  self._atlasPropertyUnsel = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UIEducationUp:OnShow(uiParams)
  self:UIWidget()
  self:InitCommonTopButton()
  self:InitMainLobbyTop()
  self:CreateElements()
  self:CreateCostAsset()
  self:InitLackShake()
  self:FlushElements()
  self:FlushDataLevelNxt()
  self:FlushSelection()
  self:InAnimation()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:IsGuideProcess(5511) then
    self._guideBtnInfo:SetActive(true)
  end
  self:AttachEvent(GameEventType.EducationChanged, self.OnEducationChanged)
end

function UIEducationUp:OnHide()
  self:StopLackShake()
  self._uiCost.uiAsset:Dispose()
end

function UIEducationUp:OnUpdate(deltaTimeMS)
  local shakeTick = self._shake.tick
  self._shake.tick = self._shake.tick + deltaTimeMS
  if shakeTick <= self._shake.period and self._shake.period < self._shake.tick then
    self:StopLackShake()
  end
end

function UIEducationUp:BtnUpstagePreviewOnClick(go)
  local selNode = self._lstNode[self._selElementType]
  self:ShowDialog("UIEducationUpPreview", go, selNode.element)
end

function UIEducationUp:BtnUpgradationOnClick(go)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local needGold = self._dataLevelNxt:NeedGold()
  local needAssets = self._dataLevelNxt:NeedAsset(true)
  local haveGoldCount = 0
  local needGoldCount = 0
  if needGold ~= nil then
    haveGoldCount = itemModule:GetItemCount(needGold.assetid)
    needGoldCount = needGold.count
  end
  local idLackAsset = 0
  for k, v in pairs(needAssets) do
    local haveAssetCount = 0
    local needAssetCount = 0
    if v ~= nil then
      haveAssetCount = itemModule:GetItemCount(v.assetid)
      needAssetCount = v.count
    end
    if haveAssetCount < needAssetCount then
      idLackAsset = k
      break
    end
  end
  local metCondition = self._dataLevelNxt:IsMetCondition()
  if not metCondition then
    ToastManager.ShowToast(StringTable.Get("str_education_upstage_not_meet"))
  elseif 0 < idLackAsset then
    self:DoLackShake(true, idLackAsset)
  elseif haveGoldCount < needGoldCount then
    self:DoLackShake(false)
  else
    local petModule = self:GetModule(PetModule)
    local ID = self._dataLevelNxt:GetCfg().ID
    local idlist = {ID}
    local smeltlist = {}
    self:StartSafeTask("UIEducationUp::BtnUpgradationOnClick", function(lockName, TT)
      self:Lock(lockName)
      local selNode = self._lstNode[self._selElementType]
      local selElement = selNode.element
      local currentLevel = selElement:GetCurrentLevel()
      local currentMaxLevel = selElement:GetCurrentMaxLevel()
      local dataLevel = selElement:GetCurrentDataLevel()
      self._enableEducationChanged = false
      local res, retMsg = petModule:HandlePropertyCultivateLv(TT, smeltlist, idlist)
      self._enableEducationChanged = true
      if res:GetSucc() and retMsg ~= nil and retMsg.ret == PET_RESULT_CODE.PET_SUCCEED then
        self:OnPlayUpAnimation(currentLevel, currentMaxLevel, dataLevel)
      else
        Log.error("UIEducationUp:BtnUpgradationOnClick(go) error ->: ", retCode, self._selElementType, ID)
      end
      self:UnLock(lockName)
    end)
  end
end

function UIEducationUp:OnPlayUpAnimation(currentLevel, currentMaxLevel, dataLevel)
  if self._upAnimationName == nil then
    UIEducationUp._upAnimationName = {
      "uieff_EducationUp_LevelUp_01_bing",
      "uieff_EducationUp_LevelUp_01_huo",
      "uieff_EducationUp_LevelUp_01_sen",
      "uieff_EducationUp_LevelUp_01_lei"
    }
  end
  self:StartSafeTask("UIEducationUp::OnPlayUpAnimation", function(lockName, TT)
    self:Lock(lockName)
    local period = 267
    local deltaMs = 0
    local alpha = 255
    local speed = -0.9550561797752809
    while period >= deltaMs do
      local dt = GameGlobal:GetInstance():GetDeltaTime()
      deltaMs = deltaMs + dt
      alpha = alpha + speed * dt
      alpha = math.max(alpha, 0)
      local attackText = self:GetAttackUpgrade(dataLevel:GetCfg().Attack, self._dataLevelNxt:GetCfg().Attack, alpha)
      local defenceText = self:GetAttackUpgrade(dataLevel:GetCfg().Defence, self._dataLevelNxt:GetCfg().Defence, alpha)
      local healthText = self:GetAttackUpgrade(dataLevel:GetCfg().Health, self._dataLevelNxt:GetCfg().Health, alpha)
      self._uiUpgrade.valueAttack:SetText(attackText)
      self._uiUpgrade.valueDefence:SetText(defenceText)
      self._uiUpgrade.valueHealth:SetText(healthText)
      YIELD()
    end
    local period = 700
    local deltaMs = 0
    local attackValue = dataLevel:GetCfg().Attack
    local defenceValue = dataLevel:GetCfg().Defence
    local healthValue = dataLevel:GetCfg().Health
    local speedAttack = (self._dataLevelNxt:GetCfg().Attack - attackValue) / period
    local speedDefence = (self._dataLevelNxt:GetCfg().Defence - defenceValue) / period
    local speedHealth = (self._dataLevelNxt:GetCfg().Health - healthValue) / period
    while period >= deltaMs do
      local dt = GameGlobal:GetInstance():GetDeltaTime()
      deltaMs = deltaMs + dt
      attackValue = attackValue + speedAttack * dt
      defenceValue = defenceValue + speedDefence * dt
      healthValue = healthValue + speedHealth * dt
      attackValue = math.min(attackValue, self._dataLevelNxt:GetCfg().Attack)
      defenceValue = math.min(defenceValue, self._dataLevelNxt:GetCfg().Defence)
      healthValue = math.min(healthValue, self._dataLevelNxt:GetCfg().Health)
      local attackText = self:GetAttackUpgrade(math.floor(attackValue))
      local defenceText = self:GetAttackUpgrade(math.floor(defenceValue))
      local healthText = self:GetAttackUpgrade(math.floor(healthValue))
      self._uiUpgrade.valueAttack:SetText(attackText)
      self._uiUpgrade.valueDefence:SetText(defenceText)
      self._uiUpgrade.valueHealth:SetText(healthText)
      YIELD()
    end
    self:OnEducationChanged()
    self:UnLock(lockName)
  end)
  local showLevel = currentLevel < currentMaxLevel
  if showLevel then
    self:StartSafeTask("UIEducationUp::OnPlayUpAnimation_2", function(lockName, TT)
      self:Lock(lockName)
      self._effLevelloop.gameObject:SetActive(false)
      local upName = self._upAnimationName[self._selElementType]
      self._upAnimation:Stop()
      self._upAnimation:Play(upName)
      YIELD(TT, 1500)
      self._effLevelloop.gameObject:SetActive(self._showLevelloop)
      self:UnLock(lockName)
    end)
  else
    self:StartSafeTask("UIEducationUp::OnPlayUpAnimation_2", function(lockName, TT)
      self:Lock(lockName)
      self._upAnimation:Play("uieff_EducationUp_LevelUp_02")
      YIELD(TT, 2000)
      self:UnLock(lockName)
    end)
  end
end

function UIEducationUp:ElementOnClick(elementType)
  if self._selElementType == elementType then
    return
  end
  local preElementType = self._selElementType
  self._selElementType = elementType
  self:StopLackShake()
  local preNode = self._lstNode[preElementType]
  local selNode = self._lstNode[self._selElementType]
  local finishCount = 0
  
  local function cbFinish()
    finishCount = finishCount + 1
    if 2 <= finishCount then
      self:FlushSelection_Tab()
    end
  end
  
  self:StartSafeTask("UIEducationUp::ElementOnClick anim_1", function(lockName, TT)
    self:Lock(lockName)
    preNode.uiWidget:PlaySel("uieff_UIEducationUpBtn_uiSel_out")
    preNode.uiWidget:PlayUnsel("uieff_UIEducationUpBtn_uiUnsel_in2")
    preNode.uiWidget:PlayRed("uieff_UIEducationUpBtn_uired_1")
    YIELD(TT, 267)
    selNode.uiWidget:PlaySel("uieff_UIEducationUpBtn_uiSel_in2")
    selNode.uiWidget:PlayUnsel("uieff_UIEducationUpBtn_uiUnsel_out")
    selNode.uiWidget:PlayRed("uieff_UIEducationUpBtn_uired_2")
    YIELD(TT, 433)
    cbFinish()
    self:UnLock(lockName)
  end)
  self:StartSafeTask("UIEducationUp::ElementOnClick anim_2", function(lockName, TT)
    self:Lock(lockName)
    self._animation:Play("uieff_EducationUp_qiehuan_out")
    YIELD(TT, 233)
    self:FlushDataLevelNxt()
    self:FlushSelection_Data()
    self._animation:Play("uieff_EducationUp_qiehuan_in")
    YIELD(TT, 367)
    cbFinish()
    self:UnLock(lockName)
  end)
end

function UIEducationUp:OnEducationChanged()
  if not self._enableEducationChanged then
    return
  end
  self:FlushElements()
  self:FlushDataLevelNxt()
  self:FlushSelection()
end

function UIEducationUp:UIWidget()
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._rtLobbyTop = self:GetUIComponent("UISelectObjectPath", "rtLobbyTop")
  self._pathTopTips = self:GetUIComponent("UISelectObjectPath", "topTips")
  self._pathBlue = self:GetUIComponent("UISelectObjectPath", "pathBlue")
  self._pathRed = self:GetUIComponent("UISelectObjectPath", "pathRed")
  self._pathGreen = self:GetUIComponent("UISelectObjectPath", "pathGreen")
  self._pathYellow = self:GetUIComponent("UISelectObjectPath", "pathYellow")
  self._displayElement = self:GetUIComponent("RawImageLoader", "displayElement")
  self._displayElementBg = self:GetUIComponent("RawImageLoader", "displayElementBg")
  self._uiLevel = self:GetUIComponent("UIView", "uiLevel")
  self._uiStage = self:GetUIComponent("UIView", "uiStage")
  self._uiUpgrade = self:GetUIComponent("UIView", "uiUpgrade")
  self._uiCondition = self:GetUIComponent("UIView", "uiCondition")
  self._btnPreview = self:GetUIComponent("Button", "btnPreview")
  self._uiCost = self:GetUIComponent("UIView", "uiCost")
  self._uiFullLevel = self:GetUIComponent("RectTransform", "uiFullLevel")
  self._uiFullLevelRB = self:GetUIComponent("RectTransform", "uiFullLevelRB")
  self._eff_levelP = self:GetUIComponent("RectTransform", "eff_levelP")
  self._effLevelloop = self:GetUIComponent("RectTransform", "eff_levelloop")
  self._safeArea = self:GetUIComponent("RectTransform", "safeArea")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._upAnimation = self:GetUIComponent("Animation", "safeArea")
  self._guideBtnInfo = self:GetGameObject("guideBtnInfo")
  self._guideBtnInfo:SetActive(false)
  local uiLevel = {
    root = self._uiLevel,
    elementName = self._uiLevel:GetUIComponent("UILocalizedTMP", "elementName"),
    stageName = self._uiLevel:GetUIComponent("UILocalizationText", "stageName"),
    levelUp = self._uiLevel:GetUIComponent("UILocalizationText", "levelUp")
  }
  local uiStage = {
    root = self._uiStage,
    elementName = self._uiStage:GetUIComponent("UILocalizedTMP", "elementName"),
    stageCur = self._uiStage:GetUIComponent("UILocalizationText", "stageCur"),
    stageNxt = self._uiStage:GetUIComponent("UILocalizationText", "stageNxt")
  }
  local uiUpgrade = {
    root = self._uiUpgrade,
    txtTitle = self._uiUpgrade:GetUIComponent("UILocalizationText", "txtTitle"),
    valueAttack = self._uiUpgrade:GetUIComponent("UILocalizationText", "valueAttack"),
    valueDefence = self._uiUpgrade:GetUIComponent("UILocalizationText", "valueDefence"),
    valueHealth = self._uiUpgrade:GetUIComponent("UILocalizationText", "valueHealth"),
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
  local uiCost = {
    root = self._uiCost,
    txtConfirm = self._uiCost:GetUIComponent("UILocalizationText", "txtConfirm"),
    assetRoot = self._uiCost:GetUIComponent("RectTransform", "uiAsset"),
    uiAsset = self._uiCost:GetUIComponent("UISelectObjectPath", "uiAsset"),
    widgetAssets = nil,
    maxAssetCount = 3,
    assetBase = nil,
    assetIcon = nil,
    assetText = nil,
    costRoot = self._uiCost:GetUIComponent("RectTransform", "costRoot"),
    costTitle = self._uiCost:GetUIComponent("UILocalizationText", "costTitle"),
    costIcon = self._uiCost:GetUIComponent("Image", "costIcon"),
    costValue = self._uiCost:GetUIComponent("UILocalizationText", "costValue"),
    imgLineL = self._uiCost:GetUIComponent("Image", "imgLineL"),
    imgLineR = self._uiCost:GetUIComponent("Image", "imgLineR")
  }
  uiCost.uiAsset = UICustomWidgetPool:New(self, uiCost.uiAsset)
  self._uiLevel = uiLevel
  self._uiStage = uiStage
  self._uiUpgrade = uiUpgrade
  self._uiCondition = uiCondition
  self._uiCost = uiCost
  self._showLevelP = true
  self._eff_levelP.gameObject:SetActive(self._showLevelP)
  self._showLevelloop = false
  self._effLevelloop.gameObject:SetActive(self._showLevelloop)
end

function UIEducationUp:InitCommonTopButton()
  self._backBtns = self._ltBtn:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    if self._outAnimationCB then
      self._outAnimationCB(self._selElementType)
    end
    self:CloseDialog()
  end, function()
    self:_ShowHelp()
  end, function()
    UICommonHelper:GetInstance():SwitchToUIMain()
  end, false, nil, false, function()
    self:EnterFullScreenBg(true)
  end)
end

function UIEducationUp:InitMainLobbyTop()
  self._topTipsInfo = self._pathTopTips:SpawnObject("UITopTipsContext")
  self._widgetLobbyTop = self._rtLobbyTop:SpawnObject("UIMainLobbyTopIcon")
  self._widgetLobbyTop:SetData(self._topTipsInfo)
  self._widgetLobbyTop:SetPanelShow(true, false, false)
end

function UIEducationUp:CreateElements()
  local lstPath = {
    self._pathBlue,
    self._pathRed,
    self._pathGreen,
    self._pathYellow
  }
  self._lstNode = {}
  for k, v in pairs(lstPath) do
    local uiNode = {
      uiPath = v,
      uiWidget = v:SpawnObjects("UIEducationUpBtn", 1)[1],
      element = self._data:Get(k)
    }
    uiNode.uiWidget:SetData(uiNode.element, self._atlasPropertySel, self._atlasPropertyUnsel, function(elementType)
      self:ElementOnClick(elementType)
    end)
    self._lstNode[k] = uiNode
  end
end

function UIEducationUp:CreateCostAsset()
  self._uiCost.widgetAssets = self._uiCost.uiAsset:SpawnObjects("UIAsset", self._uiCost.maxAssetCount)
  for k, v in pairs(self._uiCost.widgetAssets) do
    v:SetData(1)
    v:SetScale(0.8)
    local idTips = k
    local eventComponent = v:AddComponent(UIAssetComponentEvent)
    eventComponent:SetClickCallBack(function(go)
      self:ShowCostItemTips(go, idTips)
    end)
  end
end

function UIEducationUp:InitLackShake()
  local widgetAsset = self._uiCost.widgetAssets[1]
  self._uiCost.assetBase = self:GetChildComponent(widgetAsset:GetGameObject(), "RectTransform", "Base")
  self._uiCost.assetIcon = widgetAsset._icon
  self._uiCost.assetText = widgetAsset._txt
  self._uiCost.assetIcon = self._uiCost.assetIcon:GetComponent("RawImage")
  self._shake = {
    tweer = nil,
    tick = 0,
    period = Cfg.cfg_global.shakeWaitTime.IntValue or 2000,
    offsetX = Cfg.cfg_global.shakeOffsetX.IntValue or 10,
    offsetY = Cfg.cfg_global.shakeOffsetY.IntValue or 10,
    assetPosition = self._uiCost.assetBase.anchoredPosition,
    clrAssetIcon = self._uiCost.assetIcon.color,
    clrAssetText = self._uiCost.assetText.color,
    coinPosition = self._uiCost.costRoot.anchoredPosition,
    clrCoinTitle = self._uiCost.costTitle.color,
    clrCoinIcon = self._uiCost.costIcon.color,
    clrCoinValue = self._uiCost.costValue.color,
    clrLineValue = self._uiCost.imgLineL.color
  }
  self._shake.tick = self._shake.period + 1
end

function UIEducationUp:ShowCostItemTips(go, idTips)
  local clickGo = self._uiCost.uiAsset:Engine()
  local deltaPosition = clickGo.transform.position - self._safeArea.transform.position
  local needAssets = self._dataLevelNxt:NeedAsset(true)
  local needAsset = needAssets[idTips]
  if needAsset ~= nil then
    self:ShowDialog("UICommonItemInfo", {
      assetid = needAsset.assetid
    }, deltaPosition)
  end
end

function UIEducationUp:ShowCostItemTips(go, idTips)
  local needAssets = self._dataLevelNxt:NeedAsset(true)
  local needAsset = needAssets[idTips]
  if needAsset ~= nil then
    self:ShowDialog("UIItemGetPathController", needAsset.assetid)
  end
end

function UIEducationUp:FlushElements()
  for k, v in pairs(self._lstNode) do
    v.uiWidget:Flush()
  end
end

function UIEducationUp:FlushDataLevelNxt()
  local selNode = self._lstNode[self._selElementType]
  local selElement = selNode.element
  local luaIndex = selElement:GetCurrentLuaIndex()
  local dataLevel = selElement:GetCurrentDataLevel()
  local dataLevelNxt = selElement:GetDataLevel(luaIndex + 1)
  if dataLevelNxt == nil then
    dataLevelNxt = dataLevel
  end
  self._dataLevelNxt = dataLevelNxt
end

function UIEducationUp:FlushSelection()
  self:FlushSelection_Tab()
  self:FlushSelection_Data()
end

function UIEducationUp:FlushSelection_Tab()
  for k, v in pairs(self._lstNode) do
    v.uiWidget:SetSelect(k == self._selElementType)
  end
end

function UIEducationUp:FlushSelection_Data()
  local selNode = self._lstNode[self._selElementType]
  local selElement = selNode.element
  local elementBg = UIEducationMainBtn:GetElementBg(selElement:ElementType())
  self._displayElementBg:LoadImage(elementBg[1])
  self._displayElement:LoadImage(elementBg[2])
  local currentStage = selElement:GetCurrentStage()
  local currentLevel = selElement:GetCurrentLevel()
  local currentMaxState = selElement:GetCurrentMaxStage()
  local currentMaxLevel = selElement:GetCurrentMaxLevel()
  local currentClampStage = math.min(currentStage + 1, currentMaxState)
  local currentClampLevel = math.min(currentLevel + 1, currentMaxLevel)
  self._uiLevel.elementName:SetText(selElement:GetName())
  self._uiLevel.stageName:SetText(StringTable.Get("str_education_stage_name", currentStage))
  self._uiLevel.levelUp:SetText(string.format("<color=#00FF2A>%d</color>/%d", currentClampLevel, currentMaxLevel))
  self._uiStage.elementName:SetText(selElement:GetName())
  self._uiStage.stageCur:SetText(StringTable.Get("str_education_stage_name", currentStage))
  self._uiStage.stageNxt:SetText(StringTable.Get("str_education_stage_name", currentClampStage))
  local showLevel = currentLevel < currentMaxLevel
  self._uiLevel.root.gameObject:SetActive(showLevel)
  self._btnPreview.gameObject:SetActive(showLevel)
  self._uiStage.root.gameObject:SetActive(not showLevel)
  self._uiCondition.root.gameObject:SetActive(not showLevel)
  local dataLevel = selElement:GetCurrentDataLevel()
  local attackText = self:GetAttackUpgrade(dataLevel:GetCfg().Attack, self._dataLevelNxt:GetCfg().Attack)
  local defenceText = self:GetAttackUpgrade(dataLevel:GetCfg().Defence, self._dataLevelNxt:GetCfg().Defence)
  local healthText = self:GetAttackUpgrade(dataLevel:GetCfg().Health, self._dataLevelNxt:GetCfg().Health)
  self._uiUpgrade.valueAttack:SetText(attackText)
  self._uiUpgrade.valueDefence:SetText(defenceText)
  self._uiUpgrade.valueHealth:SetText(healthText)
  self._uiUpgrade.txtTitle:SetText(StringTable.Get("str_education_up_pet_upgrade_title", selElement:GetElementName()))
  local curPropertyRestraint = dataLevel:GetCfg().PropertyRestraint
  local curMainSkillDamage = dataLevel:GetCfg().MainSkillDamage
  local curWeight = dataLevel:GetCfg().SupplyPieceWeight
  local curSupplyPieceWeightChanged = selElement:IsSupplyPieceWeightChanged(curWeight, curWeight)
  local propertyRestraint = self._dataLevelNxt:GetCfg().PropertyRestraint
  local propertyStr = string.format("+%.1f%%%%", propertyRestraint)
  self._uiUpgrade.txtRestrain.gameObject:SetActive(propertyRestraint ~= 0)
  self._uiUpgrade.txtRestrain:SetText(self:GetStageUpgrade("str_education_up_restrain", selElement, propertyStr, curPropertyRestraint ~= propertyRestraint))
  local mainSkillDamage = self._dataLevelNxt:GetCfg().MainSkillDamage
  local propertyStr = string.format("+%.1f%%%%", mainSkillDamage)
  self._uiUpgrade.txtPositiveSkill.gameObject:SetActive(mainSkillDamage ~= 0)
  self._uiUpgrade.txtPositiveSkill:SetText(self:GetStageUpgrade("str_education_up_positive_skill", selElement, propertyStr, curMainSkillDamage ~= mainSkillDamage))
  local curWeight = dataLevel:GetCfg().SupplyPieceWeight
  local nxtWeight = self._dataLevelNxt:GetCfg().SupplyPieceWeight
  local supplyPieceWeightChanged = selElement:IsSupplyPieceWeightChanged(curWeight, nxtWeight)
  self._uiUpgrade.txtCellRate.gameObject:SetActive(supplyPieceWeightChanged)
  self._uiUpgrade.txtCellRate:SetText(self:GetStageUpgrade("str_education_up_cell_rate", selElement, propertyStr, curSupplyPieceWeightChanged ~= supplyPieceWeightChanged))
  self._showLevelP = false
  self._showLevelP = self._showLevelP or curPropertyRestraint ~= propertyRestraint
  self._showLevelP = self._showLevelP or curMainSkillDamage ~= mainSkillDamage
  self._showLevelP = self._showLevelP or curSupplyPieceWeightChanged ~= supplyPieceWeightChanged
  self._eff_levelP.gameObject:SetActive(self._showLevelP)
  self._showLevelloop = false
  self._showLevelloop = self._showLevelloop or curPropertyRestraint ~= propertyRestraint
  self._showLevelloop = self._showLevelloop or curMainSkillDamage ~= mainSkillDamage
  self._showLevelloop = self._showLevelloop or curSupplyPieceWeightChanged ~= supplyPieceWeightChanged
  self._effLevelloop.gameObject:SetActive(self._showLevelloop)
  UIEducationUpPreview:FlushCondition(self._uiCondition.conditions, self._dataLevelNxt)
  local preferredHeight = 0
  for k, v in pairs(self._uiCondition.conditions) do
    if v.gameObject.activeSelf then
      preferredHeight = preferredHeight + v.preferredHeight
    end
  end
  preferredHeight = math.max(154, preferredHeight + 58)
  local trCondition = self._uiCondition.root.transform
  trCondition.sizeDelta = Vector2(trCondition.sizeDelta.x, preferredHeight)
  local isFullStage = currentStage == currentMaxState
  local isFullLevel = currentStage == currentMaxState and currentLevel >= currentMaxLevel
  self._uiLevel.root.gameObject:SetActive(showLevel or isFullLevel)
  self._btnPreview.gameObject:SetActive(showLevel and not isFullStage)
  self._uiStage.root.gameObject:SetActive(not showLevel and not isFullStage)
  self._uiCondition.root.gameObject:SetActive(not showLevel and not isFullStage)
  self._uiCost.root.gameObject:SetActive(not isFullLevel)
  self._uiFullLevel.gameObject:SetActive(isFullLevel)
  self._uiFullLevelRB.gameObject:SetActive(isFullLevel)
  self._uiCost.txtConfirm:SetText(StringTable.Get(showLevel and "str_education_up_level_btn" or "str_education_up_stage_btn"))
  local itemModule = GameGlobal.GetModule(ItemModule)
  local haveGoldCount = itemModule:GetItemCount(RoleAssetID.RoleAssetGold)
  local needGold = self._dataLevelNxt:NeedGold()
  if needGold == nil then
    self._uiCost.costValue:SetText(0)
  elseif haveGoldCount < needGold.count then
    self._uiCost.costValue:SetText(string.format("<color=#FF6652>%d</color>", needGold.count))
  else
    self._uiCost.costValue:SetText(needGold.count)
  end
  local needAssets = self._dataLevelNxt:NeedAsset(true)
  for i = 1, self._uiCost.maxAssetCount do
    local needAsset = needAssets[i]
    local widgetAsset = self._uiCost.widgetAssets[i]
    local cfgItem
    if needAsset ~= nil then
      cfgItem = Cfg.cfg_item[needAsset.assetid]
    end
    if cfgItem ~= nil then
      local haveCount = itemModule:GetItemCount(needAsset.assetid)
      local icon = cfgItem.Icon
      local quality = cfgItem.Color
      local text
      if haveCount < needAsset.count then
        text = string.format("<color=#FF6652>%d</color>/%d", haveCount, needAsset.count)
      else
        text = string.format("%d/%d", haveCount, needAsset.count)
      end
      widgetAsset:GetGameObject():SetActive(true)
      widgetAsset:SetItemData({
        showBG = true,
        icon = icon,
        text = text,
        quality = quality
      })
    else
      widgetAsset:GetGameObject():SetActive(false)
    end
  end
end

function UIEducationUp:GetAttackUpgrade(cur, nxt, alpha)
  local str = ""
  if cur ~= nil and cur ~= 0 then
    str = string.format("+%d", cur)
  end
  if nxt ~= nil and nxt ~= 0 and 0 < nxt - cur then
    if alpha == nil then
      alpha = 255
    end
    alpha = math.floor(alpha)
    str = str .. string.format("<color=#00FF2A%.2X> +%d</color>", alpha, nxt - cur)
  end
  return str
end

function UIEducationUp:GetStageUpgrade(strID, selElement, propertyStr, isHighlight)
  local txtUpgrade = StringTable.Get(strID, selElement:GetElementName(), propertyStr)
  if isHighlight then
    txtUpgrade = string.format("<color=#00FF2A>%s</color>", txtUpgrade)
  end
  return txtUpgrade
end

function UIEducationUp:DoLackShake(isAsset, idLackAsset)
  if self._shake.tweer and self._shake.tweer:IsPlaying() then
    return
  else
    self:StopLackShake()
  end
  local color = Color(1, 0.4, 0.32)
  if isAsset then
    local widgetAsset = self._uiCost.widgetAssets[idLackAsset]
    self._uiCost.assetBase = self:GetChildComponent(widgetAsset:GetGameObject(), "RectTransform", "Base")
    self._uiCost.assetIcon = widgetAsset._icon
    self._uiCost.assetText = widgetAsset._txt
    self._uiCost.assetIcon = self._uiCost.assetIcon:GetComponent("RawImage")
    self._uiCost.assetIcon.color = self._shake.clrAssetIcon
    self._uiCost.assetText.color = color
    self._shake.tweer = self._uiCost.assetBase:DOShakePosition(1, Vector3(self._shake.offsetX, self._shake.offsetY, 0))
  else
    self._uiCost.costTitle.color = color
    self._uiCost.costIcon.color = color
    self._uiCost.costValue.color = color
    self._uiCost.imgLineL.color = color
    self._uiCost.imgLineR.color = color
    self._shake.tweer = self._uiCost.costRoot:DOShakePosition(1, Vector3(self._shake.offsetX, self._shake.offsetY, 0))
  end
  self._shake.tweer:OnComplete(function()
    self._shake.tick = 0
    self._uiCost.assetBase.anchoredPosition = self._shake.assetPosition
    self._uiCost.costRoot.anchoredPosition = self._shake.coinPosition
  end)
end

function UIEducationUp:StopLackShake()
  if self._shake.tweer ~= nil then
    self._shake.tweer:Kill()
    self._shake.tweer = nil
    self._uiCost.assetIcon.color = self._shake.clrAssetIcon
    self._uiCost.assetText.color = self._shake.clrAssetText
    self._uiCost.costTitle.color = self._shake.clrCoinTitle
    self._uiCost.costIcon.color = self._shake.clrCoinIcon
    self._uiCost.costValue.color = self._shake.clrCoinValue
    self._uiCost.imgLineL.color = self._shake.clrLineValue
    self._uiCost.imgLineR.color = self._shake.clrLineValue
    self._uiCost.assetBase.anchoredPosition = self._shake.assetPosition
    self._uiCost.costRoot.anchoredPosition = self._shake.coinPosition
  end
end

function UIEducationUp:InAnimation()
  if self._inAnimationName == nil then
    UIEducationUp._inAnimationName = {
      "uieff_EducationUp_shui_in",
      "uieff_EducationUp_huo_in",
      "uieff_EducationUp_sen_in",
      "uieff_EducationUp_lei_in"
    }
  end
  if self._inAnimationCB then
    self._inAnimationCB(self._selElementType)
  end
  self._animation:Play(self._inAnimationName[self._selElementType])
  for k, v in pairs(self._lstNode) do
    if k == self._selElementType then
      v.uiWidget:PlaySel("uieff_UIEducationUpBtn_uiSel_in")
    else
      v.uiWidget:PlayUnsel("uieff_UIEducationUpBtn_uiUnsel_in")
    end
  end
  self:StartSafeTask("UIEducationUp::InAnimation", function(lockName, TT)
    self:Lock(lockName)
    YIELD(TT, 567)
    self:UnLock(lockName)
  end)
end

function UIEducationUp:GuideBtnInfoOnClick(go)
  self:_ShowHelp()
  self._guideBtnInfo:SetActive(false)
end

function UIEducationUp:_ShowHelp()
  self:ShowDialog("UIHelpController", "UIEducationMain")
end
