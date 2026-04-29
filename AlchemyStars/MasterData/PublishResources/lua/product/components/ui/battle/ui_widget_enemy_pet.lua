_class("UIWidgetEnemyPet", UICustomWidget)
UIWidgetEnemyPet = UIWidgetEnemyPet

function UIWidgetEnemyPet:OnShow()
  self._uiBattleAtlas = self:GetAsset("InnerUI.spriteatlas", LoadType.SpriteAtlas)
  self.petIndex = 0
  self.petPstID = 0
  self._showMultiBuffLayer = nil
  self._offset = self:GetUIComponent("RectTransform", "offset")
  self._tweenerOffset = nil
  local effCharge = self:GetGameObject("EffCharge").transform
  self._effCharge = UIHelper.GetGameObject("UIEff_UIWidgetBattlePet_Charge_N7.prefab")
  self._effCharge.transform:SetParent(effCharge, false)
  self.txtEnergy = self:GetUIComponent("UILocalizationText", "CurEnergyText")
  self._PassiveSkillGO = self:GetGameObject("PassiveSkill")
  self._txtAccumulate = self:GetUIComponent("UILocalizationText", "AccumulateTxt")
  self._txtAccumulate1 = self:GetUIComponent("UILocalizationText", "AccumulateTxt1")
  self._imageIconA = self:GetUIComponent("Image", "ImageIconA")
  self._imageIconA1 = self:GetUIComponent("Image", "ImageIconA1")
  self._imageIconB = self:GetUIComponent("Image", "ImageIconB")
  self._imageIconB1 = self:GetUIComponent("Image", "ImageIconB1")
  self._imageIconC = self:GetUIComponent("Image", "ImageIconC")
  self._imageIconC1 = self:GetUIComponent("Image", "ImageIconC1")
  self._imageDiamondBlack = self:GetUIComponent("Image", "ImageDiamondBlack")
  self._imageDiamondLight = self:GetUIComponent("Image", "ImageDiamondLight")
  self._imageDiamondBlackRect = self:GetUIComponent("RectTransform", "ImageDiamondBlack")
  self._imageDiamondLightRect = self:GetUIComponent("RectTransform", "ImageDiamondLight")
  self.headMask = self:GetUIComponent("Image", "headMask")
  self.headIcon = self:GetUIComponent("RawImageLoader", "HeadIcon")
  self._imgChainSkillIcon = self:GetUIComponent("RawImageLoader", "imgChainSkillIcon")
  self._goChainSkillReady = self:GetGameObject("ChainSkillReady")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._attrMain = self:GetUIComponent("Image", "Attribute")
  self._attrVice = self:GetUIComponent("Image", "Attribute2")
  self._touchArea = self:GetGameObject("TouchArea")
  self._touchArea:SetActive(false)
  self.powerFull = self:GetGameObject("EffPowerFull")
  self.powerFull:SetActive(false)
  self._rootAnimation = self:GetUIComponent("Animation", "root")
  self._addCdAnimation = false
  self._skillReadyGO = self:GetGameObject("UISkillReadyN7")
  self._skillReadyBG = self:GetUIComponent("Image", "skillReadyBG")
  self._skillReadyBGAtlas = self:GetAsset("UISkillReady.spriteatlas", LoadType.SpriteAtlas)
  self.alreadyCastActiveImage = self:GetGameObject("AlreadyCastActiveImage")
  self.alreadyCastActiveImage:SetActive(false)
  self._cdGO = self:GetGameObject("CD")
  local etl = UICustomUIEventListener.Get(self._touchArea)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    self.clickCallback(go)
  end)
  self.isReady = false
  self.skillID = nil
  self.Power = 0
  self._petTemplateID = -1
  self.skillTriggerType = SkillTriggerType.Energy
  self:AttachEvent(GameEventType.InOutQueue, self.InOutQueue)
  self:AttachEvent(GameEventType.FlushPetChainSkillItem, self.FlushPetChainSkillItem)
  self:AttachEvent(GameEventType.ShowHideChainSkillCG, self.ShowHideChainSkillCG)
  self:AttachEvent(GameEventType.ShowStoryBanner, self._ShowStoryBanner)
  self:AttachEvent(GameEventType.ActiveBattlePet, self._ActiveBattlePet)
  self:AttachEvent(GameEventType.ChangePetActiveSkill, self._OnChangePetActiveSkill)
  self:AttachEvent(GameEventType.EnemyPetCastActiveSkill, self.OnCastActiveSkill)
end

function UIWidgetEnemyPet:OnHide()
  UIHelper.DestroyGameObject(self._effCharge)
end

function UIWidgetEnemyPet:SetData(index, petData, clickCallback)
  self.uiid = index
  self.petIndex = index
  self.petPstID = petData:GetPstID()
  self._petTemplateID = petData:GetTemplateID()
  self.skillID = petData:GetPetActiveSkill()
  self._passiveSkillID = petData:GetPetPassiveSkill()
  self.clickCallback = clickCallback
  local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self.skillID, self.petPstID)
  self.skillTriggerType = skillConfigData:GetSkillTriggerType()
  local triggerPower = skillConfigData:GetSkillTriggerParam()
  self.maxPower = triggerPower
  if self.skillTriggerType == SkillTriggerType.LegendEnergy then
    self:OnChangeLegendPower(0)
  else
    self:OnChangePower(triggerPower)
    if self.Power == 0 then
      self:OnPowerReady(true)
    end
  end
  local headIconName = petData:GetPetHead(PetSkinEffectPath.HEAD_ICON_CHAIN_SKILL_PREVIEW)
  self.headIcon:LoadImage(headIconName)
  local bodyName = petData:GetPetTeamBody(PetSkinEffectPath.CARD_TEAM)
  self._imgChainSkillIcon:LoadImage(bodyName)
  self:ShowElement(petData)
  self._mainAttr = petData:GetPetFirstElement()
  self._viceAttr = petData:GetPetSecondElement()
  self.petElement = petData:GetPetFirstElement()
  self:ShowHideChainSkillCG(self.petPstID, false)
  self:InitPassiveSkill()
  if self.skillTriggerType == SkillTriggerType.LegendEnergy then
    self:InitLegendEnergySkill()
  end
  self:InitSkillReadyEff()
end

function UIWidgetEnemyPet:InitSkillReadyEff()
  local element2Color = {
    [1] = "sprite_skill_shui",
    [2] = "sprite_skill_huo",
    [3] = "sprite_skill_sen",
    [4] = "sprite_skill_lei"
  }
  local animationName = element2Color[self.petElement]
  self._skillReadyBG.sprite = self._skillReadyBGAtlas:GetSprite(animationName)
end

function UIWidgetEnemyPet:OnChangePower(power, effect)
  if self.skillTriggerType == SkillTriggerType.LegendEnergy then
    self.Power = power
    self._cdGO:SetActive(false)
    return
  end
  if power <= 0 then
    power = 0
  end
  if self.Power == 0 then
    if GuideHelper.DontShowMainSkillMission() then
      self._cdGO:SetActive(false)
    else
      self._cdGO:SetActive(power ~= 0)
    end
  end
  if self.isReady or self.Power == 0 then
    self.alreadyCastActiveImage:SetActive(false)
  end
  self.txtEnergy:SetText(tostring(power))
  if self.Power == power then
    return
  end
  self.Power = power
  self:_OnPlayPowerAddEffect(effect)
end

function UIWidgetEnemyPet:OnChangeLegendPower(power, effect)
  if self.skillTriggerType ~= SkillTriggerType.LegendEnergy then
    return
  end
  self._cdGO:SetActive(false)
  self.alreadyCastActiveImage:SetActive(false)
  self._PassiveSkillGO.gameObject:SetActive(true)
  self._txtAccumulate.gameObject:SetActive(power ~= 0)
  self._txtAccumulate:SetText(tostring(power))
  if self.Power == power then
    return
  end
  self.Power = power
end

function UIWidgetEnemyPet:_OnPlayPowerAddEffect(effect)
  if self.Power > 0 then
    self._effCharge:SetActive(false)
    if effect then
      self._effCharge:SetActive(true)
    end
  end
end

function UIWidgetEnemyPet:OnPowerReady(playReminder)
  self.powerFull:SetActive(true)
  if playReminder then
    InnerGameHelperRender.InnerGamePlayPetUIVoice("Charge", self._petTemplateID)
    self._skillReadyGO:SetActive(false)
    self._skillReadyGO:SetActive(true)
  end
  self._cdGO:SetActive(false)
  self.isReady = true
  if self.skillTriggerType ~= SkillTriggerType.LegendEnergy then
    self.Power = 0
    self._addCdAnimation = false
  end
end

function UIWidgetEnemyPet:OnPowerCancelReady(addCdAnimation)
  self.powerFull:SetActive(false)
  self.isReady = false
  if self.skillTriggerType ~= SkillTriggerType.LegendEnergy then
    self._cdGO:SetActive(true)
    if addCdAnimation ~= 0 then
      self._addCdAnimation = true
    end
  end
end

function UIWidgetEnemyPet:OnShowPetInfoInish()
  if not self._addCdAnimation then
    return
  end
  self._addCdAnimation = false
  self._rootAnimation:Play("uieff_jiacdbuff")
end

function UIWidgetEnemyPet:FlushIndex(idx)
  self.petIndex = idx
end

function UIWidgetEnemyPet:IsMyPet(petPstID)
  if self.petPstID == petPstID then
    return true
  end
  return false
end

function UIWidgetEnemyPet:GetPetPstID()
  return self.petPstID
end

function UIWidgetEnemyPet:GetSkillID()
  return self.skillID
end

function UIWidgetEnemyPet:Index()
  return self.uiid
end

function UIWidgetEnemyPet:OnCastActiveSkill(pstid)
  if self.petPstID == pstid then
    local pm = GameGlobal.GetModule(PetAudioModule)
    InnerGameHelperRender.InnerGamePlayPetUIVoice("Skill", self._petTemplateID, true)
    self:ClearPower()
  end
end

function UIWidgetEnemyPet:ClearPower()
  if self.skillTriggerType == SkillTriggerType.LegendEnergy then
    local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self.skillID, self.petPstID)
    self.Power = self.Power - skillConfigData:GetSkillTriggerParam()
    if self.Power < skillConfigData:GetSkillTriggerParam() then
      self.isReady = false
      self.powerFull:SetActive(false)
    end
    self:OnChangeLegendPower(self.Power, nil)
  else
    self.Power = 0
    self.isReady = false
    self.powerFull:SetActive(false)
    self.alreadyCastActiveImage:SetActive(true)
  end
end

function UIWidgetEnemyPet:ShowElement(pet)
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

function UIWidgetEnemyPet:InOutQueue(petPstID, out)
  if petPstID ~= self.petPstID then
    return
  end
  if self._tweenerOffset then
    self._tweenerOffset:Complete()
  end
  local duration = 0.2
  local offsetEndX = 0
  if out then
    offsetEndX = 25
  end
  self._tweenerOffset = self._offset:DOAnchorPosX(offsetEndX, duration)
end

function UIWidgetEnemyPet:FlushPetChainSkillItem(isLocalTeam, chainPathLen, elementType)
  if isLocalTeam then
    return
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
  elseif self._mainAttr ~= elementType and self._viceAttr ~= elementType or self.isSealedCurse then
    self:InOutQueue(self.petPstID, false)
    return
  else
    self:InOutQueue(self.petPstID, true)
  end
end

function UIWidgetEnemyPet:ShowHideChainSkillCG(petPstID, isShow)
  if petPstID ~= self.petPstID then
    return
  end
  local s, e = 0, -280
  if not isShow then
    s, e = e, s
  end
  self._goChainSkillReady.transform:DOAnchorPosX(0, 0.2):OnStart(function()
    if isShow then
      self._goChainSkillReady:SetActive(true)
      self._offset.gameObject:SetActive(false)
      self._skillReadyGO:SetActive(false)
    end
    self._goChainSkillReady.transform.anchoredPosition = Vector2(e, 0)
  end):OnComplete(function()
    if not isShow then
      self._goChainSkillReady:SetActive(false)
      self._offset.gameObject:SetActive(true)
    end
  end)
end

function UIWidgetEnemyPet:InitLegendEnergySkill()
  self._imageDiamondLight.gameObject:SetActive(false)
  self._imageDiamondBlack.gameObject:SetActive(false)
  self._imageIconA.gameObject:SetActive(true)
  self._imageIconB.gameObject:SetActive(false)
  self._imageIconC.gameObject:SetActive(false)
end

function UIWidgetEnemyPet:InitPassiveSkill()
  if not self._passiveSkillID or self._passiveSkillID == 0 then
    self._PassiveSkillGO.gameObject:SetActive(false)
    return
  end
  local passiveSkillCfg = Cfg.cfg_passive_skill[self._passiveSkillID].ShowMethod
  if passiveSkillCfg == nil then
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
      else
        self._imageDiamondLight.sprite = self._uiBattleAtlas:GetSprite("thread_junei_icon8")
        self._imageDiamondBlack.sprite = self._uiBattleAtlas:GetSprite("thread_junei_icon9")
      end
    else
      self._imageDiamondLight.sprite = self._uiBattleAtlas:GetSprite("thread_junei_icon8")
      self._imageDiamondBlack.sprite = self._uiBattleAtlas:GetSprite("thread_junei_icon9")
    end
    self._imageDiamondLight.gameObject:SetActive(defaultLight)
    self._imageDiamondBlack.gameObject:SetActive(not defaultLight)
    self._imageIconA.gameObject:SetActive(false)
    self._imageIconB.gameObject:SetActive(false)
    self._imageIconC.gameObject:SetActive(false)
    self._txtAccumulate.gameObject:SetActive(false)
    self:AttachEvent(GameEventType.ActivatePassive, self.ActivatePassive)
  end
  if passiveSkillCfg[1] == "2" or passiveSkillCfg[1] == "3" then
    self._txtAccumulate.gameObject:SetActive(true)
    self._txtAccumulate:SetText("0")
    self._imageIconA.gameObject:SetActive(false)
    self._imageIconB.gameObject:SetActive(false)
    self._imageIconC.gameObject:SetActive(false)
    self._imageDiamondLight.gameObject:SetActive(false)
    self._imageDiamondBlack.gameObject:SetActive(false)
    if passiveSkillCfg[2] == "a" then
      self._imageIconA.gameObject:SetActive(true)
    elseif passiveSkillCfg[2] == "b" then
      self._imageIconB.gameObject:SetActive(true)
    elseif passiveSkillCfg[2] == "c" then
      self._imageIconC.gameObject:SetActive(true)
    end
    if self.skillTriggerType == SkillTriggerType.LegendEnergy then
      self._txtAccumulate1:SetText("0")
      self._imageIconA1.gameObject:SetActive(false)
      self._imageIconB1.gameObject:SetActive(false)
      self._imageIconC1.gameObject:SetActive(false)
      self._imageDiamondLight.gameObject:SetActive(false)
      self._imageDiamondBlack.gameObject:SetActive(false)
      if passiveSkillCfg[2] == "a" then
        self._imageIconA1.gameObject:SetActive(true)
      elseif passiveSkillCfg[2] == "b" then
        self._imageIconB1.gameObject:SetActive(true)
      elseif passiveSkillCfg[2] == "c" then
        self._imageIconC1.gameObject:SetActive(true)
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
  end
end

function UIWidgetEnemyPet:ActivatePassive(pstId, onOff)
  if pstId == self.petPstID then
    self._imageDiamondLight.gameObject:SetActive(onOff)
    self._imageDiamondBlack.gameObject:SetActive(not onOff)
  end
end

function UIWidgetEnemyPet:SetAccumulateNum(pstId, num)
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
    if num <= 0 then
      if self.skillTriggerType == SkillTriggerType.LegendEnergy then
        self._txtAccumulate1.gameObject:SetActive(false)
      else
        self._PassiveSkillGO.gameObject:SetActive(false)
      end
    else
      self._PassiveSkillGO.gameObject:SetActive(true)
      if self.skillTriggerType == SkillTriggerType.LegendEnergy then
        self._txtAccumulate1.gameObject:SetActive(true)
        self._txtAccumulate1:SetText(tostring(num))
      else
        self._txtAccumulate:SetText(tostring(num))
      end
    end
  end
end

function UIWidgetEnemyPet:_OnChangePetActiveSkill(pstId, skillID)
  if pstId ~= self.petPstID then
    return
  end
  self.skillID = skillID
end

function UIWidgetEnemyPet:OnChangeHeadAlpha(alpha)
  local color = self.headMask.color
  color.a = alpha
  self.headMask.color = color
end

function UIWidgetEnemyPet:_ActiveBattlePet()
  if self._touchArea then
    self._touchArea:SetActive(true)
  end
end
