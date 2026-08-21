require("main_state_sys")
_class("UnscaledCountDownFinishNotifySystem", MainStateSystem)
UnscaledCountDownFinishNotifySystem = UnscaledCountDownFinishNotifySystem

function UnscaledCountDownFinishNotifySystem:_GetMainStateID()
  return GameStateID.UnscaledCountDownFinishNotify
end

function UnscaledCountDownFinishNotifySystem:_OnMainStateEnter(TT)
  Log.info("UnscaledCountDownFinishNotifySystem:Begin")
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:_DoLogicNotifyCountDownFinish()
  self:_DoRenderNotifyCountDownFinish(TT)
  self:_DoLogicMonsterDead()
  self:_DoRenderMonsterDead(TT)
  local ntTeamOrderChange = self:_DoLogicPetDead(teamEntity)
  self:_DoRenderPetDead(TT, teamEntity, ntTeamOrderChange)
  if self:_IsBattleEnd() then
    self._world:EventDispatcher():Dispatch(GameEventType.UnscaledCountDownFinishNotifyFinish, 2)
    return
  end
  self:_DoLogicSwitchMainState(teamEntity)
end

function UnscaledCountDownFinishNotifySystem:_DoLogicNotifyCountDownFinish()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.UnscaledCountDownLogic)
  for i, e in ipairs(group:GetEntities()) do
    local cmpt = e:UnscaledCountDownLogic()
    if cmpt:GetIsActive() and cmpt:GetIsWaitTrigger() then
      local flagID = cmpt:GetFlagID()
      Log.debug("UnscaledCountDownFinishNotifySystem,notify cmpt flagID:", flagID)
      local triggerService = self._world:GetService("Trigger")
      triggerService:Notify(NTClientUnscaledCountDownFinish:New(flagID))
      if self._world:RunAtClient() then
        local l2RSvc = self._world:GetService("L2R")
        l2RSvc:L2RNTClientUnscaledCountDownFinish(flagID)
      end
      break
    end
  end
end

function UnscaledCountDownFinishNotifySystem:_DoLogicSwitchMainState(teamEntity)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local nextState = self:_DoCheckNextState(teamEntity)
  self._world:EventDispatcher():Dispatch(GameEventType.UnscaledCountDownFinishNotifyFinish, nextState)
end

function UnscaledCountDownFinishNotifySystem:_DoCheckNextState(teamEntity)
  local battleStatCmpt = self._world:BattleStat()
  local nextState = 0
  if battleStatCmpt:AssignWaveResult() then
    nextState = 1
  else
    local battleService = self._world:GetService("Battle")
    local allMonsterDead = battleService:CheckAllMonstersDead(teamEntity)
    local specificTrapDead = battleService:CheckSpecificTrapDead()
    if allMonsterDead and specificTrapDead then
      local isLastWave = battleStatCmpt:IsLastWave()
      if isLastWave then
        nextState = 1
      else
        nextState = 2
      end
    else
      nextState = 1
    end
    local waveFinish = battleService:BattleCalculation(teamEntity)
    if waveFinish then
      nextState = 2
    end
  end
  return nextState
end

function UnscaledCountDownFinishNotifySystem:_DoRenderNotifyCountDownFinish(TT)
end
