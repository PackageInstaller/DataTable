_class("BoardOutlineComponent", Object)
BoardOutlineComponent = BoardOutlineComponent

function BoardOutlineComponent:Constructor(turn)
  self._isPlayerTurn = turn
end

function BoardOutlineComponent:IsPlayerTurn()
  return self._isPlayerTurn
end

function BoardOutlineComponent:SetTurn(turn)
  self._isPlayerTurn = turn
end

function Entity:BoardOutline()
  return self:GetComponent(self.WEComponentsEnum.BoardOutline)
end

function Entity:AddBoardOutline()
  local index = self.WEComponentsEnum.BoardOutline
  local component = BoardOutlineComponent:New(true)
  self:AddComponent(index, component)
end

function Entity:ReplaceBoardOutline(turn)
  local index = self.WEComponentsEnum.BoardOutline
  local component = self:GetComponent(self.WEComponentsEnum.BoardOutline)
  component = component or BoardOutlineComponent:New(turn)
  component:SetTurn(turn)
  self:ReplaceComponent(index, component)
end
