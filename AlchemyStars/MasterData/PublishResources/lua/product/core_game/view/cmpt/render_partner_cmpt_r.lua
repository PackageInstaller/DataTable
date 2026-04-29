_class("RenderPartnerComponent", Object)
RenderPartnerComponent = RenderPartnerComponent

function RenderPartnerComponent:Constructor()
end

function RenderPartnerComponent:WEC_PostInitialize(owner)
end

function RenderPartnerComponent:WEC_PostRemoved()
end

function Entity:RenderPartner()
  return self:GetComponent(self.WEComponentsEnum.RenderPartner)
end

function Entity:HasRenderPartner()
  return self:HasComponent(self.WEComponentsEnum.RenderPartner)
end

function Entity:AddRenderPartner()
  local index = self.WEComponentsEnum.RenderPartner
  local component = RenderPartnerComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceRenderPartner()
  local index = self.WEComponentsEnum.RenderPartner
  local component = RenderPartnerComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveRenderPartner()
  if self:HasRenderPartner() then
    self:RemoveComponent(self.WEComponentsEnum.RenderPartner)
  end
end
