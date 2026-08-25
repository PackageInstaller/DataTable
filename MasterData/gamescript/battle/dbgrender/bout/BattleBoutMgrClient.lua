local BattleBoutMgrClient = System.NewClass("BattleBoutMgrClient")

function BattleBoutMgrClient:ctor()
  self.boutData = bg.battleDataCenter.boutData
  self.boutSvrDataList = {}
end

function BattleBoutMgrClient:Awake()
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.BattleBegin, self.OnBattleBegin, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeBoutPhase, self.OnChangeBoutPhase, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeExtraBout, self.OnChangeExtraBout, self)
  EventMgr.Instance.SelectInitCardAnimStart:RegisterEvent(System.fn(self, self.OnEnterSelectInitCardStage))
  EventMgr.Instance.SelectInitCardAnimEnd:RegisterEvent(System.fn(self, self.OnExitSelectInitCardStage))
end

function BattleBoutMgrClient:OnChangeBoutPhase(data)
  if not self.inSelectInitCardStage then
    self:ChangeBoutPhase(data.newPhase, data.config)
  else
    table.insert(self.boutSvrDataList, data)
  end
end

function BattleBoutMgrClient:GetPhase()
  return self.boutData.phase
end

function BattleBoutMgrClient:GetCamp()
  return self.boutData.camp
end

function BattleBoutMgrClient:GetBoutNum()
  return self.boutData.boutNumber
end

function BattleBoutMgrClient:GetBoutDamage()
  local boutDamage = self.boutData.boutDamage or 0
  return boutDamage
end

function BattleBoutMgrClient:Dispose()
  bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
  EventMgr.Instance.SelectInitCardAnimStart:RemoveEvent(System.fn(self, self.OnEnterSelectInitCardStage))
  EventMgr.Instance.SelectInitCardAnimEnd:RemoveEvent(System.fn(self, self.OnExitSelectInitCardStage))
end

function BattleBoutMgrClient:Tick(_)
end

function BattleBoutMgrClient:RecoverBout(boutData, boutDamage)
  boutDamage = boutDamage or 0
  bg.battleDataCenter:SetRealCamp(boutData.camp)
  self.boutData:SetBoutCamp(boutData.camp)
  self.boutData:SetBoutNumber(boutData.boutNumber)
  self.boutData:SetExtraBout(boutData.isExtraBout)
  self.boutData:SetBoutPhase(boutData.phase)
  self.boutData:SetBoutDamage(boutDamage)
end

function BattleBoutMgrClient:OnBattleBegin()
  self:_DispatchBattleBeginAwaiter()
end

function BattleBoutMgrClient:ChangeBoutPhase(newPhase, config)
  if bg.battlePanel and bg.battlePanel.ClearEndTurnDelayTimer then
    bg.battlePanel:ClearEndTurnDelayTimer()
  end
  if newPhase == bc.BoutPhase.Begin then
    if bg.battleDataCenter:IsMyCamp(config.camp) then
      bg.battleDataCenter:SetOpMode(rc.OpMode.Inspect)
    else
      self:_DispatchPhaseBeginAwaiter()
    end
  elseif newPhase == bc.BoutPhase.Action and bg.battleDataCenter:IsMyCamp(config.camp) then
    bg.battleDataCenter:SetOpMode(rc.OpMode.Play)
  end
  self.boutData:SetBoutCamp(config.camp)
  bg.battleDataCenter:SetRealCamp(config.camp)
  self.boutData:SetBoutPhase(newPhase)
  if config.boutNumber then
    self.boutData:SetBoutNumber(config.boutNumber)
  end
  if bg.battleDataCenter:IsMyCamp(config.camp) and newPhase == bc.BoutPhase.Begin then
    bg.battlePanel.isClickedBtnBout = false
    self.boutData:SetBoutDamage(0)
    self.boutData:SetStatsBoutDamage(0)
    bg.battleRender.recordMgr:EnableFirstTrigger(true)
  end
end

function BattleBoutMgrClient:_DispatchBattleBeginAwaiter()
  self.battleBeginAwaiter = Awaiter.Dispatch("战斗开始", 20, true)
end

function BattleBoutMgrClient:CompleteBattleBeginAwaiter()
  if self.battleBeginAwaiter then
    self.battleBeginAwaiter:SetCompleted()
  end
  self.battleBeginAwaiter = nil
end

function BattleBoutMgrClient:_DispatchPhaseBeginAwaiter()
  self.phaseBeginAwaiter = Awaiter.Dispatch("回合开始", nil, true)
  EventMgr.Instance.BattleBoutAnimStarted:Dispatch()
end

function BattleBoutMgrClient:CompletePhaseBeginAwaiter()
  if self.phaseBeginAwaiter then
    self.phaseBeginAwaiter:SetCompleted()
  end
  self.phaseBeginAwaiter = nil
  bg.battleDataCenter:SetOpMode(rc.OpMode.Play)
  EventMgr.Instance.BattleBoutAnimEnded:Dispatch()
end

function BattleBoutMgrClient:AddBoutDamage(value)
  self.boutData:SetBoutDamage(self.boutData.boutDamage + value)
end

function BattleBoutMgrClient:OnChangeExtraBout(data)
  local bResult
  local curState = data.isExtraBout
  local oldState = self.boutData:GetExtraBout()
  if true == oldState and false == curState then
    bResult = false
  elseif false == oldState and true == curState then
    bResult = true
    bg.battlePanel.isClickedBtnBout = false
  end
  self.boutData:SetExtraBout(data.isExtraBout)
  if nil ~= bResult then
    local eventName = bResult and "SFX_REALM_D_SPACE_START" or "SFX_REALM_D_SPACE_END"
    AudioManager.Instance:PostSoundEvent(eventName)
  end
end

function BattleBoutMgrClient:OnEnterSelectInitCardStage()
  self.inSelectInitCardStage = true
end

function BattleBoutMgrClient:OnExitSelectInitCardStage()
  self.inSelectInitCardStage = false
  for _, data in ipairs(self.boutSvrDataList or {}) do
    if data then
      self:ChangeBoutPhase(data.newPhase, data.config)
    end
  end
end

function BattleBoutMgrClient:GetIsExtraBout()
  return self.boutData.isExtraBout
end

return BattleBoutMgrClient
