_class("UIHomePetFollowListItem", UICustomWidget)
UIHomePetFollowListItem = UIHomePetFollowListItem

function UIHomePetFollowListItem:OnShow(uiParams)
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._line = self:GetGameObject("line")
  self._go = self:GetGameObject()
end

function UIHomePetFollowListItem:SetData(idx, pet, callback, last)
  self._pet = pet
  self._callback = callback
  self._name:SetText(self._pet:PetName())
  if last then
    self._line:SetActive(false)
  else
    self._line:SetActive(true)
  end
end

function UIHomePetFollowListItem:btnOnClick(go)
  if self._callback then
    self._callback(self._pet)
  end
end

function UIHomePetFollowListItem:Active(active)
  self._go:SetActive(active)
end
