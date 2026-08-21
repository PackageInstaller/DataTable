_class("PieceUpdownComponent", Object)
PieceUpdownComponent = PieceUpdownComponent

function PieceUpdownComponent:Constructor(pos, isDown)
  self._pos = pos
  self._isDown = isDown
end

function PieceUpdownComponent:GetPos()
  return self._pos
end

function PieceUpdownComponent:IsDown()
  return self._isDown
end

function Entity:PieceUpdown()
  return self:GetComponent(self.WEComponentsEnum.PieceUpdown)
end

function Entity:ReplacePieceUpdown(pos, isDown)
  local index = self.WEComponentsEnum.PieceUpdown
  local component = PieceUpdownComponent:New(pos, isDown)
  self:ReplaceComponent(index, component)
end
