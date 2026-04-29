require("base_ins_r")
_class("ShowHidePieceInstruction", BaseInstruction)
ShowHidePieceInstruction = ShowHidePieceInstruction

function ShowHidePieceInstruction:Constructor(paramList)
  local str = paramList.isShow or "0"
  self._isShow = tonumber(str) > 0
end

function ShowHidePieceInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local pieceSvc = self._world:GetService("Piece")
  local bodyArea = casterEntity:BodyArea():GetArea()
  local cGridLocation = casterEntity:GridLocation()
  local pos = cGridLocation.Position
  local len = table.count(bodyArea)
  for i = 1, len do
    local truePos = bodyArea[i] + pos
    local ePiece = pieceSvc:FindPieceEntity(truePos)
    ePiece:SetViewVisible(self._isShow)
  end
end
