_class("UIHomeSpPet", UICustomWidget)
UIHomeSpPet = UIHomeSpPet

function UIHomeSpPet:SetData(active, tex)
  self._tex = self:GetUIComponent("RollingText", "spPetTex")
  self._go = self:GetGameObject()
  self._go:SetActive(active)
  if active then
    self._tex:RefreshText(tex)
  end
end
