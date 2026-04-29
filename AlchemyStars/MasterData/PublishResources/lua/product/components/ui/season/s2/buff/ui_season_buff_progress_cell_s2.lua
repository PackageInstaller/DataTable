_class("UISeasonBuffProgressCellS2", UICustomWidget)
UISeasonBuffProgressCellS2 = UISeasonBuffProgressCellS2

function UISeasonBuffProgressCellS2:OnShow(uiParams)
  self.bgGo = self:GetGameObject("Bg")
  self.frontGo = self:GetGameObject("Front")
end

function UISeasonBuffProgressCellS2:SetData(index, isOn)
  self._index = index
  self.frontGo:SetActive(isOn)
end
