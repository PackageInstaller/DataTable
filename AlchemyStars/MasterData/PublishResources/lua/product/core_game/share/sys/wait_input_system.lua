require("main_state_sys")
_class("WaitInputSystem", MainStateSystem)
WaitInputSystem = WaitInputSystem

function WaitInputSystem:_GetMainStateID()
  return GameStateID.WaitInput
end

function WaitInputSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:ClearPreviewChainPathData()
  self:_DoRenderStopPortalPreview(TT)
  self:_DoLogicPetClearSelectTeamPos()
  self:_DoLogicCalc3StarProgress()
  self:_DoLogicCalcBonusObjective()
  self:_DoRenderResetBattleState()
  self:_DoLogicRestBattleState()
  self:_DoRenderPieceAnimation(TT)
  self:_DoLogicWaitInputBuff()
  self:_DoRenderPlayWaitInputBuff(TT)
  self:_DoRenderShowPetHeadUI(TT)
  self:_DoRenderWaitDeathEnd(TT)
  local isStun = self:_DoLogicCheckPlayerStun(teamEntity)
  if isStun then
    self:_DoLogicPlayerBuffDelayed(teamEntity)
    self:_DoRenderPlayerBuffDelayed(TT, teamEntity)
    self:_DoRenderWaitStun(TT)
    self:_GotoNextTurn()
    return
  end
  self:_DoRenderGuidePlayer(TT)
  self:_DoRenderShowAuroraTime(TT)
  self:_DoRenderShowPlayerTurnInfo(TT, teamEntity)
  self:_DoL2RBoardLogicData()
  self:_DoRenderCompareHPLog(TT)
  self:_DoRenderComparePieceType(TT)
  self:_DoRenderSetPreviewTeam(teamEntity)
  self:_DoLogicUpdateMatchData(teamEntity)
  if self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
    self:_DoLogic_EnableHandleInput()
  else
    self:_DoRenderAutoFight(TT, teamEntity)
  end
end

function WaitInputSystem:_GotoNextTurn()
  if self._world:MatchType() == MatchType.MT_BlackFist then
    self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 5)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 4)
  end
end

function WaitInputSystem:_DoLogic_EnableHandleInput()
  local gameFsmCmpt = self._world:GameFSM()
  gameFsmCmpt:EnableHandleInput(true)
  self._world:EventDispatcher():Dispatch(GameEventType.BanAutoFightBtn, false)
  self._world:GetDataLogger():AddDataLog("OnShowEnd")
  self._world:GetDataLogger():AddDataLog("OnLinkStart")
end

function WaitInputSystem:_DoLogicCalc3StarProgress()
  local configService = self._world:GetService("Config")
  local battleStatCmpt = self._world:BattleStat()
  if self._world:MatchType() == MatchType.MT_Mission or self._world:MatchType() == MatchType.MT_Campaign then
    local threeStarConditions = {}
    if self._world:MatchType() == MatchType.MT_Mission then
      threeStarConditions = configService:GetMission3StarCondition(self._world.BW_WorldInfo.missionID)
    elseif self._world:MatchType() == MatchType.MT_Campaign then
      threeStarConditions = configService:GetCampaignMission3StarCondition(self._world.BW_WorldInfo.missionID)
    end
    local star3CalcService = self._world:GetService("Star3Calc")
    for _, conditionId in ipairs(threeStarConditions) do
      local ret = star3CalcService:CalcProgress(conditionId)
      battleStatCmpt:UpdateA3StarProgress(conditionId, ret)
    end
  elseif self._world:MatchType() == MatchType.MT_ExtMission then
    local threeStarConditions = configService:GetExtMission3StarCondition(self._world.BW_WorldInfo.ext_mission_task_id)
    local star3CalcService = self._world:GetService("Star3Calc")
    for _, conditionId in ipairs(threeStarConditions) do
      local ret = star3CalcService:CalcProgress(conditionId)
      battleStatCmpt:UpdateA3StarProgress(conditionId, ret)
    end
  elseif self._world:MatchType() == MatchType.MT_Season then
    local threeStarConditions = configService:GetSeasonMission3StarCondition(self._world.BW_WorldInfo.missionID)
    local star3CalcService = self._world:GetService("Star3Calc")
    for _, conditionId in ipairs(threeStarConditions) do
      local ret = star3CalcService:CalcProgress(conditionId)
      battleStatCmpt:UpdateA3StarProgress(conditionId, ret)
    end
  end
end

function WaitInputSystem:_DoLogicCalcBonusObjective()
  local bonusCalcService = self._world:GetService("BonusCalc")
  local star3CalcService = self._world:GetService("Star3Calc")
  local conditionParser = ObjectiveConditionParamParser:New()
  local calcResultArray = {}
  local conditionIDArray = self._world:BattleWorldEnterData():GetBonusCondition()
  for _, conditionID in ipairs(conditionIDArray) do
    local conditionData = Cfg.cfg_threestarcondition[conditionID]
    if conditionData == nil then
      return
    end
    local conditionType = conditionData.ConditionType
    local conditionParamArray = star3CalcService:GetConditionNumber(conditionID)
    local conditionParam = conditionParser:ParseObjectiveConditionParam(conditionType, conditionParamArray)
    if conditionParam == nil then
      calcResultArray[#calcResultArray + 1] = conditionID
    else
      local matchRes = bonusCalcService:CalcCondition(conditionType, conditionParam)
      if matchRes == true then
        calcResultArray[#calcResultArray + 1] = conditionID
      end
    end
  end
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SetBonusMatchResult(calcResultArray)
end

function WaitInputSystem:_DoLogicRestBattleState()
  local battleService = self._world:GetService("Battle")
  battleService:SetLogicComboNum(0)
  battleService:SetLogicChainNum(0)
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:IncWaitInputCount()
end

function WaitInputSystem:_DoLogicCheckPlayerStun(teamEntity)
  if teamEntity == nil then
    return false
  end
  local buffCmpt = teamEntity:BuffComponent()
  local isStun = buffCmpt:HasFlag(BuffFlags.SkipTurn)
  return isStun
end

function WaitInputSystem:_DoLogicWaitInputBuff()
  self._world:GetService("Trigger"):Notify(NTWaitInput:New())
end

function WaitInputSystem:_DoL2RBoardLogicData()
  local t = self._world:GetService("BoardLogic"):CalcPieceEntities()
  self._world:GetBoardEntity():Board():SetPieceEntities(t)
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local multiBoard = levelConfigData:GetMultiBoard()
  if multiBoard and table.count(multiBoard) > 0 then
    local boardMultiServiceLogic = self._world:GetService("BoardMultiLogic")
    local boardMultiComponent = self._world:GetBoardEntity():BoardMulti()
    local entities = boardMultiServiceLogic:GetEntityGroup()
    for i, boardInfo in ipairs(multiBoard) do
      local boardIndex = boardInfo.index
      local pieceEntities = boardMultiServiceLogic:CalcPieceEntities(entities, boardIndex)
      boardMultiComponent:SetPieceEntities(boardIndex, pieceEntities)
    end
    boardMultiServiceLogic:SaveMonsterIDCmptOnOutsideRegion()
  end
  local boardSvc = self._world:GetService("BoardLogic")
  boardSvc:SaveMonsterIDCmptOffBoard()
  local svc = self._world:GetService("L2R")
  svc:L2RBoardLogicData()
end

function WaitInputSystem:_DoLogicUpdateMatchData(teamEntity)
  if self._world:RunAtServer() then
    local logic = self._world:GetCoreGameLogic()
    if logic:IsRunningAI() then
      local actorID = logic:GetActorID()
      local data = logic:GetAIData()
      update_match_state(actorID, data)
      local battleStatCmpt = self._world:BattleStat()
      local cmd = MovePathDoneCommand:New()
      cmd:SetChainPath({
        teamEntity:GetGridPosition()
      })
      cmd:SetElementType(0)
      cmd.EntityID = 2
      cmd.RoundCount = battleStatCmpt:GetGameRoundCount()
      cmd.IsAutoFight = battleStatCmpt:GetAutoFight()
      cmd.ClientWaitInput = battleStatCmpt:GetWaitInputCount()
      logic:DoAICommand(cmd)
    end
  end
end

function WaitInputSystem:_DoLogicPetClearSelectTeamPos()
  local groupEntity = self._world:GetGroupEntities(self._world.BW_WEMatchers.Team)
  for _, e in ipairs(groupEntity) do
    e:Team():ClearSelectedTeamOrderPosition()
  end
end

function WaitInputSystem:_DoLogicPlayerBuffDelayed(teamEntity)
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:CalcPlayerBuffDelayedTurn(teamEntity)
end

function WaitInputSystem:_DoRenderStopPortalPreview(TT)
end

function WaitInputSystem:_DoRenderPieceAnimation(TT)
end

function WaitInputSystem:_DoRenderGuidePlayer(TT)
end

function WaitInputSystem:_DoRenderWaitStun(TT)
end

function WaitInputSystem:_DoRenderShowPlayerTurnInfo(TT, teamEntity)
end

function WaitInputSystem:_DoRenderShowAuroraTime(TT)
end

function WaitInputSystem:_DoRenderCameraFollowHero(TT)
end

function WaitInputSystem:_DoRenderShowPetHeadUI(TT)
end

function WaitInputSystem:_DoRenderCompareHPLog(TT)
end

function WaitInputSystem:_DoRenderResetBattleState(TT)
end

function WaitInputSystem:_DoRenderPlayWaitInputBuff(TT)
end

function WaitInputSystem:_DoRenderComparePieceType(TT)
end

function WaitInputSystem:ClearPreviewChainPathData()
end

function WaitInputSystem:_DoRenderAutoFight(TT, teamEntity)
end

function WaitInputSystem:_DoRenderSetPreviewTeam(teamEntity)
end

function WaitInputSystem:_DoRenderPlayerBuffDelayed(TT)
end
