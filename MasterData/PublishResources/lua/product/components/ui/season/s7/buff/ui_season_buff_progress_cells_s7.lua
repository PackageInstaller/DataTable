_class("UISeasonBuffProgressCellsS7", UICustomWidget)
UISeasonBuffProgressCellsS7 = UISeasonBuffProgressCellsS7

function UISeasonBuffProgressCellsS7:OnShow(uiParams)
  self.progressCellGen = self:GetUIComponent("UISelectObjectPath", "CellGen")
end

function UISeasonBuffProgressCellsS7:SetData(progress, curMaxProgress)
  local count = curMaxProgress or 3
  self.progressCellGen:SpawnObjects("UISeasonBuffProgressCellS7", count)
  self._cells = self.progressCellGen:GetAllSpawnList()
  for i, v in ipairs(self._cells) do
    v:SetData(i, progress >= i)
  end
end
