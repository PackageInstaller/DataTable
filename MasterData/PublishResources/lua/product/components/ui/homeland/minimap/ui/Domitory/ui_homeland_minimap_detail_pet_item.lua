_class("UIHomelandMinimapDetailPetItem", UICustomWidget)
UIHomelandMinimapDetailPetItem = UIHomelandMinimapDetailPetItem

function UIHomelandMinimapDetailPetItem:OnShow(uiParams)
  self:InitWidget()
  self._affinity = self.affinity:SpawnObject("UIHomePetAffinityItem")
end

function UIHomelandMinimapDetailPetItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.affinity = self:GetUIComponent("UISelectObjectPath", "affinity")
end

function UIHomelandMinimapDetailPetItem:SetData(pet)
  if pet then
    self.icon:LoadImage(pet:GetPetTeamBody(PetSkinEffectPath.CARD_TEAM))
    self._affinity:SetData(pet)
    self.icon.gameObject:SetActive(true)
    self._affinity:GetGameObject():SetActive(true)
  else
    self.icon.gameObject:SetActive(false)
    self._affinity:GetGameObject():SetActive(false)
  end
end
