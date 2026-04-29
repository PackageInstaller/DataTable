ClientExceptionReportType = {
  CastPickupActiveSkillCommand = 1,
  ChangeTeamLeaderCommand = 2,
  BattleUIModuleTeamOrder = 3,
  AutoFightPickError = 4
}
_class("ClientExceptionReportCommand", IEntityCommand)
ClientExceptionReportCommand = ClientExceptionReportCommand

function ClientExceptionReportCommand:Constructor(reportType, tag, msg)
  self._reportType = reportType
  self._msg = msg
  self._tag = tag
end

function ClientExceptionReportCommand:GetEntityID()
  return self.EntityID
end

function ClientExceptionReportCommand:GetCommandType()
  return "ClientExceptionReport"
end

function ClientExceptionReportCommand:GetExecStateID()
  return 0
end

function ClientExceptionReportCommand:IsExecExcluded()
  return 0
end

function ClientExceptionReportCommand:DependRoundCount()
  return false
end

function ClientExceptionReportCommand:ToNetMessage()
  local msg = CEventClientExceptionReportCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  msg.reportType = self._reportType
  msg.msg = echo(self._msg)
  msg.tag = self._tag
  return msg
end

function ClientExceptionReportCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
  self._reportType = msg.reportType
  self._tag = msg.tag
  self._msg = msg.msg
end

function ClientExceptionReportCommand:GetReportType()
  return self._reportType
end

function ClientExceptionReportCommand.CreateCastPickupActiveException(uiWidgetBattlePet, logicCheckLog)
  local t = {}
  if uiWidgetBattlePet then
    t.uiPetPstID = uiWidgetBattlePet.petPstID
    t.uiSkillID = uiWidgetBattlePet.skillID
    t.uiPower = uiWidgetBattlePet.Power
    t.uiMaxPower = uiWidgetBattlePet.maxPower
    t.uiIsReady = uiWidgetBattlePet.isReady
    t.uiIsDead = uiWidgetBattlePet.isDead
    t.uiPetTemplateID = uiWidgetBattlePet._petTemplateID
  end
  if logicCheckLog then
    t.logicBattleConst_Kick = logicCheckLog[1]
    t.logicPetEntityExist = logicCheckLog[2]
    t.logicActiveSkillID = logicCheckLog[3]
    t.logicReady = logicCheckLog[4]
    t.logicLegendPower = logicCheckLog[5]
    t.logicPower = logicCheckLog[6]
    t.logicPetPstID = logicCheckLog[7]
    t.logicTemplateID = logicCheckLog[8]
    t.argPetPstID = logicCheckLog[9]
    t.argSkillID = logicCheckLog[10]
  end
  local cmd = ClientExceptionReportCommand:New(ClientExceptionReportType.CastPickupActiveSkillCommand, "[ClientReport]CastPickupActiveSkillCommand", t)
  return cmd
end

function ClientExceptionReportCommand.CreateChangeTeamLeaderReport(petIDArray, oldPetPstID, newPetPstID)
  local t = {
    petIDArray = petIDArray,
    oldPetPstID = oldPetPstID,
    newPetPstID = newPetPstID
  }
  local cmd = ClientExceptionReportCommand:New(ClientExceptionReportType.ChangeTeamLeaderCommand, "[ClientReport]ChangeTeamLeader", t)
  return cmd
end

function ClientExceptionReportCommand.CreateBattleUIModuleReport(req)
  local renderState = GameGlobal:GetMainWorld():RenderBattleStat()
  local t = {
    finishedSequenceNoDic = renderState._finishedSequenceNoDic,
    changeTeamOrderViewQueue = renderState._changeTeamOrderViewQueue,
    viewQueueSequenceNo = renderState._viewQueueSequenceNo,
    currentTeamOrderRequest = renderState._currentTeamOrderRequest or {},
    isChangeTeamOrderViewDisabled = renderState._isChangeTeamOrderViewDisabled,
    eventRequest = req or {}
  }
  local cmd = ClientExceptionReportCommand:New(ClientExceptionReportType.BattleUIModuleTeamOrder, "[ClientReport]CreateBattleUIModuleReport", t)
  return cmd
end

function ClientExceptionReportCommand.CreateAutoFightPickErrorReport(activeSkillID, errorStep, errorType, pickPosList, tryPickList, curPickPos)
  local t = {
    activeSkillID = activeSkillID,
    errorStep = errorStep,
    errorType = errorType
  }
  if pickPosList then
    local tmpPickList = {}
    for i, v in ipairs(pickPosList) do
      table.insert(tmpPickList, Vector2(v.x, v.y))
    end
    t.pickGridList = tmpPickList
  end
  if tryPickList then
    local tmpTryPickList = {}
    if tryPickList then
      for i, v in ipairs(tryPickList) do
        table.insert(tmpTryPickList, Vector2(v.x, v.y))
      end
    end
    t.tryPickList = tmpTryPickList
  end
  if curPickPos then
    t.curPickPos = curPickPos
  end
  local cmd = ClientExceptionReportCommand:New(ClientExceptionReportType.AutoFightPickError, "[ClientReport]AutoFightPickError", t)
  return cmd
end
