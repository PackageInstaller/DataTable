_class("UISeasonBuffProgressCellsS5", UICustomWidget)
UISeasonBuffProgressCellsS5 = UISeasonBuffProgressCellsS5

function UISeasonBuffProgressCellsS5:OnShow(uiParams)
  self.progressCellGen = self:GetUIComponent("UISelectObjectPath", "CellGen")
end

function UISeasonBuffProgressCellsS5:SetData(progress, curMaxProgress)
  local count = curMaxProgress or 3
  self.progressCellGen:SpawnObjects("UISeasonBuffProgressCellS5", count)
  self._cells = self.progressCellGen:GetAllSpawnList()
  for i, v in ipairs(self._cells) do
    v:SetData(i, progress >= i)
  end
end
