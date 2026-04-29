_class("UIWidgetFeaturePopStar", UICustomWidget)
UIWidgetFeaturePopStar = UIWidgetFeaturePopStar

function UIWidgetFeaturePopStar:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetFeaturePopStar:SetFeatureType(featureType)
  self._featureTypeBySet = featureType
end

function UIWidgetFeaturePopStar:GetFeatureType()
  return self._featureTypeBySet or FeatureType.PopStar
end

function UIWidgetFeaturePopStar:InitWidget()
  self._imgFeaturePopStar = self:GetUIComponent("Image", "UIWidgetFeaturePopStar")
  self._imageNormalGo = self:GetGameObject("ImageNormal")
  self._imageWarningGo = self:GetGameObject("ImageWarning")
  self._skillInfoGenGo = self:GetGameObject("SkillInfoGen")
  self._skillInfoGenGo:SetActive(false)
  self._skillPool = self:GetUIComponent("UISelectObjectPath", "SkillInfoGen")
  self._skillUI = self._skillPool:SpawnObject("UIWidgetFeaturePersonaSkillInfo")
  self._powerText = self:GetUIComponent("UILocalizationText", "power")
  self._powerTextGo = self:GetGameObject("power")
  self._uiBattle = nil
  self._switchTimeEvent = nil
  self._switchTimeLength = 100
  self:AttachEvent(GameEventType.PersonaPowerChange, self.OnPersonaPowerChange)
  self:AttachEvent(GameEventType.OnClickWhenPickUp, self.OnClickWhenPickUp)
  self:AttachEvent(GameEventType.UICancelChooseTarget, self.OnChooseTargetCancel)
  self:AttachEvent(GameEventType.UIChooseTargetGray, self.HandleUIChooseTargetGray)
  self:AttachEvent(GameEventType.PickUPInvalidGridCancelActiveSkill, self.OnPickInvalidGridCancel)
  self._power = 0
  self._ready = 0
  self:OnPersonaPowerChange(self:GetFeatureType(), self._power, self._ready)
end

function UIWidgetFeaturePopStar:OnPersonaPowerChange(featureType, power, ready)
  if self:GetFeatureType() ~= featureType then
    return
  end
  if power <= 0 then
    power = 0
  end
  if ready and self._ready ~= ready then
    self._ready = ready
  end
  if self._power ~= power then
    self._power = power
  end
  self._powerText:SetText(self._power)
  self:_RefreshStateBg()
end

function UIWidgetFeaturePopStar:_RefreshStateBg()
  self._imageNormalGo:SetActive(self._ready ~= 1)
  self._imageWarningGo:SetActive(self._ready == 1)
end

function UIWidgetFeaturePopStar:SetUIBattle(uiBattle)
  self._uiBattle = uiBattle
end

function UIWidgetFeaturePopStar:GetUIBattle()
  return self._uiBattle
end

function UIWidgetFeaturePopStar:SetData(popStarInitData)
  self._featureInitData = popStarInitData
  self._skillID = self._featureInitData:GetMasterSkillID()
  self._skillConfigData = ConfigServiceHelper.GetSkillConfigData(self._skillID)
  self._power, self._ready = InnerGameHelperRender.GetFeatureSkillCurPower(self:GetFeatureType())
  self:OnPersonaPowerChange(self:GetFeatureType(), self._power, self._ready)
  self:SetUiResByData()
end

function UIWidgetFeaturePopStar:UIWidgetFeaturePopStarOnClick(go)
  if InnerGameHelperRender.IsPuzzleState() then
    return
  end
  if InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
    return
  end
  self:OnClickUI()
end

function UIWidgetFeaturePopStar:OnClickUI()
  local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
  local enableInput = GameGlobal:GetInstance():IsInputEnable()
  if coreGameStateID == GameStateID.WaitInput and enableInput == true then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self._skillID)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickPersonaSkill, self:GetFeatureType(), self._skillID)
    self:ShowPersonaSkillUI()
  elseif coreGameStateID == GameStateID.PreviewActiveSkill or coreGameStateID == GameStateID.PickUpActiveSkillTarget then
    if self._switchTimeEvent == nil then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UISwitchActiveSkillUI)
      self:ShowPersonaSkillUI()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self._skillID)
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

function UIWidgetFeaturePopStar:ShowPersonaSkillUI()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIFeatureSkillInfoShow, true, self:GetFeatureType())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UICancelActiveSkillCast)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PauseGuideWeakLine)
  local skillConfigData = self._skillConfigData
  local canCast = self._ready == 1
  
  local function castCb(castSkillID, pickUpType)
    self:OnCastSkill(castSkillID, pickUpType)
  end
  
  local function cancelCb()
    self:OnCancelSkill()
  end
  
  self._skillUI:Init(self:GetFeatureType(), self._skillID, nil, self._power, canCast, castCb, cancelCb)
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

function UIWidgetFeaturePopStar:HidePersonaSkillUI()
  self._skillInfoGenGo:SetActive(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIFeatureSkillInfoShow, false, self:GetFeatureType())
end

function UIWidgetFeaturePopStar:OnCastSkill(castSkillID, pickUpType)
  if pickUpType == SkillPickUpType.None then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CastPersonaSkill, castSkillID)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIResetLastPreviewPetId)
  elseif pickUpType == SkillPickUpType.PickSwitchInstruction then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, true)
    local petPstID = 0
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveSkillPickUp, castSkillID, petPstID)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, false)
    local petPstID = 0
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveSkillPickUp, castSkillID, petPstID)
  end
  self:HidePersonaSkillUI()
end

function UIWidgetFeaturePopStar:OnCancelSkill()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StopPreviewActiveSkill, false, true, self._skillID, -1)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, -1)
  self:HidePersonaSkillUI()
end

function UIWidgetFeaturePopStar:OnSwitchActiveSkillUI()
  self:HidePersonaSkillUI()
end

function UIWidgetFeaturePopStar:OnChooseTargetConfirm()
  if self._skillID > 0 and self._uiBattle:GetCurPetActiveSkillId() == self._skillID then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIResetLastPreviewPetId)
    self:HidePersonaSkillUI()
  end
end

function UIWidgetFeaturePopStar:OnChooseTargetCancel()
  self:HidePersonaSkillUI()
end

function UIWidgetFeaturePopStar:OnPickInvalidGridCancel()
  self:HidePersonaSkillUI()
end

function UIWidgetFeaturePopStar:OnClickWhenPickUp()
  self:HidePersonaSkillUI()
end

function UIWidgetFeaturePopStar:_PreviewPickUpSkill(skillId, pickUpType)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UICancelActiveSkillSwitchTimer)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CastPersonaSkill, skillId)
  if pickUpType == SkillPickUpType.None then
    Log.fatal("[UIWidgetFeaturePopStar] preview skill pickup type is none")
  else
    local petPstID = 0
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowActiveSkillChooseUI, skillId, pickUpType, petPstID, self._isCurPetSkillReady)
  end
end

function UIWidgetFeaturePopStar:HandleUIChooseTargetGray()
  if self._skillID > 0 and self._uiBattle:GetCurPetActiveSkillId() == self._skillID then
    local bReady = self._ready == 1
    if not bReady then
      ToastManager.ShowToast(StringTable.Get("str_n31_popstar_battle_cast_skill_count_not_enough"))
    end
  end
end

function UIWidgetFeaturePopStar:SetUiResByData()
  local atlas = self:GetAsset("UIBattlePopStar.spriteatlas", LoadType.SpriteAtlas)
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
end

function UIWidgetFeaturePopStar:RemoveFeature(featureType)
  if self:GetFeatureType() ~= featureType then
    return
  end
  self:DetachAllEvents()
end
