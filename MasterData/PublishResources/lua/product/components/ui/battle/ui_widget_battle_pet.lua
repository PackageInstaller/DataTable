_class("UIDataActiveSkillUIInfo", Object)
UIDataActiveSkillUIInfo = UIDataActiveSkillUIInfo

function UIDataActiveSkillUIInfo:Constructor(skillId, maxPower, leftPower, canCast, showAlreadyCast, showPowerInfo, reason)
  self._skillId = skillId
  self._maxPower = maxPower
  self._leftPower = leftPower
  self._canCast = canCast
  self._showAlreadyCast = showAlreadyCast
  self._showPowerInfo = showPowerInfo
  self._reason = reason
end

_class("UIDataBattlePetSkillInfo", Object)
UIDataBattlePetSkillInfo = UIDataBattlePetSkillInfo

function UIDataBattlePetSkillInfo:Constructor(skillId, ready, power, maxPower, skillTriggerType)
  self._skillId = skillId
  self._ready = ready
  self._power = power
  self._maxPower = maxPower
  self._skillTriggerType = skillTriggerType
end

_class("UIExtraSkillCDUiData", Object)
UIExtraSkillCDUiData = UIExtraSkillCDUiData

function UIExtraSkillCDUiData:Constructor(infoGo, cdGo, energyText, alreadyCastGo)
  self._infoGo = infoGo
  self._infoShow = true
  self._cdGo = cdGo
  self._energyText = energyText
  self._alreadyCastGo = alreadyCastGo
  self._alreadyCastShow = false
end

_class("UIWidgetBattlePet", UICustomWidget)
UIWidgetBattlePet = UIWidgetBattlePet

function UIWidgetBattlePet:OnShow()
  self.enableFakeInput = true
  self._uiBattleAtlas = self:GetAsset("InnerUI.spriteatlas", LoadType.SpriteAtlas)
  self._dialLine2Hp = Cfg.cfg_global.UIWidgetBattlePet_dialLine2Hp.IntValue or 200
  self._bigDiaLine = Cfg.cfg_global.UIWidgetBattlePet_bigDiaLine.IntValue or 5
  self._dialLineCheckShowOffset = 0.06666666666666667
  self.petIndex = 0
  self.petPstID = 0
  self._showMultiBuffLayer = nil
  self._offset = self:GetUIComponent("RectTransform", "offset")
  self._tweenerOffset = nil
  self._autoFightState = false
  self._autoFightForbiddenStr = StringTable.Get("str_battle_forbidden_operation_in_autofight")
  local effCharge = self:GetGameObject("EffCharge").transform
  self._effCharge = UIHelper.GetGameObject("UIEff_UIWidgetBattlePet_Charge.prefab")
  self._effCharge.transform:SetParent(effCharge, false)
  self._txt1 = self:GetUIComponent("UILocalizationText", "txt1")
  self._txt2 = self:GetUIComponent("UILocalizationText", "txt2")
  self._sWhiteEnergy = nil
  self.txtEnergy = self:GetUIComponent("UILocalizationText", "CurEnergyText")
  self.txtEnergyMax = self:GetUIComponent("UILocalizationText", "MaxEnergyText")
  self._PassiveSkillGO = self:GetGameObject("PassiveSkill")
  self._txtAccumulate = self:GetUIComponent("UILocalizationText", "AccumulateTxt")
  self._txtAccumulate1 = self:GetUIComponent("UILocalizationText", "AccumulateTxt1")
  self._imageIconA = self:GetUIComponent("Image", "ImageIconA")
  self._imageIconA1 = self:GetUIComponent("Image", "ImageIconA1")
  self._imageIconB = self:GetUIComponent("Image", "ImageIconB")
  self._imageIconB1 = self:GetUIComponent("Image", "ImageIconB1")
  self._imageIconC = self:GetUIComponent("Image", "ImageIconC")
  self._imageIconC1 = self:GetUIComponent("Image", "ImageIconC1")
  self._imageIconD = self:GetUIComponent("Image", "ImageIconD")
  self._imageIconD1 = self:GetUIComponent("Image", "ImageIconD1")
  self._imageDiamondBlack = self:GetUIComponent("Image", "ImageDiamondBlack")
  self._imageDiamondLight = self:GetUIComponent("Image", "ImageDiamondLight")
  self._imageDiamondBlackRect = self:GetUIComponent("RectTransform", "ImageDiamondBlack")
  self._imageDiamondLightRect = self:GetUIComponent("RectTransform", "ImageDiamondLight")
  self.headIcon = self:GetUIComponent("RawImageLoader", "HeadIcon")
  self._imgChainSkillIcon = self:GetUIComponent("RawImageLoader", "imgChainSkillIcon")
  self._goChainSkillIcon = self:GetGameObject("imgChainSkillIcon")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._attrMain = self:GetUIComponent("Image", "Attribute")
  self._attrVice = self:GetUIComponent("Image", "Attribute2")
  self.uiBattleAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self.activeSkillUIPos = self:GetGameObject("ActiveSkillUIPos")
  self.cancelActiveSkillUIPos = self:GetGameObject("CancelActiveSkillUIPos")
  self._touchArea = self:GetGameObject("TouchArea")
  self._touchArea:SetActive(false)
  self._effParent = self:GetGameObject("EffPowerFull")
  self.headMask = self:GetUIComponent("Image", "headMask")
  self.powerFull = UIHelper.GetGameObject("UIEff_energyfull.prefab")
  self.powerFull.transform:SetParent(self._effParent.transform, false)
  self.powerFull:SetActive(false)
  self.previewAddBuff = self:GetGameObject("PreviewAddBuff")
  self.previewAddBuff.gameObject:SetActive(true)
  self.previewAddBuffEffect = UIHelper.GetGameObject("UIEff_BuffPre.prefab")
  self.previewAddBuffEffect.transform:SetParent(self.previewAddBuff.transform, false)
  self.previewAddBuffEffect:SetActive(false)
  self._hp = self:GetGameObject("hp")
  self._hpSlider = self:GetUIComponent("Slider", "hpSlider")
  self._hpvalue = self:GetUIComponent("Image", "hpvalue")
  self._hpvalueRect = self:GetUIComponent("RectTransform", "dialLines")
  self._dialLines = self:GetUIComponent("UISelectObjectPath", "dialLines")
  self._grayMask = self:GetGameObject("grayMask")
  self._showAddHpPos = self:GetUIComponent("RectTransform", "showAddHpPos")
  self._showAddHpGo = self:GetGameObject("showAddHpPos")
  self._addTex = self:GetUIComponent("UILocalizationText", "addTex")
  self._redTex = self:GetUIComponent("UILocalizationText", "redTex")
  self._rootAnimation = self:GetUIComponent("Animation", "root")
  self._addCdAnimation = false
  self._skillReadyGO = self:GetGameObject("UISkillReady")
  self._skillReadyBG = self:GetUIComponent("Image", "skillReadyBG")
  self._skillReadyBGAtlas = self:GetAsset("UISkillReady.spriteatlas", LoadType.SpriteAtlas)
  self.alreadyCastActiveImage = self:GetGameObject("AlreadyCastActiveImage")
  self.alreadyCastActiveImage:SetActive(false)
  self._cdGO = self:GetGameObject("Energy")
  self._cdGO:SetActive(not GuideHelper.DontShowMainSkillMission())
  self._helpPetGO = self:GetGameObject("helppet")
  self._helpPetGO:SetActive(false)
  self._cardBuffAreaGo = self:GetGameObject("CardBuffArea")
  self._cardBuffEffPosRect = self:GetUIComponent("RectTransform", "CardBuffArea")
  self._cardFlyEffGo = self:GetGameObject("CardFlyEff")
  self._cardBuffEffGo = self:GetGameObject("CardBuffEff")
  self._cardBuffAnim = self:GetUIComponent("Animation", "CardBuffArea")
  local cardBuffIcon1Go = self:GetGameObject("CardBuffIcon1")
  local cardBuffIcon2Go = self:GetGameObject("CardBuffIcon2")
  local cardBuffIcon3Go = self:GetGameObject("CardBuffIcon3")
  self._featureCardBuffIconGoDic = {
    [1] = cardBuffIcon1Go,
    [2] = cardBuffIcon2Go,
    [3] = cardBuffIcon3Go
  }
  if self._cardBuffAreaGo then
    self._cardBuffAreaGo:SetActive(false)
  end
  self._featureCardBuffState = 0
  self:AttachEvent(GameEventType.FeaturePetUIAddCardBuff, self._OnFeaturePetUIAddCardBuff)
  self:AttachEvent(GameEventType.FeaturePetUIPreviewAddCardBuff, self._OnFeaturePetUIPreviewAddCardBuff)
  self:AttachEvent(GameEventType.FeaturePetUIPreviewRecoverCardBuff, self._OnFeaturePetUIPreviewRecoverCardBuff)
  self:AttachEvent(GameEventType.FeatureListInit, self._OnFeatureListInit)
  self._timerEvent = nil
  self._switchTimeEvent = nil
  self._pressTime = HelperProxy:GetInstance():GetFixTimeLen(277)
  self._switchTimeLength = 100
  self._goSelectTeamPositionButton = self:GetGameObject("SelectTeamPos")
  local etl = UICustomUIEventListener.Get(self._touchArea)
  self:AddUICustomEventListener(etl, UIEvent.Press, function(go)
    self:OnDown(go)
  end)
  self:AddUICustomEventListener(etl, UIEvent.Unhovered, function(go)
    self:OnLeave()
  end)
  self:AddUICustomEventListener(etl, UIEvent.Hovered, function(go)
    self:OnEnter()
  end)
  self:AddUICustomEventListener(etl, UIEvent.Release, function(go)
    self:OnUp(go)
  end)
  self:InitLogicData()
  self:AttachEvent(GameEventType.PetShowPreviewArrow, self.ShowPreviewArrow)
  self:AttachEvent(GameEventType.PetHidePreviewArrow, self.HidePreviewArrow)
  self:AttachEvent(GameEventType.InOutQueue, self.InOutQueue)
  self:AttachEvent(GameEventType.FlushPetChainSkillItem, self.FlushPetChainSkillItem)
  self:AttachEvent(GameEventType.ShowHideChainSkillCG, self.ShowHideChainSkillCG)
  self:AttachEvent(GameEventType.ShowGuideMask, self._ShowGuideMask)
  self:AttachEvent(GameEventType.ShowStoryBanner, self._ShowStoryBanner)
  self:AttachEvent(GameEventType.ActiveBattlePet, self._ActiveBattlePet)
  self:AttachEvent(GameEventType.UIFeatureSkillInfoShow, self._UIFeatureSkillInfoShow)
  self:AttachEvent(GameEventType.AutoFight, self._AutoFight)
  self:AttachEvent(GameEventType.ChangePetActiveSkill, self._OnChangePetActiveSkill)
  self:AttachEvent(GameEventType.ChangePetExtraActiveSkill, self._OnChangePetExtraActiveSkill)
  self._csAnimSealedCurse = self:GetUIComponent("Animation", "uieff_zuzhoubuff_01")
  self.isSealedCurse = false
  self.sealedCurseBuffSeq = 0
  self._goSealedCurseDuration = self:GetGameObject("SealedCurseDuration")
  self._sealedCurseDurationText = self:GetUIComponent("UILocalizationText", "SealedCurseDurationText")
  self:AttachEvent(GameEventType.BattlePetIconSealedCurse, self._OnSealedCurseFlagChanged)
  self:AttachEvent(GameEventType.ToggleTeamLeaderChangeUI, self._OnShowTeamLeaderChangeUI)
  self:AttachEvent(GameEventType.BuffRoundCountChanged, self._OnBuffRoundCountChanged)
  self._csAnimSealedCurseClickBan = self:GetUIComponent("Animation", "UIBanned")
  self:AttachEvent(GameEventType.BattleUIShowHideSelectTeamPositionButton, self.ShowHideSelectTeamPositionButton)
  self:AttachEvent(GameEventType.BattleUISelectTargetTeamPosition, self.OnBattleUISelectTargetTeamPosition)
  self._overloadRootGo = self:GetGameObject("overloadIcon")
  self.isOverload = false
  self._overloadPos1GO = self:GetGameObject("overloadIconPos1")
  self._overloadPos2GO = self:GetGameObject("overloadIconPos2")
  self._overloadRootGo:SetActive(false)
  self._overloadPos1GO:SetActive(false)
  self._overloadPos2GO:SetActive(false)
  self._overloadPos1 = 49.8
  self._overloadPos2 = 13.39
  self:AttachEvent(GameEventType.SetPetOverloadState, self._SetPetOverloadState)
  self._silenceForbiddenStr = "str_battle_silence_tips"
  self._isBuffSetCanNotReady = false
  self._isBuffSetCanNotReadyForExtra = {}
  self:AttachEvent(GameEventType.SetActiveSkillCanNotReady, self._OnSetActiveSkillCanNotReady)
  self:AttachEvent(GameEventType.ForceInitPassiveIcon, self._ForceInitPassiveIcon)
  self._passiveIconInited = false
  self._attachedActivatePassive = false
  self:AttachEvent(GameEventType.ForceInitPassiveAccumulate, self._ForceInitPassiveAccumulate)
  self._passiveAccumulateInited = false
  self._players = {}
  self:AttachEvent(GameEventType.ShowPowerfullRoundCountUI, self._OnShowPowerfullRoundCountUI)
  self._powerfullRoundCountAreaGO = self:GetGameObject("PowerfullRoundCountArea")
  self._powerfullRoundCountImgGO = self:GetGameObject("PowerfullRoundCountImg")
  self._powerfullRoundCountImg = self:GetUIComponent("Image", "PowerfullRoundCountImg")
  if self._powerfullRoundCountAreaGO then
    self._powerfullRoundCountAreaGO:SetActive(false)
  end
  self._uiBattle1Atlas = self:GetAsset("UIBattle.spriteatlas", LoadType.SpriteAtlas)
  self._showPowerfullRoundCount = false
  self:AttachEvent(GameEventType.ScanFeatureReplaceUIActiveSkillID, self._OnScanFeatureReplaceUIActiveSkillID)
  self._cdAndPassiveContainer = self:GetGameObject("CDAndPassiveSkill")
  self._chainEnergyContainer = self:GetGameObject("ChainEnergy")
  self._chainEnergyFactory = self:GetUIComponent("UISelectObjectPath", "ChainEnergy")
  self:AttachEvent(GameEventType.UIMultiActiveSkillCastClick, self._OnUIMultiActiveSkillCastClick)
  self:AttachEvent(GameEventType.UIMultiSkillClickIndex, self._OnUIMultiSkillClickIndex)
  self._recordMultiSkillLastClickIndex = 1
  self._powerInfoArea = self:GetGameObject("PowerInfoArea")
  self._multiPowerInfoArea = self:GetGameObject("MultiPowerInfoArea")
  self._powerInfoArea:SetActive(true)
  self._multiPowerInfoArea:SetActive(false)
  local multiPowerInfoGo_1 = self:GetGameObject("MultiPowerInfo_1")
  local multiPowerInfoGo_2 = self:GetGameObject("MultiPowerInfo_2")
  local multiCdGO_1 = self:GetGameObject("Energy_1")
  local multiCdGO_2 = self:GetGameObject("Energy_2")
  local multiTxtEnergy_1 = self:GetUIComponent("UILocalizationText", "CurEnergyText_1")
  local multiTxtEnergy_2 = self:GetUIComponent("UILocalizationText", "CurEnergyText_2")
  local alreadyCastActiveImage_1 = self:GetGameObject("AlreadyCastActiveImage_1")
  local alreadyCastActiveImage_2 = self:GetGameObject("AlreadyCastActiveImage_2")
  self._singleSkillCDUi = UIExtraSkillCDUiData:New(self._powerInfoArea, self._cdGO, self.txtEnergy, self.alreadyCastActiveImage)
  self._multiSkillCDUi = {}
  self._multiSkillCDUi[1] = UIExtraSkillCDUiData:New(multiPowerInfoGo_1, multiCdGO_1, multiTxtEnergy_1, alreadyCastActiveImage_1)
  self._multiSkillCDUi[2] = UIExtraSkillCDUiData:New(multiPowerInfoGo_2, multiCdGO_2, multiTxtEnergy_2, alreadyCastActiveImage_2)
  self._skillCDUiDic = {}
  self._isActiveSkillPreviewUI = false
  self._needShowUIIcon = false
  self._spDefaultGO = self:GetGameObject("SPDefault")
  self._spChooseGO = self:GetGameObject("SPChoose")
  self._spActiveGO = self:GetGameObject("SPActive")
  self._spActiveAnim = self:GetUIComponent("Animation", "SPActive")
  self._spAlreadyGO = self:GetGameObject("SPAlreadyEffect")
  self._spAlreadyAnim = self:GetUIComponent("Animation", "SPAlreadyEffect")
  self._spPowerNumText = self:GetUIComponent("UILocalizationText", "SPPowerNum")
  self._spDefaultGO:SetActive(false)
  self._spChooseGO:SetActive(false)
  self._spActiveGO:SetActive(false)
  self:AttachEvent(GameEventType.IstavanShowPetHeadPreviewUI, self._OnIstavanShowPetHeadPreviewUI)
  self:AttachEvent(GameEventType.IstavanPreviewCancelPetHeadUI, self._OnIstavanCancelPetHeadPreviewUI)
  self._colorPaletteGO = self:GetGameObject("ColorPalette")
  self._colorPalette = self:GetUIComponent("UISelectObjectPath", "ColorPalette")
end

function UIWidgetBattlePet:InitSpecialPetRoot()
  if table.icontains(BattleConst.OverdrawPetTemplateIDList, self._petTemplateID) then
    self._overdrawIcon = self:GetGameObject("OverdrawIcon")
    self._effParent_Overdraw = self:GetGameObject("EffPowerFull_Overdraw")
    self.powerFull_Overdraw = UIHelper.GetGameObject("UIEff_energyfull_Overdraw.prefab")
    if self.powerFull_Overdraw then
      self.powerFull_Overdraw.transform:SetParent(self._effParent_Overdraw.transform, false)
      self.powerFull_Overdraw:SetActive(false)
    end
    self._skillReadyRoot_Overdraw = self:GetGameObject("UISkillReady_Overdraw")
    self._skillReadyGO_Overdraw = UIHelper.GetGameObject("UISkillReady_Overdraw.prefab")
    if self._skillReadyGO_Overdraw then
      self._skillReadyGO_Overdraw.transform:SetParent(self._skillReadyRoot_Overdraw.transform, false)
      self._skillReadyGO_Overdraw:SetActive(false)
    end
  end
end

function UIWidgetBattlePet:OnHide()
  UIHelper.DestroyGameObject(self.powerFull)
  UIHelper.DestroyGameObject(self._effCharge)
  UIHelper.DestroyGameObject(self.previewAddBuffEffect)
  self:DetachEvent(GameEventType.InOutQueue, self.InOutQueue)
  self:DetachEvent(GameEventType.FlushPetChainSkillItem, self.FlushPetChainSkillItem)
  self:DetachEvent(GameEventType.ShowHideChainSkillCG, self.ShowHideChainSkillCG)
  self:DetachEvent(GameEventType.ShowGuideMask, self._ShowGuideMask)
  self:DetachEvent(GameEventType.ShowStoryBanner, self._ShowStoryBanner)
  self:DetachEvent(GameEventType.ActiveBattlePet, self._ActiveBattlePet)
  self:DetachEvent(GameEventType.UIFeatureSkillInfoShow, self._UIFeatureSkillInfoShow)
  self:DetachEvent(GameEventType.AutoFight, self._AutoFight)
  self:DetachEvent(GameEventType.ActivatePassive, self.ActivatePassive)
  self:DetachEvent(GameEventType.SetAccumulateNum, self.SetAccumulateNum)
  self:DetachEvent(GameEventType.ChangePetActiveSkill, self._OnChangePetActiveSkill)
  self:DetachEvent(GameEventType.ChangePetExtraActiveSkill, self._OnChangePetExtraActiveSkill)
  self:DetachEvent(GameEventType.BattlePetIconSealedCurse, self._OnSealedCurseFlagChanged)
  self:DetachEvent(GameEventType.SetActiveSkillCanNotReady, self._OnSetActiveSkillCanNotReady)
  self:DetachEvent(GameEventType.ToggleTeamLeaderChangeUI, self._OnShowTeamLeaderChangeUI)
  self:DetachEvent(GameEventType.BuffRoundCountChanged, self._OnBuffRoundCountChanged)
  self:DetachEvent(GameEventType.BattleUIShowHideSelectTeamPositionButton, self.ShowHideSelectTeamPositionButton)
  self:DetachEvent(GameEventType.BattleUISelectTargetTeamPosition, self.OnBattleUISelectTargetTeamPosition)
  self:DetachEvent(GameEventType.SetPetOverloadState, self._SetPetOverloadState)
  self:DetachEvent(GameEventType.ForceInitPassiveIcon, self._ForceInitPassiveIcon)
  self:DetachEvent(GameEventType.ForceInitPassiveAccumulate, self._ForceInitPassiveAccumulate)
  self:DetachEvent(GameEventType.ShowOverloadPassiveAccumulate, self._ShowOverloadPassiveAccumulate)
  self:DetachEvent(GameEventType.ShowPowerfullRoundCountUI, self._OnShowPowerfullRoundCountUI)
  self:DetachEvent(GameEventType.IstavanShowPetHeadPreviewUI, self._OnIstavanShowPetHeadPreviewUI)
  self:DetachEvent(GameEventType.IstavanPreviewCancelPetHeadUI, self._OnIstavanCancelPetHeadPreviewUI)
  if self._players then
    for i, player in ipairs(self._players) do
      if player:IsPlaying() then
        player:Stop()
      end
    end
  end
  if self._cardEffTimerHandler then
    GameGlobal.Timer():CancelEvent(self._cardEffTimerHandler)
    self._cardEffTimerHandler = nil
  end
end

function UIWidgetBattlePet:InitLogicData()
  self.isReady = false
  self.skillID = nil
  self.Power = 0
  self.isDead = false
  self.clickCallback = nil
  self._petTemplateID = -1
  self.skillTriggerType = SkillTriggerType.Energy
  self._useSubActiveSkill = false
  self.extraSkillIDList = nil
  self.extraSkillInfoDic = nil
  self.useMultiPowerUi = false
  self._variantSkillList = nil
  self._variantSkillInfoDic = nil
end

function UIWidgetBattlePet:PstID()
  return self.petPstID
end

function UIWidgetBattlePet:Dead()
  return self.isDead
end

function UIWidgetBattlePet:Index()
  return self.uiid
end

function UIWidgetBattlePet:InitUIWidgetPet(index, petPstID, petData, clickCallback, switchCallback, multiSkillClickCallback, multiSkillSwitchCallback, uiBattle)
  self.uiid = index
  self.petIndex = index
  self.sortIndex = index
  self.petPstID = petPstID
  self._petTemplateID = petData:GetTemplateID()
  self._uiBattle = uiBattle
  self._isHelpPet = petData:IsHelpPet()
  self.skillID = petData:GetPetActiveSkill()
  local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self.skillID, self.petPstID)
  self.skillTriggerType = skillConfigData:GetSkillTriggerType()
  local uiCdCount = 0
  if self.skillTriggerType == SkillTriggerType.Energy then
    uiCdCount = 1
    local cdUiData = self._multiSkillCDUi[uiCdCount]
    if cdUiData then
      self._skillCDUiDic[self.skillID] = cdUiData
    end
  end
  local extraSkillIDList = petData:GetPetExtraActiveSkill()
  if extraSkillIDList and 0 < #extraSkillIDList then
    self.extraSkillIDList = extraSkillIDList
    self.extraSkillInfoDic = {}
    for index, skillId in ipairs(self.extraSkillIDList) do
      local ready = false
      local power = 0
      local maxPower = 0
      local skillConfigData = ConfigServiceHelper.GetSkillConfigData(skillId, self.petPstID)
      local skillTriggerType = skillConfigData:GetSkillTriggerType()
      local triggerPower = skillConfigData:GetSkillTriggerParam()
      maxPower = triggerPower
      if skillTriggerType == SkillTriggerType.LegendEnergy then
        power = 0
      elseif skillTriggerType == SkillTriggerType.Energy then
        power = triggerPower
        uiCdCount = uiCdCount + 1
        if 1 < uiCdCount then
          self.useMultiPowerUi = true
          local cdUiData = self._multiSkillCDUi[uiCdCount]
          if cdUiData then
            self._skillCDUiDic[skillId] = cdUiData
          end
          self._powerInfoArea:SetActive(false)
          self._multiPowerInfoArea:SetActive(true)
        end
      elseif skillTriggerType == SkillTriggerType.AlchemyEnergy then
        power = 0
      end
      self.extraSkillInfoDic[skillId] = UIDataBattlePetSkillInfo:New(skillId, ready, power, maxPower, skillTriggerType)
    end
  end
  self._variantActiveSkillInfo = petData:GetPetVariantActiveSkill()
  self:_RefreshVariantSkillIDList()
  self:_InitVariantSkillInfo()
  if uiCdCount == 1 then
    self.useMultiPowerUi = false
    self._skillCDUiDic[self.skillID] = self._singleSkillCDUi
    self._powerInfoArea:SetActive(true)
    self._multiPowerInfoArea:SetActive(false)
  elseif uiCdCount == 0 then
    self.useMultiPowerUi = false
    self._powerInfoArea:SetActive(false)
    self._multiPowerInfoArea:SetActive(false)
  end
  self._passiveSkillID = petData:GetPetPassiveSkill()
  local triggerPower = skillConfigData:GetSkillTriggerParam()
  self.txtEnergyMax:SetText(triggerPower)
  self.maxPower = triggerPower
  if self.skillTriggerType == SkillTriggerType.LegendEnergy then
    self._cdAndPassiveContainer:SetActive(true)
    self._chainEnergyContainer:SetActive(false)
    self:OnChangeLegendPower(0)
  elseif self.skillTriggerType == SkillTriggerType.BuffLayer then
    self._cdAndPassiveContainer:SetActive(false)
    self._chainEnergyContainer:SetActive(true)
    self._chainEnergyLights = self._chainEnergyFactory:SpawnObjects("UIWidgetChainActiveEnergy", 3)
    for lightIndex, lightItem in ipairs(self._chainEnergyLights) do
      lightItem:InitData(petPstID, lightIndex)
    end
  elseif self.skillTriggerType == SkillTriggerType.AlchemyEnergy then
    self._cdAndPassiveContainer:SetActive(true)
    self._chainEnergyContainer:SetActive(false)
    self:OnChangeAlchemyPower(0)
  else
    self._cdAndPassiveContainer:SetActive(true)
    self._chainEnergyContainer:SetActive(false)
    local power = triggerPower
    local matchType = self:GetModule(MatchModule):GetMatchType()
    local subMatchType = self:GetModule(MatchModule):GetSubMatchType()
    if matchType == MatchType.MT_Maze or matchType == MatchType.MT_SeasonMaze or matchType == MatchType.MT_PopStarPro or subMatchType == MatchType.MT_PopStarPro then
      local petPower = petData._power
      if 0 <= petPower then
        power = petPower
      end
    end
    self:OnChangePower(power)
    if self.Power == 0 then
      self:OnPowerReady(false)
    end
  end
  self:InitUiForExtraSkill()
  if not GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    self.headIcon:LoadImage(petData:GetPetHead(PetSkinEffectPath.HEAD_ICON_CHAIN_SKILL_PREVIEW))
    local headChain = petData:GetHeadChain(PetSkinEffectPath.HEAD_ICON_CHAIN_SKILL_PREVIEW)
    self._imgChainSkillIcon:LoadImage(headChain)
    self:ShowElement(petData)
  end
  if clickCallback then
    self.clickCallback = clickCallback
  end
  if switchCallback then
    self.switchCallback = switchCallback
  end
  if multiSkillClickCallback then
    self.multiSkillClickCallback = multiSkillClickCallback
  end
  if multiSkillSwitchCallback then
    self.multiSkillSwitchCallback = multiSkillSwitchCallback
  end
  self._mainAttr = petData:GetPetFirstElement()
  self._viceAttr = petData:GetPetSecondElement()
  self:ShowHideChainSkillCG(self.petPstID, false)
  self.petElement = petData:GetPetFirstElement()
  self.helpPetKey = petData:GetHelpPetKey()
  if not GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    self:InitPassiveSkill()
  end
  if (self:IsIncludeSkillTriggerType(SkillTriggerType.LegendEnergy) or self:IsIncludeSkillTriggerType(SkillTriggerType.AlchemyEnergy)) and not self._hideLegendEnergy then
    self:InitLegendEnergySkill()
  end
  self:InitMazeInfo()
  self:InitSkillReadyEff()
  self:InitHelpPetIcon()
  self:InitSpecialPetRoot()
  if Log.loglevel < ELogLevel.None and BattleConst.NonFormalPetWarningEnabled then
    local cfgPet = Cfg.cfg_pet[self._petTemplateID]
    self:GetGameObject("WorkInProgressMark"):SetActive(cfgPet.Formal ~= 1)
  end
end

function UIWidgetBattlePet:_RefreshVariantSkillIDList()
  if self._variantActiveSkillInfo then
    local variantSkillList = self._variantActiveSkillInfo[self.skillID]
    if variantSkillList and 0 < #variantSkillList then
      self._variantSkillList = variantSkillList
    end
  end
end

function UIWidgetBattlePet:_InitVariantSkillInfo()
  if self._variantSkillList then
    self._variantSkillInfoDic = {}
    for index, skillId in ipairs(self._variantSkillList) do
      local ready = false
      local power = 0
      local maxPower = 0
      local skillConfigData = ConfigServiceHelper.GetSkillConfigData(skillId, self.petPstID)
      local skillTriggerType = skillConfigData:GetSkillTriggerType()
      local triggerPower = skillConfigData:GetSkillTriggerParam()
      maxPower = triggerPower
      if skillTriggerType == SkillTriggerType.BuffLayer then
        self._variantSkillInfoDic[skillId] = UIDataBattlePetSkillInfo:New(skillId, ready, power, maxPower, skillTriggerType)
      end
    end
  end
end

function UIWidgetBattlePet:InitUiForExtraSkill()
  if self.extraSkillIDList then
    for skillId, skillInfo in pairs(self.extraSkillInfoDic) do
      local uiInfo = skillInfo
      local skillTriggerType = uiInfo._skillTriggerType
      if skillTriggerType == SkillTriggerType.LegendEnergy then
        self._cdAndPassiveContainer:SetActive(true)
        self._chainEnergyContainer:SetActive(false)
        self:OnChangeLegendPowerForExtraSkill(uiInfo._skillId, 0)
      elseif skillTriggerType == SkillTriggerType.Energy then
        self._cdAndPassiveContainer:SetActive(true)
        self._chainEnergyContainer:SetActive(false)
        local power = uiInfo._maxPower
        self:OnChangePowerForExtraSkill(uiInfo._skillId, power)
        if uiInfo._power == 0 then
          self:OnPowerReadyForExtraSkill(uiInfo._skillId, false)
        end
      elseif skillTriggerType == SkillTriggerType.ColorPalette then
        self._colorPaletteGO:SetActive(true)
        self._colorPaletteWidget = self._colorPalette:SpawnObject("UIWidgetColorPalette")
        self._colorPaletteWidget:SetData(self.petPstID)
      end
    end
  end
end

function UIWidgetBattlePet:IsSelfHelpPet()
  return self.helpPetKey and self.helpPetKey > 0
end

function UIWidgetBattlePet:InitHelpPetIcon()
  if self:IsSelfHelpPet() then
    self._helpPetGO:SetActive(true)
  else
    self._helpPetGO:SetActive(false)
  end
end

function UIWidgetBattlePet:InitSkillReadyEff()
  local element2Color = {
    [1] = "sprite_skill_shui",
    [2] = "sprite_skill_huo",
    [3] = "sprite_skill_sen",
    [4] = "sprite_skill_lei"
  }
  local animationName = element2Color[self.petElement]
  self._skillReadyBG.sprite = self._skillReadyBGAtlas:GetSprite(animationName)
end

function UIWidgetBattlePet:InitMazeInfo()
  local match = self:GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  local matchPets = InnerGameHelperRender.GetLocalMatchPets()
  self._fromMaze = MatchType.MT_Maze == enterData._match_type or MatchType.MT_SeasonMaze == enterData._match_type
  self._hp:SetActive(self._fromMaze)
  if self._fromMaze then
    local pet = matchPets[self.petPstID]
    local hp = math.floor(pet:GetPetCurHealth())
    local maxHp = math.floor(pet:GetPetHealth())
    self:_OnRefreshDialLineItems(hp, maxHp)
    self._lastHp = hp
    self._upper = maxHp
    local rate = hp / self._upper
    self._hpvalue.fillAmount = rate
    self._hpSlider.value = rate
    self._grayMask:SetActive(hp <= 0)
  end
end

function UIWidgetBattlePet:_OnRefreshDialLineItems(hp, maxHp)
  if self._upper == maxHp then
    return
  end
  local hpvaluewidth = self._hpvalueRect.sizeDelta.x
  local dialLineCount = math.ceil(maxHp / self._dialLine2Hp) - 1
  if 20 < dialLineCount then
    dialLineCount = 20
    self._dialLine2Hp = maxHp / 20
  end
  self._dialLines:SpawnObjects("UIWidgetPetHpDialLine", dialLineCount)
  self._dialLineItems = self._dialLines:GetAllSpawnList()
  for i = 1, #self._dialLineItems do
    local posx = hpvaluewidth / maxHp * self._dialLine2Hp * i
    local middleImg = i % self._bigDiaLine == 0
    local show = hp > i * self._dialLine2Hp
    self._dialLineItems[i]:SetData(i, posx, middleImg, show)
  end
end

function UIWidgetBattlePet:FlushPetHp(mazePetInfo)
  if self._fromMaze then
    if self.isDead and mazePetInfo.is_dead then
      return
    end
    self:_OnRefreshDialLineItems(mazePetInfo.cur_hp, mazePetInfo.max_hp)
    self._upper = mazePetInfo.max_hp
    local hp = mazePetInfo.cur_hp
    local changeValue = mazePetInfo.change_value
    local rate = hp / self._upper
    if mazePetInfo.is_dead then
      self.powerFull:SetActive(false)
    elseif self.isDead then
      if self.skillTriggerType == SkillTriggerType.LegendEnergy then
        self:OnChangeLegendPower(self.Power)
      elseif self.skillTriggerType == SkillTriggerType.AlchemyEnergy then
        self:OnChangeAlchemyPower(self.Power)
      else
        self:OnChangePower(self.Power)
      end
      self:FlushPetHp_RefreshExtraSkillPower()
    end
    self.isDead = mazePetInfo.is_dead
    local addHp
    local addHpValue = math.modf(hp - self._lastHp)
    if changeValue then
      addHpValue = changeValue
    end
    if 0 < addHpValue then
      addHp = true
    else
      if addHpValue < 0 then
        addHp = false
      else
      end
    end
    self._lastHp = hp
    if self._hpSliderTweener then
      self._hpSliderTweener:Kill()
    end
    self._addTex.gameObject:SetActive(addHp)
    self._redTex.gameObject:SetActive(not addHp)
    self._showAddHpGo:SetActive(true)
    if addHp then
      self._addTex:SetText("+" .. addHpValue)
      self._hpSlider.value = rate
      self._hpSliderTweener = self._hpvalue:DOFillAmount(rate, 0.5)
    else
      self._redTex:SetText(addHpValue)
      self._hpvalue.fillAmount = rate
      self._hpSliderTweener = self._hpSlider:DOValue(rate, 0.5)
    end
    if self._addHpTweener then
      self._addHpTweener:Kill()
    end
    self._addHpTweener = self._showAddHpPos:DOAnchorPosY(80, 0.5):OnComplete(function()
      self._showAddHpGo:SetActive(false)
      self._showAddHpPos.anchoredPosition = Vector2(0, 0)
    end)
    if self._dialLineItems then
      for i = 1, #self._dialLineItems do
        local show = hp > i * self._dialLine2Hp
        self._dialLineItems[i]:FlushShow(show)
      end
    end
    self._grayMask:SetActive(hp <= 0)
  end
end

function UIWidgetBattlePet:FlushPetHp_RefreshExtraSkillPower()
  if not self.extraSkillIDList then
    return
  end
  for skillId, skillInfo in pairs(self.extraSkillInfoDic) do
    local uiInfo = skillInfo
    local skillTriggerType = uiInfo._skillTriggerType
    if skillTriggerType == SkillTriggerType.LegendEnergy then
      self:OnChangeLegendPowerForExtraSkill(uiInfo._skillId, uiInfo._power)
    elseif skillTriggerType == SkillTriggerType.Energy then
      self:OnChangePowerForExtraSkill(uiInfo._skillId, uiInfo._power)
    end
  end
end

function UIWidgetBattlePet:_ShowHideCdGo(skillID, bShow)
  local uiInfo = self._skillCDUiDic[skillID]
  if not uiInfo then
    return
  end
  if GuideHelper.DontShowMainSkillMission() then
    uiInfo._cdGo:SetActive(false)
  else
    uiInfo._cdGo:SetActive(bShow)
  end
end

function UIWidgetBattlePet:_ShowHideAlreadyCastGo(skillID, bShow)
  local uiInfo = self._skillCDUiDic[skillID]
  if not uiInfo then
    return
  end
  uiInfo._alreadyCastGo:SetActive(bShow)
  uiInfo._alreadyCastShow = bShow
end

function UIWidgetBattlePet:_RefreshPowerArea(skillID, curPower, newPower, ready)
  local uiInfo = self._skillCDUiDic[skillID]
  if not uiInfo then
    return
  end
  if curPower == 0 then
    if GuideHelper.DontShowMainSkillMission() then
      uiInfo._cdGo:SetActive(false)
    else
      uiInfo._cdGo:SetActive(newPower ~= 0)
    end
  end
  if ready or curPower == 0 then
    uiInfo._alreadyCastGo:SetActive(false)
    uiInfo._alreadyCastShow = false
  end
  uiInfo._energyText:SetText(tostring(newPower))
end

function UIWidgetBattlePet:OnChangePower(power, effect)
  if self.skillTriggerType == SkillTriggerType.LegendEnergy then
    self.Power = power
    self:_ShowHideCdGo(self.skillID)
    return
  end
  if power <= 0 then
    power = 0
  end
  self:_RefreshPowerArea(self.skillID, self.Power, power, self.isReady)
  if self.Power == power then
    return
  end
  self.Power = power
  self:_OnPlayPowerAddEffect(effect, self.Power)
end

function UIWidgetBattlePet:OnChangePowerAndWatch(power, isReady, watch)
  if power <= 0 then
    power = 0
  end
  self.isReady = isReady
  self:_RefreshPowerArea(self.skillID, self.Power, power, self.isReady)
  self.Power = power
  self:_ShowHideAlreadyCastGo(self.skillID, watch)
  self.powerFull:SetActive(isReady and not self.isDead)
  if self.powerFull_Overdraw and isReady then
    self.powerFull_Overdraw:SetActive(false)
  end
end

function UIWidgetBattlePet:OnPetPowerOverdrawChange(overdrawTable)
  if not self.powerFull_Overdraw then
    return
  end
  local ready = overdrawTable.ready
  local overdraw = overdrawTable.overdraw
  self.powerFull_Overdraw:SetActive(false)
  self._skillReadyGO_Overdraw:SetActive(false)
  if ready == 1 then
    self.powerFull_Overdraw:SetActive(true)
    self._skillReadyGO_Overdraw:SetActive(true)
  end
  if overdraw ~= nil then
    self._overdrawIcon:SetActive(overdraw == 1)
  end
end

function UIWidgetBattlePet:OnChangeAlchemyPower(power, effect, logicReady, maxValue, forceColorWhite)
  if self.skillTriggerType ~= SkillTriggerType.AlchemyEnergy then
    if self:IsIncludeSkillTriggerType(SkillTriggerType.AlchemyEnergy) then
      for skillId, skillInfo in pairs(self.extraSkillInfoDic) do
        if skillInfo._skillTriggerType == SkillTriggerType.AlchemyEnergy then
          self:OnChangeLegendPowerForExtraSkill(skillId, power, effect, logicReady, maxValue, forceColorWhite)
        end
      end
    end
    return
  end
  self:_ShowHideCdGo(self.skillID, false)
  self:_ShowHideAlreadyCastGo(self.skillID, false)
  if not self._hideLegendEnergy then
    self._PassiveSkillGO.gameObject:SetActive(true)
    self._txtAccumulate.gameObject:SetActive(power ~= 0)
    self._txtAccumulate:SetText(tostring(power))
  end
  InnerGameHelperRender.UISetUIPetAccumulateNum(self.petPstID, power)
  if forceColorWhite then
    self._txtAccumulate.color = Color.white
    self._imageIconA.color = Color.white
    self._imageIconB.color = Color.white
    self._imageIconC.color = Color.white
    self._imageIconD.color = Color.white
  elseif maxValue then
    local color = Color.white
    self._txtAccumulate.color = color
    self._imageIconA.color = color
    self._imageIconB.color = color
    self._imageIconC.color = color
    self._imageIconD.color = color
  end
  if self.Power == power then
    return
  end
  self.Power = power
end

function UIWidgetBattlePet:OnChangeLegendPower(power, effect, logicReady, maxValue, forceColorWhite)
  if self.skillTriggerType ~= SkillTriggerType.LegendEnergy then
    if self:IsIncludeSkillTriggerType(SkillTriggerType.LegendEnergy) then
      for skillId, skillInfo in pairs(self.extraSkillInfoDic) do
        if skillInfo._skillTriggerType == SkillTriggerType.LegendEnergy then
          self:OnChangeLegendPowerForExtraSkill(skillId, power, effect, logicReady, maxValue, forceColorWhite)
        end
      end
    end
    return
  end
  if self.extraSkillInfoDic then
    for skillId, skillInfo in pairs(self.extraSkillInfoDic) do
      if skillInfo._skillTriggerType == SkillTriggerType.LegendEnergy then
        self:OnChangeLegendPowerForExtraSkill(skillId, power, effect, logicReady, maxValue, forceColorWhite)
      end
    end
  end
  self:_ShowHideCdGo(self.skillID, false)
  self:_ShowHideAlreadyCastGo(self.skillID, false)
  if not self._hideLegendEnergy then
    self._PassiveSkillGO.gameObject:SetActive(true)
    self._txtAccumulate.gameObject:SetActive(power ~= 0)
    self._txtAccumulate:SetText(tostring(power))
  end
  InnerGameHelperRender.UISetUIPetAccumulateNum(self.petPstID, power)
  if forceColorWhite then
    self._txtAccumulate.color = Color.white
    self._imageIconA.color = Color.white
    self._imageIconB.color = Color.white
    self._imageIconC.color = Color.white
    self._imageIconD.color = Color.white
  elseif maxValue then
    local color = Color.white
    if maxValue <= power then
      color = Color.New(1, 0.98823529, 0.058823529, 1)
    end
    self._txtAccumulate.color = color
    self._imageIconA.color = color
    self._imageIconB.color = color
    self._imageIconC.color = color
    self._imageIconD.color = color
  end
  if self.Power == power then
    return
  end
  self.Power = power
end

function UIWidgetBattlePet:OnChangePowerForExtraSkill(skillId, power, effect)
  local uiInfo = self.extraSkillInfoDic[skillId]
  if not uiInfo then
    return
  end
  if uiInfo._skillTriggerType == SkillTriggerType.LegendEnergy then
    uiInfo._power = power
    self:_ShowHideCdGo(skillId, false)
    return
  end
  if power <= 0 then
    power = 0
  end
  self:_RefreshPowerArea(skillId, uiInfo._power, power, uiInfo._ready)
  if uiInfo._power == power then
    return
  end
  uiInfo._power = power
  self:_OnPlayPowerAddEffect(effect, uiInfo._power)
end

function UIWidgetBattlePet:OnChangeLegendPowerForExtraSkill(skillId, power, effect, logicReady, maxValue, forceColorWhite)
  local uiInfo = self.extraSkillInfoDic[skillId]
  if not uiInfo then
    return
  end
  if not self._hideLegendEnergy then
    self._PassiveSkillGO.gameObject:SetActive(true)
    self._txtAccumulate.gameObject:SetActive(power ~= 0)
    self._txtAccumulate:SetText(tostring(power))
  end
  InnerGameHelperRender.UISetUIPetAccumulateNum(self.petPstID, power)
  if forceColorWhite then
    self._txtAccumulate.color = Color.white
    self._imageIconA.color = Color.white
    self._imageIconB.color = Color.white
    self._imageIconC.color = Color.white
    self._imageIconD.color = Color.white
  elseif maxValue then
    local color = Color.white
    if maxValue <= power then
      color = Color.New(1, 0.98823529, 0.058823529, 1)
    end
    self._txtAccumulate.color = color
    self._imageIconA.color = color
    self._imageIconB.color = color
    self._imageIconC.color = color
    self._imageIconD.color = color
  end
  if uiInfo._power == power then
    return
  end
  uiInfo._power = power
end

function UIWidgetBattlePet:_OnPlayPowerAddEffect(effect, power)
  if GuideHelper.DontShowMainSkillMission() then
    return
  end
  if self:MissionCanCast() and 0 < power then
    self._effCharge:SetActive(false)
    if effect then
      self._effCharge:SetActive(true)
    end
  end
end

function UIWidgetBattlePet:OnPowerReady(playReminder, previouslyReady)
  if GuideHelper.DontShowMainSkillMission() then
    self.powerFull:SetActive(false)
    return
  end
  if self._isBuffSetCanNotReady then
    return
  end
  if self:MissionCanCast() then
    if not self.isDead then
      self.powerFull:SetActive(true)
      if self.powerFull_Overdraw then
        self.powerFull_Overdraw:SetActive(false)
      end
    end
    if playReminder and not previouslyReady then
      InnerGameHelperRender.InnerGamePlayPetUIVoice("Charge", self._petTemplateID)
      self._skillReadyGO:SetActive(false)
      self._skillReadyGO:SetActive(true)
    end
  end
  self:_ShowHideCdGo(self.skillID, false)
  self.isReady = true
  if self.skillTriggerType ~= SkillTriggerType.LegendEnergy and self.skillTriggerType ~= SkillTriggerType.AlchemyEnergy then
    self.Power = 0
    self._addCdAnimation = false
  end
end

function UIWidgetBattlePet:OnPowerCancelReady(addCdAnimation)
  if not self:MissionCanCast() or self.isDead or self:IsExtraSkillHasReady() then
  else
    self.powerFull:SetActive(false)
  end
  self.isReady = false
  if self.skillTriggerType ~= SkillTriggerType.LegendEnergy and self.skillTriggerType ~= SkillTriggerType.AlchemyEnergy then
    self:_ShowHideCdGo(self.skillID, true)
    if addCdAnimation ~= 0 then
      self._addCdAnimation = true
    end
  end
end

function UIWidgetBattlePet:OnPowerReadyForExtraSkill(skillId, playReminder, previousReady)
  local uiInfo = self.extraSkillInfoDic[skillId]
  if not uiInfo then
    return
  end
  if GuideHelper.DontShowMainSkillMission() then
    self.powerFull:SetActive(false)
    return
  end
  if self._isBuffSetCanNotReady then
    return
  end
  if self._isBuffSetCanNotReadyForExtra[skillId] then
    return
  end
  if self:MissionCanCast() then
    if not self.isDead then
      self.powerFull:SetActive(true)
    end
    if playReminder and not previousReady then
      InnerGameHelperRender.InnerGamePlayPetUIVoice("Charge", self._petTemplateID)
      self._skillReadyGO:SetActive(false)
      self._skillReadyGO:SetActive(true)
    end
  end
  self:_ShowHideCdGo(skillId, false)
  self:_ShowHideAlreadyCastGo(skillId, false)
  uiInfo._ready = true
  if uiInfo._skillTriggerType ~= SkillTriggerType.LegendEnergy and uiInfo._skillTriggerType ~= SkillTriggerType.AlchemyEnergy then
    uiInfo._power = 0
    self._addCdAnimation = false
  end
end

function UIWidgetBattlePet:OnPowerCancelReadyForExtraSkill(skillId, addCdAnimation)
  local uiInfo = self.extraSkillInfoDic[skillId]
  if not uiInfo then
    return
  end
  uiInfo._ready = false
  if not self:MissionCanCast() or self.isDead or self.isReady or self:IsExtraSkillHasReady() then
  else
    self.powerFull:SetActive(false)
  end
  if uiInfo._skillTriggerType ~= SkillTriggerType.LegendEnergy then
    self:_ShowHideCdGo(skillId, true)
    if addCdAnimation ~= 0 then
      self._addCdAnimation = true
    end
  end
end

function UIWidgetBattlePet:OnShowPetInfoInish()
  if not self._addCdAnimation then
    return
  end
  self._addCdAnimation = false
  self._rootAnimation:Play("uieff_jiacdbuff")
end

function UIWidgetBattlePet:MissionCanCast()
  local matchModule = GameGlobal.GetModule(MatchModule)
  local enterData = matchModule:GetMatchEnterData()
  if enterData:GetMatchType() == MatchType.MT_Mission then
    local currentMissionId = enterData:GetMissionCreateInfo().mission_id
    local current_mission_cfg = Cfg.cfg_mission[currentMissionId]
    if current_mission_cfg == nil then
      return true
    end
    local missionCanCast = current_mission_cfg.CastSkillLimit
    return missionCanCast
  end
  return true
end

function UIWidgetBattlePet:FlushIndex(idx)
  self.petIndex = idx
end

function UIWidgetBattlePet:GetActiveSkillUIPos()
  return self.activeSkillUIPos
end

function UIWidgetBattlePet:GetCancelSkillUIPos()
  return self.cancelActiveSkillUIPos
end

function UIWidgetBattlePet:IsMyPet(petPstID)
  if self.petPstID == petPstID then
    return true
  end
  return false
end

function UIWidgetBattlePet:GetPetPstID()
  return self.petPstID
end

function UIWidgetBattlePet:GetPetTemplateID()
  return self._petTemplateID
end

function UIWidgetBattlePet:ClearPower(castSkillID)
  if GuideHelper.DontShowMainSkillMission() then
    self:_ShowHideCdGo(self.skillID, false)
    return
  end
  if self.extraSkillIDList and table.icontains(self.extraSkillIDList, castSkillID) then
    return self:ClearPowerForExtraSkill(castSkillID)
  end
  if self.skillTriggerType == SkillTriggerType.LegendEnergy then
    local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self.skillID, self:GetPetPstID())
    local costLegendPower = skillConfigData:GetSkillTriggerParam()
    local cfgCostLegendPower = costLegendPower
    costLegendPower = self:_GetLegendPowerConstByExtraParam(costLegendPower, skillConfigData, self._uiBattle:GetCurPickExtraParam(self.skillID))
    self.Power = self.Power - costLegendPower
    self:_CheckMultiLegengPowerSkillReadyOnClearPower(castSkillID, self.Power)
    if cfgCostLegendPower > self.Power then
      self.isReady = false
      if self:IsExtraSkillHasReady() then
      else
        self.powerFull:SetActive(false)
      end
    end
    self:OnChangeLegendPower(self.Power, nil, nil, nil, true)
  elseif self.skillTriggerType == SkillTriggerType.AlchemyEnergy then
    local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self.skillID, self:GetPetPstID())
    local costLegendPower = skillConfigData:GetSkillTriggerParam()
    self.Power = self.Power - costLegendPower
    self.isReady = false
    self.powerFull:SetActive(false)
    self:OnChangeAlchemyPower(self.Power, nil, nil, nil, true)
  else
    self.Power = 0
    self.isReady = false
    if self:IsExtraSkillHasReady() then
    else
      self.powerFull:SetActive(false)
    end
    self:_ShowHideAlreadyCastGo(self.skillID, true)
  end
end

function UIWidgetBattlePet:ClearPowerForExtraSkill(castSkillID)
  local uiInfo = self.extraSkillInfoDic[castSkillID]
  if not uiInfo then
    return
  end
  if uiInfo._skillTriggerType == SkillTriggerType.LegendEnergy then
    local skillConfigData = ConfigServiceHelper.GetSkillConfigData(uiInfo._skillId, self:GetPetPstID())
    local costLegendPower = skillConfigData:GetSkillTriggerParam()
    local cfgCostLegendPower = costLegendPower
    costLegendPower = self:_GetLegendPowerConstByExtraParam(costLegendPower, skillConfigData, self._uiBattle:GetCurPickExtraParam(uiInfo._skillId))
    uiInfo._power = uiInfo._power - costLegendPower
    self:_CheckMultiLegengPowerSkillReadyOnClearPower(castSkillID, uiInfo._power)
    cfgCostLegendPower = self:CalcNextMinCostLegendPowerByExtraParam(cfgCostLegendPower, skillConfigData)
    if cfgCostLegendPower > uiInfo._power then
      uiInfo._ready = false
      if self.isReady or self:IsExtraSkillHasReady() then
      else
        self.powerFull:SetActive(false)
      end
    end
    self:OnChangeLegendPowerForExtraSkill(uiInfo._skillId, uiInfo._power, nil, nil, nil, true)
  else
    uiInfo._power = 0
    uiInfo._ready = false
    if self.isReady or self:IsExtraSkillHasReady() then
    else
      self.powerFull:SetActive(false)
    end
    self:_ShowHideAlreadyCastGo(uiInfo._skillId, true)
  end
  if self.isReady or self:IsExtraSkillHasReady() then
  else
    self.powerFull:SetActive(false)
  end
  return
end

function UIWidgetBattlePet:_CheckMultiLegengPowerSkillReadyOnClearPower(castSkillID, curPower)
  if not (self.skillTriggerType == SkillTriggerType.LegendEnergy and castSkillID) or self.skillID == castSkillID then
  else
    self.Power = curPower
    local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self.skillID, self:GetPetPstID())
    local costLegendPower = skillConfigData:GetSkillTriggerParam()
    if costLegendPower > self.Power then
      self.isReady = false
    end
  end
  if self.extraSkillInfoDic then
    for skillID, uiInfo in pairs(self.extraSkillInfoDic) do
      if not castSkillID or skillID == castSkillID then
      elseif uiInfo._skillTriggerType == SkillTriggerType.LegendEnergy then
        local skillConfigData = ConfigServiceHelper.GetSkillConfigData(uiInfo._skillId, self:GetPetPstID())
        local costLegendPower = skillConfigData:GetSkillTriggerParam()
        uiInfo._power = curPower
        if costLegendPower > uiInfo._power then
          uiInfo._ready = false
        end
      end
    end
  end
end

function UIWidgetBattlePet:_GetLegendPowerConstByExtraParam(defaultCost, skillConfigData, extraParam)
  local cost = defaultCost
  if skillConfigData then
    local cfgExtraParam = skillConfigData:GetSkillTriggerExtraParam()
    if cfgExtraParam then
      if cfgExtraParam[SkillTriggerTypeExtraParam.PickPosNoCfgTrap] then
        if extraParam and table.icontains(extraParam, SkillTriggerTypeExtraParam.PickPosNoCfgTrap) then
          cost = cfgExtraParam[SkillTriggerTypeExtraParam.PickPosNoCfgTrap]
        end
      elseif cfgExtraParam[SkillTriggerTypeExtraParam.CostByForceMoveStep] then
        cost = BattleStatHelper.CalcZhongxuForceMovementCostByPick(self.petPstID, skillConfigData:GetID())
        if cost < 0 then
          cost = defaultCost
        end
      elseif cfgExtraParam[SkillTriggerTypeExtraParam.CostPickUpUIAndTrap] then
        cost = BattleStatHelper.GetCasterPickUpExtraChainPowerCount(self.petPstID, skillConfigData:GetID())
      end
    end
    local skillID = skillConfigData:GetID()
  end
  return cost
end

function UIWidgetBattlePet:CalcNextMinCostLegendPowerByExtraParam(defaultCost, skillConfigData)
  local cost = defaultCost
  if skillConfigData then
    local cfgExtraParam = skillConfigData:GetSkillTriggerExtraParam()
    if cfgExtraParam and cfgExtraParam[SkillTriggerTypeExtraParam.CostByForceMoveStep] then
      cost = BattleStatHelper.CalcZhongxuForceMovementNextMinCost(self.petPstID, skillConfigData:GetID())
      if cost < 0 then
        cost = defaultCost
      end
    end
  end
  return cost
end

function UIWidgetBattlePet:OnChangeHeadAlpha(alpha)
  local color = self.headMask.color
  color.a = alpha
  self.headMask.color = color
end

function UIWidgetBattlePet:ShowPreviewArrow(pstIds)
  if pstIds and table.icontains(pstIds, self.petPstID) then
    self.previewAddBuffEffect:SetActive(true)
    self.powerFull:SetActive(false)
    self:OnChangeHeadAlpha(0)
  else
    self.previewAddBuffEffect:SetActive(false)
  end
end

function UIWidgetBattlePet:HidePreviewArrow()
  self.previewAddBuffEffect:SetActive(false)
  if self.isReady or self:IsExtraSkillHasReady() then
    self.powerFull:SetActive(not self.isDead)
  end
end

function UIWidgetBattlePet:DoGuideClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HideCanMoveArrow)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickPetHead, self.petPstID, self.isReady)
end

function UIWidgetBattlePet:GetSkillID()
  return self.skillID
end

function UIWidgetBattlePet:ShowElement(pet)
  if pet == nil then
    return
  end
  local cfg_pet_element = Cfg.cfg_pet_element({})
  if cfg_pet_element then
    local _1stElement = pet:GetPetFirstElement()
    if _1stElement then
      self._attrMain.gameObject:SetActive(true)
      self._attrMain.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[_1stElement].Icon .. "_battle"))
    else
      self._attrMain.gameObject:SetActive(false)
    end
    local _2ndElement = pet:GetPetSecondElement()
    if _2ndElement then
      self._attrVice.gameObject:SetActive(true)
      self._attrVice.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[_2ndElement].Icon .. "_battle"))
    else
      self._attrVice.gameObject:SetActive(false)
    end
  end
end

function UIWidgetBattlePet:InOutQueue(petPstID, out)
  if petPstID ~= self.petPstID then
    return
  end
  if self.isDead then
    return
  end
  if self._tweenerOffset then
    self._tweenerOffset:Complete()
  end
  local duration = 0.2
  local offsetEndX = 0
  if out then
    offsetEndX = -25
  end
  self._tweenerOffset = self._offset:DOAnchorPosX(offsetEndX, duration)
end

function UIWidgetBattlePet:FlushPetChainSkillItem(isLocal, chainPathLen, elementType, firstElementType)
  if not isLocal then
    return
  end
  if not self.isSealedCurse then
    local isJoinChainSpecial, isAffected = BattleStatHelper.IsPetJoinChainSpecial(self.petPstID, chainPathLen, elementType, firstElementType)
    if isAffected then
      self:InOutQueue(self.petPstID, isJoinChainSpecial)
      return
    elseif isJoinChainSpecial then
      self:InOutQueue(self.petPstID, isJoinChainSpecial)
      return
    end
  end
  if chainPathLen == 0 then
    self:InOutQueue(self.petPstID, false)
    return
  elseif chainPathLen == 1 then
    if self.petIndex == 1 then
      self:InOutQueue(self.petPstID, true)
    else
      self:InOutQueue(self.petPstID, false)
      return
    end
  elseif self.petIndex == 1 then
    self:InOutQueue(self.petPstID, true)
  else
    if self.isSealedCurse then
      self:InOutQueue(self.petPstID, false)
      return
    end
    local forceMatch = BattleStatHelper.CheckForceMatch(self.petPstID)
    if forceMatch then
      self:InOutQueue(self.petPstID, true)
      return
    end
    local isElementMatch = self:CheckElementMatch(elementType, firstElementType)
    if isElementMatch then
      self:InOutQueue(self.petPstID, true)
    else
      self:InOutQueue(self.petPstID, false)
    end
  end
end

function UIWidgetBattlePet:CheckElementMatch(elementType, firstElementType)
  if self._mainAttr == elementType or self._viceAttr == elementType then
    return true
  end
  if firstElementType ~= nil and (self._mainAttr == firstElementType or self._viceAttr == firstElementType) then
    return true
  end
  return false
end

function UIWidgetBattlePet:_HidePetInfo()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetBattlePet",
    input = "_HidePetInfo",
    args = {}
  })
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  else
    self:OnUpCallback()
  end
end

function UIWidgetBattlePet:_ShowGuideMask(isShow)
  self:_HidePetInfo()
end

function UIWidgetBattlePet:_ShowStoryBanner()
  self:_HidePetInfo()
end

function UIWidgetBattlePet:_ActiveBattlePet()
  if self._touchArea and not self:IsAutoFighting() then
    self._touchArea:SetActive(true)
  end
end

function UIWidgetBattlePet:_UIFeatureSkillInfoShow(bShow, featureType)
  if FeatureType.Card == featureType then
    if self._touchArea then
      if bShow then
        self._touchArea:SetActive(not bShow)
      elseif not self:IsAutoFighting() then
        self._touchArea:SetActive(not bShow)
      end
    end
    self._cardBuffAreaGo:SetActive(bShow)
  end
end

function UIWidgetBattlePet:ShowHideChainSkillCG(petPstID, isShow)
  if petPstID ~= self.petPstID then
    return
  end
  self:_HidePetInfo()
  local s, e = 30, 700
  if not isShow then
    s, e = e, s
  end
  self._goChainSkillIcon.transform:DOAnchorPosX(s, 0.2):OnStart(function()
    if isShow then
      self._goChainSkillIcon:SetActive(true)
      self._offset.gameObject:SetActive(false)
      self._skillReadyGO:SetActive(false)
    end
    self._goChainSkillIcon.transform.anchoredPosition = Vector2(e, 0)
  end):OnComplete(function()
    if not isShow then
      self._goChainSkillIcon:SetActive(false)
      self._offset.gameObject:SetActive(true)
      if self._chainEnergyLights then
        for _, lightItem in ipairs(self._chainEnergyLights) do
          lightItem:DelayedAnimation()
        end
      end
      if self._colorPaletteWidget then
        self._colorPaletteWidget:PlayAnimation()
      end
    end
  end)
end

function UIWidgetBattlePet:CancelSwitchTimer()
  if self._switchTimeEvent then
    Log.notice("CancelSwitchTimer")
    GameGlobal.Timer():CancelEvent(self._switchTimeEvent)
    self._switchTimeEvent = nil
  end
end

function UIWidgetBattlePet:_AutoFight(enable)
  self._autoFightState = enable
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
  end
  if self._touchArea then
    self._touchArea:SetActive(not enable)
  end
end

function UIWidgetBattlePet:GetCanCastAndReason(curSkillID)
  local missonCanCast = false
  local matchModule = GameGlobal.GetModule(MatchModule)
  local enterData = matchModule:GetMatchEnterData()
  if enterData:GetMatchType() == MatchType.MT_Mission then
    local currentMissionId = enterData:GetMissionCreateInfo().mission_id
    local current_mission_cfg = Cfg.cfg_mission[currentMissionId]
    if current_mission_cfg == nil then
      missonCanCast = true
    end
    local missionCanCast = current_mission_cfg.CastSkillLimit
    missonCanCast = missionCanCast
    if not missonCanCast then
      return false, StringTable.Get("str_match_pickup_skill_limit")
    end
  end
  local reasonByBuffSetCanNotReadyReason = BattleStatHelper.CheckCanCastActiveSkill_GetCantReadyReasonByBuff(self:GetPetPstID(), curSkillID)
  if reasonByBuffSetCanNotReadyReason then
    local textKey = ActiveSkillCannotCastReasonText[reasonByBuffSetCanNotReadyReason]
    local text = StringTable.Get(textKey)
    local forceTips = true
    return false, text, forceTips
  end
  if self.skillID == curSkillID then
    local skillConfigData = ConfigServiceHelper.GetSkillConfigData(curSkillID)
    local pickUpType = skillConfigData:GetSkillPickType()
    if pickUpType == SkillPickUpType.PickUpUIAndTrap then
      return false, StringTable.Get("str_battle_spystw_skill"), true
    end
    if not self.isReady then
      return false, StringTable.Get("str_match_cannot_cast_skill_reason")
    end
    if not self:LegendPowerEnoughToCast() then
      local forceTips = true
      return false, StringTable.Get("str_battle_skill_energy_enough"), forceTips
    end
  elseif self.extraSkillInfoDic then
    local uiInfo = self.extraSkillInfoDic[curSkillID]
    if uiInfo and not uiInfo._ready then
      return false, StringTable.Get("str_match_cannot_cast_skill_reason")
    end
  elseif self._variantSkillList then
    if table.icontains(self._variantSkillList, curSkillID) then
      if not self.isReady then
        return false, StringTable.Get("str_match_cannot_cast_skill_reason")
      end
      if not self:LegendPowerEnoughToCast() then
        local forceTips = true
        return false, StringTable.Get("str_battle_skill_energy_enough"), forceTips
      end
    end
  else
    return false, StringTable.Get("str_match_cannot_cast_skill_reason")
  end
  return true, nil
end

function UIWidgetBattlePet:LegendPowerEnoughToCast()
  if self.skillTriggerType == SkillTriggerType.LegendEnergy then
    local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self.skillID, self:GetPetPstID())
    local costLegendPower = skillConfigData:GetSkillTriggerParam()
    costLegendPower = self:_GetLegendPowerConstByExtraParam(costLegendPower, skillConfigData, self._uiBattle:GetCurPickExtraParam(self.skillID))
    if costLegendPower > self.Power then
      return false
    end
  else
  end
  return true
end

function UIWidgetBattlePet:InitLegendEnergySkill()
  self._imageDiamondLight.gameObject:SetActive(false)
  self._imageDiamondBlack.gameObject:SetActive(false)
  self._imageIconA.gameObject:SetActive(true)
  self._imageIconB.gameObject:SetActive(false)
  self._imageIconC.gameObject:SetActive(false)
  self._imageIconD.gameObject:SetActive(false)
end

function UIWidgetBattlePet:InitPassiveSkill()
  if not self._passiveSkillID or self._passiveSkillID == 0 then
    Log.info("passiveSkillCfg is nil! , pettemplateid:", self._petTemplateID)
    self._PassiveSkillGO.gameObject:SetActive(false)
    return
  end
  local passiveSkillCfg = Cfg.cfg_passive_skill[self._passiveSkillID].ShowMethod
  if passiveSkillCfg == nil then
    Log.info("passiveSkillCfg is nil! , pettemplateid:", self._petTemplateID)
    self._PassiveSkillGO.gameObject:SetActive(false)
    return
  end
  self._PassiveSkillGO.gameObject:SetActive(true)
  if passiveSkillCfg[1] == "1" then
    local defaultLight = true
    if passiveSkillCfg[2] == "1" then
      defaultLight = true
    else
      defaultLight = false
    end
    if passiveSkillCfg[3] then
      if passiveSkillCfg[3] == "1" then
        self._imageDiamondLight.sprite = self._uiBattleAtlas:GetSprite("1601561_nina_san_02")
        self._imageDiamondBlack.sprite = self._uiBattleAtlas:GetSprite("1601561_nina_san_01")
        self._imageDiamondLightRect.anchoredPosition = Vector2(26.8, 4.7)
        self._imageDiamondBlackRect.anchoredPosition = Vector2(26.8, 4.7)
      else
        self._imageDiamondLight.sprite = self._uiBattleAtlas:GetSprite("thread_junei_icon8")
        self._imageDiamondBlack.sprite = self._uiBattleAtlas:GetSprite("thread_junei_icon9")
        self._imageDiamondLightRect.anchoredPosition = Vector2(20.5, 4.7)
        self._imageDiamondBlackRect.anchoredPosition = Vector2(20.5, 4.7)
      end
    else
      self._imageDiamondLight.sprite = self._uiBattleAtlas:GetSprite("thread_junei_icon8")
      self._imageDiamondBlack.sprite = self._uiBattleAtlas:GetSprite("thread_junei_icon9")
      self._imageDiamondLightRect.anchoredPosition = Vector2(20.5, 4.7)
      self._imageDiamondBlackRect.anchoredPosition = Vector2(20.5, 4.7)
    end
    self._imageDiamondLight.gameObject:SetActive(defaultLight)
    self._imageDiamondBlack.gameObject:SetActive(not defaultLight)
    self._imageIconA.gameObject:SetActive(false)
    self._imageIconB.gameObject:SetActive(false)
    self._imageIconC.gameObject:SetActive(false)
    self._imageIconD.gameObject:SetActive(false)
    self._txtAccumulate.gameObject:SetActive(false)
    if defaultLight then
      InnerGameHelperRender.UISetUIPetAccumulateNum(self.petPstID, 1)
    else
      InnerGameHelperRender.UISetUIPetAccumulateNum(self.petPstID, 0)
    end
    if not self._attachedActivatePassive then
      self:AttachEvent(GameEventType.ActivatePassive, self.ActivatePassive)
      self._attachedActivatePassive = true
    end
    self._passiveIconInited = true
  end
  if passiveSkillCfg[1] == "2" or passiveSkillCfg[1] == "3" or passiveSkillCfg[1] == "4" then
    self._txtAccumulate.gameObject:SetActive(true)
    self._txtAccumulate:SetText("0")
    self._imageIconA.gameObject:SetActive(false)
    self._imageIconB.gameObject:SetActive(false)
    self._imageIconC.gameObject:SetActive(false)
    self._imageIconD.gameObject:SetActive(false)
    self._imageDiamondLight.gameObject:SetActive(false)
    self._imageDiamondBlack.gameObject:SetActive(false)
    if passiveSkillCfg[2] == "a" then
      if passiveSkillCfg[4] == "1" then
        self._isShowOverload = true
        self._isRed = false
        self._imageIconA.sprite = self._uiBattleAtlas:GetSprite("thread_junei_icon18")
        self._maxAccumulateNum = tonumber(passiveSkillCfg[5])
      end
      self._imageIconA.gameObject:SetActive(true)
    elseif passiveSkillCfg[2] == "b" then
      self._imageIconB.gameObject:SetActive(true)
    elseif passiveSkillCfg[2] == "c" then
      self._imageIconC.gameObject:SetActive(true)
    elseif passiveSkillCfg[2] == "d" then
      self._imageIconD.gameObject:SetActive(true)
    end
    if passiveSkillCfg[1] == "4" then
      self._hideLegendEnergy = true
    end
    if (self:IsIncludeSkillTriggerType(SkillTriggerType.LegendEnergy) or self:IsIncludeSkillTriggerType(SkillTriggerType.AlchemyEnergy)) and not self._hideLegendEnergy then
      self._txtAccumulate1:SetText("0")
      self._imageIconA1.gameObject:SetActive(false)
      self._imageIconB1.gameObject:SetActive(false)
      self._imageIconC1.gameObject:SetActive(false)
      self._imageIconD1.gameObject:SetActive(false)
      self._imageDiamondLight.gameObject:SetActive(false)
      self._imageDiamondBlack.gameObject:SetActive(false)
      if passiveSkillCfg[2] == "a" then
        self._imageIconA1.gameObject:SetActive(true)
      elseif passiveSkillCfg[2] == "b" then
        self._imageIconB1.gameObject:SetActive(true)
      elseif passiveSkillCfg[2] == "c" then
        self._imageIconC1.gameObject:SetActive(true)
      elseif passiveSkillCfg[2] == "d" then
        self._imageIconD1.gameObject:SetActive(true)
      end
    end
    self._PassiveSkillGO.gameObject:SetActive(false)
    if passiveSkillCfg[3] then
      self._showMultiBuffLayer = {}
      local arr = string.split(passiveSkillCfg[3], "|")
      for _, buffID in ipairs(arr) do
        table.insert(self._showMultiBuffLayer, tonumber(buffID))
      end
    end
    self:AttachEvent(GameEventType.SetAccumulateNum, self.SetAccumulateNum)
    self:AttachEvent(GameEventType.ShowOverloadPassiveAccumulate, self._ShowOverloadPassiveAccumulate)
    self._passiveAccumulateInited = true
  end
end

function UIWidgetBattlePet:_ForceInitPassiveIcon(pstId, forceInitType)
  if pstId == self.petPstID and not self._passiveIconInited then
    self._PassiveSkillGO.gameObject:SetActive(true)
    local defaultLight = true
    if forceInitType then
      if forceInitType == 1 then
        self._imageDiamondLight.sprite = self._uiBattleAtlas:GetSprite("1601561_nina_san_02")
        self._imageDiamondBlack.sprite = self._uiBattleAtlas:GetSprite("1601561_nina_san_01")
        self._imageDiamondLightRect.anchoredPosition = Vector2(26.8, 4.7)
        self._imageDiamondBlackRect.anchoredPosition = Vector2(26.8, 4.7)
      elseif forceInitType == 2 then
        self._imageDiamondLight.sprite = self._uiBattleAtlas:GetSprite("thread_junei_icon8")
        self._imageDiamondBlack.sprite = self._uiBattleAtlas:GetSprite("thread_junei_icon9")
        self._imageDiamondLightRect.anchoredPosition = Vector2(20.5, 4.7)
        self._imageDiamondBlackRect.anchoredPosition = Vector2(20.5, 4.7)
      end
    else
      self._imageDiamondLight.sprite = self._uiBattleAtlas:GetSprite("1601561_nina_san_02")
      self._imageDiamondBlack.sprite = self._uiBattleAtlas:GetSprite("1601561_nina_san_01")
      self._imageDiamondLightRect.anchoredPosition = Vector2(26.8, 4.7)
      self._imageDiamondBlackRect.anchoredPosition = Vector2(26.8, 4.7)
    end
    self._imageDiamondLight.gameObject:SetActive(defaultLight)
    self._imageDiamondBlack.gameObject:SetActive(not defaultLight)
    self._imageIconA.gameObject:SetActive(false)
    self._imageIconB.gameObject:SetActive(false)
    self._imageIconC.gameObject:SetActive(false)
    self._imageIconD.gameObject:SetActive(false)
    self._txtAccumulate.gameObject:SetActive(false)
    if defaultLight then
      InnerGameHelperRender.UISetUIPetAccumulateNum(self.petPstID, 1)
    else
      InnerGameHelperRender.UISetUIPetAccumulateNum(self.petPstID, 0)
    end
    if not self._attachedActivatePassive then
      self:AttachEvent(GameEventType.ActivatePassive, self.ActivatePassive)
      self._attachedActivatePassive = true
      self:DetachEvent(GameEventType.SetAccumulateNum, self.SetAccumulateNum)
      self:DetachEvent(GameEventType.ShowOverloadPassiveAccumulate, self._ShowOverloadPassiveAccumulate)
    end
    self._passiveIconInited = true
  end
end

function UIWidgetBattlePet:ActivatePassive(pstId, onOff)
  if pstId == self.petPstID then
    self._imageDiamondLight.gameObject:SetActive(onOff)
    self._imageDiamondBlack.gameObject:SetActive(not onOff)
    local num = onOff and 1 or 0
    InnerGameHelperRender.UISetUIPetAccumulateNum(pstId, num)
  end
end

function UIWidgetBattlePet:_ForceInitPassiveAccumulate(pstId, buffLayerList, forceInitType, maxCount)
  if pstId == self.petPstID and not self._passiveAccumulateInited then
    self._isShowOverload = true
    self._isRed = false
    self._PassiveSkillGO.gameObject:SetActive(false)
    self._txtAccumulate.gameObject:SetActive(true)
    self._txtAccumulate:SetText("0")
    self._imageIconA.gameObject:SetActive(false)
    self._imageIconB.gameObject:SetActive(false)
    self._imageIconC.gameObject:SetActive(false)
    self._imageIconD.gameObject:SetActive(false)
    self._imageDiamondLight.gameObject:SetActive(false)
    self._imageDiamondBlack.gameObject:SetActive(false)
    self._showMultiBuffLayer = {}
    for _, buffID in ipairs(buffLayerList) do
      table.insert(self._showMultiBuffLayer, buffID)
    end
    if forceInitType == 1 then
      self._imageIconA.sprite = self._uiBattleAtlas:GetSprite("thread_junei_icon18")
      self._maxAccumulateNum = maxCount
    end
    self._imageIconA.gameObject:SetActive(true)
    self:AttachEvent(GameEventType.SetAccumulateNum, self.SetAccumulateNum)
    self:AttachEvent(GameEventType.ShowOverloadPassiveAccumulate, self._ShowOverloadPassiveAccumulate)
    self._passiveAccumulateInited = true
  end
end

function UIWidgetBattlePet:_ShowOverloadPassiveAccumulate(pstId, isShowOverload)
  if pstId == self.petPstID then
    self._isShowOverload = isShowOverload
    self:SetAccumulateNum(pstId, 1)
  end
end

function UIWidgetBattlePet:SetAccumulateNum(pstId, num)
  if not pstId or not num then
    return
  end
  if pstId == self.petPstID then
    if self._showMultiBuffLayer and table.count(self._showMultiBuffLayer) > 0 then
      local layer = 0
      local viewInstanceArray = InnerGameHelperRender.GetBuffViewByPetPstID(self.petPstID)
      for i, buffView in ipairs(viewInstanceArray) do
        if table.icontains(self._showMultiBuffLayer, buffView:BuffID()) then
          local curLayer = buffView:GetLayerCount() or 0
          layer = layer + curLayer
        end
      end
      num = layer
    end
    local bothShow = false
    if num <= 0 then
      if (self:IsIncludeSkillTriggerType(SkillTriggerType.LegendEnergy) or self:IsIncludeSkillTriggerType(SkillTriggerType.AlchemyEnergy)) and not self._hideLegendEnergy then
        self._txtAccumulate1.gameObject:SetActive(false)
        bothShow = true
      else
        self._PassiveSkillGO.gameObject:SetActive(false)
      end
    else
      self._PassiveSkillGO.gameObject:SetActive(true)
      if (self:IsIncludeSkillTriggerType(SkillTriggerType.LegendEnergy) or self:IsIncludeSkillTriggerType(SkillTriggerType.AlchemyEnergy)) and not self._hideLegendEnergy then
        self._txtAccumulate1.gameObject:SetActive(true)
        self._txtAccumulate1:SetText(tostring(num))
        bothShow = true
      else
        self._txtAccumulate:SetText(tostring(num))
        if self._maxAccumulateNum then
          local isNeedShowOverload = false
          if self._isShowOverload == false then
            isNeedShowOverload = false
          elseif num >= self._maxAccumulateNum then
            isNeedShowOverload = true
          elseif num < self._maxAccumulateNum then
            isNeedShowOverload = false
          end
          if isNeedShowOverload ~= self._isRed then
            if isNeedShowOverload == true then
              local color = Color.New(0.992156862745098, 0.0470588235294118, 0.0156862745098039, 1)
              self._txtAccumulate.color = color
              self._imageIconA.gameObject:SetActive(false)
              self._imageIconA.sprite = self._uiBattleAtlas:GetSprite("thread_junei_icon19")
              self._imageIconA.gameObject:SetActive(true)
              self._isRed = true
            else
              self._txtAccumulate.color = Color.white
              self._imageIconA.gameObject:SetActive(false)
              self._imageIconA.sprite = self._uiBattleAtlas:GetSprite("thread_junei_icon18")
              self._imageIconA.gameObject:SetActive(true)
              self._isRed = false
            end
          end
        end
      end
    end
    if bothShow then
      InnerGameHelperRender.UISetUIPetPassiveSkillBuffLayerNum(pstId, num)
    else
      InnerGameHelperRender.UISetUIPetAccumulateNum(pstId, num)
    end
  end
end

function UIWidgetBattlePet:OnDown(go)
  self._timerEvent = GameGlobal.Timer():AddEvent(HelperProxy:GetInstance():GetFixTimeLen(277), function()
    self:OnPetPressCallBack()
    self._timerEvent = nil
  end)
end

function UIWidgetBattlePet:_ClosePetInfo()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIShowPetInfo, self.petPstID, false)
end

function UIWidgetBattlePet:OnUp(go)
  Log.debug("UIWidgetBattlePet:OnUp() skillID=", self.skillID)
  if self._isActiveSkillPreviewUI then
    self:_SPActiveChooseMe()
    return
  end
  if self.extraSkillIDList then
    self:OnUpForHasExtraSkill(go)
    return
  end
  if self._variantSkillList then
    self:OnUpForHasVariantSkill(go)
    return
  end
  self._uiBattle._dbgAutoFightInfo = {}
  self._uiBattle._dbgAutoFightInfo.isDead = self.isDead
  if self.isDead then
    self._uiBattle._dbgAutoFightInfo.rtnStep = 1
    return
  end
  local canCastSkill = false
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
    if GuideHelper.DontShowMainSkillMission() then
      self._uiBattle._dbgAutoFightInfo.rtnStep = 2
      return
    end
    canCastSkill = true
  elseif GuideHelper.IsUIGuideShow() and not self._leaveBtn then
    self:TriggerClickCallBack(go)
  end
  if self._autoFightState then
    canCastSkill = true
  end
  if EDITOR then
    local autoTestMd = GameGlobal.GetModule(AutoTestModule)
    if autoTestMd:IsAutoTest() then
      canCastSkill = true
    end
  end
  local perfMD = GameGlobal.GetModule(SkillPerfModule)
  if perfMD:IsPerfCoreGame() then
    canCastSkill = true
  end
  self._uiBattle._dbgAutoFightInfo.canCastSkill = canCastSkill
  local uiPrePetId = self._uiBattle:GetPreviewPetId()
  self._uiBattle._dbgAutoFightInfo.uiPrePetId = uiPrePetId
  self._uiBattle._dbgAutoFightInfo.petPstID = self.petPstID
  self._uiBattle._dbgAutoFightInfo.skillId = self.skillID
  if canCastSkill then
    self:_ClosePetInfo()
  end
  if canCastSkill and self._uiBattle:GetPreviewPetId() ~= self.petPstID then
    local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
    local enableInput = GameGlobal:GetInstance():IsInputEnable()
    self._uiBattle._dbgAutoFightInfo.rtnStep = 3
    self._uiBattle._dbgAutoFightInfo.coreGameStateID = coreGameStateID
    self._uiBattle._dbgAutoFightInfo.enableInput = enableInput
    if coreGameStateID == GameStateID.WaitInput and enableInput == true then
      self._uiBattle._dbgAutoFightInfo.rtnStep = 4
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, self.petPstID)
      self:TriggerClickCallBack(go)
    elseif coreGameStateID == GameStateID.PreviewActiveSkill or coreGameStateID == GameStateID.PickUpActiveSkillTarget then
      self._uiBattle._dbgAutoFightInfo.rtnStep = 5
      if self.isSealedCurse then
        self._csAnimSealedCurseClickBan:Play("uieff_Battle_Banned")
        self._uiBattle._dbgAutoFightInfo.rtnStep = 6
        return
      end
      if InnerGameHelperRender.IsPetSilence(self.petPstID) then
        ToastManager.ShowToast(StringTable.Get(self._silenceForbiddenStr))
        self._uiBattle._dbgAutoFightInfo.rtnStep = 10
        return
      end
      if InnerGameHelperRender.IsPuzzleState() then
        self._uiBattle._dbgAutoFightInfo.rtnStep = 10
        return
      end
      if InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
        self._uiBattle._dbgAutoFightInfo.rtnStep = 10
        return
      end
      self._uiBattle._dbgAutoFightInfo.rtnStep = 7
      if self._switchTimeEvent == nil then
        self._uiBattle._dbgAutoFightInfo.switchTimeEvent = 0
      else
        self._uiBattle._dbgAutoFightInfo.switchTimeEvent = 1
      end
      if self._switchTimeEvent == nil then
        self._uiBattle._dbgAutoFightInfo.rtnStep = 8
        if self.switchCallback then
          self.switchCallback(go)
        end
        if self.clickCallback then
          local condiCheckOk = BattleStatHelper.CheckCanCastActiveSkill_TeamLeaderCondi(self.petPstID, self.skillID)
          local featureSvcCheck = true
          if FeatureServiceHelper.HasFeatureType(FeatureType.Sanity) then
            featureSvcCheck = FeatureServiceHelper.IsActiveSkillCanCastByPstID(self.petPstID, self.skillID, {})
          end
          local minmumConditionCheck = BattleStatHelper.CheckCanCastActiveSkill_MinimumCondition(self.petPstID, self.skillID)
          local cancast = self.isReady and not self.isDead and condiCheckOk and featureSvcCheck
          if cancast == false and BattleStatHelper.OnCheckEntityHasBuffFlag(self.petPstID, BuffFlags.CanOverdraw) then
            cancast = true
          end
          cancast = cancast and minmumConditionCheck
          self.clickCallback(self.petIndex, self.skillID, self.maxPower, self.Power, cancast, go)
        end
        if not self._useSubActiveSkill then
          Log.notice("preclickhead activeskill", self.skillID)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self.skillID)
          self._switchTimeEvent = GameGlobal.Timer():AddEvent(self._switchTimeLength, function()
            GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickPetHead, self.petPstID, self.isReady, self.skillID)
            self._switchTimeEvent = nil
            Log.notice("preview activeskill", self.skillID)
          end)
        end
        GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, self.petPstID)
      else
        Log.notice("still in switch", self.skillID)
        self._uiBattle._dbgAutoFightInfo.rtnStep = 9
      end
    end
  end
  self:OnUpCallback()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
end

function UIWidgetBattlePet:OnUpForHasExtraSkill(go)
  Log.debug("UIWidgetBattlePet:OnUpForHasExtraSkill() skillID=", self.skillID)
  if self.isDead then
    return
  end
  local canCastSkill = false
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
    if GuideHelper.DontShowMainSkillMission() then
      return
    end
    canCastSkill = true
  elseif GuideHelper.IsUIGuideShow() and not self._leaveBtn then
    self:TriggerMultiSkillClickCallBack(go)
  end
  if self._autoFightState then
    canCastSkill = true
  end
  if EDITOR then
    local autoTestMd = GameGlobal.GetModule(AutoTestModule)
    if autoTestMd:IsAutoTest() then
      canCastSkill = true
    end
  end
  local perfMD = GameGlobal.GetModule(SkillPerfModule)
  if perfMD:IsPerfCoreGame() then
    canCastSkill = true
  end
  if canCastSkill then
    self:_ClosePetInfo()
  end
  local uiPrePetId = self._uiBattle:GetPreviewPetId()
  if canCastSkill and self._uiBattle:GetPreviewPetId() ~= self.petPstID then
    local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
    local enableInput = GameGlobal:GetInstance():IsInputEnable()
    if coreGameStateID == GameStateID.WaitInput and enableInput == true then
      Log.debug("UIWidgetBattlePet:OnUpForHasExtraSkill() valid skillID=", self.skillID)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, self.petPstID)
      self:TriggerMultiSkillClickCallBack(go)
    elseif coreGameStateID == GameStateID.PreviewActiveSkill or coreGameStateID == GameStateID.PickUpActiveSkillTarget then
      if self.isSealedCurse then
        self._csAnimSealedCurseClickBan:Play("uieff_Battle_Banned")
        return
      end
      if InnerGameHelperRender.IsPetSilence(self.petPstID) then
        ToastManager.ShowToast(StringTable.Get(self._silenceForbiddenStr))
        return
      end
      if InnerGameHelperRender.IsPuzzleState() then
        return
      end
      if InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
        return
      end
      if self._switchTimeEvent == nil then
        if self.multiSkillSwitchCallback then
          self.multiSkillSwitchCallback(go)
        end
        if self.multiSkillClickCallback then
          local allSkill = {}
          table.insert(allSkill, self.skillID)
          if self.extraSkillIDList then
            table.appendArray(allSkill, self.extraSkillIDList)
          end
          local uiDataArray = {}
          for index, skillId in ipairs(allSkill) do
            local condiCheckOk = BattleStatHelper.CheckCanCastActiveSkill_TeamLeaderCondi(self.petPstID, skillId)
            local featureSvcCheck = true
            local reason
            if FeatureServiceHelper.HasFeatureType(FeatureType.Sanity) then
              featureSvcCheck, reason = FeatureServiceHelper.IsActiveSkillCanCastByPstID(self.petPstID, skillId, {})
            end
            local readyAttr = BattleStatHelper.GetPetSkillReadyAttr(self.petPstID, skillId)
            local bReady = readyAttr and readyAttr == 1
            local cancast = bReady and not self.isDead and condiCheckOk and featureSvcCheck
            local maxPower = self.maxPower
            local curPower = self.Power
            local showAlreadyCast = false
            local showPowerInfo = true
            local uiDataInfo = self.extraSkillInfoDic[skillId]
            if uiDataInfo then
              maxPower = uiDataInfo._maxPower
              curPower = uiDataInfo._power
            end
            cancast = cancast and BattleStatHelper.CheckCanCastActiveSkill_ByExtraParam(self.petPstID, skillId)
            local uiInfo = self._skillCDUiDic[skillId]
            if uiInfo then
              showAlreadyCast = uiInfo._alreadyCastShow
              showPowerInfo = uiInfo._infoShow
            end
            local uiDataSkillInfo = UIDataActiveSkillUIInfo:New(skillId, maxPower, curPower, cancast, showAlreadyCast, showPowerInfo, reason)
            table.insert(uiDataArray, uiDataSkillInfo)
          end
          self.multiSkillClickCallback(self.petIndex, uiDataArray, go, false, self._recordMultiSkillLastClickIndex)
        end
        GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, self.petPstID)
      else
        Log.notice("still in switch", self.skillID)
      end
    else
      Log.debug("UIWidgetBattlePet:OnUpForHasExtraSkill() valid skillID=", self.skillID, " not right state")
    end
  end
  self:OnUpCallback()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
end

function UIWidgetBattlePet:OnUpForHasVariantSkill(go)
  Log.debug("UIWidgetBattlePet:OnUpForHasVariantSkill() skillID=", self.skillID)
  if self.isDead then
    return
  end
  local canCastSkill = false
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
    if GuideHelper.DontShowMainSkillMission() then
      return
    end
    canCastSkill = true
  elseif GuideHelper.IsUIGuideShow() and not self._leaveBtn then
    self:TriggerVariantSkillClickCallBack(go)
  end
  if self._autoFightState then
    canCastSkill = true
  end
  if EDITOR then
    local autoTestMd = GameGlobal.GetModule(AutoTestModule)
    if autoTestMd:IsAutoTest() then
      canCastSkill = true
    end
  end
  local perfMD = GameGlobal.GetModule(SkillPerfModule)
  if perfMD:IsPerfCoreGame() then
    canCastSkill = true
  end
  if canCastSkill then
    self:_ClosePetInfo()
  end
  local uiPrePetId = self._uiBattle:GetPreviewPetId()
  if canCastSkill and self._uiBattle:GetPreviewPetId() ~= self.petPstID then
    local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
    local enableInput = GameGlobal:GetInstance():IsInputEnable()
    if coreGameStateID == GameStateID.WaitInput and enableInput == true then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, self.petPstID)
      self:TriggerVariantSkillClickCallBack(go)
    elseif coreGameStateID == GameStateID.PreviewActiveSkill or coreGameStateID == GameStateID.PickUpActiveSkillTarget then
      if self.isSealedCurse then
        self._csAnimSealedCurseClickBan:Play("uieff_Battle_Banned")
        return
      end
      if InnerGameHelperRender.IsPetSilence(self.petPstID) then
        ToastManager.ShowToast(StringTable.Get(self._silenceForbiddenStr))
        return
      end
      if InnerGameHelperRender.IsPuzzleState() then
        return
      end
      if InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
        return
      end
      if self._switchTimeEvent == nil then
        if self.multiSkillSwitchCallback then
          self.multiSkillSwitchCallback(go)
        end
        if self.multiSkillClickCallback then
          local allSkill = {}
          table.insert(allSkill, self.skillID)
          if self._variantSkillList then
            table.appendArray(allSkill, self._variantSkillList)
          end
          local uiDataArray = {}
          for index, skillId in ipairs(allSkill) do
            local condiCheckOk = BattleStatHelper.CheckCanCastActiveSkill_TeamLeaderCondi(self.petPstID, skillId)
            local featureSvcCheck = true
            local reason
            if FeatureServiceHelper.HasFeatureType(FeatureType.Sanity) then
              featureSvcCheck, reason = FeatureServiceHelper.IsActiveSkillCanCastByPstID(self.petPstID, skillId, {})
            end
            local readyAttr = BattleStatHelper.GetPetSkillReadyAttr(self.petPstID, skillId)
            local bReady = readyAttr and readyAttr == 1
            local cancast = bReady and not self.isDead and condiCheckOk and featureSvcCheck
            local uiDataSkillInfo = UIDataActiveSkillUIInfo:New(skillId, self.maxPower, self.Power, cancast, nil, nil, reason)
            table.insert(uiDataArray, uiDataSkillInfo)
          end
          local isVariantSkillList = true
          self.multiSkillClickCallback(self.petIndex, uiDataArray, go, isVariantSkillList, self._recordMultiSkillLastClickIndex)
        end
        GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, self.petPstID)
      else
        Log.notice("still in switch", self.skillID)
      end
    end
  end
  self:OnUpCallback()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
end

function UIWidgetBattlePet:OnLeave()
  self._leaveBtn = true
  self:_HidePetInfo()
end

function UIWidgetBattlePet:OnEnter()
  self._leaveBtn = false
end

function UIWidgetBattlePet:TriggerClickCallBack(go)
  if self.isSealedCurse then
    self._csAnimSealedCurseClickBan:Play("uieff_Battle_Banned")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, nil)
    return
  end
  if InnerGameHelperRender.IsPetSilence(self.petPstID) then
    ToastManager.ShowToast(StringTable.Get(self._silenceForbiddenStr))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, nil)
    return
  end
  if InnerGameHelperRender.IsPuzzleState() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, nil)
    return
  end
  if InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, nil)
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self.skillID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HideCanMoveArrow)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickPetHead, self.petPstID, self.isReady, self.skillID)
  if self.clickCallback then
    local condiCheckOk = BattleStatHelper.CheckCanCastActiveSkill_TeamLeaderCondi(self.petPstID, self.skillID)
    local featureSvcCheck = true
    if FeatureServiceHelper.HasFeatureType(FeatureType.Sanity) then
      featureSvcCheck = FeatureServiceHelper.IsActiveSkillCanCastByPstID(self.petPstID, self.skillID, {})
    end
    local cancast = self.isReady and not self.isDead and condiCheckOk and featureSvcCheck
    if cancast == false and BattleStatHelper.OnCheckEntityHasBuffFlag(self.petPstID, BuffFlags.CanOverdraw) then
      cancast = true
    end
    if cancast then
      local minmumConditionCheck = BattleStatHelper.CheckCanCastActiveSkill_MinimumCondition(self.petPstID, self.skillID)
      cancast = minmumConditionCheck
    end
    self.clickCallback(self.petIndex, self.skillID, self.maxPower, self.Power, cancast, go)
  end
end

function UIWidgetBattlePet:TriggerMultiSkillClickCallBack(go)
  if self.isSealedCurse then
    self._csAnimSealedCurseClickBan:Play("uieff_Battle_Banned")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, nil)
    return
  end
  if InnerGameHelperRender.IsPetSilence(self.petPstID) then
    ToastManager.ShowToast(StringTable.Get(self._silenceForbiddenStr))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, nil)
    return
  end
  if InnerGameHelperRender.IsPuzzleState() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, nil)
    return
  end
  if InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, nil)
    return
  end
  if self.multiSkillClickCallback then
    local allSkill = {}
    table.insert(allSkill, self.skillID)
    if self.extraSkillIDList then
      table.appendArray(allSkill, self.extraSkillIDList)
    end
    local uiDataArray = {}
    for index, skillId in ipairs(allSkill) do
      local condiCheckOk = BattleStatHelper.CheckCanCastActiveSkill_TeamLeaderCondi(self.petPstID, skillId)
      local featureSvcCheck = true
      local reason
      if FeatureServiceHelper.HasFeatureType(FeatureType.Sanity) then
        featureSvcCheck, reason = FeatureServiceHelper.IsActiveSkillCanCastByPstID(self.petPstID, skillId, {})
      end
      local readyAttr = BattleStatHelper.GetPetSkillReadyAttr(self.petPstID, skillId)
      local bReady = readyAttr and readyAttr == 1
      local cancast = bReady and not self.isDead and condiCheckOk and featureSvcCheck
      local maxPower = self.maxPower
      local curPower = self.Power
      local showAlreadyCast = false
      local showPowerInfo = true
      local uiDataInfo = self.extraSkillInfoDic[skillId]
      if uiDataInfo then
        maxPower = uiDataInfo._maxPower
        curPower = uiDataInfo._power
      end
      cancast = cancast and BattleStatHelper.CheckCanCastActiveSkill_ByExtraParam(self.petPstID, skillId)
      local uiInfo = self._skillCDUiDic[skillId]
      if uiInfo then
        showAlreadyCast = uiInfo._alreadyCastShow
        showPowerInfo = uiInfo._infoShow
      end
      local uiDataSkillInfo = UIDataActiveSkillUIInfo:New(skillId, maxPower, curPower, cancast, showAlreadyCast, showPowerInfo, reason)
      table.insert(uiDataArray, uiDataSkillInfo)
    end
    self.multiSkillClickCallback(self.petIndex, uiDataArray, go, false, self._recordMultiSkillLastClickIndex)
  end
end

function UIWidgetBattlePet:TriggerVariantSkillClickCallBack(go)
  if self.isSealedCurse then
    self._csAnimSealedCurseClickBan:Play("uieff_Battle_Banned")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, nil)
    return
  end
  if InnerGameHelperRender.IsPetSilence(self.petPstID) then
    ToastManager.ShowToast(StringTable.Get(self._silenceForbiddenStr))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, nil)
    return
  end
  if InnerGameHelperRender.IsPuzzleState() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, nil)
    return
  end
  if InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UISetLastPreviewPetId, nil)
    return
  end
  if self.multiSkillClickCallback then
    local allSkill = {}
    table.insert(allSkill, self.skillID)
    if self._variantSkillList then
      table.appendArray(allSkill, self._variantSkillList)
    end
    local uiDataArray = {}
    for index, skillId in ipairs(allSkill) do
      local condiCheckOk = BattleStatHelper.CheckCanCastActiveSkill_TeamLeaderCondi(self.petPstID, skillId)
      local featureSvcCheck = true
      local reason
      if FeatureServiceHelper.HasFeatureType(FeatureType.Sanity) then
        featureSvcCheck, reason = FeatureServiceHelper.IsActiveSkillCanCastByPstID(self.petPstID, skillId, {})
      end
      local readyAttr = BattleStatHelper.GetPetSkillReadyAttr(self.petPstID, skillId)
      local bReady = readyAttr and readyAttr == 1
      local cancast = bReady and not self.isDead and condiCheckOk and featureSvcCheck
      cancast = cancast and BattleStatHelper.CheckCanCastActiveSkill_ByExtraParam(self.petPstID, skillId)
      local uiDataSkillInfo = UIDataActiveSkillUIInfo:New(skillId, self.maxPower, self.Power, cancast, nil, nil, reason)
      table.insert(uiDataArray, uiDataSkillInfo)
    end
    local isVariantSkillList = true
    self.multiSkillClickCallback(self.petIndex, uiDataArray, go, isVariantSkillList, self._recordMultiSkillLastClickIndex)
  end
end

function UIWidgetBattlePet:_OnChangePetActiveSkill(pstId, skillID)
  if pstId ~= self.petPstID then
    return
  end
  self:_RefreshPowerUiDicOnSkillIdChanged(self.skillID, skillID)
  self.skillID = skillID
  self:_RefreshVariantSkillIDList()
end

function UIWidgetBattlePet:_RefreshPowerUiDicOnSkillIdChanged(curSkillId, newSkillId)
  if newSkillId == curSkillId then
    return
  end
  self._skillCDUiDic[newSkillId] = self._skillCDUiDic[curSkillId]
  self._skillCDUiDic[curSkillId] = nil
end

function UIWidgetBattlePet:_OnChangePetExtraActiveSkill(pstId, oriSkillID, skillID)
  if pstId ~= self.petPstID then
    return
  end
  if self.extraSkillIDList then
    local newSkillList = {}
    for index, id in ipairs(self.extraSkillIDList) do
      if id == oriSkillID then
        table.insert(newSkillList, skillID)
      else
        table.insert(newSkillList, id)
      end
    end
    self.extraSkillIDList = newSkillList
    local data = self.extraSkillInfoDic[oriSkillID]
    self.extraSkillInfoDic[oriSkillID] = nil
    self.extraSkillInfoDic[skillID] = data
    self:_RefreshPowerUiDicOnSkillIdChanged(oriSkillID, skillID)
    data._skillId = skillID
    local buffLimit = self._isBuffSetCanNotReadyForExtra[oriSkillID]
    if buffLimit then
      self._isBuffSetCanNotReadyForExtra[oriSkillID] = nil
      self._isBuffSetCanNotReadyForExtra[skillID] = buffLimit
    end
  end
end

function UIWidgetBattlePet:_OnSealedCurseFlagChanged(pstId, isCursed, buffSeq, duration, noMaxRound)
  if pstId ~= self.petPstID then
    return
  end
  if not self.isSealedCurse and not isCursed then
    return
  end
  if self.isOverload then
    if isCursed then
      self._overloadPos1GO:SetActive(false)
      self._overloadPos2GO:SetActive(true)
    else
      self._overloadPos1GO:SetActive(true)
      self._overloadPos2GO:SetActive(false)
    end
  end
  self.isSealedCurse = isCursed
  self.sealedCurseBuffSeq = buffSeq
  self._goSealedCurseDuration:SetActive(true)
  local s = noMaxRound and "∞" or tostring(duration)
  self._sealedCurseDurationText:SetText(s)
  local key = isCursed and "uieff_zuzhoubuff_01" or "uieff_zuzhoubuff_03"
  self._csAnimSealedCurse:Play(key)
  self:_CheckShowPowerfullRoundCountUI()
end

function UIWidgetBattlePet:_OnSetActiveSkillCanNotReady(pstId, isCanNotReady, buffSeq, extraSkillID)
  if pstId ~= self.petPstID then
    return
  end
  if extraSkillID then
    self._isBuffSetCanNotReadyForExtra[extraSkillID] = isCanNotReady
  else
    self._isBuffSetCanNotReady = isCanNotReady
  end
end

function UIWidgetBattlePet:_OnShowTeamLeaderChangeUI(isShow)
  if not self.isSealedCurse then
    return
  end
  self._goSealedCurseDuration:SetActive(not isShow)
end

function UIWidgetBattlePet:_OnBuffRoundCountChanged(buffseq, roundcount, noMaxRound)
  if not self.isSealedCurse then
    return
  end
  if buffseq ~= self.sealedCurseBuffSeq then
    return
  end
  local s = noMaxRound and "∞" or tostring(roundcount)
  self._sealedCurseDurationText:SetText(s)
end

function UIWidgetBattlePet:ShowHideSelectTeamPositionButton(pstID, bShow)
  if self:IsSelfHelpPet() then
    Log.info(self._className, "help pet do not show select team position button. ")
    self._goSelectTeamPositionButton:SetActive(false)
    self:_CheckShowPowerfullRoundCountUI()
    return
  end
  if self.isSealedCurse then
    Log.info(self._className, "cursed pet do not show select team position button. ")
    self._goSelectTeamPositionButton:SetActive(false)
    self:_CheckShowPowerfullRoundCountUI()
    return
  end
  if self.petPstID == pstID then
    Log.info(self._className, "do not show select team position button on caster itself. ")
    self._goSelectTeamPositionButton:SetActive(false)
    self:_CheckShowPowerfullRoundCountUI()
    return
  end
  Log.debug(self._className, "ShowHideSelectTeamPositionButton: ", tostring(bShow))
  self._goSelectTeamPositionButton:SetActive(bShow)
  self:GetGameObject("SelectTeamPosDefault"):SetActive(true)
  self:GetGameObject("SelectTeamPosSelected"):SetActive(false)
  self:InOutQueue(self.petPstID, false)
  self:_CheckShowPowerfullRoundCountUI()
end

function UIWidgetBattlePet:SelectTeamPosOnClick(go)
  if self:IsSelfHelpPet() then
    Log.info(self._className, "help pet do not show select team position button. ")
    self._goSelectTeamPositionButton:SetActive(false)
    return
  end
  if self.isSealedCurse then
    Log.info(self._className, "cursed pet do not show select team position button. ")
    self._goSelectTeamPositionButton:SetActive(false)
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleUISelectTargetTeamPosition, self.petPstID)
end

function UIWidgetBattlePet:OnBattleUISelectTargetTeamPosition(pstID)
  if self.petPstID == pstID then
    self:InOutQueue(self.petPstID, true)
    self:GetGameObject("SelectTeamPosDefault"):SetActive(false)
    self:GetGameObject("SelectTeamPosSelected"):SetActive(true)
  else
    self:InOutQueue(self.petPstID, false)
    self:GetGameObject("SelectTeamPosDefault"):SetActive(true)
    self:GetGameObject("SelectTeamPosSelected"):SetActive(false)
  end
end

function UIWidgetBattlePet:SetUseSubActiveSkillState(useSubActiveSkill)
  self._useSubActiveSkill = useSubActiveSkill
end

function UIWidgetBattlePet:_SetPetOverloadState(state, petPstID)
  if self.petPstID ~= petPstID then
    return
  end
  if state == 1 then
    self.isOverload = true
    self._overloadRootGo:SetActive(true)
    if self.isSealedCurse then
      self._overloadPos2GO:SetActive(true)
    else
      self._overloadPos1GO:SetActive(true)
    end
  else
    self.isOverload = false
    self._overloadRootGo:SetActive(false)
    self._overloadPos1GO:SetActive(false)
    self._overloadPos2GO:SetActive(false)
  end
end

function UIWidgetBattlePet:_OnFeatureListInit(featureListInfo)
  if featureListInfo then
    for i, v in ipairs(featureListInfo) do
      local featureType = v:GetFeatureType()
      if featureType == FeatureType.Card then
        local cardData = v
        local cardUiType = cardData:GetUiType()
        self._featureCardUiType = cardUiType
        if cardUiType == FeatureCardUiType.Default then
        elseif cardUiType == FeatureCardUiType.Skin1 then
          self._cardFlyEffGo = self:GetGameObject("CardFlyEff_l")
        end
      end
    end
  end
end

function UIWidgetBattlePet:_OnFeaturePetUIAddCardBuff(pstId, buffType)
  if pstId ~= self.petPstID then
    return
  end
  if self._featureCardBuffState == 0 then
    self._featureCardBuffState = buffType
  elseif self._featureCardBuffState == 1 then
    if buffType == 2 then
      self._featureCardBuffState = 3
    end
  elseif self._featureCardBuffState == 2 and buffType == 1 then
    self._featureCardBuffState = 3
  end
  self:_RefreshFeatureCardBuffIcon(self._featureCardBuffState)
  self:UIAnimOnAddCardBuffFlyEff()
  self:UIAnimOnAddCardBuff()
end

function UIWidgetBattlePet:_OnFeaturePetUIPreviewAddCardBuff(pstId, buffType)
  if pstId ~= self.petPstID then
    return
  end
  local previewCardState = self._featureCardBuffState
  if previewCardState == 0 then
    previewCardState = buffType
  elseif previewCardState == 1 then
    if buffType == 2 then
      previewCardState = 3
    end
  elseif previewCardState == 2 and buffType == 1 then
    previewCardState = 3
  end
  self:_RefreshFeatureCardBuffIcon(previewCardState)
  self:UIAnimOnPreviewAddCardBuff()
end

function UIWidgetBattlePet:_OnFeaturePetUIPreviewRecoverCardBuff()
  self:_RefreshFeatureCardBuffIcon(self._featureCardBuffState)
end

function UIWidgetBattlePet:_RefreshFeatureCardBuffIcon(state)
  if state == 0 then
    for key, iconGo in ipairs(self._featureCardBuffIconGoDic) do
      if key == state then
        iconGo:SetActive(true)
      else
        iconGo:SetActive(false)
      end
    end
    self._cardBuffEffGo:SetActive(false)
  else
    self._cardBuffAreaGo:SetActive(true)
    for key, iconGo in ipairs(self._featureCardBuffIconGoDic) do
      if key == state then
        iconGo:SetActive(true)
      else
        iconGo:SetActive(false)
      end
    end
  end
  self:_CheckShowPowerfullRoundCountUI()
end

function UIWidgetBattlePet:OnPetPressCallBack()
  if self._isActiveSkillPreviewUI then
    return
  end
  if BattleStatHelper.GetAutoFightStat() then
    ToastManager.ShowToast(self._autoFightForbiddenStr)
  elseif InnerGameHelperRender.IsPuzzleState() then
    return
  elseif InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
    return
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIShowPetInfo, self.petPstID, true)
  end
end

function UIWidgetBattlePet:OnUpCallback()
end

function UIWidgetBattlePet:UIAnimOnAddCardBuff()
  local animName = "CardBuffArea"
  if self._featureCardUiType and self._featureCardUiType == FeatureCardUiType.Skin1 then
    animName = "CardBuffArea_f"
  end
  if animName then
    local player = EZTL_Player:New()
    local tl = EZTL_Sequence:New({
      EZTL_Wait:New(2700, ""),
      EZTL_PlayAnimation:New(self._cardBuffAnim, animName),
      EZTL_Callback:New(function()
      end)
    }, "卡牌buff动效")
    player:Play(tl)
    table.insert(self._players, player)
  end
end

function UIWidgetBattlePet:UIAnimOnPreviewAddCardBuff()
  local animName = "CardBuffArea_1"
  if self._featureCardUiType and self._featureCardUiType == FeatureCardUiType.Skin1 then
    animName = "CardBuffArea_1_f"
  end
  if animName then
    local player = EZTL_Player:New()
    local tl = EZTL_Sequence:New({
      EZTL_PlayAnimation:New(self._cardBuffAnim, animName),
      EZTL_Callback:New(function()
      end)
    }, "卡牌buff动效预览")
    player:Play(tl)
    table.insert(self._players, player)
  end
end

function UIWidgetBattlePet:UIAnimOnAddCardBuffFlyEff()
  local beginPos = self._uiBattle:GetUIFeatureCardBuffEffBeginPos()
  local targetPos = self._cardBuffEffPosRect.position
  self._cardFlyEffGo.transform.position = beginPos
  if self._cardEffTimerHandler then
    GameGlobal.Timer():CancelEvent(self._cardEffTimerHandler)
    self._cardEffTimerHandler = nil
  end
  local delayMs = 1700
  self._cardEffTimerHandler = GameGlobal.Timer():AddEvent(delayMs, function()
    self._cardFlyEffGo:SetActive(true)
    self._cardFlyEffGo.transform:DOMove(targetPos, 1):SetEase(DG.Tweening.Ease.InQuart):OnComplete(function()
      self._cardFlyEffGo:SetActive(false)
    end)
  end)
end

function UIWidgetBattlePet:IsAutoFighting()
  return GameGlobal.GetUIModule(MatchModule):IsAutoFighting()
end

function UIWidgetBattlePet:_OnShowPowerfullRoundCountUI(pstId, bShow, resDic)
  if pstId ~= self.petPstID then
    return
  end
  if bShow then
    if self._powerfullRoundCountAreaGO then
      self._showPowerfullRoundCount = true
      if self._powerfullRoundCountImg then
        local count = BattleStatHelper.GetPreviousReadyRoundCount(pstId)
        if resDic and resDic[count] then
          self._powerfullRoundCountImg.sprite = self._uiBattle1Atlas:GetSprite(resDic[count])
        end
      end
      self:_CheckShowPowerfullRoundCountUI()
    end
  elseif self._powerfullRoundCountAreaGO then
    self._powerfullRoundCountAreaGO:SetActive(false)
    self._showPowerfullRoundCount = false
  end
end

function UIWidgetBattlePet:_CheckShowPowerfullRoundCountUI()
  if self._powerfullRoundCountAreaGO then
    if self._showPowerfullRoundCount then
      local canShow = false
      if self._goSelectTeamPositionButton and self._goSelectTeamPositionButton.activeSelf then
      elseif self.isSealedCurse then
      elseif self._cardBuffAreaGo and self._cardBuffAreaGo.activeSelf then
      else
        canShow = true
      end
      self._powerfullRoundCountAreaGO:SetActive(canShow)
    else
      self._powerfullRoundCountAreaGO:SetActive(false)
    end
  end
end

function UIWidgetBattlePet:_OnScanFeatureReplaceUIActiveSkillID(pstID, activeSkillID, isReady, previouslyReady)
  if self.petPstID ~= pstID then
    return
  end
  self.skillID = activeSkillID
  self:_RefreshVariantSkillIDList()
  self:OnChangeLegendPower(self.Power)
  if isReady == 1 then
    local playReminder = not self.isReady or not isReady
    self:OnPowerReady(playReminder, previouslyReady)
  else
    self:OnPowerCancelReady(0)
  end
end

function UIWidgetBattlePet:_OnUIMultiActiveSkillCastClick(pstID, activeSkillID, isReady)
  if self.petPstID ~= pstID then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, activeSkillID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HideCanMoveArrow)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickPetHead, self.petPstID, isReady, activeSkillID)
end

function UIWidgetBattlePet:_OnUIMultiSkillClickIndex(pstID, index)
  if self.petPstID ~= pstID then
    return
  end
  self._recordMultiSkillLastClickIndex = index
end

function UIWidgetBattlePet:IsExtraSkillHasReady()
  if self.extraSkillIDList then
    for skillId, skillInfo in pairs(self.extraSkillInfoDic) do
      local uiInfo = skillInfo
      if uiInfo._ready then
        return true
      end
    end
  end
  return false
end

function UIWidgetBattlePet:IsIncludeSkillTriggerType(skillTriggerType)
  if self.skillTriggerType == skillTriggerType then
    return true
  elseif self.extraSkillIDList then
    for skillId, skillInfo in pairs(self.extraSkillInfoDic) do
      local uiInfo = skillInfo
      if uiInfo._skillTriggerType == skillTriggerType then
        return true
      end
    end
  end
  return false
end

function UIWidgetBattlePet:ShowHideUiMultiPowerInfoByIndex(index, bShow)
  if self._multiSkillCDUi then
    local uiInfo = self._multiSkillCDUi[index]
    if uiInfo then
      uiInfo._infoGo:SetActive(bShow)
      uiInfo._infoShow = bShow
    end
  end
end

function UIWidgetBattlePet:_SPActiveChooseMe()
  if self._needShowUIIcon then
    self._bChoose = true
    self._spActiveAnim:Play("uieff_SPActive_select")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.IstavanPreviewChoosePetHeadUI, self:PstID())
  end
end

function UIWidgetBattlePet:_OnIstavanCancelPetHeadPreviewUI(clear, petPstID)
  if clear then
    self._spActiveAnim:Play("uieff_SPActive_out")
    self._spActiveGO:SetActive(false)
    self._spDefaultGO:SetActive(false)
    self._spChooseGO:SetActive(false)
    self._isActiveSkillPreviewUI = false
    self._needShowUIIcon = false
    self._spAlreadyGO:SetActive(false)
  elseif self:PstID() ~= petPstID and self._needShowUIIcon and self._bChoose == true then
    self._spActiveAnim:Play("uieff_SPActive_unselect")
    self._spAlreadyGO:SetActive(false)
    self._bChoose = false
  end
end

function UIWidgetBattlePet:_OnIstavanShowPetHeadPreviewUI(petList)
  if petList[self:PstID()] then
    local value = petList[self:PstID()]
    self._spActiveGO:SetActive(true)
    self._spPowerNumText.text = value
    self._needShowUIIcon = true
    self:OnChangeHeadAlpha(BattleConst.ActiveSkillDarkAlpha)
    if InnerGameHelperRender.IsPetHasBeCastExtraChainFlag(self:PstID()) then
      self._spAlreadyGO:SetActive(true)
      self._spAlreadyAnim:Play("uieff_SPYistawan_skill_On")
    end
    self._bChoose = false
  end
  self:OnChangeHeadAlpha(0)
  self._isActiveSkillPreviewUI = true
end
