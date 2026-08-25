local PVPReplayBattlePanel, Super = System.NewClass("PVPReplayBattlePanel", UIBasePanel)
PVPReplayBattlePanel.uiResCls = UI_Pvp_Panel_PlaybackResource
PVPReplayBattlePanel.closeWithoutAnim = true

function PVPReplayBattlePanel:ctor(battleUuid, watchUid, closeCb, localFilePath)
  Super.ctor(self)
  self.battleUuid = battleUuid
  self.watchUid = watchUid
  self.replayPlayer = nil
  self.closeCb = closeCb
  self.localFilePath = localFilePath
  self._speedIndex = nil
  self._isPause = false
  self._isOpposite = false
end

function PVPReplayBattlePanel:OnBind(binder)
  self.binder = binder
  self:CreateReplayPlayer()
  self:SetPauseBtnState()
  self:StartPlay()
  self:OnChangeSpeed()
  self.binder:BindButtonClick(self.ui.Btn_Block_Window, System.fn(self, self.OnSwitchCamp))
  self.binder:BindButtonClick(self.ui.Btn_GameSpeed, System.fn(self, self.OnChangeSpeed))
  self.binder:BindButtonClick(self.ui.Btn_Pause, System.fn(self, self.OnSetPause))
  binder:BindEvent(EventMgr.Instance.BattleStart, System.fn(self, self.OnReplayStart))
  binder:BindEvent(EventMgr.Instance.BattleReplayStop, System.fn(self, self.Close))
  binder:BindEvent(EventMgr.Instance.BattleReplayFailed, System.fn(self, self.Close))
  binder:BindEvent(EventMgr.Instance.OnEnterScene, System.fn(self, self.OnEnterScene))
  binder:BindEvent(EventMgr.Instance.BattleReplayPauseTime, System.fn(self, self.OnBattleReplayPause))
  binder:BindEvent(EventMgr.Instance.OnPanelOpened, System.fn(self, self.OnPanelOpened))
  binder:BindEvent(EventMgr.Instance.OnReplayExtraScale, System.fn(self, self.OnReplayExtraScale))
end

function PVPReplayBattlePanel:OnUnbind()
  Super.OnUnbind()
  if self.replayPlayer then
    self.replayPlayer:Stop()
  end
  if SceneMgr.Instance:IsInTown() then
    return
  end
  BattleManager.Instance:DisposeCurrentBattle()
  if self.closeCb then
    self.closeCb()
  else
    SceneMgr.Instance:EnterTown()
  end
end

function PVPReplayBattlePanel:OnReplayExtraScale(scale)
  if self.replayPlayer then
    self.replayPlayer:SetExtraScale(scale or 1)
  end
end

function PVPReplayBattlePanel:OnBattleReplayPause(time)
  if not self.replayPlayer then
    return
  end
  self.replayPlayer:SetPauseDelay(time)
end

function PVPReplayBattlePanel:CreateReplayPlayer()
  local defaultSpeed = DT.GetConstant("PVPplaybackSpeed")
  self.replayPlayer = BattleReplayPlayer(self.battleUuid, self.watchUid, defaultSpeed)
  self.ui.uiNode:SetActive(false)
end

function PVPReplayBattlePanel:StartPlay()
  if self.replayPlayer then
    if self.localFilePath and self.localFilePath ~= "" then
      self.replayPlayer:LoadFromLocalFile(self.localFilePath)
    else
      self.replayPlayer:DownloadRecord()
    end
    self.replayPlayer:Play()
  end
end

function PVPReplayBattlePanel:OnReplayStart()
  if bg.isPVE then
    self.binder:BindTimer(0.5, 0, nil, System.fn(self, self.ShowSelf))
  end
end

function PVPReplayBattlePanel:OnPanelOpened(panelUrl)
  if panelUrl == Urls.PvPSelectInitCardPanel or panelUrl == Urls.PvPOtherSelectInitCardPanel then
    self:ShowSelf()
  end
end

function PVPReplayBattlePanel:ShowSelf()
  self.ui.uiNode:SetActive(true)
  self.ui.Btn_Block_Window:SetActive(bg.isPVP)
end

function PVPReplayBattlePanel:OnEnterScene(sceneType, newSceneType)
  if newSceneType == cd.SceneType.Login then
    self.closeCb = nil
  end
  if sceneType ~= cd.SceneType.Battle then
    self:Close()
  end
end

function PVPReplayBattlePanel:OnSwitchCamp()
  local CAMP1 = bc.BattleCamp.Camp1
  local CAMP2 = bc.BattleCamp.Camp2
  if not self.watchingCamp then
    self.watchingCamp = bg.battleDataCenter:GetMyCamp()
  end
  local newCamp = self.watchingCamp == CAMP1 and CAMP2 or CAMP1
  self.watchingCamp = newCamp
  if bg.battleDataCenter then
    bg.battleDataCenter:SetMyCamp(newCamp)
  end
  self._isOpposite = not self._isOpposite
  EventMgr.Instance.PVPViewChange:Dispatch(self.watchingCamp, self._isOpposite)
end

function PVPReplayBattlePanel:OnChangeSpeed()
  local speedList = {
    DT.GetConstant("PVPPlaybackSpeed"),
    3
  }
  local speedGameObj = {
    self.ui.Image_Once,
    self.ui.Image_Twice
  }
  if not self._speedIndex then
    self._speedIndex = 1
  else
    self._speedIndex = self._speedIndex + 1
    if self._speedIndex > #speedList then
      self._speedIndex = 1
    end
  end
  local playSpeed = speedList[self._speedIndex]
  if self.ui.Text_GameSpeed then
    if self._speedIndex <= 2 then
      self.binder:SetText(self.ui.Text_GameSpeed, ItemNumUtils.GetStr(self._speedIndex))
    else
      self.binder:SetText(self.ui.Text_GameSpeed, ItemNumUtils.GetStr(playSpeed))
    end
  end
  for goIndex, go in ipairs(speedGameObj) do
    self.binder:SetActive(go, self._speedIndex == goIndex)
  end
  if bg.battleRender then
    bg.battleRender.gameSpeed = playSpeed
    EventMgr.Instance.UpdateBattleSpeed:Dispatch()
  end
end

function PVPReplayBattlePanel:OnSetPause()
  if not self.replayPlayer then
    return
  end
  self._isPause = not self._isPause
  self.replayPlayer:SetPause(self._isPause)
  self:SetPauseBtnState()
end

function PVPReplayBattlePanel:SetPauseBtnState()
  if self._isPause then
    self.binder:SetButtonState(self.ui.Btn_Pause, cd.Z1ButtonState.High)
  else
    self.binder:SetButtonState(self.ui.Btn_Pause, cd.Z1ButtonState.Normal)
  end
end

return PVPReplayBattlePanel
