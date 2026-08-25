local CSTime = CS.UnityEngine.Time
local MaxSmoothTime = 0.03333333333333333
local DEFAULT_AWAITER_OVER_TIME = 6
local RECORD_OVER_TIME = 10
local EventChangeFsm = BattleRenderEvent.ChangeRoleFsmState
local BattleRecordMgrClient, Super = System.NewClass("BattleRecordMgrClient")

function BattleRecordMgrClient:ctor()
  Super.ctor(self)
  self:RegisterEvents()
  self.playRecordState = bc.BattleRecordPlayState.Play
  self.recordList = {}
  self.curPlayRecordList = {}
  self.recordTime = 0
  self.realRecordTime = 0
  self.reportToApusTime = 0
  self.animAwaiters = {}
  self.stopAllAwaiters = {}
  self.isBoutPhaseBegin = false
  self.isBoutPhaseEnd = false
  self.isWaitingAnim = false
  self.isReceivedBattleWin = false
  self.isPlayedRecord = false
  self:SetUseSmoothTime(false)
  self.isHaveDeadResist = false
  self.isConfirmRespawn = false
end

function BattleRecordMgrClient:SetUseSmoothTime(isSmooth)
  if isSmooth ~= self.isUseSmoothTime then
    self.isUseSmoothTime = isSmooth
    CS.AMTimeline.AMPlayer.UseSoothTime = isSmooth
  end
end

function BattleRecordMgrClient:Awake()
  self.eventMgr = bg.battleRender.eventMgr
  EventMgr.Instance.AnimAwaiterArise:RegisterEvent(System.fn(self, self.OnAnimAwaiterArise))
end

function BattleRecordMgrClient:RecoverRecords()
  local recordData = bg.battleDataCenter.recoverRecords
  if not recordData then
    return
  end
  if bg.isReplay then
    return
  end
  bg.battleDataCenter.recoverRecords = nil
  local recoverEvents = {
    [BattleRenderEvent.SelectCardEffect] = true,
    [BattleRenderEvent.SelectMoveCard] = true,
    [BattleRenderEvent.SelectTargets] = true,
    [BattleRenderEvent.BattleFinish] = true,
    [BattleRenderEvent.Confirm] = true,
    [BattleRenderEvent.SelectInitCard] = true
  }
  for index = 1, #recordData.frameList do
    local frameData = recordData.frameList[index]
    if not recoverEvents[frameData.eventId] or frameData.eventId == BattleRenderEvent.SelectInitCard and bg.battleDataCenter.boutData.boutNumber > 0 then
    else
      self:SendFrameData(frameData)
    end
  end
end

function BattleRecordMgrClient:Dispose()
  EventMgr.Instance.AnimAwaiterArise:RemoveEvent(System.fn(self, self.OnAnimAwaiterArise))
  self:UnregisterEvents()
end

function BattleRecordMgrClient:SetRecordState(state, revertPlayTime)
  self.playRecordState = state
  if self._revertPlayTimer then
    bg.battleRender:UnperformWithDelay(self._revertPlayTimer)
  end
  if state ~= bc.BattleRecordPlayState.Play then
    self._revertPlayTimer = bg.battleRender:PerformWithDelay(revertPlayTime or 3, function()
      self.playRecordState = bc.BattleRecordPlayState.Play
      self._revertPlayTimer = nil
    end)
  end
end

function BattleRecordMgrClient:GetRecordState()
  return self.playRecordState
end

function BattleRecordMgrClient:GetNextRecordData()
  return self.recordList[1]
end

function BattleRecordMgrClient:IsHaveRecord()
  return self.recordList[1] ~= nil
end

function BattleRecordMgrClient:GetRemainingPlayTime()
  if not self.curPlayRecordList then
    return 0
  end
  local last = self.curPlayRecordList[#self.curPlayRecordList]
  if not last or not last.time then
    return 0
  end
  do return math.max, 0 end
  return math.max, 0, last.time - (self.recordTime or 0), self.recordTime or 0
end

function BattleRecordMgrClient:IsHaveRecordType(frameList, recordType)
  for _, frameData in ipairs(frameList) do
    if frameData.eventId == recordType then
      return true
    end
  end
end

function BattleRecordMgrClient:IsHaveAttackRecord(frameList)
  for _, frameData in ipairs(frameList) do
    if frameData.eventId == BattleRenderEvent.ChangeRoleFsmState and frameData.data.newState == bc.AwakerFsmState.Attack or frameData.eventId == BattleRenderEvent.UseCard then
      return true
    end
  end
end

function BattleRecordMgrClient:PushRecordData(frameList)
  self:CheckFirstTriggerRecord(frameList)
  self:SetRealData(frameList)
  table.insert(self.recordList, frameList)
  self:_ParseRealEnergy()
end

function BattleRecordMgrClient:PrintRecordData(frameList)
  for _, frameData in ipairs(frameList) do
    if frameData.eventId == BattleRenderEvent.BattleFinish then
      Logger.ReportApusInfo("OnReceive Battle Finish")
    end
  end
end

function BattleRecordMgrClient:OnReceiveInstantRecord(msgData)
  local frameList = msgData and msgData.frameList
  for _, frameData in ipairs(frameList or {}) do
    self:SendFrameData(frameData)
  end
end

function BattleRecordMgrClient:OnReceiveRecord(msgData)
  local frameList = msgData and msgData.frameList
  if not self:_IsAttachPostAction(frameList) then
    self:_OnReceiveRecord(frameList)
    return
  end
  local subFrameList = {}
  for _, frameData in ipairs(frameList or {}) do
    if frameData.eventId == BattleRenderEvent.AttachPostAction then
      self:_OnReceiveRecord(subFrameList)
      subFrameList = {}
      table.insert(subFrameList, {
        time = frameData.time,
        isAttachPostAction = true
      })
    end
    table.insert(subFrameList, frameData)
  end
  self:_OnReceiveRecord(subFrameList)
end

function BattleRecordMgrClient:_OnReceiveRecord(frameList)
  if not frameList then
    Logger.Error("ERROR: recordData.frameList is nil.")
  end
  if self:_IsBattleEndOrConfirm(frameList) then
    bg.battleRender.robotMgr:SetPause(true)
  else
    bg.battleRender.robotMgr:SetPause(false)
  end
  if self:_IsBattleWin(frameList) then
    self.isReceivedBattleWin = true
  end
  if self:_IsBoutPhaseBegin(frameList) then
    local boutPhaseBeginFrameList = self:_SeparateBoutPhaseBeginFrame(frameList)
    self:PushRecordData(boutPhaseBeginFrameList)
  end
  local swallowEmbryoPhaseFrame = self:_SeparateSwallowEmbryoPhaseFrame(frameList)
  if swallowEmbryoPhaseFrame then
    self:PushRecordData(swallowEmbryoPhaseFrame)
  end
  local dimentionRechargeFrame = self:_SeparateDimentionRechargeFrame(frameList)
  if dimentionRechargeFrame then
    self:PushRecordData(dimentionRechargeFrame)
  end
  self:PushRecordData(frameList)
end

function BattleRecordMgrClient:IsStopTick()
  if self.playRecordState == bc.BattleRecordPlayState.Stop then
    return true
  end
  if self.playRecordState == bc.BattleRecordPlayState.Pause then
    return true
  end
  if not bg.battlePanel then
    return true
  end
  if table.next(self.stopAllAwaiters) then
    return true
  end
  if self:CheckIsInWaitingAnimEvent() then
    return true
  end
end

function BattleRecordMgrClient:IsCanPlayNext()
  if bg.battleScene:HasAwakerPlayingSkill() then
    return false
  end
  if self:IsHaveAwaiterOf({KeeperSkillTimeline = true}) then
    return false
  end
  return true
end

function BattleRecordMgrClient:_GetNextRecordList()
  local nextFrameList = table.remove(self.recordList, 1)
  local frameData = nextFrameList and nextFrameList[1]
  if not frameData then
    return
  end
  self:PreDealRecordData(nextFrameList)
  return nextFrameList
end

function BattleRecordMgrClient:Reset()
  self.recordList = {}
  self.curPlayRecordList = nil
  self.playRecordState = bc.BattleRecordPlayState.Play
  self.isBoutPhaseBegin = false
  self.isBoutPhaseEnd = false
  self.isWaitingAnim = false
  self:ResetAwaiters()
end

function BattleRecordMgrClient:ResetAwaiters()
  self.isWaitingAnim = false
  local allAwaiter = self.animAwaiters
  self.animAwaiters = {}
  self.stopAllAwaiters = {}
  for awaiter in pairs(allAwaiter) do
    awaiter:Recycle()
  end
end

function BattleRecordMgrClient:ReportApusMessage()
  if UIManager.Instance:GetWindow(Urls.DbgAwakerSelectionPanel) then
    return
  end
  if UIManager.Instance:GetWindow(Urls.SkillCastSelectPanel) then
    return
  end
  if UIManager.Instance:GetWindow(Urls.KeeperSkillSelectPanel) then
    return
  end
  if not bg.battlePanel then
    Logger.ReportApusInfo("RecordTick:No BattlePanel")
  end
  if bg.battleRender and bg.battleRender:IsInSelectCard() then
    return
  end
  local msg = self:GetApusMsg()
  Logger.ReportApusInfo(msg)
end

function BattleRecordMgrClient:GetApusMsg()
  local msg = string.format("[RecordTick]PlayRecordState:%s\n", self.playRecordState)
  for awaiter, overTime in pairs(self.stopAllAwaiters) do
    msg = string.format("%s[%s:%s]\n", msg, awaiter.name, overTime - self.realRecordTime)
  end
  msg = string.format("%s[isWaitingAnim:%s]\n", msg, self.isWaitingAnim)
  if self.isWaitingAnim then
    for awaiter, overTime in pairs(self.animAwaiters) do
      msg = string.format("%s[%s:%s]\n", msg, awaiter.name, overTime - self.realRecordTime)
    end
  end
  msg = string.format("%s[IsCanPlayNext:%s]\n", msg, self:IsCanPlayNext())
  return msg
end

function BattleRecordMgrClient:Tick(deltaTime)
  if self.isUseSmoothTime then
    deltaTime = math.min(CSTime.smoothDeltaTime, MaxSmoothTime)
  end
  deltaTime = deltaTime * (bg.battleRender.gameSpeed or 1)
  self.realRecordTime = self.realRecordTime + deltaTime
  if self:GetNextRecordData() or self.curPlayRecordList then
    self.reportToApusTime = self.reportToApusTime + deltaTime
    if self.reportToApusTime > RECORD_OVER_TIME then
      self.reportToApusTime = 0
      xpcall(function()
        self:ReportApusMessage()
      end, debug.traceback)
    end
  end
  self:TickAwaiters()
  if self:IsStopTick() then
    return
  end
  local curCamp = bg.battleDataCenter.boutData.camp
  if not self.curPlayRecordList and self:IsCanPlayNext() then
    self.curPlayRecordList = self:_GetNextRecordList()
    self:_ParseRealEnergy()
    if self.curPlayRecordList and self.curPlayRecordList[1] then
      self.recordTime = self.curPlayRecordList[1].time
      if bg.isPVP and not bg.battleDataCenter:IsMyCamp(curCamp) and self:IsHaveAttackRecord(self.curPlayRecordList) then
        self.recordTime = self.recordTime - (bg.DT.GetConstant("PVPSkillShowInterval") or 0.5)
      end
      EventMgr.Instance.NewRecordSegment:Dispatch()
    end
  end
  if not self.curPlayRecordList then
    return
  end
  self.reportToApusTime = 0
  self.recordTime = self.recordTime + deltaTime
  self:PlayCurRecordList(deltaTime)
  if not self.isPlayedRecord then
    self.isPlayedRecord = true
    bg.SendBattleEvent(rc.BattleEvent.FirstPlayedRecord)
  end
end

local function GetActionAwakerByFrame(frameData, eventId)
  local data = frameData.data
  if eventId == BattleRenderEvent.ChangeRoleFsmState and data and data.newState == bc.AwakerFsmState.Attack then
    local role = bg.battleScene:GetRole(data.uid)
    if not role then
      return nil
    end
    if bg.isPVP then
      do return role.GetRandomAwaker end
      return role.GetRandomAwaker, role, nil, nil
    end
    local config = data.config
    return config and role:GetAwakerByUid(config.actionAwakerId) or nil
  end
  return nil
end

local function IsAwakerHiddenForAction(awaker)
  if not awaker or awaker.dead then
    return false
  end
  local spineComp = awaker.spineComp
  local visualNode = spineComp and spineComp.visualNode
  return visualNode and not IsNil(visualNode) and not visualNode.activeSelf
end

local function IsFrameNeedWaitAwakerVisible(frameData, eventId)
  local awaker = GetActionAwakerByFrame(frameData, eventId)
  do return IsAwakerHiddenForAction end
  return IsAwakerHiddenForAction, awaker
end

function BattleRecordMgrClient:PlayCurRecordList(deltaTime)
  local frameData, eventId
  for index = 1, #self.curPlayRecordList do
    frameData = self.curPlayRecordList[index]
    if not frameData.isDeleted then
      eventId = frameData.eventId
      if frameData.time and frameData.time > self.recordTime then
        return
      end
      if IsFrameNeedWaitAwakerVisible(frameData, eventId) then
        self.recordTime = frameData.time or self.recordTime
        return
      end
      if self:IsEventNeedWaiting(eventId, frameData) then
        self.isWaitingAnim = true
        return
      end
      self:SendFrameData(frameData)
      if self:IsStopTick() then
        return
      end
    end
  end
  self.curPlayRecordList = nil
  EventMgr.Instance.BattleRecordFinish:Dispatch()
end

function BattleRecordMgrClient:CheckIsInWaitingAnimEvent()
  if self.isWaitingAnim and not table.next(self.animAwaiters) then
    self.isWaitingAnim = false
  end
  return self.isWaitingAnim
end

local waitingAnimEvents = {
  [BattleRenderEvent.BattleBegin] = true,
  [BattleRenderEvent.ChangeBoutPhase] = true,
  [BattleRenderEvent.BattleFinish] = true,
  [BattleRenderEvent.PlayStory] = true
}

function BattleRecordMgrClient:IsEventNeedWaiting(eventId, frameData)
  if waitingAnimEvents[eventId] and table.next(self.animAwaiters) then
    return true
  end
  if (eventId == BattleRenderEvent.UseKeeperSkill or eventId == BattleRenderEvent.NotAwakerTimeline) and self:IsHaveAwaiterOf({KeeperSkillTimeline = true}) then
    return true
  end
  if eventId == EventChangeFsm and frameData.data.newState == bc.AwakerFsmState.Attack then
    local moveBackAwaiter = "AwakerMoveBack" .. frameData.data.uid
    if self:IsHaveAwaiterOf({
      AwakerExSkill = true,
      [moveBackAwaiter] = true,
      KeeperSkillTimeline = true
    }) then
      return true
    end
  end
  if eventId == BattleRenderEvent.PlayStory and self:IsHaveAwaiterOf({DbgEventEmbryoBornEffect = true}) then
    return true
  end
end

function BattleRecordMgrClient:IsHaveAwaiterOf(awaiterNameMap)
  for awaiter, _ in pairs(self.animAwaiters) do
    if awaiterNameMap[awaiter.name] then
      return true
    end
  end
end

function BattleRecordMgrClient:PreDealRecordData(frameList)
  self.isBoutPhaseBegin = self:_IsBoutPhaseBegin(frameList)
  self.isBoutPhaseEnd = self:_IsBoutPhaseEnd(frameList)
  self.isHaveDeadResist = self:_IsHaveDeadResist(frameList)
  self.isConfirmRespawn = self:_IsHaveConfirmRespawn(frameList)
  self:CheckMultiRoleFloatText(frameList)
end

function BattleRecordMgrClient:EnableFirstTrigger(isEnable)
  self._isFirstTriggerEnabled = isEnable
end

function BattleRecordMgrClient:CheckFirstTriggerRecord(frameList)
  if not self._isFirstTriggerEnabled then
    return
  end
  local frameData, eventId
  local firstRecords = {
    [BattleRenderEvent.CommandResult] = true
  }
  for index = 1, #frameList do
    frameData, eventId = frameList[index], frameList[index].eventId
    if firstRecords[eventId] then
      self:SendFrameData(frameData)
    end
  end
end

function BattleRecordMgrClient:SetRealData(frameList)
  local records = {
    [BattleRenderEvent.ChangeCardListDeck] = self.SetRealCardDeck,
    [BattleRenderEvent.AddNewCard] = self.SetRealCardDeck,
    [BattleRenderEvent.MoveCardToDeck] = self.SetRealCardDeck,
    [BattleRenderEvent.PropertyChanged] = self.SetRealProperty
  }
  for index = 1, #frameList do
    local frameData, eventId = frameList[index], frameList[index].eventId
    local func = records[eventId]
    if func then
      func(self, frameData)
    end
  end
end

function BattleRecordMgrClient:SetRealProperty(frameData)
  local data = frameData.data
  local propertyMap = self.realProperty
  if not propertyMap then
    propertyMap = {}
    self.realProperty = propertyMap
  end
  local uidData = propertyMap[data.uid]
  if not uidData then
    uidData = {}
    propertyMap[data.uid] = uidData
  end
  uidData[data.propertyType] = data.value
end

function BattleRecordMgrClient:GetRealProperty(uid, propertyType)
  local propertyMap = self.realProperty
  if not propertyMap then
    return nil
  end
  local uidData = propertyMap[uid]
  if not uidData then
    return nil
  end
  local result = uidData[propertyType] or 0
  return result
end

function BattleRecordMgrClient:GetRealPropertyOrNil(uid, propertyType)
  local uidData = self.realProperty and self.realProperty[uid]
  if not uidData then
    return nil
  end
  return uidData[propertyType]
end

function BattleRecordMgrClient:SetRealCardDeck(frameData)
  bg.battleRender.cardMgr:ChangeRealCardDeck(frameData)
end

function BattleRecordMgrClient:SendFrameData(frameData)
  frameData.isDeleted = true
  if frameData.realMsgId == BattleCommand.rd_CommandResult then
    bg.battleRender:rd_CommandResult(frameData)
    if bg.isReplay and frameData.msgId == BattleCommand.lg_SelectTargets then
      Awaiter.Dispatch("ReplayCommand", CommonDefine.ReplayCommandWaitTime, true)
    end
    return
  end
  bg.battleRender.eventMgr:SendEvent(frameData.eventId, frameData.data)
end

function BattleRecordMgrClient:CheckMultiRoleFloatText(frameList)
  local damageCountMap = {}
  local blockCountMap = {}
  local HP = bc.RoleProperty.hp
  local BLOCK = bc.RoleProperty.block
  local ChangeReason = bc.PropertyChangeReason
  for _, frameData in ipairs(frameList) do
    if frameData.eventId == BattleRenderEvent.PropertyChanged then
      local reason = frameData.data.reason
      local propertyType = frameData.data.propertyType
      local uid = frameData.data.uid
      if propertyType == HP and (reason == ChangeReason.Damage or reason == ChangeReason.DamageCrit) then
        damageCountMap[uid] = (damageCountMap[uid] or 0) + 1
      end
      if propertyType == BLOCK and reason == ChangeReason.BlockGain then
        blockCountMap[uid] = (blockCountMap[uid] or 0) + 1
      end
    end
  end
  for uid, count in pairs(damageCountMap) do
    local roleDataModel = bg.battleDataCenter:GetRoleDataModel(uid)
    if roleDataModel then
      roleDataModel:SetIsMultiHurt(count > 1)
    end
  end
  for uid, count in pairs(blockCountMap) do
    local roleDataModel = bg.battleDataCenter:GetRoleDataModel(uid)
    if roleDataModel then
      roleDataModel:SetIsMultiBlock(count > 1)
    end
  end
end

function BattleRecordMgrClient:ShowAwaitorDebugInfo()
  if self.isBoutPhaseBegin or self.isBoutPhaseEnd then
    local camp = ""
    for _, frameData in ipairs(self.curPlayRecordList) do
      if BattleRenderEvent[frameData.eventId] == "ChangeBoutPhase" and frameData.data.newPhase == bc.BoutPhase.End then
        camp = 1 == frameData.data.config.camp and "我方" or "敌方"
      end
    end
    Awaiter.Debug("▶ 播放录像" .. (self.isBoutPhaseBegin and "，" .. camp .. "回合开始。" or "，" .. camp .. "回合结束。"))
  end
end

function BattleRecordMgrClient:TickAwaiters()
  local curTime = self.realRecordTime
  local expired
  for awaiter, finishTime in pairs(self.animAwaiters) do
    if finishTime <= curTime then
      expired = expired or {}
      expired[#expired + 1] = awaiter
    end
  end
  if expired then
    for i = 1, #expired do
      local awaiter = expired[i]
      Logger.Warn("Awaiter超时:", awaiter.name)
      awaiter:SetCompleted()
      awaiter:Recycle()
      self.animAwaiters[awaiter] = nil
      self.stopAllAwaiters[awaiter] = nil
    end
  end
end

function BattleRecordMgrClient:OnAnimAwaiterArise(awaiter, desc, awaiterOverTime, isStopAll)
  local finishTime = self.realRecordTime + (awaiterOverTime or DEFAULT_AWAITER_OVER_TIME)
  self.animAwaiters[awaiter] = finishTime
  if isStopAll then
    self.stopAllAwaiters[awaiter] = finishTime
  end
  awaiter.name = desc
  awaiter:OnCompleted(function()
    self.animAwaiters[awaiter] = nil
    self.stopAllAwaiters[awaiter] = nil
  end)
end

function BattleRecordMgrClient:RecycleAllAnimAwaiters()
  for animAwaiter in pairs(self.animAwaiters) do
    animAwaiter:Recycle()
  end
  self.animAwaiters = {}
  self.stopAllAwaiters = {}
end

function BattleRecordMgrClient:_IsBoutPhaseBegin(frameList)
  for _, frameData in ipairs(frameList) do
    if frameData.eventId == BattleRenderEvent.ChangeBoutPhase and frameData.data.newPhase == bc.BoutPhase.Begin then
      return true
    end
  end
  return false
end

function BattleRecordMgrClient:_IsBoutPhaseEnd(frameList)
  for _, frameData in ipairs(frameList) do
    if frameData.eventId == BattleRenderEvent.ChangeBoutPhase and frameData.data.newPhase == bc.BoutPhase.End then
      return true
    end
  end
  return false
end

function BattleRecordMgrClient:_IsHaveDeadResist(frameList)
  for _, frameData in ipairs(frameList) do
    if frameData.eventId == BattleRenderEvent.DeathResist then
      return true
    end
  end
end

function BattleRecordMgrClient:_IsHaveConfirmRespawn(frameList)
  for _, frameData in ipairs(frameList) do
    if frameData.eventId == BattleRenderEvent.Confirm and frameData.data.confirmType == bc.ConfirmType.Respawn then
      return true
    end
  end
end

function BattleRecordMgrClient:GetDeadResistAndRespawn()
  return self.isHaveDeadResist, self.isConfirmRespawn
end

function BattleRecordMgrClient:_IsBattleWin(frameList)
  for _, frameData in ipairs(frameList) do
    if frameData.eventId == BattleRenderEvent.BattleFinish and bg.battleDataCenter:IsMyCamp(frameData.data.winCamp) then
      return true
    end
  end
end

function BattleRecordMgrClient:_IsBattleEndOrConfirm(frameList)
  for _, frameData in ipairs(frameList) do
    if frameData.eventId == BattleRenderEvent.BattleFinish or frameData.eventId == BattleRenderEvent.Confirm then
      return true
    end
  end
  return false
end

function BattleRecordMgrClient:_IsAttachPostAction(frameList)
  for _, frameData in ipairs(frameList) do
    if frameData.eventId == BattleRenderEvent.AttachPostAction then
      return true
    end
  end
  return false
end

function BattleRecordMgrClient:_SeparateBoutPhaseBeginFrame(frameList)
  for idx, frameData in ipairs(frameList) do
    if frameData.eventId == BattleRenderEvent.ChangeBoutPhase and frameData.data.newPhase == bc.BoutPhase.Begin then
      table.remove(frameList, idx)
      local time = frameList[1].time
      frameData.time = time
      return {
        {time = time},
        frameData,
        {time = time}
      }
    end
  end
end

function BattleRecordMgrClient:_ParseRealEnergy(frameList)
  local prevEnergy, eventId, data
  for _, queuedFrameList in ipairs(self.recordList) do
    for _, frameData in ipairs(queuedFrameList) do
      eventId, data = frameData.eventId, frameData.data
      if eventId == BattleRenderEvent.ChangeBoutPhase then
        if data and data.newPhase == bc.BoutPhase.Begin and data.config and data.config.camp == bc.BattleCamp.Camp2 then
          return
        end
      elseif eventId == BattleRenderEvent.PropertyChanged and data and data.propertyType == bc.RoleProperty.energy then
        prevEnergy = data.value
      end
    end
  end
  if prevEnergy then
    bg.battleDataCenter:SetRealEnergy(prevEnergy)
  end
end

function BattleRecordMgrClient:_SeparateDimentionRechargeFrame(frameList)
  local i = 1
  local dimentionRechargeFrame
  while i <= #frameList do
    local frameData = frameList[i]
    if frameData.eventId == BattleRenderEvent.AddNewCard and frameData.data.deck == bc.CardDeck.DimensionDeck then
      table.remove(frameList, i)
      dimentionRechargeFrame = dimentionRechargeFrame or {}
      local time = frameList[1].time
      frameData.time = time
      table.insert(dimentionRechargeFrame, frameData)
    else
      i = i + 1
    end
  end
  if not dimentionRechargeFrame or #dimentionRechargeFrame <= 1 then
    return dimentionRechargeFrame
  end
  local frameData = {}
  frameData.eventId = dimentionRechargeFrame[1].eventId
  frameData.time = dimentionRechargeFrame[1].time
  frameData.data = {}
  frameData.data.deck = bc.CardDeck.DimensionDeck
  frameData.data.cards = {}
  for i = 1, #dimentionRechargeFrame do
    for j = 1, #dimentionRechargeFrame[i].data.cards do
      table.insert(frameData.data.cards, dimentionRechargeFrame[i].data.cards[j])
    end
  end
  return {frameData}
end

function BattleRecordMgrClient:_SeparateSwallowEmbryoPhaseFrame(frameList)
  local i = 1
  local swallowEmbryoPhaseFrame
  while i <= #frameList do
    local frameData = frameList[i]
    if frameData.eventId == BattleRenderEvent.DoEffect and frameData.data.effectType == bc.BattleEffectType.BELaunchSwallow then
      table.remove(frameList, i)
      swallowEmbryoPhaseFrame = swallowEmbryoPhaseFrame or {}
      local time = frameList[1].time
      frameData.time = time
      table.insert(swallowEmbryoPhaseFrame, frameData)
    else
      i = i + 1
    end
  end
  if not swallowEmbryoPhaseFrame or #swallowEmbryoPhaseFrame <= 1 then
    return swallowEmbryoPhaseFrame
  end
  local frameData = {}
  frameData.eventId = swallowEmbryoPhaseFrame[1].eventId
  frameData.time = swallowEmbryoPhaseFrame[1].time
  frameData.data = {}
  frameData.data.effectType = bc.BattleEffectType.BELaunchSwallow
  frameData.data.cardUidList = {}
  for i = 1, #swallowEmbryoPhaseFrame do
    for j = 1, #swallowEmbryoPhaseFrame[i].data.cardUidList do
      table.insert(frameData.data.cardUidList, swallowEmbryoPhaseFrame[i].data.cardUidList[j])
    end
  end
  return {frameData}
end

function BattleRecordMgrClient:CanAwakerStepBack(role, awaker)
  if bg.isPVP then
    return true
  end
  local nextFrameList = self:GetNextRecordData()
  if nil == nextFrameList then
    return true
  end
  local attackData
  for _, frameData in ipairs(nextFrameList) do
    if frameData.eventId == BattleRenderEvent.ChangeRoleFsmState and frameData.data.newState == bc.AwakerFsmState.Attack then
      attackData = frameData.data
      break
    end
  end
  if attackData and attackData.uid == role.uid and attackData.config.actionAwakerId == awaker.uid then
    local castAnimation = attackData.config.castAnimation
    if castAnimation == bc.ArriveAnimation then
      return true
    end
    return false
  end
  return true
end

function BattleRecordMgrClient:GetNextBeHitRoleUid()
  local recordList = self.curPlayRecordList
  for _, record in ipairs(recordList or {}) do
    if record.eventId == BattleRenderEvent.ChangeRoleFsmState and record.data.newState == bc.AwakerFsmState.BeHit then
      return record.data.uid
    end
  end
end

function BattleRecordMgrClient:GetControlChildrenIndex()
  local frameList = self.curPlayRecordList or {}
  local controlChildrenTargetIndex = -1
  for i = 1, #frameList do
    local frameData = frameList[i]
    if frameData.eventId == BattleRenderEvent.SetTempArg and frameData.data.argKey == "TempArg1" then
      controlChildrenTargetIndex = frameData.data.argValue
      break
    end
  end
  return controlChildrenTargetIndex
end

function BattleRecordMgrClient:RegisterEvents()
end

function BattleRecordMgrClient:UnregisterEvents()
end

return BattleRecordMgrClient
