_class("UIN10ShopAwardRowCell", UICustomWidget)
UIN10ShopAwardRowCell = UIN10ShopAwardRowCell

function UIN10ShopAwardRowCell:Constructor()
  self.rowCellItemNum = 3
  self._cellGens = {}
  self._awardCells = {}
end

function UIN10ShopAwardRowCell:OnShow(uiParams)
  self:_GetComponents()
end

function UIN10ShopAwardRowCell:_GetComponents()
  self.cellsArea = self:GetUIComponent("UISelectObjectPath", "CellsArea")
  self._cellsGen1 = self:GetUIComponent("UISelectObjectPath", "CellGen1")
  self._cellsGen2 = self:GetUIComponent("UISelectObjectPath", "CellGen2")
  self._cellsGen3 = self:GetUIComponent("UISelectObjectPath", "CellGen3")
  table.insert(self._cellGens, self._cellsGen1)
  table.insert(self._cellGens, self._cellsGen2)
  table.insert(self._cellGens, self._cellsGen3)
  for index, value in ipairs(self._cellGens) do
    local cellCtrl = value:SpawnObject("UIN10ShopAwardCell")
    table.insert(self._awardCells, cellCtrl)
  end
end

function UIN10ShopAwardRowCell:SetData()
end

function UIN10ShopAwardRowCell:InitData(data, itemInfoCallBack, rowIndex)
  self._data = data
  self._itemInfoCallback = itemInfoCallBack
  self._rowIndex = rowIndex
  self:_fillCells()
end

function UIN10ShopAwardRowCell:_fillCells()
  for i = 1, #self._awardCells do
    if i > #self._data then
      self._awardCells[i]:GetGameObject():SetActive(false)
    else
      self._awardCells[i]:GetGameObject():SetActive(true)
      self._awardCells[i]:InitData(self._data[i], self._itemInfoCallback, true, i * self._rowIndex)
    end
  end
end
