_class("UISeasonBuffProgressCell", UICustomWidget)
UISeasonBuffProgressCell = UISeasonBuffProgressCell

function UISeasonBuffProgressCell:OnShow(uiParams)
  self.bgGo = self:GetGameObject("Bg")
  self.frontGo = self:GetGameObject("Front")
end

function UISeasonBuffProgressCell:SetData(index, isOn)
  self._index = index
  self.frontGo:SetActive(isOn)
end
