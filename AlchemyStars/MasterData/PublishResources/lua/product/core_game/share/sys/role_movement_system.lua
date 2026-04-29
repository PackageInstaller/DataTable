require("main_state_sys")
_class("RoleMovementSystem", MainStateSystem)
RoleMovementSystem = RoleMovementSystem

function RoleMovementSystem:_GetMainStateID()
  return GameStateID.RoleTurn
end

function RoleMovementSystem:_OnMainStateEnter(TT)
  self:_DoLoginFeatureOnRoleMoveEnter()
  self:_DoRenderFeatureOnRoleMoveEnter(TT)
  local elementType = self:_DoLogicGetChainElementType()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:_DoRenderNotifyBuff(TT, elementType, teamEntity)
  self:_DoRenderCreateActiveLinkLineGhost(TT, teamEntity)
  self:_DoRenderPetHeadShow(TT)
  self:_DoRendererMove(TT, teamEntity)
  self:_DoRenderNotifyBuffNormalAttackEnd(TT)
  local ntTeamOrderChange = self:_DoLogicPetDead(teamEntity)
  self:_DoRenderPetDead(TT, teamEntity, ntTeamOrderChange)
  self:_SendPrismNotify(TT)
  self:_DoLogicGotoNextState()
end

function RoleMovementSystem:_DoLogicGetChainElementType()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  return logicChainPathCmpt:GetLogicPieceType()
end

function RoleMovementSystem:_DoLogicGotoNextState()
  self._world:EventDispatcher():Dispatch(GameEventType.RoleTurnFinish, 1)
end

function RoleMovementSystem:_DoLoginFeatureOnRoleMoveEnter()
  local featureLogicSvc = self._world:GetService("FeatureLogic")
  if featureLogicSvc and featureLogicSvc:CanEnableFeature() then
    featureLogicSvc:DoFeatureOnRoleMoveEnter()
  end
end

function RoleMovementSystem:_DoRenderPetHeadShow(TT)
end

function RoleMovementSystem:_DoRendererMove(TT, teamEntity)
end

function RoleMovementSystem:_DoRenderNotifyBuff(TT)
end

function RoleMovementSystem:_DoRenderNotifyBuffNormalAttackEnd(TT)
end

function RoleMovementSystem:_DoRenderResetPieceAnim(TT)
end

function RoleMovementSystem:_SendPrismNotify(TT)
end

function RoleMovementSystem:_DoRenderFeatureOnRoleMoveEnter(TT)
end

function RoleMovementSystem:_DoRenderCreateActiveLinkLineGhost(TT)
end
