_class("UIWidgetFeatureMasterSkill", UICustomWidget)
UIWidgetFeatureMasterSkill = UIWidgetFeatureMasterSkill

function UIWidgetFeatureMasterSkill:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetFeatureMasterSkill:SetFeatureType(featureType)
  self._featureTypeBySet = featureType
end

function UIWidgetFeatureMasterSkill:GetFeatureType()
  return self._featureTypeBySet or FeatureType.MasterSkill
end

function UIWidgetFeatureMasterSkill:InitWidget()
  self.enableFakeInput = true
  self._imageNormalGo = self:GetGameObject("ImageNormal")
  self._imageWarningGo = self:GetGameObject("ImageWarning")
  self._UIWidgetFeatureMasterSkill = self:GetUIComponent("Image", "UIWidgetFeatureMasterSkill")
  self._skillInfoGenGo = self:GetGameObject("SkillInfoGen")
  self._skillPool = self:GetUIComponent("UISelectObjectPath", "SkillInfoGen")
  self._skillUI = self._skillPool:SpawnObject("UIWidgetFeaturePersonaSkillInfo")
  self._powerText = self:GetUIComponent("UILocalizationText", "power")
  self._powerTextGo = self:GetGameObject("power")
  self.alreadyCastActiveImage = self:GetGameObject("AlreadyCastActiveImage")
  self.alreadyCastActiveImage:SetActive(false)
  self._cdGO = self:GetGameObject("CdArea")
  self._cdGO:SetActive(true)
  self._skillInfoGenGo:SetActive(false)
  self._uiBattle = nil
  self._switchTimeEvent = nil
  self._switchTimeLength = 100
  self:AttachEvent(GameEventType.PersonaPowerChange, self.OnPersonaPowerChange)
  self:AttachEvent(GameEventType.AutoFightCastPersonaSkill, self.OnAutoFightCastPersonaSkill)
  self:AttachEvent(GameEventType.OnClickWhenPickUp, self.OnClickWhenPickUp)
  self:AttachEvent(GameEventType.UICancelChooseTarget, self.OnChooseTargetCancel)
  self:AttachEvent(GameEventType.UIChooseTargetGray, self.HandleUIChooseTargetGray)
  self:AttachEvent(GameEventType.PickUPInvalidGridCancelActiveSkill, self.OnPickInvalidGridCancel)
  self._power = 0
  self._ready = 1
  self:OnPersonaPowerChange(self:GetFeatureType(), 0, 1)
end

function UIWidgetFeatureMasterSkill:IsAutoFighting()
  return GameGlobal.GetUIModule(MatchModule):IsAutoFighting()
end

function UIWidgetFeatureMasterSkill:OnPersonaPowerChange(featureType, power, ready)
  if self:GetFeatureType() ~= featureType then
    return
  end
  if power <= 0 then
    power = 0
  end
  if self._power == 0 then
    self._cdGO:SetActive(power ~= 0)
  end
  if self._ready == 1 or self._power == 0 then
    self.alreadyCastActiveImage:SetActive(false)
  end
  if ready then
    if self._ready ~= ready then
      if ready == 1 then
        self:_PlayReadyReminder()
      end
      self._ready = ready
    end
    if ready == 1 then
      self._cdGO:SetActive(false)
    end
  end
  if self._power ~= power then
    self._power = power
  end
  self._powerText:SetText(power)
  self:_RefreshStateBg()
end

function UIWidgetFeatureMasterSkill:_RefreshStateBg()
  if self._featureInitData and self._featureInitData:GetUiType() == FeatureMasterSkillUiType.TypeSeason then
    self._imageNormalGo:SetActive(true)
  else
    self._imageNormalGo:SetActive(self._ready ~= 1)
  end
  self._imageWarningGo:SetActive(self._ready == 1)
end

function UIWidgetFeatureMasterSkill:SetUIBattle(uiBattle)
  self._uiBattle = uiBattle
end

function UIWidgetFeatureMasterSkill:GetUIBattle()
  return self._uiBattle
end

function UIWidgetFeatureMasterSkill:SetData(masterSkillInitData)
  self._featureInitData = masterSkillInitData
  self._skillID = self._featureInitData:GetMasterSkillID()
  self._skillConfigData = ConfigServiceHelper.GetSkillConfigData(self._skillID)
  local skillConfigData = self._skillConfigData
  self._maxPower = skillConfigData:GetSkillTriggerParam()
  self:_RefreshStateBg()
  self:SetUiResByData()
end

function UIWidgetFeatureMasterSkill:UIWidgetFeatureMasterSkillOnClick(go)
  if self:IsAutoFighting() or InnerGameHelperRender.IsPuzzleState() or InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
    return
  end
  self:OnClickUI()
end

function UIWidgetFeatureMasterSkill:OnClickUI()
  local canCastSkill = true
  if canCastSkill then
    local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
    local enableInput = GameGlobal:GetInstance():IsInputEnable()
    if coreGameStateID == GameStateID.WaitInput and enableInput == true then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self._skillID)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.HideCanMoveArrow)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickPersonaSkill, self:GetFeatureType(), self._skillID)
      self:ShowPersonaSkillUI()
    elseif coreGameStateID == GameStateID.PreviewActiveSkill or coreGameStateID == GameStateID.PickUpActiveSkillTarget then
      if self._switchTimeEvent == nil then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.UISwitchActiveSkillUI)
        self:ShowPersonaSkillUI()
        Log.notice("preclickhead persona skill", self._skillID)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self._skillID)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.HideCanMoveArrow)
        self._switchTimeEvent = GameGlobal.Timer():AddEvent(self._switchTimeLength, function()
          GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickPersonaSkill, self:GetFeatureType(), self._skillID)
          self._switchTimeEvent = nil
          Log.notice("preview persona skill", self._skillID)
        end)
      else
        Log.notice("still in switch", self._skillID)
      end
    end
  end
end

function UIWidgetFeatureMasterSkill:ShowPersonaSkillUI()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIFeatureSkillInfoShow, true, self:GetFeatureType())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UICancelActiveSkillCast)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PauseGuideWeakLine)
  local skillConfigData = self._skillConfigData
  local canCast = self._ready == 1
  canCast = canCast and InnerGameHelperRender.CanCastByExtraPower(skillConfigData)
  
  local function castCb(castSkillID, pickUpType)
    self:OnCastSkill(castSkillID, pickUpType)
  end
  
  local function cancelCb()
    self:OnCancelSkill()
  end
  
  self._skillUI:Init(self:GetFeatureType(), self._skillID, self._maxPower, self._power, canCast, castCb, cancelCb)
  local pickUpType = skillConfigData:GetSkillPickType()
  self._pickUpType = pickUpType
  if pickUpType ~= SkillPickUpType.None then
    self._isCurPetSkillReady = canCast
    self:_PreviewPickUpSkill(self._skillID, pickUpType)
    self._skillUI:ShowCancelBtn(false)
  else
    self._skillUI:ShowCancelBtn(true)
  end
  self._skillInfoGenGo:SetActive(true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickUI2ClosePreviewMonster)
end

function UIWidgetFeatureMasterSkill:HidePersonaSkillUI()
  self._skillInfoGenGo:SetActive(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIFeatureSkillInfoShow, false, self:GetFeatureType())
end

function UIWidgetFeatureMasterSkill:OnCastSkill(castSkillID, pickUpType)
  if pickUpType == SkillPickUpType.None then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CastPersonaSkill, castSkillID)
    self:ClearPower()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIResetLastPreviewPetId)
    self:HidePersonaSkillUI()
  elseif pickUpType == SkillPickUpType.PickSwitchInstruction then
    Log.fatal("[UIWidgetFeatureMasterSkill] cast skill pick up type error:", pickUpType)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, true)
    local petPstID = 0
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveSkillPickUp, castSkillID, petPstID)
    self:HidePersonaSkillUI()
  else
    Log.fatal("[UIWidgetFeatureMasterSkill] cast skill pick up type error:", pickUpType)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, false)
    local petPstID = 0
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveSkillPickUp, castSkillID, petPstID)
    self:HidePersonaSkillUI()
  end
end

function UIWidgetFeatureMasterSkill:ClearPower()
  self._power = 0
  self._ready = 0
  self.alreadyCastActiveImage:SetActive(true)
  self:_RefreshStateBg()
end

function UIWidgetFeatureMasterSkill:OnCancelSkill()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StopPreviewActiveSkill, false, true, self._skillID, -1)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, -1)
  self:HidePersonaSkillUI()
end

function UIWidgetFeatureMasterSkill:OnSwitchActiveSkillUI()
  self:HidePersonaSkillUI()
end

function UIWidgetFeatureMasterSkill:OnChooseTargetConfirm()
  if self._skillID > 0 and self._uiBattle:GetCurPetActiveSkillId() == self._skillID then
    self:ClearPower()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIResetLastPreviewPetId)
    self:HidePersonaSkillUI()
  end
end

function UIWidgetFeatureMasterSkill:OnChooseTargetCancel()
  self:HidePersonaSkillUI()
end

function UIWidgetFeatureMasterSkill:OnPickInvalidGridCancel()
  self:HidePersonaSkillUI()
end

function UIWidgetFeatureMasterSkill:OnAutoFightCastPersonaSkill(featureType)
  if featureType and featureType == self:GetFeatureType() then
    self:OnCastSkill(self._skillID, SkillPickUpType.None)
  end
end

function UIWidgetFeatureMasterSkill:OnClickWhenPickUp()
  self:HidePersonaSkillUI()
end

function UIWidgetFeatureMasterSkill:_PreviewPickUpSkill(skillId, pickUpType)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UICancelActiveSkillSwitchTimer)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CastPersonaSkill, skillId)
  if pickUpType == SkillPickUpType.None then
    Log.fatal("[UIWidgetFeatureMasterSkill] preview skill pickup type is none")
  else
    local petPstID = 0
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowActiveSkillChooseUI, skillId, pickUpType, petPstID, self._isCurPetSkillReady)
  end
end

function UIWidgetFeatureMasterSkill:HandleUIChooseTargetGray()
  if self._skillID > 0 and self._uiBattle:GetCurPetActiveSkillId() == self._skillID then
    local canCast, reason, forceTips = self:GetCanCastAndReason()
    if forceTips then
      ToastManager.ShowToast(reason)
    else
      if self._isCurPetSkillReady == false and not canCast then
        ToastManager.ShowToast(reason)
      else
      end
    end
  end
end

function UIWidgetFeatureMasterSkill:GetCanCastAndReason()
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
  local bReady = self._ready == 1
  if not bReady then
    return false, StringTable.Get("str_match_cannot_cast_skill_reason")
  end
  return true, nil
end

function UIWidgetFeatureMasterSkill:_PlayReadyReminder()
  if self._featureInitData:GetUiType() == FeatureMasterSkillUiType.TypeSeason then
    self._anim = self:GetGameObject():GetComponent("Animation")
    if self._anim then
      self._anim:Play("uieffanim_UIWidgetFeatureMasterSkillSeason")
    end
  end
end

function UIWidgetFeatureMasterSkill:SetUiResByData()
  local atlas = self:GetAsset("UIFeatureSkill.spriteatlas", LoadType.SpriteAtlas)
  if not atlas then
    return
  end
  local oldAtlas = self:GetAsset("UIBattle.spriteatlas", LoadType.SpriteAtlas)
  if not oldAtlas then
    return
  end
  local normalBgImg = self._featureInitData:GetImageNormalBg()
  if normalBgImg then
    local imageCmpt = self:GetUIComponent("Image", "ImageNormal")
    if imageCmpt then
      local sprite
      sprite = atlas:GetSprite(normalBgImg)
      sprite = sprite or oldAtlas:GetSprite(normalBgImg)
      imageCmpt.sprite = sprite
    end
  end
  local warningBgImg = self._featureInitData:GetImageWarningBg()
  if warningBgImg then
    local imageCmpt = self:GetUIComponent("Image", "ImageWarningBg")
    if imageCmpt then
      local sprite
      sprite = atlas:GetSprite(warningBgImg)
      sprite = sprite or oldAtlas:GetSprite(warningBgImg)
      imageCmpt.sprite = sprite
    end
  end
  local normalFrontImg = self._featureInitData:GetImageNormalFront()
  if normalFrontImg then
    local imageCmpt = self:GetUIComponent("Image", "ImageNormalFront")
    if imageCmpt then
      local sprite
      sprite = atlas:GetSprite(normalFrontImg)
      sprite = sprite or oldAtlas:GetSprite(normalFrontImg)
      imageCmpt.sprite = sprite
    end
  end
  local warningFrontImg = self._featureInitData:GetImageWarningFront()
  if warningFrontImg then
    local imageCmpt = self:GetUIComponent("Image", "ImageWarningFront")
    if imageCmpt then
      local sprite
      sprite = atlas:GetSprite(warningFrontImg)
      sprite = sprite or oldAtlas:GetSprite(warningFrontImg)
      imageCmpt.sprite = sprite
    end
  end
  local hideUIIcon = self._featureInitData:GetHideUIIcon()
  if hideUIIcon and hideUIIcon == 1 then
    local iconGo1 = self:GetGameObject("ImageIconNormal")
    if iconGo1 then
      iconGo1:SetActive(false)
    end
    local iconGo2 = self:GetGameObject("ImageIconWarning")
    if iconGo2 then
      iconGo2:SetActive(false)
    end
  end
end
