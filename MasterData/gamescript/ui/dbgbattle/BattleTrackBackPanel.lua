local BattleTrackBackPanel, Super = System.NewClass("BattleTrackBackPanel", UIBasePanel)
BattleTrackBackPanel.uiResCls = "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Tip_Backtrack.prefab"

function BattleTrackBackPanel:ctor()
  Super.ctor(self)
  self._roundIndex = self:GetDefaultShowRound()
  self._isPreLocked = not BattleBackTrackUtils.IsOpen()
end

function BattleTrackBackPanel:OnBind(binder)
  self.binder = binder
  self:BindButtonEvent()
  self:RefreshRoundIndex()
  self:RefreshUnlockState()
  self.binder:BindEvent(EventMgr.Instance.CloseUIPanel, System.fn(self, self.OnCloseUIPanel))
end

function BattleTrackBackPanel:BindButtonEvent()
  self.binder:BindButtonClick(self.ui.Btn_Left, System.fn(self, self.OnBtnLeft))
  self.binder:BindButtonClick(self.ui.Btn_Right, System.fn(self, self.OnBtnRight))
  self.binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.OnBtnCancel))
  self.binder:BindButtonClick(self.ui.Btn_Sure, System.fn(self, self.OnBtnSure))
  self.binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function BattleTrackBackPanel:RefreshUnlockState()
  if BattleBackTrackUtils.IsOpen() then
    self.binder:SetActive(self.ui.Group_Lock, false)
    self.binder:SetText(self.ui.Text_Sure, LT.Text("Common_Button_Confirm"))
    if self._isPreLocked then
      self._isPreLocked = false
      BattleBackTrackUtils.CheckShowBackTrackTutorial()
    end
  else
    self.binder:SetActive(self.ui.Group_Lock, true)
    self.binder:SetText(self.ui.Text_Sure, LT.Text("BacktrackRedirectHint"))
  end
  local btnState = CommonDefine.Z1ButtonState.High
  if not self:IsFeatureUnlock() then
    btnState = CommonDefine.Z1ButtonState.Unclickable
  end
  self.binder:SetButtonState(self.ui.Btn_Sure, btnState)
end

function BattleTrackBackPanel:OnCloseUIPanel(url)
  if url == Urls.BpMainView then
    self:RefreshUnlockState()
  end
end

function BattleTrackBackPanel:IsFeatureUnlock()
  local _, bpFeatureUnlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.BattlePass, PlayerDataUtils.GetFeatureMainTypeKey())
  return bpFeatureUnlocked
end

function BattleTrackBackPanel:OnBtnSure()
  if not BattleBackTrackUtils.IsOpen() then
    local bpFeatureUnlocked = self:IsFeatureUnlock()
    if bpFeatureUnlocked then
      BattlePassDataUtils.OpenBuyCore()
    else
      BattleBackTrackUtils.TryShowCorePrivilegeLockedTip()
    end
    return
  end
  EventMgr.Instance.ChooseRewindToBout:Dispatch(self._roundIndex)
  self.binder:BindTimer(0.1, 0, nil, function()
    if bg.battleScene then
      bg.battleScene:RestartBattle(nil, true)
    end
  end)
end

function BattleTrackBackPanel:OnBtnLeft()
  if self._roundIndex > 1 then
    self._roundIndex = self._roundIndex - 1
    self:RefreshRoundIndex()
  end
end

function BattleTrackBackPanel:OnBtnRight()
  local maxRound = self._roundIndex
  if bg.battleDataCenter then
    local playerRoleModel = bg.battleDataCenter:GetPlayerRoleDataModel()
    if playerRoleModel then
      maxRound = playerRoleModel:GetProperty("rewind_bout")
    end
  end
  if maxRound > DT.GetConstant("MaxBacktrackRounds", 25) then
    maxRound = DT.GetConstant("MaxBacktrackRounds", 25)
  end
  if maxRound > self._roundIndex then
    self._roundIndex = self._roundIndex + 1
    self:RefreshRoundIndex()
  end
end

function BattleTrackBackPanel:GetDefaultShowRound()
  local defaultRound = 1
  if bg.battleDataCenter then
    defaultRound = bg.battleDataCenter:GetCurBout()
  end
  local maxRound = DT.GetConstant("MaxBacktrackRounds", 25)
  if defaultRound > maxRound then
    defaultRound = maxRound
  end
  return defaultRound
end

function BattleTrackBackPanel:RefreshRoundIndex()
  self.binder:SetText(self.ui.Text_BacktrackRound, self._roundIndex)
end

function BattleTrackBackPanel:OnBtnCancel()
  self:Close()
end

return BattleTrackBackPanel
