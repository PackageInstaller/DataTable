local BattleGuardManager, Super = System.NewClass("BattleGuardManager", Manager, IUpdater)

function BattleGuardManager:ctor()
  Super.ctor(self)
  self.battleUid = 0
  self.battleStartTime = 0
  self.battleEndTime = 0
  self.isInBattle = false
end

function BattleGuardManager:Awake(binder)
  Super.Awake(self)
  self.binder = binder
  binder:BindEvent(EventMgr.Instance.BattleEvent, System.fn(self, self.PcallOnBattleEvent))
end

function BattleGuardManager:ReqRefreshBattle()
end

function BattleGuardManager:Update()
end

function BattleGuardManager:IsValid()
  if bg.battleRender and bg.battleDataCenter and bg.battleScene then
    return true
  end
end

function BattleGuardManager:IsReport(eventName)
  local ignoreReport = {
    [rc.BattleEvent.MoveCardToHand] = true,
    [rc.BattleEvent.InsertCard] = true
  }
  return not ignoreReport[eventName]
end

function BattleGuardManager:PcallOnBattleEvent(eventName, eventData)
  pcall(System.fn(self, self.OnBattleEvent), eventName, eventData)
end

function BattleGuardManager:OnBattleEvent(eventName, eventData)
  if self:IsReport(eventName) then
    Logger.ReportApusInfo("BattleStep:{step}:{data}", eventName, eventData or "")
  end
  if eventName == rc.BattleEvent.Start then
    self:OnBattleStart(eventData)
  elseif eventName == rc.BattleEvent.LoadScene then
    self:OnLoadScene()
  elseif eventName == rc.BattleEvent.LoadSceneDone then
    self:OnLoadSceneDone()
  elseif eventName == rc.BattleEvent.EntranceAnimationEnd then
    self:OnEntranceAnimationEnd()
  elseif eventName == rc.BattleEvent.FirstPlayedRecord then
    self:OnPlayedRecord()
  elseif eventName == rc.BattleEvent.MoveCardToHand then
    self:OnMoveCardToHand()
  elseif eventName == rc.BattleEvent.InsertCard then
    self:OnInsertCard()
  elseif eventName == rc.BattleEvent.BattleEnd then
    self:OnBattleEnd()
  end
end

function BattleGuardManager:OnBattleStart(battleData)
  self.battleUid = battleData.battleUid
  self.battleStartTime = TimeUtils.GetServerTime()
  self.battleEndTime = 0
end

function BattleGuardManager:OnBattleEnd(eventData)
  self:FinishCheckPVEStartOnInitCard()
  self:FinishCheckPVPStartOnInitCard()
end

function BattleGuardManager:OnLoadScene()
end

function BattleGuardManager:OnLoadSceneDone()
end

function BattleGuardManager:OnEntranceAnimationEnd()
  if bg.isPVE then
    self:CheckIsPVEBattleStuckOnInitCard()
  elseif bg.isPVP then
    self:CheckIsPVPBattleStuckOnInitCard()
  end
end

function BattleGuardManager:OnPlayedRecord()
end

function BattleGuardManager:OnMoveCardToHand()
  self:FinishCheckPVPStartOnInitCard()
  self:FinishCheckPVEStartOnInitCard()
end

function BattleGuardManager:OnInsertCard()
  self:FinishCheckPVPStartOnInitCard()
  self:FinishCheckPVEStartOnInitCard()
end

function BattleGuardManager:CheckIsPVEBattleStuckOnInitCard()
end

function BattleGuardManager:FinishCheckPVEStartOnInitCard()
  self.binder:StopTimer(self._pveStuckTicker)
end

function BattleGuardManager:CheckIsPVPBattleStuckOnInitCard()
end

function BattleGuardManager:FinishCheckPVPStartOnInitCard()
  self.binder:StopTimer(self._pvpStuckTicker)
end

return BattleGuardManager
