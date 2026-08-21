_class("UIHomePetAffinityItem", UICustomWidget)
UIHomePetAffinityItem = UIHomePetAffinityItem

function UIHomePetAffinityItem:OnShow(uiParams)
  self:InitWidget()
end

function UIHomePetAffinityItem:InitWidget()
  self.slider = self:GetUIComponent("Slider", "Slider")
  self.percent = self:GetUIComponent("Image", "percent")
  self.level = self:GetUIComponent("UILocalizationText", "level")
end

function UIHomePetAffinityItem:SetData(pet)
  self.level:SetText(pet:GetPetAffinityLevel())
  local percent = pet:GetPetAffinityLevelUpPercent()
  self.slider.value = percent
  self.percent.fillAmount = percent
end
