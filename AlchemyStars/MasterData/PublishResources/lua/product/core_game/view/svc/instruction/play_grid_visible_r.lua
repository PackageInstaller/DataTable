require("base_ins_r")
_class("PlayGridVisibleInstruction", BaseInstruction)
PlayGridVisibleInstruction = PlayGridVisibleInstruction

function PlayGridVisibleInstruction:Constructor(paramList)
  local param = tonumber(paramList.visible)
  if param == 1 then
    self._visible = true
  else
    self._visible = false
  end
end

function PlayGridVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local pieceSvc = world:GetService("Piece")
  local pos = casterEntity:GetGridPosition()
  local ePiece = pieceSvc:FindPieceEntity(pos)
  ePiece:View():GetGameObject():SetActive(self._visible)
end
