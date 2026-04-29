_class("UIWidgetFeaturePersonaSkill", UICustomWidget)
UIWidgetFeaturePersonaSkill = UIWidgetFeaturePersonaSkill

function UIWidgetFeaturePersonaSkill:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetFeaturePersonaSkill:InitWidget()
  self.enableFakeInput = true
  self._imageNormalGo = self:GetGameObject("ImageNormal")
  self._imageWarningGo = self:GetGameObject("ImageWarning")
  self._uIWidgetFeaturePersonaSkill = self:GetUIComponent("Image", "UIWidgetFeaturePersonaSkill")
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
  self:AttachEvent(GameEventType.PickUPInvalidGridCancelActiveSkill, self.OnPickInvalidGridCancel)
  self._power = 0
  self._ready = 1
  self:OnPersonaPowerChange(FeatureType.PersonaSkill, 0, 1)
end

function UIWidgetFeaturePersonaSkill:IsAutoFighting()
  return GameGlobal.GetUIModule(MatchModule):IsAutoFighting()
end

function UIWidgetFeaturePersonaSkill:OnPersonaPowerChange(featureType, power, ready)
  if FeatureType.PersonaSkill ~= featureType then
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

function UIWidgetFeaturePersonaSkill:_RefreshStateBg()
  self._imageNormalGo:SetActive(self._ready ~= 1)
  self._imageWarningGo:SetActive(self._ready == 1)
end

function UIWidgetFeaturePersonaSkill:SetUIBattle(uiBattle)
  self._uiBattle = uiBattle
end

function UIWidgetFeaturePersonaSkill:GetUIBattle()
  return self._uiBattle
end

function UIWidgetFeaturePersonaSkill:SetData(personaSkillInitData)
  self._featureInitData = personaSkillInitData
  self._skillID = self._featureInitData:GetPersonaSkillID()
  self._skillConfigData = ConfigServiceHelper.GetSkillConfigData(self._skillID)
  local skillConfigData = self._skillConfigData
  self._maxPower = skillConfigData:GetSkillTriggerParam()
end

function UIWidgetFeaturePersonaSkill:UIWidgetFeaturePersonaSkillOnClick(go)
  if self:IsAutoFighting() or InnerGameHelperRender.IsPuzzleState() or InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
    return
  end
  local canCastSkill = true
  if canCastSkill then
    local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
    local enableInput = GameGlobal:GetInstance():IsInputEnable()
    if coreGameStateID == GameStateID.WaitInput and enableInput == true then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self._skillID)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.HideCanMoveArrow)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickPersonaSkill, FeatureType.PersonaSkill, self._skillID)
      self:ShowPersonaSkillUI()
    elseif coreGameStateID == GameStateID.PreviewActiveSkill or coreGameStateID == GameStateID.PickUpActiveSkillTarget then
      if self._switchTimeEvent == nil then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.UISwitchActiveSkillUI)
        self:ShowPersonaSkillUI()
        Log.notice("preclickhead persona skill", self._skillID)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self._skillID)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.HideCanMoveArrow)
        self._switchTimeEvent = GameGlobal.Timer():AddEvent(self._switchTimeLength, function()
          GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickPersonaSkill, FeatureType.PersonaSkill, self._skillID)
          self._switchTimeEvent = nil
          Log.notice("preview persona skill", self._skillID)
        end)
      else
        Log.notice("still in switch", self._skillID)
      end
    end
  end
end

function UIWidgetFeaturePersonaSkill:ShowPersonaSkillUI()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIFeatureSkillInfoShow, true, FeatureType.PersonaSkill)
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
  
  self._skillUI:Init(FeatureType.PersonaSkill, self._skillID, self._maxPower, self._power, canCast, castCb, cancelCb)
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

function UIWidgetFeaturePersonaSkill:HidePersonaSkillUI()
  self._skillInfoGenGo:SetActive(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIFeatureSkillInfoShow, false, FeatureType.PersonaSkill)
end

function UIWidgetFeaturePersonaSkill:OnCastSkill(castSkillID, pickUpType)
  if pickUpType == SkillPickUpType.None then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CastPersonaSkill, castSkillID)
    self:ClearPower()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIResetLastPreviewPetId)
    self:HidePersonaSkillUI()
  elseif pickUpType == SkillPickUpType.PickSwitchInstruction then
    Log.fatal("[UIWidgetFeaturePersonaSkill] cast skill pick up type error:", pickUpType)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, true)
    local petPstID = 0
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveSkillPickUp, castSkillID, petPstID)
    self:HidePersonaSkillUI()
  else
    Log.fatal("[UIWidgetFeaturePersonaSkill] cast skill pick up type error:", pickUpType)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, false)
    local petPstID = 0
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveSkillPickUp, castSkillID, petPstID)
    self:HidePersonaSkillUI()
  end
end

function UIWidgetFeaturePersonaSkill:ClearPower()
  self._power = 0
  self._ready = 0
  self.alreadyCastActiveImage:SetActive(true)
  self:_RefreshStateBg()
end

function UIWidgetFeaturePersonaSkill:OnCancelSkill()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StopPreviewActiveSkill, false, true, self._skillID, -1)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, -1)
  self:HidePersonaSkillUI()
end

function UIWidgetFeaturePersonaSkill:OnSwitchActiveSkillUI()
  self:HidePersonaSkillUI()
end

function UIWidgetFeaturePersonaSkill:OnChooseTargetConfirm()
  if self._skillID > 0 and self._uiBattle:GetCurPetActiveSkillId() == self._skillID then
    self:ClearPower()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIResetLastPreviewPetId)
    self:HidePersonaSkillUI()
  end
end

function UIWidgetFeaturePersonaSkill:OnChooseTargetCancel()
  self:HidePersonaSkillUI()
end

function UIWidgetFeaturePersonaSkill:OnPickInvalidGridCancel()
  self:HidePersonaSkillUI()
end

function UIWidgetFeaturePersonaSkill:OnAutoFightCastPersonaSkill(featureType)
  if not featureType then
    self:OnCastSkill(self._skillID, SkillPickUpType.None)
  end
end

function UIWidgetFeaturePersonaSkill:OnClickWhenPickUp()
  self:HidePersonaSkillUI()
end

function UIWidgetFeaturePersonaSkill:_PreviewPickUpSkill(skillId, pickUpType)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UICancelActiveSkillSwitchTimer)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CastPersonaSkill, skillId)
  if pickUpType == SkillPickUpType.None then
    Log.fatal("[UIWidgetFeaturePersonaSkill] preview skill pickup type is none")
  else
    local petPstID = 0
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowActiveSkillChooseUI, skillId, pickUpType, petPstID, self._isCurPetSkillReady)
  end
end
