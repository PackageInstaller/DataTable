_class("UIN0CookPoint", UICustomWidget)
UIN0CookPoint = UIN0CookPoint

function UIN0CookPoint:OnShow(uiParams)
  self:InitWidget()
end

function UIN0CookPoint:InitWidget()
  self.pointSel = self:GetGameObject("pointSel")
end

function UIN0CookPoint:SetSelect(bSelect)
  self.pointSel:SetActive(bSelect)
end
