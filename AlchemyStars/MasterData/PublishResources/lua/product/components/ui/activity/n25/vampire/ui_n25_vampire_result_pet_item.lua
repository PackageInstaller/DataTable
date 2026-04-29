_class("UIN25VampireResultPetItem", UICustomWidget)
UIN25VampireResultPetItem = UIN25VampireResultPetItem

function UIN25VampireResultPetItem:Constructor()
end

function UIN25VampireResultPetItem:OnShow(uiParams)
  self.Icon = self:GetUIComponent("RawImageLoader", "Icon")
  self.image = self:GetGameObject("Image")
end

function UIN25VampireResultPetItem:OnHide()
  self.Icon:DestoryLastImage()
end

function UIN25VampireResultPetItem:Flush(tplId, pet)
  self.tplId = tplId
  self.image:SetActive(false)
  self.Icon:LoadImage(pet:Icon())
end

function UIN25VampireResultPetItem:IconOnClick(go)
  if self.callback then
    self.callback()
  end
end
