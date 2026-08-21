require("base_ins_r")
_class("PlayGridPrismInstruction", BaseInstruction)
PlayGridPrismInstruction = PlayGridPrismInstruction

function PlayGridPrismInstruction:Constructor(paramList)
  self._prism = tonumber(paramList.prism) or PieceEffectType.Normal
  self._notPlayAnim = tonumber(paramList.notPlayAnim)
end

function PlayGridPrismInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local pieceSvc = world:GetService("Piece")
  local gridPos = casterEntity:GetGridPosition()
  pieceSvc:SetPieceRenderEffect(gridPos, self._prism, self._notPlayAnim)
end
