_class("GameTurnComponent", Object)

function GameTurnComponent:Constructor(gameTurn)
  self._gameTurn = gameTurn
end

function GameTurnComponent:GetGameTurn()
  return self._gameTurn
end

function Entity:GameTurn()
  return self:GetComponent(self.WEComponentsEnum.GameTurn)
end

function Entity:HasGameTurn()
  return self:HasComponent(self.WEComponentsEnum.GameTurn)
end

function Entity:AddGameTurn(myTurn)
  local index = self.WEComponentsEnum.GameTurn
  local component = GameTurnComponent:New(myTurn)
  self:AddComponent(index, component)
end

function Entity:ReplaceGameTurn(myTurn)
  local index = self.WEComponentsEnum.GameTurn
  local component = GameTurnComponent:New(myTurn)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveGameTurn()
  if self:HasGameTurn() then
    self:RemoveComponent(self.WEComponentsEnum.GameTurn)
  end
end
