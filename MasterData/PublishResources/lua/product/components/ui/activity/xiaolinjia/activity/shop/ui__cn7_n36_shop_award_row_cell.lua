_class("UICN7N36ShopAwardRowCell", UICustomWidget)
UICN7N36ShopAwardRowCell = UICN7N36ShopAwardRowCell

function UICN7N36ShopAwardRowCell:Constructor()
  self.rowCellItemNum = 3
  self._cellGens = {}
  self._awardCells = {}
end

function UICN7N36ShopAwardRowCell:OnShow(uiParams)
  self:_GetComponents()
end

function UICN7N36ShopAwardRowCell:_GetComponents()
  self.cellsArea = self:GetUIComponent("UISelectObjectPath", "CellsArea")
  self._cellsGen1 = self:GetUIComponent("UISelectObjectPath", "CellGen1")
  self._cellsGen2 = self:GetUIComponent("UISelectObjectPath", "CellGen2")
  self._cellsGen3 = self:GetUIComponent("UISelectObjectPath", "CellGen3")
  table.insert(self._cellGens, self._cellsGen1)
  table.insert(self._cellGens, self._cellsGen2)
  table.insert(self._cellGens, self._cellsGen3)
  for index, value in ipairs(self._cellGens) do
    local cellCtrl = value:SpawnObject("UICN7N36ShopAwardCell")
    table.insert(self._awardCells, cellCtrl)
  end
end

function UICN7N36ShopAwardRowCell:SetData()
end

function UICN7N36ShopAwardRowCell:InitData(data, itemInfoCallBack, rowIndex)
  self._data = data
  self._itemInfoCallback = itemInfoCallBack
  self._rowIndex = rowIndex
  self:_FillCells()
end

function UICN7N36ShopAwardRowCell:_FillCells()
  for i = 1, #self._awardCells do
    if i > #self._data then
      self._awardCells[i]:GetGameObject():SetActive(false)
    else
      self._awardCells[i]:GetGameObject():SetActive(true)
      self._awardCells[i]:InitData(self._data[i], self._itemInfoCallback, true, i * self._rowIndex)
    end
  end
end
