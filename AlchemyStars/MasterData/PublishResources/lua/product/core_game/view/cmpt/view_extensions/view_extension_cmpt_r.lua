_class("ViewExtensionComponent", Object)
ViewExtensionComponent = ViewExtensionComponent

function ViewExtensionComponent:Constructor(visible)
  self.Visible = visible
end

function Entity:ViewExtension()
  if self:HasTeam() then
    local teamLeaderEntity = self:GetTeamLeaderPetEntity()
    return teamLeaderEntity:ViewExtension()
  else
    return self:GetComponent(self.WEComponentsEnum.ViewExtension)
  end
end

function Entity:HasViewExtension()
  return self:HasComponent(self.WEComponentsEnum.ViewExtension)
end

function Entity:SetViewVisible(visible)
  local index = self.WEComponentsEnum.ViewExtension
  local component
  if self:HasViewExtension() then
    component = self:ViewExtension()
    component.Visible = visible
  else
    component = ViewExtensionComponent:New(visible)
    self:ReplaceComponent(index, component)
  end
  local world = self:GetOwnerWorld()
  local renderEntitySvc = world:GetService("RenderEntity")
  if renderEntitySvc ~= nil then
    renderEntitySvc:SetEntityVisible(self, visible)
  end
end

function Entity:SetUpToVisible(visible)
  if not visible then
    self:SetLocationHeight(BattleConst.CacheHeight)
  else
    self:SetLocationHeight(0)
  end
end

function Entity:IsViewVisible()
  local viewExtensionCmpt = self:ViewExtension()
  if viewExtensionCmpt == nil then
    return false
  end
  return viewExtensionCmpt.Visible
end
