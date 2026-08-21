_class("UISeasonBuffProgressCellsS6", UICustomWidget)
UISeasonBuffProgressCellsS6 = UISeasonBuffProgressCellsS6

function UISeasonBuffProgressCellsS6:OnShow(uiParams)
  self.progressCellGen = self:GetUIComponent("UISelectObjectPath", "CellGen")
end

function UISeasonBuffProgressCellsS6:SetData(progress, curMaxProgress)
  local count = curMaxProgress or 3
  self.progressCellGen:SpawnObjects("UISeasonBuffProgressCellS6", count)
  self._cells = self.progressCellGen:GetAllSpawnList()
  for i, v in ipairs(self._cells) do
    v:SetData(i, progress >= i)
  end
end
