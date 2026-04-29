_class("MonsterRenderComponent", Object)
MonsterRenderComponent = MonsterRenderComponent

function MonsterRenderComponent:Constructor()
end

function MonsterRenderComponent:WEC_PostInitialize(owner)
end

function MonsterRenderComponent:WEC_PostRemoved()
end

function Entity:MonsterRender()
  return self:GetComponent(self.WEComponentsEnum.MonsterRender)
end

function Entity:HasMonsterRender()
  return self:HasComponent(self.WEComponentsEnum.MonsterRender)
end

function Entity:AddMonsterRender()
  local index = self.WEComponentsEnum.MonsterRender
  local component = MonsterRenderComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceMonsterRender()
  local index = self.WEComponentsEnum.MonsterRender
  local component = MonsterRenderComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveMonsterRender()
  if self:HasMonsterRender() then
    self:RemoveComponent(self.WEComponentsEnum.MonsterRender)
  end
end
