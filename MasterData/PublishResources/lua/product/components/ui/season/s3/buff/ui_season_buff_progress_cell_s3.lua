_class("UISeasonBuffProgressCellS3", UICustomWidget)
UISeasonBuffProgressCellS3 = UISeasonBuffProgressCellS3

function UISeasonBuffProgressCellS3:OnShow(uiParams)
  self.bgGo = self:GetGameObject("Bg")
  self.frontGo = self:GetGameObject("Front")
end

function UISeasonBuffProgressCellS3:SetData(index, isOn)
  self._index = index
  self.frontGo:SetActive(isOn)
end
