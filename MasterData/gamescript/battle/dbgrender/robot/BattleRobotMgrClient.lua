local BattleRobotMgrClient, Super = System.NewClass("BattleRobotMgrClient")

function BattleRobotMgrClient:ctor()
  Super.ctor(self)
  self.robotTime = 0
  self.auto = false
  self._tickTime = 0
  self._openUIPanelDict = {}
end

function BattleRobotMgrClient:Dispose()
  self:UnregisterEvents()
end

function BattleRobotMgrClient:Awake()
  self:RegisterEvents()
end

function BattleRobotMgrClient:RegisterEvents()
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.CommandResult, self.OnCommandResult, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeRoleFsmState, self.OnChangeFsmState, self)
  EventMgr.Instance.OpenUIPanel:RegisterEvent(System.fn(self, self.OnOpenUIPanel))
  EventMgr.Instance.CloseUIPanel:RegisterEvent(System.fn(self, self.OnCloseUIPanel))
end

function BattleRobotMgrClient:UnregisterEvents()
  if bg.battleRender and bg.battleRender.eventMgr then
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
  end
  EventMgr.Instance.OpenUIPanel:RemoveEvent(System.fn(self, self.OnOpenUIPanel))
  EventMgr.Instance.CloseUIPanel:RemoveEvent(System.fn(self, self.OnCloseUIPanel))
end

function BattleRobotMgrClient:Tick(deltaTime)
  if self._isPause then
    return
  end
  self._tickTime = self._tickTime + deltaTime
  self.robotTime = self.robotTime + deltaTime
  if not self.auto then
    return
  end
  local gameSpeed = bg.battleRender.gameSpeed or 1
  if self.robotTime < 1 / gameSpeed then
    return
  end
  local recordMgr = bg.battleRender.recordMgr
  if not self:_CanIssueNextCommand(recordMgr, gameSpeed) then
    return
  end
  bg.battleRender:SendCommand(BattleCommand.lg_RobotAction, {
    playerId = bg.battleDataCenter:GetMyPlayerId()
  })
  self.robotTime = 0
end

function BattleRobotMgrClient:_CanIssueNextCommand(recordMgr, gameSpeed)
  if recordMgr:GetRecordState() == bc.BattleRecordPlayState.Stop or not recordMgr:IsHaveRecord() then
    return true
  end
  if recordMgr.recordList[1] == nil then
    local overlap = (bc.DifferentAwakerOverlapDuration or 0.3) / gameSpeed
    if overlap >= recordMgr:GetRemainingPlayTime() then
      return true
    end
  end
  return false
end

function BattleRobotMgrClient:SetPause(isPause)
  self._isPause = isPause
end

function BattleRobotMgrClient:SetAuto(auto)
  if nil == auto then
    self.auto = not self.auto
  else
    self.auto = auto
  end
  self.robotTime = 0
end

function BattleRobotMgrClient:MinusRobotTime(time)
  local _ = time
end

function BattleRobotMgrClient:OnCommandResult(msgData)
  if not self.auto then
    return
  end
  if msgData.selectType == bc.TargetSelectType.Relic then
    UIManager.Instance:CloseByUrl(Urls.BattleRelicSelectPanel)
  elseif msgData.selectType == bc.TargetSelectType.KeeperSkill then
    UIManager.Instance:CloseByUrl(Urls.KeeperSkillSelectPanel)
  elseif msgData.selectType == bc.TargetSelectType.Card then
    UIManager.Instance:CloseByUrl(Urls.DeckCardSelectPanel)
  elseif msgData.selectType == bc.TargetSelectType.Awaker then
    UIManager.Instance:CloseByUrl(Urls.DbgAwakerSelectionPanel)
  elseif msgData.selectType == bc.TargetSelectType.CardDrop or msgData.selectType == bc.TargetSelectType.KeeperSkillDrop then
    print("[CardDrop] BattleRobotMgrClient:OnCommandResult closing BattleCardDropSelectView")
    UIManager.Instance:CloseByUrl(Urls.BattleCardDropSelectView)
  end
end

function BattleRobotMgrClient:OnChangeFsmState(data)
  if not self.auto then
    return
  end
  if data.newState == bc.AwakerFsmState.Attack then
    UIManager.Instance:CloseByUrl(Urls.BattleRelicSelectPanel)
    UIManager.Instance:CloseByUrl(Urls.KeeperSkillSelectPanel)
    UIManager.Instance:CloseByUrl(Urls.DeckCardSelectPanel)
    UIManager.Instance:CloseByUrl(Urls.DbgAwakerSelectionPanel)
    UIManager.Instance:CloseByUrl(Urls.BattleCardDropSelectView)
  end
end

function BattleRobotMgrClient:GetCaredUrls(url)
  if self._caredUrls then
    return self._caredUrls
  end
  self._caredUrls = {
    Urls.StageStarDetailPanel,
    Urls.TutorialMainView,
    Urls.SettingMainPanel,
    Urls.AlertConfirm2Panel,
    Urls.AlertConfirm3Panel
  }
  return self._caredUrls
end

function BattleRobotMgrClient:OnOpenUIPanel(url)
  if not self.auto then
    return
  end
  if not table.contains(self:GetCaredUrls(), url) then
    return
  end
  Alert.ShowStr(LT.Text("CancelAutoBattle"))
  SettingManager.Instance:SetAutoFight(false)
end

function BattleRobotMgrClient:OnCloseUIPanel(url)
end

return BattleRobotMgrClient
