require("main_state_sys")
_class("PreChainStateSystem", MainStateSystem)
PreChainStateSystem = PreChainStateSystem

function PreChainStateSystem:_GetMainStateID()
  return GameStateID.PreChain
end

function PreChainStateSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local posCasterOld = teamEntity:GetGridPosition()
  local trapIds = self:_DoLogicPreChainTrapSkill()
  self:_PlayPreChainTrapSkill(TT, trapIds)
  local listTrapTrigger = self:_DoLogicWaitTeleportFinish(posCasterOld, teamEntity)
  self:_DoRenderWaitTeleportFinish(TT, listTrapTrigger, teamEntity)
  self:_DoLogicResetPickUp(teamEntity)
  self:_DoRenderResetPickUp()
  self:_DoLogicPreChainFinish()
end

function PreChainStateSystem:_DoLogicPreChainTrapSkill()
  local sTrapLogic = self._world:GetService("TrapLogic")
  local trapIds = sTrapLogic:CalcTrapPreChainSkill()
  return trapIds
end

function PreChainStateSystem:_DoLogicPreChainFinish()
  local flag = self._world:BattleStat():GetTriggerDimensionFlag()
  local nextId = 1
  if flag == TriggerDimensionFlag.WaitInput then
    nextId = 2
  elseif flag == TriggerDimensionFlag.RoundResult then
    nextId = 3
  end
  self._world:BattleStat():SetTriggerDimensionFlag(TriggerDimensionFlag.None)
  self._world:EventDispatcher():Dispatch(GameEventType.PreChainFinish, nextId)
end

function PreChainStateSystem:_DoLogicResetPickUp(teamEntity)
  local logicPickUpCmpt = teamEntity:LogicPickUp()
  logicPickUpCmpt:ResetLogicPickUp()
end

function PreChainStateSystem:_DoLogicWaitTeleportFinish(posCasterOld, teamEntity)
  local posCasterNew = teamEntity:GetGridPosition()
  local bHaveTeleport = posCasterNew ~= posCasterOld
  local listTrapTrigger
  if bHaveTeleport then
    local sTrapLogic = self._world:GetService("TrapLogic")
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    listTrapTrigger = sTrapLogic:TriggerTrapByTeleport(teamEntity, true)
  end
  return listTrapTrigger
end

function PreChainStateSystem:_PlayPreChainTrapSkill(TT, trapIds)
end

function PreChainStateSystem:_DoRenderWaitTeleportFinish(TT, listTrapTrigger, teamEntity)
end

function PreChainStateSystem:_DoRenderResetPickUp()
end
