_class("RenderMonsterWeakComponent", Object)
RenderMonsterWeakComponent = RenderMonsterWeakComponent

function RenderMonsterWeakComponent:Constructor()
  self._renderMonsterWeakList = {}
end

function RenderMonsterWeakComponent:GetMonsterWeakList()
  return self._renderMonsterWeakList
end

function RenderMonsterWeakComponent:AddEffectEntity(key, effEntityID, edgePos)
  if not self._renderMonsterWeakList[key] then
    self._renderMonsterWeakList[key] = {}
  end
  local curData = self._renderMonsterWeakList[key]
  curData[effEntityID] = edgePos
end

function RenderMonsterWeakComponent:GetEffectEntity(key)
  return self._renderMonsterWeakList[key]
end

function RenderMonsterWeakComponent:RemoveEffectEntity(key)
  self._renderMonsterWeakList[key] = nil
end

function Entity:RenderMonsterWeak()
  return self:GetComponent(self.WEComponentsEnum.RenderMonsterWeak)
end

function Entity:HasRenderMonsterWeak()
  return self:HasComponent(self.WEComponentsEnum.RenderMonsterWeak)
end

function Entity:AddRenderMonsterWeak()
  local index = self.WEComponentsEnum.RenderMonsterWeak
  local component = RenderMonsterWeakComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceRenderMonsterWeak(roundTeam)
  local index = self.WEComponentsEnum.RenderMonsterWeak
  local component = RenderMonsterWeakComponent:New(roundTeam)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveRenderMonsterWeak()
  if self:HasRenderMonsterWeak() then
    self:RemoveComponent(self.WEComponentsEnum.RenderMonsterWeak)
  end
end
