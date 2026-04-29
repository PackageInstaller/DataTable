_class("UIXH1PetTryoutController", UIController)
UIXH1PetTryoutController = UIXH1PetTryoutController

function UIXH1PetTryoutController:OnShow(uiParams)
  self:InitWidget()
end

function UIXH1PetTryoutController:InitWidget()
  self.pets = self:GetUIComponent("UISelectObjectPath", "pets")
end

function UIXH1PetTryoutController:maskOnClick(go)
end
