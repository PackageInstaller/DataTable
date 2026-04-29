require("main_state_sys")
_class("MirageWaitInputSystem", MainStateSystem)
MirageWaitInputSystem = MirageWaitInputSystem

function MirageWaitInputSystem:_GetMainStateID()
  return GameStateID.MirageWaitInput
end

function MirageWaitInputSystem:_OnMainStateEnter(TT)
  self:_DoLogicRestBattleState()
  self:_DoRenderResetBattleState()
  self:_DoRenderPieceAnimation(TT)
  self:_DoL2RBoardLogicData()
  self:_DoRenderCompareHPLog(TT)
  self:_DoRenderComparePieceType(TT)
end

function MirageWaitInputSystem:_DoLogicRestBattleState()
end

function MirageWaitInputSystem:_DoL2RBoardLogicData()
end

function MirageWaitInputSystem:_DoRenderResetBattleState(TT)
end

function MirageWaitInputSystem:_DoRenderPieceAnimation(TT)
end

function MirageWaitInputSystem:_DoRenderCompareHPLog(TT)
end

function MirageWaitInputSystem:_DoRenderComparePieceType(TT)
end
