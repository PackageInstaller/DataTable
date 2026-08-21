require("main_state_sys")
_class("WaitInputChainSystem", MainStateSystem)
WaitInputChainSystem = WaitInputChainSystem

function WaitInputChainSystem:_GetMainStateID()
  return GameStateID.WaitInputChain
end

function WaitInputChainSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:_DoRenderPieceAnimation(TT)
  self:_DoLogicEnalbeInput()
  self:_ShowUI(TT)
  self:_PlayPreview(TT, teamEntity)
  self:_RemoveDimensionFlag(teamEntity)
  self:_DoRenderBeforePickUp()
  self:_DoGotoPickupTarget()
end

function WaitInputChainSystem:_RemoveDimensionFlag(teamEntity)
  teamEntity:RemoveDimensionFlag()
end

function WaitInputChainSystem:_DoGotoPickupTarget()
  self._world:EventDispatcher():Dispatch(GameEventType.WaitInputChainFinish, 1)
end

function WaitInputChainSystem:_DoLogicEnalbeInput()
  local gameFsmCmpt = self._world:GameFSM()
  local gameFsmStateID = gameFsmCmpt:CurStateID()
  if gameFsmStateID == GameStateID.WaitInputChain then
    gameFsmCmpt:EnableHandleInput(true)
  end
end

function WaitInputChainSystem:_DoRenderPieceAnimation(TT)
end

function WaitInputChainSystem:_DoEnableInput(TT)
end

function WaitInputChainSystem:_ShowUI(TT)
end

function WaitInputChainSystem:_PlayPreview(TT)
end

function WaitInputChainSystem:_DoRenderBeforePickUp()
end
