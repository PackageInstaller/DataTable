_class("UIWidgetChooseTarget", UICustomWidget)
UIWidgetChooseTarget = UIWidgetChooseTarget

function UIWidgetChooseTarget:Constructor()
  self:AttachEvent(GameEventType.RefreshPickUpNum, self.RefreshPickUpNum)
  self:AttachEvent(GameEventType.ChangePickUpText, self.ChangePickUpText)
  self:AttachEvent(GameEventType.PuzzleUICountDownOver, self.HandleActiveSkillConfirm)
end

function UIWidgetChooseTarget:OnShow()
  self.enableFakeInput = true
  self._curActiveSkillID = -1
  self._curPetPstID = -1
  self._pickUpType = SkillPickUpType.None
  self._canStartPuzzle = false
  self._chooseTargetPanel = self:GetGameObject("ChooseTargetPanel")
  self._choosehlg = self:GetGameObject("hlg")
  self._chooseColOrRow = self:GetGameObject("colOrRow")
  self._chooseRotate = self:GetGameObject("rotate")
  self._chooseSwitch = self:GetGameObject("switch")
  self._chooseDirection = self:GetGameObject("direction")
  self._choosePuzzleObj = self:GetGameObject("puzzle")
  self._txtPuzzle = self:GetUIComponent("UILocalizationText", "txtPuzzle")
  self._txtPuzzle:SetText(StringTable.Get("str_battle_choose_puzzle"))
  self._chooseDirText = self:GetUIComponent("UILocalizationText", "DirectionText")
  self._chooseDirText:SetText(StringTable.Get("str_battle_choose_dir"))
  self._chooseConfimText = self:GetUIComponent("UILocalizationText", "ActiveSkillConfigText")
  self._chooseConfimText:SetText(StringTable.Get("str_common_cancel"))
  self._choosePreText = self:GetUIComponent("UILocalizationText", "PreText")
  self._choosePreText:SetText(StringTable.Get("str_battle_choose_select"))
  self._chooseNumText = self:GetUIComponent("UILocalizationText", "SelectTargetNumText")
  self._chooseNumText:SetText("0")
  self._activeSkillCancelBtn = self:GetUIComponent("Button", "btnActiveSkillCancel")
  self._activeSkillCancelBtnGO = self:GetGameObject("btnActiveSkillCancel")
  self._activeSkillCancelBtn.interactable = true
  self._btnConfirmActiveSkill = self:GetUIComponent("Button", "btnActiveSkillConfirm")
  self._btnConfirmActiveSkillGO = self:GetGameObject("btnActiveSkillConfirm")
  self._btnConfirmActiveSkill.interactable = false
  self._btnConfirmActiveSkillGO:SetActive(false)
  self._btnConfirmActiveSkillGray = self:GetUIComponent("Button", "btnActiveSkillConfirmGray")
  self._btnConfirmActiveSkillGrayGO = self:GetGameObject("btnActiveSkillConfirmGray")
  self._btnConfirmActiveSkillGrayGO:SetActive(true)
  self._btnConfirmActiveSkillGray.interactable = true
  self._btnconfirmText = self:GetUIComponent("UILocalizationText", "ConfirmText")
  self._btnconfirmText:SetText(StringTable.Get("str_battle_confirm_cast"))
  self._btnconfirmTextGray = self:GetUIComponent("UILocalizationText", "GrayConfirmText")
  self._btnconfirmText:SetText(StringTable.Get("str_battle_confirm_cast"))
end

function UIWidgetChooseTarget:OnHide()
end

function UIWidgetChooseTarget:InitChooseTargetWidget(skillID, petPstID)
  self._curActiveSkillID = skillID
  self._curPetPstID = petPstID
end

function UIWidgetChooseTarget:ShowChooseTargetPanel(isShow)
  self._chooseTargetPanel:SetActive(isShow)
end

function UIWidgetChooseTarget:ChangePickUpText(state, param)
  if state == SkillPickUpTextStateType.Rotate or state == SkillPickUpTextStateType.Switch or state == SkillPickUpTextStateType.ChooseDir or state == SkillPickUpTextStateType.ColOrRow or state == SkillPickUpTextStateType.Puzzle then
    self._choosehlg:SetActive(false)
  else
    self._choosehlg:SetActive(true)
  end
  self._chooseColOrRow:SetActive(state == SkillPickUpTextStateType.ColOrRow)
  self._chooseRotate:SetActive(state == SkillPickUpTextStateType.Rotate)
  self._chooseSwitch:SetActive(state == SkillPickUpTextStateType.Switch)
  self._chooseDirection:SetActive(state == SkillPickUpTextStateType.ChooseDir)
  self._choosePuzzleObj:SetActive(state == SkillPickUpTextStateType.Puzzle)
  if state == SkillPickUpTextStateType.Normal then
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_point"))
  elseif state == SkillPickUpTextStateType.Tel then
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_monster_tel_pos"))
  elseif state == SkillPickUpTextStateType.Direction then
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_dir"))
  elseif state == SkillPickUpTextStateType.Target then
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_target"))
  elseif state == SkillPickUpTextStateType.ChangePreText then
    if param then
      self._choosePreText:SetText(StringTable.Get("str_battle_choose_select"))
    else
      self._choosePreText:SetText(StringTable.Get("str_battle_akxy_feature_ui_selected"))
    end
  end
end

function UIWidgetChooseTarget:SetChooseUIText(pickUpType)
  local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self._curActiveSkillID, self._curPetPstID)
  local pickUpParam = skillConfigData:GetSkillPickParam()
  local pickUpCount = pickUpParam[1]
  self._choosePreText:SetText(StringTable.Get("str_battle_choose_select"))
  self._pickUpType = pickUpType
  self._chooseNumText.transform.parent.gameObject:SetActive(true)
  if pickUpType == SkillPickUpType.Instruction or pickUpType == SkillPickUpType.PickAndTeleportInst or pickUpType == SkillPickUpType.PickDiffPowerInstruction or pickUpType == SkillPickUpType.Akexiya or pickUpType == SkillPickUpType.Yeliya or pickUpType == SkillPickUpType.Hati then
    self._chooseNumText:SetText(tostring(pickUpCount))
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_point"))
  elseif pickUpType == SkillPickUpType.DirectionInstruction then
    self._chooseNumText:SetText(tostring(pickUpCount))
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_dir"))
  elseif pickUpType == SkillPickUpType.ColorInstruction then
    self._chooseNumText:SetText(tostring(pickUpCount))
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_color"))
  elseif pickUpType == SkillPickUpType.PickAndDirectionInstruction or pickUpType == SkillPickUpType.PickOnePosAndRotate or pickUpType == SkillPickUpType.LineAndDirectionInstruction or pickUpType == SkillPickUpType.PickAndDirectionInstruction2 then
    self._chooseNumText:SetText(tostring(1))
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_point"))
  elseif pickUpType == SkillPickUpType.PickDirOrSelf then
    self._chooseNumText:SetText(tostring(pickUpCount))
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_point_or_dir"))
  elseif pickUpType == SkillPickUpType.LinkLine then
    self._choosePreText:SetText(StringTable.Get("str_battle_choose_link"))
    self._chooseNumText:SetText(tostring(pickUpCount))
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_point"))
  elseif pickUpType == SkillPickUpType.PickUpGridTogether then
    self._chooseNumText:SetText(tostring("1"))
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_point"))
  elseif pickUpType == SkillPickUpType.Puzzle then
    self._chooseNumText:SetText(tostring("1"))
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_point"))
  elseif pickUpType == SkillPickUpType.PickUpUIAndTrap then
    pickUpCount = pickUpCount == 0 and 1 or pickUpCount
    self._chooseNumText:SetText(tostring(pickUpCount))
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_point"))
  elseif pickUpType == SkillPickUpType.AlGorePickUp then
    pickUpCount = pickUpCount == 0 and 1 or pickUpCount
    self._choosePreText:SetText(StringTable.Get("str_battle_akxy_feature_ui_selected"))
    self._chooseNumText:SetText(tostring(pickUpCount))
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_point"))
  elseif pickUpType == SkillPickUpType.PickUpAndTurnTetris then
    self._chooseNumText:SetText(tostring(pickUpCount))
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_point"))
  elseif pickUpType == SkillPickUpType.LinkLineSP then
    self._choosePreText:SetText(StringTable.Get("str_battle_choose_link"))
    self._chooseDirText:SetText(StringTable.Get("str_battle_choose_point"))
    self._btnConfirmActiveSkillGrayGO:SetActive(false)
  elseif pickUpType == SkillPickUpType.Moye then
    self._choosePreText:SetText(StringTable.Get("str_battle_choose_link_moye"))
    self._chooseNumText.transform.parent.gameObject:SetActive(false)
    self._chooseDirText:SetText("")
  end
end

function UIWidgetChooseTarget:RefreshPickUpNum(canPickUpNum)
  self._chooseNumText:SetText(canPickUpNum)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._pickUpType == SkillPickUpType.LinkLineSP then
    self._btnConfirmActiveSkillGrayGO:SetActive(false)
  end
  if self._pickUpType == SkillPickUpType.Puzzle and canPickUpNum == 0 then
    self._canStartPuzzle = true
  end
end

function UIWidgetChooseTarget:SetPickUpActiveBtnState(canCastState)
  self._btnConfirmActiveSkill.interactable = canCastState
  self._btnConfirmActiveSkillGO:SetActive(canCastState)
  self._btnConfirmActiveSkillGrayGO:SetActive(not canCastState)
  self._btnConfirmActiveSkillGray.interactable = not canCastState
end

function UIWidgetChooseTarget:BtnActiveSkillCancelOnClick()
  if BattleStatHelper.GetAutoFightStat() then
    return
  end
  self:HandleActiveSkillCancel()
end

function UIWidgetChooseTarget:HandleActiveSkillCancel()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UICancelChooseTarget)
  self:SetPickUpActiveBtnState(false)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
end

function UIWidgetChooseTarget:BtnActiveSkillConfirmOnClick()
  if BattleStatHelper.GetAutoFightStat() then
    return
  end
  if self._pickUpType == SkillPickUpType.Puzzle and self._canStartPuzzle then
    self:HandleEnterPuzzle()
    return
  end
  self:HandleActiveSkillConfirm()
end

function UIWidgetChooseTarget:BtnActiveSkillConfirmGrayOnClick()
  if BattleStatHelper.GetAutoFightStat() then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIChooseTargetGray)
end

function UIWidgetChooseTarget:HandleActiveSkillConfirm()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIChooseTargetConfirm)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowPuzzleUI, false)
  self:ShowChooseTargetPanel(false)
  self:SetPickUpActiveBtnState(false)
  if self._pickUpType == SkillPickUpType.Puzzle then
    self._activeSkillCancelBtn.interactable = true
    self._activeSkillCancelBtnGO:SetActive(true)
  end
  self._pickUpType = SkillPickUpType.None
end

function UIWidgetChooseTarget:HandleEnterPuzzle()
  self:ChangePickUpText(SkillPickUpTextStateType.Puzzle)
  self._activeSkillCancelBtn.interactable = false
  self._activeSkillCancelBtnGO:SetActive(false)
  self._btnconfirmText:SetText(StringTable.Get("str_battle_choose_confim"))
  self._canStartPuzzle = false
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIChooseEnterPuzzle)
end
