_class("UISeasonBuffProgressCellS5", UICustomWidget)
UISeasonBuffProgressCellS5 = UISeasonBuffProgressCellS5

function UISeasonBuffProgressCellS5:OnShow(uiParams)
  self.bgGo = self:GetGameObject("Bg")
  self.frontGo = self:GetGameObject("Front")
end

function UISeasonBuffProgressCellS5:SetData(index, isOn)
  self._index = index
  self.frontGo:SetActive(isOn)
end
