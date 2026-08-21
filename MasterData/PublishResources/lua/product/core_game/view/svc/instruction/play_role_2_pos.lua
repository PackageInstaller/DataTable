require("base_ins_r")
_class("PlayRole2PosInstruction", BaseInstruction)
PlayRole2PosInstruction = PlayRole2PosInstruction

function PlayRole2PosInstruction:Constructor(paramList)
  self._posX = tonumber(paramList.posX) or 0
  self._posY = tonumber(paramList.posY) or 0
end

function PlayRole2PosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  casterEntity:SetViewVisible(true)
  local posNew = Vector2(self._posX, self._posY)
  casterEntity:SetLocationHeight(0)
  casterEntity:SetPosition(posNew + casterEntity:GetGridOffset())
end
