require("main_state_sys")
_class("PopStarProRoleTurnSystem", MainStateSystem)
PopStarProRoleTurnSystem = PopStarProRoleTurnSystem

function PopStarProRoleTurnSystem:_GetMainStateID()
  return GameStateID.RoleTurn
end

function PopStarProRoleTurnSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:_DoRenderPetHeadShow(TT)
  self:_DoRendererTeleport(TT, teamEntity)
  self:_DoLogicGotoNextState()
end

function PopStarProRoleTurnSystem:_DoLogicGetChainElementType()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  return logicChainPathCmpt:GetLogicPieceType()
end

function PopStarProRoleTurnSystem:_DoLogicGotoNextState()
  self._world:EventDispatcher():Dispatch(GameEventType.RoleTurnFinish, 1)
end

function PopStarProRoleTurnSystem:_DoRenderPetHeadShow(TT)
end

function PopStarProRoleTurnSystem:_DoRendererTeleport(TT, teamEntity)
end

function PopStarProRoleTurnSystem:_DoRenderNotifyBuff(TT)
end

function PopStarProRoleTurnSystem:_DoRenderNotifyBuffNormalAttackEnd(TT)
end

function PopStarProRoleTurnSystem:_DoRenderResetPieceAnim(TT)
end

function PopStarProRoleTurnSystem:_SendPrismNotify(TT)
end
