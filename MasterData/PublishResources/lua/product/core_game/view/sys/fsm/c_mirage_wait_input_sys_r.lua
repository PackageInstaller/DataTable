require("mirage_wait_input_system")
_class("ClientMirageWaitInputSystem_Render", MirageWaitInputSystem)
ClientMirageWaitInputSystem_Render = ClientMirageWaitInputSystem_Render

function ClientMirageWaitInputSystem_Render:_DoRenderResetBattleState(TT)
end

function ClientMirageWaitInputSystem_Render:_DoRenderPieceAnimation(TT)
  local piece_service = self._world:GetService("Piece")
  piece_service:RefreshPieceAnim()
  piece_service:RefreshMonsterAreaOutLine(TT)
  piece_service:SetAllPieceDark()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local utilData = self._world:GetService("UtilData")
  local roundGrids = utilData:GetRoundGrid(teamEntity:GetGridPosition())
  for _, gridPos in ipairs(roundGrids) do
    piece_service:SetPieceAnimNormal(gridPos)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowMirageChooseGrid, true)
end

function ClientMirageWaitInputSystem_Render:_DoRenderCompareHPLog(TT)
end

function ClientMirageWaitInputSystem_Render:_DoRenderComparePieceType(TT)
end
