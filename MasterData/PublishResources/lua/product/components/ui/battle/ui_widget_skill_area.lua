_class("UIWidgetSkillArea", UICustomWidget)
UIWidgetSkillArea = UIWidgetSkillArea

function UIWidgetSkillArea:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetSkillArea:InitWidget()
  self.chooseTargetRoot = self:GetUIComponent("UISelectObjectPath", "ChooseTargetRoot")
  self._petSkillPool = self:GetUIComponent("UISelectObjectPath", "petSkillPool")
  self._petSkillUIOri = self._petSkillPool:SpawnObject("UIWidgetPetSkill")
  self._petSkillUI = self._petSkillUIOri
  self._petSubSkillPool = self:GetUIComponent("UISelectObjectPath", "petSubSkillPool")
  self._petSubSkillUI = self._petSubSkillPool:SpawnObject("UIWidgetPetSubSkill")
  self._petMultiSkillPool = self:GetUIComponent("UISelectObjectPath", "petMultiSkillPool")
  self._petMultiSkillUI = self._petMultiSkillPool:SpawnObject("UIWidgetPetMultiActiveSkill")
  self._petEquipRefinePool = self:GetUIComponent("UISelectObjectPath", "petEquipRefinePool")
  self._petEquipRefineUI = self._petEquipRefinePool:SpawnObject("UIWidgetPetEquipRefine")
  self:_CloseActiveSkillTip()
  self._curWidgetPet = nil
  self:SpawnChooseTargetUI()
  self:RegisterEvent()
end

function UIWidgetSkillArea:RegisterEvent()
  self:AttachEvent(GameEventType.UIShowActiveSkillUI, self.OnUIShowActiveSkillUI)
  self:AttachEvent(GameEventType.UIShowMultiActiveSkillUI, self.OnUIShowMultiActiveSkillUI)
  self:AttachEvent(GameEventType.AutoFightCastSkill, self.OnCastSkill)
  self:AttachEvent(GameEventType.BattleUIRefreshActiveSkillCastButtonState, self._OnBattleUIRefreshActiveSkillCastButtonState)
  self:AttachEvent(GameEventType.SelectSubActiveSkill, self._OnSelectSubActiveSkill)
  self:AttachEvent(GameEventType.PickUPInvalidGridCancelActiveSkill, self.PickInvalidGridCancelPreview)
  self:AttachEvent(GameEventType.UICancelChooseTarget, self.HandleUICancelChooseTarget)
  self:AttachEvent(GameEventType.PickUPValidGridShowChooseTarget, self.ShowChooseTarget)
  self:AttachEvent(GameEventType.UIChooseTargetConfirm, self.HandleUIChooseTargetConfirm)
  self:AttachEvent(GameEventType.UIChooseTargetGray, self.HandleUIChooseTargetGray)
  self:AttachEvent(GameEventType.EnablePickUpSkillCast, self.EnablePickUpSkillCast)
  self:AttachEvent(GameEventType.OnClickWhenPickUp, self._CloseActiveSkillTip)
  self:AttachEvent(GameEventType.ShowActiveSkillChooseUI, self._OnShowActiveSkillChooseUI)
  self:AttachEvent(GameEventType.UIResetLastPreviewPetId, self.ResetLastPreviewPetId)
  self:AttachEvent(GameEventType.UISetLastPreviewPetId, self.SetPreviewPetId)
  self:AttachEvent(GameEventType.UISwitchActiveSkillUI, self.SwitchActiveSkillUI)
  self:AttachEvent(GameEventType.UICancelActiveSkillCast, self._CancelActiveSkill)
  self:AttachEvent(GameEventType.UIPetClickToSwitch, self.OnPetSwitchCallBack)
  self:AttachEvent(GameEventType.BattleUIShowHideSelectTeamPositionButton, self.ShowHideSelectTeamPositionButton)
  self:AttachEvent(GameEventType.BattleUISelectTargetTeamPosition, self.OnBattleUISelectTargetTeamPosition)
  self:AttachEvent(GameEventType.ClickPetHead, self.OnClickPetHead)
  self:AttachEvent(GameEventType.UIShowPetInfo, self.HandleUIShowPetInfo)
end

function UIWidgetSkillArea:SetData(uiBattle)
  self._uiBattle = uiBattle
end

function UIWidgetSkillArea:SpawnChooseTargetUI()
  self._chooseTargetWidget = self.chooseTargetRoot:SpawnObject("UIWidgetChooseTarget")
end

function UIWidgetSkillArea:_CloseActiveSkillTip()
  if self._petSkillUI then
    self._petSkillUI:HideSelf()
    if self._petSkillUI._className == "UIWidgetPetSubSkill" then
      self._petSkillUI:ClearCurSkillID()
    else
      self._petSkillUI:ResetSkillCanCast()
    end
  end
  if self._petSubSkillUI then
    self._petSubSkillUI:HideSelf()
  end
  if self._petMultiSkillUI then
    self._petMultiSkillUI:ClearCurSkillID()
    self._petMultiSkillUI:HideSelf()
  end
  if self._petEquipRefineUI then
    self._petEquipRefineUI:HideSelf()
  end
  self:ResetLastPreviewPetId()
end

function UIWidgetSkillArea:ResetLastPreviewPetId()
  self._lastPreviewPetId = nil
end

function UIWidgetSkillArea:SetPreviewPetId(petId)
  self._lastPreviewPetId = petId
end

function UIWidgetSkillArea:GetPreviewPetId()
  return self._lastPreviewPetId
end

function UIWidgetSkillArea:GetCurPetActiveSkillId()
  return self._curPetActiveSkillId
end

function UIWidgetSkillArea:IsAutoFighting()
  return GameGlobal.GetUIModule(MatchModule):IsAutoFighting()
end

function UIWidgetSkillArea:ShowAutoFightForbiddenMsg()
  return GameGlobal.GetUIModule(MatchModule):ShowAutoFightForbiddenMsg()
end

function UIWidgetSkillArea:IsMoreFivePet()
  local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
  return matchEnterData:GetMatchType() == MatchType.MT_MiniMaze or matchEnterData:GetMatchType() == MatchType.MT_EightPets or matchEnterData:GetMatchType() == MatchType.MT_SeasonMaze
end

function UIWidgetSkillArea:SkillNeedHideActiveSkillUIInMiniMaze(skillId)
  local spePetSkillIDList = {
    302144,
    305144,
    312144,
    315144
  }
  if table.icontains(spePetSkillIDList, skillId) then
    return true
  else
    return false
  end
end

function UIWidgetSkillArea:OnUIShowActiveSkillUI(petWidget, skillId, maxPower, leftPower, canCast)
  self:ShowActiveSkillUI(petWidget, skillId, maxPower, leftPower, canCast)
  if self:IsMoreFivePet() and self:SkillNeedHideActiveSkillUIInMiniMaze(skillId) and self._petSkillUI then
    self._petSkillUI:HideSelf()
  end
  self:ShowPetEquipRefineUI(petWidget)
end

function UIWidgetSkillArea:OnUIShowMultiActiveSkillUI(index, petWidget, uiDataArray, isVariantSkillList, lastClickIndex)
  self:ShowMultiActiveSkillUI(index, petWidget, uiDataArray, isVariantSkillList, lastClickIndex)
end

function UIWidgetSkillArea:ShowActiveSkillUI(petWidget, skillId, maxPower, leftPower, canCast)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PauseGuideWeakLine)
  local posGO = petWidget:GetActiveSkillUIPos()
  local cancelSkillPosGo = petWidget:GetCancelSkillUIPos()
  local petPstID = petWidget:GetPetPstID()
  self._curWidgetPet = petWidget
  self._curPetActiveSkillId = skillId
  self._curPetPstId = petPstID
  self._previewActiveSkillCheckPass = nil
  local skillConfigData = ConfigServiceHelper.GetSkillConfigData(skillId, petPstID)
  local subSkillIDList = skillConfigData:GetSubSkillIDList()
  if #subSkillIDList == 0 then
    self._petSkillUI = self._petSkillUIOri
    self._curWidgetPet:SetUseSubActiveSkillState(false)
  else
    self._petSkillUI = self._petSubSkillUI
    self._curWidgetPet:SetUseSubActiveSkillState(true)
  end
  self._petSkillUI:SetUiPos(posGO.transform.position)
  self._petSkillUI:SetPetPstId(petPstID)
  self._petSkillUI:ShowSelf()
  self._petSkillUI:Init(skillId, maxPower, leftPower, canCast, function(castSkillID, pickUpType)
    self:CancelActiveSkillSwitchTimer()
    self._petSkillUI:HideSelf()
    self._petEquipRefineUI:HideSelf()
    if self._petSkillUI._className == "UIWidgetPetSubSkill" then
      self._petSkillUI:ClearCurSkillID()
    end
    self:ShowHideCancelActiveSkillBtn(false)
    self:OnCastSkill(castSkillID, pickUpType, petPstID)
  end, petPstID)
  self._curPetActiveSkillId = self._petSkillUI:GetCurActiveSkillID()
  skillConfigData = ConfigServiceHelper.GetSkillConfigData(self._curPetActiveSkillId, petPstID)
  local pickUpType = skillConfigData:GetSkillPickType()
  self._pickUpType = pickUpType
  self._chooseTargetWidget:ShowChooseTargetPanel(false)
  if pickUpType ~= SkillPickUpType.None then
    self._isCurPetSkillReady = canCast
    self:_PreviewPickUpSkill(self._curPetActiveSkillId, pickUpType, petPstID, cancelSkillPosGo)
    self:ShowHideCancelActiveSkillBtn(false)
  else
    self:ShowHideCancelActiveSkillBtn(true)
  end
  self:OnExclusivePetHeadMaskAlpha(BattleConst.ActiveSkillDarkAlpha, petPstID)
  local pm = GameGlobal.GetModule(PetAudioModule)
  InnerGameHelperRender.InnerGamePlayPetUIVoice("StandBy", petWidget._petTemplateID)
end

function UIWidgetSkillArea:OnCastSkill(castSkillID, pickUpType, petPstID)
  local petWidget = self._uiBattle:GetPetWidgetByPstID(petPstID)
  if pickUpType == SkillPickUpType.None then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CastActiveSkill, castSkillID, petPstID)
    petWidget:ClearPower(castSkillID)
    self:OnExclusivePetHeadMaskAlpha(0, -1)
    local pm = GameGlobal.GetModule(PetAudioModule)
    InnerGameHelperRender.InnerGamePlayPetUIVoice("Skill", petWidget._petTemplateID, true)
    self:ResetLastPreviewPetId()
  elseif pickUpType == SkillPickUpType.PickSwitchInstruction then
    self:EnablePickUpSkillCast(true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveSkillPickUp, castSkillID, petPstID)
  else
    self:EnablePickUpSkillCast(false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveSkillPickUp, castSkillID, petPstID)
  end
end

function UIWidgetSkillArea:_OnBattleUIRefreshActiveSkillCastButtonState(result, reason)
  self:SetPickUpActiveBtnState(result)
  self._previewActiveSkillCheckPass = result
  self._activeSkillDisableReason = reason
end

function UIWidgetSkillArea:SetPickUpActiveBtnState(canCast)
  self._chooseTargetWidget:SetPickUpActiveBtnState(canCast)
end

function UIWidgetSkillArea:_PreviewPickUpSkill(skillId, pickUpType, petPstID, cancelSkillPosGo)
  self:CancelActiveSkillSwitchTimer()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CastActiveSkill, skillId, petPstID)
  if pickUpType == SkillPickUpType.None then
    Log.fatal("[UIBattle] preview skill pickup type is none")
  else
    self:_OnShowActiveSkillChooseUI(skillId, pickUpType, petPstID, self._isCurPetSkillReady)
  end
end

function UIWidgetSkillArea:_OnShowActiveSkillChooseUI(skillId, pickUpType, petPstID, canCast)
  self._curPetActiveSkillId = skillId
  self._curPetPstId = petPstID
  self._pickUpType = pickUpType
  self._isCurPetSkillReady = canCast
  self._chooseTargetWidget:InitChooseTargetWidget(skillId, petPstID)
  self._chooseTargetWidget:SetChooseUIText(pickUpType)
end

function UIWidgetSkillArea:_OnSelectSubActiveSkill(skillID, canCast)
  self._curPetActiveSkillId = skillID
  local petPstID = self._curWidgetPet:GetPetPstID()
  local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self._curPetActiveSkillId, petPstID)
  local pickUpType = skillConfigData:GetSkillPickType()
  self._pickUpType = pickUpType
  if pickUpType ~= SkillPickUpType.None then
    local cancelSkillPosGo = self._curWidgetPet:GetCancelSkillUIPos()
    self._isCurPetSkillReady = canCast
    self:_PreviewPickUpSkill(self._curPetActiveSkillId, pickUpType, petPstID, cancelSkillPosGo)
    self:ShowHideCancelActiveSkillBtn(false)
  else
    self:ShowHideCancelActiveSkillBtn(true)
  end
end

function UIWidgetSkillArea:_CancelActiveSkill()
  self:CancelActiveSkillSwitchTimer()
  self:_CloseActiveSkillTip()
  self:ShowHideCancelActiveSkillBtn(false)
  self._curPetActiveSkillId = 0
  self._curPetPstId = 0
  self._isCurPetSkillReady = false
  self._curWidgetPet = nil
  self._previewActiveSkillCheckPass = nil
  self._chooseTargetWidget:ShowChooseTargetPanel(false)
  self:OnExclusivePetHeadMaskAlpha(0, -1)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TrapPowerVisible, true)
end

function UIWidgetSkillArea:ShowHideCancelActiveSkillBtn(bShow)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIShowHideCancelActiveSkillBtn, bShow)
end

function UIWidgetSkillArea:CancelActiveSkillSwitchTimer()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UICancelActiveSkillSwitchTimer)
end

function UIWidgetSkillArea:PickInvalidGridCancelPreview()
  self:_CancelActiveSkill()
end

function UIWidgetSkillArea:HandleUICancelChooseTarget()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CancelActiveSkillCast, self._curPetActiveSkillId, self._curPetPstId)
  self:_CancelActiveSkill()
end

function UIWidgetSkillArea:OnExclusivePetHeadMaskAlpha(alpha, exclusivePetPstID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIExclusivePetHeadMaskAlpha, alpha, exclusivePetPstID)
end

function UIWidgetSkillArea:ShowChooseTarget(show)
  self._previewActiveSkillCheckPass = true
  self._chooseTargetWidget:ShowChooseTargetPanel(show)
end

function UIWidgetSkillArea:SwitchActiveSkillUI()
  self:CancelActiveSkillSwitchTimer()
  if self._petSkillUI then
    self:_CloseActiveSkillTip()
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StopPreviewActiveSkill, true, false, self._curPetActiveSkillId, self._curPetPstId)
end

function UIWidgetSkillArea:OnPetSwitchCallBack(go)
  if self:IsAutoFighting() and go then
    self:ShowAutoFightForbiddenMsg()
  else
    self:SwitchActiveSkillUI()
  end
end

function UIWidgetSkillArea:HandleUIChooseTargetConfirm()
  local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self._curPetActiveSkillId, self._curPetPstId)
  self._curPetActiveSkillId = skillConfigData:GetID()
  if skillConfigData:GetSkillType() == SkillType.Active then
    local logicCanCast, log = BattleStatHelper.CheckActiveSkillCastCondition(self._curPetPstId, self._curPetActiveSkillId)
    if not logicCanCast then
      local cmd = ClientExceptionReportCommand.CreateCastPickupActiveException(self._curWidgetPet, log)
      cmd._dbgAutoFightInfo = self._dbgAutoFightInfo
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ClientExceptionReport, cmd)
      if EDITOR then
        Log.exception(echo(cmd))
      end
      return
    end
    self:OnExclusivePetHeadMaskAlpha(0, -1)
    if self._curWidgetPet ~= nil then
      local pm = GameGlobal.GetModule(PetAudioModule)
      InnerGameHelperRender.InnerGamePlayPetUIVoice("Skill", self._curWidgetPet._petTemplateID, true)
      self._curWidgetPet:ClearPower(self._curPetActiveSkillId)
    end
    self._curWidgetPet = nil
  elseif skillConfigData:GetSkillType() == SkillType.TrapSkill then
    self._curWidgetPet = nil
  elseif skillConfigData:GetSkillType() == SkillType.FeatureSkill then
    self._curWidgetPet = nil
    self._uiBattle:FeatureOnChooseTargetConfirm()
  end
  self:_CloseActiveSkillTip()
  self._curPetActiveSkillId = 0
  self._curPetPstId = 0
  self._isCurPetSkillReady = false
  self._previewActiveSkillCheckPass = nil
  self._petSkillUI:ShowCancelBtn(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CastPickUpSkill)
end

function UIWidgetSkillArea:HandleUIChooseTargetGray()
  if not self._curWidgetPet then
    return
  end
  local canCast, reason, forceTips = self._curWidgetPet:GetCanCastAndReason(self._curPetActiveSkillId)
  if forceTips then
    ToastManager.ShowToast(reason)
  elseif self._isCurPetSkillReady == false and not canCast then
    ToastManager.ShowToast(reason)
  else
    local textKey = ActiveSkillCannotCastReasonText[self._activeSkillDisableReason]
    if textKey then
      local text = StringTable.Get(textKey)
      ToastManager.ShowToast(text)
    end
  end
end

function UIWidgetSkillArea:OnCancelActiveSkillBtnOnClick(go)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattle",
    input = "CancelActiveSkillBtnOnClick",
    args = {}
  })
  self:CancelActiveSkillSwitchTimer()
  self:OnExclusivePetHeadMaskAlpha(0, -1)
  self:ShowHideCancelActiveSkillBtn(false)
  self:_CloseActiveSkillTip()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CasterPreviewAnimatorExitPreview, self._curPetPstId, self._curPetActiveSkillId)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StopPreviewActiveSkill, false, true, self._curPetActiveSkillId, self._curPetPstId)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, -1)
end

function UIWidgetSkillArea:GetPetSkillBtn()
  return self._petSkillUI and self._petSkillUI:GetPetSkillBtn()
end

function UIWidgetSkillArea:GetPetMultiSkillIndexBtn(index)
  return self._petMultiSkillUI and self._petMultiSkillUI:GetPetMultiSkillIndexBtn(index)
end

function UIWidgetSkillArea:EnablePickUpSkillCast(canCast)
  local canCastActive = canCast and self._isCurPetSkillReady and self._previewActiveSkillCheckPass
  self:SetPickUpActiveBtnState(canCastActive)
end

function UIWidgetSkillArea:ShowHideSelectTeamPositionButton(pstID, bShow)
  if self:IsMoreFivePet() and self._petSkillUI then
    self._petSkillUI:HideSelf()
  end
end

function UIWidgetSkillArea:OnBattleUISelectTargetTeamPosition(pstID)
  if self:IsMoreFivePet() and self._petSkillUI then
    self._petSkillUI:ShowSelf()
  end
end

function UIWidgetSkillArea:ShowMultiActiveSkillUI(index, petWidget, uiDataArray, isVariantSkillList, lastClickIndex)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PauseGuideWeakLine)
  local posGO = petWidget:GetActiveSkillUIPos()
  local cancelSkillPosGo = petWidget:GetCancelSkillUIPos()
  local petPstID = petWidget:GetPetPstID()
  local petTemplateID = petWidget:GetPetTemplateID()
  self._curWidgetPet = petWidget
  self._curPetPstId = petPstID
  self._previewActiveSkillCheckPass = nil
  self._curWidgetPet:SetUseSubActiveSkillState(false)
  self._petMultiSkillUI:SetIsMoreFivePet(self:IsMoreFivePet())
  self._petMultiSkillUI:SetUiPos(posGO.transform.position)
  self._petMultiSkillUI:SetPetPstId(petPstID)
  self._petMultiSkillUI:SetPetTemplateId(petTemplateID)
  self._petMultiSkillUI:ShowSelf()
  self._petMultiSkillUI:Init(index, uiDataArray, function(castSkillID, pickUpType, ready)
    self._curPetActiveSkillId = castSkillID
    self._isCurPetSkillReady = ready
    self:CancelActiveSkillSwitchTimer()
    self._petMultiSkillUI:ClearCurSkillID()
    self._petMultiSkillUI:HideSelf()
    self:ShowHideCancelActiveSkillBtn(false)
    self:OnCastSkill(castSkillID, pickUpType, petPstID)
  end, isVariantSkillList, lastClickIndex)
  self._chooseTargetWidget:ShowChooseTargetPanel(false)
  self:OnExclusivePetHeadMaskAlpha(BattleConst.ActiveSkillDarkAlpha, petPstID)
  local pm = GameGlobal.GetModule(PetAudioModule)
  InnerGameHelperRender.InnerGamePlayPetUIVoice("StandBy", petWidget._petTemplateID)
  self:_CheckGuide()
end

function UIWidgetSkillArea:OnClickPetHead(castSkillPetPstID, energyReady, curSkillID)
  if self._curPetPstId and self._curPetPstId ~= castSkillPetPstID and self._petMultiSkillUI then
    self._petMultiSkillUI:HideSelf()
  end
end

function UIWidgetSkillArea:HandleUIShowPetInfo(petPstID, isShow)
  if isShow and self._curWidgetPet ~= nil then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CancelActiveSkillCast, self._curPetActiveSkillId, self._curPetPstId)
    self:_CancelActiveSkill()
  end
end

function UIWidgetSkillArea:ShowPetEquipRefineUI(petWidget)
  local petPstID = petWidget:GetPetPstID()
  local buffViewIns
  local buffViewArray = InnerGameHelperRender.GetBuffViewByPetPstID(petPstID)
  for i, buffView in ipairs(buffViewArray) do
    if buffView:GetBuffEffectType() == BuffEffectType.ShowEquipRefineUI then
      buffViewIns = buffView
      break
    end
  end
  if not buffViewIns then
    return
  end
  local objPos = self._petSkillUI:GetEquipRefineDownPosObj()
  local isUp = false
  if InnerGameHelperRender.UICheckIsFifthPet(petPstID) then
    objPos = self._petSkillUI:GetEquipRefineUpPosObj()
    isUp = true
  end
  self._petEquipRefineUI:SetUIPos(objPos.transform.position, isUp)
  self._petEquipRefineUI:ShowSelf()
  self._petEquipRefineUI:Init(petPstID, buffViewIns)
end

function UIWidgetSkillArea:_CheckGuide()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:GuideInProgress() then
    local guides = guideModule:GetCurGuides()
    if guides then
      for _, guide in pairs(guides) do
        local curStep = guide:GetCurStep()
        if curStep and curStep.show then
          local cfg = curStep:GetBtnGuideCfg()
          if cfg and cfg.completeRule == GuideCompleteType.OperationComplete then
            GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Button)
            return
          end
        end
      end
    end
  end
end
