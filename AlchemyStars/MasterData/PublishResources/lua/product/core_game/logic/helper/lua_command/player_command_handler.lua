_class("PlayerCommandHandler", Object)

function PlayerCommandHandler:Constructor(world)
  self._world = world
  self._cmds = {}
  self._handledCmdStates = {}
  self._movePathDownCmdHandler = MovePathDownCommandHandler:New(world)
  self._castActiveSkillCmdHandler = CastActiveSkillCommandHandler:New(world)
  self._castPickUpSkillCmdHandler = CastPickUpSkillCommandHandler:New(world)
  self._changeTeamLeaderCmdHandler = ChangeTeamLeaderCommandHandler:New(world)
  self._cancelChainSkillCmdHandler = CancelChainSkillCommandHandler:New(world)
  self._castPickUpChainSkillCmdHandler = CastPickUpChainSkillCommandHandler:New(world)
  self._castSelectTeamOrderPositionCommandHandler = CastSelectTeamOrderPositionCommandHandler:New(world)
  self._castClearSelectedTeamOrderPosCmdHandler = CastClearSelectedTeamOrderPositionCommandHandler:New(world)
  self._chessEndTurnHandler = CastChessPetEndTurnCommandHandler:New(world)
  self._castChessMoveCommandHandler = CastChessMoveCommandHandler:New(world)
  self._castChessPetAttackCommandHandler = CastChessPetAttackCommandHandler:New(world)
  self._chooseMiniMazeWaveAwardCommandHandler = ChooseMiniMazeWaveAwardCommandHandler:New(world)
  self._miragePickUpCommandHandler = MiragePickUpCommandHandler:New(world)
  self._mirageForceCloseCommandHandler = MirageForceCloseCommandHandler:New(world)
  self._switchPetEquipRefineUICommandHandler = SwitchPetEquipRefineUICommandHandler:New(world)
  self._popStarPickUpCommandHandler = PopStarPickUpCommandHandler:New(world)
  self._popStarProPickUpCommandHandler = PopStarProPickUpCommandHandler:New(world)
  self._syncClientUnscaledCountDownCommandHandler = SyncClientUnscaledCountDownCommandHandler:New(world)
  self._castSelectInfoActiveSkillCmdHandler = CastSelectInfoActiveSkillCommandHandler:New(world)
  self._scanFeatureCommandHandler = ScanFeatureCommandHandler:New(world)
  self._tetrisFeatureCmdHandler = TetrisFeatureCommandHandler:New(world)
end

function PlayerCommandHandler:AddCommand(cmd)
  table.insert(self._cmds, cmd)
end

function PlayerCommandHandler:ClearHandlerState()
  self._handledCmdStates = {}
end

function PlayerCommandHandler:HandleCommand()
  local hasPreview = self._world:RunAtClient() and self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn
  local localRoundCount = self._world:BattleStat():GetGameRoundCount()
  while self._cmds[1] do
    local cmd = self._cmds[1]
    local execStateList = {}
    local st = cmd:GetExecStateID(hasPreview)
    if type(st) == "number" then
      table.insert(execStateList, st)
    elseif type(st) == "table" then
      table.appendArray(execStateList, st)
    end
    local exclude = cmd:IsExecExcluded()
    local cmdType = cmd:GetCommandType()
    local roundCount = cmd.RoundCount
    if cmd:DependRoundCount() and roundCount and roundCount ~= localRoundCount then
      Log.error("[HandleCommand] ", cmdType, " command roundCnt=", roundCount, " local roundCnt=", localRoundCount)
      if localRoundCount > roundCount then
        table.remove(self._cmds, 1)
        goto lbl_127
      else
        break
      end
    end
    local curState = self._world:GameFSM():CurStateID()
    if table.icontains(execStateList, 0) or table.icontains(execStateList, curState) then
      if exclude == 1 then
        if self._handledCmdStates[st] then
          Log.error("[HandleCommand] ", cmdType, " exec excluded!!")
          break
        end
        self._handledCmdStates[st] = true
      end
      self:_DoHandleCommand(cmd)
      table.remove(self._cmds, 1)
    else
      break
    end
    ::lbl_127::
  end
end

function PlayerCommandHandler:_DoHandleCommand(cmd)
  if cmd:GetCommandType() ~= "BattleSync" and cmd:GetCommandType() ~= "AutoFight" and cmd:GetCommandType() ~= "Guide" and cmd:GetCommandType() ~= "ClientExceptionReport" then
    self._world:GetSyncLogger():Trace({
      key = "HandleCommand",
      cmd = cmd:GetCommandType()
    })
  end
  if cmd:GetCommandType() == "MovePathDone" then
    self._movePathDownCmdHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == "CastActiveSkill" then
    self._castActiveSkillCmdHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == "CastPickUpActiveSkill" then
    self._castPickUpSkillCmdHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == "CancelChainSkill" then
    self._cancelChainSkillCmdHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == "CastPickUpChainSkill" then
    self._castPickUpChainSkillCmdHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == "BattleSync" then
    self:HandleBattleSync(cmd)
  end
  if cmd:GetCommandType() == "AutoFight" then
    self:HandleAutoFight(cmd)
  end
  if cmd:GetCommandType() == "Guide" then
    self:HandleGuide(cmd)
  end
  if cmd:GetCommandType() == "GM" then
    self:HandleGM(cmd)
  end
  if cmd:GetCommandType() == "ChangeTeamLeader" then
    self._changeTeamLeaderCmdHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == "ClientExceptionReport" then
    self:HandleClientExceptionReport(cmd)
  end
  if cmd:GetCommandType() == CastSelectTeamOrderPositionCommand.CommandType then
    self._castSelectTeamOrderPositionCommandHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == CastClearSelectedTeamOrderPositionCommand.CommandType then
    self._castClearSelectedTeamOrderPosCmdHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == "CastChessPetEndTurn" then
    self._chessEndTurnHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == "CastChessMove" then
    self._castChessMoveCommandHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == "CastChessPetAttack" then
    self._castChessPetAttackCommandHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == ChooseMiniMazeWaveAwardCommand.CommandType then
    self._chooseMiniMazeWaveAwardCommandHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == ScanFeatureCommand.CommandType then
    self._scanFeatureCommandHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == MiragePickUpCommand.CommandType then
    self._miragePickUpCommandHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == MirageForceCloseCommand.CommandType then
    self._mirageForceCloseCommandHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == SwitchPetEquipRefineUICommand.CommandType then
    self._switchPetEquipRefineUICommandHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == PopStarPickUpCommand.CommandType then
    if self._world:MatchType() == MatchType.MT_PopStar then
      self._popStarPickUpCommandHandler:DoHandleCommand(cmd)
    else
      self._popStarProPickUpCommandHandler:DoHandleCommand(cmd)
    end
  end
  if cmd:GetCommandType() == SyncClientUnscaledCountDownCommand.CommandType then
    self._syncClientUnscaledCountDownCommandHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == CastSelectInfoActiveSkillCommand.CommandType then
    self._castSelectInfoActiveSkillCmdHandler:DoHandleCommand(cmd)
  end
  if cmd:GetCommandType() == TetrisFeatureCommand.CommandType then
    self._tetrisFeatureCmdHandler:DoHandleCommand(cmd)
  end
  return false
end

function PlayerCommandHandler:HandleBattleSync(cmd)
  local syncService = self._world:GetService("SyncLogic")
  syncService:OnRecvSyncCommand(cmd)
end

function PlayerCommandHandler:HandleAutoFight(cmd)
  local enableAutoFight = cmd:GetCmdAutoFight()
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SetAutoFight(enableAutoFight)
end

function PlayerCommandHandler:HandleGuide(cmd)
  local targetPstId = cmd:GetPetPstId()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local petList = teamEntity:Team():GetTeamPetEntities()
  local skillTriggerType = SkillTriggerType.Energy
  for _, e in ipairs(petList) do
    local petPstIDCmpt = e:PetPstID()
    local pstID = petPstIDCmpt:GetPstID()
    if pstID == targetPstId then
      local activeSkillID = e:SkillInfo():GetActiveSkillID()
      local configService = self._world:GetService("Config")
      local skillConfigData = configService:GetSkillConfigData(activeSkillID)
      if skillConfigData then
        skillTriggerType = skillConfigData:GetSkillTriggerType()
      end
      local attributeCmpt = e:Attributes()
      if skillTriggerType ~= SkillTriggerType.LegendEnergy then
        attributeCmpt:Modify("Power", 0)
      end
      attributeCmpt:Modify("Ready", 1)
    end
  end
  if skillTriggerType ~= SkillTriggerType.LegendEnergy then
    self._world:EventDispatcher():Dispatch(GameEventType.PetPowerChange, targetPstId, 0, true)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, targetPstId, true)
end

function PlayerCommandHandler:HandleGM(cmd)
  local funcName = cmd:GetFuncName()
  local funcParam = cmd:GetFuncParam()
  self._world:HandleGM(funcName, funcParam)
end

function PlayerCommandHandler:HandleClientExceptionReport(cmd)
end
