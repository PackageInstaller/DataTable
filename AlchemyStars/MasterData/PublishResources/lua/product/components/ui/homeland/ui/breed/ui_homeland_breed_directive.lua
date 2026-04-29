_class("UIHomelandBreedDirective", UIController)
UIHomelandBreedDirective = UIHomelandBreedDirective

function UIHomelandBreedDirective:Constructor()
  self._selectTree = nil
  self._items = nil
end

function UIHomelandBreedDirective:OnShow(uiParams)
  self._mainSeedData = uiParams[1]
  self._mutationSeedData = uiParams[2]
  self._directiveId = uiParams[3]
  self._callback = uiParams[4]
  self:_GetComponents()
  self:_OnValue()
end

function UIHomelandBreedDirective:_GetComponents()
  self._scrollView = self:GetUIComponent("Image", "ScrollView")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._mark = self:GetGameObject("Mark")
end

function UIHomelandBreedDirective:_OnValue()
  if self._directiveId <= 0 then
    self._data = self:_DataFilter()
  else
    self._selectTree = self._directiveId
    self._data = {}
    local cfgTree = Cfg.cfg_item_tree_attribute[self._directiveId]
    table.insert(self._data, cfgTree)
  end
  local count = table.count(self._data)
  if count <= 0 then
    Log.error("Homeland Breed Directive Cfg Error.")
    return
  end
  self._content:SpawnObjects("UIHomelandBreedDirectiveItem", count)
  self._items = self._content:GetAllSpawnList()
  for i = 1, count do
    self._items[i]:SetData(self._data[i], i, function(id, index)
      self:_OnSelect(id, index)
    end)
  end
  self._mark:SetActive(false)
end

function UIHomelandBreedDirective:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIHomelandBreedDirective:OnSureBtnOnClick(go)
  if not self._selectTree then
    return
  end
  if self._callback then
    self._callback(self._selectTree)
  end
  self:CloseDialog()
end

function UIHomelandBreedDirective:_DataFilter()
  local cfgMainSeed = Cfg.cfg_item_tree_seed[self._mainSeedData.ID]
  local cfgMainTree = Cfg.cfg_item_tree_attribute[cfgMainSeed.TreeId]
  local cfgMutationSeed = Cfg.cfg_item_tree_seed[self._mutationSeedData.ID]
  local cfgMutationTree = Cfg.cfg_item_tree_attribute[cfgMutationSeed.TreeId]
  local cfgTree = Cfg.cfg_item_tree_attribute({})
  local data = {}
  for _, tree in pairs(cfgTree) do
    if tree.Species == cfgMainTree.Species and (tree.Pedigree == cfgMainTree.Pedigree or tree.Pedigree == cfgMutationTree.Pedigree) and tree.Rarity - cfgMainTree.Rarity == 1 then
      table.insert(data, tree)
    end
  end
  return data
end

function UIHomelandBreedDirective:_OnSelect(treeID, index)
  self._selectTree = treeID
  if not self._mark.activeSelf then
    self._mark:SetActive(true)
  end
  self._mark.transform.localPosition = Vector3(self._items[index].view.gameObject.transform.localPosition.x, self._mark.transform.localPosition.y, 0)
end
