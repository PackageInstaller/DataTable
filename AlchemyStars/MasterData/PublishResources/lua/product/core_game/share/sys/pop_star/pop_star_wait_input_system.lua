require("main_state_sys")
_class("PopStarWaitInputSystem", MainStateSystem)
PopStarWaitInputSystem = PopStarWaitInputSystem

function PopStarWaitInputSystem:_GetMainStateID()
  return GameStateID.WaitInput
end

function PopStarWaitInputSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:_DoRenderHidePetEntity(TT, teamEntity)
  self:_DoLogicCalc3StarProgress()
  self:_DoLogicCalcBonusObjective()
  self:_DoLogicRestBattleState()
  self:_DoRenderPieceAnimation(TT)
  self:_DoLogicWaitInputBuff()
  self:_DoRenderPlayWaitInputBuff(TT)
  self:_DoRenderShowPetHeadUI(TT)
  self:_DoRenderWaitDeathEnd(TT)
  self:_DoRenderShowPlayerTurnInfo(TT, teamEntity)
  self:_DoL2RBoardLogicData()
  self:_DoRenderCompareHPLog(TT)
  self:_DoRenderComparePieceType(TT)
  self:_DoRenderSetPreviewTeam(teamEntity)
  self:_DoLogicUpdateMatchData(teamEntity)
  self:_DoLogicEnableHandleInput()
end

function PopStarWaitInputSystem:_DoLogicCalc3StarProgress()
  local popStarSvc = self._world:GetService("PopStarLogic")
  popStarSvc:Calculate3StarProgress()
end

function PopStarWaitInputSystem:_DoLogicCalcBonusObjective()
  local bonusService = self._world:GetService("BonusCalc")
  bonusService:CalcBonusObjective()
end

function PopStarWaitInputSystem:_DoLogicRestBattleState()
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:IncWaitInputCount()
end

function PopStarWaitInputSystem:_DoLogicWaitInputBuff()
  self._world:GetService("Trigger"):Notify(NTWaitInput:New())
end

function PopStarWaitInputSystem:_DoL2RBoardLogicData()
  local t = self._world:GetService("BoardLogic"):CalcPieceEntities()
  self._world:GetBoardEntity():Board():SetPieceEntities(t)
  local svc = self._world:GetService("L2R")
  svc:L2RBoardLogicData()
end

function PopStarWaitInputSystem:_DoLogicUpdateMatchData(teamEntity)
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

function PopStarWaitInputSystem:_DoLogicEnableHandleInput()
  local gameFsmCmpt = self._world:GameFSM()
  gameFsmCmpt:EnableHandleInput(true)
  self._world:GetDataLogger():AddDataLog("OnShowEnd")
end

function PopStarWaitInputSystem:_DoRenderHidePetEntity(TT, teamEntity)
end

function PopStarWaitInputSystem:_DoRenderPieceAnimation(TT)
end

function PopStarWaitInputSystem:_DoRenderPlayWaitInputBuff(TT)
end

function PopStarWaitInputSystem:_DoRenderShowPetHeadUI(TT)
end

function PopStarWaitInputSystem:_DoRenderShowPlayerTurnInfo(TT, teamEntity)
end

function PopStarWaitInputSystem:_DoRenderCompareHPLog(TT)
end

function PopStarWaitInputSystem:_DoRenderComparePieceType(TT)
end

function PopStarWaitInputSystem:_DoRenderSetPreviewTeam(teamEntity)
end
