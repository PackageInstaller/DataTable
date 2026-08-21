_class("LinkLineComponent", Object)
LinkLineComponent = LinkLineComponent

function LinkLineComponent:Constructor(pos, dir)
  self._head_grid_pos = pos or Vector2(-1, -1)
  self._line_dir = dir or Vector2(0, 0)
end

function LinkLineComponent:Destructor()
  self._head_grid_pos = nil
  self._line_dir = nil
end

function LinkLineComponent:Dispose()
  self._head_grid_pos = nil
  self._line_dir = nil
end

function LinkLineComponent:GetGridPos()
  return self._head_grid_pos
end

function Entity:LinkLine()
  return self:GetComponent(self.WEComponentsEnum.LinkLine)
end

function Entity:HasLinkLine()
  return self:HasComponent(self.WEComponentsEnum.LinkLine)
end

function Entity:AddLinkLine(area)
  local index = self.WEComponentsEnum.LinkLine
  local component = LinkLineComponent:New(area)
  self:AddComponent(index, component)
end

function Entity:ReplaceLinkLine(pos, dir)
  local index = self.WEComponentsEnum.LinkLine
  local component = LinkLineComponent:New(pos, dir)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveLinkLine()
  if self:HasLinkLine() then
    self:RemoveComponent(self.WEComponentsEnum.LinkLine)
  end
end
