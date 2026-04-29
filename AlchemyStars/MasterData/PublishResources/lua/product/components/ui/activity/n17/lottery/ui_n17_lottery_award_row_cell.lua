_class("UIN17LotteryAwardRowCell", UICustomWidget)
UIN17LotteryAwardRowCell = UIN17LotteryAwardRowCell

function UIN17LotteryAwardRowCell:Constructor()
  self.rowCellItemNum = 3
  self._cellGens = {}
  self._awardCells = {}
end

function UIN17LotteryAwardRowCell:OnShow(uiParams)
  self:_GetComponents()
end

function UIN17LotteryAwardRowCell:_GetComponents()
  self.cellsArea = self:GetUIComponent("UISelectObjectPath", "CellsArea")
  self._cellsGen1 = self:GetUIComponent("UISelectObjectPath", "CellGen1")
  self._cellsGen2 = self:GetUIComponent("UISelectObjectPath", "CellGen2")
  self._cellsGen3 = self:GetUIComponent("UISelectObjectPath", "CellGen3")
  table.insert(self._cellGens, self._cellsGen1)
  table.insert(self._cellGens, self._cellsGen2)
  table.insert(self._cellGens, self._cellsGen3)
  for index, value in ipairs(self._cellGens) do
    local cellCtrl = value:SpawnObject("UIN17LotteryAwardCell")
    table.insert(self._awardCells, cellCtrl)
  end
end

function UIN17LotteryAwardRowCell:SetData()
end

function UIN17LotteryAwardRowCell:InitData(data, itemInfoCallBack, rowIndex)
  self._data = data
  self._itemInfoCallback = itemInfoCallBack
  self._rowIndex = rowIndex
  self:_fillCells()
end

function UIN17LotteryAwardRowCell:_fillCells()
  for i = 1, #self._awardCells do
    if i > #self._data then
      self._awardCells[i]:GetGameObject():SetActive(false)
    else
      self._awardCells[i]:GetGameObject():SetActive(true)
      self._awardCells[i]:InitData(self._data[i], self._itemInfoCallback, true, i * self._rowIndex)
    end
  end
end
