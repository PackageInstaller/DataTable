_class("UISeasonBuffProgressCellsS4", UICustomWidget)
UISeasonBuffProgressCellsS4 = UISeasonBuffProgressCellsS4

function UISeasonBuffProgressCellsS4:OnShow(uiParams)
  self.progressCellGen = self:GetUIComponent("UISelectObjectPath", "CellGen")
end

function UISeasonBuffProgressCellsS4:SetData(progress, curMaxProgress)
  local count = curMaxProgress or 3
  self.progressCellGen:SpawnObjects("UISeasonBuffProgressCellS4", count)
  self._cells = self.progressCellGen:GetAllSpawnList()
  for i, v in ipairs(self._cells) do
    v:SetData(i, progress >= i)
  end
end
