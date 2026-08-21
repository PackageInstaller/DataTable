_class("UISeasonBuffProgressCellS4", UICustomWidget)
UISeasonBuffProgressCellS4 = UISeasonBuffProgressCellS4

function UISeasonBuffProgressCellS4:OnShow(uiParams)
  self.bgGo = self:GetGameObject("Bg")
  self.frontGo = self:GetGameObject("Front")
end

function UISeasonBuffProgressCellS4:SetData(index, isOn)
  self._index = index
  self.frontGo:SetActive(isOn)
end
