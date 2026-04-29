_class("UISakuraDrawShopAwardRowCell", UICustomWidget)
UISakuraDrawShopAwardRowCell = UISakuraDrawShopAwardRowCell

function UISakuraDrawShopAwardRowCell:Constructor()
  self.rowCellItemNum = 3
  self._cellGens = {}
  self._awardCells = {}
end

function UISakuraDrawShopAwardRowCell:OnShow(uiParams)
  self:InitWidget()
end

function UISakuraDrawShopAwardRowCell:InitWidget()
  self.cellsArea = self:GetUIComponent("UISelectObjectPath", "CellsArea")
  self._cellsGen1 = self:GetUIComponent("UISelectObjectPath", "CellGen1")
  self._cellsGen2 = self:GetUIComponent("UISelectObjectPath", "CellGen2")
  self._cellsGen3 = self:GetUIComponent("UISelectObjectPath", "CellGen3")
  table.insert(self._cellGens, self._cellsGen1)
  table.insert(self._cellGens, self._cellsGen2)
  table.insert(self._cellGens, self._cellsGen3)
  for index, value in ipairs(self._cellGens) do
    local cellCtrl = value:SpawnObject("UISakuraDrawShopAwardCell")
    table.insert(self._awardCells, cellCtrl)
  end
end

function UISakuraDrawShopAwardRowCell:SetData()
end

function UISakuraDrawShopAwardRowCell:InitData(data, itemInfoCallBack)
  self._data = data
  self._itemInfoCallback = itemInfoCallBack
  self:_fillCells()
end

function UISakuraDrawShopAwardRowCell:_GenCells()
  if not self.cells then
    self.cellsArea:SpawnObjects("UISakuraDrawShopAwardCell", self.rowCellItemNum)
    self.cells = self.cellsArea:GetAllSpawnList()
  end
  for i = 1, #self.cells do
    if i > #self._data then
      self.cells[i]:GetGameObject():SetActive(false)
    else
      self.cells[i]:GetGameObject():SetActive(true)
      self.cells[i]:InitData(self._data[i], self._itemInfoCallback)
    end
  end
end

function UISakuraDrawShopAwardRowCell:_fillCells()
  for i = 1, #self._awardCells do
    if i > #self._data then
      self._awardCells[i]:GetGameObject():SetActive(false)
    else
      self._awardCells[i]:GetGameObject():SetActive(true)
      self._awardCells[i]:InitData(self._data[i], self._itemInfoCallback)
    end
  end
end
