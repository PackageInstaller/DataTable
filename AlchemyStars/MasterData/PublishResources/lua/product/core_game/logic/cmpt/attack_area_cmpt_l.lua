_class("AttackAreaComponent", Object)
AttackAreaComponent = AttackAreaComponent

function AttackAreaComponent:Constructor(type)
  self._type = type
end

function AttackAreaComponent:GetAttackAreaType()
  return self._type
end

function AttackAreaComponent:GetAttackArea()
  local boardService = self._entity._world:GetService("BoardLogic")
  if self._type == AttackAreaType.AIArea then
    return boardService.AIArea
  elseif self._type == AttackAreaType.PlayerArea then
    return boardService.PlayerArea
  end
end

function Entity:AttackArea()
  return self:GetComponent(self.WEComponentsEnum.AttackArea)
end

function Entity:AddAttackArea(type)
  local index = self.WEComponentsEnum.AttackArea
  local component = AttackAreaComponent:New(type)
  self:AddComponent(index, component)
end

function Entity:ReplaceAttackArea(type)
  local index = self.WEComponentsEnum.AttackArea
  local component = self:GetComponent(self.WEComponentsEnum.AttackArea)
  component = component or AttackAreaComponent:New(type)
  component._type = type
  self:ReplaceComponent(index, component)
end
