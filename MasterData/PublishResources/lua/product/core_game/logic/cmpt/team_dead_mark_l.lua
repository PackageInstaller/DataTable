_class("TeamDeadMarkComponent", Object)

function TeamDeadMarkComponent:Constructor(pos)
  self._deadPos = pos
end

function TeamDeadMarkComponent:GetDeadGridPos()
  return self._deadPos
end

function Entity:TeamDeadMark()
  return self:GetComponent(self.WEComponentsEnum.TeamDeadMark)
end

function Entity:HasTeamDeadMark()
  return self:HasComponent(self.WEComponentsEnum.TeamDeadMark)
end

function Entity:AddTeamDeadMark(pos)
  local index = self.WEComponentsEnum.TeamDeadMark
  local component = TeamDeadMarkComponent:New(pos)
  self:AddComponent(index, component)
end

function Entity:RemoveTeamDeadMark()
  if self:HasDeadFlag() then
    self:RemoveComponent(self.WEComponentsEnum.TeamDeadMark)
  end
end
