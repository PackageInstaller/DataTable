_class("UISeasonBuffProgressCellsS8", UICustomWidget)
UISeasonBuffProgressCellsS8 = UISeasonBuffProgressCellsS8

function UISeasonBuffProgressCellsS8:OnShow(uiParams)
  self.progressCellGen = self:GetUIComponent("UISelectObjectPath", "CellGen")
end

function UISeasonBuffProgressCellsS8:SetData(progress, curMaxProgress)
  local count = curMaxProgress or 3
  self.progressCellGen:SpawnObjects("UISeasonBuffProgressCellS8", count)
  self._cells = self.progressCellGen:GetAllSpawnList()
  for i, v in ipairs(self._cells) do
    v:SetData(i, progress >= i)
  end
end
