_class("UISeasonBuffProgressCellS6", UICustomWidget)
UISeasonBuffProgressCellS6 = UISeasonBuffProgressCellS6

function UISeasonBuffProgressCellS6:OnShow(uiParams)
  self.bgGo = self:GetGameObject("Bg")
  self.frontGo = self:GetGameObject("Front")
end

function UISeasonBuffProgressCellS6:SetData(index, isOn)
  self._index = index
  self.frontGo:SetActive(isOn)
end
