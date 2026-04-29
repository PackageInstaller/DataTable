_class("ViewComponent", Object)
ViewComponent = ViewComponent

function ViewComponent:Constructor(view)
  self.ViewWrapper = view
end

function ViewComponent:GetGameObject()
  if self.ViewWrapper ~= nil then
    return self.ViewWrapper.GameObject
  end
  return nil
end

function ViewComponent:GetResRequest()
  if self.ViewWrapper ~= nil then
    return self.ViewWrapper.ResRequest
  end
  return nil
end

function ViewComponent:Dispose()
  local viewWrapper = self.ViewWrapper
  if viewWrapper.ViewDispose then
    viewWrapper:ViewDispose()
  end
  self.ViewWrapper = nil
end

function ViewComponent:GetViewWrapper()
  return self.ViewWrapper
end

function Entity:View()
  if self:HasTeam() then
    local teamLeaderEntity = self:GetTeamLeaderPetEntity()
    return teamLeaderEntity:View()
  elseif self:HasSuperEntity() and self:SuperEntityComponent():IsUseSuperEntityView() then
    local superEntity = self:GetSuperEntity()
    return superEntity:View()
  end
  return self:GetComponent(self.WEComponentsEnum.View)
end

function Entity:HasView()
  if self:HasTeam() then
    local teamLeaderEntity = self:GetTeamLeaderPetEntity()
    if not teamLeaderEntity then
      return false
    end
    return teamLeaderEntity:HasView()
  else
    return self:HasComponent(self.WEComponentsEnum.View)
  end
end

function Entity:AddView(view)
  local index = self.WEComponentsEnum.View
  local component = ViewComponent:New(view)
  self:AddComponent(index, component)
end

function Entity:ReplaceView(view)
  local index = self.WEComponentsEnum.View
  local component = ViewComponent:New(view)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveView()
  if self:HasView() then
    self:RemoveComponent(self.WEComponentsEnum.View)
  end
end
