_class("UITeamItemShow", UICustomWidget)
UITeamItemShow = UITeamItemShow

function UITeamItemShow:OnShow()
  self._card = self:GetUIComponent("UISelectObjectPath", "card")
  self._cardGo = self:GetGameObject("card")
  self:GetGameObject("imgMask"):SetActive(false)
  self:GetGameObject("imgAdd"):SetActive(false)
  self:GetGameObject("imgLock"):SetActive(false)
  self:GetGameObject("UIWeakKuang"):SetActive(false)
  self:GetUIComponent("Image", "imgBG").raycastTarget = false
  self._slot = 0
end

function UITeamItemShow:Flush(slot, pet)
  self._slot = slot
  self._pet = pet
  if pet == nil then
  else
    self._cardGo:SetActive(true)
    local uiItem = self._card:SpawnObject("UIPetMemberItemShow")
    uiItem:SetData(self._slot, self._pet)
  end
end
