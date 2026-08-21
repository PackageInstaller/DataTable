_class("UISeasonBuffProgressCellS7", UICustomWidget)
UISeasonBuffProgressCellS7 = UISeasonBuffProgressCellS7

function UISeasonBuffProgressCellS7:OnShow(uiParams)
  self.bgGo = self:GetGameObject("Bg")
  self.frontGo = self:GetGameObject("Front")
end

function UISeasonBuffProgressCellS7:SetData(index, isOn)
  self._index = index
  self.frontGo:SetActive(isOn)
end
