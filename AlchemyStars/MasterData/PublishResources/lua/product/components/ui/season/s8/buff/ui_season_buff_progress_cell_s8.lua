_class("UISeasonBuffProgressCellS8", UICustomWidget)
UISeasonBuffProgressCellS8 = UISeasonBuffProgressCellS8

function UISeasonBuffProgressCellS8:OnShow(uiParams)
  self.bgGo = self:GetGameObject("Bg")
  self.frontGo = self:GetGameObject("Front")
end

function UISeasonBuffProgressCellS8:SetData(index, isOn)
  self._index = index
  self.frontGo:SetActive(isOn)
end
