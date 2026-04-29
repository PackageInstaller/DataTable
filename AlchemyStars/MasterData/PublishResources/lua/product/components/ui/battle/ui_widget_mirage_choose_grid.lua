_class("UIWidgetMirageChooseGrid", UICustomWidget)
UIWidgetMirageChooseGrid = UIWidgetMirageChooseGrid

function UIWidgetMirageChooseGrid:Constructor()
  self:AttachEvent(GameEventType.RefreshMiragePickUpGrid, self.RefreshMiragePickUpGrid)
end

function UIWidgetMirageChooseGrid:OnShow()
  self.enableFakeInput = true
  self._chooseGridPanel = self:GetGameObject("ChooseGridPanel")
  self._choosehlg = self:GetGameObject("hlg")
  self._choosehlg:SetActive(true)
  self._chooseNumText = self:GetUIComponent("UILocalizationText", "SelectGridNumText")
  self._chooseNumText:SetText("1")
  self._activeSkillCancelBtn = self:GetUIComponent("Button", "btnCancel")
  self._activeSkillCancelBtn.interactable = true
  self._btnConfirm = self:GetUIComponent("Button", "btnConfirm")
  self._btnConfirmGO = self:GetGameObject("btnConfirm")
  self._btnConfirmGray = self:GetUIComponent("Button", "btnConfirmGray")
  self._btnConfirmGrayGO = self:GetGameObject("btnConfirmGray")
  self:SetPickUpConfirmBtnState(false)
  self._autoFightState = false
  self:AttachEvent(GameEventType.AutoFight, self._AutoFight)
end

function UIWidgetMirageChooseGrid:OnHide()
  self:DetachEvent(GameEventType.AutoFight, self._AutoFight)
end

function UIWidgetMirageChooseGrid:_AutoFight(enable)
  self._autoFightState = enable
end

function UIWidgetMirageChooseGrid:ShowChooseGridPanel(show)
  self._chooseGridPanel:SetActive(show)
  if show then
    self._chooseNumText:SetText(1)
    self:SetPickUpConfirmBtnState(false)
    if self._autoFightState then
      self:HandleConfirm(true)
    end
  end
end

function UIWidgetMirageChooseGrid:RefreshMiragePickUpGrid(isPick)
  local num = isPick and 0 or 1
  self._chooseNumText:SetText(num)
  self:SetPickUpConfirmBtnState(isPick)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
end

function UIWidgetMirageChooseGrid:SetPickUpConfirmBtnState(canConfirmState)
  self._btnConfirm.interactable = canConfirmState
  self._btnConfirmGO:SetActive(canConfirmState)
  self._btnConfirmGray.interactable = not canConfirmState
  self._btnConfirmGrayGO:SetActive(not canConfirmState)
end

function UIWidgetMirageChooseGrid:BtnCancelOnClick()
  if self._autoFightState then
    return
  end
  self:HandleCancel()
end

function UIWidgetMirageChooseGrid:BtnConfirmOnClick()
  if self._autoFightState then
    return
  end
  self:HandleConfirm(false)
end

function UIWidgetMirageChooseGrid:BtnConfirmGrayOnClick()
  if self._autoFightState then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIMirageChooseGridGray)
end

function UIWidgetMirageChooseGrid:HandleCancel()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIMirageCancelChoose)
  self:SetPickUpConfirmBtnState(false)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
end

function UIWidgetMirageChooseGrid:HandleConfirm(autoFight)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIMirageChooseGridConfirm, autoFight)
  self:ShowChooseGridPanel(false)
  self:SetPickUpConfirmBtnState(false)
end
