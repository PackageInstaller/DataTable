_class("OffBoardMonsterComponent", Object)
OffBoardMonsterComponent = OffBoardMonsterComponent

function OffBoardMonsterComponent:Constructor(monsterID)
  self._monsterID = monsterID
end

function OffBoardMonsterComponent:GetMonsterID()
  return self._monsterID
end

function OffBoardMonsterComponent:SetMonsterID(monsterID)
  self._monsterID = monsterID
end

function Entity:OffBoardMonster()
  return self:GetComponent(self.WEComponentsEnum.OffBoardMonster)
end

function Entity:HasOffBoardMonster()
  return self:HasComponent(self.WEComponentsEnum.OffBoardMonster)
end

function Entity:AddOffBoardMonster(monsterID)
  local index = self.WEComponentsEnum.OffBoardMonster
  local component = OffBoardMonsterComponent:New(monsterID)
  self:AddComponent(index, component)
end

function Entity:ReplaceOffBoardMonster(monsterID)
  local index = self.WEComponentsEnum.OffBoardMonster
  local component = OffBoardMonsterComponent:New(monsterID)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveOffBoardMonster()
  if self:HasOffBoardMonster() then
    self:RemoveComponent(self.WEComponentsEnum.OffBoardMonster)
  end
end
