_class("UIHomelandBreedManual", UICustomWidget)
UIHomelandBreedManual = UIHomelandBreedManual

function UIHomelandBreedManual:Constructor()
  self._curTagIndex = 0
end

function UIHomelandBreedManual:OnShow(uiParams)
  self:_GetComponents()
  self:_OnValue()
end

function UIHomelandBreedManual:_GetComponents()
  self._tagList = self:GetUIComponent("UISelectObjectPath", "TagList")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self.scrollView = self:GetUIComponent("ScrollRect", "ScrollView")
end

function UIHomelandBreedManual:_OnValue()
  self:_FilterData()
  local count = 0
  local tagData = {}
  for _species, _st in pairs(self._data) do
    for _pedigree, _pt in pairs(_st) do
      local t = {}
      t.species = _species
      t.pedigree = _pedigree
      t.pt = _pt
      table.insert(tagData, t)
      count = count + 1
    end
  end
  self._tagList:SpawnObjects("UIHomelandBreedManualTag", count)
  self._tags = self._tagList:GetAllSpawnList()
  for i = 1, count do
    self._tags[i]:SetData(tagData[i], i, function(data, index)
      self:_RefreshItem(data, index)
    end)
  end
  if 0 < #tagData then
    self:_RefreshItem(tagData[1], 1)
  end
end

function UIHomelandBreedManual:SetData()
end

function UIHomelandBreedManual:Update(deltaTime)
end

function UIHomelandBreedManual:_RefreshItem(data, index)
  if self._curTagIndex == index then
    return
  end
  self.scrollView:StopMovement()
  self.scrollView.horizontalNormalizedPosition = 0
  local count = 0
  local itemData = {}
  for _rarity, _rt in pairs(data.pt) do
    for _series, _st in pairs(_rt) do
      local t = {}
      t.species = data.species
      t.pedigree = data.pedigree
      t.rarity = _rarity
      t.series = _series
      t.st = _st
      table.insert(itemData, t)
      count = count + 1
    end
  end
  self._content:SpawnObjects("UIHomelandBreedManualItem", count)
  self._items = self._content:GetAllSpawnList()
  for i = 1, count do
    self._items[i]:SetData(itemData[i])
  end
  if self._curTagIndex > 0 then
    self._tags[self._curTagIndex]:RefreshState(false)
  end
  self._curTagIndex = index
  self._tags[self._curTagIndex]:RefreshState(true)
end

function UIHomelandBreedManual:_FilterData()
  self._data = {}
  local allTree = Cfg.cfg_item_tree_attribute({})
  for _, tree in pairs(allTree) do
    if not self._data[tree.Species] then
      self._data[tree.Species] = {}
    end
    if not self._data[tree.Species][tree.Pedigree] then
      self._data[tree.Species][tree.Pedigree] = {}
    end
    if not self._data[tree.Species][tree.Pedigree][tree.Rarity] then
      self._data[tree.Species][tree.Pedigree][tree.Rarity] = {}
    end
    if not self._data[tree.Species][tree.Pedigree][tree.Rarity][tree.SerialNum] then
      self._data[tree.Species][tree.Pedigree][tree.Rarity][tree.SerialNum] = {}
    end
    table.insert(self._data[tree.Species][tree.Pedigree][tree.Rarity][tree.SerialNum], tree)
  end
end
